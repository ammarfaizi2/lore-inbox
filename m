Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUCaSGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCaSGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:06:07 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:50337 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S262269AbUCaSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:05:46 -0500
Date: Wed, 31 Mar 2004 19:05:44 +0100
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.26-rc1, Dell Poweredge 750, IDE DMA and patch for piix
Message-ID: <20040331180544.GA10161@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently got a new Dell Poweredge 750 which has SATA disks in.
2.4.26-rc1 doesn't enable me to turn on DMA...

00:1f.2 IDE interface: Intel Corp.: Unknown device 25a3 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 0165
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fea0 [size=16]

Here is a diff against 2.4.26-rc1 which enables piix to recognise the
chip.  It works and is tested but was developed by cut and paste
rather than reading the technical manuals so may not be correct!

Here is it working...

ide: late registration of driver.
ICH5: IDE controller at PCI slot 00:1f.2
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfea0-0xfea7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfea8-0xfeaf, BIOS settings: hdc:DMA, hdd:DMA
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
hdc: ST3120026AS, ATA DISK drive
hdd: ST3120026AS, ATA DISK drive

--- piix.c.2.4.26-rc1	2004-03-31 13:06:51.000000000 +0100
+++ piix.c	2004-03-31 15:37:57.000000000 +0100
@@ -155,6 +155,7 @@
 			case PCI_DEVICE_ID_INTEL_82801E_11:
 			case PCI_DEVICE_ID_INTEL_ESB_2:
 			case PCI_DEVICE_ID_INTEL_ICH6_2:
+			case PCI_DEVICE_ID_INTEL_ESB_3:
 				p += sprintf(p, "PIIX4 Ultra 100 ");
 				break;
 			case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -294,6 +295,7 @@
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_2:
+		case PCI_DEVICE_ID_INTEL_ESB_3:
 			mode = 3;
 			break;
 		/* UDMA 66 capable */
@@ -686,6 +688,7 @@
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_2:
+		case PCI_DEVICE_ID_INTEL_ESB_3:
 		{
 			unsigned int extra = 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -883,6 +886,7 @@
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ 0, },
 };
 
--- piix.h.2.4.26-rc1	2004-03-31 13:06:51.000000000 +0100
+++ piix.h	2004-03-31 15:37:40.000000000 +0100
@@ -333,6 +333,20 @@
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 21 */
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_ESB_3,
+		.name		= "ICH5",
+		.init_setup	= init_setup_piix,
+		.init_chipset	= init_chipset_piix,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_piix,
+		.init_dma	= init_dma_piix,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,


-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
