Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVBFLeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVBFLeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVBFLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:32:40 -0500
Received: from [211.58.254.17] ([211.58.254.17]:58558 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261188AbVBFL06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:26:58 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 01/04] ide: ide_write_taskfile() implemented.
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <20050206112628.GA31274@htj.dyndns.org>
References: <20050206112628.GA31274@htj.dyndns.org>
Message-Id: <20050206112655.D9A44132647@htj.dyndns.org>
Date: Sun,  6 Feb 2005 20:26:55 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01_ide_write_taskfile.patch

	ide_write_taskfile(), which writes the content of a ide_task_t
	into the IDE taskfile registers, is implemented, and
	do_rw_taskfile() and flagged_taskfile() are converted to use
	ide_write_taskfile().  Behavior changes are
	- flagged taskfile now honors HOB feature register.
	- No do_rw_taskfile() HIHI check on select register.  Except
	  for the DEV bit, all bits are honored.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series3-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-taskfile.c	2005-02-06 19:48:58.868249056 +0900
+++ linux-ide-series3-export/drivers/ide/ide-taskfile.c	2005-02-06 19:49:18.730022291 +0900
@@ -96,12 +96,94 @@ int taskfile_lib_get_identify (ide_drive
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
+void ide_write_taskfile(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	void (*OUTB)(u8, unsigned long) = hwif->OUTB;
+	unsigned long *ports = hwif->io_ports;
+	task_struct_t *tf = (task_struct_t *)task->tfRegister;
+	hob_struct_t *hob = (hob_struct_t *)task->hobRegister;
+
+	/*
+	 * (ks) Check taskfile out flags.
+	 * If set, then execute as it is defined.
+	 * If not set, then,
+	 *	write all taskfile registers (except data) 
+	 *	write the hob registers (feature,sector,nsector,lcyl,hcyl)
+	 */
+	if (task->tf_out_flags.all == 0) {
+		/* Hot path optimization */
+		if (drive->addressing == 1) {
+			/* Send hob registers first */
+			OUTB(hob->feature,	 ports[IDE_FEATURE_OFFSET]);
+			OUTB(hob->sector_count,  ports[IDE_NSECTOR_OFFSET]);
+			OUTB(hob->sector_number, ports[IDE_SECTOR_OFFSET]);
+			OUTB(hob->low_cylinder,  ports[IDE_LCYL_OFFSET]);
+			OUTB(hob->high_cylinder, ports[IDE_HCYL_OFFSET]);
+		}
+
+		/* Send now the standard registers */
+		OUTB(tf->feature,	ports[IDE_FEATURE_OFFSET]);
+		OUTB(tf->sector_count,	ports[IDE_NSECTOR_OFFSET]);
+		OUTB(tf->sector_number, ports[IDE_SECTOR_OFFSET]);
+		OUTB(tf->low_cylinder,	ports[IDE_LCYL_OFFSET]);
+		OUTB(tf->high_cylinder, ports[IDE_HCYL_OFFSET]);
+
+		OUTB((tf->device_head & ~0x10) | drive->select.all,
+		     ports[IDE_SELECT_OFFSET]);
+
+		return;
+	}
+
+	/* Flagged */
+	if (drive->addressing == 1) {
+		/* (ks) Send hob registers first */
+		if (task->tf_out_flags.b.error_feature)
+			OUTB(hob->feature,	 ports[IDE_FEATURE_OFFSET]);
+		if (task->tf_out_flags.b.nsector_hob)
+			OUTB(hob->sector_count,	 ports[IDE_NSECTOR_OFFSET]);
+		if (task->tf_out_flags.b.sector_hob)
+			OUTB(hob->sector_number, ports[IDE_SECTOR_OFFSET]);
+		if (task->tf_out_flags.b.lcyl_hob)
+			OUTB(hob->low_cylinder,	 ports[IDE_LCYL_OFFSET]);
+		if (task->tf_out_flags.b.hcyl_hob)
+			OUTB(hob->high_cylinder, ports[IDE_HCYL_OFFSET]);
+	}
+
+	/* (ks) Send now the standard registers */
+	if (task->tf_out_flags.b.error_feature)
+		OUTB(tf->feature,	ports[IDE_FEATURE_OFFSET]);
+	if (task->tf_out_flags.b.nsector)
+		OUTB(tf->sector_count,	ports[IDE_NSECTOR_OFFSET]);
+	if (task->tf_out_flags.b.sector)
+		OUTB(tf->sector_number, ports[IDE_SECTOR_OFFSET]);
+	if (task->tf_out_flags.b.lcyl)
+		OUTB(tf->low_cylinder,	ports[IDE_LCYL_OFFSET]);
+	if (task->tf_out_flags.b.hcyl)
+		OUTB(tf->high_cylinder,	ports[IDE_HCYL_OFFSET]);
+
+	if (task->tf_out_flags.b.data) {
+		u16 data = tf->data + (hob->data << 8);
+		hwif->OUTW(data, ports[IDE_DATA_OFFSET]);
+	}
+
+	/*
+	 * (ks) In the flagged taskfile approch, we will use all
+	 * specified registers and the register value will not be
+	 * changed, except the select bit (master/slave) in the
+	 * drive_head register. We must make sure that the desired
+	 * drive is selected.
+	 */
+	hwif->OUTB(tf->device_head | drive->select.all,
+		   ports[IDE_SELECT_OFFSET]);
+}
+
+EXPORT_SYMBOL(ide_write_taskfile);
+
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
-	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
 
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG) {
@@ -110,21 +192,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	}
 	SELECT_MASK(drive, 0);
 
-	if (drive->addressing == 1) {
-		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
-	}
-
-	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
-
-	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+	ide_write_taskfile(drive, task);
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
@@ -799,7 +867,6 @@ ide_startstop_t flagged_taskfile (ide_dr
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
 #if DEBUG_TASKFILE
 	u8 status;
 #endif
@@ -812,26 +879,6 @@ ide_startstop_t flagged_taskfile (ide_dr
 		}
 	}
 
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
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG)
 		/* clear nIEN */
@@ -848,42 +895,8 @@ ide_startstop_t flagged_taskfile (ide_dr
 	}
 #endif
 
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
+	ide_write_taskfile(drive, task);
 
-        /*
-	 * (ks) In the flagged taskfile approch, we will use all specified
-	 * registers and the register value will not be changed, except the
-	 * select bit (master/slave) in the drive_head register. We must make
-	 * sure that the desired drive is selected.
-	 */
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
Index: linux-ide-series3-export/include/linux/ide.h
===================================================================
--- linux-ide-series3-export.orig/include/linux/ide.h	2005-02-06 19:48:58.869248893 +0900
+++ linux-ide-series3-export/include/linux/ide.h	2005-02-06 19:49:18.732021966 +0900
@@ -1295,6 +1295,8 @@ extern void atapi_output_bytes(ide_drive
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 
+void ide_write_taskfile(ide_drive_t *drive, ide_task_t *task);
+
 /*
  * taskfile io for disks for now...and builds request from ide_ioctl
  */
