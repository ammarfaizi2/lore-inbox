Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVBJIvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVBJIvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVBJIm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:42:59 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:27095 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262061AbVBJIiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=P1FFSwrDbxDsEb3HxCr5Vs4fDJevZuLLrlN18dTj65K00R3V47rVzagneSOaUob5UAPEz9tcIV7txytOQF4CIynrb+VMxuUUzIMs1gwloVreiNQf6fH4GMUmWl9z+2UAgE9BGyurTJ0KJ4AQEQqiAKO/GhX2OpfJWe6nEfzWNgU=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 07/11] ide: make ide_task_ioctl() use TASKFILE
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083839.71582492@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:44 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


07_ide_taskfile_task_ioctl.patch

	ide_task_ioctl() rewritten to use taskfile transport.  This is
	the last user of REQ_DRIVE_TASK.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-taskfile.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 19 deletions(-)

Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:01.539839336 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:01.974766393 +0900
@@ -742,30 +742,42 @@ abort:
 	return err;
 }
 
-static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
-{
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_TASK;
-	rq.buffer = buf;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
-/*
- * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
- */
-int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int ide_task_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
 	void __user *p = (void __user *)arg;
-	int err = 0;
-	u8 args[7], *argbuf = args;
-	int argsize = 7;
+	int err;
+	u8 args[7];
+	ide_task_t task;
+	u8 *regs = task.tfRegister;
 
 	if (copy_from_user(args, p, 7))
 		return -EFAULT;
-	err = ide_wait_cmd_task(drive, argbuf);
-	if (copy_to_user(p, argbuf, argsize))
+
+	memset(&task, 0, sizeof(task));
+
+	regs[IDE_COMMAND_OFFSET]	= args[0];
+	regs[IDE_FEATURE_OFFSET]	= args[1];
+	regs[IDE_NSECTOR_OFFSET]	= args[2];
+	regs[IDE_SECTOR_OFFSET]		= args[3];
+	regs[IDE_LCYL_OFFSET]		= args[4];
+	regs[IDE_HCYL_OFFSET]		= args[5];
+	regs[IDE_SELECT_OFFSET]		= args[6];
+	
+	task.command_type		= IDE_DRIVE_TASK_NO_DATA;
+	task.data_phase			= TASKFILE_NO_DATA;
+	task.handler			= &task_no_data_intr;
+
+	err = ide_diag_taskfile(drive, &task, 0, NULL);
+
+	args[0] = regs[IDE_COMMAND_OFFSET];
+	args[1] = regs[IDE_FEATURE_OFFSET];
+	args[2] = regs[IDE_NSECTOR_OFFSET];
+	args[3] = regs[IDE_SECTOR_OFFSET];
+	args[4] = regs[IDE_LCYL_OFFSET];
+	args[5] = regs[IDE_HCYL_OFFSET];
+	args[6] = regs[IDE_SELECT_OFFSET];
+
+	if (copy_to_user(p, args, 7))
 		err = -EFAULT;
 	return err;
 }
