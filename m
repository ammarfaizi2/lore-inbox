Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVBBDaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVBBDaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBBDPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:15:17 -0500
Received: from [211.58.254.17] ([211.58.254.17]:18571 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262258AbVBBDKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:10:39 -0500
Date: Wed, 2 Feb 2005 12:10:37 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 26/29] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
Message-ID: <20050202031037.GK1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 26_ide_taskfile_cmd_ioctl.patch
> 
> 	ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
> 	is the last user of REQ_DRIVE_CMD.


Index: linux-ide-export/drivers/ide/ide-iops.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-iops.c	2005-02-02 10:28:04.466320918 +0900
+++ linux-ide-export/drivers/ide/ide-iops.c	2005-02-02 10:28:07.406843817 +0900
@@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
 
 EXPORT_SYMBOL(eighty_ninty_three);
 
-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
+int ide_ata66_check (ide_drive_t *drive, task_ioreg_t *regs)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
+	if ((regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
+	    (regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
+	    (regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
 #ifndef CONFIG_IDEDMA_IVB
 		if ((drive->id->hw_config & 0x6000) == 0) {
 #else /* !CONFIG_IDEDMA_IVB */
@@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
  * 1 : Safe to update drive->id DMA registers.
  * 0 : OOPs not allowed.
  */
-int set_transfer (ide_drive_t *drive, ide_task_t *args)
+int set_transfer (ide_drive_t *drive, task_ioreg_t *regs)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
+	if ((regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
+	    (regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
+	    (regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
 	     drive->id->dma_1word))
Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:06.751950074 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:07.407843655 +0900
@@ -704,78 +704,90 @@ abort:
 	return err;
 }
 
-int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
-{
-	struct request rq;
-	u8 buffer[4];
-
-	if (!buf)
-		buf = buffer;
-	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
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
 int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
-	int err = 0;
-	u8 args[4], *argbuf = args;
+	u8 args[4];
+	ide_task_request_t *task_req;
+	task_ioreg_t *io_ports;
 	u8 xfer_rate = 0;
-	int argsize = 4;
-	ide_task_t tfargs;
+	mm_segment_t orig_fs;
+	int in_size, ret;
 
-	if (NULL == (void *) arg) {
+	if ((void *)arg == NULL) {
 		struct request rq;
 		ide_init_drive_cmd(&rq);
+		rq.flags = REQ_DRIVE_TASKFILE;
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
 
 	if (copy_from_user(args, (void __user *)arg, 4))
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
+	in_size = 4 * SECTOR_WORDS * args[3];
+
+	task_req = kmalloc(sizeof(*task_req) + in_size, GFP_KERNEL);
+	if (task_req == NULL)
+		return -ENOMEM;
+
+	memset(task_req, 0, sizeof(*task_req) + in_size);
+
+	task_req->out_flags.b.status_command	= 1;
+	task_req->out_flags.b.sector		= 1;
+	task_req->out_flags.b.error_feature	= 1;
+	task_req->out_flags.b.nsector		= 1;
+
+	task_req->in_flags.b.status_command	= 1;
+	task_req->in_flags.b.error_feature	= 1;
+	task_req->in_flags.b.nsector		= 1;
+
+	io_ports = task_req->io_ports;
+	io_ports[IDE_COMMAND_OFFSET]		= args[0];
+	io_ports[IDE_SECTOR_OFFSET]		= args[1];
+	io_ports[IDE_FEATURE_OFFSET]		= args[2];
+	io_ports[IDE_NSECTOR_OFFSET]		= args[3];
+
+	if (in_size) {
+		task_req->req_cmd		= IDE_DRIVE_TASK_IN;
+		task_req->data_phase		= TASKFILE_IN;
+		task_req->in_size		= in_size;
+	} else {
+		task_req->req_cmd		= IDE_DRIVE_TASK_NO_DATA;
+		task_req->data_phase		= TASKFILE_NO_DATA;
 	}
-	if (set_transfer(drive, &tfargs)) {
+
+	if (set_transfer(drive, io_ports)) {
 		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
+		if (ide_ata66_check(drive, io_ports)) {
+			ret = -EIO;
 			goto abort;
+		}
 	}
 
-	err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
+	orig_fs = get_fs();
+	set_fs(KERNEL_DS);
 
-	if (!err && xfer_rate) {
+	ret = ide_taskfile_ioctl(drive, cmd, (unsigned long)task_req);
+
+	set_fs(orig_fs);
+
+	if (!ret && xfer_rate) {
 		/* active-retuning-calls future */
 		ide_set_xfer_rate(drive, xfer_rate);
 		ide_driveid_update(drive);
 	}
+
+	args[0] = io_ports[IDE_STATUS_OFFSET];
+	args[1] = io_ports[IDE_ERROR_OFFSET];
+	args[2] = io_ports[IDE_NSECTOR_OFFSET];
+	args[3] = 0;
+
+	if (copy_to_user((void __user *)arg, args, 4) ||
+	    copy_to_user((void __user *)arg + 4,
+			 (void *)task_req + sizeof(*task_req), in_size))
+		ret = -EFAULT;
 abort:
-	if (copy_to_user((void __user *)arg, argbuf, argsize))
-		err = -EFAULT;
-	if (argsize > 4)
-		kfree(argbuf);
-	return err;
+	kfree(task_req);
+	return ret;
 }
 
 int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
Index: linux-ide-export/include/linux/ide.h
===================================================================
--- linux-ide-export.orig/include/linux/ide.h	2005-02-02 10:28:06.529986088 +0900
+++ linux-ide-export/include/linux/ide.h	2005-02-02 10:28:07.408843493 +0900
@@ -1289,14 +1289,6 @@ extern int ide_do_drive_cmd(ide_drive_t 
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
@@ -1334,10 +1326,10 @@ int ide_task_ioctl(ide_drive_t *, unsign
 extern int system_bus_clock(void);
 
 extern int ide_driveid_update(ide_drive_t *);
-extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
+extern int ide_ata66_check(ide_drive_t *, task_ioreg_t *);
 extern int ide_config_drive_speed(ide_drive_t *, u8);
 extern u8 eighty_ninty_three (ide_drive_t *);
-extern int set_transfer(ide_drive_t *, ide_task_t *);
+extern int set_transfer(ide_drive_t *, task_ioreg_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
 
 extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
