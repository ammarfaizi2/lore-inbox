Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263672AbTCVRaA>; Sat, 22 Mar 2003 12:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263688AbTCVR3y>; Sat, 22 Mar 2003 12:29:54 -0500
Received: from verein.lst.de ([212.34.181.86]:23558 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263672AbTCVR3d>;
	Sat, 22 Mar 2003 12:29:33 -0500
Date: Sat, 22 Mar 2003 18:40:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc devfs_register cleanups
Message-ID: <20030322184032.G21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a bunch of non-NULL first arguments.


diff -Nru a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Sat Mar 22 17:04:07 2003
+++ b/drivers/block/swim3.c	Sat Mar 22 17:04:07 2003
@@ -1095,9 +1095,9 @@
 
 	printk(KERN_INFO "fd%d: SWIM3 floppy controller %s\n", floppy_count,
 		mediabay ? "in media bay" : "");
-	sprintf(floppy_name, "%s%d", floppy_devfs_handle ? "" : "floppy",
-			floppy_count);
-	floppy_handle = devfs_register(floppy_devfs_handle, floppy_name, 
+
+	sprintf(floppy_name, "floppy/%d", floppy_count);
+	floppy_handle = devfs_register(NULL, floppy_name, 
 			DEVFS_FL_DEFAULT, FLOPPY_MAJOR, floppy_count, 
 			S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP, 
 			&floppy_fops, NULL);
diff -Nru a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c	Sat Mar 22 17:04:07 2003
+++ b/drivers/ieee1394/video1394.c	Sat Mar 22 17:04:07 2003
@@ -1251,7 +1251,7 @@
 {
 	struct video_card *video;
 	unsigned long flags;
-	char name[16];
+	char name[24];
 	int minor;
 
 	video = kmalloc(sizeof(struct video_card), GFP_KERNEL);
@@ -1270,9 +1270,9 @@
 	video->id = ohci->id;
 	video->ohci = ohci;
 
-	sprintf(name, "%d", video->id);
+	sprintf(name, "%s/%d", VIDEO1394_DRIVER_NAME, video->id);
 	minor = IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + video->id;
-	video->devfs = devfs_register(devfs_handle, name, DEVFS_FL_DEFAULT,
+	video->devfs = devfs_register(NULL, name, DEVFS_FL_DEFAULT,
 				      IEEE1394_MAJOR, minor,
 				      S_IFCHR | S_IRUSR | S_IWUSR,
 				      &video1394_fops, NULL);
diff -Nru a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	Sat Mar 22 17:04:07 2003
+++ b/drivers/s390/block/dasd.c	Sat Mar 22 17:04:07 2003
@@ -178,6 +178,7 @@
 	umode_t devfs_perm;
 	devfs_handle_t dir;
 	int major, minor;
+	char buf[20];
 
 	/* Increase reference count of bdev. */
 	if (bdget(MKDEV(device->gdp->major, device->gdp->first_minor)) == NULL)
@@ -198,7 +199,9 @@
 		devfs_perm = S_IFBLK | S_IRUSR;
 	else
 		devfs_perm = S_IFBLK | S_IRUSR | S_IWUSR;
-	device->devfs_entry = devfs_register(dir, "device", DEVFS_FL_DEFAULT,
+
+	snprintf(buf, sizeof(buf), "dasd/%04x/device", device->devno);
+	device->devfs_entry = devfs_register(NULL, buf, 0,
 					     major, minor << DASD_PARTN_BITS,
 					     devfs_perm,
 					     &dasd_device_operations, NULL);
diff -Nru a/drivers/s390/char/tubfs.c b/drivers/s390/char/tubfs.c
--- a/drivers/s390/char/tubfs.c	Sat Mar 22 17:04:07 2003
+++ b/drivers/s390/char/tubfs.c	Sat Mar 22 17:04:07 2003
@@ -74,8 +74,7 @@
 	}
 #ifdef CONFIG_DEVFS_FS
 	fs3270_devfs_dir = devfs_mk_dir("3270");
-	fs3270_devfs_tub = 
-		devfs_register(fs3270_devfs_dir, "tub", DEVFS_FL_DEFAULT,
+	fs3270_devfs_tub = devfs_register(NULL, "3270/tub", 0,
 			       IBM_FS3270_MAJOR, 0,
 			       S_IFCHR | S_IRUGO | S_IWUGO, 
 			       &fs3270_fops, NULL);
diff -Nru a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c	Sat Mar 22 17:04:18 2003
+++ b/arch/um/drivers/ubd_kern.c	Sat Mar 22 17:04:18 2003
@@ -488,7 +488,7 @@
 			struct gendisk **disk_out, devfs_handle_t dir_handle,
 			devfs_handle_t *handle_out)
 {
-	char devfs_name[sizeof("nnnnnn\0")];
+	char devfs_name[sizeof("ubd/nnnnnn\0")];
 	struct gendisk *disk;
 	int minor = unit << UBD_SHIFT;
 
@@ -505,8 +505,8 @@
 	*disk_out = disk;
 
 	/* /dev/ubd/N style names */
-	sprintf(devfs_name, "%d", unit);
-	*handle_out = devfs_register(dir_handle, devfs_name,
+	sprintf(devfs_name, "ubd/%d", unit);
+	*handle_out = devfs_register(NULL, devfs_name,
 				     0, major, minor,
 				     S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |
 				     S_IWGRP, &ubd_blops, NULL);
diff -Nru a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c	Sat Mar 22 17:04:18 2003
+++ b/drivers/char/ipmi/ipmi_devintf.c	Sat Mar 22 17:04:18 2003
@@ -444,15 +444,14 @@
 
 static void ipmi_new_smi(int if_num)
 {
-	char name[2];
+	char name[10];
 
 	if (if_num > MAX_DEVICES)
 		return;
 
-	name[0] = if_num + '0';
-	name[1] = '\0';
+	snprinf(name, sizeof(name), "ipmidev/%d", if_num);
 
-	handles[if_num] = devfs_register(devfs_handle, name, DEVFS_FL_NONE,
+	handles[if_num] = devfs_register(NULL, name, DEVFS_FL_NONE,
 					 ipmi_major, if_num,
 					 S_IFCHR | S_IRUSR | S_IWUSR,
 					 &ipmi_fops, NULL);
diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Sat Mar 22 17:04:17 2003
+++ b/drivers/usb/input/hiddev.c	Sat Mar 22 17:04:18 2003
@@ -684,7 +684,7 @@
 	struct hiddev *hiddev;
 	int minor, i;
 	int retval;
-	char devfs_name[16];
+	char devfs_name[24];
 
 	for (i = 0; i < hid->maxcollection; i++)
 		if (hid->collection[i].type == 
@@ -715,8 +715,8 @@
 	hiddev->hid = hid;
 	hiddev->exist = 1;
 
-	sprintf(devfs_name, "hiddev%d", minor);
-	hiddev->devfs = devfs_register(hiddev_devfs_handle, devfs_name,
+	sprintf(devfs_name, "usb/hid/hiddev%d", minor);
+	hiddev->devfs = devfs_register(NULL, devfs_name,
 		DEVFS_FL_DEFAULT, USB_MAJOR, minor + HIDDEV_MINOR_BASE,
 		S_IFCHR | S_IRUGO | S_IWUSR, &hiddev_fops, NULL);
 	hid->minor = minor;
