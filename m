Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVBXPGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVBXPGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVBXPCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:02:37 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:41634 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262376AbVBXOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:55:46 -0500
Date: Thu, 24 Feb 2005 15:48:33 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Message-ID: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ide_task_ioctl() rewritten to use taskfile transport.
This is the last user of REQ_DRIVE_TASK.

bart: ported to recent IDE changes by me

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-02-24 15:30:02 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-02-24 15:30:02 +01:00
@@ -777,30 +777,42 @@
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
+	struct ata_taskfile *tf = &task.tf;

 	if (copy_from_user(args, p, 7))
 		return -EFAULT;
-	err = ide_wait_cmd_task(drive, argbuf);
-	if (copy_to_user(p, argbuf, argsize))
+
+	memset(&task, 0, sizeof(task));
+
+	tf->command	= args[0];
+	tf->feature	= args[1];
+	tf->nsect	= args[2];
+	tf->lbal	= args[3];
+	tf->lbam	= args[4];
+	tf->lbah	= args[5];
+	tf->device	= args[6];
+
+	task.command_type = IDE_DRIVE_TASK_NO_DATA;
+	task.data_phase = TASKFILE_NO_DATA;
+	task.handler = &task_no_data_intr;
+
+	err = ide_diag_taskfile(drive, &task, 0, NULL);
+
+	args[0] = tf->command;
+	args[1] = tf->feature;
+	args[2] = tf->nsect;
+	args[3] = tf->lbal;
+	args[4] = tf->lbam;
+	args[5] = tf->lbah;
+	args[6] = tf->device;
+
+	if (copy_to_user(p, args, 7))
 		err = -EFAULT;
 	return err;
 }
