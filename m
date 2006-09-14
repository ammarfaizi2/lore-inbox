Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWINVu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWINVu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWINVu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:50:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45529 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751242AbWINVu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:50:56 -0400
Date: Thu, 14 Sep 2006 22:50:41 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
       Christophe Saout <christophe@saout.de>
Subject: [PATCH 21/25] dm crypt: move io to workqueue
Message-ID: <20060914215041.GB3928@agk.surrey.redhat.com>
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
 
This patch is designed to help dm-crypt comply with the
new constraints imposed by the following patch in -mm:
  md-dm-reduce-stack-usage-with-stacked-block-devices.patch

Under low memory the existing implementation relies upon waiting for
I/O submitted recursively to generic_make_request() completing before
the original generic_make_request() call can return.

This patch moves the I/O submission to a workqueue so the original
generic_make_request() can return immediately.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Christophe Saout <christophe@saout.de>

Index: linux-2.6.18-rc7/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-crypt.c	2006-09-14 21:31:18.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-crypt.c	2006-09-14 21:31:20.000000000 +0100
@@ -34,6 +34,7 @@ struct crypt_io {
 	struct work_struct work;
 	atomic_t pending;
 	int error;
+	int post_process;
 };
 
 /*
@@ -441,8 +442,7 @@ static void dec_pending(struct crypt_io 
  * kcryptd:
  *
  * Needed because it would be very unwise to do decryption in an
- * interrupt context, so bios returning from read requests get
- * queued here.
+ * interrupt context.
  */
 static struct workqueue_struct *_kcryptd_workqueue;
 static void kcryptd_do_work(void *data);
@@ -466,12 +466,10 @@ static int crypt_endio(struct bio *clone
 	if (!read_io)
 		crypt_free_buffer_pages(cc, clone, done);
 
+	/* keep going - not finished yet */
 	if (unlikely(clone->bi_size))
 		return 1;
 
-	/*
-	 * successful reads are decrypted by the worker thread
-	 */
 	if (!read_io)
 		goto out;
 
@@ -481,6 +479,7 @@ static int crypt_endio(struct bio *clone
 	}
 
 	bio_put(clone);
+	io->post_process = 1;
 	kcryptd_queue_io(io);
 	return 0;
 
@@ -500,7 +499,7 @@ static void clone_init(struct crypt_io *
 	clone->bi_rw      = io->base_bio->bi_rw;
 }
 
-static int process_read(struct crypt_io *io)
+static void process_read(struct crypt_io *io)
 {
 	struct crypt_config *cc = io->target->private;
 	struct bio *base_bio = io->base_bio;
@@ -517,7 +516,7 @@ static int process_read(struct crypt_io 
 	clone = bio_alloc(GFP_NOIO, bio_segments(base_bio));
 	if (unlikely(!clone)) {
 		dec_pending(io, -ENOMEM);
-		return 0;
+		return;
 	}
 
 	clone_init(io, clone);
@@ -529,11 +528,9 @@ static int process_read(struct crypt_io 
 	       sizeof(struct bio_vec) * clone->bi_vcnt);
 
 	generic_make_request(clone);
-
-	return 0;
 }
 
-static int process_write(struct crypt_io *io)
+static void process_write(struct crypt_io *io)
 {
 	struct crypt_config *cc = io->target->private;
 	struct bio *base_bio = io->base_bio;
@@ -554,15 +551,18 @@ static int process_write(struct crypt_io
 	while (remaining) {
 		clone = crypt_alloc_buffer(cc, base_bio->bi_size,
 					   io->first_clone, &bvec_idx);
-		if (unlikely(!clone))
-			goto cleanup;
+		if (unlikely(!clone)) {
+			dec_pending(io, -ENOMEM);
+			return;
+		}
 
 		ctx.bio_out = clone;
 
 		if (unlikely(crypt_convert(cc, &ctx) < 0)) {
 			crypt_free_buffer_pages(cc, clone, clone->bi_size);
 			bio_put(clone);
-			goto cleanup;
+			dec_pending(io, -EIO);
+			return;
 		}
 
 		clone_init(io, clone);
@@ -578,31 +578,20 @@ static int process_write(struct crypt_io
 			io->first_clone = clone;
 		}
 
-		atomic_inc(&io->pending);
-
 		remaining -= clone->bi_size;
 		sector += bio_sectors(clone);
 
+		/* prevent bio_put of first_clone */
+		if (remaining)
+			atomic_inc(&io->pending);
+
 		generic_make_request(clone);
 
 		/* out of memory -> run queues */
 		if (remaining)
 			blk_congestion_wait(bio_data_dir(clone), HZ/100);
-	}
 
-	/* drop reference, clones could have returned before we reach this */
-	dec_pending(io, 0);
-	return 0;
-
-cleanup:
-	if (io->first_clone) {
-		dec_pending(io, -ENOMEM);
-		return 0;
 	}
-
-	 /* if no bio has been dispatched yet, we can directly return the error */
-	mempool_free(io, cc->io_pool);
-	return -ENOMEM;
 }
 
 static void process_read_endio(struct crypt_io *io)
@@ -620,7 +609,12 @@ static void kcryptd_do_work(void *data)
 {
 	struct crypt_io *io = data;
 
-	process_read_endio(io);
+	if (io->post_process)
+		process_read_endio(io);
+	else if (bio_data_dir(io->base_bio) == READ)
+		process_read(io);
+	else
+		process_write(io);
 }
 
 /*
@@ -892,17 +886,14 @@ static int crypt_map(struct dm_target *t
 	struct crypt_io *io;
 
 	io = mempool_alloc(cc->io_pool, GFP_NOIO);
-
 	io->target = ti;
 	io->base_bio = bio;
 	io->first_clone = NULL;
-	io->error = 0;
+	io->error = io->post_process = 0;
 	atomic_set(&io->pending, 0);
+	kcryptd_queue_io(io);
 
-	if (bio_data_dir(bio) == WRITE)
-		return process_write(io);
-
-	return process_read(io);
+	return 0;
 }
 
 static int crypt_status(struct dm_target *ti, status_type_t type,
@@ -1011,7 +1002,7 @@ error:
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version= {1, 2, 0},
+	.version= {1, 3, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
