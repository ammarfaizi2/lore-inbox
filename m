Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVC2Cij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVC2Cij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVC2Cij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:38:39 -0500
Received: from fmr21.intel.com ([143.183.121.13]:63645 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262156AbVC2Cia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:38:30 -0500
Message-Id: <200503290238.j2T2cQg25626@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] optimization: defer bio_vec deallocation
Date: Mon, 28 Mar 2005 18:38:23 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0CGCIZh/1UJxvQIK/Y2I7eHP29w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel needs at least one bio and one bio_vec structure to process one I/O.
For every I/O, kernel also does two pairs of mempool_alloc/free, one for
bio and one for bio_vec.  It is not exactly cheap in setup/tear down bio_vec
structure.  bio_alloc_bs() does more things in that function other than the
minimally required mempool_alloc().

One optimization we are proposing is to defer the deallocation of bio_vec
at the next bio allocation.  Let bio hang on to the bio_vec for the last
bio_put.  And at next bio alloc time, check whether it has the same iovec
requirement.  If it is, bingo! bio already has it.  If not, then we free
previous iovec and allocate a new one.  So in steady state, When I/O size
does not change much, we benefit from the deferred free, saving one pair
of alloc/free.  If I/O request has random size or in dynamic state, then
we fall back and do the normal two pairs of alloc/free.  We have measured
that the following patch give measurable performance gain for industry
standard db benchmark.  Comments?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.12-rc1/fs/bio.c.orig	2005-03-28 13:49:37.000000000 -0800
+++ linux-2.6.12-rc1/fs/bio.c	2005-03-28 15:59:57.000000000 -0800
@@ -109,19 +109,15 @@ static inline struct bio_vec *bvec_alloc
  */
 static void bio_destructor(struct bio *bio)
 {
-	const int pool_idx = BIO_POOL_IDX(bio);
 	struct bio_set *bs = bio->bi_set;
-
-	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
-
-	mempool_free(bio->bi_io_vec, bs->bvec_pools[pool_idx]);
 	mempool_free(bio, bs->bio_pool);
 }

 inline void bio_init(struct bio *bio)
 {
 	bio->bi_next = NULL;
-	bio->bi_flags = 1 << BIO_UPTODATE;
+	bio->bi_flags &= ~(BIO_POOL_MASK - 1);
+	bio->bi_flags |= 1 << BIO_UPTODATE;
 	bio->bi_rw = 0;
 	bio->bi_vcnt = 0;
 	bio->bi_idx = 0;
@@ -130,7 +126,6 @@ inline void bio_init(struct bio *bio)
 	bio->bi_hw_front_size = 0;
 	bio->bi_hw_back_size = 0;
 	bio->bi_size = 0;
-	bio->bi_max_vecs = 0;
 	bio->bi_end_io = NULL;
 	atomic_set(&bio->bi_cnt, 1);
 	bio->bi_private = NULL;
@@ -158,20 +153,37 @@ struct bio *bio_alloc_bioset(int gfp_mas

 		bio_init(bio);
 		if (likely(nr_iovecs)) {
-			unsigned long idx;
-
-			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
-			if (unlikely(!bvl)) {
-				mempool_free(bio, bs->bio_pool);
-				bio = NULL;
-				goto out;
+			if (unlikely(nr_iovecs != bio->bi_max_vecs)) {
+				unsigned long idx;
+				if (bio->bi_max_vecs) {
+					struct bio_set *_bs = bio->bi_set;
+					idx = BIO_POOL_IDX(bio);
+					mempool_free(bio->bi_io_vec, _bs->bvec_pools[idx]);
+					bio->bi_max_vecs = 0;
+					bio->bi_flags &= BIO_POOL_MASK - 1;
+				}
+				bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
+				if (unlikely(!bvl)) {
+					mempool_free(bio, bs->bio_pool);
+					bio = NULL;
+					goto out;
+				}
+				bio->bi_flags |= idx << BIO_POOL_OFFSET;
+				bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
+				bio->bi_io_vec = bvl;
+				bio->bi_set = bs;
+			}
+		} else {
+			/* a zero io_vec allocation, need to free io_vec */
+			if (bio->bi_max_vecs) {
+				unsigned long idx = BIO_POOL_IDX(bio);
+				struct bio_set *_bs = bio->bi_set;
+				mempool_free(bio->bi_io_vec, _bs->bvec_pools[idx]);
+				bio->bi_io_vec = NULL;
+				bio->bi_max_vecs = 0;
+				bio->bi_set = bs;
 			}
-			bio->bi_flags |= idx << BIO_POOL_OFFSET;
-			bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
 		}
-		bio->bi_io_vec = bvl;
-		bio->bi_destructor = bio_destructor;
-		bio->bi_set = bs;
 	}
 out:
 	return bio;
@@ -1013,6 +1025,24 @@ bad:
 	return NULL;
 }

+static void bio_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct bio * bio = (struct bio*) p;
+	memset(bio, 0, sizeof(*bio));
+	bio->bi_destructor = bio_destructor;
+}
+
+static void bio_dtor(void *p, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct bio * bio = (struct bio*) p;
+
+	if (bio->bi_max_vecs) {
+		unsigned long idx = BIO_POOL_IDX(bio);
+		struct bio_set *bs = bio->bi_set;
+		mempool_free(bio->bi_io_vec, bs->bvec_pools[idx]);
+	}
+}
+
 static void __init biovec_init_slabs(void)
 {
 	int i;
@@ -1033,7 +1063,8 @@ static int __init init_bio(void)
 	int scale = BIOVEC_NR_POOLS;

 	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
-				SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+				SLAB_HWCACHE_ALIGN|SLAB_PANIC,
+				bio_ctor, bio_dtor);

 	biovec_init_slabs();




