Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUCPBWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUCPBQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:16:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:59311 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262948AbUCPAD0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:26 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951492163@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:09 -0800
Message-Id: <10793951492441@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.13, 2004/03/12 15:20:49-08:00, corbet@lwn.net

[PATCH] cdev 2/2: hide cdev->kobj

The existing cdev interface requires users to deal with the embedded
kobject in two places:

- The kobject name field must be set before adding the cdev, and
- Should cdev_add() fail, a call to kobject_put() is required.

IMO, this exposure of the embedded kobject makes the interface more brittle
and harder to understand.  It's also unnecessary.  With the removal of
/sys/cdev, a call to cdev_del() will nicely replace kobject_put(), and the
name setting is easily wrapped.

This is against 2.6.4, but depends on the /sys/cdev removal patch.


 drivers/char/tty_io.c          |   12 ++++++------
 drivers/ieee1394/amdtp.c       |    2 +-
 drivers/ieee1394/dv1394.c      |    2 +-
 drivers/ieee1394/raw1394.c     |    3 ++-
 drivers/ieee1394/video1394.c   |    2 +-
 drivers/s390/char/tape_class.c |    4 ++--
 drivers/scsi/sg.c              |    4 ++--
 drivers/scsi/st.c              |    5 ++---
 include/linux/cdev.h           |    2 ++
 9 files changed, 19 insertions(+), 17 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/char/tty_io.c	Mon Mar 15 15:28:33 2004
@@ -2274,14 +2274,14 @@
 		driver->termios_locked = NULL;
 	}
 
-	strcpy(driver->cdev.kobj.name, driver->name);
+	cdev_set_name(&driver->cdev, driver->name);
 	for (s = strchr(driver->cdev.kobj.name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
 	cdev_init(&driver->cdev, &tty_fops);
 	driver->cdev.owner = driver->owner;
 	error = cdev_add(&driver->cdev, dev, driver->num);
 	if (error) {
-		kobject_del(&driver->cdev.kobj);
+		cdev_del(&driver->cdev);
 		unregister_chrdev_region(dev, driver->num);
 		driver->ttys = NULL;
 		driver->termios = driver->termios_locked = NULL;
@@ -2414,7 +2414,7 @@
  */
 static int __init tty_init(void)
 {
-	strcpy(tty_cdev.kobj.name, "dev.tty");
+	cdev_set_name(&tty_cdev, "dev.tty");
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
@@ -2422,7 +2422,7 @@
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
-	strcpy(console_cdev.kobj.name, "dev.console");
+	cdev_set_name(&console_cdev, "dev.console");
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
@@ -2431,7 +2431,7 @@
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
-	strcpy(ptmx_cdev.kobj.name, "dev.ptmx");
+	cdev_set_name(&ptmx_cdev, "dev.ptmx");
 	cdev_init(&ptmx_cdev, &tty_fops);
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
@@ -2441,7 +2441,7 @@
 #endif
 
 #ifdef CONFIG_VT
-	strcpy(vc0_cdev.kobj.name, "dev.vc0");
+	cdev_set_name(&vc0_cdev, "dev.vc0");
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
diff -Nru a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/ieee1394/amdtp.c	Mon Mar 15 15:28:33 2004
@@ -1266,7 +1266,7 @@
 {
 	cdev_init(&amdtp_cdev, &amdtp_fops);
 	amdtp_cdev.owner = THIS_MODULE;
-	kobject_set_name(&amdtp_cdev.kobj, "amdtp");
+	cdev_set_name(&amdtp_cdev, "amdtp");
 	if (cdev_add(&amdtp_cdev, IEEE1394_AMDTP_DEV, 16)) {
 		HPSB_ERR("amdtp: unable to add char device");
  		return -EIO;
diff -Nru a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/ieee1394/dv1394.c	Mon Mar 15 15:28:33 2004
@@ -2616,7 +2616,7 @@
 
 	cdev_init(&dv1394_cdev, &dv1394_fops);
 	dv1394_cdev.owner = THIS_MODULE;
-	kobject_set_name(&dv1394_cdev.kobj, "dv1394");
+	cdev_set_name(&dv1394_cdev, "dv1394");
 	ret = cdev_add(&dv1394_cdev, IEEE1394_DV1394_DEV, 16);
 	if (ret) {
 		printk(KERN_ERR "dv1394: unable to register character device\n");
diff -Nru a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/ieee1394/raw1394.c	Mon Mar 15 15:28:33 2004
@@ -2746,9 +2746,10 @@
 
 	cdev_init(&raw1394_cdev, &raw1394_fops);
 	raw1394_cdev.owner = THIS_MODULE;
-	kobject_set_name(&raw1394_cdev.kobj, RAW1394_DEVICE_NAME);
+	cdev_set_name(&raw1394_cdev, RAW1394_DEVICE_NAME);
 	ret = cdev_add(&raw1394_cdev, IEEE1394_RAW1394_DEV, 1);
 	if (ret) {
+		/* jmc: leaves reference to (static) raw1394_cdev */
                 HPSB_ERR("raw1394 failed to register minor device block");
                 devfs_remove(RAW1394_DEVICE_NAME);
                 hpsb_unregister_highlevel(&raw1394_highlevel);
diff -Nru a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/ieee1394/video1394.c	Mon Mar 15 15:28:33 2004
@@ -1457,7 +1457,7 @@
 
 	cdev_init(&video1394_cdev, &video1394_fops);
 	video1394_cdev.owner = THIS_MODULE;
-	kobject_set_name(&video1394_cdev.kobj, VIDEO1394_DRIVER_NAME);
+	cdev_set_name(&video1394_cdev, VIDEO1394_DRIVER_NAME);
 	ret = cdev_add(&video1394_cdev, IEEE1394_VIDEO1394_DEV, 16);
 	if (ret) {
 		PRINT_G(KERN_ERR, "video1394: unable to get minor device block");
diff -Nru a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
--- a/drivers/s390/char/tape_class.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/s390/char/tape_class.c	Mon Mar 15 15:28:33 2004
@@ -46,13 +46,13 @@
 	cdev->owner = fops->owner;
 	cdev->ops   = fops;
 	cdev->dev   = dev;
-	strcpy(cdev->kobj.name, devname);
+	cdev_set_name(cdev, devname);
 	for (s = strchr(cdev->kobj.name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
 
 	rc = cdev_add(cdev, cdev->dev, 1);
 	if (rc) {
-		kobject_put(&cdev->kobj);
+		cdev_del(cdev);
 		return ERR_PTR(rc);
 	}
 	class_simple_device_add(tape_class, cdev->dev, device, "%s", devname);
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/scsi/sg.c	Mon Mar 15 15:28:33 2004
@@ -1409,7 +1409,7 @@
 	SCSI_LOG_TIMEOUT(3, printk("sg_add: dev=%d \n", k));
 	memset(sdp, 0, sizeof(*sdp));
 	sprintf(disk->disk_name, "sg%d", k);
-	strncpy(cdev->kobj.name, disk->disk_name, KOBJ_NAME_LEN);
+	cdev_set_name(cdev, disk->disk_name);
 	cdev->owner = THIS_MODULE;
 	cdev->ops = &sg_fops;
 	disk->major = SCSI_GENERIC_MAJOR;
@@ -1462,7 +1462,7 @@
 out:
 	put_disk(disk);
 	if (cdev)
-		kobject_put(&cdev->kobj);
+		cdev_del(cdev);
 	return error;
 }
 
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Mon Mar 15 15:28:33 2004
+++ b/drivers/scsi/st.c	Mon Mar 15 15:28:33 2004
@@ -3888,8 +3888,7 @@
 				       dev_num);
 				goto out_free_tape;
 			}
-			snprintf(cdev->kobj.name, KOBJ_NAME_LEN, "%sm%d%s", disk->disk_name,
-				 mode, j ? "n" : "");
+			cdev_set_name(cdev, "%sm%d%s", disk->disk_name, mode, j ? "n" : "");
 			cdev->owner = THIS_MODULE;
 			cdev->ops = &st_fops;
 
@@ -3944,7 +3943,7 @@
 		}
 	}
 	if (cdev)
-		kobject_put(&cdev->kobj);
+		cdev_del(cdev);
 	write_lock(&st_dev_arr_lock);
 	scsi_tapes[dev_num] = NULL;
 	st_nr_dev--;
diff -Nru a/include/linux/cdev.h b/include/linux/cdev.h
--- a/include/linux/cdev.h	Mon Mar 15 15:28:33 2004
+++ b/include/linux/cdev.h	Mon Mar 15 15:28:33 2004
@@ -25,5 +25,7 @@
 
 void cd_forget(struct inode *);
 
+#define cdev_set_name(cdev, args...) kobject_set_name(&((cdev)->kobj), ##args)
+
 #endif
 #endif

