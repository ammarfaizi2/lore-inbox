Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVEaMtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVEaMtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEaMth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:49:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32920 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261319AbVEaMqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:46:11 -0400
Date: Tue, 31 May 2005 14:47:00 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] SATA NCQ #3
Message-ID: <20050531124659.GB1530@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updated patch. Changes:

- (ahci) improve error handling some more.

- (libata) kill double queue depth accounting, add ap->queue_depth and
  use ap->flags & ATA_FLAG_NCQ_QUEUED to differentiate between the two.

- (libata) cleanup the reissue-on-busy logic. punt everything to SCSI,
  if we can. We can kill ATA_QCFLAG_DEFER and ATA_QC_ISSUE_DEFER then.

- (libata) leave ATA_DEVICE_OBS alone, which means we have to clear bit
  7 in the NCQ command setup.

- (libata) import an error handling fix from Hannes.

- various other fixes/cleanups.

Error handling still needs some work, but at least it's a little less
embarassing now (and doesn't hang the kernel if it triggers).

Jeff, I'll update your ncq branch at the end of this week if you don't
beat me to it.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -19,8 +19,8 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
- * Version 1.0 of the AHCI specification:
- * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * Version 1.1 of the AHCI specification:
+ * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  *
  */
 
@@ -47,10 +47,13 @@ enum {
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
@@ -58,6 +61,7 @@ enum {
 	AHCI_CMD_WRITE		= (1 << 6),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+	RX_FIS_SDB_REG		= 0x58,	/* offset of SDB Register FIS data */
 
 	board_ahci		= 0,
 
@@ -75,6 +79,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -162,9 +167,9 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
 	dma_addr_t		cmd_tbl_dma;
-	struct ahci_sg		*cmd_tbl_sg;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
+	u32			sactive;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -182,7 +187,7 @@ static void ahci_tf_read(struct ata_port
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static inline int ahci_host_intr(struct ata_port *ap);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -190,7 +195,8 @@ static Scsi_Host_Template ahci_sht = {
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= ATA_MAX_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
 	.max_sectors		= ATA_MAX_SECTORS,
@@ -201,7 +207,7 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
+	.ordered_flush		= 0, /* conflicts with NCQ for now */
 };
 
 static struct ata_port_operations ahci_ops = {
@@ -342,14 +348,11 @@ static int ahci_port_start(struct ata_po
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
@@ -481,9 +484,10 @@ static void ahci_tf_read(struct ata_port
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static void ahci_fill_sg(struct ata_queued_cmd *qc)
+static void ahci_fill_sg(struct ata_queued_cmd *qc, int offset)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ahci_sg *cmd_tbl_sg;
 	unsigned int i;
 
 	VPRINTK("ENTER\n");
@@ -491,6 +495,7 @@ static void ahci_fill_sg(struct ata_queu
 	/*
 	 * Next, the S/G list.
 	 */
+	cmd_tbl_sg = pp->cmd_tbl + offset + AHCI_CMD_TBL_HDR;
 	for (i = 0; i < qc->n_elem; i++) {
 		u32 sg_len;
 		dma_addr_t addr;
@@ -498,21 +503,22 @@ static void ahci_fill_sg(struct ata_queu
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
@@ -531,29 +537,39 @@ static void ahci_qc_prep(struct ata_queu
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
@@ -575,6 +591,10 @@ static void ahci_intr_error(struct ata_p
 	tmp = readl(port_mmio + PORT_SCR_ERR);
 	writel(tmp, port_mmio + PORT_SCR_ERR);
 
+	/* clear status */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	writel(tmp, port_mmio + PORT_IRQ_STAT);
+
 	/* if DRQ/BSY is set, device needs to be reset.
 	 * if so, issue COMRESET
 	 */
@@ -585,6 +605,7 @@ static void ahci_intr_error(struct ata_p
 		udelay(10);
 		writel(0x300, port_mmio + PORT_SCR_CTL);
 		readl(port_mmio + PORT_SCR_CTL); /* flush */
+		reset = 1;
 	}
 
 	/* re-start DMA */
@@ -594,9 +615,108 @@ static void ahci_intr_error(struct ata_p
 	readl(port_mmio + PORT_CMD); /* flush */
 
 	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
+	return reset;
 }
 
-static void ahci_eng_timeout(struct ata_port *ap)
+static void ahci_complete_requests(struct ata_port *ap, unsigned int tag_mask,
+				   int err)
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
+	unsigned long flags;
+	char *buffer;
+	u32 sactive;
+	int reset;
+
+	printk(KERN_ERR "ata%u: ncq interrupt error\n", ap->id);
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	sactive = readl(port_mmio + PORT_SCR_ACT);
+
+	printk(KERN_ERR "ata%u: SActive 0x%x (0x%x)\n", ap->id, sactive, pp->sactive);
+	reset = ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+
+	sactive &= pp->sactive;
+	while (sactive) {
+		struct ata_queued_cmd *qc;
+		int tag = ffs(sactive) - 1;
+
+		sactive &= ~(1 << tag);
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			if (qc->scsicmd)
+				ata_qc_free(qc);
+			else
+				ata_qc_complete(qc, ATA_ERR);
+		} else
+			printk(KERN_ERR "ahci: missing tag %d\n", tag);
+	}
+
+	printk(KERN_ERR "requeued commands, busy %d, ncq %d\n", ap->queue_depth, (int) (ap->flags & ATA_FLAG_NCQ_QUEUED));
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	printk(KERN_ERR "ata%u: COMRESET done %d\n", ap->id, reset);
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
@@ -620,13 +740,84 @@ static void ahci_eng_timeout(struct ata_
 		qc->scsidone = scsi_finish_command;
 		ata_qc_complete(qc, ATA_ERR);
 	}
+}
+
+static void ahci_eng_timeout(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_NCQ_QUEUED)
+		ahci_ncq_timeout(ap);
+	else
+		ahci_nonncq_timeout(ap);
+}
+
+static inline void ahci_ncq_intr(struct ata_port *ap, u32 status)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 sactive;
+
+	if (status & PORT_IRQ_D2H_REG_FIS) {
+		u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+		/*
+		 * pre-BSY clear error, let timeout error handling take care
+		 * of it when it kicks in
+		 */
+		if (d2h_fis[2] & ATA_ERR) {
+			VPRINTK("D2H fis, err %x\n", d2h_fis[2]);
+			return;
+		}
+	} else if (status & PORT_IRQ_SDB_FIS) {
+		u8 *sdb_fis = pp->rx_fis + RX_FIS_SDB_REG;
+
+		if (sdb_fis[1] & ATA_ERR) {
+			VPRINTK("SDB fis, err %x\n", sdb_fis[1]);
+			return;
+		}
+	}
+
+	/*
+	 * SActive will have the bits cleared for completed commands
+	 */
+	sactive = readl(port_mmio + PORT_SCR_ACT);
+	ahci_complete_requests(ap, pp->sactive & ~sactive, 0);
+	pp->sactive = sactive;
+}
+
+static void ahci_ncq_intr_error(struct ata_port *ap, u32 status)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ata_queued_cmd *qc;
+	struct ata_taskfile tf;
+	int tag;
+
+	/*
+	 * let command timeout deal with error handling
+	 */
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
 
+	ata_scsi_block_requests(ap);
 }
 
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+static inline int ahci_host_intr(struct ata_port *ap)
 {
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ata_queued_cmd *qc;
 	u32 status, serr, ci;
 
 	serr = readl(port_mmio + PORT_SCR_ERR);
@@ -635,18 +826,28 @@ static inline int ahci_host_intr(struct 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	ci = readl(port_mmio + PORT_CMD_ISSUE);
-	if (likely((ci & 0x1) == 0)) {
-		if (qc) {
-			ata_qc_complete(qc, 0);
-			qc = NULL;
+	if (ap->flags & ATA_FLAG_NCQ_QUEUED) {
+		VPRINTK("NCQ interrupt\n");
+
+		if (unlikely(status & PORT_IRQ_FATAL))
+			ahci_ncq_intr_error(ap, status);
+		else
+			ahci_ncq_intr(ap, status);
+	} else {
+		VPRINTK("NON-NCQ interrupt\n");
+		ci = readl(port_mmio + PORT_CMD_ISSUE);
+		if (likely((ci & 0x1) == 0)) {
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc)
+				ata_qc_complete(qc, 0);
 		}
-	}
 
-	if (status & PORT_IRQ_FATAL) {
-		ahci_intr_error(ap, status);
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
+		if (status & PORT_IRQ_FATAL) {
+			ahci_intr_error(ap, status);
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc)
+				ata_qc_complete(qc, ATA_ERR);
+		}
 	}
 
 	return 1;
@@ -686,9 +887,7 @@ static irqreturn_t ahci_interrupt (int i
 		ap = host_set->ports[i];
 		tmp = irq_stat & (1 << i);
 		if (tmp && ap) {
-			struct ata_queued_cmd *qc;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (ahci_host_intr(ap, qc))
+			if (ahci_host_intr(ap))
 				irq_ack |= (1 << i);
 		}
 	}
@@ -708,12 +907,17 @@ static irqreturn_t ahci_interrupt (int i
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = qc->ap->private_data;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_SCR_ACT);
-	readl(port_mmio + PORT_SCR_ACT);	/* flush */
+	if (qc->flags & ATA_QCFLAG_NCQ) {
+		pp->sactive |= (1 << qc->tag);
 
-	writel(1, port_mmio + PORT_CMD_ISSUE);
+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+		readl(port_mmio + PORT_SCR_ACT);	/* flush */
+	}
+
+	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
@@ -1030,6 +1234,9 @@ static int ahci_init_one (struct pci_dev
 	if (rc)
 		goto err_out_hpriv;
 
+	if (hpriv->cap & HOST_CAP_NCQ)
+		probe_ent->host_flags |= ATA_FLAG_NCQ;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -41,6 +41,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "scsi_priv.h"
+#include "scsi_logging.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -61,6 +62,10 @@ static int ata_choose_xfer_mode(struct a
 				unsigned int *xfer_shift_out);
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
+#if 0
+static void ata_dev_set_wb_cache(struct ata_port *ap, struct ata_device *dev,
+				 int cache_on);
+#endif
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -519,7 +524,7 @@ void ata_tf_from_fis(u8 *fis, struct ata
  *	LOCKING:
  *	None.
  */
-static int ata_prot_to_cmd(int protocol, int lba48)
+static int ata_prot_to_cmd(int protocol, int lba48, int ncq)
 {
 	int rcmd = 0, wcmd = 0;
 
@@ -535,7 +540,10 @@ static int ata_prot_to_cmd(int protocol,
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
@@ -568,6 +576,7 @@ static void ata_dev_set_protocol(struct 
 {
 	int pio = (dev->flags & ATA_DFLAG_PIO);
 	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
+	int ncq = (dev->flags & ATA_DFLAG_NCQ);
 	int proto, cmd;
 
 	if (pio)
@@ -575,7 +584,7 @@ static void ata_dev_set_protocol(struct 
 	else
 		proto = dev->xfer_protocol = ATA_PROT_DMA;
 
-	cmd = ata_prot_to_cmd(proto, lba48);
+	cmd = ata_prot_to_cmd(proto, lba48, ncq);
 	if (cmd < 0)
 		BUG();
 
@@ -1139,6 +1148,10 @@ retry:
 			goto err_out_nosup;
 		}
 
+		/* host NCQ is required as well as device support */
+		if ((ap->flags & ATA_FLAG_NCQ) && ata_id_has_ncq(dev->id))
+			dev->flags |= ATA_DFLAG_NCQ;
+
 		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
 			dev->n_sectors = ata_id_u64(dev->id, 100);
@@ -1149,11 +1162,12 @@ retry:
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
@@ -1187,6 +1201,63 @@ err_out:
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
@@ -1210,6 +1281,9 @@ static int ata_bus_probe(struct ata_port
 			found = 1;
 			if (ap->ops->dev_config)
 				ap->ops->dev_config(ap, &ap->device[i]);
+#if 0
+			ata_dev_set_wb_cache(ap, &ap->device[i], 1);
+#endif
 		}
 	}
 
@@ -1904,6 +1978,48 @@ static int ata_choose_xfer_mode(struct a
 	return -1;
 }
 
+#if 0
+static void ata_dev_set_wb_cache(struct ata_port *ap, struct ata_device *dev,
+				 int cache_on)
+{
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int rc;
+
+	if (dev->class != ATA_DEV_ATA)
+		return;
+	if (!ata_id_has_wcache(dev->id))
+		return;
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	qc->tf.command = ATA_CMD_SET_FEATURES;
+	if (cache_on)
+		qc->tf.feature = SETFEATURES_EN_WCACHE;
+	else
+		qc->tf.feature = SETFEATURES_DIS_WCACHE;
+		
+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	qc->tf.protocol = ATA_PROT_NODATA;
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc)
+		ata_port_disable(ap);
+	else
+		wait_for_completion(&wait);
+
+	printk("ata%u: writecache %sabled\n", ap->id, cache_on ? "en" : "dis");
+}
+#endif
+
 /**
  *	ata_dev_set_xfermode - Issue SET FEATURES - XFER MODE command
  *	@ap: Port associated with device @dev
@@ -2567,6 +2683,11 @@ static void atapi_request_sense(struct a
 	DPRINTK("EXIT\n");
 }
 
+void ata_qc_timeout_done(struct scsi_cmnd *scmd)
+{
+	return;
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -2594,21 +2715,20 @@ static void ata_qc_timeout(struct ata_qu
 	DPRINTK("ENTER\n");
 
 	/* FIXME: doesn't this conflict with timeout handling? */
-	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
+	if (qc->scsicmd) {
 		struct scsi_cmnd *cmd = qc->scsicmd;
 
 		if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
-
 			/* finish completing original command */
+			qc->scsidone = ata_qc_timeout_done;
+
 			__ata_qc_complete(qc);
 
 			atapi_request_sense(ap, dev, cmd);
 
 			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
 		}
+		goto out;
 	}
 
 	/* hack alert!  We cannot use the supplied completion
@@ -2699,7 +2819,7 @@ static struct ata_queued_cmd *ata_qc_new
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int i;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++)
+	for (i = 0; i < ATA_MAX_CMDS; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
 			qc = ata_qc_from_tag(ap, i);
 			break;
@@ -2754,6 +2874,14 @@ static void __ata_qc_complete(struct ata
 	struct ata_port *ap = qc->ap;
 	unsigned int tag, do_clear = 0;
 
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
@@ -2771,6 +2899,8 @@ static void __ata_qc_complete(struct ata
 
 	if (likely(do_clear))
 		clear_bit(tag, &ap->qactive);
+	if (ap->cmd_waiters)
+		wake_up(&ap->cmd_wait_queue);
 }
 
 /**
@@ -2812,15 +2942,15 @@ void ata_qc_complete(struct ata_queued_c
 
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
@@ -2849,6 +2979,72 @@ static inline int ata_should_dma_map(str
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
@@ -2868,6 +3064,18 @@ static inline int ata_should_dma_map(str
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
@@ -2886,10 +3094,19 @@ int ata_qc_issue(struct ata_queued_cmd *
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	return ap->ops->qc_issue(qc);
+	if (qc->flags & ATA_QCFLAG_NCQ)
+		ap->flags |= ATA_FLAG_NCQ_QUEUED;
+
+	ap->queue_depth++;
+
+	rc = ap->ops->qc_issue(qc);
+	if (rc != ATA_QC_ISSUE_OK)
+		goto err_out;
 
+	return ATA_QC_ISSUE_OK;
 err_out:
-	return -1;
+	ata_qc_free(qc);
+	return rc;
 }
 
 /**
@@ -2951,7 +3168,8 @@ int ata_qc_issue_prot(struct ata_queued_
 
 	default:
 		WARN_ON(1);
-		return -1;
+		ata_qc_free(qc);
+		return ATA_QC_ISSUE_FATAL;
 	}
 
 	return 0;
@@ -3390,6 +3608,8 @@ static void ata_host_init(struct ata_por
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
+	init_waitqueue_head(&ap->cmd_wait_queue);
+	ap->cmd_waiters = 0;
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
@@ -4025,6 +4245,11 @@ EXPORT_SYMBOL_GPL(ata_host_intr);
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
@@ -373,18 +466,13 @@ int ata_scsi_slave_config(struct scsi_de
 
 int ata_scsi_error(struct Scsi_Host *host)
 {
-	struct ata_port *ap;
+	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
 
 	DPRINTK("ENTER\n");
 
-	ap = (struct ata_port *) &host->hostdata[0];
-	ap->ops->eng_timeout(ap);
+	printk("ata_scsi_err: host_failed=%d\n", host->host_failed);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
+	ap->ops->eng_timeout(ap);
 
 	DPRINTK("EXIT\n");
 	return 0;
@@ -537,6 +625,7 @@ static unsigned int ata_scsi_rw_xlat(str
 {
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	unsigned int ncq = qc->dev->flags & ATA_DFLAG_NCQ;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = qc->dev->xfer_protocol;
@@ -550,8 +639,22 @@ static unsigned int ata_scsi_rw_xlat(str
 		tf->flags |= ATA_TFLAG_WRITE;
 	}
 
+	if (ncq)
+		qc->flags |= ATA_QCFLAG_NCQ;
+
 	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
-		if (lba48) {
+		if (ncq) {
+			tf->hob_feature = scsicmd[7];
+			tf->feature = scsicmd[8];
+			tf->nsect = qc->tag << 3;
+			tf->hob_lbal = scsicmd[2];
+			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
+					scsicmd[8];
+			/*
+			 * silly, but the ATA_DEVICE_OBS overlaps with FUA
+			 */
+			tf->device &= ~(1 << 7);
+		} else if (lba48) {
 			tf->hob_nsect = scsicmd[7];
 			tf->hob_lbal = scsicmd[2];
 
@@ -569,7 +672,8 @@ static unsigned int ata_scsi_rw_xlat(str
 			qc->nsect = scsicmd[8];
 		}
 
-		tf->nsect = scsicmd[8];
+		if (!ncq)
+			tf->nsect = scsicmd[8];
 		tf->lbal = scsicmd[5];
 		tf->lbam = scsicmd[4];
 		tf->lbah = scsicmd[3];
@@ -579,7 +683,18 @@ static unsigned int ata_scsi_rw_xlat(str
 	}
 
 	if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
-		qc->nsect = tf->nsect = scsicmd[4];
+		qc->nsect = scsicmd[4];
+
+		if (ncq) {
+			tf->nsect = qc->tag << 3;
+			tf->feature = scsicmd[4];
+			/*
+			 * silly, but the ATA_DEVICE_OBS overlaps with FUA
+			 */
+			tf->device &= ~(1 << 7);
+		} else
+			tf->nsect = scsicmd[4];
+
 		tf->lbal = scsicmd[3];
 		tf->lbam = scsicmd[2];
 		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
@@ -593,7 +708,20 @@ static unsigned int ata_scsi_rw_xlat(str
 		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
 			return 1;
 
-		if (lba48) {
+		if (ncq) {
+			tf->hob_feature = scsicmd[13];
+			tf->feature = scsicmd[12];
+			tf->nsect = qc->tag << 3;
+			tf->hob_lbal = scsicmd[6];
+			tf->hob_lbam = scsicmd[5];
+			tf->hob_lbah = scsicmd[4];
+			/*
+			 * silly, but the ATA_DEVICE_OBS overlaps with FUA
+			 */
+			tf->device &= ~(1 << 7);
+			qc->nsect = ((unsigned int)scsicmd[12] << 8) |
+					scsicmd[13];
+		} else if (lba48) {
 			tf->hob_nsect = scsicmd[12];
 			tf->hob_lbal = scsicmd[6];
 			tf->hob_lbam = scsicmd[5];
@@ -613,7 +741,8 @@ static unsigned int ata_scsi_rw_xlat(str
 			qc->nsect = scsicmd[13];
 		}
 
-		tf->nsect = scsicmd[13];
+		if (!ncq)
+			tf->nsect = scsicmd[13];
 		tf->lbal = scsicmd[9];
 		tf->lbam = scsicmd[8];
 		tf->lbah = scsicmd[7];
@@ -666,12 +795,19 @@ static void ata_scsi_translate(struct at
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
@@ -697,9 +833,10 @@ static void ata_scsi_translate(struct at
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
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1613,6 +1613,40 @@ static void scsi_unjam_host(struct Scsi_
 	scsi_eh_flush_done_q(&eh_done_q);
 }
 
+static void scsi_invoke_strategy_handler(struct Scsi_Host *shost)
+{
+	int rtn;
+	struct list_head *lh, *lh_sf;
+	struct scsi_cmnd *scmd;
+	unsigned long flags;
+	LIST_HEAD(eh_work_q);
+	LIST_HEAD(eh_done_q);
+
+	rtn = shost->hostt->eh_strategy_handler(shost);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	list_splice_init(&shost->eh_cmd_q, &eh_work_q);
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
+
+	list_for_each_safe(lh, lh_sf, &eh_work_q) {
+		scmd = list_entry(lh, struct scsi_cmnd, eh_entry);
+
+		if (scsi_eh_eflags_chk(scmd, SCSI_EH_CANCEL_CMD) ||
+		    !SCSI_SENSE_VALID(scmd))
+			continue;
+		scmd->retries = scmd->allowed;
+		scsi_eh_finish_cmd(scmd, &eh_done_q);
+	}
+
+	if (!list_empty(&eh_work_q))
+		if (!scsi_eh_abort_cmds(&eh_work_q, &eh_done_q))
+			scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
+
+	scsi_eh_flush_done_q(&eh_done_q);
+}
+
 /**
  * scsi_error_handler - Handle errors/timeouts of SCSI cmds.
  * @data:	Host for which we are running.
@@ -1627,7 +1661,6 @@ static void scsi_unjam_host(struct Scsi_
 int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
-	int rtn;
 	DECLARE_MUTEX_LOCKED(sem);
 
 	/*
@@ -1683,8 +1716,8 @@ int scsi_error_handler(void *data)
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (shost->hostt->eh_strategy_handler) 
-			rtn = shost->hostt->eh_strategy_handler(shost);
+		if (shost->hostt->eh_strategy_handler)
+			scsi_invoke_strategy_handler(shost);
 		else
 			scsi_unjam_host(shost);
 
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

-- 
Jens Axboe

