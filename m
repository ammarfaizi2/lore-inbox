Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVANMas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVANMas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVANMad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:30:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33934 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261969AbVANMaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:30:10 -0500
Date: Fri, 14 Jan 2005 13:30:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] bio clone memory corruption
Message-ID: <20050114123008.GA2749@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Doing some raid testing threw a bug in the scsi mid layer, because the
segment counts wasn't correct. Initially I worried that we still had
problems in this area, but it turns out that is due to the raid usage of
bio clones. Currently you have to hold on to the original bio as well,
since the clone only maintains a pointer to the bio_vec inside the
original bio. If the original bio is freed first, the clone will have
garbage in its bio->bi_io_vec as soon as that memory is scribbled.

I think the best fix is to maintain flexibility and duplicate the io_vec
inside the clone as well. Attached patch does this. Comments?

Signed-off-by: Jens Axboe <axboe@suse.de>

--- 1.71/fs/bio.c	2005-01-08 06:44:32 +01:00
+++ edited/fs/bio.c	2005-01-14 09:09:45 +01:00
@@ -98,12 +98,7 @@ static void bio_destructor(struct bio *b
 
 	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
 
-	/*
-	 * cloned bio doesn't own the veclist
-	 */
-	if (!bio_flagged(bio, BIO_CLONED))
-		mempool_free(bio->bi_io_vec, bp->pool);
-
+	mempool_free(bio->bi_io_vec, bp->pool);
 	mempool_free(bio, bio_pool);
 }
 
@@ -210,7 +205,9 @@ inline int bio_hw_segments(request_queue
  */
 inline void __bio_clone(struct bio *bio, struct bio *bio_src)
 {
-	bio->bi_io_vec = bio_src->bi_io_vec;
+	request_queue_t *q = bdev_get_queue(bio_src->bi_bdev);
+
+	memcpy(bio->bi_io_vec, bio_src->bi_io_vec, bio_src->bi_max_vecs * sizeof(struct bio_vec));
 
 	bio->bi_sector = bio_src->bi_sector;
 	bio->bi_bdev = bio_src->bi_bdev;
@@ -222,21 +219,9 @@ inline void __bio_clone(struct bio *bio,
 	 * for the clone
 	 */
 	bio->bi_vcnt = bio_src->bi_vcnt;
-	bio->bi_idx = bio_src->bi_idx;
-	if (bio_flagged(bio, BIO_SEG_VALID)) {
-		bio->bi_phys_segments = bio_src->bi_phys_segments;
-		bio->bi_hw_segments = bio_src->bi_hw_segments;
-		bio->bi_flags |= (1 << BIO_SEG_VALID);
-	}
 	bio->bi_size = bio_src->bi_size;
-
-	/*
-	 * cloned bio does not own the bio_vec, so users cannot fiddle with
-	 * it. clear bi_max_vecs and clear the BIO_POOL_BITS to make this
-	 * apparent
-	 */
-	bio->bi_max_vecs = 0;
-	bio->bi_flags &= (BIO_POOL_MASK - 1);
+	bio_phys_segments(q, bio);
+	bio_hw_segments(q, bio);
 }
 
 /**
@@ -248,7 +233,7 @@ inline void __bio_clone(struct bio *bio,
  */
 struct bio *bio_clone(struct bio *bio, int gfp_mask)
 {
-	struct bio *b = bio_alloc(gfp_mask, 0);
+	struct bio *b = bio_alloc(gfp_mask, bio->bi_max_vecs);
 
 	if (b)
 		__bio_clone(b, bio);


-- 
Jens Axboe

