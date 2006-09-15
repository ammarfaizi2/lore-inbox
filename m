Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWIOMb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWIOMb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWIOMb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:31:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63461 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751319AbWIOMbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:31:55 -0400
Date: Fri, 15 Sep 2006 13:31:37 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
       Christophe Saout <christophe@saout.de>
Subject: [PATCH 20/25] dm crypt: restructure write processing
Message-ID: <20060915123137.GG3928@agk.surrey.redhat.com>
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
 
Restructure the dm-crypt write processing in preparation
for workqueue changes in the next patches.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Christophe Saout <christophe@saout.de>

Index: linux-2.6.18-rc7/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-crypt.c	2006-09-14 20:20:21.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-crypt.c	2006-09-14 20:20:23.000000000 +0100
@@ -500,12 +500,14 @@ static void clone_init(struct crypt_io *
 	clone->bi_rw      = io->base_bio->bi_rw;
 }
 
-static struct bio *clone_read(struct crypt_io *io,
-			      sector_t sector)
+static int process_read(struct crypt_io *io)
 {
 	struct crypt_config *cc = io->target->private;
 	struct bio *base_bio = io->base_bio;
 	struct bio *clone;
+	sector_t sector = base_bio->bi_sector - io->target->begin;
+
+	atomic_inc(&io->pending);
 
 	/*
 	 * The block layer might modify the bvec array, so always
@@ -513,47 +515,94 @@ static struct bio *clone_read(struct cry
 	 * one in order to decrypt the whole bio data *afterwards*.
 	 */
 	clone = bio_alloc(GFP_NOIO, bio_segments(base_bio));
-	if (unlikely(!clone))
-		return NULL;
+	if (unlikely(!clone)) {
+		dec_pending(io, -ENOMEM);
+		return 0;
+	}
 
 	clone_init(io, clone);
 	clone->bi_idx = 0;
 	clone->bi_vcnt = bio_segments(base_bio);
 	clone->bi_size = base_bio->bi_size;
+	clone->bi_sector = cc->start + sector;
 	memcpy(clone->bi_io_vec, bio_iovec(base_bio),
 	       sizeof(struct bio_vec) * clone->bi_vcnt);
-	clone->bi_sector = cc->start + sector;
 
-	return clone;
+	generic_make_request(clone);
+
+	return 0;
 }
 
-static struct bio *clone_write(struct crypt_io *io,
-			       sector_t sector,
-			       unsigned *bvec_idx,
-			       struct convert_context *ctx)
+static int process_write(struct crypt_io *io)
 {
 	struct crypt_config *cc = io->target->private;
 	struct bio *base_bio = io->base_bio;
 	struct bio *clone;
+	struct convert_context ctx;
+	unsigned remaining = base_bio->bi_size;
+	sector_t sector = base_bio->bi_sector - io->target->begin;
+	unsigned bvec_idx = 0;
+
+	atomic_inc(&io->pending);
+
+	crypt_convert_init(cc, &ctx, NULL, base_bio, sector, 1);
+
+	/*
+	 * The allocated buffers can be smaller than the whole bio,
+	 * so repeat the whole process until all the data can be handled.
+	 */
+	while (remaining) {
+		clone = crypt_alloc_buffer(cc, base_bio->bi_size,
+					   io->first_clone, &bvec_idx);
+		if (unlikely(!clone))
+			goto cleanup;
+
+		ctx.bio_out = clone;
+
+		if (unlikely(crypt_convert(cc, &ctx) < 0)) {
+			crypt_free_buffer_pages(cc, clone, clone->bi_size);
+			bio_put(clone);
+			goto cleanup;
+		}
+
+		clone_init(io, clone);
+		clone->bi_sector = cc->start + sector;
+
+		if (!io->first_clone) {
+			/*
+			 * hold a reference to the first clone, because it
+			 * holds the bio_vec array and that can't be freed
+			 * before all other clones are released
+			 */
+			bio_get(clone);
+			io->first_clone = clone;
+		}
+
+		atomic_inc(&io->pending);
+
+		remaining -= clone->bi_size;
+		sector += bio_sectors(clone);
 
-	clone = crypt_alloc_buffer(cc, base_bio->bi_size,
-				   io->first_clone, bvec_idx);
-	if (!clone)
-		return NULL;
-
-	ctx->bio_out = clone;
-
-	if (unlikely(crypt_convert(cc, ctx) < 0)) {
-		crypt_free_buffer_pages(cc, clone,
-		                        clone->bi_size);
-		bio_put(clone);
-		return NULL;
+		generic_make_request(clone);
+
+		/* out of memory -> run queues */
+		if (remaining)
+			blk_congestion_wait(bio_data_dir(clone), HZ/100);
 	}
 
-	clone_init(io, clone);
-	clone->bi_sector = cc->start + sector;
+	/* drop reference, clones could have returned before we reach this */
+	dec_pending(io, 0);
+	return 0;
+
+cleanup:
+	if (io->first_clone) {
+		dec_pending(io, -ENOMEM);
+		return 0;
+	}
 
-	return clone;
+	 /* if no bio has been dispatched yet, we can directly return the error */
+	mempool_free(io, cc->io_pool);
+	return -ENOMEM;
 }
 
 static void process_read_endio(struct crypt_io *io)
@@ -841,68 +890,19 @@ static int crypt_map(struct dm_target *t
 {
 	struct crypt_config *cc = ti->private;
 	struct crypt_io *io;
-	struct convert_context ctx;
-	struct bio *clone;
-	unsigned int remaining = bio->bi_size;
-	sector_t sector = bio->bi_sector - ti->begin;
-	unsigned int bvec_idx = 0;
 
 	io = mempool_alloc(cc->io_pool, GFP_NOIO);
+
 	io->target = ti;
 	io->base_bio = bio;
 	io->first_clone = NULL;
 	io->error = 0;
-	atomic_set(&io->pending, 1); /* hold a reference */
+	atomic_set(&io->pending, 0);
 
 	if (bio_data_dir(bio) == WRITE)
-		crypt_convert_init(cc, &ctx, NULL, bio, sector, 1);
-
-	/*
-	 * The allocated buffers can be smaller than the whole bio,
-	 * so repeat the whole process until all the data can be handled.
-	 */
-	while (remaining) {
-		if (bio_data_dir(bio) == WRITE)
-			clone = clone_write(io, sector, &bvec_idx, &ctx);
-		else
-			clone = clone_read(io, sector);
-		if (!clone)
-			goto cleanup;
-
-		if (!io->first_clone) {
-			/*
-			 * hold a reference to the first clone, because it
-			 * holds the bio_vec array and that can't be freed
-			 * before all other clones are released
-			 */
-			bio_get(clone);
-			io->first_clone = clone;
-		}
-		atomic_inc(&io->pending);
-
-		remaining -= clone->bi_size;
-		sector += bio_sectors(clone);
-
-		generic_make_request(clone);
-
-		/* out of memory -> run queues */
-		if (remaining)
-			blk_congestion_wait(bio_data_dir(clone), HZ/100);
-	}
+		return process_write(io);
 
-	/* drop reference, clones could have returned before we reach this */
-	dec_pending(io, 0);
-	return 0;
-
-cleanup:
-	if (io->first_clone) {
-		dec_pending(io, -ENOMEM);
-		return 0;
-	}
-
-	/* if no bio has been dispatched yet, we can directly return the error */
-	mempool_free(io, cc->io_pool);
-	return -ENOMEM;
+	return process_read(io);
 }
 
 static int crypt_status(struct dm_target *ti, status_type_t type,
