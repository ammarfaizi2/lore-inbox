Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTKMWGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTKMWGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:06:20 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2439 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264439AbTKMWE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:04:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: stuart_hayes@lycos.com
Subject: [PATCH] ide-tape update for 2.6 (Was: PATCH:  gets ide-tape working on 2.6)
Date: Thu, 13 Nov 2003 23:04:51 +0100
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <DPMCCJOJLIGDCEAA@mailcity.com>
In-Reply-To: <DPMCCJOJLIGDCEAA@mailcity.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311132304.51538.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ with changed subject because ide-tape _is_ already working in 2.6 ]

On Thursday 13 of November 2003 16:54, stuart hayes wrote:
> Here's the patch in plain text.
>
> --
>
> Bart (et al),
>
> Here's a patch for ide-tape.c that gets ide-tape working on the 2.6 kernel.
>
> This should be applied after your recent patch that fixed the rq->flags
> stuff in ide-tape.

Current 2.6 -bk tree already contains corrected version of my patch
and fix for ide-tape character device (so no need to use iminor(inode)).

-bk snapshots are at http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/

I've updated your patch accordingly.

> There's nothing in here that will make it more difficult to change the
> rq->flags stuff later if necessary--this will just tweak a few things to
> get the driver functional.
>
> Most of this stuff is just stuff to get the Seagate STT3401A Travan tape
> drive working, as I already submitted for the 2.4 kernel.

I dropped tape->spinlock changes.  They are racy, you can't use spin_lock()
for tape->spinlock because this lock can be taken from IRQ context
(i.e. through idetape_pc_intr() -> pc->callback() -> idetape_end_request()).
I moved check for Travan drives outside CONFIG_BLK_DEV_IDEPCI.
I also removed code depending on NO_LONGER_NEEDED define to match 2.4.x
kernel (it was removed in 2.4.21 kernel) and made some cosmetics.

Thanks,
--bartlomiej


[IDE] ide-tape update

From: Stuart Hayes <stuart_hayes@dell.com>

- Check drive's write protect bit, try to return appropriate
  errors when attempting to write a write-protected tape.

- Moved "idetape_read_position" call in idetape_chrdev_open
  after the "wait_ready" call.

- Added IDETAPE_MEDIUM_PRESENT flag so driver would know
  not to rewind tape after ejecting it.

- Fixed bug with ide_abort_pipeline (it was deleting stages
  from tape->next_stage to end, instead of from
  new_last_stage->next (tape->next_stage was set to NULL
  by idetape_discard_read_pipeline before calling!).

- Made improvements to idetape_wait_ready.

- Added a few comments here and there.

- Made MTOFFL unlock tape drive door before attempting to eject.

- Added fixes to get Seagate STT3401A Travan working:
  Handle drives that don't support 0-length reads/writes increased timeout
  (retension takes ~10 minutes before irq is returned).
  Fixed request mode page packet command byte 3.

Also remove code depending on NO_LONGER_REQUIRED to match 2.4.x (me).

 drivers/ide/ide-tape.c |  211 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 147 insertions(+), 64 deletions(-)

diff -puN drivers/ide/ide-tape.c~ide-tape-update drivers/ide/ide-tape.c
--- linux-2.6.0-test9-bk17/drivers/ide/ide-tape.c~ide-tape-update	2003-11-13 18:25:52.537457360 +0100
+++ linux-2.6.0-test9-bk17-root/drivers/ide/ide-tape.c	2003-11-13 22:37:06.768825864 +0100
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-tape.c		Version 1.17b	Oct, 2002
+ * linux/drivers/ide/ide-tape.c		Version 1.18	Nov, 2003
  *
  * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>
  *
@@ -422,7 +422,7 @@
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
  */
 
-#define IDETAPE_VERSION "1.17b-ac1"
+#define IDETAPE_VERSION "1.18"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -450,9 +450,6 @@
 #include <asm/unaligned.h>
 #include <asm/bitops.h>
 
-
-#define NO_LONGER_REQUIRED	(1)
-
 /*
  *	OnStream support
  */
@@ -652,9 +649,11 @@ typedef struct {
 #define IDETAPE_PC_STACK		(10 + IDETAPE_MAX_PC_RETRIES)
 
 /*
- *	Some tape drives require a long irq timeout
+ * Some drives (for example, Seagate STT3401A Travan) require a very long
+ * timeout, because they don't return an interrupt or clear their busy bit
+ * until after the command completes (even retension commands).
  */
-#define IDETAPE_WAIT_CMD		(60*HZ)
+#define IDETAPE_WAIT_CMD		(900*HZ)
 
 /*
  *	The following parameter is used to select the point in the internal
@@ -1032,6 +1031,10 @@ typedef struct {
 
 	/* the door is currently locked */
 	int door_locked;
+	/* the tape hardware is write protected */
+	char drv_write_prot;
+	/* the tape is write protected (hardware or opened as read-only) */
+	char write_prot;
 
 	/*
 	 * OnStream flags
@@ -1164,6 +1167,8 @@ typedef struct {
 #define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
 #define IDETAPE_READ_ERROR		7
 #define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
+/* 0 = no tape is loaded, so we don't rewind after ejecting */
+#define IDETAPE_MEDIUM_PRESENT		9
 
 /*
  *	Supported ATAPI tape drives packet commands
@@ -1665,6 +1670,20 @@ static void idetape_analyze_error (ide_d
 		idetape_update_buffers(pc);
 	}
 
+	/*
+	 * If error was the result of a zero-length read or write command,
+	 * with sense key=5, asc=0x22, ascq=0, let it slide.  Some drives
+	 * (i.e. Seagate STT3401A Travan) don't support 0-length read/writes.
+	 */
+	if ((pc->c[0] == IDETAPE_READ_CMD || pc->c[0] == IDETAPE_WRITE_CMD)
+	    && pc->c[4] == 0 && pc->c[3] == 0 && pc->c[2] == 0) { /* length==0 */
+		if (result->sense_key == 5) {
+			/* don't report an error, everything's ok */
+			pc->error = 0;
+			/* don't retry read/write */
+			set_bit(PC_ABORT, &pc->flags);
+		}
+	}
 	if (pc->c[0] == IDETAPE_READ_CMD && result->filemark) {
 		pc->error = IDETAPE_ERROR_FILEMARK;
 		set_bit(PC_ABORT, &pc->flags);
@@ -1805,10 +1824,15 @@ static void idetape_remove_stage_head (i
 	}
 }
 
-static void idetape_abort_pipeline (ide_drive_t *drive, idetape_stage_t *last_stage)
+/*
+ * This will free all the pipeline stages starting from new_last_stage->next
+ * to the end of the list, and point tape->last_stage to new_last_stage.
+ */
+static void idetape_abort_pipeline(ide_drive_t *drive,
+				   idetape_stage_t *new_last_stage)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage = tape->next_stage;
+	idetape_stage_t *stage = new_last_stage->next;
 	idetape_stage_t *nstage;
 
 #if IDETAPE_DEBUG_LOG
@@ -1822,9 +1846,9 @@ static void idetape_abort_pipeline (ide_
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
 
@@ -2430,7 +2454,14 @@ static void idetape_create_mode_sense_cm
 	if (page_code != IDETAPE_BLOCK_DESCRIPTOR)
 		pc->c[1] = 8;	/* DBD = 1 - Don't return block descriptors */
 	pc->c[2] = page_code;
-	pc->c[3] = 255;		/* Don't limit the returned information */
+	/*
+	 * Changed pc->c[3] to 0 (255 will at best return unused info).
+	 *
+	 * For SCSI this byte is defined as subpage instead of high byte
+	 * of length and some IDE drives seem to interpret it this way
+	 * and return an error when 255 is used.
+	 */
+	pc->c[3] = 0;
 	pc->c[4] = 255;		/* (We will just discard data in that case) */
 	if (page_code == IDETAPE_BLOCK_DESCRIPTOR)
 		pc->request_transfer = 12;
@@ -2544,8 +2575,9 @@ static ide_startstop_t idetape_media_acc
 	if (status.b.dsc) {
 		if (status.b.check) {
 			/* Error detected */
-			printk(KERN_ERR "ide-tape: %s: I/O error, ",tape->name);
-
+			if (pc->c[0] != IDETAPE_TEST_UNIT_READY_CMD)
+				printk(KERN_ERR "ide-tape: %s: I/O error, ",
+						tape->name);
 			/* Retry operation */
 			return idetape_retry_pc(drive);
 		}
@@ -3295,25 +3327,28 @@ static int idetape_wait_ready(ide_drive_
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
+	int load_attempted = 0;
 
 	/*
 	 * Wait for the tape to become ready
 	 */
+	set_bit(IDETAPE_MEDIUM_PRESENT, &tape->flags);
 	timeout += jiffies;
 	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
 		if (!__idetape_queue_pc_tail(drive, &pc))
 			return 0;
-		if (tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2) {
+		if ((tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2)
+		    || (tape->asc == 0x3A)) {	/* no media */
+			if (load_attempted)
+				return -ENOMEDIUM;
 			idetape_create_load_unload_cmd(drive, &pc, IDETAPE_LU_LOAD_MASK);
 			__idetape_queue_pc_tail(drive, &pc);
-			idetape_create_test_unit_ready_cmd(&pc);
-			if (!__idetape_queue_pc_tail(drive, &pc))
-				return 0;
-		}
-		if (!(tape->sense_key == 2 && tape->asc == 4 &&
-		      (tape->ascq == 1 || tape->ascq == 8)))
-			break;
+			load_attempted = 1;
+		/* not about to be ready */
+		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
+			     (tape->ascq == 1 || tape->ascq == 8)))
+			return -EIO;
 		current->state = TASK_INTERRUPTIBLE;
   		schedule_timeout(HZ / 10);
 	}
@@ -3369,25 +3404,10 @@ static int idetape_read_position (ide_dr
 		printk(KERN_INFO "ide-tape: Reached idetape_read_position\n");
 #endif /* IDETAPE_DEBUG_LOG */
 
-#ifdef NO_LONGER_REQUIRED
-	idetape_flush_tape_buffers(drive);
-#endif
 	idetape_create_read_position_cmd(&pc);
 	if (idetape_queue_pc_tail(drive, &pc))
 		return -1;
 	position = tape->first_frame_position;
-#ifdef NO_LONGER_REQUIRED
-	if (tape->onstream) {
-		if ((position != tape->last_frame_position - tape->blocks_in_buffer) &&
-		    (position != tape->last_frame_position + tape->blocks_in_buffer)) {
-			if (tape->blocks_in_buffer == 0) {
-				printk("ide-tape: %s: correcting read position %d, %d, %d\n", tape->name, position, tape->last_frame_position, tape->blocks_in_buffer);
-				position = tape->last_frame_position;
-				tape->first_frame_position = position;
-			}
-		}
-	}
-#endif
 	return position;
 }
 
@@ -3436,6 +3456,8 @@ static int __idetape_discard_read_pipeli
 
 	if (tape->chrdev_direction != idetape_direction_read)
 		return 0;
+
+	/* Remove merge stage. */
 	cnt = tape->merge_stage_size / tape->tape_block_size;
 	if (test_and_clear_bit(IDETAPE_FILEMARK, &tape->flags))
 		++cnt;		/* Filemarks count as 1 sector */
@@ -3444,9 +3466,12 @@ static int __idetape_discard_read_pipeli
 		__idetape_kfree_stage(tape->merge_stage);
 		tape->merge_stage = NULL;
 	}
+
+	/* Clear pipeline flags. */
 	clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 	tape->chrdev_direction = idetape_direction_none;
-	
+
+	/* Remove pipeline stages. */
 	if (tape->first_stage == NULL)
 		return 0;
 
@@ -4059,13 +4084,17 @@ static int idetape_initiate_read (ide_dr
 		 *	Issue a read 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
 		 *	mode.
+		 *	No point in issuing this if DSC overlap isn't supported,
+		 *	some drives (Seagate STT3401A) will return an error.
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
@@ -4898,6 +4927,10 @@ static ssize_t idetape_chrdev_write (str
 		return -ENXIO;
 	}
 
+	/* The drive is write protected. */
+	if (tape->write_prot)
+		return -EACCES;
+
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
 		printk(KERN_INFO "ide-tape: Reached idetape_chrdev_write, "
@@ -4979,13 +5012,17 @@ static ssize_t idetape_chrdev_write (str
 		 *	Issue a write 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
 		 *	mode.
+		 *	No point in issuing this if DSC overlap isn't supported,
+		 *	some drives (Seagate STT3401A) will return an error.
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
@@ -5141,7 +5178,7 @@ ok:
  *	Note:
  *
  *		MTBSF and MTBSFM are not supported when the tape doesn't
- *		supports spacing over filemarks in the reverse direction.
+ *		support spacing over filemarks in the reverse direction.
  *		In this case, MTFSFM is also usually not supported (it is
  *		supported in the rare case in which we crossed the filemark
  *		during our read-ahead pipelined operation mode).
@@ -5211,6 +5248,8 @@ static int idetape_mtioctop (ide_drive_t
 	}
 	switch (mt_op) {
 		case MTWEOF:
+			if (tape->write_prot)
+				return -EACCES;
 			idetape_discard_read_pipeline(drive, 1);
 			for (i = 0; i < mt_count; i++) {
 				retval = idetape_write_filemark(drive);
@@ -5231,9 +5270,21 @@ static int idetape_mtioctop (ide_drive_t
 			return (idetape_queue_pc_tail(drive, &pc));
 		case MTUNLOAD:
 		case MTOFFL:
+			/*
+			 * If door is locked, attempt to unlock before
+			 * attempting to eject.
+			 */
+			if (tape->door_locked) {
+				if (idetape_create_prevent_cmd(drive, &pc, 0))
+					if (!idetape_queue_pc_tail(drive, &pc))
+						tape->door_locked = DOOR_UNLOCKED;
+			}
 			idetape_discard_read_pipeline(drive, 0);
 			idetape_create_load_unload_cmd(drive, &pc,!IDETAPE_LU_LOAD_MASK);
-			return (idetape_queue_pc_tail(drive, &pc));
+			retval = idetape_queue_pc_tail(drive, &pc);
+			if (!retval)
+				clear_bit(IDETAPE_MEDIUM_PRESENT, &tape->flags);
+			return retval;
 		case MTNOP:
 			idetape_discard_read_pipeline(drive, 0);
 			return (idetape_flush_tape_buffers(drive));
@@ -5409,6 +5460,8 @@ static int idetape_chrdev_ioctl (struct 
 					mtget.mt_gstat |= GMT_EOD(0xffffffff);
 				if (position <= OS_DATA_STARTFRAME1)
 					mtget.mt_gstat |= GMT_BOT(0xffffffff);
+			} else if (tape->drv_write_prot) {
+				mtget.mt_gstat |= GMT_WR_PROT(0xffffffff);
 			}
 			if (copy_to_user((char *) arg,(char *) &mtget, sizeof(struct mtget)))
 				return -EFAULT;
@@ -5530,6 +5583,8 @@ ok:
 	return 1;
 }
 
+static void idetape_get_blocksize_from_block_descriptor(ide_drive_t *drive);
+
 /*
  *	Our character device open function.
  */
@@ -5539,7 +5594,8 @@ static int idetape_chrdev_open (struct i
 	ide_drive_t *drive;
 	idetape_tape_t *tape;
 	idetape_pc_t pc;
-			
+	int retval;
+
 #if IDETAPE_DEBUG_LOG
 	printk(KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");
 #endif /* IDETAPE_DEBUG_LOG */
@@ -5552,11 +5608,7 @@ static int idetape_chrdev_open (struct i
 
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
@@ -5566,16 +5618,42 @@ static int idetape_chrdev_open (struct i
 		}
                 idetape_onstream_mode_sense_tape_parameter_page(drive, tape->debug_level);
 	}
-	if (idetape_wait_ready(drive, 60 * HZ)) {
+	retval = idetape_wait_ready(drive, 60 * HZ);
+	if (retval) {
 		clear_bit(IDETAPE_BUSY, &tape->flags);
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);
-		return -EBUSY;
+		return retval;
 	}
-	if (tape->onstream)
-		idetape_read_position(drive);
+
+	idetape_read_position(drive);
+	if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))
+		(void)idetape_rewind_tape(drive);
+
 	if (tape->chrdev_direction != idetape_direction_read)
 		clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 
+	/* Read block size and write protect status from drive. */
+	idetape_get_blocksize_from_block_descriptor(drive);
+
+	/* Set write protect flag if device is opened as read-only. */
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY)
+		tape->write_prot = 1;
+	else
+		tape->write_prot = tape->drv_write_prot;
+
+	/* Make sure drive isn't write protected if user wants to write. */
+	if (tape->write_prot) {
+		if ((filp->f_flags & O_ACCMODE) == O_WRONLY ||
+		    (filp->f_flags & O_ACCMODE) == O_RDWR) {
+			clear_bit(IDETAPE_BUSY, &tape->flags);
+			return -EROFS;
+		}
+	}
+
+	/*
+	 * Lock the tape drive door so user can't eject.
+	 * Analyze headers for OnStream drives.
+	 */
 	if (tape->chrdev_direction == idetape_direction_none) {
 		if (idetape_create_prevent_cmd(drive, &pc, 1)) {
 			if (!idetape_queue_pc_tail(drive, &pc)) {
@@ -5638,7 +5716,7 @@ static int idetape_chrdev_release (struc
 		__idetape_kfree_stage(tape->cache_stage);
 		tape->cache_stage = NULL;
 	}
-	if (minor < 128)
+	if (minor < 128 && test_bit(IDETAPE_MEDIUM_PRESENT, &tape->flags))
 		(void) idetape_rewind_tape(drive);
 	if (tape->chrdev_direction == idetape_direction_none) {
 		if (tape->door_locked == DOOR_LOCKED) {
@@ -6059,6 +6137,8 @@ static void idetape_get_blocksize_from_b
 	header = (idetape_mode_parameter_header_t *) pc.buffer;
 	block_descrp = (idetape_parameter_block_descriptor_t *) (pc.buffer + sizeof(idetape_mode_parameter_header_t));
 	tape->tape_block_size =( block_descrp->length[0]<<16) + (block_descrp->length[1]<<8) + block_descrp->length[2];
+	tape->drv_write_prot = (header->dsp & 0x80) >> 7;
+
 #if IDETAPE_DEBUG_INFO
 	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
 #endif /* IDETAPE_DEBUG_INFO */
@@ -6139,6 +6219,9 @@ static void idetape_setup (ide_drive_t *
 		}
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
+	/* Seagate Travan drives do not support DSC overlap. */
+	if (strstr(drive->id->model, "Seagate STT3401"))
+		drive->dsc_overlap = 0;
 	tape->drive = drive;
 	tape->minor = minor;
 	tape->name[0] = 'h';

_

