Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTFJPPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTFJPPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:15:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55271 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263103AbTFJPPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:15:05 -0400
Date: Tue, 10 Jun 2003 16:31:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop 2/9 absorb bio_copy
In-Reply-To: <Pine.LNX.4.44.0306101606080.2285-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101630210.2285-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bio_copy is used only by the loop driver, which already has to walk the
bio segments itself: so it makes sense to change it from bio.c export
to loop.c static, as prelude to working upon it there.

bio_copy itself is unchanged by this patch, with one exception.  On oom
failure it must use bio_put, instead of mempool_free to static bio_pool:
which it should have been doing all along - it was leaking the veclist.

--- loop1/drivers/block/loop.c	Mon Jun  9 10:29:01 2003
+++ loop2/drivers/block/loop.c	Mon Jun  9 10:32:06 2003
@@ -439,6 +439,74 @@
 	return 0;
 }
 
+static struct bio *bio_copy(struct bio *bio, int gfp_mask, int copy)
+{
+	struct bio *b = bio_alloc(gfp_mask, bio->bi_vcnt);
+	unsigned long flags = 0; /* gcc silly */
+	struct bio_vec *bv;
+	int i;
+
+	if (unlikely(!b))
+		return NULL;
+
+	/*
+	 * iterate iovec list and alloc pages + copy data
+	 */
+	__bio_for_each_segment(bv, bio, i, 0) {
+		struct bio_vec *bbv = &b->bi_io_vec[i];
+		char *vfrom, *vto;
+
+		bbv->bv_page = alloc_page(gfp_mask);
+		if (bbv->bv_page == NULL)
+			goto oom;
+
+		bbv->bv_len = bv->bv_len;
+		bbv->bv_offset = bv->bv_offset;
+
+		/*
+		 * if doing a copy for a READ request, no need
+		 * to memcpy page data
+		 */
+		if (!copy)
+			continue;
+
+		if (gfp_mask & __GFP_WAIT) {
+			vfrom = kmap(bv->bv_page);
+			vto = kmap(bbv->bv_page);
+		} else {
+			local_irq_save(flags);
+			vfrom = kmap_atomic(bv->bv_page, KM_BIO_SRC_IRQ);
+			vto = kmap_atomic(bbv->bv_page, KM_BIO_DST_IRQ);
+		}
+
+		memcpy(vto + bbv->bv_offset, vfrom + bv->bv_offset, bv->bv_len);
+		if (gfp_mask & __GFP_WAIT) {
+			kunmap(bbv->bv_page);
+			kunmap(bv->bv_page);
+		} else {
+			kunmap_atomic(vto, KM_BIO_DST_IRQ);
+			kunmap_atomic(vfrom, KM_BIO_SRC_IRQ);
+			local_irq_restore(flags);
+		}
+	}
+
+	b->bi_sector = bio->bi_sector;
+	b->bi_bdev = bio->bi_bdev;
+	b->bi_rw = bio->bi_rw;
+
+	b->bi_vcnt = bio->bi_vcnt;
+	b->bi_size = bio->bi_size;
+
+	return b;
+
+oom:
+	while (--i >= 0)
+		__free_page(b->bi_io_vec[i].bv_page);
+
+	bio_put(bio);
+	return NULL;
+}
+
 static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
 {
 	struct bio *bio;
--- loop1/fs/bio.c	Mon Jun  9 10:14:59 2003
+++ loop2/fs/bio.c	Mon Jun  9 10:32:06 2003
@@ -261,84 +261,6 @@
 }
 
 /**
- *	bio_copy	-	create copy of a bio
- *	@bio: bio to copy
- *	@gfp_mask: allocation priority
- *	@copy: copy data to allocated bio
- *
- *	Create a copy of a &bio. Caller will own the returned bio and
- *	the actual data it points to. Reference count of returned
- * 	bio will be one.
- */
-struct bio *bio_copy(struct bio *bio, int gfp_mask, int copy)
-{
-	struct bio *b = bio_alloc(gfp_mask, bio->bi_vcnt);
-	unsigned long flags = 0; /* gcc silly */
-	struct bio_vec *bv;
-	int i;
-
-	if (unlikely(!b))
-		return NULL;
-
-	/*
-	 * iterate iovec list and alloc pages + copy data
-	 */
-	__bio_for_each_segment(bv, bio, i, 0) {
-		struct bio_vec *bbv = &b->bi_io_vec[i];
-		char *vfrom, *vto;
-
-		bbv->bv_page = alloc_page(gfp_mask);
-		if (bbv->bv_page == NULL)
-			goto oom;
-
-		bbv->bv_len = bv->bv_len;
-		bbv->bv_offset = bv->bv_offset;
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
-	}
-
-	b->bi_sector = bio->bi_sector;
-	b->bi_bdev = bio->bi_bdev;
-	b->bi_rw = bio->bi_rw;
-
-	b->bi_vcnt = bio->bi_vcnt;
-	b->bi_size = bio->bi_size;
-
-	return b;
-
-oom:
-	while (--i >= 0)
-		__free_page(b->bi_io_vec[i].bv_page);
-
-	mempool_free(b, bio_pool);
-	return NULL;
-}
-
-/**
  *	bio_get_nr_vecs		- return approx number of vecs
  *	@bdev:  I/O target
  *
@@ -907,7 +829,6 @@
 EXPORT_SYMBOL(bio_put);
 EXPORT_SYMBOL(bio_endio);
 EXPORT_SYMBOL(bio_init);
-EXPORT_SYMBOL(bio_copy);
 EXPORT_SYMBOL(__bio_clone);
 EXPORT_SYMBOL(bio_clone);
 EXPORT_SYMBOL(bio_phys_segments);
--- loop1/include/linux/bio.h	Mon Jun  9 10:15:00 2003
+++ loop2/include/linux/bio.h	Mon Jun  9 10:32:06 2003
@@ -235,7 +235,6 @@
 
 extern inline void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, int);
-extern struct bio *bio_copy(struct bio *, int, int);
 
 extern inline void bio_init(struct bio *);
 

