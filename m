Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283170AbRK2LPY>; Thu, 29 Nov 2001 06:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283175AbRK2LPG>; Thu, 29 Nov 2001 06:15:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23568 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283170AbRK2LPB>;
	Thu, 29 Nov 2001 06:15:01 -0500
Date: Thu, 29 Nov 2001 12:14:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, rwhron@earthlink.net
Subject: 2.5.1-pre3 FIXED (was Re: 2.5.1-pre3 DON'T USE)
Message-ID: <20011129121431.D10601@suse.de>
In-Reply-To: <20011129091554.E5788@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129091554.E5788@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Jens Axboe wrote:
> Hi,
> 
> Please don't use this kernel unless you can afford to loose your data.
> I'm looking at the problem right now.

Ok the problem was only on highmem machines, the copying of data was
just wrong. The attached patch fixes that and a few other buglets, such
as:

- BIO_HASH remnant in LVM
- bouncing should take multi-page bio's into account
- bouncing should bounce pages _above_ the bounce_pfn :-)
- remove bio_size() macro, it's just silly
- multi-page bio fixes (BIO_CONTIG etc)

Linus, please apply.

I'm going to make a TODO list for the new block stuff, so potential
block janitors can get cracking on updating all those broken drivers
etc. If someone would be willing to coordinate this effort, let me know.

diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/block/elevator.c	Thu Nov 29 06:07:20 2001
+++ linux/drivers/block/elevator.c	Thu Nov 29 04:36:29 2001
@@ -98,7 +98,7 @@
 {
 	if (bio_data_dir(bio) == rq->cmd) {
 		if (rq->rq_dev == bio->bi_dev && !rq->waiting
-		    && !rq->special && rq->inactive && rq->q == q)
+		    && !rq->special && rq->inactive)
 			return 1;
 	}
 
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/block/floppy.c linux/drivers/block/floppy.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/block/floppy.c	Thu Nov 29 06:07:20 2001
+++ linux/drivers/block/floppy.c	Thu Nov 29 05:07:37 2001
@@ -2437,16 +2437,15 @@
 	char *base;
 
 	base = CURRENT->buffer;
-	size = CURRENT->current_nr_sectors << 9;
-	bio = CURRENT->bio;
+	size = 0;
 
-	if (bio){
-		bio = bio->bi_next;
-		while (bio && bio_data(bio) == base + size){
-			size += bio_size(bio);
-			bio = bio->bi_next;
-		}
+	rq_for_each_bio(bio, CURRENT) {
+		if (bio_data(bio) != base + size)
+			break;
+
+		size += bio->bi_size;
 	}
+
 	return size >> 9;
 }
 
@@ -2543,7 +2542,7 @@
 			break;
 		}
 #endif
-		size = bio_size(bio);
+		size = bio->bi_size;;
 		buffer = bio_data(bio);
 	}
 #ifdef FLOPPY_SANITY_CHECK
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/block/ll_rw_blk.c	Thu Nov 29 06:07:20 2001
+++ linux/drivers/block/ll_rw_blk.c	Thu Nov 29 06:02:17 2001
@@ -303,10 +303,7 @@
 
 			BIO_BUG_ON(i > bio->bi_vcnt);
 
-			if (!cluster)
-				goto new_segment;
-
-			if (bvec_to_phys(bvec) == lastend) {
+			if (cluster && bvec_to_phys(bvec) == lastend) {
 				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
 					goto new_segment;
 
@@ -1135,7 +1132,7 @@
 	BUG_ON(!bio->bi_end_io);
 
 	BIO_BUG_ON(bio_offset(bio) > PAGE_SIZE);
-	BIO_BUG_ON(!bio_size(bio));
+	BIO_BUG_ON(!bio->bi_size);
 	BIO_BUG_ON(!bio->bi_io_vec);
 
 	bio->bi_rw = rw;
@@ -1172,11 +1169,7 @@
 	bio = bio_alloc(GFP_NOIO, 1);
 
 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio->bi_next = NULL;
 	bio->bi_dev = bh->b_dev;
-	bio->bi_private = bh;
-	bio->bi_end_io = end_bio_bh_io_sync;
-
 	bio->bi_io_vec[0].bv_page = bh->b_page;
 	bio->bi_io_vec[0].bv_len = bh->b_size;
 	bio->bi_io_vec[0].bv_offset = bh_offset(bh);
@@ -1184,6 +1177,9 @@
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
 	bio->bi_size = bh->b_size;
+
+	bio->bi_end_io = end_bio_bh_io_sync;
+	bio->bi_private = bh;
 
 	return submit_bio(rw, bio);
 }
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/block/loop.c linux/drivers/block/loop.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/block/loop.c	Thu Nov 29 06:07:20 2001
+++ linux/drivers/block/loop.c	Thu Nov 29 05:08:06 2001
@@ -182,7 +182,7 @@
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
-	len = bio_size(bio);
+	len = bio->bi_size;
 	data = bio_data(bio);
 	while (len > 0) {
 		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
@@ -272,7 +272,7 @@
 	cookie.data = bio_data(bio);
 	cookie.bsize = bsize;
 	desc.written = 0;
-	desc.count = bio_size(bio);
+	desc.count = bio->bi_size;
 	desc.buf = (char*)&cookie;
 	desc.error = 0;
 	spin_lock_irq(&lo->lo_lock);
@@ -470,7 +470,7 @@
 	IV = loop_get_iv(lo, rbh->bi_sector);
 	if (rw == WRITE) {
 		if (lo_do_transfer(lo, WRITE, bio_data(bh), bio_data(rbh),
-				   bio_size(bh), IV))
+				   bh->bi_size, IV))
 			goto err;
 	}
 
@@ -504,7 +504,7 @@
 		unsigned long IV = loop_get_iv(lo, rbh->bi_sector);
 
 		ret = lo_do_transfer(lo, READ, bio_data(bio), bio_data(rbh),
-				     bio_size(bio), IV);
+				     bio->bi_size, IV);
 
 		bio_endio(rbh, !ret, bio_sectors(bio));
 		loop_put_buffer(bio);
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/block/nbd.c linux/drivers/block/nbd.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/block/nbd.c	Thu Nov 29 06:07:20 2001
+++ linux/drivers/block/nbd.c	Thu Nov 29 05:04:41 2001
@@ -168,7 +168,7 @@
 		struct bio *bio = req->bio;
 		DEBUG("data, ");
 		do {
-			result = nbd_xmit(1, sock, bio_data(bio), bio_size(bio), bio->bi_next == NULL ? 0 : MSG_MORE);
+			result = nbd_xmit(1, sock, bio_data(bio), bio->bi_size, bio->bi_next == NULL ? 0 : MSG_MORE);
 			if (result <= 0)
 				FAIL("Send data failed.");
 			bio = bio->bi_next;
@@ -208,7 +208,7 @@
 		struct bio *bio = req->bio;
 		DEBUG("data, ");
 		do {
-			result = nbd_xmit(0, lo->sock, bio_data(bio), bio_size(bio), MSG_WAITALL);
+			result = nbd_xmit(0, lo->sock, bio_data(bio), bio->bi_size, MSG_WAITALL);
 			if (result <= 0)
 				HARDFAIL("Recv data failed.");
 			bio = bio->bi_next;
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/md/lvm.c linux/drivers/md/lvm.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/md/lvm.c	Thu Nov 29 06:07:21 2001
+++ linux/drivers/md/lvm.c	Thu Nov 29 05:50:47 2001
@@ -1246,8 +1246,6 @@
  	}
 
  out:
-	if (test_bit(BIO_HASHED, &bh->bi_flags))
-		BUG();
 	bh->bi_dev = rdev_map;
 	bh->bi_sector = rsector_map;
 	up_read(&lv->lv_lock);
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/message/i2o/i2o_block.c linux/drivers/message/i2o/i2o_block.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/message/i2o/i2o_block.c	Thu Nov 29 06:07:21 2001
+++ linux/drivers/message/i2o/i2o_block.c	Thu Nov 29 05:14:13 2001
@@ -287,8 +287,8 @@
 		while(bio)
 		{
 			if (bio_to_phys(bio) == last) {
-				size += bio_size(bio);
-				last += bio_size(bio);
+				size += bio->bi_size;
+				last += bio->bi_size;
 				if(bio->bi_next)
 					__raw_writel(0x14000000|(size), mptr-8);
 				else
@@ -297,16 +297,16 @@
 			else
 			{
 				if(bio->bi_next)
-					__raw_writel(0x10000000|bio_size(bio), mptr);
+					__raw_writel(0x10000000|bio->bi_size, mptr);
 				else
-					__raw_writel(0xD0000000|bio_size(bio), mptr);
+					__raw_writel(0xD0000000|bio->bi_size, mptr);
 				__raw_writel(bio_to_phys(bio), mptr+4);
 				mptr += 8;	
-				size = bio_size(bio);
-				last = bio_to_phys(bio) + bio_size(bio);
+				size = bio->bi_size;
+				last = bio_to_phys(bio) + bio->bi_size;
 			}
 
-			count -= bio_size(bio);
+			count -= bio->bi_size;
 			bio = bio->bi_next;
 		}
 		/*
@@ -326,8 +326,8 @@
 		while(bio)
 		{
 			if (bio_to_phys(bio) == last) {
-				size += bio_size(bio);
-				last += bio_size(bio);
+				size += bio->bi_size;
+				last += bio->bi_size;
 				if(bio->bi_next)
 					__raw_writel(0x14000000|(size), mptr-8);
 				else
@@ -336,16 +336,16 @@
 			else
 			{
 				if(bio->bi_next)
-					__raw_writel(0x14000000|bio_size(bio), mptr);
+					__raw_writel(0x14000000|bio->bi_size, mptr);
 				else
-					__raw_writel(0xD4000000|bio_size(bio), mptr);
+					__raw_writel(0xD4000000|bio->bi_size, mptr);
 				__raw_writel(bio_to_phys(bio), mptr+4);
 				mptr += 8;	
-				size = bio_size(bio);
-				last = bio_to_phys(bio) + bio_size(bio);
+				size = bio->bi_size;
+				last = bio_to_phys(bio) + bio->bi_size;
 			}
 
-			count -= bio_size(bio);
+			count -= bio->bi_size;
 			bio = bio->bi_next;
 		}
 
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/drivers/scsi/scsi_merge.c linux/drivers/scsi/scsi_merge.c
--- /opt/kernel/linux-2.5.1-pre3/drivers/scsi/scsi_merge.c	Thu Nov 29 06:07:21 2001
+++ linux/drivers/scsi/scsi_merge.c	Thu Nov 29 05:12:28 2001
@@ -148,7 +148,7 @@
 	 */
 	bio = req->bio;
 #ifdef DMA_SEGMENT_SIZE_LIMITED
-	if (reqsize + bio_size(bio) > PAGE_SIZE)
+	if (reqsize + bio->bi_size > PAGE_SIZE)
 		ret++;
 #endif
 
@@ -156,7 +156,7 @@
 		bio_for_each_segment(bvec, bio, i)
 			ret++;
 
-		reqsize += bio_size(bio);
+		reqsize += bio->bi_size;
 	}
 
 	if (remainder)
@@ -201,7 +201,7 @@
 }
 
 #define MERGEABLE_BUFFERS(X,Y) \
-(((((long)bio_to_phys((X))+bio_size((X)))|((long)bio_to_phys((Y)))) & \
+(((((long)bio_to_phys((X))+(X)->bi_size)|((long)bio_to_phys((Y)))) & \
   (DMA_CHUNK_SIZE - 1)) == 0)
 
 #ifdef DMA_CHUNK_SIZE
@@ -767,7 +767,7 @@
 		 * back and allocate a really small one - enough to satisfy
 		 * the first buffer.
 		 */
-		if (bio_to_phys(bio) + bio_size(bio) - 1 > ISA_DMA_THRESHOLD) {
+		if (bio_to_phys(bio) + bio->bi_size - 1 > ISA_DMA_THRESHOLD) {
 			buff = (char *) scsi_malloc(this_count << 9);
 			if (!buff) {
 				printk("Warning - running low on DMA memory\n");
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/fs/bio.c linux/fs/bio.c
--- /opt/kernel/linux-2.5.1-pre3/fs/bio.c	Thu Nov 29 06:07:21 2001
+++ linux/fs/bio.c	Thu Nov 29 02:24:31 2001
@@ -215,6 +215,9 @@
 	atomic_set(&bio->bi_cnt, 1);
 	bio->bi_flags = 0;
 	bio->bi_rw = 0;
+	bio->bi_vcnt = 0;
+	bio->bi_idx = 0;
+	bio->bi_size = 0;
 	bio->bi_end_io = NULL;
 }
 
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/include/linux/bio.h linux/include/linux/bio.h
--- /opt/kernel/linux-2.5.1-pre3/include/linux/bio.h	Thu Nov 29 06:07:22 2001
+++ linux/include/linux/bio.h	Thu Nov 29 05:04:05 2001
@@ -93,10 +93,9 @@
 #define bio_iovec_idx(bio, idx)	(&((bio)->bi_io_vec[(bio)->bi_idx]))
 #define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_idx)
 #define bio_page(bio)		bio_iovec((bio))->bv_page
-#define bio_size(bio)		((bio)->bi_size)
 #define __bio_offset(bio, idx)	bio_iovec_idx((bio), (idx))->bv_offset
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
-#define bio_sectors(bio)	(bio_size((bio)) >> 9)
+#define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
 #define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_BARRIER))
 
@@ -107,13 +106,6 @@
 #define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (bv)->bv_offset)
 
 /*
- * hack to avoid doing 64-bit calculations on 32-bit archs, instead use a
- * pseudo-pfn check to do segment coalescing
- */
-#define bio_sec_pfn(bio) \
-	((((bio_page(bio) - bio_page(bio)->zone->zone_mem_map) << PAGE_SHIFT) / bio_size(bio)) + (bio_offset(bio) >> 9))
-
-/*
  * queues that have highmem support enabled may still need to revert to
  * PIO transfers occasionally and thus map high pages temporarily. For
  * permanent PIO fall back, user is probably better off disabling highmem
@@ -124,12 +116,16 @@
 #define __bio_kunmap(bio, idx)	kunmap(bio_iovec_idx((bio), (idx))->bv_page)
 #define bio_kunmap(bio)		__bio_kunmap((bio), (bio)->bi_idx)
 
+/*
+ * merge helpers etc
+ */
+#define __BVEC_END(bio) bio_iovec_idx((bio), (bio)->bi_idx - 1)
 #define BIO_CONTIG(bio, nxt) \
-	(bio_to_phys((bio)) + bio_size((bio)) == bio_to_phys((nxt)))
+	(bvec_to_phys(__BVEC_END((bio)) + (bio)->bi_size) ==bio_to_phys((nxt)))
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
 #define BIO_SEG_BOUNDARY(q, b1, b2) \
-	__BIO_SEG_BOUNDARY(bvec_to_phys(bio_iovec_idx((b1), (b1)->bi_cnt - 1)), bio_to_phys((b2)) + bio_size((b2)), (q)->seg_boundary_mask)
+	__BIO_SEG_BOUNDARY(bvec_to_phys(__BVEC_END((b1))), bio_to_phys((b2)) + (b2)->bi_size, (q)->seg_boundary_mask)
 
 typedef int (bio_end_io_t) (struct bio *, int);
 typedef void (bio_destructor_t) (struct bio *);
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.5.1-pre3/include/linux/blkdev.h	Thu Nov 29 06:07:22 2001
+++ linux/include/linux/blkdev.h	Thu Nov 29 05:49:48 2001
@@ -177,14 +177,11 @@
 
 #ifdef CONFIG_HIGHMEM
 
-extern void create_bounce(struct bio **bio_orig, int gfp_mask);
+extern void create_bounce(unsigned long pfn, struct bio **bio_orig, int gfp_mask);
 
 extern inline void blk_queue_bounce(request_queue_t *q, struct bio **bio)
 {
-	struct page *page = bio_page(*bio);
-
-	if ((page - page->zone->zone_mem_map) + (page->zone->zone_start_paddr >> PAGE_SHIFT) < q->bounce_pfn)
-		create_bounce(bio, q->bounce_gfp);
+	create_bounce(q->bounce_pfn, bio, q->bounce_gfp);
 }
 
 #else /* CONFIG_HIGHMEM */
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/include/linux/highmem.h linux/include/linux/highmem.h
--- /opt/kernel/linux-2.5.1-pre3/include/linux/highmem.h	Thu Nov 29 06:07:22 2001
+++ linux/include/linux/highmem.h	Thu Nov 29 05:49:34 2001
@@ -13,7 +13,7 @@
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 
-extern void create_bounce(struct bio **bio_orig, int gfp_mask);
+extern void create_bounce(unsigned long pfn, struct bio **bio_orig, int gfp_mask);
 
 static inline char *bh_kmap(struct buffer_head *bh)
 {
diff -ur -X exclude /opt/kernel/linux-2.5.1-pre3/mm/highmem.c linux/mm/highmem.c
--- /opt/kernel/linux-2.5.1-pre3/mm/highmem.c	Thu Nov 29 06:07:22 2001
+++ linux/mm/highmem.c	Thu Nov 29 06:02:04 2001
@@ -207,35 +207,31 @@
  * queue gfp mask set, *to may or may not be a highmem page. kmap it
  * always, it will do the Right Thing
  */
-static inline void copy_from_high_bio(struct bio *to, struct bio *from)
+static inline void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 {
 	unsigned char *vto, *vfrom;
+	unsigned long flags;
+	struct bio_vec *tovec, *fromvec;
+	int i;
 
-	if (unlikely(in_interrupt()))
-		BUG();
-
-	vto = bio_kmap(to);
-	vfrom = bio_kmap(from);
-
-	memcpy(vto, vfrom + bio_offset(from), bio_size(to));
+	bio_for_each_segment(tovec, to, i) {
+		fromvec = &from->bi_io_vec[i];
 
-	bio_kunmap(from);
-	bio_kunmap(to);
-}
+		/*
+		 * not bounced
+		 */
+		if (tovec->bv_page == fromvec->bv_page)
+			continue;
 
-static inline void copy_to_high_bio_irq(struct bio *to, struct bio *from)
-{
-	unsigned char *vto, *vfrom;
-	unsigned long flags;
+		vfrom = page_address(fromvec->bv_page) + fromvec->bv_offset;
 
-	__save_flags(flags);
-	__cli();
-	vto = kmap_atomic(bio_page(to), KM_BOUNCE_READ);
-	vfrom = kmap_atomic(bio_page(from), KM_BOUNCE_READ);
-	memcpy(vto + bio_offset(to), vfrom, bio_size(to));
-	kunmap_atomic(vfrom, KM_BOUNCE_READ);
-	kunmap_atomic(vto, KM_BOUNCE_READ);
-	__restore_flags(flags);
+		__save_flags(flags);
+		__cli();
+		vto = kmap_atomic(tovec->bv_page, KM_BOUNCE_READ);
+		memcpy(vto + tovec->bv_offset, vfrom, to->bi_size);
+		kunmap_atomic(vto, KM_BOUNCE_READ);
+		__restore_flags(flags);
+	}
 }
 
 static __init int init_emergency_pool(void)
@@ -347,15 +343,64 @@
 	goto repeat_alloc;
 }
 
-void create_bounce(struct bio **bio_orig, int gfp_mask)
+void create_bounce(unsigned long pfn, struct bio **bio_orig, int gfp_mask)
 {
 	struct page *page;
-	struct bio *bio;
+	struct bio *bio = NULL;
 	int i, rw = bio_data_dir(*bio_orig);
+	struct bio_vec *to, *from;
 
 	BUG_ON((*bio_orig)->bi_idx);
 
-	bio = bio_alloc(GFP_NOHIGHIO, (*bio_orig)->bi_vcnt);
+	bio_for_each_segment(from, *bio_orig, i) {
+		page = from->bv_page;
+
+		/*
+		 * is destination page below bounce pfn?
+		 */
+		if ((page - page->zone->zone_mem_map) + (page->zone->zone_start_paddr >> PAGE_SHIFT) < pfn)
+			continue;
+
+		/*
+		 * irk, bounce it
+		 */
+		if (!bio)
+			bio = bio_alloc(GFP_NOHIGHIO, (*bio_orig)->bi_vcnt);
+
+		to = &bio->bi_io_vec[i];
+
+		to->bv_page = alloc_bounce_page(gfp_mask);
+		to->bv_len = from->bv_len;
+		to->bv_offset = from->bv_offset;
+
+		if (rw & WRITE) {
+			char *vto, *vfrom;
+
+			vto = page_address(to->bv_page) + to->bv_offset;
+			vfrom = kmap(from->bv_page);
+			memcpy(vto, vfrom + from->bv_offset, to->bv_len);
+			kunmap(to->bv_page);
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
+	bio_for_each_segment(from, *bio_orig, i) {
+		to = &bio->bi_io_vec[i];
+		if (!to->bv_page) {
+			to->bv_page = from->bv_page;
+			to->bv_len = from->bv_len;
+			to->bv_offset = to->bv_offset;
+		}
+	}
 
 	bio->bi_dev = (*bio_orig)->bi_dev;
 	bio->bi_sector = (*bio_orig)->bi_sector;
@@ -369,23 +414,6 @@
 		bio->bi_end_io = bounce_end_io_write;
 	else
 		bio->bi_end_io = bounce_end_io_read;
-
-	for (i = 0; i < bio->bi_vcnt; i++) {
-		char *vto, *vfrom;
-
-		page = alloc_bounce_page(gfp_mask);
-
-		bio->bi_io_vec[i].bv_page = page;
-		bio->bi_io_vec[i].bv_len = (*bio_orig)->bi_io_vec[i].bv_len;
-		bio->bi_io_vec[i].bv_offset = 0;
-
-		if (rw & WRITE) {
-			vto = page_address(page);
-			vfrom = __bio_kmap(*bio_orig, i);
-			memcpy(vto, vfrom + __bio_offset(*bio_orig, i), bio->bi_io_vec[i].bv_len);
-			__bio_kunmap(bio, i);
-		}
-	}
 
 	bio->bi_private = *bio_orig;
 	*bio_orig = bio;

-- 
Jens Axboe

