Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVAUABF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVAUABF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVAUABF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:01:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:2004 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261445AbVATX6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:58:36 -0500
Date: Thu, 20 Jan 2005 15:58:26 -0800
From: Dave Olien <dmo@osdl.org>
To: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: axboe@suse.de, kevcorry@us.ibm.com, agk@sourceware.org
Subject: [RFC] [PATCH] move bio code from dm into bio
Message-ID: <20050120235826.GA3041@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, last December you observed there was bio code
duplicated in the dm drivers.

Here are a collection of patches that implements
support for local bio and bvec pools into bio.c and then
removes the duplicate bio code from the dm drivers.

It also replaces a call to alloc_bio() in dm.c with
a call to use a local bio pool.  This removes a 
deadlock case in that code.

These patches are against 2.6.11-rc1.  If that's not
a good source version to patch against, let me now
what versions I should generate patches for.

I still need to implement some form of congestion
control in the dm code.  As things are now, the snapshot
target can consume all the bio's in the system.  With the elmination
of the deadlock case in dm.c, the system nolonger deadlocks.
But instead, it starts invoking the oom killer.  That'll
be the next patch set to this code.

Please review.

Thanks!


diff -ur linux-2.6.11-rc1-original/drivers/md/dm.c linux-2.6.11-rc1-bio/drivers/md/dm.c
--- linux-2.6.11-rc1-original/drivers/md/dm.c	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.11-rc1-bio/drivers/md/dm.c	2005-01-19 15:51:49.000000000 -0800
@@ -96,10 +96,16 @@
 static kmem_cache_t *_io_cache;
 static kmem_cache_t *_tio_cache;
 
+static struct bio_set *dm_set;
+
 static int __init local_init(void)
 {
 	int r;
 
+	dm_set = bioset_create(512, 512, 1);
+	if (!dm_set)
+		return -ENOMEM;
+
 	/* allocate a slab for the dm_ios */
 	_io_cache = kmem_cache_create("dm_io",
 				      sizeof(struct dm_io), 0, 0, NULL, NULL);
@@ -133,6 +139,8 @@
 	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
 
+	bioset_free(dm_set);
+	
 	if (unregister_blkdev(_major, _name) < 0)
 		DMERR("devfs_unregister_blkdev failed");
 
@@ -393,7 +401,7 @@
 	struct bio *clone;
 	struct bio_vec *bv = bio->bi_io_vec + idx;
 
-	clone = bio_alloc(GFP_NOIO, 1);
+	clone = bio_alloc_bs(GFP_NOIO, 1, dm_set);
 	*clone->bi_io_vec = *bv;
 
 	clone->bi_sector = sector;
diff -ur linux-2.6.11-rc1-original/drivers/md/dm-io.c linux-2.6.11-rc1-bio/drivers/md/dm-io.c
--- linux-2.6.11-rc1-original/drivers/md/dm-io.c	2004-12-24 13:35:39.000000000 -0800
+++ linux-2.6.11-rc1-bio/drivers/md/dm-io.c	2005-01-19 15:26:55.000000000 -0800
@@ -12,207 +12,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-#define BIO_POOL_SIZE 256
-
-
-/*-----------------------------------------------------------------
- * Bio set, move this to bio.c
- *---------------------------------------------------------------*/
-#define BV_NAME_SIZE 16
-struct biovec_pool {
-	int nr_vecs;
-	char name[BV_NAME_SIZE];
-	kmem_cache_t *slab;
-	mempool_t *pool;
-	atomic_t allocated;	/* FIXME: debug */
-};
-
-#define BIOVEC_NR_POOLS 6
-struct bio_set {
-	char name[BV_NAME_SIZE];
-	kmem_cache_t *bio_slab;
-	mempool_t *bio_pool;
-	struct biovec_pool pools[BIOVEC_NR_POOLS];
-};
-
-static void bio_set_exit(struct bio_set *bs)
-{
-	unsigned i;
-	struct biovec_pool *bp;
-
-	if (bs->bio_pool)
-		mempool_destroy(bs->bio_pool);
-
-	if (bs->bio_slab)
-		kmem_cache_destroy(bs->bio_slab);
-
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
-		bp = bs->pools + i;
-		if (bp->pool)
-			mempool_destroy(bp->pool);
-
-		if (bp->slab)
-			kmem_cache_destroy(bp->slab);
-	}
-}
-
-static void mk_name(char *str, size_t len, const char *prefix, unsigned count)
-{
-	snprintf(str, len, "%s-%u", prefix, count);
-}
-
-static int bio_set_init(struct bio_set *bs, const char *slab_prefix,
-			 unsigned pool_entries, unsigned scale)
-{
-	/* FIXME: this must match bvec_index(), why not go the
-	 * whole hog and have a pool per power of 2 ? */
-	static unsigned _vec_lengths[BIOVEC_NR_POOLS] = {
-		1, 4, 16, 64, 128, BIO_MAX_PAGES
-	};
-
-
-	unsigned i, size;
-	struct biovec_pool *bp;
-
-	/* zero the bs so we can tear down properly on error */
-	memset(bs, 0, sizeof(*bs));
-
-	/*
-	 * Set up the bio pool.
-	 */
-	snprintf(bs->name, sizeof(bs->name), "%s-bio", slab_prefix);
-
-	bs->bio_slab = kmem_cache_create(bs->name, sizeof(struct bio), 0,
-					 SLAB_HWCACHE_ALIGN, NULL, NULL);
-	if (!bs->bio_slab) {
-		DMWARN("can't init bio slab");
-		goto bad;
-	}
-
-	bs->bio_pool = mempool_create(pool_entries, mempool_alloc_slab,
-				      mempool_free_slab, bs->bio_slab);
-	if (!bs->bio_pool) {
-		DMWARN("can't init bio pool");
-		goto bad;
-	}
-
-	/*
-	 * Set up the biovec pools.
-	 */
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
-		bp = bs->pools + i;
-		bp->nr_vecs = _vec_lengths[i];
-		atomic_set(&bp->allocated, 1); /* FIXME: debug */
-
-
-		size = bp->nr_vecs * sizeof(struct bio_vec);
-
-		mk_name(bp->name, sizeof(bp->name), slab_prefix, i);
-		bp->slab = kmem_cache_create(bp->name, size, 0,
-					     SLAB_HWCACHE_ALIGN, NULL, NULL);
-		if (!bp->slab) {
-			DMWARN("can't init biovec slab cache");
-			goto bad;
-		}
-
-		if (i >= scale)
-			pool_entries >>= 1;
-
-		bp->pool = mempool_create(pool_entries, mempool_alloc_slab,
-					  mempool_free_slab, bp->slab);
-		if (!bp->pool) {
-			DMWARN("can't init biovec mempool");
-			goto bad;
-		}
-	}
-
-	return 0;
-
- bad:
-	bio_set_exit(bs);
-	return -ENOMEM;
-}
-
-/* FIXME: blech */
-static inline unsigned bvec_index(unsigned nr)
-{
-	switch (nr) {
-	case 1:		return 0;
-	case 2 ... 4: 	return 1;
-	case 5 ... 16:	return 2;
-	case 17 ... 64:	return 3;
-	case 65 ... 128:return 4;
-	case 129 ... BIO_MAX_PAGES: return 5;
-	}
-
-	BUG();
-	return 0;
-}
-
-static inline void bs_bio_init(struct bio *bio)
-{
-	bio->bi_next = NULL;
-	bio->bi_flags = 1 << BIO_UPTODATE;
-	bio->bi_rw = 0;
-	bio->bi_vcnt = 0;
-	bio->bi_idx = 0;
-	bio->bi_phys_segments = 0;
-	bio->bi_hw_segments = 0;
-	bio->bi_size = 0;
-	bio->bi_max_vecs = 0;
-	bio->bi_end_io = NULL;
-	atomic_set(&bio->bi_cnt, 1);
-	bio->bi_private = NULL;
-}
-
-static unsigned _bio_count = 0;
-struct bio *bio_set_alloc(struct bio_set *bs, int gfp_mask, int nr_iovecs)
-{
-	struct biovec_pool *bp;
-	struct bio_vec *bv = NULL;
-	unsigned long idx;
-	struct bio *bio;
-
-	bio = mempool_alloc(bs->bio_pool, gfp_mask);
-	if (unlikely(!bio))
-		return NULL;
-
-	bio_init(bio);
-
-	if (likely(nr_iovecs)) {
-		idx = bvec_index(nr_iovecs);
-		bp = bs->pools + idx;
-		bv = mempool_alloc(bp->pool, gfp_mask);
-		if (!bv) {
-			mempool_free(bio, bs->bio_pool);
-			return NULL;
-		}
-
-		memset(bv, 0, bp->nr_vecs * sizeof(*bv));
-		bio->bi_flags |= idx << BIO_POOL_OFFSET;
-		bio->bi_max_vecs = bp->nr_vecs;
-		atomic_inc(&bp->allocated);
-	}
-
-	bio->bi_io_vec = bv;
-	return bio;
-}
-
-static void bio_set_free(struct bio_set *bs, struct bio *bio)
-{
-	struct biovec_pool *bp = bs->pools + BIO_POOL_IDX(bio);
-
-	if (atomic_dec_and_test(&bp->allocated))
-		BUG();
-
-	mempool_free(bio->bi_io_vec, bp->pool);
-	mempool_free(bio, bs->bio_pool);
-}
-
-/*-----------------------------------------------------------------
- * dm-io proper
- *---------------------------------------------------------------*/
-static struct bio_set _bios;
+static struct bio_set *_bios;
 
 /* FIXME: can we shrink this ? */
 struct io {
@@ -256,7 +56,8 @@
 			/* free off the pool */
 			mempool_destroy(_io_pool);
 			_io_pool = NULL;
-			bio_set_exit(&_bios);
+			/*bio_set_exit(&_bios); XXX */
+			bioset_free(_bios);
 
 		} else {
 			/* resize the pool */
@@ -269,10 +70,11 @@
 		if (!_io_pool)
 			return -ENOMEM;
 
-		r = bio_set_init(&_bios, "dm-io", 512, 1);
-		if (r) {
+		_bios = bioset_create(512, 512, 1);
+		if (!_bios) {
 			mempool_destroy(_io_pool);
 			_io_pool = NULL;
+			return -ENOMEM;
 		}
 	}
 
@@ -296,6 +98,7 @@
  * We need to keep track of which region a bio is doing io for.
  * In order to save a memory allocation we store this the last
  * bvec which we know is unused (blech).
+ * XXX This is ugly and can OOPS with some configs... find another way.
  *---------------------------------------------------------------*/
 static inline void bio_set_region(struct bio *bio, unsigned region)
 {
@@ -331,21 +134,6 @@
 	}
 }
 
-/* FIXME Move this to bio.h? */
-static void zero_fill_bio(struct bio *bio)
-{
-	unsigned long flags;
-	struct bio_vec *bv;
-	int i;
-
-	bio_for_each_segment(bv, bio, i) {
-		char *data = bvec_kmap_irq(bv, &flags);
-		memset(data, 0, bv->bv_len);
-		flush_dcache_page(bv->bv_page);
-		bvec_kunmap_irq(data, &flags);
-	}
-}
-
 static int endio(struct bio *bio, unsigned int done, int error)
 {
 	struct io *io = (struct io *) bio->bi_private;
@@ -363,12 +151,6 @@
 	return 0;
 }
 
-static void bio_dtr(struct bio *bio)
-{
-	_bio_count--;
-	bio_set_free(&_bios, bio);
-}
-
 /*-----------------------------------------------------------------
  * These little objects provide an abstraction for getting a new
  * destination page for io.
@@ -477,13 +259,12 @@
 		 * bvec for bio_get/set_region().
 		 */
 		num_bvecs = (remaining / (PAGE_SIZE >> 9)) + 2;
-		_bio_count++;
-		bio = bio_set_alloc(&_bios, GFP_NOIO, num_bvecs);
+		bio = bio_alloc_bs(GFP_NOIO, num_bvecs, _bios);
 		bio->bi_sector = where->sector + (where->count - remaining);
 		bio->bi_bdev = where->bdev;
 		bio->bi_end_io = endio;
 		bio->bi_private = io;
-		bio->bi_destructor = bio_dtr;
+		/* bio->bi_destructor = bio_dtr; XXX */
 		bio_set_region(bio, region);
 
 		/*
diff -ur linux-2.6.11-rc1-original/drivers/md/dm-zero.c linux-2.6.11-rc1-bio/drivers/md/dm-zero.c
--- linux-2.6.11-rc1-original/drivers/md/dm-zero.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.11-rc1-bio/drivers/md/dm-zero.c	2005-01-19 17:20:27.000000000 -0800
@@ -24,23 +24,6 @@
 }
 
 /*
- * Fills the bio pages with zeros
- */
-static void zero_fill_bio(struct bio *bio)
-{
-	unsigned long flags;
-	struct bio_vec *bv;
-	int i;
-
-	bio_for_each_segment(bv, bio, i) {
-		char *data = bvec_kmap_irq(bv, &flags);
-		memset(data, 0, bv->bv_len);
-		flush_dcache_page(bv->bv_page);
-		bvec_kunmap_irq(data, &flags);
-	}
-}
-
-/*
  * Return zeros only on reads
  */
 static int zero_map(struct dm_target *ti, struct bio *bio,
diff -ur linux-2.6.11-rc1-original/fs/bio.c linux-2.6.11-rc1-bio/fs/bio.c
--- linux-2.6.11-rc1-original/fs/bio.c	2005-01-19 12:42:24.000000000 -0800
+++ linux-2.6.11-rc1-bio/fs/bio.c	2005-01-19 12:53:44.000000000 -0800
@@ -28,7 +28,6 @@
 
 #define BIO_POOL_SIZE 256
 
-static mempool_t *bio_pool;
 static kmem_cache_t *bio_slab;
 
 #define BIOVEC_NR_POOLS 6
@@ -40,11 +39,10 @@
 #define BIO_SPLIT_ENTRIES 8	
 mempool_t *bio_split_pool;
 
-struct biovec_pool {
+struct biovec_slab {
 	int nr_vecs;
 	char *name; 
 	kmem_cache_t *slab;
-	mempool_t *pool;
 };
 
 /*
@@ -54,15 +52,32 @@
  */
 
 #define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
-static struct biovec_pool bvec_array[BIOVEC_NR_POOLS] = {
+static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] = {
 	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
 };
 #undef BV
 
-static inline struct bio_vec *bvec_alloc(int gfp_mask, int nr, unsigned long *idx)
+/*
+ * bio_set is used to allow other portions of the IO system to
+ * allocate their own private memory pools for bio and iovec structures.
+ * These memory pools in turn all allocate from the bio_slab
+ * and the bvec_slabs[].
+ */
+struct bio_set {
+	mempool_t *bio_pool;
+	mempool_t *bvec_pools[BIOVEC_NR_POOLS];
+};
+
+/*
+ * fs_bio_set is the bio_set containing bio and iovec memory pools used by
+ * IO code that does not need private memory pools.
+ */
+static struct bio_set *fs_bio_set;
+
+static inline struct bio_vec *bvec_alloc_bs(int gfp_mask, int nr, unsigned long *idx, struct bio_set *bs)
 {
-	struct biovec_pool *bp;
 	struct bio_vec *bvl;
+	struct biovec_slab *bp;
 
 	/*
 	 * see comment near bvec_array define!
@@ -80,21 +95,22 @@
 	/*
 	 * idx now points to the pool we want to allocate from
 	 */
-	bp = bvec_array + *idx;
 
-	bvl = mempool_alloc(bp->pool, gfp_mask);
+	bp = bvec_slabs + *idx;
+	bvl = mempool_alloc(bs->bvec_pools[*idx], gfp_mask);
 	if (bvl)
 		memset(bvl, 0, bp->nr_vecs * sizeof(struct bio_vec));
+
 	return bvl;
 }
 
 /*
- * default destructor for a bio allocated with bio_alloc()
+ * default destructor for a bio allocated with bio_alloc_bs()
  */
 static void bio_destructor(struct bio *bio)
 {
 	const int pool_idx = BIO_POOL_IDX(bio);
-	struct biovec_pool *bp = bvec_array + pool_idx;
+	struct bio_set *bs = bio->bi_set;
 
 	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
 
@@ -102,9 +118,9 @@
 	 * cloned bio doesn't own the veclist
 	 */
 	if (!bio_flagged(bio, BIO_CLONED))
-		mempool_free(bio->bi_io_vec, bp->pool);
+		mempool_free(bio->bi_io_vec, bs->bvec_pools[pool_idx]);
 
-	mempool_free(bio, bio_pool);
+	mempool_free(bio, bs->bio_pool);
 }
 
 inline void bio_init(struct bio *bio)
@@ -126,18 +142,21 @@
 }
 
 /**
- * bio_alloc - allocate a bio for I/O
+ * bio_alloc_bs - allocate a bio for I/O
  * @gfp_mask:   the GFP_ mask given to the slab allocator
  * @nr_iovecs:	number of iovecs to pre-allocate
  *
  * Description:
- *   bio_alloc will first try it's on mempool to satisfy the allocation.
+ *   bio_alloc_bs will first try it's on mempool to satisfy the allocation.
  *   If %__GFP_WAIT is set then we will block on the internal pool waiting
  *   for a &struct bio to become free.
+ *
+ *   allocate bio and iovecs from the memory pools specified by the
+ *   bio_set structure.
  **/
-struct bio *bio_alloc(int gfp_mask, int nr_iovecs)
+struct bio *bio_alloc_bs(int gfp_mask, int nr_iovecs, struct bio_set *bs)
 {
-	struct bio *bio = mempool_alloc(bio_pool, gfp_mask);
+	struct bio *bio = mempool_alloc(bs->bio_pool, gfp_mask);
 
 	if (likely(bio)) {
 		struct bio_vec *bvl = NULL;
@@ -146,22 +165,28 @@
 		if (likely(nr_iovecs)) {
 			unsigned long idx;
 
-			bvl = bvec_alloc(gfp_mask, nr_iovecs, &idx);
+			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
 			if (unlikely(!bvl)) {
-				mempool_free(bio, bio_pool);
+				mempool_free(bio, bs->bio_pool);
 				bio = NULL;
 				goto out;
 			}
 			bio->bi_flags |= idx << BIO_POOL_OFFSET;
-			bio->bi_max_vecs = bvec_array[idx].nr_vecs;
+			bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
 		}
 		bio->bi_io_vec = bvl;
 		bio->bi_destructor = bio_destructor;
+		bio->bi_set = bs;
 	}
 out:
 	return bio;
 }
 
+struct bio *bio_alloc(int gfp_mask, int nr_iovecs)
+{
+	return bio_alloc_bs(gfp_mask, nr_iovecs, fs_bio_set);
+}
+
 /**
  * bio_put - release a reference to a bio
  * @bio:   bio to release reference to
@@ -248,7 +273,7 @@
  */
 struct bio *bio_clone(struct bio *bio, int gfp_mask)
 {
-	struct bio *b = bio_alloc(gfp_mask, 0);
+	struct bio *b = bio_alloc_bs(gfp_mask, 0, bio->bi_set);
 
 	if (b)
 		__bio_clone(b, bio);
@@ -919,11 +944,101 @@
 	kfree(bp);
 }
 
-static void __init biovec_init_pools(void)
+
+/*
+ * create memory pools for biovec's in a bio_set.
+ * use the global biovec slabs created for general use.
+ */
+static int biovec_create_pools(struct bio_set *bs, int pool_entries, int scale)
+{
+	int i;
+
+	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
+		struct biovec_slab *bp = bvec_slabs + i;
+		mempool_t **bvp = bs->bvec_pools + i;
+
+		if (i >= scale)
+			pool_entries >>= 1;
+
+		*bvp = mempool_create(pool_entries, mempool_alloc_slab,
+					mempool_free_slab, bp->slab);
+		if (!*bvp)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static void biovec_free_pools(struct bio_set *bs)
 {
-	int i, size, megabytes, pool_entries = BIO_POOL_SIZE;
+	int i;
+
+	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
+		mempool_t *bvp = bs->bvec_pools[i];
+
+		if (bvp)
+			mempool_destroy(bvp);
+	}
+	
+}
+
+void bioset_free(struct bio_set *bs)
+{
+	if (!bs->bio_pool)
+		mempool_destroy(bs->bio_pool);
+
+	biovec_free_pools(bs);
+
+	kfree(bs);
+}
+
+struct bio_set *bioset_create(int bio_pool_size, int bvec_pool_size, int scale)
+{
+	struct bio_set *bs = kmalloc(sizeof(*bs), GFP_KERNEL);
+
+	if (!bs)
+		return NULL;
+
+	memset(bs, 0, sizeof(*bs));
+	bs->bio_pool = mempool_create(bio_pool_size, mempool_alloc_slab,
+			mempool_free_slab, bio_slab);
+
+	if (!bs->bio_pool) 
+		goto bad;
+	
+	if (biovec_create_pools(bs, bvec_pool_size, scale))
+		goto bad;
+
+	return bs;
+
+bad:
+	bioset_free(bs);
+	return NULL;
+}
+
+static void __init biovec_init_slabs(void)
+{
+	int i;
+
+	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
+		int size;
+		struct biovec_slab *bvs = bvec_slabs + i;
+
+		size = bvs->nr_vecs * sizeof(struct bio_vec);
+		bvs->slab = kmem_cache_create(bvs->name, size, 0,
+                                SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+	}
+}
+
+static int __init init_bio(void)
+{
+	int megabytes, bvec_pool_entries;
 	int scale = BIOVEC_NR_POOLS;
 
+	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
+				SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+
+	biovec_init_slabs();
+
 	megabytes = nr_free_pages() >> (20 - PAGE_SHIFT);
 
 	/*
@@ -943,38 +1058,13 @@
 	/*
 	 * scale number of entries
 	 */
-	pool_entries = megabytes * 2;
-	if (pool_entries > 256)
-		pool_entries = 256;
-
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
-		struct biovec_pool *bp = bvec_array + i;
-
-		size = bp->nr_vecs * sizeof(struct bio_vec);
-
-		bp->slab = kmem_cache_create(bp->name, size, 0,
-				SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
-
-		if (i >= scale)
-			pool_entries >>= 1;
-
-		bp->pool = mempool_create(pool_entries, mempool_alloc_slab,
-					mempool_free_slab, bp->slab);
-		if (!bp->pool)
-			panic("biovec: can't init mempool\n");
-	}
-}
-
-static int __init init_bio(void)
-{
-	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
-				SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
-	bio_pool = mempool_create(BIO_POOL_SIZE, mempool_alloc_slab,
-				mempool_free_slab, bio_slab);
-	if (!bio_pool)
-		panic("bio: can't create mempool\n");
-
-	biovec_init_pools();
+	bvec_pool_entries = megabytes * 2;
+	if (bvec_pool_entries > 256)
+		bvec_pool_entries = 256;
+
+	fs_bio_set = bioset_create(BIO_POOL_SIZE, bvec_pool_entries, scale);
+	if (!fs_bio_set)
+		panic("bio: can't allocate bios\n");
 
 	bio_split_pool = mempool_create(BIO_SPLIT_ENTRIES,
 				bio_pair_alloc, bio_pair_free, NULL);
@@ -1003,3 +1093,6 @@
 EXPORT_SYMBOL(bio_split_pool);
 EXPORT_SYMBOL(bio_copy_user);
 EXPORT_SYMBOL(bio_uncopy_user);
+EXPORT_SYMBOL(bioset_create);
+EXPORT_SYMBOL(bioset_free);
+EXPORT_SYMBOL(bio_alloc_bs);
diff -ur linux-2.6.11-rc1-original/include/linux/bio.h linux-2.6.11-rc1-bio/include/linux/bio.h
--- linux-2.6.11-rc1-original/include/linux/bio.h	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.11-rc1-bio/include/linux/bio.h	2005-01-19 14:45:14.000000000 -0800
@@ -59,6 +59,7 @@
 	unsigned int	bv_offset;
 };
 
+struct bio_set;
 struct bio;
 typedef int (bio_end_io_t) (struct bio *, unsigned int, int);
 typedef void (bio_destructor_t) (struct bio *);
@@ -109,6 +110,7 @@
 	void			*bi_private;
 
 	bio_destructor_t	*bi_destructor;	/* destructor */
+	struct bio_set		*bi_set;	/* memory pools set */
 };
 
 /*
@@ -258,7 +260,11 @@
 extern mempool_t *bio_split_pool;
 extern void bio_pair_release(struct bio_pair *dbio);
 
+extern struct bio_set *bioset_create(int, int, int);
+extern void bioset_free(struct bio_set *);
+
 extern struct bio *bio_alloc(int, int);
+extern struct bio *bio_alloc_bs(int, int, struct bio_set *);
 extern void bio_put(struct bio *);
 
 extern void bio_endio(struct bio *, unsigned int, int);
@@ -329,4 +335,18 @@
 	__bio_kmap_irq((bio), (bio)->bi_idx, (flags))
 #define bio_kunmap_irq(buf,flags)	__bio_kunmap_irq(buf, flags)
 
+extern inline void zero_fill_bio(struct bio *bio)
+{
+	unsigned long flags;
+	struct bio_vec *bv;
+	int i;
+
+	bio_for_each_segment(bv, bio, i) {
+		char *data = bvec_kmap_irq(bv, &flags);
+		memset(data, 0, bv->bv_len);
+		flush_dcache_page(bv->bv_page);
+		bvec_kunmap_irq(data, &flags);
+	}
+}
+
 #endif /* __LINUX_BIO_H */
