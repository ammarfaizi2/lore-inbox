Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934298AbWKXFVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934298AbWKXFVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 00:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934302AbWKXFVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 00:21:36 -0500
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:48954 "EHLO
	outbound4-dub-R.bigfish.com") by vger.kernel.org with ESMTP
	id S934298AbWKXFVf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 00:21:35 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Add IDE mode support for SB600 SATA
Date: Fri, 24 Nov 2006 13:21:17 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F3586020108D22C@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add IDE mode support for SB600 SATA
Thread-Index: AccPHiwiKgPaNNIHTAWUdiO+kMc3SgAZg3Qg
From: "Conke Hu" <conke.hu@amd.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 24 Nov 2006 05:21:20.0469 (UTC) FILETIME=[600B9850:01C70F88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan
Sent: Friday, November 24, 2006 12:46 AM
To: Luugi Marsan
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA

On Thu, 23 Nov 2006 11:35:47 -0500 (EST) luugi.marsan@amd.com (Luugi Marsan) wrote:

> From: Conke Hu <conke.hu@amd.com>

NAK - Conke Hu's later patch is better and that should be the one applied
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-----------------------------------------------------------


Hi all,
We've sent out more than one patch on the sb600 sata issue and one of them has been applied, so please just ignore others. 
The applied patch is:

--- linux-2.6.19-rc6-git4/drivers/pci/quirks.c.orig	2006-11-23 19:45:49.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/pci/quirks.c	2006-11-23 19:34:23.000000000 +0800
@@ -795,6 +795,25 @@ static void __init quirk_mediagx_master(
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
+ 
+#if defined(CONFIG_SATA_AHCI) || defined(CONFIG_SATA_AHCI_MODULE)
+static void __devinit quirk_sb600_sata(struct pci_dev *pdev)
+{
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
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
+#endif
 
 /*
  * As per PCI spec, ignore base address registers 0-3 of the IDE controllers


Conke


