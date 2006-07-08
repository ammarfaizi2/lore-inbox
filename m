Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWGHO3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWGHO3n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWGHO3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:29:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:52586 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964855AbWGHO3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:29:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OKa+rzGZSDHqhWoPhgpZWYkRazQAIZv54oGZdC5SavC1fzZwumJBvJZP0lcOQ9jDxODUXU7oGQo7IfD5l+mg3rVM0DXobpctqBZ9IuEpyToQ4WWTe7gFvSYfi8wAJPuuw6LtQUnpN8h4WCCimo/h0xhxIZ/HlnIKaWZ/wqfEHCc=
Message-ID: <44AFC15A.1060003@gmail.com>
Date: Sat, 08 Jul 2006 08:29:46 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patchset 2/3 -2.6.18-rc1]  pc8736x_gpio:  fix re-modprobe errors
 - undo region reservation
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <44AFBCB5.4040409@gmail.com>
In-Reply-To: <44AFBCB5.4040409@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2 - pc-init-fix-undo-region-rollup

this patch fixes module-init-func by repairing usage of 
platform_device_del/put in module-exit-func.
IOW, it imitates Ingo's 'mishaps' patch, which fixed the 
module-init-func's undo handling.
Also fixes lack of release_region to undo the earlier registration.

Also starts to 'use a cdev' which was originally intended (its present 
in scx200_gpio).
Code compiles and runs, exhibits a lesser error than previously. 
(re-register-chrdev fails)

Since I had to add "include <linux/cdev.h>", I went ahead and made 2
tweaks that fell into diff-context-window:
- remove include <linux/config.h>      everyone's doing it
- copyright updates - current date is 'wrong'

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

---

$ diffstat fxd1/pc-init-fix-undo-region-rollup
 pc8736x_gpio.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)
[jimc@harpo gpio-stuff]$

---

diff -ruNp -X dontdiff -X exclude-diffs x4h-1/drivers/char/pc8736x_gpio.c x4h-2/drivers/char/pc8736x_gpio.c
--- x4h-1/drivers/char/pc8736x_gpio.c	2006-07-07 16:59:14.000000000 -0600
+++ x4h-2/drivers/char/pc8736x_gpio.c	2006-07-07 17:02:17.000000000 -0600
@@ -3,18 +3,18 @@
    National Semiconductor PC8736x GPIO driver.  Allows a user space
    process to play with the GPIO pins.
 
-   Copyright (c) 2005 Jim Cromie <jim.cromie@gmail.com>
+   Copyright (c) 2005,2006 Jim Cromie <jim.cromie@gmail.com>
 
    adapted from linux/drivers/char/scx200_gpio.c
    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>,
 */
 
-#include <linux/config.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/cdev.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
@@ -255,6 +255,8 @@ static void __init pc8736x_init_shadow(v
 
 }
 
+static struct cdev pc8736x_gpio_cdev;
+
 static int __init pc8736x_gpio_init(void)
 {
 	int rc = 0;
@@ -308,7 +310,7 @@ static int __init pc8736x_gpio_init(void
 	rc = register_chrdev(major, DEVNAME, &pc8736x_gpio_fops);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "register-chrdev failed: %d\n", rc);
-		goto undo_platform_dev_add;
+		goto undo_request_region;
 	}
 	if (!major) {
 		major = rc;
@@ -318,6 +320,8 @@ static int __init pc8736x_gpio_init(void
 	pc8736x_init_shadow();
 	return 0;
 
+undo_request_region:
+	release_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE);
 undo_platform_dev_add:
 	platform_device_del(pdev);
 undo_platform_dev_alloc:
@@ -328,11 +332,14 @@ undo_platform_dev_alloc:
 
 static void __exit pc8736x_gpio_cleanup(void)
 {
-	dev_dbg(&pdev->dev, " cleanup\n");
+	dev_dbg(&pdev->dev, "cleanup\n");
 
-	release_region(pc8736x_gpio_base, 16);
+	cdev_del(&pc8736x_gpio_cdev);
+	unregister_chrdev_region(MKDEV(major,0), PC8736X_GPIO_CT);
+	release_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE);
 
-	unregister_chrdev(major, DEVNAME);
+	platform_device_del(pdev);
+	platform_device_put(pdev);
 }
 
 EXPORT_SYMBOL(pc8736x_access);


