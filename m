Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTFHAK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTFHAK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:10:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30412 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264067AbTFHAJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:09:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] switch ide to taskfile IO
Date: Sun, 8 Jun 2003 02:22:45 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306080222.45852.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
please apply.
--
Bartlomiej

[ide] switch ide to taskfile IO

- rewrite taskfile PIO handlers
  (they now comply with ide state machine and use bio walking)
- switch ide-disk.c to use *only* taskfile IO
- swicth pdc4030.c to use *only* taskfile IO (untested)
- remove old cruft (>600 lines)

 drivers/ide/Kconfig          |    6 
 drivers/ide/ide-disk.c       |  422 ----------------------------------
 drivers/ide/ide-taskfile.c   |  521 ++++++++++++++++---------------------------
 drivers/ide/legacy/pdc4030.c |  220 ++++--------------
 include/linux/blkdev.h       |    1 
 include/linux/ide.h          |   47 ++-
 6 files changed, 290 insertions(+), 927 deletions(-)

diff -puN drivers/ide/Kconfig~ide-taskfile-io-switch drivers/ide/Kconfig
--- linux-2.5.70-bk11/drivers/ide/Kconfig~ide-taskfile-io-switch	Sat Jun  7 22:33:38 2003
+++ linux-2.5.70-bk11-root/drivers/ide/Kconfig	Sat Jun  7 22:33:38 2003
@@ -219,7 +219,6 @@ config IDE_TASK_IOCTL
 
 	  If you are unsure, say N here.
 
-#bool '  IDE Taskfile IO' CONFIG_IDE_TASKFILE_IO
 comment "IDE chipset support/bugfixes"
 	depends on BLK_DEV_IDE
 
@@ -1071,11 +1070,6 @@ config BLK_DEV_PDC202XX
 
 	  If unsure, say N.
 
-##if [ "$CONFIG_IDE_TASKFILE_IO" = "y" ]; then
-##  dep_mbool CONFIG_BLK_DEV_TF_DISK $CONFIG_BLK_DEV_IDEDISK
-##else
-##  dep_mbool CONFIG_BLK_DEV_NTF_DISK $CONFIG_BLK_DEV_IDEDISK
-##fi
 config BLK_DEV_IDE_MODES
 	bool
 	depends on BLK_DEV_4DRIVES || BLK_DEV_ALI14XX || BLK_DEV_DTC2278 || BLK_DEV_HT6560B || BLK_DEV_PDC4030 || BLK_DEV_QD65XX || BLK_DEV_UMC8672 || BLK_DEV_AEC62XX=y || BLK_DEV_ALI15X3=y || BLK_DEV_AMD74XX=y || BLK_DEV_CMD640 || BLK_DEV_CMD64X=y || BLK_DEV_CS5530=y || BLK_DEV_CY82C693=y || BLK_DEV_HPT34X=y || BLK_DEV_HPT366=y || BLK_DEV_IDE_PMAC || BLK_DEV_IT8172 || BLK_DEV_MPC8xx_IDE || BLK_DEV_NFORCE=y || BLK_DEV_OPTI621=y || BLK_DEV_PDC202XX || BLK_DEV_PIIX=y || BLK_DEV_SVWKS=y || BLK_DEV_SIIMAGE=y || BLK_DEV_SIS5513=y || BLK_DEV_SL82C105=y || BLK_DEV_SLC90E66=y || BLK_DEV_VIA82CXXX=y
diff -puN drivers/ide/ide-disk.c~ide-taskfile-io-switch drivers/ide/ide-disk.c
--- linux-2.5.70-bk11/drivers/ide/ide-disk.c~ide-taskfile-io-switch	Sat Jun  7 22:33:38 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-disk.c	Sat Jun  7 22:33:38 2003
@@ -136,423 +136,6 @@ static int idedisk_start_tag(ide_drive_t
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
- * Note that we may be called from two contexts - __ide_do_rw_disk() context
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
- * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
- * using LBA if supported, or CHS otherwise, to address sectors.
- * It also takes care of issuing special DRIVE_CMDs.
- */
-ide_startstop_t __ide_do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
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
-	blk_dump_rq_flags(rq, "__ide_do_rw_disk - bad command");
-	ide_end_request(drive, 0, 0);
-	return ide_stopped;
-}
-EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
-
-#else /* CONFIG_IDE_TASKFILE_IO */
-
 static ide_startstop_t chs_rw_disk(ide_drive_t *, struct request *, unsigned long);
 static ide_startstop_t lba_28_rw_disk(ide_drive_t *, struct request *, unsigned long);
 static ide_startstop_t lba_48_rw_disk(ide_drive_t *, struct request *, unsigned long long);
@@ -750,8 +333,6 @@ static ide_startstop_t lba_48_rw_disk (i
 	return do_rw_taskfile(drive, &args);
 }
 
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 static ide_startstop_t ide_do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -866,6 +447,9 @@ ide_startstop_t idedisk_error (ide_drive
 		return ide_stopped;
 	}
 #endif
+	/* make rq completion pointers new submission pointers */
+	blk_rq_prep_restart(rq);
+
 	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
 		/* other bits are useless when BUSY */
 		rq->errors |= ERROR_RESET;
diff -puN drivers/ide/ide-taskfile.c~ide-taskfile-io-switch drivers/ide/ide-taskfile.c
--- linux-2.5.70-bk11/drivers/ide/ide-taskfile.c~ide-taskfile-io-switch	Sat Jun  7 22:33:38 2003
+++ linux-2.5.70-bk11-root/drivers/ide/ide-taskfile.c	Sat Jun  7 23:32:57 2003
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
 
@@ -351,404 +352,271 @@ ide_startstop_t task_no_data_intr (ide_d
 
 EXPORT_SYMBOL(task_no_data_intr);
 
+static u8 wait_drive_not_busy(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	int retries = 5;
+	u8 stat;
+	/*
+	 * (ks) Last sector was transfered, wait until drive is ready.
+	 * This can take up to 10 usec. We willl wait max 50 us.
+	 */
+	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
+		udelay(10);
+	return stat;
+}
+
 /*
- * Handler for command with PIO data-in phase, READ
- */
-/*
- * FIXME before 2.4 enable ...
- *	DATA integrity issue upon error. <andre@linux-ide.org>
+ * Handler for command with PIO data-in phase (Read).
  */
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
-	struct request *rq	= HWGROUP(drive)->rq;
-	ide_hwif_t *hwif	= HWIF(drive);
-	char *pBuf		= NULL;
-	u8 stat;
-	unsigned long flags;
+	struct request *rq = HWGROUP(drive)->rq;
+	u8 stat, good_stat;
 
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
+	good_stat = DATA_READY;
+	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+check_status:
+	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
+		if (stat & (ERR_STAT | DRQ_STAT))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		/* BUSY_STAT: No data yet, so wait for another IRQ. */
+		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+		return ide_started;
 	}
-#if 0
 
 	/*
-	 * Holding point for a brain dump of a thought :-/
+	 * Complete previously submitted bios (if any).
+	 * Status was already verifyied.
 	 */
-
-	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat)) {
-		DTF("%s: READ attempting to recover last " \
-			"sector counter status=0x%02x\n",
-			drive->name, stat);
-		rq->current_nr_sectors++;
-		return DRIVER(drive)->error(drive, "task_in_intr", stat);
-        }
-	if (!rq->current_nr_sectors)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
+	while (rq->bio != rq->cbio)
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
 			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}
 
-	if (--rq->current_nr_sectors <= 0)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
-#endif
+	rq->errors = 0;
+	task_sectors(drive, rq, 1, IDE_PIO_IN);
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
 
-	pBuf = task_map_rq(rq, &flags);
-	DTF("Read: %p, rq->current_nr_sectors: %d, stat: %02x\n",
-		pBuf, (int) rq->current_nr_sectors, stat);
-	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
-	task_unmap_rq(rq, pBuf, &flags);
-	/*
-	 * FIXME :: We really can not legally get a new page/bh
-	 * regardless, if this is the end of our segment.
-	 * BH walking or segment can only be updated after we have a good
-	 * hwif->INB(IDE_STATUS_REG); return.
-	 */
-	if (--rq->current_nr_sectors <= 0)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
-	/*
-	 * ERM, it is techincally legal to leave/exit here but it makes
-	 * a mess of the code ...
-	 */
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
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
+		task_sectors(drive, rq, nsect, IDE_PIO_IN);
 
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
+	task_sectors(drive, rq, 1, IDE_PIO_OUT);
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
-
-	/*
-	 * WARNING :: if the drive as not acked good status we may not
-	 * move the DATA-TRANSFER T-Bar as BSY != 0. <andre@linux-ide.org>
-	 */
-	return args->handler(drive);
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
+	return task_out_intr(drive);
 }
-
-EXPORT_SYMBOL(pre_task_mulout_intr);
+EXPORT_SYMBOL(pre_task_out_intr);
 
 /*
- * FIXME before enabling in 2.4 ... DATA integrity issue upon error.
- */
-/*
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
+		task_sectors(drive, rq, nsect, IDE_PIO_OUT);
+
+		if (!rq->nr_sectors)
+			msect = 0;
+		else
+			msect -= nsect;
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
@@ -1092,11 +960,12 @@ int ide_diag_taskfile (ide_drive_t *driv
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
diff -puN drivers/ide/legacy/pdc4030.c~ide-taskfile-io-switch drivers/ide/legacy/pdc4030.c
--- linux-2.5.70-bk11/drivers/ide/legacy/pdc4030.c~ide-taskfile-io-switch	Sat Jun  7 22:33:38 2003
+++ linux-2.5.70-bk11-root/drivers/ide/legacy/pdc4030.c	Sun Jun  8 00:54:43 2003
@@ -94,7 +94,7 @@
 
 #include "pdc4030.h"
 
-static ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block);
+static ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block);
 
 /*
  * promise_selectproc() is invoked by ide.c
@@ -408,67 +408,44 @@ module_exit(pdc4030_mod_exit);
  */
 static ide_startstop_t promise_read_intr (ide_drive_t *drive)
 {
-	int total_remaining;
 	unsigned int sectors_left, sectors_avail, nsect;
-	struct request *rq;
+	struct request *rq = HWGROUP(drive)->rq;
 	ata_status_t status;
-#ifdef CONFIG_IDE_TASKFILE_IO
-	unsigned long flags;
-	char *to;
-#endif /* CONFIG_IDE_TASKFILE_IO */
 
 	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (!OK_STAT(status.all, DATA_READY, BAD_R_STAT))
-		return DRIVER(drive)->error(drive,
-			"promise_read_intr", status.all);
+		return DRIVER(drive)->error(drive, __FUNCTION__, status.all);
 
 read_again:
 	do {
 		sectors_left = HWIF(drive)->INB(IDE_NSECTOR_REG);
 		HWIF(drive)->INB(IDE_SECTOR_REG);
 	} while (HWIF(drive)->INB(IDE_NSECTOR_REG) != sectors_left);
-	rq = HWGROUP(drive)->rq;
 	sectors_avail = rq->nr_sectors - sectors_left;
 	if (!sectors_avail)
 		goto read_again;
 
 read_next:
-	rq = HWGROUP(drive)->rq;
 	nsect = rq->current_nr_sectors;
 	if (nsect > sectors_avail)
 		nsect = sectors_avail;
 	sectors_avail -= nsect;
-#ifdef CONFIG_IDE_TASKFILE_IO
-	to = ide_map_buffer(rq, &flags);
-	HWIF(drive)->ata_input_data(drive, to, nsect * SECTOR_WORDS);
-#else /* !CONFIG_IDE_TASKFILE_IO */
-	HWIF(drive)->ata_input_data(drive, rq->buffer, nsect * SECTOR_WORDS);
-#endif /* CONFIG_IDE_TASKFILE_IO */
 
 #ifdef DEBUG_READ
-	printk(KERN_DEBUG "%s:  promise_read: sectors(%ld-%ld), "
-	       "buf=0x%08lx, rem=%ld\n", drive->name, (long)rq->sector,
-	       (long)rq->sector+nsect-1,
-#ifdef CONFIG_IDE_TASKFILE_IO
-		(unsigned long) to,
-#else /* !CONFIG_IDE_TASKFILE_IO */
-		(unsigned long) rq->buffer,
-#endif /* CONFIG_IDE_TASKFILE_IO */
-	       rq->nr_sectors-nsect);
+	printk(KERN_DEBUG "%s: %s: sectors(%lu-%lu), rem=%lu\n",
+			  drive->name, __FUNCTION__,
+			  (unsigned long)rq->sector,
+			  (unsigned long)rq->sector + nsect - 1,
+			  (unsigned long)rq->nr_sectors - nsect);
 #endif /* DEBUG_READ */
 
-#ifdef CONFIG_IDE_TASKFILE_IO
-	ide_unmap_buffer(to, &flags);
-#else /* !CONFIG_IDE_TASKFILE_IO */
-	rq->buffer += nsect<<9;
-#endif /* CONFIG_IDE_TASKFILE_IO */
-	rq->sector += nsect;
-	rq->errors = 0;
-	rq->nr_sectors -= nsect;
-	total_remaining = rq->nr_sectors;
-	if ((rq->current_nr_sectors -= nsect) <= 0) {
-		DRIVER(drive)->end_request(drive, 1, 0);
-	}
+	task_sectors(drive, rq, nsect, IDE_PIO_IN);
+
+	/* FIXME: can we check status after transfer on pdc4030? */
+	/* Complete previously submitted bios. */
+	while (rq->bio != rq->cbio)
+		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
+			return ide_stopped;
 /*
  * Now the data has been read in, do the following:
  * 
@@ -480,7 +457,7 @@ read_next:
  *   else if BUSY is asserted, we are going to get an interrupt, so
  *     set the handler for the interrupt and just return
  */
-	if (total_remaining > 0) {
+	if (rq->nr_sectors > 0) {
 		if (sectors_avail)
 			goto read_next;
 		status.all = HWIF(drive)->INB(IDE_STATUS_REG);
@@ -519,7 +496,6 @@ static ide_startstop_t promise_complete_
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	struct request *rq = hwgroup->rq;
-	int i;
 
 	if ((HWIF(drive)->INB(IDE_STATUS_REG)) & BUSY_STAT) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
@@ -542,85 +518,35 @@ static ide_startstop_t promise_complete_
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Write complete - end_request\n", drive->name);
 #endif /* DEBUG_WRITE */
-	for (i = rq->nr_sectors; i > 0; ) {
-		i -= rq->current_nr_sectors;
-		DRIVER(drive)->end_request(drive, 1, 0);
-	}
+
+	/* Complete previously submitted bios. */
+	while (rq->bio != rq->cbio)
+		(void) DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio));
 	return ide_stopped;
 }
 
 /*
  * promise_multwrite() transfers a block of up to mcount sectors of data
  * to a drive as part of a disk multiple-sector write operation.
- *
- * Returns 0 on success.
- *
- * Note that we may be called from two contexts - the do_rw_disk context
- * and IRQ context. The IRQ can happen any time after we've output the
- * full "mcount" number of sectors, so we must make sure we update the
- * state _before_ we output the final part of the data!
  */
-int promise_multwrite (ide_drive_t *drive, unsigned int mcount)
+static void promise_multwrite (ide_drive_t *drive, unsigned int msect)
 {
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	struct request *rq	= &hwgroup->wrq;
+	struct request* rq = HWGROUP(drive)->rq;
+	unsigned int nsect;
 
+	rq->errors = 0;
 	do {
-		char *buffer;
-		int nsect = rq->current_nr_sectors;
-#ifdef CONFIG_IDE_TASKFILE_IO
-		unsigned long flags;
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
-		if (nsect > mcount)
-			nsect = mcount;
-		mcount -= nsect;
-#ifdef CONFIG_IDE_TASKFILE_IO
-		buffer = ide_map_buffer(rq, &flags);
-		rq->sector += nsect;
-#else /* !CONFIG_IDE_TASKFILE_IO */
-		buffer = rq->buffer;
-
-		rq->sector += nsect;
-		rq->buffer += nsect << 9;
-#endif /* CONFIG_IDE_TASKFILE_IO */
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
-#ifdef CONFIG_IDE_TASKFILE_IO
-		ide_unmap_buffer(buffer, &flags);
-#endif /* CONFIG_IDE_TASKFILE_IO */
-	} while (mcount);
-
-	return 0;
+		nsect = rq->current_nr_sectors;
+		if (nsect > msect)
+			nsect = msect;
+
+		task_sectors(drive, rq, nsect, IDE_PIO_OUT);
+
+		if (!rq->nr_sectors)
+			msect = 0;
+		else
+			msect -= nsect;
+	} while (msect);
 }
 
 /*
@@ -629,6 +555,7 @@ int promise_multwrite (ide_drive_t *driv
 static ide_startstop_t promise_write_pollfunc (ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct request *rq = hwgroup->rq;
 
 	if (HWIF(drive)->INB(IDE_NSECTOR_REG) != 0) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
@@ -646,6 +573,10 @@ static ide_startstop_t promise_write_pol
 				HWIF(drive)->INB(IDE_STATUS_REG));
 	}
 
+	/* Complete previously submitted bios. */
+	while (rq->bio != rq->cbio)
+		(void) DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio));
+
 	/*
 	 * Now write out last 4 sectors and poll for not BUSY
 	 */
@@ -671,12 +602,13 @@ static ide_startstop_t promise_write_pol
 static ide_startstop_t promise_write (ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	struct request *rq = &hwgroup->wrq;
+	struct request *rq = hwgroup->rq;
 
 #ifdef DEBUG_WRITE
-	printk(KERN_DEBUG "%s: promise_write: sectors(%ld-%ld), "
-	       "buffer=%p\n", drive->name, (long)rq->sector,
-	       (long)rq->sector + rq->nr_sectors - 1, rq->buffer);
+	printk(KERN_DEBUG "%s: %s: sectors(%lu-%lu)\n",
+			  drive->name, __FUNCTION__,
+			  (unsigned long)rq->sector,
+			  (unsigned long)rq->sector + rq->nr_sectors - 1);
 #endif /* DEBUG_WRITE */
 
 	/*
@@ -684,8 +616,7 @@ static ide_startstop_t promise_write (id
 	 * the polling strategy as defined above.
 	 */
 	if (rq->nr_sectors > 4) {
-		if (promise_multwrite(drive, rq->nr_sectors - 4))
-			return ide_stopped;
+		promise_multwrite(drive, rq->nr_sectors - 4);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 		if (hwgroup->handler != NULL)	/* paranoia check */
 			BUG();
@@ -696,8 +627,7 @@ static ide_startstop_t promise_write (id
 	 * There are 4 or fewer sectors to transfer, do them all in one go
 	 * and wait for NOT BUSY.
 	 */
-		if (promise_multwrite(drive, rq->nr_sectors))
-			return ide_stopped;
+		promise_multwrite(drive, rq->nr_sectors);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 		if (hwgroup->handler != NULL)
 			BUG();
@@ -720,26 +650,14 @@ static ide_startstop_t promise_write (id
  * already set up. It issues a READ or WRITE command to the Promise
  * controller, assuming LBA has been used to set up the block number.
  */
-#ifndef CONFIG_IDE_TASKFILE_IO
-ide_startstop_t do_pdc4030_io (ide_drive_t *drive, struct request *rq)
-{
-#else /* CONFIG_IDE_TASKFILE_IO */
-ide_startstop_t do_pdc4030_io (ide_drive_t *drive, ide_task_t *task)
+static ide_startstop_t do_pdc4030_io (ide_drive_t *drive, ide_task_t *task)
 {
 	struct request *rq	= HWGROUP(drive)->rq;
 	task_struct_t *taskfile = (task_struct_t *) task->tfRegister;
-#endif /* CONFIG_IDE_TASKFILE_IO */
 	ide_startstop_t startstop;
 	unsigned long timeout;
 	u8 stat = 0;
 
-	if (!blk_fs_request(rq)) {
-		blk_dump_rq_flags(rq, "do_pdc4030_io - bad command");
-		DRIVER(drive)->end_request(drive, 0, 0);
-		return ide_stopped;
-	}
-
-#ifdef CONFIG_IDE_TASKFILE_IO
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
 	SELECT_MASK(drive, 0);
@@ -752,12 +670,8 @@ ide_startstop_t do_pdc4030_io (ide_drive
 	HWIF(drive)->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
 	HWIF(drive)->OUTB(taskfile->device_head, IDE_SELECT_REG);
 	HWIF(drive)->OUTB(taskfile->command, IDE_COMMAND_REG);
-#endif /* CONFIG_IDE_TASKFILE_IO */
 
 	if (rq_data_dir(rq) == READ) {
-#ifndef CONFIG_IDE_TASKFILE_IO
-		HWIF(drive)->OUTB(PROMISE_READ, IDE_COMMAND_REG);
-#endif /* CONFIG_IDE_TASKFILE_IO */
 /*
  * The card's behaviour is odd at this point. If the data is
  * available, DRQ will be true, and no interrupt will be
@@ -793,9 +707,6 @@ ide_startstop_t do_pdc4030_io (ide_drive
 				"waiting - Odd!\n", drive->name);
 		return ide_stopped;
 	} else {
-#ifndef CONFIG_IDE_TASKFILE_IO
-		HWIF(drive)->OUTB(PROMISE_WRITE, IDE_COMMAND_REG);
-#endif /* CONFIG_IDE_TASKFILE_IO */
 		if (ide_wait_stat(&startstop, drive, DATA_READY,
 				drive->bad_wstat, WAIT_DRQ)) {
 			printk(KERN_ERR "%s: no DRQ after issuing "
@@ -804,12 +715,11 @@ ide_startstop_t do_pdc4030_io (ide_drive
 	    	}
 		if (!drive->unmask)
 			local_irq_disable();
-		HWGROUP(drive)->wrq = *rq; /* scratchpad */
 		return promise_write(drive);
 	}
 }
 
-static ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t promise_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	/* The four drives on the two logical (one physical) interfaces
 	   are distinguished by writing the drive number (0-3) to the
@@ -817,33 +727,22 @@ static ide_startstop_t promise_rw_disk (
 	   FIXME: Is promise_selectproc now redundant??
 	*/
 	int drive_number = (HWIF(drive)->channel << 1) + drive->select.b.unit;
-#ifndef CONFIG_IDE_TASKFILE_IO
-	ide_hwif_t *hwif = HWIF(drive);
+	struct hd_drive_task_hdr taskfile;
+	ide_task_t args;
 
 	BUG_ON(rq->nr_sectors > 127);
 
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	if (!blk_fs_request(rq)) {
+		blk_dump_rq_flags(rq, "promise_rw_disk - bad command");
+		DRIVER(drive)->end_request(drive, 0, 0);
+		return ide_stopped;
+	}
 
 #ifdef DEBUG
-	printk("%s: %sing: LBAsect=%ld, sectors=%ld, "
-		"buffer=0x%08lx\n", drive->name,
-		(rq->cmd==READ)?"read":"writ", block,
-		rq->nr_sectors, (unsigned long) rq->buffer);
+	printk(KERN_DEBUG "%s: %sing: LBAsect=%lu, sectors=%lu\n",
+			  drive->name, rq_data_dir(rq) ? "writ" : "read",
+			  block, rq->nr_sectors);
 #endif
-	hwif->OUTB(drive_number, IDE_FEATURE_REG);
-	hwif->OUTB(rq->nr_sectors, IDE_NSECTOR_REG);
-	hwif->OUTB(block,IDE_SECTOR_REG);
-	hwif->OUTB(block>>=8,IDE_LCYL_REG);
-	hwif->OUTB(block>>=8,IDE_HCYL_REG);
-	hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
-
-	return do_pdc4030_io(drive, rq);
-
-#else /* CONFIG_IDE_TASKFILE_IO */
-
-	struct hd_drive_task_hdr	taskfile;
-	ide_task_t			args;
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 
@@ -867,5 +766,4 @@ static ide_startstop_t promise_rw_disk (
 	rq->special		= (ide_task_t *)&args;
 
 	return do_pdc4030_io(drive, &args);
-#endif /* CONFIG_IDE_TASKFILE_IO */
 }
diff -puN include/linux/blkdev.h~ide-taskfile-io-switch include/linux/blkdev.h
--- linux-2.5.70-bk11/include/linux/blkdev.h~ide-taskfile-io-switch	Sat Jun  7 22:33:38 2003
+++ linux-2.5.70-bk11-root/include/linux/blkdev.h	Sat Jun  7 22:33:38 2003
@@ -457,6 +457,7 @@ extern void blk_queue_invalidate_tags(re
 extern void blk_congestion_wait(int rw, long timeout);
 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
+extern void blk_rq_prep_restart(struct request *);
 
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
diff -puN include/linux/ide.h~ide-taskfile-io-switch include/linux/ide.h
--- linux-2.5.70-bk11/include/linux/ide.h~ide-taskfile-io-switch	Sat Jun  7 22:33:38 2003
+++ linux-2.5.70-bk11-root/include/linux/ide.h	Sun Jun  8 01:58:54 2003
@@ -817,33 +817,25 @@ typedef struct ide_dma_ops_s {
  * 
  * temporarily mapping a (possible) highmem bio for PIO transfer
  */
-#define ide_rq_offset(rq) \
-	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
-/*
- * taskfiles really should use hard_cur_sectors as well!
- */
-#define task_rq_offset(rq) \
-	(((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE)
-
-static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
+static inline void *task_map_rq(struct request *rq, unsigned long *flags)
 {
 	/*
 	 * fs request
 	 */
-	if (rq->bio)
-		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
+	if (rq->cbio)
+		return rq_map_buffer(rq, flags);
 
 	/*
 	 * task request
 	 */
-	return rq->buffer + task_rq_offset(rq);
+	return rq->buffer + blk_rq_offset(rq);
 }
 
-static inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
+static inline void task_unmap_rq(struct request *rq, char *buffer, unsigned long *flags)
 {
-	if (rq->bio)
-		bio_kunmap_irq(buffer, flags);
+	if (rq->cbio)
+		rq_unmap_buffer(buffer, flags);
 }
 
 #define IDE_CHIPSET_PCI_MASK	\
@@ -1418,6 +1410,31 @@ extern void atapi_output_bytes(ide_drive
 extern void taskfile_input_data(ide_drive_t *, void *, u32);
 extern void taskfile_output_data(ide_drive_t *, void *, u32);
 
+#define IDE_PIO_IN	0
+#define IDE_PIO_OUT	1
+
+static inline void task_sectors(ide_drive_t *drive, struct request *rq,
+				unsigned nsect, int rw)
+{
+	unsigned long flags;
+	char *buf;
+
+	buf = task_map_rq(rq, &flags);
+
+	/*
+	 * IRQ can happen instantly after reading/writing
+	 * last sector of the datablock.
+	 */
+	process_that_request_first(rq, nsect);
+
+	if (rw == IDE_PIO_OUT)
+		taskfile_output_data(drive, buf, nsect * SECTOR_WORDS);
+	else
+		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);
+
+	task_unmap_rq(rq, buf, &flags);
+}
+
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 

_

