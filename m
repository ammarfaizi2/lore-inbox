Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVHGF6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVHGF6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 01:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVHGF6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 01:58:45 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:35037 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751110AbVHGF6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 01:58:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ReYlmywbNu7KXnWFiECfK/jVhmwWAGwMIKX5OzoEf9J+vyUj7/eaJj6ckCAYeBxqyqKyn3ZzT1xoXb3KI6uttUUzm2NDKbCCv/R+XlyzG5qy0noxaAjeHIO9zaiLvpFxCO6JYuq7KDt3g2iSZsXcPwjKdtVIkakEmCiyHdUsqdo=
Date: Sun, 7 Aug 2005 14:58:36 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Rd: [PATCH 2/2] sata: implement ATAPI alignment adjustment
Message-ID: <20050807055836.GC13335@htj.dyndns.org>
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807054850.GA13335@htj.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 SATA ATAPI is nasty in that it requires that all transfers should be
sized in multiples of 4 bytes.  This patch implements ATAPI 4-byte
alignment by mangling sg table and using an extra pad_sgent.  Setups
and cleanups are all done inside libata core layer and the only
requirement on specific drivers is using ata_for_each_sg() to iterate
over sg table.  This patch also renames qc->sg to qc->__sg to signify
that it cannot be iterated directly.

 This patch is a rewrite of Jeff's implementation.


Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-08-07 14:07:17.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-08-07 14:09:21.000000000 +0900
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
 
@@ -475,23 +483,23 @@ static void ahci_tf_read(struct ata_port
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
-	unsigned int i;
+	struct scatterlist *sg;
+	struct ahci_sg *ahci_sg;
 
 	VPRINTK("ENTER\n");
 
 	/*
 	 * Next, the S/G list.
 	 */
-	for (i = 0; i < qc->n_elem; i++) {
-		u32 sg_len;
-		dma_addr_t addr;
-
-		addr = sg_dma_address(&qc->sg[i]);
-		sg_len = sg_dma_len(&qc->sg[i]);
-
-		pp->cmd_tbl_sg[i].addr = cpu_to_le32(addr & 0xffffffff);
-		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
+	ahci_sg = pp->cmd_tbl_sg;
+	ata_for_each_sg(sg, qc) {
+		dma_addr_t addr = sg_dma_address(sg);
+		u32 sg_len = sg_dma_len(sg);
+
+		ahci_sg->addr = cpu_to_le32(addr & 0xffffffff);
+		ahci_sg->addr_hi = cpu_to_le32((addr >> 16) >> 16);
+		ahci_sg->flags_size = cpu_to_le32(sg_len - 1);
+		ahci_sg++;
 	}
 }
 
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-08-07 14:07:17.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-08-07 14:09:21.000000000 +0900
@@ -2142,8 +2142,9 @@ static void ata_dev_set_xfermode(struct 
 static void ata_sg_clean(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	int dir = qc->dma_dir;
+	void *pad_buf = NULL;
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 	assert(sg != NULL);
@@ -2153,14 +2154,35 @@ static void ata_sg_clean(struct ata_queu
 
 	DPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
-	if (qc->flags & ATA_QCFLAG_SG)
+	/* if we padded the buffer out to 32-bit bound, and data
+	 * xfer direction is from-device, we must copy from the
+	 * pad buffer back into the supplied buffer
+	 */
+	if (qc->pad_len && !(qc->tf.flags & ATA_TFLAG_WRITE))
+		pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
+
+	if (qc->flags & ATA_QCFLAG_SG) {
 		dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
-	else
+		/* restore last sg */
+		sg[qc->orig_n_elem - 1].length += qc->pad_len;
+		if (pad_buf) {
+			struct scatterlist *psg = &qc->pad_sgent;
+			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
+			kunmap_atomic(psg->page, KM_IRQ0);
+		}
+	} else {
 		dma_unmap_single(ap->host_set->dev, sg_dma_address(&sg[0]),
 				 sg_dma_len(&sg[0]), dir);
+		/* restore sg */
+		sg->length += qc->pad_len;
+		if (pad_buf)
+			memcpy(qc->buf_virt + sg->length - qc->pad_len,
+			       pad_buf, qc->pad_len);
+	}
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	qc->sg = NULL;
+	qc->__sg = NULL;
 }
 
 /**
@@ -2176,15 +2198,15 @@ static void ata_sg_clean(struct ata_queu
  */
 static void ata_fill_sg(struct ata_queued_cmd *qc)
 {
-	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
-	unsigned int idx, nelem;
+	struct scatterlist *sg;
+	unsigned int idx;
 
-	assert(sg != NULL);
+	assert(qc->__sg != NULL);
 	assert(qc->n_elem > 0);
 
 	idx = 0;
-	for (nelem = qc->n_elem; nelem; nelem--,sg++) {
+	ata_for_each_sg(sg, qc) {
 		u32 addr, offset;
 		u32 sg_len, len;
 
@@ -2288,11 +2310,12 @@ void ata_sg_init_one(struct ata_queued_c
 	qc->flags |= ATA_QCFLAG_SINGLE;
 
 	memset(&qc->sgent, 0, sizeof(qc->sgent));
-	qc->sg = &qc->sgent;
+	qc->__sg = &qc->sgent;
 	qc->n_elem = 1;
+	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
 
-	sg = qc->sg;
+	sg = qc->__sg;
 	sg->page = virt_to_page(buf);
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
 	sg->length = buflen;
@@ -2328,8 +2351,9 @@ void ata_sg_init(struct ata_queued_cmd *
 		 unsigned int n_elem)
 {
 	qc->flags |= ATA_QCFLAG_SG;
-	qc->sg = sg;
+	qc->__sg = sg;
 	qc->n_elem = n_elem;
+	qc->orig_n_elem = n_elem;
 }
 
 /**
@@ -2349,9 +2373,32 @@ static int ata_sg_setup_one(struct ata_q
 {
 	struct ata_port *ap = qc->ap;
 	int dir = qc->dma_dir;
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	dma_addr_t dma_address;
 
+	/* we must lengthen transfers to end on a 32-bit boundary */
+	qc->pad_len = sg->length & 3;
+	if (qc->pad_len) {
+		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
+		struct scatterlist *psg = &qc->pad_sgent;
+
+		assert(qc->dev->class == ATA_DEV_ATAPI);
+
+		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE)
+			memcpy(pad_buf, qc->buf_virt + sg->length - qc->pad_len,
+			       qc->pad_len);
+
+		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
+		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
+		/* trim sg */
+		sg->length -= qc->pad_len;
+
+		DPRINTK("padding done, sg->length=%u pad_len=%u\n",
+			sg->length, qc->pad_len);
+	}
+
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg->length, dir);
 	if (dma_mapping_error(dma_address))
@@ -2383,12 +2430,47 @@ static int ata_sg_setup_one(struct ata_q
 static int ata_sg_setup(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
+	struct scatterlist *lsg = &sg[qc->n_elem - 1];
 	int n_elem, dir;
 
 	VPRINTK("ENTER, ata%u\n", ap->id);
 	assert(qc->flags & ATA_QCFLAG_SG);
 
+	/* we must lengthen transfers to end on a 32-bit boundary */
+	qc->pad_len = lsg->length & 3;
+	if (qc->pad_len) {
+		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
+		struct scatterlist *psg = &qc->pad_sgent;
+		unsigned int offset;
+
+		assert(qc->dev->class == ATA_DEV_ATAPI);
+
+		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
+
+		/*
+		 * psg->page/offset are used to copy to-be-written
+		 * data in this function or read data in ata_sg_clean.
+		 */
+		offset = lsg->offset + lsg->length - qc->pad_len;
+		psg->page = nth_page(lsg->page, offset >> PAGE_SHIFT);
+		psg->offset = offset_in_page(offset);
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			memcpy(pad_buf, addr + psg->offset, qc->pad_len);
+			kunmap_atomic(psg->page, KM_IRQ0);
+		}
+
+		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
+		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
+		/* trim last sg */
+		lsg->length -= qc->pad_len;
+
+		DPRINTK("padding done, sg[%d].length=%u pad_len=%u\n",
+			qc->n_elem - 1, lsg->length, qc->pad_len);
+	}
+
 	dir = qc->dma_dir;
 	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 	if (n_elem < 1)
@@ -2559,7 +2641,7 @@ static void ata_data_xfer(struct ata_por
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned int offset;
@@ -2597,7 +2679,7 @@ static void ata_pio_sector(struct ata_qu
 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned char *buf;
@@ -2607,7 +2689,7 @@ static void __atapi_pio_bytes(struct ata
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
-	sg = &qc->sg[qc->cursg];
+	sg = &qc->__sg[qc->cursg];
 
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
@@ -2997,7 +3079,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 
 	qc = ata_qc_new(ap);
 	if (qc) {
-		qc->sg = NULL;
+		qc->__sg = NULL;
 		qc->flags = 0;
 		qc->scsicmd = NULL;
 		qc->ap = ap;
@@ -3672,6 +3754,12 @@ int ata_port_start (struct ata_port *ap)
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
@@ -3694,6 +3782,7 @@ void ata_port_stop (struct ata_port *ap)
 	struct device *dev = ap->host_set->dev;
 
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	dma_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
 }
 
 void ata_host_stop (struct ata_host_set *host_set)
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-08-07 14:07:17.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-08-07 14:09:21.000000000 +0900
@@ -139,10 +139,10 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 		qc->scsidone = done;
 
 		if (cmd->use_sg) {
-			qc->sg = (struct scatterlist *) cmd->request_buffer;
+			qc->__sg = (struct scatterlist *) cmd->request_buffer;
 			qc->n_elem = cmd->use_sg;
 		} else {
-			qc->sg = &qc->sgent;
+			qc->__sg = &qc->sgent;
 			qc->n_elem = 1;
 		}
 	} else {
@@ -353,6 +353,16 @@ int ata_scsi_slave_config(struct scsi_de
 			 */
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
+
+		/*
+		 * SATA DMA transfers must be multiples of 4 byte, so
+		 * we need to pad ATAPI transfers using an extra sg.
+		 * Decrement max hw segments accordingly.
+		 */
+		if (dev->class == ATA_DEV_ATAPI) {
+			request_queue_t *q = sdev->request_queue;
+			blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
+		}
 	}
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
Index: work/drivers/scsi/sata_qstor.c
===================================================================
--- work.orig/drivers/scsi/sata_qstor.c	2005-08-07 14:07:17.000000000 +0900
+++ work/drivers/scsi/sata_qstor.c	2005-08-07 14:09:21.000000000 +0900
@@ -265,16 +265,17 @@ static void qs_scr_write (struct ata_por
 
 static void qs_fill_sg(struct ata_queued_cmd *qc)
 {
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
 	struct qs_port_priv *pp = ap->private_data;
 	unsigned int nelem;
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
 
-	assert(sg != NULL);
+	assert(qc->__sg != NULL);
 	assert(qc->n_elem > 0);
 
-	for (nelem = 0; nelem < qc->n_elem; nelem++,sg++) {
+	nelem = 0;
+	ata_for_each_sg(sg, qc) {
 		u64 addr;
 		u32 len;
 
@@ -288,6 +289,7 @@ static void qs_fill_sg(struct ata_queued
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
 					(unsigned long long)addr, len);
+		nelem++;
 	}
 }
 
Index: work/drivers/scsi/sata_sx4.c
===================================================================
--- work.orig/drivers/scsi/sata_sx4.c	2005-08-07 14:08:25.000000000 +0900
+++ work/drivers/scsi/sata_sx4.c	2005-08-07 14:10:01.000000000 +0900
@@ -443,14 +443,14 @@ static inline void pdc20621_host_pkt(str
 
 static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 {
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
 	void *mmio = ap->host_set->mmio_base;
 	struct pdc_host_priv *hpriv = ap->host_set->private_data;
 	void *dimm_mmio = hpriv->dimm_mmio;
 	unsigned int portno = ap->port_no;
-	unsigned int i, last, idx, total_len = 0, sgt_len;
+	unsigned int i, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
@@ -463,12 +463,11 @@ static void pdc20621_dma_prep(struct ata
 	/*
 	 * Build S/G table
 	 */
-	last = qc->n_elem;
 	idx = 0;
-	for (i = 0; i < last; i++) {
-		buf[idx++] = cpu_to_le32(sg_dma_address(&sg[i]));
-		buf[idx++] = cpu_to_le32(sg_dma_len(&sg[i]));
-		total_len += sg_dma_len(&sg[i]);
+	ata_for_each_sg(sg, qc) {
+		buf[idx++] = cpu_to_le32(sg_dma_address(sg));
+		buf[idx++] = cpu_to_le32(sg_dma_len(sg));
+		total_len += sg_dma_len(sg);
 	}
 	buf[idx - 1] |= cpu_to_le32(ATA_PRD_EOT);
 	sgt_len = idx * 4;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-08-07 14:07:17.000000000 +0900
+++ work/include/linux/libata.h	2005-08-07 14:09:21.000000000 +0900
@@ -150,6 +150,10 @@ enum {
 	ATA_SHIFT_UDMA		= 0,
 	ATA_SHIFT_MWDMA		= 8,
 	ATA_SHIFT_PIO		= 11,
+
+	/* size of buffer to pad xfers ending on unaligned boundaries */
+	ATA_DMA_PAD_SZ		= 4,
+	ATA_DMA_PAD_BUF_SZ	= ATA_DMA_PAD_SZ * ATA_MAX_QUEUE,
 };
 
 enum pio_task_states {
@@ -233,9 +237,12 @@ struct ata_queued_cmd {
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
+	unsigned int		orig_n_elem;
 
 	int			dma_dir;
 
+	unsigned int		pad_len;
+
 	unsigned int		nsect;
 	unsigned int		cursect;
 
@@ -246,9 +253,11 @@ struct ata_queued_cmd {
 	unsigned int		cursg_ofs;
 
 	struct scatterlist	sgent;
+	struct scatterlist	pad_sgent;
 	void			*buf_virt;
 
-	struct scatterlist	*sg;
+	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
+	struct scatterlist	*__sg;
 
 	ata_qc_cb_t		complete_fn;
 
@@ -291,6 +300,9 @@ struct ata_port {
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
 
+	void			*pad;	/* array of DMA pad buffers */
+	dma_addr_t		pad_dma;
+
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 
 	u8			ctl;	/* cache of ATA control register */
@@ -452,6 +464,19 @@ extern int pci_test_config_bits(struct p
 #endif /* CONFIG_PCI */
 
 
+static inline struct scatterlist *
+ata_qc_next_sg(struct scatterlist *sg, struct ata_queued_cmd *qc)
+{
+	if (sg == &qc->pad_sgent)
+		return NULL;
+	if (++sg - qc->__sg < qc->n_elem)
+		return sg;
+	return qc->pad_len ? &qc->pad_sgent : NULL;
+}
+
+#define ata_for_each_sg(sg, qc) \
+	for (sg = qc->__sg; sg; sg = ata_qc_next_sg(sg, qc))
+
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
