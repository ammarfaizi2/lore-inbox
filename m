Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVG2FG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVG2FG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVG2FG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:06:58 -0400
Received: from havoc.gtf.org ([69.61.125.42]:47494 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262350AbVG2FGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:06:55 -0400
Date: Fri, 29 Jul 2005 01:06:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC][PATCH] libata ATAPI alignment
Message-ID: <20050729050654.GA10413@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So, one thing that's terribly ugly about SATA ATAPI is that we need to
pad DMA transfers to the next 32-bit boundary, if the length is not
evenly divisible by 4.

Messing with the scatterlist to accomplish this is terribly ugly
no matter how you slice it.  One way would be to create my own
scatterlist, via memcpy and then manual labor.  Another way would be
to special case a pad buffer, appending it onto the end of various
scatterlist code.

Complicating matters, we currently must support two methods of data
buffer submission:  a single kernel virtual address, or a struct
scatterlist.

Review is requested by any and all parties, as well as suggestions for
a prettier approach.

This is one of the last steps needed to get ATAPI going.



diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -44,7 +44,7 @@
 
 enum {
 	AHCI_PCI_BAR		= 5,
-	AHCI_MAX_SG		= 168, /* hardware max is 64K */
+	AHCI_MAX_SG		= 300, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
 	AHCI_CMD_SLOT_SZ	= 32 * 32,
@@ -197,7 +197,7 @@ static Scsi_Host_Template ahci_sht = {
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= AHCI_MAX_SG,
+	.sg_tablesize		= AHCI_MAX_SG - 1,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
@@ -313,8 +313,15 @@ static int ahci_port_start(struct ata_po
 		return -ENOMEM;
 	memset(pp, 0, sizeof(*pp));
 
+	ap->pad = dma_alloc_coherent(dev, ATA_DMA_PAD_BUF_SZ, &ap->pad_dma, GFP_KERNEL);
+	if (!ap->pad) {
+		kfree(pp);
+		return -ENOMEM;
+	}
+
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
+		dma_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
 		kfree(pp);
 		return -ENOMEM;
 	}
@@ -390,6 +397,7 @@ static void ahci_port_stop(struct ata_po
 	ap->private_data = NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
 			  pp->cmd_slot, pp->cmd_slot_dma);
+	dma_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
 	kfree(pp);
 }
 
@@ -474,7 +482,8 @@ static void ahci_tf_read(struct ata_port
 
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
 	unsigned int i;
 
 	VPRINTK("ENTER\n");
@@ -493,6 +502,24 @@ static void ahci_fill_sg(struct ata_queu
 		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
 		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
 	}
+
+	/* if we added a small buffer, to pad xfer to next 32-bit bound,
+	 * add it to the s/g list here
+	 */
+	if (qc->flags & ATA_QCFLAG_PADDED) {
+		dma_addr_t pad_addr = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
+		u32 len;
+
+		/* fixup last s/g entry */
+		len = le32_to_cpu(pp->cmd_tbl_sg[i - 1].flags_size);
+		pp->cmd_tbl_sg[i - 1].flags_size =
+			cpu_to_le32(len - qc->pad_len);
+
+		/* append pad buffer to s/g list */
+		pp->cmd_tbl_sg[i].addr = cpu_to_le32(pad_addr & 0xffffffff);
+		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((pad_addr >> 16) >> 16);
+		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(ATA_DMA_PAD_SZ - 1);
+	}
 }
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
@@ -501,13 +528,16 @@ static void ahci_qc_prep(struct ata_queu
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
+	unsigned int n_elem = qc->n_elem;
 
 	/*
 	 * Fill in command slot information (currently only one slot,
 	 * slot 0, is currently since we don't do queueing)
 	 */
 
-	opts = (qc->n_elem << 16) | cmd_fis_len;
+	if (qc->flags & ATA_QCFLAG_PADDED)
+		n_elem++;
+	opts = (n_elem << 16) | cmd_fis_len;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi_taskfile(&qc->tf))
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2144,6 +2144,8 @@ static void ata_sg_clean(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->sg;
 	int dir = qc->dma_dir;
+	unsigned int copy_pad = 0;
+	void *pad_buf = NULL;
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 	assert(sg != NULL);
@@ -2153,11 +2155,33 @@ static void ata_sg_clean(struct ata_queu
 
 	DPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
-	if (qc->flags & ATA_QCFLAG_SG)
+	/* if we padded the buffer out to 32-bit bound, and data
+	 * xfer direction is from-device, we must copy from the
+	 * pad buffer back into the supplied buffer
+	 */
+	if ((qc->flags & ATA_QCFLAG_PADDED) &&
+	    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+		copy_pad = 1;
+		pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
+	}
+
+	if (qc->flags & ATA_QCFLAG_SG) {
 		dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
-	else
+		if (copy_pad) {
+			void *addr = kmap_atomic(sg[qc->n_elem - 1].page, KM_IRQ0);
+			memcpy(addr + sg[qc->n_elem - 1].offset +
+			         sg[qc->n_elem - 1].length - qc->pad_len,
+			       pad_buf, qc->pad_len);
+
+			kunmap_atomic(sg[qc->n_elem - 1].page, KM_IRQ0);
+		}
+	} else {
 		dma_unmap_single(ap->host_set->dev, sg_dma_address(&sg[0]),
 				 sg_dma_len(&sg[0]), dir);
+		if (copy_pad)
+			memcpy(qc->buf_virt + sg->length - qc->pad_len,
+			       pad_buf, qc->pad_len);
+	}
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	qc->sg = NULL;
@@ -2211,6 +2235,23 @@ static void ata_fill_sg(struct ata_queue
 		}
 	}
 
+	/* if we added a small buffer, to pad xfer to next 32-bit bound,
+	 * add it to the s/g list here
+	 */
+	if (qc->flags & ATA_QCFLAG_PADDED) {
+		u32 pad_addr = (u32) (ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ));
+		u32 len;
+
+		/* fix up length of last s/g entry */
+		len = le32_to_cpu(ap->prd[idx - 1].flags_len);
+		ap->prd[idx - 1].flags_len = cpu_to_le32(len - qc->pad_len);
+
+		/* append pad entry to s/g list */
+		ap->prd[idx].addr = cpu_to_le32(pad_addr);
+		ap->prd[idx].flags_len = cpu_to_le32(ATA_DMA_PAD_SZ);
+		idx++;
+	}
+
 	if (idx)
 		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
@@ -2351,6 +2392,21 @@ static int ata_sg_setup_one(struct ata_q
 	int dir = qc->dma_dir;
 	struct scatterlist *sg = qc->sg;
 	dma_addr_t dma_address;
+	unsigned int pad_len;
+
+	/* we must lengthen transfers to end on a 32-bit boundary */
+	pad_len = sg->length & 3;
+	if (pad_len) {
+		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
+		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE)
+			memcpy(pad_buf, qc->buf_virt + sg->length - pad_len,
+			       pad_len);
+
+		qc->pad_len = pad_len;
+		qc->flags |= ATA_QCFLAG_PADDED;
+	}
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg->length, dir);
@@ -2385,10 +2441,31 @@ static int ata_sg_setup(struct ata_queue
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->sg;
 	int n_elem, dir;
+	unsigned int pad_len;
 
 	VPRINTK("ENTER, ata%u\n", ap->id);
 	assert(qc->flags & ATA_QCFLAG_SG);
 
+	/* we must lengthen transfers to end on a 32-bit boundary */
+	pad_len = sg[qc->n_elem - 1].length & 3;
+	if (pad_len) {
+		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
+		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+			void *addr = kmap_atomic(sg[qc->n_elem - 1].page, KM_IRQ0);
+			memcpy(pad_buf,
+			       addr + sg[qc->n_elem - 1].offset +
+			         sg[qc->n_elem - 1].length - pad_len,
+			       pad_len);
+
+			kunmap_atomic(sg[qc->n_elem - 1].page, KM_IRQ0);
+		}
+
+		qc->pad_len = pad_len;
+		qc->flags |= ATA_QCFLAG_PADDED;
+	}
+
 	dir = qc->dma_dir;
 	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 	if (n_elem < 1)
@@ -3672,6 +3749,12 @@ int ata_port_start (struct ata_port *ap)
 	if (!ap->prd)
 		return -ENOMEM;
 
+	ap->pad = dma_alloc_coherent(dev, ATA_DMA_PAD_BUF_SZ, &ap->pad_dma, GFP_KERNEL);
+	if (!ap->pad) {
+		dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+		return -ENOMEM;
+	}
+
 	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd, (unsigned long long) ap->prd_dma);
 
 	return 0;
@@ -3694,6 +3777,7 @@ void ata_port_stop (struct ata_port *ap)
 	struct device *dev = ap->host_set->dev;
 
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	dma_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
 }
 
 void ata_host_stop (struct ata_host_set *host_set)
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -130,7 +130,7 @@ static Scsi_Host_Template qs_ata_sht = {
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= QS_MAX_PRD,
+	.sg_tablesize		= QS_MAX_PRD - 1,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
@@ -270,10 +270,14 @@ static void qs_fill_sg(struct ata_queued
 	struct qs_port_priv *pp = ap->private_data;
 	unsigned int nelem;
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
+	unsigned int pad_len = 0;
 
 	assert(sg != NULL);
 	assert(qc->n_elem > 0);
 
+	if (qc->flags & ATA_QCFLAG_PADDED)
+		pad_len = qc->pad_len;
+
 	for (nelem = 0; nelem < qc->n_elem; nelem++,sg++) {
 		u64 addr;
 		u32 len;
@@ -283,12 +287,33 @@ static void qs_fill_sg(struct ata_queued
 		prd += sizeof(u64);
 
 		len = sg_dma_len(sg);
+
+		/* fixup last s/g entry, if using pad buffer */
+		if (nelem == (qc->n_elem - 1))
+			len -= pad_len;
+
 		*(__le32 *)prd = cpu_to_le32(len);
 		prd += sizeof(u64);
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
 					(unsigned long long)addr, len);
 	}
+
+	/* if we added a small buffer, to pad xfer to next 32-bit bound,
+	 * add it to the s/g list here
+	 */
+	if (qc->flags & ATA_QCFLAG_PADDED) {
+		dma_addr_t pad_addr = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
+		u64 addr = pad_addr;
+
+		*(__le64 *)prd = cpu_to_le64(addr);
+		prd += sizeof(u64);
+
+		*(__le32 *)prd = cpu_to_le32(ATA_DMA_PAD_SZ);
+
+		VPRINTK("PRD[%u] = (0x%llX, 0x%X) [pad PRD]\n", nelem,
+					(unsigned long long)addr, ATA_DMA_PAD_SZ);
+	}
 }
 
 static void qs_qc_prep(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -452,6 +452,7 @@ static void pdc20621_dma_prep(struct ata
 	unsigned int portno = ap->port_no;
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
+	unsigned int pad_len = 0;
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 
@@ -460,16 +461,37 @@ static void pdc20621_dma_prep(struct ata
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
+	if (qc->flags & ATA_QCFLAG_PADDED)
+		pad_len = qc->pad_len;
+
 	/*
 	 * Build S/G table
 	 */
 	last = qc->n_elem;
 	idx = 0;
 	for (i = 0; i < last; i++) {
+		u32 len;
+
 		buf[idx++] = cpu_to_le32(sg_dma_address(&sg[i]));
-		buf[idx++] = cpu_to_le32(sg_dma_len(&sg[i]));
-		total_len += sg[i].length;
+
+		len = sg_dma_len(&sg[i]);
+		if (i == (last - 1))
+			len -= pad_len;
+
+		buf[idx++] = cpu_to_le32(len);
+		total_len += len;
 	}
+
+	/* if we added a small buffer, to pad xfer to next 32-bit bound,
+	 * add it to the s/g list here
+	 */
+	if (qc->flags & ATA_QCFLAG_PADDED) {
+		u32 pad_addr = (u32) (ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ));
+		buf[idx++] = cpu_to_le32(pad_addr);
+		buf[idx++] = cpu_to_le32(ATA_DMA_PAD_SZ);
+		total_len += ATA_DMA_PAD_SZ;
+	}
+
 	buf[idx - 1] |= cpu_to_le32(ATA_PRD_EOT);
 	sgt_len = idx * 4;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -115,6 +115,7 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
+	ATA_QCFLAG_PADDED	= (1 << 2), /* xfer padded to 32-bit bound */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
@@ -150,6 +151,10 @@ enum {
 	ATA_SHIFT_UDMA		= 0,
 	ATA_SHIFT_MWDMA		= 8,
 	ATA_SHIFT_PIO		= 11,
+
+	/* size of buffer to pad xfers ending on unaligned boundaries */
+	ATA_DMA_PAD_SZ		= 4,
+	ATA_DMA_PAD_BUF_SZ	= ATA_DMA_PAD_SZ * ATA_MAX_QUEUE,
 };
 
 enum pio_task_states {
@@ -236,6 +241,8 @@ struct ata_queued_cmd {
 
 	int			dma_dir;
 
+	unsigned int		pad_len;
+
 	unsigned int		nsect;
 	unsigned int		cursect;
 
@@ -291,6 +298,9 @@ struct ata_port {
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
 
+	void			*pad;	/* array of DMA pad buffers */
+	dma_addr_t		pad_dma;
+
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 
 	u8			ctl;	/* cache of ATA control register */
