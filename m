Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbUCOSBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCOSBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:01:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53399 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262645AbUCOSBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:01:00 -0500
Message-ID: <4055EF4F.8060803@pobox.com>
Date: Mon, 15 Mar 2004 13:00:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] a better Silicon Image SATA mod15 write fix?
References: <4055D032.1090708@pobox.com>
In-Reply-To: <4055D032.1090708@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------050607000402000409030400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050607000402000409030400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And here already is an updated patch :)


--------------050607000402000409030400
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.14 vs edited =====
--- 1.14/drivers/scsi/sata_sil.c	Sun Mar 14 23:32:15 2004
+++ edited/drivers/scsi/sata_sil.c	Mon Mar 15 12:55:55 2004
@@ -79,6 +79,7 @@
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void sil_fill_sg(struct ata_queued_cmd *qc);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -123,13 +124,13 @@
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
@@ -144,7 +145,7 @@
 	.phy_reset		= sata_phy_reset,
 	.phy_config		= pata_phy_config,	/* not a typo */
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.fill_sg		= sil_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= sil_scr_read,
@@ -210,6 +211,39 @@
 	void *mmio = (void *) sil_scr_addr(ap, sc_reg);
 	if (mmio)
 		writel(val, mmio);
+}
+
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
 }
 
 /**

--------------050607000402000409030400
Content-Type: application/x-bzip2;
 name="sata_sil.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sata_sil.c.bz2"

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
IlEBCMlAJTVAFFSUf/F3JFOFCQ/S2Wcg
--------------050607000402000409030400--

