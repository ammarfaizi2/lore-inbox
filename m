Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUAZVsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUAZVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:48:12 -0500
Received: from vena.lwn.net ([206.168.112.25]:60850 "HELO lwn.net")
	by vger.kernel.org with SMTP id S265552AbUAZVsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:48:02 -0500
Message-ID: <20040126214802.26666.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] cdev_unmap()
cc: viro@parcelfarce.linux.theplanet.co.uk
From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 26 Jan 2004 14:48:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers which use the cdev interface, it seems, must call cdev_unmap()
prior to removing their devices with cdev_del().  This is important -
otherwise the char dev subsystem maintains a non-reference-counted pointer
to the cdev structure, and references to the wrong device number after the
relevant module has been unloaded can create all sorts of internal
trouble. 

The 2.6.2-rc2 st and sg drivers fail to call cdev_unmap(), for what it's
worth. 

One can certainly document the cdev interface to note that, while a single
call (cdev_add()) is sufficient to add a cdev to the system, two calls are
required to remove it.  And you must remember the device number and count
you used for cdev_add() too.  All this can be made to work.  It would be
better to bump the cdev's reference count for as long as a pointer lives in
cdev_map, though.

But why?  It's an extra thing to remember, has catastrophic consequences if
somebody screws up (but driver programmers never do that), exposes some of
the cdev code's internal recordkeeping, and seems unnecessary.  Can
somebody tell me if there's anything wrong with the following patch, which
eliminates the need to call cdev_unmap() and unexports it?

jon

diff -urNp -X dontdiff 2.6.2-rc2-vanilla/drivers/char/tty_io.c 2.6.2-rc2/drivers/char/tty_io.c
--- 2.6.2-rc2-vanilla/drivers/char/tty_io.c	2004-01-27 02:14:22.000000000 -0700
+++ 2.6.2-rc2/drivers/char/tty_io.c	2004-01-27 04:44:30.000000000 -0700
@@ -2259,7 +2259,6 @@ int tty_unregister_driver(struct tty_dri
 	if (driver->refcount)
 		return -EBUSY;
 
-	cdev_unmap(MKDEV(driver->major, driver->minor_start), driver->num);
 	unregister_chrdev_region(MKDEV(driver->major, driver->minor_start),
 				driver->num);
 
diff -urNp -X dontdiff 2.6.2-rc2-vanilla/drivers/ieee1394/amdtp.c 2.6.2-rc2/drivers/ieee1394/amdtp.c
--- 2.6.2-rc2-vanilla/drivers/ieee1394/amdtp.c	2004-01-27 02:14:23.000000000 -0700
+++ 2.6.2-rc2/drivers/ieee1394/amdtp.c	2004-01-27 04:44:30.000000000 -0700
@@ -1308,7 +1308,6 @@ static void __exit amdtp_exit_module (vo
 
         hpsb_unregister_highlevel(&amdtp_highlevel);
 	devfs_remove("amdtp");
-	cdev_unmap(IEEE1394_AMDTP_DEV, 16);
 	cdev_del(&amdtp_cdev);
 
 	HPSB_INFO("Unloaded AMDTP driver");
diff -urNp -X dontdiff 2.6.2-rc2-vanilla/drivers/ieee1394/dv1394.c 2.6.2-rc2/drivers/ieee1394/dv1394.c
--- 2.6.2-rc2-vanilla/drivers/ieee1394/dv1394.c	2004-01-27 02:14:23.000000000 -0700
+++ 2.6.2-rc2/drivers/ieee1394/dv1394.c	2004-01-27 04:44:30.000000000 -0700
@@ -2609,7 +2609,6 @@ static void __exit dv1394_exit_module(vo
 	hpsb_unregister_protocol(&dv1394_driver);
 
 	hpsb_unregister_highlevel(&dv1394_highlevel);
-	cdev_unmap(IEEE1394_DV1394_DEV, 16);
 	cdev_del(&dv1394_cdev);
 	devfs_remove("ieee1394/dv");
 }
diff -urNp -X dontdiff 2.6.2-rc2-vanilla/drivers/ieee1394/raw1394.c 2.6.2-rc2/drivers/ieee1394/raw1394.c
--- 2.6.2-rc2-vanilla/drivers/ieee1394/raw1394.c	2004-01-27 02:14:24.000000000 -0700
+++ 2.6.2-rc2/drivers/ieee1394/raw1394.c	2004-01-27 04:44:30.000000000 -0700
@@ -2682,7 +2682,6 @@ static int __init init_raw1394(void)
 static void __exit cleanup_raw1394(void)
 {
 	hpsb_unregister_protocol(&raw1394_driver);
-	cdev_unmap(IEEE1394_RAW1394_DEV, 1);
 	cdev_del(&raw1394_cdev);
         devfs_remove(RAW1394_DEVICE_NAME);
         hpsb_unregister_highlevel(&raw1394_highlevel);
diff -urNp -X dontdiff 2.6.2-rc2-vanilla/drivers/ieee1394/video1394.c 2.6.2-rc2/drivers/ieee1394/video1394.c
--- 2.6.2-rc2-vanilla/drivers/ieee1394/video1394.c	2004-01-27 02:14:24.000000000 -0700
+++ 2.6.2-rc2/drivers/ieee1394/video1394.c	2004-01-27 04:44:30.000000000 -0700
@@ -1447,7 +1447,6 @@ static void __exit video1394_exit_module
 	hpsb_unregister_highlevel(&video1394_highlevel);
 
 	devfs_remove(VIDEO1394_DRIVER_NAME);
-	cdev_unmap(IEEE1394_VIDEO1394_DEV, 16);
 	cdev_del(&video1394_cdev);
 
 	PRINT_G(KERN_INFO, "Removed " VIDEO1394_DRIVER_NAME " module");
diff -urNp -X dontdiff 2.6.2-rc2-vanilla/fs/char_dev.c 2.6.2-rc2/fs/char_dev.c
--- 2.6.2-rc2-vanilla/fs/char_dev.c	2004-01-27 02:14:04.000000000 -0700
+++ 2.6.2-rc2/fs/char_dev.c	2004-01-27 05:14:36.000000000 -0700
@@ -240,7 +240,6 @@ void unregister_chrdev_region(dev_t from
 int unregister_chrdev(unsigned int major, const char *name)
 {
 	struct char_device_struct *cd;
-	cdev_unmap(MKDEV(major, 0), 256);
 	cd = __unregister_chrdev_region(major, 0, 256);
 	if (cd && cd->cdev)
 		cdev_del(cd->cdev);
@@ -347,6 +346,8 @@ int cdev_add(struct cdev *p, dev_t dev, 
 	err = kobj_map(cdev_map, dev, count, NULL, exact_match, exact_lock, p);
 	if (err)
 		kobject_del(&p->kobj);
+	p->dev = dev;
+	p->count = count;
 	return err;
 }
 
@@ -357,6 +358,7 @@ void cdev_unmap(dev_t dev, unsigned coun
 
 void cdev_del(struct cdev *p)
 {
+	cdev_unmap(p->dev, p->count);
 	kobject_del(&p->kobj);
 	kobject_put(&p->kobj);
 }
@@ -458,6 +460,5 @@ EXPORT_SYMBOL(cdev_get);
 EXPORT_SYMBOL(cdev_put);
 EXPORT_SYMBOL(cdev_del);
 EXPORT_SYMBOL(cdev_add);
-EXPORT_SYMBOL(cdev_unmap);
 EXPORT_SYMBOL(register_chrdev);
 EXPORT_SYMBOL(unregister_chrdev);
diff -urNp -X dontdiff 2.6.2-rc2-vanilla/include/linux/cdev.h 2.6.2-rc2/include/linux/cdev.h
--- 2.6.2-rc2-vanilla/include/linux/cdev.h	2003-09-08 13:50:09.000000000 -0600
+++ 2.6.2-rc2/include/linux/cdev.h	2004-01-27 04:38:57.000000000 -0700
@@ -7,6 +7,8 @@ struct cdev {
 	struct module *owner;
 	struct file_operations *ops;
 	struct list_head list;
+	dev_t dev;
+	unsigned int count;
 };
 
 void cdev_init(struct cdev *, struct file_operations *);
