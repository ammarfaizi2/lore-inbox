Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUATBzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUATBOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:14:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:35785 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265359AbUATBMx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:53 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <1074561160498@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:40 -0800
Message-Id: <10745611601623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1502, 2004/01/19 16:41:53-08:00, greg@kroah.com

[PATCH] MISC: add sysfs class support for misc devices

This adds class/misc/ for all misc devices (ones that use the
misc_register() function).


 drivers/char/misc.c        |   17 +++++++++++++++--
 include/linux/miscdevice.h |    3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Mon Jan 19 17:04:53 2004
+++ b/drivers/char/misc.c	Mon Jan 19 17:04:53 2004
@@ -47,7 +47,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/stat.h>
 #include <linux/init.h>
-
+#include <linux/device.h>
 #include <linux/tty.h>
 #include <linux/kmod.h>
 
@@ -180,6 +180,13 @@
 	return err;
 }
 
+/* 
+ * TODO for 2.7:
+ *  - add a struct class_device to struct miscdevice and make all usages of
+ *    them dynamic.
+ */
+static struct class_simple *misc_class;
+
 static struct file_operations misc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= misc_open,
@@ -234,6 +241,8 @@
 				"misc/%s", misc->name);
 	}
 
+	class_simple_device_add(misc_class, MKDEV(MISC_MAJOR, misc->minor),
+				misc->dev, misc->name);
 	devfs_mk_cdev(MKDEV(MISC_MAJOR, misc->minor),
 			S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, misc->devfs_name);
 
@@ -265,6 +274,7 @@
 
 	down(&misc_sem);
 	list_del(&misc->list);
+	class_simple_device_remove(MKDEV(MISC_MAJOR, misc->minor));
 	devfs_remove(misc->devfs_name);
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
@@ -285,6 +295,9 @@
 	if (ent)
 		ent->proc_fops = &misc_proc_fops;
 #endif
+	misc_class = class_simple_create(THIS_MODULE, "misc");
+	if (IS_ERR(misc_class))
+		return PTR_ERR(misc_class);
 #ifdef CONFIG_MVME16x
 	rtc_MK48T08_init();
 #endif
@@ -319,4 +332,4 @@
 	}
 	return 0;
 }
-module_init(misc_init);
+subsys_initcall(misc_init);
diff -Nru a/include/linux/miscdevice.h b/include/linux/miscdevice.h
--- a/include/linux/miscdevice.h	Mon Jan 19 17:04:53 2004
+++ b/include/linux/miscdevice.h	Mon Jan 19 17:04:53 2004
@@ -36,12 +36,15 @@
 
 #define TUN_MINOR	     200
 
+struct device;
+
 struct miscdevice 
 {
 	int minor;
 	const char *name;
 	struct file_operations *fops;
 	struct list_head list;
+	struct device *dev;
 	char devfs_name[64];
 };
 

