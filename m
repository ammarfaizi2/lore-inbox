Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSFEOCD>; Wed, 5 Jun 2002 10:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSFEOCC>; Wed, 5 Jun 2002 10:02:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11781 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315431AbSFEOBv>; Wed, 5 Jun 2002 10:01:51 -0400
Message-ID: <3CFE0C16.1020203@evision-ventures.com>
Date: Wed, 05 Jun 2002 15:03:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: [PATCH] 2.5.20 IDE 85
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020200010506080706040302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200010506080706040302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue Jun  4 16:50:01 CEST 2002 ide-clean-85

- Work a bit on the automatic CRC error recovery handling. System still hangs.
   But one thing for sure - we don't have to use any specialized irq handler for
   it.

- Since ioctl don't any longer submit requests to the queue without
   rq->special set, we can safely remove args_error handling from
   start_request.

- Make REQ_SPECIAL usage in ide-floppy obvious.

- Use REQ_SPECIAL everywhere instead of REQ_DRIVE_ACB. This is actually a bit
   dangerous but should work as far as I can see.

- Unfold the now not REQ_SPECIAL specific dequeing part of ide_end_drive_cmd().
   Turns out that we can thereafter remove the calls to ide_end_drice_cmd() at
   places where the request type isn't REQ_SPECIAL all any longer. (tcq.c)


- After the above operation it turns out that there are just two places where
   ide_end_drive_cmd remains, namely: ata_error, task_no_data_intr
   drive_cmd_intr.

   We can avoid it by changing the logics in ata_error a slightly.

   So now just to cases remain where ide_end_drive_cmd remains used:
   drive_cmd_intr and task_no_data_intr.

- Now looking  a bit closer we can realize that drive_cmd_intr and
   task_no_data_intr can be easly merged together, since the usage of
   task_no_data_intr implied taskfile.sector_number == 0.

- Use one single ata_special_intr function for the handling of interrupts
   submitted through ide_raw_cmd.

- Move the remaining artefacts of ide_end_drive_cmd directly to
   ata_special_intr. Oh we don't need to check for REQ_SPECIAL any longer there,
   since the context is already known.

- Set the ata_special_intr handler and command type directly inside
   ide_raw_taskfile to save code.

--------------020200010506080706040302
Content-Type: text/plain;
 name="ide-clean-85.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-85.diff"

diff -urN linux-2.5.20/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.20/drivers/block/ll_rw_blk.c	2002-06-03 03:44:41.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-05 02:37:13.000000000 +0200
@@ -507,7 +507,6 @@
 	"REQ_STARTED",
 	"REQ_DONTPREP",
 	"REQ_QUEUED",
-	"REQ_DRIVE_ACB",
 	"REQ_PC",
 	"REQ_BLOCK_PC",
 	"REQ_SENSE",
diff -urN linux-2.5.20/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.20/drivers/ide/icside.c	2002-06-05 13:06:33.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-06-05 11:56:14.000000000 +0200
@@ -281,7 +281,7 @@
 	struct scatterlist *sg = ch->sg_table;
 	int nents;
 
-	if (rq->flags & REQ_DRIVE_ACB) {
+	if (rq->flags & REQ_SPECIAL) {
 		struct ata_taskfile *args = rq->special;
 
 		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
@@ -391,7 +391,7 @@
 		udma_tcq_enable(drive, 0);
 #endif
 	}
-	
+
 	/*
 	 * We don't need any bouncing.  Yes, this looks the
 	 * wrong way around, but it is correct.
@@ -492,7 +492,7 @@
 	 */
 	BUG_ON(dma_channel_active(ch->hw.dma));
 
-	count = ch->sg_nents = ide_build_sglist(ch, rq);
+	count = ch->sg_nents = ide_build_sglist(drive, rq);
 	if (!count)
 		return 1;
 
@@ -518,33 +518,6 @@
 	return 0;
 }
 
-static int icside_dma_read(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned int cmd;
-
-	if (icside_dma_common(drive, rq, DMA_MODE_READ))
-		return 1;
-
-	if (drive->type != ATA_DISK)
-		return 0;
-
-	ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
-
-	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
-		struct ata_taskfile *args = rq->special;
-		cmd = args->taskfile.command;
-	} else if (drive->addressing) {
-		cmd = WIN_READDMA_EXT;
-	} else {
-		cmd = WIN_READDMA;
-	}
-
-	OUT_BYTE(cmd, IDE_COMMAND_REG);
-	enable_dma(ch->hw.dma);
-	return 0;
-}
-
 static int icside_dma_init(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
@@ -558,13 +531,13 @@
 
 	ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
 
-	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
+	if ((rq->flags & REQ_SPECIAL) && drive->addressing == 1) {
 		struct ata_taskfile *args = rq->special;
-		cmd = args->taskfile.command;
+		cmd = args->cmd;
 	} else if (drive->addressing) {
-		cmd = WIN_WRITEDMA_EXT;
+		cmd = rq_data_dir(rq) == WRITE ? WIN_WRITEDMA_EXT : WIN_READDMA_EXT;
 	} else {
-		cmd = WIN_WRITEDMA;
+		cmd = rq_data_dir(rq) == WRITE ? WIN_WRITEDMA : WIN_READDMA;
 	}
 	OUT_BYTE(cmd, IDE_COMMAND_REG);
 
diff -urN linux-2.5.20/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.20/drivers/ide/ide.c	2002-06-05 13:06:36.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-05 02:37:13.000000000 +0200
@@ -389,37 +389,6 @@
 		 IN_BYTE(IDE_SECTOR_REG);
 }
 
-/*
- * Clean up after success/failure of an explicit drive cmd
- *
- * Should be called under lock held.
- */
-void ide_end_drive_cmd(struct ata_device *drive, struct request *rq)
-{
-	if (rq->flags & REQ_DRIVE_ACB) {
-		struct ata_taskfile *ar = rq->special;
-
-		rq->errors = !ata_status(drive, READY_STAT, BAD_STAT);
-		if (ar) {
-			ar->taskfile.feature = IN_BYTE(IDE_ERROR_REG);
-			ata_in_regfile(drive, &ar->taskfile);
-			ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
-			if ((drive->id->command_set_2 & 0x0400) &&
-			    (drive->id->cfs_enable_2 & 0x0400) &&
-			    (drive->addressing == 1)) {
-				/* The following command goes to the hob file! */
-				OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
-				ar->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
-				ata_in_regfile(drive, &ar->hobfile);
-			}
-		}
-	}
-
-	blkdev_dequeue_request(rq);
-	drive->rq = NULL;
-	end_that_request_last(rq);
-}
-
 #if FANCY_STATUS_DUMPS
 struct ata_bit_messages {
 	u8 mask;
@@ -552,25 +521,11 @@
 #endif
 
 /*
- * This is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
- *
- * FIXME: Why can't be just use task_no_data_intr here?
- */
-static ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
-{
-	if (!ata_status(drive, READY_STAT, BAD_STAT))
-		return ata_error(drive, rq, __FUNCTION__);
-
-	return ide_stopped;
-}
-
-/*
  * We are still on the old request path here so issuing the recalibrate command
  * directly should just work.
  */
 static int do_recalibrate(struct ata_device *drive)
 {
-	printk(KERN_INFO "%s: recalibrating!\n", drive->name);
 
 	if (drive->type != ATA_DISK)
 		return ide_stopped;
@@ -578,12 +533,12 @@
 	if (!IS_PDC4030_DRIVE) {
 		struct ata_taskfile args;
 
+		printk(KERN_INFO "%s: recalibrating...\n", drive->name);
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_count = drive->sect;
 		args.cmd = WIN_RESTORE;
-		args.handler = recal_intr;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-		ata_taskfile(drive, &args, NULL);
+		ide_raw_taskfile(drive, &args);
+		printk(KERN_INFO "%s: done!\n", drive->name);
 	}
 
 	return IS_PDC4030_DRIVE ? ide_stopped : ide_started;
@@ -604,7 +559,6 @@
 	/* retry only "normal" I/O: */
 	if (!(rq->flags & REQ_CMD)) {
 		rq->errors = 1;
-		ide_end_drive_cmd(drive, rq);
 
 		return ide_stopped;
 	}
@@ -633,6 +587,7 @@
 		OUT_BYTE(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);	/* force an abort */
 
 	if (rq->errors >= ERROR_MAX) {
+		printk(KERN_ERR "%s: max number of retries exceeded!\n", drive->name);
 		if (ata_ops(drive) && ata_ops(drive)->end_request)
 			ata_ops(drive)->end_request(drive, rq, 0);
 		else
@@ -729,10 +684,10 @@
 
 	/* Strange disk manager remap.
 	 */
-	if ((rq->flags & REQ_CMD) &&
-	    (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)) {
-		block += drive->sect0;
-	}
+	if (rq->flags & REQ_CMD)
+		if (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)
+			block += drive->sect0;
+
 
 	/* Yecch - this will shift the entire interval, possibly killing some
 	 * innocent following sector.
@@ -753,14 +708,8 @@
 
 	/* This issues a special drive command.
 	 */
-	if (rq->flags & REQ_DRIVE_ACB) {
-		struct ata_taskfile *ar = rq->special;
-
-		if (!(ar))
-			goto args_error;
-
-		return ata_taskfile(drive, ar, NULL);
-	}
+	if (rq->flags & REQ_SPECIAL)
+		return ata_taskfile(drive, rq->special, NULL);
 
 	/* The normal way of execution is to pass and execute the request
 	 * handler down to the device type driver.
@@ -789,19 +738,6 @@
 		ide_end_request(drive, rq, 0);
 
 	return ide_stopped;
-
-args_error:
-
-	/* NULL as arguemnt is used by ioctls as a way of waiting for all
-	 * current requests to be flushed from the queue.
-	 */
-
-#ifdef DEBUG
-	printk("%s: DRIVE_CMD (null)\n", drive->name);
-#endif
-	ide_end_drive_cmd(drive, rq);
-
-	return ide_stopped;
 }
 
 ide_startstop_t restart_request(struct ata_device *drive)
@@ -1485,8 +1421,8 @@
 EXPORT_SYMBOL(ata_error);
 
 EXPORT_SYMBOL(ide_wait_stat);
+/* FIXME: this is a trully bad name */
 EXPORT_SYMBOL(restart_request);
-EXPORT_SYMBOL(ide_end_drive_cmd);
 EXPORT_SYMBOL(__ide_end_request);
 EXPORT_SYMBOL(ide_end_request);
 EXPORT_SYMBOL(ide_stall_queue);
diff -urN linux-2.5.20/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.20/drivers/ide/ide-disk.c	2002-06-05 13:06:36.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-05 02:37:13.000000000 +0200
@@ -372,9 +372,8 @@
 			}
 		}
 	}
-	ar->handler = task_no_data_intr;
-	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
 
+	/* not reached! */
 	return WIN_NOP;
 }
 
@@ -582,23 +581,21 @@
 {
 	MOD_INC_USE_COUNT;
 	if (drive->removable && drive->usage == 1) {
-		struct ata_taskfile args;
-
 		check_disk_change(inode->i_rdev);
 
-		memset(&args, 0, sizeof(args));
-		args.cmd = WIN_DOORLOCK;
-		args.handler = task_no_data_intr;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 		/*
 		 * Ignore the return code from door_lock, since the open() has
 		 * already succeeded once, and the door_lock is irrelevant at this
 		 * time.
 		 */
+		if (drive->doorlocking) {
+			struct ata_taskfile args;
 
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args))
-			drive->doorlocking = 0;
+			memset(&args, 0, sizeof(args));
+			args.cmd = WIN_DOORLOCK;
+			if (ide_raw_taskfile(drive, &args))
+				drive->doorlocking = 0;
+		}
 	}
 	return 0;
 }
@@ -613,29 +610,23 @@
 		args.cmd = WIN_FLUSH_CACHE_EXT;
 	else
 		args.cmd = WIN_FLUSH_CACHE;
-
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	return ide_raw_taskfile(drive, &args);
 }
 
 static void idedisk_release(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	if (drive->removable && !drive->usage) {
-		struct ata_taskfile args;
-
 		/* XXX I don't think this is up to the lowlevel drivers..  --hch */
 		invalidate_bdev(inode->i_bdev, 0);
 
-		memset(&args, 0, sizeof(args));
-		args.cmd = WIN_DOORUNLOCK;
-		args.handler = task_no_data_intr;
-		args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
-		if (drive->doorlocking &&
-		    ide_raw_taskfile(drive, &args))
-			drive->doorlocking = 0;
+		if (drive->doorlocking) {
+			struct ata_taskfile args;
+
+			memset(&args, 0, sizeof(args));
+			args.cmd = WIN_DOORUNLOCK;
+			if (ide_raw_taskfile(drive, &args))
+				drive->doorlocking = 0;
+		}
 	}
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (idedisk_flushcache(drive))
@@ -680,9 +671,6 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETMULT;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	if (!ide_raw_taskfile(drive, &args)) {
 		/* all went well track this setting as valid */
 		drive->mult_count = arg;
@@ -712,9 +700,6 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	ide_raw_taskfile(drive, &args);
 
 	drive->wcache = arg;
@@ -728,9 +713,6 @@
 
 	memset(&args, 0, sizeof(args));
 	args.cmd = WIN_STANDBYNOW1;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	return ide_raw_taskfile(drive, &args);
 }
 
@@ -742,9 +724,6 @@
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
 	args.cmd = WIN_SETFEATURES;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	ide_raw_taskfile(drive, &args);
 
 	drive->acoustic = arg;
@@ -864,9 +843,6 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX;
-	args.handler = task_no_data_intr;
-
-	/* submit command request */
 	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
@@ -892,9 +868,6 @@
 
 	args.taskfile.device_head = 0x40;
 	args.cmd = WIN_READ_NATIVE_MAX_EXT;
-	args.handler = task_no_data_intr;
-
-        /* submit command request */
         ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
@@ -933,9 +906,8 @@
 
 	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
 	args.cmd = WIN_SET_MAX;
-	args.handler = task_no_data_intr;
-	/* submit command request */
 	ide_raw_taskfile(drive, &args);
+
 	/* if OK, read new maximum address value */
 	if (!(drive->status & ERR_STAT)) {
 		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
@@ -965,12 +937,10 @@
 	args.hobfile.sector_number = (addr_req >>= 8);
 	args.hobfile.low_cylinder = (addr_req >>= 8);
 	args.hobfile.high_cylinder = (addr_req >>= 8);
-
 	args.hobfile.device_head = 0x40;
 
-        args.handler = task_no_data_intr;
-	/* submit command request */
 	ide_raw_taskfile(drive, &args);
+
 	/* if OK, compute maximum address value */
 	if (!(drive->status & ERR_STAT)) {
 		u32 high = (args.hobfile.high_cylinder << 16) |
diff -urN linux-2.5.20/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.20/drivers/ide/ide-floppy.c	2002-06-03 03:44:44.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-05 02:37:13.000000000 +0200
@@ -308,8 +308,6 @@
 #define	IDEFLOPPY_IOCTL_FORMAT_START		0x4602
 #define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS	0x4603
 
-#define IDEFLOPPY_RQ			(REQ_SPECIAL)
-
 /*
  *	Error codes which are returned in rq->errors to the higher part
  *	of the driver.
@@ -633,7 +631,7 @@
 	if (!rq)
 		return 0;
 
-	if (!(rq->flags & IDEFLOPPY_RQ)) {
+	if (!(rq->flags & REQ_SPECIAL)) {
 		ide_end_request(drive, rq, uptodate);
 		return 0;
 	}
@@ -717,7 +715,7 @@
 		struct atapi_packet_command *pc, struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->flags = IDEFLOPPY_RQ;
+	rq->flags = REQ_SPECIAL;
 	/* FIXME: --mdcki */
 	rq->buffer = (char *) pc;
 	(void) ide_do_drive_cmd (drive, rq, ide_preempt);
@@ -1251,7 +1249,7 @@
 		}
 		pc = idefloppy_next_pc_storage(drive);
 		idefloppy_create_rw_cmd (floppy, pc, rq, block);
-	} else if (rq->flags & IDEFLOPPY_RQ) {
+	} else if (rq->flags & REQ_SPECIAL) {
 		/* FIXME: --mdcki */
 		pc = (struct atapi_packet_command *) rq->buffer;
 	} else {
@@ -1274,7 +1272,7 @@
 	memset(&rq, 0, sizeof(rq));
 	/* FIXME: --mdcki */
 	rq.buffer = (char *) pc;
-	rq.flags = IDEFLOPPY_RQ;
+	rq.flags = REQ_SPECIAL;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff -urN linux-2.5.20/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.20/drivers/ide/ide-pmac.c	2002-06-03 03:44:51.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-05 11:50:35.000000000 +0200
@@ -1126,7 +1126,7 @@
 		udelay(1);
 
 	/* Build sglist */
-	if (rq->flags & REQ_DRIVE_ACB) {
+	if (rq->flags & REQ_SPECIAL) {
 		pmac_ide[ix].sg_nents = i = pmac_raw_build_sglist(ix, rq);
 	} else {
 		pmac_ide[ix].sg_nents = i = pmac_ide_build_sglist(ix, rq);
@@ -1437,10 +1437,11 @@
 	if (drive->type != ATA_DISK)
 		return 0;
 	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, NULL);
-	if ((rq->flags & REQ_DRIVE_ACB) &&
+	if ((rq->flags & REQ_SPECIAL) &&
 		(drive->addressing == 1)) {
 		struct ata_taskfile *args = rq->special;
-		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+		/* FIXME: this is never reached */
+		OUT_BYTE(args->cmd, IDE_COMMAND_REG);
 	} else if (drive->addressing) {
 		OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
 	} else {
diff -urN linux-2.5.20/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.20/drivers/ide/ide-taskfile.c	2002-06-05 13:06:36.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-05 02:37:13.000000000 +0200
@@ -176,27 +176,6 @@
 	return 1;	/* drive ready: *might* be interrupting */
 }
 
-/*
- * Handler for commands without a data phase
- */
-ide_startstop_t task_no_data_intr(struct ata_device *drive, struct request *rq)
-{
-	struct ata_taskfile *ar = rq->special;
-
-	ide__sti();	/* local CPU only */
-
-	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
-		/* Keep quiet for NOP because it is expected to fail. */
-		if (ar && ar->cmd != WIN_NOP)
-			return ata_error(drive, rq, __FUNCTION__);
-	}
-
-	if (ar)
-		ide_end_drive_cmd(drive, rq);
-
-	return ide_stopped;
-}
-
 ide_startstop_t ata_taskfile(struct ata_device *drive,
 		struct ata_taskfile *ar, struct request *rq)
 {
@@ -385,21 +364,72 @@
 
 }
 
-int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *args)
+
+/*
+ * Invoked on completion of a special REQ_SPECIAL command.
+ */
+ide_startstop_t ata_special_intr(struct ata_device *drive, struct
+		request *rq) {
+
+	struct ata_taskfile *ar = rq->special;
+	ide_startstop_t ret = ide_stopped;
+
+	ide__sti();	/* local CPU only */
+	if (rq->buffer && ar->taskfile.sector_number) {
+		if (!ata_status(drive, 0, DRQ_STAT) && ar->taskfile.sector_number) {
+			int retries = 10;
+
+			ata_read(drive, rq->buffer, ar->taskfile.sector_number * SECTOR_WORDS);
+
+			while (!ata_status(drive, 0, BUSY_STAT) && retries--)
+				udelay(100);
+		}
+	}
+
+	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
+		/* Keep quiet for NOP because it is expected to fail. */
+		if (ar->cmd != WIN_NOP)
+			ret = ata_error(drive, rq, __FUNCTION__);
+		rq->errors = 1;
+	}
+
+	ar->taskfile.feature = IN_BYTE(IDE_ERROR_REG);
+	ata_in_regfile(drive, &ar->taskfile);
+	ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
+	if ((drive->id->command_set_2 & 0x0400) &&
+			(drive->id->cfs_enable_2 & 0x0400) &&
+			(drive->addressing == 1)) {
+		/* The following command goes to the hob file! */
+		OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
+		ar->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
+		ata_in_regfile(drive, &ar->hobfile);
+	}
+
+	blkdev_dequeue_request(rq);
+	drive->rq = NULL;
+	end_that_request_last(rq);
+
+	return ret;
+}
+
+int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar)
 {
-	struct request rq;
+	struct request req;
+
+	ar->command_type = IDE_DRIVE_TASK_NO_DATA;
+	ar->handler = ata_special_intr;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_ACB;
-	rq.special = args;
+	memset(&req, 0, sizeof(req));
+	req.flags = REQ_SPECIAL;
+	req.special = ar;
 
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	return ide_do_drive_cmd(drive, &req, ide_wait);
 }
 
 EXPORT_SYMBOL(drive_is_ready);
+EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
 EXPORT_SYMBOL(ata_taskfile);
-EXPORT_SYMBOL(task_no_data_intr);
-EXPORT_SYMBOL(ide_do_drive_cmd);
+EXPORT_SYMBOL(ata_special_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -urN linux-2.5.20/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.20/drivers/ide/ioctl.c	2002-06-05 13:06:36.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-05 02:37:13.000000000 +0200
@@ -34,30 +34,6 @@
 #include "ioctl.h"
 
 /*
- * Invoked on completion of a special DRIVE_CMD.
- */
-static ide_startstop_t drive_cmd_intr(struct ata_device *drive, struct request *rq)
-{
-	struct ata_taskfile *ar = rq->special;
-
-	ide__sti();	/* local CPU only */
-	if (!ata_status(drive, 0, DRQ_STAT) && ar->taskfile.sector_number) {
-		int retries = 10;
-
-		ata_read(drive, rq->buffer, ar->taskfile.sector_number * SECTOR_WORDS);
-
-		while (!ata_status(drive, 0, BUSY_STAT) && retries--)
-			udelay(100);
-	}
-
-	if (!ata_status(drive, READY_STAT, BAD_STAT))
-		return ata_error(drive, rq, __FUNCTION__); /* already calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, rq);
-
-	return ide_stopped;
-}
-
-/*
  * Implement generic ioctls invoked from userspace to imlpement specific
  * functionality.
  *
@@ -79,7 +55,7 @@
 		return -EFAULT;
 
 	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_ACB;
+	rq.flags = REQ_SPECIAL;
 
 	memset(&args, 0, sizeof(args));
 
@@ -107,7 +83,7 @@
 
 	/* Issue ATA command and wait for completion.
 	 */
-	args.handler = drive_cmd_intr;
+	args.handler = ata_special_intr;
 
 	rq.buffer = argbuf + 4;
 	rq.special = &args;
diff -urN linux-2.5.20/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.20/drivers/ide/pcidma.c	2002-06-05 13:06:33.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-05 02:37:13.000000000 +0200
@@ -64,7 +64,7 @@
 	struct scatterlist *sg = ch->sg_table;
 	int nents = 0;
 
-	if (rq->flags & REQ_DRIVE_ACB) {
+	if (rq->flags & REQ_SPECIAL) {
 		struct ata_taskfile *args = rq->special;
 #if 1
 		unsigned char *virt_addr = rq->buffer;
@@ -525,6 +525,7 @@
 	if (ata_start_dma(drive, rq))
 		return 1;
 
+	/* No DMA transfers on ATAPI devices. */
 	if (drive->type != ATA_DISK)
 		return 0;
 
@@ -533,13 +534,8 @@
 	else
 		cmd = 0x00;
 
-	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-	if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
-		/* FIXME: this should never happen */
-		struct ata_taskfile *args = rq->special;
-
-		outb(args->cmd, IDE_COMMAND_REG);
-	} else if (drive->addressing)
+	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);
+	if (drive->addressing)
 		outb(cmd ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
 	else
 		outb(cmd ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
diff -urN linux-2.5.20/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.20/drivers/ide/tcq.c	2002-06-05 13:06:36.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-05 02:37:13.000000000 +0200
@@ -60,7 +60,9 @@
 	struct ata_taskfile *args = rq->special;
 
 	ide__sti();
-	ide_end_drive_cmd(drive, rq);
+	blkdev_dequeue_request(rq);
+	drive->rq = NULL;
+	end_that_request_last(rq);
 	kfree(args);
 
 	return ide_stopped;
@@ -402,18 +404,14 @@
 	if (drives <= 1)
 		return 0;
 
-	memset(&args, 0, sizeof(args));
-
-	args.taskfile.feature = 0x01;
-	args.cmd = WIN_NOP;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	/*
 	 * do taskfile and check ABRT bit -- intelligent adapters will not
 	 * pass NOP with sub-code 0x01 to device, so the command will not
 	 * fail there
 	 */
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = 0x01;
+	args.cmd = WIN_NOP;
 	ide_raw_taskfile(drive, &args);
 	if (args.taskfile.feature & ABRT_ERR)
 		return 1;
@@ -442,9 +440,6 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
 	args.cmd = WIN_SETFEATURES;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: failed to enable write cache\n", drive->name);
 		return 1;
@@ -457,9 +452,6 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_DIS_RI;
 	args.cmd = WIN_SETFEATURES;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
 		return 1;
@@ -472,9 +464,6 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_SI;
 	args.cmd = WIN_SETFEATURES;
-	args.handler = task_no_data_intr;
-	args.command_type = IDE_DRIVE_TASK_NO_DATA;
-
 	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
 		return 1;
diff -urN linux-2.5.20/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.20/include/linux/blkdev.h	2002-06-03 03:44:44.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-06-05 02:39:00.000000000 +0200
@@ -81,13 +81,11 @@
 	/*
 	 * for ATA/ATAPI devices
 	 */
-	__REQ_DRIVE_ACB,
-
 	__REQ_PC,	/* packet command (special) */
 	__REQ_BLOCK_PC,	/* queued down pc from block layer */
 	__REQ_SENSE,	/* sense retrival */
 
-	__REQ_SPECIAL,	/* driver special command (currently reset) */
+	__REQ_SPECIAL,	/* driver suplied command */
 
 	__REQ_NR_BITS,	/* stops here */
 };
@@ -100,7 +98,6 @@
 #define REQ_STARTED	(1 << __REQ_STARTED)
 #define REQ_DONTPREP	(1 << __REQ_DONTPREP)
 #define REQ_QUEUED	(1 << __REQ_QUEUED)
-#define REQ_DRIVE_ACB	(1 << __REQ_DRIVE_ACB)
 #define REQ_PC		(1 << __REQ_PC)
 #define REQ_BLOCK_PC	(1 << __REQ_BLOCK_PC)
 #define REQ_SENSE	(1 << __REQ_SENSE)
diff -urN linux-2.5.20/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.20/include/linux/ide.h	2002-06-05 13:06:36.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-05 02:40:26.000000000 +0200
@@ -654,11 +654,6 @@
 
 extern int ide_do_drive_cmd(struct ata_device *, struct request *, ide_action_t);
 
-/*
- * Clean up after success/failure of an explicit drive cmd.
- */
-extern void ide_end_drive_cmd(struct ata_device *, struct request *);
-
 struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_task_hdr  hobfile;
@@ -695,7 +690,7 @@
 		bio_kunmap_irq(to, flags);
 }
 
-extern ide_startstop_t task_no_data_intr(struct ata_device *, struct request *);
+extern ide_startstop_t ata_special_intr(struct ata_device *, struct request *);
 extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
 
 extern void ide_fix_driveid(struct hd_driveid *id);

--------------020200010506080706040302--

