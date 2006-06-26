Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWFZNaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFZNaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWFZNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:30:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28136 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751090AbWFZNaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:30:08 -0400
Subject: PATCH: Clean up siimage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 14:46:10 +0100
Message-Id: <1151329570.27147.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the ifdef preparation for enhanced features that never
occcurred and is only in libata. For the SATA chips (but not yet PATA
ones) politely suggest to the user that libata may offer more features.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/siimage.c linux-2.6.17/drivers/ide/pci/siimage.c
--- linux.vanilla-2.6.17/drivers/ide/pci/siimage.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/siimage.c	2006-06-26 13:18:05.385094280 +0100
@@ -38,9 +38,6 @@
 
 #include <asm/io.h>
 
-#undef SIIMAGE_VIRTUAL_DMAPIO
-#undef SIIMAGE_LARGE_DMA
-
 /**
  *	pdev_is_sata		-	check if device is SATA
  *	@pdev:	PCI device to check
@@ -461,36 +458,6 @@
 	return 0;
 }
 
-#if 0
-/**
- *	siimage_mmio_ide_dma_count	-	DMA bytes done
- *	@drive
- *
- *	If we are doing VDMA the CMD680 requires a little bit
- *	of more careful handling and we have to read the counts
- *	off ourselves. For non VDMA life is normal.
- */
- 
-static int siimage_mmio_ide_dma_count (ide_drive_t *drive)
-{
-#ifdef SIIMAGE_VIRTUAL_DMAPIO
-	struct request *rq	= HWGROUP(drive)->rq;
-	ide_hwif_t *hwif	= HWIF(drive);
-	u32 count		= (rq->nr_sectors * SECTOR_SIZE);
-	u32 rcount		= 0;
-	unsigned long addr	= siimage_selreg(hwif, 0x1C);
-
-	hwif->OUTL(count, addr);
-	rcount = hwif->INL(addr);
-
-	printk("\n%s: count = %d, rcount = %d, nr_sectors = %lu\n",
-		drive->name, count, rcount, rq->nr_sectors);
-
-#endif /* SIIMAGE_VIRTUAL_DMAPIO */
-	return __ide_dma_count(drive);
-}
-#endif
-
 /**
  *	siimage_mmio_ide_dma_test_irq	-	check we caused an IRQ
  *	@drive: drive we are testing
@@ -512,12 +479,10 @@
 			u32 sata_error = hwif->INL(SATA_ERROR_REG);
 			hwif->OUTL(sata_error, SATA_ERROR_REG);
 			watchdog = (sata_error & 0x00680000) ? 1 : 0;
-#if 1
 			printk(KERN_WARNING "%s: sata_error = 0x%08x, "
 				"watchdog = %d, %s\n",
 				drive->name, sata_error, watchdog,
 				__FUNCTION__);
-#endif
 
 		} else {
 			watchdog = (ext_stat & 0x8000) ? 1 : 0;
@@ -863,7 +828,7 @@
  *	time.
  *
  *	The hardware supports buffered taskfiles and also some rather nice
- *	extended PRD tables. Unfortunately right now we don't.
+ *	extended PRD tables. For better SI3112 support use the libata driver
  */
 
 static void __devinit init_mmio_iops_siimage(ide_hwif_t *hwif)
@@ -900,9 +865,6 @@
 	 *	so we can't currently use it sanely since we want to
 	 *	use LBA48 mode.
 	 */	
-//	base += 0x10;
-//	hwif->no_lba48 = 1;
-
 	hw.io_ports[IDE_DATA_OFFSET]	= base;
 	hw.io_ports[IDE_ERROR_OFFSET]	= base + 1;
 	hw.io_ports[IDE_NSECTOR_OFFSET]	= base + 2;
@@ -936,15 +898,8 @@
 
        	base = (unsigned long) addr;
 
-#ifdef SIIMAGE_LARGE_DMA
-/* Watch the brackets - even Ken and Dennis get some language design wrong */
-	hwif->dma_base			= base + (ch ? 0x18 : 0x10);
-	hwif->dma_base2			= base + (ch ? 0x08 : 0x00);
-	hwif->dma_prdtable		= hwif->dma_base2 + 4;
-#else /* ! SIIMAGE_LARGE_DMA */
 	hwif->dma_base			= base + (ch ? 0x08 : 0x00);
 	hwif->dma_base2			= base + (ch ? 0x18 : 0x10);
-#endif /* SIIMAGE_LARGE_DMA */
 	hwif->mmio			= 2;
 }
 
@@ -1052,9 +1007,16 @@
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 
-	if(is_sata(hwif))
+	if(is_sata(hwif)) {
+		static int first = 1;
+		
 		hwif->busproc   = &siimage_busproc;
-
+		
+		if (first) {
+			printk(KERN_INFO "siimage: For full SATA support you should use the libata sata_sil module.\n");
+			first = 0;
+		}
+	}
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
@@ -1121,10 +1083,10 @@
 }
 
 static struct pci_device_id siimage_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680), 0},
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112), 1},
+	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA), 2},
 #endif
 	{ 0, },
 };

