Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTJ3NfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbTJ3NfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:35:15 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:3201
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S262446AbTJ3Nes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:34:48 -0500
Date: Thu, 30 Oct 2003 08:34:44 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] improved memory allocation for loop.c (Bugzilla #1198)
Message-ID: <20031030133441.GC12147@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@fukurou.paranoiacs.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

The attached patch changes the bio allocation procedure in loop_copy_bio.
The current procedure is to get one page at a time with a weak GFP mask,
in order to avoid consuming all available memory copying huge bios,
and fail (put 'em all back, wait and retry) unless we can get as many
pages as the incoming request bio. Under heavy write I/O and low memory
conditions a deadlock often occurs as the loop device can't process any
of its outstanding write requests.

This patch permits loop_copy_bio to get fewer pages than the request,
in which case the loop device can start to transfer and write those
pages. When the short bio comes back (via loop_end_io_transfer) the
pages already allocated will be moved into position for the next transfer
and write.

So now we can get the first page with GFP_NOIO, and all subsequent
pages with the failure-prone __GFP_NOWARN. This seems to fix the memory
allocation deadlock identified in Bugzilla bug #1198, although the stress
test described there now causes an Oops in kswapd, which I'd like to
believe is not my fault...

Read requests are simply cloned with bio_clone, and done. All CryptoAPI
transforms are capable of working in place, as can NONE and XOR.

Questions? Comments? Flames?

-- 
Ben Slusky                      | This is the noise
sluskyb@paranoiacs.org          | that keeps me awake
sluskyb@stwing.org              |               -Garbage
PGP keyID ADA44B3B      

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-recycle.diff"

--- linux-2.6.0-test/drivers/block/loop.c-orig	2003-10-23 07:45:31.000000000 -0400
+++ linux-2.6.0-test/drivers/block/loop.c	2003-10-30 08:12:17.000000000 -0500
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
@@ -369,6 +367,8 @@ static void loop_add_bio(struct loop_dev
 {
 	unsigned long flags;
 
+	bio->bi_next = NULL;
+
 	spin_lock_irqsave(&lo->lo_lock, flags);
 	if (lo->lo_biotail) {
 		lo->lo_biotail->bi_next = bio;
@@ -413,7 +413,7 @@ static int loop_end_io_transfer(struct b
 	if (bio->bi_size)
 		return 1;
 
-	if (err || bio_rw(bio) == WRITE) {
+	if (err || (bio_rw(bio) == WRITE && bio->bi_vcnt == rbh->bi_vcnt)) {
 		bio_endio(rbh, rbh->bi_size, err);
 		if (atomic_dec_and_test(&lo->lo_pending))
 			up(&lo->lo_bh_mutex);
@@ -430,35 +430,41 @@ static struct bio *loop_copy_bio(struct 
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
@@ -479,19 +485,85 @@ static struct bio *loop_get_buffer(struc
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
@@ -502,17 +574,19 @@ static int loop_transfer_bio(struct loop
 
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
 
@@ -523,24 +597,31 @@ static int loop_make_request(request_que
 {
 	struct bio *new_bio = NULL;
 	struct loop_device *lo = q->queuedata;
-	int rw = bio_rw(old_bio);
+	int ret, rw = bio_rw(old_bio);
 
-	if (!lo)
+	if (!lo) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	spin_lock_irq(&lo->lo_lock);
-	if (lo->lo_state != Lo_bound)
+	if (lo->lo_state != Lo_bound) {
+		ret = -EINVAL;
 		goto inactive;
+	}
 	atomic_inc(&lo->lo_pending);
 	spin_unlock_irq(&lo->lo_lock);
 
 	if (rw == WRITE) {
-		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
+		if (lo->lo_flags & LO_FLAGS_READ_ONLY) {
+			ret = -EINVAL;
 			goto err;
+		}
 	} else if (rw == READA) {
 		rw = READ;
 	} else if (rw != READ) {
 		printk(KERN_ERR "loop: unknown command (%x)\n", rw);
+		ret = -EINVAL;
 		goto err;
 	}
 
@@ -557,7 +638,7 @@ static int loop_make_request(request_que
 	 */
 	new_bio = loop_get_buffer(lo, old_bio);
 	if (rw == WRITE) {
-		if (loop_transfer_bio(lo, new_bio, old_bio))
+		if ((ret = loop_transfer_bio(lo, new_bio, old_bio)))
 			goto err;
 	}
 
@@ -569,7 +650,7 @@ err:
 		up(&lo->lo_bh_mutex);
 	loop_put_buffer(new_bio);
 out:
-	bio_io_error(old_bio, old_bio->bi_size);
+	bio_endio(old_bio, old_bio->bi_size, ret);
 	return 0;
 inactive:
 	spin_unlock_irq(&lo->lo_lock);
@@ -579,16 +660,30 @@ inactive:
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
@@ -606,6 +701,7 @@ static int loop_thread(void *data)
 {
 	struct loop_device *lo = data;
 	struct bio *bio;
+	int x;
 
 	daemonize("loop%d", lo->lo_number);
 
@@ -640,7 +736,11 @@ static int loop_thread(void *data)
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

--PNTmBPCT7hxwcZjr--
