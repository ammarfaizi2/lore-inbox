Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUAOUqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUAOUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:44:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:24283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262796AbUAOUoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:16 -0500
Date: Thu, 15 Jan 2004 12:42:09 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs class support for misc devices [05/10]
Message-ID: <20040115204209.GF22199@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204153.GE22199@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds class/misc/ for all misc devices (ones that use the
misc_register() function).

diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Thu Jan 15 11:05:56 2004
+++ b/drivers/char/misc.c	Thu Jan 15 11:05:56 2004
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
--- a/include/linux/miscdevice.h	Thu Jan 15 11:05:53 2004
+++ b/include/linux/miscdevice.h	Thu Jan 15 11:05:53 2004
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
 
