Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937171AbWLDT23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937171AbWLDT23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759157AbWLDT23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:28:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:17688 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759310AbWLDT22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:28:28 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="170050003:sNHT49528066"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <jens.axboe@oracle.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch] speed up single bio_vec allocation
Date: Mon, 4 Dec 2006 11:27:32 -0800
Message-ID: <000301c717da$3ecf4970$2589030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccX2j5+fBLikAGjQCqkOdjveIWCiw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit arch like x86_64, struct bio is 104 byte.  Since bio slab is
created with SLAB_HWCACHE_ALIGN flag, there are usually spare memory
available at the end of bio.  I think we can utilize that memory for
bio_vec allocation.  The purpose is not so much on saving memory consumption
for bio_vec, instead, I'm attempting to optimize away a call to bvec_alloc_bs.

So here is a patch to do just that for 1 segment bio_vec (we currently only
have space for 1 on 2.6.19).  And the detection whether there are spare space
available is dynamically calculated at compile time.  If there are no space
available, there will be no run time cost at all because gcc simply optimize
away all the code added in this patch.  If there are space available, the only
run time check is to see what the size of iovec is and we do appropriate
assignment to bio->bi_io_Vec etc.  The cost is minimal and we gain a whole
lot back from not calling bvec_alloc_bs() function.

I tried to use cache_line_size() to find out the alignment of struct bio, but
stumbled on that it is a runtime function for x86_64. So instead I made bio
to hint to the slab allocator to align on 32 byte (slab will use the larger
value of hw cache line and caller hints of "align").  I think it is a sane
number for majority of the CPUs out in the world.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./fs/bio.c.orig	2006-12-03 17:20:36.000000000 -0800
+++ ./fs/bio.c	2006-12-03 21:29:20.000000000 -0800
@@ -29,11 +29,14 @@
 #include <scsi/sg.h>		/* for struct sg_iovec */
 
 #define BIO_POOL_SIZE 256
-
+#define BIO_ALIGN 32		/* minimal bio structure alignment */
 static kmem_cache_t *bio_slab __read_mostly;
 
 #define BIOVEC_NR_POOLS 6
 
+#define BIOVEC_FIT_INSIDE_BIO_CACHE_LINE				\
+	(ALIGN(sizeof(struct bio), BIO_ALIGN) ==			\
+	 ALIGN(sizeof(struct bio) + sizeof(struct bio_vec), BIO_ALIGN))
 /*
  * a small number of entries is fine, not going to be performance critical.
  * basically we just need to survive
@@ -113,7 +116,8 @@ void bio_free(struct bio *bio, struct bi
 
 	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
 
-	mempool_free(bio->bi_io_vec, bio_set->bvec_pools[pool_idx]);
+	if (!BIOVEC_FIT_INSIDE_BIO_CACHE_LINE || pool_idx)
+		mempool_free(bio->bi_io_vec, bio_set->bvec_pools[pool_idx]);
 	mempool_free(bio, bio_set->bio_pool);
 }
 
@@ -166,7 +170,15 @@ struct bio *bio_alloc_bioset(gfp_t gfp_m
 		struct bio_vec *bvl = NULL;
 
 		bio_init(bio);
-		if (likely(nr_iovecs)) {
+
+		/*
+		 * if bio_vec can fit into remaining cache line of struct
+		 * bio, go ahead use it and skip mempool allocation.
+		 */
+		if (nr_iovecs == 1 && BIOVEC_FIT_INSIDE_BIO_CACHE_LINE) {
+			bvl = (struct bio_vec*) (bio + 1);
+			bio->bi_max_vecs = 1;
+		} else if (likely(nr_iovecs)) {
 			unsigned long idx = 0; /* shut up gcc */
 
 			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
@@ -1204,7 +1216,7 @@ static void __init biovec_init_slabs(voi
 		struct biovec_slab *bvs = bvec_slabs + i;
 
 		size = bvs->nr_vecs * sizeof(struct bio_vec);
-		bvs->slab = kmem_cache_create(bvs->name, size, 0,
+		bvs->slab = kmem_cache_create(bvs->name, size, BIO_ALIGN,
                                 SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 	}
 }
