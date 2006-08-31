Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWHaVU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWHaVU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHaVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:20:25 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:3204 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932368AbWHaVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:20:25 -0400
Date: Thu, 31 Aug 2006 23:20:23 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] fs/bio.c: tweaks
Message-ID: <20060831212023.GA13918@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate a variable in bvec_alloc_bs() only once needed, not earlier
(bio.o down from 18408 to 18376 Bytes, 32 Bytes saved, probably due to
data locality improvements).
Init variable idx to silence a gcc warning which already existed in the
unmodified original base file (bvec_alloc_bs() handles idx
correctly, so there's no need for the warning):
fs/bio.c: In function `bio_alloc_bioset':
fs/bio.c:169: warning: `idx' may be used uninitialized in this function
Inline bio_set_map_data() since it's only called once.

Compile-tested and run-tested on 2.6.18-rc4-mm3.


Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.18-rc4-mm3.orig/fs/bio.c	2006-09-04 23:38:46.000000000 +0200
+++ linux-2.6.18-rc4-mm3/fs/bio.c	2006-09-08 22:07:54.000000000 +0200
@@ -79,7 +79,6 @@
 static inline struct bio_vec *bvec_alloc_bs(gfp_t gfp_mask, int nr, unsigned long *idx, struct bio_set *bs)
 {
 	struct bio_vec *bvl;
-	struct biovec_slab *bp;
 
 	/*
 	 * see comment near bvec_array define!
@@ -98,10 +97,12 @@
 	 * idx now points to the pool we want to allocate from
 	 */
 
-	bp = bvec_slabs + *idx;
 	bvl = mempool_alloc(bs->bvec_pools[*idx], gfp_mask);
-	if (bvl)
+	if (bvl) {
+		struct biovec_slab *bp = bvec_slabs + *idx;
+
 		memset(bvl, 0, bp->nr_vecs * sizeof(struct bio_vec));
+	}
 
 	return bvl;
 }
@@ -166,7 +167,7 @@
 
 		bio_init(bio);
 		if (likely(nr_iovecs)) {
-			unsigned long idx;
+			unsigned long idx = 0; /* shut up gcc */
 
 			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
 			if (unlikely(!bvl)) {
@@ -455,7 +456,7 @@
 	void __user *userptr;
 };
 
-static void bio_set_map_data(struct bio_map_data *bmd, struct bio *bio)
+static inline void bio_set_map_data(struct bio_map_data *bmd, struct bio *bio)
 {
 	memcpy(bmd->iovecs, bio->bi_io_vec, sizeof(struct bio_vec) * bio->bi_vcnt);
 	bio->bi_private = bmd;
