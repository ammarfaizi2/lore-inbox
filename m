Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSLPKMk>; Mon, 16 Dec 2002 05:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSLPKMK>; Mon, 16 Dec 2002 05:12:10 -0500
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:40973 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266686AbSLPKKZ>; Mon, 16 Dec 2002 05:10:25 -0500
Date: Mon, 16 Dec 2002 10:18:30 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 18/19
Message-ID: <20021216101830.GS7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block layer does not honour bio->bi_size when issuing io, instead
it performs io to the complete bvecs.  This means we have to change
the bio splitting code slightly.

Given a bio we repeatedly apply one of the following three operations
until there is no more io left in the bio:

1) The remaining io does not cross an io/target boundary, so just
   create a clone and issue all of the io.

2) There are some bvecs at the start of the bio that are not split by
   a target boundary.  Create a clone for these bvecs only.

3) The first bvec needs splitting, use bio_alloc() to create *two*
   bios, one for the first half of the bvec, the other for the second
   half.  A bvec can never contain more than one boundary.
--- diff/drivers/md/dm.c	2002-12-16 09:41:39.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:42:31.000000000 +0000
@@ -228,6 +228,15 @@
  *   interests of getting something for people to use I give
  *   you this clearly demarcated crap.
  *---------------------------------------------------------------*/
+static inline sector_t to_sector(unsigned int bytes)
+{
+	return bytes >> SECTOR_SHIFT;
+}
+
+static inline unsigned int to_bytes(sector_t sector)
+{
+	return sector << SECTOR_SHIFT;
+}
 
 /*
  * Decrements the number of outstanding ios that a bio has been
@@ -270,16 +279,17 @@
 static sector_t max_io_len(struct mapped_device *md,
 			   sector_t sector, struct dm_target *ti)
 {
-	sector_t len = ti->len;
+	sector_t offset = sector - ti->begin;
+	sector_t len = ti->len - offset;
 
 	/* FIXME: obey io_restrictions ! */
 
+
 	/*
 	 * Does the target need to split even further ?
 	 */
 	if (ti->split_io) {
 		sector_t boundary;
-		sector_t offset = sector - ti->begin;
 		boundary = dm_round_up(offset + 1, ti->split_io) - offset;
 
 		if (len > boundary)
@@ -289,16 +299,17 @@
 	return len;
 }
 
-static void __map_bio(struct dm_target *ti, struct bio *clone)
+static void __map_bio(struct dm_target *ti, struct bio *clone, struct dm_io *io)
 {
-	struct dm_io *io = clone->bi_private;
 	int r;
 
 	/*
 	 * Sanity checks.
 	 */
-	if (!clone->bi_size)
-		BUG();
+	BUG_ON(!clone->bi_size);
+
+	clone->bi_end_io = clone_endio;
+	clone->bi_private = io;
 
 	/*
 	 * Map the clone.  If r == 0 we don't need to do
@@ -326,77 +337,125 @@
 };
 
 /*
- * Issues a little bio that just does the back end of a split page.
+ * Creates a little bio that is just does part of a bvec.
  */
-static void __split_page(struct clone_info *ci, unsigned int len)
+static struct bio *split_bvec(struct bio *bio, sector_t sector,
+			      unsigned short idx, unsigned int offset,
+			      unsigned int len)
 {
-	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
-	struct bio *clone, *bio = ci->bio;
-	struct bio_vec *bv = bio->bi_io_vec + ci->idx;
-
-	if (len > ci->sector_count)
-		len = ci->sector_count;
+	struct bio *clone;
+	struct bio_vec *bv = bio->bi_io_vec + idx;
 
 	clone = bio_alloc(GFP_NOIO, 1);
-	memcpy(clone->bi_io_vec, bv, sizeof(*bv));
 
-	clone->bi_sector = ci->sector;
-	clone->bi_bdev = bio->bi_bdev;
-	clone->bi_rw = bio->bi_rw;
-	clone->bi_vcnt = 1;
-	clone->bi_size = len << SECTOR_SHIFT;
-	clone->bi_end_io = clone_endio;
-	clone->bi_private = ci->io;
-	clone->bi_io_vec->bv_offset = bv->bv_len - clone->bi_size;
-	clone->bi_io_vec->bv_len = clone->bi_size;
+	if (clone) {
+		memcpy(clone->bi_io_vec, bv, sizeof(*bv));
 
-	ci->sector += len;
-	ci->sector_count -= len;
+		clone->bi_sector = sector;
+		clone->bi_bdev = bio->bi_bdev;
+		clone->bi_rw = bio->bi_rw;
+		clone->bi_vcnt = 1;
+		clone->bi_size = to_bytes(len);
+		clone->bi_io_vec->bv_offset = offset;
+		clone->bi_io_vec->bv_len = clone->bi_size;
+	}
 
-	__map_bio(ti, clone);
+	return clone;
+}
+
+/*
+ * Creates a bio that consists of range of complete bvecs.
+ */
+static struct bio *clone_bio(struct bio *bio, sector_t sector,
+			     unsigned short idx, unsigned short bv_count,
+			     unsigned int len)
+{
+	struct bio *clone;
+
+	clone = bio_clone(bio, GFP_NOIO);
+	clone->bi_sector = sector;
+	clone->bi_idx = idx;
+	clone->bi_vcnt = idx + bv_count;
+	clone->bi_size = to_bytes(len);
+
+	return clone;
 }
 
 static void __clone_and_map(struct clone_info *ci)
 {
 	struct bio *clone, *bio = ci->bio;
 	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
-	sector_t len = max_io_len(ci->md, bio->bi_sector, ti);
+	sector_t len = 0, max = max_io_len(ci->md, ci->sector, ti);
 
-	/* shorter than current target ? */
-	if (ci->sector_count < len)
-		len = ci->sector_count;
+	if (ci->sector_count <= max) {
+		/*
+		 * Optimise for the simple case where we can do all of
+		 * the remaining io with a single clone.
+		 */
+		clone = clone_bio(bio, ci->sector, ci->idx,
+				  bio->bi_vcnt - ci->idx, ci->sector_count);
+		__map_bio(ti, clone, ci->io);
+		ci->sector_count = 0;
 
-	/* create the clone */
-	clone = bio_clone(ci->bio, GFP_NOIO);
-	clone->bi_sector = ci->sector;
-	clone->bi_idx = ci->idx;
-	clone->bi_size = len << SECTOR_SHIFT;
-	clone->bi_end_io = clone_endio;
-	clone->bi_private = ci->io;
+	} else if (to_sector(bio->bi_io_vec[ci->idx].bv_len) <= max) {
+		/*
+		 * There are some bvecs that don't span targets.
+		 * Do as many of these as possible.
+		 */
+		int i;
+		sector_t remaining = max;
+		sector_t bv_len;
 
-	/* adjust the remaining io */
-	ci->sector += len;
-	ci->sector_count -= len;
-	__map_bio(ti, clone);
+		for (i = ci->idx; remaining && (i < bio->bi_vcnt); i++) {
+			bv_len = to_sector(bio->bi_io_vec[i].bv_len);
 
-	/*
-	 * If we are not performing all remaining io in this
-	 * clone then we need to calculate ci->idx for the next
-	 * time round.
-	 */
-	if (ci->sector_count) {
-		while (len) {
-			struct bio_vec *bv = clone->bi_io_vec + ci->idx;
-			sector_t bv_len = bv->bv_len >> SECTOR_SHIFT;
-			if (bv_len <= len)
-				len -= bv_len;
+			if (bv_len > remaining)
+				break;
 
-			else {
-				__split_page(ci, bv_len - len);
-				len = 0;
-			}
-			ci->idx++;
+			remaining -= bv_len;
+			len += bv_len;
 		}
+
+		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
+		__map_bio(ti, clone, ci->io);
+
+		ci->sector += len;
+		ci->sector_count -= len;
+		ci->idx = i;
+
+	} else {
+		/*
+		 * Create two copy bios to deal with io that has
+		 * been split across a target.
+		 */
+		struct bio_vec *bv = bio->bi_io_vec + ci->idx;
+
+		clone = split_bvec(bio, ci->sector, ci->idx,
+				   bv->bv_offset, max);
+		if (!clone) {
+			dec_pending(ci->io, -ENOMEM);
+			return;
+		}
+
+		__map_bio(ti, clone, ci->io);
+
+		ci->sector += max;
+		ci->sector_count -= max;
+		ti = dm_table_find_target(ci->md->map, ci->sector);
+
+		len = to_sector(bv->bv_len) - max;
+		clone = split_bvec(bio, ci->sector, ci->idx,
+				   bv->bv_offset + to_bytes(max), len);
+		if (!clone) {
+			dec_pending(ci->io, -ENOMEM);
+			return;
+		}
+
+		__map_bio(ti, clone, ci->io);
+
+		ci->sector += len;
+		ci->sector_count -= len;
+		ci->idx++;
 	}
 }
 
