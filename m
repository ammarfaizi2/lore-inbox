Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266702AbUF3PdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266702AbUF3PdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266722AbUF3P1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:27:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266703AbUF3PZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:25 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [8/9]
Date: Wed, 30 Jun 2004 17:26:35 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301726.35347.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: merge CONFIG_IDE_TASKFILE_IO=y|n PIO handlers together

This fixes a couple of CONFIG_IDE_TASKFILE_IO=n issues:
- check status after last sector for PIO-in transfers
- handle drive->unmask properly in PIO-out prehandlers
- use rq->[hard]_nr_sectors where appropriate

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |  195 +------------------
 1 files changed, 15 insertions(+), 180 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_non_tf_pio drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_non_tf_pio	2004-06-28 21:28:49.993246064 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:28:49.999245152 +0200
@@ -303,176 +303,7 @@ static inline void task_buffer_multi_sec
 	task_buffer_sectors(drive, rq, nsect, rw);
 }
 
-/*
- * old taskfile PIO handlers, to be killed as soon as possible.
- */
-#ifndef CONFIG_IDE_TASKFILE_IO
-
-/*
- * Handler for command with PIO data-in phase, READ
- */
-ide_startstop_t task_in_intr (ide_drive_t *drive)
-{
-	struct request *rq	= HWGROUP(drive)->rq;
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat;
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "task_in_intr", stat);
-		}
-		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-
-	task_buffer_sectors(drive, rq, 1, IDE_PIO_IN);
-
-	/* FIXME: check drive status */
-	if (!rq->current_nr_sectors)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
-	ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
-	return ide_started;
-}
-
-EXPORT_SYMBOL(task_in_intr);
-
-/*
- * Handler for command with Read Multiple
- */
-ide_startstop_t task_mulin_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	u8 stat;
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return DRIVER(drive)->error(drive, "task_mulin_intr", stat);
-		}
-		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-
-	task_buffer_multi_sectors(drive, rq, IDE_PIO_IN);
-
-	/* FIXME: check drive status */
-	if (!rq->current_nr_sectors) {
-		DRIVER(drive)->end_request(drive, 1, 0);
-		return ide_stopped;
-	}
-
-	ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
-	return ide_started;
-}
-
-EXPORT_SYMBOL(task_mulin_intr);
-
-ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
-{
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing WRITE%s\n",
-			drive->name,
-			drive->addressing ? "_EXT" : "");
-		return startstop;
-	}
-	/* For Write_sectors we need to stuff the first sector */
-	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
-	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
-
-	return ide_started;
-}
-
-EXPORT_SYMBOL(pre_task_out_intr);
-
-/*
- * Handler for command with PIO data-out phase WRITE
- *
- * WOOHOO this is a CORRECT STATE DIAGRAM NOW, <andre@linux-ide.org>
- */
-ide_startstop_t task_out_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= HWGROUP(drive)->rq;
-	u8 stat;
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY, drive->bad_wstat)) {
-		return DRIVER(drive)->error(drive, "task_out_intr", stat);
-	}
-
-	if (((stat & DRQ_STAT) == 0) ^ !rq->current_nr_sectors)
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-
-	/*
-	 * Safe to update request for partial completions.
-	 * We have a good STATUS CHECK!!!
-	 */
-	if (!rq->current_nr_sectors)
-		if (!DRIVER(drive)->end_request(drive, 1, 0))
-			return ide_stopped;
-
-	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
-	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
-	return ide_started;
-}
-
-EXPORT_SYMBOL(task_out_intr);
-
-ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
-{
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing %s\n",
-			drive->name,
-			drive->addressing ? "MULTWRITE_EXT" : "MULTWRITE");
-		return startstop;
-	}
-
-	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
-
-	return ide_started;
-}
-
-EXPORT_SYMBOL(pre_task_mulout_intr);
-
-/*
- * Handler for command write multiple
- */
-ide_startstop_t task_mulout_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif		= HWIF(drive);
-	u8 stat				= hwif->INB(IDE_STATUS_REG);
-	struct request *rq		= HWGROUP(drive)->rq;
-
-	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-
-	if (((stat & DRQ_STAT) == 0) ^ !rq->current_nr_sectors)
-		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-
-	/* Handle last IRQ, occurs after all data was sent. */
-	if (!rq->current_nr_sectors) {
-		DRIVER(drive)->end_request(drive, 1, 0);
-		return ide_stopped;
-	}
-
-	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
-	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}
-
-EXPORT_SYMBOL(task_mulout_intr);
-
-#else /* !CONFIG_IDE_TASKFILE_IO */
-
+#ifdef CONFIG_IDE_TASKFILE_IO
 static void task_sectors(ide_drive_t *drive, struct request *rq,
 			 unsigned nsect, unsigned rw)
 {
@@ -511,6 +342,10 @@ static void task_multi_sectors(ide_drive
 	} else		/* task request */
 		task_buffer_multi_sectors(drive, rq, rw);
 }
+#else
+# define task_sectors(d, rq, nsect, rw)	task_buffer_sectors(d, rq, nsect, rw)
+# define task_multi_sectors(d, rq, rw)	task_buffer_multi_sectors(d, rq, rw)
+#endif /* CONFIG_IDE_TASKFILE_IO */
 
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
@@ -532,6 +367,7 @@ static u8 wait_drive_not_busy(ide_drive_
 	return stat;
 }
 
+#ifdef CONFIG_IDE_TASKFILE_IO
 static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
 				  const char *s, u8 stat, unsigned cur_bad)
 {
@@ -543,6 +379,9 @@ static ide_startstop_t task_error(ide_dr
 	}
 	return drive->driver->error(drive, s, stat);
 }
+#else
+# define task_error(d, rq, s, stat, cur_bad) drive->driver->error(d, s, stat)
+#endif
 
 /*
  * Handler for command with PIO data-in phase (Read).
@@ -555,7 +394,7 @@ ide_startstop_t task_in_intr (ide_drive_
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat, 0);
-		/* BUSY_STAT: No data yet, so wait for another IRQ. */
+		/* No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
@@ -589,7 +428,7 @@ ide_startstop_t task_mulin_intr (ide_dri
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat, 0);
-		/* BUSY_STAT: No data yet, so wait for another IRQ. */
+		/* No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
@@ -625,8 +464,7 @@ ide_startstop_t task_out_intr (ide_drive
 		return task_error(drive, rq, __FUNCTION__, stat, 1);
 
 	/* Deal with unexpected ATA data phase. */
-	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
-	    ((stat & DATA_READY) && !rq->nr_sectors))
+	if (((stat & DRQ_STAT) == 0) ^ !rq->nr_sectors)
 		return task_error(drive, rq, __FUNCTION__, stat, 1);
 
 	if (!rq->nr_sectors) {
@@ -635,8 +473,8 @@ ide_startstop_t task_out_intr (ide_drive
 	}
 
 	/* Still data left to transfer. */
-	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 	task_sectors(drive, rq, 1, IDE_PIO_OUT);
+	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 
 	return ide_started;
 }
@@ -677,8 +515,7 @@ ide_startstop_t task_mulout_intr (ide_dr
 		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
 
 	/* Deal with unexpected ATA data phase. */
-	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
-	    ((stat & DATA_READY) && !rq->nr_sectors))
+	if (((stat & DRQ_STAT) == 0) ^ !rq->nr_sectors)
 		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
 
 	if (!rq->nr_sectors) {
@@ -687,8 +524,8 @@ ide_startstop_t task_mulout_intr (ide_dr
 	}
 
 	/* Still data left to transfer. */
-	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
 	task_multi_sectors(drive, rq, IDE_PIO_OUT);
+	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
 
 	return ide_started;
 }
@@ -715,8 +552,6 @@ ide_startstop_t pre_task_mulout_intr (id
 }
 EXPORT_SYMBOL(pre_task_mulout_intr);
 
-#endif /* !CONFIG_IDE_TASKFILE_IO */
-
 int ide_diag_taskfile (ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
 {
 	struct request rq;

_

