Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHUTE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHUTE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWHUTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:04:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42141 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750734AbWHUTE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:04:28 -0400
Subject: [PATCH] libata : Add 40pin "short" cable support, honour drive
	side speed detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 20:23:49 +0100
Message-Id: <1156188229.18887.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/ata/ata_piix.c linux-2.6.18-rc4-mm2/drivers/ata/ata_piix.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/ata/ata_piix.c	2006-08-21 14:18:52.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/ata/ata_piix.c	2006-08-21 14:21:45.000000000 +0100
@@ -93,7 +93,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"2.00ac6"
+#define DRV_VERSION	"2.00ac7"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -560,6 +560,23 @@
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+struct ich_laptop {
+	u16 device;
+	u16 subvendor;
+	u16 subdevice;
+};
+
+/*
+ *	List of laptops that use short cables rather than 80 wire
+ */
+
+static const struct ich_laptop ich_laptop[] = {
+	/* devid, subvendor, subdev */
+	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
+	/* end marker */
+	{ 0, }
+};
+
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -574,11 +591,21 @@
 static void ich_pata_cbl_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	const struct ich_laptop *lap = &ich_laptop[0];
 	u8 tmp, mask;
 
 	/* no 80c support in host controller? */
 	if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
 		goto cbl40;
+		
+	/* Check for specials - Acer Aspire 5602WLMi */
+	while (lap->device) {
+		if (lap->device == pdev->device && 
+		    lap->subvendor == pdev->subsystem_vendor &&
+		    lap->subdevice == pdev->subsystem_device)
+		    	return ATA_CBL_PATA40_SHORT;
+		lap++;
+	}
 
 	/* check BIOS cable detect results */
 	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/ata/libata-core.c linux-2.6.18-rc4-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/ata/libata-core.c	2006-08-21 14:18:52.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/ata/libata-core.c	2006-08-16 14:26:29.000000000 +0100
@@ -3092,6 +3092,13 @@
 	 */
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
+	/* Apply drive side cable rule. Unknown or 80 pin cables reported
+	 * host side are checked drive side as well. Cases where we know a
+	 * 40wire cable is used safely for 80 are not checked here.
+	 */
+        if (ata_drive_40wire(dev->id) && (ap->cbl == ATA_CBL_PATA_UNK || ap->cbl == ATA_CBL_PATA80))
+		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
+        	
 
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
 				       dev->mwdma_mask, dev->udma_mask);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/ata/pata_ali.c linux-2.6.18-rc4-mm2/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/ata/pata_ali.c	2006-08-21 14:18:52.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/ata/pata_ali.c	2006-08-16 14:27:10.000000000 +0100
@@ -78,7 +78,7 @@
 	   implement the detect logic */
 
 	if (ali_cable_override(pdev))
-		return ATA_CBL_PATA80;
+		return ATA_CBL_PATA40_SHORT;
 
 	/* Host view cable detect 0x4A bit 0 primary bit 1 secondary
 	   Bit set for 40 pin */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/linux/ata.h linux-2.6.18-rc4-mm2/include/linux/ata.h
--- linux.vanilla-2.6.18-rc4-mm2/include/linux/ata.h	2006-08-21 14:18:57.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/linux/ata.h	2006-08-16 15:55:39.000000000 +0100
@@ -200,8 +200,9 @@
 	ATA_CBL_NONE		= 0,
 	ATA_CBL_PATA40		= 1,
 	ATA_CBL_PATA80		= 2,
-	ATA_CBL_PATA_UNK	= 3,
-	ATA_CBL_SATA		= 4,
+	ATA_CBL_PATA40_SHORT	= 3,		/* 40 wire cable to high UDMA spec */
+	ATA_CBL_PATA_UNK	= 4,
+	ATA_CBL_SATA		= 5,
 
 	/* SATA Status and Control Registers */
 	SCR_STATUS		= 0,
@@ -342,6 +343,15 @@
 	return 0;
 }
 
+static inline int ata_drive_40wire(const u16 *dev_id)
+{
+	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
+		return 0;	/* SATA */
+	if (dev_id[93] & 0x4000)
+		return 0;	/* 80 wire */
+	return 1;
+}
+
 static inline int atapi_cdb_len(const u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;

