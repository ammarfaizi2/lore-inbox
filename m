Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUCLSea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUCLSea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:34:30 -0500
Received: from vena.lwn.net ([206.168.112.25]:56536 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262413AbUCLSdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:33:31 -0500
Message-ID: <20040312183329.1438.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cdev 2/2: hide cdev->kobj
cc: viro@parcelfarce.linux.theplanet.co.uk, greg@kroah.com
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 12 Mar 2004 11:33:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing cdev interface requires users to deal with the embedded
kobject in two places:

- The kobject name field must be set before adding the cdev, and
- Should cdev_add() fail, a call to kobject_put() is required.

IMO, this exposure of the embedded kobject makes the interface more brittle
and harder to understand.  It's also unnecessary.  With the removal of
/sys/cdev, a call to cdev_del() will nicely replace kobject_put(), and the
name setting is easily wrapped.

This is against 2.6.4, but depends on the /sys/cdev removal patch.

jon

diff -urNp -X dontdiff 2.6.4/drivers/char/tty_io.c 2.6.4-cd2/drivers/char/tty_io.c
--- 2.6.4/drivers/char/tty_io.c	2004-03-13 01:28:38.000000000 -0700
+++ 2.6.4-cd2/drivers/char/tty_io.c	2004-03-13 01:44:50.000000000 -0700
@@ -2294,14 +2294,14 @@ int tty_register_driver(struct tty_drive
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
@@ -2434,7 +2434,7 @@ static struct cdev vc0_cdev;
  */
 static int __init tty_init(void)
 {
-	strcpy(tty_cdev.kobj.name, "dev.tty");
+	cdev_set_name(&tty_cdev, "dev.tty");
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
@@ -2442,7 +2442,7 @@ static int __init tty_init(void)
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
-	strcpy(console_cdev.kobj.name, "dev.console");
+	cdev_set_name(&console_cdev, "dev.console");
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
@@ -2451,7 +2451,7 @@ static int __init tty_init(void)
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
-	strcpy(ptmx_cdev.kobj.name, "dev.ptmx");
+	cdev_set_name(&ptmx_cdev, "dev.ptmx");
 	cdev_init(&ptmx_cdev, &tty_fops);
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
@@ -2461,7 +2461,7 @@ static int __init tty_init(void)
 #endif
 
 #ifdef CONFIG_VT
-	strcpy(vc0_cdev.kobj.name, "dev.vc0");
+	cdev_set_name(&vc0_cdev, "dev.vc0");
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
diff -urNp -X dontdiff 2.6.4/drivers/ieee1394/amdtp.c 2.6.4-cd2/drivers/ieee1394/amdtp.c
--- 2.6.4/drivers/ieee1394/amdtp.c	2004-03-13 00:16:53.000000000 -0700
+++ 2.6.4-cd2/drivers/ieee1394/amdtp.c	2004-03-13 01:50:41.000000000 -0700
@@ -1266,7 +1266,7 @@ static int __init amdtp_init_module (voi
 {
 	cdev_init(&amdtp_cdev, &amdtp_fops);
 	amdtp_cdev.owner = THIS_MODULE;
-	kobject_set_name(&amdtp_cdev.kobj, "amdtp");
+	cdev_set_name(&amdtp_cdev, "amdtp");
 	if (cdev_add(&amdtp_cdev, IEEE1394_AMDTP_DEV, 16)) {
 		HPSB_ERR("amdtp: unable to add char device");
  		return -EIO;
diff -urNp -X dontdiff 2.6.4/drivers/ieee1394/dv1394.c 2.6.4-cd2/drivers/ieee1394/dv1394.c
--- 2.6.4/drivers/ieee1394/dv1394.c	2004-03-13 00:16:54.000000000 -0700
+++ 2.6.4-cd2/drivers/ieee1394/dv1394.c	2004-03-13 01:50:55.000000000 -0700
@@ -2616,7 +2616,7 @@ static int __init dv1394_init_module(voi
 
 	cdev_init(&dv1394_cdev, &dv1394_fops);
 	dv1394_cdev.owner = THIS_MODULE;
-	kobject_set_name(&dv1394_cdev.kobj, "dv1394");
+	cdev_set_name(&dv1394_cdev, "dv1394");
 	ret = cdev_add(&dv1394_cdev, IEEE1394_DV1394_DEV, 16);
 	if (ret) {
 		printk(KERN_ERR "dv1394: unable to register character device\n");
diff -urNp -X dontdiff 2.6.4/drivers/ieee1394/raw1394.c 2.6.4-cd2/drivers/ieee1394/raw1394.c
--- 2.6.4/drivers/ieee1394/raw1394.c	2004-03-13 00:16:54.000000000 -0700
+++ 2.6.4-cd2/drivers/ieee1394/raw1394.c	2004-03-13 01:50:41.000000000 -0700
@@ -2746,9 +2746,10 @@ static int __init init_raw1394(void)
 
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
diff -urNp -X dontdiff 2.6.4/drivers/ieee1394/video1394.c 2.6.4-cd2/drivers/ieee1394/video1394.c
--- 2.6.4/drivers/ieee1394/video1394.c	2004-03-13 00:16:54.000000000 -0700
+++ 2.6.4-cd2/drivers/ieee1394/video1394.c	2004-03-13 01:50:41.000000000 -0700
@@ -1457,7 +1457,7 @@ static int __init video1394_init_module 
 
 	cdev_init(&video1394_cdev, &video1394_fops);
 	video1394_cdev.owner = THIS_MODULE;
-	kobject_set_name(&video1394_cdev.kobj, VIDEO1394_DRIVER_NAME);
+	cdev_set_name(&video1394_cdev, VIDEO1394_DRIVER_NAME);
 	ret = cdev_add(&video1394_cdev, IEEE1394_VIDEO1394_DEV, 16);
 	if (ret) {
 		PRINT_G(KERN_ERR, "video1394: unable to get minor device block");
diff -urNp -X dontdiff 2.6.4/drivers/s390/char/tape_class.c 2.6.4-cd2/drivers/s390/char/tape_class.c
--- 2.6.4/drivers/s390/char/tape_class.c	2004-03-13 00:17:00.000000000 -0700
+++ 2.6.4-cd2/drivers/s390/char/tape_class.c	2004-03-13 01:22:23.000000000 -0700
@@ -46,13 +46,13 @@ struct cdev *register_tape_dev(
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
diff -urNp -X dontdiff 2.6.4/drivers/scsi/sg.c 2.6.4-cd2/drivers/scsi/sg.c
--- 2.6.4/drivers/scsi/sg.c	2004-03-05 04:58:40.000000000 -0700
+++ 2.6.4-cd2/drivers/scsi/sg.c	2004-03-13 01:46:16.000000000 -0700
@@ -1409,7 +1409,7 @@ find_empty_slot:
 	SCSI_LOG_TIMEOUT(3, printk("sg_add: dev=%d \n", k));
 	memset(sdp, 0, sizeof(*sdp));
 	sprintf(disk->disk_name, "sg%d", k);
-	strncpy(cdev->kobj.name, disk->disk_name, KOBJ_NAME_LEN);
+	cdev_set_name(cdev, disk->disk_name);
 	cdev->owner = THIS_MODULE;
 	cdev->ops = &sg_fops;
 	disk->major = SCSI_GENERIC_MAJOR;
@@ -1462,7 +1462,7 @@ find_empty_slot:
 out:
 	put_disk(disk);
 	if (cdev)
-		kobject_put(&cdev->kobj);
+		cdev_del(cdev);
 	return error;
 }
 
diff -urNp -X dontdiff 2.6.4/drivers/scsi/st.c 2.6.4-cd2/drivers/scsi/st.c
--- 2.6.4/drivers/scsi/st.c	2004-03-13 00:17:02.000000000 -0700
+++ 2.6.4-cd2/drivers/scsi/st.c	2004-03-13 01:47:18.000000000 -0700
@@ -3888,8 +3888,7 @@ static int st_probe(struct device *dev)
 				       dev_num);
 				goto out_free_tape;
 			}
-			snprintf(cdev->kobj.name, KOBJ_NAME_LEN, "%sm%d%s", disk->disk_name,
-				 mode, j ? "n" : "");
+			cdev_set_name(cdev, "%sm%d%s", disk->disk_name, mode, j ? "n" : "");
 			cdev->owner = THIS_MODULE;
 			cdev->ops = &st_fops;
 
@@ -3944,7 +3943,7 @@ out_free_tape:
 		}
 	}
 	if (cdev)
-		kobject_put(&cdev->kobj);
+		cdev_del(cdev);
 	write_lock(&st_dev_arr_lock);
 	scsi_tapes[dev_num] = NULL;
 	st_nr_dev--;
diff -urNp -X dontdiff 2.6.4/include/linux/cdev.h 2.6.4-cd2/include/linux/cdev.h
--- 2.6.4/include/linux/cdev.h	2004-03-05 04:58:45.000000000 -0700
+++ 2.6.4-cd2/include/linux/cdev.h	2004-03-13 01:17:09.000000000 -0700
@@ -25,5 +25,7 @@ void cdev_del(struct cdev *);
 
 void cd_forget(struct inode *);
 
+#define cdev_set_name(cdev, args...) kobject_set_name(&((cdev)->kobj), ##args)
+
 #endif
 #endif
