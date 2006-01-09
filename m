Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWAIWUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWAIWUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWAIWUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:20:25 -0500
Received: from fmr17.intel.com ([134.134.136.16]:61902 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751556AbWAIWUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:20:24 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: jgarzik@redhat.com
Subject: [PATCH 2.6.15 5/6] ata_piix: IDE mode SATA patch for Intel ICH8
Date: Mon, 9 Jan 2006 11:07:44 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601091107.45100.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH8 DID's to the ata_piix.c and quirks.c file for IDE mode SATA support.  This patch was built against the 2.6.15 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.15/drivers/pci/quirks.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/pci/quirks.c	2006-01-09 08:18:08.012291624 -0800
@@ -1125,6 +1125,9 @@
 	case 0x27c4:
 		ich = 7;
 		break;
+	case 0x2828:	/* ICH8M */
+		ich = 8;
+		break;
 	default:
 		/* we do not handle this PCI device */
 		return;
@@ -1144,7 +1147,7 @@
 		else
 			return;			/* not in combined mode */
 	} else {
-		WARN_ON((ich != 6) && (ich != 7));
+		WARN_ON((ich != 6) && (ich != 7) && (ich != 8));
 		tmp &= 0x3;  /* interesting bits 1:0 */
 		if (tmp & (1 << 0))
 			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
--- linux-2.6.15/drivers/scsi/ata_piix.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/scsi/ata_piix.c	2006-01-09 08:18:08.013291472 -0800
@@ -81,6 +81,7 @@
 	ich6_sata_rm		= 4,
 	ich7_sata		= 5,
 	esb2_sata		= 6,
+	ich8_sata		= 7,
 
 	PIIX_AHCI_DEVICE	= 6,
 };
@@ -116,6 +117,9 @@
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 
 	{ }	/* terminate list */
 };
@@ -293,6 +297,18 @@
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &piix_sata_ops,
 	},
+
+	/* ich8_sata */
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
