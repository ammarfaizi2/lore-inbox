Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266707AbUF3PdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266707AbUF3PdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUF3P2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:28:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266706AbUF3PZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:27 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [7/9]
Date: Wed, 30 Jun 2004 17:26:18 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301726.18688.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: no partial completions for PIO (CONFIG_IDE_TASKFILE_IO=y)

Don't do partial completions but instead acknowledge already transferred
sectors with verified good status on error.  This allows us to complete
"good" sectors to block layer even if bio they belong to wasn't finished
and simplifies code.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |   84 ++++++-------------
 1 files changed, 28 insertions(+), 56 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_no_partial drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_tf_no_partial	2004-06-28 21:27:54.872625672 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:27:54.878624760 +0200
@@ -532,6 +532,18 @@ static u8 wait_drive_not_busy(ide_drive_
 	return stat;
 }
 
+static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
+				  const char *s, u8 stat, unsigned cur_bad)
+{
+	if (rq->bio) {
+		int sectors = rq->hard_nr_sectors - rq->nr_sectors - cur_bad;
+
+		if (sectors > 0)
+			drive->driver->end_request(drive, 1, sectors);
+	}
+	return drive->driver->error(drive, s, stat);
+}
+
 /*
  * Handler for command with PIO data-in phase (Read).
  */
@@ -542,24 +554,11 @@ ide_startstop_t task_in_intr (ide_drive_
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
-			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+			return task_error(drive, rq, __FUNCTION__, stat, 0);
 		/* BUSY_STAT: No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-finish_rq:
-	/*
-	 * Complete previously submitted bios (if any).
-	 * Status was already verifyied.
-	 */
-	while (rq->bio != rq->cbio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
-			return ide_stopped;
-	/* Complete rq->buffer based request (ioctls). */
-	if (!rq->bio && !rq->nr_sectors) {
-		DRIVER(drive)->end_request(drive, 1, 0);
-		return ide_stopped;
-	}
 
 	task_sectors(drive, rq, 1, IDE_PIO_IN);
 
@@ -567,8 +566,9 @@ finish_rq:
 	if (!rq->nr_sectors) {
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
-			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-		goto finish_rq;
+			return task_error(drive, rq, __FUNCTION__, stat, 1);
+		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		return ide_stopped;
 	}
 
 	/* Still data left to transfer. */
@@ -588,24 +588,11 @@ ide_startstop_t task_mulin_intr (ide_dri
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
-			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+			return task_error(drive, rq, __FUNCTION__, stat, 0);
 		/* BUSY_STAT: No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-finish_rq:
-	/*
-	 * Complete previously submitted bios (if any).
-	 * Status was already verifyied.
-	 */
-	while (rq->bio != rq->cbio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
-			return ide_stopped;
-	/* Complete rq->buffer based request (ioctls). */
-	if (!rq->bio && !rq->nr_sectors) {
-		DRIVER(drive)->end_request(drive, 1, 0);
-		return ide_stopped;
-	}
 
 	task_multi_sectors(drive, rq, IDE_PIO_IN);
 
@@ -613,8 +600,9 @@ finish_rq:
 	if (!rq->nr_sectors) {
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
-			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-		goto finish_rq;
+			return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
+		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		return ide_stopped;
 	}
 
 	/* Still data left to transfer. */
@@ -634,23 +622,15 @@ ide_startstop_t task_out_intr (ide_drive
 
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		return task_error(drive, rq, __FUNCTION__, stat, 1);
 
 	/* Deal with unexpected ATA data phase. */
 	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
 	    ((stat & DATA_READY) && !rq->nr_sectors))
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		return task_error(drive, rq, __FUNCTION__, stat, 1);
 
-	/* 
-	 * Complete previously submitted bios (if any).
-	 * Status was already verifyied.
-	 */
-	while (rq->bio != rq->cbio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
-			return ide_stopped;
-	/* Complete rq->buffer based request (ioctls). */
-	if (!rq->bio && !rq->nr_sectors) {
-		DRIVER(drive)->end_request(drive, 1, 0);
+	if (!rq->nr_sectors) {
+		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
 		return ide_stopped;
 	}
 
@@ -694,23 +674,15 @@ ide_startstop_t task_mulout_intr (ide_dr
 
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
 
 	/* Deal with unexpected ATA data phase. */
 	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
 	    ((stat & DATA_READY) && !rq->nr_sectors))
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
 
-	/* 
-	 * Complete previously submitted bios (if any).
-	 * Status was already verifyied.
-	 */
-	while (rq->bio != rq->cbio)
-		if (!DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio)))
-			return ide_stopped;
-	/* Complete rq->buffer based request (ioctls). */
-	if (!rq->bio && !rq->nr_sectors) {
-		DRIVER(drive)->end_request(drive, 1, 0);
+	if (!rq->nr_sectors) {
+		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
 		return ide_stopped;
 	}
 

_

