Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUFSQVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUFSQVB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUFSQUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:20:46 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264304AbUFSQQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:16:00 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [11/11]
Date: Sat, 19 Jun 2004 18:15:06 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191815.06060.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: PIO-out setup fixes (CONFIG_IDE_TASKFILE_IO=n)

- setup hwgroup->handler/timer in ->prehandler() (after checking
  drive status) and in do_rw_taskfile() only send a command
- make pre_task_mulout_intr() transfer first datablock itself
  instead of calling ->handler() so we don't have to play tricks
  with hwgroup->handler/timer in task_mulout_intr()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   39 ++++++------------------
 1 files changed, 10 insertions(+), 29 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_handler drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_pio_out_handler	2004-06-19 03:13:11.956953632 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 03:18:09.543713568 +0200
@@ -159,7 +159,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
 
 	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
-#ifdef CONFIG_IDE_TASKFILE_IO
+
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
 			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
@@ -169,14 +169,6 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-#else
-	if (task->handler != NULL) {
-		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
-		if (task->prehandler != NULL)
-			return task->prehandler(drive, task->rq);
-		return ide_started;
-	}
-#endif
 
 	if (!drive->using_dma)
 		return ide_stopped;
@@ -395,7 +387,9 @@ ide_startstop_t pre_task_out_intr (ide_d
 		return startstop;
 	}
 	/* For Write_sectors we need to stuff the first sector */
+	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
+
 	return ide_started;
 }
 
@@ -433,7 +427,6 @@ EXPORT_SYMBOL(task_out_intr);
 
 ide_startstop_t pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
 {
-	ide_task_t *args = rq->special;
 	ide_startstop_t startstop;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
@@ -451,19 +444,16 @@ ide_startstop_t pre_task_mulout_intr (id
 		}
 	}
 
-	/*
-	 * WARNING :: if the drive as not acked good status we may not
-	 * move the DATA-TRANSFER T-Bar as BSY != 0. <andre@linux-ide.org>
-	 */
-	return args->handler(drive);
+	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
+
+	return ide_started;
 }
 
 EXPORT_SYMBOL(pre_task_mulout_intr);
 
 /*
  * Handler for command write multiple
- * Called directly from execute_drive_cmd for the first bunch of sectors,
- * afterwards only by the ISR
  */
 ide_startstop_t task_mulout_intr (ide_drive_t *drive)
 {
@@ -481,22 +471,13 @@ ide_startstop_t task_mulout_intr (ide_dr
 			return ide_stopped;
 		}
 		/* no data yet, so wait for another interrupt */
-		if (HWGROUP(drive)->handler == NULL)
-			ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+		ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
 
-	if (HWGROUP(drive)->handler != NULL) {
-		unsigned long lflags;
-		spin_lock_irqsave(&ide_lock, lflags);
-		HWGROUP(drive)->handler = NULL;
-		del_timer(&HWGROUP(drive)->timer);
-		spin_unlock_irqrestore(&ide_lock, lflags);
-	}
-
 	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+
 	return ide_started;
 }
 

_

