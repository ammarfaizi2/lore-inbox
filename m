Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTC0XvU>; Thu, 27 Mar 2003 18:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbTC0Xu4>; Thu, 27 Mar 2003 18:50:56 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39322 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261572AbTC0Xty>; Thu, 27 Mar 2003 18:49:54 -0500
Date: Fri, 28 Mar 2003 01:00:42 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE *_dump_status() and *_error() cleanup
In-Reply-To: <Pine.SOL.4.30.0303280056440.6453-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303280057240.6453-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental to new PIO handlers (but not related to them),
however should also apply to vanilla 2.5.66.

# Remove duplicates of ide_read_24(), ide_dump_status(),
#		       try_to_flush_leftover_data() and ide_error().
#
# In ide-disk.c:     idedisk_read_24(), idedisk_dump_status(), idedisk_error().
# In ide-taskfile.c: task_read_24(), taskfile_dump_status(),
#		     task_try_to_flush_leftover_data() and taskfile_error().
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.66-ide-pio-4/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.66-ide-pio-4/drivers/ide/ide-disk.c	Thu Mar 27 00:10:59 2003
+++ linux/drivers/ide/ide-disk.c	Thu Mar 27 23:09:56 2003
@@ -73,14 +73,6 @@

 #include "legacy/pdc4030.h"

-static inline u32 idedisk_read_24 (ide_drive_t *drive)
-{
-	u8 hcyl = HWIF(drive)->INB(IDE_HCYL_REG);
-	u8 lcyl = HWIF(drive)->INB(IDE_LCYL_REG);
-	u8 sect = HWIF(drive)->INB(IDE_SECTOR_REG);
-	return (hcyl<<16)|(lcyl<<8)|sect;
-}
-
 /*
  * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
@@ -348,163 +340,6 @@

 static int do_idedisk_flushcache(ide_drive_t *drive);

-static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
-	u8 err = 0;
-
-	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-#if FANCY_STATUS_DUMPS
-	printk(" { ");
-	if (stat & BUSY_STAT)
-		printk("Busy ");
-	else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
-	}
-	printk("}");
-#endif	/* FANCY_STATUS_DUMPS */
-	printk("\n");
-	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
-		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-#if FANCY_STATUS_DUMPS
-		printk(" { ");
-		if (err & ABRT_ERR)	printk("DriveStatusError ");
-		if (err & ICRC_ERR)
-			printk("Bad%s ", (err & ABRT_ERR) ? "CRC" : "Sector");
-		if (err & ECC_ERR)	printk("UncorrectableError ");
-		if (err & ID_ERR)	printk("SectorIdNotFound ");
-		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-		printk("}");
-		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
-		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			if (drive->addressing == 1) {
-				__u64 sectors = 0;
-				u32 low = 0, high = 0;
-				low = idedisk_read_24(drive);
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				high = idedisk_read_24(drive);
-				sectors = ((__u64)high << 24) | low;
-				printk(", LBAsect=%llu, high=%d, low=%d",
-				       (unsigned long long) sectors,
-				       high, low);
-			} else {
-				u8 cur = hwif->INB(IDE_SELECT_REG);
-				if (cur & 0x40) {	/* using LBA? */
-					printk(", LBAsect=%ld", (unsigned long)
-					 ((cur&0xf)<<24)
-					 |(hwif->INB(IDE_HCYL_REG)<<16)
-					 |(hwif->INB(IDE_LCYL_REG)<<8)
-					 | hwif->INB(IDE_SECTOR_REG));
-				} else {
-					printk(", CHS=%d/%d/%d",
-					 (hwif->INB(IDE_HCYL_REG)<<8) +
-					  hwif->INB(IDE_LCYL_REG),
-					  cur & 0xf,
-					  hwif->INB(IDE_SECTOR_REG));
-				}
-			}
-			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=%llu",
-					(unsigned long long)HWGROUP(drive)->rq->sector);
-		}
-	}
-#endif	/* FANCY_STATUS_DUMPS */
-	printk("\n");
-	local_irq_restore(flags);
-	return err;
-}
-
-ide_startstop_t idedisk_error (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif;
-	struct request *rq;
-	u8 err;
-	int i = (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
-
-	err = idedisk_dump_status(drive, msg, stat);
-
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-
-	hwif = HWIF(drive);
-	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-		rq->errors = 1;
-		ide_end_drive_cmd(drive, stat, err);
-		return ide_stopped;
-	}
-#if 0
-	else if (rq->flags & REQ_DRIVE_TASKFILE) {
-		rq->errors = 1;
-		ide_end_taskfile(drive, stat, err);
-		return ide_stopped;
-	}
-#endif
-	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
-		/* other bits are useless when BUSY */
-		rq->errors |= ERROR_RESET;
-	} else if (stat & ERR_STAT) {
-		/* err has different meaning on cdrom and tape */
-		if (err == ABRT_ERR) {
-			if (drive->select.b.lba &&
-			    /* some newer drives don't support WIN_SPECIFY */
-			    hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY)
-				return ide_stopped;
-		} else if ((err & BAD_CRC) == BAD_CRC) {
-			/* UDMA crc error, just retry the operation */
-			drive->crc_count++;
-		} else if (err & (BBD_ERR | ECC_ERR)) {
-			/* retries won't help these */
-			rq->errors = ERROR_MAX;
-		} else if (err & TRK0_ERR) {
-			/* help it find track zero */
-			rq->errors |= ERROR_RECAL;
-		}
-	}
-	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ) {
-		/*
-		 * try_to_flush_leftover_data() is invoked in response to
-		 * a drive unexpectedly having its DRQ_STAT bit set.  As
-		 * an alternative to resetting the drive, this routine
-		 * tries to clear the condition by read a sector's worth
-		 * of data from the drive.  Of course, this may not help
-		 * if the drive is *waiting* for data from *us*.
-		 */
-		while (i > 0) {
-			u32 buffer[16];
-			unsigned int wcount = (i > 16) ? 16 : i;
-			i -= wcount;
-			taskfile_input_data(drive, buffer, wcount);
-		}
-	}
-	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
-		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
-	}
-	if (rq->errors >= ERROR_MAX)
-		DRIVER(drive)->end_request(drive, 0, 0);
-	else {
-		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
-			++rq->errors;
-			return ide_do_reset(drive);
-		}
-		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			drive->special.b.recalibrate = 1;
-		++rq->errors;
-	}
-	return ide_stopped;
-}
-
 ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
 {
 	ide_hwif_t *hwif;
@@ -1248,8 +1083,6 @@
 	.cleanup		= idedisk_cleanup,
 	.flushcache		= do_idedisk_flushcache,
 	.do_request		= do_rw_disk,
-	.sense			= idedisk_dump_status,
-	.error			= idedisk_error,
 	.abort			= idedisk_abort,
 	.pre_reset		= idedisk_pre_reset,
 	.capacity		= idedisk_capacity,
diff -uNr linux-2.5.66-ide-pio-4/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.66-ide-pio-4/drivers/ide/ide-taskfile.c	Thu Mar 27 00:08:16 2003
+++ linux/drivers/ide/ide-taskfile.c	Thu Mar 27 23:08:29 2003
@@ -62,15 +62,6 @@
 #define task_map_rq(rq, flags)		ide_map_buffer((rq), (flags))
 #define task_unmap_rq(rq, buf, flags)	ide_unmap_buffer((rq), (buf), (flags))

-inline u32 task_read_24 (ide_drive_t *drive)
-{
-	return	(HWIF(drive)->INB(IDE_HCYL_REG)<<16) |
-		(HWIF(drive)->INB(IDE_LCYL_REG)<<8) |
-		 HWIF(drive)->INB(IDE_SECTOR_REG);
-}
-
-EXPORT_SYMBOL(task_read_24);
-
 static void ata_bswap_data (void *buffer, int wcount)
 {
 	u16 *p = buffer;
@@ -220,88 +211,6 @@
 EXPORT_SYMBOL(do_rw_taskfile);

 /*
- * Error reporting, in human readable form (luxurious, but a memory hog).
- */
-u8 taskfile_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
-	u8 err = 0;
-
-	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-#if FANCY_STATUS_DUMPS
-	printk(" { ");
-	if (stat & BUSY_STAT) {
-		printk("Busy ");
-	} else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
-	}
-	printk("}");
-#endif  /* FANCY_STATUS_DUMPS */
-	printk("\n");
-	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
-		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-#if FANCY_STATUS_DUMPS
-		if (drive->media == ide_disk)
-			goto media_out;
-
-		printk(" { ");
-		if (err & ABRT_ERR)	printk("DriveStatusError ");
-		if (err & ICRC_ERR)	printk("Bad%s", (err & ABRT_ERR) ? "CRC " : "Sector ");
-		if (err & ECC_ERR)	printk("UncorrectableError ");
-		if (err & ID_ERR)	printk("SectorIdNotFound ");
-		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-		printk("}");
-		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
-		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			if (drive->addressing == 1) {
-				u64 sectors = 0;
-				u32 high = 0;
-				u32 low = task_read_24(drive);
-				hwif->OUTB(0x80, IDE_CONTROL_REG);
-				high = task_read_24(drive);
-				sectors = ((u64)high << 24) | low;
-				printk(", LBAsect=%lld", (long long) sectors);
-			} else {
-				u8 cur  = hwif->INB(IDE_SELECT_REG);
-				u8 low  = hwif->INB(IDE_LCYL_REG);
-				u8 high = hwif->INB(IDE_HCYL_REG);
-				u8 sect = hwif->INB(IDE_SECTOR_REG);
-				/* using LBA? */
-				if (cur & 0x40) {
-					printk(", LBAsect=%d", (u32)
-						((cur&0xf)<<24)|(high<<16)|
-						(low<<8)|sect);
-				} else {
-					printk(", CHS=%d/%d/%d",
-						((high<<8) + low),
-						(cur & 0xf), sect);
-				}
-			}
-			if (HWGROUP(drive)->rq)
-				printk(", sector=%llu",
-					(unsigned long long)HWGROUP(drive)->rq->sector);
-		}
-media_out:
-#endif  /* FANCY_STATUS_DUMPS */
-		printk("\n");
-	}
-	local_irq_restore(flags);
-	return err;
-}
-
-EXPORT_SYMBOL(taskfile_dump_status);
-
-/*
  * Clean up after success/failure of an explicit taskfile operation.
  */
 void ide_end_taskfile (ide_drive_t *drive, u8 stat, u8 err)
@@ -362,99 +271,6 @@
 EXPORT_SYMBOL(ide_end_taskfile);

 /*
- * try_to_flush_leftover_data() is invoked in response to a drive
- * unexpectedly having its DRQ_STAT bit set.  As an alternative to
- * resetting the drive, this routine tries to clear the condition
- * by read a sector's worth of data from the drive.  Of course,
- * this may not help if the drive is *waiting* for data from *us*.
- */
-void task_try_to_flush_leftover_data (ide_drive_t *drive)
-{
-	int i = (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
-
-	if (drive->media != ide_disk)
-		return;
-	while (i > 0) {
-		u32 buffer[16];
-		unsigned int wcount = (i > 16) ? 16 : i;
-		i -= wcount;
-		taskfile_input_data(drive, buffer, wcount);
-	}
-}
-
-EXPORT_SYMBOL(task_try_to_flush_leftover_data);
-
-/*
- * taskfile_error() takes action based on the error returned by the drive.
- */
-ide_startstop_t taskfile_error (ide_drive_t *drive, const char *msg, u8 stat)
-{
-	ide_hwif_t *hwif;
-	struct request *rq;
-	u8 err;
-
-        err = taskfile_dump_status(drive, msg, stat);
-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
-		return ide_stopped;
-
-	hwif = HWIF(drive);
-	/* retry only "normal" I/O: */
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
-		rq->errors = 1;
-		ide_end_taskfile(drive, stat, err);
-		return ide_stopped;
-	}
-	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
-		/* other bits are useless when BUSY */
-		rq->errors |= ERROR_RESET;
-	} else {
-		if (drive->media != ide_disk)
-			goto media_out;
-		if (stat & ERR_STAT) {
-			/* err has different meaning on cdrom and tape */
-			if (err == ABRT_ERR) {
-				if (drive->select.b.lba &&
-				    (hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY))
-					/* some newer drives don't
-					 * support WIN_SPECIFY
-					 */
-					return ide_stopped;
-			} else if ((err & BAD_CRC) == BAD_CRC) {
-				/* UDMA crc error -- just retry the operation */
-				drive->crc_count++;
-			} else if (err & (BBD_ERR | ECC_ERR)) {
-				/* retries won't help these */
-				rq->errors = ERROR_MAX;
-			} else if (err & TRK0_ERR) {
-				/* help it find track zero */
-				rq->errors |= ERROR_RECAL;
-			}
-                }
-media_out:
-                if ((stat & DRQ_STAT) && rq_data_dir(rq) != WRITE)
-                        task_try_to_flush_leftover_data(drive);
-	}
-	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
-		/* force an abort */
-		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
-	}
-	if (rq->errors >= ERROR_MAX) {
-		DRIVER(drive)->end_request(drive, 0, 0);
-	} else {
-		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
-			++rq->errors;
-			return ide_do_reset(drive);
-		}
-		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			drive->special.b.recalibrate = 1;
-		++rq->errors;
-	}
-	return ide_stopped;
-}
-
-EXPORT_SYMBOL(taskfile_error);
-
-/*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
  */
 ide_startstop_t set_multmode_intr (ide_drive_t *drive)
diff -uNr linux-2.5.66-ide-pio-4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.66-ide-pio-4/drivers/ide/ide.c	Tue Mar 25 22:53:09 2003
+++ linux/drivers/ide/ide.c	Thu Mar 27 22:38:42 2003
@@ -421,19 +421,20 @@
 					       (long long) sectors,
 					       high, low);
 				} else {
-					u8 cur = hwif->INB(IDE_SELECT_REG);
-					if (cur & 0x40) {	/* using LBA? */
-						printk(", LBAsect=%ld", (unsigned long)
-						 ((cur&0xf)<<24)
-						 |(hwif->INB(IDE_HCYL_REG)<<16)
-						 |(hwif->INB(IDE_LCYL_REG)<<8)
-						 | hwif->INB(IDE_SECTOR_REG));
+					u8 cur  = hwif->INB(IDE_SELECT_REG);
+					u8 low  = hwif->INB(IDE_LCYL_REG);
+					u8 high = hwif->INB(IDE_HCYL_REG);
+					u8 sect = hwif->INB(IDE_SECTOR_REG);
+					/* using LBA? */
+					if (cur & 0x40) {
+						printk(", LBAsect=%d", (u32)
+							((cur&0xf)<<24)
+							|(high<<16)|(low<<8)
+							|sect);
 					} else {
 						printk(", CHS=%d/%d/%d",
-						 (hwif->INB(IDE_HCYL_REG)<<8) +
-						  hwif->INB(IDE_LCYL_REG),
-						  cur & 0xf,
-						  hwif->INB(IDE_SECTOR_REG));
+							((high<<8) + low),
+							(cur & 0xf), sect);
 					}
 				}
 				if (HWGROUP(drive) && HWGROUP(drive)->rq)

