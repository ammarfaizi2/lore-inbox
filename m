Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUFSQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUFSQVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUFSQUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:20:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264265AbUFSQP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [3/11]
Date: Sat, 19 Jun 2004 18:09:42 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191809.42554.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: PIO-in drive busy fix (CONFIG_IDE_TASKFILE_IO=y)

If drive timeouts final status check we should fail request
instead of setting another handler for the next IRQ.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   28 ++++++++++--------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_busy_fix drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_busy_fix	2004-06-19 02:47:36.847325768 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:55:05.388137200 +0200
@@ -564,19 +564,16 @@ static u8 wait_drive_not_busy(ide_drive_
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat, good_stat;
+	u8 stat = HWIF(drive)->INB(IDE_STATUS_REG);
 
-	good_stat = DATA_READY;
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-check_status:
-	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
+	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
 		/* BUSY_STAT: No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-
+finish_rq:
 	/*
 	 * Complete previously submitted bios (if any).
 	 * Status was already verifyied.
@@ -595,9 +592,10 @@ check_status:
 
 	/* If it was the last datablock check status and finish transfer. */
 	if (!rq->nr_sectors) {
-		good_stat = 0;
 		stat = wait_drive_not_busy(drive);
-		goto check_status;
+		if (!OK_STAT(stat, 0, BAD_R_STAT))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		goto finish_rq;
 	}
 
 	/* Still data left to transfer. */
@@ -615,19 +613,16 @@ ide_startstop_t task_mulin_intr (ide_dri
 	struct request *rq = HWGROUP(drive)->rq;
 	unsigned int msect = drive->mult_count;
 	unsigned int nsect;
-	u8 stat, good_stat;
+	u8 stat = HWIF(drive)->INB(IDE_STATUS_REG);
 
-	good_stat = DATA_READY;
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-check_status:
-	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
+	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
 		/* BUSY_STAT: No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-
+finish_rq:
 	/*
 	 * Complete previously submitted bios (if any).
 	 * Status was already verifyied.
@@ -657,9 +652,10 @@ check_status:
 
 	/* If it was the last datablock check status and finish transfer. */
 	if (!rq->nr_sectors) {
-		good_stat = 0;
 		stat = wait_drive_not_busy(drive);
-		goto check_status;
+		if (!OK_STAT(stat, 0, BAD_R_STAT))
+			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		goto finish_rq;
 	}
 
 	/* Still data left to transfer. */

_

