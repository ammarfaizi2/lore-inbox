Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbTKMPwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTKMPwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:52:46 -0500
Received: from ausadmmsrr504.aus.amer.dell.com ([143.166.83.91]:46091 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S264307AbTKMPv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:51:56 -0500
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F020E5D61@ausx2kmpc106.aus.amer.dell.com>
From: Stuart_Hayes@Dell.com
To: B.Zolnierkiewicz@elka.pw.edu.pl
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATCH:  gets ide-tape working on 2.6
Date: Thu, 13 Nov 2003 09:51:28 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 13AD770F163084-01-01
Content-Type: multipart/mixed; 
 boundary="----_=_NextPart_000_01C3A9FE.0038FB2C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3A9FE.0038FB2C
Content-Type: text/plain; 
 charset=iso-8859-2
Content-Transfer-Encoding: 7bit


Bart (et al),

Here's a patch for ide-tape.c that gets ide-tape working on the 2.6 kernel.

This should be applied after your recent patch that fixed the rq->flags
stuff in ide-tape.

There's nothing in here that will make it more difficult to change the
rq->flags stuff later if necessary--this will just tweak a few things to get
the driver functional.

Most of this stuff is just stuff to get the Seagate STT3401A Travan tape
drive working, as I already submitted for the 2.4 kernel.

Thanks!
Stuart

(I'll resend this in just a moment as plain text--I have to do that from a
different email account.)




------_=_NextPart_000_01C3A9FE.0038FB2C
Content-Type: application/octet-stream; 
 name=26_tape_works
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; 
 filename=26_tape_works

--- ide-tape.c.orig	2003-11-05 11:08:49.000000000 -0600=0A=
+++ ide-tape.c.26works	2003-11-13 09:32:53.188145144 -0600=0A=
@@ -1,5 +1,5 @@=0A=
 /*=0A=
- * linux/drivers/ide/ide-tape.c		Version 1.17b	Oct, 2002=0A=
+ * linux/drivers/ide/ide-tape.c		Version 1.18	Oct, 2003=0A=
  *=0A=
  * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>=0A=
  *=0A=
@@ -313,6 +313,28 @@=0A=
  *			Cosmetic fixes to miscellaneous debugging output messages.=0A=
  *			Set the minimum /proc/ide/hd?/settings values for "pipeline",=0A=
  *			 "pipeline_min", and "pipeline_max" to 1.=0A=
+ * Ver 1.18 Oct 2003	Stuart Hayes <stuart_hayes@dell.com>=0A=
+ *			Check drive's write protect bit, try to return appropriate=0A=
+ *			  errors when attempting to write a write-protected tape=0A=
+ *			Moved "idetape_read_position" call in idetape_chrdev_open=0A=
+ *			  after the "wait_ready" call=0A=
+ *			Added IDETAPE_MEDIUM_PRESENT flag so driver would know=0A=
+ *			  not to rewind tape after ejecting it =0A=
+ *			Fixed bug with ide_abort_pipeline (it was deleting stages=0A=
+ *			  from tape->next_stage to end, instead of from=0A=
+ *			  new_last_stage->next (tape->next_stage was set to NULL=0A=
+ *			  by idetape_discard_read_pipeline before calling!)=0A=
+ *			Made improvements to idetape_wait_ready=0A=
+ *			Added a few comments here and there=0A=
+ *			Made MTOFFL unlock tape drive door before attempting to eject=0A=
+ *			Added fixes to get Seagate STT3401A Travan working:=0A=
+ *			  handle drives that don't support 0-length reads/writes=0A=
+ *			  increased timeout (retension takes ~10 minutes before=0A=
+ *			    irq is returned)=0A=
+ *			  fixed request mode page packet command byte 3=0A=
+ *			Changed spinlock_irqsave to spinlock when calling=0A=
+ *			  "idetape_wait_for_request" so IRQs wouldn't be=0A=
+ *			  masked when we call "wait_for_completion"=0A=
  *=0A=
  * Here are some words from the first releases of hd.c, which are =
quoted=0A=
  * in ide.c and apply here as well:=0A=
@@ -422,7 +444,7 @@=0A=
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.=0A=
  */=0A=
 =0A=
-#define IDETAPE_VERSION "1.17b-ac1"=0A=
+#define IDETAPE_VERSION "1.18"=0A=
 =0A=
 #include <linux/config.h>=0A=
 #include <linux/module.h>=0A=
@@ -451,7 +473,6 @@=0A=
 #include <asm/bitops.h>=0A=
 =0A=
 =0A=
-#define NO_LONGER_REQUIRED	(1)=0A=
 =0A=
 /*=0A=
  *	OnStream support=0A=
@@ -653,8 +674,13 @@=0A=
 =0A=
 /*=0A=
  *	Some tape drives require a long irq timeout=0A=
+ *=0A=
+ *	Some drives (for example, the Seagate STT3401A Travan)=0A=
+ *	require a very long timeout, because they don't=0A=
+ *	return an interrupt or clear their busy bit until after the=0A=
+ *	command completes--even retension commands.=0A=
  */=0A=
-#define IDETAPE_WAIT_CMD		(60*HZ)=0A=
+#define IDETAPE_WAIT_CMD		(900*HZ)=0A=
 =0A=
 /*=0A=
  *	The following parameter is used to select the point in the =
internal=0A=
@@ -1032,6 +1058,10 @@=0A=
 =0A=
 	/* the door is currently locked */=0A=
 	int door_locked;=0A=
+	/* the tape hardware is write protected */=0A=
+	char drv_write_prot;=0A=
+	/* the tape is write protected (hardware or opened as read-only) =
*/=0A=
+	char write_prot;=0A=
 =0A=
 	/*=0A=
 	 * OnStream flags=0A=
@@ -1164,6 +1194,7 @@=0A=
 #define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */=0A=
 #define IDETAPE_READ_ERROR		7=0A=
 #define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */=0A=
+#define IDETAPE_MEDIUM_PRESENT		9	/* 0=3Dno tape is loaded, so we =
don't rewind after ejecting */=0A=
 =0A=
 /*=0A=
  *	Supported ATAPI tape drives packet commands=0A=
@@ -1665,6 +1696,20 @@=0A=
 		idetape_update_buffers(pc);=0A=
 	}=0A=
 =0A=
+	/*	If error was the result of a zero-length read or write=0A=
+	 *	command, with sense key=3D5, asc=3D0x22, ascq=3D0, let it=0A=
+	 *	slide... some drives (Seagate STT3401A Travan) don't=0A=
+	 *	support 0-length read/writes=0A=
+	 */=0A=
+=0A=
+	if ((pc->c[0] =3D=3D IDETAPE_READ_CMD || pc->c[0] =3D=3D =
IDETAPE_WRITE_CMD)=0A=
+	    && pc->c[4] =3D=3D 0 && pc->c[3] =3D=3D 0 && pc->c[2] =3D=3D 0) { =
/* length=3D=3D0 */=0A=
+		if (result->sense_key =3D=3D 5) {=0A=
+			pc->error =3D 0; /* don't report an error, everything's ok */=0A=
+			set_bit(PC_ABORT, &pc->flags); /* don't retry read/write */=0A=
+		}=0A=
+	}=0A=
+=0A=
 	if (pc->c[0] =3D=3D IDETAPE_READ_CMD && result->filemark) {=0A=
 		pc->error =3D IDETAPE_ERROR_FILEMARK;=0A=
 		set_bit(PC_ABORT, &pc->flags);=0A=
@@ -1805,10 +1850,18 @@=0A=
 	}=0A=
 }=0A=
 =0A=
-static void idetape_abort_pipeline (ide_drive_t *drive, =
idetape_stage_t *last_stage)=0A=
+/*=0A=
+ * idetape_abort_pipeline=0A=
+ * ----------------------=0A=
+ *   This will free all the pipeline stages starting from=0A=
+ *     new_last_stage->next to the end of the list, and point=0A=
+ *     tape->last_stage to new_last_stage.=0A=
+ */=0A=
+=0A=
+static void idetape_abort_pipeline (ide_drive_t *drive, =
idetape_stage_t *new_last_stage)=0A=
 {=0A=
 	idetape_tape_t *tape =3D drive->driver_data;=0A=
-	idetape_stage_t *stage =3D tape->next_stage;=0A=
+	idetape_stage_t *stage =3D new_last_stage->next;=0A=
 	idetape_stage_t *nstage;=0A=
 =0A=
 #if IDETAPE_DEBUG_LOG=0A=
@@ -1822,9 +1875,9 @@=0A=
 		--tape->nr_pending_stages;=0A=
 		stage =3D nstage;=0A=
 	}=0A=
-	tape->last_stage =3D last_stage;=0A=
-	if (last_stage)=0A=
-		last_stage->next =3D NULL;=0A=
+	if (new_last_stage)=0A=
+		new_last_stage->next =3D NULL;=0A=
+	tape->last_stage =3D new_last_stage;=0A=
 	tape->next_stage =3D NULL;=0A=
 }=0A=
 =0A=
@@ -1995,6 +2048,7 @@=0A=
 {=0A=
 	ide_init_drive_cmd(rq);=0A=
 	rq->buffer =3D (char *) pc;=0A=
+	rq->flags &=3D ~(REQ_DRIVE_CMD);=0A=
 	rq->flags |=3D REQ_IDETAPE_PC1;=0A=
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);=0A=
 }=0A=
@@ -2430,7 +2484,11 @@=0A=
 	if (page_code !=3D IDETAPE_BLOCK_DESCRIPTOR)=0A=
 		pc->c[1] =3D 8;	/* DBD =3D 1 - Don't return block descriptors */=0A=
 	pc->c[2] =3D page_code;=0A=
-	pc->c[3] =3D 255;		/* Don't limit the returned information */=0A=
+	/* Changed pc->c[3] (subpages) to 0... 255 will at best return  *=0A=
+	 *   unused info... for SCSI, this byte is defined as subpage   *=0A=
+	 *   instead of high byte of length, and some IDE drives        *=0A=
+	 *   seem to interpret it this way and return an error.         */=0A=
+	pc->c[3] =3D 0;		/* Don't limit the returned information */=0A=
 	pc->c[4] =3D 255;		/* (We will just discard data in that case) */=0A=
 	if (page_code =3D=3D IDETAPE_BLOCK_DESCRIPTOR)=0A=
 		pc->request_transfer =3D 12;=0A=
@@ -2544,7 +2602,8 @@=0A=
 	if (status.b.dsc) {=0A=
 		if (status.b.check) {=0A=
 			/* Error detected */=0A=
-			printk(KERN_ERR "ide-tape: %s: I/O error, ",tape->name);=0A=
+			if (pc->c[0] !=3D IDETAPE_TEST_UNIT_READY_CMD)=0A=
+				printk(KERN_ERR "ide-tape: %s: I/O error, ",tape->name);=0A=
 =0A=
 			/* Retry operation */=0A=
 			return idetape_retry_pc(drive);=0A=
@@ -3174,7 +3233,7 @@=0A=
 	wait_for_completion(&wait);=0A=
 	/* The stage and its struct request have been deallocated */=0A=
 	tape->waiting =3D NULL;=0A=
-	spin_lock_irq(&tape->spinlock);=0A=
+	spin_lock(&tape->spinlock);=0A=
 }=0A=
 =0A=
 static ide_startstop_t idetape_read_position_callback (ide_drive_t =
*drive)=0A=
@@ -3271,6 +3330,7 @@=0A=
 =0A=
 	ide_init_drive_cmd(&rq);=0A=
 	rq.buffer =3D (char *) pc;=0A=
+	rq.flags &=3D ~(REQ_DRIVE_CMD);=0A=
 	rq.flags |=3D REQ_IDETAPE_PC1;=0A=
 	return ide_do_drive_cmd(drive, &rq, ide_wait);=0A=
 }=0A=
@@ -3295,25 +3355,26 @@=0A=
 {=0A=
 	idetape_tape_t *tape =3D drive->driver_data;=0A=
 	idetape_pc_t pc;=0A=
-=0A=
+	int load_attempted =3D 0;=0A=
 	/*=0A=
 	 * Wait for the tape to become ready=0A=
 	 */=0A=
+	set_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags);=0A=
 	timeout +=3D jiffies;=0A=
 	while (time_before(jiffies, timeout)) {=0A=
 		idetape_create_test_unit_ready_cmd(&pc);=0A=
 		if (!__idetape_queue_pc_tail(drive, &pc))=0A=
 			return 0;=0A=
-		if (tape->sense_key =3D=3D 2 && tape->asc =3D=3D 4 && tape->ascq =
=3D=3D 2) {=0A=
-			idetape_create_load_unload_cmd(drive, &pc, =
IDETAPE_LU_LOAD_MASK);=0A=
-			__idetape_queue_pc_tail(drive, &pc);=0A=
-			idetape_create_test_unit_ready_cmd(&pc);=0A=
-			if (!__idetape_queue_pc_tail(drive, &pc))=0A=
-				return 0;=0A=
-		}=0A=
-		if (!(tape->sense_key =3D=3D 2 && tape->asc =3D=3D 4 &&=0A=
-		      (tape->ascq =3D=3D 1 || tape->ascq =3D=3D 8)))=0A=
-			break;=0A=
+		if ((tape->sense_key =3D=3D 2 && tape->asc =3D=3D 4 && tape->ascq =
=3D=3D 2)=0A=
+		    || (tape->asc =3D=3D 0x3A)) {  /* no media... */=0A=
+			if (!load_attempted) {=0A=
+				idetape_create_load_unload_cmd(drive, &pc, =
IDETAPE_LU_LOAD_MASK);=0A=
+				__idetape_queue_pc_tail(drive, &pc);=0A=
+				load_attempted =3D 1;=0A=
+			} else return -ENOMEDIUM;=0A=
+		} else if (!(tape->sense_key =3D=3D 2 && tape->asc =3D=3D 4 &&=0A=
+		           (tape->ascq =3D=3D 1 || tape->ascq =3D=3D 8))) /* not =
about to be ready... */=0A=
+			return -EIO;=0A=
 		current->state =3D TASK_INTERRUPTIBLE;=0A=
   		schedule_timeout(HZ / 10);=0A=
 	}=0A=
@@ -3436,6 +3497,8 @@=0A=
 =0A=
 	if (tape->chrdev_direction !=3D idetape_direction_read)=0A=
 		return 0;=0A=
+=0A=
+	/* Remove merge stage */=0A=
 	cnt =3D tape->merge_stage_size / tape->tape_block_size;=0A=
 	if (test_and_clear_bit(IDETAPE_FILEMARK, &tape->flags))=0A=
 		++cnt;		/* Filemarks count as 1 sector */=0A=
@@ -3444,17 +3507,20 @@=0A=
 		__idetape_kfree_stage(tape->merge_stage);=0A=
 		tape->merge_stage =3D NULL;=0A=
 	}=0A=
+=0A=
+	/* Clear pipeline flags */=0A=
 	clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);=0A=
 	tape->chrdev_direction =3D idetape_direction_none;=0A=
-	=0A=
+=0A=
+	/* Remove pipeline stages */=0A=
 	if (tape->first_stage =3D=3D NULL)=0A=
 		return 0;=0A=
 =0A=
-	spin_lock_irqsave(&tape->spinlock, flags);=0A=
+	spin_lock(&tape->spinlock);=0A=
 	tape->next_stage =3D NULL;=0A=
 	if (idetape_pipeline_active(tape))=0A=
 		idetape_wait_for_request(drive, tape->active_data_request);=0A=
-	spin_unlock_irqrestore(&tape->spinlock, flags);=0A=
+	spin_unlock(&tape->spinlock);=0A=
 =0A=
 	while (tape->first_stage !=3D NULL) {=0A=
 		struct request *rq_ptr =3D &tape->first_stage->rq;=0A=
@@ -3547,6 +3613,7 @@=0A=
 #endif /* IDETAPE_DEBUG_BUGS */	=0A=
 =0A=
 	ide_init_drive_cmd(&rq);=0A=
+	rq.flags &=3D ~(REQ_DRIVE_CMD);=0A=
 	rq.special =3D (void *)bh;=0A=
 	rq.flags |=3D cmd;=0A=
 	rq.sector =3D tape->first_frame_position;=0A=
@@ -3597,6 +3664,7 @@=0A=
 #endif=0A=
 		rq =3D &stage->rq;=0A=
 		ide_init_drive_cmd(rq);=0A=
+		rq->flags &=3D ~(REQ_DRIVE_CMD);=0A=
 		rq->flags |=3D REQ_IDETAPE_WRITE;=0A=
 		rq->sector =3D tape->first_frame_position;=0A=
 		rq->nr_sectors =3D rq->current_nr_sectors =3D =
tape->capabilities.ctl;=0A=
@@ -3820,10 +3888,10 @@=0A=
 =0A=
 	if (tape->first_stage =3D=3D NULL)=0A=
 		return;=0A=
-	spin_lock_irqsave(&tape->spinlock, flags);=0A=
+	spin_lock(&tape->spinlock);=0A=
 	if (tape->active_stage =3D=3D tape->first_stage)=0A=
 		idetape_wait_for_request(drive, tape->active_data_request);=0A=
-	spin_unlock_irqrestore(&tape->spinlock, flags);=0A=
+	spin_unlock(&tape->spinlock);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -3854,12 +3922,12 @@=0A=
 	 *	Pay special attention to possible race conditions.=0A=
 	 */=0A=
 	while ((new_stage =3D idetape_kmalloc_stage(tape)) =3D=3D NULL) {=0A=
-		spin_lock_irqsave(&tape->spinlock, flags);=0A=
+		spin_lock(&tape->spinlock);=0A=
 		if (idetape_pipeline_active(tape)) {=0A=
 			idetape_wait_for_request(drive, tape->active_data_request);=0A=
-			spin_unlock_irqrestore(&tape->spinlock, flags);=0A=
+			spin_unlock(&tape->spinlock);=0A=
 		} else {=0A=
-			spin_unlock_irqrestore(&tape->spinlock, flags);=0A=
+			spin_unlock(&tape->spinlock);=0A=
 			idetape_insert_pipeline_into_queue(drive);=0A=
 			if (idetape_pipeline_active(tape))=0A=
 				continue;=0A=
@@ -3872,6 +3940,7 @@=0A=
 	}=0A=
 	rq =3D &new_stage->rq;=0A=
 	ide_init_drive_cmd(rq);=0A=
+	rq->flags &=3D ~(REQ_DRIVE_CMD);=0A=
 	rq->flags |=3D REQ_IDETAPE_WRITE;=0A=
 	/* Doesn't actually matter - We always assume sequential access */=0A=
 	rq->sector =3D tape->first_frame_position;=0A=
@@ -3934,10 +4003,10 @@=0A=
 =0A=
 	while (tape->next_stage || idetape_pipeline_active(tape)) {=0A=
 		idetape_insert_pipeline_into_queue(drive);=0A=
-		spin_lock_irqsave(&tape->spinlock, flags);=0A=
+		spin_lock(&tape->spinlock);=0A=
 		if (idetape_pipeline_active(tape))=0A=
 			idetape_wait_for_request(drive, tape->active_data_request);=0A=
-		spin_unlock_irqrestore(&tape->spinlock, flags);=0A=
+		spin_unlock(&tape->spinlock);=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -4059,18 +4128,23 @@=0A=
 		 *	Issue a read 0 command to ensure that DSC handshake=0A=
 		 *	is switched from completion mode to buffer available=0A=
 		 *	mode.=0A=
+		 *	No point in issuing this if dsc_overlap isn't supported=0A=
+		 *	(some drives (Seagate STT3401A) will return an error).=0A=
 		 */=0A=
-		bytes_read =3D idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 0, =
tape->merge_stage->bh);=0A=
-		if (bytes_read < 0) {=0A=
-			__idetape_kfree_stage(tape->merge_stage);=0A=
-			tape->merge_stage =3D NULL;=0A=
-			tape->chrdev_direction =3D idetape_direction_none;=0A=
-			return bytes_read;=0A=
+		if (drive->dsc_overlap) {=0A=
+			bytes_read =3D idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 0, =
tape->merge_stage->bh);=0A=
+			if (bytes_read < 0) {=0A=
+				__idetape_kfree_stage(tape->merge_stage);=0A=
+				tape->merge_stage =3D NULL;=0A=
+				tape->chrdev_direction =3D idetape_direction_none;=0A=
+				return bytes_read;=0A=
+			}=0A=
 		}=0A=
 	}=0A=
 	if (tape->restart_speed_control_req)=0A=
 		idetape_restart_speed_control(drive);=0A=
 	ide_init_drive_cmd(&rq);=0A=
+	rq.flags &=3D ~(REQ_DRIVE_CMD);=0A=
 	rq.flags |=3D REQ_IDETAPE_READ;=0A=
 	rq.sector =3D tape->first_frame_position;=0A=
 	rq.nr_sectors =3D rq.current_nr_sectors =3D blocks;=0A=
@@ -4658,7 +4732,9 @@=0A=
 static ssize_t idetape_chrdev_read (struct file *file, char *buf,=0A=
 				    size_t count, loff_t *ppos)=0A=
 {=0A=
-	ide_drive_t *drive =3D file->private_data;=0A=
+	struct inode *inode =3D file->f_dentry->d_inode;=0A=
+	unsigned int minor =3D iminor(inode);=0A=
+	ide_drive_t *drive =3D idetape_chrdevs[minor & ~0xC0].drive;=0A=
 	idetape_tape_t *tape =3D drive->driver_data;=0A=
 	ssize_t bytes_read,temp, actually_read =3D 0, rc;=0A=
 =0A=
@@ -4887,9 +4963,9 @@=0A=
 				     size_t count, loff_t *ppos)=0A=
 {=0A=
 	struct inode *inode =3D file->f_dentry->d_inode;=0A=
-	ide_drive_t *drive =3D file->private_data;=0A=
-	idetape_tape_t *tape =3D drive->driver_data;=0A=
 	unsigned int minor =3D iminor(inode);=0A=
+	ide_drive_t *drive =3D idetape_chrdevs[minor&~0xC0].drive;=0A=
+	idetape_tape_t *tape =3D drive->driver_data;=0A=
 	ssize_t retval, actually_written =3D 0;=0A=
 	int position;=0A=
 =0A=
@@ -4898,6 +4974,11 @@=0A=
 		return -ENXIO;=0A=
 	}=0A=
 =0A=
+	if (tape->write_prot) {=0A=
+		/* The drive is write protected */=0A=
+		return -EACCES;=0A=
+	}=0A=
+=0A=
 #if IDETAPE_DEBUG_LOG=0A=
 	if (tape->debug_level >=3D 3)=0A=
 		printk(KERN_INFO "ide-tape: Reached idetape_chrdev_write, "=0A=
@@ -4979,13 +5060,17 @@=0A=
 		 *	Issue a write 0 command to ensure that DSC handshake=0A=
 		 *	is switched from completion mode to buffer available=0A=
 		 *	mode.=0A=
+		 *	No point in issuing this if dsc_overlap isn't supported=0A=
+		 *	(some drives (Seagate STT3401A) will return an error).=0A=
 		 */=0A=
-		retval =3D idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, =
tape->merge_stage->bh);=0A=
-		if (retval < 0) {=0A=
-			__idetape_kfree_stage(tape->merge_stage);=0A=
-			tape->merge_stage =3D NULL;=0A=
-			tape->chrdev_direction =3D idetape_direction_none;=0A=
-			return retval;=0A=
+		if (drive->dsc_overlap) {=0A=
+			retval =3D idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, =
tape->merge_stage->bh);=0A=
+			if (retval < 0) {=0A=
+				__idetape_kfree_stage(tape->merge_stage);=0A=
+				tape->merge_stage =3D NULL;=0A=
+				tape->chrdev_direction =3D idetape_direction_none;=0A=
+				return retval;=0A=
+			}=0A=
 		}=0A=
 #if ONSTREAM_DEBUG=0A=
 		if (tape->debug_level >=3D 2)=0A=
@@ -5141,7 +5226,7 @@=0A=
  *	Note:=0A=
  *=0A=
  *		MTBSF and MTBSFM are not supported when the tape doesn't=0A=
- *		supports spacing over filemarks in the reverse direction.=0A=
+ *		support spacing over filemarks in the reverse direction.=0A=
  *		In this case, MTFSFM is also usually not supported (it is=0A=
  *		supported in the rare case in which we crossed the filemark=0A=
  *		during our read-ahead pipelined operation mode).=0A=
@@ -5211,6 +5296,8 @@=0A=
 	}=0A=
 	switch (mt_op) {=0A=
 		case MTWEOF:=0A=
+			if (tape->write_prot)=0A=
+				return -EACCES;=0A=
 			idetape_discard_read_pipeline(drive, 1);=0A=
 			for (i =3D 0; i < mt_count; i++) {=0A=
 				retval =3D idetape_write_filemark(drive);=0A=
@@ -5232,8 +5319,16 @@=0A=
 		case MTUNLOAD:=0A=
 		case MTOFFL:=0A=
 			idetape_discard_read_pipeline(drive, 0);=0A=
+			/* if door is locked, attempt to unlock  */=0A=
+			/* before attempting to eject            */=0A=
+			if (tape->door_locked)=0A=
+				if (idetape_create_prevent_cmd(drive, &pc, 0))=0A=
+					if (!idetape_queue_pc_tail(drive, &pc))=0A=
+						tape->door_locked =3D DOOR_UNLOCKED;=0A=
 			idetape_create_load_unload_cmd(drive, =
&pc,!IDETAPE_LU_LOAD_MASK);=0A=
-			return (idetape_queue_pc_tail(drive, &pc));=0A=
+			if (!(retval=3D idetape_queue_pc_tail(drive, &pc)))=0A=
+				clear_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags);=0A=
+			return retval;=0A=
 		case MTNOP:=0A=
 			idetape_discard_read_pipeline(drive, 0);=0A=
 			return (idetape_flush_tape_buffers(drive));=0A=
@@ -5363,7 +5458,7 @@=0A=
  */=0A=
 static int idetape_chrdev_ioctl (struct inode *inode, struct file =
*file, unsigned int cmd, unsigned long arg)=0A=
 {=0A=
-	ide_drive_t *drive =3D file->private_data;=0A=
+	ide_drive_t *drive =3D idetape_chrdevs[iminor(inode)&~0xC0].drive;=0A=
 	idetape_tape_t *tape =3D drive->driver_data;=0A=
 	struct mtop mtop;=0A=
 	struct mtget mtget;=0A=
@@ -5403,12 +5498,15 @@=0A=
 					mtget.mt_blkno =3D tape->logical_blk_num;=0A=
 			}=0A=
 			mtget.mt_dsreg =3D ((tape->tape_block_size * tape->user_bs_factor) =
<< MT_ST_BLKSIZE_SHIFT) & MT_ST_BLKSIZE_MASK;=0A=
+			mtget.mt_gstat =3D 0;=0A=
 			if (tape->onstream) {=0A=
 				mtget.mt_gstat |=3D GMT_ONLINE(0xffffffff);=0A=
 				if (tape->first_stage && tape->first_stage->aux->frame_type =3D=3D =
OS_FRAME_TYPE_EOD)=0A=
 					mtget.mt_gstat |=3D GMT_EOD(0xffffffff);=0A=
 				if (position <=3D OS_DATA_STARTFRAME1)=0A=
 					mtget.mt_gstat |=3D GMT_BOT(0xffffffff);=0A=
+			} else {=0A=
+				if (tape->drv_write_prot) mtget.mt_gstat |=3D =
GMT_WR_PROT(0xffffffff);=0A=
 			}=0A=
 			if (copy_to_user((char *) arg,(char *) &mtget, sizeof(struct =
mtget)))=0A=
 				return -EFAULT;=0A=
@@ -5530,6 +5628,8 @@=0A=
 	return 1;=0A=
 }=0A=
 =0A=
+static void idetape_get_blocksize_from_block_descriptor(ide_drive_t =
*drive);=0A=
+=0A=
 /*=0A=
  *	Our character device open function.=0A=
  */=0A=
@@ -5539,7 +5639,8 @@=0A=
 	ide_drive_t *drive;=0A=
 	idetape_tape_t *tape;=0A=
 	idetape_pc_t pc;=0A=
-			=0A=
+	int retval;=0A=
+=0A=
 #if IDETAPE_DEBUG_LOG=0A=
 	printk(KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");=0A=
 #endif /* IDETAPE_DEBUG_LOG */=0A=
@@ -5551,11 +5652,7 @@=0A=
 =0A=
 	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags))=0A=
 		return -EBUSY;=0A=
-	if (!tape->onstream) {	=0A=
-		idetape_read_position(drive);=0A=
-		if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))=0A=
-			(void) idetape_rewind_tape(drive);=0A=
-	} else {=0A=
+	if (tape->onstream) {=0A=
 		if (minor & 64) {=0A=
 			tape->tape_block_size =3D tape->stage_size =3D 32768 + 512;=0A=
 			tape->raw =3D 1;=0A=
@@ -5565,16 +5662,40 @@=0A=
 		}=0A=
                 idetape_onstream_mode_sense_tape_parameter_page(drive, =
tape->debug_level);=0A=
 	}=0A=
-	if (idetape_wait_ready(drive, 60 * HZ)) {=0A=
+=0A=
+	/* See if the drive is ready to go */=0A=
+	if ((retval =3D idetape_wait_ready(drive, 60 * HZ))) {=0A=
 		clear_bit(IDETAPE_BUSY, &tape->flags);=0A=
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);=0A=
-		return -EBUSY;=0A=
+		return retval;=0A=
 	}=0A=
-	if (tape->onstream)=0A=
-		idetape_read_position(drive);=0A=
+=0A=
+	/* Read the tape position */=0A=
+	idetape_read_position(drive);=0A=
+	if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))=0A=
+		(void) idetape_rewind_tape(drive);=0A=
+=0A=
 	if (tape->chrdev_direction !=3D idetape_direction_read)=0A=
 		clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);=0A=
 =0A=
+	/* Read block size and write protect status from drive */=0A=
+	idetape_get_blocksize_from_block_descriptor(drive);=0A=
+=0A=
+	/* Set write protect flag if device is opened as read-only */=0A=
+	if ( (filp->f_flags & O_ACCMODE)=3D=3DO_RDONLY)=0A=
+		tape->write_prot =3D 1;=0A=
+	else tape->write_prot =3D tape->drv_write_prot;=0A=
+=0A=
+	/* Make sure drive isn't write protected if user wants to write */=0A=
+	if (tape->write_prot)=0A=
+		if ( (filp->f_flags & O_ACCMODE)=3D=3DO_WRONLY ||=0A=
+		     (filp->f_flags & O_ACCMODE)=3D=3DO_RDWR) {=0A=
+			clear_bit (IDETAPE_BUSY, &tape->flags);=0A=
+			return -EROFS;=0A=
+	}=0A=
+=0A=
+	/* Lock the tape drive door so user can't eject */=0A=
+	/* (and analyze headers for OnStream drives)    */=0A=
 	if (tape->chrdev_direction =3D=3D idetape_direction_none) {=0A=
 		if (idetape_create_prevent_cmd(drive, &pc, 1)) {=0A=
 			if (!idetape_queue_pc_tail(drive, &pc)) {=0A=
@@ -5613,7 +5734,7 @@=0A=
  */=0A=
 static int idetape_chrdev_release (struct inode *inode, struct file =
*filp)=0A=
 {=0A=
-	ide_drive_t *drive =3D filp->private_data;=0A=
+	ide_drive_t *drive =3D idetape_chrdevs[iminor(inode)&~0xC0].drive;=0A=
 	idetape_tape_t *tape;=0A=
 	idetape_pc_t pc;=0A=
 	unsigned int minor =3D iminor(inode);=0A=
@@ -5637,7 +5758,7 @@=0A=
 		__idetape_kfree_stage(tape->cache_stage);=0A=
 		tape->cache_stage =3D NULL;=0A=
 	}=0A=
-	if (minor < 128)=0A=
+	if ((minor < 128) && =
(test_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags)))=0A=
 		(void) idetape_rewind_tape(drive);=0A=
 	if (tape->chrdev_direction =3D=3D idetape_direction_none) {=0A=
 		if (tape->door_locked =3D=3D DOOR_LOCKED) {=0A=
@@ -6058,6 +6179,8 @@=0A=
 	header =3D (idetape_mode_parameter_header_t *) pc.buffer;=0A=
 	block_descrp =3D (idetape_parameter_block_descriptor_t *) (pc.buffer =
+ sizeof(idetape_mode_parameter_header_t));=0A=
 	tape->tape_block_size =3D( block_descrp->length[0]<<16) + =
(block_descrp->length[1]<<8) + block_descrp->length[2];=0A=
+	tape->drv_write_prot =3D tape->write_prot =3D (header->dsp & 0x80) >> =
7;=0A=
+=0A=
 #if IDETAPE_DEBUG_INFO=0A=
 	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", =
tape->tape_block_size);=0A=
 #endif /* IDETAPE_DEBUG_INFO */=0A=
@@ -6137,6 +6260,9 @@=0A=
 		    	drive->dsc_overlap =3D 0;=0A=
 		}=0A=
 	}=0A=
+	/* Seagate Travan drives do not support DSC overlap */=0A=
+	if (strstr(drive->id->model,"Seagate STT3401"))=0A=
+		drive->dsc_overlap =3D 0;=0A=
 #endif /* CONFIG_BLK_DEV_IDEPCI */=0A=
 	tape->drive =3D drive;=0A=
 	tape->minor =3D minor;=0A=

------_=_NextPart_000_01C3A9FE.0038FB2C--

