Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWA0HMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWA0HMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWA0HMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:12:32 -0500
Received: from havoc.gtf.org ([69.61.125.42]:7638 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751433AbWA0HMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:12:31 -0500
Date: Fri, 27 Jan 2006 02:12:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com, tmb@mandriva.org
Subject: [PATCH v2] sata_sil: combined irq + LBT DMA patch for testing
Message-ID: <20060127071223.GA20141@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Updated with the bug fix that Bart's keen eye discovered.  Good catch.




 drivers/scsi/sata_sil.c |  236 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 222 insertions(+), 14 deletions(-)


diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index b017f85..0bb3f28 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -80,11 +80,20 @@ enum {
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
 
+enum {
+	SIL_DMA_BOUNDARY	= 0xffffffffU,
+};
+
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_qc_prep(struct ata_queued_cmd *qc);
+static void sil_bmdma_setup (struct ata_queued_cmd *qc);
+static void sil_bmdma_start (struct ata_queued_cmd *qc);
+static void sil_bmdma_stop(struct ata_queued_cmd *qc);
+static irqreturn_t sil_irq (int irq, void *dev_instance, struct pt_regs *regs);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
@@ -138,13 +147,13 @@ static struct scsi_host_template sil_sht
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
+	.sg_tablesize		= ATA_MAX_PRD,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.dma_boundary		= SIL_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 };
@@ -159,14 +168,14 @@ static const struct ata_port_operations 
 	.dev_select		= ata_std_dev_select,
 	.phy_reset		= sata_phy_reset,
 	.post_set_mode		= sil_post_set_mode,
-	.bmdma_setup            = ata_bmdma_setup,
-	.bmdma_start            = ata_bmdma_start,
-	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_setup            = sil_bmdma_setup,
+	.bmdma_start            = sil_bmdma_start,
+	.bmdma_stop		= sil_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.qc_prep		= ata_qc_prep,
+	.qc_prep		= sil_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
-	.irq_handler		= ata_interrupt,
+	.irq_handler		= sil_irq,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
@@ -213,16 +222,18 @@ static const struct {
 	unsigned long tf;	/* ATA taskfile register block */
 	unsigned long ctl;	/* ATA control/altstatus register block */
 	unsigned long bmdma;	/* DMA register block */
+	unsigned long bmdma_lbt;/* Large block DMA register block */
 	unsigned long scr;	/* SATA control register block */
 	unsigned long sien;	/* SATA Interrupt Enable register */
 	unsigned long xfer_mode;/* data transfer mode register */
 } sil_port[] = {
-	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
-	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
-	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
-	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
-	/* ... port 3 */
+
+	/*   tf    ctl  bmdma    lbt    scr   sien   mode */
+	{  0x80,  0x8A,   0x0,  0x10, 0x100, 0x148,  0xb4 }, /* port 0 */
+	{  0xC0,  0xCA,   0x8,  0x18, 0x180, 0x1c8,  0xf4 }, /* port 1 */
+	{ 0x280, 0x28A, 0x200, 0x210, 0x300, 0x348, 0x2b4 }, /* port 2 */
+	{ 0x2C0, 0x2CA, 0x208, 0x218, 0x380, 0x3c8, 0x2f4 }, /* port 3 */
+
 };
 
 MODULE_AUTHOR("Jeff Garzik");
@@ -232,6 +243,203 @@ MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
 
+static void sil_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+	u32 val;
+
+	/* clear start/stop bit */
+	if (ap->port_no == 2)
+		val = SIL_INTR_STEERING;
+	else
+		val = 0;
+	writeb(val, mmio + ATA_DMA_CMD);
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);        /* dummy read */
+}
+
+static void sil_bmdma_setup (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *mmio;
+
+	mmio = ap->host_set->mmio_base + sil_port[ap->port_no].bmdma;
+
+	/* load PRD table addr. */
+	mb();	/* make sure PRD table writes are visible to controller */
+	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
+
+	/* issue r/w command */
+	ata_exec_command(ap, &qc->tf);
+}
+
+static void sil_bmdma_start (struct ata_queued_cmd *qc)
+{
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct ata_port *ap = qc->ap;
+	void __iomem *mmio;
+	u8 dmactl;
+
+	mmio = ap->host_set->mmio_base + sil_port[ap->port_no].bmdma_lbt;
+
+	/* set transfer direction, start host DMA transaction */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl &= ~ATA_DMA_WR;
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
+}
+
+/* The way God intended PCI IDE scatter/gather lists to look and behave... */
+static inline void sil_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct scatterlist *sg;
+	struct ata_port *ap = qc->ap;
+	struct ata_prd *prd;
+
+	prd = &ap->prd[0];
+	ata_for_each_sg(sg, qc) {
+		u32 addr = sg_dma_address(sg);
+		u32 sg_len = sg_dma_len(sg);
+
+		prd->addr = cpu_to_le32(addr);
+		prd->flags_len = cpu_to_le32(sg_len);
+
+		if (ata_sg_is_last(sg, qc))
+			prd->flags_len |= cpu_to_le32(ATA_PRD_EOT);
+
+		prd++;
+	}
+}
+
+static void sil_qc_prep(struct ata_queued_cmd *qc)
+{
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	sil_fill_sg(qc);
+}
+
+static inline void sil_port_irq(struct ata_port *ap, void __iomem *mmio,
+				u8 dma_stat, u8 dma_stat_mask)
+{
+	struct ata_queued_cmd *qc = NULL;
+	unsigned int err_mask = AC_ERR_OTHER;
+	int complete = 1;
+	u8 dev_stat;
+
+	/* Exit now, if port or port's irqs are disabled */
+	if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)) {
+		complete = 0;
+		goto out;
+	}
+
+	/* Get active command */
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if ((!qc) || (qc->tf.ctl & ATA_NIEN)) {
+		complete = 0;
+		goto out;
+	}
+
+	/* Stop DMA, if doing DMA */
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
+		sil_bmdma_stop(qc);
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	/* Catch PCI bus errors */
+	if (unlikely(dma_stat_mask & ATA_DMA_ERR)) {
+		struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+		u16 pci_stat;
+
+		pci_read_config_word(pdev, PCI_STATUS, &pci_stat);
+		pci_write_config_word(pdev, PCI_STATUS, pci_stat);
+
+		err_mask = AC_ERR_HOST_BUS;
+
+		printk(KERN_ERR "ata%u: PCI error, pci %x, dma %x\n",
+			ap->id, pci_stat, dma_stat);
+		goto out;
+	}
+
+	/* Read device Status, clear device interrupt */
+	dev_stat = ata_check_status(ap);
+
+	/* Let timeout handler handle stuck BSY */
+	if (unlikely(dev_stat & ATA_BUSY)) {
+		complete = 0;
+		goto out;
+	}
+
+	/* Did S/G table specify a size smaller than the transfer size?  */
+	if (unlikely(dma_stat_mask == 0)) {
+		printk(KERN_ERR "ata%u: BUG: SG size underflow\n", ap->id);
+		err_mask = AC_ERR_OTHER; /* only occurs due to coder error? */
+		goto out;
+	}
+
+	/* Clear 311x DMA completion indicator */
+	writeb(ATA_DMA_INTR, mmio + ATA_DMA_STATUS);
+
+	/* Finally, complete the ATA command transaction */
+	qc->err_mask = ac_err_mask(dev_stat);
+	ata_qc_complete(qc);
+	return;
+
+out:
+	ata_chk_status(ap);
+	writeb(dma_stat_mask, mmio + ATA_DMA_STATUS);
+	if (complete) {
+		qc->err_mask = err_mask;
+		ata_qc_complete(qc);
+	}
+}
+
+static irqreturn_t sil_irq (int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned int i, handled = 0;
+
+	spin_lock(&host_set->lock);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+		void __iomem *mmio;
+		u8 status, mask;
+		u32 serr;
+
+		ap = host_set->ports[i];
+		if (!ap)
+			continue;
+
+		mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+		status = readb(mmio + ATA_DMA_STATUS);
+		mask = status & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE);
+		if (mask == ATA_DMA_ACTIVE)
+			continue;
+
+		handled = 1;
+
+		sil_port_irq(ap, mmio, status, mask);
+
+		serr = sil_scr_read(ap, SCR_ERROR);
+		if (serr)
+			sil_scr_write(ap, SCR_ERROR, serr);
+	}
+
+	spin_unlock(&host_set->lock);
+
+	return IRQ_RETVAL(handled);
+}
+
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
 	u8 cache_line = 0;
@@ -441,7 +649,7 @@ static int sil_init_one (struct pci_dev 
 		probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
 		probe_ent->port[i].altstatus_addr =
 		probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
-		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
+		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma_lbt;
 		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
 		ata_std_ports(&probe_ent->port[i]);
 	}
