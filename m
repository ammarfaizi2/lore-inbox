Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWIPEIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWIPEIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 00:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWIPEIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 00:08:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48784 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932416AbWIPEIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 00:08:51 -0400
From: michaelc@cs.wisc.edu
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 1/2] block: support larger block pc requests take 2
Reply-To: michaelc@cs.wisc.edu
Date: Fri, 15 Sep 2006 23:08:35 -0400
Message-Id: <11583761161108-git-send-email-michaelc@cs.wisc.edu>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch modifies blk_rq_map/unmap_user() so that it supports
requests larger than bio by chaning them together.

Changes since v1.
1. Removed blk_get_bounced_bio() function. blk_rq_unmap_user
checks the bounced flag and if set access bi_private.

2. Removed biohead_orig field from request.
Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 block/ll_rw_blk.c      |  166 ++++++++++++++++++++++++++++++++++++------------
 fs/bio.c               |   18 +----
 include/linux/blkdev.h |    7 +-
 3 files changed, 132 insertions(+), 59 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 5c8c7d7..e7de1ee 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2278,6 +2278,84 @@ void blk_insert_request(request_queue_t 
 
 EXPORT_SYMBOL(blk_insert_request);
 
+static int __blk_rq_unmap_user(struct bio *bio)
+{
+	int ret = 0;
+
+	if (bio) {
+		if (bio_flagged(bio, BIO_USER_MAPPED))
+			bio_unmap_user(bio);
+		else
+			ret = bio_uncopy_user(bio);
+	}
+
+	return ret;
+}
+
+static int __blk_rq_map_user(request_queue_t *q, struct request *rq,
+			     void __user *ubuf, unsigned int len)
+{
+	unsigned long uaddr;
+	struct bio *bio, *orig_bio;
+	int reading, ret;
+
+	reading = rq_data_dir(rq) == READ;
+
+	/*
+	 * if alignment requirement is satisfied, map in user pages for
+	 * direct dma. else, set up kernel bounce buffers
+	 */
+	uaddr = (unsigned long) ubuf;
+	if (!(uaddr & queue_dma_alignment(q)) && !(len & queue_dma_alignment(q)))
+		bio = bio_map_user(q, NULL, uaddr, len, reading);
+	else
+		bio = bio_copy_user(q, uaddr, len, reading);
+
+	if (IS_ERR(bio)) {
+		return PTR_ERR(bio);
+	}
+
+	orig_bio = bio;
+	blk_queue_bounce(q, &bio);
+	/*
+	 * We link the bounce buffer in and could have to traverse it
+	 * later so we have to get a ref to prevent it from being freed
+	 */
+	bio_get(bio);
+
+	/*
+	 * for most (all? don't know of any) queues we could
+	 * skip grabbing the queue lock here. only drivers with
+	 * funky private ->back_merge_fn() function could be
+	 * problematic.
+	 */
+	spin_lock_irq(q->queue_lock);
+	if (!rq->bio)
+		blk_rq_bio_prep(q, rq, bio);
+	else if (!q->back_merge_fn(q, rq, bio)) {
+		ret = -EINVAL;
+		spin_unlock_irq(q->queue_lock);
+		goto unmap_bio;
+	} else {
+		rq->biotail->bi_next = bio;
+		rq->biotail = bio;
+
+		rq->nr_sectors += bio_sectors(bio);
+		rq->hard_nr_sectors = rq->nr_sectors;
+		rq->data_len += bio->bi_size;
+	}
+	spin_unlock_irq(q->queue_lock);
+
+	return bio->bi_size;
+
+unmap_bio:
+	/* if it was boucned we must call the end io function */
+	bio_endio(bio, bio->bi_size, 0);
+	__blk_rq_unmap_user(orig_bio);
+	bio_put(bio);
+	return ret;
+}
+
 /**
  * blk_rq_map_user - map user data to a request, for REQ_BLOCK_PC usage
  * @q:		request queue where request should be inserted
@@ -2299,42 +2377,44 @@ EXPORT_SYMBOL(blk_insert_request);
  *    unmapping.
  */
 int blk_rq_map_user(request_queue_t *q, struct request *rq, void __user *ubuf,
-		    unsigned int len)
+		    unsigned long len)
 {
-	unsigned long uaddr;
-	struct bio *bio;
-	int reading;
+	unsigned long bytes_read = 0;
+	int ret;
 
 	if (len > (q->max_hw_sectors << 9))
 		return -EINVAL;
 	if (!len || !ubuf)
 		return -EINVAL;
 
-	reading = rq_data_dir(rq) == READ;
+	while (bytes_read != len) {
+		unsigned long map_len, end, start;
 
-	/*
-	 * if alignment requirement is satisfied, map in user pages for
-	 * direct dma. else, set up kernel bounce buffers
-	 */
-	uaddr = (unsigned long) ubuf;
-	if (!(uaddr & queue_dma_alignment(q)) && !(len & queue_dma_alignment(q)))
-		bio = bio_map_user(q, NULL, uaddr, len, reading);
-	else
-		bio = bio_copy_user(q, uaddr, len, reading);
+		map_len = min_t(unsigned long, len - bytes_read, BIO_MAX_SIZE);
+		end = ((unsigned long)ubuf + map_len + PAGE_SIZE - 1)
+								>> PAGE_SHIFT;
+		start = (unsigned long)ubuf >> PAGE_SHIFT;
 
-	if (!IS_ERR(bio)) {
-		rq->bio = rq->biotail = bio;
-		blk_rq_bio_prep(q, rq, bio);
+		/*
+		 * A bad offset could cause us to require BIO_MAX_PAGES + 1
+		 * pages. If this happens we just lower the requested
+		 * mapping len by a page so that we can fit
+		 */
+		if (end - start > BIO_MAX_PAGES)
+			map_len -= PAGE_SIZE;
 
-		rq->buffer = rq->data = NULL;
-		rq->data_len = len;
-		return 0;
+		ret = __blk_rq_map_user(q, rq, ubuf, map_len);
+		if (ret < 0)
+			goto unmap_rq;
+		bytes_read += ret;
+		ubuf += ret;
 	}
 
-	/*
-	 * bio is the err-ptr
-	 */
-	return PTR_ERR(bio);
+	rq->buffer = rq->data = NULL;
+	return 0;
+unmap_rq:
+	blk_rq_unmap_user(rq);
+	return ret;
 }
 
 EXPORT_SYMBOL(blk_rq_map_user);
@@ -2360,7 +2440,7 @@ EXPORT_SYMBOL(blk_rq_map_user);
  *    unmapping.
  */
 int blk_rq_map_user_iov(request_queue_t *q, struct request *rq,
-			struct sg_iovec *iov, int iov_count)
+			struct sg_iovec *iov, int iov_count, unsigned int len)
 {
 	struct bio *bio;
 
@@ -2374,10 +2454,15 @@ int blk_rq_map_user_iov(request_queue_t 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	rq->bio = rq->biotail = bio;
+	if (bio->bi_size != len) {
+		bio_endio(bio, bio->bi_size, 0);
+		bio_unmap_user(bio);
+		return -EINVAL;
+	}
+
+	bio_get(bio);
 	blk_rq_bio_prep(q, rq, bio);
 	rq->buffer = rq->data = NULL;
-	rq->data_len = bio->bi_size;
 	return 0;
 }
 
@@ -2385,23 +2470,26 @@ EXPORT_SYMBOL(blk_rq_map_user_iov);
 
 /**
  * blk_rq_unmap_user - unmap a request with user data
- * @bio:	bio to be unmapped
- * @ulen:	length of user buffer
+ * @rq:		rq to be unmapped
  *
  * Description:
- *    Unmap a bio previously mapped by blk_rq_map_user().
+ *    Unmap a rq previously mapped by blk_rq_map_user().
+ *    rq->bio must be set to the original head of the request.
  */
-int blk_rq_unmap_user(struct bio *bio, unsigned int ulen)
+int blk_rq_unmap_user(struct request *rq)
 {
-	int ret = 0;
+	struct bio *bio, *mapped_bio;
 
-	if (bio) {
-		if (bio_flagged(bio, BIO_USER_MAPPED))
-			bio_unmap_user(bio);
+	while ((bio = rq->bio)) {
+		if (bio_flagged(bio, BIO_BOUNCED))
+			mapped_bio = bio->bi_private;
 		else
-			ret = bio_uncopy_user(bio);
-	}
+			mapped_bio = bio;
 
+		__blk_rq_unmap_user(mapped_bio);
+		rq->bio = bio->bi_next;
+		bio_put(bio);
+	}
 	return 0;
 }
 
@@ -2432,11 +2520,8 @@ int blk_rq_map_kern(request_queue_t *q, 
 	if (rq_data_dir(rq) == WRITE)
 		bio->bi_rw |= (1 << BIO_RW);
 
-	rq->bio = rq->biotail = bio;
 	blk_rq_bio_prep(q, rq, bio);
-
 	rq->buffer = rq->data = NULL;
-	rq->data_len = len;
 	return 0;
 }
 
@@ -3469,6 +3554,7 @@ void blk_rq_bio_prep(request_queue_t *q,
 	rq->hard_cur_sectors = rq->current_nr_sectors;
 	rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
 	rq->buffer = bio_data(bio);
+	rq->data_len = bio->bi_size;
 
 	rq->bio = rq->biotail = bio;
 }
diff --git a/fs/bio.c b/fs/bio.c
index 6a0b9ad..9abf256 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -559,10 +559,8 @@ struct bio *bio_copy_user(request_queue_
 			break;
 		}
 
-		if (bio_add_pc_page(q, bio, page, bytes, 0) < bytes) {
-			ret = -EINVAL;
+		if (bio_add_pc_page(q, bio, page, bytes, 0) < bytes)
 			break;
-		}
 
 		len -= bytes;
 	}
@@ -750,7 +748,6 @@ struct bio *bio_map_user_iov(request_que
 			     int write_to_vm)
 {
 	struct bio *bio;
-	int len = 0, i;
 
 	bio = __bio_map_user_iov(q, bdev, iov, iov_count, write_to_vm);
 
@@ -765,18 +762,7 @@ struct bio *bio_map_user_iov(request_que
 	 */
 	bio_get(bio);
 
-	for (i = 0; i < iov_count; i++)
-		len += iov[i].iov_len;
-
-	if (bio->bi_size == len)
-		return bio;
-
-	/*
-	 * don't support partial mappings
-	 */
-	bio_endio(bio, bio->bi_size, 0);
-	bio_unmap_user(bio);
-	return ERR_PTR(-EINVAL);
+	return bio;
 }
 
 static void __bio_unmap_user(struct bio *bio)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f38ad35..17d3f68 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -638,10 +638,11 @@ extern void blk_sync_queue(struct reques
 extern void __blk_stop_queue(request_queue_t *q);
 extern void blk_run_queue(request_queue_t *);
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
-extern int blk_rq_map_user(request_queue_t *, struct request *, void __user *, unsigned int);
-extern int blk_rq_unmap_user(struct bio *, unsigned int);
+extern int blk_rq_map_user(request_queue_t *, struct request *, void __user *, unsigned long);
+extern int blk_rq_unmap_user(struct request *);
 extern int blk_rq_map_kern(request_queue_t *, struct request *, void *, unsigned int, gfp_t);
-extern int blk_rq_map_user_iov(request_queue_t *, struct request *, struct sg_iovec *, int);
+extern int blk_rq_map_user_iov(request_queue_t *, struct request *,
+			       struct sg_iovec *, int, unsigned int);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *,
 			  struct request *, int);
 extern void blk_execute_rq_nowait(request_queue_t *, struct gendisk *,
-- 
1.4.1

