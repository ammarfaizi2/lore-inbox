Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUBIXiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUBIXcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:32:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:27071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265501AbUBIX3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:29:01 -0500
Subject: [PATCH] Driver Core update for 2.6.3-rc1
In-Reply-To: <20040209231325.GC2393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:25:40 -0800
Message-Id: <10763691402412@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.2.170, 2004/02/06 14:07:24-08:00, corbet@lwn.net

[PATCH] Char drivers: cdev_unmap()

To recap my argument: the current cdev implementation keeps an uncounted
reference to every cdev in cdev_map.  Creators of cdevs must know to call
cdev_unmap() with the same arguments they passed to cdev_add() before
releasing the device, or that reference will remain and will oops the
kernel should user space attempt to open the (missing) device.  It's an
easy mistake to make, and, IMO, entirely unnecessary; the cdev code should
be able to do its own bookkeeping.


 drivers/char/tty_io.c        |    1 -
 drivers/ieee1394/amdtp.c     |    1 -
 drivers/ieee1394/dv1394.c    |    1 -
 drivers/ieee1394/raw1394.c   |    1 -
 drivers/ieee1394/video1394.c |    1 -
 drivers/scsi/sg.c            |    1 -
 drivers/scsi/st.c            |    4 ----
 fs/char_dev.c                |    7 ++++---
 include/linux/cdev.h         |    4 ++--
 9 files changed, 6 insertions(+), 15 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/char/tty_io.c	Mon Feb  9 15:09:00 2004
@@ -2264,7 +2264,6 @@
 	if (driver->refcount)
 		return -EBUSY;
 
-	cdev_unmap(MKDEV(driver->major, driver->minor_start), driver->num);
 	unregister_chrdev_region(MKDEV(driver->major, driver->minor_start),
 				driver->num);
 
diff -Nru a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/ieee1394/amdtp.c	Mon Feb  9 15:09:00 2004
@@ -1308,7 +1308,6 @@
 
         hpsb_unregister_highlevel(&amdtp_highlevel);
 	devfs_remove("amdtp");
-	cdev_unmap(IEEE1394_AMDTP_DEV, 16);
 	cdev_del(&amdtp_cdev);
 
 	HPSB_INFO("Unloaded AMDTP driver");
diff -Nru a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/ieee1394/dv1394.c	Mon Feb  9 15:09:00 2004
@@ -2609,7 +2609,6 @@
 	hpsb_unregister_protocol(&dv1394_driver);
 
 	hpsb_unregister_highlevel(&dv1394_highlevel);
-	cdev_unmap(IEEE1394_DV1394_DEV, 16);
 	cdev_del(&dv1394_cdev);
 	devfs_remove("ieee1394/dv");
 }
diff -Nru a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/ieee1394/raw1394.c	Mon Feb  9 15:09:00 2004
@@ -2682,7 +2682,6 @@
 static void __exit cleanup_raw1394(void)
 {
 	hpsb_unregister_protocol(&raw1394_driver);
-	cdev_unmap(IEEE1394_RAW1394_DEV, 1);
 	cdev_del(&raw1394_cdev);
         devfs_remove(RAW1394_DEVICE_NAME);
         hpsb_unregister_highlevel(&raw1394_highlevel);
diff -Nru a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/ieee1394/video1394.c	Mon Feb  9 15:09:00 2004
@@ -1447,7 +1447,6 @@
 	hpsb_unregister_highlevel(&video1394_highlevel);
 
 	devfs_remove(VIDEO1394_DRIVER_NAME);
-	cdev_unmap(IEEE1394_VIDEO1394_DEV, 16);
 	cdev_del(&video1394_cdev);
 
 	PRINT_G(KERN_INFO, "Removed " VIDEO1394_DRIVER_NAME " module");
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/scsi/sg.c	Mon Feb  9 15:09:00 2004
@@ -1521,7 +1521,6 @@
 	if (sdp) {
 		sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
 		class_simple_device_remove(MKDEV(SCSI_GENERIC_MAJOR, k));
-		cdev_unmap(MKDEV(SCSI_GENERIC_MAJOR, k), 1);
 		cdev_del(sdp->cdev);
 		sdp->cdev = NULL;
 		devfs_remove("%s/generic", scsidp->devfs_name);
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Mon Feb  9 15:09:00 2004
+++ b/drivers/scsi/st.c	Mon Feb  9 15:09:00 2004
@@ -3946,8 +3946,6 @@
 				if (cdev == STm->cdevs[j])
 					cdev = NULL;
 				sysfs_remove_link(&STm->cdevs[j]->kobj, "device");
-				cdev_unmap(MKDEV(SCSI_TAPE_MAJOR,
-						 TAPE_MINOR(dev_num, mode, j)), 1);
 				cdev_del(STm->cdevs[j]);
 			}
 		}
@@ -3990,8 +3988,6 @@
 				for (j=0; j < 2; j++) {
 					sysfs_remove_link(&tpnt->modes[mode].cdevs[j]->kobj,
 							  "device");
-					cdev_unmap(MKDEV(SCSI_TAPE_MAJOR,
-							 TAPE_MINOR(i, mode, j)), 1);
 					cdev_del(tpnt->modes[mode].cdevs[j]);
 					tpnt->modes[mode].cdevs[j] = NULL;
 				}
diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Mon Feb  9 15:09:00 2004
+++ b/fs/char_dev.c	Mon Feb  9 15:09:00 2004
@@ -240,7 +240,6 @@
 int unregister_chrdev(unsigned int major, const char *name)
 {
 	struct char_device_struct *cd;
-	cdev_unmap(MKDEV(major, 0), 256);
 	cd = __unregister_chrdev_region(major, 0, 256);
 	if (cd && cd->cdev)
 		cdev_del(cd->cdev);
@@ -347,16 +346,19 @@
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
@@ -458,6 +460,5 @@
 EXPORT_SYMBOL(cdev_put);
 EXPORT_SYMBOL(cdev_del);
 EXPORT_SYMBOL(cdev_add);
-EXPORT_SYMBOL(cdev_unmap);
 EXPORT_SYMBOL(register_chrdev);
 EXPORT_SYMBOL(unregister_chrdev);
diff -Nru a/include/linux/cdev.h b/include/linux/cdev.h
--- a/include/linux/cdev.h	Mon Feb  9 15:09:00 2004
+++ b/include/linux/cdev.h	Mon Feb  9 15:09:00 2004
@@ -7,6 +7,8 @@
 	struct module *owner;
 	struct file_operations *ops;
 	struct list_head list;
+	dev_t dev;
+	unsigned int count;
 };
 
 void cdev_init(struct cdev *, struct file_operations *);
@@ -20,8 +22,6 @@
 int cdev_add(struct cdev *, dev_t, unsigned);
 
 void cdev_del(struct cdev *);
-
-void cdev_unmap(dev_t, unsigned);
 
 void cd_forget(struct inode *);
 

