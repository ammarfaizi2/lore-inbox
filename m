Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUL3CJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUL3CJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUL3CJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:09:31 -0500
Received: from fmr17.intel.com ([134.134.136.16]:63704 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261507AbUL3CJU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:09:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] SATA support for Intel ICH7 - 2.6.10 - Updated
Date: Wed, 29 Dec 2004 18:07:41 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F502AE9FAB@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SATA support for Intel ICH7 - 2.6.10 - Updated
Thread-Index: AcTuBGsyqmX8Kc99RLmMQYGQtLZACwAD18Yg
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Jeff Garzik" <jgarzik@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Dec 2004 02:08:54.0920 (UTC) FILETIME=[83AE2080:01C4EE14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Updated to fix || typo, replaced with &&.

This patch adds the Intel ICH7 DID's to the ata_piix SATA driver, ahci
SATA AHCI driver and quirks.c for ICH7 SATA support.  If acceptable,
please apply.

Thanks,

Jason Gaston


--- linux-2.6.10/drivers/pci/quirks.c.orig	2004-12-24
13:33:49.000000000 -0800
+++ linux-2.6.10/drivers/pci/quirks.c	2004-12-28 07:07:38.000000000
-0800
@@ -1162,6 +1162,10 @@
 	case 0x2653:
 		ich = 6;
 		break;
+	case 0x27c0:
+	case 0x27c4:
+		ich = 7;
+		break;
 	default:
 		/* we do not handle this PCI device */
 		return;
@@ -1181,7 +1185,7 @@
 		else
 			return;			/* not in combined mode
*/
 	} else {
-		WARN_ON(ich != 6);
+		WARN_ON((ich != 6) && (ich != 7));
 		tmp &= 0x3;  /* interesting bits 1:0 */
 		if (tmp & (1 << 0))
 			comb = (1 << 2);	/* PATA port 0, SATA
port 1 */
--- linux-2.6.10/drivers/scsi/ata_piix.c.orig	2004-12-24
13:35:50.000000000 -0800
+++ linux-2.6.10/drivers/scsi/ata_piix.c	2004-12-28
07:07:38.000000000 -0800
@@ -60,6 +60,7 @@
 	piix4_pata		= 2,
 	ich6_sata		= 3,
 	ich6_sata_rm		= 4,
+	ich7_sata		= 5,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -90,6 +91,8 @@
 	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },
 	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
+	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 
 	{ }	/* terminate list */
 };
@@ -236,6 +239,18 @@
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* ich7_sata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
+				  PIIX_FLAG_COMBINED |
PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
--- linux-2.6.10/drivers/scsi/ahci.c.orig	2004-12-24
13:34:26.000000000 -0800
+++ linux-2.6.10/drivers/scsi/ahci.c	2004-12-28 07:07:38.000000000
-0800
@@ -239,9 +239,13 @@
 
 static struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },
+	  board_ahci }, /* ICH6 */
 	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },
+	  board_ahci }, /* ICH6M */
+	{ PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7 */
+	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7M */
 	{ }	/* terminate list */
 };
 


