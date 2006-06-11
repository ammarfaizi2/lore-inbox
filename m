Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWFKVTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWFKVTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWFKVTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:19:52 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:39894 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751039AbWFKVTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:19:51 -0400
Message-ID: <448C88B7.9070108@ru.mvista.com>
Date: Mon, 12 Jun 2006 01:18:47 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] HPT370: clean up DMA timeout handling
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478E104.7040200@ru.mvista.com> <4479112D.8070501@ru.mvista.com> <44835D98.3070609@ru.mvista.com>
In-Reply-To: <44835D98.3070609@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------040108020506020102040106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040108020506020102040106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Clean up DMA timeout handling for HPT370:

- hpt370_lostirq_timeout() cleared the DMA status which made __ide_dma_end()
   called afterwards return the incorrect result, and the DMA engine was reset
   both before and after stopping DMA while the HighPoint drivers only do it
   after (which seems logical) -- fix this and also rename the function;

- get rid of the needless mutual recursion in hpt370_ide_dma_end() and
   hpt370_ide_dma_timeout();

- get rid of hpt370_lostirq_timeout() since hwif->ide_dma_end() called from
   the driver's interrupt handler later does all its work.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------040108020506020102040106
Content-Type: text/plain;
 name="HPT370-cleanup-DMA-timeout-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT370-cleanup-DMA-timeout-handling.patch"

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.51	Jun 04, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 0.52	Jun 07, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -90,6 +90,7 @@
  *   there; make HPT36x speedproc handler look the same way as the HPT37x one
  * - fix  the tuneproc handler to always set the PIO mode requested,  not the
  *   best possible one
+ * - clean up DMA timeout handling for HPT370
  *		<source@mvista.com>
  *
  */
@@ -677,7 +678,7 @@ static int hpt366_ide_dma_lostirq(ide_dr
 	return __ide_dma_lostirq(drive);
 }
 
-static void hpt370_clear_engine (ide_drive_t *drive)
+static void hpt370_clear_engine(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 
@@ -685,6 +686,22 @@ static void hpt370_clear_engine (ide_dri
 	udelay(10);
 }
 
+static void hpt370_irq_timeout(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	u16 bfifo		= 0;
+	u8  dma_cmd;
+
+	pci_read_config_word(hwif->pci_dev, hwif->select_data + 2, &bfifo);
+	printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name, bfifo & 0x1ff);
+
+	/* get DMA command mode */
+	dma_cmd = hwif->INB(hwif->dma_command);
+	/* stop DMA */
+	hwif->OUTB(dma_cmd & ~0x1, hwif->dma_command);
+	hpt370_clear_engine(drive);
+}
+
 static void hpt370_ide_dma_start(ide_drive_t *drive)
 {
 #ifdef HPT_RESET_STATE_ENGINE
@@ -693,55 +710,28 @@ static void hpt370_ide_dma_start(ide_dri
 	ide_dma_start(drive);
 }
 
-static int hpt370_ide_dma_end (ide_drive_t *drive)
+static int hpt370_ide_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 dma_stat		= hwif->INB(hwif->dma_status);
+	u8  dma_stat		= hwif->INB(hwif->dma_status);
 
 	if (dma_stat & 0x01) {
 		/* wait a little */
 		udelay(20);
 		dma_stat = hwif->INB(hwif->dma_status);
+		if (dma_stat & 0x01)
+			/* fallthrough */
+			hpt370_irq_timeout(drive);
 	}
-	if ((dma_stat & 0x01) != 0) 
-		/* fallthrough */
-		(void) HWIF(drive)->ide_dma_timeout(drive);
-
 	return __ide_dma_end(drive);
 }
 
-static void hpt370_lostirq_timeout (ide_drive_t *drive)
+static int hpt370_ide_dma_timeout(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 bfifo = 0;
-	u8 dma_stat = 0, dma_cmd = 0;
-
-	pci_read_config_byte(HWIF(drive)->pci_dev, hwif->select_data + 2, &bfifo);
-	printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name, bfifo);
-	hpt370_clear_engine(drive);
-	/* get dma command mode */
-	dma_cmd = hwif->INB(hwif->dma_command);
-	/* stop dma */
-	hwif->OUTB(dma_cmd & ~0x1, hwif->dma_command);
-	dma_stat = hwif->INB(hwif->dma_status);
-	/* clear errors */
-	hwif->OUTB(dma_stat | 0x6, hwif->dma_status);
-}
-
-static int hpt370_ide_dma_timeout (ide_drive_t *drive)
-{
-	hpt370_lostirq_timeout(drive);
-	hpt370_clear_engine(drive);
+	hpt370_irq_timeout(drive);
 	return __ide_dma_timeout(drive);
 }
 
-static int hpt370_ide_dma_lostirq (ide_drive_t *drive)
-{
-	hpt370_lostirq_timeout(drive);
-	hpt370_clear_engine(drive);
-	return __ide_dma_lostirq(drive);
-}
-
 /* returns 1 if DMA IRQ issued, 0 otherwise */
 static int hpt374_ide_dma_test_irq(ide_drive_t *drive)
 {
@@ -1223,7 +1213,6 @@ static void __devinit init_hwif_hpt366(i
 		hwif->dma_start 	= &hpt370_ide_dma_start;
 		hwif->ide_dma_end	= &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout	= &hpt370_ide_dma_timeout;
-		hwif->ide_dma_lostirq	= &hpt370_ide_dma_lostirq;
 	} else
 		hwif->ide_dma_lostirq	= &hpt366_ide_dma_lostirq;
 

--------------040108020506020102040106--
