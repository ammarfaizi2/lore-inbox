Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264239AbUFKQ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbUFKQ0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUFKQSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:18:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264134AbUFKQQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [6/12]
Date: Fri, 11 Jun 2004 18:18:17 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406111759.12066.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could somebody explain why ALTERNATE_STATE_DIAGRAM_MULTI_OUT was needed?

[PATCH] ide: remove ALTERNATE_STATE_DIAGRAM_MULTI_OUT from ide-taskfile.c

First introduced in 2.4.19/2.5.3 as ALTSTAT_SCREW_UP, never used.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c |   38 --------------------
 1 files changed, 38 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_alt_pio_mulout drivers/ide/ide-taskfile.c
--- linux-2.6.7-rc3/drivers/ide/ide-taskfile.c~ide_alt_pio_mulout	2004-06-10 23:00:18.900409664 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c	2004-06-10 23:00:18.907408600 +0200
@@ -503,18 +503,8 @@ ide_startstop_t task_out_intr (ide_drive
 
 EXPORT_SYMBOL(task_out_intr);
 
-#undef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-
 ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
 {
-#ifdef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-	ide_hwif_t *hwif		= HWIF(drive);
-	char *pBuf			= NULL;
-	unsigned int nsect = 0, msect	= drive->mult_count;
-        u8 stat;
-	unsigned long flags;
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
-
 	ide_task_t *args = rq->special;
 	ide_startstop_t startstop;
 
@@ -525,31 +515,6 @@ ide_startstop_t pre_task_mulout_intr (id
 			drive->addressing ? "MULTWRITE_EXT" : "MULTWRITE");
 		return startstop;
 	}
-#ifdef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
-
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-		pBuf = task_map_rq(rq, &flags);
-		DTF("Pre-Multiwrite: %p, nsect: %d, msect: %d, " \
-			"rq->current_nr_sectors: %ld\n",
-			pBuf, nsect, msect, rq->current_nr_sectors);
-		msect -= nsect;
-		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
-		rq->current_nr_sectors -= nsect;
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				if (!rq->bio) {
-					stat = hwif->INB(IDE_STATUS_REG);
-					return ide_stopped;
-				}
-		}
-	} while (msect);
-	rq->errors = 0;
-	return ide_started;
-#else /* ! ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
 	if (!(drive_is_ready(drive))) {
 		int i;
 		for (i=0; i<100; i++) {
@@ -563,7 +528,6 @@ ide_startstop_t pre_task_mulout_intr (id
 	 * move the DATA-TRANSFER T-Bar as BSY != 0. <andre@linux-ide.org>
 	 */
 	return args->handler(drive);
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
 }
 
 EXPORT_SYMBOL(pre_task_mulout_intr);
@@ -632,7 +596,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 		return ide_started;
 	}
 
-#ifndef ALTERNATE_STATE_DIAGRAM_MULTI_OUT
 	if (HWGROUP(drive)->handler != NULL) {
 		unsigned long lflags;
 		spin_lock_irqsave(&ide_lock, lflags);
@@ -640,7 +603,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 		del_timer(&HWGROUP(drive)->timer);
 		spin_unlock_irqrestore(&ide_lock, lflags);
 	}
-#endif /* ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
 
 	do {
 		nsect = rq->current_nr_sectors;

_

