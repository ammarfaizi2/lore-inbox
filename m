Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUCOSJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUCOSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:08:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262652AbUCOSFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:05:07 -0500
Message-ID: <4055F045.40102@pobox.com>
Date: Mon, 15 Mar 2004 13:04:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH try3] a better Silicon Image SATA mod15 write fix?
References: <4055D032.1090708@pobox.com> <4055EF4F.8060803@pobox.com>
In-Reply-To: <4055EF4F.8060803@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------050505090508020103000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050505090508020103000408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sigh... it would help to disable the old errata fix.

Try 3.


--------------050505090508020103000408
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.14 vs edited =====
--- 1.14/drivers/scsi/sata_sil.c	Sun Mar 14 23:32:15 2004
+++ edited/drivers/scsi/sata_sil.c	Mon Mar 15 13:02:28 2004
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
@@ -212,6 +201,39 @@
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
+	/* hardware S/G list may be longer than number of 
+	 * PCI-mapped S/G entries (qc->n_elem), due to splitting
+	 * in ata_fill_sg().  Start at qc->n_elem, and skip to end
+	 * of list, if we're not already there.
+	 */
+	idx = qc->n_elem - 1;
+	while ((le32_to_cpu(ap->prd[idx].flags_len) & ATA_PRD_EOT) == 0)
+		idx++;
+
+	/* Errata workaround: if last segment is exactly 8K, split
+	 * into 7.5K and 512b pieces.
+	 */
+	len = (le32_to_cpu(ap->prd[idx].flags_len) & ~ATA_PRD_EOT) & 0xffff;
+	if (len == 8192) {
+		addr = le32_to_cpu(ap->prd[idx].addr);
+		ap->prd[idx].flags_len = cpu_to_le32(15 * 512);
+
+		ap->prd[idx].addr = cpu_to_le32(addr + (15 * 512));
+		ap->prd[idx].flags_len = cpu_to_le32(512 | ATA_PRD_EOT);
+	}
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -258,15 +280,6 @@
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

--------------050505090508020103000408
Content-Type: application/x-bzip2;
 name="sata_sil.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sata_sil.c.bz2"

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
--------------050505090508020103000408--

