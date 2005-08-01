Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVHAPWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVHAPWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVHAPWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:22:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64979 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262100AbVHAPUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:20:00 -0400
Date: Mon, 1 Aug 2005 17:19:56 +0200
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] properly stop devices before poweroff
Message-ID: <20050801151956.GA29448@suse.de>
References: <200506260105.j5Q15eBj021334@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200506260105.j5Q15eBj021334@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Jun 26, Linux Kernel Mailing List wrote:

> tree e2de713c76ddb42b091305b88aa7ca4938081789
> parent 5ce47e59c9688d8480ae41100117d8188c191401
> author Pavel Machek <pavel@ucw.cz> Sun, 26 Jun 2005 04:55:11 -0700
> committer Linus Torvalds <torvalds@ppc970.osdl.org> Sun, 26 Jun 2005 06:24:33 -0700
> 
> [PATCH] properly stop devices before poweroff
> 
> Without this patch, Linux provokes emergency disk shutdowns and
> similar nastiness. It was in SuSE kernels for some time, IIRC.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  include/linux/pm.h |   33 +++++++++++++++++++++------------
>  kernel/sys.c       |    3 +++
>  2 files changed, 24 insertions(+), 12 deletions(-)

> +++ b/kernel/sys.c
> @@ -405,6 +405,7 @@ asmlinkage long sys_reboot(int magic1, i
>  	case LINUX_REBOOT_CMD_HALT:
>  		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
>  		system_state = SYSTEM_HALT;
> +		device_suspend(PMSG_SUSPEND);
>  		device_shutdown();
>  		printk(KERN_EMERG "System halted.\n");
>  		machine_halt();
> @@ -415,6 +416,7 @@ asmlinkage long sys_reboot(int magic1, i
>  	case LINUX_REBOOT_CMD_POWER_OFF:
>  		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
>  		system_state = SYSTEM_POWER_OFF;
> +		device_suspend(PMSG_SUSPEND);
>  		device_shutdown();
>  		printk(KERN_EMERG "Power down.\n");
>  		machine_power_off();

This change for 'case LINUX_REBOOT_CMD_POWER_OFF' causes an endless hang
after 'halt -p' on my Macs with USB keyboard.
It went into rc1, but the hang in an usb device (1-1.3) shows up only
with rc3. Why is device_suspend() called anyway if the
system will go down anyway in a few milliseconds?
