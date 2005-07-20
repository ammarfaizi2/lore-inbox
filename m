Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVGUDcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVGUDcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 23:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVGUDcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 23:32:52 -0400
Received: from [216.208.38.107] ([216.208.38.107]:24716 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261600AbVGUDcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 23:32:51 -0400
Date: Thu, 21 Jul 2005 00:29:49 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, dmo@osdl.org
Subject: [PATCH] kill bio->bi_set
Message-ID: <20050720222949.GE2548@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dunno why I didn't notice before, but ->bi_set is totally unnecessary
bloat of struct bio. Just define a proper destructor for the bio and it
already knows what bio_set it belongs too.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -239,6 +239,11 @@ static void vm_dp_init(struct dpages *dp
 	dp->context_ptr = data;
 }
 
+static void dm_bio_destructor(struct bio *bio)
+{
+	bio_free(bio, _bios);
+}
+
 /*-----------------------------------------------------------------
  * IO routines that accept a list of pages.
  *---------------------------------------------------------------*/
@@ -263,6 +268,7 @@ static void do_region(int rw, unsigned i
 		bio->bi_bdev = where->bdev;
 		bio->bi_end_io = endio;
 		bio->bi_private = io;
+		bio->bi_destructor = dm_bio_destructor;
 		bio_set_region(bio, region);
 
 		/*
diff --git a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -104,18 +104,22 @@ static inline struct bio_vec *bvec_alloc
 	return bvl;
 }
 
-/*
- * default destructor for a bio allocated with bio_alloc_bioset()
- */
-static void bio_destructor(struct bio *bio)
+void bio_free(struct bio *bio, struct bio_set *bio_set)
 {
 	const int pool_idx = BIO_POOL_IDX(bio);
-	struct bio_set *bs = bio->bi_set;
 
 	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);
 
-	mempool_free(bio->bi_io_vec, bs->bvec_pools[pool_idx]);
-	mempool_free(bio, bs->bio_pool);
+	mempool_free(bio->bi_io_vec, fs_bio_set->bvec_pools[pool_idx]);
+	mempool_free(bio, fs_bio_set->bio_pool);
+}
+
+/*
+ * default destructor for a bio allocated with bio_alloc_bioset()
+ */
+static void bio_fs_destructor(struct bio *bio)
+{
+	bio_free(bio, fs_bio_set);
 }
 
 inline void bio_init(struct bio *bio)
@@ -171,8 +175,6 @@ struct bio *bio_alloc_bioset(unsigned in
 			bio->bi_max_vecs = bvec_slabs[idx].nr_vecs;
 		}
 		bio->bi_io_vec = bvl;
-		bio->bi_destructor = bio_destructor;
-		bio->bi_set = bs;
 	}
 out:
 	return bio;
@@ -180,7 +182,12 @@ out:
 
 struct bio *bio_alloc(unsigned int __nocast gfp_mask, int nr_iovecs)
 {
-	return bio_alloc_bioset(gfp_mask, nr_iovecs, fs_bio_set);
+	struct bio *bio = bio_alloc_bioset(gfp_mask, nr_iovecs, fs_bio_set);
+
+	if (bio)
+		bio->bi_destructor = bio_fs_destructor;
+
+	return bio;
 }
 
 void zero_fill_bio(struct bio *bio)
@@ -1078,6 +1085,7 @@ subsys_initcall(init_bio);
 
 EXPORT_SYMBOL(bio_alloc);
 EXPORT_SYMBOL(bio_put);
+EXPORT_SYMBOL(bio_free);
 EXPORT_SYMBOL(bio_endio);
 EXPORT_SYMBOL(bio_init);
 EXPORT_SYMBOL(__bio_clone);
diff --git a/include/linux/bio.h b/include/linux/bio.h
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -111,7 +111,6 @@ struct bio {
 	void			*bi_private;
 
 	bio_destructor_t	*bi_destructor;	/* destructor */
-	struct bio_set		*bi_set;	/* memory pools set */
 };
 
 /*
@@ -280,6 +279,7 @@ extern void bioset_free(struct bio_set *
 extern struct bio *bio_alloc(unsigned int __nocast, int);
 extern struct bio *bio_alloc_bioset(unsigned int __nocast, int, struct bio_set *);
 extern void bio_put(struct bio *);
+extern void bio_free(struct bio *, struct bio_set *);
 
 extern void bio_endio(struct bio *, unsigned int, int);
 struct request_queue;

-- 
Jens Axboe

