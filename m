Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVDESko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVDESko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVDESig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:38:36 -0400
Received: from fmr20.intel.com ([134.134.136.19]:11662 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261905AbVDEShO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:37:14 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH 2.6.11.6 4/6] ata_piix: IDE mode SATA patch for Intel ESB2
Date: Tue, 5 Apr 2005 08:13:00 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504050813.01109.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ESB2 DID's to the ata_piix.c and quirks.c file for IDE mode SATA support.  This patch was built against the 2.6.11.6 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.11.6/drivers/pci/quirks.c.orig	2005-03-28 08:50:06.756139168 -0800
+++ linux-2.6.11.6/drivers/pci/quirks.c	2005-03-28 08:53:58.230949648 -0800
@@ -1172,6 +1172,7 @@
 	case 0x2651:
 	case 0x2652:
 	case 0x2653:
+	case 0x2680:	/* ESB2 */
 		ich = 6;
 		break;
 	case 0x27c0:
--- linux-2.6.11.6/drivers/scsi/ata_piix.c.orig	2005-03-28 08:58:20.427089776 -0800
+++ linux-2.6.11.6/drivers/scsi/ata_piix.c	2005-03-28 09:03:23.384033320 -0800
@@ -61,6 +61,7 @@
 	ich6_sata		= 3,
 	ich6_sata_rm		= 4,
 	ich7_sata		= 5,
+	esb2_sata		= 6,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -93,6 +94,7 @@
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
 
 	{ }	/* terminate list */
 };
@@ -255,6 +257,18 @@
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* esb2_sata */
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
