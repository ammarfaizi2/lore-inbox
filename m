Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUFKQTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUFKQTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUFKQSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:18:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264138AbUFKQQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:14 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [12/12]
Date: Fri, 11 Jun 2004 18:16:24 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111816.24875.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: check no. of sectors for in/out commands in ide_diag_taskfile()

Make sure that number of sectors != 0 for in/out command before sending
it to drive.  Remove no longer needed checks from flagged_* PIO handlers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c |   21 +++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_task_sectors drivers/ide/ide-taskfile.c
--- linux-2.6.7-rc3/drivers/ide/ide-taskfile.c~ide_task_sectors	2004-06-11 16:30:34.934913976 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c	2004-06-11 16:30:34.947912000 +0200
@@ -846,6 +846,12 @@ int ide_diag_taskfile (ide_drive_t *driv
 		else
 			rq.nr_sectors = data_size / SECTOR_SIZE;
 
+		if (!rq.nr_sectors) {
+			printk(KERN_ERR "%s: in/out command without data\n",
+					drive->name);
+			return -EFAULT;
+		}
+
 		rq.hard_nr_sectors = rq.nr_sectors;
 		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
 	}
@@ -1330,9 +1336,6 @@ ide_startstop_t flagged_task_in_intr (id
 	char *pBuf		= NULL;
 	int retries             = 5;
 
-	if (rq->current_nr_sectors == 0) 
-		return DRIVER(drive)->error(drive, "flagged_task_in_intr (no data requested)", stat); 
-
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & ERR_STAT) {
 			return DRIVER(drive)->error(drive, "flagged_task_in_intr", stat);
@@ -1379,9 +1382,6 @@ ide_startstop_t flagged_task_mulin_intr 
 	int retries             = 5;
 	unsigned int msect, nsect;
 
-	if (rq->current_nr_sectors == 0) 
-		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (no data requested)", stat); 
-
 	msect = drive->mult_count;
 	if (msect == 0) 
 		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (multimode not set)", stat); 
@@ -1433,14 +1433,8 @@ ide_startstop_t flagged_task_mulin_intr 
  */
 ide_startstop_t flagged_pre_task_out_intr (ide_drive_t *drive, struct request *rq)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	ide_startstop_t startstop;
 
-	if (!rq->current_nr_sectors) {
-		return DRIVER(drive)->error(drive, "flagged_pre_task_out_intr (write data not specified)", stat);
-	}
-
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
 			BAD_W_STAT, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: No DRQ bit after issuing write command.\n", drive->name);
@@ -1502,9 +1496,6 @@ ide_startstop_t flagged_pre_task_mulout_
 	ide_startstop_t startstop;
 	unsigned int msect, nsect;
 
-	if (!rq->current_nr_sectors) 
-		return DRIVER(drive)->error(drive, "flagged_pre_task_mulout_intr (write data not specified)", stat);
-
 	msect = drive->mult_count;
 	if (msect == 0)
 		return DRIVER(drive)->error(drive, "flagged_pre_task_mulout_intr (multimode not set)", stat);

_

