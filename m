Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTKMP4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTKMPz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:55:59 -0500
Received: from www5.mail.lycos.com ([209.202.220.85]:16602 "HELO lycos.com")
	by vger.kernel.org with SMTP id S264321AbTKMPyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:54:53 -0500
To: B.Zolnierkiewicz@elka.pw.edu.pl
Date: Thu, 13 Nov 2003 10:54:37 -0500
From: "stuart hayes" <stuart_hayes@lycos.com>
Message-ID: <DPMCCJOJLIGDCEAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
X-Sent-Mail: off
Reply-To: stuart_hayes@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: PATCH:  gets ide-tape working on 2.6
X-Sender-Ip: 143.166.255.18
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the patch in plain text.

--

Bart (et al),

Here's a patch for ide-tape.c that gets ide-tape working on the 2.6 kernel.

This should be applied after your recent patch that fixed the rq->flags stuff in ide-tape.

There's nothing in here that will make it more difficult to change the rq->flags stuff later if necessary--this will just tweak a few things to get the driver functional.

Most of this stuff is just stuff to get the Seagate STT3401A Travan tape drive working, as I already submitted for the 2.4 kernel.

Thanks!
Stuart

(I'll resend this in just a moment as plain text--I have to do that from a different email account.)



--- ide-tape.c.orig	2003-11-05 11:08:49.000000000 -0600
+++ ide-tape.c.26works	2003-11-13 09:32:53.188145144 -0600
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-tape.c		Version 1.17b	Oct, 2002
+ * linux/drivers/ide/ide-tape.c		Version 1.18	Oct, 2003
  *
  * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>
  *
@@ -313,6 +313,28 @@
  *			Cosmetic fixes to miscellaneous debugging output messages.
  *			Set the minimum /proc/ide/hd?/settings values for "pipeline",
  *			 "pipeline_min", and "pipeline_max" to 1.
+ * Ver 1.18 Oct 2003	Stuart Hayes <stuart_hayes@dell.com>
+ *			Check drive's write protect bit, try to return appropriate
+ *			  errors when attempting to write a write-protected tape
+ *			Moved "idetape_read_position" call in idetape_chrdev_open
+ *			  after the "wait_ready" call
+ *			Added IDETAPE_MEDIUM_PRESENT flag so driver would know
+ *			  not to rewind tape after ejecting it 
+ *			Fixed bug with ide_abort_pipeline (it was deleting stages
+ *			  from tape->next_stage to end, instead of from
+ *			  new_last_stage->next (tape->next_stage was set to NULL
+ *			  by idetape_discard_read_pipeline before calling!)
+ *			Made improvements to idetape_wait_ready
+ *			Added a few comments here and there
+ *			Made MTOFFL unlock tape drive door before attempting to eject
+ *			Added fixes to get Seagate STT3401A Travan working:
+ *			  handle drives that don't support 0-length reads/writes
+ *			  increased timeout (retension takes ~10 minutes before
+ *			    irq is returned)
+ *			  fixed request mode page packet command byte 3
+ *			Changed spinlock_irqsave to spinlock when calling
+ *			  "idetape_wait_for_request" so IRQs wouldn't be
+ *			  masked when we call "wait_for_completion"
  *
  * Here are some words from the first releases of hd.c, which are quoted
  * in ide.c and apply here as well:
@@ -422,7 +444,7 @@
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
  */
 
-#define IDETAPE_VERSION "1.17b-ac1"
+#define IDETAPE_VERSION "1.18"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -451,7 +473,6 @@
 #include <asm/bitops.h>
 
 
-#define NO_LONGER_REQUIRED	(1)
 
 /*
  *	OnStream support
@@ -653,8 +674,13 @@
 
 /*
  *	Some tape drives require a long irq timeout
+ *
+ *	Some drives (for example, the Seagate STT3401A Travan)
+ *	require a very long timeout, because they don't
+ *	return an interrupt or clear their busy bit until after the
+ *	command completes--even retension commands.
  */
-#define IDETAPE_WAIT_CMD		(60*HZ)
+#define IDETAPE_WAIT_CMD		(900*HZ)
 
 /*
  *	The following parameter is used to select the point in the internal
@@ -1032,6 +1058,10 @@
 
 	/* the door is currently locked */
 	int door_locked;
+	/* the tape hardware is write protected */
+	char drv_write_prot;
+	/* the tape is write protected (hardware or opened as read-only) */
+	char write_prot;
 
 	/*
 	 * OnStream flags
@@ -1164,6 +1194,7 @@
 #define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
 #define IDETAPE_READ_ERROR		7
 #define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
+#define IDETAPE_MEDIUM_PRESENT		9	/* 0=no tape is loaded, so we don't rewind after ejecting */
 
 /*
  *	Supported ATAPI tape drives packet commands
@@ -1665,6 +1696,20 @@
 		idetape_update_buffers(pc);
 	}
 
+	/*	If error was the result of a zero-length read or write
+	 *	command, with sense key=5, asc=0x22, ascq=0, let it
+	 *	slide... some drives (Seagate STT3401A Travan) don't
+	 *	support 0-length read/writes
+	 */
+
+	if ((pc->c[0] == IDETAPE_READ_CMD || pc->c[0] == IDETAPE_WRITE_CMD)
+	    && pc->c[4] == 0 && pc->c[3] == 0 && pc->c[2] == 0) { /* length==0 */
+		if (result->sense_key == 5) {
+			pc->error = 0; /* don't report an error, everything's ok */
+			set_bit(PC_ABORT, &pc->flags); /* don't retry read/write */
+		}
+	}
+
 	if (pc->c[0] == IDETAPE_READ_CMD && result->filemark) {
 		pc->error = IDETAPE_ERROR_FILEMARK;
 		set_bit(PC_ABORT, &pc->flags);
@@ -1805,10 +1850,18 @@
 	}
 }
 
-static void idetape_abort_pipeline (ide_drive_t *drive, idetape_stage_t *last_stage)
+/*
+ * idetape_abort_pipeline
+ * ----------------------
+ *   This will free all the pipeline stages starting from
+ *     new_last_stage->next to the end of the list, and point
+ *     tape->last_stage to new_last_stage.
+ */
+
+static void idetape_abort_pipeline (ide_drive_t *drive, idetape_stage_t *new_last_stage)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage = tape->next_stage;
+	idetape_stage_t *stage = new_last_stage->next;
 	idetape_stage_t *nstage;
 
 #if IDETAPE_DEBUG_LOG
@@ -1822,9 +1875,9 @@
 		--tape->nr_pending_stages;
 		stage = nstage;
 	}
-	tape->last_stage = last_stage;
-	if (last_stage)
-		last_stage->next = NULL;
+	if (new_last_stage)
+		new_last_stage->next = NULL;
+	tape->last_stage = new_last_stage;
 	tape->next_stage = NULL;
 }
 
@@ -1995,6 +2048,7 @@
 {
 	ide_init_drive_cmd(rq);
 	rq->buffer = (char *) pc;
+	rq->flags &= ~(REQ_DRIVE_CMD);
 	rq->flags |= REQ_IDETAPE_PC1;
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
@@ -2430,7 +2484,11 @@
 	if (page_code != IDETAPE_BLOCK_DESCRIPTOR)
 		pc->c[1] = 8;	/* DBD = 1 - Don't return block descriptors */
 	pc->c[2] = page_code;
-	pc->c[3] = 255;		/* Don't limit the returned information */
+	/* Changed pc->c[3] (subpages) to 0... 255 will at best return  *
+	 *   unused info... for SCSI, this byte is defined as subpage   *
+	 *   instead of high byte of length, and some IDE drives        *
+	 *   seem to interpret it this way and return an error.         */
+	pc->c[3] = 0;		/* Don't limit the returned information */
 	pc->c[4] = 255;		/* (We will just discard data in that case) */
 	if (page_code == IDETAPE_BLOCK_DESCRIPTOR)
 		pc->request_transfer = 12;
@@ -2544,7 +2602,8 @@
 	if (status.b.dsc) {
 		if (status.b.check) {
 			/* Error detected */
-			printk(KERN_ERR "ide-tape: %s: I/O error, ",tape->name);
+			if (pc->c[0] != IDETAPE_TEST_UNIT_READY_CMD)
+				printk(KERN_ERR "ide-tape: %s: I/O error, ",tape->name);
 
 			/* Retry operation */
 			return idetape_retry_pc(drive);
@@ -3174,7 +3233,7 @@
 	wait_for_completion(&wait);
 	/* The stage and its struct request have been deallocated */
 	tape->waiting = NULL;
-	spin_lock_irq(&tape->spinlock);
+	spin_lock(&tape->spinlock);
 }
 
 static ide_startstop_t idetape_read_position_callback (ide_drive_t *drive)
@@ -3271,6 +3330,7 @@
 
 	ide_init_drive_cmd(&rq);
 	rq.buffer = (char *) pc;
+	rq.flags &= ~(REQ_DRIVE_CMD);
 	rq.flags |= REQ_IDETAPE_PC1;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -3295,25 +3355,26 @@
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
-
+	int load_attempted = 0;
 	/*
 	 * Wait for the tape to become ready
 	 */
+	set_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags);
 	timeout += jiffies;
 	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
 		if (!__idetape_queue_pc_tail(drive, &pc))
 			return 0;
-		if (tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2) {
-			idetape_create_load_unload_cmd(drive, &pc, IDETAPE_LU_LOAD_MASK);
-			__idetape_queue_pc_tail(drive, &pc);
-			idetape_create_test_unit_ready_cmd(&pc);
-			if (!__idetape_queue_pc_tail(drive, &pc))
-				return 0;
-		}
-		if (!(tape->sense_key == 2 && tape->asc == 4 &&
-		      (tape->ascq == 1 || tape->ascq == 8)))
-			break;
+		if ((tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2)
+		    || (tape->asc == 0x3A)) {  /* no media... */
+			if (!load_attempted) {
+				idetape_create_load_unload_cmd(drive, &pc, IDETAPE_LU_LOAD_MASK);
+				__idetape_queue_pc_tail(drive, &pc);
+				load_attempted = 1;
+			} else return -ENOMEDIUM;
+		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
+		           (tape->ascq == 1 || tape->ascq == 8))) /* not about to be ready... */
+			return -EIO;
 		current->state = TASK_INTERRUPTIBLE;
   		schedule_timeout(HZ / 10);
 	}
@@ -3436,6 +3497,8 @@
 
 	if (tape->chrdev_direction != idetape_direction_read)
 		return 0;
+
+	/* Remove merge stage */
 	cnt = tape->merge_stage_size / tape->tape_block_size;
 	if (test_and_clear_bit(IDETAPE_FILEMARK, &tape->flags))
 		++cnt;		/* Filemarks count as 1 sector */
@@ -3444,17 +3507,20 @@
 		__idetape_kfree_stage(tape->merge_stage);
 		tape->merge_stage = NULL;
 	}
+
+	/* Clear pipeline flags */
 	clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 	tape->chrdev_direction = idetape_direction_none;
-	
+
+	/* Remove pipeline stages */
 	if (tape->first_stage == NULL)
 		return 0;
 
-	spin_lock_irqsave(&tape->spinlock, flags);
+	spin_lock(&tape->spinlock);
 	tape->next_stage = NULL;
 	if (idetape_pipeline_active(tape))
 		idetape_wait_for_request(drive, tape->active_data_request);
-	spin_unlock_irqrestore(&tape->spinlock, flags);
+	spin_unlock(&tape->spinlock);
 
 	while (tape->first_stage != NULL) {
 		struct request *rq_ptr = &tape->first_stage->rq;
@@ -3547,6 +3613,7 @@
 #endif /* IDETAPE_DEBUG_BUGS */	
 
 	ide_init_drive_cmd(&rq);
+	rq.flags &= ~(REQ_DRIVE_CMD);
 	rq.special = (void *)bh;
 	rq.flags |= cmd;
 	rq.sector = tape->first_frame_position;
@@ -3597,6 +3664,7 @@
 #endif
 		rq = &stage->rq;
 		ide_init_drive_cmd(rq);
+		rq->flags &= ~(REQ_DRIVE_CMD);
 		rq->flags |= REQ_IDETAPE_WRITE;
 		rq->sector = tape->first_frame_position;
 		rq->nr_sectors = rq->current_nr_sectors = tape->capabilities.ctl;
@@ -3820,10 +3888,10 @@
 
 	if (tape->first_stage == NULL)
 		return;
-	spin_lock_irqsave(&tape->spinlock, flags);
+	spin_lock(&tape->spinlock);
 	if (tape->active_stage == tape->first_stage)
 		idetape_wait_for_request(drive, tape->active_data_request);
-	spin_unlock_irqrestore(&tape->spinlock, flags);
+	spin_unlock(&tape->spinlock);
 }
 
 /*
@@ -3854,12 +3922,12 @@
 	 *	Pay special attention to possible race conditions.
 	 */
 	while ((new_stage = idetape_kmalloc_stage(tape)) == NULL) {
-		spin_lock_irqsave(&tape->spinlock, flags);
+		spin_lock(&tape->spinlock);
 		if (idetape_pipeline_active(tape)) {
 			idetape_wait_for_request(drive, tape->active_data_request);
-			spin_unlock_irqrestore(&tape->spinlock, flags);
+			spin_unlock(&tape->spinlock);
 		} else {
-			spin_unlock_irqrestore(&tape->spinlock, flags);
+			spin_unlock(&tape->spinlock);
 			idetape_insert_pipeline_into_queue(drive);
 			if (idetape_pipeline_active(tape))
 				continue;
@@ -3872,6 +3940,7 @@
 	}
 	rq = &new_stage->rq;
 	ide_init_drive_cmd(rq);
+	rq->flags &= ~(REQ_DRIVE_CMD);
 	rq->flags |= REQ_IDETAPE_WRITE;
 	/* Doesn't actually matter - We always assume sequential access */
 	rq->sector = tape->first_frame_position;
@@ -3934,10 +4003,10 @@
 
 	while (tape->next_stage || idetape_pipeline_active(tape)) {
 		idetape_insert_pipeline_into_queue(drive);
-		spin_lock_irqsave(&tape->spinlock, flags);
+		spin_lock(&tape->spinlock);
 		if (idetape_pipeline_active(tape))
 			idetape_wait_for_request(drive, tape->active_data_request);
-		spin_unlock_irqrestore(&tape->spinlock, flags);
+		spin_unlock(&tape->spinlock);
 	}
 }
 
@@ -4059,18 +4128,23 @@
 		 *	Issue a read 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
 		 *	mode.
+		 *	No point in issuing this if dsc_overlap isn't supported
+		 *	(some drives (Seagate STT3401A) will return an error).
 		 */
-		bytes_read = idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 0, tape->merge_stage->bh);
-		if (bytes_read < 0) {
-			__idetape_kfree_stage(tape->merge_stage);
-			tape->merge_stage = NULL;
-			tape->chrdev_direction = idetape_direction_none;
-			return bytes_read;
+		if (drive->dsc_overlap) {
+			bytes_read = idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 0, tape->merge_stage->bh);
+			if (bytes_read < 0) {
+				__idetape_kfree_stage(tape->merge_stage);
+				tape->merge_stage = NULL;
+				tape->chrdev_direction = idetape_direction_none;
+				return bytes_read;
+			}
 		}
 	}
 	if (tape->restart_speed_control_req)
 		idetape_restart_speed_control(drive);
 	ide_init_drive_cmd(&rq);
+	rq.flags &= ~(REQ_DRIVE_CMD);
 	rq.flags |= REQ_IDETAPE_READ;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
@@ -4658,7 +4732,9 @@
 static ssize_t idetape_chrdev_read (struct file *file, char *buf,
 				    size_t count, loff_t *ppos)
 {
-	ide_drive_t *drive = file->private_data;
+	struct inode *inode = file->f_dentry->d_inode;
+	unsigned int minor = iminor(inode);
+	ide_drive_t *drive = idetape_chrdevs[minor & ~0xC0].drive;
 	idetape_tape_t *tape = drive->driver_data;
 	ssize_t bytes_read,temp, actually_read = 0, rc;
 
@@ -4887,9 +4963,9 @@
 				     size_t count, loff_t *ppos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	ide_drive_t *drive = file->private_data;
-	idetape_tape_t *tape = drive->driver_data;
 	unsigned int minor = iminor(inode);
+	ide_drive_t *drive = idetape_chrdevs[minor&~0xC0].drive;
+	idetape_tape_t *tape = drive->driver_data;
 	ssize_t retval, actually_written = 0;
 	int position;
 
@@ -4898,6 +4974,11 @@
 		return -ENXIO;
 	}
 
+	if (tape->write_prot) {
+		/* The drive is write protected */
+		return -EACCES;
+	}
+
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
 		printk(KERN_INFO "ide-tape: Reached idetape_chrdev_write, "
@@ -4979,13 +5060,17 @@
 		 *	Issue a write 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
 		 *	mode.
+		 *	No point in issuing this if dsc_overlap isn't supported
+		 *	(some drives (Seagate STT3401A) will return an error).
 		 */
-		retval = idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, tape->merge_stage->bh);
-		if (retval < 0) {
-			__idetape_kfree_stage(tape->merge_stage);
-			tape->merge_stage = NULL;
-			tape->chrdev_direction = idetape_direction_none;
-			return retval;
+		if (drive->dsc_overlap) {
+			retval = idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, tape->merge_stage->bh);
+			if (retval < 0) {
+				__idetape_kfree_stage(tape->merge_stage);
+				tape->merge_stage = NULL;
+				tape->chrdev_direction = idetape_direction_none;
+				return retval;
+			}
 		}
 #if ONSTREAM_DEBUG
 		if (tape->debug_level >= 2)
@@ -5141,7 +5226,7 @@
  *	Note:
  *
  *		MTBSF and MTBSFM are not supported when the tape doesn't
- *		supports spacing over filemarks in the reverse direction.
+ *		support spacing over filemarks in the reverse direction.
  *		In this case, MTFSFM is also usually not supported (it is
  *		supported in the rare case in which we crossed the filemark
  *		during our read-ahead pipelined operation mode).
@@ -5211,6 +5296,8 @@
 	}
 	switch (mt_op) {
 		case MTWEOF:
+			if (tape->write_prot)
+				return -EACCES;
 			idetape_discard_read_pipeline(drive, 1);
 			for (i = 0; i < mt_count; i++) {
 				retval = idetape_write_filemark(drive);
@@ -5232,8 +5319,16 @@
 		case MTUNLOAD:
 		case MTOFFL:
 			idetape_discard_read_pipeline(drive, 0);
+			/* if door is locked, attempt to unlock  */
+			/* before attempting to eject            */
+			if (tape->door_locked)
+				if (idetape_create_prevent_cmd(drive, &pc, 0))
+					if (!idetape_queue_pc_tail(drive, &pc))
+						tape->door_locked = DOOR_UNLOCKED;
 			idetape_create_load_unload_cmd(drive, &pc,!IDETAPE_LU_LOAD_MASK);
-			return (idetape_queue_pc_tail(drive, &pc));
+			if (!(retval= idetape_queue_pc_tail(drive, &pc)))
+				clear_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags);
+			return retval;
 		case MTNOP:
 			idetape_discard_read_pipeline(drive, 0);
 			return (idetape_flush_tape_buffers(drive));
@@ -5363,7 +5458,7 @@
  */
 static int idetape_chrdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	ide_drive_t *drive = file->private_data;
+	ide_drive_t *drive = idetape_chrdevs[iminor(inode)&~0xC0].drive;
 	idetape_tape_t *tape = drive->driver_data;
 	struct mtop mtop;
 	struct mtget mtget;
@@ -5403,12 +5498,15 @@
 					mtget.mt_blkno = tape->logical_blk_num;
 			}
 			mtget.mt_dsreg = ((tape->tape_block_size * tape->user_bs_factor) << MT_ST_BLKSIZE_SHIFT) & MT_ST_BLKSIZE_MASK;
+			mtget.mt_gstat = 0;
 			if (tape->onstream) {
 				mtget.mt_gstat |= GMT_ONLINE(0xffffffff);
 				if (tape->first_stage && tape->first_stage->aux->frame_type == OS_FRAME_TYPE_EOD)
 					mtget.mt_gstat |= GMT_EOD(0xffffffff);
 				if (position <= OS_DATA_STARTFRAME1)
 					mtget.mt_gstat |= GMT_BOT(0xffffffff);
+			} else {
+				if (tape->drv_write_prot) mtget.mt_gstat |= GMT_WR_PROT(0xffffffff);
 			}
 			if (copy_to_user((char *) arg,(char *) &mtget, sizeof(struct mtget)))
 				return -EFAULT;
@@ -5530,6 +5628,8 @@
 	return 1;
 }
 
+static void idetape_get_blocksize_from_block_descriptor(ide_drive_t *drive);
+
 /*
  *	Our character device open function.
  */
@@ -5539,7 +5639,8 @@
 	ide_drive_t *drive;
 	idetape_tape_t *tape;
 	idetape_pc_t pc;
-			
+	int retval;
+
 #if IDETAPE_DEBUG_LOG
 	printk(KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");
 #endif /* IDETAPE_DEBUG_LOG */
@@ -5551,11 +5652,7 @@
 
 	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags))
 		return -EBUSY;
-	if (!tape->onstream) {	
-		idetape_read_position(drive);
-		if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))
-			(void) idetape_rewind_tape(drive);
-	} else {
+	if (tape->onstream) {
 		if (minor & 64) {
 			tape->tape_block_size = tape->stage_size = 32768 + 512;
 			tape->raw = 1;
@@ -5565,16 +5662,40 @@
 		}
                 idetape_onstream_mode_sense_tape_parameter_page(drive, tape->debug_level);
 	}
-	if (idetape_wait_ready(drive, 60 * HZ)) {
+
+	/* See if the drive is ready to go */
+	if ((retval = idetape_wait_ready(drive, 60 * HZ))) {
 		clear_bit(IDETAPE_BUSY, &tape->flags);
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);
-		return -EBUSY;
+		return retval;
 	}
-	if (tape->onstream)
-		idetape_read_position(drive);
+
+	/* Read the tape position */
+	idetape_read_position(drive);
+	if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))
+		(void) idetape_rewind_tape(drive);
+
 	if (tape->chrdev_direction != idetape_direction_read)
 		clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 
+	/* Read block size and write protect status from drive */
+	idetape_get_blocksize_from_block_descriptor(drive);
+
+	/* Set write protect flag if device is opened as read-only */
+	if ( (filp->f_flags & O_ACCMODE)==O_RDONLY)
+		tape->write_prot = 1;
+	else tape->write_prot = tape->drv_write_prot;
+
+	/* Make sure drive isn't write protected if user wants to write */
+	if (tape->write_prot)
+		if ( (filp->f_flags & O_ACCMODE)==O_WRONLY ||
+		     (filp->f_flags & O_ACCMODE)==O_RDWR) {
+			clear_bit (IDETAPE_BUSY, &tape->flags);
+			return -EROFS;
+	}
+
+	/* Lock the tape drive door so user can't eject */
+	/* (and analyze headers for OnStream drives)    */
 	if (tape->chrdev_direction == idetape_direction_none) {
 		if (idetape_create_prevent_cmd(drive, &pc, 1)) {
 			if (!idetape_queue_pc_tail(drive, &pc)) {
@@ -5613,7 +5734,7 @@
  */
 static int idetape_chrdev_release (struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = filp->private_data;
+	ide_drive_t *drive = idetape_chrdevs[iminor(inode)&~0xC0].drive;
 	idetape_tape_t *tape;
 	idetape_pc_t pc;
 	unsigned int minor = iminor(inode);
@@ -5637,7 +5758,7 @@
 		__idetape_kfree_stage(tape->cache_stage);
 		tape->cache_stage = NULL;
 	}
-	if (minor < 128)
+	if ((minor < 128) && (test_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags)))
 		(void) idetape_rewind_tape(drive);
 	if (tape->chrdev_direction == idetape_direction_none) {
 		if (tape->door_locked == DOOR_LOCKED) {
@@ -6058,6 +6179,8 @@
 	header = (idetape_mode_parameter_header_t *) pc.buffer;
 	block_descrp = (idetape_parameter_block_descriptor_t *) (pc.buffer + sizeof(idetape_mode_parameter_header_t));
 	tape->tape_block_size =( block_descrp->length[0]<<16) + (block_descrp->length[1]<<8) + block_descrp->length[2];
+	tape->drv_write_prot = tape->write_prot = (header->dsp & 0x80) >> 7;
+
 #if IDETAPE_DEBUG_INFO
 	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
 #endif /* IDETAPE_DEBUG_INFO */
@@ -6137,6 +6260,9 @@
 		    	drive->dsc_overlap = 0;
 		}
 	}
+	/* Seagate Travan drives do not support DSC overlap */
+	if (strstr(drive->id->model,"Seagate STT3401"))
+		drive->dsc_overlap = 0;
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 	tape->drive = drive;
 	tape->minor = minor;



____________________________________________________________
Enter now for a chance to win a 42" Plasma Television!
http://ad.doubleclick.net/clk;6413623;3807821;f?http://mocda1.com/1/c/563632/113422/313631/313631
AOL users go here: http://ad.doubleclick.net/clk;6413623;3807821;f?http://mocda1.com/1/c/563632/113422/313631/313631
This offer applies to U.S. Residents Only
