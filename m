Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVBJIvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVBJIvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVBJIn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:43:58 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:52184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262067AbVBJIjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:39:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=S9c1zFsR1mFavals9lNqlc3EvB3O/qz525qkeY4sYOfgU7CcRQHwiVUJHoLV+LPQPRNnuCcbUNaE2KgSCB84i2bBA0Zg2Es1kg51MipnJzStDPziQtriaNCi17Fk3RktEi/374foJg5v91pMmBCUfitv97HNAOjjYRZ+GOoopYM=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 09/11] ide: convert uses of REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083849.D679B48D@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:54 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


09_ide_taskfile_cmd.patch

	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
	converted to use REQ_DRIVE_TASKFILE.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-disk.c |    1 -
 ide.c      |   15 ++++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

Index: linux-ide/drivers/ide/ide-disk.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-disk.c	2005-02-10 17:38:01.744804960 +0900
+++ linux-ide/drivers/ide/ide-disk.c	2005-02-10 17:38:02.415692451 +0900
@@ -723,7 +723,6 @@ static int set_multcount(ide_drive_t *dr
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 	ide_init_drive_cmd (&rq);
-	rq.flags = REQ_DRIVE_CMD;
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
Index: linux-ide/drivers/ide/ide.c
===================================================================
--- linux-ide.orig/drivers/ide/ide.c	2005-02-10 17:31:48.305767251 +0900
+++ linux-ide/drivers/ide/ide.c	2005-02-10 17:38:02.416692284 +0900
@@ -1250,9 +1250,18 @@ static int set_pio_mode (ide_drive_t *dr
 
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
-	int err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
+	ide_task_t task;
+	int err;
+
+	memset(&task, 0, sizeof(task));
+	task.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	task.tfRegister[IDE_FEATURE_OFFSET]	= SETFEATURES_XFER;
+	task.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
+	task.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	task.data_phase				= TASKFILE_NO_DATA;
+	task.handler				= task_no_data_intr;
+
+	err = ide_raw_taskfile(drive, &task, NULL);
 
 	if (!err && arg) {
 		ide_set_xfer_rate(drive, (u8) arg);
