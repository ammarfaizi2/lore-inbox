Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVD2NT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVD2NT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVD2NT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:19:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:57049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262577AbVD2NS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:18:58 -0400
Date: Fri, 29 Apr 2005 06:18:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-Id: <20050429061825.36f98cc0.akpm@osdl.org>
In-Reply-To: <20050421111346.GA21421@elf.ucw.cz>
References: <20050421111346.GA21421@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> 
> Without this patch, Linux provokes emergency disk shutdowns and
> similar nastiness. It was in SuSE kernels for some time, IIRC.
> 

With this patch when running `halt -p' my ia64 Tiger (using
tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
and then hangs up.

Unfortunately it all seems to happen after the serial port has been
disabled because nothing comes out.  I set the console to a squitty font
and took a piccy.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg

I guess it's an ia64 problem.  I'll leave the patch in -mm for now.

> 
> --- clean/kernel/sys.c	2005-03-19 00:32:32.000000000 +0100
> +++ linux/kernel/sys.c	2005-03-22 12:20:53.000000000 +0100
> @@ -404,6 +404,7 @@
>  	case LINUX_REBOOT_CMD_HALT:
>  		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
>  		system_state = SYSTEM_HALT;
> +		device_suspend(PMSG_SUSPEND);
>  		device_shutdown();
>  		printk(KERN_EMERG "System halted.\n");
>  		machine_halt();
> @@ -414,6 +415,7 @@
>  	case LINUX_REBOOT_CMD_POWER_OFF:
>  		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
>  		system_state = SYSTEM_POWER_OFF;
> +		device_suspend(PMSG_SUSPEND);
>  		device_shutdown();
>  		printk(KERN_EMERG "Power down.\n");
>  		machine_power_off();
> @@ -430,6 +432,7 @@
>  
>  		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
>  		system_state = SYSTEM_RESTART;
> +		device_suspend(PMSG_FREEZE);
>  		device_shutdown();
>  		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
>  		machine_restart(buffer);
> 
> -- 
> Boycott Kodak -- for their patent abuse against Java.
