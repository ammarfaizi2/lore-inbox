Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVBBDLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVBBDLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVBBDLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:11:00 -0500
Received: from [211.58.254.17] ([211.58.254.17]:395 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262259AbVBBDGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:06:13 -0500
Date: Wed, 2 Feb 2005 12:06:03 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 21/29] ide: Merge do_rw_taskfile() and flagged_taskfile().
Message-ID: <20050202030603.GF1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 21_ide_do_taskfile.patch
> 
> 	Merged do_rw_taskfile() and flagged_taskfile() into
> 	do_taskfile().  During the merge, the following changes took
> 	place.
> 	1. flagged taskfile now honors HOB feature register.
> 	   (do_rw_taskfile() did write to HOB feature.)
> 	2. No do_rw_taskfile() HIHI check on select register.  Except
> 	   for the DEV bit, all bits are honored.
> 	3. Uses taskfile->data_phase to determine if dma trasfer is
> 	   requested.  (do_rw_taskfile() directly switched on
> 	   taskfile->command for all dma commands)


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:28:04.080383536 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:06.272027942 +0900
@@ -535,7 +535,7 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &set_geometry_intr;
-			do_rw_taskfile(drive, &args);
+			do_taskfile(drive, &args);
 		}
 	} else if (s->b.recalibrate) {
 		s->b.recalibrate = 0;
@@ -546,7 +546,7 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &recal_intr;
-			do_rw_taskfile(drive, &args);
+			do_taskfile(drive, &args);
 		}
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
@@ -559,7 +559,7 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &set_multmode_intr;
-			do_rw_taskfile(drive, &args);
+			do_taskfile(drive, &args);
 		}
 	} else if (s->all) {
 		int special = s->all;
@@ -905,19 +905,19 @@ static ide_startstop_t idedisk_start_pow
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		return do_taskfile(drive, args);
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		return do_taskfile(drive, args);
 
 	case idedisk_pm_idle:		/* Resume step 1 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler = task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		return do_taskfile(drive, args);
 
 	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
 		/*
Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:04.904249864 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:06.273027780 +0900
@@ -756,9 +756,7 @@ static ide_startstop_t execute_drive_cmd
 			break;
 		}
 
-		if (args->tf_out_flags.all != 0) 
-			return flagged_taskfile(drive, args);
-		return do_rw_taskfile(drive, args);
+		return do_taskfile(drive, args);
 	} else if (rq->flags & REQ_DRIVE_TASK) {
 		u8 *args = rq->buffer;
 		u8 sel;
Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:06.035066389 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:06.273027780 +0900
@@ -96,35 +96,92 @@ int taskfile_lib_get_identify (ide_drive
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
-ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
+ide_startstop_t do_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
 
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
+	if (task->data_phase == TASKFILE_MULTI_IN ||
+	    task->data_phase == TASKFILE_MULTI_OUT) {
+		if (!drive->mult_count) {
+			printk(KERN_ERR "%s: multimode not set!\n", drive->name);
+			return ide_stopped;
+		}
+	}
+
+	/*
+	 * (ks) Check taskfile in/out flags.
+	 * If set, then execute as it is defined.
+	 * If not set, then define default settings.
+	 * The default values are:
+	 *	write and read all taskfile registers (except data) 
+	 *	write and read the hob registers (sector,nsector,lcyl,hcyl)
+	 */
+	if (task->tf_out_flags.all == 0) {
+		task->tf_out_flags.h.taskfile = IDE_TASKFILE_STD_OUT_FLAGS;
+		if (drive->addressing == 1)
+			task->tf_out_flags.h.hob = IDE_HOB_STD_OUT_FLAGS;
+        }
+
+	if (task->tf_in_flags.all == 0) {
+		task->tf_in_flags.h.taskfile = IDE_TASKFILE_STD_IN_FLAGS;
+		if (drive->addressing == 1)
+			task->tf_in_flags.h.hob = IDE_HOB_STD_IN_FLAGS;
+        }
+
+	/* ALL Command Block Executions SHALL clear nIEN, unless
+	 * otherwise specified.*/
 	if (IDE_CONTROL_REG) {
 		/* clear nIEN */
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	}
 	SELECT_MASK(drive, 0);
 
+	if (task->tf_out_flags.b.data) {
+		u16 data =  taskfile->data + (hobfile->data << 8);
+		/* We want hobfile->data to go to the upper address,
+		   so the cpu_to_le16(). - tj */
+		hwif->OUTW(cpu_to_le16(data), IDE_DATA_REG);
+	}
+
 	if (drive->addressing == 1) {
-		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		/* (ks) send hob registers first */
+		if (task->tf_out_flags.b.error_feature)
+			hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
+		if (task->tf_out_flags.b.nsector_hob)
+			hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
+		if (task->tf_out_flags.b.sector_hob)
+			hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
+		if (task->tf_out_flags.b.lcyl_hob)
+			hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
+		if (task->tf_out_flags.b.hcyl_hob)
+			hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
 	}
 
-	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+	/* (ks) Send now the standard registers */
+	if (task->tf_out_flags.b.error_feature)
+		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
+	if (task->tf_out_flags.b.nsector)
+		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
+	if (task->tf_out_flags.b.sector)
+		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
+	if (task->tf_out_flags.b.lcyl)
+		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
+	if (task->tf_out_flags.b.hcyl)
+		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
 
-	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+        /*
+	 * (ks) In the taskfile approch, we will use all specified
+	 * registers and the register value will not be changed, except
+	 * the select bit (master/slave) in the drive_head register.
+	 * We must make sure that the desired drive is selected.
+	 */
+	if (task->tf_out_flags.b.select)
+		hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
+			   IDE_SELECT_REG);
+	else
+		hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
@@ -136,32 +193,23 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		return ide_started;
 	}
 
-	if (!drive->using_dma)
+	switch (task->data_phase) {
+	case TASKFILE_OUT_DMAQ:
+	case TASKFILE_OUT_DMA:
+	case TASKFILE_IN_DMAQ:
+	case TASKFILE_IN_DMA:
+		if (!hwif->dma_setup(drive)) {
+			hwif->dma_exec_cmd(drive, taskfile->command);
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
 
-EXPORT_SYMBOL(do_rw_taskfile);
+EXPORT_SYMBOL(do_taskfile);
 
 /*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
@@ -757,131 +805,3 @@ int ide_task_ioctl (ide_drive_t *drive, 
 		err = -EFAULT;
 	return err;
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
-	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
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
-	/*
-	 * (ks) Check taskfile in/out flags.
-	 * If set, then execute as it is defined.
-	 * If not set, then define default settings.
-	 * The default values are:
-	 *	write and read all taskfile registers (except data) 
-	 *	write and read the hob registers (sector,nsector,lcyl,hcyl)
-	 */
-	if (task->tf_out_flags.all == 0) {
-		task->tf_out_flags.h.taskfile = IDE_TASKFILE_STD_OUT_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_out_flags.h.hob = IDE_HOB_STD_OUT_FLAGS;
-        }
-
-	if (task->tf_in_flags.all == 0) {
-		task->tf_in_flags.h.taskfile = IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_in_flags.h.hob = IDE_HOB_STD_IN_FLAGS;
-        }
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
-	if (task->tf_out_flags.b.data) {
-		u16 data =  taskfile->data + (hobfile->data << 8);
-		/* We want hobfile->data to go to the upper address,
-		   so the cpu_to_le16(). - tj */
-		hwif->OUTW(cpu_to_le16(data), IDE_DATA_REG);
-	}
-
-	/* (ks) send hob registers first */
-	if (task->tf_out_flags.b.nsector_hob)
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-	if (task->tf_out_flags.b.sector_hob)
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl_hob)
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl_hob)
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
-
-	/* (ks) Send now the standard registers */
-	if (task->tf_out_flags.b.error_feature)
-		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	/* refers to number of sectors to transfer */
-	if (task->tf_out_flags.b.nsector)
-		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	/* refers to sector offset or start sector */
-	if (task->tf_out_flags.b.sector)
-		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl)
-		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl)
-		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
-
-        /*
-	 * (ks) In the flagged taskfile approch, we will use all specified
-	 * registers and the register value will not be changed, except the
-	 * select bit (master/slave) in the drive_head register. We must make
-	 * sure that the desired drive is selected.
-	 */
-	if (task->tf_out_flags.b.select)
-		hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
-			   IDE_SELECT_REG);
-	else
-		hwif->OUTB(drive->select.all, IDE_SELECT_REG);
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
Index: linux-ide-export/include/linux/ide.h
===================================================================
--- linux-ide-export.orig/include/linux/ide.h	2005-02-02 10:28:06.036066227 +0900
+++ linux-ide-export/include/linux/ide.h	2005-02-02 10:28:06.274027617 +0900
@@ -1067,7 +1067,7 @@ static inline void destroy_proc_ide_inte
  *	- ide_started :	In this case, the channel is left busy until an
  *			async event (interrupt) occurs.
  * Typically, start_power_step() will issue a taskfile request with
- * do_rw_taskfile().
+ * do_taskfile().
  *
  * Upon reception of the interrupt, the core will call complete_power_step()
  * with the error code if any. This routine should update the step value
@@ -1311,12 +1311,7 @@ extern int wait_for_ready(ide_drive_t *,
 /*
  * taskfile io for disks for now...and builds request from ide_ioctl
  */
-extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
-
-/*
- * Special Flagged Register Validation Caller
- */
-extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
+extern ide_startstop_t do_taskfile(ide_drive_t *, ide_task_t *);
 
 extern void task_end_request(ide_drive_t *, struct request *, u8);
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
