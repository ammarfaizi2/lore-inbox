Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266744AbUF3Pcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbUF3Pcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266706AbUF3P3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:29:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266707AbUF3PZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [2/9]
Date: Wed, 30 Jun 2004 17:24:22 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301724.22337.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: PIO-out ->prehandler() fixes (CONFIG_IDE_TASKFILE_IO=y)

Setup handler and output first data block directly from ->prehandler()
instead of calling ->handler().  The only change in functionality is that
we no longer check DRIVE_READY status bits (there is no need to do it).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_prehandler drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_tf_pio_out_prehandler	2004-06-28 21:21:23.952054632 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:21:23.957053872 +0200
@@ -698,7 +698,10 @@ ide_startstop_t pre_task_out_intr (ide_d
 	if (!drive->unmask)
 		local_irq_disable();
 
-	return task_out_intr(drive);
+	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
+	task_sectors(drive, rq, 1, IDE_PIO_OUT);
+
+	return ide_started;
 }
 EXPORT_SYMBOL(pre_task_out_intr);
 
@@ -762,7 +765,10 @@ ide_startstop_t pre_task_mulout_intr (id
 	if (!drive->unmask)
 		local_irq_disable();
 
-	return task_mulout_intr(drive);
+	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
+	task_multi_sectors(drive, rq, IDE_PIO_OUT);
+
+	return ide_started;
 }
 EXPORT_SYMBOL(pre_task_mulout_intr);
 

_

