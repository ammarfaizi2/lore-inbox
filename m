Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbTDQXMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbTDQXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:12:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262685AbTDQXMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:12:34 -0400
Date: Fri, 18 Apr 2003 01:24:15 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304180123510.22161-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tf-ioctls-4.diff:

# Remove dead ide_diag_taskfile() code.
# Incremental to tf-ioctls-3 patch.
#
# - rq->flags is already set to REQ_DRIVE_TASKFILE by ide_init_drive_taskfile()
# - remove dead variant of ide_diag_taskfile(), it was broken
#   and had ide_do_drive_cmd() unfolded which IMHO wasn't good idea
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac1-tf3/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac1-tf3/drivers/ide/ide-taskfile.c	Thu Apr 17 23:24:51 2003
+++ linux/drivers/ide/ide-taskfile.c	Thu Apr 17 23:49:03 2003
@@ -990,14 +990,11 @@

 EXPORT_SYMBOL(ide_init_drive_taskfile);

-#if 1
-
 int ide_diag_taskfile (ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
 {
 	struct request rq;

 	ide_init_drive_taskfile(&rq);
-	rq.flags = REQ_DRIVE_TASKFILE;
 	rq.buffer = buf;

 	/*
@@ -1009,6 +1006,12 @@
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size == 0)
 			rq.current_nr_sectors = rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
+#if 0
+			ata_nsector_t nsector;
+			nsector.b.low = args->hobRegister[IDE_NSECTOR_OFFSET_HOB];
+			nsector.b.high = args->tfRegister[IDE_NSECTOR_OFFSET];
+			rq.nr_sectors = nsector.all;
+#endif
 		else
 			rq.current_nr_sectors = rq.nr_sectors = data_size / SECTOR_SIZE;

@@ -1030,69 +1033,6 @@
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }

-#else
-
-int ide_diag_taskfile (ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
-{
-	struct request *rq;
-	unsigned long flags;
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	struct list_head *queue_head = &drive->queue.queue_head;
-	DECLARE_COMPLETION(wait);
-
-	if (HWIF(drive)->chipset == ide_pdc4030 && buf != NULL)
-		return -ENOSYS; /* special drive cmds not supported */
-
-	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_TASKFILE;
-	rq->buffer = buf;
-
-	/*
-	 * (ks) We transfer currently only whole sectors.
-	 * This is suffient for now.  But, it would be great,
-	 * if we would find a solution to transfer any size.
-	 * To support special commands like READ LONG.
-	 */
-	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
-		if (data_size == 0) {
-			ata_nsector_t nsector;
-			nsector.b.low = args->hobRegister[IDE_NSECTOR_OFFSET_HOB];
-			nsector.b.high = args->tfRegister[IDE_NSECTOR_OFFSET];
-			rq.nr_sectors = nsector.all;
-		} else {
-			rq.nr_sectors = data_size / SECTOR_SIZE;
-		}
-		rq.current_nr_sectors = rq.nr_sectors;
-	//	rq.hard_cur_sectors = rq.nr_sectors;
-	}
-
-	if (args->tf_out_flags.all == 0) {
-		/*
-		 * clean up kernel settings for driver sanity, regardless.
-		 * except for discrete diag services.
-		 */
-		args->posthandler = ide_post_handler_parser(
-				(struct hd_drive_task_hdr *) args->tfRegister,
-				(struct hd_drive_hob_hdr *) args->hobRegister);
-	}
-	rq->special = args;
-	rq->errors = 0;
-	rq->rq_status = RQ_ACTIVE;
-	rq->rq_disk = drive->disk;
-	rq->waiting = &wait;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	queue_head = queue_head->prev;
-	list_add(&rq->queue, queue_head);
-	ide_do_request(hwgroup, 0);
-	spin_unlock_irqrestore(&ide_lock, flags);
-
-	wait_for_completion(&wait);	/* wait for it to be serviced */
-	return rq->errors ? -EIO : 0;	/* return -EIO if errors */
-}
-
-#endif
-
 EXPORT_SYMBOL(ide_diag_taskfile);

 int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)

