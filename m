Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTDQXIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTDQXIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:08:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262673AbTDQXIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:08:12 -0400
Date: Fri, 18 Apr 2003 01:19:55 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304180119200.22161-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tf-ioctls-1.diff:

# Fix PIO handlers for Taskfile ioctls.
#
# Detailed changelog:
# - fix process_that_request_first() for rq->buffer (non-bio) based requests
# - set rq->hard_nr_sectors and rq->hard_cur_sectors in ide_diag_taskfile()
# - use ide_rq_offset() in ide_map_buffer() and remove task_rq_offset()
# - fix PIO handlers for rq->buffer based requests
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac1/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.67-ac1/drivers/block/ll_rw_blk.c	Thu Apr 17 17:46:53 2003
+++ linux/drivers/block/ll_rw_blk.c	Thu Apr 17 17:47:33 2003
@@ -2265,9 +2265,11 @@
 		nsect = min_t(unsigned int, req->current_nr_sectors,
 			      nr_sectors);
 		req->current_nr_sectors -= nsect;
-		req->nr_bio_sectors -= nsect;
 		nr_sectors -= nsect;
-		blk_rq_next_segment(req);
+		if (req->bio) {
+			req->nr_bio_sectors -= nsect;
+			blk_rq_next_segment(req);
+		}
 	}
 	return 1;
 }
diff -uNr linux-2.5.67-ac1/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac1/drivers/ide/ide-taskfile.c	Thu Apr 17 20:03:36 2003
+++ linux/drivers/ide/ide-taskfile.c	Thu Apr 17 20:10:59 2003
@@ -406,6 +406,11 @@
 	while (rq->hard_bio != rq->bio)
 		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
 			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}

 	rq->errors = 0;
 	task_sectors(drive, rq, 1, PIO_IN);
@@ -452,6 +457,11 @@
 	while (rq->hard_bio != rq->bio)
 		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
 			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}

 	rq->errors = 0;
 	do {
@@ -510,6 +520,11 @@
 	while (rq->hard_bio != rq->bio)
 		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
 			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}

 	/* Still data left to transfer. */
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
@@ -569,6 +584,11 @@
 	while (rq->hard_bio != rq->bio)
 		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->hard_bio)))
 			return ide_stopped;
+	/* Complete rq->buffer based request (ioctls). */
+	if (!rq->bio && !rq->nr_sectors) {
+		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		return ide_stopped;
+	}

 	/* Still data left to transfer. */
 	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
@@ -953,10 +973,11 @@
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size == 0)
 			rq.current_nr_sectors = rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
-		/*	rq.hard_cur_sectors	*/
 		else
 			rq.current_nr_sectors = rq.nr_sectors = data_size / SECTOR_SIZE;
-		/*	rq.hard_cur_sectors	*/
+
+		rq.hard_nr_sectors = rq.nr_sectors;
+		rq.hard_cur_sectors = rq.current_nr_sectors;
 	}

 	if (args->tf_out_flags.all == 0) {
diff -uNr linux-2.5.67-ac1/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.67-ac1/include/linux/ide.h	Thu Apr 17 17:46:53 2003
+++ linux/include/linux/ide.h	Thu Apr 17 18:01:18 2003
@@ -840,12 +840,6 @@
 #define ide_rq_offset(rq) \
 	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)

-/*
- * taskfiles really should use hard_cur_sectors as well!
- */
-#define task_rq_offset(rq) \
-	(((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE)
-
 static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
 {
 	/*
@@ -857,7 +851,7 @@
 	/*
 	 * task request
 	 */
-	return rq->buffer + task_rq_offset(rq);
+	return rq->buffer + ide_rq_offset(rq);
 }

 static inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)

