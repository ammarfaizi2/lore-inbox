Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbTJCXKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTJCXKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:10:53 -0400
Received: from mail.netbeat.de ([193.254.185.26]:43273 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S261443AbTJCXKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:10:49 -0400
Subject: Re: PPP not working on test6-mm2
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031003135131.0a8c5f05.akpm@osdl.org>
References: <1065220814.2261.1.camel@JHome.uni-bonn.de>
	 <20031003135131.0a8c5f05.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1065228626.2252.6.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 04 Oct 2003 03:13:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 03.10.2003 schrieb Andrew Morton um 22:51:
> Jan Ischebeck <mail@jan-ischebeck.de> wrote:
> >
> > Hi Andrew,
> > 
> > PPP isn't working anymore since test5-mm1.
> > 
> > Here a stacktrace from test6-mm2, last lines from dmesg:
> > 
> > Badness in local_bh_enable at kernel/softirq.c:119
> > Call Trace:
> > [<c01281e5>] local_bh_enable+0x85/0x90
> > [<c0243762>] ppp_async_push+0xa2/0x190
> > [<c024307d>] ppp_asynctty_wakeup+0x2d/0x60
> > [<c020fcf8>] pty_unthrottle+0x58/0x60
> > [<c020c67d>] check_unthrottle+0x3d/0x40
> > [<c020c723>] n_tty_flush_buffer+0x13/0x60
> > [<c0210107>] pty_flush_buffer+0x67/0x70
> > [<c0208f55>] do_tty_hangup+0x405/0x470
> > [<c020a4dc>] release_dev+0x64c/0x680
> > [<c014abfb>] zap_pmd_range+0x4b/0x70
> > [<c014ac63>] unmap_page_range+0x43/0x70
> > [<c0170562>] dput+0x22/0x270
> > [<c020a8aa>] tty_release+0x2a/0x60
> > [<c015ac40>] __fput+0x100/0x120
> > [<c0159229>] filp_close+0x59/0x90
> > [<c0125b34>] put_files_struct+0x54/0xc0
> > [<c0126795>] do_exit+0x155/0x3f0
> > [<c0126aca>] do_group_exit+0x3a/0xb0
> > [<c02fb427>] syscall_call+0x7/0xb
> > 
> 
> Yes, this is due to a locking problem in do_tty_hangup() which everyone is
> pretenting isn't there.
> 
> 
> > PPP is build in, 
> > 
> > # CONFIG_PLIP is not set
> > CONFIG_PPP=y
> > # CONFIG_PPP_MULTILINK is not set
> > CONFIG_PPP_FILTER=y
> > CONFIG_PPP_ASYNC=y
> > # CONFIG_PPP_SYNC_TTY is not set
> > CONFIG_PPP_DEFLATE=y
> > CONFIG_PPP_BSDCOMP=y
> > CONFIG_PPPOE=y
> > # CONFIG_SLIP is not set
> > 
> > 
> > trying to start pppd doesn't work. Syslog:
> > 
> > Oct  4 00:05:39 JHome pppoe[2108]: ioctl(SIOCGIFHWADDR): Session 0: No
> > such device
> > Oct  4 00:05:39 JHome pppd[1134]: Serial connection established.
> > Oct  4 00:05:39 JHome pppd[1134]: Couldn't get channel number:
> > Input/output error
> 
> Odd.  -ENODEV against the ppp device I suppose.  test5-mm1 added the below
> fix, which is only applicable if you're using devfs (are you using devfs?)
> and is unlikely to explain this anyway.
> 
> Still, could you do a `patch -p1 -R' of the below, see what happens?
> 
> 
> diff -puN drivers/net/ppp_generic.c~ppp-oops-fix drivers/net/ppp_generic.c
> --- 25/drivers/net/ppp_generic.c~ppp-oops-fix	2003-09-09 23:41:40.000000000 -0700
> +++ 25-akpm/drivers/net/ppp_generic.c	2003-09-09 23:41:40.000000000 -0700
> @@ -792,7 +792,7 @@ static struct file_operations ppp_device
>  
>  /* Called at boot time if ppp is compiled into the kernel,
>     or at module load time (from init_module) if compiled as a module. */
> -int __init ppp_init(void)
> +static int __init ppp_init(void)
>  {
>  	int err;
>  
> @@ -801,6 +801,8 @@ int __init ppp_init(void)
>  	if (!err) {
>  		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
>  				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
> +		if (err)
> +			unregister_chrdev(PPP_MAJOR, "ppp");
>  	}
>  
>  	if (err)
> 

No, no result. Still can't use PPP.

I'll to compile PPP as module to get another type of stacktrace.

> _
-- 
Jan Ischebeck <mail@jan-ischebeck.de>

