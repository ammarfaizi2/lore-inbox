Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263334AbVBDDJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbVBDDJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVBDDHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:07:13 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:39860 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262807AbVBDCyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:54:32 -0500
Date: Fri, 4 Feb 2005 03:52:51 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 7/9] get driver from rq->rq_disk->private_data
Message-ID: <Pine.GSO.4.58.0502040352000.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* add ide_driver_t * to device drivers objects
* set it to point at driver's ide_driver_t
* store address of this entry in disk->private_data
* fix ide_{cd,disk,floppy,tape,scsi}_g accordingly
* use rq->rq_disk->private_data instead of drive->driver
  to obtain driver (this allows us to kill ide-default)

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-cd.c	2005-02-04 03:31:58 +01:00
@@ -328,7 +328,8 @@

 #define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref)

-#define ide_cd_g(disk)	((disk)->private_data)
+#define ide_cd_g(disk) \
+	container_of((disk)->private_data, struct cdrom_info, driver)

 static struct cdrom_info *ide_cd_get(struct gendisk *disk)
 {
@@ -3462,8 +3463,11 @@
 	kref_init(&info->kref);

 	info->drive = drive;
+	info->driver = &ide_cdrom_driver;
 	info->disk = g;

+	g->private_data = &info->driver;
+
 	drive->driver_data = info;

 	DRIVER(drive)->busy++;
@@ -3492,7 +3496,6 @@

 	cdrom_read_toc(drive, &sense);
 	g->fops = &idecd_ops;
-	g->private_data = info;
 	g->flags |= GENHD_FL_REMOVABLE;
 	add_disk(g);
 	return 0;
diff -Nru a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
--- a/drivers/ide/ide-cd.h	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-cd.h	2005-02-04 03:31:58 +01:00
@@ -461,6 +461,7 @@
 /* Extra per-device info for cdrom drives. */
 struct cdrom_info {
 	ide_drive_t	*drive;
+	ide_driver_t	*driver;
 	struct gendisk	*disk;
 	struct kref	kref;

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-04 03:31:58 +01:00
@@ -73,6 +73,7 @@

 struct ide_disk_obj {
 	ide_drive_t	*drive;
+	ide_driver_t	*driver;
 	struct gendisk	*disk;
 	struct kref	kref;
 };
@@ -81,7 +82,8 @@

 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)

-#define ide_disk_g(disk) ((disk)->private_data)
+#define ide_disk_g(disk) \
+	container_of((disk)->private_data, struct ide_disk_obj, driver)

 static struct ide_disk_obj *ide_disk_get(struct gendisk *disk)
 {
@@ -1179,8 +1181,11 @@
 	kref_init(&idkp->kref);

 	idkp->drive = drive;
+	idkp->driver = &idedisk_driver;
 	idkp->disk = g;

+	g->private_data = &idkp->driver;
+
 	drive->driver_data = idkp;

 	DRIVER(drive)->busy++;
@@ -1198,7 +1203,6 @@
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, idedisk_capacity(drive));
 	g->fops = &idedisk_ops;
-	g->private_data = idkp;
 	add_disk(g);
 	return 0;

diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-dma.c	2005-02-04 03:31:58 +01:00
@@ -175,8 +175,10 @@
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
+			ide_driver_t *drv;

-			DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
+			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+			drv->end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-02-04 03:31:58 +01:00
@@ -276,6 +276,7 @@
  */
 typedef struct ide_floppy_obj {
 	ide_drive_t	*drive;
+	ide_driver_t	*driver;
 	struct gendisk	*disk;
 	struct kref	kref;

@@ -520,7 +521,8 @@

 #define to_ide_floppy(obj) container_of(obj, struct ide_floppy_obj, kref)

-#define ide_floppy_g(disk)	((disk)->private_data)
+#define ide_floppy_g(disk) \
+	container_of((disk)->private_data, struct ide_floppy_obj, driver)

 static struct ide_floppy_obj *ide_floppy_get(struct gendisk *disk)
 {
@@ -2160,8 +2162,11 @@
 	kref_init(&floppy->kref);

 	floppy->drive = drive;
+	floppy->driver = &idefloppy_driver;
 	floppy->disk = g;

+	g->private_data = &floppy->driver;
+
 	drive->driver_data = floppy;

 	DRIVER(drive)->busy++;
@@ -2172,7 +2177,6 @@
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	g->fops = &idefloppy_ops;
-	g->private_data = floppy;
 	drive->attach = 1;
 	add_disk(g);
 	return 0;
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-04 03:31:58 +01:00
@@ -539,6 +539,17 @@
 	}
 }

+static void ide_kill_rq(ide_drive_t *drive, struct request *rq)
+{
+	if (rq->rq_disk) {
+		ide_driver_t *drv;
+
+		drv = *(ide_driver_t **)rq->rq_disk->private_data;
+		drv->end_request(drive, 0, 0);
+	} else
+		ide_end_request(drive, 0, 0);
+}
+
 static ide_startstop_t ide_ata_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -573,7 +584,7 @@
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);

 	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
-		drive->driver->end_request(drive, 0, 0);
+		ide_kill_rq(drive, rq);
 	else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;
@@ -602,7 +613,7 @@
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);

 	if (rq->errors >= ERROR_MAX) {
-		drive->driver->end_request(drive, 0, 0);
+		ide_kill_rq(drive, rq);
 	} else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;
@@ -654,7 +665,13 @@
 		return ide_stopped;
 	}

-	return drive->driver->error(drive, rq, stat, err);
+	if (rq->rq_disk) {
+		ide_driver_t *drv;
+
+		drv = *(ide_driver_t **)rq->rq_disk->private_data;
+		return drv->error(drive, rq, stat, err);
+	} else
+		return __ide_error(drive, rq, stat, err);
 }

 EXPORT_SYMBOL_GPL(ide_error);
@@ -664,7 +681,8 @@
 	if (drive->media != ide_disk)
 		rq->errors |= ERROR_RESET;

-	DRIVER(drive)->end_request(drive, 0, 0);
+	ide_kill_rq(drive, rq);
+
 	return ide_stopped;
 }

@@ -698,7 +716,13 @@
 		return ide_stopped;
 	}

-	return drive->driver->abort(drive, rq);
+	if (rq->rq_disk) {
+		ide_driver_t *drv;
+
+		drv = *(ide_driver_t **)rq->rq_disk->private_data;
+		return drv->abort(drive, rq);
+	} else
+		return __ide_abort(drive, rq);
 }

 /**
@@ -751,7 +775,7 @@
 			udelay(100);
 	}

-	if (!OK_STAT(stat, READY_STAT, BAD_STAT) && DRIVER(drive) != NULL)
+	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
 		return ide_error(drive, "drive_cmd", stat);
 		/* calls ide_end_drive_cmd */
 	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
@@ -1051,6 +1075,8 @@
 		return startstop;
 	}
 	if (!drive->special.all) {
+		ide_driver_t *drv;
+
 		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK))
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
@@ -1066,11 +1092,13 @@
 				ide_complete_pm_request(drive, rq);
 			return startstop;
 		}
-		return (DRIVER(drive)->do_request(drive, rq, block));
+
+		drv = *(ide_driver_t **)rq->rq_disk->private_data;
+		return drv->do_request(drive, rq, block);
 	}
 	return do_special(drive);
 kill_rq:
-	DRIVER(drive)->end_request(drive, 0, 0);
+	ide_kill_rq(drive, rq);
 	return ide_stopped;
 }

diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-04 03:31:58 +01:00
@@ -783,6 +783,7 @@
  */
 typedef struct ide_tape_obj {
 	ide_drive_t	*drive;
+	ide_driver_t	*driver;
 	struct gendisk	*disk;
 	struct kref	kref;

@@ -1014,7 +1015,8 @@

 #define to_ide_tape(obj) container_of(obj, struct ide_tape_obj, kref)

-#define ide_tape_g(disk)	((disk)->private_data)
+#define ide_tape_g(disk) \
+	container_of((disk)->private_data, struct ide_tape_obj, driver)

 static struct ide_tape_obj *ide_tape_get(struct gendisk *disk)
 {
@@ -4866,8 +4868,11 @@
 	kref_init(&tape->kref);

 	tape->drive = drive;
+	tape->driver = &idetape_driver;
 	tape->disk = g;

+	g->private_data = &tape->driver;
+
 	drive->driver_data = tape;

 	down(&idetape_ref_sem);
@@ -4887,7 +4892,6 @@

 	g->number = devfs_register_tape(drive->devfs_name);
 	g->fops = &idetape_block_ops;
-	g->private_data = tape;
 	ide_register_region(g);

 	return 0;
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-02-04 03:31:58 +01:00
@@ -354,14 +354,20 @@
 			break;
 		}

-		if (sectors > 0)
-			drive->driver->end_request(drive, 1, sectors);
+		if (sectors > 0) {
+			ide_driver_t *drv;
+
+			drv = *(ide_driver_t **)rq->rq_disk->private_data;
+			drv->end_request(drive, 1, sectors);
+		}
 	}
 	return ide_error(drive, s, stat);
 }

 static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
+	ide_driver_t *drv;
+
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *task = rq->special;

@@ -371,7 +377,9 @@
 			return;
 		}
 	}
-	drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+
+	drv = *(ide_driver_t **)rq->rq_disk->private_data;
+	drv->end_request(drive, 1, rq->hard_nr_sectors);
 }

 /*
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/ide/ide.c	2005-02-04 03:31:58 +01:00
@@ -1404,6 +1404,7 @@
 			unsigned int cmd, unsigned long arg)
 {
 	ide_settings_t *setting;
+	ide_driver_t *drv;
 	int err = 0;
 	void __user *p = (void __user *)arg;

@@ -1503,7 +1504,8 @@
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
 				return -EPERM;
 			drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
-			if (drive->dsc_overlap && !DRIVER(drive)->supports_dsc_overlap) {
+			drv = *(ide_driver_t **)bdev->bd_disk->private_data;
+			if (drive->dsc_overlap && !drv->supports_dsc_overlap) {
 				drive->dsc_overlap = 0;
 				return -EPERM;
 			}
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-02-04 03:31:58 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-02-04 03:31:58 +01:00
@@ -98,6 +98,7 @@

 typedef struct ide_scsi_obj {
 	ide_drive_t		*drive;
+	ide_driver_t		*driver;
 	struct gendisk		*disk;
 	struct Scsi_Host	*host;

@@ -109,7 +110,8 @@

 static DECLARE_MUTEX(idescsi_ref_sem);

-#define ide_scsi_g(disk)	((disk)->private_data)
+#define ide_scsi_g(disk) \
+	container_of((disk)->private_data, struct ide_scsi_obj, driver)

 static struct ide_scsi_obj *ide_scsi_get(struct gendisk *disk)
 {
@@ -328,6 +330,8 @@
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }

+static int idescsi_end_request(ide_drive_t *, int, int);
+
 static ide_startstop_t
 idescsi_atapi_error(ide_drive_t *drive, struct request *rq, u8 stat, u8 err)
 {
@@ -336,7 +340,9 @@
 		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);

 	rq->errors++;
-	DRIVER(drive)->end_request(drive, 0, 0);
+
+	idescsi_end_request(drive, 0, 0);
+
 	return ide_stopped;
 }

@@ -348,7 +354,9 @@
 			((idescsi_pc_t *) rq->special)->scsi_cmd->serial_number);
 #endif
 	rq->errors |= ERROR_MAX;
-	DRIVER(drive)->end_request(drive, 0, 0);
+
+	idescsi_end_request(drive, 0, 0);
+
 	return ide_stopped;
 }

@@ -1128,13 +1136,14 @@
 	drive->driver_data = host;
 	idescsi = scsihost_to_idescsi(host);
 	idescsi->drive = drive;
+	idescsi->driver = &idescsi_driver;
 	idescsi->host = host;
 	idescsi->disk = g;
+	g->private_data = &idescsi->driver;
 	err = ide_register_subdriver(drive, &idescsi_driver);
 	if (!err) {
 		idescsi_setup (drive, idescsi);
 		g->fops = &idescsi_ops;
-		g->private_data = idescsi;
 		ide_register_region(g);
 		err = scsi_add_host(host, &drive->gendev);
 		if (!err) {
