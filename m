Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293133AbSBWNUW>; Sat, 23 Feb 2002 08:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293134AbSBWNUN>; Sat, 23 Feb 2002 08:20:13 -0500
Received: from mail.uklinux.net ([80.84.72.21]:58374 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S293133AbSBWNUI>;
	Sat, 23 Feb 2002 08:20:08 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 23 Feb 2002 13:19:53 +0000 (GMT)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
Subject: [PATCH] Promise PDC4030 updates
Message-ID: <Pine.LNX.4.44.0202231309380.13187-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to Promise DC4030 driver following the taskfile changes to the IDE 
layer. I've removed repeated commands and made sure the correct drive is 
accessed. Also folded in some comments, version number and cosmetic 
fixes.

Applies against 2.5.5

--- linux/drivers/ide/Config.help.old	Tue Feb 12 10:28:52 2002
+++ linux/drivers/ide/Config.help	Tue Feb 12 16:44:00 2002
@@ -612,13 +612,13 @@
 
 CONFIG_BLK_DEV_PDC4030
   This driver provides support for the secondary IDE interface and
-  cache of Promise IDE chipsets, e.g. DC4030 and DC5030.  This driver
-  is known to incur timeouts/retries during heavy I/O to drives
-  attached to the secondary interface.  CD-ROM and TAPE devices are
-  not supported yet.  This driver is enabled at runtime using the
-  "ide0=dc4030" kernel boot parameter.  See the
-  <file:Documentation/ide.txt> and <file:drivers/ide/pdc4030.c> files
-  for more info.
+  cache of the original Promise IDE chipsets, e.g. DC4030 and DC5030.
+  It is nothing to do with the later range of Promise UDMA chipsets -
+  see the PDC_202XX support for these. CD-ROM and TAPE devices are not
+  supported (and probably never will be since I don't think the cards
+  support them). This driver is enabled at runtime using the "ide0=dc4030"
+  or "ide1=dc4030" kernel boot parameter. See the
+  <file:drivers/ide/pdc4030.c> file for more info.
 
 CONFIG_BLK_DEV_QD65XX
   This driver is enabled at runtime using the "ide0=qd65xx" kernel
--- linux/drivers/ide/pdc4030.c.old	Thu Feb 21 06:57:20 2002
+++ linux/drivers/ide/pdc4030.c	Fri Feb 22 17:37:30 2002
@@ -1,7 +1,7 @@
 /*  -*- linux-c -*-
- *  linux/drivers/ide/pdc4030.c		Version 0.90  May 27, 1999
+ *  linux/drivers/ide/pdc4030.c		Version 0.92  Jan 15, 2002
  *
- *  Copyright (C) 1995-1999  Linus Torvalds & authors (see below)
+ *  Copyright (C) 1995-2002  Linus Torvalds & authors (see below)
  */
 
 /*
@@ -37,6 +37,8 @@
  *			Autodetection code added.
  *
  *  Version 0.90	Transition to BETA code. No lost/unexpected interrupts
+ *  Version 0.91	Bring in line with new bio code in 2.5.1
+ *  Version 0.92	Update for IDE driver taskfile changes
  */
 
 /*
@@ -72,8 +74,8 @@
  * effects.
  */
 
-#define DEBUG_READ
-#define DEBUG_WRITE
+#undef DEBUG_READ
+#undef DEBUG_WRITE
 
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -91,6 +93,10 @@
 
 #include "pdc4030.h"
 
+#if SUPPORT_VLB_SYNC != 1
+#error This driver will not work unless SUPPORT_VLB_SYNC is 1
+#endif
+
 /*
  * promise_selectproc() is invoked by ide.c
  * in preparation for access to the specified drive.
@@ -230,12 +236,12 @@
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 
-/* Shift the remaining interfaces down by one */
+/* Shift the remaining interfaces up by one */
 	for (i=MAX_HWIFS-1 ; i > hwif->index+1 ; i--) {
 		ide_hwif_t *h = &ide_hwifs[i];
 
 #ifdef DEBUG
-		printk(KERN_DEBUG "Shifting i/f %d values to i/f %d\n",i-1,i);
+		printk(KERN_DEBUG "pdc4030: Shifting i/f %d values to i/f %d\n",i-1,i);
 #endif
 		ide_init_hwif_ports(&h->hw, (h-1)->io_ports[IDE_DATA_OFFSET], 0, NULL);
 		memcpy(h->io_ports, h->hw.io_ports, sizeof(h->io_ports));
@@ -559,6 +565,13 @@
 		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
 	SELECT_MASK(HWIF(drive), drive, 0);
 
+/* Check that it's a regular command. If not, bomb out early. */
+	if (!(rq->flags & REQ_CMD)) {
+		blk_dump_rq_flags(rq, "pdc4030 bad flags");
+		ide_end_request(drive, 0);
+		return ide_stopped;
+	}
+
 	OUT_BYTE(taskfile->feature, IDE_FEATURE_REG);
 	OUT_BYTE(taskfile->sector_count, IDE_NSECTOR_REG);
 	/* refers to number of sectors to transfer */
@@ -569,16 +582,8 @@
 	OUT_BYTE(taskfile->device_head, IDE_SELECT_REG);
 	OUT_BYTE(taskfile->command, IDE_COMMAND_REG);
 
-/* Check that it's a regular command. If not, bomb out early. */
-	if (!(rq->flags & REQ_CMD)) {
-		blk_dump_rq_flags(rq, "pdc4030 bad flags");
-		ide_end_request(drive, 0);
-		return ide_stopped;
-	}
-
 	switch (rq_data_dir(rq)) {
 	case READ:
-		OUT_BYTE(PROMISE_READ, IDE_COMMAND_REG);
 /*
  * The card's behaviour is odd at this point. If the data is
  * available, DRQ will be true, and no interrupt will be
@@ -611,9 +616,7 @@
 			drive->name);
 		return ide_stopped;
 
-	case WRITE: {
-		ide_startstop_t startstop;
-		OUT_BYTE(PROMISE_WRITE, IDE_COMMAND_REG);
+	case WRITE:
 /*
  * Strategy on write is:
  *	look for the DRQ that should have been immediately asserted
@@ -630,7 +633,6 @@
 			__cli();	/* local CPU only */
 		HWGROUP(drive)->wrq = *rq; /* scratchpad */
 		return promise_write(drive);
-	}
 
 	default:
 		printk(KERN_ERR "pdc4030: command not READ or WRITE! Huh?\n");
@@ -645,6 +647,13 @@
 	ide_task_t		 args;
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+
+	/* The four drives on the two logical (one physical) interfaces
+	   are distinguished by writing the drive number (0-3) to the
+	   Feature register.
+	   FIXME: Is promise_selectproc now redundant??
+	*/
+	taskfile.feature	= (HWIF(drive)->channel << 1) + drive->select.b.unit;
 
 	taskfile.sector_count	= rq->nr_sectors;
 	taskfile.sector_number	= block;

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please note that my address is changing from <peterd at pnd-pc dot demon.co.uk>

