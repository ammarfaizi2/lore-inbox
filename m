Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUFKQTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUFKQTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUFKQTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:19:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264147AbUFKQQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:15 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [11/12]
Date: Fri, 11 Jun 2004 18:16:10 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111816.10369.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: kill task_[un]map_rq()

PIO handlers under CONFIG_IDE_TASKFILE_IO=n are never used for bio
based requests (rq->bio is always NULL) so we can use rq->buffer
directly instead of calling ide_[un]map_buffer().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c |   25 ++++----------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_task_rq_mapping drivers/ide/ide-taskfile.c
--- linux-2.6.7-rc3/drivers/ide/ide-taskfile.c~ide_task_rq_mapping	2004-06-11 16:28:38.227656176 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-taskfile.c	2004-06-11 16:29:20.524226120 +0200
@@ -301,9 +301,6 @@ EXPORT_SYMBOL(task_no_data_intr);
  */
 #ifndef CONFIG_IDE_TASKFILE_IO
 
-#define task_map_rq(rq, flags)		ide_map_buffer((rq), (flags))
-#define task_unmap_rq(rq, buf, flags)	ide_unmap_buffer((rq), (buf), (flags))
-
 /*
  * Handler for command with PIO data-in phase, READ
  */
@@ -313,7 +310,6 @@ ide_startstop_t task_in_intr (ide_drive_
 	ide_hwif_t *hwif	= HWIF(drive);
 	char *pBuf		= NULL;
 	u8 stat;
-	unsigned long flags;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
@@ -327,11 +323,10 @@ ide_startstop_t task_in_intr (ide_drive_
 		}
 	}
 
-	pBuf = task_map_rq(rq, &flags);
+	pBuf = rq->buffer + task_rq_offset(rq);
 	DTF("Read: %p, rq->current_nr_sectors: %d, stat: %02x\n",
 		pBuf, (int) rq->current_nr_sectors, stat);
 	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
-	task_unmap_rq(rq, pBuf, &flags);
 
 	/* FIXME: check drive status */
 	if (--rq->current_nr_sectors <= 0)
@@ -358,7 +353,6 @@ ide_startstop_t task_mulin_intr (ide_dri
 	char *pBuf		= NULL;
 	unsigned int msect	= drive->mult_count;
 	unsigned int nsect;
-	unsigned long flags;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
@@ -375,12 +369,11 @@ ide_startstop_t task_mulin_intr (ide_dri
 		nsect = rq->current_nr_sectors;
 		if (nsect > msect)
 			nsect = msect;
-		pBuf = task_map_rq(rq, &flags);
+		pBuf = rq->buffer + task_rq_offset(rq);
 		DTF("Multiread: %p, nsect: %d, msect: %d, " \
 			" rq->current_nr_sectors: %d\n",
 			pBuf, nsect, msect, rq->current_nr_sectors);
 		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
 		rq->errors = 0;
 		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
@@ -404,8 +397,6 @@ EXPORT_SYMBOL(task_mulin_intr);
  */
 ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
 {
-	char *pBuf		= NULL;
-	unsigned long flags;
 	ide_startstop_t startstop;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
@@ -416,10 +407,8 @@ ide_startstop_t pre_task_out_intr (ide_d
 		return startstop;
 	}
 	/* For Write_sectors we need to stuff the first sector */
-	pBuf = task_map_rq(rq, &flags);
-	taskfile_output_data(drive, pBuf, SECTOR_WORDS);
+	taskfile_output_data(drive, rq->buffer + task_rq_offset(rq), SECTOR_WORDS);
 	rq->current_nr_sectors--;
-	task_unmap_rq(rq, pBuf, &flags);
 	return ide_started;
 }
 
@@ -435,7 +424,6 @@ ide_startstop_t task_out_intr (ide_drive
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
-	unsigned long flags;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY, drive->bad_wstat)) {
@@ -450,11 +438,10 @@ ide_startstop_t task_out_intr (ide_drive
 			return ide_stopped;
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
 		rq = HWGROUP(drive)->rq;
-		pBuf = task_map_rq(rq, &flags);
+		pBuf = rq->buffer + task_rq_offset(rq);
 		DTF("write: %p, rq->current_nr_sectors: %d\n",
 			pBuf, (int) rq->current_nr_sectors);
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
 		rq->errors = 0;
 		rq->current_nr_sectors--;
 	}
@@ -507,7 +494,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 	char *pBuf			= NULL;
 	unsigned int msect		= drive->mult_count;
 	unsigned int nsect;
-	unsigned long flags;
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT) || !rq->current_nr_sectors) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
@@ -536,13 +522,12 @@ ide_startstop_t task_mulout_intr (ide_dr
 		nsect = rq->current_nr_sectors;
 		if (nsect > msect)
 			nsect = msect;
-		pBuf = task_map_rq(rq, &flags);
+		pBuf = rq->buffer + task_rq_offset(rq);
 		DTF("Multiwrite: %p, nsect: %d, msect: %d, " \
 			"rq->current_nr_sectors: %ld\n",
 			pBuf, nsect, msect, rq->current_nr_sectors);
 		msect -= nsect;
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-		task_unmap_rq(rq, pBuf, &flags);
 		rq->current_nr_sectors -= nsect;
 
 		/* FIXME: check drive status */

_

