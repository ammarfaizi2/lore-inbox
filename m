Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUENXKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUENXKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUENXK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:10:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:52956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263226AbUENXIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:07 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760424123@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <10845760422513@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.19, 2004/05/04 14:16:58-07:00, olh@suse.de

[PATCH] add simple class for adb

This adds /sys/class/adb/, removes unused devfs lines and updates a
comment to match reality.


 drivers/macintosh/adb.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)


diff -Nru a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c	Fri May 14 15:58:13 2004
+++ b/drivers/macintosh/adb.c	Fri May 14 15:58:13 2004
@@ -10,7 +10,7 @@
  *
  * To do:
  *
- * - /proc/adb to list the devices and infos
+ * - /sys/bus/adb to list the devices and infos
  * - more /dev/adb to allow userland to receive the
  *   flow of auto-polling datas from a given device.
  * - move bus probe to a kernel thread
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
@@ -36,6 +35,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/completion.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #ifdef CONFIG_PPC
@@ -75,6 +75,8 @@
 	NULL
 };
 
+static struct class_simple *adb_dev_class;
+
 struct adb_driver *adb_controller;
 struct notifier_block *adb_client_list = NULL;
 static int adb_got_sleep;
@@ -883,6 +885,7 @@
 }
 
 static struct file_operations adb_fops = {
+	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= adb_read,
 	.write		= adb_write,
@@ -893,9 +896,13 @@
 static void
 adbdev_init(void)
 {
-	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops))
+	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
 		printk(KERN_ERR "adb: unable to get major %d\n", ADB_MAJOR);
-	else
-		devfs_mk_cdev(MKDEV(ADB_MAJOR, 0),
-				S_IFCHR | S_IRUSR | S_IWUSR, "adb");
+		return;
+	}
+	adb_dev_class = class_simple_create(THIS_MODULE, "adb");
+	if (IS_ERR(adb_dev_class)) {
+		return;
+	}
+	class_simple_device_add(adb_dev_class, MKDEV(ADB_MAJOR, 0), NULL, "adb");
 }

