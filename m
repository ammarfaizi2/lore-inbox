Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUFKQ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUFKQ0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUFKQSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:18:07 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264124AbUFKQQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:12 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [9/12]
Date: Fri, 11 Jun 2004 18:15:16 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111815.16493.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: cleanup taskfile PIO handlers (CONFIG_IDE_TASKFILE_IO=n)

These handlers are nowadays used only for REQ_DRIVE_TASKFILE
requests (rq->bio is always NULL) which aren't retried et all so
remove code 'rewinding' rq->current_nr_sectors and some FIXMEs.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c |   77 +-------------------
 1 files changed, 6 insertions(+), 71 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_taskfile_retry drivers/ide/ide-taskfile.c
--- linux-2.6.7-rc3/drivers/ide/ide-taskfile.c~ide_taskfile_retry	2004-06-10 23:13:09.376279528 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c	2004-06-10 23:13:09.382278616 +0200
@@ -307,10 +307,6 @@ EXPORT_SYMBOL(task_no_data_intr);
 /*
  * Handler for command with PIO data-in phase, READ
  */
-/*
- * FIXME before 2.4 enable ...
- *	DATA integrity issue upon error. <andre@linux-ide.org>
- */
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
 	struct request *rq	= HWGROUP(drive)->rq;
@@ -321,18 +317,6 @@ ide_startstop_t task_in_intr (ide_drive_
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-#if 0
-			DTF("%s: attempting to recover last " \
-				"sector counter status=0x%02x\n",
-				drive->name, stat);
-			/*
-			 * Expect a BUG BOMB if we attempt to rewind the
-			 * offset in the BH aka PAGE in the current BLOCK
-			 * segment.  This is different than the HOST segment.
-			 */
-#endif
-			if (!rq->bio)
-				rq->current_nr_sectors++;
 			return DRIVER(drive)->error(drive, "task_in_intr", stat);
 		}
 		if (!(stat & BUSY_STAT)) {
@@ -348,12 +332,8 @@ ide_startstop_t task_in_intr (ide_drive_
 		pBuf, (int) rq->current_nr_sectors, stat);
 	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
 	task_unmap_rq(rq, pBuf, &flags);
-	/*
-	 * FIXME :: We really can not legally get a new page/bh
-	 * regardless, if this is the end of our segment.
-	 * BH walking or segment can only be updated after we have a good
-	 * hwif->INB(IDE_STATUS_REG); return.
-	 */
+
+	/* FIXME: check drive status */
 	if (--rq->current_nr_sectors <= 0)
 		if (!DRIVER(drive)->end_request(drive, 1, 0))
 			return ide_stopped;
@@ -383,16 +363,6 @@ ide_startstop_t task_mulin_intr (ide_dri
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			if (!rq->bio) {
-				rq->current_nr_sectors += drive->mult_count;
-				/*
-				 * NOTE: could rewind beyond beginning :-/
-				 */
-			} else {
-				printk(KERN_ERR "%s: MULTI-READ assume all data " \
-					"transfered is bad status=0x%02x\n",
-					drive->name, stat);
-			}
 			return DRIVER(drive)->error(drive, "task_mulin_intr", stat);
 		}
 		/* no data yet, so wait for another interrupt */
@@ -414,12 +384,8 @@ ide_startstop_t task_mulin_intr (ide_dri
 		rq->errors = 0;
 		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
-		/*
-		 * FIXME :: We really can not legally get a new page/bh
-		 * regardless, if this is the end of our segment.
-		 * BH walking or segment can only be updated after we have a
-		 * good hwif->INB(IDE_STATUS_REG); return.
-		 */
+
+		/* FIXME: check drive status */
 		if (!rq->current_nr_sectors) {
 			if (!DRIVER(drive)->end_request(drive, 1, 0))
 				return ide_stopped;
@@ -473,10 +439,6 @@ ide_startstop_t task_out_intr (ide_drive
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY, drive->bad_wstat)) {
-		DTF("%s: WRITE attempting to recover last " \
-			"sector counter status=0x%02x\n",
-			drive->name, stat);
-		rq->current_nr_sectors++;
 		return DRIVER(drive)->error(drive, "task_out_intr", stat);
 	}
 	/*
@@ -533,9 +495,6 @@ ide_startstop_t pre_task_mulout_intr (id
 EXPORT_SYMBOL(pre_task_mulout_intr);
 
 /*
- * FIXME before enabling in 2.4 ... DATA integrity issue upon error.
- */
-/*
  * Handler for command write multiple
  * Called directly from execute_drive_cmd for the first bunch of sectors,
  * afterwards only by the ISR
@@ -557,16 +516,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 	 */
 	if (rq->current_nr_sectors == 0) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			if (!rq->bio) {
-                                rq->current_nr_sectors += drive->mult_count;
-				/*
-				 * NOTE: could rewind beyond beginning :-/
-				 */
-			} else {
-				printk(KERN_ERR "%s: MULTI-WRITE assume all data " \
-					"transfered is bad status=0x%02x\n",
-					drive->name, stat);
-			}
 			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
 		}
 		if (!rq->bio)
@@ -578,16 +527,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 	 */
 	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
-			if (!rq->bio) {
-				rq->current_nr_sectors += drive->mult_count;
-				/*
-				 * NOTE: could rewind beyond beginning :-/
-				 */
-			} else {
-				printk("%s: MULTI-WRITE assume all data " \
-					"transfered is bad status=0x%02x\n",
-					drive->name, stat);
-			}
 			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
 		}
 		/* no data yet, so wait for another interrupt */
@@ -616,12 +555,8 @@ ide_startstop_t task_mulout_intr (ide_dr
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 		task_unmap_rq(rq, pBuf, &flags);
 		rq->current_nr_sectors -= nsect;
-		/*
-		 * FIXME :: We really can not legally get a new page/bh
-		 * regardless, if this is the end of our segment.
-		 * BH walking or segment can only be updated after we
-		 * have a good  hwif->INB(IDE_STATUS_REG); return.
-		 */
+
+		/* FIXME: check drive status */
 		if (!rq->current_nr_sectors) {
 			if (!DRIVER(drive)->end_request(drive, 1, 0))
 				if (!rq->bio)

_

