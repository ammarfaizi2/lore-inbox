Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVBFLeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVBFLeN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVBFL3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:29:04 -0500
Received: from [211.58.254.17] ([211.58.254.17]:60094 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261194AbVBFL06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:26:58 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 03/04] ide: ide_read_taskfile() implemented.
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <20050206112628.GA31274@htj.dyndns.org>
References: <20050206112628.GA31274@htj.dyndns.org>
Message-Id: <20050206112656.44F7F132649@htj.dyndns.org>
Date: Sun,  6 Feb 2005 20:26:56 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


03_ide_read_taskfile.patch

	Status reading part of ide_end_drive_cmd() is moved into
	a separate function ide_read_taskfile().


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series3-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-io.c	2005-02-06 19:48:58.680279593 +0900
+++ linux-ide-series3-export/drivers/ide/ide-io.c	2005-02-06 19:49:19.496897703 +0900
@@ -339,7 +339,6 @@ static void ide_complete_barrier(ide_dri
  
 void ide_end_drive_cmd (ide_drive_t *drive, u8 stat, u8 err)
 {
-	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
 
@@ -351,32 +350,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 		ide_task_t *args = (ide_task_t *) rq->special;
 		if (rq->errors == 0)
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-			
-		if (args) {
-			if (args->tf_in_flags.b.data) {
-				u16 data				= hwif->INW(IDE_DATA_REG);
-				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
-				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
-			}
-			args->tfRegister[IDE_ERROR_OFFSET]   = err;
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args->tfRegister[IDE_NSECTOR_OFFSET] = hwif->INB(IDE_NSECTOR_REG);
-			args->tfRegister[IDE_SECTOR_OFFSET]  = hwif->INB(IDE_SECTOR_REG);
-			args->tfRegister[IDE_LCYL_OFFSET]    = hwif->INB(IDE_LCYL_REG);
-			args->tfRegister[IDE_HCYL_OFFSET]    = hwif->INB(IDE_HCYL_REG);
-			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
-			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
-
-			if (drive->addressing == 1) {
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				args->hobRegister[IDE_FEATURE_OFFSET]	= hwif->INB(IDE_FEATURE_REG);
-				args->hobRegister[IDE_NSECTOR_OFFSET]	= hwif->INB(IDE_NSECTOR_REG);
-				args->hobRegister[IDE_SECTOR_OFFSET]	= hwif->INB(IDE_SECTOR_REG);
-				args->hobRegister[IDE_LCYL_OFFSET]	= hwif->INB(IDE_LCYL_REG);
-				args->hobRegister[IDE_HCYL_OFFSET]	= hwif->INB(IDE_HCYL_REG);
-			}
-		}
+		if (args)
+			ide_read_taskfile(drive, args, stat, err);
 	} else if (blk_pm_request(rq)) {
 #ifdef DEBUG_PM
 		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
Index: linux-ide-series3-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-taskfile.c	2005-02-06 19:49:18.730022291 +0900
+++ linux-ide-series3-export/drivers/ide/ide-taskfile.c	2005-02-06 19:49:19.493898191 +0900
@@ -180,6 +180,41 @@ void ide_write_taskfile(ide_drive_t *dri
 
 EXPORT_SYMBOL(ide_write_taskfile);
 
+void ide_read_taskfile(ide_drive_t *drive, ide_task_t *task, u8 stat, u8 err)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 (*INB)(unsigned long) = hwif->INB;
+	unsigned long *ports = hwif->io_ports;
+	task_struct_t *tf = (task_struct_t *)task->tfRegister;
+	hob_struct_t *hob = (hob_struct_t *)task->hobRegister;
+
+	if (task->tf_in_flags.b.data) {
+		u16 data	= hwif->INW(ports[IDE_DATA_OFFSET]);
+		tf->data	= (data) & 0xFF;
+		hob->data	= (data >> 8) & 0xFF;
+	}
+
+	if (drive->addressing == 1) {
+		/* read HOB first such that HOB bit stays cleared when
+		   we leave this function. */
+		hwif->OUTB(drive->ctl|0x80, ports[IDE_CONTROL_OFFSET]);
+		hob->feature		= INB(ports[IDE_FEATURE_OFFSET]);
+		hob->sector_count	= INB(ports[IDE_NSECTOR_OFFSET]);
+		hob->sector_number	= INB(ports[IDE_SECTOR_OFFSET]);
+		hob->low_cylinder	= INB(ports[IDE_LCYL_OFFSET]);
+		hob->high_cylinder	= INB(ports[IDE_HCYL_OFFSET]);
+	}
+
+	hwif->OUTB(drive->ctl & ~0x80, ports[IDE_CONTROL_OFFSET]);
+	tf->feature		= err;
+	tf->sector_count	= INB(ports[IDE_NSECTOR_OFFSET]);
+	tf->sector_number	= INB(ports[IDE_SECTOR_OFFSET]);
+	tf->low_cylinder	= INB(ports[IDE_LCYL_OFFSET]);
+	tf->high_cylinder	= INB(ports[IDE_HCYL_OFFSET]);
+	tf->device_head		= INB(ports[IDE_SELECT_OFFSET]);
+	tf->command		= stat;
+}
+
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
Index: linux-ide-series3-export/include/linux/ide.h
===================================================================
--- linux-ide-series3-export.orig/include/linux/ide.h	2005-02-06 19:49:18.732021966 +0900
+++ linux-ide-series3-export/include/linux/ide.h	2005-02-06 19:49:19.495897866 +0900
@@ -1296,6 +1296,7 @@ extern int drive_is_ready(ide_drive_t *)
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 
 void ide_write_taskfile(ide_drive_t *drive, ide_task_t *task);
+void ide_read_taskfile(ide_drive_t *drive, ide_task_t *task, u8 stat, u8 err);
 
 /*
  * taskfile io for disks for now...and builds request from ide_ioctl
