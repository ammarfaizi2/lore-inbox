Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSFBHGG>; Sun, 2 Jun 2002 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317145AbSFBHGF>; Sun, 2 Jun 2002 03:06:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32787 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317141AbSFBHFe>; Sun, 2 Jun 2002 03:05:34 -0400
Message-ID: <3CF9B60C.3080506@evision-ventures.com>
Date: Sun, 02 Jun 2002 08:07:08 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.19 IDE 80
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000405080005030907020401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000405080005030907020401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sun Jun  2 03:31:56 CEST 2002 ide-clean-80

- Sanitize the handling of the ioctl's and fix a bug on the way in dealing with
   the WIN_SMART command where arguments where exchanged.

- Finally sanitize ioctl further until it turned out that we could get rid of
   the special request type REQ_DRIVE_CMD entierly. We are now using
   consistently REQ_DRIVE_ACB.

   One hidden code path less again!

- Realize the ide_end_drive_cmd can be on the REQ_DRIVE_ACB only for ioctl() to
   a disk. Eliminate it's usage from device type driver modules.

- Remove command member from struct  hd_drive_task_hdr and place it in strcut
   ata_taskfile. It is not common between the normal register file and HOB.

   We will have to introduce some helper functions for particular command types.


--------------000405080005030907020401
Content-Type: text/plain;
 name="ide-clean-80.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-80.diff"

diff -urN linux-2.5.19/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.19/drivers/block/ll_rw_blk.c	2002-05-29 20:42:46.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-02 06:33:53.000000000 +0200
@@ -490,11 +490,21 @@
 	}
 }
 
-static char *rq_flags[] = { "REQ_RW", "REQ_RW_AHEAD", "REQ_BARRIER",
-			   "REQ_CMD", "REQ_NOMERGE", "REQ_STARTED",
-			   "REQ_DONTPREP", "REQ_QUEUED", "REQ_DRIVE_CMD",
-			   "REQ_DRIVE_ACB", "REQ_PC", "REQ_BLOCK_PC",
-			   "REQ_SENSE", "REQ_SPECIAL" };
+static char *rq_flags[] = {
+	"REQ_RW",
+	"REQ_RW_AHEAD",
+	"REQ_BARRIER",
+	"REQ_CMD",
+	"REQ_NOMERGE",
+	"REQ_STARTED",
+	"REQ_DONTPREP",
+	"REQ_QUEUED",
+	"REQ_DRIVE_ACB",
+	"REQ_PC",
+	"REQ_BLOCK_PC",
+	"REQ_SENSE",
+	"REQ_SPECIAL"
+};
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
 {
diff -urN linux-2.5.19/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.19/drivers/ide/ide.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-02 07:09:29.000000000 +0200
@@ -395,38 +395,30 @@
  *
  * Should be called under lock held.
  */
-void ide_end_drive_cmd(struct ata_device *drive, struct request *rq, u8 err)
+void ide_end_drive_cmd(struct ata_device *drive, struct request *rq)
 {
-	if (rq->flags & REQ_DRIVE_CMD) {
-		u8 *args = rq->buffer;
-		rq->errors = !ata_status(drive, READY_STAT, BAD_STAT);
-		if (args) {
-			args[0] = drive->status;
-			args[1] = err;
-			args[2] = IN_BYTE(IDE_NSECTOR_REG);
-		}
-	} else if (rq->flags & REQ_DRIVE_ACB) {
-		struct ata_taskfile *args = rq->special;
+	if (rq->flags & REQ_DRIVE_ACB) {
+		struct ata_taskfile *ar = rq->special;
 
 		rq->errors = !ata_status(drive, READY_STAT, BAD_STAT);
-		if (args) {
-			args->taskfile.feature = err;
-			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
-			args->taskfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
-			args->taskfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
-			args->taskfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
-			args->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
-			args->taskfile.command = drive->status;
+		if (ar) {
+			ar->taskfile.feature = IN_BYTE(IDE_ERROR_REG);
+			ar->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
+			ar->taskfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
+			ar->taskfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
+			ar->taskfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
+			ar->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
+			ar->cmd = drive->status;
 			if ((drive->id->command_set_2 & 0x0400) &&
 			    (drive->id->cfs_enable_2 & 0x0400) &&
 			    (drive->addressing == 1)) {
 				/* The following command goes to the hob file! */
 				OUT_BYTE(0x80, drive->channel->io_ports[IDE_CONTROL_OFFSET]);
-				args->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
-				args->hobfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
-				args->hobfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
-				args->hobfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
-				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
+				ar->hobfile.feature = IN_BYTE(IDE_FEATURE_REG);
+				ar->hobfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
+				ar->hobfile.sector_number = IN_BYTE(IDE_SECTOR_REG);
+				ar->hobfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
+				ar->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
 	}
@@ -583,7 +575,7 @@
 
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_count = drive->sect;
-		args.taskfile.command = WIN_RESTORE;
+		args.cmd = WIN_RESTORE;
 		args.handler = recal_intr;
 		ata_taskfile(drive, &args, NULL);
 	}
@@ -602,10 +594,12 @@
 	err = ide_dump_status(drive, rq, msg, stat);
 	if (!drive || !rq)
 		return ide_stopped;
+
 	/* retry only "normal" I/O: */
 	if (!(rq->flags & REQ_CMD)) {
 		rq->errors = 1;
-		ide_end_drive_cmd(drive, rq, err);
+		ide_end_drive_cmd(drive, rq);
+
 		return ide_stopped;
 	}
 	/* other bits are useless when BUSY */
@@ -649,30 +643,6 @@
 }
 
 /*
- * Invoked on completion of a special DRIVE_CMD.
- */
-static ide_startstop_t drive_cmd_intr(struct ata_device *drive, struct request *rq)
-{
-	u8 *args = rq->buffer;
-
-	ide__sti();	/* local CPU only */
-	if (!ata_status(drive, 0, DRQ_STAT) && args && args[3]) {
-		int retries = 10;
-
-		ata_read(drive, &args[4], args[3] * SECTOR_WORDS);
-
-		while (!ata_status(drive, 0, BUSY_STAT) && retries--)
-			udelay(100);
-	}
-
-	if (!ata_status(drive, READY_STAT, BAD_STAT))
-		return ata_error(drive, rq, __FUNCTION__); /* already calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, rq, GET_ERR());
-
-	return ide_stopped;
-}
-
-/*
  * Busy-wait for the drive status to be not "busy".  Check then the status for
  * all of the "good" bits and none of the "bad" bits, and if all is okay it
  * returns 0.  All other cases return 1 after invoking error handler -- caller
@@ -775,53 +745,20 @@
 		}
 	}
 
-	/* This issues a special drive command, usually initiated by ioctl()
-	 * from the external hdparm program.
+	/* This issues a special drive command.
 	 */
 	if (rq->flags & REQ_DRIVE_ACB) {
-		struct ata_taskfile *args = rq->special;
+		struct ata_taskfile *ar = rq->special;
 
-		if (!(args))
+		if (!(ar))
 			goto args_error;
 
-		ata_taskfile(drive, args, NULL);
-
-		if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
-		     (args->command_type == IDE_DRIVE_TASK_OUT)) &&
-				args->prehandler && args->handler)
-			return args->prehandler(drive, rq);
-
-		return ide_started;
-	}
+		ata_taskfile(drive, ar, NULL);
 
-	if (rq->flags & REQ_DRIVE_CMD) {
-		u8 *args = rq->buffer;
-
-		if (!(args))
-			goto args_error;
-#ifdef DEBUG
-		printk("%s: DRIVE_CMD ", drive->name);
-		printk("cmd=0x%02x ", args[0]);
-		printk(" sc=0x%02x ", args[1]);
-		printk(" fr=0x%02x ", args[2]);
-		printk(" xx=0x%02x\n", args[3]);
-#endif
-		ide_set_handler(drive, drive_cmd_intr, WAIT_CMD, NULL);
-		ata_irq_enable(drive, 1);
-		ata_mask(drive);
-		if (args[0] == WIN_SMART) {
-			struct hd_drive_task_hdr regfile;
-			regfile.feature = args[2];
-			regfile.sector_count = args[3];
-			regfile.sector_number = args[1];
-			regfile.low_cylinder = 0x4f;
-			regfile.high_cylinder = 0xc2;
-			ata_out_regfile(drive, &regfile);
-		} else {
-			OUT_BYTE(args[2], IDE_FEATURE_REG);
-			OUT_BYTE(args[1], IDE_NSECTOR_REG);
-		}
-		OUT_BYTE(args[0], IDE_COMMAND_REG);
+		if (((ar->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
+		     (ar->command_type == IDE_DRIVE_TASK_OUT)) &&
+				ar->prehandler && ar->handler)
+			return ar->prehandler(drive, rq);
 
 		return ide_started;
 	}
@@ -863,7 +800,7 @@
 #ifdef DEBUG
 	printk("%s: DRIVE_CMD (null)\n", drive->name);
 #endif
-	ide_end_drive_cmd(drive, rq, GET_ERR());
+	ide_end_drive_cmd(drive, rq);
 
 	return ide_stopped;
 }
diff -urN linux-2.5.19/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.19/drivers/ide/ide-disk.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-02 07:18:26.000000000 +0200
@@ -170,7 +170,7 @@
 
 	args.taskfile.device_head = head;
 	args.taskfile.device_head |= drive->select.all;
-	args.taskfile.command =  get_command(drive, rq_data_dir(rq));
+	args.cmd =  get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -211,7 +211,7 @@
 
 	args.taskfile.device_head = ((block >> 8) & 0x0f);
 	args.taskfile.device_head |= drive->select.all;
-	args.taskfile.command = get_command(drive, rq_data_dir(rq));
+	args.cmd = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -264,7 +264,7 @@
 	args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
 	args.hobfile.device_head = drive->select.all;
 
-	args.taskfile.command = get_command(drive, rq_data_dir(rq));
+	args.cmd = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -355,7 +355,7 @@
 
 		memset(&args, 0, sizeof(args));
 
-		args.taskfile.command = WIN_DOORLOCK;
+		args.cmd = WIN_DOORLOCK;
 		ide_cmd_type_parser(&args);
 
 		/*
@@ -377,9 +377,9 @@
 	memset(&args, 0, sizeof(args));
 
 	if (drive->id->cfs_enable_2 & 0x2400)
-		args.taskfile.command = WIN_FLUSH_CACHE_EXT;
+		args.cmd = WIN_FLUSH_CACHE_EXT;
 	else
-		args.taskfile.command = WIN_FLUSH_CACHE;
+		args.cmd = WIN_FLUSH_CACHE;
 
 	ide_cmd_type_parser(&args);
 
@@ -395,7 +395,7 @@
 		invalidate_bdev(inode->i_bdev, 0);
 
 		memset(&args, 0, sizeof(args));
-		args.taskfile.command = WIN_DOORUNLOCK;
+		args.cmd = WIN_DOORUNLOCK;
 		ide_cmd_type_parser(&args);
 
 		if (drive->doorlocking &&
@@ -444,7 +444,7 @@
 
 	memset(&args, 0, sizeof(args));
 	args.taskfile.sector_count = arg;
-	args.taskfile.command	= WIN_SETMULT;
+	args.cmd = WIN_SETMULT;
 	ide_cmd_type_parser(&args);
 
 	if (!ide_raw_taskfile(drive, &args)) {
@@ -475,7 +475,7 @@
 
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-	args.taskfile.command	= WIN_SETFEATURES;
+	args.cmd = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 	ide_raw_taskfile(drive, &args);
 
@@ -489,7 +489,7 @@
 	struct ata_taskfile args;
 
 	memset(&args, 0, sizeof(args));
-	args.taskfile.command = WIN_STANDBYNOW1;
+	args.cmd = WIN_STANDBYNOW1;
 	ide_cmd_type_parser(&args);
 
 	return ide_raw_taskfile(drive, &args);
@@ -502,7 +502,7 @@
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
 	args.taskfile.sector_count = arg;
-	args.taskfile.command = WIN_SETFEATURES;
+	args.cmd = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 	ide_raw_taskfile(drive, &args);
 
@@ -622,14 +622,14 @@
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(args));
 	args.taskfile.device_head = 0x40;
-	args.taskfile.command = WIN_READ_NATIVE_MAX;
+	args.cmd = WIN_READ_NATIVE_MAX;
 	args.handler = task_no_data_intr;
 
 	/* submit command request */
 	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
+	if ((args.cmd & 0x01) == 0) {
 		addr = ((args.taskfile.device_head & 0x0f) << 24)
 		     | (args.taskfile.high_cylinder << 16)
 		     | (args.taskfile.low_cylinder <<  8)
@@ -650,14 +650,14 @@
 	memset(&args, 0, sizeof(args));
 
 	args.taskfile.device_head = 0x40;
-	args.taskfile.command = WIN_READ_NATIVE_MAX_EXT;
+	args.cmd = WIN_READ_NATIVE_MAX_EXT;
 	args.handler = task_no_data_intr;
 
         /* submit command request */
         ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
+	if ((args.cmd & 0x01) == 0) {
 		u32 high = (args.hobfile.high_cylinder << 16) |
 			   (args.hobfile.low_cylinder << 8) |
 			    args.hobfile.sector_number;
@@ -691,12 +691,12 @@
 	args.taskfile.high_cylinder = (addr_req >> 16);
 
 	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
-	args.taskfile.command = WIN_SET_MAX;
+	args.cmd = WIN_SET_MAX;
 	args.handler = task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args);
 	/* if OK, read new maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
+	if ((args.cmd & 0x01) == 0) {
 		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
 			 | (args.taskfile.high_cylinder << 16)
 			 | (args.taskfile.low_cylinder <<  8)
@@ -719,7 +719,7 @@
 	args.taskfile.low_cylinder = (addr_req >>= 8);
 	args.taskfile.high_cylinder = (addr_req >>= 8);
 	args.taskfile.device_head = 0x40;
-	args.taskfile.command = WIN_SET_MAX_EXT;
+	args.cmd = WIN_SET_MAX_EXT;
 
 	args.hobfile.sector_number = (addr_req >>= 8);
 	args.hobfile.low_cylinder = (addr_req >>= 8);
@@ -731,7 +731,7 @@
 	/* submit command request */
 	ide_raw_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
+	if ((args.cmd & 0x01) == 0) {
 		u32 high = (args.hobfile.high_cylinder << 16) |
 			   (args.hobfile.low_cylinder << 8) |
 			    args.hobfile.sector_number;
diff -urN linux-2.5.19/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.19/drivers/ide/ide-floppy.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-02 06:51:41.000000000 +0200
@@ -620,7 +620,7 @@
 
 #if IDEFLOPPY_DEBUG_LOG
 	printk (KERN_INFO "Reached idefloppy_end_request\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+#endif
 
 	switch (uptodate) {
 		case 0: error = IDEFLOPPY_ERROR_GENERAL; break;
@@ -632,12 +632,16 @@
 	/* Why does this happen? */
 	if (!rq)
 		return 0;
+
 	if (!(rq->flags & IDEFLOPPY_RQ)) {
 		ide_end_request(drive, rq, uptodate);
 		return 0;
 	}
+
 	rq->errors = error;
-	ide_end_drive_cmd (drive, rq, 0);
+	blkdev_dequeue_request(rq);
+	drive->rq = NULL;
+	end_that_request_last(rq);
 
 	return 0;
 }
diff -urN linux-2.5.19/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.19/drivers/ide/ide-tape.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-02 06:52:11.000000000 +0200
@@ -1864,9 +1864,12 @@
 				idetape_increase_max_pipeline_stages (drive);
 		}
 	}
-	ide_end_drive_cmd(drive, rq, 0);
+	blkdev_dequeue_request(rq);
+	drive->rq = NULL;
+	end_that_request_last(rq);
+
 	if (remove_stage)
-		idetape_remove_stage_head (drive);
+		idetape_remove_stage_head(drive);
 	if (tape->active_data_request == NULL)
 		clear_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
 	spin_unlock_irqrestore(&tape->spinlock, flags);
diff -urN linux-2.5.19/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.19/drivers/ide/ide-taskfile.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-02 07:07:28.000000000 +0200
@@ -311,34 +311,34 @@
 }
 
 ide_startstop_t ata_taskfile(struct ata_device *drive,
-		struct ata_taskfile *args, struct request *rq)
+		struct ata_taskfile *ar, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
-	if (args->handler != task_mulout_intr) {
+	if (ar->handler != task_mulout_intr) {
 		ata_irq_enable(drive, 1);
 		ata_mask(drive);
 	}
 
 	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400) &&
 	    (drive->addressing == 1))
-		ata_out_regfile(drive, &args->hobfile);
+		ata_out_regfile(drive, &ar->hobfile);
 
-	ata_out_regfile(drive, &args->taskfile);
+	ata_out_regfile(drive, &ar->taskfile);
 
 	{
 		u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
-		OUT_BYTE((args->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+		OUT_BYTE((ar->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
 	}
-	if (args->handler != NULL) {
+	if (ar->handler != NULL) {
 
 		/* This is apparently supposed to reset the wait timeout for
 		 * the interrupt to accur.
 		 */
 
-		ide_set_handler(drive, args->handler, WAIT_CMD, NULL);
-		OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+		ide_set_handler(drive, ar->handler, WAIT_CMD, NULL);
+		OUT_BYTE(ar->cmd, IDE_COMMAND_REG);
 
 		/*
 		 * Warning check for race between handler and prehandler for
@@ -346,8 +346,8 @@
 		 * inside the boundaries of the seek, we should be okay.
 		 */
 
-		if (args->prehandler != NULL)
-			return args->prehandler(drive, rq);
+		if (ar->prehandler != NULL)
+			return ar->prehandler(drive, rq);
 	} else {
 		/*
 		 * FIXME: this is a gross hack, need to unify tcq dma proc and
@@ -358,21 +358,20 @@
 			return ide_started;
 
 		/* for dma commands we don't set the handler */
-		if (args->taskfile.command == WIN_WRITEDMA
-		 || args->taskfile.command == WIN_WRITEDMA_EXT)
+		if (ar->cmd == WIN_WRITEDMA  || ar->cmd == WIN_WRITEDMA_EXT)
 			return !udma_write(drive, rq);
-		else if (args->taskfile.command == WIN_READDMA
-		      || args->taskfile.command == WIN_READDMA_EXT)
+		else if (ar->cmd == WIN_READDMA
+		      || ar->cmd == WIN_READDMA_EXT)
 			return !udma_read(drive, rq);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED
-		      || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT
-		      || args->taskfile.command == WIN_READDMA_QUEUED
-		      || args->taskfile.command == WIN_READDMA_QUEUED_EXT)
+		else if (ar->cmd == WIN_WRITEDMA_QUEUED
+		      || ar->cmd == WIN_WRITEDMA_QUEUED_EXT
+		      || ar->cmd == WIN_READDMA_QUEUED
+		      || ar->cmd == WIN_READDMA_QUEUED_EXT)
 			return udma_tcq_taskfile(drive, rq);
 #endif
 		else {
-			printk("ata_taskfile: unknown command %x\n", args->taskfile.command);
+			printk("ata_taskfile: unknown command %x\n", ar->cmd);
 			return ide_stopped;
 		}
 	}
@@ -396,18 +395,18 @@
  */
 ide_startstop_t task_no_data_intr(struct ata_device *drive, struct request *rq)
 {
-	struct ata_taskfile *args = rq->special;
+	struct ata_taskfile *ar = rq->special;
 
 	ide__sti();	/* local CPU only */
 
 	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
 		/* Keep quiet for NOP because it is expected to fail. */
-		if (args && args->taskfile.command != WIN_NOP)
+		if (ar && ar->cmd != WIN_NOP)
 			return ata_error(drive, rq, __FUNCTION__);
 	}
 
-	if (args)
-		ide_end_drive_cmd(drive, rq, GET_ERR());
+	if (ar)
+		ide_end_drive_cmd(drive, rq);
 
 	return ide_stopped;
 }
@@ -466,8 +465,8 @@
 	}
 
 	/* (ks/hs): Fixed Multi Write */
-	if ((args->taskfile.command != WIN_MULTWRITE) &&
-	    (args->taskfile.command != WIN_MULTWRITE_EXT)) {
+	if ((args->cmd != WIN_MULTWRITE) &&
+	    (args->cmd != WIN_MULTWRITE_EXT)) {
 		unsigned long flags;
 		char *buf = ide_map_rq(rq, &flags);
 		/* For Write_sectors we need to stuff the first sector */
@@ -569,7 +568,7 @@
 	args->prehandler = NULL;
 	args->handler = NULL;
 
-	switch(args->taskfile.command) {
+	switch (args->cmd) {
 		case WIN_IDENTIFY:
 		case WIN_PIDENTIFY:
 			args->handler = task_in_intr;
@@ -817,13 +816,6 @@
 
 	memset(&rq, 0, sizeof(rq));
 	rq.flags = REQ_DRIVE_ACB;
-
-#if 0
-	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
-		rq.current_nr_sectors = rq.nr_sectors
-			= (args->hobfile.sector_count << 8)
-			| args->taskfile.sector_count;
-#endif
 	rq.special = args;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
diff -urN linux-2.5.19/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.19/drivers/ide/ioctl.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-02 07:10:02.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/blkpg.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <linux/cdrom.h>
 #include <linux/device.h>
 
@@ -33,42 +34,67 @@
 #include "ioctl.h"
 
 /*
+ * Invoked on completion of a special DRIVE_CMD.
+ */
+static ide_startstop_t drive_cmd_intr(struct ata_device *drive, struct request *rq)
+{
+	struct ata_taskfile *ar = rq->special;
+
+	ide__sti();	/* local CPU only */
+	if (!ata_status(drive, 0, DRQ_STAT) && ar->taskfile.sector_number) {
+		int retries = 10;
+
+		ata_read(drive, rq->buffer, ar->taskfile.sector_number * SECTOR_WORDS);
+
+		while (!ata_status(drive, 0, BUSY_STAT) && retries--)
+			udelay(100);
+	}
+
+	if (!ata_status(drive, READY_STAT, BAD_STAT))
+		return ata_error(drive, rq, __FUNCTION__); /* already calls ide_end_drive_cmd */
+	ide_end_drive_cmd(drive, rq);
+
+	return ide_stopped;
+}
+
+/*
  * Implement generic ioctls invoked from userspace to imlpement specific
  * functionality.
  *
  * Unfortunately every single low level programm out there is using this
  * interface.
  */
-static int cmd_ioctl(struct ata_device *drive, unsigned long arg)
+static int do_cmd_ioctl(struct ata_device *drive, unsigned long arg)
 {
 	int err = 0;
 	u8 vals[4];
 	u8 *argbuf = vals;
-	u8 pio = 0;
 	int argsize = 4;
 	struct ata_taskfile args;
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_CMD;
-
-	/* If empty parameter file - wait for drive ready.
-	 */
-	if (!arg)
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
-
 	/* Second phase.
 	 */
 	if (copy_from_user(vals, (void *)arg, 4))
 		return -EFAULT;
 
+	memset(&rq, 0, sizeof(rq));
+	rq.flags = REQ_DRIVE_ACB;
+
+	memset(&args, 0, sizeof(args));
+
 	args.taskfile.feature = vals[2];
-	args.taskfile.sector_count = vals[3];
-	args.taskfile.sector_number = vals[1];
-	args.taskfile.low_cylinder = 0x00;
-	args.taskfile.high_cylinder = 0x00;
+	args.taskfile.sector_count = vals[1];
+	args.taskfile.sector_number = vals[3];
+	if (vals[0] == WIN_SMART) {
+		args.taskfile.low_cylinder = 0x4f;
+		args.taskfile.high_cylinder = 0xc2;
+	} else {
+		args.taskfile.low_cylinder = 0x00;
+		args.taskfile.high_cylinder = 0x00;
+	}
 	args.taskfile.device_head = 0x00;
-	args.taskfile.command = vals[0];
+	args.cmd = vals[0];
 
 	if (vals[3]) {
 		argsize = 4 + (SECTOR_WORDS * 4 * vals[3]);
@@ -79,63 +105,18 @@
 		memset(argbuf + 4, 0, argsize - 4);
 	}
 
-	/*
-	 * Always make sure the transfer reate has been setup.
-	 *
-	 * FIXME: what about setting up the drive with ->tuneproc?
-	 *
-	 * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
-	 * 1 : Safe to update drive->id DMA registers.
-	 * 0 : OOPs not allowed.
-	 */
-	if ((args.taskfile.command == WIN_SETFEATURES) &&
-	    (args.taskfile.sector_number >= XFER_SW_DMA_0) &&
-	    (args.taskfile.feature == SETFEATURES_XFER) &&
-	    (drive->id->dma_ultra ||
-	     drive->id->dma_mword ||
-	     drive->id->dma_1word)) {
-		pio = vals[1];
-		/*
-		 * Verify that we are doing an approved SETFEATURES_XFER with
-		 * respect to the hardware being able to support request.
-		 * Since some hardware can improperly report capabilties, we
-		 * check to see if the host adapter in combination with the
-		 * device (usually a disk) properly detect and acknowledge each
-		 * end of the ribbon.
-		 */
-		if (args.taskfile.sector_number > XFER_UDMA_2) {
-			if (!drive->channel->udma_four) {
-				printk(KERN_WARNING "%s: Speed warnings UDMA > 2 is not functional.\n",
-						drive->channel->name);
-				goto abort;
-			}
-#ifndef CONFIG_IDEDMA_IVB
-			if (!(drive->id->hw_config & 0x6000))
-#else
-			if (!(drive->id->hw_config & 0x2000) ||
-			    !(drive->id->hw_config & 0x4000))
-#endif
-			{
-				printk(KERN_WARNING "%s: Speed warnings UDMA > 2 is not functional.\n",
-						drive->name);
-				goto abort;
-			}
-		}
-	}
-
 	/* Issue ATA command and wait for completion.
 	 */
-	rq.buffer = argbuf;
+	args.handler = drive_cmd_intr;
+
+	rq.buffer = argbuf + 4;
+	rq.special = &args;
 	err = ide_do_drive_cmd(drive, &rq, ide_wait);
 
-	if (!err && pio) {
-		/* active-retuning-calls future */
-		/* FIXME: what about the setup for the drive?! */
-		if (drive->channel->speedproc)
-			drive->channel->speedproc(drive, pio);
-	}
+	argbuf[0] = drive->status;
+	argbuf[1] = args.taskfile.feature;
+	argbuf[2] = args.taskfile.sector_count;
 
-abort:
 	if (copy_to_user((void *)arg, argbuf, argsize))
 		err = -EFAULT;
 
@@ -153,7 +134,6 @@
 {
 	unsigned int major, minor;
 	struct ata_device *drive;
-//	struct request rq;
 	kdev_t dev;
 
 	dev = inode->i_rdev;
@@ -354,10 +334,14 @@
 			return 0;
 
 		case HDIO_DRIVE_CMD:
-			if (!capable(CAP_SYS_RAWIO))
-				return -EACCES;
+			if (!arg) {
+				if (ide_spin_wait_hwgroup(drive))
+					return -EBUSY;
+				else
+					return 0;
+			}
 
-			return cmd_ioctl(drive, arg);
+			return do_cmd_ioctl(drive, arg);
 
 		/*
 		 * uniform packet command handling
diff -urN linux-2.5.19/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.19/drivers/ide/pcidma.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-06-02 07:11:16.000000000 +0200
@@ -541,9 +541,10 @@
 
 	ide_set_handler(drive, ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
 	if ((rq->flags & REQ_DRIVE_ACB) && (drive->addressing == 1)) {
+		/* FIXME: this should never happen */
 		struct ata_taskfile *args = rq->special;
 
-		outb(args->taskfile.command, IDE_COMMAND_REG);
+		outb(args->cmd, IDE_COMMAND_REG);
 	} else if (drive->addressing) {
 		outb(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
 	} else {
diff -urN linux-2.5.19/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.19/drivers/ide/pdc4030.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-06-02 07:13:34.000000000 +0200
@@ -630,7 +630,7 @@
 	outb(taskfile->low_cylinder, IDE_LCYL_REG);
 	outb(taskfile->high_cylinder, IDE_HCYL_REG);
 	outb(taskfile->device_head, IDE_SELECT_REG);
-	outb(taskfile->command, IDE_COMMAND_REG);
+	outb(args->cmd, IDE_COMMAND_REG);
 
 	switch (rq_data_dir(rq)) {
 	case READ:
@@ -708,7 +708,7 @@
 	args.taskfile.low_cylinder	= (block>>=8);
 	args.taskfile.high_cylinder	= (block>>=8);
 	args.taskfile.device_head	= ((block>>8)&0x0f)|drive->select.all;
-	args.taskfile.command		= (rq_data_dir(rq)==READ)?PROMISE_READ:PROMISE_WRITE;
+	args.cmd			= (rq_data_dir(rq)==READ)?PROMISE_READ:PROMISE_WRITE;
 
 	/* We can't call ide_cmd_type_parser here, since it won't understand
 	   our command, but that doesn't matter, since we don't use the
diff -urN linux-2.5.19/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.19/drivers/ide/tcq.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-06-02 07:12:17.000000000 +0200
@@ -60,7 +60,7 @@
 	struct ata_taskfile *args = rq->special;
 
 	ide__sti();
-	ide_end_drive_cmd(drive, rq, GET_ERR());
+	ide_end_drive_cmd(drive, rq);
 	kfree(args);
 
 	return ide_stopped;
@@ -118,7 +118,7 @@
 	BUG_ON(!rq);
 
 	rq->special = args;
-	args->taskfile.command = WIN_NOP;
+	args->cmd = WIN_NOP;
 	args->handler = tcq_nop_handler;
 	args->command_type = IDE_DRIVE_TASK_NO_DATA;
 
@@ -407,7 +407,7 @@
 	memset(&args, 0, sizeof(args));
 
 	args.taskfile.feature = 0x01;
-	args.taskfile.command = WIN_NOP;
+	args.cmd = WIN_NOP;
 	ide_cmd_type_parser(&args);
 
 	/*
@@ -442,7 +442,7 @@
 
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
-	args.taskfile.command = WIN_SETFEATURES;
+	args.cmd = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 
 	if (ide_raw_taskfile(drive, &args)) {
@@ -456,7 +456,7 @@
 	 */
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_DIS_RI;
-	args.taskfile.command = WIN_SETFEATURES;
+	args.cmd = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 
 	if (ide_raw_taskfile(drive, &args)) {
@@ -470,7 +470,7 @@
 	 */
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_SI;
-	args.taskfile.command = WIN_SETFEATURES;
+	args.cmd = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 
 	if (ide_raw_taskfile(drive, &args)) {
@@ -554,7 +554,7 @@
 	ata_irq_enable(drive, 0);
 #endif
 
-	OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+	OUT_BYTE(args->cmd, IDE_COMMAND_REG);
 
 	if (wait_altstat(drive, &stat, BUSY_STAT)) {
 		ide_dump_status(drive, rq, "queued start", stat);
diff -urN linux-2.5.19/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.19/drivers/scsi/ide-scsi.c	2002-06-02 07:28:28.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-02 04:48:47.000000000 +0200
@@ -242,7 +242,11 @@
 		ide_end_request(drive, rq, uptodate);
 		return 0;
 	}
-	ide_end_drive_cmd(drive, rq, 0);
+
+	blkdev_dequeue_request(rq);
+	drive->rq = NULL;
+	end_that_request_last(rq);
+
 	if (rq->errors >= ERROR_MAX) {
 		pc->s.scsi_cmd->result = DID_ERROR << 16;
 		if (log)
diff -urN linux-2.5.19/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.19/include/linux/blkdev.h	2002-05-29 20:42:49.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-06-02 06:33:55.000000000 +0200
@@ -81,7 +81,6 @@
 	/*
 	 * for ATA/ATAPI devices
 	 */
-	__REQ_DRIVE_CMD,
 	__REQ_DRIVE_ACB,
 
 	__REQ_PC,	/* packet command (special) */
@@ -101,7 +100,6 @@
 #define REQ_STARTED	(1 << __REQ_STARTED)
 #define REQ_DONTPREP	(1 << __REQ_DONTPREP)
 #define REQ_QUEUED	(1 << __REQ_QUEUED)
-#define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
 #define REQ_DRIVE_ACB	(1 << __REQ_DRIVE_ACB)
 #define REQ_PC		(1 << __REQ_PC)
 #define REQ_BLOCK_PC	(1 << __REQ_BLOCK_PC)
diff -urN linux-2.5.19/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.19/include/linux/hdreg.h	2002-06-02 07:28:28.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-06-02 07:20:57.000000000 +0200
@@ -74,16 +74,12 @@
 #define IDE_DRIVE_TASK_RAW_WRITE	4
 
 struct hd_drive_task_hdr {
-	u8 data;
 	u8 feature;
 	u8 sector_count;
 	u8 sector_number;
 	u8 low_cylinder;
 	u8 high_cylinder;
 	u8 device_head;
-
-	/* FXIME: Consider moving this out from here. */
-	u8 command;
 } __attribute__((packed));
 
 /*
diff -urN linux-2.5.19/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.19/include/linux/ide.h	2002-06-02 07:28:28.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-02 07:21:08.000000000 +0200
@@ -253,11 +253,11 @@
 	unsigned all			: 8;	/* all of the bits together */
 	struct {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned XXX_head	: 4;	/* always zeros here */
+		unsigned head		: 4;	/* always zeros here */
 		unsigned unit		: 1;	/* drive select number: 0/1 */
-		unsigned XXX_bit5	: 1;	/* always 1 */
+		unsigned bit5		: 1;	/* always 1 */
 		unsigned lba		: 1;	/* using LBA instead of CHS */
-		unsigned XXX_bit7	: 1;	/* always 1 */
+		unsigned bit7		: 1;	/* always 1 */
 #elif defined(__BIG_ENDIAN_BITFIELD)
 		unsigned bit7		: 1;
 		unsigned lba		: 1;
@@ -666,11 +666,12 @@
 /*
  * Clean up after success/failure of an explicit drive cmd.
  */
-extern void ide_end_drive_cmd(struct ata_device *, struct request *, u8);
+extern void ide_end_drive_cmd(struct ata_device *, struct request *);
 
 struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_task_hdr  hobfile;
+	u8 cmd;					/* actual ATA command */
 	int command_type;
 	ide_startstop_t (*prehandler)(struct ata_device *, struct request *);
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);

--------------000405080005030907020401--

