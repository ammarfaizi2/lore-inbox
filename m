Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUIHTmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUIHTmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUIHTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:40:24 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:14295 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269315AbUIHT2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:28:13 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][2/9] ide: unify taskfile single/multiple PIO code
Date: Wed, 8 Sep 2004 21:26:46 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082126.46361.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: unify taskfile single/multiple PIO code

Make the actual use of hwif->data_phase.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c     |    9 
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-taskfile.c |  155 ++++-----------
 linux-2.6.9-rc1-bk10-bzolnier/include/linux/ide.h        |    3 
 3 files changed, 53 insertions(+), 114 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_tf_multi_pio drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-disk.c~ide_tf_multi_pio	2004-09-05 19:47:57.977443888 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c	2004-09-05 19:47:58.000440392 +0200
@@ -496,27 +496,24 @@ static u8 get_command(ide_drive_t *drive
 		task->command_type = IDE_DRIVE_TASK_IN;
 		if (drive->using_dma)
 			return lba48 ? WIN_READDMA_EXT : WIN_READDMA;
+		task->handler = &task_in_intr;
 		if (drive->mult_count) {
 			task->data_phase = TASKFILE_MULTI_IN;
-			task->handler = &task_mulin_intr;
 			return lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
 		}
 		task->data_phase = TASKFILE_IN;
-		task->handler = &task_in_intr;
 		return lba48 ? WIN_READ_EXT : WIN_READ;
 	} else {
 		task->command_type = IDE_DRIVE_TASK_RAW_WRITE;
 		if (drive->using_dma)
 			return lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+		task->prehandler = &pre_task_out_intr;
+		task->handler = &task_out_intr;
 		if (drive->mult_count) {
 			task->data_phase = TASKFILE_MULTI_OUT;
-			task->prehandler = &pre_task_mulout_intr;
-			task->handler = &task_mulout_intr;
 			return lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
 		}
 		task->data_phase = TASKFILE_OUT;
-		task->prehandler = &pre_task_out_intr;
-		task->handler = &task_out_intr;
 		return lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 	}
 }
diff -puN drivers/ide/ide-taskfile.c~ide_tf_multi_pio drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-taskfile.c~ide_tf_multi_pio	2004-09-05 19:47:57.979443584 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-taskfile.c	2004-09-05 19:47:58.002440088 +0200
@@ -368,12 +368,44 @@ static u8 wait_drive_not_busy(ide_drive_
 	return stat;
 }
 
+static inline void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
+				     unsigned int write)
+{
+	switch (drive->hwif->data_phase) {
+	case TASKFILE_MULTI_IN:
+	case TASKFILE_MULTI_OUT:
+		task_multi_sectors(drive, rq, write);
+		break;
+	default:
+		task_sectors(drive, rq, 1, write);
+		break;
+	}
+}
+
 #ifdef CONFIG_IDE_TASKFILE_IO
 static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
-				  const char *s, u8 stat, unsigned cur_bad)
+				  const char *s, u8 stat)
 {
 	if (rq->bio) {
-		int sectors = rq->hard_nr_sectors - rq->nr_sectors - cur_bad;
+		int sectors = rq->hard_nr_sectors - rq->nr_sectors;
+
+		switch (drive->hwif->data_phase) {
+		case TASKFILE_IN:
+			if (rq->nr_sectors)
+				break;
+			/* fall through */
+		case TASKFILE_OUT:
+			sectors--;
+			break;
+		case TASKFILE_MULTI_IN:
+			if (rq->nr_sectors)
+				break;
+			/* fall through */
+		case TASKFILE_MULTI_OUT:
+			sectors -= drive->mult_count;
+		default:
+			break;
+		}
 
 		if (sectors > 0)
 			drive->driver->end_request(drive, 1, sectors);
@@ -381,7 +413,7 @@ static ide_startstop_t task_error(ide_dr
 	return drive->driver->error(drive, s, stat);
 }
 #else
-# define task_error(d, rq, s, stat, cur_bad) drive->driver->error(d, s, stat)
+# define task_error(d, rq, s, stat) drive->driver->error(d, s, stat)
 #endif
 
 static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
@@ -399,7 +431,7 @@ static void task_end_request(ide_drive_t
 }
 
 /*
- * Handler for command with PIO data-in phase (Read).
+ * Handler for command with PIO data-in phase (Read/Read Multiple).
  */
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
@@ -408,19 +440,19 @@ ide_startstop_t task_in_intr (ide_drive_
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
-			return task_error(drive, rq, __FUNCTION__, stat, 0);
+			return task_error(drive, rq, __FUNCTION__, stat);
 		/* No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
 
-	task_sectors(drive, rq, 1, IDE_PIO_IN);
+	ide_pio_datablock(drive, rq, 0);
 
 	/* If it was the last datablock check status and finish transfer. */
 	if (!rq->nr_sectors) {
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
-			return task_error(drive, rq, __FUNCTION__, stat, 1);
+			return task_error(drive, rq, __FUNCTION__, stat);
 		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
@@ -433,41 +465,7 @@ ide_startstop_t task_in_intr (ide_drive_
 EXPORT_SYMBOL(task_in_intr);
 
 /*
- * Handler for command with PIO data-in phase (Read Multiple).
- */
-ide_startstop_t task_mulin_intr (ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat = HWIF(drive)->INB(IDE_STATUS_REG);
-
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
-		if (stat & (ERR_STAT | DRQ_STAT))
-			return task_error(drive, rq, __FUNCTION__, stat, 0);
-		/* No data yet, so wait for another IRQ. */
-		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
-		return ide_started;
-	}
-
-	task_multi_sectors(drive, rq, IDE_PIO_IN);
-
-	/* If it was the last datablock check status and finish transfer. */
-	if (!rq->nr_sectors) {
-		stat = wait_drive_not_busy(drive);
-		if (!OK_STAT(stat, 0, BAD_R_STAT))
-			return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
-		task_end_request(drive, rq, stat);
-		return ide_stopped;
-	}
-
-	/* Still data left to transfer. */
-	ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}
-EXPORT_SYMBOL(task_mulin_intr);
-
-/*
- * Handler for command with PIO data-out phase (Write).
+ * Handler for command with PIO data-out phase (Write/Write Multiple).
  */
 ide_startstop_t task_out_intr (ide_drive_t *drive)
 {
@@ -476,11 +474,11 @@ ide_startstop_t task_out_intr (ide_drive
 
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
-		return task_error(drive, rq, __FUNCTION__, stat, 1);
+		return task_error(drive, rq, __FUNCTION__, stat);
 
 	/* Deal with unexpected ATA data phase. */
 	if (((stat & DRQ_STAT) == 0) ^ !rq->nr_sectors)
-		return task_error(drive, rq, __FUNCTION__, stat, 1);
+		return task_error(drive, rq, __FUNCTION__, stat);
 
 	if (!rq->nr_sectors) {
 		task_end_request(drive, rq, stat);
@@ -488,7 +486,7 @@ ide_startstop_t task_out_intr (ide_drive
 	}
 
 	/* Still data left to transfer. */
-	task_sectors(drive, rq, 1, IDE_PIO_OUT);
+	ide_pio_datablock(drive, rq, 1);
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 
 	return ide_started;
@@ -502,8 +500,10 @@ ide_startstop_t pre_task_out_intr (ide_d
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
 			  drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing WRITE%s\n",
-				drive->name, drive->addressing ? "_EXT" : "");
+		printk(KERN_ERR "%s: no DRQ after issuing %sWRITE%s\n",
+				drive->name,
+				drive->hwif->data_phase ? "MULT" : "",
+				drive->addressing ? "_EXT" : "");
 		return startstop;
 	}
 
@@ -511,62 +511,12 @@ ide_startstop_t pre_task_out_intr (ide_d
 		local_irq_disable();
 
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
-	task_sectors(drive, rq, 1, IDE_PIO_OUT);
+	ide_pio_datablock(drive, rq, 1);
 
 	return ide_started;
 }
 EXPORT_SYMBOL(pre_task_out_intr);
 
-/*
- * Handler for command with PIO data-out phase (Write Multiple).
- */
-ide_startstop_t task_mulout_intr (ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat;
-
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
-		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
-
-	/* Deal with unexpected ATA data phase. */
-	if (((stat & DRQ_STAT) == 0) ^ !rq->nr_sectors)
-		return task_error(drive, rq, __FUNCTION__, stat, drive->mult_count);
-
-	if (!rq->nr_sectors) {
-		task_end_request(drive, rq, stat);
-		return ide_stopped;
-	}
-
-	/* Still data left to transfer. */
-	task_multi_sectors(drive, rq, IDE_PIO_OUT);
-	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-
-	return ide_started;
-}
-EXPORT_SYMBOL(task_mulout_intr);
-
-ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
-{
-	ide_startstop_t startstop;
-
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
-			  drive->bad_wstat, WAIT_DRQ)) {
-		printk(KERN_ERR "%s: no DRQ after issuing MULTWRITE%s\n",
-				drive->name, drive->addressing ? "_EXT" : "");
-		return startstop;
-	}
-
-	if (!drive->unmask)
-		local_irq_disable();
-
-	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-	task_multi_sectors(drive, rq, IDE_PIO_OUT);
-
-	return ide_started;
-}
-EXPORT_SYMBOL(pre_task_mulout_intr);
-
 int ide_diag_taskfile (ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
 {
 	struct request rq;
@@ -711,10 +661,7 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 				err = -EPERM;
 				goto abort;
 			}
-			args.prehandler = &pre_task_mulout_intr;
-			args.handler = &task_mulout_intr;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
-			break;
+			/* fall through */
 		case TASKFILE_OUT:
 			args.prehandler = &pre_task_out_intr;
 			args.handler = &task_out_intr;
@@ -729,9 +676,7 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 				err = -EPERM;
 				goto abort;
 			}
-			args.handler = &task_mulin_intr;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
-			break;
+			/* fall through */
 		case TASKFILE_IN:
 			args.handler = &task_in_intr;
 			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
diff -puN include/linux/ide.h~ide_tf_multi_pio include/linux/ide.h
--- linux-2.6.9-rc1-bk10/include/linux/ide.h~ide_tf_multi_pio	2004-09-05 19:47:57.981443280 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/include/linux/ide.h	2004-09-05 19:47:58.004439784 +0200
@@ -1455,11 +1455,8 @@ extern ide_startstop_t set_geometry_intr
 extern ide_startstop_t recal_intr(ide_drive_t *);
 extern ide_startstop_t task_no_data_intr(ide_drive_t *);
 extern ide_startstop_t task_in_intr(ide_drive_t *);
-extern ide_startstop_t task_mulin_intr(ide_drive_t *);
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
 extern ide_startstop_t task_out_intr(ide_drive_t *);
-extern ide_startstop_t pre_task_mulout_intr(ide_drive_t *, struct request *);
-extern ide_startstop_t task_mulout_intr(ide_drive_t *);
 
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
 
_
