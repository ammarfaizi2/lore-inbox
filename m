Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTFJPQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTFJPQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:16:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50682 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263023AbTFJPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:15:55 -0400
Date: Tue, 10 Jun 2003 16:31:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 3/9 loop bio renaming
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101631170.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now it's in loop not bio, better rename bio_copy to loop_copy_bio: loop
prefers names that way; and bio_transfer better named loop_transfer_bio.
Rename bio,b to rbh,bio to follow call from loop_get_buffer more easily.

--- loop2/drivers/block/loop.c	Mon Jun  9 10:32:06 2003
+++ loop3/drivers/block/loop.c	Mon Jun  9 10:39:45 2003
@@ -439,21 +439,22 @@
 	return 0;
 }
 
-static struct bio *bio_copy(struct bio *bio, int gfp_mask, int copy)
+static struct bio *loop_copy_bio(struct bio *rbh, int gfp_mask, int copy)
 {
-	struct bio *b = bio_alloc(gfp_mask, bio->bi_vcnt);
+	struct bio *bio;
 	unsigned long flags = 0; /* gcc silly */
 	struct bio_vec *bv;
 	int i;
 
-	if (unlikely(!b))
+	bio = bio_alloc(gfp_mask, rbh->bi_vcnt);
+	if (!bio)
 		return NULL;
 
 	/*
 	 * iterate iovec list and alloc pages + copy data
 	 */
-	__bio_for_each_segment(bv, bio, i, 0) {
-		struct bio_vec *bbv = &b->bi_io_vec[i];
+	__bio_for_each_segment(bv, rbh, i, 0) {
+		struct bio_vec *bbv = &bio->bi_io_vec[i];
 		char *vfrom, *vto;
 
 		bbv->bv_page = alloc_page(gfp_mask);
@@ -490,18 +491,18 @@
 		}
 	}
 
-	b->bi_sector = bio->bi_sector;
-	b->bi_bdev = bio->bi_bdev;
-	b->bi_rw = bio->bi_rw;
+	bio->bi_sector = rbh->bi_sector;
+	bio->bi_bdev = rbh->bi_bdev;
+	bio->bi_rw = rbh->bi_rw;
 
-	b->bi_vcnt = bio->bi_vcnt;
-	b->bi_size = bio->bi_size;
+	bio->bi_vcnt = rbh->bi_vcnt;
+	bio->bi_size = rbh->bi_size;
 
-	return b;
+	return bio;
 
 oom:
 	while (--i >= 0)
-		__free_page(b->bi_io_vec[i].bv_page);
+		__free_page(bio->bi_io_vec[i].bv_page);
 
 	bio_put(bio);
 	return NULL;
@@ -529,7 +530,8 @@
 		int flags = current->flags;
 
 		current->flags &= ~PF_MEMALLOC;
-		bio = bio_copy(rbh, (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_NOWARN,
+		bio = loop_copy_bio(rbh,
+				    (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_NOWARN,
 					rbh->bi_rw & WRITE);
 		current->flags = flags;
 		if (bio == NULL)
@@ -547,9 +549,8 @@
 	return bio;
 }
 
-static int
-bio_transfer(struct loop_device *lo, struct bio *to_bio,
-			      struct bio *from_bio)
+static int loop_transfer_bio(struct loop_device *lo,
+			     struct bio *to_bio, struct bio *from_bio)
 {
 	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
 	struct bio_vec *from_bvec, *to_bvec;
@@ -614,7 +615,7 @@
 	new_bio = loop_get_buffer(lo, old_bio);
 	IV = loop_get_iv(lo, old_bio->bi_sector);
 	if (rw == WRITE) {
-		if (bio_transfer(lo, new_bio, old_bio))
+		if (loop_transfer_bio(lo, new_bio, old_bio))
 			goto err;
 	}
 
@@ -646,7 +647,7 @@
 	} else {
 		struct bio *rbh = bio->bi_private;
 
-		ret = bio_transfer(lo, bio, rbh);
+		ret = loop_transfer_bio(lo, bio, rbh);
 
 		bio_endio(rbh, rbh->bi_size, ret);
 		loop_put_buffer(bio);

