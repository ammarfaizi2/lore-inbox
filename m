Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVBFLaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVBFLaj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVBFLaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:30:20 -0500
Received: from [211.58.254.17] ([211.58.254.17]:60862 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261198AbVBFL07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:26:59 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 04/04] ide: merge flagged_taskfile() into do_rw_taskfile()
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <20050206112628.GA31274@htj.dyndns.org>
References: <20050206112628.GA31274@htj.dyndns.org>
Message-Id: <20050206112656.65BBF13264B@htj.dyndns.org>
Date: Sun,  6 Feb 2005 20:26:56 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04_ide_merge_rw_and_flagged_taskfile.patch

	Merged flagged_taskfile() into do_rw_taskfile().  During the
	merge, the following change took place.
	- Uses taskfile->data_phase to determine if dma trasfer is
	  requested.  (previously, do_rw_taskfile() directly switched
	  on taskfile->command for all dma commands)


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series3-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-io.c	2005-02-06 19:49:19.496897703 +0900
+++ linux-ide-series3-export/drivers/ide/ide-io.c	2005-02-06 19:49:19.839841988 +0900
@@ -657,8 +657,6 @@ static ide_startstop_t execute_drive_tas
 		break;
 	}
 
-	if (args->tf_out_flags.all != 0) 
-		return flagged_taskfile(drive, args);
 	return do_rw_taskfile(drive, args);
 }
 
Index: linux-ide-series3-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-taskfile.c	2005-02-06 19:49:19.493898191 +0900
+++ linux-ide-series3-export/drivers/ide/ide-taskfile.c	2005-02-06 19:49:19.840841826 +0900
@@ -215,53 +215,57 @@ void ide_read_taskfile(ide_drive_t *driv
 	tf->command		= stat;
 }
 
-ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
+ide_startstop_t do_rw_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned long *ports = drive->hwif->io_ports;
+	task_struct_t *tf = (task_struct_t *)task->tfRegister;
 
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG) {
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	/* We check this in ide_taskfile_ioctl(), but the setting could
+	   have been changed inbetween. */
+	if (task->data_phase == TASKFILE_MULTI_IN ||
+	    task->data_phase == TASKFILE_MULTI_OUT) {
+		if (!drive->mult_count) {
+			printk(KERN_ERR "%s: multimode not set!\n",
+			       drive->name);
+			/* FIXME: this path is an infnite loop. - tj */
+			return ide_stopped;
+		}
 	}
+
+	/* ALL Command Block Executions SHALL clear nIEN. */
+	if (ports[IDE_CONTROL_OFFSET])
+		hwif->OUTB(drive->ctl, ports[IDE_CONTROL_OFFSET]);
 	SELECT_MASK(drive, 0);
 
 	ide_write_taskfile(drive, task);
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
-			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+			hwif->OUTBSYNC(drive, tf->command,
+				       ports[IDE_COMMAND_OFFSET]);
 			ndelay(400);	/* FIXME */
 			return task->prehandler(drive, task->rq);
 		}
-		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
+		ide_execute_command(drive, tf->command, task->handler,
+				    WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
 
-	if (!drive->using_dma)
+	switch (task->data_phase) {
+	case TASKFILE_OUT_DMAQ:
+	case TASKFILE_OUT_DMA:
+	case TASKFILE_IN_DMAQ:
+	case TASKFILE_IN_DMA:
+		if (!hwif->dma_setup(drive)) {
+			hwif->dma_exec_cmd(drive, tf->command);
+			hwif->dma_start(drive);
+			return ide_started;
+		}
+		return ide_stopped;
+	default:
 		return ide_stopped;
-
-	switch (taskfile->command) {
-		case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA:
-		case WIN_WRITEDMA_EXT:
-		case WIN_READDMA_ONCE:
-		case WIN_READDMA:
-		case WIN_READDMA_EXT:
-		case WIN_IDENTIFY_DMA:
-			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
-				hwif->dma_start(drive);
-				return ide_started;
-			}
-			break;
-		default:
-			if (task->handler == NULL)
-				return ide_stopped;
 	}
-
-	return ide_stopped;
 }
 
 EXPORT_SYMBOL(do_rw_taskfile);
@@ -892,69 +896,3 @@ int ide_task_ioctl(ide_drive_t *drive, u
 
 	return ret;
 }
-
-/*
- * NOTICE: This is additions from IBM to provide a discrete interface,
- * for selective taskregister access operations.  Nice JOB Klaus!!!
- * Glad to be able to work and co-develop this with you and IBM.
- */
-ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
-#if DEBUG_TASKFILE
-	u8 status;
-#endif
-
-	if (task->data_phase == TASKFILE_MULTI_IN ||
-	    task->data_phase == TASKFILE_MULTI_OUT) {
-		if (!drive->mult_count) {
-			printk(KERN_ERR "%s: multimode not set!\n", drive->name);
-			return ide_stopped;
-		}
-	}
-
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG)
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	SELECT_MASK(drive, 0);
-
-#if DEBUG_TASKFILE
-	status = hwif->INB(IDE_STATUS_REG);
-	if (status & 0x80) {
-		printk("flagged_taskfile -> Bad status. Status = %02x. wait 100 usec ...\n", status);
-		udelay(100);
-		status = hwif->INB(IDE_STATUS_REG);
-		printk("flagged_taskfile -> Status = %02x\n", status);
-	}
-#endif
-
-	ide_write_taskfile(drive, task);
-
-	switch(task->data_phase) {
-
-   	        case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			hwif->dma_setup(drive);
-			hwif->dma_exec_cmd(drive, taskfile->command);
-			hwif->dma_start(drive);
-			break;
-
-	        default:
- 			if (task->handler == NULL)
-				return ide_stopped;
-
-			/* Issue the command */
-			if (task->prehandler) {
-				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
-				ndelay(400);	/* FIXME */
-				return task->prehandler(drive, task->rq);
-			}
-			ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
-	}
-
-	return ide_started;
-}
Index: linux-ide-series3-export/include/linux/ide.h
===================================================================
--- linux-ide-series3-export.orig/include/linux/ide.h	2005-02-06 19:49:19.495897866 +0900
+++ linux-ide-series3-export/include/linux/ide.h	2005-02-06 19:49:19.841841663 +0900
@@ -1303,11 +1303,6 @@ void ide_read_taskfile(ide_drive_t *driv
  */
 extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
-/*
- * Special Flagged Register Validation Caller
- */
-extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
-
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
 extern ide_startstop_t recal_intr(ide_drive_t *);
