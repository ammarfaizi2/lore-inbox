Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUCPA7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUCPA4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:56:22 -0500
Received: from fmr04.intel.com ([143.183.121.6]:17377 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262888AbUCPAxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:53:37 -0500
Message-Id: <200403160053.i2G0rNm31241@unix-os.sc.intel.com>
From: "Kenneth Chen" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Patch - make config_max_raw_devices work
Date: Mon, 15 Mar 2004 16:53:23 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQK8RT9znrkbjNjTBeiDzSkh110lg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even though there is a CONFIG_MAX_RAW_DEVS option, it doesn't actually
increase the number of raw devices beyond 256 because during the char
registration, it uses the standard register_chrdev() interface which
has hard coded 256 minor in it.  Here is a patch that fix this problem
by using register_chrdev_region() and cdev_(init/add/del) functions.

I'm also thinking this config option probably should be converted into
module_param.  Would that be worthwhile?

- Ken



diff -Nurp linux-2.6.4/drivers/char/raw.c linux-2.6.4-raw/drivers/char/raw.c
--- linux-2.6.4/drivers/char/raw.c	2004-03-10 18:55:34.000000000 -0800
+++ linux-2.6.4-raw/drivers/char/raw.c	2004-03-15 15:51:19.000000000 -0800
@@ -17,6 +17,7 @@
 #include <linux/raw.h>
 #include <linux/capability.h>
 #include <linux/uio.h>
+#include <linux/cdev.h>

 #include <asm/uaccess.h>

@@ -260,11 +261,26 @@ static struct file_operations raw_ctl_fo
 	.owner	=	THIS_MODULE,
 };

+static struct cdev raw_cdev = {
+	.kobj	=	{.name = "raw", },
+	.owner	=	THIS_MODULE,
+};
+
 static int __init raw_init(void)
 {
 	int i;
+	dev_t dev = MKDEV(RAW_MAJOR, 0);
+
+	if (register_chrdev_region(dev, MAX_RAW_MINORS, "raw"))
+		goto error;
+
+	cdev_init(&raw_cdev, &raw_fops);
+	if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
+		kobject_put(&raw_cdev.kobj);
+		unregister_chrdev_region(dev, MAX_RAW_MINORS);
+		goto error;
+	}

-	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
 	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
 		      S_IFCHR | S_IRUGO | S_IWUGO,
 		      "raw/rawctl");
@@ -273,6 +289,10 @@ static int __init raw_init(void)
 			      S_IFCHR | S_IRUGO | S_IWUGO,
 			      "raw/raw%d", i);
 	return 0;
+
+error:
+	printk(KERN_ERR "error register raw device\n");
+	return 1;
 }

 static void __exit raw_exit(void)
@@ -283,7 +303,8 @@ static void __exit raw_exit(void)
 		devfs_remove("raw/raw%d", i);
 	devfs_remove("raw/rawctl");
 	devfs_remove("raw");
-	unregister_chrdev(RAW_MAJOR, "raw");
+	cdev_del(&raw_cdev);
+	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), MAX_RAW_MINORS);
 }

 module_init(raw_init);


