Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUFKQ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUFKQ0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFKQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:18:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264131AbUFKQQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:12 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [10/12]
Date: Fri, 11 Jun 2004 18:15:49 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111815.49395.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: tiny task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n) cleanup

- merge status checking code for rq->current_nr_sectors
  and !rq->current_nr_sectors cases
- remove !rq->bio check as it is always true

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_task_mulout_intr drivers/ide/ide-taskfile.c
--- linux-2.6.7-rc3/drivers/ide/ide-taskfile.c~ide_task_mulout_intr	2004-06-10 23:15:19.927432736 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c	2004-06-10 23:15:19.931432128 +0200
@@ -505,29 +505,18 @@ ide_startstop_t task_mulout_intr (ide_dr
 	u8 stat				= hwif->INB(IDE_STATUS_REG);
 	struct request *rq		= HWGROUP(drive)->rq;
 	char *pBuf			= NULL;
-	ide_startstop_t startstop	= ide_stopped;
 	unsigned int msect		= drive->mult_count;
 	unsigned int nsect;
 	unsigned long flags;
 
-	/*
-	 * (ks/hs): Handle last IRQ on multi-sector transfer,
-	 * occurs after all data was sent in this chunk
-	 */
-	if (rq->current_nr_sectors == 0) {
+	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT) || !rq->current_nr_sectors) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
 			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
 		}
-		if (!rq->bio)
+		/* Handle last IRQ, occurs after all data was sent. */
+		if (!rq->current_nr_sectors) {
 			DRIVER(drive)->end_request(drive, 1, 0);
-		return startstop;
-	}
-	/*
-	 * DON'T be lazy code the above and below togather !!!
-	 */
-	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "task_mulout_intr", stat);
+			return ide_stopped;
 		}
 		/* no data yet, so wait for another interrupt */
 		if (HWGROUP(drive)->handler == NULL)

_

