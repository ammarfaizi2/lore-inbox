Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTFJPRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFJPRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:17:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21514 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263131AbTFJPQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:16:50 -0400
Date: Tue, 10 Jun 2003 16:32:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 4/9 copy bio not data
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101632060.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove copy flag and code from loop_copy_bio: wasn't used when reading,
and waste of time when writing - the loop transfer function does that.
And don't initialize bio fields immediately reinitialized by caller.

--- loop3/drivers/block/loop.c	Mon Jun  9 10:39:45 2003
+++ loop4/drivers/block/loop.c	Mon Jun  9 10:44:49 2003
@@ -439,10 +439,9 @@
 	return 0;
 }
 
-static struct bio *loop_copy_bio(struct bio *rbh, int gfp_mask, int copy)
+static struct bio *loop_copy_bio(struct bio *rbh, int gfp_mask)
 {
 	struct bio *bio;
-	unsigned long flags = 0; /* gcc silly */
 	struct bio_vec *bv;
 	int i;
 
@@ -451,11 +450,10 @@
 		return NULL;
 
 	/*
-	 * iterate iovec list and alloc pages + copy data
+	 * iterate iovec list and alloc pages
 	 */
 	__bio_for_each_segment(bv, rbh, i, 0) {
 		struct bio_vec *bbv = &bio->bi_io_vec[i];
-		char *vfrom, *vto;
 
 		bbv->bv_page = alloc_page(gfp_mask);
 		if (bbv->bv_page == NULL)
@@ -463,38 +461,8 @@
 
 		bbv->bv_len = bv->bv_len;
 		bbv->bv_offset = bv->bv_offset;
-
-		/*
-		 * if doing a copy for a READ request, no need
-		 * to memcpy page data
-		 */
-		if (!copy)
-			continue;
-
-		if (gfp_mask & __GFP_WAIT) {
-			vfrom = kmap(bv->bv_page);
-			vto = kmap(bbv->bv_page);
-		} else {
-			local_irq_save(flags);
-			vfrom = kmap_atomic(bv->bv_page, KM_BIO_SRC_IRQ);
-			vto = kmap_atomic(bbv->bv_page, KM_BIO_DST_IRQ);
-		}
-
-		memcpy(vto + bbv->bv_offset, vfrom + bv->bv_offset, bv->bv_len);
-		if (gfp_mask & __GFP_WAIT) {
-			kunmap(bbv->bv_page);
-			kunmap(bv->bv_page);
-		} else {
-			kunmap_atomic(vto, KM_BIO_DST_IRQ);
-			kunmap_atomic(vfrom, KM_BIO_SRC_IRQ);
-			local_irq_restore(flags);
-		}
 	}
 
-	bio->bi_sector = rbh->bi_sector;
-	bio->bi_bdev = rbh->bi_bdev;
-	bio->bi_rw = rbh->bi_rw;
-
 	bio->bi_vcnt = rbh->bi_vcnt;
 	bio->bi_size = rbh->bi_size;
 
@@ -531,8 +499,7 @@
 
 		current->flags &= ~PF_MEMALLOC;
 		bio = loop_copy_bio(rbh,
-				    (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_NOWARN,
-					rbh->bi_rw & WRITE);
+				    (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_NOWARN);
 		current->flags = flags;
 		if (bio == NULL)
 			blk_congestion_wait(WRITE, HZ/10);

