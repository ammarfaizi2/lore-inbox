Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWAQSnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWAQSnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWAQSnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:43:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:56236 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932359AbWAQSnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:43:02 -0500
Subject: PATCH: SBC EPX does not check/claim I/O ports it uses (2nd Edition)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: calin@ajvar.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
References: <1137520351.14135.40.camel@localhost.localdomain>
	 <58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 18:42:25 +0000
Message-Id: <1137523345.14135.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c	2006-01-17 18:27:39.149607944 +0000
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -180,12 +181,15 @@
 static int __init watchdog_init(void)
 {
 	int ret;
+	
+	if (!request_region(EPXC3_WATCHDOG_CTL_REG, 2, "epxc3_watchdog"))
+		return -EBUSY;
 
 	ret = register_reboot_notifier(&epx_c3_notifier);
 	if (ret) {
 		printk(KERN_ERR PFX "cannot register reboot notifier "
 			"(err=%d)\n", ret);
-		return ret;
+		goto out;
 	}
 
 	ret = misc_register(&epx_c3_miscdev);
@@ -193,12 +197,16 @@
 		printk(KERN_ERR PFX "cannot register miscdev on minor=%d "
 			"(err=%d)\n", WATCHDOG_MINOR, ret);
 		unregister_reboot_notifier(&epx_c3_notifier);
-		return ret;
+		goto out;
 	}
 
 	printk(banner);
 
 	return 0;
+
+out:
+	release_region(EPXC3_WATCHDOG_CTL_REG, 2);
+	return ret;
 }
 
 static void __exit watchdog_exit(void)

