Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVBEKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVBEKfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbVBEKbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:31:13 -0500
Received: from [211.58.254.17] ([211.58.254.17]:36753 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266343AbVBEK2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:52 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 07/09] ide: convert REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.B4E4B132704@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


07_ide_taskfile_cmd.patch

	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
	converted to use REQ_DRIVE_TASKFILE.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-disk.c	2005-02-05 19:27:08.735540988 +0900
+++ linux-ide-series2-export/drivers/ide/ide-disk.c	2005-02-05 19:27:09.428428438 +0900
@@ -741,7 +741,6 @@ static int set_multcount(ide_drive_t *dr
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 	ide_init_drive_cmd (&rq);
-	rq.flags = REQ_DRIVE_CMD;
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
Index: linux-ide-series2-export/drivers/ide/ide.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide.c	2005-02-05 19:26:50.977425527 +0900
+++ linux-ide-series2-export/drivers/ide/ide.c	2005-02-05 19:27:09.429428276 +0900
@@ -1263,9 +1263,18 @@ static int set_pio_mode (ide_drive_t *dr
 
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
-	int err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
+	ide_task_t args;
+	int err;
+
+	memset(&args, 0, sizeof(args));
+	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	args.tfRegister[IDE_FEATURE_OFFSET]	= SETFEATURES_XFER;
+	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
+	args.handler				= task_no_data_intr;
+
+	err = ide_raw_taskfile(drive, &args, NULL);
 
 	if (!err && arg) {
 		ide_set_xfer_rate(drive, (u8) arg);
