Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWINVwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWINVwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWINVwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:52:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39642 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751245AbWINVwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:52:17 -0400
Date: Thu, 14 Sep 2006 22:52:00 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stefan Bader <Stefan.Bader@de.ibm.com>
Subject: [PATCH 23/25] dm: use private biosets
Message-ID: <20060914215200.GD3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Stefan Bader <Stefan.Bader@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <Stefan.Bader@de.ibm.com>

I found a problem within device-mapper that occurs in low-mem
situations. It was found using a mirror target but I think in theory it
would hit any setup that stacks device-mapper devices (like LVM on top
of multipath).

Since device-mapper core uses the common fs_bioset 
in clone_bio(), and a private, but still global, bio_set in split_bvec()
it is possible that the filesystem and the first level target successfully
get bios but the lower level target doesn't because there is no more memory
and the pool was drained by upper layers. So the remapping will be stuck
forever.  To solve this device-mapper core needs to use a private bio_set
for each device.

Signed-off-by: Stefan Bader <Stefan.Bader@de.ibm.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm.c	2006-09-14 21:03:16.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm.c	2006-09-14 21:35:14.000000000 +0100
@@ -102,6 +102,8 @@ struct mapped_device {
 	mempool_t *io_pool;
 	mempool_t *tio_pool;
 
+	struct bio_set *bs;
+
 	/*
 	 * Event handling.
 	 */
@@ -122,16 +124,10 @@ struct mapped_device {
 static kmem_cache_t *_io_cache;
 static kmem_cache_t *_tio_cache;
 
-static struct bio_set *dm_set;
-
 static int __init local_init(void)
 {
 	int r;
 
-	dm_set = bioset_create(16, 16, 4);
-	if (!dm_set)
-		return -ENOMEM;
-
 	/* allocate a slab for the dm_ios */
 	_io_cache = kmem_cache_create("dm_io",
 				      sizeof(struct dm_io), 0, 0, NULL, NULL);
@@ -165,8 +161,6 @@ static void local_exit(void)
 	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
 
-	bioset_free(dm_set);
-
 	if (unregister_blkdev(_major, _name) < 0)
 		DMERR("unregister_blkdev failed");
 
@@ -475,7 +469,7 @@ static int clone_endio(struct bio *bio, 
 {
 	int r = 0;
 	struct target_io *tio = bio->bi_private;
-	struct dm_io *io = tio->io;
+	struct mapped_device *md = tio->io->md;
 	dm_endio_fn endio = tio->ti->type->end_io;
 
 	if (bio->bi_size)
@@ -494,9 +488,15 @@ static int clone_endio(struct bio *bio, 
 			return 1;
 	}
 
-	free_tio(io->md, tio);
-	dec_pending(io, error);
+	dec_pending(tio->io, error);
+
+	/*
+	 * Store md for cleanup instead of tio which is about to get freed.
+	 */
+	bio->bi_private = md->bs;
+
 	bio_put(bio);
+	free_tio(md, tio);
 	return r;
 }
 
@@ -525,6 +525,7 @@ static void __map_bio(struct dm_target *
 {
 	int r;
 	sector_t sector;
+	struct mapped_device *md;
 
 	/*
 	 * Sanity checks.
@@ -554,10 +555,14 @@ static void __map_bio(struct dm_target *
 
 	else if (r < 0) {
 		/* error the io and bail out */
-		struct dm_io *io = tio->io;
-		free_tio(tio->io->md, tio);
-		dec_pending(io, r);
+		md = tio->io->md;
+		dec_pending(tio->io, r);
+		/*
+		 * Store bio_set for cleanup.
+		 */
+		clone->bi_private = md->bs;
 		bio_put(clone);
+		free_tio(md, tio);
 	}
 }
 
@@ -573,7 +578,9 @@ struct clone_info {
 
 static void dm_bio_destructor(struct bio *bio)
 {
-	bio_free(bio, dm_set);
+	struct bio_set *bs = bio->bi_private;
+
+	bio_free(bio, bs);
 }
 
 /*
@@ -581,12 +588,12 @@ static void dm_bio_destructor(struct bio
  */
 static struct bio *split_bvec(struct bio *bio, sector_t sector,
 			      unsigned short idx, unsigned int offset,
-			      unsigned int len)
+			      unsigned int len, struct bio_set *bs)
 {
 	struct bio *clone;
 	struct bio_vec *bv = bio->bi_io_vec + idx;
 
-	clone = bio_alloc_bioset(GFP_NOIO, 1, dm_set);
+	clone = bio_alloc_bioset(GFP_NOIO, 1, bs);
 	clone->bi_destructor = dm_bio_destructor;
 	*clone->bi_io_vec = *bv;
 
@@ -606,11 +613,13 @@ static struct bio *split_bvec(struct bio
  */
 static struct bio *clone_bio(struct bio *bio, sector_t sector,
 			     unsigned short idx, unsigned short bv_count,
-			     unsigned int len)
+			     unsigned int len, struct bio_set *bs)
 {
 	struct bio *clone;
 
-	clone = bio_clone(bio, GFP_NOIO);
+	clone = bio_alloc_bioset(GFP_NOIO, bio->bi_max_vecs, bs);
+	__bio_clone(clone, bio);
+	clone->bi_destructor = dm_bio_destructor;
 	clone->bi_sector = sector;
 	clone->bi_idx = idx;
 	clone->bi_vcnt = idx + bv_count;
@@ -641,7 +650,8 @@ static void __clone_and_map(struct clone
 		 * the remaining io with a single clone.
 		 */
 		clone = clone_bio(bio, ci->sector, ci->idx,
-				  bio->bi_vcnt - ci->idx, ci->sector_count);
+				  bio->bi_vcnt - ci->idx, ci->sector_count,
+				  ci->md->bs);
 		__map_bio(ti, clone, tio);
 		ci->sector_count = 0;
 
@@ -664,7 +674,8 @@ static void __clone_and_map(struct clone
 			len += bv_len;
 		}
 
-		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
+		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len,
+				  ci->md->bs);
 		__map_bio(ti, clone, tio);
 
 		ci->sector += len;
@@ -693,7 +704,8 @@ static void __clone_and_map(struct clone
 			len = min(remaining, max);
 
 			clone = split_bvec(bio, ci->sector, ci->idx,
-					   bv->bv_offset + offset, len);
+					   bv->bv_offset + offset, len,
+					   ci->md->bs);
 
 			__map_bio(ti, clone, tio);
 
@@ -961,6 +973,10 @@ static struct mapped_device *alloc_dev(i
 	if (!md->tio_pool)
 		goto bad3;
 
+	md->bs = bioset_create(16, 16, 4);
+	if (!md->bs)
+		goto bad_no_bioset;
+
 	md->disk = alloc_disk(1);
 	if (!md->disk)
 		goto bad4;
@@ -988,6 +1004,8 @@ static struct mapped_device *alloc_dev(i
 	return md;
 
  bad4:
+	bioset_free(md->bs);
+ bad_no_bioset:
 	mempool_destroy(md->tio_pool);
  bad3:
 	mempool_destroy(md->io_pool);
@@ -1012,6 +1030,7 @@ static void free_dev(struct mapped_devic
 	}
 	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);
+	bioset_free(md->bs);
 	del_gendisk(md->disk);
 	free_minor(minor);
 
