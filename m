Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUFVT2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUFVT2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUFVSH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:07:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:30901 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265052AbUFVRnT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:19 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926109433@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:49 -0700
Message-Id: <10879261093697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.46, 2004/06/03 09:48:45-07:00, greg@kroah.com

Add basic sysfs support for raw devices

This is needed by people who use udev and want raw devices.
SuSE is shipping with this patch.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/raw.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Tue Jun 22 09:49:10 2004
+++ b/drivers/char/raw.c	Tue Jun 22 09:49:10 2004
@@ -18,6 +18,7 @@
 #include <linux/capability.h>
 #include <linux/uio.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -26,6 +27,7 @@
 	int inuse;
 };
 
+static struct class_simple *raw_class;
 static struct raw_device_data raw_devices[MAX_RAW_MINORS];
 static DECLARE_MUTEX(raw_mutex);
 static struct file_operations raw_ctl_fops;	     /* forward declaration */
@@ -123,6 +125,13 @@
 	return ioctl_by_bdev(bdev, command, arg);
 }
 
+static void bind_device(struct raw_config_request rq)
+{
+	class_simple_device_remove(MKDEV(RAW_MAJOR, rq.raw_minor));
+	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, rq.raw_minor),
+				      NULL, "raw%d", rq.raw_minor);
+}
+
 /*
  * Deal with ioctls against the raw-device control interface, to bind
  * and unbind other raw devices.
@@ -191,12 +200,15 @@
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
+					}
 			}
 			up(&raw_mutex);
 		} else {
@@ -287,6 +299,15 @@
 		goto error;
 	}
 
+	raw_class = class_simple_create(THIS_MODULE, "raw");
+	if (IS_ERR(raw_class)) {
+		printk(KERN_ERR "Error creating raw class.\n");
+		cdev_del(&raw_cdev);
+		unregister_chrdev_region(dev, MAX_RAW_MINORS);
+		goto error;
+	}
+	class_simple_device_add(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
+
 	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
 		      S_IFCHR | S_IRUGO | S_IWUGO,
 		      "raw/rawctl");
@@ -309,6 +330,8 @@
 		devfs_remove("raw/raw%d", i);
 	devfs_remove("raw/rawctl");
 	devfs_remove("raw");
+	class_simple_device_remove(MKDEV(RAW_MAJOR, 0));
+	class_simple_destroy(raw_class);
 	cdev_del(&raw_cdev);
 	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), MAX_RAW_MINORS);
 }

