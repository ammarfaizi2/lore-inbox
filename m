Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTFJPVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFJPV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:21:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23915 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263084AbTFJPU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:20:59 -0400
Date: Tue, 10 Jun 2003 16:37:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 8/9 copy_bio use highmem
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101636070.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop_copy_bio uses one gfp_mask for bio_alloc and alloc_page calls.
The bio_alloc obviously can't use highmem, but the alloc_page can.
Yes, the underlying device might be unable to use highmem, and have
to use one of its bounce buffers, with an extra copy: so be it.

(Originally I did propagate the underlying device's bounce needs down to
the loop device, to avoid that possible extra copy; but let's keep this
simple, the low end doesn't have highmem and the high end can I/O it.)

--- loop7/drivers/block/loop.c	Tue Jun 10 11:40:23 2003
+++ loop8/drivers/block/loop.c	Tue Jun 10 11:55:11 2003
@@ -432,13 +432,13 @@
 	return 0;
 }
 
-static struct bio *loop_copy_bio(struct bio *rbh, int gfp_mask)
+static struct bio *loop_copy_bio(struct bio *rbh)
 {
 	struct bio *bio;
 	struct bio_vec *bv;
 	int i;
 
-	bio = bio_alloc(gfp_mask, rbh->bi_vcnt);
+	bio = bio_alloc(__GFP_NOWARN, rbh->bi_vcnt);
 	if (!bio)
 		return NULL;
 
@@ -448,7 +448,7 @@
 	__bio_for_each_segment(bv, rbh, i, 0) {
 		struct bio_vec *bbv = &bio->bi_io_vec[i];
 
-		bbv->bv_page = alloc_page(gfp_mask);
+		bbv->bv_page = alloc_page(__GFP_NOWARN|__GFP_HIGHMEM);
 		if (bbv->bv_page == NULL)
 			goto oom;
 
@@ -483,8 +483,7 @@
 		int flags = current->flags;
 
 		current->flags &= ~PF_MEMALLOC;
-		bio = loop_copy_bio(rbh,
-				    (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_NOWARN);
+		bio = loop_copy_bio(rbh);
 		current->flags = flags;
 		if (bio == NULL)
 			blk_congestion_wait(WRITE, HZ/10);

