Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVFHKbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVFHKbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVFHKbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:31:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261200AbVFHK1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:27:54 -0400
Date: Wed, 8 Jun 2005 12:28:59 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [PATCH] SATA NCQ #4
Message-ID: <20050608102857.GC18490@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This should be pretty final, at least only minor stuff left. Changes:

- (ahci) error handling updates

- (ahci) streamline/fix the ncq vs non-ncq interrupt handling. Important
  for error handling, where we have NCQ commands pending but may issue
  a non-NCQ command.

- (libata) improve ata_qc_from_tag()

- (libata) improve ncq setting in the scsi command translation

- (libata) fix READ_16/WRITE_16 translation for NCQ, it works now.

Patch is against 2.6.12-rc6 / current git. Jeff, I'll get you an
incremental this time very shortly.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -19,8 +19,10 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
- * Version 1.0 of the AHCI specification:
- * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * Version 1.1 of the AHCI specification:
+ * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
+ *
+ * NCQ support (C) 2005 Jens Axboe <axboe@suse.de>
  *
  */
 
@@ -47,10 +49,13 @@ enum {
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
-	AHCI_CMD_SLOT_SZ	= 32 * 32,
-	AHCI_RX_FIS_SZ		= 256,
+	AHCI_MAX_CMDS		= 32,
+	AHCI_CMD_SZ		= 32,
 	AHCI_CMD_TBL_HDR	= 0x80,
-	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
+	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
+	AHCI_RX_FIS_SZ		= 256,
+	AHCI_CMD_TOTAL		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
+	AHCI_CMD_TBL_SZ		= AHCI_MAX_CMDS * AHCI_CMD_TOTAL,
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
 				  AHCI_RX_FIS_SZ,
 	AHCI_IRQ_ON_SG		= (1 << 31),
@@ -58,6 +63,7 @@ enum {
 	AHCI_CMD_WRITE		= (1 << 6),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+	RX_FIS_SDB_REG		= 0x58,	/* offset of SDB Register FIS data */
 
 	board_ahci		= 0,
 
@@ -75,6 +81,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -162,9 +169,9 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
 	dma_addr_t		cmd_tbl_dma;
-	struct ahci_sg		*cmd_tbl_sg;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
+	u32			sactive;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -182,7 +189,7 @@ static void ahci_tf_read(struct ata_port
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static inline int ahci_host_intr(struct ata_port *ap);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -190,7 +197,8 @@ static Scsi_Host_Template ahci_sht = {
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= ATA_MAX_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
 	.max_sectors		= ATA_MAX_SECTORS,
@@ -201,7 +209,7 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
+	.ordered_flush		= 0, /* conflicts with NCQ for now */
 };
 
 static struct ata_port_operations ahci_ops = {
@@ -342,14 +350,11 @@ static int ahci_port_start(struct ata_po
 	mem_dma += AHCI_RX_FIS_SZ;
 
 	/*
-	 * Third item: data area for storing a single command
-	 * and its scatter-gather table
+	 * Third item: data area for storing commands and their sg tables
 	 */
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
-	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR;
-
 	ap->private_data = pp;
 
 	if (hpriv->cap & HOST_CAP_64)
@@ -481,9 +486,10 @@ static void ahci_tf_read(struct ata_port
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static void ahci_fill_sg(struct ata_queued_cmd *qc)
+static void ahci_fill_sg(struct ata_queued_cmd *qc, int offset)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ahci_sg *cmd_tbl_sg;
 	unsigned int i;
 
 	VPRINTK("ENTER\n");
@@ -491,6 +497,7 @@ static void ahci_fill_sg(struct ata_queu
 	/*
 	 * Next, the S/G list.
 	 */
+	cmd_tbl_sg = pp->cmd_tbl + offset + AHCI_CMD_TBL_HDR;
 	for (i = 0; i < qc->n_elem; i++) {
 		u32 sg_len;
 		dma_addr_t addr;
@@ -498,21 +505,22 @@ static void ahci_fill_sg(struct ata_queu
 		addr = sg_dma_address(&qc->sg[i]);
 		sg_len = sg_dma_len(&qc->sg[i]);
 
-		pp->cmd_tbl_sg[i].addr = cpu_to_le32(addr & 0xffffffff);
-		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
+		cmd_tbl_sg[i].addr = cpu_to_le32(addr & 0xffffffff);
+		cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
+		cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
 	}
 }
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
-	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
+	dma_addr_t cmd_tbl_dma;
+	u32 opts;
+	int offset;
 
 	/*
-	 * Fill in command slot information (currently only one slot,
-	 * slot 0, is currently since we don't do queueing)
+	 * Fill in command slot information
 	 */
 
 	opts = (qc->n_elem << 16) | cmd_fis_len;
@@ -531,29 +539,39 @@ static void ahci_qc_prep(struct ata_queu
 		break;
 	}
 
-	pp->cmd_slot[0].opts = cpu_to_le32(opts);
-	pp->cmd_slot[0].status = 0;
-	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
-	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+	/*
+	 * the tag determines the offset into the allocated cmd table
+	 */
+	offset = qc->tag * AHCI_CMD_TOTAL;
+
+	cmd_tbl_dma = pp->cmd_tbl_dma + offset;
+
+	pp->cmd_slot[qc->tag].opts = cpu_to_le32(opts);
+	pp->cmd_slot[qc->tag].status = 0;
+	pp->cmd_slot[qc->tag].tbl_addr = cpu_to_le32(cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[qc->tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
 
 	/*
 	 * Fill in command table information.  First, the header,
 	 * a SATA Register - Host to Device command FIS.
 	 */
-	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+	ata_tf_to_fis(&qc->tf, pp->cmd_tbl + offset, 0);
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
-	ahci_fill_sg(qc);
+	ahci_fill_sg(qc, offset);
 }
 
-static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
+/*
+ * Return 1 if COMRESET was done
+ */
+static int ahci_intr_error(struct ata_port *ap, u32 irq_stat)
 {
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
-	int work;
+	int work, reset = 0;
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -575,16 +593,22 @@ static void ahci_intr_error(struct ata_p
 	tmp = readl(port_mmio + PORT_SCR_ERR);
 	writel(tmp, port_mmio + PORT_SCR_ERR);
 
+	/* clear status */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	writel(tmp, port_mmio + PORT_IRQ_STAT);
+
 	/* if DRQ/BSY is set, device needs to be reset.
 	 * if so, issue COMRESET
 	 */
 	tmp = readl(port_mmio + PORT_TFDATA);
 	if (tmp & (ATA_BUSY | ATA_DRQ)) {
+		printk(KERN_WARNING "ata%u: stat=%x, issuing COMRESET\n", ap->id, tmp);
 		writel(0x301, port_mmio + PORT_SCR_CTL);
 		readl(port_mmio + PORT_SCR_CTL); /* flush */
 		udelay(10);
 		writel(0x300, port_mmio + PORT_SCR_CTL);
 		readl(port_mmio + PORT_SCR_CTL); /* flush */
+		reset = 1;
 	}
 
 	/* re-start DMA */
@@ -594,9 +618,117 @@ static void ahci_intr_error(struct ata_p
 	readl(port_mmio + PORT_CMD); /* flush */
 
 	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
+	return reset;
 }
 
-static void ahci_eng_timeout(struct ata_port *ap)
+static void ahci_complete_requests(struct ata_port *ap, u32 tag_mask, int err)
+{
+	while (tag_mask) {
+		struct ata_queued_cmd *qc;
+		int tag = ffs(tag_mask) - 1;
+
+		tag_mask &= ~(1 << tag);
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc)
+			ata_qc_complete(qc, err);
+		else
+			printk(KERN_ERR "ahci: missing tag %d\n", tag);
+	}
+}
+
+static void dump_log_page(unsigned char *p)
+{
+	int i;
+
+	printk("LOG 0x10: nq=%d, tag=%d\n", p[0] >> 7, p[0] & 0x1f);
+
+	for (i = 2; i < 14; i++)
+		printk("%d:%d ", i, p[i]);
+
+	printk("\n");
+}
+
+/*
+ * TODO: needs to use READ_LOG_EXT/page=10h to retrieve error information
+ */
+extern void ata_qc_free(struct ata_queued_cmd *qc);
+static void ahci_ncq_timeout(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	char *buffer;
+	u32 sactive;
+	int reset;
+
+	printk(KERN_WARNING "ata%u: ncq interrupt error (Q=%d)\n", ap->id, ap->queue_depth);
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	sactive = readl(port_mmio + PORT_SCR_ACT);
+
+	printk(KERN_WARNING "ata%u: SActive 0x%x (0x%x)\n", ap->id, sactive, pp->sactive);
+	reset = ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	/*
+	 * if COMRESET was done, we don't have to issue a log page read
+	 */
+	if (reset)
+		goto done;
+
+	buffer = kmalloc(512, GFP_KERNEL);
+	if (!buffer) {
+		printk(KERN_ERR "ata%u: unable to allocate memory for error\n", ap->id);
+		goto done;
+	}
+
+	if (ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1)) {
+		printk(KERN_ERR "ata%u: unable to read log page\n", ap->id);
+		goto out;
+	}
+
+	dump_log_page(buffer);
+
+	/*
+	 * if NQ is cleared, bottom 5 bits contain the tag of the errored
+	 * command
+	 */
+	if ((buffer[0] & (1 << 7)) == 0) {
+		int tag = buffer[0] & 0x1f;
+
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc)
+			ata_qc_complete(qc, ATA_ERR);
+	}
+
+	/*
+	 * requeue the remaining commands
+	 */
+	while (pp->sactive) {
+		int tag = ffs(pp->sactive) - 1;
+
+		pp->sactive &= ~(1 << tag);
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			if (qc->scsicmd)
+				ata_qc_free(qc);
+			else
+				ata_qc_complete(qc, ATA_ERR);
+		} else
+			printk(KERN_ERR "ata%u: missing tag %d\n", ap->id, tag);
+	}
+
+out:
+	kfree(buffer);
+done:
+	ata_scsi_unblock_requests(ap);
+}
+
+static void ahci_nonncq_timeout(struct ata_port *ap)
 {
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -620,13 +752,100 @@ static void ahci_eng_timeout(struct ata_
 		qc->scsidone = scsi_finish_command;
 		ata_qc_complete(qc, ATA_ERR);
 	}
+}
+
+static void ahci_eng_timeout(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
 
+	if (pp->sactive)
+		ahci_ncq_timeout(ap);
+	else
+		ahci_nonncq_timeout(ap);
 }
 
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+static int ahci_ncq_intr(struct ata_port *ap, u32 status)
 {
+	struct ahci_port_priv *pp = ap->private_data;
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+
+	if (!pp->sactive)
+		return 0;
+
+	if (status & PORT_IRQ_SDB_FIS) {
+		u8 *sdb = pp->rx_fis + RX_FIS_SDB_REG;
+		u32 sactive, mask;
+
+		if (unlikely(sdb[2] & ATA_ERR)) {
+			printk("SDB fis, stat %x, err %x\n", sdb[2], sdb[3]);
+			return 1;
+		}
+
+		/*
+		 * SActive will have the bits cleared for completed commands
+		 */
+		sactive = readl(port_mmio + PORT_SCR_ACT);
+		mask = pp->sactive & ~sactive;
+		if (mask) {
+			ahci_complete_requests(ap, mask, 0);
+			pp->sactive = sactive;
+			return 1;
+		} else
+			printk(KERN_INFO "ata%u: SDB with no bits cleared\n", ap->id);
+	} else if (status & PORT_IRQ_D2H_REG_FIS) {
+		u8 *d2h = pp->rx_fis + RX_FIS_D2H_REG;
+
+		/*
+		 * pre-BSY clear error, let timeout error handling take care
+		 * of it when it kicks in
+		 */
+		if (d2h[2] & ATA_ERR) {
+			VPRINTK("D2H fis, err %x\n", d2h[2]);
+			return 1;
+		}
+
+		printk("D2H fis\n");
+	} else
+		printk(KERN_WARNING "ata%u: unhandled FIS, stat %x\n", ap->id, status);
+
+	return 0;
+}
+
+static void ahci_ncq_intr_error(struct ata_port *ap, u32 status)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ata_queued_cmd *qc;
+	struct ata_taskfile tf;
+	int tag;
+
+	printk(KERN_ERR "ata%u: NCQ err status 0x%x\n", ap->id, status);
+
+	if (status & PORT_IRQ_D2H_REG_FIS) {
+		ahci_tf_read(ap, &tf);
+		tag = tf.nsect >> 3;
+
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			printk(KERN_ERR "ata%u: ending bad tag %d\n", ap->id, tag);
+			pp->sactive &= ~(1 << tag);
+			ata_qc_complete(qc, ATA_ERR);
+		} else
+			printk(KERN_ERR "ata%u: error on tag %d, but not present\n", ap->id, tag);
+	}
+
+	/*
+	 * let command timeout deal with error handling
+	 */
+	ata_scsi_block_requests(ap);
+}
+
+static inline int ahci_host_intr(struct ata_port *ap)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ata_queued_cmd *qc;
 	u32 status, serr, ci;
 
 	serr = readl(port_mmio + PORT_SCR_ERR);
@@ -635,18 +854,28 @@ static inline int ahci_host_intr(struct 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	ci = readl(port_mmio + PORT_CMD_ISSUE);
-	if (likely((ci & 0x1) == 0)) {
-		if (qc) {
-			ata_qc_complete(qc, 0);
-			qc = NULL;
-		}
+	if (status & PORT_IRQ_FATAL) {
+		printk("ata%u: irq error %x %x, tag %d\n", ap->id, serr, status, ap->active_tag);
+		if (pp->sactive)
+			ahci_ncq_intr_error(ap, status);
+		else
+			ahci_intr_error(ap, status);
+
+		return 1;
 	}
 
-	if (status & PORT_IRQ_FATAL) {
-		ahci_intr_error(ap, status);
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
+	if (ahci_ncq_intr(ap, status))
+		return 1;
+
+	ci = readl(port_mmio + PORT_CMD_ISSUE);
+
+	if ((ci & (1 << ap->active_tag)) == 0) {
+		VPRINTK("NON-NCQ interrupt\n");
+
+		qc = ata_qc_from_tag(ap, ap->active_tag);
+		if (qc && (qc->flags & ATA_QCFLAG_ACTIVE) &&
+		    !(qc->flags & ATA_QCFLAG_NCQ))
+			ata_qc_complete(qc, 0);
 	}
 
 	return 1;
@@ -679,18 +908,13 @@ static irqreturn_t ahci_interrupt (int i
         spin_lock(&host_set->lock);
 
         for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap;
-		u32 tmp;
+		struct ata_port *ap = host_set->ports[i];
 
 		VPRINTK("port %u\n", i);
-		ap = host_set->ports[i];
-		tmp = irq_stat & (1 << i);
-		if (tmp && ap) {
-			struct ata_queued_cmd *qc;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (ahci_host_intr(ap, qc))
+
+		if (ap && (irq_stat & (1 << i)))
+			if (ahci_host_intr(ap))
 				irq_ack |= (1 << i);
-		}
 	}
 
 	if (irq_ack) {
@@ -705,15 +929,21 @@ static irqreturn_t ahci_interrupt (int i
 	return IRQ_RETVAL(handled);
 }
 
+
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_SCR_ACT);
-	readl(port_mmio + PORT_SCR_ACT);	/* flush */
+	if (qc->flags & ATA_QCFLAG_NCQ) {
+		pp->sactive |= (1 << qc->tag);
 
-	writel(1, port_mmio + PORT_CMD_ISSUE);
+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+		readl(port_mmio + PORT_SCR_ACT);
+	}
+
+	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
@@ -1030,6 +1260,9 @@ static int ahci_init_one (struct pci_dev
 	if (rc)
 		goto err_out_hpriv;
 
+	if (hpriv->cap & HOST_CAP_NCQ)
+		probe_ent->host_flags |= ATA_FLAG_NCQ;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
@@ -1052,7 +1285,6 @@ err_out:
 	return rc;
 }
 
-
 static int __init ahci_init(void)
 {
 	return pci_module_init(&ahci_pci_driver);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -612,7 +612,7 @@ void ata_tf_from_fis(u8 *fis, struct ata
  *	LOCKING:
  *	None.
  */
-static int ata_prot_to_cmd(int protocol, int lba48)
+static int ata_prot_to_cmd(int protocol, int lba48, int ncq)
 {
 	int rcmd = 0, wcmd = 0;
 
@@ -628,7 +628,10 @@ static int ata_prot_to_cmd(int protocol,
 		break;
 
 	case ATA_PROT_DMA:
-		if (lba48) {
+		if (ncq) {
+			rcmd = ATA_CMD_FPDMA_READ;
+			wcmd = ATA_CMD_FPDMA_WRITE;
+		} else if (lba48) {
 			rcmd = ATA_CMD_READ_EXT;
 			wcmd = ATA_CMD_WRITE_EXT;
 		} else {
@@ -661,6 +664,7 @@ static void ata_dev_set_protocol(struct 
 {
 	int pio = (dev->flags & ATA_DFLAG_PIO);
 	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
+	int ncq = (dev->flags & ATA_DFLAG_NCQ);
 	int proto, cmd;
 
 	if (pio)
@@ -668,7 +672,7 @@ static void ata_dev_set_protocol(struct 
 	else
 		proto = dev->xfer_protocol = ATA_PROT_DMA;
 
-	cmd = ata_prot_to_cmd(proto, lba48);
+	cmd = ata_prot_to_cmd(proto, lba48, ncq);
 	if (cmd < 0)
 		BUG();
 
@@ -1248,6 +1252,10 @@ retry:
 			goto err_out_nosup;
 		}
 
+		/* host NCQ is required as well as device support */
+		if ((ap->flags & ATA_FLAG_NCQ) && ata_id_has_ncq(dev->id))
+			dev->flags |= ATA_DFLAG_NCQ;
+
 		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
 			dev->n_sectors = ata_id_u64(dev->id, 100);
@@ -1258,11 +1266,12 @@ retry:
 		ap->host->max_cmd_len = 16;
 
 		/* print device info to dmesg */
-		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
+		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s%s\n",
 		       ap->id, device,
 		       ata_mode_string(xfer_modes),
 		       (unsigned long long)dev->n_sectors,
-		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
+		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "",
+		       dev->flags & ATA_DFLAG_NCQ ? " ncq" : "");
 	}
 
 	/* ATAPI-specific feature tests */
@@ -1296,6 +1305,63 @@ err_out:
 }
 
 /**
+ *	ata_read_log_page - read a specific log page
+ *	@ap: port on which device we wish to probe resides
+ *	@device: device bus address, starting at zero
+ *	@page: page to read
+ *	@buffer: where to store the read data
+ *	@sectors: how much data to read
+ *
+ *	After reading the device information page, we use several
+ *	bits of information from it to initialize data structures
+ *	that will be used during the lifetime of the ata_device.
+ *	Other data from the info page is used to disqualify certain
+ *	older ATA devices we do not wish to support.
+ *
+ *	LOCKING:
+ *	Grabs host_set lock.
+ */
+
+int ata_read_log_page(struct ata_port *ap, unsigned int device, char page,
+		      char *buffer, unsigned int sectors)
+{
+	struct ata_device *dev = &ap->device[device];
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int rc;
+
+	assert(dev->class == ATA_DEV_ATA);
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	ata_sg_init_one(qc, buffer, sectors << 9);
+	qc->dma_dir = DMA_FROM_DEVICE;
+	qc->tf.protocol = ATA_PROT_PIO;
+	qc->nsect = sectors;
+
+	qc->tf.command = ATA_CMD_READ_LOG_EXT;
+	qc->tf.nsect = sectors;
+	qc->tf.hob_nsect = sectors >> 8;
+	qc->tf.lbal = page;
+	qc->flags |= ATA_QCFLAG_PREEMPT;
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc)
+		return -EIO;
+
+	wait_for_completion(&wait);
+	return 0;
+}
+
+/**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
  *
@@ -2936,19 +3002,17 @@ out:
 
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
-	struct ata_queued_cmd *qc = NULL;
 	unsigned int i;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++)
+	for (i = 0; i < ATA_MAX_CMDS; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
-			qc = ata_qc_from_tag(ap, i);
-			break;
-		}
+			struct ata_queued_cmd *qc = &ap->qcmd[i];
 
-	if (qc)
-		qc->tag = i;
+			qc->tag = i;
+			return qc;
+		}
 
-	return qc;
+	return NULL;
 }
 
 /**
@@ -2995,6 +3059,16 @@ static void __ata_qc_complete(struct ata
 	struct ata_port *ap = qc->ap;
 	unsigned int tag, do_clear = 0;
 
+	WARN_ON(!spin_is_locked(&ap->host_set->lock));
+
+	if (likely(qc->flags & ATA_QCFLAG_ACTIVE)) {
+		assert(ap->queue_depth);
+		ap->queue_depth--;
+
+		if (!ap->queue_depth)
+			ap->flags &= ~ATA_FLAG_NCQ_QUEUED;
+	}
+
 	qc->flags = 0;
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
@@ -3012,6 +3086,8 @@ static void __ata_qc_complete(struct ata
 
 	if (likely(do_clear))
 		clear_bit(tag, &ap->qactive);
+	if (ap->cmd_waiters)
+		wake_up(&ap->cmd_wait_queue);
 }
 
 /**
@@ -3058,15 +3134,15 @@ void ata_qc_complete(struct ata_queued_c
 
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
 	 */
-	if (rc != 0)
+	if (unlikely(rc != 0))
 		return;
 
 	__ata_qc_complete(qc);
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	VPRINTK("EXIT\n");
 }
@@ -3095,6 +3171,72 @@ static inline int ata_should_dma_map(str
 	/* never reached */
 }
 
+/*
+ * NCQ and non-NCQ commands are mutually exclusive. So we have to deny a
+ * request to queue a non-NCQ command, if we have NCQ commands in flight (and
+ * vice versa).
+ */
+static inline int ata_qc_issue_ok(struct ata_port *ap,
+				  struct ata_queued_cmd *qc, int waiting)
+{
+	if (qc->flags & ATA_QCFLAG_PREEMPT)
+		return 1;
+	/*
+	 * if people are already waiting for a queue drain, don't allow a
+	 * new 'lucky' queuer to get in there
+	 */
+	if (ap->cmd_waiters > waiting)
+		return 0;
+
+	/*
+	 * If nothing is queued, it's always ok to continue.
+	 */
+	if (!ap->queue_depth)
+		return 1;
+
+	/*
+	 * Commands are queued. We can never allow a non-NCQ command to be
+	 * added in that case
+	 */
+	if (!(qc->flags & ATA_QCFLAG_NCQ))
+		return 0;
+
+	/*
+	 * Command is NCQ, allow it to be queued if the commands that are
+	 * currently running are also NCQ
+	 */
+	if (ap->flags & ATA_FLAG_NCQ_QUEUED)
+		return 1;
+
+	return 0;
+}
+
+static void ata_qc_issue_wait(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	DEFINE_WAIT(wait);
+
+	ap->cmd_waiters++;
+
+	do {
+		/*
+		 * we rely on the FIFO order of the exclusive waitqueues
+		 */
+		prepare_to_wait_exclusive(&ap->cmd_wait_queue, &wait,
+					  TASK_UNINTERRUPTIBLE);
+
+		if (!ata_qc_issue_ok(ap, qc, 1)) {
+			spin_unlock_irq(&ap->host_set->lock);
+			schedule();
+			spin_lock_irq(&ap->host_set->lock);
+		}
+
+		finish_wait(&ap->cmd_wait_queue, &wait);
+
+	} while (!ata_qc_issue_ok(ap, qc, 1));
+
+	ap->cmd_waiters--;
+}
+
 /**
  *	ata_qc_issue - issue taskfile to device
  *	@qc: command to issue to device
@@ -3114,6 +3256,18 @@ static inline int ata_should_dma_map(str
 int ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	int rc = ATA_QC_ISSUE_FATAL;
+
+	/*
+	 * see if we can queue one more command at this point in time, see
+	 * comment at ata_qc_issue_ok(). NCQ commands typically originate from
+	 * the SCSI layer, we can ask the mid layer to defer those commands
+	 * similar to a QUEUE_FULL condition on a 'real' SCSI device
+	 */
+	if (!ata_qc_issue_ok(ap, qc, 0)) {
+		ata_qc_issue_wait(ap, qc);
+		assert(ata_qc_issue_ok(ap, qc, 0));
+	}
 
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
@@ -3132,10 +3286,19 @@ int ata_qc_issue(struct ata_queued_cmd *
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	return ap->ops->qc_issue(qc);
+	if (qc->flags & ATA_QCFLAG_NCQ)
+		ap->flags |= ATA_FLAG_NCQ_QUEUED;
 
+	ap->queue_depth++;
+
+	rc = ap->ops->qc_issue(qc);
+	if (rc != ATA_QC_ISSUE_OK)
+		goto err_out;
+
+	return ATA_QC_ISSUE_OK;
 err_out:
-	return -1;
+	ata_qc_free(qc);
+	return rc;
 }
 
 
@@ -3200,7 +3363,8 @@ int ata_qc_issue_prot(struct ata_queued_
 
 	default:
 		WARN_ON(1);
-		return -1;
+		ata_qc_free(qc);
+		return ATA_QC_ISSUE_FATAL;
 	}
 
 	return 0;
@@ -3738,6 +3902,8 @@ static void ata_host_init(struct ata_por
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
+	init_waitqueue_head(&ap->cmd_wait_queue);
+	ap->cmd_waiters = 0;
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
@@ -4409,6 +4575,11 @@ EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
+EXPORT_SYMBOL_GPL(ata_scsi_block_requests);
+EXPORT_SYMBOL_GPL(ata_scsi_unblock_requests);
+EXPORT_SYMBOL_GPL(ata_scsi_requeue);
+EXPORT_SYMBOL_GPL(ata_read_log_page);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -105,6 +105,30 @@ out:
 	return rc;
 }
 
+static inline int scsi_rw_ncq_request(struct ata_device *dev,
+				      struct scsi_cmnd *cmd)
+{
+	if (!(dev->flags & ATA_DFLAG_NCQ))
+		return 0;
+
+	/*
+	 * return 1 for commands we will transform into NCQ requests
+	 */
+	switch (cmd->cmnd[0]) {
+		case READ_6:
+		case READ_10:
+		case READ_12:
+		case READ_16:
+		case WRITE_6:
+		case WRITE_10:
+		case WRITE_12:
+		case WRITE_16:
+			return 1;
+	}
+
+	return 0;
+}
+
 /**
  *	ata_scsi_qc_new - acquire new ata_queued_cmd reference
  *	@ap: ATA port to which the new command is attached
@@ -133,6 +157,18 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 {
 	struct ata_queued_cmd *qc;
 
+	/*
+	 * check if we need to defer this command
+	 */
+	if (ap->cmd_waiters)
+		return NULL;
+	if (ap->queue_depth) {
+		if (!scsi_rw_ncq_request(dev, cmd))
+			return NULL;
+		if (!(ap->flags & ATA_FLAG_NCQ_QUEUED))
+			return NULL;
+	}
+
 	qc = ata_qc_new_init(ap, dev);
 	if (qc) {
 		qc->scsicmd = cmd;
@@ -145,9 +181,6 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 			qc->sg = &qc->sgent;
 			qc->n_elem = 1;
 		}
-	} else {
-		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
-		done(cmd);
 	}
 
 	return qc;
@@ -336,6 +369,7 @@ int ata_scsi_slave_config(struct scsi_de
 	if (sdev->id < ATA_MAX_DEVICES) {
 		struct ata_port *ap;
 		struct ata_device *dev;
+		int depth;
 
 		ap = (struct ata_port *) &sdev->host->hostdata[0];
 		dev = &ap->device[sdev->id];
@@ -353,11 +387,70 @@ int ata_scsi_slave_config(struct scsi_de
 			 */
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
+
+		if (dev->flags & ATA_DFLAG_NCQ) {
+			int ddepth = ata_id_queue_depth(dev->id);
+
+			depth = min(sdev->host->can_queue, ddepth);
+			scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
+		}
 	}
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
 }
 
+int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
+{
+	struct ata_port *ap;
+	struct ata_device *dev;
+	int max_depth;
+
+	if (sdev->id >= ATA_MAX_DEVICES || queue_depth < 1)
+		return sdev->queue_depth;
+
+	ap = (struct ata_port *) &sdev->host->hostdata[0];
+	dev = &ap->device[sdev->id];
+
+	max_depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
+	if (queue_depth > max_depth)
+		queue_depth = max_depth;
+
+	scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, queue_depth);
+	return queue_depth;
+}
+
+void ata_scsi_requeue(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+
+	if (scmd) {
+		request_queue_t *q = scmd->device->request_queue;
+
+		scmd->request->flags &= ~REQ_DONTPREP;
+		scsi_delete_timer(scmd);
+		blk_requeue_request(q, scmd->request);
+
+		ata_qc_free(qc);
+	} else
+		ata_qc_complete(qc, ATA_ERR);
+}
+
+void ata_scsi_block_requests(struct ata_port *ap)
+{
+	struct Scsi_Host *host = ap->host;
+
+	scsi_block_requests(host);
+}
+
+void ata_scsi_unblock_requests(struct ata_port *ap)
+{
+	struct Scsi_Host *host = ap->host;
+
+	scsi_unblock_requests(host);
+}
+
+
+
 /**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
@@ -373,11 +466,12 @@ int ata_scsi_slave_config(struct scsi_de
 
 int ata_scsi_error(struct Scsi_Host *host)
 {
-	struct ata_port *ap;
+	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
 
 	DPRINTK("ENTER\n");
 
-	ap = (struct ata_port *) &host->hostdata[0];
+	printk("ata_scsi_err: host_failed=%d\n", host->host_failed);
+
 	ap->ops->eng_timeout(ap);
 
 	/* TODO: this is per-command; when queueing is supported
@@ -537,6 +631,7 @@ static unsigned int ata_scsi_rw_xlat(str
 {
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	unsigned int ncq = qc->dev->flags & ATA_DFLAG_NCQ;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = qc->dev->xfer_protocol;
@@ -551,8 +646,18 @@ static unsigned int ata_scsi_rw_xlat(str
 	}
 
 	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
-		if (lba48) {
+		if (ncq) {
+			tf->hob_feature = scsicmd[7];
+			tf->feature = scsicmd[8];
+			tf->nsect = qc->tag << 3;
+			tf->hob_lbal = scsicmd[2];
+			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
+					scsicmd[8];
+			tf->device &= ~ATA_DEVICE_OBS;
+			qc->flags |= ATA_QCFLAG_NCQ;
+		} else if (lba48) {
 			tf->hob_nsect = scsicmd[7];
+			tf->nsect = scsicmd[8];
 			tf->hob_lbal = scsicmd[2];
 
 			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
@@ -563,13 +668,14 @@ static unsigned int ata_scsi_rw_xlat(str
 			if ((scsicmd[2] & 0xf0) || scsicmd[7])
 				return 1;
 
+			tf->nsect = scsicmd[8];
+
 			/* stores LBA27:24 in lower 4 bits of device reg */
 			tf->device |= scsicmd[2];
 
 			qc->nsect = scsicmd[8];
 		}
 
-		tf->nsect = scsicmd[8];
 		tf->lbal = scsicmd[5];
 		tf->lbam = scsicmd[4];
 		tf->lbah = scsicmd[3];
@@ -579,7 +685,16 @@ static unsigned int ata_scsi_rw_xlat(str
 	}
 
 	if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
-		qc->nsect = tf->nsect = scsicmd[4];
+		qc->nsect = scsicmd[4];
+
+		if (ncq) {
+			tf->nsect = qc->tag << 3;
+			tf->feature = scsicmd[4];
+			tf->device &= ~ATA_DEVICE_OBS;
+			qc->flags |= ATA_QCFLAG_NCQ;
+		} else
+			tf->nsect = scsicmd[4];
+
 		tf->lbal = scsicmd[3];
 		tf->lbam = scsicmd[2];
 		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
@@ -593,11 +708,23 @@ static unsigned int ata_scsi_rw_xlat(str
 		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
 			return 1;
 
-		if (lba48) {
+		if (ncq) {
+			tf->feature = scsicmd[13];
+			tf->hob_feature = scsicmd[12];
+			tf->nsect = qc->tag << 3;
+			tf->hob_lbal = scsicmd[6];
+			tf->hob_lbam = scsicmd[5];
+			tf->hob_lbah = scsicmd[4];
+			tf->device &= ~ATA_DEVICE_OBS;
+			qc->nsect = ((unsigned int)scsicmd[12] << 8) |
+					scsicmd[13];
+			qc->flags |= ATA_QCFLAG_NCQ;
+		} else if (lba48) {
 			tf->hob_nsect = scsicmd[12];
 			tf->hob_lbal = scsicmd[6];
 			tf->hob_lbam = scsicmd[5];
 			tf->hob_lbah = scsicmd[4];
+			tf->nsect = scsicmd[13];
 
 			qc->nsect = ((unsigned int)scsicmd[12] << 8) |
 					scsicmd[13];
@@ -607,13 +734,13 @@ static unsigned int ata_scsi_rw_xlat(str
 			    (scsicmd[6] & 0xf0))
 				return 1;
 
+			tf->nsect = scsicmd[13];
 			/* stores LBA27:24 in lower 4 bits of device reg */
 			tf->device |= scsicmd[6];
 
 			qc->nsect = scsicmd[13];
 		}
 
-		tf->nsect = scsicmd[13];
 		tf->lbal = scsicmd[9];
 		tf->lbam = scsicmd[8];
 		tf->lbah = scsicmd[7];
@@ -666,12 +793,19 @@ static void ata_scsi_translate(struct at
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
+	int ret;
 
 	VPRINTK("ENTER\n");
 
+	/*
+	 * QUEUE_FULL, defer command
+	 */
 	qc = ata_scsi_qc_new(ap, dev, cmd, done);
-	if (!qc)
+	if (!qc) {
+		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
+		done(cmd);
 		return;
+	}
 
 	/* data is present; dma-map it */
 	if (cmd->sc_data_direction == DMA_FROM_DEVICE ||
@@ -697,9 +831,10 @@ static void ata_scsi_translate(struct at
 		goto err_out;
 
 	/* select device, send command to hardware */
-	if (ata_qc_issue(qc))
+	ret = ata_qc_issue(qc);
+	if (ret == ATA_QC_ISSUE_FATAL)
 		goto err_out;
-
+ 
 	VPRINTK("EXIT\n");
 	return;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1292,13 +1292,17 @@ static void scsi_request_fn(struct reque
 	shost = sdev->host;
 	while (!blk_queue_plugged(q)) {
 		int rtn;
+
+		if (!scsi_dev_queue_ready(q, sdev))
+			break;
+
 		/*
 		 * get next queueable request.  We do this early to make sure
 		 * that the request is fully prepared even if we cannot 
 		 * accept it.
 		 */
 		req = elv_next_request(q);
-		if (!req || !scsi_dev_queue_ready(q, sdev))
+		if (!req)
 			break;
 
 		if (unlikely(!scsi_device_online(sdev))) {
diff --git a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -125,9 +125,17 @@ enum {
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,
+	ATA_CMD_FPDMA_READ	= 0x60,
+	ATA_CMD_FPDMA_WRITE	= 0x61,
+	ATA_CMD_READ_LOG_EXT	= 0x2f,
+
+	/* READ_LOG_EXT pages */
+	READ_LOG_SATA_NCQ_PAGE	= 0x10,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
+	SETFEATURES_EN_WCACHE	= 0x02,
+	SETFEATURES_DIS_WCACHE	= 0x82,
 	XFER_UDMA_7		= 0x47,
 	XFER_UDMA_6		= 0x46,
 	XFER_UDMA_5		= 0x45,
@@ -233,7 +241,9 @@ struct ata_taskfile {
 #define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -80,7 +80,8 @@ enum {
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
 	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
-	ATA_MAX_QUEUE		= 1,
+	ATA_MAX_CMDS		= 31,	/* to avoid SActive 0xffffffff error */
+	ATA_MAX_QUEUE		= 30,	/* leave one command for errors */
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
@@ -95,6 +96,7 @@ enum {
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
 	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
+	ATA_DFLAG_NCQ		= (1 << 3), /* Device can do NCQ */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -113,11 +115,18 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
+	ATA_FLAG_NCQ_QUEUED	= (1 << 10), /* NCQ commands are queued */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
+	ATA_QCFLAG_NCQ		= (1 << 5), /* using NCQ */
+	ATA_QCFLAG_PREEMPT	= (1 << 6), /* for error handling */
+
+	ATA_QC_ISSUE_OK		= 0,
+	ATA_QC_ISSUE_FATAL	= -1,
 
 	/* various lengths of time */
 	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
@@ -305,9 +314,13 @@ struct ata_port {
 
 	struct ata_device	device[ATA_MAX_DEVICES];
 
-	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
+	struct ata_queued_cmd	qcmd[ATA_MAX_CMDS];
 	unsigned long		qactive;
 	unsigned int		active_tag;
+	unsigned int		queue_depth;
+
+	wait_queue_head_t	cmd_wait_queue;
+	unsigned int		cmd_waiters;
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
@@ -434,6 +447,12 @@ extern int ata_std_bios_param(struct scs
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern int ata_scsi_change_queue_depth(struct scsi_device *, int);
+extern void ata_scsi_block_requests(struct ata_port *);
+extern void ata_scsi_unblock_requests(struct ata_port *);
+extern void ata_scsi_requeue(struct ata_queued_cmd *);
+extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
+			     unsigned int);
 
 
 #ifdef CONFIG_PCI
@@ -453,7 +472,7 @@ extern int pci_test_config_bits(struct p
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
-	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
+	return (tag < ATA_MAX_CMDS) ? 1 : 0;
 }
 
 static inline unsigned int ata_dev_present(struct ata_device *dev)
@@ -540,11 +559,19 @@ static inline void ata_qc_set_polling(st
 	qc->tf.ctl |= ATA_NIEN;
 }
 
-static inline struct ata_queued_cmd *ata_qc_from_tag (struct ata_port *ap,
-						      unsigned int tag)
+/*
+ * Only return the qc, if it is currently 'active'
+ */
+static inline struct ata_queued_cmd *ata_qc_from_tag(struct ata_port *ap,
+						     unsigned int tag)
 {
-	if (likely(ata_tag_valid(tag)))
-		return &ap->qcmd[tag];
+	if (likely(ata_tag_valid(tag))) {
+		struct ata_queued_cmd *qc = &ap->qcmd[tag];
+
+		if (tag == qc->tag)
+			return qc;
+	}
+
 	return NULL;
 }
 

-- 
Jens Axboe

