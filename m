Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUIHTe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUIHTe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269322AbUIHTdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:33:50 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:20439 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269323AbUIHT2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:28:35 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][8/9] ide: unify PIO code
Date: Wed, 8 Sep 2004 21:27:02 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082127.02705.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: unify PIO code

Use PIO code from ide-taskfile.c in ide-disk.c so:
- drive status is checked after PIO read
- request is failed if invalid data phase
  is detected during PIO write

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c     |   86 ---------------
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-taskfile.c |    1 
 2 files changed, 3 insertions(+), 84 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_pio_unify drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-disk.c~ide_pio_unify	2004-09-08 19:54:39.707150568 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-disk.c	2004-09-08 19:56:21.225717400 +0200
@@ -123,72 +123,6 @@ static int lba_capacity_is_ok (struct hd
 #ifndef CONFIG_IDE_TASKFILE_IO
 
 /*
- * read_intr() is the handler for disk read/multread interrupts
- */
-static ide_startstop_t read_intr (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq = hwif->hwgroup->rq;
-	u8 stat;
-
-	/* new way for dealing with premature shared PCI interrupts */
-	if (!OK_STAT(stat=hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return task_error(drive, rq, __FUNCTION__, stat);
-		}
-		/* no data yet, so wait for another interrupt */
-		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-		return ide_started;
-	}
-
-	if (drive->mult_count)
-		ide_pio_multi(drive, 0);
-	else
-		ide_pio_sector(drive, 0);
-	rq->errors = 0;
-	if (!hwif->nleft) {
-		ide_end_request(drive, 1, hwif->nsect);
-		return ide_stopped;
-	}
-	ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
-	return ide_started;
-}
-
-/*
- * write_intr() is the handler for disk write/multwrite interrupts
- */
-static ide_startstop_t write_intr (ide_drive_t *drive)
-{
-	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= hwgroup->rq;
-	u8 stat;
-
-	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),
-			DRIVE_READY, drive->bad_wstat)) {
-		printk("%s: write_intr error1: nr_sectors=%u, stat=0x%02x\n",
-			drive->name, hwif->nleft, stat);
-        } else {
-		if ((hwif->nleft == 0) ^ ((stat & DRQ_STAT) != 0)) {
-			rq->errors = 0;
-			if (!hwif->nleft) {
-				ide_end_request(drive, 1, hwif->nsect);
-				return ide_stopped;
-			}
-			if (drive->mult_count)
-				ide_pio_multi(drive, 1);
-			else
-				ide_pio_sector(drive, 1);
-			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-			return ide_started;
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
@@ -292,11 +226,9 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 			command = lba48 ? WIN_READ_EXT : WIN_READ;
 		}
 
-		ide_execute_command(drive, command, &read_intr, WAIT_CMD, NULL);
+		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
 		return ide_started;
 	} else {
-		ide_startstop_t startstop;
-
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_OUT;
 			command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
@@ -307,21 +239,7 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 
 		hwif->OUTB(command, IDE_COMMAND_REG);
 
-		if (ide_wait_stat(&startstop, drive, DATA_READY,
-				drive->bad_wstat, WAIT_DRQ)) {
-			printk(KERN_ERR "%s: no DRQ after issuing %s\n",
-				drive->name,
-				drive->mult_count ? "MULTWRITE" : "WRITE");
-			return startstop;
-		}
-		if (!drive->unmask)
-			local_irq_disable();
-		ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
-		if (drive->mult_count) {
-			ide_pio_multi(drive, 1);
-		} else {
-			ide_pio_sector(drive, 1);
-		}
+		pre_task_out_intr(drive, rq);
 		return ide_started;
 	}
 }
diff -puN drivers/ide/ide-taskfile.c~ide_pio_unify drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-taskfile.c~ide_pio_unify	2004-09-08 19:54:39.709150264 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-taskfile.c	2004-09-08 19:54:40.970958440 +0200
@@ -413,6 +413,7 @@ ide_startstop_t task_in_intr (ide_drive_
 	struct request *rq = HWGROUP(drive)->rq;
 	u8 stat = hwif->INB(IDE_STATUS_REG);
 
+	/* new way for dealing with premature shared PCI interrupts */
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
_
