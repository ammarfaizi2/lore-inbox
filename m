Return-Path: <linux-kernel-owner+w=401wt.eu-S1030500AbXALEYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbXALEYJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbXALEYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030499AbXALEXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=uq8TpjHflghgEiStt0I3R9yQW/VdJAB0Na4COHIo3sGWZe/jejnGanVIUXm0QpIY34vOXbsZaHTE1b7gJ6lPCX5tbOGa7wP3sM0sN+NY6RuJlH22Yt6wiYdZ7zZ7HgIKPjgALnnRwPVpjG4/8ROGRxnXxLzdJY8KCT9KfKAjkOA=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:22 +0100
Message-Id: <20070112042722.28794.74399.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 12/19] ide: remove ide_drive_t.usage
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: remove ide_drive_t.usage

This field is no longer used by the core IDE code so fix ide-{disk,floppy}
drivers to keep openers count in the driver specific objects and remove
it from ide-{cd,scsi,tape} drivers (it was write-only).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-cd.c     |   15 ++++-----------
 drivers/ide/ide-disk.c   |   14 +++++++++-----
 drivers/ide/ide-floppy.c |   18 +++++++++---------
 drivers/ide/ide-tape.c   |    8 --------
 drivers/scsi/ide-scsi.c  |    8 --------
 include/linux/ide.h      |    1 -
 6 files changed, 22 insertions(+), 42 deletions(-)

Index: a/drivers/ide/ide-cd.c
===================================================================
--- a.orig/drivers/ide/ide-cd.c
+++ a/drivers/ide/ide-cd.c
@@ -3345,21 +3345,16 @@ static int idecd_open(struct inode * ino
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct cdrom_info *info;
-	ide_drive_t *drive;
 	int rc = -ENOMEM;
 
 	if (!(info = ide_cd_get(disk)))
 		return -ENXIO;
 
-	drive = info->drive;
-
-	drive->usage++;
-
 	if (!info->buffer)
-		info->buffer = kmalloc(SECTOR_BUFFER_SIZE,
-					GFP_KERNEL|__GFP_REPEAT);
-        if (!info->buffer || (rc = cdrom_open(&info->devinfo, inode, file)))
-		drive->usage--;
+		info->buffer = kmalloc(SECTOR_BUFFER_SIZE, GFP_KERNEL|__GFP_REPEAT);
+
+	if (info->buffer)
+		rc = cdrom_open(&info->devinfo, inode, file);
 
 	if (rc < 0)
 		ide_cd_put(info);
@@ -3371,10 +3366,8 @@ static int idecd_release(struct inode * 
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct cdrom_info *info = ide_cd_g(disk);
-	ide_drive_t *drive = info->drive;
 
 	cdrom_release (&info->devinfo, file);
-	drive->usage--;
 
 	ide_cd_put(info);
 
Index: a/drivers/ide/ide-disk.c
===================================================================
--- a.orig/drivers/ide/ide-disk.c
+++ a/drivers/ide/ide-disk.c
@@ -77,6 +77,7 @@ struct ide_disk_obj {
 	ide_driver_t	*driver;
 	struct gendisk	*disk;
 	struct kref	kref;
+	unsigned int	openers;	/* protected by BKL for now */
 };
 
 static DEFINE_MUTEX(idedisk_ref_mutex);
@@ -1081,8 +1082,9 @@ static int idedisk_open(struct inode *in
 
 	drive = idkp->drive;
 
-	drive->usage++;
-	if (drive->removable && drive->usage == 1) {
+	idkp->openers++;
+
+	if (drive->removable && idkp->openers == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
@@ -1106,9 +1108,10 @@ static int idedisk_release(struct inode 
 	struct ide_disk_obj *idkp = ide_disk_g(disk);
 	ide_drive_t *drive = idkp->drive;
 
-	if (drive->usage == 1)
+	if (idkp->openers == 1)
 		ide_cacheflush_p(drive);
-	if (drive->removable && drive->usage == 1) {
+
+	if (drive->removable && idkp->openers == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
@@ -1117,7 +1120,8 @@ static int idedisk_release(struct inode 
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
-	drive->usage--;
+
+	idkp->openers--;
 
 	ide_disk_put(idkp);
 
Index: a/drivers/ide/ide-floppy.c
===================================================================
--- a.orig/drivers/ide/ide-floppy.c
+++ a/drivers/ide/ide-floppy.c
@@ -279,6 +279,7 @@ typedef struct ide_floppy_obj {
 	ide_driver_t	*driver;
 	struct gendisk	*disk;
 	struct kref	kref;
+	unsigned int	openers;	/* protected by BKL for now */
 
 	/* Current packet command */
 	idefloppy_pc_t *pc;
@@ -1949,9 +1950,9 @@ static int idefloppy_open(struct inode *
 
 	drive = floppy->drive;
 
-	drive->usage++;
+	floppy->openers++;
 
-	if (drive->usage == 1) {
+	if (floppy->openers == 1) {
 		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
 		/* Just in case */
 
@@ -1969,13 +1970,11 @@ static int idefloppy_open(struct inode *
 		    ** capacity of the drive or begin the format - Sam
 		    */
 		    ) {
-			drive->usage--;
 			ret = -EIO;
 			goto out_put_floppy;
 		}
 
 		if (floppy->wp && (filp->f_mode & 2)) {
-			drive->usage--;
 			ret = -EROFS;
 			goto out_put_floppy;
 		}
@@ -1987,13 +1986,13 @@ static int idefloppy_open(struct inode *
 		}
 		check_disk_change(inode->i_bdev);
 	} else if (test_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags)) {
-		drive->usage--;
 		ret = -EBUSY;
 		goto out_put_floppy;
 	}
 	return 0;
 
 out_put_floppy:
+	floppy->openers--;
 	ide_floppy_put(floppy);
 	return ret;
 }
@@ -2007,7 +2006,7 @@ static int idefloppy_release(struct inod
 	
 	debug_log(KERN_INFO "Reached idefloppy_release\n");
 
-	if (drive->usage == 1) {
+	if (floppy->openers == 1) {
 		/* IOMEGA Clik! drives do not support lock/unlock commands */
                 if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
 			idefloppy_create_prevent_cmd(&pc, 0);
@@ -2016,7 +2015,8 @@ static int idefloppy_release(struct inod
 
 		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
 	}
-	drive->usage--;
+
+	floppy->openers--;
 
 	ide_floppy_put(floppy);
 
@@ -2050,7 +2050,7 @@ static int idefloppy_ioctl(struct inode 
 		prevent = 0;
 		/* fall through */
 	case CDROM_LOCKDOOR:
-		if (drive->usage > 1)
+		if (floppy->openers > 1)
 			return -EBUSY;
 
 		/* The IOMEGA Clik! Drive doesn't support this command - no room for an eject mechanism */
@@ -2072,7 +2072,7 @@ static int idefloppy_ioctl(struct inode 
 		if (!(file->f_mode & 2))
 			return -EPERM;
 
-		if (drive->usage > 1) {
+		if (floppy->openers > 1) {
 			/* Don't format if someone is using the disk */
 
 			clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS,
Index: a/drivers/ide/ide-tape.c
===================================================================
--- a.orig/drivers/ide/ide-tape.c
+++ a/drivers/ide/ide-tape.c
@@ -4792,15 +4792,10 @@ static int idetape_open(struct inode *in
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct ide_tape_obj *tape;
-	ide_drive_t *drive;
 
 	if (!(tape = ide_tape_get(disk)))
 		return -ENXIO;
 
-	drive = tape->drive;
-
-	drive->usage++;
-
 	return 0;
 }
 
@@ -4808,9 +4803,6 @@ static int idetape_release(struct inode 
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct ide_tape_obj *tape = ide_tape_g(disk);
-	ide_drive_t *drive = tape->drive;
-
-	drive->usage--;
 
 	ide_tape_put(tape);
 
Index: a/drivers/scsi/ide-scsi.c
===================================================================
--- a.orig/drivers/scsi/ide-scsi.c
+++ a/drivers/scsi/ide-scsi.c
@@ -801,15 +801,10 @@ static int idescsi_ide_open(struct inode
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct ide_scsi_obj *scsi;
-	ide_drive_t *drive;
 
 	if (!(scsi = ide_scsi_get(disk)))
 		return -ENXIO;
 
-	drive = scsi->drive;
-
-	drive->usage++;
-
 	return 0;
 }
 
@@ -817,9 +812,6 @@ static int idescsi_ide_release(struct in
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct ide_scsi_obj *scsi = ide_scsi_g(disk);
-	ide_drive_t *drive = scsi->drive;
-
-	drive->usage--;
 
 	ide_scsi_put(scsi);
 
Index: a/include/linux/ide.h
===================================================================
--- a.orig/include/linux/ide.h
+++ a/include/linux/ide.h
@@ -628,7 +628,6 @@ typedef struct ide_drive_s {
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
 	unsigned int	drive_data;	/* use by tuneproc/selectproc */
-	unsigned int	usage;		/* current "open()" count for drive */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	u64		probed_capacity;/* initial reported media capacity (ide-cd only currently) */
