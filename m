Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVAUXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVAUXbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVAUX3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:29:32 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262589AbVAUXXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:19 -0500
Date: Sat, 22 Jan 2005 00:20:53 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 4/8] ide-cd: add basic refcounting
Message-ID: <Pine.GSO.4.58.0501220020200.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* based on reference counting in drivers/scsi/{sd,sr}.c
* fixes race between ->open() and ->cleanup() (ide_unregister_subdriver()
  tests for drive->usage != 0 but there is no protection against new users)
* struct kref and pointer to a drive are added to struct ide_cdrom_info
* pointer to drive's struct ide_cdrom_info is stored in disk->private_data
* ide_cd_{get,put}() is used to {get,put} reference to struct ide_cdrom_info
* ide_cd_release() is a release method for struct ide_cdrom_info

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-21 23:40:52 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-21 23:40:52 +01:00
@@ -324,6 +324,33 @@

 #include "ide-cd.h"

+static DECLARE_MUTEX(idecd_ref_sem);
+
+#define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref)
+
+#define ide_cd_g(disk)	((disk)->private_data)
+
+static struct cdrom_info *ide_cd_get(struct gendisk *disk)
+{
+	struct cdrom_info *cd = NULL;
+
+	down(&idecd_ref_sem);
+	cd = ide_cd_g(disk);
+	if (cd)
+		kref_get(&cd->kref);
+	up(&idecd_ref_sem);
+	return cd;
+}
+
+static void ide_cd_release(struct kref *);
+
+static void ide_cd_put(struct cdrom_info *cd)
+{
+	down(&idecd_ref_sem);
+	kref_put(&cd->kref, ide_cd_release);
+	up(&idecd_ref_sem);
+}
+
 /****************************************************************************
  * Generic packet command support and error handling routines.
  */
@@ -3225,14 +3252,27 @@
 int ide_cdrom_cleanup(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct cdrom_device_info *devinfo = &info->devinfo;
-	struct gendisk *g = drive->disk;

 	if (ide_unregister_subdriver(drive)) {
 		printk(KERN_ERR "%s: %s: failed to ide_unregister_subdriver\n",
 			__FUNCTION__, drive->name);
 		return 1;
 	}
+
+	del_gendisk(drive->disk);
+
+	ide_cd_put(info);
+
+	return 0;
+}
+
+static void ide_cd_release(struct kref *kref)
+{
+	struct cdrom_info *info = to_ide_cd(kref);
+	struct cdrom_device_info *devinfo = &info->devinfo;
+	ide_drive_t *drive = info->drive;
+	struct gendisk *g = drive->disk;
+
 	if (info->buffer != NULL)
 		kfree(info->buffer);
 	if (info->toc != NULL)
@@ -3240,13 +3280,13 @@
 	if (info->changer_info != NULL)
 		kfree(info->changer_info);
 	if (devinfo->handle == drive && unregister_cdrom(devinfo))
-		printk(KERN_ERR "%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
-	kfree(info);
+		printk(KERN_ERR "%s: %s failed to unregister device from the cdrom "
+				"driver.\n", __FUNCTION__, drive->name);
 	drive->driver_data = NULL;
 	blk_queue_prep_rq(drive->queue, NULL);
-	del_gendisk(g);
+	g->private_data = NULL;
 	g->fops = ide_fops;
-	return 0;
+	kfree(info);
 }

 static int ide_cdrom_attach (ide_drive_t *drive);
@@ -3289,9 +3329,16 @@

 static int idecd_open(struct inode * inode, struct file * file)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
-	struct cdrom_info *info = drive->driver_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct cdrom_info *info;
+	ide_drive_t *drive;
 	int rc = -ENOMEM;
+
+	if (!(info = ide_cd_get(disk)))
+		return -ENXIO;
+
+	drive = info->drive;
+
 	drive->usage++;

 	if (!info->buffer)
@@ -3299,16 +3346,24 @@
 					GFP_KERNEL|__GFP_REPEAT);
         if (!info->buffer || (rc = cdrom_open(&info->devinfo, inode, file)))
 		drive->usage--;
+
+	if (rc < 0)
+		ide_cd_put(info);
+
 	return rc;
 }

 static int idecd_release(struct inode * inode, struct file * file)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
-	struct cdrom_info *info = drive->driver_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct cdrom_info *info = ide_cd_g(disk);
+	ide_drive_t *drive = info->drive;

 	cdrom_release (&info->devinfo, file);
 	drive->usage--;
+
+	ide_cd_put(info);
+
 	return 0;
 }

@@ -3316,27 +3371,27 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	ide_drive_t *drive = bdev->bd_disk->private_data;
-	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
-	if (err == -EINVAL) {
-		struct cdrom_info *info = drive->driver_data;
+	struct cdrom_info *info = ide_cd_g(bdev->bd_disk);
+	int err;
+
+	err  = generic_ide_ioctl(info->drive, file, bdev, cmd, arg);
+	if (err == -EINVAL)
 		err = cdrom_ioctl(file, &info->devinfo, inode, cmd, arg);
-	}
+
 	return err;
 }

 static int idecd_media_changed(struct gendisk *disk)
 {
-	ide_drive_t *drive = disk->private_data;
-	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_info *info = ide_cd_g(disk);
 	return cdrom_media_changed(&info->devinfo);
 }

 static int idecd_revalidate_disk(struct gendisk *disk)
 {
-	ide_drive_t *drive = disk->private_data;
+	struct cdrom_info *info = ide_cd_g(disk);
 	struct request_sense sense;
-	cdrom_read_toc(drive, &sense);
+	cdrom_read_toc(info->drive, &sense);
 	return  0;
 }

@@ -3390,7 +3445,12 @@
 		goto failed;
 	}
 	memset(info, 0, sizeof (struct cdrom_info));
+
+	kref_init(&info->kref);
+
+	info->drive = drive;
 	drive->driver_data = info;
+
 	DRIVER(drive)->busy++;
 	g->minors = 1;
 	snprintf(g->devfs_name, sizeof(g->devfs_name),
@@ -3417,6 +3477,7 @@

 	cdrom_read_toc(drive, &sense);
 	g->fops = &idecd_ops;
+	g->private_data = info;
 	g->flags |= GENHD_FL_REMOVABLE;
 	add_disk(g);
 	return 0;
diff -Nru a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
--- a/drivers/ide/ide-cd.h	2005-01-21 23:40:52 +01:00
+++ b/drivers/ide/ide-cd.h	2005-01-21 23:40:52 +01:00
@@ -460,6 +460,8 @@

 /* Extra per-device info for cdrom drives. */
 struct cdrom_info {
+	ide_drive_t	*drive;
+	struct kref	kref;

 	/* Buffer for table of contents.  NULL if we haven't allocated
 	   a TOC buffer for this device yet. */
