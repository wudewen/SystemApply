//
//  ViewController.m
//  系统应用
//
//  Created by 吴德文 on 16/11/2.
//  Copyright © 2016年 Shanutec. All rights reserved.
//

#import "ViewController.h"

#define SPACE_WH 50

@interface ViewController ()

/** 打电话 */
@property (nonatomic ,strong) UIButton *callBtn;
/** 发送短信 */
@property (nonatomic ,strong) UIButton *messageBtn;
/** 发送邮件 */
@property (nonatomic ,strong) UIButton *mailBtn;
/** 进入官网 */
@property (nonatomic ,strong) UIButton *browserBtn;
@end

@implementation ViewController

-(UIButton *)callBtn
{
    if (!_callBtn) {
        _callBtn = [[UIButton alloc] init];
        [_callBtn setTitle:@"打电话" forState:UIControlStateNormal];
        _callBtn.backgroundColor = [UIColor redColor];
        [_callBtn addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callBtn;
}

-(UIButton *)messageBtn
{
    if (!_messageBtn) {
        _messageBtn = [[UIButton alloc] init];
        [_messageBtn setTitle:@"发送短信" forState:UIControlStateNormal];
        _messageBtn.backgroundColor = [UIColor redColor];
        [_messageBtn addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

-(UIButton *)mailBtn
{
    if (!_mailBtn) {
        _mailBtn = [[UIButton alloc] init];
        [_mailBtn setTitle:@"发送邮件" forState:UIControlStateNormal];
        _mailBtn.backgroundColor = [UIColor redColor];
        [_mailBtn addTarget:self action:@selector(mailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mailBtn;
}

-(UIButton *)browserBtn
{
    if (!_browserBtn) {
        _browserBtn = [[UIButton alloc] init];
        [_browserBtn setTitle:@"进入官网" forState:UIControlStateNormal];
        _browserBtn.backgroundColor = [UIColor redColor];
        [_browserBtn addTarget:self action:@selector(browserBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _browserBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.callBtn];
    [self.view addSubview:self.messageBtn];
    [self.view addSubview:self.mailBtn];
    [self.view addSubview:self.browserBtn];
    
    [self addAutoLayOut];
}

-(void)addAutoLayOut
{
    [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SPACE_WH);
        make.top.mas_equalTo(SPACE_WH);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-2*SPACE_WH, SPACE_WH));
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.callBtn.mas_left);
        make.top.mas_equalTo(self.callBtn.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-2*SPACE_WH, SPACE_WH));
    }];
    
    [self.mailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.callBtn.mas_left);
        make.top.mas_equalTo(self.messageBtn.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-2*SPACE_WH, SPACE_WH));
    }];
    
    [self.browserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.callBtn.mas_left);
        make.top.mas_equalTo(self.mailBtn.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-2*SPACE_WH, SPACE_WH));
    }];

}

#pragma mark - 按钮的点击事件

// 打电话
-(void)callBtnClick
{
    NSString *phoneNumber = @"17770848240";
    // NSString *url=[NSString stringWithFormat:@"tel://%@",phoneNumber];//这种方式会直接拨打电话
    NSString *url=[NSString stringWithFormat:@"telprompt://%@",phoneNumber];//这种方式会提示用户确认是否拨打电话
    [self openUrl:url];

}

// 发送信息
-(void)messageBtnClick
{
    NSString *phoneNumber=@"17770848240";
    NSString *url=[NSString stringWithFormat:@"sms://%@",phoneNumber];
    [self openUrl:url];
}

-(void)mailBtnClick
{
    NSString *mailAddress=@"wudewen@shanutec.com";
    NSString *url=[NSString stringWithFormat:@"mailto://%@",mailAddress];
    [self openUrl:url];
}

-(void)browserBtnClick
{
    NSString *url=@"http://www.shanutec.com";
    [self openUrl:url];
}

#pragma mark - 私有方法
-(void)openUrl:(NSString *)urlStr{
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
