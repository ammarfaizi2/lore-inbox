Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbUCKHnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbUCKHlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:41:10 -0500
Received: from ncircle.nullnet.fi ([81.17.200.207]:63448 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262987AbUCKHj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:39:56 -0500
Message-ID: <40715.194.237.142.24.1078990792.squirrel@ncircle.nullnet.fi>
Date: Thu, 11 Mar 2004 09:39:52 +0200 (EET)
Subject: hpt366.c-2.4.23.patch fixes HPT374 ide/dma problems!
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040311093952_73863"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20040311093952_73863
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Hi everybody,

I have been testing the patch below from Andre Hendrick
for a couple of weeks now with two different machines
and it seems that this patch really fixes the DMA problems
some users (including me) have been suffering with kernel
HPT374-driver in the past (2.4.2x & 2.6.x).

The hardware used in the tests are:
Epox 8K9A3+ (integrated HPT374-chip)
and
Epox 4PCA3+ (integrated HPT374-chip)

The machines seem to run without any IDE-related problems
after this patch even with 4-disks & heavy I/O-traffic.
Please, consider migrating this patch into the official kernel.

Regards,
Tomi Orava


---------------------------- Original Message ----------------------------
Subject: hpt366.c-2.4.23.patch
From:    "Andre Hedrick" <andre@linux-ide.org>
Date:    Fri, February 6, 2004 11:24
To:      linux-kernel@vger.kernel.org
--------------------------------------------------------------------------


For those suffering highpoint errors.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


------=_20040311093952_73863
Content-Type: text/plain; name="hpt366.c-2.4.23.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="hpt366.c-2.4.23.patch"

--- linux-2.4.23.orig/drivers/ide/pci/hpt366.c	Mon Aug 25 04:44:41 2003
+++ linux-2.4.23/drivers/ide/pci/hpt366.c	Fri Jan  9 21:44:48 2004
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/ide/pci/hpt366.c		Version 0.36	April 25, 2003
  *
- * Copyright (C) 1999-2002		Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
  *
@@ -668,6 +668,35 @@
 	return __ide_dma_lostirq(drive);
 }
 
+/* returns 1 if dma irq issued, 0 otherwise */
+static int hpt374_ide_dma_test_irq (ide_drive_t *drive)
+{
+		        
+	ide_hwif_t *hwif	= HWIF(drive);
+	u16 bfifo		= 0;
+	u8 reginfo		= hwif->channel ? 0x56 : 0x52;
+	u8 dma_stat		= 0;
+
+	pci_read_config_word(hwif->pci_dev, reginfo, &bfifo);
+	if (bfifo & 0x1FF) {
+//		printk("%s: %d bytes in FIFO\n", drive->name, bfifo);
+		return 0;
+	}
+
+	dma_stat = hwif->INB(hwif->dma_status);
+	/* return 1 if INTR asserted */
+	if ((dma_stat & 4) == 4)
+		return 1;
+
+	if (!drive->waiting_for_dma)
+		printk(KERN_WARNING "%s: (%s) called while not waiting\n",
+				drive->name, __FUNCTION__);
+#if 0
+	drive->waiting_for_dma++;
+#endif
+	return 0;
+}
+
 static int hpt374_ide_dma_end (ide_drive_t *drive)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
@@ -1245,11 +1274,13 @@
 		hwif->udma_four = ((ata66 & regmask) ? 0 : 1);
 	hwif->ide_dma_check = &hpt366_config_drive_xfer_rate;
 
-	if (hpt_minimum_revision(dev,8))
+	if (hpt_minimum_revision(dev,8)) {
+		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	else if (hpt_minimum_revision(dev,5))
+	} else if (hpt_minimum_revision(dev,5)) {
+		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	else if (hpt_minimum_revision(dev,3)) {
+	} else if (hpt_minimum_revision(dev,3)) {
 		hwif->ide_dma_begin = &hpt370_ide_dma_begin;
 		hwif->ide_dma_end = &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout = &hpt370_ide_dma_timeout;
------=_20040311093952_73863--

