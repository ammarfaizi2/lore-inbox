Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUF3PdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUF3PdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUF3P3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:29:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266710AbUF3PZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:33 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [3/9]
Date: Wed, 30 Jun 2004 17:24:46 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301724.46921.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: PIO-out error handling fixes (CONFIG_IDE_TASKFILE_IO=y)

We shouldn't ever get into ->handler() if drive is busy so
just call ->error() unconditionally if status check fails.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |   24 +++----------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_error drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_tf_pio_out_error	2004-06-28 21:23:48.652056888 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:23:48.656056280 +0200
@@ -646,16 +646,8 @@ ide_startstop_t task_out_intr (ide_drive
 	u8 stat;
 
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
-		if ((stat & (ERR_STAT | DRQ_STAT)) ||
-		    ((stat & WRERR_STAT) && !drive->nowerr))
-			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-		if (stat & BUSY_STAT) {
-			/* Not ready yet, so wait for another IRQ. */
-			ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
-			return ide_started;
-		}
-	}
+	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
 
 	/* Deal with unexpected ATA data phase. */
 	if ((!(stat & DATA_READY) && rq->nr_sectors) ||
@@ -714,16 +706,8 @@ ide_startstop_t task_mulout_intr (ide_dr
 	u8 stat;
 
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
-		if ((stat & (ERR_STAT | DRQ_STAT)) ||
-		    ((stat & WRERR_STAT) && !drive->nowerr))
-			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-		if (stat & BUSY_STAT) {
-			/* Not ready yet, so wait for another IRQ. */
-			ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-			return ide_started;
-		}
-	}
+	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
 
 	/* Deal with unexpected ATA data phase. */
 	if ((!(stat & DATA_READY) && rq->nr_sectors) ||

_

