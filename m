Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVKEEok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVKEEok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKEEok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:44:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:56227 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751183AbVKEEoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:44:39 -0500
Date: Fri, 4 Nov 2005 23:44:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] fix libata ATAPI DMA alignment
Message-ID: <20051105044431.GA4119@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain a fix for SATA ATAPI DMA alignment (xfers must fall on
4-byte boundary).

 drivers/scsi/ahci.c        |   31 ++++++----
 drivers/scsi/libata-core.c |  129 +++++++++++++++++++++++++++++++++++++++------
 drivers/scsi/libata-scsi.c |   14 ++++
 drivers/scsi/pdc_adma.c    |    8 +-
 drivers/scsi/sata_mv.c     |   48 +++++++++++-----
 drivers/scsi/sata_qstor.c  |    8 +-
 drivers/scsi/sata_sil24.c  |   48 +++++++++++-----
 drivers/scsi/sata_sx4.c    |   13 ++--
 include/linux/libata.h     |   52 +++++++++++++++++-
 9 files changed, 276 insertions(+), 75 deletions(-)

Jeff Garzik:
      libata: fix ATAPI DMA alignment issues
      libata: add ata_sg_is_last() helper, use it in several drivers
      [libata] ATAPI pad allocation fixes/cleanup

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e2a5657..4612312 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -307,14 +307,22 @@ static int ahci_port_start(struct ata_po
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	void *mem;
 	dma_addr_t mem_dma;
+	int rc;
 
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
 	memset(pp, 0, sizeof(*pp));
 
+	rc = ata_pad_alloc(ap, dev);
+	if (rc) {
+		kfree(pp);
+		return rc;
+	}
+
 	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
 	if (!mem) {
+		ata_pad_free(ap, dev);
 		kfree(pp);
 		return -ENOMEM;
 	}
@@ -390,6 +398,7 @@ static void ahci_port_stop(struct ata_po
 	ap->private_data = NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
 			  pp->cmd_slot, pp->cmd_slot_dma);
+	ata_pad_free(ap, dev);
 	kfree(pp);
 }
 
@@ -468,23 +477,23 @@ static void ahci_tf_read(struct ata_port
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
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ff18fa7..e1346cd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2390,8 +2390,9 @@ static void ata_dev_init_params(struct a
 static void ata_sg_clean(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	int dir = qc->dma_dir;
+	void *pad_buf = NULL;
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 	assert(sg != NULL);
@@ -2401,14 +2402,35 @@ static void ata_sg_clean(struct ata_queu
 
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
@@ -2424,15 +2446,15 @@ static void ata_sg_clean(struct ata_queu
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
 
@@ -2518,12 +2540,18 @@ void ata_qc_prep(struct ata_queued_cmd *
 
 void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 {
+	struct scatterlist *sg;
+
 	qc->flags |= ATA_QCFLAG_SINGLE;
 
-	qc->sg = &qc->sgent;
+	memset(&qc->sgent, 0, sizeof(qc->sgent));
+	qc->__sg = &qc->sgent;
 	qc->n_elem = 1;
+	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
-	sg_init_one(qc->sg, buf, buflen);
+
+	sg = qc->__sg;
+	sg_init_one(sg, buf, buflen);
 }
 
 /**
@@ -2544,8 +2572,9 @@ void ata_sg_init(struct ata_queued_cmd *
 		 unsigned int n_elem)
 {
 	qc->flags |= ATA_QCFLAG_SG;
-	qc->sg = sg;
+	qc->__sg = sg;
 	qc->n_elem = n_elem;
+	qc->orig_n_elem = n_elem;
 }
 
 /**
@@ -2565,9 +2594,32 @@ static int ata_sg_setup_one(struct ata_q
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
@@ -2599,12 +2651,47 @@ static int ata_sg_setup_one(struct ata_q
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
@@ -2880,7 +2967,7 @@ static void ata_data_xfer(struct ata_por
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned int offset;
@@ -2930,7 +3017,7 @@ static void ata_pio_sector(struct ata_qu
 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg = qc->__sg;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned char *buf;
@@ -2963,7 +3050,7 @@ next_sg:
 		return;
 	}
 
-	sg = &qc->sg[qc->cursg];
+	sg = &qc->__sg[qc->cursg];
 
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
@@ -3320,7 +3407,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 
 	qc = ata_qc_new(ap);
 	if (qc) {
-		qc->sg = NULL;
+		qc->__sg = NULL;
 		qc->flags = 0;
 		qc->scsicmd = NULL;
 		qc->ap = ap;
@@ -4004,11 +4091,18 @@ err_out:
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
+	int rc;
 
 	ap->prd = dma_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma, GFP_KERNEL);
 	if (!ap->prd)
 		return -ENOMEM;
 
+	rc = ata_pad_alloc(ap, dev);
+	if (rc) {
+		dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+		return rc;
+	}
+
 	DPRINTK("prd alloc, virt %p, dma %llx\n", ap->prd, (unsigned long long) ap->prd_dma);
 
 	return 0;
@@ -4032,6 +4126,7 @@ void ata_port_stop (struct ata_port *ap)
 	struct device *dev = ap->host_set->dev;
 
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	ata_pad_free(ap, dev);
 }
 
 void ata_host_stop (struct ata_host_set *host_set)
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 248baae..eb604b0 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -355,10 +355,10 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
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
@@ -702,6 +702,16 @@ int ata_scsi_slave_config(struct scsi_de
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
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 665017e..a50588c 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -293,14 +293,14 @@ static void adma_eng_timeout(struct ata_
 
 static int adma_fill_sg(struct ata_queued_cmd *qc)
 {
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
 	struct adma_port_priv *pp = ap->private_data;
 	u8  *buf = pp->pkt;
-	int nelem, i = (2 + buf[3]) * 8;
+	int i = (2 + buf[3]) * 8;
 	u8 pFLAGS = pORD | ((qc->tf.flags & ATA_TFLAG_WRITE) ? pDIRO : 0);
 
-	for (nelem = 0; nelem < qc->n_elem; nelem++,sg++) {
+	ata_for_each_sg(sg, qc) {
 		u32 addr;
 		u32 len;
 
@@ -312,7 +312,7 @@ static int adma_fill_sg(struct ata_queue
 		*(__le32 *)(buf + i) = cpu_to_le32(len);
 		i += 4;
 
-		if ((nelem + 1) == qc->n_elem)
+		if (ata_sg_is_last(sg, qc))
 			pFLAGS |= pEND;
 		buf[i++] = pFLAGS;
 		buf[i++] = qc->dev->dma_mode & 0xf;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 46dbdee..0f469e3 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -670,6 +670,11 @@ static void mv_host_stop(struct ata_host
 	ata_host_stop(host_set);
 }
 
+static inline void mv_priv_free(struct mv_port_priv *pp, struct device *dev)
+{
+	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
+}
+
 /**
  *      mv_port_start - Port specific init/start routine.
  *      @ap: ATA channel to manipulate
@@ -687,21 +692,23 @@ static int mv_port_start(struct ata_port
 	void __iomem *port_mmio = mv_ap_base(ap);
 	void *mem;
 	dma_addr_t mem_dma;
+	int rc = -ENOMEM;
 
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		return -ENOMEM;
-	}
+	if (!pp)
+		goto err_out;
 	memset(pp, 0, sizeof(*pp));
 
 	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma, 
 				 GFP_KERNEL);
-	if (!mem) {
-		kfree(pp);
-		return -ENOMEM;
-	}
+	if (!mem)
+		goto err_out_pp;
 	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
 
+	rc = ata_pad_alloc(ap, dev);
+	if (rc)
+		goto err_out_priv;
+
 	/* First item in chunk of DMA memory: 
 	 * 32-slot command request table (CRQB), 32 bytes each in size
 	 */
@@ -746,6 +753,13 @@ static int mv_port_start(struct ata_port
 	 */
 	ap->private_data = pp;
 	return 0;
+
+err_out_priv:
+	mv_priv_free(pp, dev);
+err_out_pp:
+	kfree(pp);
+err_out:
+	return rc;
 }
 
 /**
@@ -768,7 +782,8 @@ static void mv_port_stop(struct ata_port
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	ap->private_data = NULL;
-	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
+	ata_pad_free(ap, dev);
+	mv_priv_free(pp, dev);
 	kfree(pp);
 }
 
@@ -784,23 +799,24 @@ static void mv_port_stop(struct ata_port
 static void mv_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct mv_port_priv *pp = qc->ap->private_data;
-	unsigned int i;
+	unsigned int i = 0;
+	struct scatterlist *sg;
 
-	for (i = 0; i < qc->n_elem; i++) {
+	ata_for_each_sg(sg, qc) {
 		u32 sg_len;
 		dma_addr_t addr;
 
-		addr = sg_dma_address(&qc->sg[i]);
-		sg_len = sg_dma_len(&qc->sg[i]);
+		addr = sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
 
 		pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
 		pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
 		assert(0 == (sg_len & ~MV_DMA_BOUNDARY));
 		pp->sg_tbl[i].flags_size = cpu_to_le32(sg_len);
-	}
-	if (0 < qc->n_elem) {
-		pp->sg_tbl[qc->n_elem - 1].flags_size |= 
-			cpu_to_le32(EPRD_FLAG_END_OF_TBL);
+		if (ata_sg_is_last(sg, qc))
+			pp->sg_tbl[i].flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
+
+		i++;
 	}
 }
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 9938dae..65502c1 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -271,16 +271,17 @@ static void qs_scr_write (struct ata_por
 
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
 
@@ -294,6 +295,7 @@ static void qs_fill_sg(struct ata_queued
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
 					(unsigned long long)addr, len);
+		nelem++;
 	}
 }
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index c665480..e6c8e89 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -411,15 +411,20 @@ static void sil24_phy_reset(struct ata_p
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 				 struct sil24_cmd_block *cb)
 {
-	struct scatterlist *sg = qc->sg;
 	struct sil24_sge *sge = cb->sge;
-	unsigned i;
+	struct scatterlist *sg;
+	unsigned int idx = 0;
 
-	for (i = 0; i < qc->n_elem; i++, sg++, sge++) {
+	ata_for_each_sg(sg, qc) {
 		sge->addr = cpu_to_le64(sg_dma_address(sg));
 		sge->cnt = cpu_to_le32(sg_dma_len(sg));
-		sge->flags = 0;
-		sge->flags = i < qc->n_elem - 1 ? 0 : cpu_to_le32(SGE_TRM);
+		if (ata_sg_is_last(sg, qc))
+			sge->flags = cpu_to_le32(SGE_TRM);
+		else
+			sge->flags = 0;
+
+		sge++;
+		idx++;
 	}
 }
 
@@ -630,6 +635,13 @@ static irqreturn_t sil24_interrupt(int i
 	return IRQ_RETVAL(handled);
 }
 
+static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
+{
+	const size_t cb_size = sizeof(*pp->cmd_block);
+
+	dma_free_coherent(dev, cb_size, pp->cmd_block, pp->cmd_block_dma);
+}
+
 static int sil24_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -637,36 +649,44 @@ static int sil24_port_start(struct ata_p
 	struct sil24_cmd_block *cb;
 	size_t cb_size = sizeof(*cb);
 	dma_addr_t cb_dma;
+	int rc = -ENOMEM;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp)
-		return -ENOMEM;
-	memset(pp, 0, sizeof(*pp));
+		goto err_out;
 
 	pp->tf.command = ATA_DRDY;
 
 	cb = dma_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
-	if (!cb) {
-		kfree(pp);
-		return -ENOMEM;
-	}
+	if (!cb)
+		goto err_out_pp;
 	memset(cb, 0, cb_size);
 
+	rc = ata_pad_alloc(ap, dev);
+	if (rc)
+		goto err_out_pad;
+
 	pp->cmd_block = cb;
 	pp->cmd_block_dma = cb_dma;
 
 	ap->private_data = pp;
 
 	return 0;
+
+err_out_pad:
+	sil24_cblk_free(pp, dev);
+err_out_pp:
+	kfree(pp);
+err_out:
+	return rc;
 }
 
 static void sil24_port_stop(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
 	struct sil24_port_priv *pp = ap->private_data;
-	size_t cb_size = sizeof(*pp->cmd_block);
 
-	dma_free_coherent(dev, cb_size, pp->cmd_block, pp->cmd_block_dma);
+	sil24_cblk_free(pp, dev);
 	kfree(pp);
 }
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 0ec21e0..f859bbd 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -450,14 +450,14 @@ static inline void pdc20621_host_pkt(str
 
 static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 {
-	struct scatterlist *sg = qc->sg;
+	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
 	struct pdc_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
 	struct pdc_host_priv *hpriv = ap->host_set->private_data;
 	void __iomem *dimm_mmio = hpriv->dimm_mmio;
 	unsigned int portno = ap->port_no;
-	unsigned int i, last, idx, total_len = 0, sgt_len;
+	unsigned int i, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
@@ -470,12 +470,11 @@ static void pdc20621_dma_prep(struct ata
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0ba3af7..dcd17e7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -155,6 +155,10 @@ enum {
 	ATA_SHIFT_UDMA		= 0,
 	ATA_SHIFT_MWDMA		= 8,
 	ATA_SHIFT_PIO		= 11,
+
+	/* size of buffer to pad xfers ending on unaligned boundaries */
+	ATA_DMA_PAD_SZ		= 4,
+	ATA_DMA_PAD_BUF_SZ	= ATA_DMA_PAD_SZ * ATA_MAX_QUEUE,
 	
 	/* Masks for port functions */
 	ATA_PORT_PRIMARY	= (1 << 0),
@@ -249,9 +253,12 @@ struct ata_queued_cmd {
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
+	unsigned int		orig_n_elem;
 
 	int			dma_dir;
 
+	unsigned int		pad_len;
+
 	unsigned int		nsect;
 	unsigned int		cursect;
 
@@ -262,9 +269,11 @@ struct ata_queued_cmd {
 	unsigned int		cursg_ofs;
 
 	struct scatterlist	sgent;
+	struct scatterlist	pad_sgent;
 	void			*buf_virt;
 
-	struct scatterlist	*sg;
+	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
+	struct scatterlist	*__sg;
 
 	ata_qc_cb_t		complete_fn;
 
@@ -310,6 +319,9 @@ struct ata_port {
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
 
+	void			*pad;	/* array of DMA pad buffers */
+	dma_addr_t		pad_dma;
+
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 
 	u8			ctl;	/* cache of ATA control register */
@@ -512,6 +524,31 @@ extern int pci_test_config_bits(struct p
 #endif /* CONFIG_PCI */
 
 
+static inline int
+ata_sg_is_last(struct scatterlist *sg, struct ata_queued_cmd *qc)
+{
+	if (sg == &qc->pad_sgent)
+		return 1;
+	if (qc->pad_len)
+		return 0;
+	if (((sg - qc->__sg) + 1) == qc->n_elem)
+		return 1;
+	return 0;
+}
+
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
@@ -740,4 +777,17 @@ static inline unsigned int __ac_err_mask
 	return mask;
 }
 
+static inline int ata_pad_alloc(struct ata_port *ap, struct device *dev)
+{
+	ap->pad_dma = 0;
+	ap->pad = dma_alloc_coherent(dev, ATA_DMA_PAD_BUF_SZ,
+				     &ap->pad_dma, GFP_KERNEL);
+	return (ap->pad == NULL) ? -ENOMEM : 0;
+}
+
+static inline void ata_pad_free(struct ata_port *ap, struct device *dev)
+{
+	dma_free_coherent(dev, ATA_DMA_PAD_BUF_SZ, ap->pad, ap->pad_dma);
+}
+
 #endif /* __LINUX_LIBATA_H__ */
