Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267931AbTBRRxr>; Tue, 18 Feb 2003 12:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267905AbTBRRxr>; Tue, 18 Feb 2003 12:53:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267931AbTBRRxn>; Tue, 18 Feb 2003 12:53:43 -0500
Subject: PATCH: fix ide_ioreg_t and ifdefs in iops
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:04:05 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC69-00067Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-iops.c linux-2.5.61-ac2/drivers/ide/ide-iops.c
--- linux-2.5.61/drivers/ide/ide-iops.c	2003-02-10 18:38:18.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-iops.c	2003-02-18 18:06:17.000000000 +0000
@@ -245,7 +302,7 @@
  * of the sector count register location, with interrupts disabled
  * to ensure that the reads all happen together.
  */
-void ata_vlb_sync (ide_drive_t *drive, ide_ioreg_t port)
+void ata_vlb_sync (ide_drive_t *drive, unsigned long port)
 {
 	(void) HWIF(drive)->INB(port);
 	(void) HWIF(drive)->INB(port);
@@ -819,9 +876,9 @@
 //	while (HWGROUP(drive)->busy)
 //		ide_delay_50ms();
 
-#if !defined(CONFIG_DMA_NONPCI)
+#if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
 	hwif->ide_dma_host_off(drive);
-#endif /* !(CONFIG_DMA_NONPCI) */
+#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	/*
 	 * Don't use ide_wait_cmd here - it will
@@ -887,12 +944,12 @@
 	drive->id->dma_mword &= ~0x0F00;
 	drive->id->dma_1word &= ~0x0F00;
 
-#if !defined(CONFIG_DMA_NONPCI)
+#if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
 	if (speed >= XFER_SW_DMA_0)
 		hwif->ide_dma_host_on(drive);
 	else
-		hwif->ide_dma_off(drive);
-#endif /* !(CONFIG_DMA_NONPCI) */
+		hwif->ide_dma_off_quietly(drive);
+#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	switch(speed) {
 		case XFER_UDMA_7:   drive->id->dma_ultra |= 0x8080; break;
