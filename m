Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVAVAnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVAVAnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVAVAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:41:30 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262567AbVAUXXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:32 -0500
Date: Sat, 22 Jan 2005 00:21:27 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 5/8] ide-disk: add basic refcounting
Message-ID: <Pine.GSO.4.58.0501220020540.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similar changes as for ide-cd.c (except that struct ide_disk_obj is added).

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-21 23:41:03 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-21 23:41:03 +01:00
@@ -71,6 +71,38 @@
 #include <asm/io.h>
 #include <asm/div64.h>

+struct ide_disk_obj {
+	ide_drive_t	*drive;
+	struct kref	kref;
+};
+
+static DECLARE_MUTEX(idedisk_ref_sem);
+
+#define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
+
+#define ide_disk_g(disk) ((disk)->private_data)
+
+static struct ide_disk_obj *ide_disk_get(struct gendisk *disk)
+{
+	struct ide_disk_obj *idkp = NULL;
+
+	down(&idedisk_ref_sem);
+	idkp = ide_disk_g(disk);
+	if (idkp)
+		kref_get(&idkp->kref);
+	up(&idedisk_ref_sem);
+	return idkp;
+}
+
+static void ide_disk_release(struct kref *);
+
+static void ide_disk_put(struct ide_disk_obj *idkp)
+{
+	down(&idedisk_ref_sem);
+	kref_put(&idkp->kref, ide_disk_release);
+	up(&idedisk_ref_sem);
+}
+
 /*
  * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
@@ -941,14 +973,30 @@

 static int idedisk_cleanup (ide_drive_t *drive)
 {
+	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = drive->disk;
+
 	ide_cacheflush_p(drive);
 	if (ide_unregister_subdriver(drive))
 		return 1;
 	del_gendisk(g);
+
+	ide_disk_put(idkp);
+
+	return 0;
+}
+
+static void ide_disk_release(struct kref *kref)
+{
+	struct ide_disk_obj *idkp = to_ide_disk(kref);
+	ide_drive_t *drive = idkp->drive;
+	struct gendisk *g = drive->disk;
+
+	drive->driver_data = NULL;
 	drive->devfs_name[0] = '\0';
+	g->private_data = NULL;
 	g->fops = ide_fops;
-	return 0;
+	kfree(idkp);
 }

 static int idedisk_attach(ide_drive_t *drive);
@@ -1006,7 +1054,15 @@

 static int idedisk_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_disk_obj *idkp;
+	ide_drive_t *drive;
+
+	if (!(idkp = ide_disk_get(disk)))
+		return -ENXIO;
+
+	drive = idkp->drive;
+
 	drive->usage++;
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
@@ -1028,7 +1084,10 @@

 static int idedisk_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_disk_obj *idkp = ide_disk_g(disk);
+	ide_drive_t *drive = idkp->drive;
+
 	if (drive->usage == 1)
 		ide_cacheflush_p(drive);
 	if (drive->removable && drive->usage == 1) {
@@ -1041,6 +1100,9 @@
 			drive->doorlocking = 0;
 	}
 	drive->usage--;
+
+	ide_disk_put(idkp);
+
 	return 0;
 }

@@ -1048,13 +1110,14 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	ide_drive_t *drive = bdev->bd_disk->private_data;
-	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	struct ide_disk_obj *idkp = ide_disk_g(bdev->bd_disk);
+	return generic_ide_ioctl(idkp->drive, file, bdev, cmd, arg);
 }

 static int idedisk_media_changed(struct gendisk *disk)
 {
-	ide_drive_t *drive = disk->private_data;
+	struct ide_disk_obj *idkp = ide_disk_g(disk);
+	ide_drive_t *drive = idkp->drive;

 	/* do not scan partitions twice if this is a removable device */
 	if (drive->attach) {
@@ -1067,8 +1130,8 @@

 static int idedisk_revalidate_disk(struct gendisk *disk)
 {
-	ide_drive_t *drive = disk->private_data;
-	set_capacity(disk, idedisk_capacity(drive));
+	struct ide_disk_obj *idkp = ide_disk_g(disk);
+	set_capacity(disk, idedisk_capacity(idkp->drive));
 	return 0;
 }

@@ -1085,6 +1148,7 @@

 static int idedisk_attach(ide_drive_t *drive)
 {
+	struct ide_disk_obj *idkp;
 	struct gendisk *g = drive->disk;

 	/* strstr("foo", "") is non-NULL */
@@ -1095,10 +1159,22 @@
 	if (drive->media != ide_disk)
 		goto failed;

+	idkp = kmalloc(sizeof(*idkp), GFP_KERNEL);
+	if (!idkp)
+		goto failed;
+
 	if (ide_register_subdriver(drive, &idedisk_driver)) {
 		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto failed;
+		goto out_free_idkp;
 	}
+
+	memset(idkp, 0, sizeof(*idkp));
+
+	kref_init(&idkp->kref);
+
+	idkp->drive = drive;
+	drive->driver_data = idkp;
+
 	DRIVER(drive)->busy++;
 	idedisk_setup(drive);
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
@@ -1114,8 +1190,11 @@
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, idedisk_capacity(drive));
 	g->fops = &idedisk_ops;
+	g->private_data = idkp;
 	add_disk(g);
 	return 0;
+out_free_idkp:
+	kfree(idkp);
 failed:
 	return 1;
 }
