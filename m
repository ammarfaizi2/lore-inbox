Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVBEKfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVBEKfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266064AbVBEKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:30:30 -0500
Received: from [211.58.254.17] ([211.58.254.17]:35217 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266331AbVBEK2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:50 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 05/09] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.9F9A6132702@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


05_ide_taskfile_task_ioctl.patch

	ide_task_ioctl() modified to map to ide_taskfile_ioctl().
	This is the last user of REQ_DRIVE_TASK.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.533573794 +0900
+++ linux-ide-series2-export/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.985500385 +0900
@@ -735,32 +735,45 @@ abort:
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
+	u8 args[7];
+	ide_task_t task;
+	task_ioreg_t *regs = task.tfRegister;
+	int ret;
 
 	if (copy_from_user(args, p, 7))
 		return -EFAULT;
-	err = ide_wait_cmd_task(drive, argbuf);
-	if (copy_to_user(p, argbuf, argsize))
-		err = -EFAULT;
-	return err;
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
+	ret = ide_diag_taskfile(drive, &task, 0, NULL);
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
+		ret = -EFAULT;
+
+	return ret;
 }
 
 /*
