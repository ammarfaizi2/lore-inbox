Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVE0HNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVE0HNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVE0HMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:12:50 -0400
Received: from brick.kernel.dk ([62.242.22.158]:36553 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261920AbVE0HC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:02:57 -0400
Date: Fri, 27 May 2005 09:03:54 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] SATA NCQ support
Message-ID: <20050527070353.GL1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Update the patch, it's against bleeding edge git (applies to 2.6.12-rc5
as well). Changes:

- (libata) Change to SCSI change_queue_depth API, kill current hack.

- (ahci) Move SActive bit set to ahci_qc_issue() where it belongs.

- (ahci) Check fatal irq mask for NCQ.

- (libata) Check IDENTIFICATION page for NCQ support

- (libata) Remove legacy code from ata_read_log_page()

- (libata) Split ATA_MAX_QUEUE into ATA_MAX_QUEUE and ATA_MAX_CMDS.


Index: drivers/scsi/ahci.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/drivers/scsi/ahci.c  (mode:100644)
+++ uncommitted/drivers/scsi/ahci.c  (mode:100644)
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
 
@@ -46,10 +46,13 @@
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
@@ -57,6 +60,7 @@
 	AHCI_CMD_WRITE		= (1 << 6),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+	RX_FIS_SDB_REG		= 0x58,	/* offset of SDB Register FIS data */
 
 	board_ahci		= 0,
 
@@ -74,6 +78,7 @@
 
 	/* HOST_CAP bits */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -161,9 +166,9 @@
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
 	dma_addr_t		cmd_tbl_dma;
-	struct ahci_sg		*cmd_tbl_sg;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
+	u32			sactive;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -181,7 +186,7 @@
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static inline int ahci_host_intr(struct ata_port *ap);
 
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -189,7 +194,8 @@
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= ATA_MAX_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
 	.max_sectors		= ATA_MAX_SECTORS,
@@ -200,7 +206,7 @@
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
+	.ordered_flush		= 0, /* conflicts with NCQ for now */
 };
 
 static struct ata_port_operations ahci_ops = {
@@ -339,14 +345,11 @@
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
@@ -478,9 +481,10 @@
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static void ahci_fill_sg(struct ata_queued_cmd *qc)
+static void ahci_fill_sg(struct ata_queued_cmd *qc, int offset)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ahci_sg *cmd_tbl_sg;
 	unsigned int i;
 
 	VPRINTK("ENTER\n");
@@ -488,6 +492,7 @@
 	/*
 	 * Next, the S/G list.
 	 */
+	cmd_tbl_sg = pp->cmd_tbl + offset + AHCI_CMD_TBL_HDR;
 	for (i = 0; i < qc->n_elem; i++) {
 		u32 sg_len;
 		dma_addr_t addr;
@@ -495,21 +500,22 @@
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
@@ -528,21 +534,28 @@
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
 
 static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
@@ -593,7 +606,54 @@
 	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
 }
 
-static void ahci_eng_timeout(struct ata_port *ap)
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
+static void ahci_host_ncq_intr_err(struct ata_port *ap)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	char *buffer;
+
+	printk(KERN_ERR "ata%u: ncq interrupt error\n", ap->id);
+
+	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+
+	buffer = kmalloc(512, GFP_KERNEL);
+	if (!buffer) {
+		printk(KERN_ERR "ata%u: unable to allocate memory for error\n", ap->id);
+		return;
+	}
+
+	if (ata_read_log_page(ap, 0, 0x10, buffer, 1)) {
+		printk(KERN_ERR "ata%u: unable to read log page\n", ap->id);
+		goto out;
+	}
+
+	dump_log_page(buffer);
+
+out:
+	kfree(buffer);
+}
+
+/*
+ * TODO: needs to use READ_LOG_EXT/page=10h to retrieve error information
+ */
+static void ahci_ncq_timeout(struct ata_port *ap)
+{
+	ahci_host_ncq_intr_err(ap);
+}
+
+static void ahci_nonncq_timeout(struct ata_port *ap)
 {
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -617,13 +677,65 @@
 		qc->scsidone = scsi_finish_command;
 		ata_qc_complete(qc, ATA_ERR);
 	}
+}
+
+static void ahci_eng_timeout(struct ata_port *ap)
+{
+	if (ap->ncq_depth)
+		ahci_ncq_timeout(ap);
+	else
+		ahci_nonncq_timeout(ap);
+}
+
+static inline void ahci_host_ncq_intr(struct ata_port *ap, u32 status)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tags, sactive;
+
+	if (status & PORT_IRQ_D2H_REG_FIS) {
+		u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+		/*
+		 * pre-BSY clear error, let timeout error handling take care
+		 * of it when it kicks in
+		 */
+		if (d2h_fis[2] & ATA_ERR)
+			return;
+	} else if (status & PORT_IRQ_SDB_FIS) {
+		u8 *sdb_fis = pp->rx_fis + RX_FIS_SDB_REG;
+
+		if (sdb_fis[1] & ATA_ERR)
+			return;
+	}
+
+	/*
+	 * SActive will have the bits cleared for completed commands
+	 */
+	sactive = readl(port_mmio + PORT_SCR_ACT);
+	tags = pp->sactive & ~sactive;
+
+	while (tags) {
+		struct ata_queued_cmd *qc;
+		int tag = ffs(tags) - 1;
+
+		tags &= ~(1 << tag);
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc)
+			ata_qc_complete(qc, 0);
+		else
+			printk(KERN_ERR "ahci: missing tag %d\n", tag);
+	}
 
+	pp->sactive = sactive;
 }
 
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+static inline int ahci_host_intr(struct ata_port *ap)
 {
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ata_queued_cmd *qc;
 	u32 status, serr, ci;
 
 	serr = readl(port_mmio + PORT_SCR_ERR);
@@ -632,18 +744,27 @@
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	ci = readl(port_mmio + PORT_CMD_ISSUE);
-	if (likely((ci & 0x1) == 0)) {
-		if (qc) {
-			ata_qc_complete(qc, 0);
-			qc = NULL;
+	if (ap->ncq_depth) {
+		if (serr || (status & PORT_IRQ_FATAL))
+			ahci_host_ncq_intr_err(ap);
+		else
+			ahci_host_ncq_intr(ap, status);
+	} else {
+		ci = readl(port_mmio + PORT_CMD_ISSUE);
+		if (likely((ci & 0x1) == 0)) {
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc) {
+				ata_qc_complete(qc, 0);
+				qc = NULL;
+			}
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
@@ -683,9 +804,7 @@
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
@@ -705,12 +824,17 @@
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = qc->ap->private_data;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_SCR_ACT);
-	readl(port_mmio + PORT_SCR_ACT);	/* flush */
+	if (qc->flags & ATA_QCFLAG_NCQ) {
+		pp->sactive |= (1 << qc->tag);
+
+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+		readl(port_mmio + PORT_SCR_ACT);	/* flush */
+	}
 
-	writel(1, port_mmio + PORT_CMD_ISSUE);
+	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
@@ -1027,6 +1151,9 @@
 	if (rc)
 		goto err_out_hpriv;
 
+	if (hpriv->cap & HOST_CAP_NCQ)
+		probe_ent->host_flags |= ATA_FLAG_NCQ;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
Index: drivers/scsi/libata-core.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/drivers/scsi/libata-core.c  (mode:100644)
+++ uncommitted/drivers/scsi/libata-core.c  (mode:100644)
@@ -519,7 +519,7 @@
  *	LOCKING:
  *	None.
  */
-static int ata_prot_to_cmd(int protocol, int lba48)
+static int ata_prot_to_cmd(int protocol, int lba48, int ncq)
 {
 	int rcmd = 0, wcmd = 0;
 
@@ -535,7 +535,10 @@
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
@@ -568,6 +571,7 @@
 {
 	int pio = (dev->flags & ATA_DFLAG_PIO);
 	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
+	int ncq = (dev->flags & ATA_DFLAG_NCQ);
 	int proto, cmd;
 
 	if (pio)
@@ -575,7 +579,7 @@
 	else
 		proto = dev->xfer_protocol = ATA_PROT_DMA;
 
-	cmd = ata_prot_to_cmd(proto, lba48);
+	cmd = ata_prot_to_cmd(proto, lba48, ncq);
 	if (cmd < 0)
 		BUG();
 
@@ -1139,6 +1143,10 @@
 			goto err_out_nosup;
 		}
 
+		/* host NCQ is required as well as device support */
+		if ((ap->flags & ATA_FLAG_NCQ) && ata_id_has_ncq(dev->id))
+			dev->flags |= ATA_DFLAG_NCQ;
+
 		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
 			dev->n_sectors = ata_id_u64(dev->id, 100);
@@ -1149,11 +1157,12 @@
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
@@ -1187,6 +1196,66 @@
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
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	printk("RLP issue\n");
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	printk("RLP issue done\n");
+
+	if (rc)
+		return -EIO;
+
+	wait_for_completion(&wait);
+
+	printk("RLP wait done\n");
+	return 0;
+}
+
+/**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
  *
@@ -2699,7 +2768,7 @@
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int i;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++)
+	for (i = 0; i < ATA_MAX_CMDS; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
 			qc = ata_qc_from_tag(ap, i);
 			break;
@@ -2754,6 +2823,16 @@
 	struct ata_port *ap = qc->ap;
 	unsigned int tag, do_clear = 0;
 
+	if (likely(qc->flags & ATA_QCFLAG_ACCOUNT)) {
+		if (qc->flags & ATA_QCFLAG_NCQ) {
+			assert(ap->ncq_depth);
+			ap->ncq_depth--;
+		} else {
+			assert(ap->depth);
+			ap->depth--;
+		}
+	}
+
 	qc->flags = 0;
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
@@ -2771,6 +2850,8 @@
 
 	if (likely(do_clear))
 		clear_bit(tag, &ap->qactive);
+	if (ap->cmd_waiters)
+		wake_up(&ap->cmd_wait_queue);
 }
 
 /**
@@ -2849,6 +2930,52 @@
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
+	/*
+	 * if people are already waiting for a queue drain, don't allow a
+	 * new 'lucky' queuer to get in there
+	 */
+	if (ap->cmd_waiters > waiting)
+		return 0;
+	if (qc->flags & ATA_QCFLAG_NCQ)
+		return !ap->depth;
+
+	return !(ap->ncq_depth + ap->depth);
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
@@ -2868,6 +2995,21 @@
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
+		if (qc->flags & ATA_QCFLAG_DEFER)
+			return ATA_QC_ISSUE_DEFER;
+
+		ata_qc_issue_wait(ap, qc);
+		assert(ata_qc_issue_ok(ap, qc, 0));
+	}
 
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
@@ -2884,12 +3026,24 @@
 	ap->ops->qc_prep(qc);
 
 	qc->ap->active_tag = qc->tag;
-	qc->flags |= ATA_QCFLAG_ACTIVE;
+	qc->flags |= (ATA_QCFLAG_ACTIVE | ATA_QCFLAG_ACCOUNT);
+
+	rc = ap->ops->qc_issue(qc);
+	if (rc != ATA_QC_ISSUE_OK)
+		goto err_out;
 
-	return ap->ops->qc_issue(qc);
+	if (qc->flags & ATA_QCFLAG_NCQ) {
+		assert(ap->ncq_depth < ATA_MAX_QUEUE)
+		ap->ncq_depth++;
+	} else {
+		assert(!ap->depth);
+		ap->depth++;
+	}
 
+	return ATA_QC_ISSUE_OK;
 err_out:
-	return -1;
+	ata_qc_free(qc);
+	return rc;
 }
 
 /**
@@ -2951,7 +3105,8 @@
 
 	default:
 		WARN_ON(1);
-		return -1;
+		ata_qc_free(qc);
+		return ATA_QC_ISSUE_FATAL;
 	}
 
 	return 0;
@@ -3383,6 +3538,8 @@
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
+	init_waitqueue_head(&ap->cmd_wait_queue);
+	ap->cmd_waiters = 0;
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
@@ -4018,6 +4175,8 @@
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
+EXPORT_SYMBOL_GPL(ata_read_log_page);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
Index: drivers/scsi/libata-scsi.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/drivers/scsi/libata-scsi.c  (mode:100644)
+++ uncommitted/drivers/scsi/libata-scsi.c  (mode:100644)
@@ -336,6 +336,7 @@
 	if (sdev->id < ATA_MAX_DEVICES) {
 		struct ata_port *ap;
 		struct ata_device *dev;
+		int depth;
 
 		ap = (struct ata_port *) &sdev->host->hostdata[0];
 		dev = &ap->device[sdev->id];
@@ -353,6 +354,13 @@
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
@@ -537,6 +545,7 @@
 {
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	unsigned int ncq = qc->dev->flags & ATA_DFLAG_NCQ;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = qc->dev->xfer_protocol;
@@ -550,8 +559,18 @@
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
+		} else if (lba48) {
 			tf->hob_nsect = scsicmd[7];
 			tf->hob_lbal = scsicmd[2];
 
@@ -569,7 +588,8 @@
 			qc->nsect = scsicmd[8];
 		}
 
-		tf->nsect = scsicmd[8];
+		if (!ncq)
+			tf->nsect = scsicmd[8];
 		tf->lbal = scsicmd[5];
 		tf->lbam = scsicmd[4];
 		tf->lbah = scsicmd[3];
@@ -579,7 +599,14 @@
 	}
 
 	if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
-		qc->nsect = tf->nsect = scsicmd[4];
+		qc->nsect = scsicmd[4];
+
+		if (ncq) {
+			tf->nsect = qc->tag << 3;
+			tf->feature = scsicmd[4];
+		} else
+			tf->nsect = scsicmd[4];
+
 		tf->lbal = scsicmd[3];
 		tf->lbam = scsicmd[2];
 		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
@@ -593,7 +620,16 @@
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
+			qc->nsect = ((unsigned int)scsicmd[12] << 8) |
+					scsicmd[13];
+		} else if (lba48) {
 			tf->hob_nsect = scsicmd[12];
 			tf->hob_lbal = scsicmd[6];
 			tf->hob_lbam = scsicmd[5];
@@ -613,7 +649,8 @@
 			qc->nsect = scsicmd[13];
 		}
 
-		tf->nsect = scsicmd[13];
+		if (!ncq)
+			tf->nsect = scsicmd[13];
 		tf->lbal = scsicmd[9];
 		tf->lbam = scsicmd[8];
 		tf->lbah = scsicmd[7];
@@ -666,6 +703,7 @@
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
+	int ret;
 
 	VPRINTK("ENTER\n");
 
@@ -696,9 +734,18 @@
 	if (xlat_func(qc, scsicmd))
 		goto err_out;
 
+	qc->flags |= ATA_QCFLAG_DEFER;
+
 	/* select device, send command to hardware */
-	if (ata_qc_issue(qc))
+	ret = ata_qc_issue(qc);
+	if (ret == ATA_QC_ISSUE_FATAL)
 		goto err_out;
+	else if (ret == ATA_QC_ISSUE_DEFER) {
+		VPRINTK("DEFER\n");
+		ata_qc_free(qc);
+		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
+		done(cmd);
+	}
 
 	VPRINTK("EXIT\n");
 	return;
@@ -1594,3 +1641,22 @@
 	}
 }
 
+int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
+{
+	struct ata_port *ap;
+	struct ata_device *dev;
+	int max_depth;
+
+	if (sdev->id >= ATA_MAX_DEVICES)
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
Index: drivers/scsi/scsi_lib.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/drivers/scsi/scsi_lib.c  (mode:100644)
+++ uncommitted/drivers/scsi/scsi_lib.c  (mode:100644)
@@ -1292,13 +1292,17 @@
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
Index: include/linux/ata.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/linux/ata.h  (mode:100644)
+++ uncommitted/include/linux/ata.h  (mode:100644)
@@ -79,7 +79,8 @@
 	ATA_NIEN		= (1 << 1),	/* disable-irq flag */
 	ATA_LBA			= (1 << 6),	/* LBA28 selector */
 	ATA_DEV1		= (1 << 4),	/* Select Device 1 (slave) */
-	ATA_DEVICE_OBS		= (1 << 7) | (1 << 5), /* obs bits in dev reg */
+	ATA_DEVICE_OBS		= (1 << 5), 	/* obs bits in dev reg */
+	ATA_FPDMA_FUA		= (1 << 7),	/* FUA cache bypass bit */
 	ATA_DEVCTL_OBS		= (1 << 3),	/* obsolete bit in devctl reg */
 	ATA_BUSY		= (1 << 7),	/* BSY status bit */
 	ATA_DRDY		= (1 << 6),	/* device ready */
@@ -125,6 +126,12 @@
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
@@ -233,7 +240,9 @@
 #define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_queue_depth(id)	(((id)[75] & 0x1f) + 1)
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
Index: include/linux/libata.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/linux/libata.h  (mode:100644)
+++ uncommitted/include/linux/libata.h  (mode:100644)
@@ -80,7 +80,8 @@
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
 	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
-	ATA_MAX_QUEUE		= 1,
+	ATA_MAX_CMDS		= 31,	/* to avoid SActive 0xffffffff error */
+	ATA_MAX_QUEUE		= 30,	/* leave one command for errors */
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
@@ -95,6 +96,7 @@
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
 	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
+	ATA_DFLAG_NCQ		= (1 << 3), /* Device can do NCQ */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -113,11 +115,19 @@
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
+	ATA_QCFLAG_NCQ		= (1 << 5), /* using NCQ */
+	ATA_QCFLAG_DEFER	= (1 << 6), /* ok to defer */
+	ATA_QCFLAG_ACCOUNT	= (1 << 7),
+
+	ATA_QC_ISSUE_OK		= 0,
+	ATA_QC_ISSUE_DEFER	= 1,
+	ATA_QC_ISSUE_FATAL	= 2,
 
 	/* various lengths of time */
 	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
@@ -305,9 +315,14 @@
 
 	struct ata_device	device[ATA_MAX_DEVICES];
 
-	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
+	struct ata_queued_cmd	qcmd[ATA_MAX_CMDS];
 	unsigned long		qactive;
 	unsigned int		active_tag;
+	int			ncq_depth;
+	int			depth;
+
+	wait_queue_head_t	cmd_wait_queue;
+	unsigned int		cmd_waiters;
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
@@ -433,6 +448,9 @@
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern int ata_scsi_change_queue_depth(struct scsi_device *, int);
+extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
+			     unsigned int);
 
 
 #ifdef CONFIG_PCI
@@ -452,7 +470,7 @@
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
-	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
+	return (tag < ATA_MAX_CMDS) ? 1 : 0;
 }
 
 static inline unsigned int ata_dev_present(struct ata_device *dev)

-- 
Jens Axboe

