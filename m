Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUCOTEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCOTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:04:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262676AbUCOTD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:03:29 -0500
Message-ID: <4055FDF2.7020908@pobox.com>
Date: Mon, 15 Mar 2004 14:03:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
CC: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH try4] a better Silicon Image SATA mod15 write fix?
References: <4055D032.1090708@pobox.com>
In-Reply-To: <4055D032.1090708@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------020202050905040206040700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020202050905040206040700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And here goes try4.  Thanks for all the feedback so far...


--------------020202050905040206040700
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.14 vs edited =====
--- 1.14/drivers/scsi/sata_sil.c	Sun Mar 14 23:32:15 2004
+++ edited/drivers/scsi/sata_sil.c	Mon Mar 15 14:01:51 2004
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
+	.sg_tablesize		= 120,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.use_clustering		= 1,
 	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.dma_boundary		= 0x1fff,
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
@@ -212,6 +201,40 @@
 		writel(val, mmio);
 }
 
+static void sil_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u32 addr, len;
+	unsigned int idx;
+
+	ata_fill_sg(qc);
+
+	if (unlikely(qc->n_elem < 1))
+		return;
+
+	/* hardware S/G list may be longer (or shorter) than number of 
+	 * PCI-mapped S/G entries (qc->n_elem), due to splitting
+	 * in ata_fill_sg().  Start at zero, and skip to end
+	 * of list, if we're not already there.
+	 */
+	idx = 0;
+	while ((le32_to_cpu(ap->prd[idx].flags_len) & ATA_PRD_EOT) == 0)
+		idx++;
+
+	/* Errata workaround: if last segment is exactly 8K, split
+	 * into 7.5K and 512b pieces.
+	 */
+	len = le32_to_cpu(ap->prd[idx].flags_len) & 0xffff;
+	if (len == 8192) {
+		addr = le32_to_cpu(ap->prd[idx].addr);
+		ap->prd[idx].flags_len = cpu_to_le32(15 * 512);
+
+		idx++;
+		ap->prd[idx].addr = cpu_to_le32(addr + (15 * 512));
+		ap->prd[idx].flags_len = cpu_to_le32(512 | ATA_PRD_EOT);
+	}
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -258,15 +281,6 @@
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

--------------020202050905040206040700
Content-Type: application/x-bzip2;
 name="sata_sil.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sata_sil.c.bz2"

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
--------------020202050905040206040700--

