Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUFSQZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUFSQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUFSQXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:23:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264355AbUFSQQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:16:00 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [9/11]
Date: Sat, 19 Jun 2004 18:14:04 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191814.04988.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: don't clear rq->errors for REQ_DRIVE_TASKFILE requests

REQ_DRIVE_TASKFILE requests aren't retried so don't clear rq->errors
in CONFIG_IDE_TASKFILE_IO=n PIO handlers and in CONFIG_IDE_TASKFILE_IO=y
PIO handlers clear rq->errors only for fs requests, flagged_* PIO
handlers were already okay.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_rq_errors drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_rq_errors	2004-06-19 03:01:41.416931672 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 03:01:41.421930912 +0200
@@ -374,7 +374,6 @@ ide_startstop_t task_mulin_intr (ide_dri
 			nsect = msect;
 		pBuf = rq->buffer + task_rq_offset(rq);
 		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
-		rq->errors = 0;
 		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
 
@@ -439,7 +438,6 @@ ide_startstop_t task_out_intr (ide_drive
 		rq = HWGROUP(drive)->rq;
 		pBuf = rq->buffer + task_rq_offset(rq);
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-		rq->errors = 0;
 		rq->current_nr_sectors--;
 	}
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
@@ -523,7 +521,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 		rq->current_nr_sectors -= nsect;
 	} while (msect);
-	rq->errors = 0;
 	if (HWGROUP(drive)->handler == NULL)
 		ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
@@ -536,9 +533,10 @@ EXPORT_SYMBOL(task_mulout_intr);
 static void task_sectors(ide_drive_t *drive, struct request *rq,
 			 unsigned nsect, unsigned rw)
 {
-	if (rq->cbio)	/* fs request */
+	if (rq->cbio) {	/* fs request */
+		rq->errors = 0;
 		task_bio_sectors(drive, rq, nsect, rw);
-	else		/* task request */
+	} else		/* task request */
 		task_buffer_sectors(drive, rq, nsect, rw);
 }
 
@@ -547,7 +545,6 @@ static inline void task_bio_multi_sector
 {
 	unsigned int nsect, msect = drive->mult_count;
 
-	rq->errors = 0;
 	do {
 		nsect = rq->current_nr_sectors;
 		if (nsect > msect)
@@ -565,9 +562,10 @@ static inline void task_bio_multi_sector
 static void task_multi_sectors(ide_drive_t *drive,
 			       struct request *rq, unsigned rw)
 {
-	if (rq->cbio)	/* fs request */
+	if (rq->cbio) {	/* fs request */
+		rq->errors = 0;
 		task_bio_multi_sectors(drive, rq, rw);
-	else		/* task request */
+	} else		/* task request */
 		task_buffer_multi_sectors(drive, rq, rw);
 }
 
@@ -620,7 +618,6 @@ finish_rq:
 		return ide_stopped;
 	}
 
-	rq->errors = 0;
 	task_sectors(drive, rq, 1, IDE_PIO_IN);
 
 	/* If it was the last datablock check status and finish transfer. */
@@ -724,8 +721,6 @@ ide_startstop_t task_out_intr (ide_drive
 
 	/* Still data left to transfer. */
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
-
-	rq->errors = 0;
 	task_sectors(drive, rq, 1, IDE_PIO_OUT);
 
 	return ide_started;

_

