Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVAVAIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVAVAIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVAUX0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:26:37 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262595AbVAUXX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:28 -0500
Date: Sat, 22 Jan 2005 00:20:17 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 3/8] make ide_generic_ioctl() take ide_drive_t * as an argument
Message-ID: <Pine.GSO.4.58.0501220019430.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As a result disk->private_data can be used by device drivers now.

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-21 22:30:19 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-21 22:30:19 +01:00
@@ -3317,7 +3317,7 @@
 {
 	struct block_device *bdev = inode->i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
-	int err = generic_ide_ioctl(file, bdev, cmd, arg);
+	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
 	if (err == -EINVAL) {
 		struct cdrom_info *info = drive->driver_data;
 		err = cdrom_ioctl(file, &info->devinfo, inode, cmd, arg);
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-21 22:30:19 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-21 22:30:19 +01:00
@@ -1048,7 +1048,8 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	return generic_ide_ioctl(file, bdev, cmd, arg);
+	ide_drive_t *drive = bdev->bd_disk->private_data;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
 }

 static int idedisk_media_changed(struct gendisk *disk)
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-21 22:30:19 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-21 22:30:19 +01:00
@@ -1970,7 +1970,7 @@
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(file, bdev, cmd, arg);
+	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
 	int prevent = (arg) ? 1 : 0;
 	idefloppy_pc_t pc;
 	if (err != -EINVAL)
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-21 22:30:19 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-21 22:30:19 +01:00
@@ -4724,7 +4724,7 @@
 {
 	struct block_device *bdev = inode->i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
-	int err = generic_ide_ioctl(file, bdev, cmd, arg);
+	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
 	if (err == -EINVAL)
 		err = idetape_blkdev_ioctl(drive, cmd, arg);
 	return err;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-21 22:30:19 +01:00
+++ b/drivers/ide/ide.c	2005-01-21 22:30:19 +01:00
@@ -1410,10 +1410,9 @@
 	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }

-int generic_ide_ioctl(struct file *file, struct block_device *bdev,
+int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
 			unsigned int cmd, unsigned long arg)
 {
-	ide_drive_t *drive = bdev->bd_disk->private_data;
 	ide_settings_t *setting;
 	int err = 0;
 	void __user *p = (void __user *)arg;
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-01-21 22:30:19 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-01-21 22:30:19 +01:00
@@ -755,7 +755,8 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	return generic_ide_ioctl(file, bdev, cmd, arg);
+	ide_drive_t *drive = bdev->bd_disk->private_data;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
 }

 static struct block_device_operations idescsi_ops = {
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-21 22:30:19 +01:00
+++ b/include/linux/ide.h	2005-01-21 22:30:19 +01:00
@@ -1111,7 +1111,7 @@

 #define DRIVER(drive)		((drive)->driver)

-extern int generic_ide_ioctl(struct file *, struct block_device *, unsigned, unsigned long);
+int generic_ide_ioctl(ide_drive_t *, struct file *, struct block_device *, unsigned, unsigned long);

 /*
  * ide_hwifs[] is the master data structure used to keep track
