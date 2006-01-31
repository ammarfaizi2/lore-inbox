Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWAaH4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWAaH4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWAaH4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:56:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:33189 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965055AbWAaH4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:56:07 -0500
Date: Tue, 31 Jan 2006 02:55:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sata_mv: add 6042 (Gen 2E) support
Message-ID: <20060131075554.GA21331@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got the Marvell 88SX6042 SATA controller going, and it should
be a few short steps more to make 7042 work.  See the patch below.
It's against libata-dev.git#upstream, but should apply to any recent
sata_mv.

This is the bare minimum needed to get 6042 going.  There is still some
Gen 2E support that needs to be added, as well as several errata
workarounds for previous generations (50xx, 60xx).  Even though the
driver is passing tests on my local devel platform, I still classify it
as 'highly experimental' until it gets more attention, and field
testing.

Also note that this work exposed some bugs in the existing EDMA
configuration, which are now fixed in this patch.  50xx and 60xx users
should be pleased.

As an aside, I hope that someone at Marvell or EMC or whereever picks
up the development and maintenance of sata_mv driver, because it needs
fleshing out.  A developer will definitely be needed for NCQ and Port
Multiplier support, as I don't know when I'll be able to get to it.



diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index d9a554c..6e5bcb7 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -228,7 +228,9 @@ enum {
 	MV_HP_ERRATA_50XXB2	= (1 << 2),
 	MV_HP_ERRATA_60X1B2	= (1 << 3),
 	MV_HP_ERRATA_60X1C0	= (1 << 4),
-	MV_HP_50XX		= (1 << 5),
+	MV_HP_ERRATA_XX42A0	= (1 << 5),
+	MV_HP_50XX		= (1 << 6),
+	MV_HP_GEN_IIE		= (1 << 7),
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),
@@ -237,6 +239,9 @@ enum {
 
 #define IS_50XX(hpriv) ((hpriv)->hp_flags & MV_HP_50XX)
 #define IS_60XX(hpriv) (((hpriv)->hp_flags & MV_HP_50XX) == 0)
+#define IS_GEN_I(hpriv) IS_50XX(hpriv)
+#define IS_GEN_II(hpriv) IS_60XX(hpriv)
+#define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
 
 enum {
 	/* Our DMA boundary is determined by an ePRD being unable to handle
@@ -255,6 +260,8 @@ enum chip_type {
 	chip_5080,
 	chip_604x,
 	chip_608x,
+	chip_6042,
+	chip_7042,
 };
 
 /* Command ReQuest Block: 32B */
@@ -265,6 +272,14 @@ struct mv_crqb {
 	u16			ata_cmd[11];
 };
 
+struct mv_crqb_iie {
+	u32			addr;
+	u32			addr_hi;
+	u32			flags;
+	u32			len;
+	u32			ata_cmd[4];
+};
+
 /* Command ResPonse Block: 8B */
 struct mv_crpb {
 	u16			id;
@@ -328,6 +343,7 @@ static void mv_host_stop(struct ata_host
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
+static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t mv_interrupt(int irq, void *dev_instance,
 				struct pt_regs *regs);
@@ -430,6 +446,33 @@ static const struct ata_port_operations 
 	.host_stop		= mv_host_stop,
 };
 
+static const struct ata_port_operations mv_iie_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= mv_phy_reset,
+
+	.qc_prep		= mv_qc_prep_iie,
+	.qc_issue		= mv_qc_issue,
+
+	.eng_timeout		= mv_eng_timeout,
+
+	.irq_handler		= mv_interrupt,
+	.irq_clear		= mv_irq_clear,
+
+	.scr_read		= mv_scr_read,
+	.scr_write		= mv_scr_write,
+
+	.port_start		= mv_port_start,
+	.port_stop		= mv_port_stop,
+	.host_stop		= mv_host_stop,
+};
+
 static const struct ata_port_info mv_port_info[] = {
 	{  /* chip_504x */
 		.sht		= &mv_sht,
@@ -467,6 +510,21 @@ static const struct ata_port_info mv_por
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv6_ops,
 	},
+	{  /* chip_6042 */
+		.sht		= &mv_sht,
+		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &mv_iie_ops,
+	},
+	{  /* chip_7042 */
+		.sht		= &mv_sht,
+		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				   MV_FLAG_DUAL_HC),
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &mv_iie_ops,
+	},
 };
 
 static const struct pci_device_id mv_pci_tbl[] = {
@@ -477,6 +535,7 @@ static const struct pci_device_id mv_pci
 
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6042), 0, 0, chip_6042},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
 
@@ -767,6 +826,33 @@ static inline void mv_priv_free(struct m
 	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
 }
 
+static void mv_edma_cfg(struct mv_host_priv *hpriv, void __iomem *port_mmio)
+{
+	u32 cfg = readl(port_mmio + EDMA_CFG_OFS);
+
+	/* set up non-NCQ EDMA configuration */
+	cfg &= ~0x1f;		/* clear queue depth */
+	cfg &= ~EDMA_CFG_NCQ;	/* clear NCQ mode */
+	cfg &= ~(1 << 9);	/* disable equeue */
+
+	if (IS_GEN_I(hpriv))
+		cfg |= (1 << 8);	/* enab config burst size mask */
+
+	else if (IS_GEN_II(hpriv))
+		cfg |= EDMA_CFG_RD_BRST_EXT | EDMA_CFG_WR_BUFF_LEN;
+
+	else if (IS_GEN_IIE(hpriv)) {
+		cfg |= (1 << 23);	/* dis RX PM port mask */
+		cfg &= ~(1 << 16);	/* dis FIS-based switching (for now) */
+		cfg &= ~(1 << 19);	/* dis 128-entry queue (for now?) */
+		cfg |= (1 << 18);	/* enab early completion */
+		cfg |= (1 << 17);	/* enab host q cache */
+		cfg |= (1 << 22);	/* enab cutthrough */
+	}
+
+	writelfl(cfg, port_mmio + EDMA_CFG_OFS);
+}
+
 /**
  *      mv_port_start - Port specific init/start routine.
  *      @ap: ATA channel to manipulate
@@ -780,6 +866,7 @@ static inline void mv_priv_free(struct m
 static int mv_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	void *mem;
@@ -823,17 +910,26 @@ static int mv_port_start(struct ata_port
 	pp->sg_tbl = mem;
 	pp->sg_tbl_dma = mem_dma;
 
-	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT |
-		 EDMA_CFG_WR_BUFF_LEN, port_mmio + EDMA_CFG_OFS);
+	mv_edma_cfg(hpriv, port_mmio);
 
 	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
 	writelfl(pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
-	writelfl(0, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
-	writelfl(0, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
+	if (hpriv->hp_flags & MV_HP_ERRATA_XX42A0)
+		writelfl(pp->crqb_dma & 0xffffffff,
+			 port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
+	else
+		writelfl(0, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
 
 	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
+
+	if (hpriv->hp_flags & MV_HP_ERRATA_XX42A0)
+		writelfl(pp->crpb_dma & 0xffffffff,
+			 port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
+	else
+		writelfl(0, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
+
 	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
@@ -954,9 +1050,8 @@ static void mv_qc_prep(struct ata_queued
 	struct ata_taskfile *tf;
 	u16 flags = 0;
 
- 	if (ATA_PROT_DMA != qc->tf.protocol) {
+ 	if (ATA_PROT_DMA != qc->tf.protocol)
 		return;
-	}
 
 	/* the req producer index should be the same as we remember it */
 	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
@@ -965,9 +1060,8 @@ static void mv_qc_prep(struct ata_queued
 
 	/* Fill in command request block
 	 */
-	if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
-	}
 	assert(MV_MAX_Q_DEPTH > qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
@@ -1022,9 +1116,76 @@ static void mv_qc_prep(struct ata_queued
 	mv_crqb_pack_cmd(cw++, tf->device, ATA_REG_DEVICE, 0);
 	mv_crqb_pack_cmd(cw++, tf->command, ATA_REG_CMD, 1);	/* last */
 
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP)) {
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+	mv_fill_sg(qc);
+}
+
+/**
+ *      mv_qc_prep_iie - Host specific command preparation.
+ *      @qc: queued command to prepare
+ *
+ *      This routine simply redirects to the general purpose routine
+ *      if command is not DMA.  Else, it handles prep of the CRQB
+ *      (command request block), does some sanity checking, and calls
+ *      the SG load routine.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
+static void mv_qc_prep_iie(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct mv_port_priv *pp = ap->private_data;
+	struct mv_crqb_iie *crqb;
+	struct ata_taskfile *tf;
+	u32 flags = 0;
+
+ 	if (ATA_PROT_DMA != qc->tf.protocol)
+		return;
+
+	/* the req producer index should be the same as we remember it */
+	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
+		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
+	       pp->req_producer);
+
+	/* Fill in Gen IIE command request block
+	 */
+	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
+		flags |= CRQB_FLAG_READ;
+
+	assert(MV_MAX_Q_DEPTH > qc->tag);
+	flags |= qc->tag << CRQB_TAG_SHIFT;
+
+	crqb = (struct mv_crqb_iie *) &pp->crqb[pp->req_producer];
+	crqb->addr = cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
+	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
+	crqb->flags = cpu_to_le32(flags);
+
+	tf = &qc->tf;
+	crqb->ata_cmd[0] = cpu_to_le32(
+			(tf->command << 16) |
+			(tf->feature << 24)
+		);
+	crqb->ata_cmd[1] = cpu_to_le32(
+			(tf->lbal << 0) |
+			(tf->lbam << 8) |
+			(tf->lbah << 16) |
+			(tf->device << 24)
+		);
+	crqb->ata_cmd[2] = cpu_to_le32(
+			(tf->hob_lbal << 0) |
+			(tf->hob_lbam << 8) |
+			(tf->hob_lbah << 16) |
+			(tf->hob_feature << 24)
+		);
+	crqb->ata_cmd[3] = cpu_to_le32(
+			(tf->nsect << 0) |
+			(tf->hob_nsect << 8)
+		);
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
-	}
 	mv_fill_sg(qc);
 }
 
@@ -1674,6 +1835,12 @@ static void mv6_phy_errata(struct mv_hos
 	m2 |= hpriv->signal[port].pre;
 	m2 &= ~(1 << 16);
 
+	/* according to mvSata 3.6.1, some IIE values are fixed */
+	if (IS_GEN_IIE(hpriv)) {
+		m2 &= ~0xC30FF01F;
+		m2 |= 0x0000900F;
+	}
+
 	writel(m2, port_mmio + PHY_MODE2);
 }
 
@@ -1978,6 +2145,27 @@ static int mv_chip_id(struct pci_dev *pd
 		}
 		break;
 
+	case chip_7042:
+	case chip_6042:
+		hpriv->ops = &mv6xxx_ops;
+
+		hp_flags |= MV_HP_GEN_IIE;
+
+		switch (rev_id) {
+		case 0x0:
+			hp_flags |= MV_HP_ERRATA_XX42A0;
+			break;
+		case 0x1:
+			hp_flags |= MV_HP_ERRATA_60X1C0;
+			break;
+		default:
+			dev_printk(KERN_WARNING, &pdev->dev,
+			   "Applying 60X1C0 workarounds to unknown rev\n");
+			hp_flags |= MV_HP_ERRATA_60X1C0;
+			break;
+		}
+		break;
+
 	default:
 		printk(KERN_ERR DRV_NAME ": BUG: invalid board index %u\n", board_idx);
 		return 1;
