Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263557AbVBEK3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbVBEK3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbVBEK3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:29:34 -0500
Received: from [211.58.254.17] ([211.58.254.17]:33681 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266322AbVBEK2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:48 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 02/09] ide: ide_init_drive_cmd() now defaults to REQ_DRIVE_TASKFILE
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102842.35A901326FB@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:42 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


02_ide_taskfile_init_drive_cmd.patch

	ide_init_drive_cmd() now initializes rq->flags to
	REQ_DRIVE_TASKFILE.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-io.c	2005-02-05 19:26:51.303372581 +0900
+++ linux-ide-series2-export/drivers/ide/ide-io.c	2005-02-05 19:27:08.308610336 +0900
@@ -64,7 +64,7 @@ static void ide_fill_flush_cmd(ide_drive
 	 */
 	memset(buf, 0, sizeof(rq->cmd));
 
-	rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
+	rq->flags = REQ_DRIVE_TASK | REQ_STARTED;
 	rq->buffer = buf;
 	rq->buffer[0] = WIN_FLUSH_CACHE;
 
@@ -1549,7 +1549,7 @@ irqreturn_t ide_intr (int irq, void *dev
 void ide_init_drive_cmd (struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_CMD;
+	rq->flags = REQ_DRIVE_TASKFILE;
 	rq->ref_count = 1;
 }
 
Index: linux-ide-series2-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-taskfile.c	2005-02-05 19:26:51.303372581 +0900
+++ linux-ide-series2-export/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.308610336 +0900
@@ -670,6 +670,7 @@ int ide_wait_cmd (ide_drive_t *drive, u8
 		buf = buffer;
 	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
 	ide_init_drive_cmd(&rq);
+	rq.flags = REQ_DRIVE_CMD;
 	rq.buffer = buf;
 	*buf++ = cmd;
 	*buf++ = nsect;
