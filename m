Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUILXjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUILXjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUILXjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:39:41 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:3817 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264098AbUILXhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:37:01 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][1/3] ide: add ide_hwif_t->dma_setup()
Date: Mon, 13 Sep 2004 01:33:48 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Cc: "Mikael Starvik" <mikael.starvik@axis.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409130133.48630.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: add ide_hwif_t->dma_setup()

- tag REQ_DRIVE_TASKFILE write requests with REQ_RW
- split off ->dma_setup() from ->ide_dma_[read,write] functions
- use ->dma_setup() directly in ATAPI drivers and remove media
  checks from ->ide_dma_[read,write]
- ->ide_dma_[read,write,begin] cannot fail now
- in Etrax ide.c setup DMA for ATAPI devices before sending
  command to drive (so setup order is the same as for disks)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk18-bzolnier/arch/cris/arch-v10/drivers/ide.c |   62 +++------
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/arm/icside.c         |   24 +--
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-cd.c             |   12 -
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-disk.c           |   14 +-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-dma.c            |   43 ++----
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-floppy.c         |   10 -
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-tape.c           |    8 -
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-taskfile.c       |   13 +
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide.c                |    1 
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/alim15x3.c       |   15 +-
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/ns87415.c        |   18 --
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sgiioc4.c        |   41 +++---
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/trm290.c         |   66 ++++------
 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ppc/pmac.c           |   19 --
 linux-2.6.9-rc1-bk18-bzolnier/drivers/scsi/ide-scsi.c          |    9 -
 linux-2.6.9-rc1-bk18-bzolnier/include/linux/ide.h              |    5 
 16 files changed, 147 insertions(+), 213 deletions(-)

diff -puN arch/cris/arch-v10/drivers/ide.c~ide_dma_setup arch/cris/arch-v10/drivers/ide.c
--- linux-2.6.9-rc1-bk18/arch/cris/arch-v10/drivers/ide.c~ide_dma_setup	2004-09-12 23:42:15.665113520 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/arch/cris/arch-v10/drivers/ide.c	2004-09-13 00:14:08.407332504 +0200
@@ -282,6 +282,29 @@ static void tune_e100_ide(ide_drive_t *d
 	}
 }
 
+static int e100_dma_setup(ide_drive_t *drive)
+{
+	struct request *rq = drive->hwif->hwgroup->rq;
+
+	if (rq_data_dir(rq)) {
+		e100_read_command = 0;
+
+		RESET_DMA(ATA_TX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
+		WAIT_DMA(ATA_TX_DMA_NBR);
+	} else {
+		e100_read_command = 1;
+
+		RESET_DMA(ATA_RX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
+		WAIT_DMA(ATA_RX_DMA_NBR);
+	}
+
+	/* set up the Etrax DMA descriptors */
+	if (e100_ide_build_dmatable(drive))
+		return 1;
+
+	return 0;
+}
+
 void __init
 init_e100_ide (void)
 {
@@ -303,6 +326,7 @@ init_e100_ide (void)
                 hwif->atapi_output_bytes = &e100_atapi_output_bytes;
                 hwif->ide_dma_check = &e100_dma_check;
                 hwif->ide_dma_end = &e100_dma_end;
+		hwif->dma_setup = &e100_dma_setup;
 		hwif->ide_dma_write = &e100_dma_write;
 		hwif->ide_dma_read = &e100_dma_read;
 		hwif->ide_dma_begin = &e100_dma_begin;
@@ -769,10 +793,6 @@ static ide_startstop_t etrax_dma_intr (i
  * sector address using CHS or LBA.  All that remains is to prepare for DMA
  * and then issue the actual read/write DMA/PIO command to the drive.
  *
- * For ATAPI devices, we just prepare for DMA and return. The caller should
- * then issue the packet command to the drive and call us again with
- * ide_dma_begin afterwards.
- *
  * Returns 0 if all went well.
  * Returns 1 if DMA read/write could not be started, in which case
  * the caller should revert to PIO for the current request.
@@ -793,14 +813,6 @@ static int e100_start_dma(ide_drive_t *d
 {
 	if(reading) {
 
-		RESET_DMA(ATA_RX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
-		WAIT_DMA(ATA_RX_DMA_NBR);
-
-		/* set up the Etrax DMA descriptors */
-
-		if(e100_ide_build_dmatable (drive))
-			return 1;
-
 		if(!atapi) {
 			/* set the irq handler which will finish the request when DMA is done */
 
@@ -851,14 +863,6 @@ static int e100_start_dma(ide_drive_t *d
 	} else {
 		/* writing */
 
-		RESET_DMA(ATA_TX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
-		WAIT_DMA(ATA_TX_DMA_NBR);
-
-		/* set up the Etrax DMA descriptors */
-
-		if(e100_ide_build_dmatable (drive))
-			return 1;
-
 		if(!atapi) {
 			/* set the irq handler which will finish the request when DMA is done */
 
@@ -903,27 +907,11 @@ static int e100_start_dma(ide_drive_t *d
 
 static int e100_dma_write(ide_drive_t *drive)
 {
-	e100_read_command = 0;
-	/* ATAPI-devices (not disks) first call ide_dma_read/write to set the direction
-	 * then they call ide_dma_begin after they have issued the appropriate drive command
-	 * themselves to actually start the chipset DMA. so we just return here if we're
-	 * not a diskdrive.
-	 */
-	if (drive->media != ide_disk)
-                return 0;
 	return e100_start_dma(drive, 0, 0);
 }
 
 static int e100_dma_read(ide_drive_t *drive)
 {
-	e100_read_command = 1;
-	/* ATAPI-devices (not disks) first call ide_dma_read/write to set the direction
-	 * then they call ide_dma_begin after they have issued the appropriate drive command
-	 * themselves to actually start the chipset DMA. so we just return here if we're
-	 * not a diskdrive.
-	 */
-	if (drive->media != ide_disk)
-                return 0;
 	return e100_start_dma(drive, 0, 1);
 }
 
@@ -932,7 +920,7 @@ static int e100_dma_begin(ide_drive_t *d
 	/* begin DMA, used by ATAPI devices which want to issue the
 	 * appropriate IDE command themselves.
 	 *
-	 * they have already called ide_dma_read/write to set the
+	 * they have already called ->dma_setup to set the
 	 * static reading flag, now they call ide_dma_begin to do
 	 * the real stuff. we tell our code below not to issue
 	 * any IDE commands itself and jump into it.
diff -puN drivers/ide/arm/icside.c~ide_dma_setup drivers/ide/arm/icside.c
--- linux-2.6.9-rc1-bk18/drivers/ide/arm/icside.c~ide_dma_setup	2004-09-12 23:42:15.667113216 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/arm/icside.c	2004-09-13 00:14:08.409332200 +0200
@@ -443,11 +443,16 @@ static ide_startstop_t icside_dmaintr(id
 	return DRIVER(drive)->error(drive, __FUNCTION__, stat);
 }
 
-static int
-icside_dma_common(ide_drive_t *drive, struct request *rq,
-		  unsigned int dma_mode)
+static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	struct request *rq = hwif->hwgroup->rq;
+	unsigned int dma_mode;
+
+	if (rq_data_dir(rq))
+		dma_mode = DMA_MODE_WRITE;
+	else
+		dma_mode = DMA_MODE_READ;
 
 	/*
 	 * We can not enable DMA on both channels.
@@ -489,12 +494,6 @@ static int icside_dma_read(ide_drive_t *
 	struct request *rq = HWGROUP(drive)->rq;
 	task_ioreg_t cmd;
 
-	if (icside_dma_common(drive, rq, DMA_MODE_READ))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
 	BUG_ON(HWGROUP(drive)->handler != NULL);
 
 	/*
@@ -526,12 +525,6 @@ static int icside_dma_write(ide_drive_t 
 	struct request *rq = HWGROUP(drive)->rq;
 	task_ioreg_t cmd;
 
-	if (icside_dma_common(drive, rq, DMA_MODE_WRITE))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
 	BUG_ON(HWGROUP(drive)->handler != NULL);
 
 	/*
@@ -626,6 +619,7 @@ static int icside_dma_init(ide_hwif_t *h
 	hwif->ide_dma_off_quietly = icside_dma_off_quietly;
 	hwif->ide_dma_host_on	= icside_dma_host_on;
 	hwif->ide_dma_on	= icside_dma_on;
+	hwif->dma_setup		= icside_dma_setup;
 	hwif->ide_dma_read	= icside_dma_read;
 	hwif->ide_dma_write	= icside_dma_write;
 	hwif->ide_dma_begin	= icside_dma_begin;
diff -puN drivers/ide/ide.c~ide_dma_setup drivers/ide/ide.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide.c~ide_dma_setup	2004-09-12 23:42:15.670112760 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide.c	2004-09-13 00:14:08.412331744 +0200
@@ -685,6 +685,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->atapi_input_bytes		= tmp_hwif->atapi_input_bytes;
 	hwif->atapi_output_bytes	= tmp_hwif->atapi_output_bytes;
 
+	hwif->dma_setup			= tmp_hwif->dma_setup;
 	hwif->ide_dma_read		= tmp_hwif->ide_dma_read;
 	hwif->ide_dma_write		= tmp_hwif->ide_dma_write;
 	hwif->ide_dma_begin		= tmp_hwif->ide_dma_begin;
diff -puN drivers/ide/ide-cd.c~ide_dma_setup drivers/ide/ide-cd.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-cd.c~ide_dma_setup	2004-09-12 23:42:15.673112304 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-cd.c	2004-09-13 00:14:07.534465200 +0200
@@ -865,20 +865,14 @@ static ide_startstop_t cdrom_start_packe
 {
 	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
+	ide_hwif_t *hwif = drive->hwif;
 
 	/* Wait for the controller to be idle. */
 	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
 		return startstop;
 
-	if (info->dma) {
-		if (info->cmd == READ) {
-			info->dma = !HWIF(drive)->ide_dma_read(drive);
-		} else if (info->cmd == WRITE) {
-			info->dma = !HWIF(drive)->ide_dma_write(drive);
-		} else {
-			printk("ide-cd: DMA set, but not allowed\n");
-		}
-	}
+	if (info->dma)
+		info->dma = !hwif->dma_setup(drive);
 
 	/* Set up the controller registers. */
 	/* FIXME: for Virtual DMA we must check harder */
diff -puN drivers/ide/ide-disk.c~ide_dma_setup drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-disk.c~ide_dma_setup	2004-09-12 23:42:15.675112000 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-disk.c	2004-09-13 00:14:08.414331440 +0200
@@ -213,13 +213,15 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 	}
 
 	if (dma) {
-		if (rq_data_dir(rq)) {
-			if (!hwif->ide_dma_write(drive))
-				return ide_started;
-		} else {
-			if (!hwif->ide_dma_read(drive))
-				return ide_started;
+		if (!hwif->dma_setup(drive)) {
+			if (rq_data_dir(rq)) {
+				hwif->ide_dma_write(drive);
+			} else {
+				hwif->ide_dma_read(drive);
+			}
+			return ide_started;
 		}
+		/* fallback to PIO */
 		ide_init_sg_cmd(drive, rq);
 	}
 
diff -puN drivers/ide/ide-dma.c~ide_dma_setup drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-dma.c~ide_dma_setup	2004-09-12 23:42:15.677111696 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-dma.c	2004-09-13 00:14:08.416331136 +0200
@@ -590,10 +590,8 @@ int __ide_dma_check (ide_drive_t *drive)
 EXPORT_SYMBOL(__ide_dma_check);
 
 /**
- *	ide_start_dma	-	begin a DMA phase
- *	@hwif: interface
+ *	ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
- *	@reading: set if reading, clear if writing
  *
  *	Build an IDE DMA PRD (IDE speak for scatter gather table)
  *	and then set up the DMA transfer registers for a device
@@ -603,12 +601,19 @@ EXPORT_SYMBOL(__ide_dma_check);
  *	Returns 0 on success. If a PIO fallback is required then 1
  *	is returned. 
  */
- 
-int ide_start_dma(ide_hwif_t *hwif, ide_drive_t *drive, int reading)
+
+int ide_dma_setup(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int reading;
 	u8 dma_stat;
 
+	if (rq_data_dir(rq))
+		reading = 0;
+	else
+		reading = 1 << 3;
+
 	/* fall back to pio! */
 	if (!ide_build_dmatable(drive, rq))
 		return 1;
@@ -628,23 +633,15 @@ int ide_start_dma(ide_hwif_t *hwif, ide_
 	return 0;
 }
 
-EXPORT_SYMBOL(ide_start_dma);
+EXPORT_SYMBOL_GPL(ide_dma_setup);
 
-int __ide_dma_read (ide_drive_t *drive /*, struct request *rq */)
+static int __ide_dma_read(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
-	unsigned int reading	= 1 << 3;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	/* try pio */
-	if (ide_start_dma(hwif, drive, reading))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
 	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
 	
 	if (drive->vdma)
@@ -660,23 +657,13 @@ int __ide_dma_read (ide_drive_t *drive /
 	return hwif->ide_dma_begin(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_read);
-
-int __ide_dma_write (ide_drive_t *drive /*, struct request *rq */)
+static int __ide_dma_write(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
-	unsigned int reading	= 0;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command	= WIN_NOP;
 
-	/* try PIO instead of DMA */
-	if (ide_start_dma(hwif, drive, reading))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
 	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	if (drive->vdma)
 		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
@@ -692,8 +679,6 @@ int __ide_dma_write (ide_drive_t *drive 
 	return hwif->ide_dma_begin(drive);
 }
 
-EXPORT_SYMBOL(__ide_dma_write);
-
 int __ide_dma_begin (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -1002,6 +987,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_host_on = &__ide_dma_host_on;
 	if (!hwif->ide_dma_check)
 		hwif->ide_dma_check = &__ide_dma_check;
+	if (!hwif->dma_setup)
+		hwif->dma_setup = &ide_dma_setup;
 	if (!hwif->ide_dma_read)
 		hwif->ide_dma_read = &__ide_dma_read;
 	if (!hwif->ide_dma_write)
diff -puN drivers/ide/ide-floppy.c~ide_dma_setup drivers/ide/ide-floppy.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-floppy.c~ide_dma_setup	2004-09-12 23:42:15.680111240 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-floppy.c	2004-09-13 00:14:07.541464136 +0200
@@ -995,6 +995,7 @@ static ide_startstop_t idefloppy_transfe
 static ide_startstop_t idefloppy_issue_pc (ide_drive_t *drive, idefloppy_pc_t *pc)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
+	ide_hwif_t *hwif = drive->hwif;
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
@@ -1049,13 +1050,8 @@ static ide_startstop_t idefloppy_issue_p
 	}
 	feature.all = 0;
 
-	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
-		if (test_bit(PC_WRITING, &pc->flags)) {
-			feature.b.dma = !HWIF(drive)->ide_dma_write(drive);
-		} else {
-			feature.b.dma = !HWIF(drive)->ide_dma_read(drive);
-		}
-	}
+	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+		feature.b.dma = !hwif->dma_setup(drive);
 
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
diff -puN drivers/ide/ide-tape.c~ide_dma_setup drivers/ide/ide-tape.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-tape.c~ide_dma_setup	2004-09-12 23:42:15.683110784 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-tape.c	2004-09-13 00:14:07.547463224 +0200
@@ -2135,12 +2135,8 @@ static ide_startstop_t idetape_issue_pac
 				"reverting to PIO\n");
 		(void)__ide_dma_off(drive);
 	}
-	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma) {
-		if (test_bit(PC_WRITING, &pc->flags))
-			dma_ok = !HWIF(drive)->ide_dma_write(drive);
-		else
-			dma_ok = !HWIF(drive)->ide_dma_read(drive);
-	}
+	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+		dma_ok = !hwif->dma_setup(drive);
 
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
diff -puN drivers/ide/ide-taskfile.c~ide_dma_setup drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-taskfile.c~ide_dma_setup	2004-09-12 23:42:15.687110176 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-taskfile.c	2004-09-13 00:14:08.418330832 +0200
@@ -178,15 +178,19 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
-			if (!hwif->ide_dma_write(drive))
+			if (!hwif->dma_setup(drive)) {
+				hwif->ide_dma_write(drive);
 				return ide_started;
+			}
 			break;
 		case WIN_READDMA_ONCE:
 		case WIN_READDMA:
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
-			if (!hwif->ide_dma_read(drive))
+			if (!hwif->dma_setup(drive)) {
+				hwif->ide_dma_read(drive);
 				return ide_started;
+			}
 			break;
 		default:
 			if (task->handler == NULL)
@@ -526,6 +530,9 @@ int ide_diag_taskfile (ide_drive_t *driv
 
 		rq.hard_nr_sectors = rq.nr_sectors;
 		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
+
+		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+			rq.flags |= REQ_RW;
 	}
 
 	rq.special = args;
@@ -923,11 +930,13 @@ ide_startstop_t flagged_taskfile (ide_dr
 
    	        case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
+			hwif->dma_setup(drive);
 			hwif->ide_dma_write(drive);
 			break;
 
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
+			hwif->dma_setup(drive);
 			hwif->ide_dma_read(drive);
 			break;
 
diff -puN drivers/ide/pci/alim15x3.c~ide_dma_setup drivers/ide/pci/alim15x3.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/alim15x3.c~ide_dma_setup	2004-09-12 23:42:15.690109720 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/alim15x3.c	2004-09-12 23:42:15.808091784 +0200
@@ -558,18 +558,17 @@ no_dma_set:
 }
 
 /**
- *	ali15x3_dma_write	-	do a DMA IDE write
- *	@drive:	drive to issue write for
+ *	ali15x3_dma_setup	-	begin a DMA phase
+ *	@drive:	target device
  *
- *	Returns 1 if the DMA write cannot be performed, zero on 
- *	success.
+ *	Returns 1 if the DMA cannot be performed, zero on success.
  */
- 
-static int ali15x3_dma_write (ide_drive_t *drive)
+
+static int ali15x3_dma_setup(ide_drive_t *drive)
 {
 	if ((m5229_revision < 0xC2) && (drive->media != ide_disk))
 		return 1;	/* try PIO instead of DMA */
-	return __ide_dma_write(drive);
+	return ide_dma_setup(drive);
 }
 
 /**
@@ -773,7 +772,7 @@ static void __init init_hwif_common_ali1
                  * M1543C or newer for DMAing
                  */
                 hwif->ide_dma_check = &ali15x3_config_drive_for_dma;
-                hwif->ide_dma_write = &ali15x3_dma_write;
+		hwif->dma_setup = &ali15x3_dma_setup;
 		if (!noautodma)
 			hwif->autodma = 1;
 		if (!(hwif->udma_four))
diff -puN drivers/ide/pci/ns87415.c~ide_dma_setup drivers/ide/pci/ns87415.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/ns87415.c~ide_dma_setup	2004-09-12 23:42:15.693109264 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/ns87415.c	2004-09-12 23:42:15.808091784 +0200
@@ -101,22 +101,11 @@ static int ns87415_ide_dma_end (ide_driv
 	return (dma_stat & 7) != 4;
 }
 
-static int ns87415_ide_dma_read (ide_drive_t *drive)
+static int ns87415_ide_dma_setup(ide_drive_t *drive)
 {
 	/* select DMA xfer */
 	ns87415_prepare_drive(drive, 1);
-	if (!(__ide_dma_read(drive)))
-		return 0;
-	/* DMA failed: select PIO xfer */
-	ns87415_prepare_drive(drive, 0);
-	return 1;
-}
-
-static int ns87415_ide_dma_write (ide_drive_t *drive)
-{
-	/* select DMA xfer */
-	ns87415_prepare_drive(drive, 1);
-	if (!(__ide_dma_write(drive)))
+	if (!ide_dma_setup(drive))
 		return 0;
 	/* DMA failed: select PIO xfer */
 	ns87415_prepare_drive(drive, 0);
@@ -204,8 +193,7 @@ static void __init init_hwif_ns87415 (id
 		return;
 
 	hwif->OUTB(0x60, hwif->dma_status);
-	hwif->ide_dma_read = &ns87415_ide_dma_read;
-	hwif->ide_dma_write = &ns87415_ide_dma_write;
+	hwif->dma_setup = &ns87415_ide_dma_setup;
 	hwif->ide_dma_check = &ns87415_ide_dma_check;
 	hwif->ide_dma_end = &ns87415_ide_dma_end;
 
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_setup drivers/ide/pci/sgiioc4.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/sgiioc4.c~ide_dma_setup	2004-09-12 23:42:15.697108656 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/sgiioc4.c	2004-09-13 00:14:08.419330680 +0200
@@ -575,36 +575,36 @@ use_pio_instead:
 	return 0;		/* revert to PIO for this request */
 }
 
-static int
-sgiioc4_ide_dma_read(ide_drive_t * drive)
+static int sgiioc4_ide_dma_setup(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	unsigned int count = 0;
+	int ddir;
+
+	if (rq_data_dir(rq))
+		ddir = PCI_DMA_TODEVICE;
+	else
+		ddir = PCI_DMA_FROMDEVICE;
 
-	if (!(count = sgiioc4_build_dma_table(drive, rq, PCI_DMA_FROMDEVICE))) {
+	if (!(count = sgiioc4_build_dma_table(drive, rq, ddir))) {
 		/* try PIO instead of DMA */
 		return 1;
 	}
-	/* Writes FROM the IOC4 TO Main Memory */
-	sgiioc4_configure_for_dma(IOC4_DMA_WRITE, drive);
+
+	if (rq_data_dir(rq))
+		/* Writes TO the IOC4 FROM Main Memory */
+		ddir = IOC4_DMA_READ;
+	else
+		/* Writes FROM the IOC4 TO Main Memory */
+		ddir = IOC4_DMA_WRITE;
+
+	sgiioc4_configure_for_dma(ddir, drive);
 
 	return 0;
 }
 
-static int
-sgiioc4_ide_dma_write(ide_drive_t * drive)
+static int sgiioc4_ide_dma_dummy(ide_drive_t *drive)
 {
-	struct request *rq = HWGROUP(drive)->rq;
-	unsigned int count = 0;
-
-	if (!(count = sgiioc4_build_dma_table(drive, rq, PCI_DMA_TODEVICE))) {
-		/* try PIO instead of DMA */
-		return 1;
-	}
-
-	sgiioc4_configure_for_dma(IOC4_DMA_READ, drive);
-	/* Writes TO the IOC4 FROM Main Memory */
-
 	return 0;
 }
 
@@ -630,8 +630,9 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->quirkproc = NULL;
 	hwif->busproc = NULL;
 
-	hwif->ide_dma_read = &sgiioc4_ide_dma_read;
-	hwif->ide_dma_write = &sgiioc4_ide_dma_write;
+	hwif->dma_setup = &sgiioc4_ide_dma_setup;
+	hwif->ide_dma_read = &sgiioc4_ide_dma_dummy;
+	hwif->ide_dma_write = &sgiioc4_ide_dma_dummy;
 	hwif->ide_dma_begin = &sgiioc4_ide_dma_begin;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
 	hwif->ide_dma_check = &sgiioc4_ide_dma_check;
diff -puN drivers/ide/pci/trm290.c~ide_dma_setup drivers/ide/pci/trm290.c
--- linux-2.6.9-rc1-bk18/drivers/ide/pci/trm290.c~ide_dma_setup	2004-09-12 23:42:15.699108352 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/pci/trm290.c	2004-09-13 00:14:08.420330528 +0200
@@ -185,28 +185,7 @@ static int trm290_ide_dma_write (ide_dri
 	struct request *rq	= HWGROUP(drive)->rq;
 //	ide_task_t *args	= rq->special;
 	task_ioreg_t command	= WIN_NOP;
-	unsigned int count, reading = 2, writing = 0;
 
-	reading = 0;
-	writing = 1;
-#ifdef TRM290_NO_DMA_WRITES
-	/* always use PIO for writes */
-	trm290_prepare_drive(drive, 0);	/* select PIO xfer */
-	return 1;
-#endif
-	if (!(count = ide_build_dmatable(drive, rq))) {
-		/* try PIO instead of DMA */
-		trm290_prepare_drive(drive, 0); /* select PIO xfer */
-		return 1;
-	}
-	/* select DMA xfer */
-	trm290_prepare_drive(drive, 1);
-	hwif->OUTL(hwif->dmatable_dma|reading|writing, hwif->dma_command);
-	drive->waiting_for_dma = 1;
-	/* start DMA */
-	hwif->OUTW((count * 2) - 1, hwif->dma_status);
-	if (drive->media != ide_disk)
-		return 0;
 	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
 		BUG();
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
@@ -236,21 +215,7 @@ static int trm290_ide_dma_read (ide_driv
 	struct request *rq	= HWGROUP(drive)->rq;
 //	ide_task_t *args	= rq->special;
 	task_ioreg_t command	= WIN_NOP;
-	unsigned int count, reading = 2, writing = 0;
 
-	if (!(count = ide_build_dmatable(drive, rq))) {
-		/* try PIO instead of DMA */
-		trm290_prepare_drive(drive, 0); /* select PIO xfer */
-		return 1;
-	}
-	/* select DMA xfer */
-	trm290_prepare_drive(drive, 1);
-	hwif->OUTL(hwif->dmatable_dma|reading|writing, hwif->dma_command);
-	drive->waiting_for_dma = 1;
-	/* start DMA */
-	hwif->OUTW((count * 2) - 1, hwif->dma_status);
-	if (drive->media != ide_disk)
-		return 0;
 	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
 		BUG();
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
@@ -274,6 +239,36 @@ static int trm290_ide_dma_read (ide_driv
 	return hwif->ide_dma_begin(drive);
 }
 
+static int trm290_ide_dma_setup(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->hwgroup->rq;
+	unsigned int count, rw;
+
+	if (rq_data_dir(rq)) {
+#ifdef TRM290_NO_DMA_WRITES
+		/* always use PIO for writes */
+		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
+		return 1;
+#endif
+		rw = 1;
+	} else
+		rw = 2;
+
+	if (!(count = ide_build_dmatable(drive, rq))) {
+		/* try PIO instead of DMA */
+		trm290_prepare_drive(drive, 0); /* select PIO xfer */
+		return 1;
+	}
+	/* select DMA xfer */
+	trm290_prepare_drive(drive, 1);
+	hwif->OUTL(hwif->dmatable_dma|rw, hwif->dma_command);
+	drive->waiting_for_dma = 1;
+	/* start DMA */
+	hwif->OUTW((count * 2) - 1, hwif->dma_status);
+	return 0;
+}
+
 static int trm290_ide_dma_begin (ide_drive_t *drive)
 {
 	return 0;
@@ -347,6 +342,7 @@ void __devinit init_hwif_trm290(ide_hwif
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
+	hwif->dma_setup = &trm290_ide_dma_setup;
 	hwif->ide_dma_write = &trm290_ide_dma_write;
 	hwif->ide_dma_read = &trm290_ide_dma_read;
 	hwif->ide_dma_begin = &trm290_ide_dma_begin;
diff -puN drivers/ide/ppc/pmac.c~ide_dma_setup drivers/ide/ppc/pmac.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ppc/pmac.c~ide_dma_setup	2004-09-12 23:42:15.702107896 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ppc/pmac.c	2004-09-13 00:14:08.423330072 +0200
@@ -1889,7 +1889,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
  * a read on KeyLargo ATA/66 and mark us as waiting for DMA completion
  */
 static int __pmac
-pmac_ide_dma_start(ide_drive_t *drive, int reading)
+pmac_ide_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
@@ -1906,7 +1906,7 @@ pmac_ide_dma_start(ide_drive_t *drive, i
 
 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
-		writel(pmif->timings[unit] + (reading ? 0x00800000UL : 0),
+		writel(pmif->timings[unit] + (!rq_data_dir(rq) ? 0x00800000UL : 0),
 			(unsigned *)(IDE_DATA_REG+IDE_TIMING_CONFIG));
 		(void)readl((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG));
 	}
@@ -1926,12 +1926,6 @@ pmac_ide_dma_read(ide_drive_t *drive)
 	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command = WIN_NOP;
 
-	if (pmac_ide_dma_start(drive, 1))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
 	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
 	
 	if (drive->vdma)
@@ -1958,12 +1952,6 @@ pmac_ide_dma_write (ide_drive_t *drive)
 	u8 lba48 = (drive->addressing == 1) ? 1 : 0;
 	task_ioreg_t command = WIN_NOP;
 
-	if (pmac_ide_dma_start(drive, 0))
-		return 1;
-
-	if (drive->media != ide_disk)
-		return 0;
-
 	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	if (drive->vdma)
 		command = (lba48) ? WIN_WRITE_EXT: WIN_WRITE;
@@ -1989,8 +1977,6 @@ pmac_ide_dma_begin (ide_drive_t *drive)
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	volatile struct dbdma_regs *dma;
 
-	if (pmif == NULL)
-		return 1;
 	dma = pmif->dma_regs;
 
 	writel((RUN << 16) | RUN, &dma->control);
@@ -2152,6 +2138,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
+	hwif->dma_setup = &pmac_ide_dma_setup;
 	hwif->ide_dma_read = &pmac_ide_dma_read;
 	hwif->ide_dma_write = &pmac_ide_dma_write;
 	hwif->ide_dma_begin = &pmac_ide_dma_begin;
diff -puN drivers/scsi/ide-scsi.c~ide_dma_setup drivers/scsi/ide-scsi.c
--- linux-2.6.9-rc1-bk18/drivers/scsi/ide-scsi.c~ide_dma_setup	2004-09-12 23:42:15.704107592 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/scsi/ide-scsi.c	2004-09-13 00:14:07.560461248 +0200
@@ -587,6 +587,7 @@ static ide_startstop_t idescsi_transfer_
 static ide_startstop_t idescsi_issue_pc (ide_drive_t *drive, idescsi_pc_t *pc)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
+	ide_hwif_t *hwif = drive->hwif;
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 	struct request *rq = pc->rq;
@@ -597,12 +598,8 @@ static ide_startstop_t idescsi_issue_pc 
 	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
 	feature.all = 0;
-	if (drive->using_dma && rq->bio) {
-		if (test_bit(PC_WRITING, &pc->flags))
-			feature.b.dma = !HWIF(drive)->ide_dma_write(drive);
-		else
-			feature.b.dma = !HWIF(drive)->ide_dma_read(drive);
-	}
+	if (drive->using_dma && rq->bio)
+		feature.b.dma = !hwif->dma_setup(drive);
 
 	SELECT_DRIVE(drive);
 	if (IDE_CONTROL_REG)
diff -puN include/linux/ide.h~ide_dma_setup include/linux/ide.h
--- linux-2.6.9-rc1-bk18/include/linux/ide.h~ide_dma_setup	2004-09-12 23:42:15.707107136 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/include/linux/ide.h	2004-09-13 00:14:08.426329616 +0200
@@ -873,6 +873,7 @@ typedef struct hwif_s {
 	void (*atapi_input_bytes)(ide_drive_t *, void *, u32);
 	void (*atapi_output_bytes)(ide_drive_t *, void *, u32);
 
+	int (*dma_setup)(ide_drive_t *);
 	int (*ide_dma_read)(ide_drive_t *drive);
 	int (*ide_dma_write)(ide_drive_t *drive);
 	int (*ide_dma_begin)(ide_drive_t *drive);
@@ -1509,15 +1510,13 @@ extern void ide_destroy_dmatable(ide_dri
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
-extern int ide_start_dma(ide_hwif_t *, ide_drive_t *, int);
 
 extern int __ide_dma_host_off(ide_drive_t *);
 extern int __ide_dma_off_quietly(ide_drive_t *);
 extern int __ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
 extern int __ide_dma_check(ide_drive_t *);
-extern int __ide_dma_read(ide_drive_t *);
-extern int __ide_dma_write(ide_drive_t *);
+extern int ide_dma_setup(ide_drive_t *);
 extern int __ide_dma_begin(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
 extern int __ide_dma_test_irq(ide_drive_t *);
_
