Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUIHThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUIHThU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269329AbUIHTeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:34:37 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:20439 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269324AbUIHT2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:28:52 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][7/9] ide: merge PIO write/multiwrite code (ide-disk.c)
Date: Wed, 8 Sep 2004 21:27:00 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082127.00927.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: merge PIO write/multiwrite code (ide-disk.c)

Merge multwrite_intr() into write_intr().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c |   40 ++-----------------
 1 files changed, 6 insertions(+), 34 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_multwrite drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-disk.c~ide_multwrite	2004-09-08 19:52:32.420501080 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c	2004-09-08 19:54:11.132494576 +0200
@@ -155,7 +155,7 @@ static ide_startstop_t read_intr (ide_dr
 }
 
 /*
- * write_intr() is the handler for disk write interrupts
+ * write_intr() is the handler for disk write/multwrite interrupts
  */
 static ide_startstop_t write_intr (ide_drive_t *drive)
 {
@@ -175,7 +175,10 @@ static ide_startstop_t write_intr (ide_d
 				ide_end_request(drive, 1, hwif->nsect);
 				return ide_stopped;
 			}
-			ide_pio_sector(drive, 1);
+			if (drive->mult_count)
+				ide_pio_multi(drive, 1);
+			else
+				ide_pio_sector(drive, 1);
 			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
 			return ide_started;
 		}
@@ -186,36 +189,6 @@ static ide_startstop_t write_intr (ide_d
 }
 
 /*
- * multwrite_intr() is the handler for disk multwrite interrupts
- */
-static ide_startstop_t multwrite_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq = hwif->hwgroup->rq;
-	u8 stat;
-
-	stat = hwif->INB(IDE_STATUS_REG);
-	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat)) {
-		if (stat & DRQ_STAT) {
-			/* The drive wants data. */
-			if (hwif->nleft) {
-				ide_pio_multi(drive, 1);
-				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-				return ide_started;
-			}
-		} else {
-			if (!hwif->nleft) {	/* all done? */
-				ide_end_request(drive, 1, hwif->nsect);
-				return ide_stopped;
-			}
-		}
-		/* the original code did this here (?) */
-		return ide_stopped;
-	}
-	return task_error(drive, rq, __FUNCTION__, stat);
-}
-
-/*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
  * It also takes care of issuing special DRIVE_CMDs.
@@ -343,11 +316,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		}
 		if (!drive->unmask)
 			local_irq_disable();
+		ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
 		if (drive->mult_count) {
-			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 			ide_pio_multi(drive, 1);
 		} else {
-			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
 			ide_pio_sector(drive, 1);
 		}
 		return ide_started;
_
