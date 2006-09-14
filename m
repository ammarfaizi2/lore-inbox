Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWINVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWINVuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWINVuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:50:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10457 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751232AbWINVuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:50:15 -0400
Date: Thu, 14 Sep 2006 22:50:04 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
       Christophe Saout <christophe@saout.de>
Subject: [PATCH 19/25] dm crypt: restructure for workqueue change
Message-ID: <20060914215004.GA3928@agk.surrey.redhat.com>
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

Restructure part of the dm-crypt code in preparation
for workqueue changes.

Use 'base_bio' or 'clone' variable names consistently throughout.
No functional changes are included in this patch.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Christophe Saout <christophe@saout.de>

Index: linux-2.6.18-rc7/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-crypt.c	2006-09-14 20:20:20.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-crypt.c	2006-09-14 20:20:21.000000000 +0100
@@ -29,7 +29,7 @@
  */
 struct crypt_io {
 	struct dm_target *target;
-	struct bio *bio;
+	struct bio *base_bio;
 	struct bio *first_clone;
 	struct work_struct work;
 	atomic_t pending;
@@ -315,7 +315,7 @@ static struct bio *
 crypt_alloc_buffer(struct crypt_config *cc, unsigned int size,
                    struct bio *base_bio, unsigned int *bio_vec_idx)
 {
-	struct bio *bio;
+	struct bio *clone;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
 	unsigned int i;
@@ -326,23 +326,23 @@ crypt_alloc_buffer(struct crypt_config *
 	 * FIXME: Is this really intelligent?
 	 */
 	if (base_bio)
-		bio = bio_clone(base_bio, GFP_NOIO|__GFP_NOMEMALLOC);
+		clone = bio_clone(base_bio, GFP_NOIO|__GFP_NOMEMALLOC);
 	else
-		bio = bio_alloc(GFP_NOIO|__GFP_NOMEMALLOC, nr_iovecs);
-	if (!bio)
+		clone = bio_alloc(GFP_NOIO|__GFP_NOMEMALLOC, nr_iovecs);
+	if (!clone)
 		return NULL;
 
 	/* if the last bio was not complete, continue where that one ended */
-	bio->bi_idx = *bio_vec_idx;
-	bio->bi_vcnt = *bio_vec_idx;
-	bio->bi_size = 0;
-	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
+	clone->bi_idx = *bio_vec_idx;
+	clone->bi_vcnt = *bio_vec_idx;
+	clone->bi_size = 0;
+	clone->bi_flags &= ~(1 << BIO_SEG_VALID);
 
-	/* bio->bi_idx pages have already been allocated */
-	size -= bio->bi_idx * PAGE_SIZE;
+	/* clone->bi_idx pages have already been allocated */
+	size -= clone->bi_idx * PAGE_SIZE;
 
-	for(i = bio->bi_idx; i < nr_iovecs; i++) {
-		struct bio_vec *bv = bio_iovec_idx(bio, i);
+	for (i = clone->bi_idx; i < nr_iovecs; i++) {
+		struct bio_vec *bv = bio_iovec_idx(clone, i);
 
 		bv->bv_page = mempool_alloc(cc->page_pool, gfp_mask);
 		if (!bv->bv_page)
@@ -353,7 +353,7 @@ crypt_alloc_buffer(struct crypt_config *
 		 * return a partially allocated bio, the caller will then try
 		 * to allocate additional bios while submitting this partial bio
 		 */
-		if ((i - bio->bi_idx) == (MIN_BIO_PAGES - 1))
+		if ((i - clone->bi_idx) == (MIN_BIO_PAGES - 1))
 			gfp_mask = (gfp_mask | __GFP_NOWARN) & ~__GFP_WAIT;
 
 		bv->bv_offset = 0;
@@ -362,13 +362,13 @@ crypt_alloc_buffer(struct crypt_config *
 		else
 			bv->bv_len = size;
 
-		bio->bi_size += bv->bv_len;
-		bio->bi_vcnt++;
+		clone->bi_size += bv->bv_len;
+		clone->bi_vcnt++;
 		size -= bv->bv_len;
 	}
 
-	if (!bio->bi_size) {
-		bio_put(bio);
+	if (!clone->bi_size) {
+		bio_put(clone);
 		return NULL;
 	}
 
@@ -376,13 +376,13 @@ crypt_alloc_buffer(struct crypt_config *
 	 * Remember the last bio_vec allocated to be able
 	 * to correctly continue after the splitting.
 	 */
-	*bio_vec_idx = bio->bi_vcnt;
+	*bio_vec_idx = clone->bi_vcnt;
 
-	return bio;
+	return clone;
 }
 
 static void crypt_free_buffer_pages(struct crypt_config *cc,
-                                    struct bio *bio, unsigned int bytes)
+                                    struct bio *clone, unsigned int bytes)
 {
 	unsigned int i, start, end;
 	struct bio_vec *bv;
@@ -396,19 +396,19 @@ static void crypt_free_buffer_pages(stru
 	 * A fix to the bi_idx issue in the kernel is in the works, so
 	 * we will hopefully be able to revert to the cleaner solution soon.
 	 */
-	i = bio->bi_vcnt - 1;
-	bv = bio_iovec_idx(bio, i);
-	end = (i << PAGE_SHIFT) + (bv->bv_offset + bv->bv_len) - bio->bi_size;
+	i = clone->bi_vcnt - 1;
+	bv = bio_iovec_idx(clone, i);
+	end = (i << PAGE_SHIFT) + (bv->bv_offset + bv->bv_len) - clone->bi_size;
 	start = end - bytes;
 
 	start >>= PAGE_SHIFT;
-	if (!bio->bi_size)
-		end = bio->bi_vcnt;
+	if (!clone->bi_size)
+		end = clone->bi_vcnt;
 	else
 		end >>= PAGE_SHIFT;
 
-	for(i = start; i < end; i++) {
-		bv = bio_iovec_idx(bio, i);
+	for (i = start; i < end; i++) {
+		bv = bio_iovec_idx(clone, i);
 		BUG_ON(!bv->bv_page);
 		mempool_free(bv->bv_page, cc->page_pool);
 		bv->bv_page = NULL;
@@ -432,7 +432,7 @@ static void dec_pending(struct crypt_io 
 	if (io->first_clone)
 		bio_put(io->first_clone);
 
-	bio_endio(io->bio, io->bio->bi_size, io->error);
+	bio_endio(io->base_bio, io->base_bio->bi_size, io->error);
 
 	mempool_free(io, cc->io_pool);
 }
@@ -445,25 +445,133 @@ static void dec_pending(struct crypt_io 
  * queued here.
  */
 static struct workqueue_struct *_kcryptd_workqueue;
+static void kcryptd_do_work(void *data);
 
-static void kcryptd_do_work(void *data)
+static void kcryptd_queue_io(struct crypt_io *io)
 {
-	struct crypt_io *io = (struct crypt_io *) data;
-	struct crypt_config *cc = (struct crypt_config *) io->target->private;
+	INIT_WORK(&io->work, kcryptd_do_work, io);
+	queue_work(_kcryptd_workqueue, &io->work);
+}
+
+static int crypt_endio(struct bio *clone, unsigned int done, int error)
+{
+	struct crypt_io *io = clone->bi_private;
+	struct crypt_config *cc = io->target->private;
+	unsigned read_io = bio_data_dir(clone) == READ;
+
+	/*
+	 * free the processed pages, even if
+	 * it's only a partially completed write
+	 */
+	if (!read_io)
+		crypt_free_buffer_pages(cc, clone, done);
+
+	if (unlikely(clone->bi_size))
+		return 1;
+
+	/*
+	 * successful reads are decrypted by the worker thread
+	 */
+	if (!read_io)
+		goto out;
+
+	if (unlikely(!bio_flagged(clone, BIO_UPTODATE))) {
+		error = -EIO;
+		goto out;
+	}
+
+	bio_put(clone);
+	kcryptd_queue_io(io);
+	return 0;
+
+out:
+	bio_put(clone);
+	dec_pending(io, error);
+	return error;
+}
+
+static void clone_init(struct crypt_io *io, struct bio *clone)
+{
+	struct crypt_config *cc = io->target->private;
+
+	clone->bi_private = io;
+	clone->bi_end_io  = crypt_endio;
+	clone->bi_bdev    = cc->dev->bdev;
+	clone->bi_rw      = io->base_bio->bi_rw;
+}
+
+static struct bio *clone_read(struct crypt_io *io,
+			      sector_t sector)
+{
+	struct crypt_config *cc = io->target->private;
+	struct bio *base_bio = io->base_bio;
+	struct bio *clone;
+
+	/*
+	 * The block layer might modify the bvec array, so always
+	 * copy the required bvecs because we need the original
+	 * one in order to decrypt the whole bio data *afterwards*.
+	 */
+	clone = bio_alloc(GFP_NOIO, bio_segments(base_bio));
+	if (unlikely(!clone))
+		return NULL;
+
+	clone_init(io, clone);
+	clone->bi_idx = 0;
+	clone->bi_vcnt = bio_segments(base_bio);
+	clone->bi_size = base_bio->bi_size;
+	memcpy(clone->bi_io_vec, bio_iovec(base_bio),
+	       sizeof(struct bio_vec) * clone->bi_vcnt);
+	clone->bi_sector = cc->start + sector;
+
+	return clone;
+}
+
+static struct bio *clone_write(struct crypt_io *io,
+			       sector_t sector,
+			       unsigned *bvec_idx,
+			       struct convert_context *ctx)
+{
+	struct crypt_config *cc = io->target->private;
+	struct bio *base_bio = io->base_bio;
+	struct bio *clone;
+
+	clone = crypt_alloc_buffer(cc, base_bio->bi_size,
+				   io->first_clone, bvec_idx);
+	if (!clone)
+		return NULL;
+
+	ctx->bio_out = clone;
+
+	if (unlikely(crypt_convert(cc, ctx) < 0)) {
+		crypt_free_buffer_pages(cc, clone,
+		                        clone->bi_size);
+		bio_put(clone);
+		return NULL;
+	}
+
+	clone_init(io, clone);
+	clone->bi_sector = cc->start + sector;
+
+	return clone;
+}
+
+static void process_read_endio(struct crypt_io *io)
+{
+	struct crypt_config *cc = io->target->private;
 	struct convert_context ctx;
-	int r;
 
-	crypt_convert_init(cc, &ctx, io->bio, io->bio,
-	                   io->bio->bi_sector - io->target->begin, 0);
-	r = crypt_convert(cc, &ctx);
+	crypt_convert_init(cc, &ctx, io->base_bio, io->base_bio,
+			   io->base_bio->bi_sector - io->target->begin, 0);
 
-	dec_pending(io, r);
+	dec_pending(io, crypt_convert(cc, &ctx));
 }
 
-static void kcryptd_queue_io(struct crypt_io *io)
+static void kcryptd_do_work(void *data)
 {
-	INIT_WORK(&io->work, kcryptd_do_work, io);
-	queue_work(_kcryptd_workqueue, &io->work);
+	struct crypt_io *io = data;
+
+	process_read_endio(io);
 }
 
 /*
@@ -477,7 +585,7 @@ static int crypt_decode_key(u8 *key, cha
 
 	buffer[2] = '\0';
 
-	for(i = 0; i < size; i++) {
+	for (i = 0; i < size; i++) {
 		buffer[0] = *hex++;
 		buffer[1] = *hex++;
 
@@ -500,7 +608,7 @@ static void crypt_encode_key(char *hex, 
 {
 	unsigned int i;
 
-	for(i = 0; i < size; i++) {
+	for (i = 0; i < size; i++) {
 		sprintf(hex, "%02x", *key);
 		hex += 2;
 		key++;
@@ -728,88 +836,10 @@ static void crypt_dtr(struct dm_target *
 	kfree(cc);
 }
 
-static int crypt_endio(struct bio *bio, unsigned int done, int error)
-{
-	struct crypt_io *io = (struct crypt_io *) bio->bi_private;
-	struct crypt_config *cc = (struct crypt_config *) io->target->private;
-
-	if (bio_data_dir(bio) == WRITE) {
-		/*
-		 * free the processed pages, even if
-		 * it's only a partially completed write
-		 */
-		crypt_free_buffer_pages(cc, bio, done);
-	}
-
-	if (bio->bi_size)
-		return 1;
-
-	bio_put(bio);
-
-	/*
-	 * successful reads are decrypted by the worker thread
-	 */
-	if ((bio_data_dir(bio) == READ)
-	    && bio_flagged(bio, BIO_UPTODATE)) {
-		kcryptd_queue_io(io);
-		return 0;
-	}
-
-	dec_pending(io, error);
-	return error;
-}
-
-static inline struct bio *
-crypt_clone(struct crypt_config *cc, struct crypt_io *io, struct bio *bio,
-            sector_t sector, unsigned int *bvec_idx,
-            struct convert_context *ctx)
-{
-	struct bio *clone;
-
-	if (bio_data_dir(bio) == WRITE) {
-		clone = crypt_alloc_buffer(cc, bio->bi_size,
-                                 io->first_clone, bvec_idx);
-		if (clone) {
-			ctx->bio_out = clone;
-			if (crypt_convert(cc, ctx) < 0) {
-				crypt_free_buffer_pages(cc, clone,
-				                        clone->bi_size);
-				bio_put(clone);
-				return NULL;
-			}
-		}
-	} else {
-		/*
-		 * The block layer might modify the bvec array, so always
-		 * copy the required bvecs because we need the original
-		 * one in order to decrypt the whole bio data *afterwards*.
-		 */
-		clone = bio_alloc(GFP_NOIO, bio_segments(bio));
-		if (clone) {
-			clone->bi_idx = 0;
-			clone->bi_vcnt = bio_segments(bio);
-			clone->bi_size = bio->bi_size;
-			memcpy(clone->bi_io_vec, bio_iovec(bio),
-			       sizeof(struct bio_vec) * clone->bi_vcnt);
-		}
-	}
-
-	if (!clone)
-		return NULL;
-
-	clone->bi_private = io;
-	clone->bi_end_io = crypt_endio;
-	clone->bi_bdev = cc->dev->bdev;
-	clone->bi_sector = cc->start + sector;
-	clone->bi_rw = bio->bi_rw;
-
-	return clone;
-}
-
 static int crypt_map(struct dm_target *ti, struct bio *bio,
 		     union map_info *map_context)
 {
-	struct crypt_config *cc = (struct crypt_config *) ti->private;
+	struct crypt_config *cc = ti->private;
 	struct crypt_io *io;
 	struct convert_context ctx;
 	struct bio *clone;
@@ -819,7 +849,7 @@ static int crypt_map(struct dm_target *t
 
 	io = mempool_alloc(cc->io_pool, GFP_NOIO);
 	io->target = ti;
-	io->bio = bio;
+	io->base_bio = bio;
 	io->first_clone = NULL;
 	io->error = 0;
 	atomic_set(&io->pending, 1); /* hold a reference */
@@ -832,7 +862,10 @@ static int crypt_map(struct dm_target *t
 	 * so repeat the whole process until all the data can be handled.
 	 */
 	while (remaining) {
-		clone = crypt_clone(cc, io, bio, sector, &bvec_idx, &ctx);
+		if (bio_data_dir(bio) == WRITE)
+			clone = clone_write(io, sector, &bvec_idx, &ctx);
+		else
+			clone = clone_read(io, sector);
 		if (!clone)
 			goto cleanup;
 
