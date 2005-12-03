Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVLCUEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVLCUEk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVLCUEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 15:04:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:34731 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750930AbVLCUEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 15:04:39 -0500
Date: Sat, 3 Dec 2005 15:04:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sata_sil: greatly improve DMA handling
Message-ID: <20051203200438.GA3770@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just checked this into the 'sil-lbt' branch of libata-dev.git:

I had written a previous version of this patch, but it never worked.  I
finally figured out my dumb bug, so I dusted off the patch, finished it,
and verified it works.

This will probably head upstream.

NOTE:  This conflicts with the sata_sil interrupt handling patch I
posted yesterday.  Applying both patches is fine, but you'll have to fix
up some trivial patch rejections.

 drivers/scsi/sata_sil.c |  116 ++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 103 insertions(+), 13 deletions(-)

    [libata sata_sil] Greatly improve DMA handling

    311x hardware includes a vendor-specific scatter/gather format which
    eliminates the traditional 64k boundary limit found in PCI IDE DMA.
    
    Since implementing this feature required custom implementations
    of the bmdma_xxx hooks, I took the opportunity to eliminate a few
    unnecessary MMIO register reads/writes.



diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 3609186..5f7220d 100644
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
+
 
 
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
 	.ordered_flush		= 1,
@@ -160,11 +169,11 @@ static const struct ata_port_operations 
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
 	.irq_handler		= ata_interrupt,
@@ -214,16 +223,18 @@ static const struct {
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
@@ -233,6 +244,85 @@ MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
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
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
 	u8 cache_line = 0;
@@ -442,7 +532,7 @@ static int sil_init_one (struct pci_dev 
 		probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
 		probe_ent->port[i].altstatus_addr =
 		probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
-		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
+		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma_lbt;
 		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
 		ata_std_ports(&probe_ent->port[i]);
 	}
