Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760434AbWLFKIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760434AbWLFKIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760435AbWLFKIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:08:02 -0500
Received: from brick.kernel.dk ([62.242.22.158]:12918 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760434AbWLFKIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:08:00 -0500
Date: Wed, 6 Dec 2006 11:08:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up single bio_vec allocation
Message-ID: <20061206100847.GP4392@kernel.dk>
References: <20061204200645.GN4392@kernel.dk> <000601c717e3$f098a8a0$2589030a@amr.corp.intel.com> <20061204204351.GO4392@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204351.GO4392@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04 2006, Jens Axboe wrote:
> On Mon, Dec 04 2006, Chen, Kenneth W wrote:
> > > [...]
> > > 
> > > Another idea would be to kill SLAB_HWCACHE_ALIGN (it's pretty pointless,
> > > I bet), and always alloc sizeof(*bio) + sizeof(*bvl) in one go when a
> > > bio is allocated. It doesn't add a lot of overhead even for the case
> > > where we do > 1 page bios, and it gets rid of the dual allocation for
> > > the 1 page bio.
> > 
> > I will try that too.  I'm a bit touchy about sharing a cache line for
> > different bio.  But given that there are 200,000 I/O per second we are
> > currently pushing the kernel, the chances of two cpu working on two
> > bio that sits in the same cache line are pretty small.
> 
> Yep I really think so. Besides, it's not like we are repeatedly writing
> to these objects in the first place.

This is what I had in mind, in case it wasn't completely clear. Not
tested, other than it compiles. Basically it eliminates the small
bio_vec pool, and grows the bio by 16-bytes on 64-bit archs, or by
12-bytes on 32-bit archs instead and uses the room at the end for the
bio_vec structure.

I still can't help but think we can do better than this, and that this
is nothing more than optimizing for a benchmark. For high performance
I/O, you will be doing > 1 page bio's anyway and this patch wont help
you at all. Perhaps we can just kill bio_vec slabs completely, and
create bio slabs instead with differing sizes. So instead of having 1
bio slab and 5 bio_vec slabs, change that to 5 bio slabs that leave room
for the bio_vec list at the end. That would always eliminate the extra
allocation, at the cost of blowing the 256-page case into a order 1 page
allocation (256*16 + sizeof(*bio) > PAGE_SIZE) for the 4kb 64-bit archs,
which is something I've always tried to avoid.


diff --git a/fs/bio.c b/fs/bio.c
index aa4d09b..94b5e05 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -32,7 +32,7 @@
 
 static kmem_cache_t *bio_slab __read_mostly;
 
-#define BIOVEC_NR_POOLS 6
+#define BIOVEC_NR_POOLS 5
 
 /*
  * a small number of entries is fine, not going to be performance critical.
@@ -55,7 +55,7 @@ struct biovec_slab {
 
 #define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
 static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] __read_mostly = {
-	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
+	BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
 };
 #undef BV
 
@@ -76,7 +76,8 @@ struct bio_set {
  */
 static struct bio_set *fs_bio_set;
 
-static inline struct bio_vec *bvec_alloc_bs(gfp_t gfp_mask, int nr, unsigned long *idx, struct bio_set *bs)
+static struct bio_vec *bvec_alloc_bs(gfp_t gfp_mask, int nr, unsigned long *idx,
+				     struct bio_set *bs)
 {
 	struct bio_vec *bvl;
 
@@ -84,15 +85,25 @@ static inline struct bio_vec *bvec_alloc
 	 * see comment near bvec_array define!
 	 */
 	switch (nr) {
-		case   1        : *idx = 0; break;
-		case   2 ...   4: *idx = 1; break;
-		case   5 ...  16: *idx = 2; break;
-		case  17 ...  64: *idx = 3; break;
-		case  65 ... 128: *idx = 4; break;
-		case 129 ... BIO_MAX_PAGES: *idx = 5; break;
-		default:
-			return NULL;
+	case   2 ...   4:
+		*idx = 0;
+		break;
+	case   5 ...  16:
+		*idx = 1;
+		break;
+	case  17 ...  64:
+		*idx = 2;
+		break;
+	case  65 ... 128:
+		*idx = 3;
+		break;
+	case 129 ... BIO_MAX_PAGES:
+		*idx = 4;
+		break;
+	default:
+		return NULL;
 	}
+
 	/*
 	 * idx now points to the pool we want to allocate from
 	 */
@@ -109,11 +120,13 @@ static inline struct bio_vec *bvec_alloc
 
 void bio_free(struct bio *bio, struct bio_set *bio_set)
 {
-	const int pool_idx = BIO_POOL_IDX(bio);
+	if ((bio->bi_flags & (1 << BIO_BVL_EMBED)) == 0) {
+		const int pool_idx = BIO_POOL_IDX(bio);
 
-	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
+		BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
+		mempool_free(bio->bi_io_vec, bio_set->bvec_pools[pool_idx]);
+	}
 
-	mempool_free(bio->bi_io_vec, bio_set->bvec_pools[pool_idx]);
 	mempool_free(bio, bio_set->bio_pool);
 }
 
@@ -166,7 +179,13 @@ struct bio *bio_alloc_bioset(gfp_t gfp_m
 		struct bio_vec *bvl = NULL;
 
 		bio_init(bio);
-		if (likely(nr_iovecs)) {
+
+		if (nr_iovecs == 1) {
+			bvl = (void *) bio + sizeof(*bio);
+			memset(bvl, 0, sizeof(*bvl));
+			bio->bi_flags |= 1 << BIO_BVL_EMBED;
+			bio->bi_max_vecs = 1;
+		} else if (nr_iovecs) {
 			unsigned long idx = 0; /* shut up gcc */
 
 			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
@@ -1189,8 +1208,8 @@ static void __init biovec_init_slabs(voi
 		struct biovec_slab *bvs = bvec_slabs + i;
 
 		size = bvs->nr_vecs * sizeof(struct bio_vec);
-		bvs->slab = kmem_cache_create(bvs->name, size, 0,
-                                SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+		bvs->slab = kmem_cache_create(bvs->name, size, 0, SLAB_PANIC,
+						NULL, NULL);
 	}
 }
 
@@ -1199,8 +1218,7 @@ static int __init init_bio(void)
 	int megabytes, bvec_pool_entries;
 	int scale = BIOVEC_NR_POOLS;
 
-	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
-				SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+	bio_slab = kmem_cache_create("bio", sizeof(struct bio) + sizeof(struct bio_vec), 0, SLAB_PANIC, NULL, NULL);
 
 	biovec_init_slabs();
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 092dbd0..7cf7c5c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -125,6 +125,7 @@ struct bio {
 #define BIO_BOUNCED	5	/* bio is a bounce bio */
 #define BIO_USER_MAPPED 6	/* contains user pages */
 #define BIO_EOPNOTSUPP	7	/* not supported */
+#define BIO_BVL_EMBED	8	/* bvl embedded in bio */
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*

-- 
Jens Axboe

