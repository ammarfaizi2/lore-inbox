Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUIHT1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUIHT1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269317AbUIHT1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:27:34 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:11991 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269277AbUIHT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:27:21 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][1/9] ide: add ide_hwif_t->data_phase
Date: Wed, 8 Sep 2004 21:26:28 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082126.28262.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: add ide_hwif_t->data_phase

Use it for taskfile requests (only PIO/DMA for now) for storing
ide_task_t->data_phase of the active command.

Also add some missing task->data_phase assignments.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c     |    9 +++++++++
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-io.c       |    4 +++-
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-taskfile.c |    1 +
 linux-2.6.9-rc1-bk10-bzolnier/include/linux/ide.h        |    3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff -puN drivers/ide/ide-disk.c~ide_data_phase drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-disk.c~ide_data_phase	2004-09-05 19:46:25.905440960 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c	2004-09-05 19:46:25.921438528 +0200
@@ -497,9 +497,11 @@ static u8 get_command(ide_drive_t *drive
 		if (drive->using_dma)
 			return lba48 ? WIN_READDMA_EXT : WIN_READDMA;
 		if (drive->mult_count) {
+			task->data_phase = TASKFILE_MULTI_IN;
 			task->handler = &task_mulin_intr;
 			return lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
 		}
+		task->data_phase = TASKFILE_IN;
 		task->handler = &task_in_intr;
 		return lba48 ? WIN_READ_EXT : WIN_READ;
 	} else {
@@ -507,10 +509,12 @@ static u8 get_command(ide_drive_t *drive
 		if (drive->using_dma)
 			return lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 		if (drive->mult_count) {
+			task->data_phase = TASKFILE_MULTI_OUT;
 			task->prehandler = &pre_task_mulout_intr;
 			task->handler = &task_mulout_intr;
 			return lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
 		}
+		task->data_phase = TASKFILE_OUT;
 		task->prehandler = &pre_task_out_intr;
 		task->handler = &task_out_intr;
 		return lba48 ? WIN_WRITE_EXT : WIN_WRITE;
@@ -544,6 +548,7 @@ static ide_startstop_t chs_rw_disk (ide_
 	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq_data_dir(rq), &args);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
+	drive->hwif->data_phase = args.data_phase;
 	return do_rw_taskfile(drive, &args);
 }
 
@@ -568,6 +573,7 @@ static ide_startstop_t lba_28_rw_disk (i
 	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq_data_dir(rq), &args);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
+	drive->hwif->data_phase = args.data_phase;
 	return do_rw_taskfile(drive, &args);
 }
 
@@ -603,6 +609,7 @@ static ide_startstop_t lba_48_rw_disk (i
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
+	drive->hwif->data_phase = args.data_phase;
 	return do_rw_taskfile(drive, &args);
 }
 
@@ -1148,6 +1155,7 @@ static int get_smart_values(ide_drive_t 
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
+	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf);
@@ -1163,6 +1171,7 @@ static int get_smart_thresholds(ide_driv
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
+	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf);
diff -puN drivers/ide/ide-io.c~ide_data_phase drivers/ide/ide-io.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-io.c~ide_data_phase	2004-09-05 19:46:25.907440656 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-io.c	2004-09-05 19:46:25.924438072 +0200
@@ -692,7 +692,9 @@ ide_startstop_t execute_drive_cmd (ide_d
  
 		if (!args)
 			goto done;
- 
+
+		hwif->data_phase = args->data_phase;
+
 		if (args->tf_out_flags.all != 0) 
 			return flagged_taskfile(drive, args);
 		return do_rw_taskfile(drive, args);
diff -puN drivers/ide/ide-taskfile.c~ide_data_phase drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-taskfile.c~ide_data_phase	2004-09-05 19:46:25.909440352 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-taskfile.c	2004-09-05 19:46:25.925437920 +0200
@@ -96,6 +96,7 @@ int taskfile_lib_get_identify (ide_drive
 	else
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_PIDENTIFY;
 	args.command_type = IDE_DRIVE_TASK_IN;
+	args.data_phase   = TASKFILE_IN;
 	args.handler	  = &task_in_intr;
 	return ide_raw_taskfile(drive, &args, buf);
 }
diff -puN include/linux/ide.h~ide_data_phase include/linux/ide.h
--- linux-2.6.9-rc1-bk10/include/linux/ide.h~ide_data_phase	2004-09-05 19:46:25.911440048 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/include/linux/ide.h	2004-09-05 19:46:25.927437616 +0200
@@ -963,6 +963,9 @@ typedef struct hwif_s {
 	int sg_dma_direction;		/* dma transfer direction */
 	int sg_dma_active;		/* is it in use */
 
+	/* data phase of the active command (currently only valid for PIO/DMA) */
+	int		data_phase;
+
 	int		mmio;		/* hosts iomio (0) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
_
