Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUFSQVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUFSQVC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUFSQTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:19:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5028 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264346AbUFSQPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [6/11]
Date: Sat, 19 Jun 2004 18:11:53 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406191811.30819.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: remove DTF() debugging printks from ide-taskfile.c

They are off by default and conflict with the future changes.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   34 ------------------------
 1 files changed, 34 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_taskfile_DTF drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_taskfile_DTF	2004-06-19 02:57:51.953815368 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:57:51.959814456 +0200
@@ -53,12 +53,6 @@
 
 #define DEBUG_TASKFILE	0	/* unset when fixed */
 
-#if DEBUG_TASKFILE
-#define DTF(x...) printk(x)
-#else
-#define DTF(x...)
-#endif
-
 static void ata_bswap_data (void *buffer, int wcount)
 {
 	u16 *p = buffer;
@@ -283,8 +277,6 @@ ide_startstop_t task_no_data_intr (ide_d
 
 	local_irq_enable();
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),READY_STAT,BAD_STAT)) {
-		DTF("%s: command opcode 0x%02x\n", drive->name,
-			args->tfRegister[IDE_COMMAND_OFFSET]);
 		return DRIVER(drive)->error(drive, "task_no_data_intr", stat);
 		/* calls ide_end_drive_cmd */
 	}
@@ -316,15 +308,12 @@ ide_startstop_t task_in_intr (ide_drive_
 			return DRIVER(drive)->error(drive, "task_in_intr", stat);
 		}
 		if (!(stat & BUSY_STAT)) {
-			DTF("task_in_intr to Soon wait for next interrupt\n");
 			ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 			return ide_started;  
 		}
 	}
 
 	pBuf = rq->buffer + task_rq_offset(rq);
-	DTF("Read: %p, rq->current_nr_sectors: %d, stat: %02x\n",
-		pBuf, (int) rq->current_nr_sectors, stat);
 	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
 
 	/* FIXME: check drive status */
@@ -363,9 +352,6 @@ ide_startstop_t task_mulin_intr (ide_dri
 		if (nsect > msect)
 			nsect = msect;
 		pBuf = rq->buffer + task_rq_offset(rq);
-		DTF("Multiread: %p, nsect: %d, msect: %d, " \
-			" rq->current_nr_sectors: %d\n",
-			pBuf, nsect, msect, rq->current_nr_sectors);
 		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
 		rq->errors = 0;
 		rq->current_nr_sectors -= nsect;
@@ -431,8 +417,6 @@ ide_startstop_t task_out_intr (ide_drive
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
 		rq = HWGROUP(drive)->rq;
 		pBuf = rq->buffer + task_rq_offset(rq);
-		DTF("write: %p, rq->current_nr_sectors: %d\n",
-			pBuf, (int) rq->current_nr_sectors);
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
 		rq->errors = 0;
 		rq->current_nr_sectors--;
@@ -514,9 +498,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 		if (nsect > msect)
 			nsect = msect;
 		pBuf = rq->buffer + task_rq_offset(rq);
-		DTF("Multiwrite: %p, nsect: %d, msect: %d, " \
-			"rq->current_nr_sectors: %ld\n",
-			pBuf, nsect, msect, rq->current_nr_sectors);
 		msect -= nsect;
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 		rq->current_nr_sectors -= nsect;
@@ -1338,8 +1319,6 @@ ide_startstop_t flagged_task_in_intr (id
 	}
 
 	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Read - rq->current_nr_sectors: %d, status: %02x\n", (int) rq->current_nr_sectors, stat);
-
 	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
 
 	if (--rq->current_nr_sectors != 0) {
@@ -1387,10 +1366,6 @@ ide_startstop_t flagged_task_mulin_intr 
 
 	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
 	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-
-	DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-	    pBuf, nsect, rq->current_nr_sectors);
-
 	taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
 
 	rq->current_nr_sectors -= nsect;
@@ -1459,9 +1434,6 @@ ide_startstop_t flagged_task_out_intr (i
 	}
 
 	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Write - rq->current_nr_sectors: %d, status: %02x\n",
-		(int) rq->current_nr_sectors, stat);
-
 	taskfile_output_data(drive, pBuf, SECTOR_WORDS);
 	--rq->current_nr_sectors;
 
@@ -1490,9 +1462,6 @@ ide_startstop_t flagged_pre_task_mulout_
 
 	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
 	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-	    pBuf, nsect, rq->current_nr_sectors);
-
 	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 
 	rq->current_nr_sectors -= nsect;
@@ -1530,9 +1499,6 @@ ide_startstop_t flagged_task_mulout_intr
 
 	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
 	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-	    pBuf, nsect, rq->current_nr_sectors);
-
 	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 	rq->current_nr_sectors -= nsect;
 

_

