Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVBBDQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVBBDQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVBBDPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:15:54 -0500
Received: from [211.58.254.17] ([211.58.254.17]:22923 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262263AbVBBDMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:12:03 -0500
Date: Wed, 2 Feb 2005 12:11:55 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 28/29] ide: ide_init_drive_cmd() now defaults to REQ_DRIVE_TASKFILE
Message-ID: <20050202031155.GM1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 28_ide_taskfile_init_drive_cmd.patch
> 
> 	ide_init_drive_cmd() now initializes rq->flags to
> 	REQ_DRIVE_TASKFILE.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:28:07.204876587 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:07.852771465 +0900
@@ -750,7 +750,6 @@ static int set_multcount(ide_drive_t *dr
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 	ide_init_drive_cmd (&rq);
-	rq.flags = REQ_DRIVE_TASKFILE;
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:07.650804235 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:07.853771303 +0900
@@ -75,7 +75,7 @@ static struct request *ide_queue_flush_c
 	}
 
 	ide_init_drive_cmd(flush_rq);
-	flush_rq->flags = REQ_DRIVE_TASKFILE | REQ_STARTED;
+	flush_rq->flags |= REQ_STARTED;
 	flush_rq->nr_sectors = rq->nr_sectors;
 	flush_rq->special = args;
 	HWGROUP(drive)->flush_real_rq = rq;
@@ -1401,7 +1401,7 @@ irqreturn_t ide_intr (int irq, void *dev
 void ide_init_drive_cmd (struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_CMD;
+	rq->flags = REQ_DRIVE_TASKFILE;
 	rq->ref_count = 1;
 }
 
Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:07.407843655 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:07.854771141 +0900
@@ -515,7 +515,6 @@ static int ide_diag_taskfile(ide_drive_t
 	struct request rq;
 
 	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_TASKFILE;
 	rq.buffer = buf;
 
 	/*
@@ -716,7 +715,6 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	if ((void *)arg == NULL) {
 		struct request rq;
 		ide_init_drive_cmd(&rq);
-		rq.flags = REQ_DRIVE_TASKFILE;
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
 
Index: linux-ide-export/drivers/ide/ide.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide.c	2005-02-02 10:28:07.205876425 +0900
+++ linux-ide-export/drivers/ide/ide.c	2005-02-02 10:28:07.855770979 +0900
@@ -1255,7 +1255,6 @@ static int set_pio_mode (ide_drive_t *dr
 	if (drive->special.b.set_tune)
 		return -EBUSY;
 	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_TASKFILE;
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
 	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
