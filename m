Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVAUXij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVAUXij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVAUXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:38:27 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:28591 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262600AbVAUX1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:27:01 -0500
Date: Sat, 22 Jan 2005 00:22:06 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 6/8] ide-floppy: add basic refcounting
Message-ID: <Pine.GSO.4.58.0501220021360.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similar changes as for ide-cd.c.

diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-21 23:41:14 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-21 23:41:14 +01:00
@@ -274,8 +274,9 @@
  *	driver due to an interrupt or a timer event is stored in a variable
  *	of type idefloppy_floppy_t, defined below.
  */
-typedef struct {
-	ide_drive_t *drive;
+typedef struct ide_floppy_obj {
+	ide_drive_t	*drive;
+	struct kref	kref;

 	/* Current packet command */
 	idefloppy_pc_t *pc;
@@ -514,6 +515,33 @@
 	u8		reserved[4];
 } idefloppy_mode_parameter_header_t;

+static DECLARE_MUTEX(idefloppy_ref_sem);
+
+#define to_ide_floppy(obj) container_of(obj, struct ide_floppy_obj, kref)
+
+#define ide_floppy_g(disk)	((disk)->private_data)
+
+static struct ide_floppy_obj *ide_floppy_get(struct gendisk *disk)
+{
+	struct ide_floppy_obj *floppy = NULL;
+
+	down(&idefloppy_ref_sem);
+	floppy = ide_floppy_g(disk);
+	if (floppy)
+		kref_get(&floppy->kref);
+	up(&idefloppy_ref_sem);
+	return floppy;
+}
+
+static void ide_floppy_release(struct kref *);
+
+static void ide_floppy_put(struct ide_floppy_obj *floppy)
+{
+	down(&idefloppy_ref_sem);
+	kref_put(&floppy->kref, ide_floppy_release);
+	up(&idefloppy_ref_sem);
+}
+
 /*
  *	Too bad. The drive wants to send us data which we are not ready to accept.
  *	Just throw it away.
@@ -1792,9 +1820,6 @@
 	struct idefloppy_id_gcw gcw;

 	*((u16 *) &gcw) = drive->id->config;
-	drive->driver_data = floppy;
-	memset(floppy, 0, sizeof(idefloppy_floppy_t));
-	floppy->drive = drive;
 	floppy->pc = floppy->pc_stack;
 	if (gcw.drq_type == 1)
 		set_bit(IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags);
@@ -1838,13 +1863,26 @@

 	if (ide_unregister_subdriver(drive))
 		return 1;
-	drive->driver_data = NULL;
-	kfree(floppy);
+
 	del_gendisk(g);
-	g->fops = ide_fops;
+
+	ide_floppy_put(floppy);
+
 	return 0;
 }

+static void ide_floppy_release(struct kref *kref)
+{
+	struct ide_floppy_obj *floppy = to_ide_floppy(kref);
+	ide_drive_t *drive = floppy->drive;
+	struct gendisk *g = drive->disk;
+
+	drive->driver_data = NULL;
+	g->private_data = NULL;
+	g->fops = ide_fops;
+	kfree(floppy);
+}
+
 #ifdef CONFIG_PROC_FS

 static int proc_idefloppy_read_capacity
@@ -1893,14 +1931,21 @@

 static int idefloppy_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
-	idefloppy_floppy_t *floppy = drive->driver_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_floppy_obj *floppy;
+	ide_drive_t *drive;
 	idefloppy_pc_t pc;
+	int ret = 0;

-	drive->usage++;
-
 	debug_log(KERN_INFO "Reached idefloppy_open\n");

+	if (!(floppy = ide_floppy_get(disk)))
+		return -ENXIO;
+
+	drive = floppy->drive;
+
+	drive->usage++;
+
 	if (drive->usage == 1) {
 		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
 		/* Just in case */
@@ -1920,13 +1965,15 @@
 		    */
 		    ) {
 			drive->usage--;
-			return -EIO;
+			ret = -EIO;
+			goto out_put_floppy;
 		}

 		if (floppy->wp && (filp->f_mode & 2)) {
 			drive->usage--;
-			return -EROFS;
-		}
+			ret = -EROFS;
+			goto out_put_floppy;
+		}
 		set_bit(IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
 		/* IOMEGA Clik! drives do not support lock/unlock commands */
                 if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
@@ -1936,21 +1983,26 @@
 		check_disk_change(inode->i_bdev);
 	} else if (test_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags)) {
 		drive->usage--;
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_put_floppy;
 	}
 	return 0;
+
+out_put_floppy:
+	ide_floppy_put(floppy);
+	return ret;
 }

 static int idefloppy_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_floppy_obj *floppy = ide_floppy_g(disk);
+	ide_drive_t *drive = floppy->drive;
 	idefloppy_pc_t pc;

 	debug_log(KERN_INFO "Reached idefloppy_release\n");

 	if (drive->usage == 1) {
-		idefloppy_floppy_t *floppy = drive->driver_data;
-
 		/* IOMEGA Clik! drives do not support lock/unlock commands */
                 if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
 			idefloppy_create_prevent_cmd(&pc, 0);
@@ -1960,6 +2012,9 @@
 		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
 	}
 	drive->usage--;
+
+	ide_floppy_put(floppy);
+
 	return 0;
 }

@@ -1967,8 +2022,8 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	ide_drive_t *drive = bdev->bd_disk->private_data;
-	idefloppy_floppy_t *floppy = drive->driver_data;
+	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
+	ide_drive_t *drive = floppy->drive;
 	void __user *argp = (void __user *)arg;
 	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
 	int prevent = (arg) ? 1 : 0;
@@ -2031,8 +2086,8 @@

 static int idefloppy_media_changed(struct gendisk *disk)
 {
-	ide_drive_t *drive = disk->private_data;
-	idefloppy_floppy_t *floppy = drive->driver_data;
+	struct ide_floppy_obj *floppy = ide_floppy_g(disk);
+	ide_drive_t *drive = floppy->drive;

 	/* do not scan partitions twice if this is a removable device */
 	if (drive->attach) {
@@ -2044,8 +2099,8 @@

 static int idefloppy_revalidate_disk(struct gendisk *disk)
 {
-	ide_drive_t *drive = disk->private_data;
-	set_capacity(disk, idefloppy_capacity(drive));
+	struct ide_floppy_obj *floppy = ide_floppy_g(disk);
+	set_capacity(disk, idefloppy_capacity(floppy->drive));
 	return 0;
 }

@@ -2085,6 +2140,15 @@
 		kfree (floppy);
 		goto failed;
 	}
+
+	memset(floppy, 0, sizeof(*floppy));
+
+	kref_init(&floppy->kref);
+
+	floppy->drive = drive;
+
+	drive->driver_data = floppy;
+
 	DRIVER(drive)->busy++;
 	idefloppy_setup (drive, floppy);
 	DRIVER(drive)->busy--;
@@ -2093,6 +2157,7 @@
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	g->fops = &idefloppy_ops;
+	g->private_data = floppy;
 	drive->attach = 1;
 	add_disk(g);
 	return 0;
