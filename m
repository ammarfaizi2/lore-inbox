Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUIKAyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUIKAyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUIKAyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:54:51 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:34265 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268061AbUIKAvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:51:46 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][4/6] ide: sg PIO for fs requests
Date: Sat, 11 Sep 2004 00:26:37 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409110026.37286.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: sg PIO for fs requests

Convert CONFIG_IDE_TASKFILE_IO=n code to use
scatterlist for PIO transfers.

Fixes longstanding 'data integrity on error' issue.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk16-bzolnier/Documentation/block/biodoc.txt |    3 
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-disk.c         |  224 ++---------
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-taskfile.c     |   18 
 linux-2.6.9-rc1-bk16-bzolnier/include/linux/ide.h            |   26 -
 4 files changed, 76 insertions(+), 195 deletions(-)

diff -puN Documentation/block/biodoc.txt~ide_sg_pio Documentation/block/biodoc.txt
--- linux-2.6.9-rc1-bk16/Documentation/block/biodoc.txt~ide_sg_pio	2004-09-10 23:47:03.229550112 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/Documentation/block/biodoc.txt	2004-09-10 23:47:03.255546160 +0200
@@ -1172,8 +1172,7 @@ PIO drivers (or drivers that need to rev
 while (IDE for example)), where the CPU is doing the actual data
 transfer a virtual mapping is needed. If the driver supports highmem I/O,
 (Sec 1.1, (ii) ) it needs to use __bio_kmap_atomic and bio_kmap_irq to
-temporarily map a bio into the virtual address space. See how IDE handles
-this with ide_map_buffer.
+temporarily map a bio into the virtual address space.
 
 
 8. Prior/Related/Impacted patches
diff -puN drivers/ide/ide-disk.c~ide_sg_pio drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-disk.c~ide_sg_pio	2004-09-10 23:47:03.231549808 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-disk.c	2004-09-10 23:47:03.260545400 +0200
@@ -128,55 +128,30 @@ static int lba_capacity_is_ok (struct hd
 static ide_startstop_t read_intr (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u32 i = 0, nsect	= 0, msect = drive->mult_count;
-	struct request *rq;
-	unsigned long flags;
+	struct request *rq = hwif->hwgroup->rq;
 	u8 stat;
-	char *to;
 
 	/* new way for dealing with premature shared PCI interrupts */
 	if (!OK_STAT(stat=hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "read_intr", stat);
+			return task_error(drive, rq, __FUNCTION__, stat);
 		}
 		/* no data yet, so wait for another interrupt */
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
 		return ide_started;
 	}
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
+
+	if (drive->mult_count)
+		ide_pio_multi(drive, 0);
+	else
+		ide_pio_sector(drive, 0);
 	rq->errors = 0;
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
+	if (!hwif->nleft) {
+		ide_end_request(drive, 1, hwif->nsect);
+		return ide_stopped;
 	}
-        return ide_stopped;
+	ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
+	return ide_started;
 }
 
 /*
@@ -187,106 +162,27 @@ static ide_startstop_t write_intr (ide_d
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= hwgroup->rq;
-	u32 i = 0;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),
 			DRIVE_READY, drive->bad_wstat)) {
-		printk("%s: write_intr error1: nr_sectors=%ld, stat=0x%02x\n",
-			drive->name, rq->nr_sectors, stat);
+		printk("%s: write_intr error1: nr_sectors=%u, stat=0x%02x\n",
+			drive->name, hwif->nleft, stat);
         } else {
-#ifdef DEBUG
-		printk("%s: write: sector %ld, buffer=0x%08lx, remaining=%ld\n",
-			drive->name, rq->sector, (unsigned long) rq->buffer,
-			rq->nr_sectors-1);
-#endif
-		if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
-			rq->sector++;
+		if ((hwif->nleft == 0) ^ ((stat & DRQ_STAT) != 0)) {
 			rq->errors = 0;
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
+			if (!hwif->nleft) {
+				ide_end_request(drive, 1, hwif->nsect);
+				return ide_stopped;
 			}
-                        return ide_stopped;
+			ide_pio_sector(drive, 1);
+			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
+			return ide_started;
 		}
 		/* the original code did this here (?) */
 		return ide_stopped;
 	}
-	return DRIVER(drive)->error(drive, "write_intr", stat);
-}
-
-/*
- * ide_multwrite() transfers a block of up to mcount sectors of data
- * to a drive as part of a disk multiple-sector write operation.
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
-static void ide_multwrite(ide_drive_t *drive, unsigned int mcount)
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
-				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-				bio = bio->bi_next;
-			}
-
-			/* end early early we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->nr_cbio_segments = bio_segments(bio);
-				rq->current_nr_sectors = bio_cur_sectors(bio);
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
+	return task_error(drive, rq, __FUNCTION__, stat);
 }
 
 /*
@@ -294,42 +190,29 @@ static void ide_multwrite(ide_drive_t *d
  */
 static ide_startstop_t multwrite_intr (ide_drive_t *drive)
 {
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= &hwgroup->wrq;
-	struct bio *bio		= rq->bio;
+	struct request *rq = hwif->hwgroup->rq;
 	u8 stat;
 
 	stat = hwif->INB(IDE_STATUS_REG);
 	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
 		if (stat & DRQ_STAT) {
-			/*
-			 *	The drive wants data. Remember rq is the copy
-			 *	of the request
-			 */
-			if (rq->nr_sectors) {
-				ide_multwrite(drive, drive->mult_count);
+			/* The drive wants data. */
+			if (hwif->nleft) {
+				ide_pio_multi(drive, 1);
 				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 				return ide_started;
 			}
 		} else {
-			/*
-			 *	If the copy has all the blocks completed then
-			 *	we can end the original request.
-			 */
-			if (!rq->nr_sectors) {	/* all done? */
-				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-				rq = hwgroup->rq;
-				ide_end_request(drive, 1, rq->nr_sectors);
+			if (!hwif->nleft) {	/* all done? */
+				ide_end_request(drive, 1, hwif->nsect);
 				return ide_stopped;
 			}
 		}
-		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
 		/* the original code did this here (?) */
 		return ide_stopped;
 	}
-	bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
-	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
+	return task_error(drive, rq, __FUNCTION__, stat);
 }
 
 /*
@@ -352,6 +235,9 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 			dma = 0;
 	}
 
+	if (!dma)
+		ide_init_sg_cmd(drive, rq);
+
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 
@@ -419,24 +305,40 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
 	}
 
+	if (dma) {
+		if (rq_data_dir(rq)) {
+			if (!hwif->ide_dma_write(drive))
+				return ide_started;
+		} else {
+			if (!hwif->ide_dma_read(drive))
+				return ide_started;
+		}
+		ide_init_sg_cmd(drive, rq);
+	}
+
 	if (rq_data_dir(rq) == READ) {
-		if (dma && !hwif->ide_dma_read(drive))
-			return ide_started;
 
-		command = ((drive->mult_count) ?
-			   ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
-			   ((lba48) ? WIN_READ_EXT : WIN_READ));
+		if (drive->mult_count) {
+			hwif->data_phase = TASKFILE_MULTI_IN;
+			command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
+		} else {
+			hwif->data_phase = TASKFILE_IN;
+			command = lba48 ? WIN_READ_EXT : WIN_READ;
+		}
+
 		ide_execute_command(drive, command, &read_intr, WAIT_CMD, NULL);
 		return ide_started;
 	} else {
 		ide_startstop_t startstop;
 
-		if (dma && !hwif->ide_dma_write(drive))
-			return ide_started;
+		if (drive->mult_count) {
+			hwif->data_phase = TASKFILE_MULTI_OUT;
+			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+		} else {
+			hwif->data_phase = TASKFILE_OUT;
+			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
+		}
 
-		command = ((drive->mult_count) ?
-			   ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
-			   ((lba48) ? WIN_WRITE_EXT : WIN_WRITE));
 		hwif->OUTB(command, IDE_COMMAND_REG);
 
 		if (ide_wait_stat(&startstop, drive, DATA_READY,
@@ -449,17 +351,11 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		if (!drive->unmask)
 			local_irq_disable();
 		if (drive->mult_count) {
-			ide_hwgroup_t *hwgroup = HWGROUP(drive);
-
-			hwgroup->wrq = *rq; /* scratchpad */
 			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-			ide_multwrite(drive, drive->mult_count);
+			ide_pio_multi(drive, 1);
 		} else {
-			unsigned long flags;
-			char *to = ide_map_buffer(rq, &flags);
 			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-			taskfile_output_data(drive, to, SECTOR_WORDS);
-			ide_unmap_buffer(rq, to, &flags);
+			ide_pio_sector(drive, 1);
 		}
 		return ide_started;
 	}
diff -puN drivers/ide/ide-taskfile.c~ide_sg_pio drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-taskfile.c~ide_sg_pio	2004-09-10 23:47:03.235549200 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-taskfile.c	2004-09-10 23:47:55.460609784 +0200
@@ -301,7 +301,7 @@ static u8 wait_drive_not_busy(ide_drive_
 	return stat;
 }
 
-static void ide_pio_sector(ide_drive_t *drive, unsigned int write)
+void ide_pio_sector(ide_drive_t *drive, unsigned int write)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
@@ -338,7 +338,9 @@ static void ide_pio_sector(ide_drive_t *
 #endif
 }
 
-static void ide_pio_multi(ide_drive_t *drive, unsigned int write)
+EXPORT_SYMBOL_GPL(ide_pio_sector);
+
+void ide_pio_multi(ide_drive_t *drive, unsigned int write)
 {
 	unsigned int nsect;
 
@@ -347,6 +349,8 @@ static void ide_pio_multi(ide_drive_t *d
 		ide_pio_sector(drive, write);
 }
 
+EXPORT_SYMBOL_GPL(ide_pio_multi);
+
 static inline void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
@@ -364,9 +368,8 @@ static inline void ide_pio_datablock(ide
 	}
 }
 
-#ifdef CONFIG_IDE_TASKFILE_IO
-static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
-				  const char *s, u8 stat)
+ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
+			   const char *s, u8 stat)
 {
 	if (rq->bio) {
 		ide_hwif_t *hwif = drive->hwif;
@@ -395,9 +398,8 @@ static ide_startstop_t task_error(ide_dr
 	}
 	return drive->driver->error(drive, s, stat);
 }
-#else
-# define task_error(d, rq, s, stat) drive->driver->error(d, s, stat)
-#endif
+
+EXPORT_SYMBOL_GPL(task_error);
 
 static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
diff -puN include/linux/ide.h~ide_sg_pio include/linux/ide.h
--- linux-2.6.9-rc1-bk16/include/linux/ide.h~ide_sg_pio	2004-09-10 23:47:03.237548896 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/include/linux/ide.h	2004-09-10 23:48:31.686102672 +0200
@@ -796,27 +796,6 @@ typedef struct ide_drive_s {
 	struct gendisk *disk;
 } ide_drive_t;
 
-/*
- * mapping stuff, prepare for highmem...
- * 
- * temporarily mapping a (possible) highmem bio for PIO transfer
- */
-#ifndef CONFIG_IDE_TASKFILE_IO
-
-#define ide_rq_offset(rq) \
-	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
-
-static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
-{
-	return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
-}
-
-static inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
-{
-	bio_kunmap_irq(buffer, flags);
-}
-#endif /* !CONFIG_IDE_TASKFILE_IO */
-
 #define IDE_CHIPSET_PCI_MASK	\
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
@@ -1382,6 +1361,11 @@ extern void atapi_output_bytes(ide_drive
 extern void taskfile_input_data(ide_drive_t *, void *, u32);
 extern void taskfile_output_data(ide_drive_t *, void *, u32);
 
+extern void ide_pio_sector(ide_drive_t *, unsigned int);
+extern void ide_pio_multi(ide_drive_t *, unsigned int);
+
+extern ide_startstop_t task_error(ide_drive_t *, struct request *, const char *, u8);
+
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 
_
