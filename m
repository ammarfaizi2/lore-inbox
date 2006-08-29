Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWH2SHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWH2SHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWH2SG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:06:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965208AbWH2SGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:06:09 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/19] BLOCK: Separate the bounce buffering code from the highmem code [try #6]
Date: Tue, 29 Aug 2006 19:06:00 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180600.32596.55480.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the bounce buffer code from mm/highmem.c to mm/bounce.c so that it can be
more easily disabled when the block layer is disabled.

!!!NOTE!!! There may be a bug in this code: Should init_emergency_pool() be
	   contingent on CONFIG_HIGHMEM?

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/Makefile  |    4 +
 mm/bounce.c  |  302 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/highmem.c |  281 ------------------------------------------------------
 3 files changed, 305 insertions(+), 282 deletions(-)

diff --git a/mm/Makefile b/mm/Makefile
index 9dd824c..63637f0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -12,6 +12,9 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o swap.o truncate.o vmscan.o \
 			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
 
+ifeq ($(CONFIG_MMU),y)
+obj-y			+= bounce.o
+endif
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
@@ -23,4 +26,3 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-
diff --git a/mm/bounce.c b/mm/bounce.c
new file mode 100644
index 0000000..e4b62d2
--- /dev/null
+++ b/mm/bounce.c
@@ -0,0 +1,302 @@
+/* bounce buffer handling for block devices
+ *
+ * - Split from highmem.c
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/swap.h>
+#include <linux/bio.h>
+#include <linux/pagemap.h>
+#include <linux/mempool.h>
+#include <linux/blkdev.h>
+#include <linux/init.h>
+#include <linux/hash.h>
+#include <linux/highmem.h>
+#include <linux/blktrace_api.h>
+#include <asm/tlbflush.h>
+
+#define POOL_SIZE	64
+#define ISA_POOL_SIZE	16
+
+static mempool_t *page_pool, *isa_page_pool;
+
+#ifdef CONFIG_HIGHMEM
+static __init int init_emergency_pool(void)
+{
+	struct sysinfo i;
+	si_meminfo(&i);
+	si_swapinfo(&i);
+
+	if (!i.totalhigh)
+		return 0;
+
+	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
+	BUG_ON(!page_pool);
+	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
+
+	return 0;
+}
+
+__initcall(init_emergency_pool);
+
+/*
+ * highmem version, map in to vec
+ */
+static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
+{
+	unsigned long flags;
+	unsigned char *vto;
+
+	local_irq_save(flags);
+	vto = kmap_atomic(to->bv_page, KM_BOUNCE_READ);
+	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
+	kunmap_atomic(vto, KM_BOUNCE_READ);
+	local_irq_restore(flags);
+}
+
+#else /* CONFIG_HIGHMEM */
+
+#define bounce_copy_vec(to, vfrom)	\
+	memcpy(page_address((to)->bv_page) + (to)->bv_offset, vfrom, (to)->bv_len)
+
+#endif /* CONFIG_HIGHMEM */
+
+/*
+ * allocate pages in the DMA region for the ISA pool
+ */
+static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
+{
+	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
+}
+
+/*
+ * gets called "every" time someone init's a queue with BLK_BOUNCE_ISA
+ * as the max address, so check if the pool has already been created.
+ */
+int init_emergency_isa_pool(void)
+{
+	if (isa_page_pool)
+		return 0;
+
+	isa_page_pool = mempool_create(ISA_POOL_SIZE, mempool_alloc_pages_isa,
+				       mempool_free_pages, (void *) 0);
+	BUG_ON(!isa_page_pool);
+
+	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
+	return 0;
+}
+
+/*
+ * Simple bounce buffer support for highmem pages. Depending on the
+ * queue gfp mask set, *to may or may not be a highmem page. kmap it
+ * always, it will do the Right Thing
+ */
+static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
+{
+	unsigned char *vfrom;
+	struct bio_vec *tovec, *fromvec;
+	int i;
+
+	__bio_for_each_segment(tovec, to, i, 0) {
+		fromvec = from->bi_io_vec + i;
+
+		/*
+		 * not bounced
+		 */
+		if (tovec->bv_page == fromvec->bv_page)
+			continue;
+
+		/*
+		 * fromvec->bv_offset and fromvec->bv_len might have been
+		 * modified by the block layer, so use the original copy,
+		 * bounce_copy_vec already uses tovec->bv_len
+		 */
+		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
+
+		flush_dcache_page(tovec->bv_page);
+		bounce_copy_vec(tovec, vfrom);
+	}
+}
+
+static void bounce_end_io(struct bio *bio, mempool_t *pool, int err)
+{
+	struct bio *bio_orig = bio->bi_private;
+	struct bio_vec *bvec, *org_vec;
+	int i;
+
+	if (test_bit(BIO_EOPNOTSUPP, &bio->bi_flags))
+		set_bit(BIO_EOPNOTSUPP, &bio_orig->bi_flags);
+
+	/*
+	 * free up bounce indirect pages used
+	 */
+	__bio_for_each_segment(bvec, bio, i, 0) {
+		org_vec = bio_orig->bi_io_vec + i;
+		if (bvec->bv_page == org_vec->bv_page)
+			continue;
+
+		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
+		mempool_free(bvec->bv_page, pool);
+	}
+
+	bio_endio(bio_orig, bio_orig->bi_size, err);
+	bio_put(bio);
+}
+
+static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	bounce_end_io(bio, page_pool, err);
+	return 0;
+}
+
+static int bounce_end_io_write_isa(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	bounce_end_io(bio, isa_page_pool, err);
+	return 0;
+}
+
+static void __bounce_end_io_read(struct bio *bio, mempool_t *pool, int err)
+{
+	struct bio *bio_orig = bio->bi_private;
+
+	if (test_bit(BIO_UPTODATE, &bio->bi_flags))
+		copy_to_high_bio_irq(bio_orig, bio);
+
+	bounce_end_io(bio, pool, err);
+}
+
+static int bounce_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	__bounce_end_io_read(bio, page_pool, err);
+	return 0;
+}
+
+static int bounce_end_io_read_isa(struct bio *bio, unsigned int bytes_done, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	__bounce_end_io_read(bio, isa_page_pool, err);
+	return 0;
+}
+
+static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
+			       mempool_t *pool)
+{
+	struct page *page;
+	struct bio *bio = NULL;
+	int i, rw = bio_data_dir(*bio_orig);
+	struct bio_vec *to, *from;
+
+	bio_for_each_segment(from, *bio_orig, i) {
+		page = from->bv_page;
+
+		/*
+		 * is destination page below bounce pfn?
+		 */
+		if (page_to_pfn(page) < q->bounce_pfn)
+			continue;
+
+		/*
+		 * irk, bounce it
+		 */
+		if (!bio)
+			bio = bio_alloc(GFP_NOIO, (*bio_orig)->bi_vcnt);
+
+		to = bio->bi_io_vec + i;
+
+		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
+		to->bv_len = from->bv_len;
+		to->bv_offset = from->bv_offset;
+		inc_zone_page_state(to->bv_page, NR_BOUNCE);
+
+		if (rw == WRITE) {
+			char *vto, *vfrom;
+
+			flush_dcache_page(from->bv_page);
+			vto = page_address(to->bv_page) + to->bv_offset;
+			vfrom = kmap(from->bv_page) + from->bv_offset;
+			memcpy(vto, vfrom, to->bv_len);
+			kunmap(from->bv_page);
+		}
+	}
+
+	/*
+	 * no pages bounced
+	 */
+	if (!bio)
+		return;
+
+	/*
+	 * at least one page was bounced, fill in possible non-highmem
+	 * pages
+	 */
+	__bio_for_each_segment(from, *bio_orig, i, 0) {
+		to = bio_iovec_idx(bio, i);
+		if (!to->bv_page) {
+			to->bv_page = from->bv_page;
+			to->bv_len = from->bv_len;
+			to->bv_offset = from->bv_offset;
+		}
+	}
+
+	bio->bi_bdev = (*bio_orig)->bi_bdev;
+	bio->bi_flags |= (1 << BIO_BOUNCED);
+	bio->bi_sector = (*bio_orig)->bi_sector;
+	bio->bi_rw = (*bio_orig)->bi_rw;
+
+	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
+	bio->bi_idx = (*bio_orig)->bi_idx;
+	bio->bi_size = (*bio_orig)->bi_size;
+
+	if (pool == page_pool) {
+		bio->bi_end_io = bounce_end_io_write;
+		if (rw == READ)
+			bio->bi_end_io = bounce_end_io_read;
+	} else {
+		bio->bi_end_io = bounce_end_io_write_isa;
+		if (rw == READ)
+			bio->bi_end_io = bounce_end_io_read_isa;
+	}
+
+	bio->bi_private = *bio_orig;
+	*bio_orig = bio;
+}
+
+void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
+{
+	mempool_t *pool;
+
+	/*
+	 * for non-isa bounce case, just check if the bounce pfn is equal
+	 * to or bigger than the highest pfn in the system -- in that case,
+	 * don't waste time iterating over bio segments
+	 */
+	if (!(q->bounce_gfp & GFP_DMA)) {
+		if (q->bounce_pfn >= blk_max_pfn)
+			return;
+		pool = page_pool;
+	} else {
+		BUG_ON(!isa_page_pool);
+		pool = isa_page_pool;
+	}
+
+	blk_add_trace_bio(q, *bio_orig, BLK_TA_BOUNCE);
+
+	/*
+	 * slow path
+	 */
+	__blk_queue_bounce(q, bio_orig, pool);
+}
+
+EXPORT_SYMBOL(blk_queue_bounce);
diff --git a/mm/highmem.c b/mm/highmem.c
index 9b2a540..1ac20d6 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -29,13 +29,6 @@ #include <linux/highmem.h>
 #include <linux/blktrace_api.h>
 #include <asm/tlbflush.h>
 
-static mempool_t *page_pool, *isa_page_pool;
-
-static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
-{
-	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
-}
-
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -204,282 +197,8 @@ void fastcall kunmap_high(struct page *p
 }
 
 EXPORT_SYMBOL(kunmap_high);
-
-#define POOL_SIZE	64
-
-static __init int init_emergency_pool(void)
-{
-	struct sysinfo i;
-	si_meminfo(&i);
-	si_swapinfo(&i);
-        
-	if (!i.totalhigh)
-		return 0;
-
-	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
-	BUG_ON(!page_pool);
-	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
-
-	return 0;
-}
-
-__initcall(init_emergency_pool);
-
-/*
- * highmem version, map in to vec
- */
-static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
-{
-	unsigned long flags;
-	unsigned char *vto;
-
-	local_irq_save(flags);
-	vto = kmap_atomic(to->bv_page, KM_BOUNCE_READ);
-	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
-	kunmap_atomic(vto, KM_BOUNCE_READ);
-	local_irq_restore(flags);
-}
-
-#else /* CONFIG_HIGHMEM */
-
-#define bounce_copy_vec(to, vfrom)	\
-	memcpy(page_address((to)->bv_page) + (to)->bv_offset, vfrom, (to)->bv_len)
-
 #endif
 
-#define ISA_POOL_SIZE	16
-
-/*
- * gets called "every" time someone init's a queue with BLK_BOUNCE_ISA
- * as the max address, so check if the pool has already been created.
- */
-int init_emergency_isa_pool(void)
-{
-	if (isa_page_pool)
-		return 0;
-
-	isa_page_pool = mempool_create(ISA_POOL_SIZE, mempool_alloc_pages_isa,
-				       mempool_free_pages, (void *) 0);
-	BUG_ON(!isa_page_pool);
-
-	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
-	return 0;
-}
-
-/*
- * Simple bounce buffer support for highmem pages. Depending on the
- * queue gfp mask set, *to may or may not be a highmem page. kmap it
- * always, it will do the Right Thing
- */
-static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
-{
-	unsigned char *vfrom;
-	struct bio_vec *tovec, *fromvec;
-	int i;
-
-	__bio_for_each_segment(tovec, to, i, 0) {
-		fromvec = from->bi_io_vec + i;
-
-		/*
-		 * not bounced
-		 */
-		if (tovec->bv_page == fromvec->bv_page)
-			continue;
-
-		/*
-		 * fromvec->bv_offset and fromvec->bv_len might have been
-		 * modified by the block layer, so use the original copy,
-		 * bounce_copy_vec already uses tovec->bv_len
-		 */
-		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
-
-		flush_dcache_page(tovec->bv_page);
-		bounce_copy_vec(tovec, vfrom);
-	}
-}
-
-static void bounce_end_io(struct bio *bio, mempool_t *pool, int err)
-{
-	struct bio *bio_orig = bio->bi_private;
-	struct bio_vec *bvec, *org_vec;
-	int i;
-
-	if (test_bit(BIO_EOPNOTSUPP, &bio->bi_flags))
-		set_bit(BIO_EOPNOTSUPP, &bio_orig->bi_flags);
-
-	/*
-	 * free up bounce indirect pages used
-	 */
-	__bio_for_each_segment(bvec, bio, i, 0) {
-		org_vec = bio_orig->bi_io_vec + i;
-		if (bvec->bv_page == org_vec->bv_page)
-			continue;
-
-		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
-		mempool_free(bvec->bv_page, pool);
-	}
-
-	bio_endio(bio_orig, bio_orig->bi_size, err);
-	bio_put(bio);
-}
-
-static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	bounce_end_io(bio, page_pool, err);
-	return 0;
-}
-
-static int bounce_end_io_write_isa(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	bounce_end_io(bio, isa_page_pool, err);
-	return 0;
-}
-
-static void __bounce_end_io_read(struct bio *bio, mempool_t *pool, int err)
-{
-	struct bio *bio_orig = bio->bi_private;
-
-	if (test_bit(BIO_UPTODATE, &bio->bi_flags))
-		copy_to_high_bio_irq(bio_orig, bio);
-
-	bounce_end_io(bio, pool, err);
-}
-
-static int bounce_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	__bounce_end_io_read(bio, page_pool, err);
-	return 0;
-}
-
-static int bounce_end_io_read_isa(struct bio *bio, unsigned int bytes_done, int err)
-{
-	if (bio->bi_size)
-		return 1;
-
-	__bounce_end_io_read(bio, isa_page_pool, err);
-	return 0;
-}
-
-static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
-			       mempool_t *pool)
-{
-	struct page *page;
-	struct bio *bio = NULL;
-	int i, rw = bio_data_dir(*bio_orig);
-	struct bio_vec *to, *from;
-
-	bio_for_each_segment(from, *bio_orig, i) {
-		page = from->bv_page;
-
-		/*
-		 * is destination page below bounce pfn?
-		 */
-		if (page_to_pfn(page) < q->bounce_pfn)
-			continue;
-
-		/*
-		 * irk, bounce it
-		 */
-		if (!bio)
-			bio = bio_alloc(GFP_NOIO, (*bio_orig)->bi_vcnt);
-
-		to = bio->bi_io_vec + i;
-
-		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
-		to->bv_len = from->bv_len;
-		to->bv_offset = from->bv_offset;
-		inc_zone_page_state(to->bv_page, NR_BOUNCE);
-
-		if (rw == WRITE) {
-			char *vto, *vfrom;
-
-			flush_dcache_page(from->bv_page);
-			vto = page_address(to->bv_page) + to->bv_offset;
-			vfrom = kmap(from->bv_page) + from->bv_offset;
-			memcpy(vto, vfrom, to->bv_len);
-			kunmap(from->bv_page);
-		}
-	}
-
-	/*
-	 * no pages bounced
-	 */
-	if (!bio)
-		return;
-
-	/*
-	 * at least one page was bounced, fill in possible non-highmem
-	 * pages
-	 */
-	__bio_for_each_segment(from, *bio_orig, i, 0) {
-		to = bio_iovec_idx(bio, i);
-		if (!to->bv_page) {
-			to->bv_page = from->bv_page;
-			to->bv_len = from->bv_len;
-			to->bv_offset = from->bv_offset;
-		}
-	}
-
-	bio->bi_bdev = (*bio_orig)->bi_bdev;
-	bio->bi_flags |= (1 << BIO_BOUNCED);
-	bio->bi_sector = (*bio_orig)->bi_sector;
-	bio->bi_rw = (*bio_orig)->bi_rw;
-
-	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
-	bio->bi_idx = (*bio_orig)->bi_idx;
-	bio->bi_size = (*bio_orig)->bi_size;
-
-	if (pool == page_pool) {
-		bio->bi_end_io = bounce_end_io_write;
-		if (rw == READ)
-			bio->bi_end_io = bounce_end_io_read;
-	} else {
-		bio->bi_end_io = bounce_end_io_write_isa;
-		if (rw == READ)
-			bio->bi_end_io = bounce_end_io_read_isa;
-	}
-
-	bio->bi_private = *bio_orig;
-	*bio_orig = bio;
-}
-
-void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
-{
-	mempool_t *pool;
-
-	/*
-	 * for non-isa bounce case, just check if the bounce pfn is equal
-	 * to or bigger than the highest pfn in the system -- in that case,
-	 * don't waste time iterating over bio segments
-	 */
-	if (!(q->bounce_gfp & GFP_DMA)) {
-		if (q->bounce_pfn >= blk_max_pfn)
-			return;
-		pool = page_pool;
-	} else {
-		BUG_ON(!isa_page_pool);
-		pool = isa_page_pool;
-	}
-
-	blk_add_trace_bio(q, *bio_orig, BLK_TA_BOUNCE);
-
-	/*
-	 * slow path
-	 */
-	__blk_queue_bounce(q, bio_orig, pool);
-}
-
-EXPORT_SYMBOL(blk_queue_bounce);
-
 #if defined(HASHED_PAGE_VIRTUAL)
 
 #define PA_HASH_ORDER	7
