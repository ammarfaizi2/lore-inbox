Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267884AbVBFCPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267884AbVBFCPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 21:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268176AbVBFCPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 21:15:42 -0500
Received: from [211.58.254.17] ([211.58.254.17]:48808 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S267884AbVBFCNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 21:13:35 -0500
Date: Sun, 6 Feb 2005 11:13:31 +0900
From: Tejun Heo <tj@home-tj.org>
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [PATCH 2.6.11-rc2] ide: merge do_rw_taskfile() and flagged_taskfile() into do_taskfile()
Message-ID: <20050206021331.GA25337@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

 This is a new version of ide_do_taskfile.patch.  Compared to the
original do_rw_task(), only one more 'if' is used in the hot path, so
I think the performance issue can be ignored now.  Also, there's no
userland visible change with this patch.  Everything should work just
as it did with do_rw_taskfile()/flagged_taskfile().

 do_taskfile() is different from do_rw_taskfile() in that

 - It uses task->data_phase to determine whether it's a DMA command
   or not.

 do_taskfile() is different from flagged_taskfile() in that

 - No (TASKFILE_MULTI_IN && !mult_count) check.  ide_taskfile_ioctl()
   checks the same thing, so it doesn't change anything.
 - No task->tf_out_flags handling.  ide_end_drive_cmd() ignores it
   anyway, so, again, it doesn't change anything.

 So, what do you think?


 Signed-off-by: Tejun Heo (tj@home-tj.org)


Index: linux-ide-series3-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-disk.c	2005-02-06 10:58:27.478337364 +0900
+++ linux-ide-series3-export/drivers/ide/ide-disk.c	2005-02-06 11:01:11.673688441 +0900
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
@@ -898,19 +898,19 @@ static ide_startstop_t idedisk_start_pow
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
Index: linux-ide-series3-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-io.c	2005-02-06 10:58:27.478337364 +0900
+++ linux-ide-series3-export/drivers/ide/ide-io.c	2005-02-06 11:01:11.675688117 +0900
@@ -682,9 +682,7 @@ static ide_startstop_t execute_drive_tas
 		break;
 	}
 
-	if (args->tf_out_flags.all != 0) 
-		return flagged_taskfile(drive, args);
-	return do_rw_taskfile(drive, args);
+	return do_taskfile(drive, args);
 }
 
 /**
Index: linux-ide-series3-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-taskfile.c	2005-02-06 10:58:27.479337202 +0900
+++ linux-ide-series3-export/drivers/ide/ide-taskfile.c	2005-02-06 11:01:11.676687955 +0900
@@ -96,35 +96,86 @@ int taskfile_lib_get_identify (ide_drive
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
-ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
+ide_startstop_t do_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
 
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG) {
-		/* clear nIEN */
+	/* ALL Command Block Executions SHALL clear nIEN, unless
+	 * otherwise specified.*/
+	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	}
 	SELECT_MASK(drive, 0);
 
-	if (drive->addressing == 1) {
-		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
-	}
+	/*
+	 * (ks) Check taskfile out flags.
+	 * If set, then execute as it is defined.
+	 * If not set, then,
+	 *	write all taskfile registers (except data) 
+	 *	write the hob registers (feature,sector,nsector,lcyl,hcyl)
+	 */
+	if (task->tf_out_flags.all == 0) {
+		/* Common path optimization */
+		if (drive->addressing == 1) {
+			/* Send hob registers first */
+			hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
+			hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
+			hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
+			hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
+			hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		}
 
-	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+		/* Send now the standard registers */
+		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
+		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
+		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
+		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
+		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
 
-	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+		hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
+			   IDE_SELECT_REG);
+	} else {
+		if (drive->addressing == 1) {
+			/* (ks) Send hob registers first */
+			if (task->tf_out_flags.b.error_feature)
+				hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
+			if (task->tf_out_flags.b.nsector_hob)
+				hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
+			if (task->tf_out_flags.b.sector_hob)
+				hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
+			if (task->tf_out_flags.b.lcyl_hob)
+				hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
+			if (task->tf_out_flags.b.hcyl_hob)
+				hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		}
+
+		/* (ks) Send now the standard registers */
+		if (task->tf_out_flags.b.error_feature)
+			hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
+		if (task->tf_out_flags.b.nsector)
+			hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
+		if (task->tf_out_flags.b.sector)
+			hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
+		if (task->tf_out_flags.b.lcyl)
+			hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
+		if (task->tf_out_flags.b.hcyl)
+			hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+
+		if (task->tf_out_flags.b.data) {
+			u16 data =  taskfile->data + (hobfile->data << 8);
+			hwif->OUTW(data, IDE_DATA_REG);
+		}
+
+		/*
+		 * (ks) In the taskfile approch, we will use all specified
+		 * registers and the register value will not be changed,
+		 * except the select bit (master/slave) in the drive_head
+		 * register.  We must make sure that the desired drive is
+		 * selected.
+		 */
+		hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
+	}
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
@@ -136,32 +187,23 @@ ide_startstop_t do_rw_taskfile (ide_driv
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
@@ -789,124 +831,3 @@ int ide_task_ioctl(ide_drive_t *drive, u
 
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
-		task->tf_out_flags.all = IDE_TASKFILE_STD_OUT_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_out_flags.all |= (IDE_HOB_STD_OUT_FLAGS << 8);
-        }
-
-	if (task->tf_in_flags.all == 0) {
-		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing == 1)
-			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
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
-		hwif->OUTW(data, IDE_DATA_REG);
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
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
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
--- linux-ide-series3-export.orig/include/linux/ide.h	2005-02-06 10:58:27.479337202 +0900
+++ linux-ide-series3-export/include/linux/ide.h	2005-02-06 11:01:11.678687630 +0900
@@ -1090,7 +1090,7 @@ static inline void destroy_proc_ide_inte
  *	- ide_started :	In this case, the channel is left busy until an
  *			async event (interrupt) occurs.
  * Typically, start_power_step() will issue a taskfile request with
- * do_rw_taskfile().
+ * do_taskfile().
  *
  * Upon reception of the interrupt, the core will call complete_power_step()
  * with the error code if any. This routine should update the step value
@@ -1298,12 +1298,7 @@ extern int wait_for_ready(ide_drive_t *,
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
 
 extern ide_startstop_t set_multmode_intr(ide_drive_t *);
 extern ide_startstop_t set_geometry_intr(ide_drive_t *);
