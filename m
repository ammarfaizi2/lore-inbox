Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSIJQyz>; Tue, 10 Sep 2002 12:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSIJQyz>; Tue, 10 Sep 2002 12:54:55 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:61588 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316582AbSIJQyw>; Tue, 10 Sep 2002 12:54:52 -0400
Date: Tue, 10 Sep 2002 19:22:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]][2.4-ac] opti621 can't do dma
Message-ID: <Pine.LNX.4.44.0209101920260.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre, Alan
	afaik the opti621 can't do DMA, also aren't they all addon cards?

ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
SIS5513: IDE controller at PCI slot 00:00.1
PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try using 
pci=biosirq.
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS620    ATA 66 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
OPTI621: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 9 for device 00:09.0
OPTI621: chipset revision 0
OPTI621: 100% native mode on irq 9
OPTI621: dma_base is invalid (0x0000)
ide2: OPTI621 Bus-Master DMA disabled (BIOS)
OPTI621: dma_base is invalid (0x0000)
ide3: OPTI621 Bus-Master DMA disabled (BIOS)
hda: WDC WD75DA-00AWA1, ATA DISK drive
hdb: WDC AC11200L, ATA DISK drive
blk: queue c04ad7c0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c04ad91c, I/O limit 4095Mb (mask 0xffffffff)
hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

Index: linux-2.4.20-pre5-ac4/drivers/ide/pci//opti621.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-pre5-ac4/drivers/ide/pci/opti621.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 opti621.c
--- linux-2.4.20-pre5-ac4/drivers/ide/pci//opti621.c	8 Sep 2002 18:05:34 -0000	1.1.1.1
+++ linux-2.4.20-pre5-ac4/drivers/ide/pci//opti621.c	9 Sep 2002 21:00:42 -0000
@@ -330,30 +330,10 @@
  */
 static void __init init_hwif_opti621 (ide_hwif_t *hwif)
 {
-	hwif->autodma = 0;
 	hwif->drives[0].drive_data = PIO_DONT_KNOW;
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
 	hwif->tuneproc = &opti621_tune_drive;
-
-	if (!(hwif->dma_base))
-		return;
-
-	hwif->atapi_dma = 1;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-
-}
-
-static void __init init_dma_opti621 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
+	hwif->dma_base = 0;
 }
 
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
Index: linux-2.4.20-pre5-ac4/drivers/ide/pci//opti621.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-pre5-ac4/drivers/ide/pci/opti621.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 opti621.h
--- linux-2.4.20-pre5-ac4/drivers/ide/pci//opti621.h	8 Sep 2002 18:05:34 -0000	1.1.1.1
+++ linux-2.4.20-pre5-ac4/drivers/ide/pci//opti621.h	9 Sep 2002 20:56:11 -0000
@@ -18,11 +18,11 @@
 		init_chipset:	NULL,
 		init_iops:	NULL,
 		init_hwif:	init_hwif_opti621,
-		init_dma:	init_dma_opti621,
+		init_dma:	NULL,
 		channels:	2,
-		autodma:	AUTODMA,
+		autodma:	NODMA,
 		enablebits:	{{0x45,0x80,0x00}, {0x40,0x08,0x00}},
-		bootable:	ON_BOARD,
+		bootable:	OFF_BOARD,
 		extra:		0,
 	},{
 		vendor:		PCI_VENDOR_ID_OPTI,
@@ -32,11 +32,11 @@
 		init_chipset:	NULL,
 		init_iops:	NULL,
 		init_hwif:	init_hwif_opti621,
-                init_dma:	init_dma_opti621,
+                init_dma:	NULL,
 		channels:	2,
-		autodma:	AUTODMA,
+		autodma:	NODMA,
 		enablebits:	{{0x45,0x80,0x00}, {0x40,0x08,0x00}},
-		bootable:	ON_BOARD,
+		bootable:	OFF_BOARD,
 		extra:		0,
 	},{
 		vendor:		0,

-- 
function.linuxpower.ca

