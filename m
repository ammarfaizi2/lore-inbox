Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUALOpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUALOpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:45:47 -0500
Received: from [192.35.37.50] ([192.35.37.50]:56259 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S266191AbUALOpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:45:43 -0500
Message-ID: <4002B314.2010502@atl.lmco.com>
Date: Mon, 12 Jan 2004 09:45:40 -0500
From: Aron Rubin <arubin@atl.lmco.com>
Organization: Lockheed Martin ATL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.1]  Silicon Image 3512 SATA Controller - Tested
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000409040003010608060009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409040003010608060009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch enables the Silicon Image 3512 SATA Controller and has been 
tested and functioning without any apparent bugs (I do not have a full 
test suite but I am not booting off a device attached to this 
controller). This patch is against the Dave Jones 2.6.1-1.34 kernel 
source rpm.

You may remember I was trying to get help on this chipset before. My 
patch is simply a duplicate of the entries for the 3112 chipset. It did 
not work fully with prior kernels, giving me a "Interrupt Lost" errors. 
Whatever else was done to 2.6.1 had made it happy again. Also I did not 
have to use any special commandline options.

Aron

-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

--------------000409040003010608060009
Content-Type: text/plain;
 name="SiI3512-2004011201.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SiI3512-2004011201.patch"

--- linux-2.6.1-1.34/include/linux/pci_ids.h.orig	2004-01-11 10:30:11.000000000 -0500
+++ linux-2.6.1-1.34/include/linux/pci_ids.h	2004-01-11 10:44:25.000000000 -0500
@@ -883,6 +883,7 @@
 
 #define PCI_DEVICE_ID_SII_680		0x0680
 #define PCI_DEVICE_ID_SII_3112		0x3112
+#define PCI_DEVICE_ID_SII_3512		0x3512
 #define PCI_DEVICE_ID_SII_1210SA	0x0240
 
 #define PCI_VENDOR_ID_VISION		0x1098
--- linux-2.6.1-1.34/drivers/scsi/sata_sil.c.orig	2004-01-11 21:41:36.968803995 -0500
+++ linux-2.6.1-1.34/drivers/scsi/sata_sil.c	2004-01-11 10:43:09.000000000 -0500
@@ -39,6 +39,7 @@
 
 enum {
 	sil_3112		= 0,
+	sil_3512		= 1,
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -62,6 +63,7 @@
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ }	/* terminate list */
 };
 
@@ -121,6 +123,15 @@
 		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
 		.port_ops	= &sil_ops,
 	},
+	/* sil_3512 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03,			/* pio3-4 */
+		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.port_ops	= &sil_ops,
+	},
 };
 
 MODULE_AUTHOR("Jeff Garzik");
--- linux-2.6.1-1.34/drivers/ide/pci/siimage.c.orig	2004-01-11 10:14:19.000000000 -0500
+++ linux-2.6.1-1.34/drivers/ide/pci/siimage.c	2004-01-11 10:44:12.000000000 -0500
@@ -55,6 +55,7 @@
 	switch(pdev->device)
 	{
 		case PCI_DEVICE_ID_SII_3112:
+		case PCI_DEVICE_ID_SII_3512:
 		case PCI_DEVICE_ID_SII_1210SA:
 			return 1;
 		case PCI_DEVICE_ID_SII_680:
@@ -1179,6 +1180,7 @@
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
 	{ 0, },
 };
 
--- linux-2.6.1-1.34/drivers/ide/pci/siimage.h.orig	2004-01-11 10:15:21.000000000 -0500
+++ linux-2.6.1-1.34/drivers/ide/pci/siimage.h	2004-01-11 10:43:41.000000000 -0500
@@ -82,6 +82,18 @@
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 3 */
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_SII_3512,
+		.name		= "SiI3512 Serial ATA",
+		.init_chipset	= init_chipset_siimage,
+		.init_iops	= init_iops_siimage,
+		.init_hwif	= init_hwif_siimage,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,

--------------000409040003010608060009--

