Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVKLSEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVKLSEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKLSEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:04:50 -0500
Received: from havoc.gtf.org ([69.61.125.42]:4833 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932459AbVKLSEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:04:48 -0500
Date: Sat, 12 Nov 2005 13:04:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fixes
Message-ID: <20051112180447.GA19820@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following fixes:

 drivers/scsi/ahci.c       |   32 +++++++++++++++++++++++++++-----
 drivers/scsi/sata_qstor.c |    9 ++++++---
 2 files changed, 33 insertions(+), 8 deletions(-)

Jeff Garzik:
      [libata ahci, qstor] fix miscount of scatter/gather entries
      [libata ahci] set port ATAPI bit correctly

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 57ef7ae..4e96ec5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -134,6 +134,7 @@ enum {
 				  PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
+	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
@@ -441,7 +442,7 @@ static void ahci_phy_reset(struct ata_po
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ata_taskfile tf;
 	struct ata_device *dev = &ap->device[0];
-	u32 tmp;
+	u32 new_tmp, tmp;
 
 	__sata_phy_reset(ap);
 
@@ -455,8 +456,21 @@ static void ahci_phy_reset(struct ata_po
 	tf.nsect	= (tmp)		& 0xff;
 
 	dev->class = ata_dev_classify(&tf);
-	if (!ata_dev_present(dev))
+	if (!ata_dev_present(dev)) {
 		ata_port_disable(ap);
+		return;
+	}
+
+	/* Make sure port's ATAPI bit is set appropriately */
+	new_tmp = tmp = readl(port_mmio + PORT_CMD);
+	if (dev->class == ATA_DEV_ATAPI)
+		new_tmp |= PORT_CMD_ATAPI;
+	else
+		new_tmp &= ~PORT_CMD_ATAPI;
+	if (new_tmp != tmp) {
+		writel(new_tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+	}
 }
 
 static u8 ahci_check_status(struct ata_port *ap)
@@ -474,11 +488,12 @@ static void ahci_tf_read(struct ata_port
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static void ahci_fill_sg(struct ata_queued_cmd *qc)
+static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	struct scatterlist *sg;
 	struct ahci_sg *ahci_sg;
+	unsigned int n_sg = 0;
 
 	VPRINTK("ENTER\n");
 
@@ -493,8 +508,12 @@ static void ahci_fill_sg(struct ata_queu
 		ahci_sg->addr = cpu_to_le32(addr & 0xffffffff);
 		ahci_sg->addr_hi = cpu_to_le32((addr >> 16) >> 16);
 		ahci_sg->flags_size = cpu_to_le32(sg_len - 1);
+
 		ahci_sg++;
+		n_sg++;
 	}
+
+	return n_sg;
 }
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
@@ -503,13 +522,14 @@ static void ahci_qc_prep(struct ata_queu
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
+	unsigned int n_elem;
 
 	/*
 	 * Fill in command slot information (currently only one slot,
 	 * slot 0, is currently since we don't do queueing)
 	 */
 
-	opts = (qc->n_elem << 16) | cmd_fis_len;
+	opts = cmd_fis_len;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi_taskfile(&qc->tf))
@@ -533,7 +553,9 @@ static void ahci_qc_prep(struct ata_queu
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
-	ahci_fill_sg(qc);
+	n_elem = ahci_fill_sg(qc);
+
+	pp->cmd_slot[0].opts |= cpu_to_le32(n_elem << 16);
 }
 
 static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index b2f6324..4a6d306 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -268,7 +268,7 @@ static void qs_scr_write (struct ata_por
 	writel(val, (void __iomem *)(ap->ioaddr.scr_addr + (sc_reg * 8)));
 }
 
-static void qs_fill_sg(struct ata_queued_cmd *qc)
+static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
@@ -296,6 +296,8 @@ static void qs_fill_sg(struct ata_queued
 					(unsigned long long)addr, len);
 		nelem++;
 	}
+
+	return nelem;
 }
 
 static void qs_qc_prep(struct ata_queued_cmd *qc)
@@ -304,6 +306,7 @@ static void qs_qc_prep(struct ata_queued
 	u8 dflags = QS_DF_PORD, *buf = pp->pkt;
 	u8 hflags = QS_HF_DAT | QS_HF_IEN | QS_HF_VLD;
 	u64 addr;
+	unsigned int nelem;
 
 	VPRINTK("ENTER\n");
 
@@ -313,7 +316,7 @@ static void qs_qc_prep(struct ata_queued
 		return;
 	}
 
-	qs_fill_sg(qc);
+	nelem = qs_fill_sg(qc);
 
 	if ((qc->tf.flags & ATA_TFLAG_WRITE))
 		hflags |= QS_HF_DIRO;
@@ -324,7 +327,7 @@ static void qs_qc_prep(struct ata_queued
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
 	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
-	*(__le32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
+	*(__le32 *)(&buf[ 8]) = cpu_to_le32(nelem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
 	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
 
