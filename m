Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUAOUqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAOUoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:44:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:14299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262795AbUAOUoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:05 -0500
Date: Thu, 15 Jan 2004 12:42:41 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs class support for raw devices [06/10]
Message-ID: <20040115204241.GG22199@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com> <20040115204209.GF22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204209.GF22199@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds class/raw/ support for all raw devices.  It also provides a
symlink to the block device that the raw device is mapped to.  For
example:

$ tree /sys/class/raw/
/sys/class/raw/
|-- raw1
|   |-- dev
|   `-- device -> ../../../block/sda
|-- raw2
|   |-- dev
|   `-- device -> ../../../block/sda/sda2
`-- rawctl
    `-- dev


Note, in order to get that symlink, I had to export get_gendisk() so that
modules can use it.  I hope this is ok with everyone.

This is based on a patch originally written by 
Leann Ogasawara <ogasawara@osdl.org>



diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Thu Jan 15 11:05:57 2004
+++ b/drivers/block/genhd.c	Thu Jan 15 11:05:57 2004
@@ -224,6 +224,8 @@
 	return  kobj ? to_disk(kobj) : NULL;
 }
 
+EXPORT_SYMBOL(get_gendisk);
+
 #ifdef CONFIG_PROC_FS
 /* iterator */
 static void *part_start(struct seq_file *part, loff_t *pos)
diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Thu Jan 15 11:05:47 2004
+++ b/drivers/char/raw.c	Thu Jan 15 11:05:47 2004
@@ -17,6 +17,8 @@
 #include <linux/raw.h>
 #include <linux/capability.h>
 #include <linux/uio.h>
+#include <linux/device.h>
+#include <linux/genhd.h>
 
 #include <asm/uaccess.h>
 
@@ -25,6 +27,7 @@
 	int inuse;
 };
 
+static struct class_simple *raw_class;
 static struct raw_device_data raw_devices[MAX_RAW_MINORS];
 static DECLARE_MUTEX(raw_mutex);
 static struct file_operations raw_ctl_fops;	     /* forward declaration */
@@ -119,6 +122,29 @@
 	return ioctl_by_bdev(bdev, command, arg);
 }
 
+static void bind_device(struct raw_config_request rq)
+{
+	int part;
+	struct gendisk *gen;
+	struct class_device *dev;
+	struct kobject *target = NULL;
+
+	gen = get_gendisk(MKDEV(rq.block_major, rq.block_minor), &part);
+	if (gen) {
+		if (part && gen->part[part])
+			target = &gen->part[part]->kobj;
+		else
+			target = &gen->kobj;
+	}
+
+	class_simple_device_remove(MKDEV(RAW_MAJOR, rq.raw_minor));
+	dev = class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, rq.raw_minor),
+				      NULL, "raw%d", rq.raw_minor);
+	if (dev && target) {
+		sysfs_create_link(&dev->kobj, target, "device");
+	}
+}
+
 /*
  * Deal with ioctls against the raw-device control interface, to bind
  * and unbind other raw devices.
@@ -187,12 +213,15 @@
 			if (rq.block_major == 0 && rq.block_minor == 0) {
 				/* unbind */
 				rawdev->binding = NULL;
+				class_simple_device_remove(MKDEV(RAW_MAJOR, rq.raw_minor));
 			} else {
 				rawdev->binding = bdget(dev);
 				if (rawdev->binding == NULL)
 					err = -ENOMEM;
-				else
+				else {
 					__module_get(THIS_MODULE);
+					bind_device(rq);
+				}
 			}
 			up(&raw_mutex);
 		} else {
@@ -262,6 +291,14 @@
 	int i;
 
 	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+
+	raw_class = class_simple_create(THIS_MODULE, "raw");
+	if (IS_ERR(raw_class)) {
+		printk (KERN_ERR "Error creating raw class.\n");
+		return PTR_ERR(raw_class);
+	}
+	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
+
 	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
 		      S_IFCHR | S_IRUGO | S_IWUGO,
 		      "raw/rawctl");
@@ -280,6 +317,8 @@
 		devfs_remove("raw/raw%d", i);
 	devfs_remove("raw/rawctl");
 	devfs_remove("raw");
+	class_simple_device_remove(MKDEV(RAW_MAJOR, 0));
+	class_simple_destroy(raw_class);
 	unregister_chrdev(RAW_MAJOR, "raw");
 }
 
