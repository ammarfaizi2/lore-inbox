Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266716AbUF3P1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266716AbUF3P1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUF3P0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:26:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266702AbUF3PZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [1/9]
Date: Wed, 30 Jun 2004 17:24:05 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301724.05862.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: PIO-out fixes for ide-taskfile.c (CONFIG_IDE_TASKFILE_IO=n)

- in task_out_intr() fix off-by-1 bug and (stat & DRQ_STAT) check,
  previously "if" was always true for rq->current_nr_sectors == 1
- fail request if DRQ_STAT is not set and rq->current_nr_sectors != 0
  (instead of setting handler and waiting for the next IRQ) or if DRQ_STAT
  is set but !rq->current_nr_sectors (in task_mulout_intr() this was OK)
- in task_mulout_intr() check also DRIVE_READY and WRERR_STAT status bits

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |   31 +++++++++----------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_fixes drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_tf_pio_out_fixes	2004-06-28 21:15:54.030210376 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:15:54.035209616 +0200
@@ -409,6 +409,10 @@ ide_startstop_t task_out_intr (ide_drive
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY, drive->bad_wstat)) {
 		return DRIVER(drive)->error(drive, "task_out_intr", stat);
 	}
+
+	if (((stat & DRQ_STAT) == 0) ^ !rq->current_nr_sectors)
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
 	/*
 	 * Safe to update request for partial completions.
 	 * We have a good STATUS CHECK!!!
@@ -416,9 +420,8 @@ ide_startstop_t task_out_intr (ide_drive
 	if (!rq->current_nr_sectors)
 		if (!DRIVER(drive)->end_request(drive, 1, 0))
 			return ide_stopped;
-	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
-		task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
-	}
+
+	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 }
@@ -461,18 +464,16 @@ ide_startstop_t task_mulout_intr (ide_dr
 	u8 stat				= hwif->INB(IDE_STATUS_REG);
 	struct request *rq		= HWGROUP(drive)->rq;
 
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT) || !rq->current_nr_sectors) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
-		}
-		/* Handle last IRQ, occurs after all data was sent. */
-		if (!rq->current_nr_sectors) {
-			DRIVER(drive)->end_request(drive, 1, 0);
-			return ide_stopped;
-		}
-		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-		return ide_started;
+	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
+	if (((stat & DRQ_STAT) == 0) ^ !rq->current_nr_sectors)
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
+	/* Handle last IRQ, occurs after all data was sent. */
+	if (!rq->current_nr_sectors) {
+		DRIVER(drive)->end_request(drive, 1, 0);
+		return ide_stopped;
 	}
 
 	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);

_

