Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUDJNvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUDJNvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 09:51:21 -0400
Received: from pra68-d137.gd.dial-up.cz ([193.85.68.137]:36224 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S262020AbUDJNvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 09:51:18 -0400
Date: Sat, 10 Apr 2004 15:51:15 +0200
To: linux-kernel@vger.kernel.org
Cc: tim@cyberelk.net, greg@kroah.com
Subject: [PATCH 2.6] Class support for ppdev.c
Message-ID: <20040410135115.GA3612@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, tim@cyberelk.net,
	greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds class support to ppdev.c.

The module compiles and loads ok.


diff -urN linux-2.6/drivers/char/ppdev.c linux-2.6-new/drivers/char/ppdev.c
--- linux-2.6/drivers/char/ppdev.c	2003-12-31 18:51:23.000000000 +0100
+++ linux-2.6-new/drivers/char/ppdev.c	2004-04-10 14:28:54.000000000 +0200
@@ -59,6 +59,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl.h>
 #include <linux/parport.h>
@@ -750,31 +751,54 @@
 	.release	= pp_release,
 };
 
+static struct class_simple *ppdev_class;
+
 static int __init ppdev_init (void)
 {
-	int i;
+	int i, err = 0;
 
 	if (register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
 		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
 			PP_MAJOR);
 		return -EIO;
 	}
+	ppdev_class = class_simple_create(THIS_MODULE, CHRDEV);
+	if (IS_ERR(ppdev_class)) {
+		err = PTR_ERR(ppdev_class);
+		goto out_chrdev;
+	}
 	devfs_mk_dir("parports");
 	for (i = 0; i < PARPORT_MAX; i++) {
-		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
+		class_simple_device_add(ppdev_class, MKDEV(PP_MAJOR, i), 
+				NULL, "parport%d", i);
+		err = devfs_mk_cdev(MKDEV(PP_MAJOR, i),
 				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
+		if (err)
+			goto out_class;
 	}
 
 	printk (KERN_INFO PP_VERSION "\n");
-	return 0;
+	goto out;
+
+out_class:
+	for (i = 0; i < PARPORT_MAX; i++)
+		class_simple_device_remove(MKDEV(PP_MAJOR, i));
+	class_simple_destroy(ppdev_class);
+out_chrdev:
+	unregister_chrdev(PP_MAJOR, CHRDEV);
+out:
+	return err;
 }
 
 static void __exit ppdev_cleanup (void)
 {
 	int i;
 	/* Clean up all parport stuff */
-	for (i = 0; i < PARPORT_MAX; i++)
+	for (i = 0; i < PARPORT_MAX; i++) {
+		class_simple_device_remove(MKDEV(PP_MAJOR, i));
 		devfs_remove("parports/%d", i);
+	}
+	class_simple_destroy(ppdev_class);
 	devfs_remove("parports");
 	unregister_chrdev (PP_MAJOR, CHRDEV);
 }


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

