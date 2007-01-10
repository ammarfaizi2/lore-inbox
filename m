Return-Path: <linux-kernel-owner+w=401wt.eu-S964962AbXAJRDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbXAJRDB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbXAJRDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:03:01 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42165 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964962AbXAJRDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:03:00 -0500
Date: Wed, 10 Jan 2007 17:13:38 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libata: PIIX3 support
Message-ID: <20070110171338.5cd555b1@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This I believe completes the PIIX range of support for libata

This adds the table entries needed for the PIIX3, both a new PCI
identifier and a new mode list. It also fixes an erroneous access to PCI
configuration 0x48 on non UDMA capable chips.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/ata_piix.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/ata_piix.c	2007-01-10 16:37:56.840128000 +0000
@@ -118,7 +118,7 @@
 	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
 
 	/* controller IDs */
-	piix_pata_33		= 0,	/* PIIX3 or 4 at 33Mhz */
+	piix_pata_33		= 0,	/* PIIX4 at 33Mhz */
 	ich_pata_33		= 1,	/* ICH up to UDMA 33 only */
 	ich_pata_66		= 2,	/* ICH up to 66 Mhz */
 	ich_pata_100		= 3,	/* ICH up to UDMA 100 */
@@ -128,6 +128,7 @@
 	ich6_sata_ahci		= 7,
 	ich6m_sata_ahci		= 8,
 	ich8_sata_ahci		= 9,
+	piix_pata_mwdma		= 10,	/* PIIX3 MWDMA only */
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -165,6 +166,8 @@
 
 static const struct pci_device_id piix_pci_tbl[] = {
 #ifdef ATA_ENABLE_PATA
+	/* Intel PIIX3 for the 430HX etc */
+	{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },
 	/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
 	/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
@@ -441,7 +444,7 @@
 };
 
 static struct ata_port_info piix_port_info[] = {
-	/* piix_pata_33: 0:  PIIX3 or 4 at 33MHz */
+	/* piix_pata_33: 0:  PIIX4 at 33MHz */
 	{
 		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS,
@@ -543,6 +546,14 @@
 		.port_ops	= &piix_sata_ops,
 	},
 
+	/* piix_pata_mwdma: 10:  PIIX3 MWDMA only */
+	{
+		.sht		= &piix_sht,
+		.flags		= PIIX_PATA_FLAGS,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
+		.port_ops	= &piix_pata_ops,
+	},
 };
 
 static struct pci_bits piix_enable_bits[] = {
@@ -786,7 +797,8 @@
 			    { 2, 3 }, };
 
 	pci_read_config_word(dev, master_port, &master_data);
-	pci_read_config_byte(dev, 0x48, &udma_enable);
+	if (ap->udma_mask)
+		pci_read_config_byte(dev, 0x48, &udma_enable);
 
 	if (speed >= XFER_UDMA_0) {
 		unsigned int udma = adev->dma_mode - XFER_UDMA_0;
