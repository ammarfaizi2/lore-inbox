Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRLLSsQ>; Wed, 12 Dec 2001 13:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLLSsI>; Wed, 12 Dec 2001 13:48:08 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:52677 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281609AbRLLSrz>; Wed, 12 Dec 2001 13:47:55 -0500
Date: Wed, 12 Dec 2001 13:47:54 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v2.5.1-pre10-01_kvec.diff
Message-ID: <20011212134754.H17550@redhat.com>
In-Reply-To: <20011211162639.F6878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211162639.F6878@redhat.com>; from bcrl@redhat.com on Tue, Dec 11, 2001 at 04:26:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

This patch follows on top of 00_kvec.diff to rename the bio_vec users to 
kveclets since nobody objected.  It still boots on my test box...

		-ben

... v2.5.1-pre10-01_kvec.diff ...

diff -urN 00_kvec-v2.5.1-pre10/drivers/block/ll_rw_blk.c 01_kvec-v2.5.1-pre10/drivers/block/ll_rw_blk.c
--- 00_kvec-v2.5.1-pre10/drivers/block/ll_rw_blk.c	Tue Dec 11 22:18:55 2001
+++ 01_kvec-v2.5.1-pre10/drivers/block/ll_rw_blk.c	Wed Dec 12 13:38:59 2001
@@ -318,7 +318,7 @@
 
 void blk_recount_segments(request_queue_t *q, struct bio *bio)
 {
-	struct bio_vec *bv, *bvprv = NULL;
+	struct kveclet *bv, *bvprv = NULL;
 	int i, nr_segs, seg_size, cluster;
 
 	if (unlikely(!bio->bi_io_vec))
@@ -328,14 +328,14 @@
 	seg_size = nr_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
 		if (bvprv && cluster) {
-			if (seg_size + bv->bv_len > q->max_segment_size)
+			if (seg_size + bv->length > q->max_segment_size)
 				goto new_segment;
 			if (!BIOVEC_MERGEABLE(bvprv, bv))
 				goto new_segment;
 			if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bv))
 				goto new_segment;
 
-			seg_size += bv->bv_len;
+			seg_size += bv->length;
 			bvprv = bv;
 			continue;
 		}
@@ -377,7 +377,7 @@
  */
 int blk_rq_map_sg(request_queue_t *q, struct request *rq, struct scatterlist *sg)
 {
-	struct bio_vec *bvec, *bvprv;
+	struct kveclet *bvec, *bvprv;
 	struct bio *bio;
 	int nsegs, i, cluster;
 
@@ -393,7 +393,7 @@
 		 * for each segment in bio
 		 */
 		bio_for_each_segment(bvec, bio, i) {
-			int nbytes = bvec->bv_len;
+			int nbytes = bvec->length;
 
 			if (bvprv && cluster) {
 				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
@@ -413,9 +413,9 @@
 				}
 
 				sg[nsegs].address = NULL;
-				sg[nsegs].page = bvec->bv_page;
+				sg[nsegs].page = bvec->page;
 				sg[nsegs].length = nbytes;
-				sg[nsegs].offset = bvec->bv_offset;
+				sg[nsegs].offset = bvec->offset;
 
 				nsegs++;
 			}
@@ -964,7 +964,7 @@
 
 	sector = bio->bi_sector;
 	nr_sectors = bio_sectors(bio);
-	cur_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+	cur_nr_sectors = bio_iovec(bio)->length >> 9;
 	rw = bio_data_dir(bio);
 
 	/*
@@ -1303,9 +1303,9 @@
 
 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_dev = bh->b_dev;
-	bio->bi_io_vec[0].bv_page = bh->b_page;
-	bio->bi_io_vec[0].bv_len = bh->b_size;
-	bio->bi_io_vec[0].bv_offset = bh_offset(bh);
+	bio->bi_io_vec[0].page = bh->b_page;
+	bio->bi_io_vec[0].length = bh->b_size;
+	bio->bi_io_vec[0].offset = bh_offset(bh);
 
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
@@ -1434,7 +1434,7 @@
 	rq->sector = rq->hard_sector;
 	rq->nr_sectors = rq->hard_nr_sectors;
 
-	rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
+	rq->current_nr_sectors = bio_iovec(rq->bio)->length >> 9;
 	rq->hard_cur_sectors = rq->current_nr_sectors;
 
 	/*
@@ -1476,9 +1476,9 @@
 
 	total_nsect = 0;
 	while ((bio = req->bio)) {
-		nsect = bio_iovec(bio)->bv_len >> 9;
+		nsect = bio_iovec(bio)->length >> 9;
 
-		BIO_BUG_ON(bio_iovec(bio)->bv_len > bio->bi_size);
+		BIO_BUG_ON(bio_iovec(bio)->length > bio->bi_size);
 
 		/*
 		 * not a complete bvec done
@@ -1487,8 +1487,8 @@
 			int residual = (nsect - nr_sectors) << 9;
 
 			bio->bi_size -= residual;
-			bio_iovec(bio)->bv_offset += residual;
-			bio_iovec(bio)->bv_len -= residual;
+			bio_iovec(bio)->offset += residual;
+			bio_iovec(bio)->length -= residual;
 			blk_recalc_request(req, nr_sectors);
 			return 1;
 		}
@@ -1496,7 +1496,7 @@
 		/*
 		 * account transfer
 		 */
-		bio->bi_size -= bio_iovec(bio)->bv_len;
+		bio->bi_size -= bio_iovec(bio)->length;
 		bio->bi_idx++;
 
 		nr_sectors -= nsect;
diff -urN 00_kvec-v2.5.1-pre10/drivers/block/loop.c 01_kvec-v2.5.1-pre10/drivers/block/loop.c
--- 00_kvec-v2.5.1-pre10/drivers/block/loop.c	Tue Dec 11 22:18:55 2001
+++ 01_kvec-v2.5.1-pre10/drivers/block/loop.c	Wed Dec 12 13:38:59 2001
@@ -335,7 +335,7 @@
 	if (bio && bio->bi_end_io == loop_end_io_transfer) {
 		int i;
 		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
+			__free_page(bio->bi_io_vec[i].page);
 
 		bio_put(bio);
 	}
@@ -496,15 +496,15 @@
 			      struct bio *rbh)
 {
 	unsigned long IV = loop_get_iv(lo, rbh->bi_sector);
-	struct bio_vec *to;
+	struct kveclet *to;
 	char *vto, *vfrom;
 	int ret = 0, i;
 
 	bio_for_each_segment(to, bio, i) {
-		vfrom = page_address(rbh->bi_io_vec[i].bv_page) + rbh->bi_io_vec[i].bv_offset;
-		vto = page_address(to->bv_page) + to->bv_offset;
+		vfrom = page_address(rbh->bi_io_vec[i].page) + rbh->bi_io_vec[i].offset;
+		vto = page_address(to->page) + to->offset;
 		ret |= lo_do_transfer(lo, bio_data_dir(bio), vto, vfrom,
-					to->bv_len, IV);
+					to->length, IV);
 	}
 
 	return ret;
diff -urN 00_kvec-v2.5.1-pre10/drivers/block/nbd.c 01_kvec-v2.5.1-pre10/drivers/block/nbd.c
--- 00_kvec-v2.5.1-pre10/drivers/block/nbd.c	Tue Dec 11 22:18:55 2001
+++ 01_kvec-v2.5.1-pre10/drivers/block/nbd.c	Wed Dec 12 13:38:59 2001
@@ -173,13 +173,13 @@
 		 * whether to set MSG_MORE or not...
 		 */
 		rq_for_each_bio(bio, req) {
-			struct bio_vec *bvec;
+			struct kveclet *bvec;
 			bio_for_each_segment(bvec, bio, i) {
 				flags = 0;
 				if ((i < (bio->bi_vcnt - 1)) || bio->bi_next)
 					flags = MSG_MORE;
 				DEBUG("data, ");
-				result = nbd_xmit(1, sock, page_address(bvec->bv_page) + bvec->bv_offset, bvec->bv_len, flags);
+				result = nbd_xmit(1, sock, page_address(bvec->page) + bvec->offset, bvec->length, flags);
 				if (result <= 0)
 					FAIL("Send data failed.");
 			}
diff -urN 00_kvec-v2.5.1-pre10/drivers/block/rd.c 01_kvec-v2.5.1-pre10/drivers/block/rd.c
--- 00_kvec-v2.5.1-pre10/drivers/block/rd.c	Tue Dec 11 22:18:55 2001
+++ 01_kvec-v2.5.1-pre10/drivers/block/rd.c	Wed Dec 12 13:38:59 2001
@@ -228,7 +228,7 @@
 	commit_write: ramdisk_commit_write,
 };
 
-static int rd_blkdev_pagecache_IO(int rw, struct bio_vec *vec,
+static int rd_blkdev_pagecache_IO(int rw, struct kveclet *vec,
 				  sector_t sector, int minor)
 {
 	struct address_space * mapping;
@@ -240,7 +240,7 @@
 
 	index = sector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sector << 9) & ~PAGE_CACHE_MASK;
-	size = vec->bv_len;
+	size = vec->length;
 
 	do {
 		int count;
@@ -277,18 +277,18 @@
 		if (rw == READ) {
 			src = kmap(page);
 			src += offset;
-			dst = kmap(vec->bv_page) + vec->bv_offset;
+			dst = kmap(vec->page) + vec->offset;
 		} else {
 			dst = kmap(page);
 			dst += offset;
-			src = kmap(vec->bv_page) + vec->bv_offset;
+			src = kmap(vec->page) + vec->offset;
 		}
 		offset = 0;
 
 		memcpy(dst, src, count);
 
 		kunmap(page);
-		kunmap(vec->bv_page);
+		kunmap(vec->page);
 
 		if (rw == READ) {
 			flush_dcache_page(page);
@@ -306,7 +306,7 @@
 
 static int rd_blkdev_bio_IO(struct bio *bio, unsigned int minor)
 {
-	struct bio_vec *bvec;
+	struct kveclet *bvec;
 	sector_t sector;
 	int ret = 0, i, rw;
 
@@ -314,7 +314,7 @@
 	rw = bio_data_dir(bio);
 	bio_for_each_segment(bvec, bio, i) {
 		ret |= rd_blkdev_pagecache_IO(rw, bvec, sector, minor);
-		sector += bvec->bv_len >> 9;
+		sector += bvec->length >> 9;
 	}
 
 	return ret;
diff -urN 00_kvec-v2.5.1-pre10/drivers/md/lvm.c 01_kvec-v2.5.1-pre10/drivers/md/lvm.c
--- 00_kvec-v2.5.1-pre10/drivers/md/lvm.c	Tue Dec 11 22:18:55 2001
+++ 01_kvec-v2.5.1-pre10/drivers/md/lvm.c	Wed Dec 12 13:38:59 2001
@@ -1,5 +1,5 @@
 /*
- * kernel/lvm.c
+ * linux/drivers/md/lvm.c
  *
  * Copyright (C) 1997 - 2000  Heinz Mauelshagen, Sistina Software
  *
@@ -1043,7 +1043,7 @@
 
 	memset(&bio,0,sizeof(bio));
 	bio.bi_dev = inode->i_rdev;
-	bio.bi_io_vec.bv_len = lvm_get_blksize(bio.bi_dev);
+	bio.bi_io_vec.length = lvm_get_blksize(bio.bi_dev);
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {
diff -urN 00_kvec-v2.5.1-pre10/drivers/scsi/ide-scsi.c 01_kvec-v2.5.1-pre10/drivers/scsi/ide-scsi.c
--- 00_kvec-v2.5.1-pre10/drivers/scsi/ide-scsi.c	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/drivers/scsi/ide-scsi.c	Wed Dec 12 13:38:59 2001
@@ -718,9 +718,9 @@
 				offset = (unsigned long) sg->address & ~PAGE_MASK;
 			}
 				
-			bh->bi_io_vec[0].bv_page = page;
-			bh->bi_io_vec[0].bv_len = sg->length;
-			bh->bi_io_vec[0].bv_offset = offset;
+			bh->bi_io_vec[0].page = page;
+			bh->bi_io_vec[0].length = sg->length;
+			bh->bi_io_vec[0].offset = offset;
 			bh->bi_size = sg->length;
 			bh = bh->bi_next;
 			/*
@@ -736,9 +736,9 @@
 #if IDESCSI_DEBUG_LOG
 		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
-		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
-		bh->bi_io_vec[0].bv_len = pc->request_transfer;
-		bh->bi_io_vec[0].bv_offset = (unsigned long) pc->scsi_cmd->request_buffer & ~PAGE_MASK;
+		bh->bi_io_vec[0].page = virt_to_page(pc->scsi_cmd->request_buffer);
+		bh->bi_io_vec[0].length = pc->request_transfer;
+		bh->bi_io_vec[0].offset = (unsigned long) pc->scsi_cmd->request_buffer & ~PAGE_MASK;
 		bh->bi_size = pc->request_transfer;
 	}
 	return first_bh;
diff -urN 00_kvec-v2.5.1-pre10/drivers/scsi/scsi_merge.c 01_kvec-v2.5.1-pre10/drivers/scsi/scsi_merge.c
--- 00_kvec-v2.5.1-pre10/drivers/scsi/scsi_merge.c	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/drivers/scsi/scsi_merge.c	Wed Dec 12 13:38:59 2001
@@ -138,7 +138,7 @@
 	int reqsize = 0;
 	int i;
 	struct bio *bio;
-	struct bio_vec *bvec;
+	struct kveclet *bvec;
 
 	if (remainder)
 		reqsize = *remainder;
@@ -201,7 +201,7 @@
 #ifdef DMA_CHUNK_SIZE
 
 #define MERGEABLE_BUFFERS(X,Y) \
-	((((bvec_to_phys(__BVEC_END((X))) + __BVEC_END((X))->bv_len) | bio_to_phys((Y))) & (DMA_CHUNK_SIZE - 1)) == 0)
+	((((bvec_to_phys(__BVEC_END((X))) + __BVEC_END((X))->length) | bio_to_phys((Y))) & (DMA_CHUNK_SIZE - 1)) == 0)
 
 static inline int scsi_new_mergeable(request_queue_t * q,
 				     struct request * req,
diff -urN 00_kvec-v2.5.1-pre10/fs/bio.c 01_kvec-v2.5.1-pre10/fs/bio.c
--- 00_kvec-v2.5.1-pre10/fs/bio.c	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/fs/bio.c	Wed Dec 12 13:43:12 2001
@@ -58,10 +58,10 @@
 	kmem_cache_free(data, ptr);
 }
 
-static inline struct bio_vec *bvec_alloc(int gfp_mask, int nr, int *idx)
+static inline struct kveclet *bvec_alloc(int gfp_mask, int nr, int *idx)
 {
 	struct biovec_pool *bp;
-	struct bio_vec *bvl;
+	struct kveclet *bvl;
 
 	/*
 	 * see comment near bvec_pool_sizes define!
@@ -130,7 +130,7 @@
 struct bio *bio_alloc(int gfp_mask, int nr_iovecs)
 {
 	struct bio *bio = mempool_alloc(bio_pool, gfp_mask);
-	struct bio_vec *bvl = NULL;
+	struct kveclet *bvl = NULL;
 
 	if (unlikely(!bio))
 		return NULL;
@@ -237,7 +237,7 @@
 {
 	struct bio *b = bio_alloc(gfp_mask, bio->bi_vcnt);
 	unsigned long flags = 0; /* gcc silly */
-	struct bio_vec *bv;
+	struct kveclet *bv;
 	int i;
 
 	if (unlikely(!b))
@@ -247,15 +247,15 @@
 	 * iterate iovec list and alloc pages + copy data
 	 */
 	__bio_for_each_segment(bv, bio, i, 0) {
-		struct bio_vec *bbv = &b->bi_io_vec[i];
+		struct kveclet *bbv = &b->bi_io_vec[i];
 		char *vfrom, *vto;
 
-		bbv->bv_page = alloc_page(gfp_mask);
-		if (bbv->bv_page == NULL)
+		bbv->page = alloc_page(gfp_mask);
+		if (bbv->page == NULL)
 			goto oom;
 
-		bbv->bv_len = bv->bv_len;
-		bbv->bv_offset = bv->bv_offset;
+		bbv->length = bv->length;
+		bbv->offset = bv->offset;
 
 		/*
 		 * if doing a copy for a READ request, no need
@@ -265,18 +265,18 @@
 			continue;
 
 		if (gfp_mask & __GFP_WAIT) {
-			vfrom = kmap(bv->bv_page);
-			vto = kmap(bbv->bv_page);
+			vfrom = kmap(bv->page);
+			vto = kmap(bbv->page);
 		} else {
 			local_irq_save(flags);
-			vfrom = kmap_atomic(bv->bv_page, KM_BIO_IRQ);
-			vto = kmap_atomic(bbv->bv_page, KM_BIO_IRQ);
+			vfrom = kmap_atomic(bv->page, KM_BIO_IRQ);
+			vto = kmap_atomic(bbv->page, KM_BIO_IRQ);
 		}
 
-		memcpy(vto + bbv->bv_offset, vfrom + bv->bv_offset, bv->bv_len);
+		memcpy(vto + bbv->offset, vfrom + bv->offset, bv->length);
 		if (gfp_mask & __GFP_WAIT) {
-			kunmap(bbv->bv_page);
-			kunmap(bv->bv_page);
+			kunmap(bbv->page);
+			kunmap(bv->page);
 		} else {
 			kunmap_atomic(vto, KM_BIO_IRQ);
 			kunmap_atomic(vfrom, KM_BIO_IRQ);
@@ -295,7 +295,7 @@
 
 oom:
 	while (--i >= 0)
-		__free_page(b->bi_io_vec[i].bv_page);
+		__free_page(b->bi_io_vec[i].page);
 
 	mempool_free(b, bio_pool);
 	return NULL;
@@ -347,7 +347,7 @@
 void ll_rw_kio(int rw, struct kiobuf *kio, kdev_t dev, sector_t sector)
 {
 	int i, offset, size, err, map_i, total_nr_pages, nr_pages;
-	struct bio_vec *bvec;
+	struct kveclet *bvec;
 	struct bio *bio;
 
 	err = 0;
@@ -410,9 +410,9 @@
 		bio->bi_vcnt++;
 		bio->bi_size += nbytes;
 
-		bvec->bv_page = kio->maplist[map_i];
-		bvec->bv_len = nbytes;
-		bvec->bv_offset = offset;
+		bvec->page = kio->maplist[map_i];
+		bvec->length = nbytes;
+		bvec->offset = offset;
 
 		/*
 		 * kiobuf only has an offset into the first page
@@ -468,7 +468,7 @@
 	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
 		struct biovec_pool *bp = bvec_array + i;
 
-		size = bvec_pool_sizes[i] * sizeof(struct bio_vec);
+		size = bvec_pool_sizes[i] * sizeof(struct kveclet);
 
 		printk("biovec: init pool %d, %d entries, %d bytes\n", i,
 						bvec_pool_sizes[i], size);
diff -urN 00_kvec-v2.5.1-pre10/include/asm-i386/io.h 01_kvec-v2.5.1-pre10/include/asm-i386/io.h
--- 00_kvec-v2.5.1-pre10/include/asm-i386/io.h	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/include/asm-i386/io.h	Wed Dec 12 13:39:29 2001
@@ -109,7 +109,7 @@
  * constraints.
  */
 #define BIOVEC_MERGEABLE(vec1, vec2)	\
-	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
+	((bvec_to_phys((vec1)) + (vec1)->length) == bvec_to_phys((vec2)))
 
 /*
  * readX/writeX() are used to access memory mapped devices. On some
diff -urN 00_kvec-v2.5.1-pre10/include/asm-sparc64/io.h 01_kvec-v2.5.1-pre10/include/asm-sparc64/io.h
--- 00_kvec-v2.5.1-pre10/include/asm-sparc64/io.h	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/include/asm-sparc64/io.h	Wed Dec 12 13:38:59 2001
@@ -22,7 +22,7 @@
 #define page_to_phys(page)	((((page) - mem_map) << PAGE_SHIFT)+phys_base)
 
 #define BIOVEC_MERGEABLE(vec1, vec2)	\
-	((((bvec_to_phys((vec1)) + (vec1)->bv_len) | bvec_to_phys((vec2))) & (DMA_CHUNK_SIZE - 1)) == 0)
+	((((bvec_to_phys((vec1)) + (vec1)->length) | bvec_to_phys((vec2))) & (DMA_CHUNK_SIZE - 1)) == 0)
 
 /* Different PCI controllers we support have their PCI MEM space
  * mapped to an either 2GB (Psycho) or 4GB (Sabre) aligned area,
diff -urN 00_kvec-v2.5.1-pre10/include/linux/bio.h 01_kvec-v2.5.1-pre10/include/linux/bio.h
--- 00_kvec-v2.5.1-pre10/include/linux/bio.h	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/include/linux/bio.h	Wed Dec 12 13:39:26 2001
@@ -20,6 +20,10 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
+#ifndef __LINUX__KIOVEC_H
+#include <linux/kiovec.h>
+#endif
+
 #define BIO_DEBUG
 
 #ifdef BIO_DEBUG
@@ -31,15 +35,6 @@
 #define BIO_MAX_SECTORS	128
 
 /*
- * was unsigned short, but we might as well be ready for > 64kB I/O pages
- */
-struct bio_vec {
-	struct page	*bv_page;
-	unsigned int	bv_len;
-	unsigned int	bv_offset;
-};
-
-/*
  * weee, c forward decl...
  */
 struct bio;
@@ -59,14 +54,14 @@
 						 * top bits priority
 						 */
 
-	unsigned short		bi_vcnt;	/* how many bio_vec's */
+	unsigned short		bi_vcnt;	/* how many kveclet's */
 	unsigned short		bi_idx;		/* current index into bvl_vec */
 	unsigned short		bi_hw_seg;	/* actual mapped segments */
 	unsigned int		bi_size;	/* residual I/O count */
 	unsigned int		bi_max;		/* max bvl_vecs we can hold,
 						   used as index into pool */
 
-	struct bio_vec		*bi_io_vec;	/* the actual vec list */
+	struct kveclet		*bi_io_vec;	/* the actual vec list */
 
 	bio_end_io_t		*bi_end_io;
 	atomic_t		bi_cnt;		/* pin count */
@@ -102,8 +97,8 @@
  */
 #define bio_iovec_idx(bio, idx)	(&((bio)->bi_io_vec[(idx)]))
 #define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_idx)
-#define bio_page(bio)		bio_iovec((bio))->bv_page
-#define bio_offset(bio)		bio_iovec((bio))->bv_offset
+#define bio_page(bio)		bio_iovec((bio))->page
+#define bio_offset(bio)		bio_iovec((bio))->offset
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
 #define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_BARRIER))
@@ -112,7 +107,7 @@
  * will die
  */
 #define bio_to_phys(bio)	(page_to_phys(bio_page((bio))) + (unsigned long) bio_offset((bio)))
-#define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (unsigned long) (bv)->bv_offset)
+#define bvec_to_phys(bv)	(page_to_phys((bv)->page) + (unsigned long) (bv)->offset)
 
 /*
  * queues that have highmem support enabled may still need to revert to
@@ -120,9 +115,9 @@
  * permanent PIO fall back, user is probably better off disabling highmem
  * I/O completely on that queue (see ide-dma for example)
  */
-#define __bio_kmap(bio, idx) (kmap(bio_iovec_idx((bio), (idx))->bv_page) + bio_iovec_idx((bio), (idx))->bv_offset)
+#define __bio_kmap(bio, idx) (kmap(bio_iovec_idx((bio), (idx))->page) + bio_iovec_idx((bio), (idx))->offset)
 #define bio_kmap(bio)	__bio_kmap((bio), (bio)->bi_idx)
-#define __bio_kunmap(bio, idx)	kunmap(bio_iovec_idx((bio), (idx))->bv_page)
+#define __bio_kunmap(bio, idx)	kunmap(bio_iovec_idx((bio), (idx))->page)
 #define bio_kunmap(bio)		__bio_kunmap((bio), (bio)->bi_idx)
 
 /*
@@ -135,7 +130,7 @@
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
 #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
-	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, (q)->seg_boundary_mask)
+	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->length, (q)->seg_boundary_mask)
 #define BIO_SEG_BOUNDARY(q, b1, b2) \
 	BIOVEC_SEG_BOUNDARY((q), __BVEC_END((b1)), __BVEC_START((b2)))
 
diff -urN 00_kvec-v2.5.1-pre10/mm/highmem.c 01_kvec-v2.5.1-pre10/mm/highmem.c
--- 00_kvec-v2.5.1-pre10/mm/highmem.c	Tue Dec 11 22:18:56 2001
+++ 01_kvec-v2.5.1-pre10/mm/highmem.c	Wed Dec 12 13:40:48 2001
@@ -226,7 +226,7 @@
 {
 	unsigned char *vto, *vfrom;
 	unsigned long flags;
-	struct bio_vec *tovec, *fromvec;
+	struct kveclet *tovec, *fromvec;
 	int i;
 
 	__bio_for_each_segment(tovec, to, i, 0) {
@@ -235,14 +235,14 @@
 		/*
 		 * not bounced
 		 */
-		if (tovec->bv_page == fromvec->bv_page)
+		if (tovec->page == fromvec->page)
 			continue;
 
-		vfrom = page_address(fromvec->bv_page) + fromvec->bv_offset;
+		vfrom = page_address(fromvec->page) + fromvec->offset;
 
 		local_irq_save(flags);
-		vto = kmap_atomic(tovec->bv_page, KM_BOUNCE_READ);
-		memcpy(vto + tovec->bv_offset, vfrom, tovec->bv_len);
+		vto = kmap_atomic(tovec->page, KM_BOUNCE_READ);
+		memcpy(vto + tovec->offset, vfrom, tovec->length);
 		kunmap_atomic(vto, KM_BOUNCE_READ);
 		local_irq_restore(flags);
 	}
@@ -251,7 +251,7 @@
 static inline int bounce_end_io (struct bio *bio, int nr_sectors)
 {
 	struct bio *bio_orig = bio->bi_private;
-	struct bio_vec *bvec, *org_vec;
+	struct kveclet *bvec, *org_vec;
 	int ret, i;
 
 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
@@ -264,10 +264,10 @@
 	 */
 	__bio_for_each_segment(bvec, bio, i, 0) {
 		org_vec = &bio_orig->bi_io_vec[i];
-		if (bvec->bv_page == org_vec->bv_page)
+		if (bvec->page == org_vec->page)
 			continue;
 
-		mempool_free(bvec->bv_page, page_pool);	
+		mempool_free(bvec->page, page_pool);	
 	}
 
 out_eio:
@@ -297,12 +297,12 @@
 	struct page *page;
 	struct bio *bio = NULL;
 	int i, rw = bio_data_dir(*bio_orig);
-	struct bio_vec *to, *from;
+	struct kveclet *to, *from;
 
 	BUG_ON((*bio_orig)->bi_idx);
 
 	bio_for_each_segment(from, *bio_orig, i) {
-		page = from->bv_page;
+		page = from->page;
 
 		/*
 		 * is destination page below bounce pfn?
@@ -318,17 +318,17 @@
 
 		to = &bio->bi_io_vec[i];
 
-		to->bv_page = mempool_alloc(page_pool, GFP_NOHIGHIO);
-		to->bv_len = from->bv_len;
-		to->bv_offset = from->bv_offset;
+		to->page = mempool_alloc(page_pool, GFP_NOHIGHIO);
+		to->length = from->length;
+		to->offset = from->offset;
 
 		if (rw & WRITE) {
 			char *vto, *vfrom;
 
-			vto = page_address(to->bv_page) + to->bv_offset;
-			vfrom = kmap(from->bv_page) + from->bv_offset;
-			memcpy(vto, vfrom, to->bv_len);
-			kunmap(from->bv_page);
+			vto = page_address(to->page) + to->offset;
+			vfrom = kmap(from->page) + from->offset;
+			memcpy(vto, vfrom, to->length);
+			kunmap(from->page);
 		}
 	}
 
@@ -344,10 +344,10 @@
 	 */
 	bio_for_each_segment(from, *bio_orig, i) {
 		to = &bio->bi_io_vec[i];
-		if (!to->bv_page) {
-			to->bv_page = from->bv_page;
-			to->bv_len = from->bv_len;
-			to->bv_offset = to->bv_offset;
+		if (!to->page) {
+			to->page = from->page;
+			to->length = from->length;
+			to->offset = to->offset;
 		}
 	}
 
diff -urN 00_kvec-v2.5.1-pre10/mm/memory.c 01_kvec-v2.5.1-pre10/mm/memory.c
--- 00_kvec-v2.5.1-pre10/mm/memory.c	Wed Dec 12 13:17:06 2001
+++ 01_kvec-v2.5.1-pre10/mm/memory.c	Wed Dec 12 13:38:59 2001
@@ -1455,14 +1455,14 @@
 	int			i;
 	int			datain = (rw == READ);
 	unsigned		nr_pages;
+	const int		mask = PAGE_SIZE - 1;
 
 	end = ptr + len;
 	if (end < ptr)
 		return ERR_PTR(-EINVAL);
 
-	nr_pages = (ptr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	nr_pages -= ptr >> PAGE_SHIFT;
-	nr_pages ++;
+	nr_pages = ((ptr & mask) + len + mask) >> PAGE_SHIFT;
+	nr_pages ++;	/* Padding for NULL page */
 	vec = kmalloc(sizeof(struct kvec) + nr_pages * sizeof(struct kveclet),
 			GFP_KERNEL);
 	if (!vec)
