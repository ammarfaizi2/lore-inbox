Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTEOXGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTEOXGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:06:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52471 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264308AbTEOXFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:05:18 -0400
Date: Fri, 16 May 2003 01:17:40 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] switch IDE to taskfile IO
Message-ID: <Pine.SOL.4.30.0305160107320.19724-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resynced with 2.5.69-bk10 and updated slightly.

Please try it if you were experiencing problems
with IDE PIO / IDE multisector PIO

As usual with IDE stuff, special care is needed.

I want to send it to Linus before 2.6.
--
Bartlomiej


# Switch IDE to taskfile IO and remove non-taskfile code.
# New IDE PIO handlers for taskfile IO (they use bio walking).
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 drivers/ide/ide-disk.c     |  426 -----------------------------------
 drivers/ide/ide-taskfile.c |  545 ++++++++++++++++++---------------------------
 include/linux/blkdev.h     |    1
 include/linux/ide.h        |   20 +
 4 files changed, 244 insertions(+), 748 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_tf_pio_handlers drivers/ide/ide-disk.c
--- linux-2.5.69-bk10/drivers/ide/ide-disk.c~ide_tf_pio_handlers	Fri May 16 00:24:41 2003
+++ linux-2.5.69-bk10-root/drivers/ide/ide-disk.c	Fri May 16 00:31:25 2003
@@ -136,427 +136,6 @@ static int idedisk_start_tag(ide_drive_t
 	return ret;
 }

-#ifndef CONFIG_IDE_TASKFILE_IO
-
-static int driver_blocked;
-
-/*
- * read_intr() is the handler for disk read/multread interrupts
- */
-static ide_startstop_t read_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u32 i = 0, nsect	= 0, msect = drive->mult_count;
-	struct request *rq;
-	unsigned long flags;
-	u8 stat;
-	char *to;
-
-	/* new way for dealing with premature shared PCI interrupts */
-	if (!OK_STAT(stat=hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "read_intr", stat);
-		}
-		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-		return ide_started;
-	}
-
-read_next:
-	rq = HWGROUP(drive)->rq;
-	if (msect) {
-		if ((nsect = rq->current_nr_sectors) > msect)
-			nsect = msect;
-		msect -= nsect;
-	} else
-		nsect = 1;
-	to = ide_map_buffer(rq, &flags);
-	taskfile_input_data(drive, to, nsect * SECTOR_WORDS);
-#ifdef DEBUG
-	printk("%s:  read: sectors(%ld-%ld), buffer=0x%08lx, remaining=%ld\n",
-		drive->name, rq->sector, rq->sector+nsect-1,
-		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
-#endif
-	ide_unmap_buffer(rq, to, &flags);
-	rq->sector += nsect;
-	rq->errors = 0;
-	i = (rq->nr_sectors -= nsect);
-	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
-		ide_end_request(drive, 1, rq->hard_cur_sectors);
-	/*
-	 * Another BH Page walker and DATA INTEGRITY Questioned on ERROR.
-	 * If passed back up on multimode read, BAD DATA could be ACKED
-	 * to FILE SYSTEMS above ...
-	 */
-	if (i > 0) {
-		if (msect)
-			goto read_next;
-		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-                return ide_started;
-	}
-        return ide_stopped;
-}
-
-/*
- * write_intr() is the handler for disk write interrupts
- */
-static ide_startstop_t write_intr (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= hwgroup->rq;
-	u32 i = 0;
-	u8 stat;
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),
-			DRIVE_READY, drive->bad_wstat)) {
-		printk("%s: write_intr error1: nr_sectors=%ld, stat=0x%02x\n",
-			drive->name, rq->nr_sectors, stat);
-        } else {
-#ifdef DEBUG
-		printk("%s: write: sector %ld, buffer=0x%08lx, remaining=%ld\n",
-			drive->name, rq->sector, (unsigned long) rq->buffer,
-			rq->nr_sectors-1);
-#endif
-		if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
-			rq->sector++;
-			rq->errors = 0;
-			i = --rq->nr_sectors;
-			--rq->current_nr_sectors;
-			if (((long)rq->current_nr_sectors) <= 0)
-				ide_end_request(drive, 1, rq->hard_cur_sectors);
-			if (i > 0) {
-				unsigned long flags;
-				char *to = ide_map_buffer(rq, &flags);
-				taskfile_output_data(drive, to, SECTOR_WORDS);
-				ide_unmap_buffer(rq, to, &flags);
-				ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-                                return ide_started;
-			}
-                        return ide_stopped;
-		}
-		/* the original code did this here (?) */
-		return ide_stopped;
-	}
-	return DRIVER(drive)->error(drive, "write_intr", stat);
-}
-
-/*
- * ide_multwrite() transfers a block of up to mcount sectors of data
- * to a drive as part of a disk multiple-sector write operation.
- *
- * Returns 0 on success.
- *
- * Note that we may be called from two contexts - the do_rw_disk context
- * and IRQ context. The IRQ can happen any time after we've output the
- * full "mcount" number of sectors, so we must make sure we update the
- * state _before_ we output the final part of the data!
- *
- * The update and return to BH is a BLOCK Layer Fakey to get more data
- * to satisfy the hardware atomic segment.  If the hardware atomic segment
- * is shorter or smaller than the BH segment then we should be OKAY.
- * This is only valid if we can rewind the rq->current_nr_sectors counter.
- */
-int ide_multwrite (ide_drive_t *drive, unsigned int mcount)
-{
- 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
- 	struct request *rq	= &hwgroup->wrq;
-
-  	do {
-  		char *buffer;
-  		int nsect = rq->current_nr_sectors;
-		unsigned long flags;
-
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-		buffer = ide_map_buffer(rq, &flags);
-
-		rq->sector += nsect;
-		rq->nr_sectors -= nsect;
-		rq->current_nr_sectors -= nsect;
-
-		/* Do we move to the next bh after this? */
-		if (!rq->current_nr_sectors) {
-			struct bio *bio = rq->bio;
-
-			/*
-			 * only move to next bio, when we have processed
-			 * all bvecs in this one.
-			 */
-			if (++bio->bi_idx >= bio->bi_vcnt) {
-				bio->bi_idx = 0;
-				bio = bio->bi_next;
-			}
-
-			/* end early early we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
-				rq->hard_cur_sectors = rq->current_nr_sectors;
-			}
-		}
-
-		/*
-		 * Ok, we're all setup for the interrupt
-		 * re-entering us on the last transfer.
-		 */
-		taskfile_output_data(drive, buffer, nsect<<7);
-		ide_unmap_buffer(rq, buffer, &flags);
-	} while (mcount);
-
-        return 0;
-}
-
-/*
- * multwrite_intr() is the handler for disk multwrite interrupts
- */
-static ide_startstop_t multwrite_intr (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= &hwgroup->wrq;
-	u8 stat;
-
-	stat = hwif->INB(IDE_STATUS_REG);
-	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
-		if (stat & DRQ_STAT) {
-			/*
-			 *	The drive wants data. Remember rq is the copy
-			 *	of the request
-			 */
-			if (rq->nr_sectors) {
-				if (ide_multwrite(drive, drive->mult_count))
-					return ide_stopped;
-				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-				return ide_started;
-			}
-		} else {
-			/*
-			 *	If the copy has all the blocks completed then
-			 *	we can end the original request.
-			 */
-			if (!rq->nr_sectors) {	/* all done? */
-				rq = hwgroup->rq;
-				ide_end_request(drive, 1, rq->nr_sectors);
-				return ide_stopped;
-			}
-		}
-		/* the original code did this here (?) */
-		return ide_stopped;
-	}
-	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
-}
-
-/*
- * do_rw_disk() issues READ and WRITE commands to a disk,
- * using LBA if supported, or CHS otherwise, to address sectors.
- * It also takes care of issuing special DRIVE_CMDs.
- */
-static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
-	ata_nsector_t		nsectors;
-
-	nsectors.all		= (u16) rq->nr_sectors;
-
-	if (driver_blocked)
-		panic("Request while ide driver is blocked?");
-
-#if defined(CONFIG_BLK_DEV_PDC4030) || defined(CONFIG_BLK_DEV_PDC4030_MODULE)
-	if (IS_PDC4030_DRIVE)
-		return promise_rw_disk(drive, rq, block);
-#endif /* CONFIG_BLK_DEV_PDC4030 */
-
-	if (drive->using_tcq && idedisk_start_tag(drive, rq)) {
-		if (!ata_pending_commands(drive))
-			BUG();
-
-		return ide_started;
-	}
-
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-
-	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
-			task_ioreg_t tasklets[10];
-
-			if (blk_rq_tagged(rq)) {
-				tasklets[0] = nsectors.b.low;
-				tasklets[1] = nsectors.b.high;
-				tasklets[2] = rq->tag << 3;
-				tasklets[3] = 0;
-			} else {
-				tasklets[0] = 0;
-				tasklets[1] = 0;
-				tasklets[2] = nsectors.b.low;
-				tasklets[3] = nsectors.b.high;
-			}
-
-			tasklets[4] = (task_ioreg_t) block;
-			tasklets[5] = (task_ioreg_t) (block>>8);
-			tasklets[6] = (task_ioreg_t) (block>>16);
-			tasklets[7] = (task_ioreg_t) (block>>24);
-			if (sizeof(block) == 4) {
-				tasklets[8] = (task_ioreg_t) 0;
-				tasklets[9] = (task_ioreg_t) 0;
-			} else {
-				tasklets[8] = (task_ioreg_t)((u64)block >> 32);
-				tasklets[9] = (task_ioreg_t)((u64)block >> 40);
-			}
-#ifdef DEBUG
-			printk("%s: %sing: LBAsect=%lu, sectors=%ld, "
-				"buffer=0x%08lx, LBAsect=0x%012lx\n",
-				drive->name,
-				rq_data_dir(rq)==READ?"read":"writ",
-				block,
-				rq->nr_sectors,
-				(unsigned long) rq->buffer,
-				block);
-			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
-				drive->name, tasklets[3], tasklets[2],
-				tasklets[9], tasklets[8], tasklets[7],
-				tasklets[6], tasklets[5], tasklets[4]);
-#endif
-			hwif->OUTB(tasklets[1], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[3], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[7], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[8], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[9], IDE_HCYL_REG);
-
-			hwif->OUTB(tasklets[0], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[2], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[4], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[5], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[6], IDE_HCYL_REG);
-			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
-		} else {
-#ifdef DEBUG
-			printk("%s: %sing: LBAsect=%llu, sectors=%ld, "
-				"buffer=0x%08lx\n",
-				drive->name,
-				rq_data_dir(rq)==READ?"read":"writ",
-				(unsigned long long)block, rq->nr_sectors,
-				(unsigned long) rq->buffer);
-#endif
-			if (blk_rq_tagged(rq)) {
-				hwif->OUTB(nsectors.b.low, IDE_FEATURE_REG);
-				hwif->OUTB(rq->tag << 3, IDE_NSECTOR_REG);
-			} else {
-				hwif->OUTB(0x00, IDE_FEATURE_REG);
-				hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-			}
-
-			hwif->OUTB(block, IDE_SECTOR_REG);
-			hwif->OUTB(block>>=8, IDE_LCYL_REG);
-			hwif->OUTB(block>>=8, IDE_HCYL_REG);
-			hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
-		}
-	} else {
-		unsigned int sect,head,cyl,track;
-		track = (int)block / drive->sect;
-		sect  = (int)block % drive->sect + 1;
-		hwif->OUTB(sect, IDE_SECTOR_REG);
-		head  = track % drive->head;
-		cyl   = track / drive->head;
-
-		if (blk_rq_tagged(rq)) {
-			hwif->OUTB(nsectors.b.low, IDE_FEATURE_REG);
-			hwif->OUTB(rq->tag << 3, IDE_NSECTOR_REG);
-		} else {
-			hwif->OUTB(0x00, IDE_FEATURE_REG);
-			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-		}
-
-		hwif->OUTB(cyl, IDE_LCYL_REG);
-		hwif->OUTB(cyl>>8, IDE_HCYL_REG);
-		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
-#ifdef DEBUG
-		printk("%s: %sing: CHS=%d/%d/%d, sectors=%ld, buffer=0x%08lx\n",
-			drive->name, rq_data_dir(rq)==READ?"read":"writ", cyl,
-			head, sect, rq->nr_sectors, (unsigned long) rq->buffer);
-#endif
-	}
-
-	if (rq_data_dir(rq) == READ) {
-		if (blk_rq_tagged(rq))
-			return hwif->ide_dma_queued_read(drive);
-
-		if (drive->using_dma && !hwif->ide_dma_read(drive))
-			return ide_started;
-
-		command = ((drive->mult_count) ?
-			   ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
-			   ((lba48) ? WIN_READ_EXT : WIN_READ));
-		ide_execute_command(drive, command, &read_intr, WAIT_CMD, NULL);
-		return ide_started;
-	} else if (rq_data_dir(rq) == WRITE) {
-		ide_startstop_t startstop;
-
-		if (blk_rq_tagged(rq))
-			return hwif->ide_dma_queued_write(drive);
-
-		if (drive->using_dma && !(HWIF(drive)->ide_dma_write(drive)))
-			return ide_started;
-
-		command = ((drive->mult_count) ?
-			   ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
-			   ((lba48) ? WIN_WRITE_EXT : WIN_WRITE));
-		hwif->OUTB(command, IDE_COMMAND_REG);
-
-		if (ide_wait_stat(&startstop, drive, DATA_READY,
-				drive->bad_wstat, WAIT_DRQ)) {
-			printk(KERN_ERR "%s: no DRQ after issuing %s\n",
-				drive->name,
-				drive->mult_count ? "MULTWRITE" : "WRITE");
-			return startstop;
-		}
-		if (!drive->unmask)
-			local_irq_disable();
-		if (drive->mult_count) {
-			ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	/*
-	 * Ugh.. this part looks ugly because we MUST set up
-	 * the interrupt handler before outputting the first block
-	 * of data to be written.  If we hit an error (corrupted buffer list)
-	 * in ide_multwrite(), then we need to remove the handler/timer
-	 * before returning.  Fortunately, this NEVER happens (right?).
-	 *
-	 * Except when you get an error it seems...
-	 *
-	 * MAJOR DATA INTEGRITY BUG !!! only if we error
-	 */
-			hwgroup->wrq = *rq; /* scratchpad */
-			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-			if (ide_multwrite(drive, drive->mult_count)) {
-				unsigned long flags;
-				spin_lock_irqsave(&ide_lock, flags);
-				hwgroup->handler = NULL;
-				del_timer(&hwgroup->timer);
-				spin_unlock_irqrestore(&ide_lock, flags);
-				return ide_stopped;
-			}
-		} else {
-			unsigned long flags;
-			char *to = ide_map_buffer(rq, &flags);
-			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-			taskfile_output_data(drive, to, SECTOR_WORDS);
-			ide_unmap_buffer(rq, to, &flags);
-		}
-		return ide_started;
-	}
-	blk_dump_rq_flags(rq, "do_rw_disk - bad command");
-	ide_end_request(drive, 0, 0);
-	return ide_stopped;
-}
-
-#else /* CONFIG_IDE_TASKFILE_IO */
-
 static ide_startstop_t chs_rw_disk(ide_drive_t *, struct request *, unsigned long);
 static ide_startstop_t lba_28_rw_disk(ide_drive_t *, struct request *, unsigned long);
 static ide_startstop_t lba_48_rw_disk(ide_drive_t *, struct request *, unsigned long long);
@@ -758,8 +337,6 @@ static ide_startstop_t lba_48_rw_disk (i
 	return do_rw_taskfile(drive, &args);
 }

-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 static int do_idedisk_flushcache(ide_drive_t *drive);

 static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
@@ -864,6 +441,9 @@ ide_startstop_t idedisk_error (ide_drive
 		return ide_stopped;
 	}
 #endif
+	/* make rq completion pointers new submission pointers */
+	blk_rq_prep_restart(rq);
+
 	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
 		/* other bits are useless when BUSY */
 		rq->errors |= ERROR_RESET;
diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_handlers drivers/ide/ide-taskfile.c
--- linux-2.5.69-bk10/drivers/ide/ide-taskfile.c~ide_tf_pio_handlers	Fri May 16 00:24:01 2003
+++ linux-2.5.69-bk10-root/drivers/ide/ide-taskfile.c	Fri May 16 00:34:20 2003
@@ -5,6 +5,7 @@
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2001-2002	Klaus Smolin
  *					IBM Storage Technology Division
+ *  Copyright (C) 2003		Bartlomiej Zolnierkiewicz
  *
  *  The big the bad and the ugly.
  *
@@ -58,9 +59,6 @@
 #define DTF(x...)
 #endif

-#define task_map_rq(rq, flags)		ide_map_buffer((rq), (flags))
-#define task_unmap_rq(rq, buf, flags)	ide_unmap_buffer((rq), (buf), (flags))
-
 static void ata_bswap_data (void *buffer, int wcount)
 {
 	u16 *p = buffer;
@@ -167,9 +165,12 @@ ide_startstop_t do_rw_taskfile (ide_driv

 	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
 	if (task->handler != NULL) {
-		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
-		if (task->prehandler != NULL)
+		if (task->prehandler != NULL) {
+			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+			ndelay(400);	/* FIXME */
 			return task->prehandler(drive, task->rq);
+		}
+		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}

@@ -351,404 +352,297 @@ ide_startstop_t task_no_data_intr (ide_d

 EXPORT_SYMBOL(task_no_data_intr);

-/*
- * Handler for command with PIO data-in phase, READ
- */
-/*
- * FIXME before 2.4 enable ...
- *	DATA integrity issue upon error. <andre@linux-ide.org>
- */
-ide_startstop_t task_in_intr (ide_drive_t *drive)
+static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
-	struct request *rq	= HWGROUP(drive)->rq;
-	ide_hwif_t *hwif	= HWIF(drive);
-	char *pBuf		= NULL;
+	ide_hwif_t *hwif = HWIF(drive);
+	int retries = 5;
 	u8 stat;
+	/*
+	 * (ks) Last sector was transfered, wait until drive is ready.
+	 * This can take up to 10 usec. We willl wait max 50 us.
+	 */
+	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
+		udelay(10);
+	return stat;
+}
+
+#define PIO_IN	0
+#define PIO_OUT	1
+
+static inline void task_sectors(ide_drive_t *drive, struct request *rq,
+				unsigned nsect, int rw)
+{
 	unsigned long flags;
+	char *buf;

-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-#if 0
-			DTF("%s: attempting to recover last " \
-				"sector counter status=0x%02x\n",
-				drive->name, stat);
-			/*
-			 * Expect a BUG BOMB if we attempt to rewind the
-			 * offset in the BH aka PAGE in the current BLOCK
-			 * segment.  This is different than the HOST segment.
-			 */
-#endif
-			if (!rq->bio)
-				rq->current_nr_sectors++;
-			return DRIVER(drive)->error(drive, "task_in_intr", stat);
-		}
-		if (!(stat & BUSY_STAT)) {
-			DTF("task_in_intr to Soon wait for next interrupt\n");
-			if (HWGROUP(drive)->handler == NULL)
-				ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
-			return ide_started;
-		}
-	}
-#if 0
+	buf = task_map_rq(rq, &flags);

 	/*
-	 * Holding point for a brain dump of a thought :-/
+	 * IRQ can happen instantly after reading/writing
+	 * last sector of the datablock.
 	 */
+	process_that_request_first(rq, nsect);

-	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat)) {
-		DTF("%s: READ attempting to recover last " \
-			"sector counter status=0x%02x\n",
-			drive->name, stat);
-		rq->current_nr_sectors++;
-		return DRIVER(drive)->error(drive, "task_in_intr", stat);
-        }
-	if (!rq->current_nr_sectors)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
+	if (rw == PIO_OUT)
+		taskfile_output_data(drive, buf, nsect * SECTOR_WORDS);
+	else
+		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);

-	if (--rq->current_nr_sectors <= 0)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
-#endif
+	task_unmap_rq(rq, buf, &flags);
+}
+
+/*
+ * Handler for command with PIO data-in phase (Read).
+ */
+ide_startstop_t task_in_intr (ide_drive_t *drive)
+{
+	struct request *rq = HWGROUP(drive)->rq;
+	u8 stat, good_stat;
+
+	good_stat = DATA_READY;
+	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+check_status:
+	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
+		if (stat & (ERR_STAT | DRQ_STAT))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		/* BUSY_STAT: No data yet, so wait for another IRQ. */
+		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+		return ide_started;
+	}

-	pBuf = task_map_rq(rq, &flags);
-	DTF("Read: %p, rq->current_nr_sectors: %d, stat: %02x\n",
-		pBuf, (int) rq->current_nr_sectors, stat);
-	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
-	task_unmap_rq(rq, pBuf, &flags);
 	/*
-	 * FIXME :: We really can not legally get a new page/bh
-	 * regardless, if this is the end of our segment.
-	 * BH walking or segment can only be updated after we have a good
-	 * hwif->INB(IDE_STATUS_REG); return.
+	 * Complete previously submitted bios (if any).
+	 * Status was already verifyied.
 	 */
-	if (--rq->current_nr_sectors <= 0)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
+	while (rq->bio != rq->cbio)
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
 			return ide_stopped;
-	/*
-	 * ERM, it is techincally legal to leave/exit here but it makes
-	 * a mess of the code ...
-	 */
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}
+
+	rq->errors = 0;
+	task_sectors(drive, rq, 1, PIO_IN);
+
+	/* If it was the last datablock check status and finish transfer. */
+	if (!rq->nr_sectors) {
+		good_stat = 0;
+		stat = wait_drive_not_busy(drive);
+		goto check_status;
+	}
+
+	/* Still data left to transfer. */
+	ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+
 	return ide_started;
 }
-
 EXPORT_SYMBOL(task_in_intr);

 /*
- * Handler for command with Read Multiple
+ * Handler for command with PIO data-in phase (Read Multiple).
  */
 ide_startstop_t task_mulin_intr (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-	unsigned int msect	= drive->mult_count;
+	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int msect = drive->mult_count;
 	unsigned int nsect;
-	unsigned long flags;
-	u8 stat;
+	u8 stat, good_stat;

-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			if (!rq->bio) {
-				rq->current_nr_sectors += drive->mult_count;
-				/*
-				 * NOTE: could rewind beyond beginning :-/
-				 */
-			} else {
-				printk(KERN_ERR "%s: MULTI-READ assume all data " \
-					"transfered is bad status=0x%02x\n",
-					drive->name, stat);
-			}
-			return DRIVER(drive)->error(drive, "task_mulin_intr", stat);
-		}
-		/* no data yet, so wait for another interrupt */
-		if (HWGROUP(drive)->handler == NULL)
-			ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
+	good_stat = DATA_READY;
+	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+check_status:
+	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
+		if (stat & (ERR_STAT | DRQ_STAT))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		/* BUSY_STAT: No data yet, so wait for another IRQ. */
+		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}

+	/*
+	 * Complete previously submitted bios (if any).
+	 * Status was already verifyied.
+	 */
+	while (rq->bio != rq->cbio)
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
+			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}
+
+	rq->errors = 0;
 	do {
 		nsect = rq->current_nr_sectors;
 		if (nsect > msect)
 			nsect = msect;
-		pBuf = task_map_rq(rq, &flags);
-		DTF("Multiread: %p, nsect: %d, msect: %d, " \
-			" rq->current_nr_sectors: %d\n",
-			pBuf, nsect, msect, rq->current_nr_sectors);
-		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
-		rq->errors = 0;
-		rq->current_nr_sectors -= nsect;
-		msect -= nsect;
-		/*
-		 * FIXME :: We really can not legally get a new page/bh
-		 * regardless, if this is the end of our segment.
-		 * BH walking or segment can only be updated after we have a
-		 * good hwif->INB(IDE_STATUS_REG); return.
-		 */
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				return ide_stopped;
-		}
-	} while (msect);
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
-	return ide_started;
-}

-EXPORT_SYMBOL(task_mulin_intr);
+		task_sectors(drive, rq, nsect, PIO_IN);

-/*
- * VERIFY ME before 2.4 ... unexpected race is possible based on details
- * RMK with 74LS245/373/374 TTL buffer logic because of passthrough.
- */
-ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
-{
-	char *pBuf		= NULL;
-	unsigned long flags;
-	ide_startstop_t startstop;
+		if (!rq->nr_sectors)
+			msect = 0;
+		else
+			msect -= nsect;
+	} while (msect);

-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing WRITE%s\n",
-			drive->name,
-			drive->addressing ? "_EXT" : "");
-		return startstop;
+	/* If it was the last datablock check status and finish transfer. */
+	if (!rq->nr_sectors) {
+		good_stat = 0;
+		stat = wait_drive_not_busy(drive);
+		goto check_status;
 	}
-	/* For Write_sectors we need to stuff the first sector */
-	pBuf = task_map_rq(rq, &flags);
-	taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-	rq->current_nr_sectors--;
-	task_unmap_rq(rq, pBuf, &flags);
+
+	/* Still data left to transfer. */
+	ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
+
 	return ide_started;
 }
-
-EXPORT_SYMBOL(pre_task_out_intr);
+EXPORT_SYMBOL(task_mulin_intr);

 /*
- * Handler for command with PIO data-out phase WRITE
- *
- * WOOHOO this is a CORRECT STATE DIAGRAM NOW, <andre@linux-ide.org>
+ * Handler for command with PIO data-out phase (Write).
  */
 ide_startstop_t task_out_intr (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-	unsigned long flags;
+	struct request *rq = HWGROUP(drive)->rq;
 	u8 stat;

-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY, drive->bad_wstat)) {
-		DTF("%s: WRITE attempting to recover last " \
-			"sector counter status=0x%02x\n",
-			drive->name, stat);
-		rq->current_nr_sectors++;
-		return DRIVER(drive)->error(drive, "task_out_intr", stat);
+	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
+		if ((stat & (ERR_STAT | DRQ_STAT)) ||
+		    ((stat & WRERR_STAT) && !drive->nowerr))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		if (stat & BUSY_STAT) {
+			/* Not ready yet, so wait for another IRQ. */
+			ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
+			return ide_started;
+		}
 	}
-	/*
-	 * Safe to update request for partial completions.
-	 * We have a good STATUS CHECK!!!
+
+	/* Deal with unexpected ATA data phase. */
+	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
+	    ((stat & DATA_READY) && !rq->nr_sectors))
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
+	/*
+	 * Complete previously submitted bios (if any).
+	 * Status was already verifyied.
 	 */
-	if (!rq->current_nr_sectors)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
+	while (rq->bio != rq->cbio)
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
 			return ide_stopped;
-	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
-		rq = HWGROUP(drive)->rq;
-		pBuf = task_map_rq(rq, &flags);
-		DTF("write: %p, rq->current_nr_sectors: %d\n",
-			pBuf, (int) rq->current_nr_sectors);
-		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
-		rq->errors = 0;
-		rq->current_nr_sectors--;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
 	}
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
+
+	/* Still data left to transfer. */
+	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
+
+	rq->errors = 0;
+	task_sectors(drive, rq, 1, PIO_OUT);
+
 	return ide_started;
 }

 EXPORT_SYMBOL(task_out_intr);

-#undef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-
-ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
+ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
 {
-#ifdef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-	ide_hwif_t *hwif		= HWIF(drive);
-	char *pBuf			= NULL;
-	unsigned int nsect = 0, msect	= drive->mult_count;
-        u8 stat;
-	unsigned long flags;
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
-
-	ide_task_t *args = rq->special;
 	ide_startstop_t startstop;

-#if 0
-	/*
-	 * assign private copy for multi-write
-	 */
-	memcpy(&HWGROUP(drive)->wrq, rq, sizeof(struct request));
-#endif
-
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing %s\n",
-			drive->name,
-			drive->addressing ? "MULTWRITE_EXT" : "MULTWRITE");
+			  drive->bad_wstat, WAIT_DRQ)) {
+		printk(KERN_ERR "%s: no DRQ after issuing WRITE%s\n",
+				drive->name, drive->addressing ? "_EXT" : "");
 		return startstop;
 	}
-#ifdef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-		pBuf = task_map_rq(rq, &flags);
-		DTF("Pre-Multiwrite: %p, nsect: %d, msect: %d, " \
-			"rq->current_nr_sectors: %ld\n",
-			pBuf, nsect, msect, rq->current_nr_sectors);
-		msect -= nsect;
-		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
-		rq->current_nr_sectors -= nsect;
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				if (!rq->bio) {
-					stat = hwif->INB(IDE_STATUS_REG);
-					return ide_stopped;
-				}
-		}
-	} while (msect);
-	rq->errors = 0;
-	return ide_started;
-#else /* ! ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
-	if (!(drive_is_ready(drive))) {
-		int i;
-		for (i=0; i<100; i++) {
-			if (drive_is_ready(drive))
-				break;
-		}
-	}

-	/*
-	 * WARNING :: if the drive as not acked good status we may not
-	 * move the DATA-TRANSFER T-Bar as BSY != 0. <andre@linux-ide.org>
-	 */
-	return args->handler(drive);
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
+	return task_out_intr(drive);
 }
+EXPORT_SYMBOL(pre_task_out_intr);

-EXPORT_SYMBOL(pre_task_mulout_intr);
-
-/*
- * FIXME before enabling in 2.4 ... DATA integrity issue upon error.
- */
 /*
- * Handler for command write multiple
- * Called directly from execute_drive_cmd for the first bunch of sectors,
- * afterwards only by the ISR
+ * Handler for command with PIO data-out phase (Write Multiple).
  */
 ide_startstop_t task_mulout_intr (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif		= HWIF(drive);
-	u8 stat				= hwif->INB(IDE_STATUS_REG);
-	struct request *rq		= HWGROUP(drive)->rq;
-	char *pBuf			= NULL;
-	ide_startstop_t startstop	= ide_stopped;
-	unsigned int msect		= drive->mult_count;
+	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int msect = drive->mult_count;
 	unsigned int nsect;
-	unsigned long flags;
+	u8 stat;

-	/*
-	 * (ks/hs): Handle last IRQ on multi-sector transfer,
-	 * occurs after all data was sent in this chunk
-	 */
-	if (rq->current_nr_sectors == 0) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			if (!rq->bio) {
-                                rq->current_nr_sectors += drive->mult_count;
-				/*
-				 * NOTE: could rewind beyond beginning :-/
-				 */
-			} else {
-				printk(KERN_ERR "%s: MULTI-WRITE assume all data " \
-					"transfered is bad status=0x%02x\n",
-					drive->name, stat);
-			}
-			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
+	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
+		if ((stat & (ERR_STAT | DRQ_STAT)) ||
+		    ((stat & WRERR_STAT) && !drive->nowerr))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		if (stat & BUSY_STAT) {
+			/* Not ready yet, so wait for another IRQ. */
+			ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+			return ide_started;
 		}
-		if (!rq->bio)
-			DRIVER(drive)->end_request(drive, 1, 0);
-		return startstop;
 	}
-	/*
-	 * DON'T be lazy code the above and below togather !!!
+
+	/* Deal with unexpected ATA data phase. */
+	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
+	    ((stat & DATA_READY) && !rq->nr_sectors))
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
+	/*
+	 * Complete previously submitted bios (if any).
+	 * Status was already verifyied.
 	 */
-	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			if (!rq->bio) {
-				rq->current_nr_sectors += drive->mult_count;
-				/*
-				 * NOTE: could rewind beyond beginning :-/
-				 */
-			} else {
-				printk("%s: MULTI-WRITE assume all data " \
-					"transfered is bad status=0x%02x\n",
-					drive->name, stat);
-			}
-			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
-		}
-		/* no data yet, so wait for another interrupt */
-		if (HWGROUP(drive)->handler == NULL)
-			ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-		return ide_started;
+	while (rq->bio != rq->cbio)
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
+			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
 	}

-#ifndef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-	if (HWGROUP(drive)->handler != NULL) {
-		unsigned long lflags;
-		spin_lock_irqsave(&ide_lock, lflags);
-		HWGROUP(drive)->handler = NULL;
-		del_timer(&HWGROUP(drive)->timer);
-		spin_unlock_irqrestore(&ide_lock, lflags);
-	}
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
+	/* Still data left to transfer. */
+	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);

+	rq->errors = 0;
 	do {
 		nsect = rq->current_nr_sectors;
 		if (nsect > msect)
 			nsect = msect;
-		pBuf = task_map_rq(rq, &flags);
-		DTF("Multiwrite: %p, nsect: %d, msect: %d, " \
-			"rq->current_nr_sectors: %ld\n",
-			pBuf, nsect, msect, rq->current_nr_sectors);
-		msect -= nsect;
-		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
-		rq->current_nr_sectors -= nsect;
-		/*
-		 * FIXME :: We really can not legally get a new page/bh
-		 * regardless, if this is the end of our segment.
-		 * BH walking or segment can only be updated after we
-		 * have a good  hwif->INB(IDE_STATUS_REG); return.
-		 */
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				if (!rq->bio)
-					return ide_stopped;
-		}
+
+		task_sectors(drive, rq, nsect, PIO_OUT);
+
+		if (!rq->nr_sectors)
+			msect = 0;
+		else
+			msect -= nsect;
+
 	} while (msect);
-	rq->errors = 0;
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+
 	return ide_started;
 }
-
 EXPORT_SYMBOL(task_mulout_intr);

+ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
+{
+	ide_startstop_t startstop;
+
+	if (ide_wait_stat(&startstop, drive, DATA_READY,
+			  drive->bad_wstat, WAIT_DRQ)) {
+		printk(KERN_ERR "%s: no DRQ after issuing MULTWRITE%s\n",
+				drive->name, drive->addressing ? "_EXT" : "");
+		return startstop;
+	}
+
+	return task_mulout_intr(drive);
+}
+EXPORT_SYMBOL(pre_task_mulout_intr);
+
 /* Called by internal to feature out type of command being called */
 //ide_pre_handler_t * ide_pre_handler_parser (task_struct_t *taskfile, hob_struct_t *hobfile)
 ide_pre_handler_t * ide_pre_handler_parser (struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
@@ -1092,11 +986,12 @@ int ide_diag_taskfile (ide_drive_t *driv
 	 */
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size == 0)
-			rq.current_nr_sectors = rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
-		/*	rq.hard_cur_sectors	*/
+			rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
 		else
-			rq.current_nr_sectors = rq.nr_sectors = data_size / SECTOR_SIZE;
-		/*	rq.hard_cur_sectors	*/
+			rq.nr_sectors = data_size / SECTOR_SIZE;
+
+		rq.hard_nr_sectors = rq.nr_sectors;
+		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
 	}

 	if (args->tf_out_flags.all == 0) {
diff -puN include/linux/blkdev.h~ide_tf_pio_handlers include/linux/blkdev.h
--- linux-2.5.69-bk10/include/linux/blkdev.h~ide_tf_pio_handlers	Fri May 16 00:44:50 2003
+++ linux-2.5.69-bk10-root/include/linux/blkdev.h	Fri May 16 00:46:34 2003
@@ -456,6 +456,7 @@ extern void blk_queue_invalidate_tags(re
 extern void blk_congestion_wait(int rw, long timeout);

 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
+extern void blk_rq_prep_restart(struct request *);

 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
diff -puN include/linux/ide.h~ide_tf_pio_handlers include/linux/ide.h
--- linux-2.5.69-bk10/include/linux/ide.h~ide_tf_pio_handlers	Fri May 16 00:24:01 2003
+++ linux-2.5.69-bk10-root/include/linux/ide.h	Fri May 16 00:24:01 2003
@@ -820,6 +820,26 @@ typedef struct ide_dma_ops_s {
 #define ide_rq_offset(rq) \
 	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)

+static inline void *task_map_rq(struct request *rq, unsigned long *flags)
+{
+	/*
+	 * fs request
+	 */
+	if (rq->cbio)
+		return rq_map_buffer(rq, flags);
+
+	/*
+	 * task request
+	 */
+	return rq->buffer + blk_rq_offset(rq);
+}
+
+static inline void task_unmap_rq(struct request *rq, char *buffer, unsigned long *flags)
+{
+	if (rq->cbio)
+		rq_unmap_buffer(buffer, flags);
+}
+
 /*
  * taskfiles really should use hard_cur_sectors as well!
  */

_


