Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbTC0Xwt>; Thu, 27 Mar 2003 18:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbTC0Xvy>; Thu, 27 Mar 2003 18:51:54 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39322 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261635AbTC0XqL>; Thu, 27 Mar 2003 18:46:11 -0500
Date: Fri, 28 Mar 2003 00:57:07 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] new IDE PIO handlers 4/4
In-Reply-To: <Pine.SOL.4.30.0303280056080.6453-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303280056440.6453-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Rewritten PIO handlers, both single and multiple sector sizes.
#
# They make use of new bio travelsing code and are supposed to be
# correct in respect to ATA state machine.
#
# Patch 4/4 - Remove not taskfile PIO handlers from ide-disk.c.
#	      Also remove not taskfile do_rw_disk().
#
# Now only new PIO handlers and taskfile based do_rw_disk() are used.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.66-ide-pio-2/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.66-ide-pio-2/drivers/ide/ide-disk.c	Thu Mar 27 00:07:59 2003
+++ linux/drivers/ide/ide-disk.c	Thu Mar 27 00:10:59 2003
@@ -145,427 +145,6 @@
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
@@ -767,8 +346,6 @@
 	return do_rw_taskfile(drive, &args);
 }

-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 static int do_idedisk_flushcache(ide_drive_t *drive);

 static u8 idedisk_dump_status (ide_drive_t *drive, const char *msg, u8 stat)

