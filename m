Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVAUXSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVAUXSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAUXR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:17:28 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:7085 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262573AbVAUXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:09:23 -0500
Date: Sat, 22 Jan 2005 00:04:03 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [ide-dev 2/5] fix drive->ready_stat for ATAPI
Message-ID: <Pine.GSO.4.58.0501220002500.23959@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
It is currently done by device drivers (including ide-default fake driver)
but for PMAC driver it is too late as wait_for_ready() may be called during
probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
->pmac_ide_do_setfeature()->wait_for_ready().

Fixup drive->ready_stat just after detecting ATAPI device.

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-21 23:53:20 +01:00
@@ -3088,7 +3088,6 @@
 		drive->queue->unplug_delay = 1;

 	drive->special.all	= 0;
-	drive->ready_stat	= 0;

 	CDROM_STATE_FLAGS(drive)->media_changed = 1;
 	CDROM_STATE_FLAGS(drive)->toc_valid     = 0;
diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/ide/ide-default.c	2005-01-21 23:53:20 +01:00
@@ -57,13 +57,6 @@
 			"driver with ide.c\n", drive->name);
 		return 1;
 	}
-
-	/* For the sake of the request layer, we must make sure we have a
-	 * correct ready_stat value, that is 0 for ATAPI devices or we will
-	 * fail any request like Power Management
-	 */
-	if (drive->media != ide_disk)
-		drive->ready_stat = 0;

 	return 0;
 }
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-21 23:53:20 +01:00
@@ -1793,7 +1793,6 @@

 	*((u16 *) &gcw) = drive->id->config;
 	drive->driver_data = floppy;
-	drive->ready_stat = 0;
 	memset(floppy, 0, sizeof(idefloppy_floppy_t));
 	floppy->drive = drive;
 	floppy->pc = floppy->pc_stack;
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/ide/ide-probe.c	2005-01-21 23:53:20 +01:00
@@ -221,6 +221,8 @@
 		}
 		printk (" drive\n");
 		drive->media = type;
+		/* an ATAPI device ignores DRDY */
+		drive->ready_stat = 0;
 		return;
 	}

diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-21 23:53:20 +01:00
@@ -4530,8 +4530,6 @@
 	memset(tape, 0, sizeof (idetape_tape_t));
 	spin_lock_init(&tape->spinlock);
 	drive->driver_data = tape;
-	/* An ATAPI device ignores DRDY */
-	drive->ready_stat = 0;
 	drive->dsc_overlap = 1;
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	if (HWIF(drive)->pci_dev != NULL) {
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/ide/ide.c	2005-01-21 23:53:20 +01:00
@@ -1747,6 +1747,8 @@
 			case -4: /* "cdrom" */
 				drive->present = 1;
 				drive->media = ide_cdrom;
+				/* an ATAPI device ignores DRDY */
+				drive->ready_stat = 0;
 				hwif->noprobe = 0;
 				goto done;
 			case -5: /* "serialize" */
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-01-21 23:53:20 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-01-21 23:53:20 +01:00
@@ -679,7 +679,6 @@
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi)
 {
 	DRIVER(drive)->busy++;
-	drive->ready_stat = 0;
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
 		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
 	set_bit(IDESCSI_TRANSFORM, &scsi->transform);
