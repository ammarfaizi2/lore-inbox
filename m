Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266706AbUF3Pc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUF3Pc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUF3P3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:29:19 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266708AbUF3PZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [6/9]
Date: Wed, 30 Jun 2004 17:25:44 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301725.44787.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: pre_task_mulout_intr() cleanup (CONFIG_IDE_TASKFILE_IO=n)

drive_is_ready() reads STATUS register if CONFIG_IDEPCI_SHARE_IRQ is not
defined and ALTSTATUS register if it is defined.  Therefore drive_is_ready()
in pre_task_mulout_intr() only makes sense if we can't trust STATUS register
(because we call ide_wait_stat() which reads STATUS register earlier).

Remove this "workaround" for now as it is not present in ide-disk.c
and whole multi PIO-out code (CONFIG_IDE_TASKFILE_IO=n) was buggy before.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |    7 -------
 1 files changed, 7 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_pre_task_mulout_intr drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_pre_task_mulout_intr	2004-06-28 21:27:32.442035640 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:27:32.448034728 +0200
@@ -433,13 +433,6 @@ ide_startstop_t pre_task_mulout_intr (id
 			drive->addressing ? "MULTWRITE_EXT" : "MULTWRITE");
 		return startstop;
 	}
-	if (!(drive_is_ready(drive))) {
-		int i;
-		for (i=0; i<100; i++) {
-			if (drive_is_ready(drive))
-				break;
-		}
-	}
 
 	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
 	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);

_

