Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTLUT4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTLUT4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:56:22 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:5248
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S263971AbTLUTzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:55:54 -0500
Date: Sun, 21 Dec 2003 14:55:37 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, jariruusu@users.sourceforge.net
Subject: [PATCH] loop.c patches, take two
Message-ID: <20031221195534.GA4721@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jariruusu@users.sourceforge.net
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org> <20031102204624.GA5740@fukurou.paranoiacs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20031102204624.GA5740@fukurou.paranoiacs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everybody,

Well, it appears that neither my loop.c patches nor Andrew's were merged
into 2.6.0... I'd request that my patches be merged into mainline,
since Jari Ruusu has pointed out that Andrew's patch (which removes the
separate code path for block-backed loop devices) will break journaling
filesystems on loop devices. Right now, journaling FS's on file-backed
loop devices are kinda iffy (they will work only if the underlying FS is
also journaled, with the correct journal options) but journaling FS's
on block-backed loop devices work perfectly. Andrew's patches would
break this.

This first patch improves the memory allocation technique used by
block-backed loop devices. Specifically the loop device will make
efficient use of whatever pages it can get, rather than throwing them all
back in case it didn't get as many as it wanted -- this fixes Bugzilla
bug #1198.

Taken together, this patch and the following patch make loop devices
safe for use as swap. Please apply.

-
-Ben


-- 
Ben Slusky                      | "I have a cunning plan! 
sluskyb@paranoiacs.org          |  RUN!"
sluskyb@stwing.org              |       -Spider Jerusalem
PGP keyID ADA44B3B      

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-recycle-mk2.diff"

diff -pu linux-2.6.0/drivers/block/loop.c-orig linux-2.6.0/drivers/block/loop.c
--- linux-2.6.0/drivers/block/loop.c-orig	2003-12-20 21:46:53.430260696 -0500
+++ linux-2.6.0/drivers/block/loop.c	2003-12-20 21:47:11.743476664 -0500
@@ -247,12 +247,10 @@ fail:
 static int
 lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	struct bio_vec *bvec;
+	int i, ret = 0;
 
+	bio_for_each_segment(bvec, bio, i) {
 		ret = do_lo_send(lo, bvec, bsize, pos);
 		if (ret < 0)
 			break;
@@ -318,12 +316,10 @@ do_lo_receive(struct loop_device *lo,
 static int
 lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	struct bio_vec *bvec;
+	int i, ret = 0;
 
+	bio_for_each_segment(bvec, bio, i) {
 		ret = do_lo_receive(lo, bvec, bsize, pos);
 		if (ret < 0)
 			break;
@@ -353,10 +349,12 @@ static void loop_put_buffer(struct bio *
 	 * check bi_end_io, may just be a remapped bio
 	 */
 	if (bio && bio->bi_end_io == loop_end_io_transfer) {
+		struct bio_vec *bv;
 		int i;
 
-		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
+		if (!bio_flagged(bio, BIO_CLONED))
+			bio_for_each_segment(bv, bio, i)
+				__free_page(bv->bv_page);
 
 		bio_put(bio);
 	}
@@ -413,7 +411,7 @@ static int loop_end_io_transfer(struct b
 	if (bio->bi_size)
 		return 1;
 
-	if (err || bio_rw(bio) == WRITE) {
+	if (err || (bio_rw(bio) == WRITE && bio->bi_vcnt == rbh->bi_vcnt)) {
 		bio_endio(rbh, rbh->bi_size, err);
 		if (atomic_dec_and_test(&lo->lo_pending))
 			up(&lo->lo_bh_mutex);
@@ -430,35 +428,41 @@ static struct bio *loop_copy_bio(struct 
 	struct bio_vec *bv;
 	int i;
 
-	bio = bio_alloc(__GFP_NOWARN, rbh->bi_vcnt);
+	if (bio_rw(rbh) != WRITE) {
+		bio = bio_clone(rbh, GFP_NOIO);
+		return bio;
+	}
+
+	bio = bio_alloc(GFP_NOIO, rbh->bi_vcnt);
 	if (!bio)
 		return NULL;
 
 	/*
 	 * iterate iovec list and alloc pages
 	 */
-	__bio_for_each_segment(bv, rbh, i, 0) {
+	bio_for_each_segment(bv, rbh, i) {
 		struct bio_vec *bbv = &bio->bi_io_vec[i];
 
-		bbv->bv_page = alloc_page(__GFP_NOWARN|__GFP_HIGHMEM);
+		/* We need one page; the rest we can live without */
+		bbv->bv_page = alloc_page((bio->bi_vcnt ? __GFP_NOWARN : GFP_NOIO) | __GFP_HIGHMEM);
 		if (bbv->bv_page == NULL)
-			goto oom;
+			break;
 
-		bbv->bv_len = bv->bv_len;
 		bbv->bv_offset = bv->bv_offset;
+		bio->bi_size += (bbv->bv_len = bv->bv_len);
+		bio->bi_vcnt++;
 	}
 
-	bio->bi_vcnt = rbh->bi_vcnt;
-	bio->bi_size = rbh->bi_size;
-
-	return bio;
+	/* Can't get anything done if we didn't get any pages */
+	if (unlikely(!bio->bi_vcnt)) {
+		bio_put(bio);
+		return NULL;
+	}
 
-oom:
-	while (--i >= 0)
-		__free_page(bio->bi_io_vec[i].bv_page);
+	bio->bi_vcnt += (bio->bi_idx = rbh->bi_idx);
+	bio->bi_rw = rbh->bi_rw;
 
-	bio_put(bio);
-	return NULL;
+	return bio;
 }
 
 static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
@@ -479,19 +483,85 @@ static struct bio *loop_get_buffer(struc
 		if (flags & PF_MEMALLOC)
 			current->flags |= PF_MEMALLOC;
 
-		if (bio == NULL)
+		if (unlikely(bio == NULL)) {
+			printk("loop: alloc failed\n");
 			blk_congestion_wait(WRITE, HZ/10);
+		}
 	} while (bio == NULL);
 
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;
 	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
-	bio->bi_rw = rbh->bi_rw;
 	bio->bi_bdev = lo->lo_device;
 
 	return bio;
 }
 
+static void loop_recycle_buffer(struct loop_device *lo, struct bio *bio)
+{
+	struct bio *rbh = bio->bi_private;
+	struct bio_vec *bv, *bbv, *rbv;
+	int i, flags, nvecs = bio->bi_vcnt - bio->bi_idx;
+
+	/*
+	 * Comments in ll_rw_blk.c reserve for generic_make_request the right to
+	 * "change bi_dev and bi_sector for remaps as it sees fit." Doh!
+	 * Workaround: reset the bi_bdev and recompute the starting sector for
+	 * the next write.
+	 */
+	bio->bi_bdev = lo->lo_device;
+	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
+	/* Clean up the flags too */
+	bio->bi_flags &= (~(BIO_POOL_MASK - 1) | (1 << BIO_UPTODATE));
+
+	/*
+	 * Move the allocated pages into position to transfer more data.
+	 */
+	__bio_for_each_segment(bv, bio, i, rbh->bi_idx) {
+		rbv = &rbh->bi_io_vec[i];
+		bbv = bv + nvecs;
+
+		/* Workaround -- see note above */
+		bio->bi_sector += rbv->bv_len >> 9;
+		if (i < bio->bi_idx)
+			continue;
+
+		if (i + nvecs < rbh->bi_vcnt) {
+			bbv->bv_page = bv->bv_page;
+			bbv->bv_offset = rbv->bv_offset;
+			bio->bi_size += (bbv->bv_len = rbv->bv_len);
+		} else
+			__free_page(bv->bv_page);
+		memset(bv, 0, sizeof(*bv));
+	}
+
+	bio->bi_idx = bio->bi_vcnt;
+	bio->bi_vcnt += nvecs;
+	bio->bi_vcnt = min(bio->bi_vcnt, rbh->bi_vcnt);
+
+	/*
+	 * If we need more pages, try to get some.
+	 * Clear PF_MEMALLOC to avoid consuming all available memory.
+	 */
+	flags = current->flags;
+	current->flags &= ~PF_MEMALLOC;
+
+	__bio_for_each_segment(rbv, rbh, i, bio->bi_vcnt) {
+		bv = &bio->bi_io_vec[i];
+
+		bv->bv_page = alloc_page(__GFP_NOWARN|__GFP_HIGHMEM);
+		if (bv->bv_page == NULL)
+			break;
+
+		bv->bv_offset = rbv->bv_offset;
+		bio->bi_size += (bv->bv_len = rbv->bv_len);
+		bio->bi_vcnt++;
+	}
+
+	if (flags & PF_MEMALLOC)
+		current->flags |= PF_MEMALLOC;
+}
+
 static int loop_transfer_bio(struct loop_device *lo,
 			     struct bio *to_bio, struct bio *from_bio)
 {
@@ -502,17 +572,19 @@ static int loop_transfer_bio(struct loop
 
 	IV = from_bio->bi_sector + (lo->lo_offset >> 9);
 
-	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
-		to_bvec = &to_bio->bi_io_vec[i];
+	__bio_for_each_segment(to_bvec, to_bio, i, from_bio->bi_idx) {
+		from_bvec = &from_bio->bi_io_vec[i];
 
-		kmap(from_bvec->bv_page);
-		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
-		kunmap(from_bvec->bv_page);
-		kunmap(to_bvec->bv_page);
+		if (i >= to_bio->bi_idx) {
+			kmap(from_bvec->bv_page);
+			kmap(to_bvec->bv_page);
+			vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
+			vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
+			ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
+						from_bvec->bv_len, IV);
+			kunmap(from_bvec->bv_page);
+			kunmap(to_bvec->bv_page);
+		}
 		IV += from_bvec->bv_len >> 9;
 	}
 
@@ -579,16 +651,30 @@ inactive:
 static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
 {
 	int ret;
+	struct bio *rbh;
 
-	/*
-	 * For block backed loop, we know this is a READ
-	 */
 	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
 		ret = do_bio_filebacked(lo, bio);
 		bio_endio(bio, bio->bi_size, ret);
-	} else {
-		struct bio *rbh = bio->bi_private;
+	} else if (bio_rw(bio) == WRITE) {
+		/*
+		 * Write complete, but more pages remain;
+		 * encrypt and write some more pages
+		 */
+		loop_recycle_buffer(lo, bio);
 
+		rbh = bio->bi_private;
+		if ((ret = loop_transfer_bio(lo, bio, rbh))) {
+			bio_endio(bio, bio->bi_size, ret);
+			return;
+		}
+
+		generic_make_request(bio);
+	} else {
+		/*
+		 * Read complete; do decryption now
+		 */
+		rbh = bio->bi_private;
 		ret = loop_transfer_bio(lo, bio, rbh);
 
 		bio_endio(rbh, rbh->bi_size, ret);
@@ -606,6 +692,7 @@ static int loop_thread(void *data)
 {
 	struct loop_device *lo = data;
 	struct bio *bio;
+	int x;
 
 	daemonize("loop%d", lo->lo_number);
 
@@ -640,7 +727,11 @@ static int loop_thread(void *data)
 			printk("loop: missing bio\n");
 			continue;
 		}
+
+		x = (lo->lo_flags & LO_FLAGS_DO_BMAP) || bio_rw(bio) != WRITE;
 		loop_handle_bio(lo, bio);
+		if (!x)
+			continue;
 
 		/*
 		 * upped both for pending work and tear-down, lo_pending

--wxDdMuZNg1r63Hyj--
