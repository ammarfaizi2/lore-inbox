Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTIREA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 00:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbTIREA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 00:00:27 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:44560 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262958AbTIREAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 00:00:15 -0400
Message-ID: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7134@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "Andre Hedrick (andre@linux-ide.org)" <andre@linux-ide.org>
Cc: "LKML (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23-pre4 add support for udma6 to nForce IDE driver
Date: Wed, 17 Sep 2003 21:00:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for udma6 (Ultra 133) to the combined AMD / NVIDIA IDE
driver.  It depends on linux-2.4.23-pre4-nvide.patch.

It looks like UDMA modes > udma2 were shoehorned into this driver, so the
code to set the UDMA timing registers is pretty ugly.  In particular,
computing UDMA cycle times from UDMA mode and then mapping that into a
register value is akward and cause for much of the complexity in
amd_set_speed().  At least on all the nForce controllers, this register is
always programmed the same, regardless if the PCI bus is 33MHz or 66MHz, so
the UDMA cycle times can be ignored.



diff -ru -X dontdiff linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c
linux-2.4.23-pre4-nvata133/drivers/ide/pci/amd74xx.c
--- linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c	2003-09-17
19:58:46.000000000 -0700
+++ linux-2.4.23-pre4-nvata133/drivers/ide/pci/amd74xx.c	2003-09-17
20:11:20.000000000 -0700
@@ -40,6 +40,7 @@
 #define AMD_UDMA_33		0x01
 #define AMD_UDMA_66		0x02
 #define AMD_UDMA_100		0x03
+#define AMD_UDMA_133		0x04
 #define AMD_CHECK_SWDMA		0x08
 #define AMD_BAD_SWDMA		0x10
 #define AMD_BAD_FIFO		0x20
@@ -60,13 +61,13 @@
 	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },
/* AMD-768 Opus */
 	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },
/* AMD-8111 */
         { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce2 */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce2s */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, 0x00, 0x50, AMD_UDMA_100 },
/* nVidia nForce2s SATA */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3 */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3s */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3s SATA */
-        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2, 0x00, 0x50, AMD_UDMA_100 },
/* NVIDIA nForce3s SATA2 */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_133 },
/* nVidia nForce2 */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE, 0x00, 0x50, AMD_UDMA_133 },
/* nVidia nForce2s */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, 0x00, 0x50, AMD_UDMA_133 },
/* nVidia nForce2s SATA */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE, 0x00, 0x50, AMD_UDMA_133 },
/* NVIDIA nForce3 */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE, 0x00, 0x50, AMD_UDMA_133 },
/* NVIDIA nForce3s */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA, 0x00, 0x50, AMD_UDMA_133 },
/* NVIDIA nForce3s SATA */
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2, 0x00, 0x50, AMD_UDMA_133 },
/* NVIDIA nForce3s SATA2 */
 
 	{ 0 }
 };
@@ -76,9 +77,9 @@
 static unsigned int amd_80w;
 static unsigned int amd_clock;
 
-static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3 };
-static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 1 };
-static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100" };
+static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 7
};
+static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 0 };
+static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100",
"UDMA133" };
 
 /*
  * AMD /proc entry.
@@ -160,6 +161,11 @@
 			cycle[i] = 666666 / amd_clock;
 			continue;
 		}
+		if (den[i] && uen[i] && udma[i] == 0) {
+			speed[i] = amd_clock * 4;
+			cycle[i] = 500000 / amd_clock;
+			continue;
+		}
 
 		speed[i] = 4 * amd_clock / ((den[i] && uen[i]) ? udma[i] :
(active[i] + recover[i]) * 2);
 		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] :
(active[i] + recover[i]) * 2) / amd_clock / 2;
@@ -206,6 +212,7 @@
 		case AMD_UDMA_33:  t = timing->udma ? (0xc0 |
(FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
 		case AMD_UDMA_66:  t = timing->udma ? (0xc0 |
amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
 		case AMD_UDMA_100: t = timing->udma ? (0xc0 |
amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
+		case AMD_UDMA_133: t = timing->udma ? (0xc0 |
amd_cyc2udma[FIT(timing->udma, 1, 11)]) : 0x03; break;
 		default: return;
 	}
 
@@ -239,7 +246,12 @@
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
+	/*
+	 * AMD / nForce UDMA timing register should really be programmed 
+	 * based on UDMA mode not UDMA cycle time...
+	 */
 	if (speed == XFER_UDMA_5 && amd_clock <= 33333) t.udma = 1;
+	if (speed == XFER_UDMA_6 && amd_clock <= 33333) t.udma = 11;
 
 	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
 
@@ -282,7 +294,8 @@
 		XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
 		((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA) |
 		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_66 ?
XFER_UDMA_66 : 0) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ?
XFER_UDMA_100 : 0));
+		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ?
XFER_UDMA_100 : 0) |
+		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_133 ?
XFER_UDMA_133 : 0));
 
 	amd_set_drive(drive, speed);
 
@@ -318,6 +331,7 @@
 
 	switch (amd_config->flags & AMD_UDMA) {
 
+		case AMD_UDMA_133:
 		case AMD_UDMA_100:
 			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
 			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
