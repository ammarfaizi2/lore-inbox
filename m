Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVKLRzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVKLRzs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVKLRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:55:48 -0500
Received: from havoc.gtf.org ([69.61.125.42]:64992 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932436AbVKLRzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:55:47 -0500
Date: Sat, 12 Nov 2005 12:55:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Marvell SATA fixes; disable 50XX
Message-ID: <20051112175543.GA19199@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just checked in the following into the 'marv' branch of
rsync://rsync.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Unfortunately my own 60XX still doesn't work.  I get
>ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
>ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
>ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
>ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
>ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
>ATA: abnormal status 0x80 on port 0xFFFFC2001012411C
>ata4: PIO error
>ata4: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
>ata4: no dma
>ata4: dev 0 not supported, ignoring

when I boot.  I think some users get this too.


Also, as previously discussed, sata_mv doesn't even attempt to implement
50XX support, so we should definitely disable it (for now) in the PCI
table.


 drivers/scsi/Kconfig   |    2 
 drivers/scsi/sata_mv.c |  372 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 320 insertions(+), 54 deletions(-)


Jeff Garzik:
      [libata sata_mv] minor fixes
      [libata sata_mv] trim trailing whitespace
      [libata sata_mv] note driver is "HIGHLY EXPERIMENTAL" in Kconfig
      [libata sata_mv] implement a bunch of errata workarounds


diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 84c42c4..20dd85a 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -497,7 +497,7 @@ config SCSI_ATA_PIIX
 	  If unsure, say N.
 
 config SCSI_SATA_MV
-	tristate "Marvell SATA support"
+	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 257c128..b1696e3 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1,7 +1,7 @@
 /*
  * sata_mv.c - Marvell SATA support
  *
- * Copyright 2005: EMC Corporation, all rights reserved. 
+ * Copyright 2005: EMC Corporation, all rights reserved.
  *
  * Please ALWAYS copy linux-ide@vger.kernel.org on emails.
  *
@@ -50,6 +50,8 @@ enum {
 	MV_PCI_REG_BASE		= 0,
 	MV_IRQ_COAL_REG_BASE	= 0x18000,	/* 6xxx part only */
 	MV_SATAHC0_REG_BASE	= 0x20000,
+	MV_GPIO_PORT_CTL	= 0x104f0,
+	MV_RESET_CFG		= 0x180d8,
 
 	MV_PCI_REG_SZ		= MV_MAJOR_REG_AREA_SZ,
 	MV_SATAHC_REG_SZ	= MV_MAJOR_REG_AREA_SZ,
@@ -72,11 +74,6 @@ enum {
 	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
 	MV_PORT_PRIV_DMA_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ + MV_SG_TBL_SZ),
 
-	/* Our DMA boundary is determined by an ePRD being unable to handle
-	 * anything larger than 64KB
-	 */
-	MV_DMA_BOUNDARY		= 0xffffU,
-
 	MV_PORTS_PER_HC		= 4,
 	/* == (port / MV_PORTS_PER_HC) to determine HC from 0-7 port */
 	MV_PORT_HC_SHIFT	= 2,
@@ -89,7 +86,7 @@ enum {
 	MV_FLAG_GLBL_SFT_RST	= (1 << 28),  /* Global Soft Reset support */
 	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO),
-	MV_6XXX_FLAGS		= (MV_FLAG_IRQ_COALESCE | 
+	MV_6XXX_FLAGS		= (MV_FLAG_IRQ_COALESCE |
 				   MV_FLAG_GLBL_SFT_RST),
 
 	chip_504x		= 0,
@@ -134,7 +131,7 @@ enum {
 	SELF_INT		= (1 << 23),
 	TWSI_INT		= (1 << 24),
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
-	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE | 
+	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
 
@@ -153,6 +150,11 @@ enum {
 	/* SATA registers */
 	SATA_STATUS_OFS		= 0x300,  /* ctrl, err regs follow status */
 	SATA_ACTIVE_OFS		= 0x350,
+	PHY_MODE4		= 0x314,
+	PHY_MODE2		= 0x330,
+	SATA_INTERFACE_CTL	= 0x050,
+
+	MV_M2_PREAMP_MASK	= 0x7e0,
 
 	/* Port registers */
 	EDMA_CFG_OFS		= 0,
@@ -182,17 +184,16 @@ enum {
 	EDMA_ERR_LNK_CTRL_TX	= (0x1f << 21),
 	EDMA_ERR_LNK_DATA_TX	= (0x1f << 26),
 	EDMA_ERR_TRANS_PROTO	= (1 << 31),
-	EDMA_ERR_FATAL		= (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR | 
+	EDMA_ERR_FATAL		= (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR |
 				   EDMA_ERR_DEV_DCON | EDMA_ERR_CRBQ_PAR |
 				   EDMA_ERR_CRPB_PAR | EDMA_ERR_INTRL_PAR |
-				   EDMA_ERR_IORDY | EDMA_ERR_LNK_CTRL_RX_2 | 
+				   EDMA_ERR_IORDY | EDMA_ERR_LNK_CTRL_RX_2 |
 				   EDMA_ERR_LNK_DATA_RX |
-				   EDMA_ERR_LNK_DATA_TX | 
+				   EDMA_ERR_LNK_DATA_TX |
 				   EDMA_ERR_TRANS_PROTO),
 
 	EDMA_REQ_Q_BASE_HI_OFS	= 0x10,
 	EDMA_REQ_Q_IN_PTR_OFS	= 0x14,		/* also contains BASE_LO */
-	EDMA_REQ_Q_BASE_LO_MASK	= 0xfffffc00U,
 
 	EDMA_REQ_Q_OUT_PTR_OFS	= 0x18,
 	EDMA_REQ_Q_PTR_SHIFT	= 5,
@@ -200,7 +201,6 @@ enum {
 	EDMA_RSP_Q_BASE_HI_OFS	= 0x1c,
 	EDMA_RSP_Q_IN_PTR_OFS	= 0x20,
 	EDMA_RSP_Q_OUT_PTR_OFS	= 0x24,		/* also contains BASE_LO */
-	EDMA_RSP_Q_BASE_LO_MASK	= 0xffffff00U,
 	EDMA_RSP_Q_PTR_SHIFT	= 3,
 
 	EDMA_CMD_OFS		= 0x28,
@@ -208,14 +208,37 @@ enum {
 	EDMA_DS			= (1 << 1),
 	ATA_RST			= (1 << 2),
 
+	EDMA_ARB_CFG		= 0x38,
+	EDMA_NO_SNOOP		= (1 << 6),
+
 	/* Host private flags (hp_flags) */
 	MV_HP_FLAG_MSI		= (1 << 0),
+	MV_HP_ERRATA_60X1A1	= (1 << 1),
+	MV_HP_ERRATA_60X1B0	= (1 << 2),
+	MV_HP_ERRATA_50XXB0	= (1 << 3),
+	MV_HP_ERRATA_50XXB1	= (1 << 4),
+	MV_HP_ERRATA_50XXB2	= (1 << 5),
+	MV_HP_50XX		= (1 << 6),
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),
 	MV_PP_FLAG_EDMA_DS_ACT	= (1 << 1),
 };
 
+#define IS_50XX(hpriv) ((hpriv)->hp_flags & MV_HP_50XX)
+#define IS_60XX(hpriv) (((hpriv)->hp_flags & MV_HP_50XX) == 0)
+
+enum {
+	/* Our DMA boundary is determined by an ePRD being unable to handle
+	 * anything larger than 64KB
+	 */
+	MV_DMA_BOUNDARY		= 0xffffU,
+
+	EDMA_REQ_Q_BASE_LO_MASK	= 0xfffffc00U,
+
+	EDMA_RSP_Q_BASE_LO_MASK	= 0xffffff00U,
+};
+
 /* Command ReQuest Block: 32B */
 struct mv_crqb {
 	u32			sg_addr;
@@ -252,8 +275,14 @@ struct mv_port_priv {
 	u32			pp_flags;
 };
 
+struct mv_port_signal {
+	u32			amps;
+	u32			pre;
+};
+
 struct mv_host_priv {
 	u32			hp_flags;
+	struct mv_port_signal	signal[8];
 };
 
 static void mv_irq_clear(struct ata_port *ap);
@@ -341,7 +370,7 @@ static struct ata_port_info mv_port_info
 	},
 	{  /* chip_608x */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS | 
+		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				   MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -350,10 +379,12 @@ static struct ata_port_info mv_port_info
 };
 
 static const struct pci_device_id mv_pci_tbl[] = {
+#if 0 /* unusably broken right now */
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_508x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5081), 0, 0, chip_508x},
+#endif
 
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
@@ -389,7 +420,7 @@ static inline void __iomem *mv_hc_base(v
 static inline void __iomem *mv_port_base(void __iomem *base, unsigned int port)
 {
 	return (mv_hc_base(base, port >> MV_PORT_HC_SHIFT) +
-		MV_SATAHC_ARBTR_REG_SZ + 
+		MV_SATAHC_ARBTR_REG_SZ +
 		((port & MV_PORT_MASK) * MV_PORT_REG_SZ));
 }
 
@@ -398,9 +429,9 @@ static inline void __iomem *mv_ap_base(s
 	return mv_port_base(ap->host_set->mmio_base, ap->port_no);
 }
 
-static inline int mv_get_hc_count(unsigned long hp_flags)
+static inline int mv_get_hc_count(unsigned long host_flags)
 {
-	return ((hp_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
+	return ((host_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
 }
 
 static void mv_irq_clear(struct ata_port *ap)
@@ -452,7 +483,7 @@ static void mv_stop_dma(struct ata_port 
 	} else {
 		assert(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
   	}
-	
+
 	/* now properly wait for the eDMA to stop */
 	for (i = 1000; i > 0; i--) {
 		reg = readl(port_mmio + EDMA_CMD_OFS);
@@ -503,7 +534,7 @@ static void mv_dump_all_regs(void __iome
 			     struct pci_dev *pdev)
 {
 #ifdef ATA_DEBUG
-	void __iomem *hc_base = mv_hc_base(mmio_base, 
+	void __iomem *hc_base = mv_hc_base(mmio_base,
 					   port >> MV_PORT_HC_SHIFT);
 	void __iomem *port_base;
 	int start_port, num_ports, p, start_hc, num_hcs, hc;
@@ -517,7 +548,7 @@ static void mv_dump_all_regs(void __iome
 		start_port = port;
 		num_ports = num_hcs = 1;
 	}
-	DPRINTK("All registers for port(s) %u-%u:\n", start_port, 
+	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
 		num_ports > 1 ? num_ports - 1 : start_port);
 
 	if (NULL != pdev) {
@@ -690,6 +721,7 @@ static inline void mv_priv_free(struct m
 static int mv_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	void *mem;
@@ -701,7 +733,7 @@ static int mv_port_start(struct ata_port
 		goto err_out;
 	memset(pp, 0, sizeof(*pp));
 
-	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma, 
+	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
 				 GFP_KERNEL);
 	if (!mem)
 		goto err_out_pp;
@@ -711,7 +743,7 @@ static int mv_port_start(struct ata_port
 	if (rc)
 		goto err_out_priv;
 
-	/* First item in chunk of DMA memory: 
+	/* First item in chunk of DMA memory:
 	 * 32-slot command request table (CRQB), 32 bytes each in size
 	 */
 	pp->crqb = mem;
@@ -719,7 +751,7 @@ static int mv_port_start(struct ata_port
 	mem += MV_CRQB_Q_SZ;
 	mem_dma += MV_CRQB_Q_SZ;
 
-	/* Second item: 
+	/* Second item:
 	 * 32-slot command response table (CRPB), 8 bytes each in size
 	 */
 	pp->crpb = mem;
@@ -733,20 +765,29 @@ static int mv_port_start(struct ata_port
 	pp->sg_tbl = mem;
 	pp->sg_tbl_dma = mem_dma;
 
-	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT | 
+	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT |
 		 EDMA_CFG_WR_BUFF_LEN, port_mmio + EDMA_CFG_OFS);
 
 	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
-	writelfl(pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK, 
+	writelfl(pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
 	writelfl(0, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
 	writelfl(0, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
 
 	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
-	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK, 
+	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
+	if (hpriv->hp_flags & MV_HP_ERRATA_60X1A1) {
+		u32 new_tmp, tmp;
+
+		new_tmp = tmp = readl(port_mmio + EDMA_ARB_CFG);
+		new_tmp &= ~EDMA_NO_SNOOP;
+		if (new_tmp != tmp)
+			writel(new_tmp, port_mmio + EDMA_ARB_CFG);
+	}
+
 	pp->req_producer = pp->rsp_consumer = 0;
 
 	/* Don't turn on EDMA here...do it before DMA commands only.  Else
@@ -859,7 +900,7 @@ static void mv_qc_prep(struct ata_queued
 	}
 
 	/* the req producer index should be the same as we remember it */
-	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >> 
+	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
 		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->req_producer);
 
@@ -871,9 +912,9 @@ static void mv_qc_prep(struct ata_queued
 	assert(MV_MAX_Q_DEPTH > qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	pp->crqb[pp->req_producer].sg_addr = 
+	pp->crqb[pp->req_producer].sg_addr =
 		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	pp->crqb[pp->req_producer].sg_addr_hi = 
+	pp->crqb[pp->req_producer].sg_addr_hi =
 		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
 	pp->crqb[pp->req_producer].ctrl_flags = cpu_to_le16(flags);
 
@@ -896,7 +937,7 @@ static void mv_qc_prep(struct ata_queued
 #ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */
 	case ATA_CMD_FPDMA_READ:
 	case ATA_CMD_FPDMA_WRITE:
-		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0); 
+		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0);
 		mv_crqb_pack_cmd(cw++, tf->feature, ATA_REG_FEATURE, 0);
 		break;
 #endif				/* FIXME: remove this line when NCQ added */
@@ -962,7 +1003,7 @@ static int mv_qc_issue(struct ata_queued
 	       pp->req_producer);
 	/* until we do queuing, the queue should be empty at this point */
 	assert(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >> 
+	       ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
 		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
 	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
@@ -999,15 +1040,15 @@ static u8 mv_get_crpb_status(struct ata_
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* the response consumer index should be the same as we remember it */
-	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == 
+	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
-	
+
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
-	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> 
-		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == 
+	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
+		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
@@ -1131,7 +1172,7 @@ static void mv_host_intr(struct ata_host
 			err_mask |= AC_ERR_OTHER;
 			handled++;
 		}
-		
+
 		if (handled && ap) {
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (NULL != qc) {
@@ -1146,7 +1187,7 @@ static void mv_host_intr(struct ata_host
 }
 
 /**
- *      mv_interrupt - 
+ *      mv_interrupt -
  *      @irq: unused
  *      @dev_instance: private data; in this case the host structure
  *      @regs: unused
@@ -1156,7 +1197,7 @@ static void mv_host_intr(struct ata_host
  *      routine to handle.  Also check for PCI errors which are only
  *      reported here.
  *
- *      LOCKING: 
+ *      LOCKING:
  *      This routine holds the host_set lock while processing pending
  *      interrupts.
  */
@@ -1202,6 +1243,52 @@ static irqreturn_t mv_interrupt(int irq,
 	return IRQ_RETVAL(handled);
 }
 
+static void mv_phy_errata5(struct ata_port *ap)
+{
+	/* FIXME */
+}
+
+static void mv_phy_errata6(struct ata_port *ap)
+{
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
+	u32 hp_flags = hpriv->hp_flags;
+	void __iomem *port_mmio = mv_ap_base(ap);
+	int fix_phy_mode4 =
+		hp_flags & (MV_HP_ERRATA_60X1A1 | MV_HP_ERRATA_60X1B0);
+	u32 m2;
+
+	if (fix_phy_mode4) {
+		u32 tmp, m4;
+
+		m4 = readl(port_mmio + PHY_MODE4);
+		tmp = readl(port_mmio + 0x310);
+
+		m4 = (m4 & ~(1 << 1)) | (1 << 0);
+
+		writel(m4, port_mmio + PHY_MODE4);
+		writel(tmp, port_mmio + 0x310);
+	}
+
+	/* Revert values of pre-emphasis and signal amps to the saved ones */
+	m2 = readl(port_mmio + PHY_MODE2);
+
+	m2 &= ~MV_M2_PREAMP_MASK;
+	m2 |= hpriv->signal[ap->port_no].amps;
+	m2 |= hpriv->signal[ap->port_no].pre;
+
+	writel(m2, port_mmio + PHY_MODE2);
+}
+
+static void mv_phy_errata(struct ata_port *ap)
+{
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
+
+	if (IS_50XX(hpriv))
+		mv_phy_errata5(ap);
+	else
+		mv_phy_errata6(ap);
+}
+
 /**
  *      mv_phy_reset - Perform eDMA reset followed by COMRESET
  *      @ap: ATA channel to manipulate
@@ -1215,6 +1302,8 @@ static irqreturn_t mv_interrupt(int irq,
  */
 static void mv_phy_reset(struct ata_port *ap)
 {
+	struct mv_port_priv *pp	= ap->private_data;
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct ata_taskfile tf;
 	struct ata_device *dev = &ap->device[0];
@@ -1225,6 +1314,13 @@ static void mv_phy_reset(struct ata_port
 	mv_stop_dma(ap);
 
 	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
+
+	if (IS_60XX(hpriv)) {
+		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
+		ifctl |= (1 << 12) | (1 << 7);
+		writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
+	}
+
 	udelay(25);		/* allow reset propagation */
 
 	/* Spec never mentions clearing the bit.  Marvell's driver does
@@ -1232,7 +1328,9 @@ static void mv_phy_reset(struct ata_port
 	 */
 	writelfl(0, port_mmio + EDMA_CMD_OFS);
 
-	VPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
+	mv_phy_errata(ap);
+
+	DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
@@ -1247,7 +1345,9 @@ static void mv_phy_reset(struct ata_port
 			break;
 	} while (time_before(jiffies, timeout));
 
-	VPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
+	mv_scr_write(ap, SCR_ERROR, mv_scr_read(ap, SCR_ERROR));
+
+	DPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
@@ -1271,6 +1371,11 @@ static void mv_phy_reset(struct ata_port
 		VPRINTK("Port disabled post-sig: No device present.\n");
 		ata_port_disable(ap);
 	}
+
+	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+
+	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
+
 	VPRINTK("EXIT\n");
 }
 
@@ -1291,12 +1396,12 @@ static void mv_eng_timeout(struct ata_po
 
 	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
 	DPRINTK("All regs @ start of eng_timeout\n");
-	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no, 
+	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no,
 			 to_pci_dev(ap->host_set->dev));
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
         printk(KERN_ERR "mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
-	       ap->host_set->mmio_base, ap, qc, qc->scsicmd, 
+	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
 	mv_err_intr(ap);
@@ -1336,17 +1441,17 @@ static void mv_port_init(struct ata_iopo
 	unsigned long shd_base = (unsigned long) port_mmio + SHD_BLK_OFS;
 	unsigned serr_ofs;
 
-	/* PIO related setup 
+	/* PIO related setup
 	 */
 	port->data_addr = shd_base + (sizeof(u32) * ATA_REG_DATA);
-	port->error_addr = 
+	port->error_addr =
 		port->feature_addr = shd_base + (sizeof(u32) * ATA_REG_ERR);
 	port->nsect_addr = shd_base + (sizeof(u32) * ATA_REG_NSECT);
 	port->lbal_addr = shd_base + (sizeof(u32) * ATA_REG_LBAL);
 	port->lbam_addr = shd_base + (sizeof(u32) * ATA_REG_LBAM);
 	port->lbah_addr = shd_base + (sizeof(u32) * ATA_REG_LBAH);
 	port->device_addr = shd_base + (sizeof(u32) * ATA_REG_DEVICE);
-	port->status_addr = 
+	port->status_addr =
 		port->command_addr = shd_base + (sizeof(u32) * ATA_REG_STATUS);
 	/* special case: control/altstatus doesn't have ATA_REG_ address */
 	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST_OFS;
@@ -1362,14 +1467,158 @@ static void mv_port_init(struct ata_iopo
 	/* unmask all EDMA error interrupts */
 	writelfl(~0, port_mmio + EDMA_ERR_IRQ_MASK_OFS);
 
-	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n", 
+	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n",
 		readl(port_mmio + EDMA_CFG_OFS),
 		readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS),
 		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));
 }
 
+static void mv_enable_leds5(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	/* FIXME */
+}
+
+static void mv_enable_leds6(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	if (hpriv->hp_flags & MV_HP_ERRATA_60X1A1)
+		writel(0x00020060, mmio + MV_GPIO_PORT_CTL);
+
+	else if (hpriv->hp_flags & MV_HP_ERRATA_60X1B0)
+		writel(0x00000060, mmio + MV_GPIO_PORT_CTL);
+}
+
+static void mv_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	if (IS_50XX(hpriv))
+		mv_enable_leds5(hpriv, mmio);
+	else
+		mv_enable_leds6(hpriv, mmio);
+}
+
+static void mv_cfg_signal5(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio)
+{
+	/* FIXME */
+}
+
+static void mv_cfg_signal6(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio)
+{
+	void __iomem *port_mmio;
+	u32 tmp;
+
+	if (hpriv->hp_flags & MV_HP_ERRATA_60X1A1) {
+		hpriv->signal[idx].amps = 0x5 << 8;
+		hpriv->signal[idx].pre = 0x3 << 5;
+		return;
+	}
+
+	assert (hpriv->hp_flags & MV_HP_ERRATA_60X1B0);
+
+	tmp = readl(mmio + MV_RESET_CFG);
+	if ((tmp & (1 << 0)) == 0) {
+		hpriv->signal[idx].amps = 0x4 << 8;
+		hpriv->signal[idx].pre = 0x1 << 5;
+		return;
+	}
+
+	port_mmio = mv_port_base(mmio, idx);
+	tmp = readl(port_mmio + PHY_MODE2);
+
+	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
+	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
+}
+
+static int mv_cfg_errata(struct pci_dev *pdev, struct mv_host_priv *hpriv,
+			 unsigned int board_idx)
+{
+	u8 rev_id;
+	u32 hp_flags = hpriv->hp_flags;
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev_id);
+
+	switch(board_idx) {
+	case chip_504x:
+	case chip_508x:
+		hp_flags |= MV_HP_50XX;
+
+		if (pdev->device == 0x5080) {
+			switch (rev_id) {
+			case 0x0:
+				dev_printk(KERN_WARNING, &pdev->dev,
+					   "Applying B0 workarounds to unknown rev 0\n");
+				/* fall through */
+			case 0x1:
+				hp_flags |= MV_HP_ERRATA_50XXB0;
+				break;
+			case 0x2:
+				hp_flags |= MV_HP_ERRATA_50XXB1;
+				break;
+			case 0x3:
+				hp_flags |= MV_HP_ERRATA_50XXB2;
+				break;
+			default:
+				dev_printk(KERN_WARNING, &pdev->dev,
+					   "Applying B2 workarounds to future rev\n");
+				hp_flags |= MV_HP_ERRATA_50XXB2;
+				break;
+			}
+		} else {
+			switch (rev_id) {
+			case 0x0:
+				hp_flags |= MV_HP_ERRATA_50XXB0;
+				break;
+			case 0x1:
+				dev_printk(KERN_WARNING, &pdev->dev,
+			          "Applying B1 workarounds to unknown rev 1\n");
+				/* fall through */
+			case 0x2:
+				hp_flags |= MV_HP_ERRATA_50XXB1;
+				break;
+			default:
+				dev_printk(KERN_WARNING, &pdev->dev,
+				   "Applying B2 workarounds to future rev\n");
+				/* fall through */
+			case 0x3:
+				hp_flags |= MV_HP_ERRATA_50XXB2;
+				break;
+			}
+		}
+		break;
+
+	case chip_604x:
+	case chip_608x:
+		switch (rev_id) {
+		case 0x0:
+			dev_printk(KERN_WARNING, &pdev->dev,
+			          "Applying A1 workarounds to unknown rev 0\n");
+			/* fall through */
+		case 0x1:
+			hp_flags |= MV_HP_ERRATA_60X1A1;
+			break;
+		default:
+			dev_printk(KERN_WARNING, &pdev->dev,
+				   "Applying B0 workarounds to future rev\n");
+			/* fall through */
+		case 0x2:
+			hp_flags |= MV_HP_ERRATA_60X1B0;
+			break;
+		}
+		break;
+
+	default:
+		printk(KERN_ERR DRV_NAME ": BUG: invalid board index %u\n", board_idx);
+		return 1;
+	}
+
+	hpriv->hp_flags = hp_flags;
+
+	return 0;
+}
+
 /**
  *      mv_host_init - Perform some early initialization of the host.
+ *	@pdev: host PCI device
  *      @probe_ent: early data struct representing the host
  *
  *      If possible, do an early global reset of the host.  Then do
@@ -1378,20 +1627,36 @@ static void mv_port_init(struct ata_iopo
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_host_init(struct ata_probe_ent *probe_ent)
+static int mv_host_init(struct pci_dev *pdev, struct ata_probe_ent *probe_ent,
+			unsigned int board_idx)
 {
 	int rc = 0, n_hc, port, hc;
 	void __iomem *mmio = probe_ent->mmio_base;
 	void __iomem *port_mmio;
+	struct mv_host_priv *hpriv = probe_ent->private_data;
+
+	rc = mv_cfg_errata(pdev, hpriv, board_idx);
+	if (rc)
+		goto done;
 
-	if ((MV_FLAG_GLBL_SFT_RST & probe_ent->host_flags) && 
+	n_hc = mv_get_hc_count(probe_ent->host_flags);
+	probe_ent->n_ports = MV_PORTS_PER_HC * n_hc;
+
+	if (IS_50XX(hpriv)) {
+		for (port = 0; port < probe_ent->n_ports; port++)
+			mv_cfg_signal5(hpriv, port, mmio);
+	} else {
+		for (port = 0; port < probe_ent->n_ports; port++)
+			mv_cfg_signal6(hpriv, port, mmio);
+	}
+
+	if ((MV_FLAG_GLBL_SFT_RST & probe_ent->host_flags) &&
 	    mv_global_soft_reset(probe_ent->mmio_base)) {
 		rc = 1;
 		goto done;
 	}
 
-	n_hc = mv_get_hc_count(probe_ent->host_flags);
-	probe_ent->n_ports = MV_PORTS_PER_HC * n_hc;
+	mv_enable_leds(hpriv, mmio);
 
 	for (port = 0; port < probe_ent->n_ports; port++) {
 		port_mmio = mv_port_base(mmio, port);
@@ -1418,11 +1683,12 @@ static int mv_host_init(struct ata_probe
 	writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
 
 	VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
-		"PCI int cause/mask=0x%08x/0x%08x\n", 
+		"PCI int cause/mask=0x%08x/0x%08x\n",
 		readl(mmio + HC_MAIN_IRQ_CAUSE_OFS),
 		readl(mmio + HC_MAIN_IRQ_MASK_OFS),
 		readl(mmio + PCI_IRQ_CAUSE_OFS),
 		readl(mmio + PCI_IRQ_MASK_OFS));
+
 done:
 	return rc;
 }
@@ -1458,7 +1724,7 @@ static void mv_print_info(struct ata_pro
 
 	dev_printk(KERN_INFO, &pdev->dev,
 	       "%u slots %u ports %s mode IRQ via %s\n",
-	       (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports, 
+	       (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports,
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }
 
@@ -1528,7 +1794,7 @@ static int mv_init_one(struct pci_dev *p
 	probe_ent->private_data = hpriv;
 
 	/* initialize adapter */
-	rc = mv_host_init(probe_ent);
+	rc = mv_host_init(pdev, probe_ent, board_idx);
 	if (rc) {
 		goto err_out_hpriv;
 	}
