Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbVBEKoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbVBEKoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbVBEKhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:37:06 -0500
Received: from [211.58.254.17] ([211.58.254.17]:38801 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266432AbVBEK2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:55 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 08/09] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.BFFD5132705@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


08_ide_taskfile_cmd_ioctl.patch

	ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
	is the last user of REQ_DRIVE_CMD.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-iops.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-iops.c	2005-02-05 19:26:50.937432023 +0900
+++ linux-ide-series2-export/drivers/ide/ide-iops.c	2005-02-05 19:27:09.636394657 +0900
@@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
 
 EXPORT_SYMBOL(eighty_ninty_three);
 
-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
+int ide_ata66_check(ide_drive_t *drive, task_ioreg_t *regs)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
+	if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
+	    regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2 &&
+	    regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) {
 #ifndef CONFIG_IDEDMA_IVB
 		if ((drive->id->hw_config & 0x6000) == 0) {
 #else /* !CONFIG_IDEDMA_IVB */
@@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
  * 1 : Safe to update drive->id DMA registers.
  * 0 : OOPs not allowed.
  */
-int set_transfer (ide_drive_t *drive, ide_task_t *args)
+int set_transfer(ide_drive_t *drive, task_ioreg_t *regs)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
+	if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
+	    regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0 &&
+	    regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
 	     drive->id->dma_1word))
Index: linux-ide-series2-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.985500385 +0900
+++ linux-ide-series2-export/drivers/ide/ide-taskfile.c	2005-02-05 19:27:09.637394495 +0900
@@ -660,79 +660,93 @@ abort:
 	return err;
 }
 
-int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
+int ide_cmd_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
-	struct request rq;
-	u8 buffer[4];
-
-	if (!buf)
-		buf = buffer;
-	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_CMD;
-	rq.buffer = buf;
-	*buf++ = cmd;
-	*buf++ = nsect;
-	*buf++ = feature;
-	*buf++ = sectors;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
-/*
- * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
- */
-int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
-{
-	int err = 0;
-	u8 args[4], *argbuf = args;
-	u8 xfer_rate = 0;
-	int argsize = 4;
-	ide_task_t tfargs;
+	void __user *p = (void __user *)arg;
+	u8 args[4];
+	ide_task_t task;
+	ide_reg_valid_t *out_valid = &task.tf_out_flags;
+	ide_reg_valid_t *in_valid = &task.tf_in_flags;
+	task_ioreg_t *regs = task.tfRegister;
+	void *buf = NULL;
+	int io_32bit, xfer_rate = 0, in_size, ret;
 
-	if (NULL == (void *) arg) {
+	if (p == NULL) {
 		struct request rq;
 		ide_init_drive_cmd(&rq);
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
 
-	if (copy_from_user(args, (void __user *)arg, 4))
+	if (copy_from_user(args, p, 4))
 		return -EFAULT;
 
-	memset(&tfargs, 0, sizeof(ide_task_t));
-	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
-	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];
-	tfargs.tfRegister[IDE_SECTOR_OFFSET]  = args[1];
-	tfargs.tfRegister[IDE_LCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_HCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_SELECT_OFFSET]  = 0x00;
-	tfargs.tfRegister[IDE_COMMAND_OFFSET] = args[0];
-
-	if (args[3]) {
-		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
-		argbuf = kmalloc(argsize, GFP_KERNEL);
-		if (argbuf == NULL)
-			return -ENOMEM;
-		memcpy(argbuf, args, 4);
-	}
-	if (set_transfer(drive, &tfargs)) {
+	memset(&task, 0, sizeof(task));
+
+	out_valid->b.status_command	= 1;
+	out_valid->b.sector		= 1;
+	out_valid->b.error_feature	= 1;
+	out_valid->b.nsector		= 1;
+
+	in_valid->b.status_command	= 1;
+	in_valid->b.error_feature	= 1;
+	in_valid->b.nsector		= 1;
+
+	regs[IDE_COMMAND_OFFSET]	= args[0];
+	regs[IDE_SECTOR_OFFSET]		= args[1];
+	regs[IDE_FEATURE_OFFSET]	= args[2];
+	regs[IDE_NSECTOR_OFFSET]	= args[3];
+
+	if (set_transfer(drive, regs)) {
 		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
-			goto abort;
+		if (ide_ata66_check(drive, regs))
+			return -EIO;
 	}
 
-	err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
+	/* SMART needs its secret keys in lcyl and hcyl registers. */
+	if (regs[IDE_COMMAND_OFFSET] == WIN_SMART) {
+		out_valid->b.lcyl	= 1;
+		out_valid->b.hcyl	= 1;
+		regs[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
+		regs[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
+	}
+
+	in_size = 4 * SECTOR_WORDS * regs[IDE_NSECTOR_OFFSET];
+
+	if (!in_size) {
+		task.command_type		= IDE_DRIVE_TASK_NO_DATA;
+		task.data_phase			= TASKFILE_NO_DATA;
+		task.handler			= &task_no_data_intr;
+	} else {
+		task.command_type		= IDE_DRIVE_TASK_IN;
+		task.data_phase			= TASKFILE_IN;
+		task.handler			= &task_in_intr;
 
-	if (!err && xfer_rate) {
+		if ((buf = kmalloc(in_size, GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+		memset(buf, 0, in_size);	/* paranoia */
+	}
+
+	io_32bit = drive->io_32bit;
+	drive->io_32bit = 0;	/* racy */
+	ret = ide_diag_taskfile(drive, &task, in_size, buf);
+	drive->io_32bit = io_32bit;
+
+	if (!ret && xfer_rate) {
 		/* active-retuning-calls future */
 		ide_set_xfer_rate(drive, xfer_rate);
 		ide_driveid_update(drive);
 	}
-abort:
-	if (copy_to_user((void __user *)arg, argbuf, argsize))
-		err = -EFAULT;
-	if (argsize > 4)
-		kfree(argbuf);
-	return err;
+
+	args[0] = regs[IDE_STATUS_OFFSET];
+	args[1] = regs[IDE_ERROR_OFFSET];
+	args[2] = regs[IDE_NSECTOR_OFFSET];
+	args[3] = 0;
+
+	if (copy_to_user(p, args, 4) || copy_to_user(p + 4, buf, in_size))
+		ret = -EFAULT;
+
+	kfree(buf);
+	return ret;
 }
 
 int ide_task_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
Index: linux-ide-series2-export/include/linux/ide.h
===================================================================
--- linux-ide-series2-export.orig/include/linux/ide.h	2005-02-05 19:27:08.737540663 +0900
+++ linux-ide-series2-export/include/linux/ide.h	2005-02-05 19:27:09.638394333 +0900
@@ -1280,14 +1280,6 @@ extern int ide_do_drive_cmd(ide_drive_t 
  */
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
 
-/*
- * Issue ATA command and wait for completion.
- * Use for implementing commands in kernel
- *
- *  (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
- */
-extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
-
 extern u32 ide_read_24(ide_drive_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
@@ -1329,10 +1321,10 @@ int ide_task_ioctl(ide_drive_t *, unsign
 extern int system_bus_clock(void);
 
 extern int ide_driveid_update(ide_drive_t *);
-extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
+int ide_ata66_check(ide_drive_t *, task_ioreg_t *);
 extern int ide_config_drive_speed(ide_drive_t *, u8);
 extern u8 eighty_ninty_three (ide_drive_t *);
-extern int set_transfer(ide_drive_t *, ide_task_t *);
+int set_transfer(ide_drive_t *, task_ioreg_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
 
 extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
