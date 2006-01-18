Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWARMLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWARMLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWARMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:11:10 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:33700 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030243AbWARMLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:11:09 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed, 18 Jan 2006 13:10:46 +0100
Subject: Re: PATCH: SBC EPX does not check/claim I/O ports it uses (2nd Edition)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, calin@ajvar.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1137520351.14135.40.camel@localhost.localdomain>
	 <58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
In-reply-to: <1137523345.14135.85.camel@localhost.localdomain>
Message-Id: <20060118121046.15C3122B38B@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>Signed-off-by: Alan Cox <alan@redhat.com>
>
>--- linux.vanilla-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c	2006-01-17 15:52:53.000000000 +0000
>+++ linux-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c	2006-01-17 18:27:39.149607944 +0000
>@@ -25,6 +25,7 @@
> #include <linux/notifier.h>
> #include <linux/reboot.h>
> #include <linux/init.h>
>+#include <linux/ioport.h>
> #include <asm/uaccess.h>
> #include <asm/io.h>
> 
>@@ -180,12 +181,15 @@
> static int __init watchdog_init(void)
> {
> 	int ret;
>+	
>+	if (!request_region(EPXC3_WATCHDOG_CTL_REG, 2, "epxc3_watchdog"))
>+		return -EBUSY;
> 
> 	ret = register_reboot_notifier(&epx_c3_notifier);
> 	if (ret) {
> 		printk(KERN_ERR PFX "cannot register reboot notifier "
> 			"(err=%d)\n", ret);
>-		return ret;
>+		goto out;
> 	}
> 
> 	ret = misc_register(&epx_c3_miscdev);
>@@ -193,12 +197,16 @@
> 		printk(KERN_ERR PFX "cannot register miscdev on minor=%d "
> 			"(err=%d)\n", WATCHDOG_MINOR, ret);
> 		unregister_reboot_notifier(&epx_c3_notifier);
>-		return ret;
>+		goto out;
> 	}
> 
> 	printk(banner);
> 
> 	return 0;
>+
>+out:
>+	release_region(EPXC3_WATCHDOG_CTL_REG, 2);
>+	return ret;
> }
> 
> static void __exit watchdog_exit(void)
But now, you forgot to add release_region in this (exit) function :)?

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
