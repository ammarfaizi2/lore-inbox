Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTDQXKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTDQXKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:10:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262682AbTDQXJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:09:53 -0400
Date: Fri, 18 Apr 2003 01:21:27 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304180120530.22161-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tf-ioctls-2b.diff:

# Taskfile and flagged Taskfile PIO handlers unification [2/2].
# Incremental to tf-ioctls-2a patch.
#
# Detailed changelog:
# - remove all flagged Taskfile handlers, use standard ones instead
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac1-tf2a/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac1-tf2a/drivers/ide/ide-taskfile.c	Thu Apr 17 21:17:43 2003
+++ linux/drivers/ide/ide-taskfile.c	Thu Apr 17 22:32:32 2003
@@ -1116,15 +1116,6 @@

 #define MAX_DMA		(256*SECTOR_WORDS)

-ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
-ide_startstop_t flagged_task_no_data_intr(ide_drive_t *);
-ide_startstop_t flagged_task_in_intr(ide_drive_t *);
-ide_startstop_t flagged_task_mulin_intr(ide_drive_t *);
-ide_startstop_t flagged_pre_task_out_intr(ide_drive_t *, struct request *);
-ide_startstop_t flagged_task_out_intr(ide_drive_t *);
-ide_startstop_t flagged_pre_task_mulout_intr(ide_drive_t *, struct request *);
-ide_startstop_t flagged_task_mulout_intr(ide_drive_t *);
-
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	ide_task_request_t	*req_task;
@@ -1230,23 +1221,13 @@
 				err = -EPERM;
 				goto abort;
 			}
-			if (args.tf_out_flags.all != 0) {
-				args.prehandler = &flagged_pre_task_mulout_intr;
-				args.handler = &flagged_task_mulout_intr;
-			} else {
-				args.prehandler = &pre_task_mulout_intr;
-				args.handler = &task_mulout_intr;
-			}
+			args.prehandler = &pre_task_mulout_intr;
+			args.handler = &task_mulout_intr;
 			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			break;
 		case TASKFILE_OUT:
-			if (args.tf_out_flags.all != 0) {
-				args.prehandler = &flagged_pre_task_out_intr;
-				args.handler    = &flagged_task_out_intr;
-			} else {
-				args.prehandler = &pre_task_out_intr;
-				args.handler = &task_out_intr;
-			}
+			args.prehandler = &pre_task_out_intr;
+			args.handler = &task_out_intr;
 			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			break;
 		case TASKFILE_MULTI_IN:
@@ -1258,27 +1239,15 @@
 				err = -EPERM;
 				goto abort;
 			}
-			if (args.tf_out_flags.all != 0) {
-				args.handler = &flagged_task_mulin_intr;
-			} else {
-				args.handler = &task_mulin_intr;
-			}
+			args.handler = &task_mulin_intr;
 			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 		case TASKFILE_IN:
-			if (args.tf_out_flags.all != 0) {
-				args.handler = &flagged_task_in_intr;
-			} else {
-				args.handler = &task_in_intr;
-			}
+			args.handler = &task_in_intr;
 			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 		case TASKFILE_NO_DATA:
-			if (args.tf_out_flags.all != 0) {
-				args.handler = &flagged_task_no_data_intr;
-			} else {
-				args.handler = &task_no_data_intr;
-			}
+			args.handler = &task_no_data_intr;
 			err = ide_diag_taskfile(drive, &args, 0, NULL);
 			break;
 		default:
@@ -1621,273 +1590,6 @@

 EXPORT_SYMBOL(flagged_taskfile);

-ide_startstop_t flagged_task_no_data_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	u8 stat;
-
-	local_irq_enable();
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), READY_STAT, BAD_STAT)) {
-		if (stat & ERR_STAT) {
-			return DRIVER(drive)->error(drive, "flagged_task_no_data_intr", stat);
-		}
-		/*
-		 * (ks) Unexpected ATA data phase detected.
-		 * This should not happen. But, it can !
-		 * I am not sure, which function is best to clean up
-		 * this situation.  I choose: ide_error(...)
-		 */
- 		return DRIVER(drive)->error(drive, "flagged_task_no_data_intr (unexpected phase)", stat);
-	}
-
-	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
-
-	return ide_stopped;
-}
-
-/*
- * Handler for command with PIO data-in phase
- */
-ide_startstop_t flagged_task_in_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-
-	if (rq->current_nr_sectors == 0)
-		return DRIVER(drive)->error(drive, "flagged_task_in_intr (no data requested)", stat);
-
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
-		if (stat & ERR_STAT) {
-			return DRIVER(drive)->error(drive, "flagged_task_in_intr", stat);
-		}
-		/*
-		 * (ks) Unexpected ATA data phase detected.
-		 * This should not happen. But, it can !
-		 * I am not sure, which function is best to clean up
-		 * this situation.  I choose: ide_error(...)
-		 */
-		return DRIVER(drive)->error(drive, "flagged_task_in_intr (unexpected data phase)", stat);
-	}
-
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Read - rq->current_nr_sectors: %d, status: %02x\n", (int) rq->current_nr_sectors, stat);
-
-	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
-
-	if (--rq->current_nr_sectors != 0) {
-		/*
-                 * (ks) We don't know which command was executed.
-		 * So, we wait the 'WORSTCASE' value.
-                 */
-		ide_set_handler(drive, &flagged_task_in_intr,  WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-	stat = flagged_wait_drive_ready(drive);
-	ide_end_drive_cmd (drive, stat, hwif->INB(IDE_ERROR_REG));
-
-	return ide_stopped;
-}
-
-ide_startstop_t flagged_task_mulin_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-	unsigned int msect, nsect;
-
-	if (rq->current_nr_sectors == 0)
-		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (no data requested)", stat);
-
-	msect = drive->mult_count;
-	if (msect == 0)
-		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (multimode not set)", stat);
-
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
-		if (stat & ERR_STAT) {
-			return DRIVER(drive)->error(drive, "flagged_task_mulin_intr", stat);
-		}
-		/*
-		 * (ks) Unexpected ATA data phase detected.
-		 * This should not happen. But, it can !
-		 * I am not sure, which function is best to clean up
-		 * this situation.  I choose: ide_error(...)
-		 */
-		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (unexpected data phase)", stat);
-	}
-
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-
-	DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-	    pBuf, nsect, rq->current_nr_sectors);
-
-	taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
-
-	rq->current_nr_sectors -= nsect;
-	if (rq->current_nr_sectors != 0) {
-		/*
-                 * (ks) We don't know which command was executed.
-		 * So, we wait the 'WORSTCASE' value.
-                 */
-		ide_set_handler(drive, &flagged_task_mulin_intr,  WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-	stat = flagged_wait_drive_ready(drive);
-	ide_end_drive_cmd (drive, stat, hwif->INB(IDE_ERROR_REG));
-
-	return ide_stopped;
-}
-
-/*
- * Pre handler for command with PIO data-out phase
- */
-ide_startstop_t flagged_pre_task_out_intr (ide_drive_t *drive, struct request *rq)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	ide_startstop_t startstop;
-
-	if (!rq->current_nr_sectors) {
-		return DRIVER(drive)->error(drive, "flagged_pre_task_out_intr (write data not specified)", stat);
-	}
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			BAD_W_STAT, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: No DRQ bit after issuing write command.\n", drive->name);
-		return startstop;
-	}
-
-	taskfile_output_data(drive, rq->buffer, SECTOR_WORDS);
-	--rq->current_nr_sectors;
-
-	return ide_started;
-}
-
-ide_startstop_t flagged_task_out_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-
-	if (!OK_STAT(stat, DRIVE_READY, BAD_W_STAT))
-		return DRIVER(drive)->error(drive, "flagged_task_out_intr", stat);
-
-	if (!rq->current_nr_sectors) {
-		ide_end_drive_cmd (drive, stat, hwif->INB(IDE_ERROR_REG));
-		return ide_stopped;
-	}
-
-	if (!OK_STAT(stat, DATA_READY, BAD_W_STAT)) {
-		/*
-		 * (ks) Unexpected ATA data phase detected.
-		 * This should not happen. But, it can !
-		 * I am not sure, which function is best to clean up
-		 * this situation.  I choose: ide_error(...)
-		 */
-		return DRIVER(drive)->error(drive, "flagged_task_out_intr (unexpected data phase)", stat);
-	}
-
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Write - rq->current_nr_sectors: %d, status: %02x\n",
-		(int) rq->current_nr_sectors, stat);
-
-	taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-	--rq->current_nr_sectors;
-
-	/*
-	 * (ks) We don't know which command was executed.
-	 * So, we wait the 'WORSTCASE' value.
-	 */
-	ide_set_handler(drive, &flagged_task_out_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}
-
-ide_startstop_t flagged_pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	char *pBuf		= NULL;
-	ide_startstop_t startstop;
-	unsigned int msect, nsect;
-
-	if (!rq->current_nr_sectors)
-		return DRIVER(drive)->error(drive, "flagged_pre_task_mulout_intr (write data not specified)", stat);
-
-	msect = drive->mult_count;
-	if (msect == 0)
-		return DRIVER(drive)->error(drive, "flagged_pre_task_mulout_intr (multimode not set)", stat);
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			BAD_W_STAT, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: No DRQ bit after issuing write command.\n", drive->name);
-		return startstop;
-	}
-
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-	    pBuf, nsect, rq->current_nr_sectors);
-
-	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-
-	rq->current_nr_sectors -= nsect;
-
-	return ide_started;
-}
-
-ide_startstop_t flagged_task_mulout_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-	unsigned int msect, nsect;
-
-	msect = drive->mult_count;
-	if (msect == 0)
-		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr (multimode not set)", stat);
-
-	if (!OK_STAT(stat, DRIVE_READY, BAD_W_STAT))
-		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr", stat);
-
-	if (!rq->current_nr_sectors) {
-		ide_end_drive_cmd (drive, stat, hwif->INB(IDE_ERROR_REG));
-		return ide_stopped;
-	}
-
-	if (!OK_STAT(stat, DATA_READY, BAD_W_STAT)) {
-		/*
-		 * (ks) Unexpected ATA data phase detected.
-		 * This should not happen. But, it can !
-		 * I am not sure, which function is best to clean up
-		 * this situation.  I choose: ide_error(...)
-		 */
-		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr (unexpected data phase)", stat);
-	}
-
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
-	    pBuf, nsect, rq->current_nr_sectors);
-
-	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-	rq->current_nr_sectors -= nsect;
-
-	/*
-	 * (ks) We don't know which command was executed.
-	 * So, we wait the 'WORSTCASE' value.
-	 */
-	ide_set_handler(drive, &flagged_task_mulout_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}
-
 /*
  * Beginning of Taskfile OPCODE Library and feature sets.
  */

