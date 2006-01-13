Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161478AbWAMPZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWAMPZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161532AbWAMPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:52 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:4995 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161385AbWAMPY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=e+BscdpyGzNQIO8NrmWKNVJShyBggLAeNDvXA078Om2/l5Tq5rIyXeJkmAHKOj9QNmwAvoYUm/vHKTkjrwkmhlD0IfhTtwarfnrgMCtFbenSzgh/lRyeozXfZd6juhQrgeK2GejKvRH6vYi7iL0/CzauAa4V6M3YUI85CwzTSeE=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/8] block: convert libata to use blk_kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:16 +0900
Message-Id: <11371658561308-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert direct uses of kmap/unmap to blk_kmap/unmap in libata.  This
combined with the previous bio helper change fixes PIO cache coherency
bugs on architectures with aliased caches.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   24 +++++++++++++++---------
 drivers/scsi/libata-scsi.c |    5 +++--
 2 files changed, 18 insertions(+), 11 deletions(-)

c1a1417612a1dc346baf783904d716c2e1d5f223
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f55b9b3..877a33c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2491,9 +2491,10 @@ static void ata_sg_clean(struct ata_queu
 		sg[qc->orig_n_elem - 1].length += qc->pad_len;
 		if (pad_buf) {
 			struct scatterlist *psg = &qc->pad_sgent;
-			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			void *addr = blk_kmap_atomic(psg->page, KM_IRQ0,
+						     DMA_FROM_DEVICE);
 			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-			kunmap_atomic(addr, KM_IRQ0);
+			blk_kunmap_atomic(addr, KM_IRQ0, DMA_FROM_DEVICE);
 		}
 	} else {
 		if (sg_dma_len(&sg[0]) > 0)
@@ -2765,9 +2766,10 @@ static int ata_sg_setup(struct ata_queue
 		psg->offset = offset_in_page(offset);
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
-			void *addr = kmap_atomic(psg->page, KM_IRQ0);
+			void *addr = blk_kmap_atomic(psg->page, KM_IRQ0,
+						     DMA_TO_DEVICE);
 			memcpy(pad_buf, addr + psg->offset, qc->pad_len);
-			kunmap_atomic(addr, KM_IRQ0);
+			blk_kunmap_atomic(addr, KM_IRQ0, DMA_TO_DEVICE);
 		}
 
 		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
@@ -3077,6 +3079,7 @@ static void ata_pio_sector(struct ata_qu
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
 	struct ata_port *ap = qc->ap;
+	enum dma_data_direction dir;
 	struct page *page;
 	unsigned int offset;
 	unsigned char *buf;
@@ -3084,6 +3087,7 @@ static void ata_pio_sector(struct ata_qu
 	if (qc->cursect == (qc->nsect - 1))
 		ap->hsm_task_state = HSM_ST_LAST;
 
+	dir = do_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	page = sg[qc->cursg].page;
 	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
 
@@ -3091,7 +3095,7 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	buf = kmap(page) + offset;
+	buf = blk_kmap(page, dir) + offset;
 
 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -3104,10 +3108,9 @@ static void ata_pio_sector(struct ata_qu
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
 	/* do the actual data transfer */
-	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
 
-	kunmap(page);
+	blk_kunmap(page, dir);
 }
 
 /**
@@ -3127,6 +3130,7 @@ static void __atapi_pio_bytes(struct ata
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
 	struct ata_port *ap = qc->ap;
+	enum dma_data_direction dir;
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
@@ -3134,6 +3138,8 @@ static void __atapi_pio_bytes(struct ata
 	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->hsm_task_state = HSM_ST_LAST;
 
+	dir = do_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
 next_sg:
 	if (unlikely(qc->cursg >= qc->n_elem)) {
 		/*
@@ -3173,7 +3179,7 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
-	buf = kmap(page) + offset;
+	buf = blk_kmap(page, dir) + offset;
 
 	bytes -= count;
 	qc->curbytes += count;
@@ -3189,7 +3195,7 @@ next_sg:
 	/* do the actual data transfer */
 	ata_data_xfer(ap, buf, count, do_write);
 
-	kunmap(page);
+	blk_kunmap(page, dir);
 
 	if (bytes)
 		goto next_sg;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index cfbceb5..8f8a19a 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1372,7 +1372,8 @@ static unsigned int ata_scsi_rbuf_get(st
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
+		buf = blk_kmap_atomic(sg->page, KM_USER0, DMA_FROM_DEVICE);
+		buf += sg->offset;
 		buflen = sg->length;
 	} else {
 		buf = cmd->request_buffer;
@@ -1400,7 +1401,7 @@ static inline void ata_scsi_rbuf_put(str
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(buf - sg->offset, KM_USER0);
+		blk_kunmap_atomic(buf - sg->offset, KM_USER0, DMA_FROM_DEVICE);
 	}
 }
 
-- 
1.0.6


