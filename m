Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSFBHEv>; Sun, 2 Jun 2002 03:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSFBHEu>; Sun, 2 Jun 2002 03:04:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31763 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317140AbSFBHEe>; Sun, 2 Jun 2002 03:04:34 -0400
Message-ID: <3CF9B5CD.9040904@evision-ventures.com>
Date: Sun, 02 Jun 2002 08:06:05 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH} 2.5.19 IDE 79
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090300010104060906010607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300010104060906010607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sat Jun  1 21:31:47 CEST 2002 ide-clean-79

- Fix typo in sparc_v9 code, in ns87415, just introduced.

- Eliminate unnecessary struct hd_drive_hob_hdr those are
   in reality precisely the same registers as usual.

- Eliminate control_t, nowhere used type.

- Unfold ide_init_drive_cmd() at the places where it's used. This makes obvious
   that REQ_DRIVE_CMD gets only used on the ioctl command path.


--------------090300010104060906010607
Content-Type: text/plain;
 name="ide-clean-79.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-79.diff"

diff -urN linux-2.5.19/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.19/drivers/ide/device.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/device.c	2002-06-01 22:14:42.000000000 +0200
@@ -142,4 +142,18 @@
 
 EXPORT_SYMBOL(ata_reset);
 
+/*
+ * Output a complete register file.
+ */
+void ata_out_regfile(struct ata_device *drive, struct hd_drive_task_hdr *rf)
+{
+	struct ata_channel *ch = drive->channel;
+
+	OUT_BYTE(rf->feature, ch->io_ports[IDE_FEATURE_OFFSET]);
+	OUT_BYTE(rf->sector_count, ch->io_ports[IDE_NSECTOR_OFFSET]);
+	OUT_BYTE(rf->sector_number, ch->io_ports[IDE_SECTOR_OFFSET]);
+	OUT_BYTE(rf->low_cylinder, ch->io_ports[IDE_LCYL_OFFSET]);
+	OUT_BYTE(rf->high_cylinder, ch->io_ports[IDE_HCYL_OFFSET]);
+}
+
 MODULE_LICENSE("GPL");
diff -urN linux-2.5.19/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.19/drivers/ide/ide.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-01 22:41:03.000000000 +0200
@@ -673,19 +673,6 @@
 }
 
 /*
- * Issue a simple drive command.  The drive must be selected beforehand.
- */
-static void drive_cmd(struct ata_device *drive, u8 cmd, u8 nsect)
-{
-	ide_set_handler(drive, drive_cmd_intr, WAIT_CMD, NULL);
-	ata_irq_enable(drive, 1);
-	ata_mask(drive);
-	OUT_BYTE(nsect, IDE_NSECTOR_REG);
-	OUT_BYTE(cmd, IDE_COMMAND_REG);
-}
-
-
-/*
  * Busy-wait for the drive status to be not "busy".  Check then the status for
  * all of the "good" bits and none of the "bad" bits, and if all is okay it
  * returns 0.  All other cases return 1 after invoking error handler -- caller
@@ -815,21 +802,26 @@
 #ifdef DEBUG
 		printk("%s: DRIVE_CMD ", drive->name);
 		printk("cmd=0x%02x ", args[0]);
-		printk("sc=0x%02x ", args[1]);
-		printk("fr=0x%02x ", args[2]);
-		printk("xx=0x%02x\n", args[3]);
+		printk(" sc=0x%02x ", args[1]);
+		printk(" fr=0x%02x ", args[2]);
+		printk(" xx=0x%02x\n", args[3]);
 #endif
+		ide_set_handler(drive, drive_cmd_intr, WAIT_CMD, NULL);
+		ata_irq_enable(drive, 1);
+		ata_mask(drive);
 		if (args[0] == WIN_SMART) {
-			OUT_BYTE(0x4f, IDE_LCYL_REG);
-			OUT_BYTE(0xc2, IDE_HCYL_REG);
-			OUT_BYTE(args[2],IDE_FEATURE_REG);
-			OUT_BYTE(args[1],IDE_SECTOR_REG);
-			drive_cmd(drive, args[0], args[3]);
-
-			return ide_started;
+			struct hd_drive_task_hdr regfile;
+			regfile.feature = args[2];
+			regfile.sector_count = args[3];
+			regfile.sector_number = args[1];
+			regfile.low_cylinder = 0x4f;
+			regfile.high_cylinder = 0xc2;
+			ata_out_regfile(drive, &regfile);
+		} else {
+			OUT_BYTE(args[2], IDE_FEATURE_REG);
+			OUT_BYTE(args[1], IDE_NSECTOR_REG);
 		}
-		OUT_BYTE(args[2],IDE_FEATURE_REG);
-		drive_cmd(drive, args[0], args[1]);
+		OUT_BYTE(args[0], IDE_COMMAND_REG);
 
 		return ide_started;
 	}
diff -urN linux-2.5.19/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.19/drivers/ide/ide-cd.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-06-01 23:48:30.000000000 +0200
@@ -535,7 +535,7 @@
 
 	/* stuff the sense request in front of our current request */
 	rq = &info->request_sense_request;
-	ide_init_drive_cmd(rq);
+	memset(rq, 0, sizeof(*rq));
 	rq->cmd[0] = GPCMD_REQUEST_SENSE;
 	rq->cmd[4] = pc->buflen;
 	rq->flags = REQ_SENSE;
@@ -1389,9 +1389,8 @@
 
 	/* Start of retry loop. */
 	do {
-		ide_init_drive_cmd(&rq);
+		memset(&rq, 0, sizeof(rq));
 		memcpy(rq.cmd, cmd, CDROM_PACKET_SIZE);
-
 		rq.flags = REQ_PC;
 
 		/* FIXME --mdcki */
@@ -2276,7 +2275,7 @@
 	struct request req;
 	int ret;
 
-	ide_init_drive_cmd(&req);
+	memset(&req, 0, sizeof(req));
 	req.flags = REQ_SPECIAL;
 	ret = ide_do_drive_cmd(drive, &req, ide_wait);
 
diff -urN linux-2.5.19/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.19/drivers/ide/ide-disk.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-06-01 21:53:07.000000000 +0200
@@ -264,8 +264,6 @@
 	args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
 	args.hobfile.device_head = drive->select.all;
 
-	args.hobfile.control = 0x80;
-
 	args.taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
@@ -728,7 +726,6 @@
 	args.hobfile.high_cylinder = (addr_req >>= 8);
 
 	args.hobfile.device_head = 0x40;
-	args.hobfile.control = 0x80;
 
         args.handler = task_no_data_intr;
 	/* submit command request */
diff -urN linux-2.5.19/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.19/drivers/ide/ide-floppy.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-06-01 23:55:10.000000000 +0200
@@ -712,10 +712,10 @@
 static void idefloppy_queue_pc_head(struct ata_device *drive,
 		struct atapi_packet_command *pc, struct request *rq)
 {
-	ide_init_drive_cmd (rq);
+	memset(rq, 0, sizeof(*rq));
+	rq->flags = IDEFLOPPY_RQ;
 	/* FIXME: --mdcki */
 	rq->buffer = (char *) pc;
-	rq->flags = IDEFLOPPY_RQ;
 	(void) ide_do_drive_cmd (drive, rq, ide_preempt);
 }
 
@@ -1065,10 +1065,10 @@
 #endif
 
 	ata_irq_enable(drive, 1);
-	OUT_BYTE (dma_ok ? 1:0,IDE_FEATURE_REG);			/* Use PIO/DMA */
-	OUT_BYTE (bcount.b.high,IDE_BCOUNTH_REG);
-	OUT_BYTE (bcount.b.low,IDE_BCOUNTL_REG);
-	OUT_BYTE (drive->select.all,IDE_SELECT_REG);
+	OUT_BYTE(dma_ok ? 1:0,IDE_FEATURE_REG);			/* Use PIO/DMA */
+	OUT_BYTE(bcount.b.high,IDE_BCOUNTH_REG);
+	OUT_BYTE(bcount.b.low,IDE_BCOUNTL_REG);
+	OUT_BYTE(drive->select.all,IDE_SELECT_REG);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (dma_ok) {							/* Begin DMA, if necessary */
@@ -1271,11 +1271,12 @@
 {
 	struct request rq;
 
-	ide_init_drive_cmd (&rq);
+	memset(&rq, 0, sizeof(rq));
 	/* FIXME: --mdcki */
 	rq.buffer = (char *) pc;
 	rq.flags = IDEFLOPPY_RQ;
-	return ide_do_drive_cmd (drive, &rq, ide_wait);
+
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
 /*
diff -urN linux-2.5.19/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.19/drivers/ide/ide-tape.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-06-01 23:43:22.000000000 +0200
@@ -1921,7 +1921,7 @@
  */
 static void idetape_queue_pc_head(struct ata_device *drive, struct atapi_packet_command *pc, struct request *rq)
 {
-	ide_init_drive_cmd (rq);
+	memset(rq, 0, sizeof(*rq));
 	rq->buffer = (char *) pc;
 	rq->flags = IDETAPE_PC_RQ1;
 	ide_do_drive_cmd(drive, rq, ide_preempt);
@@ -3153,7 +3153,7 @@
 {
 	struct request rq;
 
-	ide_init_drive_cmd (&rq);
+	memset(&rq, 0, sizeof(rq));
 	/* FIXME: --mdcki */
 	rq.buffer = (char *) pc;
 	rq.flags = IDETAPE_PC_RQ1;
@@ -3414,17 +3414,17 @@
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 2)
 		printk (KERN_INFO "ide-tape: idetape_queue_rw_tail: cmd=%d\n",cmd);
-#endif /* IDETAPE_DEBUG_LOG */
+#endif
 #if IDETAPE_DEBUG_BUGS
 	if (idetape_pipeline_active (tape)) {
 		printk (KERN_ERR "ide-tape: bug: the pipeline is active in idetape_queue_rw_tail\n");
 		return (0);
 	}
-#endif /* IDETAPE_DEBUG_BUGS */	
+#endif
 
-	ide_init_drive_cmd (&rq);
-	rq.bio = bio;
+	memset(&rq, 0, sizeof(rq));
 	rq.flags = cmd;
+	rq.bio = bio;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
 	if (tape->onstream)
@@ -3472,7 +3472,7 @@
 			printk(KERN_INFO "ide-tape: %s: read back logical block %d, data %x %x %x %x\n", tape->name, logical_blk_num, *p++, *p++, *p++, *p++);
 #endif
 		rq = &stage->rq;
-		ide_init_drive_cmd (rq);
+		memset(rq, 0, sizeof(*rq));
 		rq->flags = IDETAPE_WRITE_RQ;
 		rq->sector = tape->first_frame_position;
 		rq->nr_sectors = rq->current_nr_sectors = tape->capabilities.ctl;
@@ -3748,7 +3748,7 @@
 		}
 	}
 	rq = &new_stage->rq;
-	ide_init_drive_cmd (rq);
+	memset(rq, 0, sizeof(*rq));
 	rq->flags = IDETAPE_WRITE_RQ;
 	rq->sector = tape->first_frame_position;	/* Doesn't actually matter - We always assume sequential access */
 	rq->nr_sectors = rq->current_nr_sectors = blocks;
@@ -3938,7 +3938,8 @@
 	}
 	if (tape->restart_speed_control_req)
 		idetape_restart_speed_control(drive);
-	ide_init_drive_cmd (&rq);
+
+	memset(&rq, 0, sizeof(rq));
 	rq.flags = IDETAPE_READ_RQ;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
diff -urN linux-2.5.19/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.19/drivers/ide/ide-taskfile.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-06-01 23:59:07.000000000 +0200
@@ -314,7 +314,6 @@
 		struct ata_taskfile *args, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
-	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
 	if (args->handler != task_mulout_intr) {
@@ -322,25 +321,16 @@
 		ata_mask(drive);
 	}
 
-	if ((id->command_set_2 & 0x0400) &&
-	    (id->cfs_enable_2 & 0x0400) &&
-	    (drive->addressing == 1)) {
-		OUT_BYTE(args->hobfile.feature, IDE_FEATURE_REG);
-		OUT_BYTE(args->hobfile.sector_count, IDE_NSECTOR_REG);
-		OUT_BYTE(args->hobfile.sector_number, IDE_SECTOR_REG);
-		OUT_BYTE(args->hobfile.low_cylinder, IDE_LCYL_REG);
-		OUT_BYTE(args->hobfile.high_cylinder, IDE_HCYL_REG);
-	}
-
-	OUT_BYTE(args->taskfile.feature, IDE_FEATURE_REG);
-	OUT_BYTE(args->taskfile.sector_count, IDE_NSECTOR_REG);
-	/* refers to number of sectors to transfer */
-	OUT_BYTE(args->taskfile.sector_number, IDE_SECTOR_REG);
-	/* refers to sector offset or start sector */
-	OUT_BYTE(args->taskfile.low_cylinder, IDE_LCYL_REG);
-	OUT_BYTE(args->taskfile.high_cylinder, IDE_HCYL_REG);
-
-	OUT_BYTE((args->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400) &&
+	    (drive->addressing == 1))
+		ata_out_regfile(drive, &args->hobfile);
+
+	ata_out_regfile(drive, &args->taskfile);
+
+	{
+		u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
+		OUT_BYTE((args->taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+	}
 	if (args->handler != NULL) {
 
 		/* This is apparently supposed to reset the wait timeout for
@@ -361,8 +351,7 @@
 	} else {
 		/*
 		 * FIXME: this is a gross hack, need to unify tcq dma proc and
-		 * regular dma proc -- basically split stuff that needs to act
-		 * on a request from things like ide_dma_check etc.
+		 * regular dma proc.
 		 */
 
 		if (!drive->using_dma)
@@ -761,15 +750,6 @@
 }
 
 /*
- * This function is intended to be used prior to invoking ide_do_drive_cmd().
- */
-void ide_init_drive_cmd(struct request *rq)
-{
-	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_CMD;
-}
-
-/*
  * This function issues a special IDE device request onto the request queue.
  *
  * If action is ide_wait, then the rq is queued at the end of the request
@@ -849,139 +829,12 @@
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-/*
- * Implement generic ioctls invoked from userspace to imlpement specific
- * functionality.
- *
- * Unfortunately every single low level programm out there is using this
- * interface.
- */
-
-/*
- * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
- * 1 : Safe to update drive->id DMA registers.
- * 0 : OOPs not allowed.
- */
-static int set_transfer(struct ata_device *drive, struct ata_taskfile *args)
-{
-	if ((args->taskfile.command == WIN_SETFEATURES) &&
-	    (args->taskfile.sector_number >= XFER_SW_DMA_0) &&
-	    (args->taskfile.feature == SETFEATURES_XFER) &&
-	    (drive->id->dma_ultra ||
-	     drive->id->dma_mword ||
-	     drive->id->dma_1word))
-		return 1;
-
-	return 0;
-}
-
-/*
- * Verify that we are doing an approved SETFEATURES_XFER with respect
- * to the hardware being able to support request.  Since some hardware
- * can improperly report capabilties, we check to see if the host adapter
- * in combination with the device (usually a disk) properly detect
- * and acknowledge each end of the ribbon.
- */
-static int ata66_check(struct ata_device *drive, struct ata_taskfile *args)
-{
-	if ((args->taskfile.command == WIN_SETFEATURES) &&
-	    (args->taskfile.sector_number > XFER_UDMA_2) &&
-	    (args->taskfile.feature == SETFEATURES_XFER)) {
-		if (!drive->channel->udma_four) {
-			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->channel->name);
-			return 1;
-		}
-#ifndef CONFIG_IDEDMA_IVB
-		if ((drive->id->hw_config & 0x6000) == 0) {
-#else
-		if (((drive->id->hw_config & 0x2000) == 0) ||
-		    ((drive->id->hw_config & 0x4000) == 0)) {
-#endif
-			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->name);
-			return 1;
-		}
-	}
-	return 0;
-}
-
-int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg)
-{
-	int err = 0;
-	u8 vals[4];
-	u8 *argbuf = vals;
-	u8 pio = 0;
-	int argsize = 4;
-	struct ata_taskfile args;
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-
-	/* Wait for drive ready.
-	 */
-	if (!arg)
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
-
-	/* Second phase.
-	 */
-	if (copy_from_user(vals, (void *)arg, 4))
-		return -EFAULT;
-
-	args.taskfile.feature = vals[2];
-	args.taskfile.sector_count = vals[3];
-	args.taskfile.sector_number = vals[1];
-	args.taskfile.low_cylinder = 0x00;
-	args.taskfile.high_cylinder = 0x00;
-	args.taskfile.device_head = 0x00;
-	args.taskfile.command = vals[0];
-
-	if (vals[3]) {
-		argsize = 4 + (SECTOR_WORDS * 4 * vals[3]);
-		argbuf = kmalloc(argsize, GFP_KERNEL);
-		if (argbuf == NULL)
-			return -ENOMEM;
-		memcpy(argbuf, vals, 4);
-		memset(argbuf + 4, 0, argsize - 4);
-	}
-
-	/* Always make sure the transfer reate has been setup.
-	 * FIXME: what about setting up the drive with ->tuneproc?
-	 */
-	if (set_transfer(drive, &args)) {
-		pio = vals[1];
-		if (ata66_check(drive, &args))
-			goto abort;
-	}
-
-	/* Issue ATA command and wait for completion.
-	 */
-	rq.buffer = argbuf;
-	err = ide_do_drive_cmd(drive, &rq, ide_wait);
-
-	if (!err && pio) {
-		/* active-retuning-calls future */
-		/* FIXME: what about the setup for the drive?! */
-		if (drive->channel->speedproc)
-			drive->channel->speedproc(drive, pio);
-	}
-
-abort:
-	if (copy_to_user((void *)arg, argbuf, argsize))
-		err = -EFAULT;
-
-	if (argsize > 4)
-		kfree(argbuf);
-
-	return err;
-}
-
 EXPORT_SYMBOL(drive_is_ready);
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
 EXPORT_SYMBOL(ata_taskfile);
 EXPORT_SYMBOL(recal_intr);
 EXPORT_SYMBOL(task_no_data_intr);
-EXPORT_SYMBOL(ide_init_drive_cmd);
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ide_raw_taskfile);
 EXPORT_SYMBOL(ide_cmd_type_parser);
-EXPORT_SYMBOL(ide_cmd_ioctl);
diff -urN linux-2.5.19/drivers/ide/ioctl.c linux/drivers/ide/ioctl.c
--- linux-2.5.19/drivers/ide/ioctl.c	2002-05-29 20:42:50.000000000 +0200
+++ linux/drivers/ide/ioctl.c	2002-06-02 00:03:22.000000000 +0200
@@ -33,6 +33,119 @@
 #include "ioctl.h"
 
 /*
+ * Implement generic ioctls invoked from userspace to imlpement specific
+ * functionality.
+ *
+ * Unfortunately every single low level programm out there is using this
+ * interface.
+ */
+static int cmd_ioctl(struct ata_device *drive, unsigned long arg)
+{
+	int err = 0;
+	u8 vals[4];
+	u8 *argbuf = vals;
+	u8 pio = 0;
+	int argsize = 4;
+	struct ata_taskfile args;
+	struct request rq;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.flags = REQ_DRIVE_CMD;
+
+	/* If empty parameter file - wait for drive ready.
+	 */
+	if (!arg)
+		return ide_do_drive_cmd(drive, &rq, ide_wait);
+
+	/* Second phase.
+	 */
+	if (copy_from_user(vals, (void *)arg, 4))
+		return -EFAULT;
+
+	args.taskfile.feature = vals[2];
+	args.taskfile.sector_count = vals[3];
+	args.taskfile.sector_number = vals[1];
+	args.taskfile.low_cylinder = 0x00;
+	args.taskfile.high_cylinder = 0x00;
+	args.taskfile.device_head = 0x00;
+	args.taskfile.command = vals[0];
+
+	if (vals[3]) {
+		argsize = 4 + (SECTOR_WORDS * 4 * vals[3]);
+		argbuf = kmalloc(argsize, GFP_KERNEL);
+		if (argbuf == NULL)
+			return -ENOMEM;
+		memcpy(argbuf, vals, 4);
+		memset(argbuf + 4, 0, argsize - 4);
+	}
+
+	/*
+	 * Always make sure the transfer reate has been setup.
+	 *
+	 * FIXME: what about setting up the drive with ->tuneproc?
+	 *
+	 * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
+	 * 1 : Safe to update drive->id DMA registers.
+	 * 0 : OOPs not allowed.
+	 */
+	if ((args.taskfile.command == WIN_SETFEATURES) &&
+	    (args.taskfile.sector_number >= XFER_SW_DMA_0) &&
+	    (args.taskfile.feature == SETFEATURES_XFER) &&
+	    (drive->id->dma_ultra ||
+	     drive->id->dma_mword ||
+	     drive->id->dma_1word)) {
+		pio = vals[1];
+		/*
+		 * Verify that we are doing an approved SETFEATURES_XFER with
+		 * respect to the hardware being able to support request.
+		 * Since some hardware can improperly report capabilties, we
+		 * check to see if the host adapter in combination with the
+		 * device (usually a disk) properly detect and acknowledge each
+		 * end of the ribbon.
+		 */
+		if (args.taskfile.sector_number > XFER_UDMA_2) {
+			if (!drive->channel->udma_four) {
+				printk(KERN_WARNING "%s: Speed warnings UDMA > 2 is not functional.\n",
+						drive->channel->name);
+				goto abort;
+			}
+#ifndef CONFIG_IDEDMA_IVB
+			if (!(drive->id->hw_config & 0x6000))
+#else
+			if (!(drive->id->hw_config & 0x2000) ||
+			    !(drive->id->hw_config & 0x4000))
+#endif
+			{
+				printk(KERN_WARNING "%s: Speed warnings UDMA > 2 is not functional.\n",
+						drive->name);
+				goto abort;
+			}
+		}
+	}
+
+	/* Issue ATA command and wait for completion.
+	 */
+	rq.buffer = argbuf;
+	err = ide_do_drive_cmd(drive, &rq, ide_wait);
+
+	if (!err && pio) {
+		/* active-retuning-calls future */
+		/* FIXME: what about the setup for the drive?! */
+		if (drive->channel->speedproc)
+			drive->channel->speedproc(drive, pio);
+	}
+
+abort:
+	if (copy_to_user((void *)arg, argbuf, argsize))
+		err = -EFAULT;
+
+	if (argsize > 4)
+		kfree(argbuf);
+
+	return err;
+}
+
+/*
  * NOTE: Due to ridiculous coding habbits in the hdparm utility we have to
  * always return unsigned long in case we are returning simple values.
  */
@@ -40,7 +153,7 @@
 {
 	unsigned int major, minor;
 	struct ata_device *drive;
-	struct request rq;
+//	struct request rq;
 	kdev_t dev;
 
 	dev = inode->i_rdev;
@@ -50,7 +163,6 @@
 	if ((drive = get_info_ptr(inode->i_rdev)) == NULL)
 		return -ENODEV;
 
-
 	/* Contrary to popular beleve we disallow even the reading of the ioctl
 	 * values for users which don't have permission too. We do this becouse
 	 * such information could be used by an attacker to deply a simple-user
@@ -61,7 +173,6 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	ide_init_drive_cmd(&rq);
 	switch (cmd) {
 		case HDIO_GET_32BIT: {
 			unsigned long val = drive->channel->io_32bit;
@@ -96,7 +207,6 @@
 			/* FIXME: we can see that tuneproc whould do the
 			 * locking!.
 			 */
-
 			if (ide_spin_wait_hwgroup(drive))
 				return -EBUSY;
 
@@ -114,7 +224,6 @@
 			return 0;
 		}
 
-
 		case HDIO_SET_UNMASKINTR:
 			if (arg < 0 || arg > 1)
 				return -EINVAL;
@@ -202,9 +311,6 @@
 			return 0;
 		}
 
-		case BLKRRPART: /* Re-read partition tables */
-			return ata_revalidate(inode->i_rdev);
-
 		case HDIO_GET_IDENTITY:
 			if (minor(inode->i_rdev) & PARTN_MASK)
 				return -EINVAL;
@@ -222,12 +328,6 @@
 					drive->atapi_overlap << IDE_NICE_ATAPI_OVERLAP,
 					(long *) arg);
 
-		case HDIO_DRIVE_CMD:
-			if (!capable(CAP_SYS_RAWIO))
-				return -EACCES;
-
-			return ide_cmd_ioctl(drive, arg);
-
 		case HDIO_SET_NICE:
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP))))
 				return -EPERM;
@@ -241,6 +341,34 @@
 
 			return 0;
 
+		case HDIO_GET_BUSSTATE:
+			if (put_user(drive->channel->bus_state, (long *)arg))
+				return -EFAULT;
+
+			return 0;
+
+		case HDIO_SET_BUSSTATE:
+			if (drive->channel->busproc)
+				drive->channel->busproc(drive, (int)arg);
+
+			return 0;
+
+		case HDIO_DRIVE_CMD:
+			if (!capable(CAP_SYS_RAWIO))
+				return -EACCES;
+
+			return cmd_ioctl(drive, arg);
+
+		/*
+		 * uniform packet command handling
+		 */
+		case CDROMEJECT:
+		case CDROMCLOSETRAY:
+			return block_ioctl(inode->i_bdev, cmd, arg);
+
+		case BLKRRPART: /* Re-read partition tables */
+			return ata_revalidate(inode->i_rdev);
+
 		case BLKGETSIZE:
 		case BLKGETSIZE64:
 		case BLKROSET:
@@ -254,25 +382,6 @@
 		case BLKBSZSET:
 			return blk_ioctl(inode->i_bdev, cmd, arg);
 
-		/*
-		 * uniform packet command handling
-		 */
-		case CDROMEJECT:
-		case CDROMCLOSETRAY:
-			return block_ioctl(inode->i_bdev, cmd, arg);
-
-		case HDIO_GET_BUSSTATE:
-			if (put_user(drive->channel->bus_state, (long *)arg))
-				return -EFAULT;
-
-			return 0;
-
-		case HDIO_SET_BUSSTATE:
-			if (drive->channel->busproc)
-				drive->channel->busproc(drive, (int)arg);
-
-			return 0;
-
 		/* Now check whatever this particular ioctl has a device type
 		 * specific implementation.
 		 */
diff -urN linux-2.5.19/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.19/drivers/ide/ns87415.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-06-01 21:32:31.000000000 +0200
@@ -193,7 +193,7 @@
 		 * XXX: Reset the device, if we don't it will not respond
 		 *      to select properly during first probe.
 		 */
-		ata_reset(struct ata_channel *hwif);
+		ata_reset(hwif);
 #endif
 	}
 
diff -urN linux-2.5.19/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.19/drivers/scsi/ide-scsi.c	2002-06-01 23:17:28.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-06-01 23:39:24.000000000 +0200
@@ -412,9 +412,9 @@
 
 	ata_select(drive, 10);
 	ata_irq_enable(drive, 1);
-	OUT_BYTE (dma_ok,IDE_FEATURE_REG);
-	OUT_BYTE (bcount >> 8,IDE_BCOUNTH_REG);
-	OUT_BYTE (bcount & 0xff,IDE_BCOUNTL_REG);
+	OUT_BYTE(dma_ok,IDE_FEATURE_REG);
+	OUT_BYTE(bcount >> 8,IDE_BCOUNTH_REG);
+	OUT_BYTE(bcount & 0xff,IDE_BCOUNTL_REG);
 
 	if (dma_ok) {
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
@@ -662,17 +662,20 @@
 		}
 	}
 
-	ide_init_drive_cmd (rq);
+	memset(rq, 0, sizeof(*rq));
+	rq->flags = REQ_SPECIAL;
 	rq->special = (char *) pc;
 	rq->bio = idescsi_dma_bio (drive, pc);
-	rq->flags = REQ_SPECIAL;
 	spin_unlock_irq(cmd->host->host_lock);
-	(void) ide_do_drive_cmd (drive, rq, ide_end);
+	ide_do_drive_cmd (drive, rq, ide_end);
 	spin_lock_irq(cmd->host->host_lock);
+
 	return 0;
 abort:
-	if (pc) kfree (pc);
-	if (rq) kfree (rq);
+	if (pc)
+		kfree (pc);
+	if (rq)
+		kfree (rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
 
diff -urN linux-2.5.19/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.19/include/linux/hdreg.h	2002-05-29 20:42:54.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-06-01 22:45:05.000000000 +0200
@@ -81,18 +81,9 @@
 	u8 low_cylinder;
 	u8 high_cylinder;
 	u8 device_head;
-	u8 command;
-} __attribute__((packed));
 
-struct hd_drive_hob_hdr {
-	u8 data;
-	u8 feature;
-	u8 sector_count;
-	u8 sector_number;
-	u8 low_cylinder;
-	u8 high_cylinder;
-	u8 device_head;
-	u8 control;
+	/* FXIME: Consider moving this out from here. */
+	u8 command;
 } __attribute__((packed));
 
 /*
diff -urN linux-2.5.19/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.19/include/linux/ide.h	2002-06-01 23:17:29.000000000 +0200
+++ linux/include/linux/ide.h	2002-06-01 23:58:26.000000000 +0200
@@ -253,11 +253,11 @@
 	unsigned all			: 8;	/* all of the bits together */
 	struct {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned head		: 4;	/* always zeros here */
+		unsigned XXX_head	: 4;	/* always zeros here */
 		unsigned unit		: 1;	/* drive select number: 0/1 */
-		unsigned bit5		: 1;	/* always 1 */
+		unsigned XXX_bit5	: 1;	/* always 1 */
 		unsigned lba		: 1;	/* using LBA instead of CHS */
-		unsigned bit7		: 1;	/* always 1 */
+		unsigned XXX_bit7	: 1;	/* always 1 */
 #elif defined(__BIG_ENDIAN_BITFIELD)
 		unsigned bit7		: 1;
 		unsigned lba		: 1;
@@ -270,29 +270,6 @@
 	} b;
 } select_t;
 
-typedef union {
-	unsigned all			: 8;	/* all of the bits together */
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned bit0		: 1;
-		unsigned nIEN		: 1;	/* device INTRQ to host */
-		unsigned SRST		: 1;	/* host soft reset bit */
-		unsigned bit3		: 1;	/* ATA-2 thingy */
-		unsigned reserved456	: 3;
-		unsigned HOB		: 1;	/* 48-bit address ordering */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned HOB		: 1;
-		unsigned reserved456	: 3;
-		unsigned bit3		: 1;
-		unsigned SRST		: 1;
-		unsigned nIEN		: 1;
-		unsigned bit0		: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} control_t;
-
 /*
  * ATA/ATAPI device structure :
  */
@@ -530,7 +507,7 @@
  * Register new hardware with ide
  */
 extern int ide_register_hw(hw_regs_t *hw);
-extern void ide_unregister(struct ata_channel *hwif);
+extern void ide_unregister(struct ata_channel *);
 
 struct ata_taskfile;
 
@@ -671,11 +648,6 @@
 ide_startstop_t restart_request(struct ata_device *);
 
 /*
- * This function is intended to be used prior to invoking ide_do_drive_cmd().
- */
-extern void ide_init_drive_cmd(struct request *rq);
-
-/*
  * "action" parameter type for ide_do_drive_cmd() below.
  */
 typedef enum {
@@ -698,7 +670,7 @@
 
 struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr  hobfile;
+	struct hd_drive_task_hdr  hobfile;
 	int command_type;
 	ide_startstop_t (*prehandler)(struct ata_device *, struct request *);
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);
@@ -717,21 +689,18 @@
 extern ide_startstop_t recal_intr(struct ata_device *, struct request *);
 extern ide_startstop_t task_no_data_intr(struct ata_device *, struct request *);
 
-
-/* This is setting up all fields in args, which depend upon the command type.
- */
 extern void ide_cmd_type_parser(struct ata_taskfile *args);
 extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
-extern int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg);
 
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_config_drive_speed(struct ata_device *, byte);
 extern byte eighty_ninty_three(struct ata_device *);
 
-extern int system_bus_speed;
 
 extern void ide_stall_queue(struct ata_device *, unsigned long);
 
+extern int system_bus_speed;
+
 /*
  * CompactFlash cards and their brethern pretend to be removable hard disks,
  * but they never have a slave unit, and they don't have doorlock mechanisms.
@@ -873,5 +842,6 @@
 extern int ata_status(struct ata_device *, u8, u8);
 extern int ata_irq_enable(struct ata_device *, int);
 extern void ata_reset(struct ata_channel *);
+extern void ata_out_regfile(struct ata_device *, struct hd_drive_task_hdr *);
 
 #endif

--------------090300010104060906010607--

