Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVDFH3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVDFH3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVDFH3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:29:44 -0400
Received: from black.click.cz ([62.141.0.10]:43949 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S262130AbVDFH3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:29:39 -0400
From: Michal Rokos <michal@rokos.info>
To: jt@hpl.hp.com
Subject: Re: [IrDA] Oops with NULL deref in irda_device_set_media_busy
Date: Wed, 6 Apr 2005 09:22:48 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200504051102.27533.michal@rokos.info> <20050405170102.GD10447@bougret.hpl.hp.com>
In-Reply-To: <20050405170102.GD10447@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200504060922.49267.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

I'm gonna provide more info this time...

On Tuesday 05 April 2005 19:01, Jean Tourrilhes wrote:
> On Tue, Apr 05, 2005 at 11:02:26AM +0200, Michal Rokos wrote:
> > I've problems with IrDA - when debug is off, I'm getting oops for obvious
> > reason...
> > (I don't have a log, this is just rewrite from screen:
> > EIP: irda_device_set_media_busy+0x15/0x40 [irda]
> > ali_ircc_sir_receive+0x4a/0x70
> > ali_ircc_sir_interrupt+0x66/0x70
> > ali_ircc_interrupt+0x5e/0x80
and continues with:
handle_IRQ_event+0x2a/0x60
__do_IRQ+0xda/0x150
do_IRQ+0x4a/0x70
================
common_interrupt+0x1a/0x20
dev_open+0x74/0x90
dev_change_flags+0x52/0x120
devinet_ioctl+0x245/0x570
inet_ioctl+0x63/0xb0
sock_ioctl+0xb1/0x150
do_ioctl+0x69/0x80
vfs_ioctl+0x59/0x1b0
sys_ioctl+0x51/0x80
sysenter_past_esp+0x54/0x75

So it has something to do with ioctl. Could it be caused by 
ali_ircc_net_ioctl() when cmd is SIOCSMEDIABUSY (in 
drivers/net/irda/ali-ircc.c:2282)?

> > .....
> > )
> > When I turn debug on, I get just
> > Assertion failed! net/irda/irda_device.c:irda_device_set_media_busy:128
> > self != NULL
> >
> > The obvious reason is that I don't have irlap module in that inits
> > dev->atalk_ptr, so I'm getting assertion exception in irda_device.c:489.

The assertion is seen when ifup -a is called so it's when 'ifconfig irda0 up' 
is used.

>
>  I'm unclear here. The default IrDA stack intitialise properly
> dev->atalk_ptr in every case, and is not expected to work if you
> don't. I don't understand why dev->atalk_ptr would not be initialised,
> is it something you did or something specific to the mr kernel (I only
> test mainline kernels).
>
Hehe, no it's mainstream... There's just
CONFIG_LOCALVERSION="-mr"
in the .config.

>From the syslog:
...
Apr  6 08:59:01 michal kernel: irda_init()
Apr  6 08:59:01 michal kernel: NET: Registered protocol family 23
Apr  6 08:59:01 michal kernel: ali-ircc, driver loaded (Benjamin Kong)
Apr  6 08:59:01 michal kernel: IrDA: Registered device irda0
Apr  6 08:59:01 michal kernel: ali_ircc_open(), ali-ircc, Found dongle: HP 
HSDL-3600
Apr  6 08:59:01 michal kernel: IrCOMM protocol (Dag Brattli)
...
Apr  6 08:59:01 michal kernel: Assertion failed! 
net/irda/irda_device.c:irda_device_set_media_busy:128 self != NULL
Apr  6 08:59:01 michal kernel: irlap_change_speed(), setting speed to 9600
...

and when connecting via gprs:
Apr  6 09:01:13 michal kernel: ircomm_tty_attach_cable()
Apr  6 09:01:13 michal kernel: ircomm_tty_ias_register()
Apr  6 09:01:13 michal kernel: irlap_change_speed(), setting speed to 115200
Apr  6 09:01:14 michal kernel: ircomm_param_service_type(), services in 
common=04
Apr  6 09:01:14 michal kernel: ircomm_param_service_type(), resulting service 
type=0x04
Apr  6 09:01:14 michal kernel: ircomm_param_port_type(), port type=1
Apr  6 09:01:14 michal kernel: ircomm_param_port_type(), port type=1
Apr  6 09:01:14 michal kernel: ircomm_param_xon_xoff(), XON/XOFF = 0x11,0x13
Apr  6 09:01:14 michal kernel: ircomm_param_enq_ack(), ENQ/ACK = 0x13,0x11
Apr  6 09:01:14 michal kernel: ircomm_tty_check_modem_status()
Apr  6 09:01:34 michal last message repeated 4 times
Apr  6 09:01:37 michal kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Apr  6 09:01:37 michal kernel: PPP generic driver version 2.4.2
Apr  6 09:01:37 michal kernel: ircomm_tty_close()
Apr  6 09:01:37 michal kernel: ircomm_tty_close(), open count > 0
Apr  6 09:01:40 michal kernel: PPP BSD Compression module registered
Apr  6 09:01:40 michal kernel: PPP Deflate Compression module registered

 Michal
