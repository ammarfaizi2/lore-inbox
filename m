Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWINVv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWINVv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWINVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:51:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751234AbWINVvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:51:25 -0400
Date: Thu, 14 Sep 2006 22:51:18 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
       Christophe Saout <christophe@saout.de>
Subject: [PATCH 22/25] dm crypt: use private biosets
Message-ID: <20060914215118.GC3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Milan Broz <mbroz@redhat.com>,
	Christophe Saout <christophe@saout.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

In the low memory situation dm-crypt needs to use
a private mempool of bios to avoid blocking.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Christophe Saout <christophe@saout.de>

Index: linux-2.6.18-rc7/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-crypt.c	2006-09-14 21:31:20.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-crypt.c	2006-09-14 21:33:07.000000000 +0100
@@ -76,6 +76,7 @@ struct crypt_config {
 	 */
 	mempool_t *io_pool;
 	mempool_t *page_pool;
+	struct bio_set *bs;
 
 	/*
 	 * crypto related data
@@ -92,7 +93,7 @@ struct crypt_config {
 	u8 key[0];
 };
 
-#define MIN_IOS        256
+#define MIN_IOS        16
 #define MIN_POOL_PAGES 32
 #define MIN_BIO_PAGES  8
 
@@ -307,6 +308,14 @@ static int crypt_convert(struct crypt_co
 	return r;
 }
 
+ static void dm_crypt_bio_destructor(struct bio *bio)
+ {
+	struct crypt_io *io = bio->bi_private;
+	struct crypt_config *cc = io->target->private;
+
+	bio_free(bio, cc->bs);
+ }
+
 /*
  * Generate a new unfragmented bio with the given size
  * This should never violate the device limitations
@@ -321,18 +330,17 @@ crypt_alloc_buffer(struct crypt_config *
 	gfp_t gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
 	unsigned int i;
 
-	/*
-	 * Use __GFP_NOMEMALLOC to tell the VM to act less aggressively and
-	 * to fail earlier.  This is not necessary but increases throughput.
-	 * FIXME: Is this really intelligent?
-	 */
-	if (base_bio)
-		clone = bio_clone(base_bio, GFP_NOIO|__GFP_NOMEMALLOC);
-	else
-		clone = bio_alloc(GFP_NOIO|__GFP_NOMEMALLOC, nr_iovecs);
+	if (base_bio) {
+		clone = bio_alloc_bioset(GFP_NOIO, base_bio->bi_max_vecs, cc->bs);
+		__bio_clone(clone, base_bio);
+	} else
+		clone = bio_alloc_bioset(GFP_NOIO, nr_iovecs, cc->bs);
+
 	if (!clone)
 		return NULL;
 
+	clone->bi_destructor = dm_crypt_bio_destructor;
+
 	/* if the last bio was not complete, continue where that one ended */
 	clone->bi_idx = *bio_vec_idx;
 	clone->bi_vcnt = *bio_vec_idx;
@@ -513,13 +521,14 @@ static void process_read(struct crypt_io
 	 * copy the required bvecs because we need the original
 	 * one in order to decrypt the whole bio data *afterwards*.
 	 */
-	clone = bio_alloc(GFP_NOIO, bio_segments(base_bio));
+	clone = bio_alloc_bioset(GFP_NOIO, bio_segments(base_bio), cc->bs);
 	if (unlikely(!clone)) {
 		dec_pending(io, -ENOMEM);
 		return;
 	}
 
 	clone_init(io, clone);
+	clone->bi_destructor = dm_crypt_bio_destructor;
 	clone->bi_idx = 0;
 	clone->bi_vcnt = bio_segments(base_bio);
 	clone->bi_size = base_bio->bi_size;
@@ -590,7 +599,6 @@ static void process_write(struct crypt_i
 		/* out of memory -> run queues */
 		if (remaining)
 			blk_congestion_wait(bio_data_dir(clone), HZ/100);
-
 	}
 }
 
@@ -807,6 +815,12 @@ static int crypt_ctr(struct dm_target *t
 		goto bad4;
 	}
 
+	cc->bs = bioset_create(MIN_IOS, MIN_IOS, 4);
+	if (!cc->bs) {
+		ti->error = "Cannot allocate crypt bioset";
+		goto bad_bs;
+	}
+
 	if (tfm->crt_cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
 		ti->error = "Error setting key";
 		goto bad5;
@@ -846,6 +860,8 @@ static int crypt_ctr(struct dm_target *t
 	return 0;
 
 bad5:
+	bioset_free(cc->bs);
+bad_bs:
 	mempool_destroy(cc->page_pool);
 bad4:
 	mempool_destroy(cc->io_pool);
@@ -865,6 +881,7 @@ static void crypt_dtr(struct dm_target *
 {
 	struct crypt_config *cc = (struct crypt_config *) ti->private;
 
+	bioset_free(cc->bs);
 	mempool_destroy(cc->page_pool);
 	mempool_destroy(cc->io_pool);
 
