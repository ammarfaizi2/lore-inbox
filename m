Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUAVQKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAVQKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:10:46 -0500
Received: from main.gmane.org ([80.91.224.249]:61420 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264484AbUAVQKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:10:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: RISKO Gergely <risko@risko.hu>
Subject: [PATCH] VT6410 on ASUS P4P800 Deluxe for 2.4.24
Date: Thu, 22 Jan 2004 16:04:35 +0100
Message-ID: <84llo058jg.fsf@risko.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:5PQnd1aEk2Xy/4Kx1gVIIWrYRoQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hello!

I've got a new ASUS P4P800 Deluxe with 2 SATA port and 4 IDE port (2
software raid, with via vt6410). The 2 SATA port and first 2 IDE port
work nice out of the box with the 2.4.24. But the via vt6410 is not
recognized at all:

portion of /proc/pci:
  Bus  2, device   4, function  0:
    RAID bus controller: PCI device 1106:3164 (VIA Technologies, Inc.)
  (rev 6).
      IRQ 23.
      Master Capable.  Latency=64.  
      I/O at 0xdfe0 [0xdfe7].
      I/O at 0xdfac [0xdfaf].
      I/O at 0xdfa0 [0xdfa7].
      I/O at 0xdfa8 [0xdfab].
      I/O at 0xdf90 [0xdf9f].

After applying the attached patch everything work nice. Can you apply
it to the 2.4 and 2.6 tree?

Patch from: http://robertk.com/source/

Thanks,
Gergely


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=VT6410.patch

--- linux/drivers/ide/pci/generic.h	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22.2/drivers/ide/pci/generic.h	Mon Sep 22 20:36:26 2003
@@ -140,6 +140,19 @@
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 10 */
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device		= PCI_DEVICE_ID_VIA_610,
+		.name		= "VIA_610",
+		.init_chipset	= init_chipset_generic,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_generic,
+		.init_dma	= init_dma_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
--- linux/drivers/ide/pci/generic.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22.2/drivers/ide/pci/generic.c	Mon Sep 22 20:42:48 2003
@@ -65,6 +65,8 @@
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
+ if (hwif->pci_dev->device == PCI_DEVICE_ID_VIA_610) 
+   hwif->udma_four = 1; /* mj */
 
 	if (!noautodma)
 		hwif->autodma = 1;
@@ -141,6 +143,7 @@
 	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
 	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
 	{ PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_PICCOLO,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_610,             PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 	{ 0, },
 };
 
--- linux/include/linux/pci_ids.h	Mon Aug 25 13:44:44 2003
+++ linux-2.4.22.2/include/linux/pci_ids.h	Mon Sep 22 20:36:13 2003
@@ -1085,6 +1085,7 @@
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_P4M266	0x3148
 #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
+#define PCI_DEVICE_ID_VIA_610		0x3164
 #define PCI_DEVICE_ID_VIA_P4X333	0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189

--=-=-=--

