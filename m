Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUCOPsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 10:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUCOPsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 10:48:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47073 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262609AbUCOPsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 10:48:17 -0500
Message-ID: <4055D032.1090708@pobox.com>
Date: Mon, 15 Mar 2004 10:48:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH] a better Silicon Image SATA mod15 write fix?
Content-Type: multipart/mixed;
 boundary="------------070308000806000303070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308000806000303070104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Anyone with a Silicon Image controller interested in testing this patch 
on a non-production box?

It adds support for a new, Silicon Image-specific DMA table which should 
not only reduce CPU utilization a bit, but hopefully also magically 
solve the "mod15write bug" that affected Silicon Image chipsets _when in 
combination with_ certain SATA drives.

Feedback from people with and without the affected SATA drives 
("mod15write" bug) is welcome.

This patch should apply against the latest 2.6.4-bkN snapshot version of 
sata_sil.c, but for ease I have attached the full 2.6 version of the 
driver as well (compressed, it's just over 4K).

	Jeff




--------------070308000806000303070104
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.14 vs edited =====
--- 1.14/drivers/scsi/sata_sil.c	Sun Mar 14 23:32:15 2004
+++ edited/drivers/scsi/sata_sil.c	Mon Mar 15 10:20:43 2004
@@ -52,12 +52,12 @@
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
-	SIL_IDE0_BMDMA		= 0x00,
+	SIL_IDE0_BMDMA		= 0x10,
 	SIL_IDE0_SCR		= 0x100,
 
 	SIL_IDE1_TF		= 0xC0,
 	SIL_IDE1_CTL		= 0xCA,
-	SIL_IDE1_BMDMA		= 0x08,
+	SIL_IDE1_BMDMA		= 0x18,
 	SIL_IDE1_SCR		= 0x180,
 
 	SIL_IDE2_TF		= 0x280,
@@ -71,7 +71,6 @@
 	SIL_IDE3_BMDMA		= 0x208,
 	SIL_IDE3_SCR		= 0x380,
 
-	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
 
@@ -79,6 +78,7 @@
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void sil_fill_sg(struct ata_queued_cmd *qc);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -94,17 +94,6 @@
 	const char * product;
 	unsigned int quirk;
 } sil_blacklist [] = {
-	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
 	{ }
 };
@@ -123,13 +112,13 @@
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
+	.sg_tablesize		= 256,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.use_clustering		= 1,
 	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.dma_boundary		= 0xffffffff,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 };
@@ -144,7 +133,7 @@
 	.phy_reset		= sata_phy_reset,
 	.phy_config		= pata_phy_config,	/* not a typo */
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.fill_sg		= sil_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= sil_scr_read,
@@ -212,6 +201,27 @@
 		writel(val, mmio);
 }
 
+static void sil_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int idx, n_elem = qc->n_elem;
+	struct scatterlist *sg = qc->sg;
+
+	for (idx = 0; idx < n_elem; idx++, sg++) {
+		u32 addr;
+		u32 size;
+
+		addr = (u32) sg_dma_address(sg);
+		size = (u32) sg_dma_len(sg);
+		size &= ~ATA_PRD_EOT;
+		if (idx == (n_elem - 1))
+			size |= ATA_PRD_EOT;
+
+		ap->prd[idx].addr = cpu_to_le32(addr);
+		ap->prd[idx].flags_len = cpu_to_le32(size);
+	}
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -258,15 +268,6 @@
 			break;
 		}
 	
-	/* limit requests to 15 sectors */
-	if (quirks & SIL_QUIRK_MOD15WRITE) {
-		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
-		       ap->id, dev->devno);
-		ap->host->max_sectors = 15;
-		ap->host->hostt->max_sectors = 15;
-		return;
-	}
-
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
 		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",

--------------070308000806000303070104
Content-Type: application/x-bzip2;
 name="sata_sil.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sata_sil.c.bz2"

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
SgEpqoUVJR/4u5IpwoSAbEQvUA==
--------------070308000806000303070104--

