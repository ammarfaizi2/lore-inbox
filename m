Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317916AbSFNOCz>; Fri, 14 Jun 2002 10:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317917AbSFNOCy>; Fri, 14 Jun 2002 10:02:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28173 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317916AbSFNOCU>; Fri, 14 Jun 2002 10:02:20 -0400
Message-ID: <3D09F769.8090704@evision-ventures.com>
Date: Fri, 14 Jun 2002 16:02:17 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 IDE 91
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000305090706060004000009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000305090706060004000009
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Thu Jun 13 22:59:54 CEST 2002 ide-clean-91

- Realize that the only place where ata_do_taskfile gets used is ide-disk.c
   move it and its "friends' over there.

- Unify the do_request method for disk devices. This saves quite a lot of code.

- Make task_muin_intr and task_in_intr use the same busy status checks on
   entry.

- Unfold get_command at the single only place where it's used.

- Add missing __ata_end_request on kill_rq path.

- Rename udma_tcq_taskfile() to udma_tcq_init to make the code look like to
   normal udma_init. Revert the logics of udma_init and it's
   implementations to mirror that of udma_tcq_init().

- Fix a tinny bug in pmac_udma_init() where it was reporting the wrong value up
   on failure.

- Revert the logics of udma_start(). It's called from udma_init context.
   Realize that it is always returning ide_started. Make it self and the
   implementations of it return void.


--------------000305090706060004000009
Content-Type: text/plain;
 name="ide-clean-91.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-91.diff"

diff -urN linux-2.5.21/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.21/drivers/ide/alim15x3.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-06-14 14:23:39.000000000 +0200
@@ -259,7 +259,7 @@
 static int ali15x3_udma_init(struct ata_device *drive, struct request *rq)
 {
 	if ((m5229_revision < 0xC2) && (drive->type != ATA_DISK))
-		return 1;	/* try PIO instead of DMA */
+		return ide_stopped;	/* try PIO instead of DMA */
 
 	return udma_pci_init(drive, rq);
 }
diff -urN linux-2.5.21/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.21/drivers/ide/hpt34x.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-06-14 14:20:16.000000000 +0200
@@ -175,7 +175,7 @@
 	u8 cmd;
 
 	if (!(count = udma_new_table(drive, rq)))
-		return 1;	/* try PIO instead of DMA */
+		return ide_stopped;	/* try PIO instead of DMA */
 
 	if (rq_data_dir(rq) == READ)
 		cmd = 0x09;
@@ -192,7 +192,7 @@
 		OUT_BYTE((cmd == 0x09) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 	}
 
-	return 0;
+	return ide_started;
 }
 #endif
 
diff -urN linux-2.5.21/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.21/drivers/ide/hpt366.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-06-14 15:11:39.000000000 +0200
@@ -858,7 +858,7 @@
 	udelay(10);
 }
 
-static int hpt370_udma_start(struct ata_device *drive, struct request *__rq)
+static void hpt370_udma_start(struct ata_device *drive, struct request *__rq)
 {
 	struct ata_channel *ch = drive->channel;
 
@@ -870,8 +870,6 @@
 	 */
 
 	outb(inb(ch->dma_base) | 1, ch->dma_base);	/* start DMA */
-
-	return 0;
 }
 
 static void do_timeout_irq(struct ata_device *drive)
diff -urN linux-2.5.21/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.21/drivers/ide/icside.c	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-06-14 15:11:08.000000000 +0200
@@ -447,18 +447,13 @@
 	return get_dma_residue(ch->hw.dma) != 0;
 }
 
-static int icside_dma_start(struct ata_device *drive, struct request *rq)
+static void icside_dma_start(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
 
-	/*
-	 * We can not enable DMA on both channels.
-	 */
+	/* We can not enable DMA on both channels simultaneously. */
 	BUG_ON(dma_channel_active(ch->hw.dma));
-
 	enable_dma(ch->hw.dma);
-
-	return 0;
 }
 
 /*
@@ -524,10 +519,10 @@
 	u8 int cmd;
 
 	if (icside_dma_common(drive, rq, DMA_MODE_WRITE))
-		return 1;
+		return ide_stopped;
 
 	if (drive->type != ATA_DISK)
-		return 0;
+		return ide_started;
 
 	ata_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
 
@@ -543,7 +538,7 @@
 
 	enable_dma(ch->hw.dma);
 
-	return 0;
+	return ide_started;
 }
 
 static int icside_irq_status(struct ata_device *drive)
diff -urN linux-2.5.21/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.21/drivers/ide/ide.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-14 13:18:44.000000000 +0200
@@ -702,7 +702,8 @@
 			spin_unlock_irq(ch->lock);
 			ata_ops(drive)->end_request(drive, rq, 0);
 			spin_lock_irq(ch->lock);
-		}
+		} else
+			__ata_end_request(drive, rq, 0, 0);
 	} else
 		__ata_end_request(drive, rq, 0, 0);
 
diff -urN linux-2.5.21/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.21/drivers/ide/ide-cd.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-14 14:23:18.000000000 +0200
@@ -741,7 +741,7 @@
 	else {
 		if (info->dma) {
 			if (info->cmd == READ || info->cmd == WRITE)
-				info->dma = !udma_init(drive, rq);
+				info->dma = udma_init(drive, rq);
 			else
 				printk("ide-cd: DMA set, but not allowed\n");
 		}
diff -urN linux-2.5.21/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.21/drivers/ide/ide-disk.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-14 14:18:25.000000000 +0200
@@ -102,40 +102,44 @@
 	spin_lock_irqsave(ch->lock, flags);
 
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT)) {
+		if (drive->status & (ERR_STAT | DRQ_STAT)) {
 			spin_unlock_irqrestore(ch->lock, flags);
 
 			return ata_error(drive, rq, __FUNCTION__);
 		}
 
-		if (!(drive->status & BUSY_STAT)) {
-//			printk("task_in_intr to Soon wait for next interrupt\n");
-			ata_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
-			spin_unlock_irqrestore(ch->lock, flags);
+		/* no data yet, so wait for another interrupt */
+		ata_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
 
-			return ide_started;
+		ret = ide_started;
+	} else {
+
+		//	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
+		{
+			unsigned long flags;
+			char *buf;
+
+			buf = ide_map_rq(rq, &flags);
+			ata_read(drive, buf, SECTOR_WORDS);
+			ide_unmap_rq(rq, buf, &flags);
 		}
-	}
 
-//	printk("Read: %p, rq->current_nr_sectors: %d\n", buf, (int) rq->current_nr_sectors);
-	{
-		unsigned long flags;
-		char *buf;
-
-		buf = ide_map_rq(rq, &flags);
-		ata_read(drive, buf, SECTOR_WORDS);
-		ide_unmap_rq(rq, buf, &flags);
-	}
+		/* First segment of the request is complete. note that this does not
+		 * necessarily mean that the entire request is done!! this is only true
+		 * if ata_end_request() returns 0.
+		 */
+		rq->errors = 0;
+		--rq->current_nr_sectors;
 
-	/* First segment of the request is complete. note that this does not
-	 * necessarily mean that the entire request is done!! this is only true
-	 * if ata_end_request() returns 0.
-	 */
+		if (rq->current_nr_sectors <= 0) {
+			if (!__ata_end_request(drive, rq, 1, 0)) {
+			//		printk("Request Ended stat: %02x\n", drive->status);
+				spin_unlock_irqrestore(ch->lock, flags);
+
+				return ide_stopped;
+			}
+		}
 
-	if (--rq->current_nr_sectors <= 0 && !__ata_end_request(drive, rq, 1, 0)) {
-//		printk("Request Ended stat: %02x\n", drive->status);
-		ret = ide_stopped;
-	} else {
 		/* still data left to transfer */
 		ata_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
 
@@ -197,7 +201,7 @@
 
 	spin_lock_irqsave(ch->lock, flags);
 	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
-		if (drive->status & (ERR_STAT|DRQ_STAT)) {
+		if (drive->status & (ERR_STAT | DRQ_STAT)) {
 			spin_unlock_irqrestore(ch->lock, flags);
 
 			return ata_error(drive, rq, __FUNCTION__);
@@ -235,16 +239,16 @@
 
 			rq->errors = 0;
 			rq->current_nr_sectors -= nsect;
-			msect -= nsect;
 
 			/* FIXME: this seems buggy */
-			if (!rq->current_nr_sectors) {
+			if (rq->current_nr_sectors <= 0) {
 				if (!__ata_end_request(drive, rq, 1, 0)) {
 					spin_unlock_irqrestore(ch->lock, flags);
 
 					return ide_stopped;
 				}
 			}
+			msect -= nsect;
 		} while (msect);
 
 		/* more data left */
@@ -343,212 +347,138 @@
 }
 
 /*
- * Decode with physical ATA command to use and setup associated data.
+ * Channel lock should be held on entry.
  */
-static u8 get_command(struct ata_device *drive, struct ata_taskfile *ar, int cmd)
+static ide_startstop_t __do_request(struct ata_device *drive,
+		struct ata_taskfile *ar, struct request *rq)
 {
-	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
-
-#if 1
-	lba48bit = drive->addressing;
-#endif
-
-	if (lba48bit) {
-		if (cmd == READ) {
-			ar->command_type = IDE_DRIVE_TASK_IN;
-			if (drive->using_tcq) {
-				return WIN_READDMA_QUEUED_EXT;
-			} else if (drive->using_dma) {
-				return WIN_READDMA_EXT;
-			} else if (drive->mult_count) {
-				ar->handler = task_mulin_intr;
-				return WIN_MULTREAD_EXT;
-			} else {
-				ar->handler = task_in_intr;
-				return WIN_READ_EXT;
-			}
-		} else if (cmd == WRITE) {
-			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
-			if (drive->using_tcq) {
-				return WIN_WRITEDMA_QUEUED_EXT;
-			} else if (drive->using_dma) {
-				return WIN_WRITEDMA_EXT;
-			} else if (drive->mult_count) {
-				ar->handler = task_mulout_intr;
-				return WIN_MULTWRITE_EXT;
-			} else {
-				ar->handler = task_out_intr;
-				return WIN_WRITE_EXT;
-			}
-		}
-	} else {
-		if (cmd == READ) {
-			ar->command_type = IDE_DRIVE_TASK_IN;
-			if (drive->using_tcq) {
-				return WIN_READDMA_QUEUED;
-			} else if (drive->using_dma) {
-				return WIN_READDMA;
-			} else if (drive->mult_count) {
-				ar->handler = task_in_intr;
-				return WIN_MULTREAD;
-			} else {
-				ar->handler = task_in_intr;
-				return WIN_READ;
-			}
-		} else if (cmd == WRITE) {
-			ar->command_type = IDE_DRIVE_TASK_RAW_WRITE;
-			if (drive->using_tcq) {
-				return WIN_WRITEDMA_QUEUED;
-			} else if (drive->using_dma) {
-				return WIN_WRITEDMA;
-			} else if (drive->mult_count) {
-				ar->handler = task_mulout_intr;
-				return WIN_MULTWRITE;
-			} else {
-				ar->handler = task_out_intr;
-				return WIN_WRITE;
-			}
-		}
-	}
-
-	/* not reached! */
-	return WIN_NOP;
-}
-
-static ide_startstop_t chs_do_request(struct ata_device *drive, struct request *rq, sector_t block)
-{
-	struct ata_taskfile args;
-	int sectors;
-
-	unsigned int track	= (block / drive->sect);
-	unsigned int sect	= (block % drive->sect) + 1;
-	unsigned int head	= (track % drive->head);
-	unsigned int cyl	= (track / drive->head);
-
-	sectors = rq->nr_sectors;
-	if (sectors == 256)
-		sectors = 0;
-
-	memset(&args, 0, sizeof(args));
-
-	if (blk_rq_tagged(rq)) {
-		args.taskfile.feature = sectors;
-		args.taskfile.sector_count = rq->tag << 3;
-	} else
-		args.taskfile.sector_count = sectors;
-
-	args.taskfile.sector_number = sect;
-	args.taskfile.low_cylinder = cyl;
-	args.taskfile.high_cylinder = (cyl>>8);
-
-	args.taskfile.device_head = head;
-	args.taskfile.device_head |= drive->select.all;
-	args.cmd = get_command(drive, &args, rq_data_dir(rq));
-
-#ifdef DEBUG
-	printk("%s: %sing: ", drive->name,
-		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
-	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=%p\n", rq->buffer);
-#endif
-
-	rq->special = &args;
-
-	return ata_do_taskfile(drive, &args, rq);
-}
-
-static ide_startstop_t lba28_do_request(struct ata_device *drive, struct request *rq, sector_t block)
-{
-	struct ata_taskfile args;
-	int sectors;
-
-	sectors = rq->nr_sectors;
-	if (sectors == 256)
-		sectors = 0;
-
-	memset(&args, 0, sizeof(args));
-
-	if (blk_rq_tagged(rq)) {
-		args.taskfile.feature = sectors;
-		args.taskfile.sector_count = rq->tag << 3;
-	} else
-		args.taskfile.sector_count = sectors;
-
-	args.taskfile.sector_number = block;
-	args.taskfile.low_cylinder = (block >>= 8);
-
-	args.taskfile.high_cylinder = (block >>= 8);
+	struct hd_driveid *id = drive->id;
 
-	args.taskfile.device_head = ((block >> 8) & 0x0f);
-	args.taskfile.device_head |= drive->select.all;
-	args.cmd = get_command(drive, &args, rq_data_dir(rq));
+	/* (ks/hs): Moved to start, do not use for multiple out commands.
+	 * FIXME: why not?! */
+	if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
+	      ar->cmd == WIN_MULTWRITE ||
+	      ar->cmd == WIN_MULTWRITE_EXT)) {
+		ata_irq_enable(drive, 1);
+		ata_mask(drive);
+	}
+
+	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400) &&
+	    (drive->addressing == 1))
+		ata_out_regfile(drive, &ar->hobfile);
+
+	ata_out_regfile(drive, &ar->taskfile);
+
+	OUT_BYTE((ar->taskfile.device_head & (drive->addressing ? 0xE0 : 0xEF)) | drive->select.all,
+			IDE_SELECT_REG);
+
+	if (ar->XXX_handler) {
+		struct ata_channel *ch = drive->channel;
+
+		ata_set_handler(drive, ar->XXX_handler, WAIT_CMD, NULL);
+		OUT_BYTE(ar->cmd, IDE_COMMAND_REG);
+
+		/* FIXME: Warning check for race between handler and prehandler
+		 * for writing first block of data.  however since we are well
+		 * inside the boundaries of the seek, we should be okay.
+		 *
+		 * FIXME: Replace the switch by using a proper command_type.
+		 */
 
-#ifdef DEBUG
-	printk("%s: %sing: ", drive->name,
-		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
-	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=%p\n", rq->buffer);
-#endif
+		if (ar->cmd == CFA_WRITE_SECT_WO_ERASE ||
+		    ar->cmd == WIN_WRITE ||
+		    ar->cmd == WIN_WRITE_EXT ||
+		    ar->cmd == WIN_WRITE_VERIFY ||
+		    ar->cmd == WIN_WRITE_BUFFER ||
+		    ar->cmd == WIN_DOWNLOAD_MICROCODE ||
+		    ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
+		    ar->cmd == WIN_MULTWRITE ||
+		    ar->cmd == WIN_MULTWRITE_EXT) {
+			ide_startstop_t startstop;
+
+			if (ata_status_poll(drive, DATA_READY, drive->bad_wstat,
+						WAIT_DRQ, rq, &startstop)) {
+				printk(KERN_ERR "%s: no DRQ after issuing %s\n",
+						drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
 
-	rq->special = &args;
+				return startstop;
+			}
 
-	return ata_do_taskfile(drive, &args, rq);
-}
+			/* FIXME: This doesn't make the slightest sense.
+			 * (ks/hs): Fixed Multi Write
+			 */
+			if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
+			      ar->cmd == WIN_MULTWRITE ||
+			      ar->cmd == WIN_MULTWRITE_EXT)) {
+				unsigned long flags;
+				char *buf = ide_map_rq(rq, &flags);
 
-/*
- * 268435455  == 137439 MB or 28bit limit
- * 320173056  == 163929 MB or 48bit addressing
- * 1073741822 == 549756 MB or 48bit addressing fake drive
- */
+				/* For Write_sectors we need to stuff the first sector */
+				ata_write(drive, buf, SECTOR_WORDS);
 
-static ide_startstop_t lba48_do_request(struct ata_device *drive, struct request *rq, sector_t block)
-{
-	struct ata_taskfile args;
-	int sectors;
+				rq->current_nr_sectors--;
+				ide_unmap_rq(rq, buf, &flags);
 
-	sectors = rq->nr_sectors;
-	if (sectors == 65536)
-		sectors = 0;
+				return ide_started;
+			} else {
+				int i;
+				int ret;
 
-	memset(&args, 0, sizeof(args));
+				/* Polling wait until the drive is ready.
+				 *
+				 * Stuff the first sector(s) by calling the
+				 * handler driectly therafter.
+				 *
+				 * FIXME: Replace hard-coded 100, what about
+				 * error handling?
+				 */
+
+				for (i = 0; i < 100; ++i) {
+					if (drive_is_ready(drive))
+						break;
+				}
+				if (!drive_is_ready(drive)) {
+					printk(KERN_ERR "DISASTER WAITING TO HAPPEN!\n");
+				}
+				/* FIXME: make this unlocking go away*/
+				spin_unlock_irq(ch->lock);
+				ret =  ar->XXX_handler(drive, rq);
+				spin_lock_irq(ch->lock);
 
-	if (blk_rq_tagged(rq)) {
-		args.taskfile.feature = sectors;
-		args.hobfile.feature = sectors >> 8;
-		args.taskfile.sector_count = rq->tag << 3;
+				return ret;
+			}
+		}
 	} else {
-		args.taskfile.sector_count = sectors;
-		args.hobfile.sector_count = sectors >> 8;
-	}
-
-	args.taskfile.sector_number = block;		/* low lba */
-	args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
-	args.taskfile.high_cylinder = (block >>= 8);	/* hi  lba */
-	args.taskfile.device_head = drive->select.all;
-
-	args.hobfile.sector_number = (block >>= 8);	/* low lba */
-	args.hobfile.low_cylinder = (block >>= 8);	/* mid lba */
-	args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
-	args.hobfile.device_head = drive->select.all;
+		/*
+		 * FIXME: This is a gross hack, need to unify tcq dma proc and
+		 * regular dma proc. It should now be easier.
+		 *
+		 * FIXME: Handle the alternateives by a command type.
+		 */
 
-	args.cmd = get_command(drive, &args, rq_data_dir(rq));
+		if (!drive->using_dma)
+			return ide_started;
 
-#ifdef DEBUG
-	printk("%s: %sing: ", drive->name,
-		(rq_data_dir(rq)==READ) ? "read" : "writ");
-	if (lba)	printk("LBAsect=%lld, ", block);
-	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
-	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=%p\n",rq->buffer);
+		/* for dma commands we don't set the handler */
+		if (ar->cmd == WIN_WRITEDMA ||
+		    ar->cmd == WIN_WRITEDMA_EXT ||
+		    ar->cmd == WIN_READDMA ||
+		    ar->cmd == WIN_READDMA_EXT)
+			return udma_init(drive, rq);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		else if (ar->cmd == WIN_WRITEDMA_QUEUED ||
+			 ar->cmd == WIN_WRITEDMA_QUEUED_EXT ||
+			 ar->cmd == WIN_READDMA_QUEUED ||
+			 ar->cmd == WIN_READDMA_QUEUED_EXT)
+			return udma_tcq_init(drive, rq);
 #endif
+		else {
+			printk(KERN_ERR "%s: unknown command %x\n", __FUNCTION__, ar->cmd);
+			return ide_stopped;
+		}
+	}
 
-	rq->special = &args;
-
-	return ata_do_taskfile(drive, &args, rq);
+	return ide_started;
 }
 
 /*
@@ -560,10 +490,13 @@
  */
 static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
+	struct ata_taskfile args;
+	unsigned int sectors;
+
 	/* This issues a special drive command.
 	 */
 	if (rq->flags & REQ_SPECIAL)
-		return ata_do_taskfile(drive, rq->special, rq);
+		return __do_request(drive, rq->special, rq);
 
 	/* FIXME: this check doesn't make sense */
 	if (!(rq->flags & REQ_CMD)) {
@@ -597,15 +530,150 @@
 		}
 	}
 
-	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
-		return lba48_do_request(drive, rq, block);
-	else if (drive->select.b.lba)
-		return lba28_do_request(drive, rq, block);
-	else
-		return chs_do_request(drive, rq, block);
+	memset(&args, 0, sizeof(args));
+	sectors = rq->nr_sectors;
+	/* Dispatch depending up on the drive access method. */
+	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing)) {
+		/* LBA 48 bit */
+		/*
+		 * 268435455  == 137439 MB or 28bit limit
+		 * 320173056  == 163929 MB or 48bit addressing
+		 * 1073741822 == 549756 MB or 48bit addressing fake drive
+		 */
+		if (sectors == 65536)
+			sectors = 0;
+
+		if (blk_rq_tagged(rq)) {
+			args.taskfile.feature = sectors;
+			args.hobfile.feature = sectors >> 8;
+			args.taskfile.sector_count = rq->tag << 3;
+		} else {
+			args.taskfile.sector_count = sectors;
+			args.hobfile.sector_count = sectors >> 8;
+		}
+
+		args.taskfile.sector_number = block;		/* low lba */
+		args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
+		args.taskfile.high_cylinder = (block >>= 8);	/* hi  lba */
+		args.taskfile.device_head = drive->select.all;
+
+		args.hobfile.sector_number = (block >>= 8);	/* low lba */
+		args.hobfile.low_cylinder = (block >>= 8);	/* mid lba */
+		args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
+	} else if (drive->select.b.lba) {
+		/* LBA 28 bit  */
+		if (sectors == 256)
+			sectors = 0;
+
+		if (blk_rq_tagged(rq)) {
+			args.taskfile.feature = sectors;
+			args.taskfile.sector_count = rq->tag << 3;
+		} else
+			args.taskfile.sector_count = sectors;
+
+		args.taskfile.sector_number = block;
+		args.taskfile.low_cylinder = (block >>= 8);
+		args.taskfile.high_cylinder = (block >>= 8);
+		args.taskfile.device_head = ((block >> 8) & 0x0f);
+	} else {
+		/* CHS */
+		unsigned int track	= (block / drive->sect);
+		unsigned int sect	= (block % drive->sect) + 1;
+		unsigned int head	= (track % drive->head);
+		unsigned int cyl	= (track / drive->head);
+
+		if (sectors == 256)
+			sectors = 0;
+
+		if (blk_rq_tagged(rq)) {
+			args.taskfile.feature = sectors;
+			args.taskfile.sector_count = rq->tag << 3;
+		} else
+			args.taskfile.sector_count = sectors;
+
+		args.taskfile.sector_number = sect;
+		args.taskfile.low_cylinder = cyl;
+		args.taskfile.high_cylinder = (cyl>>8);
+		args.taskfile.device_head = head;
+	}
+	args.taskfile.device_head |= drive->select.all;
+
+	/*
+	 * Decode with physical ATA command to use and setup associated data.
+	 */
+
+	if (rq_data_dir(rq) == READ) {
+		args.command_type = IDE_DRIVE_TASK_IN;
+		if (drive->addressing) {
+			if (drive->using_tcq) {
+				args.cmd = WIN_READDMA_QUEUED_EXT;
+			} else if (drive->using_dma) {
+				args.cmd = WIN_READDMA_EXT;
+			} else if (drive->mult_count) {
+				args.XXX_handler = task_mulin_intr;
+				args.cmd = WIN_MULTREAD_EXT;
+			} else {
+				args.XXX_handler = task_in_intr;
+				args.cmd = WIN_READ_EXT;
+			}
+		} else {
+			if (drive->using_tcq) {
+				args.cmd = WIN_READDMA_QUEUED;
+			} else if (drive->using_dma) {
+				args.cmd = WIN_READDMA;
+			} else if (drive->mult_count) {
+				/* FIXME : Shouldn't this be task_mulin_intr?! */
+				args.XXX_handler = task_in_intr;
+				args.cmd = WIN_MULTREAD;
+			} else {
+				args.XXX_handler = task_in_intr;
+				args.cmd = WIN_READ;
+			}
+		}
+	} else {
+		args.command_type = IDE_DRIVE_TASK_RAW_WRITE;
+		if (drive->addressing) {
+			if (drive->using_tcq) {
+				args.cmd = WIN_WRITEDMA_QUEUED_EXT;
+			} else if (drive->using_dma) {
+				args.cmd = WIN_WRITEDMA_EXT;
+			} else if (drive->mult_count) {
+				args.XXX_handler = task_mulout_intr;
+				args.cmd = WIN_MULTWRITE_EXT;
+			} else {
+				args.XXX_handler = task_out_intr;
+				args.cmd = WIN_WRITE_EXT;
+			}
+		} else {
+			if (drive->using_tcq) {
+				args.cmd = WIN_WRITEDMA_QUEUED;
+			} else if (drive->using_dma) {
+				args.cmd = WIN_WRITEDMA;
+			} else if (drive->mult_count) {
+				args.XXX_handler = task_mulout_intr;
+				args.cmd = WIN_MULTWRITE;
+			} else {
+				args.XXX_handler = task_out_intr;
+				args.cmd = WIN_WRITE;
+			}
+		}
+	}
+
+
+#ifdef DEBUG
+	printk("%s: %sing: ", drive->name,
+			(rq_data_dir(rq)==READ) ? "read" : "writ");
+	if (lba)	printk("LBAsect=%lld, ", block);
+	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
+	printk("sectors=%ld, ", rq->nr_sectors);
+	printk("buffer=%p\n", rq->buffer);
+#endif
+	rq->special = &args;
+
+	return __do_request(drive, &args, rq);
 }
 
-static int idedisk_open(struct inode *inode, struct file *filp, struct ata_device *drive)
+static int idedisk_open(struct inode *inode, struct file *__fp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
 	if (drive->removable && drive->usage == 1) {
diff -urN linux-2.5.21/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.21/drivers/ide/ide-floppy.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-14 14:21:59.000000000 +0200
@@ -1102,7 +1102,7 @@
 		udma_enable(drive, 0, 1);
 
 	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
-		dma_ok = !udma_init(drive, rq);
+		dma_ok = udma_init(drive, rq);
 #endif
 
 	ata_irq_enable(drive, 1);
diff -urN linux-2.5.21/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.21/drivers/ide/ide-pmac.c	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-14 15:03:31.000000000 +0200
@@ -1365,7 +1365,8 @@
 	 */
 	ix = pmac_ide_find(drive);
 	if (ix < 0)
-		return 0;
+		return ide_started;
+
 	dma = pmac_ide[ix].dma_regs;
 	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
 		pmac_ide[ix].kind == controller_kl_ata4_80);
@@ -1373,7 +1374,8 @@
 	out_le32(&dma->control, (RUN << 16) | RUN);
 	/* Make sure it gets to the controller right now */
 	(void)in_le32(&dma->control);
-	return 0;
+
+	return ide_started;
 }
 
 static int pmac_udma_stop(struct ata_device *drive)
@@ -1411,7 +1413,7 @@
 	 */
 	ix = pmac_ide_find(drive);
 	if (ix < 0)
-		return 0;
+		return ide_stopped;
 
 	if (rq_data_dir(rq) == READ)
 		reading = 1;
@@ -1423,7 +1425,7 @@
 		pmac_ide[ix].kind == controller_kl_ata4_80);
 
 	if (!pmac_ide_build_dmatable(drive, rq, ix, !reading))
-		return 1;
+		return ide_stopped;
 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
 		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
@@ -1433,7 +1435,7 @@
 	}
 	drive->waiting_for_dma = 1;
 	if (drive->type != ATA_DISK)
-		return 0;
+		return ide_started;
 
 	ata_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
 	if ((rq->flags & REQ_SPECIAL) &&
@@ -1447,7 +1449,9 @@
 		OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 	}
 
-	return udma_start(drive, rq);
+	udma_start(drive, rq);
+
+	return ide_started;
 }
 
 /*
diff -urN linux-2.5.21/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.21/drivers/ide/ide-tape.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-14 14:20:30.000000000 +0200
@@ -2290,7 +2290,7 @@
 		udma_enable(drive, 0, 1);
 	}
 	if (test_bit (PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
-		dma_ok = !udma_init(drive, rq);
+		dma_ok = udma_init(drive, rq);
 #endif
 
 	ata_irq_enable(drive, 1);
diff -urN linux-2.5.21/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.21/drivers/ide/ide-taskfile.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-14 02:04:27.000000000 +0200
@@ -177,145 +177,6 @@
 }
 
 /*
- * Channel lock should be held on entry.
- */
-ide_startstop_t ata_do_taskfile(struct ata_device *drive,
-		struct ata_taskfile *ar, struct request *rq)
-{
-	struct hd_driveid *id = drive->id;
-
-	/* (ks/hs): Moved to start, do not use for multiple out commands.
-	 * FIXME: why not?! */
-	if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
-	      ar->cmd == WIN_MULTWRITE ||
-	      ar->cmd == WIN_MULTWRITE_EXT)) {
-		ata_irq_enable(drive, 1);
-		ata_mask(drive);
-	}
-
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1))
-		ata_out_regfile(drive, &ar->hobfile);
-
-	ata_out_regfile(drive, &ar->taskfile);
-
-	OUT_BYTE((ar->taskfile.device_head & (drive->addressing ? 0xE0 : 0xEF)) | drive->select.all,
-			IDE_SELECT_REG);
-
-	if (ar->handler) {
-		struct ata_channel *ch = drive->channel;
-
-		/* This is apparently supposed to reset the wait timeout for
-		 * the interrupt to accur.
-		 */
-
-		ata_set_handler(drive, ar->handler, WAIT_CMD, NULL);
-		OUT_BYTE(ar->cmd, IDE_COMMAND_REG);
-
-		/* FIXME: Warning check for race between handler and prehandler
-		 * for writing first block of data.  however since we are well
-		 * inside the boundaries of the seek, we should be okay.
-		 *
-		 * FIXME: Replace the switch by using a proper command_type.
-		 */
-
-		if (ar->cmd == CFA_WRITE_SECT_WO_ERASE ||
-		    ar->cmd == WIN_WRITE ||
-		    ar->cmd == WIN_WRITE_EXT ||
-		    ar->cmd == WIN_WRITE_VERIFY ||
-		    ar->cmd == WIN_WRITE_BUFFER ||
-		    ar->cmd == WIN_DOWNLOAD_MICROCODE ||
-		    ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
-		    ar->cmd == WIN_MULTWRITE ||
-		    ar->cmd == WIN_MULTWRITE_EXT) {
-			ide_startstop_t startstop;
-
-			if (ata_status_poll(drive, DATA_READY, drive->bad_wstat,
-						WAIT_DRQ, rq, &startstop)) {
-				printk(KERN_ERR "%s: no DRQ after issuing %s\n",
-						drive->name, drive->mult_count ? "MULTWRITE" : "WRITE");
-
-				return startstop;
-			}
-
-			/* FIXME: This doesn't make the slightest sense.
-			 * (ks/hs): Fixed Multi Write
-			 */
-			if (!(ar->cmd == CFA_WRITE_MULTI_WO_ERASE ||
-			      ar->cmd == WIN_MULTWRITE ||
-			      ar->cmd == WIN_MULTWRITE_EXT)) {
-				unsigned long flags;
-				char *buf = ide_map_rq(rq, &flags);
-
-				/* For Write_sectors we need to stuff the first sector */
-				ata_write(drive, buf, SECTOR_WORDS);
-
-				rq->current_nr_sectors--;
-				ide_unmap_rq(rq, buf, &flags);
-
-				return ide_started;
-			} else {
-				int i;
-				int ret;
-
-				/* Polling wait until the drive is ready.
-				 *
-				 * Stuff the first sector(s) by calling the
-				 * handler driectly therafter.
-				 *
-				 * FIXME: Replace hard-coded 100, what about
-				 * error handling?
-				 */
-
-				for (i = 0; i < 100; ++i) {
-					if (drive_is_ready(drive))
-						break;
-				}
-				if (!drive_is_ready(drive)) {
-					printk(KERN_ERR "DISASTER WAITING TO HAPPEN!\n");
-				}
-				/* FIXME: make this unlocking go away*/
-				spin_unlock_irq(ch->lock);
-				ret =  ar->handler(drive, rq);
-				spin_lock_irq(ch->lock);
-
-				return ret;
-			}
-		}
-	} else {
-		/*
-		 * FIXME: This is a gross hack, need to unify tcq dma proc and
-		 * regular dma proc. It should now be easier.
-		 *
-		 * FIXME: Handle the alternateives by a command type.
-		 */
-
-		if (!drive->using_dma)
-			return ide_started;
-
-		/* for dma commands we don't set the handler */
-		if (ar->cmd == WIN_WRITEDMA ||
-		    ar->cmd == WIN_WRITEDMA_EXT ||
-		    ar->cmd == WIN_READDMA ||
-		    ar->cmd == WIN_READDMA_EXT)
-			return !udma_init(drive, rq);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-		else if (ar->cmd == WIN_WRITEDMA_QUEUED ||
-			 ar->cmd == WIN_WRITEDMA_QUEUED_EXT ||
-			 ar->cmd == WIN_READDMA_QUEUED ||
-			 ar->cmd == WIN_READDMA_QUEUED_EXT)
-			return udma_tcq_taskfile(drive, rq);
-#endif
-		else {
-			printk(KERN_ERR "%s: unknown command %x\n", __FUNCTION__, ar->cmd);
-			return ide_stopped;
-		}
-	}
-
-	return ide_started;
-}
-
-/*
  * This function issues a special IDE device request onto the request queue.
  *
  * If action is ide_wait, then the rq is queued at the end of the request
@@ -436,7 +297,7 @@
 	struct request req;
 
 	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
-	ar->handler = ata_special_intr;
+	ar->XXX_handler = ata_special_intr;
 
 	memset(&req, 0, sizeof(req));
 	req.flags = REQ_SPECIAL;
@@ -449,6 +310,5 @@
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
-EXPORT_SYMBOL(ata_do_taskfile);
 EXPORT_SYMBOL(ata_special_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -urN linux-2.5.21/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.21/drivers/ide/ioctl.c	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-14 02:08:02.000000000 +0200
@@ -54,9 +54,6 @@
 	if (copy_from_user(vals, (void *)arg, 4))
 		return -EFAULT;
 
-	memset(&req, 0, sizeof(req));
-	req.flags = REQ_SPECIAL;
-
 	memset(&args, 0, sizeof(args));
 
 	args.taskfile.feature = vals[2];
@@ -83,10 +80,14 @@
 
 	/* Issue ATA command and wait for completion.
 	 */
-	args.handler = ata_special_intr;
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.XXX_handler = ata_special_intr;
 
-	req.buffer = argbuf + 4;
+	memset(&req, 0, sizeof(req));
+	req.flags = REQ_SPECIAL;
 	req.special = &args;
+
+	req.buffer = argbuf + 4;
 	err = ide_do_drive_cmd(drive, &req, ide_wait);
 
 	argbuf[0] = drive->status;
diff -urN linux-2.5.21/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.21/drivers/ide/ns87415.c	2002-06-09 07:28:49.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-06-14 14:27:42.000000000 +0200
@@ -105,12 +105,12 @@
 {
 	ns87415_prepare_drive(drive, 1);	/* select DMA xfer */
 
-	if (!udma_pci_init(drive, rq))		/* use standard DMA stuff */
-		return 0;
+	if (udma_pci_init(drive, rq))		/* use standard DMA stuff */
+		return ide_started;
 
 	ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
 
-	return 1;
+	return ide_stopped;
 }
 
 static int ns87415_udma_setup(struct ata_device *drive)
diff -urN linux-2.5.21/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.21/drivers/ide/pcidma.c	2002-06-14 12:45:03.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-14 15:12:30.000000000 +0200
@@ -420,13 +420,11 @@
 	struct ata_channel *ch = drive->channel;
 	unsigned long dma_base = ch->dma_base;
 
-	/* Note that this is done *after* the cmd has
-	 * been issued to the drive, as per the BM-IDE spec.
-	 * The Promise Ultra33 doesn't work correctly when
-	 * we do this part before issuing the drive cmd.
+	/* Note that this is done *after* the cmd has been issued to the drive,
+	 * as per the BM-IDE spec.  The Promise Ultra33 doesn't work correctly
+	 * when we do this part before issuing the drive cmd.
 	 */
-	outb(inb(dma_base)|1, dma_base);		/* start DMA */
-	return 0;
+	outb(inb(dma_base) | 1, dma_base);	/* start DMA */
 }
 
 /*
@@ -545,11 +543,11 @@
 	u8 cmd;
 
 	if (ata_start_dma(drive, rq))
-		return 1;
+		return ide_stopped;
 
 	/* No DMA transfers on ATAPI devices. */
 	if (drive->type != ATA_DISK)
-		return 0;
+		return ide_started;
 
 	if (rq_data_dir(rq) == READ)
 		cmd = 0x08;
@@ -562,7 +560,9 @@
 	else
 		outb(cmd ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 
-	return udma_start(drive, rq);
+	udma_start(drive, rq);
+
+	return ide_started;
 }
 
 EXPORT_SYMBOL(ide_dma_intr);
diff -urN linux-2.5.21/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.21/drivers/ide/pdc202xx.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-06-14 15:13:37.000000000 +0200
@@ -573,8 +573,6 @@
 	 */
 
 	outb(inb(ch->dma_base) | 1, ch->dma_base); /* start DMA */
-
-	return 0;
 }
 
 int pdc202xx_udma_stop(struct ata_device *drive)
diff -urN linux-2.5.21/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.21/drivers/ide/pdc4030.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-06-14 02:09:46.000000000 +0200
@@ -784,7 +784,7 @@
 	args.taskfile.high_cylinder	= (block>>=8);
 	args.taskfile.device_head	= ((block>>8)&0x0f)|drive->select.all;
 	args.cmd = (rq_data_dir(rq) == READ) ? PROMISE_READ : PROMISE_WRITE;
-	args.handler	= NULL;
+	args.XXX_handler	= NULL;
 	rq->special	= &args;
 
 	return do_pdc4030_io(drive, &args, rq);
diff -urN linux-2.5.21/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.21/drivers/ide/sl82c105.c	2002-06-09 07:28:39.000000000 +0200
+++ linux/drivers/ide/sl82c105.c	2002-06-14 14:22:23.000000000 +0200
@@ -209,6 +209,7 @@
 static int sl82c105_dma_init(struct ata_device *drive, struct request *rq)
 {
 	sl82c105_reset_host(drive->channel->pci_dev);
+
 	return udma_pci_init(drive, rq);
 }
 
diff -urN linux-2.5.21/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.21/drivers/ide/tcq.c	2002-06-14 12:45:03.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-14 15:04:59.000000000 +0200
@@ -84,7 +84,7 @@
 {
 	struct ata_channel *ch = drive->channel;
 	request_queue_t *q = &drive->queue;
-	struct ata_taskfile *args;
+	struct ata_taskfile *ar;
 	struct request *rq;
 	unsigned long flags;
 
@@ -110,8 +110,8 @@
 	 * executed before any new commands are started. issue a NOP
 	 * to clear internal queue on drive.
 	 */
-	args = kmalloc(sizeof(*args), GFP_ATOMIC);
-	if (!args) {
+	ar = kmalloc(sizeof(*ar), GFP_ATOMIC);
+	if (!ar) {
 		printk(KERN_ERR "ATA: %s: failed to issue NOP\n", drive->name);
 		goto out;
 	}
@@ -126,10 +126,10 @@
 	 */
 	BUG_ON(!rq);
 
-	rq->special = args;
-	args->cmd = WIN_NOP;
-	args->handler = tcq_nop_handler;
-	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	rq->special = ar;
+	ar->cmd = WIN_NOP;
+	ar->XXX_handler = tcq_nop_handler;
+	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 
 	rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
 	_elv_add_request(q, rq, 0, 0);
@@ -539,10 +539,9 @@
 		return ide_stopped;
 
 	set_irq(drive, ide_dmaq_intr);
-	if (!udma_start(drive, rq))
-		return ide_started;
+	udma_start(drive, rq);
 
-	return ide_stopped;
+	return ide_started;
 }
 
 /*
@@ -550,7 +549,7 @@
  *
  * Channel lock should be held.
  */
-ide_startstop_t udma_tcq_taskfile(struct ata_device *drive, struct request *rq)
+ide_startstop_t udma_tcq_init(struct ata_device *drive, struct request *rq)
 {
 	u8 stat;
 	u8 feat;
diff -urN linux-2.5.21/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.21/drivers/ide/trm290.c	2002-06-14 12:45:00.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-06-14 15:12:48.000000000 +0200
@@ -179,7 +179,6 @@
 static int trm290_udma_start(struct ata_device *drive, struct request *__rq)
 {
 	/* Nothing to be done here. */
-	return 0;
 }
 
 static int trm290_udma_stop(struct ata_device *drive)
@@ -210,7 +209,7 @@
 #ifdef TRM290_NO_DMA_WRITES
 		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 
-		return 1;
+		return ide_stopped;
 #endif
 	} else {
 		reading = 2;
@@ -219,7 +218,7 @@
 
 	if (!(count = udma_new_table(drive, rq))) {
 		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
-		return 1;	/* try PIO instead of DMA */
+		return ide_stopped;	/* try PIO instead of DMA */
 	}
 
 	trm290_prepare_drive(drive, 1);	/* select DMA xfer */
@@ -233,7 +232,7 @@
 		outb(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 	}
 
-	return 0;
+	return ide_started;
 }
 
 static int trm290_udma_irq_status(struct ata_device *drive)
diff -urN linux-2.5.21/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.21/drivers/scsi/ide-scsi.c	2002-06-14 12:45:13.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-14 14:18:13.000000000 +0200
@@ -444,7 +444,7 @@
 	bcount = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
 	if (drive->using_dma && rq->bio)
-		dma_ok = !udma_init(drive, rq);
+		dma_ok = udma_init(drive, rq);
 
 	ata_select(drive, 10);
 	ata_irq_enable(drive, 1);
diff -urN linux-2.5.21/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.21/include/linux/ide.h	2002-06-14 12:45:13.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-14 15:14:20.000000000 +0200
@@ -459,9 +459,9 @@
 	int (*udma_setup)(struct ata_device *);
 
 	void (*udma_enable)(struct ata_device *, int, int);
-	int (*udma_start) (struct ata_device *, struct request *rq);
+	void (*udma_start) (struct ata_device *, struct request *);
 	int (*udma_stop) (struct ata_device *);
-	int (*udma_init) (struct ata_device *, struct request *rq);
+	int (*udma_init) (struct ata_device *, struct request *);
 	int (*udma_irq_status) (struct ata_device *);
 	void (*udma_timeout) (struct ata_device *);
 	void (*udma_irq_lost) (struct ata_device *);
@@ -651,15 +651,12 @@
 	struct hd_drive_task_hdr  hobfile;
 	u8 cmd;					/* actual ATA command */
 	int command_type;
-	ide_startstop_t (*handler)(struct ata_device *, struct request *);
+	ide_startstop_t (*XXX_handler)(struct ata_device *, struct request *);
 };
 
 extern void ata_read(struct ata_device *, void *, unsigned int);
 extern void ata_write(struct ata_device *, void *, unsigned int);
 
-extern ide_startstop_t ata_do_taskfile(struct ata_device *,
-	struct ata_taskfile *, struct request *);
-
 /*
  * Special Flagged Register Validation Caller
  */
@@ -751,9 +748,9 @@
 	drive->channel->udma_enable(drive, on, verbose);
 }
 
-static inline int udma_start(struct ata_device *drive, struct request *rq)
+static inline void udma_start(struct ata_device *drive, struct request *rq)
 {
-	return drive->channel->udma_start(drive, rq);
+	drive->channel->udma_start(drive, rq);
 }
 
 static inline int udma_stop(struct ata_device *drive)
@@ -764,7 +761,7 @@
 /*
  * Initiate actual DMA data transfer. The direction is encoded in the request.
  */
-static inline int udma_init(struct ata_device *drive, struct request *rq)
+static inline ide_startstop_t udma_init(struct ata_device *drive, struct request *rq)
 {
 	return drive->channel->udma_init(drive, rq);
 }
@@ -802,7 +799,7 @@
 extern int udma_black_list(struct ata_device *);
 extern int udma_white_list(struct ata_device *);
 
-extern ide_startstop_t udma_tcq_taskfile(struct ata_device *, struct request *);
+extern ide_startstop_t udma_tcq_init(struct ata_device *, struct request *);
 extern int udma_tcq_enable(struct ata_device *, int);
 
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);

--------------000305090706060004000009--

