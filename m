Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVBJIqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVBJIqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVBJIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:45:28 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:40665 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262070AbVBJIjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:39:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=tKWD5PWnreEgd6nbWjrCRTnKWDxcwH1tirkzI1T1PO4LK+rVPx9S6wx2pMHfeF2KLUcfZP87QowVcCufs9mKnpXJOrvT+7JwYXsaS8J+VNrv4/tv4PVRDRz7VshpniFm9HUcij7xINkxrfKq23PEoWrZahrL/8qXHB6dTV0nt0A=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083854.BD13DFBD@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:59 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


10_ide_taskfile_cmd_ioctl.patch

	ide_cmd_ioctl() rewritten to use taskfile transport.  This is
	the last user of REQ_DRIVE_CMD.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-taskfile.c |  118 ++++++++++++++++++++++++---------------------
 include/linux/ide.h        |   12 ----
 2 files changed, 67 insertions(+), 63 deletions(-)

Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:01.974766393 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:02.621657912 +0900
@@ -667,78 +667,90 @@ abort:
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
+	int xfer_rate = 0, in_size, err;
 
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
+	if (set_transfer(drive, &task)) {
 		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
-			goto abort;
+		if (ide_ata66_check(drive, &task))
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
+		task.flags		       |= ATA_TFLAG_IO_16BIT;
+
+		if ((buf = kmalloc(in_size, GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+		memset(buf, 0, in_size);	/* paranoia */
+	}
+
+	err = ide_diag_taskfile(drive, &task, in_size, buf);
 
 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */
 		ide_set_xfer_rate(drive, xfer_rate);
 		ide_driveid_update(drive);
 	}
-abort:
-	if (copy_to_user((void __user *)arg, argbuf, argsize))
+
+	args[0] = regs[IDE_STATUS_OFFSET];
+	args[1] = regs[IDE_ERROR_OFFSET];
+	args[2] = regs[IDE_NSECTOR_OFFSET];
+	args[3] = 0;
+
+	if (copy_to_user(p, args, 4) || copy_to_user(p + 4, buf, in_size))
 		err = -EFAULT;
-	if (argsize > 4)
-		kfree(argbuf);
+
+	kfree(buf);
 	return err;
 }
 
Index: linux-ide/include/linux/ide.h
===================================================================
--- linux-ide.orig/include/linux/ide.h	2005-02-10 17:38:01.745804793 +0900
+++ linux-ide/include/linux/ide.h	2005-02-10 17:38:02.622657745 +0900
@@ -1269,14 +1269,6 @@ extern int ide_do_drive_cmd(ide_drive_t 
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
@@ -1314,10 +1306,10 @@ int ide_task_ioctl(ide_drive_t *, unsign
 extern int system_bus_clock(void);
 
 extern int ide_driveid_update(ide_drive_t *);
-extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
+int ide_ata66_check(ide_drive_t *, ide_task_t *);
 extern int ide_config_drive_speed(ide_drive_t *, u8);
 extern u8 eighty_ninty_three (ide_drive_t *);
-extern int set_transfer(ide_drive_t *, ide_task_t *);
+int set_transfer(ide_drive_t *, ide_task_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
 
 extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
