Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263586AbVCECWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbVCECWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbVCECGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:06:14 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:9189 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263648AbVCEBsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=rWwM9W5Rs623O/gRPRv9ua8f0XqrSqUKHktOLnU8tQ91fibKexeCmd5YQ9IPH6MqShaqIGVrXogRNwRD3EbwWyHQPIJGgReMLDxWS27dZ0nC54stKGoNbExhsylR+lPmuay5ZpOUes96W+QVlT+Snk/fFT7NX5pt2D+Rb/favCg=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 07/08] ide: reimplement ide_cmd_ioctl() using taskfile
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014828.3D7EEAEA@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:33 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


07_ide_taskfile_cmd_ioctl.patch

	Reimplement ide_cmd_ioctl() using taskfile.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-taskfile.c |  105 +++++++++++++++++++++++++--------------------
 include/linux/ide.h        |    8 ---
 2 files changed, 60 insertions(+), 53 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-taskfile.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-taskfile.c	2005-03-05 10:46:59.686862923 +0900
+++ linux-taskfile-ng/drivers/ide/ide-taskfile.c	2005-03-05 10:47:00.116795711 +0900
@@ -770,75 +770,90 @@ abort:
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
-	struct ata_taskfile *tf = &tfargs.tf;
+	void __user *p = (void __user *)arg;
+	u8 args[4];
+	ide_task_t task;
+	struct ata_taskfile *tf = &task.tf;
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
+	memset(&task, 0, sizeof(task));
+
+	/*
+	 * Due to a bug in the original code, args[1] was not loaded
+	 * into lbal but instead loaded into nsect except for
+	 * WIN_SMART.  IOW, args[3] was used for sector count to setup
+	 * the command but it was args[1] which actually got into the
+	 * nsect register.
+	 *
+	 * Another problem is that lbal is used in the
+	 * WIN_SETFEATURES/SETFEATURES_XFER command.  The original
+	 * code worked because ide_set_xfer_rate() issued the command
+	 * again with correct registers loaded.
+	 *
+	 * So, here, we load args[1] for WIN_SMART and
+	 * SETFEATURES_XFER; otherwise, we ignore args[1].
+	 */
+	tf->flags	= ATA_TFLAG_OUT_FEATURE	| ATA_TFLAG_IN_FEATURE	|
+			  ATA_TFLAG_OUT_NSECT	| ATA_TFLAG_IN_NSECT	|
+			  ATA_TFLAG_IO_16BIT;
 	tf->feature	= args[2];
 	tf->nsect	= args[3];
 	tf->lbal	= args[1];
 	tf->command	= args[0];
 
-	if (args[3]) {
-		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
-		argbuf = kmalloc(argsize, GFP_KERNEL);
-		if (argbuf == NULL)
-			return -ENOMEM;
-		memcpy(argbuf, args, 4);
+	if (set_transfer(drive, &task)) {
+		tf->flags	|= ATA_TFLAG_OUT_LBAL;
+		xfer_rate	= args[1];
+		if (ide_ata66_check(drive, &task))
+			return -EIO;
 	}
-	if (set_transfer(drive, &tfargs)) {
-		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
-			goto abort;
+
+	/* SMART needs its secret keys in lcyl and hcyl registers. */
+	if (tf->command == WIN_SMART) {
+		tf->flags	|= ATA_TFLAG_OUT_LBAL | ATA_TFLAG_OUT_LBAM |
+				   ATA_TFLAG_OUT_LBAH;
+		tf->lbam	= SMART_LCYL_PASS;
+		tf->lbah	= SMART_HCYL_PASS;
 	}
 
-	err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
+	in_size = 4 * SECTOR_WORDS * args[3];
+
+	if (in_size) {
+		tf->protocol	= ATA_PROT_PIO;
+		if ((buf = kmalloc(in_size, GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+		memset(buf, 0, in_size);	/* paranoia */
+	} else
+		tf->protocol	= ATA_PROT_NODATA;
+
+	err = ide_diag_taskfile(drive, &task, READ, in_size, buf);
 
 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */
 		ide_set_xfer_rate(drive, xfer_rate);
 		ide_driveid_update(drive);
 	}
-abort:
-	if (copy_to_user((void __user *)arg, argbuf, argsize))
+
+	args[0] = tf->command;
+	args[1] = tf->feature;
+	args[2] = tf->nsect;
+	args[3] = 0;
+
+	if (copy_to_user(p, args, 4) || copy_to_user(p + 4, buf, in_size))
 		err = -EFAULT;
-	if (argsize > 4)
-		kfree(argbuf);
+	kfree(buf);
 	return err;
 }
 
Index: linux-taskfile-ng/include/linux/ide.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ide.h	2005-03-05 10:46:59.687862767 +0900
+++ linux-taskfile-ng/include/linux/ide.h	2005-03-05 10:47:00.117795555 +0900
@@ -1251,14 +1251,6 @@ extern int ide_do_drive_cmd(ide_drive_t 
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
