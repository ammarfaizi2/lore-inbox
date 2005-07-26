Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVGZADh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGZADh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVGZADh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:03:37 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:43488 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261508AbVGZADg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:03:36 -0400
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kill bio->bi_set
References: <20050720222949.GE2548@suse.de> <m34qaljnvd.fsf@telia.com>
	<20050723205956.GA17370@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Jul 2005 02:03:09 +0200
In-Reply-To: <20050723205956.GA17370@suse.de>
Message-ID: <m37jfea0xu.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Sat, Jul 23 2005, Peter Osterlund wrote:
> > Jens Axboe <axboe@suse.de> writes:
> > 
> > > Dunno why I didn't notice before, but ->bi_set is totally unnecessary
> > > bloat of struct bio. Just define a proper destructor for the bio and it
> > > already knows what bio_set it belongs too.
> > 
> > This causes crashes on my computer.
> 
> Did I neglect to mention it was untested? :)
...
> Thanks, I'll go over these and submit a fixed version.

I fixed this myself. The patch below is tested with dm-crypt on top of
pktcdvd on top of usb-storage, and worked fine in my tests.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/md/dm-io.c  |    6 ++++++
 drivers/md/dm.c     |    6 ++++++
 fs/bio.c            |   32 +++++++++++++++++++++-----------
 include/linux/bio.h |    2 +-
 4 files changed, 34 insertions(+), 12 deletions(-)

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
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -399,6 +399,11 @@ struct clone_info {
 	unsigned short idx;
 };
 
+static void dm_bio_destructor(struct bio *bio)
+{
+	bio_free(bio, dm_set);
+}
+
 /*
  * Creates a little bio that is just does part of a bvec.
  */
@@ -410,6 +415,7 @@ static struct bio *split_bvec(struct bio
 	struct bio_vec *bv = bio->bi_io_vec + idx;
 
 	clone = bio_alloc_bioset(GFP_NOIO, 1, dm_set);
+	clone->bi_destructor = dm_bio_destructor;
 	*clone->bi_io_vec = *bv;
 
 	clone->bi_sector = sector;
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
+	mempool_free(bio->bi_io_vec, bio_set->bvec_pools[pool_idx]);
+	mempool_free(bio, bio_set->bio_pool);
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
@@ -276,8 +283,10 @@ struct bio *bio_clone(struct bio *bio, u
 {
 	struct bio *b = bio_alloc_bioset(gfp_mask, bio->bi_max_vecs, fs_bio_set);
 
-	if (b)
+	if (b) {
+		b->bi_destructor = bio_fs_destructor;
 		__bio_clone(b, bio);
+	}
 
 	return b;
 }
@@ -1078,6 +1087,7 @@ subsys_initcall(init_bio);
 
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
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
