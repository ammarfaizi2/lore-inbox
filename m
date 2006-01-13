Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161367AbWAMPZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161367AbWAMPZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWAMPYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:54 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:37035 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161367AbWAMPY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=r0eZk9tX859LP5aLE4ipzXDzFml5hgBp5KDWyvcngb2/laK8q6pIzpe2CFoDqaQxiXVSk2IMWOCwb/IA/A+84RFtGCA5Yx71FysmD8twAFAqWT+OoEiNYqoSts5WNa1M+7BMlxmsa+erlbRK1aYLPLTJOCvfixAFpphirujXwGk=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/8] block: convert bio kmap helpers to use blk_kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:16 +0900
Message-Id: <11371658562445-git-send-email-htejun@gmail.com>
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

Convert __bio_kmap_atomic, bvec_kmap_irq, __bio_kmap_irq, bio_kmap_irq
and their unmap counterparts such that they take @dir argument and use
blk_kmap helpers instead of directly calling kmap/unmap.  This patch
also converts all users accordingly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/ide/ide-floppy.c |    8 +++---
 drivers/md/raid5.c       |    9 +++++--
 drivers/md/raid6main.c   |    9 +++++--
 drivers/scsi/scsi_lib.c  |    5 ++--
 fs/bio.c                 |    5 ++--
 include/linux/bio.h      |   59 --------------------------------------------
 include/linux/blkdev.h   |   61 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 84 insertions(+), 72 deletions(-)

b35899fcc1babe0d74c9eb6d05beddb5992f4a60
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5945f55..af39130 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -615,9 +615,9 @@ static void idefloppy_input_buffers (ide
 
 			count = min(bvec->bv_len, bcount);
 
-			data = bvec_kmap_irq(bvec, &flags);
+			data = bvec_kmap_irq(bvec, &flags, DMA_FROM_DEVICE);
 			drive->hwif->atapi_input_bytes(drive, data, count);
-			bvec_kunmap_irq(data, &flags);
+			bvec_kunmap_irq(data, &flags, DMA_FROM_DEVICE);
 
 			bcount -= count;
 			pc->b_count += count;
@@ -649,9 +649,9 @@ static void idefloppy_output_buffers (id
 
 			count = min(bvec->bv_len, bcount);
 
-			data = bvec_kmap_irq(bvec, &flags);
+			data = bvec_kmap_irq(bvec, &flags, DMA_TO_DEVICE);
 			drive->hwif->atapi_output_bytes(drive, data, count);
-			bvec_kunmap_irq(data, &flags);
+			bvec_kunmap_irq(data, &flags, DMA_TO_DEVICE);
 
 			bcount -= count;
 			pc->b_count += count;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 54f4a98..db1fcd2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -689,12 +689,17 @@ static void copy_data(int frombio, struc
 		else clen = len;
 			
 		if (clen > 0) {
-			char *ba = __bio_kmap_atomic(bio, i, KM_USER0);
+			enum dma_data_direction dir;
+			char *ba;
+
+			dir = frombio ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+			ba = __bio_kmap_atomic(bio, i, KM_USER0, dir);
+
 			if (frombio)
 				memcpy(pa+page_offset, ba+b_offset, clen);
 			else
 				memcpy(ba+b_offset, pa+page_offset, clen);
-			__bio_kunmap_atomic(ba, KM_USER0);
+			__bio_kunmap_atomic(ba, KM_USER0, dir);
 		}
 		if (clen < len) /* hit end of page */
 			break;
diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
index 8c823d6..f320291 100644
--- a/drivers/md/raid6main.c
+++ b/drivers/md/raid6main.c
@@ -720,12 +720,17 @@ static void copy_data(int frombio, struc
 		else clen = len;
 
 		if (clen > 0) {
-			char *ba = __bio_kmap_atomic(bio, i, KM_USER0);
+			enum dma_data_direction dir;
+			char *ba;
+
+			dir = frombio ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+			ba = __bio_kmap_atomic(bio, i, KM_USER0, dir);
+
 			if (frombio)
 				memcpy(pa+page_offset, ba+b_offset, clen);
 			else
 				memcpy(ba+b_offset, pa+page_offset, clen);
-			__bio_kunmap_atomic(ba, KM_USER0);
+			__bio_kunmap_atomic(ba, KM_USER0, dir);
 		}
 		if (clen < len) /* hit end of page */
 			break;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 00c9bf3..73285eb 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -942,9 +942,10 @@ void scsi_io_completion(struct scsi_cmnd
 	else if (cmd->buffer != req->buffer) {
 		if (rq_data_dir(req) == READ) {
 			unsigned long flags;
-			char *to = bio_kmap_irq(req->bio, &flags);
+			char *to = bio_kmap_irq(req->bio, &flags,
+						DMA_FROM_DEVICE);
 			memcpy(to, cmd->buffer, cmd->bufflen);
-			bio_kunmap_irq(to, &flags);
+			bio_kunmap_irq(to, &flags, DMA_FROM_DEVICE);
 		}
 		kfree(cmd->buffer);
 	}
diff --git a/fs/bio.c b/fs/bio.c
index 7b30695..c7b5442 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -199,10 +199,9 @@ void zero_fill_bio(struct bio *bio)
 	int i;
 
 	bio_for_each_segment(bv, bio, i) {
-		char *data = bvec_kmap_irq(bv, &flags);
+		char *data = bvec_kmap_irq(bv, &flags, DMA_FROM_DEVICE);
 		memset(data, 0, bv->bv_len);
-		flush_dcache_page(bv->bv_page);
-		bvec_kunmap_irq(data, &flags);
+		bvec_kunmap_irq(data, &flags, DMA_FROM_DEVICE);
 	}
 }
 EXPORT_SYMBOL(zero_fill_bio);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b60ffe3..8c80a14 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -186,18 +186,6 @@ struct bio {
 #define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (unsigned long) (bv)->bv_offset)
 
 /*
- * queues that have highmem support enabled may still need to revert to
- * PIO transfers occasionally and thus map high pages temporarily. For
- * permanent PIO fall back, user is probably better off disabling highmem
- * I/O completely on that queue (see ide-dma for example)
- */
-#define __bio_kmap_atomic(bio, idx, kmtype)				\
-	(kmap_atomic(bio_iovec_idx((bio), (idx))->bv_page, kmtype) +	\
-		bio_iovec_idx((bio), (idx))->bv_offset)
-
-#define __bio_kunmap_atomic(addr, kmtype) kunmap_atomic(addr, kmtype)
-
-/*
  * merge helpers etc
  */
 
@@ -310,51 +298,4 @@ extern struct bio *bio_copy_user(struct 
 extern int bio_uncopy_user(struct bio *);
 void zero_fill_bio(struct bio *bio);
 
-#ifdef CONFIG_HIGHMEM
-/*
- * remember to add offset! and never ever reenable interrupts between a
- * bvec_kmap_irq and bvec_kunmap_irq!!
- *
- * This function MUST be inlined - it plays with the CPU interrupt flags.
- */
-static inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
-{
-	unsigned long addr;
-
-	/*
-	 * might not be a highmem page, but the preempt/irq count
-	 * balancing is a lot nicer this way
-	 */
-	local_irq_save(*flags);
-	addr = (unsigned long) kmap_atomic(bvec->bv_page, KM_BIO_SRC_IRQ);
-
-	BUG_ON(addr & ~PAGE_MASK);
-
-	return (char *) addr + bvec->bv_offset;
-}
-
-static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
-{
-	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
-
-	kunmap_atomic((void *) ptr, KM_BIO_SRC_IRQ);
-	local_irq_restore(*flags);
-}
-
-#else
-#define bvec_kmap_irq(bvec, flags)	(page_address((bvec)->bv_page) + (bvec)->bv_offset)
-#define bvec_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
-#endif
-
-static inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
-				   unsigned long *flags)
-{
-	return bvec_kmap_irq(bio_iovec_idx(bio, idx), flags);
-}
-#define __bio_kunmap_irq(buf, flags)	bvec_kunmap_irq(buf, flags)
-
-#define bio_kmap_irq(bio, flags) \
-	__bio_kmap_irq((bio), (bio)->bi_idx, (flags))
-#define bio_kunmap_irq(buf,flags)	__bio_kunmap_irq(buf, flags)
-
 #endif /* __LINUX_BIO_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1040029..ed432cf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -850,6 +850,67 @@ static inline void blk_kunmap(struct pag
 	kunmap(page);
 }
 
+static inline void * __bio_kmap_atomic(struct bio *bio, unsigned short idx,
+				       enum km_type type,
+				       enum dma_data_direction dir)
+{
+	struct bio_vec *bvec = bio_iovec_idx(bio, idx);
+	return blk_kmap_atomic(bvec->bv_page, type, dir) + bvec->bv_offset;
+}
+
+static inline void __bio_kunmap_atomic(void *addr, enum km_type type,
+				       enum dma_data_direction dir)
+{
+	addr = (void *)((unsigned long)addr & PAGE_MASK);
+	return blk_kunmap_atomic(addr, type, dir);
+}
+
+/*
+ * Never ever reenable interrupts between a bvec_kmap_irq and
+ * bvec_kunmap_irq!!  This function MUST be inlined - it plays with
+ * the CPU interrupt flags.
+ */
+static inline char * bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags,
+				   enum dma_data_direction dir)
+{
+	char *addr;
+
+	/*
+	 * might not be a highmem page, but the preempt/irq count
+	 * balancing is a lot nicer this way
+	 */
+#ifdef CONFIG_HIGHMEM
+	local_irq_save(*flags);
+#endif
+	addr = blk_kmap_atomic(bvec->bv_page, KM_BIO_SRC_IRQ, dir);
+
+	BUG_ON(((unsigned long)addr) & ~PAGE_MASK);
+
+	return addr + bvec->bv_offset;
+}
+
+static inline void bvec_kunmap_irq(char *addr, unsigned long *flags,
+				   enum dma_data_direction dir)
+{
+	addr = (char *)((unsigned long)addr & PAGE_MASK);
+	blk_kunmap_atomic(addr, KM_BIO_SRC_IRQ, dir);
+#ifdef CONFIG_HIGHMEM
+	local_irq_restore(*flags);
+#endif
+}
+
+static inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
+				   unsigned long *flags,
+				   enum dma_data_direction dir)
+{
+	return bvec_kmap_irq(bio_iovec_idx(bio, idx), flags, dir);
+}
+#define __bio_kunmap_irq(buf, flags, dir) bvec_kunmap_irq(buf, flags, dir)
+
+#define bio_kmap_irq(bio, flags, dir) \
+	__bio_kmap_irq((bio), (bio)->bi_idx, (flags), dir)
+#define bio_kunmap_irq(buf,flags, dir)	__bio_kunmap_irq(buf, flags, dir)
+
 struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 void kblockd_flush(void);
-- 
1.0.6


