Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUL3VKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUL3VKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 16:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUL3VKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 16:10:53 -0500
Received: from fmr20.intel.com ([134.134.136.19]:3519 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261717AbUL3VKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 16:10:45 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH] SATA support for Intel ICH7 - 2.6.10 - repost
Date: Thu, 30 Dec 2004 06:16:11 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412300616.11635.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting patch with word wrap turned off.  Please let me know if this is still not formated correctly.

This patch adds the Intel ICH7 DID's to the ata_piix.c SATA driver, ahci.c SATA AHCI driver and quirks.c for ICH7 SATA support.
If acceptable, please apply.

Thanks,

Jason Gaston

--- linux-2.6.10/drivers/pci/quirks.c.orig	2004-12-24 13:33:49.000000000 -0800
+++ linux-2.6.10/drivers/pci/quirks.c	2004-12-30 04:24:21.128072896 -0800
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
 			return;			/* not in combined mode */
 	} else {
-		WARN_ON(ich != 6);
+		WARN_ON((ich != 6) && (ich != 7));
 		tmp &= 0x3;  /* interesting bits 1:0 */
 		if (tmp & (1 << 0))
 			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
--- linux-2.6.10/drivers/scsi/ata_piix.c.orig	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/drivers/scsi/ata_piix.c	2004-12-28 07:07:38.000000000 -0800
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
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
--- linux-2.6.10/drivers/scsi/ahci.c.orig	2004-12-24 13:34:26.000000000 -0800
+++ linux-2.6.10/drivers/scsi/ahci.c	2004-12-28 07:07:38.000000000 -0800
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
 
