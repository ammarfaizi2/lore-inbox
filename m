Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVBXL3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVBXL3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVBXL3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:29:41 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62854 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262232AbVBXL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:28:04 -0500
Date: Thu, 24 Feb 2005 12:20:30 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.58.0502241218470.20590@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/ide-disk.c   |   10 ++++------
 drivers/ide/ide-io.c     |    4 ++--
 drivers/ide/pci/hpt366.c |   29 +++++++++++------------------
 include/linux/ide.h      |    7 +++----
 4 files changed, 20 insertions(+), 30 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/02/24 1.2052)
   [ide] fix IRQ masking in ide_do_request()

   Revert to previous way of handling masked_irq argument.
   Reported to fix problems with shared PCI IRQs.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/24 1.2051)
   [ide] fix build for built-in hpt366 and modular ide-disk

   * always call __ide_do_rw_disk() in ide_do_rw_disk()
   * modify ide_hwif_t->rw_disk hook accordingly
   * update and cleanup hpt372n_rw_disk()
     (the only user of ide_hwif_t->rw_disk hook)
   * make __ide_do_rw_disk() static + fix comment

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<rddunlap@osdl.org> (05/02/24 1.2050)
   [ide] make 1-bit fields unsigned

   It's a bit difficult to have a value and a sign bit in a
   1-bit field.

   Fix (90) boolean/bitfield sparse warnings:
   include/linux/ide.h:937:18: warning: dubious one-bit signed bitfield
   include/linux/ide.h:939:17: warning: dubious one-bit signed bitfield

   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-24 12:05:25 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-24 12:05:25 +01:00
@@ -119,9 +119,8 @@
 /*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
- * It also takes care of issuing special DRIVE_CMDs.
  */
-ide_startstop_t __ide_do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
+static ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned int dma	= drive->using_dma;
@@ -256,7 +255,6 @@
 		return pre_task_out_intr(drive, rq);
 	}
 }
-EXPORT_SYMBOL_GPL(__ide_do_rw_disk);

 /*
  * 268435455  == 137439 MB or 28bit limit
@@ -281,9 +279,9 @@
 		 block, rq->nr_sectors, (unsigned long)rq->buffer);

 	if (hwif->rw_disk)
-		return hwif->rw_disk(drive, rq, block);
-	else
-		return __ide_do_rw_disk(drive, rq, block);
+		hwif->rw_disk(drive, rq);
+
+	return __ide_do_rw_disk(drive, rq, block);
 }

 /*
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-24 12:05:25 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-24 12:05:25 +01:00
@@ -1163,14 +1163,14 @@
 		 * happens anyway when any interrupt comes in, IDE or otherwise
 		 *  -- the kernel masks the IRQ while it is being handled.
 		 */
-		if (hwif->irq != masked_irq)
+		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
 		spin_unlock(&ide_lock);
 		local_irq_enable();
 			/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 		spin_lock_irq(&ide_lock);
-		if (hwif->irq != masked_irq)
+		if (masked_irq != IDE_NO_IRQ && hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
 		if (startstop == ide_stopped)
 			hwgroup->busy = 0;
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	2005-02-24 12:05:25 +01:00
+++ b/drivers/ide/pci/hpt366.c	2005-02-24 12:05:25 +01:00
@@ -1018,32 +1018,25 @@
 }

 /**
- *	hpt372n_rw_disk		-	wrapper for I/O
+ *	hpt372n_rw_disk		-	prepare for I/O
  *	@drive: drive for command
  *	@rq: block request structure
- *	@block: block number
- *
- *	This is called when a disk I/O is issued to the 372N instead
- *	of the default functionality. We need it because of the clock
- *	switching
  *
+ *	This is called when a disk I/O is issued to the 372N.
+ *	We need it because of the clock switching.
  */
-
-static ide_startstop_t hpt372n_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block)
+
+static void hpt372n_rw_disk(ide_drive_t *drive, struct request *rq)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	int wantclock;
-
-	if(rq_data_dir(rq) == READ)
-		wantclock = 0x21;
-	else
-		wantclock = 0x23;
-
-	if(HWIF(drive)->config_data != wantclock)
-	{
+
+	wantclock = rq_data_dir(rq) ? 0x23 : 0x21;
+
+	if (hwif->config_data != wantclock) {
 		hpt372n_set_clock(drive, wantclock);
-		HWIF(drive)->config_data = wantclock;
+		hwif->config_data = wantclock;
 	}
-	return __ide_do_rw_disk(drive, rq, block);
 }

 /*
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-24 12:05:25 +01:00
+++ b/include/linux/ide.h	2005-02-24 12:05:25 +01:00
@@ -797,7 +797,7 @@
 	struct pci_dev  *pci_dev;	/* for pci chipsets */
 	struct ide_pci_device_s	*cds;	/* chipset device struct */

-	ide_startstop_t (*rw_disk)(ide_drive_t *, struct request *, sector_t);
+	void (*rw_disk)(ide_drive_t *, struct request *);

 #if 0
 	ide_hwif_ops_t	*hwifops;
@@ -934,9 +934,9 @@
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
-	int sleeping	: 1;
+	unsigned int sleeping	: 1;
 		/* BOOL: polling active & poll_timeout field valid */
-	int polling	: 1;
+	unsigned int polling	: 1;
 		/* current drive */
 	ide_drive_t *drive;
 		/* ptr to current hwif in linked-list */
@@ -1318,7 +1318,6 @@
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);

 extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
-ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block);

 /*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
