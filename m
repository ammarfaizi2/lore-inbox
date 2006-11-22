Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966972AbWKVAyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966972AbWKVAyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966971AbWKVAyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:54:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:8484 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S966922AbWKVAx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:53:59 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,445,1157353200"; 
   d="scan'208"; a="165193666:sNHT20896925"
From: Jason Gaston <jason.d.gaston@intel.com>
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       jason.d.gaston@intel.com
Subject: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for Intel ICH9
Date: Tue, 21 Nov 2006 16:53:51 -0800
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211653.51596.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Intel ICH9 IDE mode SATA controller DID's.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20 04:58:48.000000000 -0800
+++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20 06:15:12.000000000 -0800
@@ -127,6 +127,7 @@
 	ich6_sata_ahci		= 8,
 	ich6m_sata_ahci		= 9,
 	ich8_sata_ahci		= 10,
+	ich9_sata_ahci		= 11,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -227,14 +228,26 @@
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
-	/* Enterprise Southbridge 2 (where's the datasheet?) */
+	/* Enterprise Southbridge 2 (631xESB/632xESB) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
+	/* SATA Controller 1 IDE (ICH8) */
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* SATA Controller 2 IDE (ICH8, ditto) */
+	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* Mobile SATA Controller IDE (ICH8M, ditto) */
+	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller 1 IDE (ICH9) */
+	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_sata_ahci },
+	/* SATA Controller 1 IDE (ICH9) */
+	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_sata_ahci },
+	/* SATA Controller 2 IDE (ICH9) */
+	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_sata_ahci },
+	/* Mobile SATA Controller 1 IDE (ICH9M) */
+	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_sata_ahci },
+	/* Mobile SATA Controller 2 IDE (ICH9M) */
+	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_sata_ahci },
+	/* Mobile SATA Controller 2 IDE (ICH9M) */
+	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich9_sata_ahci },
 
 	{ }	/* terminate list */
 };
@@ -425,6 +438,19 @@
 	},
 };
 
+static const struct piix_map_db ich9_map_db = {
+	.mask = 0x3,
+	.port_enable = 0x3,
+	.present_shift = 8,
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
+		{  RV,  RV,  RV,  RV },
+		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
 static const struct piix_map_db *piix_map_db_table[] = {
 	[ich5_sata]		= &ich5_map_db,
 	[esb_sata]		= &ich5_map_db,
@@ -432,6 +458,8 @@
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
 	[ich8_sata_ahci]	= &ich8_map_db,
+	[ich9_sata_ahci]	= &ich9_map_db,
+
 };
 
 static struct ata_port_info piix_port_info[] = {
@@ -553,6 +581,18 @@
 		.port_ops	= &piix_sata_ops,
 	},
 
+	/* ich9_sata_ahci: 11 */
+	{
+		.sht		= &piix_sht,
+		.flags		= ATA_FLAG_SATA |
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
+
 };
 
 static struct pci_bits piix_enable_bits[] = {
