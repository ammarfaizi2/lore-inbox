Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760481AbWLFKzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760481AbWLFKzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760484AbWLFKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:55:42 -0500
Received: from brick.kernel.dk ([62.242.22.158]:1670 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760481AbWLFKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:55:41 -0500
Date: Wed, 6 Dec 2006 11:56:29 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up single bio_vec allocation
Message-ID: <20061206105629.GR4392@kernel.dk>
References: <20061204200645.GN4392@kernel.dk> <000601c717e3$f098a8a0$2589030a@amr.corp.intel.com> <20061204204351.GO4392@kernel.dk> <20061206100847.GP4392@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206100847.GP4392@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06 2006, Jens Axboe wrote:
> I still can't help but think we can do better than this, and that this
> is nothing more than optimizing for a benchmark. For high performance
> I/O, you will be doing > 1 page bio's anyway and this patch wont help
> you at all. Perhaps we can just kill bio_vec slabs completely, and
> create bio slabs instead with differing sizes. So instead of having 1
> bio slab and 5 bio_vec slabs, change that to 5 bio slabs that leave room
> for the bio_vec list at the end. That would always eliminate the extra
> allocation, at the cost of blowing the 256-page case into a order 1 page
> allocation (256*16 + sizeof(*bio) > PAGE_SIZE) for the 4kb 64-bit archs,
> which is something I've always tried to avoid.

That would look something like this. You'd probably want to re-tweak the
slab sizes now, so that we get the most out of the slab page. If we
accept the 2^1 order allocation for the largest bio, we can make it
larger than 256 pages at no extra cost. Probably around 500 pages would
still fit inside the two pages.

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 08a40f4..b4bf3b3 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -813,7 +813,7 @@ static int crypt_ctr(struct dm_target *t
 		goto bad4;
 	}
 
-	cc->bs = bioset_create(MIN_IOS, MIN_IOS, 4);
+	cc->bs = bioset_create(MIN_IOS, 4);
 	if (!cc->bs) {
 		ti->error = "Cannot allocate crypt bioset";
 		goto bad_bs;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index da663d2..581c24a 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -60,7 +60,7 @@ static int resize_pool(unsigned int new_
 		if (!_io_pool)
 			return -ENOMEM;
 
-		_bios = bioset_create(16, 16, 4);
+		_bios = bioset_create(16, 4);
 		if (!_bios) {
 			mempool_destroy(_io_pool);
 			_io_pool = NULL;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fc4f743..98f6768 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -973,7 +973,7 @@ static struct mapped_device *alloc_dev(i
 	if (!md->tio_pool)
 		goto bad3;
 
-	md->bs = bioset_create(16, 16, 4);
+	md->bs = bioset_create(16, 4);
 	if (!md->bs)
 		goto bad_no_bioset;
 
diff --git a/fs/bio.c b/fs/bio.c
index aa4d09b..452e8f7 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -30,10 +30,6 @@
 
 #define BIO_POOL_SIZE 256
 
-static kmem_cache_t *bio_slab __read_mostly;
-
-#define BIOVEC_NR_POOLS 6
-
 /*
  * a small number of entries is fine, not going to be performance critical.
  * basically we just need to survive
@@ -41,23 +37,23 @@ static kmem_cache_t *bio_slab __read_mos
 #define BIO_SPLIT_ENTRIES 8	
 mempool_t *bio_split_pool __read_mostly;
 
-struct biovec_slab {
+struct bio_slab {
 	int nr_vecs;
-	char *name; 
+	const char *name;
 	kmem_cache_t *slab;
 };
 
-/*
- * if you change this list, also change bvec_alloc or things will
- * break badly! cannot be bigger than what you can fit into an
- * unsigned short
- */
-
-#define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
-static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] __read_mostly = {
-	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
+#define BIOSLAB_NR_POOLS 6
+#define BIOSLAB(x) { .nr_vecs = x, .name = "bio-"__stringify(x) }
+static struct bio_slab bio_slabs[BIOSLAB_NR_POOLS] __read_mostly = {
+	BIOSLAB(0),
+	BIOSLAB(4),
+	BIOSLAB(16),
+	BIOSLAB(64),
+	BIOSLAB(128),
+	BIOSLAB(BIO_MAX_PAGES),
 };
-#undef BV
+#undef BIOSLAB
 
 /*
  * bio_set is used to allow other portions of the IO system to
@@ -66,8 +62,7 @@ static struct biovec_slab bvec_slabs[BIO
  * and the bvec_slabs[].
  */
 struct bio_set {
-	mempool_t *bio_pool;
-	mempool_t *bvec_pools[BIOVEC_NR_POOLS];
+	mempool_t *bio_pools[BIOSLAB_NR_POOLS];
 };
 
 /*
@@ -76,45 +71,12 @@ struct bio_set {
  */
 static struct bio_set *fs_bio_set;
 
-static inline struct bio_vec *bvec_alloc_bs(gfp_t gfp_mask, int nr, unsigned long *idx, struct bio_set *bs)
-{
-	struct bio_vec *bvl;
-
-	/*
-	 * see comment near bvec_array define!
-	 */
-	switch (nr) {
-		case   1        : *idx = 0; break;
-		case   2 ...   4: *idx = 1; break;
-		case   5 ...  16: *idx = 2; break;
-		case  17 ...  64: *idx = 3; break;
-		case  65 ... 128: *idx = 4; break;
-		case 129 ... BIO_MAX_PAGES: *idx = 5; break;
-		default:
-			return NULL;
-	}
-	/*
-	 * idx now points to the pool we want to allocate from
-	 */
-
-	bvl = mempool_alloc(bs->bvec_pools[*idx], gfp_mask);
-	if (bvl) {
-		struct biovec_slab *bp = bvec_slabs + *idx;
-
-		memset(bvl, 0, bp->nr_vecs * sizeof(struct bio_vec));
-	}
-
-	return bvl;
-}
-
 void bio_free(struct bio *bio, struct bio_set *bio_set)
 {
 	const int pool_idx = BIO_POOL_IDX(bio);
 
-	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
-
-	mempool_free(bio->bi_io_vec, bio_set->bvec_pools[pool_idx]);
-	mempool_free(bio, bio_set->bio_pool);
+	BIO_BUG_ON(pool_idx >= BIOSLAB_NR_POOLS);
+	mempool_free(bio, bio_set->bio_pools[pool_idx]);
 }
 
 /*
@@ -160,26 +122,51 @@ void bio_init(struct bio *bio)
  **/
 struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
 {
-	struct bio *bio = mempool_alloc(bs->bio_pool, gfp_mask);
+	struct bio *bio = NULL;
+	long idx;
+
+	switch (nr_iovecs) {
+	case   0:
+		idx = 0;
+		break;
+	case   1 ...   4:
+		idx = 1;
+		break;
+	case   5 ...  16:
+		idx = 2;
+		break;
+	case  17 ...  64:
+		idx = 3;
+		break;
+	case  65 ... 128:
+		idx = 4;
+		break;
+	case 129 ... BIO_MAX_PAGES:
+		idx = 5;
+		break;
+	default:
+		goto out;
+	}
+
+	bio = mempool_alloc(bs->bio_pools[idx], gfp_mask);
 
 	if (likely(bio)) {
 		struct bio_vec *bvl = NULL;
 
 		bio_init(bio);
-		if (likely(nr_iovecs)) {
-			unsigned long idx = 0; /* shut up gcc */
-
-			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
-			if (unlikely(!bvl)) {
-				mempool_free(bio, bs->bio_pool);
-				bio = NULL;
-				goto out;
-			}
+
+		if (nr_iovecs) {
+			struct bio_slab *bslab = &bio_slabs[idx];
+
+			bvl = (void *) bio + sizeof(*bio);
+			memset(bvl, 0, bslab->nr_vecs * sizeof(struct bio_vec));
+
 			bio->bi_flags |= idx << BIO_POOL_OFFSET;
-			bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
+			bio->bi_max_vecs = bslab->nr_vecs;
 		}
 		bio->bi_io_vec = bvl;
 	}
+
 out:
 	return bio;
 }
@@ -1120,89 +1107,78 @@ struct bio_pair *bio_split(struct bio *b
  * create memory pools for biovec's in a bio_set.
  * use the global biovec slabs created for general use.
  */
-static int biovec_create_pools(struct bio_set *bs, int pool_entries, int scale)
+static int bio_create_pools(struct bio_set *bs, int pool_entries, int scale)
 {
 	int i;
 
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
-		struct biovec_slab *bp = bvec_slabs + i;
-		mempool_t **bvp = bs->bvec_pools + i;
+	for (i = 0; i < BIOSLAB_NR_POOLS; i++) {
+		struct bio_slab *bslab = bio_slabs + i;
+		mempool_t **bvp = bs->bio_pools + i;
 
 		if (pool_entries > 1 && i >= scale)
 			pool_entries >>= 1;
 
-		*bvp = mempool_create_slab_pool(pool_entries, bp->slab);
+		*bvp = mempool_create_slab_pool(pool_entries, bslab->slab);
 		if (!*bvp)
 			return -ENOMEM;
 	}
 	return 0;
 }
 
-static void biovec_free_pools(struct bio_set *bs)
+static void bio_free_pools(struct bio_set *bs)
 {
 	int i;
 
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
-		mempool_t *bvp = bs->bvec_pools[i];
+	for (i = 0; i < BIOSLAB_NR_POOLS; i++) {
+		mempool_t *bp = bs->bio_pools[i];
 
-		if (bvp)
-			mempool_destroy(bvp);
+		if (bp)
+			mempool_destroy(bp);
 	}
 
 }
 
 void bioset_free(struct bio_set *bs)
 {
-	if (bs->bio_pool)
-		mempool_destroy(bs->bio_pool);
-
-	biovec_free_pools(bs);
+	bio_free_pools(bs);
 
 	kfree(bs);
 }
 
-struct bio_set *bioset_create(int bio_pool_size, int bvec_pool_size, int scale)
+struct bio_set *bioset_create(int bio_pool_size, int scale)
 {
 	struct bio_set *bs = kzalloc(sizeof(*bs), GFP_KERNEL);
 
 	if (!bs)
 		return NULL;
 
-	bs->bio_pool = mempool_create_slab_pool(bio_pool_size, bio_slab);
-	if (!bs->bio_pool)
-		goto bad;
-
-	if (!biovec_create_pools(bs, bvec_pool_size, scale))
+	if (!bio_create_pools(bs, bio_pool_size, scale))
 		return bs;
 
-bad:
 	bioset_free(bs);
 	return NULL;
 }
 
-static void __init biovec_init_slabs(void)
+static void __init bio_init_slabs(void)
 {
 	int i;
 
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
+	for (i = 0; i < BIOSLAB_NR_POOLS; i++) {
 		int size;
-		struct biovec_slab *bvs = bvec_slabs + i;
+		struct bio_slab *bs = bio_slabs + i;
 
-		size = bvs->nr_vecs * sizeof(struct bio_vec);
-		bvs->slab = kmem_cache_create(bvs->name, size, 0,
-                                SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+		size = bs->nr_vecs * sizeof(struct bio_vec) + sizeof(struct bio);
+		bs->slab = kmem_cache_create(bs->name, size, 0, SLAB_PANIC,
+						NULL, NULL);
 	}
 }
 
 static int __init init_bio(void)
 {
-	int megabytes, bvec_pool_entries;
-	int scale = BIOVEC_NR_POOLS;
-
-	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
-				SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+	int scale = BIOSLAB_NR_POOLS;
+	int megabytes;
 
-	biovec_init_slabs();
+	bio_init_slabs();
 
 	megabytes = nr_free_pages() >> (20 - PAGE_SHIFT);
 
@@ -1225,9 +1201,8 @@ static int __init init_bio(void)
 	 * the system is completely unable to allocate memory, so we only
 	 * need enough to make progress.
 	 */
-	bvec_pool_entries = 1 + scale;
 
-	fs_bio_set = bioset_create(BIO_POOL_SIZE, bvec_pool_entries, scale);
+	fs_bio_set = bioset_create(BIO_POOL_SIZE, scale);
 	if (!fs_bio_set)
 		panic("bio: can't allocate bios\n");
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 092dbd0..d6d0047 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -276,7 +276,7 @@ extern struct bio_pair *bio_split(struct
 extern mempool_t *bio_split_pool;
 extern void bio_pair_release(struct bio_pair *dbio);
 
-extern struct bio_set *bioset_create(int, int, int);
+extern struct bio_set *bioset_create(int, int);
 extern void bioset_free(struct bio_set *);
 
 extern struct bio *bio_alloc(gfp_t, int);

-- 
Jens Axboe

