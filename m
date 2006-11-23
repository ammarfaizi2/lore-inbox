Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755874AbWKWEYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbWKWEYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 23:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbWKWEYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 23:24:30 -0500
Received: from outbound-red.frontbridge.com ([216.148.222.49]:11301 "EHLO
	outbound3-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1755874AbWKWEY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 23:24:29 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Add IDE mode support for SB600 SATA
Date: Thu, 23 Nov 2006 12:24:24 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F3586020108CE7F@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add IDE mode support for SB600 SATA
Thread-Index: AccOp6BajH/1qDm3QAeMtzkZOwLiUgADV9WAAAB2AuA=
From: "Conke Hu" <conke.hu@amd.com>
To: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jeff@garzik.org>
X-OriginalArrivalTime: 23 Nov 2006 04:24:27.0316 (UTC) FILETIME=[433C0740:01C70EB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Conke Hu 
Sent: Thursday, November 23, 2006 12:21 PM
To: linux-kernel@vger.kernel.org; 'alan@lxorguk.ukuu.org.uk'; 'Andrew Morton'; Jeff Garzik
Subject: [PATCH] Add IDE mode support for SB600 SATA


ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch will make SB600 SATA run in AHCI mode even if it was set as IDE mode by system BIOS.

Signed-off-by: conke.hu@amd.com
---------
--- linux-2.6.19-rc6-git4/drivers/pci/quirks.c.orig	2006-11-23 19:45:49.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/pci/quirks.c	2006-11-23 19:34:23.000000000 +0800
@@ -795,6 +795,25 @@ static void __init quirk_mediagx_master(
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
+ 
+#if defined(CONFIG_SATA_AHCI) || defined(CONFIG_SATA_AHCI_MODULE) 
+static void __devinit quirk_sb600_sata(struct pci_dev *pdev) {
+	/* set sb600 sata to ahci mode */
+	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+		u8 tmp;
+
+		pci_read_config_byte(pdev, 0x40, &tmp);
+		pci_write_config_byte(pdev, 0x40, tmp|1);
+		pci_write_config_byte(pdev, 0x9, 1);
+		pci_write_config_byte(pdev, 0xa, 6);
+		pci_write_config_byte(pdev, 0x40, tmp);
+		
+		pdev->class = 0x010601;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 
+PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata); #endif
 
 /*
  * As per PCI spec, ignore base address registers 0-3 of the IDE controllers

---------------------

This is the re-written patch, if still any unreasonable, please feel free to contact me. Thanks!

Conke


