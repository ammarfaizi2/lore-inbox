Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161378AbWBUFRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161378AbWBUFRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161377AbWBUFRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:17:19 -0500
Received: from havoc.gtf.org ([69.61.125.42]:4309 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161374AbWBUFRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:17:18 -0500
Date: Tue, 21 Feb 2006 00:17:14 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060221051714.GA25302@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |   15 +++++++++------
 drivers/scsi/sata_qstor.c  |    2 +-
 include/linux/libata.h     |   16 ++++++++++++++--
 3 files changed, 24 insertions(+), 9 deletions(-)

Tejun Heo:
      libata: fix WARN_ON() condition in *_fill_sg()
      libata: fix qc->n_elem == 0 case handling in ata_qc_next_sg
      libata: make ata_sg_setup_one() trim zero length sg

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7ddd5a6..5f1d758 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2514,7 +2514,7 @@ static void ata_sg_clean(struct ata_queu
 	assert(sg != NULL);
 
 	if (qc->flags & ATA_QCFLAG_SINGLE)
-		assert(qc->n_elem == 1);
+		assert(qc->n_elem <= 1);
 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
@@ -2537,7 +2537,7 @@ static void ata_sg_clean(struct ata_queu
 			kunmap_atomic(addr, KM_IRQ0);
 		}
 	} else {
-		if (sg_dma_len(&sg[0]) > 0)
+		if (qc->n_elem)
 			dma_unmap_single(ap->host_set->dev,
 				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
 				dir);
@@ -2570,7 +2570,7 @@ static void ata_fill_sg(struct ata_queue
 	unsigned int idx;
 
 	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	assert(qc->n_elem > 0 || qc->pad_len > 0);
 
 	idx = 0;
 	ata_for_each_sg(sg, qc) {
@@ -2715,6 +2715,7 @@ static int ata_sg_setup_one(struct ata_q
 	int dir = qc->dma_dir;
 	struct scatterlist *sg = qc->__sg;
 	dma_addr_t dma_address;
+	int trim_sg = 0;
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = sg->length & 3;
@@ -2734,13 +2735,15 @@ static int ata_sg_setup_one(struct ata_q
 		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
 		/* trim sg */
 		sg->length -= qc->pad_len;
+		if (sg->length == 0)
+			trim_sg = 1;
 
 		DPRINTK("padding done, sg->length=%u pad_len=%u\n",
 			sg->length, qc->pad_len);
 	}
 
-	if (!sg->length) {
-		sg_dma_address(sg) = 0;
+	if (trim_sg) {
+		qc->n_elem--;
 		goto skip_map;
 	}
 
@@ -2753,9 +2756,9 @@ static int ata_sg_setup_one(struct ata_q
 	}
 
 	sg_dma_address(sg) = dma_address;
-skip_map:
 	sg_dma_len(sg) = sg->length;
 
+skip_map:
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index de05e28..80480f0 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -277,7 +277,7 @@ static unsigned int qs_fill_sg(struct at
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
 
 	assert(qc->__sg != NULL);
-	assert(qc->n_elem > 0);
+	assert(qc->n_elem > 0 || qc->pad_len > 0);
 
 	nelem = 0;
 	ata_for_each_sg(sg, qc) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9e5db29..c91be5e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -557,17 +557,29 @@ ata_sg_is_last(struct scatterlist *sg, s
 }
 
 static inline struct scatterlist *
+ata_qc_first_sg(struct ata_queued_cmd *qc)
+{
+	if (qc->n_elem)
+		return qc->__sg;
+	if (qc->pad_len)
+		return &qc->pad_sgent;
+	return NULL;
+}
+
+static inline struct scatterlist *
 ata_qc_next_sg(struct scatterlist *sg, struct ata_queued_cmd *qc)
 {
 	if (sg == &qc->pad_sgent)
 		return NULL;
 	if (++sg - qc->__sg < qc->n_elem)
 		return sg;
-	return qc->pad_len ? &qc->pad_sgent : NULL;
+	if (qc->pad_len)
+		return &qc->pad_sgent;
+	return NULL;
 }
 
 #define ata_for_each_sg(sg, qc) \
-	for (sg = qc->__sg; sg; sg = ata_qc_next_sg(sg, qc))
+	for (sg = ata_qc_first_sg(qc); sg; sg = ata_qc_next_sg(sg, qc))
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
