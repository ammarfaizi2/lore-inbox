Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTLWVbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTLWVbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:31:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:48351 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262580AbTLWVbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:31:38 -0500
Date: Tue, 23 Dec 2003 13:30:37 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs misc class  [4/5]
Message-ID: <20031223213037.GE15700@kroah.com>
References: <20031223212459.GA15700@kroah.com> <20031223212620.GB15700@kroah.com> <20031223212739.GC15700@kroah.com> <20031223212929.GD15700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223212929.GD15700@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs misc class support, and fix bug where misc_init() was being
called to late in the boot process.

diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Tue Dec 23 12:53:35 2003
+++ b/drivers/char/misc.c	Tue Dec 23 12:53:35 2003
@@ -47,7 +47,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/stat.h>
 #include <linux/init.h>
-
+#include <linux/device.h>
 #include <linux/tty.h>
 #include <linux/kmod.h>
 
@@ -180,6 +180,15 @@
 	return err;
 }
 
+/* 
+ * TODO for 2.7:
+ *  - add a struct class_device to struct miscdevice and make all usages of
+ *    them dynamic.
+ */
+static struct class misc_class = {
+	.name	= "misc",
+};
+
 static struct file_operations misc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= misc_open,
@@ -234,6 +243,8 @@
 				"misc/%s", misc->name);
 	}
 
+	simple_add_class_device(&misc_class, MKDEV(MISC_MAJOR, misc->minor),
+				misc->dev, misc->name);
 	devfs_mk_cdev(MKDEV(MISC_MAJOR, misc->minor),
 			S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, misc->devfs_name);
 
@@ -265,6 +276,7 @@
 
 	down(&misc_sem);
 	list_del(&misc->list);
+	simple_remove_class_device(MKDEV(MISC_MAJOR, misc->minor));
 	devfs_remove(misc->devfs_name);
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
@@ -285,6 +297,7 @@
 	if (ent)
 		ent->proc_fops = &misc_proc_fops;
 #endif
+	class_register(&misc_class);
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
--- a/include/linux/miscdevice.h	Tue Dec 23 12:53:25 2003
+++ b/include/linux/miscdevice.h	Tue Dec 23 12:53:25 2003
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
 
