Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSFYRXs>; Tue, 25 Jun 2002 13:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFYRXr>; Tue, 25 Jun 2002 13:23:47 -0400
Received: from web30.achilles.net ([209.151.1.2]:3734 "EHLO web30.achilles.net")
	by vger.kernel.org with ESMTP id <S315717AbSFYRXb>;
	Tue, 25 Jun 2002 13:23:31 -0400
Message-ID: <3D18A024.5000301@evision-ventures.com>
Date: Tue, 25 Jun 2002 18:53:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.24  IDE 94
References: <Pine.LNX.4.33.0206201614450.1316-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040007070507040603080003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040007070507040603080003
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable

Fri Jun 21 02:23:13 CEST 2002 ide-clean-94

- Synchronize with 2.5.24

- Integrate work on ATAPI unification by Bart=B3omiej:

generic ATAPI hit #1 against 2.5.22:

	- move generic ATAPI structs from ide/ide-floppy.c
	  and ide/ide-tape.c to include/atapi.h
	  (this has a nice side effect of making ide-tape
	   a bit more endianness aware)

	- remove IDEFLOPPY_MIN/MAX() macros, use generic ones


- Unify ioctl handling with generic ide_raw_taskfile().

- Extend the scope of IDE_DMA bit setting in udma_init() and udma_stop() =
to be
   a more encompassing. This should solve the "DMA in progress" problems.=


--------------040007070507040603080003
Content-Type: text/plain;
 name="ide-clean-94.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-94.diff"

diff -urN linux-2.5.24/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.24/drivers/ide/ide.c	2002-06-21 00:53:57.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-24 20:41:39.000000000 +0200
@@ -563,7 +563,7 @@
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_count = drive->sect;
 		args.cmd = WIN_RESTORE;
-		ide_raw_taskfile(drive, &args);
+		ide_raw_taskfile(drive, &args, NULL);
 		printk(KERN_INFO "%s: done!\n", drive->name);
 	}
 
@@ -834,86 +834,6 @@
 	return NULL;
 }
 
-
-/*
- * Feed commands to a drive until it barfs.  Called with queue lock held and
- * busy channel.
- */
-static void queue_commands(struct ata_device *drive)
-{
-	struct ata_channel *ch = drive->channel;
-	ide_startstop_t startstop = -1;
-
-	for (;;) {
-		struct request *rq = NULL;
-
-		if (!test_bit(IDE_BUSY, ch->active))
-			printk(KERN_ERR "%s: error: not busy while queueing!\n", drive->name);
-
-		/* Abort early if we can't queue another command. for non
-		 * tcq, ata_can_queue is always 1 since we never get here
-		 * unless the drive is idle.
-		 */
-		if (!ata_can_queue(drive)) {
-			if (!ata_pending_commands(drive))
-				clear_bit(IDE_BUSY, ch->active);
-			break;
-		}
-
-		drive->sleep = 0;
-
-		if (test_bit(IDE_DMA, ch->active)) {
-			printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
-			break;
-		}
-
-		/* There's a small window between where the queue could be
-		 * replugged while we are in here when using tcq (in which
-		 * case the queue is probably empty anyways...), so check
-		 * and leave if appropriate. When not using tcq, this is
-		 * still a severe BUG!
-		 */
-		if (blk_queue_plugged(&drive->queue)) {
-			BUG_ON(!drive->using_tcq);
-			break;
-		}
-
-		if (!(rq = elv_next_request(&drive->queue))) {
-			if (!ata_pending_commands(drive))
-				clear_bit(IDE_BUSY, ch->active);
-			drive->rq = NULL;
-			break;
-		}
-
-		/* If there are queued commands, we can't start a non-fs
-		 * request (really, a non-queuable command) until the
-		 * queue is empty.
-		 */
-		if (!(rq->flags & REQ_CMD) && ata_pending_commands(drive))
-			break;
-
-		drive->rq = rq;
-
-		ide__sti();	/* allow other IRQs while we start this request */
-		startstop = start_request(drive, rq);
-
-		/* command started, we are busy */
-		if (startstop == ide_started)
-			break;
-
-		/* start_request() can return either ide_stopped (no command
-		 * was started), ide_started (command started, don't queue
-		 * more), or ide_released (command started, try and queue
-		 * more).
-		 */
-#if 0
-		if (startstop == ide_stopped)
-			set_bit(IDE_BUSY, &hwgroup->flags);
-#endif
-
-	}
-}
-
 /*
  * Issue a new request.
  * Caller must have already done spin_lock_irqsave(channel->lock, ...)
@@ -926,6 +846,8 @@
 	while (!test_and_set_bit(IDE_BUSY, channel->active)) {
 		struct ata_channel *ch;
 		struct ata_device *drive;
+		struct request *rq = NULL;
+		int i;
 
 		/* this will clear IDE_BUSY, if appropriate */
 		drive = choose_urgent_device(channel);
@@ -935,23 +857,92 @@
 
 		ch = drive->channel;
 
-		/* Disable intrerrupts from the drive on the previous channel.
-		 *
-		 * FIXME: This should be only done if we are indeed sharing the same
-		 * interrupt line with it.
-		 *
-		 * FIXME: check this! It appears to act on the current channel!
+		/* Make sure that all drives on channels sharing the IRQ line
+		 * with us won't generate IRQ's during our activity.
 		 */
-		if (ch != channel && channel->sharing_irq && ch->irq == channel->irq)
-			ata_irq_enable(drive, 0);
+		for (i = 0; i < MAX_HWIFS; ++i) {
+			struct ata_channel *tmp = &ide_hwifs[i];
+			int j;
+
+			if (!tmp->present)
+				continue;
+
+			if (ch == tmp || ch->irq != tmp->irq)
+				continue;
+
+			/* Only care if there is any drive on the channel in
+			 * question.
+			 */
+			for (j = 0;  j < MAX_DRIVES; ++j) {
+				struct ata_device * drive = &tmp->drives[j];
+				if (drive->present)
+					ata_irq_enable(drive, 0);
+			}
+		}
 
 		/* Remember the last drive we where acting on.
 		 */
 		ch->drive = drive;
 
-		queue_commands(drive);
-	}
+		/*
+		 * Feed commands to a drive until it barfs.
+		 */
+
+		do {
+			if (!test_bit(IDE_BUSY, ch->active))
+				printk(KERN_ERR "%s: error: not busy while queueing!\n", drive->name);
+
+			/* Abort early if we can't queue another command. for
+			 * non tcq, ata_can_queue is always 1 since we never
+			 * get here unless the drive is idle.
+			 */
+			if (!ata_can_queue(drive)) {
+				if (!ata_pending_commands(drive))
+					clear_bit(IDE_BUSY, ch->active);
+				break;
+			}
+
+			drive->sleep = 0;
+
+			if (test_bit(IDE_DMA, ch->active)) {
+				printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
+				break;
+			}
+
+			/* There's a small window between where the queue could
+			 * be replugged while we are in here when using tcq (in
+			 * which case the queue is probably empty anyways...),
+			 * so check and leave if appropriate. When not using
+			 * tcq, this is still a severe BUG!
+			 */
+			if (blk_queue_plugged(&drive->queue)) {
+				BUG_ON(!drive->using_tcq);
+				break;
+			}
 
+			if (!(rq = elv_next_request(&drive->queue))) {
+				if (!ata_pending_commands(drive))
+					clear_bit(IDE_BUSY, ch->active);
+				drive->rq = NULL;
+				break;
+			}
+
+			/* If there are queued commands, we can't start a
+			 * non-fs request (really, a non-queuable command)
+			 * until the queue is empty.
+			 */
+			if (!(rq->flags & REQ_CMD) && ata_pending_commands(drive))
+				break;
+
+			drive->rq = rq;
+
+			ide__sti();	/* allow other IRQs while we start this request */
+			/* command started, we are busy */
+		} while (ide_started != start_request(drive, rq));
+		/* make sure the BUSY bit is set */
+		/* FIXME: perhaps there is some place where we miss to set it? */
+		set_bit(IDE_BUSY, ch->active);
+	}
 }
 
 void do_ide_request(request_queue_t *q)
@@ -1234,8 +1225,7 @@
 		} else {
 			printk("%s: %s: huh? expected NULL handler on exit\n", drive->name, __FUNCTION__);
 		}
-	} else if (startstop == ide_released)
-		queue_commands(drive);
+	}
 
 out_lock:
 	spin_unlock_irqrestore(ch->lock, flags);
diff -urN linux-2.5.24/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.24/drivers/ide/ide-disk.c	2002-06-21 00:53:41.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-24 23:09:32.000000000 +0200
@@ -11,8 +11,6 @@
  * This is the ATA disk device driver, as evolved from hd.c and ide.c.
  */
 
-#define IDEDISK_VERSION	"1.14"
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -41,6 +39,24 @@
 #endif
 
 /*
+ * for now, taskfile requests are special :/
+ */
+static inline char *ide_map_rq(struct request *rq, unsigned long *flags)
+{
+	if (rq->bio)
+		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
+	else
+		return rq->buffer + ((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE;
+}
+
+static inline void ide_unmap_rq(struct request *rq, char *to,
+				unsigned long *flags)
+{
+	if (rq->bio)
+		bio_kunmap_irq(to, flags);
+}
+
+/*
  * Perform a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
  *
@@ -113,7 +129,6 @@
 
 		ret = ide_started;
 	} else {
-
 		//	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
 		{
 			unsigned long flags;
@@ -347,18 +362,207 @@
 }
 
 /*
- * Channel lock should be held on entry.
+ * Issue a READ or WRITE command to a disk, using LBA if supported, or CHS
+ * otherwise, to address sectors.  It also takes care of issuing special
+ * DRIVE_CMDs.
+ *
+ * Channel lock should be held.
  */
-static ide_startstop_t __do_request(struct ata_device *drive,
-		struct ata_taskfile *ar, struct request *rq)
+static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
+	struct ata_taskfile args;
+	struct ata_taskfile *ar;
 	struct hd_driveid *id = drive->id;
+	u8 cmd;
+
+	/* Special drive commands don't need any kind of setup.
+	 */
+	if (rq->flags & REQ_SPECIAL) {
+		ar = rq->special;
+		cmd  = ar->cmd;
+	} else  {
+		unsigned int sectors;
+
+		/* FIXME: this check doesn't make sense */
+		if (!(rq->flags & REQ_CMD)) {
+			blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
+			__ata_end_request(drive, rq, 0, 0);
+
+			return ide_stopped;
+		}
+
+		if (IS_PDC4030_DRIVE) {
+			extern ide_startstop_t promise_do_request(struct ata_device *, struct request *, sector_t);
+
+			return promise_do_request(drive, rq, block);
+		}
+
+		/*
+		 * start a tagged operation
+		 */
+		if (drive->using_tcq) {
+			int st = blk_queue_start_tag(&drive->queue, rq);
+
+			if (ata_pending_commands(drive) > drive->max_depth)
+				drive->max_depth = ata_pending_commands(drive);
+			if (ata_pending_commands(drive) > drive->max_last_depth)
+				drive->max_last_depth = ata_pending_commands(drive);
+
+			if (st) {
+				BUG_ON(!ata_pending_commands(drive));
+
+				return ide_started;
+			}
+		}
+		ar = &args;
+
+		memset(&args, 0, sizeof(args));
+		sectors = rq->nr_sectors;
+		/* Dispatch depending up on the drive access method. */
+		if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing)) {
+			/* LBA 48 bit */
+			/*
+			 * 268435455  == 137439 MB or 28bit limit
+			 * 320173056  == 163929 MB or 48bit addressing
+			 * 1073741822 == 549756 MB or 48bit addressing fake drive
+			 */
+			if (sectors == 65536)
+				sectors = 0;
+
+			if (blk_rq_tagged(rq)) {
+				args.taskfile.feature = sectors;
+				args.hobfile.feature = sectors >> 8;
+				args.taskfile.sector_count = rq->tag << 3;
+			} else {
+				args.taskfile.sector_count = sectors;
+				args.hobfile.sector_count = sectors >> 8;
+			}
+
+			args.taskfile.sector_number = block;		/* low lba */
+			args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
+			args.taskfile.high_cylinder = (block >>= 8);	/* hi  lba */
+			args.taskfile.device_head = drive->select.all;
+
+			args.hobfile.sector_number = (block >>= 8);	/* low lba */
+			args.hobfile.low_cylinder = (block >>= 8);	/* mid lba */
+			args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
+		} else if (drive->select.b.lba) {
+			/* LBA 28 bit  */
+			if (sectors == 256)
+				sectors = 0;
+
+			if (blk_rq_tagged(rq)) {
+				args.taskfile.feature = sectors;
+				args.taskfile.sector_count = rq->tag << 3;
+			} else
+				args.taskfile.sector_count = sectors;
+
+			args.taskfile.sector_number = block;
+			args.taskfile.low_cylinder = (block >>= 8);
+			args.taskfile.high_cylinder = (block >>= 8);
+			args.taskfile.device_head = ((block >> 8) & 0x0f);
+		} else {
+			/* CHS */
+			unsigned int track	= (block / drive->sect);
+			unsigned int sect	= (block % drive->sect) + 1;
+			unsigned int head	= (track % drive->head);
+			unsigned int cyl	= (track / drive->head);
+
+			if (sectors == 256)
+				sectors = 0;
+
+			if (blk_rq_tagged(rq)) {
+				args.taskfile.feature = sectors;
+				args.taskfile.sector_count = rq->tag << 3;
+			} else
+				args.taskfile.sector_count = sectors;
+
+			args.taskfile.sector_number = sect;
+			args.taskfile.low_cylinder = cyl;
+			args.taskfile.high_cylinder = (cyl>>8);
+			args.taskfile.device_head = head;
+		}
+		args.taskfile.device_head |= drive->select.all;
+
+		/*
+		 * Decode with physical ATA command to use and setup associated data.
+		 */
+
+		if (rq_data_dir(rq) == READ) {
+			args.command_type = IDE_DRIVE_TASK_IN;
+			if (drive->addressing) {
+				if (drive->using_tcq) {
+					cmd = WIN_READDMA_QUEUED_EXT;
+				} else if (drive->using_dma) {
+					cmd = WIN_READDMA_EXT;
+				} else if (drive->mult_count) {
+					args.XXX_handler = task_mulin_intr;
+					cmd = WIN_MULTREAD_EXT;
+				} else {
+					args.XXX_handler = task_in_intr;
+					cmd = WIN_READ_EXT;
+				}
+			} else {
+				if (drive->using_tcq) {
+					cmd = WIN_READDMA_QUEUED;
+				} else if (drive->using_dma) {
+					cmd = WIN_READDMA;
+				} else if (drive->mult_count) {
+					/* FIXME : Shouldn't this be task_mulin_intr?! */
+					args.XXX_handler = task_in_intr;
+					cmd = WIN_MULTREAD;
+				} else {
+					args.XXX_handler = task_in_intr;
+					cmd = WIN_READ;
+				}
+			}
+		} else {
+			args.command_type = IDE_DRIVE_TASK_RAW_WRITE;
+			if (drive->addressing) {
+				if (drive->using_tcq) {
+					cmd = WIN_WRITEDMA_QUEUED_EXT;
+				} else if (drive->using_dma) {
+					cmd = WIN_WRITEDMA_EXT;
+				} else if (drive->mult_count) {
+					args.XXX_handler = task_mulout_intr;
+					cmd = WIN_MULTWRITE_EXT;
+				} else {
+					args.XXX_handler = task_out_intr;
+					cmd = WIN_WRITE_EXT;
+				}
+			} else {
+				if (drive->using_tcq) {
+					cmd = WIN_WRITEDMA_QUEUED;
+				} else if (drive->using_dma) {
+					cmd = WIN_WRITEDMA;
+				} else if (drive->mult_count) {
+					args.XXX_handler = task_mulout_intr;
+					cmd = WIN_MULTWRITE;
+				} else {
+					args.XXX_handler = task_out_intr;
+					cmd = WIN_WRITE;
+				}
+			}
+		}
+#ifdef DEBUG
+		printk("%s: %sing: ", drive->name,
+				(rq_data_dir(rq)==READ) ? "read" : "writ");
+		if (lba)	printk("LBAsect=%lld, ", block);
+		else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
+		printk("sectors=%ld, ", rq->nr_sectors);
+		printk("buffer=%p\n", rq->buffer);
+#endif
+	}
+
+	/*
+	 * Channel lock should be held on entry.
+	 */
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands.
 	 * FIXME: why not?! */
-	if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
-	      ar->cmd == WIN_MULTWRITE ||
-	      ar->cmd == WIN_MULTWRITE_EXT)) {
+	if (!(cmd == CFA_WRITE_MULTI_WO_ERASE ||
+	      cmd == WIN_MULTWRITE ||
+	      cmd == WIN_MULTWRITE_EXT)) {
 		ata_irq_enable(drive, 1);
 		ata_mask(drive);
 	}
@@ -372,11 +576,13 @@
 	OUT_BYTE((ar->taskfile.device_head & (drive->addressing ? 0xE0 : 0xEF)) | drive->select.all,
 			IDE_SELECT_REG);
 
+	/* FIXME: this is actually distingushing between PIO and DMA requests.
+	 */
 	if (ar->XXX_handler) {
 		struct ata_channel *ch = drive->channel;
 
 		ata_set_handler(drive, ar->XXX_handler, WAIT_CMD, NULL);
-		OUT_BYTE(ar->cmd, IDE_COMMAND_REG);
+		OUT_BYTE(cmd, IDE_COMMAND_REG);
 
 		/* FIXME: Warning check for race between handler and prehandler
 		 * for writing first block of data.  however since we are well
@@ -385,15 +591,15 @@
 		 * FIXME: Replace the switch by using a proper command_type.
 		 */
 
-		if (ar->cmd == CFA_WRITE_SECT_WO_ERASE ||
-		    ar->cmd == WIN_WRITE ||
-		    ar->cmd == WIN_WRITE_EXT ||
-		    ar->cmd == WIN_WRITE_VERIFY ||
-		    ar->cmd == WIN_WRITE_BUFFER ||
-		    ar->cmd == WIN_DOWNLOAD_MICROCODE ||
-		    ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
-		    ar->cmd == WIN_MULTWRITE ||
-		    ar->cmd == WIN_MULTWRITE_EXT) {
+		if (cmd == CFA_WRITE_SECT_WO_ERASE ||
+		    cmd == WIN_WRITE ||
+		    cmd == WIN_WRITE_EXT ||
+		    cmd == WIN_WRITE_VERIFY ||
+		    cmd == WIN_WRITE_BUFFER ||
+		    cmd == WIN_DOWNLOAD_MICROCODE ||
+		    cmd == CFA_WRITE_MULTI_WO_ERASE ||
+		    cmd == WIN_MULTWRITE ||
+		    cmd == WIN_MULTWRITE_EXT) {
 			ide_startstop_t startstop;
 
 			if (ata_status_poll(drive, DATA_READY, drive->bad_wstat,
@@ -407,9 +613,9 @@
 			/* FIXME: This doesn't make the slightest sense.
 			 * (ks/hs): Fixed Multi Write
 			 */
-			if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
-			      ar->cmd == WIN_MULTWRITE ||
-			      ar->cmd == WIN_MULTWRITE_EXT)) {
+			if (!(cmd == CFA_WRITE_MULTI_WO_ERASE ||
+			      cmd == WIN_MULTWRITE ||
+			      cmd == WIN_MULTWRITE_EXT)) {
 				unsigned long flags;
 				char *buf = ide_map_rq(rq, &flags);
 
@@ -438,6 +644,9 @@
 						break;
 				}
 				if (!drive_is_ready(drive)) {
+					/* We are compleatly missing an error
+					 * return path here.
+					 */
 					printk(KERN_ERR "DISASTER WAITING TO HAPPEN!\n");
 				}
 				/* FIXME: make this unlocking go away*/
@@ -460,20 +669,22 @@
 			return ide_started;
 
 		/* for dma commands we don't set the handler */
-		if (ar->cmd == WIN_WRITEDMA ||
-		    ar->cmd == WIN_WRITEDMA_EXT ||
-		    ar->cmd == WIN_READDMA ||
-		    ar->cmd == WIN_READDMA_EXT)
+		if (cmd == WIN_WRITEDMA ||
+		    cmd == WIN_WRITEDMA_EXT ||
+		    cmd == WIN_READDMA ||
+		    cmd == WIN_READDMA_EXT)
 			return udma_init(drive, rq);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-		else if (ar->cmd == WIN_WRITEDMA_QUEUED ||
-			 ar->cmd == WIN_WRITEDMA_QUEUED_EXT ||
-			 ar->cmd == WIN_READDMA_QUEUED ||
-			 ar->cmd == WIN_READDMA_QUEUED_EXT)
+		else if (cmd == WIN_WRITEDMA_QUEUED ||
+			 cmd == WIN_WRITEDMA_QUEUED_EXT ||
+			 cmd == WIN_READDMA_QUEUED ||
+			 cmd == WIN_READDMA_QUEUED_EXT)
 			return udma_tcq_init(drive, rq);
 #endif
 		else {
-			printk(KERN_ERR "%s: unknown command %x\n", __FUNCTION__, ar->cmd);
+			printk(KERN_ERR "%s: unknown command %x\n",
+					__FUNCTION__, cmd);
+
 			return ide_stopped;
 		}
 	}
@@ -481,198 +692,6 @@
 	return ide_started;
 }
 
-/*
- * Issue a READ or WRITE command to a disk, using LBA if supported, or CHS
- * otherwise, to address sectors.  It also takes care of issuing special
- * DRIVE_CMDs.
- *
- * Channel lock should be held.
- */
-static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
-{
-	struct ata_taskfile args;
-	unsigned int sectors;
-
-	/* This issues a special drive command.
-	 */
-	if (rq->flags & REQ_SPECIAL)
-		return __do_request(drive, rq->special, rq);
-
-	/* FIXME: this check doesn't make sense */
-	if (!(rq->flags & REQ_CMD)) {
-		blk_dump_rq_flags(rq, "idedisk_do_request - bad command");
-		__ata_end_request(drive, rq, 0, 0);
-
-		return ide_stopped;
-	}
-
-	if (IS_PDC4030_DRIVE) {
-		extern ide_startstop_t promise_do_request(struct ata_device *, struct request *, sector_t);
-
-		return promise_do_request(drive, rq, block);
-	}
-
-	/*
-	 * start a tagged operation
-	 */
-	if (drive->using_tcq) {
-		int st = blk_queue_start_tag(&drive->queue, rq);
-
-		if (ata_pending_commands(drive) > drive->max_depth)
-			drive->max_depth = ata_pending_commands(drive);
-		if (ata_pending_commands(drive) > drive->max_last_depth)
-			drive->max_last_depth = ata_pending_commands(drive);
-
-		if (st) {
-			BUG_ON(!ata_pending_commands(drive));
-
-			return ide_started;
-		}
-	}
-
-	memset(&args, 0, sizeof(args));
-	sectors = rq->nr_sectors;
-	/* Dispatch depending up on the drive access method. */
-	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing)) {
-		/* LBA 48 bit */
-		/*
-		 * 268435455  == 137439 MB or 28bit limit
-		 * 320173056  == 163929 MB or 48bit addressing
-		 * 1073741822 == 549756 MB or 48bit addressing fake drive
-		 */
-		if (sectors == 65536)
-			sectors = 0;
-
-		if (blk_rq_tagged(rq)) {
-			args.taskfile.feature = sectors;
-			args.hobfile.feature = sectors >> 8;
-			args.taskfile.sector_count = rq->tag << 3;
-		} else {
-			args.taskfile.sector_count = sectors;
-			args.hobfile.sector_count = sectors >> 8;
-		}
-
-		args.taskfile.sector_number = block;		/* low lba */
-		args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
-		args.taskfile.high_cylinder = (block >>= 8);	/* hi  lba */
-		args.taskfile.device_head = drive->select.all;
-
-		args.hobfile.sector_number = (block >>= 8);	/* low lba */
-		args.hobfile.low_cylinder = (block >>= 8);	/* mid lba */
-		args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
-	} else if (drive->select.b.lba) {
-		/* LBA 28 bit  */
-		if (sectors == 256)
-			sectors = 0;
-
-		if (blk_rq_tagged(rq)) {
-			args.taskfile.feature = sectors;
-			args.taskfile.sector_count = rq->tag << 3;
-		} else
-			args.taskfile.sector_count = sectors;
-
-		args.taskfile.sector_number = block;
-		args.taskfile.low_cylinder = (block >>= 8);
-		args.taskfile.high_cylinder = (block >>= 8);
-		args.taskfile.device_head = ((block >> 8) & 0x0f);
-	} else {
-		/* CHS */
-		unsigned int track	= (block / drive->sect);
-		unsigned int sect	= (block % drive->sect) + 1;
-		unsigned int head	= (track % drive->head);
-		unsigned int cyl	= (track / drive->head);
-
-		if (sectors == 256)
-			sectors = 0;
-
-		if (blk_rq_tagged(rq)) {
-			args.taskfile.feature = sectors;
-			args.taskfile.sector_count = rq->tag << 3;
-		} else
-			args.taskfile.sector_count = sectors;
-
-		args.taskfile.sector_number = sect;
-		args.taskfile.low_cylinder = cyl;
-		args.taskfile.high_cylinder = (cyl>>8);
-		args.taskfile.device_head = head;
-	}
-	args.taskfile.device_head |= drive->select.all;
-
-	/*
-	 * Decode with physical ATA command to use and setup associated data.
-	 */
-
-	if (rq_data_dir(rq) == READ) {
-		args.command_type = IDE_DRIVE_TASK_IN;
-		if (drive->addressing) {
-			if (drive->using_tcq) {
-				args.cmd = WIN_READDMA_QUEUED_EXT;
-			} else if (drive->using_dma) {
-				args.cmd = WIN_READDMA_EXT;
-			} else if (drive->mult_count) {
-				args.XXX_handler = task_mulin_intr;
-				args.cmd = WIN_MULTREAD_EXT;
-			} else {
-				args.XXX_handler = task_in_intr;
-				args.cmd = WIN_READ_EXT;
-			}
-		} else {
-			if (drive->using_tcq) {
-				args.cmd = WIN_READDMA_QUEUED;
-			} else if (drive->using_dma) {
-				args.cmd = WIN_READDMA;
-			} else if (drive->mult_count) {
-				/* FIXME : Shouldn't this be task_mulin_intr?! */
-				args.XXX_handler = task_in_intr;
-				args.cmd = WIN_MULTREAD;
-			} else {
-				args.XXX_handler = task_in_intr;
-				args.cmd = WIN_READ;
-			}
-		}
-	} else {
-		args.command_type = IDE_DRIVE_TASK_RAW_WRITE;
-		if (drive->addressing) {
-			if (drive->using_tcq) {
-				args.cmd = WIN_WRITEDMA_QUEUED_EXT;
-			} else if (drive->using_dma) {
-				args.cmd = WIN_WRITEDMA_EXT;
-			} else if (drive->mult_count) {
-				args.XXX_handler = task_mulout_intr;
-				args.cmd = WIN_MULTWRITE_EXT;
-			} else {
-				args.XXX_handler = task_out_intr;
-				args.cmd = WIN_WRITE_EXT;
-			}
-		} else {
-			if (drive->using_tcq) {
-				args.cmd = WIN_WRITEDMA_QUEUED;
-			} else if (drive->using_dma) {
-				args.cmd = WIN_WRITEDMA;
-			} else if (drive->mult_count) {
-				args.XXX_handler = task_mulout_intr;
-				args.cmd = WIN_MULTWRITE;
-			} else {
-				args.XXX_handler = task_out_intr;
-				args.cmd = WIN_WRITE;
-			}
-		}
-	}
-
-
-#ifdef DEBUG
-	printk("%s: %sing: ", drive->name,
-			(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
-	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=%p\n", rq->buffer);
-#endif
-	rq->special = &args;
-
-	return __do_request(drive, &args, rq);
-}
-
 static int idedisk_open(struct inode *inode, struct file *__fp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
@@ -689,7 +708,7 @@
 
 			memset(&args, 0, sizeof(args));
 			args.cmd = WIN_DOORLOCK;
-			if (ide_raw_taskfile(drive, &args))
+			if (ide_raw_taskfile(drive, &args, NULL))
 				drive->doorlocking = 0;
 		}
 	}
@@ -708,7 +727,7 @@
 	else
 		args.cmd = WIN_FLUSH_CACHE;
 
-	return ide_raw_taskfile(drive, &args);
+	return ide_raw_taskfile(drive, &args, NULL);
 }
 
 static void idedisk_release(struct inode *inode, struct file *filp, struct ata_device *drive)
@@ -722,7 +741,7 @@
 
 			memset(&args, 0, sizeof(args));
 			args.cmd = WIN_DOORUNLOCK;
-			if (ide_raw_taskfile(drive, &args))
+			if (ide_raw_taskfile(drive, &args, NULL))
 				drive->doorlocking = 0;
 		}
 	}
@@ -769,7 +788,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETMULT;
-	if (!ide_raw_taskfile(drive, &args)) {
+	if (!ide_raw_taskfile(drive, &args, NULL)) {
 		/* all went well track this setting as valid */
 		drive->mult_count = arg;
 
@@ -798,7 +817,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	drive->wcache = arg;
 
@@ -811,7 +830,7 @@
 
 	memset(&args, 0, sizeof(args));
 	args.cmd = WIN_STANDBYNOW1;
-	return ide_raw_taskfile(drive, &args);
+	return ide_raw_taskfile(drive, &args, NULL);
 }
 
 static int set_acoustic(struct ata_device *drive, int arg)
@@ -822,7 +841,7 @@
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETFEATURES;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	drive->acoustic = arg;
 
@@ -942,7 +961,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -964,10 +983,9 @@
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(args));
-
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX_EXT;
-        ide_raw_taskfile(drive, &args);
+        ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -1005,7 +1023,7 @@
 
 	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
 	args.cmd = WIN_SET_MAX;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, read new maximum address value */
 	if (!(drive->status & ERR_STAT)) {
@@ -1038,7 +1056,7 @@
 	args.hobfile.high_cylinder = (addr_req >>= 8);
 	args.hobfile.device_head = 0x40;
 
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
diff -urN linux-2.5.24/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.24/drivers/ide/ide-floppy.c	2002-06-21 00:53:47.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-23 20:12:27.000000000 +0200
@@ -315,270 +315,6 @@
 #define	IDEFLOPPY_ERROR_GENERAL		101
 
 /*
- *	The ATAPI Status Register.
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned check		:1;	/* Error occurred */
-		unsigned idx		:1;	/* Reserved */
-		unsigned corr		:1;	/* Correctable error occurred */
-		unsigned drq		:1;	/* Data is request by the device */
-		unsigned dsc		:1;	/* Media access command finished */
-		unsigned reserved5	:1;	/* Reserved */
-		unsigned drdy		:1;	/* Ignored for ATAPI commands (ready to accept ATA command) */
-		unsigned bsy		:1;	/* The device has access to the command block */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned bsy		:1;	/* The device has access to the command block */
-		unsigned drdy		:1;	/* Ignored for ATAPI commands (ready to accept ATA command) */
-		unsigned reserved5	:1;	/* Reserved */
-		unsigned dsc		:1;	/* Media access command finished */
-		unsigned drq		:1;	/* Data is request by the device */
-		unsigned corr		:1;	/* Correctable error occurred */
-		unsigned idx		:1;	/* Reserved */
-		unsigned check		:1;	/* Error occurred */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_status_reg_t;
-
-/*
- *	The ATAPI error register.
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned ili		:1;	/* Illegal Length Indication */
-		unsigned eom		:1;	/* End Of Media Detected */
-		unsigned abrt		:1;	/* Aborted command - As defined by ATA */
-		unsigned mcr		:1;	/* Media Change Requested - As defined by ATA */
-		unsigned sense_key	:4;	/* Sense key of the last failed packet command */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned sense_key	:4;	/* Sense key of the last failed packet command */
-		unsigned mcr		:1;	/* Media Change Requested - As defined by ATA */
-		unsigned abrt		:1;	/* Aborted command - As defined by ATA */
-		unsigned eom		:1;	/* End Of Media Detected */
-		unsigned ili		:1;	/* Illegal Length Indication */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_error_reg_t;
-
-/*
- *	ATAPI Feature Register
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned dma		:1;	/* Using DMA or PIO */
-		unsigned reserved321	:3;	/* Reserved */
-		unsigned reserved654	:3;	/* Reserved (Tag Type) */
-		unsigned reserved7	:1;	/* Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved7	:1;	/* Reserved */
-		unsigned reserved654	:3;	/* Reserved (Tag Type) */
-		unsigned reserved321	:3;	/* Reserved */
-		unsigned dma		:1;	/* Using DMA or PIO */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_feature_reg_t;
-
-/*
- *	ATAPI Byte Count Register.
- */
-typedef union {
-	unsigned all			:16;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned low		:8;	/* LSB */
-		unsigned high		:8;	/* MSB */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned high		:8;	/* MSB */
-		unsigned low		:8;	/* LSB */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_bcount_reg_t;
-
-/*
- *	ATAPI Interrupt Reason Register.
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned cod		:1;	/* Information transferred is command (1) or data (0) */
-		unsigned io		:1;	/* The device requests us to read (1) or write (0) */
-		unsigned reserved	:6;	/* Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	:6;	/* Reserved */
-		unsigned io		:1;	/* The device requests us to read (1) or write (0) */
-		unsigned cod		:1;	/* Information transferred is command (1) or data (0) */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_ireason_reg_t;
-
-/*
- *	ATAPI floppy Drive Select Register
- */
-typedef union {	
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned sam_lun	:3;	/* Logical unit number */
-		unsigned reserved3	:1;	/* Reserved */
-		unsigned drv		:1;	/* The responding drive will be drive 0 (0) or drive 1 (1) */
-		unsigned one5		:1;	/* Should be set to 1 */
-		unsigned reserved6	:1;	/* Reserved */
-		unsigned one7		:1;	/* Should be set to 1 */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned one7		:1;	/* Should be set to 1 */
-		unsigned reserved6	:1;	/* Reserved */
-		unsigned one5		:1;	/* Should be set to 1 */
-		unsigned drv		:1;	/* The responding drive will be drive 0 (0) or drive 1 (1) */
-		unsigned reserved3	:1;	/* Reserved */
-		unsigned sam_lun	:3;	/* Logical unit number */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_drivesel_reg_t;
-
-/*
- *	ATAPI Device Control Register
- */
-typedef union {			
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned zero0		:1;	/* Should be set to zero */
-		unsigned nien		:1;	/* Device interrupt is disabled (1) or enabled (0) */
-		unsigned srst		:1;	/* ATA software reset. ATAPI devices should use the new ATAPI srst. */
-		unsigned one3		:1;	/* Should be set to 1 */
-		unsigned reserved4567	:4;	/* Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved4567	:4;	/* Reserved */
-		unsigned one3		:1;	/* Should be set to 1 */
-		unsigned srst		:1;	/* ATA software reset. ATAPI devices should use the new ATAPI srst. */
-		unsigned nien		:1;	/* Device interrupt is disabled (1) or enabled (0) */
-		unsigned zero0		:1;	/* Should be set to zero */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	} b;
-} idefloppy_control_reg_t;
-
-/*
- *	The following is used to format the general configuration word of
- *	the ATAPI IDENTIFY DEVICE command.
- */
-struct idefloppy_id_gcw {	
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned packet_size		:2;	/* Packet Size */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned device_type		:5;	/* Device type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned protocol		:2;	/* Protocol type */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned protocol		:2;	/* Protocol type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned device_type		:5;	/* Device type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned packet_size		:2;	/* Packet Size */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-};
-
-/*
- *	INQUIRY packet command - Data Format
- */
-typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	response_format :4;	/* Response Data Format */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	response_format :4;	/* Response Data Format */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	u8		additional_length;	/* Additional Length (total_length-4) */
-	u8		rsv5, rsv6, rsv7;	/* Reserved */
-	u8		vendor_id[8];		/* Vendor Identification */
-	u8		product_id[16];		/* Product Identification */
-	u8		revision_level[4];	/* Revision Level */
-	u8		vendor_specific[20];	/* Vendor Specific - Optional */
-	u8		reserved56t95[40];	/* Reserved - Optional */
-						/* Additional information may be returned */
-} idefloppy_inquiry_result_t;
-
-/*
- *	REQUEST SENSE packet command result - Data Format.
- */
-typedef struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	error_code	:7;	/* Current error (0x70) */
-	unsigned	valid		:1;	/* The information field conforms to SFF-8070i */
-	u8		reserved1	:8;	/* Reserved */
-	unsigned	sense_key	:4;	/* Sense Key */
-	unsigned	reserved2_4	:1;	/* Reserved */
-	unsigned	ili		:1;	/* Incorrect Length Indicator */
-	unsigned	reserved2_67	:2;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	valid		:1;	/* The information field conforms to SFF-8070i */
-	unsigned	error_code	:7;	/* Current error (0x70) */
-	u8		reserved1	:8;	/* Reserved */
-	unsigned	reserved2_67	:2;
-	unsigned	ili		:1;	/* Incorrect Length Indicator */
-	unsigned	reserved2_4	:1;	/* Reserved */
-	unsigned	sense_key	:4;	/* Sense Key */
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-	u32		information __attribute__ ((packed));
-	u8		asl;			/* Additional sense length (n-7) */
-	u32		command_specific;	/* Additional command specific information */
-	u8		asc;			/* Additional Sense Code */
-	u8		ascq;			/* Additional Sense Code Qualifier */
-	u8		replaceable_unit_code;	/* Field Replaceable Unit Code */
-	u8		sksv[3];
-	u8		pad[2];			/* Padding to 20 bytes */
-} idefloppy_request_sense_result_t;
-
-/*
  *	Pages of the SELECT SENSE / MODE SENSE packet commands.
  */
 #define	IDEFLOPPY_CAPABILITIES_PAGE	0x1b
@@ -602,9 +338,6 @@
 	u8		reserved[4];
 } idefloppy_mode_parameter_header_t;
 
-#define IDEFLOPPY_MIN(a,b)	((a)<(b) ? (a):(b))
-#define	IDEFLOPPY_MAX(a,b)	((a)>(b) ? (a):(b))
-
 /*
  *	idefloppy_end_request is used to finish servicing a request.
  *
@@ -663,7 +396,7 @@
 			atapi_discard_data(drive, bcount);
 			return;
 		}
-		count = IDEFLOPPY_MIN(bio->bi_size - pc->b_count, bcount);
+		count = min_t(unsigned int, bio->bi_size - pc->b_count, bcount);
 		atapi_read(drive, bio_data(bio) + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 	}
@@ -690,7 +423,7 @@
 			atapi_write_zeros (drive, bcount);
 			return;
 		}
-		count = IDEFLOPPY_MIN(pc->b_count, bcount);
+		count = min_t(unsigned int, pc->b_count, bcount);
 		atapi_write(drive, pc->b_data, count);
 		bcount -= count; pc->b_data += count; pc->b_count -= count;
 	}
@@ -743,13 +476,13 @@
  *	idefloppy_analyze_error is called on each failed packet command retry
  *	to analyze the request sense.
  */
-static void idefloppy_analyze_error(struct ata_device *drive, idefloppy_request_sense_result_t *result)
+static void idefloppy_analyze_error(struct ata_device *drive, atapi_request_sense_result_t *result)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 
 	floppy->sense_key = result->sense_key; floppy->asc = result->asc; floppy->ascq = result->ascq;
-	floppy->progress_indication= result->sksv[0] & 0x80 ?
-		(unsigned short)get_unaligned((u16 *)(result->sksv+1)):0x10000;
+	floppy->progress_indication= result->sksv ?
+		(unsigned short)get_unaligned((u16 *)(result->sk_specific)):0x10000;
 #if IDEFLOPPY_DEBUG_LOG
 	if (floppy->failed_pc)
 		printk (KERN_INFO "ide-floppy: pc = %x, sense key = %x, asc = %x, ascq = %x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
@@ -766,7 +499,7 @@
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_request_sense_callback\n");
 #endif
 	if (!floppy->pc->error) {
-		idefloppy_analyze_error(drive,(idefloppy_request_sense_result_t *) floppy->pc->buffer);
+		idefloppy_analyze_error(drive,(atapi_request_sense_result_t *) floppy->pc->buffer);
 		idefloppy_end_request(drive, rq, 1);
 	} else {
 		printk (KERN_ERR "Error in REQUEST SENSE itself - Aborting request!\n");
@@ -806,7 +539,7 @@
 {
 	struct atapi_packet_command *pc;
 	struct request *rq;
-	idefloppy_error_reg_t error;
+	atapi_error_reg_t error;
 
 	error.all = IN_BYTE(IDE_ERROR_REG);
 	pc = idefloppy_next_pc_storage(drive);
@@ -824,9 +557,9 @@
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	idefloppy_status_reg_t status;
-	idefloppy_bcount_reg_t bcount;
-	idefloppy_ireason_reg_t ireason;
+	atapi_status_reg_t status;
+	atapi_bcount_reg_t bcount;
+	atapi_ireason_reg_t ireason;
 	struct atapi_packet_command *pc = floppy->pc;
 	unsigned int temp;
 
@@ -955,7 +688,7 @@
 	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	idefloppy_ireason_reg_t ireason;
+	atapi_ireason_reg_t ireason;
 	int ret;
 
 	/* FIXME: Move this lock upwards.
@@ -1010,7 +743,7 @@
 	struct ata_channel *ch = drive->channel;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	ide_startstop_t startstop;
-	idefloppy_ireason_reg_t ireason;
+	atapi_ireason_reg_t ireason;
 	int ret;
 
 	if (ata_status_poll(drive, DRQ_STAT, BUSY_STAT,
@@ -1057,7 +790,7 @@
 		struct atapi_packet_command *pc)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	idefloppy_bcount_reg_t bcount;
+	atapi_bcount_reg_t bcount;
 	int dma_ok = 0;
 	ata_handler_t *pkt_xfer_routine;
 
@@ -1655,7 +1388,7 @@
 	}
 	else
 	{
-		idefloppy_status_reg_t status;
+		atapi_status_reg_t status;
 		unsigned long flags;
 
 		__save_flags(flags);
@@ -1861,7 +1594,7 @@
  */
 static int idefloppy_identify_device(struct ata_device *drive,struct hd_driveid *id)
 {
-	struct idefloppy_id_gcw gcw;
+	struct atapi_id_gcw gcw;
 #if IDEFLOPPY_DEBUG_INFO
 	unsigned short mask,i;
 	char buffer[80];
@@ -1976,7 +1709,7 @@
  */
 static void idefloppy_setup(struct ata_device *drive, idefloppy_floppy_t *floppy)
 {
-	struct idefloppy_id_gcw gcw;
+	struct atapi_id_gcw gcw;
 	int i;
 
 	*((unsigned short *) &gcw) = drive->id->config;
diff -urN linux-2.5.24/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.24/drivers/ide/ide-pmac.c	2002-06-21 00:53:55.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-24 16:07:16.000000000 +0200
@@ -1491,7 +1491,7 @@
 	set_bit(IDE_DMA, drive->channel->active);
 //	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
 //		printk(KERN_WARNING "ide%d, timeout waiting \
-				for dbdma command stop\n", ix);
+//				for dbdma command stop\n", ix);
 		return 1;
 	}
 	udelay(1);
diff -urN linux-2.5.24/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.24/drivers/ide/ide-tape.c	2002-06-21 00:53:46.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-23 20:12:28.000000000 +0200
@@ -771,32 +771,6 @@
 } idetape_stage_t;
 
 /*
- *	REQUEST SENSE packet command result - Data Format.
- */
-typedef struct {
-	unsigned	error_code	:7;	/* Current of deferred errors */
-	unsigned	valid		:1;	/* The information field conforms to QIC-157C */
-	__u8		reserved1	:8;	/* Segment Number - Reserved */
-	unsigned	sense_key	:4;	/* Sense Key */
-	unsigned	reserved2_4	:1;	/* Reserved */
-	unsigned	ili		:1;	/* Incorrect Length Indicator */
-	unsigned	eom		:1;	/* End Of Medium */
-	unsigned	filemark 	:1;	/* Filemark */
-	__u32		information __attribute__ ((packed));
-	__u8		asl;			/* Additional sense length (n-7) */
-	__u32		command_specific;	/* Additional command specific information */
-	__u8		asc;			/* Additional Sense Code */
-	__u8		ascq;			/* Additional Sense Code Qualifier */
-	__u8		replaceable_unit_code;	/* Field Replaceable Unit Code */
-	unsigned	sk_specific1 	:7;	/* Sense Key Specific */
-	unsigned	sksv		:1;	/* Sense Key Specific information is valid */
-	__u8		sk_specific2;		/* Sense Key Specific */
-	__u8		sk_specific3;		/* Sense Key Specific */
-	__u8		pad[2];			/* Padding to 20 bytes */
-} idetape_request_sense_result_t;
-
-
-/*
  *	Most of our global data which we need to save even as we leave the
  *	driver due to an interrupt or a timer event is stored in a variable
  *	of type idetape_tape_t, defined below.
@@ -920,7 +894,7 @@
 	int avg_size;
 	int avg_speed;
 
-	idetape_request_sense_result_t sense;	/* last sense information */
+	atapi_request_sense_result_t sense;	/* last sense information */
 
 	char vendor_id[10];
 	char product_id[18];
@@ -1124,101 +1098,6 @@
 #define	IDETAPE_ERROR_EOD		103
 
 /*
- *	The ATAPI Status Register.
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-		unsigned check		:1;	/* Error occurred */
-		unsigned idx		:1;	/* Reserved */
-		unsigned corr		:1;	/* Correctable error occurred */
-		unsigned drq		:1;	/* Data is request by the device */
-		unsigned dsc		:1;	/* Buffer availability / Media access command finished */
-		unsigned reserved5	:1;	/* Reserved */
-		unsigned drdy		:1;	/* Ignored for ATAPI commands (ready to accept ATA command) */
-		unsigned bsy		:1;	/* The device has access to the command block */
-	} b;
-} idetape_status_reg_t;
-
-/*
- *	The ATAPI error register.
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-		unsigned ili		:1;	/* Illegal Length Indication */
-		unsigned eom		:1;	/* End Of Media Detected */
-		unsigned abrt		:1;	/* Aborted command - As defined by ATA */
-		unsigned mcr		:1;	/* Media Change Requested - As defined by ATA */
-		unsigned sense_key	:4;	/* Sense key of the last failed packet command */
-	} b;
-} idetape_error_reg_t;
-
-/*
- *	ATAPI Feature Register
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-		unsigned dma		:1;	/* Using DMA or PIO */
-		unsigned reserved321	:3;	/* Reserved */
-		unsigned reserved654	:3;	/* Reserved (Tag Type) */
-		unsigned reserved7	:1;	/* Reserved */
-	} b;
-} idetape_feature_reg_t;
-
-/*
- *	ATAPI Byte Count Register.
- */
-typedef union {
-	unsigned all			:16;
-	struct {
-		unsigned low		:8;	/* LSB */
-		unsigned high		:8;	/* MSB */
-	} b;
-} idetape_bcount_reg_t;
-
-/*
- *	ATAPI Interrupt Reason Register.
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-		unsigned cod		:1;	/* Information transferred is command (1) or data (0) */
-		unsigned io		:1;	/* The device requests us to read (1) or write (0) */
-		unsigned reserved	:6;	/* Reserved */
-	} b;
-} idetape_ireason_reg_t;
-
-/*
- *	ATAPI Drive Select Register
- */
-typedef union {	
-	unsigned all			:8;
-	struct {
-		unsigned sam_lun	:4;	/* Should be zero with ATAPI (not used) */
-		unsigned drv		:1;	/* The responding drive will be drive 0 (0) or drive 1 (1) */
-		unsigned one5		:1;	/* Should be set to 1 */
-		unsigned reserved6	:1;	/* Reserved */
-		unsigned one7		:1;	/* Should be set to 1 */
-	} b;
-} idetape_drivesel_reg_t;
-
-/*
- *	ATAPI Device Control Register
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-		unsigned zero0		:1;	/* Should be set to zero */
-		unsigned nien		:1;	/* Device interrupt is disabled (1) or enabled (0) */
-		unsigned srst		:1;	/* ATA software reset. ATAPI devices should use the new ATAPI srst. */
-		unsigned one3		:1;	/* Should be set to 1 */
-		unsigned reserved4567	:4;	/* Reserved */
-	} b;
-} idetape_control_reg_t;
-
-/*
  *	idetape_chrdev_t provides the link between out character device
  *	interface and our block device interface and the corresponding
  *	ata_device structure.
@@ -1228,45 +1107,6 @@
 } idetape_chrdev_t;
 
 /*
- *	The following is used to format the general configuration word of
- *	the ATAPI IDENTIFY DEVICE command.
- */
-struct idetape_id_gcw {	
-	unsigned packet_size		:2;	/* Packet Size */
-	unsigned reserved234		:3;	/* Reserved */
-	unsigned drq_type		:2;	/* Command packet DRQ type */
-	unsigned removable		:1;	/* Removable media */
-	unsigned device_type		:5;	/* Device type */
-	unsigned reserved13		:1;	/* Reserved */
-	unsigned protocol		:2;	/* Protocol type */
-};
-
-/*
- *	INQUIRY packet command - Data Format (From Table 6-8 of QIC-157C)
- */
-typedef struct {
-	unsigned	device_type	:5;	/* Peripheral Device Type */
-	unsigned	reserved0_765	:3;	/* Peripheral Qualifier - Reserved */
-	unsigned	reserved1_6t0	:7;	/* Reserved */
-	unsigned	rmb		:1;	/* Removable Medium Bit */
-	unsigned	ansi_version	:3;	/* ANSI Version */
-	unsigned	ecma_version	:3;	/* ECMA Version */
-	unsigned	iso_version	:2;	/* ISO Version */
-	unsigned	response_format :4;	/* Response Data Format */
-	unsigned	reserved3_45	:2;	/* Reserved */
-	unsigned	reserved3_6	:1;	/* TrmIOP - Reserved */
-	unsigned	reserved3_7	:1;	/* AENC - Reserved */
-	__u8		additional_length;	/* Additional Length (total_length-4) */
-	__u8		rsv5, rsv6, rsv7;	/* Reserved */
-	__u8		vendor_id[8];		/* Vendor Identification */
-	__u8		product_id[16];		/* Product Identification */
-	__u8		revision_level[4];	/* Revision Level */
-	__u8		vendor_specific[20];	/* Vendor Specific - Optional */
-	__u8		reserved56t95[40];	/* Reserved - Optional */
-						/* Additional information may be returned */
-} idetape_inquiry_result_t;
-
-/*
  *	READ POSITION packet command - Data Format (From Table 6-57)
  */
 typedef struct {
@@ -1574,7 +1414,7 @@
  *	to analyze the request sense. We currently do not utilize this
  *	information.
  */
-static void idetape_analyze_error(struct ata_device *drive, idetape_request_sense_result_t *result)
+static void idetape_analyze_error(struct ata_device *drive, atapi_request_sense_result_t *result)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command *pc = tape->failed_pc;
@@ -1887,7 +1727,7 @@
 		printk (KERN_INFO "ide-tape: Reached idetape_request_sense_callback\n");
 #endif
 	if (!tape->pc->error) {
-		idetape_analyze_error (drive, (idetape_request_sense_result_t *) tape->pc->buffer);
+		idetape_analyze_error (drive, (atapi_request_sense_result_t *) tape->pc->buffer);
 		idetape_end_request(drive, rq, 1);
 	} else {
 		printk (KERN_ERR "ide-tape: Error in REQUEST SENSE itself - Aborting request!\n");
@@ -1941,7 +1781,7 @@
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command *pc;
 	struct request *rq;
-	idetape_error_reg_t error;
+	atapi_error_reg_t error;
 
 	error.all = IN_BYTE (IDE_ERROR_REG);
 	pc = idetape_next_pc_storage (drive);
@@ -1981,9 +1821,9 @@
 	unsigned long flags;
 	struct ata_channel *ch = drive->channel;
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_status_reg_t status;
-	idetape_bcount_reg_t bcount;
-	idetape_ireason_reg_t ireason;
+	atapi_status_reg_t status;
+	atapi_bcount_reg_t bcount;
+	atapi_ireason_reg_t ireason;
 	struct atapi_packet_command *pc = tape->pc;
 
 	unsigned int temp;
@@ -2196,7 +2036,7 @@
 	struct ata_channel *ch = drive->channel;
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command *pc = tape->pc;
-	idetape_ireason_reg_t ireason;
+	atapi_ireason_reg_t ireason;
 	int retries = 100;
 	ide_startstop_t startstop;
 	int ret;
@@ -2240,7 +2080,7 @@
 		struct request *rq, struct atapi_packet_command *pc)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_bcount_reg_t bcount;
+	atapi_bcount_reg_t bcount;
 	int dma_ok = 0;
 
 #if IDETAPE_DEBUG_BUGS
@@ -2451,7 +2291,7 @@
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command *pc = tape->pc;
-	idetape_status_reg_t status;
+	atapi_status_reg_t status;
 
 	if (tape->onstream)
 		printk(KERN_INFO "ide-tape: bug: onstream, media_access_finished\n");
@@ -2609,7 +2449,7 @@
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command *pc;
 	struct request *postponed_rq = tape->postponed_rq;
-	idetape_status_reg_t status;
+	atapi_status_reg_t status;
 	int ret;
 
 #if IDETAPE_DEBUG_LOG
@@ -5572,7 +5412,7 @@
  */
 static int idetape_identify_device(struct ata_device *drive,struct hd_driveid *id)
 {
-	struct idetape_id_gcw gcw;
+	struct atapi_id_gcw gcw;
 #if IDETAPE_DEBUG_INFO
 	unsigned short mask,i;
 #endif /* IDETAPE_DEBUG_INFO */
@@ -5791,14 +5631,14 @@
 	char *r;
 	idetape_tape_t *tape = drive->driver_data;
 	struct atapi_packet_command pc;
-	idetape_inquiry_result_t *inquiry;
+	atapi_inquiry_result_t *inquiry;
 
 	idetape_create_inquiry_cmd(&pc);
 	if (idetape_queue_pc_tail (drive, &pc)) {
 		printk (KERN_ERR "ide-tape: %s: can't get INQUIRY results\n", tape->name);
 		return;
 	}
-	inquiry = (idetape_inquiry_result_t *) pc.buffer;
+	inquiry = (atapi_inquiry_result_t *) pc.buffer;
 	memcpy(tape->vendor_id, inquiry->vendor_id, 8);
 	memcpy(tape->product_id, inquiry->product_id, 16);
 	memcpy(tape->firmware_revision, inquiry->revision_level, 4);
@@ -5985,7 +5825,7 @@
 	unsigned long t1, tmid, tn;
 	unsigned long t;
 	int speed;
-	struct idetape_id_gcw gcw;
+	struct atapi_id_gcw gcw;
 	int stage_size;
 	struct sysinfo si;
 
diff -urN linux-2.5.24/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.24/drivers/ide/ide-taskfile.c	2002-06-21 00:53:53.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-23 20:12:28.000000000 +0200
@@ -242,7 +242,7 @@
 /*
  * Invoked on completion of a special REQ_SPECIAL command.
  */
-ide_startstop_t ata_special_intr(struct ata_device *drive, struct
+static ide_startstop_t special_intr(struct ata_device *drive, struct
 		request *rq) {
 
 	struct ata_taskfile *ar = rq->special;
@@ -292,15 +292,16 @@
 	return ret;
 }
 
-int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar)
+int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar, char *buf)
 {
 	struct request req;
 
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-	ar->XXX_handler = ata_special_intr;
+	ar->XXX_handler = special_intr;
 
 	memset(&req, 0, sizeof(req));
 	req.flags = REQ_SPECIAL;
+	req.buffer = buf;
 	req.special = ar;
 
 	return ide_do_drive_cmd(drive, &req, ide_wait);
@@ -310,5 +311,4 @@
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
-EXPORT_SYMBOL(ata_special_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -urN linux-2.5.24/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.24/drivers/ide/ioctl.c	2002-06-21 00:53:48.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-23 20:12:28.000000000 +0200
@@ -47,7 +47,6 @@
 	u8 *argbuf = vals;
 	int argsize = 4;
 	struct ata_taskfile args;
-	struct request req;
 
 	/* Second phase.
 	 */
@@ -80,15 +79,7 @@
 
 	/* Issue ATA command and wait for completion.
 	 */
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-	args.XXX_handler = ata_special_intr;
-
-	memset(&req, 0, sizeof(req));
-	req.flags = REQ_SPECIAL;
-	req.special = &args;
-
-	req.buffer = argbuf + 4;
-	err = ide_do_drive_cmd(drive, &req, ide_wait);
+	err = ide_raw_taskfile(drive, &args, argbuf + 4);
 
 	argbuf[0] = drive->status;
 	argbuf[1] = args.taskfile.feature;
diff -urN linux-2.5.24/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.24/drivers/ide/tcq.c	2002-06-21 00:53:55.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-23 20:12:28.000000000 +0200
@@ -441,7 +441,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = 0x01;
 	args.cmd = WIN_NOP;
-	ide_raw_taskfile(drive, &args);
+	ide_raw_taskfile(drive, &args, NULL);
 	if (args.taskfile.feature & ABRT_ERR)
 		return 1;
 
@@ -469,7 +469,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args)) {
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: failed to enable write cache\n", drive->name);
 		return 1;
 	}
@@ -481,7 +481,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_DIS_RI;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args)) {
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
 		return 1;
 	}
@@ -493,7 +493,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_SI;
 	args.cmd = WIN_SETFEATURES;
-	if (ide_raw_taskfile(drive, &args)) {
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
 		return 1;
 	}
diff -urN linux-2.5.24/include/linux/atapi.h linux/include/linux/atapi.h
--- linux-2.5.24/include/linux/atapi.h	2002-06-21 00:53:49.000000000 +0200
+++ linux/include/linux/atapi.h	2002-06-23 20:12:28.000000000 +0200
@@ -12,6 +12,9 @@
  * more details.
  */
 
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
 /*
  * With each packet command, we allocate a buffer.
  * This is used for several packet
@@ -79,3 +82,281 @@
 extern void atapi_read(struct ata_device *, u8 *, unsigned int);
 extern void atapi_write(struct ata_device *, u8 *, unsigned int);
 
+
+/*
+ *	ATAPI Status Register.
+ */
+typedef union {
+	u8 all			: 8;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 check	: 1;	/* Error occurred */
+		u8 idx		: 1;	/* Reserved */
+		u8 corr		: 1;	/* Correctable error occurred */
+		u8 drq		: 1;	/* Data is request by the device */
+		u8 dsc		: 1;	/* Media access command finished / Buffer availability */
+		u8 reserved5	: 1;	/* Reserved */
+		u8 drdy		: 1;	/* Ignored for ATAPI commands (ready to accept ATA command) */
+		u8 bsy		: 1;	/* The device has access to the command block */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 bsy		: 1;
+		u8 drdy		: 1;
+		u8 reserved5	: 1;
+		u8 dsc		: 1;
+		u8 drq		: 1;
+		u8 corr		: 1;
+		u8 idx		: 1;
+		u8 check	: 1;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_status_reg_t;
+
+/*
+ *	ATAPI error register.
+ */
+typedef union {
+	u8 all			: 8;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 ili		: 1;	/* Illegal Length Indication */
+		u8 eom		: 1;	/* End Of Media Detected */
+		u8 abrt		: 1;	/* Aborted command - As defined by ATA */
+		u8 mcr		: 1;	/* Media Change Requested - As defined by ATA */
+		u8 sense_key	: 4;	/* Sense key of the last failed packet command */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 sense_key	: 4;
+		u8 mcr		: 1;
+		u8 abrt		: 1;
+		u8 eom		: 1;
+		u8 ili		: 1;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_error_reg_t;
+
+/* Currently unused, but please do not remove.  --bkz */
+/*
+ *	ATAPI Feature Register.
+ */
+typedef union {
+	u8 all			: 8;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 dma		: 1;	/* Using DMA or PIO */
+		u8 reserved321	: 3;	/* Reserved */
+		u8 reserved654	: 3;	/* Reserved (Tag Type) */
+		u8 reserved7	: 1;	/* Reserved */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 reserved7	: 1;
+		u8 reserved654	: 3;
+		u8 reserved321	: 3;
+		u8 dma		: 1;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_feature_reg_t;
+
+/*
+ *	ATAPI Byte Count Register.
+ */
+typedef union {
+	u16 all			: 16;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 low;			/* LSB */
+		u8 high;		/* MSB */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 high;
+		u8 low;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_bcount_reg_t;
+
+/*
+ *	ATAPI Interrupt Reason Register.
+ */
+typedef union {
+	u8 all			: 8;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 cod		: 1;	/* Information transferred is command (1) or data (0) */
+		u8 io		: 1;	/* The device requests us to read (1) or write (0) */
+		u8 reserved	: 6;	/* Reserved */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 reserved	: 6;
+		u8 io		: 1;
+		u8 cod		: 1;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_ireason_reg_t;
+
+/* Currently unused, but please do not remove.  --bkz */
+/*
+ *	ATAPI Drive Select Register.
+ */
+typedef union {
+	u8 all			:8;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 sam_lun	:3;	/* Logical unit number */
+		u8 reserved3	:1;	/* Reserved */
+		u8 drv		:1;	/* The responding drive will be drive 0 (0) or drive 1 (1) */
+		u8 one5		:1;	/* Should be set to 1 */
+		u8 reserved6	:1;	/* Reserved */
+		u8 one7		:1;	/* Should be set to 1 */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 one7		:1;
+		u8 reserved6	:1;
+		u8 one5		:1;
+		u8 drv		:1;
+		u8 reserved3	:1;
+		u8 sam_lun	:3;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_drivesel_reg_t;
+
+/* Currently unused, but please do not remove.  --bkz */
+/*
+ *	ATAPI Device Control Register.
+ */
+typedef union {
+	u8 all			: 8;
+	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		u8 zero0	: 1;	/* Should be set to zero */
+		u8 nien		: 1;	/* Device interrupt is disabled (1) or enabled (0) */
+		u8 srst		: 1;	/* ATA software reset. ATAPI devices should use the new ATAPI srst. */
+		u8 one3		: 1;	/* Should be set to 1 */
+		u8 reserved4567	: 4;	/* Reserved */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		u8 reserved4567	: 4;
+		u8 one3		: 1;
+		u8 srst		: 1;
+		u8 nien		: 1;
+		u8 zero0	: 1;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	} b;
+} atapi_control_reg_t;
+
+/*
+ *	The following is used to format the general configuration word
+ *	of the ATAPI IDENTIFY DEVICE command.
+ */
+struct atapi_id_gcw {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 packet_size		: 2;	/* Packet Size */
+	u8 reserved234		: 3;	/* Reserved */
+	u8 drq_type		: 2;	/* Command packet DRQ type */
+	u8 removable		: 1;	/* Removable media */
+	u8 device_type		: 5;	/* Device type */
+	u8 reserved13		: 1;	/* Reserved */
+	u8 protocol		: 2;	/* Protocol type */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 protocol		: 2;
+	u8 reserved13		: 1;
+	u8 device_type		: 5;
+	u8 removable		: 1;
+	u8 drq_type		: 2;
+	u8 reserved234		: 3;
+	u8 packet_size		: 2;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+};
+
+/*
+ *	INQUIRY packet command - Data Format.
+ */
+typedef struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8	device_type	: 5;	/* Peripheral Device Type */
+	u8	reserved0_765	: 3;	/* Peripheral Qualifier - Reserved */
+	u8	reserved1_6t0	: 7;	/* Reserved */
+	u8	rmb		: 1;	/* Removable Medium Bit */
+	u8	ansi_version	: 3;	/* ANSI Version */
+	u8	ecma_version	: 3;	/* ECMA Version */
+	u8	iso_version	: 2;	/* ISO Version */
+	u8	response_format : 4;	/* Response Data Format */
+	u8	reserved3_45	: 2;	/* Reserved */
+	u8	reserved3_6	: 1;	/* TrmIOP - Reserved */
+	u8	reserved3_7	: 1;	/* AENC - Reserved */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8	reserved0_765	: 3;
+	u8	device_type	: 5;
+	u8	rmb		: 1;
+	u8	reserved1_6t0	: 7;
+	u8	iso_version	: 2;
+	u8	ecma_version	: 3;
+	u8	ansi_version	: 3;
+	u8	reserved3_7	: 1;
+	u8	reserved3_6	: 1;
+	u8	reserved3_45	: 2;
+	u8	response_format : 4;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	u8	additional_length;	/* Additional Length (total_length-4) */
+	u8	rsv5, rsv6, rsv7;	/* Reserved */
+	u8	vendor_id[8];		/* Vendor Identification */
+	u8	product_id[16];		/* Product Identification */
+	u8	revision_level[4];	/* Revision Level */
+	u8	vendor_specific[20];	/* Vendor Specific - Optional */
+	u8	reserved56t95[40];	/* Reserved - Optional */
+					/* Additional information may be returned */
+} atapi_inquiry_result_t;
+
+/*
+ *	REQUEST SENSE packet command result - Data Format.
+ */
+typedef struct atapi_request_sense {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8	error_code	: 7;	/* Error Code (0x70 - current or 0x71 - deferred) */
+	u8	valid		: 1;	/* The information field conforms to standard */
+	u8	reserved1	: 8;	/* Reserved (Segment Number) */
+	u8	sense_key	: 4;	/* Sense Key */
+	u8	reserved2_4	: 1;	/* Reserved */
+	u8	ili		: 1;	/* Incorrect Length Indicator */
+	u8	eom		: 1;	/* End Of Medium */
+	u8	filemark	: 1;	/* Filemark */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8	valid		: 1;
+	u8	error_code	: 7;
+	u8	reserved1	: 8;
+	u8	filemark	: 1;
+	u8	eom		: 1;
+	u8	ili		: 1;
+	u8	reserved2_4	: 1;
+	u8	sense_key	: 4;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	u32	information __attribute__ ((packed));
+	u8	asl;			/* Additional sense length (n-7) */
+	u32	command_specific;	/* Additional command specific information */
+	u8	asc;			/* Additional Sense Code */
+	u8	ascq;			/* Additional Sense Code Qualifier */
+	u8	replaceable_unit_code;	/* Field Replaceable Unit Code */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8	sk_specific1	: 7;	/* Sense Key Specific */
+	u8	sksv		: 1;	/* Sense Key Specific information is valid */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8	sksv		: 1;	/* Sense Key Specific information is valid */
+	u8	sk_specific1	: 7;	/* Sense Key Specific */
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+	u8	sk_specific[2];		/* Sense Key Specific */
+	u8	pad[2];			/* Padding to 20 bytes */
+} atapi_request_sense_result_t;
diff -urN linux-2.5.24/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.24/include/linux/ide.h	2002-06-21 00:53:46.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-24 17:03:21.000000000 +0200
@@ -658,31 +658,7 @@
 extern void ata_read(struct ata_device *, void *, unsigned int);
 extern void ata_write(struct ata_device *, void *, unsigned int);
 
-/*
- * Special Flagged Register Validation Caller
- */
-
-/*
- * for now, taskfile requests are special :/
- */
-static inline char *ide_map_rq(struct request *rq, unsigned long *flags)
-{
-	if (rq->bio)
-		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
-	else
-		return rq->buffer + ((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE;
-}
-
-static inline void ide_unmap_rq(struct request *rq, char *to,
-				unsigned long *flags)
-{
-	if (rq->bio)
-		bio_kunmap_irq(to, flags);
-}
-
-extern ide_startstop_t ata_special_intr(struct ata_device *, struct request *);
-extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
-
+extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *, char *);
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_config_drive_speed(struct ata_device *, byte);
 extern byte eighty_ninty_three(struct ata_device *);
@@ -756,9 +732,12 @@
 
 static inline int udma_stop(struct ata_device *drive)
 {
+	int ret;
+
+	ret = drive->channel->udma_stop(drive);
 	clear_bit(IDE_DMA, drive->channel->active);
 
-	return drive->channel->udma_stop(drive);
+	return ret;
 }
 
 /*
@@ -766,9 +745,12 @@
  */
 static inline ide_startstop_t udma_init(struct ata_device *drive, struct request *rq)
 {
-	int ret = drive->channel->udma_init(drive, rq);
-	if (ret == ide_started)
-		set_bit(IDE_DMA, drive->channel->active);
+	int ret;
+
+	set_bit(IDE_DMA, drive->channel->active);
+	ret = drive->channel->udma_init(drive, rq);
+	if (ret != ide_started)
+		clear_bit(IDE_DMA, drive->channel->active);
 
 	return ret;
 }

--------------040007070507040603080003--

