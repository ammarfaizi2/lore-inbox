Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266701AbUF3PdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266701AbUF3PdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266734AbUF3PcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:32:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266714AbUF3PZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [9/9]
Date: Wed, 30 Jun 2004 17:26:52 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301726.52076.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: use "normal" handlers for "flagged" taskfiles (ide-taskfile.c)

This fixes following issues for PIO-in:
- shared PCI IRQs handling
- fail request if the last status is bad
and PIO-out:
- set hwgroup->handler/timer in prehandlers
- handle drive->unmask in prehandlers
- check for !rq->nr_sectors and DRQ_STAT bit set
- use drive->bad_wstat instead of BAD_W_STAT

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |  286 +------------------
 1 files changed, 30 insertions(+), 256 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_no_flagged_pio drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_no_flagged_pio	2004-06-28 21:30:00.484529760 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:30:00.492528544 +0200
@@ -383,6 +383,20 @@ static ide_startstop_t task_error(ide_dr
 # define task_error(d, rq, s, stat, cur_bad) drive->driver->error(d, s, stat)
 #endif
 
+static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
+{
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
+		ide_task_t *task = rq->special;
+
+		if (task->tf_out_flags.all) {
+			u8 err = drive->hwif->INB(IDE_ERROR_REG);
+			ide_end_drive_cmd(drive, stat, err);
+			return;
+		}
+	}
+	drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+}
+
 /*
  * Handler for command with PIO data-in phase (Read).
  */
@@ -406,7 +420,7 @@ ide_startstop_t task_in_intr (ide_drive_
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat, 1);
-		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
 
@@ -440,7 +454,7 @@ ide_startstop_t task_mulin_intr (ide_dri
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
-		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
 
@@ -468,7 +482,7 @@ ide_startstop_t task_out_intr (ide_drive
 		return task_error(drive, rq, __FUNCTION__, stat, 1);
 
 	if (!rq->nr_sectors) {
-		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
 
@@ -519,7 +533,7 @@ ide_startstop_t task_mulout_intr (ide_dr
 		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
 
 	if (!rq->nr_sectors) {
-		drive->driver->end_request(drive, 1, rq->hard_nr_sectors);
+		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
 
@@ -598,13 +612,6 @@ EXPORT_SYMBOL(ide_raw_taskfile);
 #define MAX_DMA		(256*SECTOR_WORDS)
 
 ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
-ide_startstop_t flagged_task_no_data_intr(ide_drive_t *);
-ide_startstop_t flagged_task_in_intr(ide_drive_t *);
-ide_startstop_t flagged_task_mulin_intr(ide_drive_t *);
-ide_startstop_t flagged_pre_task_out_intr(ide_drive_t *, struct request *);
-ide_startstop_t flagged_task_out_intr(ide_drive_t *);
-ide_startstop_t flagged_pre_task_mulout_intr(ide_drive_t *, struct request *);
-ide_startstop_t flagged_task_mulout_intr(ide_drive_t *);
 
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
@@ -703,23 +710,13 @@ int ide_taskfile_ioctl (ide_drive_t *dri
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
@@ -731,27 +728,15 @@ int ide_taskfile_ioctl (ide_drive_t *dri
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
@@ -1024,226 +1009,15 @@ ide_startstop_t flagged_taskfile (ide_dr
 				return ide_stopped;
 
 			/* Issue the command */
+			if (task->prehandler) {
+				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+				ndelay(400);	/* FIXME */
+				return task->prehandler(drive, task->rq);
+			}
 			ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
-			if (task->prehandler != NULL)
-				return task->prehandler(drive, HWGROUP(drive)->rq);
 	}
 
 	return ide_started;
 }
 
 EXPORT_SYMBOL(flagged_taskfile);
-
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
-	int retries             = 5;
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
-	task_buffer_sectors(drive, rq, 1, IDE_PIO_IN);
-
-	if (rq->current_nr_sectors) {
-		/*
-                 * (ks) We don't know which command was executed. 
-		 * So, we wait the 'WORSTCASE' value.
-                 */
-		ide_set_handler(drive, &flagged_task_in_intr,  WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-	/*
-	 * (ks) Last sector was transfered, wait until drive is ready. 
-	 * This can take up to 10 usec. We willl wait max 50 us.
-	 */
-	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
-		udelay(10);
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
-	int retries             = 5;
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
-	task_buffer_multi_sectors(drive, rq, IDE_PIO_IN);
-
-	if (rq->current_nr_sectors != 0) {
-		/*
-                 * (ks) We don't know which command was executed. 
-		 * So, we wait the 'WORSTCASE' value.
-                 */
-		ide_set_handler(drive, &flagged_task_mulin_intr,  WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-
-	/*
-	 * (ks) Last sector was transfered, wait until drive is ready. 
-	 * This can take up to 10 usec. We willl wait max 50 us.
-	 */
-	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
-		udelay(10);
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
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			BAD_W_STAT, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: No DRQ bit after issuing write command.\n", drive->name);
-		return startstop;
-	}
-
-	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
-
-	return ide_started;
-}
-
-ide_startstop_t flagged_task_out_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	struct request *rq	= HWGROUP(drive)->rq;
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
-	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
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
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			BAD_W_STAT, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: No DRQ bit after issuing write command.\n", drive->name);
-		return startstop;
-	}
-
-	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
-
-	return ide_started;
-}
-
-ide_startstop_t flagged_task_mulout_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
-	struct request *rq	= HWGROUP(drive)->rq;
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
-	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
-
-	/*
-	 * (ks) We don't know which command was executed. 
-	 * So, we wait the 'WORSTCASE' value.
-	 */
-	ide_set_handler(drive, &flagged_task_mulout_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}

_

