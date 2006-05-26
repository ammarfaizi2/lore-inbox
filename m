Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWEZNTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEZNTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWEZNTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:19:38 -0400
Received: from rtr.ca ([64.26.128.89]:56707 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750712AbWEZNTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:19:36 -0400
Message-ID: <44770065.8070907@rtr.ca>
Date: Fri, 26 May 2006 09:19:33 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alexandre.Bounine@tundra.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca> <20060526114245.GA32330@powerlinux.fr>
In-Reply-To: <20060526114245.GA32330@powerlinux.fr>
Content-Type: multipart/mixed;
 boundary="------------060807040308030703080806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060807040308030703080806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sven Luther wrote:
> On Fri, May 26, 2006 at 07:41:24AM -0400, Mark Lord wrote:
>> All of the relevant bits of "my work" are now in Jeff's upstream libata 
>> tree,
>> from the recently posted sata_mv patches.
> 
> Ok. can i use this tree with a 2.6.16 base ?

Not as-is.  Here (attached) is a patch for 2.6.16.17+ that updates
the sata_mv driver to the latest source.  Completely untested,
but it does compile.

I will hopefully test it later today, but in the meanwhile, have a go at it.

Cheers 


--------------060807040308030703080806
Content-Type: text/x-patch;
 name="sata_mv-2.6.16_backport.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_mv-2.6.16_backport.patch"

--- linux-2.6.16.17/drivers/scsi/sata_mv.c	2006-04-14 23:14:22.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-26 09:15:22.000000000 -0400
@@ -37,7 +37,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.5"
+#define DRV_VERSION	"0.7-backport"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -50,6 +50,12 @@
 
 	MV_PCI_REG_BASE		= 0,
 	MV_IRQ_COAL_REG_BASE	= 0x18000,	/* 6xxx part only */
+	MV_IRQ_COAL_CAUSE		= (MV_IRQ_COAL_REG_BASE + 0x08),
+	MV_IRQ_COAL_CAUSE_LO		= (MV_IRQ_COAL_REG_BASE + 0x88),
+	MV_IRQ_COAL_CAUSE_HI		= (MV_IRQ_COAL_REG_BASE + 0x8c),
+	MV_IRQ_COAL_THRESHOLD		= (MV_IRQ_COAL_REG_BASE + 0xcc),
+	MV_IRQ_COAL_TIME_THRESHOLD	= (MV_IRQ_COAL_REG_BASE + 0xd0),
+
 	MV_SATAHC0_REG_BASE	= 0x20000,
 	MV_FLASH_CTL		= 0x1046c,
 	MV_GPIO_PORT_CTL	= 0x104f0,
@@ -228,7 +234,9 @@
 	MV_HP_ERRATA_50XXB2	= (1 << 2),
 	MV_HP_ERRATA_60X1B2	= (1 << 3),
 	MV_HP_ERRATA_60X1C0	= (1 << 4),
-	MV_HP_50XX		= (1 << 5),
+	MV_HP_ERRATA_XX42A0	= (1 << 5),
+	MV_HP_50XX		= (1 << 6),
+	MV_HP_GEN_IIE		= (1 << 7),
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),
@@ -237,6 +245,9 @@
 
 #define IS_50XX(hpriv) ((hpriv)->hp_flags & MV_HP_50XX)
 #define IS_60XX(hpriv) (((hpriv)->hp_flags & MV_HP_50XX) == 0)
+#define IS_GEN_I(hpriv) IS_50XX(hpriv)
+#define IS_GEN_II(hpriv) IS_60XX(hpriv)
+#define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
 
 enum {
 	/* Our DMA boundary is determined by an ePRD being unable to handle
@@ -255,29 +266,39 @@
 	chip_5080,
 	chip_604x,
 	chip_608x,
+	chip_6042,
+	chip_7042,
 };
 
 /* Command ReQuest Block: 32B */
 struct mv_crqb {
-	u32			sg_addr;
-	u32			sg_addr_hi;
-	u16			ctrl_flags;
-	u16			ata_cmd[11];
+	__le32			sg_addr;
+	__le32			sg_addr_hi;
+	__le16			ctrl_flags;
+	__le16			ata_cmd[11];
+};
+
+struct mv_crqb_iie {
+	__le32			addr;
+	__le32			addr_hi;
+	__le32			flags;
+	__le32			len;
+	__le32			ata_cmd[4];
 };
 
 /* Command ResPonse Block: 8B */
 struct mv_crpb {
-	u16			id;
-	u16			flags;
-	u32			tmstmp;
+	__le16			id;
+	__le16			flags;
+	__le32			tmstmp;
 };
 
 /* EDMA Physical Region Descriptor (ePRD); A.K.A. SG */
 struct mv_sg {
-	u32			addr;
-	u32			flags_size;
-	u32			addr_hi;
-	u32			reserved;
+	__le32			addr;
+	__le32			flags_size;
+	__le32			addr_hi;
+	__le32			reserved;
 };
 
 struct mv_port_priv {
@@ -287,9 +308,6 @@
 	dma_addr_t		crpb_dma;
 	struct mv_sg		*sg_tbl;
 	dma_addr_t		sg_tbl_dma;
-
-	unsigned		req_producer;		/* cp of req_in_ptr */
-	unsigned		rsp_consumer;		/* cp of rsp_out_ptr */
 	u32			pp_flags;
 };
 
@@ -328,6 +346,7 @@
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
+static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static int mv_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t mv_interrupt(int irq, void *dev_instance,
 				struct pt_regs *regs);
@@ -430,6 +449,33 @@
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
@@ -467,6 +513,21 @@
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
@@ -477,6 +538,7 @@
 
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6042), 0, 0, chip_6042},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
 
@@ -572,8 +634,8 @@
  *      @base: port base address
  *      @pp: port private data
  *
- *      Verify the local cache of the eDMA state is accurate with an
- *      assert.
+ *      Verify the local cache of the eDMA state is accurate with a
+ *      WARN_ON.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -584,15 +646,15 @@
 		writelfl(EDMA_EN, base + EDMA_CMD_OFS);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 	}
-	assert(EDMA_EN & readl(base + EDMA_CMD_OFS));
+	WARN_ON(!(EDMA_EN & readl(base + EDMA_CMD_OFS)));
 }
 
 /**
  *      mv_stop_dma - Disable eDMA engine
  *      @ap: ATA channel to manipulate
  *
- *      Verify the local cache of the eDMA state is accurate with an
- *      assert.
+ *      Verify the local cache of the eDMA state is accurate with a
+ *      WARN_ON.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -610,7 +672,7 @@
 		writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 	} else {
-		assert(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
+		WARN_ON(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS));
   	}
 
 	/* now properly wait for the eDMA to stop */
@@ -690,7 +752,7 @@
 	mv_dump_mem(mmio_base+0xf00, 0x4);
 	mv_dump_mem(mmio_base+0x1d00, 0x6c);
 	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
-		hc_base = mv_hc_base(mmio_base, port >> MV_PORT_HC_SHIFT);
+		hc_base = mv_hc_base(mmio_base, hc);
 		DPRINTK("HC regs (HC %i):\n", hc);
 		mv_dump_mem(hc_base, 0x1c);
 	}
@@ -773,6 +835,33 @@
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
@@ -786,6 +875,7 @@
 static int mv_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	void *mem;
@@ -829,22 +919,29 @@
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
 
-	pp->req_producer = pp->rsp_consumer = 0;
-
 	/* Don't turn on EDMA here...do it before DMA commands only.  Else
 	 * we'll be unable to send non-data, PIO, etc due to restricted access
 	 * to shadow regs.
@@ -915,7 +1012,7 @@
 
 			pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
 			pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-			pp->sg_tbl[i].flags_size = cpu_to_le32(len);
+			pp->sg_tbl[i].flags_size = cpu_to_le32(len & 0xffff);
 
 			sg_len -= len;
 			addr += len;
@@ -928,16 +1025,16 @@
 	}
 }
 
-static inline unsigned mv_inc_q_index(unsigned *index)
+static inline unsigned mv_inc_q_index(unsigned index)
 {
-	*index = (*index + 1) & MV_MAX_Q_DEPTH_MASK;
-	return *index;
+	return (index + 1) & MV_MAX_Q_DEPTH_MASK;
 }
 
-static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 addr, unsigned last)
+static inline void mv_crqb_pack_cmd(__le16 *cmdw, u8 data, u8 addr, unsigned last)
 {
-	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
+	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
 		(last ? CRQB_CMD_LAST : 0);
+	*cmdw = cpu_to_le16(tmp);
 }
 
 /**
@@ -956,34 +1053,32 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
-	u16 *cw;
+	__le16 *cw;
 	struct ata_taskfile *tf;
 	u16 flags = 0;
+	unsigned in_index;
 
- 	if (ATA_PROT_DMA != qc->tf.protocol) {
+ 	if (ATA_PROT_DMA != qc->tf.protocol)
 		return;
-	}
-
-	/* the req producer index should be the same as we remember it */
-	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->req_producer);
 
 	/* Fill in command request block
 	 */
-	if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 		flags |= CRQB_FLAG_READ;
-	}
-	assert(MV_MAX_Q_DEPTH > qc->tag);
+	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	pp->crqb[pp->req_producer].sg_addr =
+	/* get current queue index from hardware */
+	in_index = (readl(mv_ap_base(ap) + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+
+	pp->crqb[in_index].sg_addr =
 		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	pp->crqb[pp->req_producer].sg_addr_hi =
+	pp->crqb[in_index].sg_addr_hi =
 		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
-	pp->crqb[pp->req_producer].ctrl_flags = cpu_to_le16(flags);
+	pp->crqb[in_index].ctrl_flags = cpu_to_le16(flags);
 
-	cw = &pp->crqb[pp->req_producer].ata_cmd[0];
+	cw = &pp->crqb[in_index].ata_cmd[0];
 	tf = &qc->tf;
 
 	/* Sadly, the CRQB cannot accomodate all registers--there are
@@ -1029,9 +1124,76 @@
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
+	unsigned in_index;
+	u32 flags = 0;
+
+ 	if (ATA_PROT_DMA != qc->tf.protocol)
+		return;
+
+	/* Fill in Gen IIE command request block
+	 */
+	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
+		flags |= CRQB_FLAG_READ;
+
+	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
+	flags |= qc->tag << CRQB_TAG_SHIFT;
+
+	/* get current queue index from hardware */
+	in_index = (readl(mv_ap_base(ap) + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+
+	crqb = (struct mv_crqb_iie *) &pp->crqb[in_index];
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
 
@@ -1051,6 +1213,7 @@
 {
 	void __iomem *port_mmio = mv_ap_base(qc->ap);
 	struct mv_port_priv *pp = qc->ap->private_data;
+	unsigned in_index;
 	u32 in_ptr;
 
 	if (ATA_PROT_DMA != qc->tf.protocol) {
@@ -1062,23 +1225,20 @@
 		return ata_qc_issue_prot(qc);
 	}
 
-	in_ptr = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+	in_ptr   = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+	in_index = (in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	/* the req producer index should be the same as we remember it */
-	assert(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->req_producer);
 	/* until we do queuing, the queue should be empty at this point */
-	assert(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
-		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
+	WARN_ON(in_index != ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
+		>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
-	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
+	in_index = mv_inc_q_index(in_index);	/* now incr producer index */
 
 	mv_start_dma(port_mmio, pp);
 
 	/* and write the request in pointer to kick the EDMA to life */
 	in_ptr &= EDMA_REQ_Q_BASE_LO_MASK;
-	in_ptr |= pp->req_producer << EDMA_REQ_Q_PTR_SHIFT;
+	in_ptr |= in_index << EDMA_REQ_Q_PTR_SHIFT;
 	writelfl(in_ptr, port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
 	return 0;
@@ -1090,7 +1250,7 @@
  *
  *      This routine is for use when the port is in DMA mode, when it
  *      will be using the CRPB (command response block) method of
- *      returning command completion information.  We assert indices
+ *      returning command completion information.  We check indices
  *      are good, grab status, and bump the response consumer index to
  *      prove that we're up to date.
  *
@@ -1101,28 +1261,26 @@
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
+	unsigned out_index;
 	u32 out_ptr;
 	u8 ata_status;
 
-	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+	out_ptr   = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+	out_index = (out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	/* the response consumer index should be the same as we remember it */
-	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->rsp_consumer);
-
-	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+	ata_status = le16_to_cpu(pp->crpb[out_index].flags)
+					>> CRPB_FLAG_STATUS_SHIFT;
 
 	/* increment our consumer index... */
-	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
+	out_index = mv_inc_q_index(out_index);
 
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
-	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
-		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       pp->rsp_consumer);
+	WARN_ON(out_index != ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS)
+		>> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
 	out_ptr &= EDMA_RSP_Q_BASE_LO_MASK;
-	out_ptr |= pp->rsp_consumer << EDMA_RSP_Q_PTR_SHIFT;
+	out_ptr |= out_index << EDMA_RSP_Q_PTR_SHIFT;
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
@@ -1132,6 +1290,7 @@
 /**
  *      mv_err_intr - Handle error interrupts on the port
  *      @ap: ATA channel to manipulate
+ *      @reset_allowed: bool: 0 == don't trigger from reset here
  *
  *      In most cases, just clear the interrupt and move on.  However,
  *      some cases require an eDMA reset, which is done right before
@@ -1142,7 +1301,7 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_err_intr(struct ata_port *ap)
+static void mv_err_intr(struct ata_port *ap, int reset_allowed)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 edma_err_cause, serr = 0;
@@ -1164,9 +1323,8 @@
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	/* check for fatal here and recover if needed */
-	if (EDMA_ERR_FATAL & edma_err_cause) {
+	if (reset_allowed && (EDMA_ERR_FATAL & edma_err_cause))
 		mv_stop_and_reset(ap);
-	}
 }
 
 /**
@@ -1190,7 +1348,6 @@
 {
 	void __iomem *mmio = host_set->mmio_base;
 	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
-	struct ata_port *ap;
 	struct ata_queued_cmd *qc;
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
@@ -1213,21 +1370,34 @@
 
 	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
 		u8 ata_status = 0;
-		ap = host_set->ports[port];
-		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
+		struct ata_port *ap = host_set->ports[port];
+		struct mv_port_priv *pp = ap->private_data;
+
+		hard_port = mv_hardport_from_port(port); /* range 0..3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
 
-		if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
-			/* new CRPB on the queue; just one at a time until NCQ
-			 */
-			ata_status = mv_get_crpb_status(ap);
-			handled++;
-		} else if ((DEV_IRQ << hard_port) & hc_irq_cause) {
-			/* received ATA IRQ; read the status reg to clear INTRQ
-			 */
-			ata_status = readb((void __iomem *)
+		/* Note that DEV_IRQ might happen spuriously during EDMA,
+		 * and should be ignored in such cases.
+		 * The cause of this is still under investigation.
+		 */ 
+		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
+			/* EDMA: check for response queue interrupt */
+			if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
+				ata_status = mv_get_crpb_status(ap);
+				handled = 1;
+			}
+		} else {
+			/* PIO: check for device (drive) interrupt */
+			if ((DEV_IRQ << hard_port) & hc_irq_cause) {
+				ata_status = readb((void __iomem *)
 					   ap->ioaddr.status_addr);
-			handled++;
+				handled = 1;
+				/* ignore spurious intr if drive still BUSY */
+				if (ata_status & ATA_BUSY) {
+					ata_status = 0;
+					handled = 0;
+				}
+			}
 		}
 
 		if (ap &&
@@ -1241,14 +1411,14 @@
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 		}
 		if ((PORT0_ERR << shift) & relevant) {
-			mv_err_intr(ap);
+			mv_err_intr(ap, 1);
 			err_mask |= AC_ERR_OTHER;
-			handled++;
+			handled = 1;
 		}
 
-		if (handled && ap) {
+		if (handled) {
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (NULL != qc) {
+			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
@@ -1283,6 +1453,7 @@
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int hc, handled = 0, n_hcs;
 	void __iomem *mmio = host_set->mmio_base;
+	struct mv_host_priv *hpriv;
 	u32 irq_stat;
 
 	irq_stat = readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
@@ -1304,6 +1475,17 @@
 			handled++;
 		}
 	}
+
+	hpriv = host_set->private_data;
+	if (IS_60XX(hpriv)) {
+		/* deal with the interrupt coalescing bits */
+		if (irq_stat & (TRAN_LO_DONE | TRAN_HI_DONE | PORTS_0_7_COAL_DONE)) {
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE_LO);
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE_HI);
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE);
+		}
+	}
+
 	if (PCI_ERR & irq_stat) {
 		printk(KERN_ERR DRV_NAME ": PCI ERROR; PCI IRQ cause=0x%08x\n",
 		       readl(mmio + PCI_IRQ_CAUSE_OFS));
@@ -1684,6 +1866,12 @@
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
 
@@ -1696,7 +1884,8 @@
 
 	if (IS_60XX(hpriv)) {
 		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
-		ifctl |= (1 << 12) | (1 << 7);
+		ifctl |= (1 << 7);		/* enable gen2i speed */
+		ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
 		writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
 	}
 
@@ -1792,7 +1981,7 @@
 		ata_port_probe(ap);
 	} else {
 		printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
-		       ap->id, scr_read(ap, SCR_STATUS));
+				ap->id, scr_read(ap, SCR_STATUS));
 		ata_port_disable(ap);
 		return;
 	}
@@ -1861,13 +2050,11 @@
 	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
-	mv_err_intr(ap);
+	mv_err_intr(ap, 0);
 	mv_stop_and_reset(ap);
 
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-	} else {
+	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
+	if (qc->flags & ATA_QCFLAG_ACTIVE) {
 		/* hack alert!  We cannot use the supplied completion
 	 	 * function from inside the ->eh_strategy_handler() thread.
 	 	 * libata is the only user of ->eh_strategy_handler() in
@@ -1998,6 +2185,27 @@
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
@@ -2052,7 +2260,8 @@
 			void __iomem *port_mmio = mv_port_base(mmio, port);
 
 			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
-			ifctl |= (1 << 12);
+			ifctl |= (1 << 7);		/* enable gen2i speed */
+			ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
 			writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
 		}
 
@@ -2153,6 +2362,7 @@
 	if (rc) {
 		return rc;
 	}
+	pci_set_master(pdev);
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {

--------------060807040308030703080806--
