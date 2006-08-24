Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWHXQvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWHXQvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWHXQvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:51:02 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24551 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030386AbWHXQvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:51:00 -0400
Subject: [PATCH 001/001]  libata: upstream version of the 40pin short cable
	patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 18:09:34 +0100
Message-Id: <1156439374.3007.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <number6@the-village.bc.nu>

(Sorry its -R, git doesn't appear to have the ability to generate
reverse diffs to fix this)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 62b1a3f..22b2dba 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -93,7 +93,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"2.00-u1ac40"
+#define DRV_VERSION	"2.00"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -473,24 +473,6 @@ module_param(force_pcs, int, 0444);
 MODULE_PARM_DESC(force_pcs, "force honoring or ignoring PCS to work around "
 		 "device mis-detection (0=default, 1=ignore PCS, 2=honor PCS)");
 
-
-struct ich_laptop {
-	u16 device;
-	u16 subvendor;
-	u16 subdevice;
-};
-
-/*
- *	List of laptops that use short cables rather than 80 wire
- */
-
-static const struct ich_laptop ich_laptop[] = {
-	/* devid, subvendor, subdev */
-	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
-	/* end marker */
-	{ 0, }
-};
-
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -504,21 +486,12 @@ static const struct ich_laptop ich_lapto
 static void piix_pata_cbl_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	const struct ich_laptop *lap = &ich_laptop[0];
 	u8 tmp, mask;
 
 	/* no 80c support in host controller? */
 	if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
 		goto cbl40;
 
-	/* Check for specials - Acer Aspire 5602WLMi */
-	while (lap->device) {
-		if (lap->device == pdev->device && 
-		    lap->subvendor == pdev->subsystem_vendor &&
-		    lap->subdevice == pdev->subsystem_device)
-		    	return ATA_CBL_PATA40_SHORT;
-		lap++;
-	}
 	/* check BIOS cable detect results */
 	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
@@ -604,7 +577,6 @@ static unsigned int piix_sata_present_ma
 	return present_mask;
 }
 
-
 /**
  *	piix_sata_softreset - reset SATA host port via ATA SRST
  *	@ap: port to reset
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 82dc3ad..1c93154 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3093,13 +3093,6 @@ static void ata_dev_xfermask(struct ata_
 	 */
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-	/* Apply drive side cable rule. Unknown or 80 pin cables reported
-	 * host side are checked drive side as well. Cases where we know a
-	 * 40wire cable is used safely for 80 are not checked here.
-	 */
-        if (ata_drive_40wire(dev->id) && (ap->cbl == ATA_CBL_PATA_UNK || ap->cbl == ATA_CBL_PATA80))
-		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-        	
 
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
 				       dev->mwdma_mask, dev->udma_mask);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 0a7a284..991b858 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -200,9 +200,8 @@ enum {
 	ATA_CBL_NONE		= 0,
 	ATA_CBL_PATA40		= 1,
 	ATA_CBL_PATA80		= 2,
-	ATA_CBL_PATA40_SHORT	= 3,		/* 40 wire cable to high UDMA spec */
-	ATA_CBL_PATA_UNK	= 4,
-	ATA_CBL_SATA		= 5,
+	ATA_CBL_PATA_UNK	= 3,
+	ATA_CBL_SATA		= 4,
 
 	/* SATA Status and Control Registers */
 	SCR_STATUS		= 0,
@@ -343,15 +342,6 @@ static inline int ata_id_is_cfa(const u1
 	return 0;
 }
 
-static inline int ata_drive_40wire(const u16 *dev_id)
-{
-	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
-		return 0;	/* SATA */
-	if (dev_id[93] & 0x4000)
-		return 0;	/* 80 wire */
-	return 1;
-}
-
 static inline int atapi_cdb_len(const u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;

