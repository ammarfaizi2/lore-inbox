Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266556AbUBESBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUBESBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:01:22 -0500
Received: from vena.lwn.net ([206.168.112.25]:11418 "HELO lwn.net")
	by vger.kernel.org with SMTP id S266556AbUBESBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:01:05 -0500
Message-ID: <20040205180103.32517.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Take 2: cdev_unmap()
cc: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 05 Feb 2004 11:01:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't get any responses to my last posting on cdev_unmap(); I take it
that means nobody objects :)

To recap my argument: the current cdev implementation keeps an uncounted
reference to every cdev in cdev_map.  Creators of cdevs must know to call
cdev_unmap() with the same arguments they passed to cdev_add() before
releasing the device, or that reference will remain and will oops the
kernel should user space attempt to open the (missing) device.  It's an
easy mistake to make, and, IMO, entirely unnecessary; the cdev code should
be able to do its own bookkeeping.

So, does anybody have a reason why this shouldn't go in?  Al, have I missed
something?

[This is against 2.6.2-mm1].

jon

diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/char/tty_io.c 2.6.2-mm1/drivers/char/tty_io.c
--- 2.6.2-mm1-v/drivers/char/tty_io.c	2004-02-06 00:53:14.000000000 -0700
+++ 2.6.2-mm1/drivers/char/tty_io.c	2004-02-06 01:18:38.000000000 -0700
@@ -2264,7 +2264,6 @@ int tty_unregister_driver(struct tty_dri
 	if (driver->refcount)
 		return -EBUSY;
 
-	cdev_unmap(MKDEV(driver->major, driver->minor_start), driver->num);
 	unregister_chrdev_region(MKDEV(driver->major, driver->minor_start),
 				driver->num);
 
diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/ieee1394/amdtp.c 2.6.2-mm1/drivers/ieee1394/amdtp.c
--- 2.6.2-mm1-v/drivers/ieee1394/amdtp.c	2004-02-06 00:51:44.000000000 -0700
+++ 2.6.2-mm1/drivers/ieee1394/amdtp.c	2004-02-06 01:18:38.000000000 -0700
@@ -1308,7 +1308,6 @@ static void __exit amdtp_exit_module (vo
 
         hpsb_unregister_highlevel(&amdtp_highlevel);
 	devfs_remove("amdtp");
-	cdev_unmap(IEEE1394_AMDTP_DEV, 16);
 	cdev_del(&amdtp_cdev);
 
 	HPSB_INFO("Unloaded AMDTP driver");
diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/ieee1394/dv1394.c 2.6.2-mm1/drivers/ieee1394/dv1394.c
--- 2.6.2-mm1-v/drivers/ieee1394/dv1394.c	2004-02-06 00:51:44.000000000 -0700
+++ 2.6.2-mm1/drivers/ieee1394/dv1394.c	2004-02-06 01:18:38.000000000 -0700
@@ -2609,7 +2609,6 @@ static void __exit dv1394_exit_module(vo
 	hpsb_unregister_protocol(&dv1394_driver);
 
 	hpsb_unregister_highlevel(&dv1394_highlevel);
-	cdev_unmap(IEEE1394_DV1394_DEV, 16);
 	cdev_del(&dv1394_cdev);
 	devfs_remove("ieee1394/dv");
 }
diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/ieee1394/raw1394.c 2.6.2-mm1/drivers/ieee1394/raw1394.c
--- 2.6.2-mm1-v/drivers/ieee1394/raw1394.c	2004-02-06 00:51:44.000000000 -0700
+++ 2.6.2-mm1/drivers/ieee1394/raw1394.c	2004-02-06 01:18:38.000000000 -0700
@@ -2682,7 +2682,6 @@ static int __init init_raw1394(void)
 static void __exit cleanup_raw1394(void)
 {
 	hpsb_unregister_protocol(&raw1394_driver);
-	cdev_unmap(IEEE1394_RAW1394_DEV, 1);
 	cdev_del(&raw1394_cdev);
         devfs_remove(RAW1394_DEVICE_NAME);
         hpsb_unregister_highlevel(&raw1394_highlevel);
diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/ieee1394/video1394.c 2.6.2-mm1/drivers/ieee1394/video1394.c
--- 2.6.2-mm1-v/drivers/ieee1394/video1394.c	2004-02-06 00:51:44.000000000 -0700
+++ 2.6.2-mm1/drivers/ieee1394/video1394.c	2004-02-06 01:18:38.000000000 -0700
@@ -1447,7 +1447,6 @@ static void __exit video1394_exit_module
 	hpsb_unregister_highlevel(&video1394_highlevel);
 
 	devfs_remove(VIDEO1394_DRIVER_NAME);
-	cdev_unmap(IEEE1394_VIDEO1394_DEV, 16);
 	cdev_del(&video1394_cdev);
 
 	PRINT_G(KERN_INFO, "Removed " VIDEO1394_DRIVER_NAME " module");
diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/scsi/sg.c 2.6.2-mm1/drivers/scsi/sg.c
--- 2.6.2-mm1-v/drivers/scsi/sg.c	2004-02-06 00:53:19.000000000 -0700
+++ 2.6.2-mm1/drivers/scsi/sg.c	2004-02-06 01:21:23.000000000 -0700
@@ -1521,7 +1521,6 @@ sg_remove(struct class_device *cl_dev)
 	if (sdp) {
 		sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
 		class_simple_device_remove(MKDEV(SCSI_GENERIC_MAJOR, k));
-		cdev_unmap(MKDEV(SCSI_GENERIC_MAJOR, k), 1);
 		cdev_del(sdp->cdev);
 		sdp->cdev = NULL;
 		devfs_remove("%s/generic", scsidp->devfs_name);
diff -urNp -X dontdiff 2.6.2-mm1-v/drivers/scsi/st.c 2.6.2-mm1/drivers/scsi/st.c
--- 2.6.2-mm1-v/drivers/scsi/st.c	2004-02-06 00:53:19.000000000 -0700
+++ 2.6.2-mm1/drivers/scsi/st.c	2004-02-06 01:21:37.000000000 -0700
@@ -3946,8 +3946,6 @@ out_free_tape:
 				if (cdev == STm->cdevs[j])
 					cdev = NULL;
 				sysfs_remove_link(&STm->cdevs[j]->kobj, "device");
-				cdev_unmap(MKDEV(SCSI_TAPE_MAJOR,
-						 TAPE_MINOR(dev_num, mode, j)), 1);
 				cdev_del(STm->cdevs[j]);
 			}
 		}
@@ -3990,8 +3988,6 @@ static int st_remove(struct device *dev)
 				for (j=0; j < 2; j++) {
 					sysfs_remove_link(&tpnt->modes[mode].cdevs[j]->kobj,
 							  "device");
-					cdev_unmap(MKDEV(SCSI_TAPE_MAJOR,
-							 TAPE_MINOR(i, mode, j)), 1);
 					cdev_del(tpnt->modes[mode].cdevs[j]);
 					tpnt->modes[mode].cdevs[j] = NULL;
 				}
diff -urNp -X dontdiff 2.6.2-mm1-v/fs/char_dev.c 2.6.2-mm1/fs/char_dev.c
--- 2.6.2-mm1-v/fs/char_dev.c	2004-02-06 00:51:25.000000000 -0700
+++ 2.6.2-mm1/fs/char_dev.c	2004-02-06 01:22:02.000000000 -0700
@@ -240,7 +240,6 @@ void unregister_chrdev_region(dev_t from
 int unregister_chrdev(unsigned int major, const char *name)
 {
 	struct char_device_struct *cd;
-	cdev_unmap(MKDEV(major, 0), 256);
 	cd = __unregister_chrdev_region(major, 0, 256);
 	if (cd && cd->cdev)
 		cdev_del(cd->cdev);
@@ -347,16 +346,19 @@ int cdev_add(struct cdev *p, dev_t dev, 
 	err = kobj_map(cdev_map, dev, count, NULL, exact_match, exact_lock, p);
 	if (err)
 		kobject_del(&p->kobj);
+	p->dev = dev;
+	p->count = count;
 	return err;
 }
 
-void cdev_unmap(dev_t dev, unsigned count)
+static void cdev_unmap(dev_t dev, unsigned count)
 {
 	kobj_unmap(cdev_map, dev, count);
 }
 
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
diff -urNp -X dontdiff 2.6.2-mm1-v/include/linux/cdev.h 2.6.2-mm1/include/linux/cdev.h
--- 2.6.2-mm1-v/include/linux/cdev.h	2003-09-08 13:50:09.000000000 -0600
+++ 2.6.2-mm1/include/linux/cdev.h	2004-02-06 01:22:02.000000000 -0700
@@ -7,6 +7,8 @@ struct cdev {
 	struct module *owner;
 	struct file_operations *ops;
 	struct list_head list;
+	dev_t dev;
+	unsigned int count;
 };
 
 void cdev_init(struct cdev *, struct file_operations *);
@@ -21,8 +23,6 @@ int cdev_add(struct cdev *, dev_t, unsig
 
 void cdev_del(struct cdev *);
 
-void cdev_unmap(dev_t, unsigned);
-
 void cd_forget(struct inode *);
 
 #endif

