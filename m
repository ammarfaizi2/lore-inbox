Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWIIVxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWIIVxg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWIIVxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 17:53:36 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:42404 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964873AbWIIVxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:53:35 -0400
Subject: [PATCH 1/2] block: Modify blk_rq_map_user to support large requests
From: Mike Christie <michaelc@cs.wisc.edu>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de
Content-Type: text/plain
Date: Sat, 09 Sep 2006 16:53:41 -0400
Message-Id: <1157835221.4543.10.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is some duplication between bsg, scsi_ioctl.c
and scsi_lib.c/sg/st in its mapping code. This patch modifies
the block layer blk_rq_map_user code to support large requests so
that the scsi and block drivers can use this common code. The
changes also make it so the callers do not have to account for
the bio to be unmapped and bounce buffers.

The next patch then coverts bsg.c, scsi_ioctl.c and cdrom.c
to use the updated functions. For scsi_ioctl.c and cdrom.c
the only thing that changes is that they no longer have
to do the bounce buffer management and pass in the len for
the unmapping. The bsg change is a little larger since that
code was duplicating a lot of code that is now common
in the block layer. The bsg conversions als should fix
a memory leak caused when unmapping a hdr with iovec_count=0.

Patch was made over Jens's block tree and the bsg branch

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

---
 block/ll_rw_blk.c      |  169 ++++++++++++++++++++++++++++++++++++------------
 fs/bio.c               |   18 +----
 include/linux/blkdev.h |   16 +++--
 mm/highmem.c           |    7 ++
 4 files changed, 148 insertions(+), 62 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 5c8c7d7..26a32a7 100644
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
@@ -2299,42 +2377,45 @@ EXPORT_SYMBOL(blk_insert_request);
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
+	rq->bio = rq->biohead_orig = NULL;
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
@@ -2360,7 +2441,7 @@ EXPORT_SYMBOL(blk_rq_map_user);
  *    unmapping.
  */
 int blk_rq_map_user_iov(request_queue_t *q, struct request *rq,
-			struct sg_iovec *iov, int iov_count)
+			struct sg_iovec *iov, int iov_count, unsigned int len)
 {
 	struct bio *bio;
 
@@ -2374,10 +2455,15 @@ int blk_rq_map_user_iov(request_queue_t 
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
 
@@ -2385,23 +2471,26 @@ EXPORT_SYMBOL(blk_rq_map_user_iov);
 
 /**
  * blk_rq_unmap_user - unmap a request with user data
- * @bio:	bio to be unmapped
- * @ulen:	length of user buffer
+ * @rq:		rq to be unmapped
  *
  * Description:
- *    Unmap a bio previously mapped by blk_rq_map_user().
+ *    Unmap a rq previously mapped by blk_rq_map_user().
  */
-int blk_rq_unmap_user(struct bio *bio, unsigned int ulen)
+int blk_rq_unmap_user(struct request *rq)
 {
-	int ret = 0;
+	struct bio *bio, *mapped_bio; 
 
-	if (bio) {
-		if (bio_flagged(bio, BIO_USER_MAPPED))
-			bio_unmap_user(bio);
+	rq->bio = rq->biohead_orig;
+	while ((bio = rq->bio)) {
+		if (bio_flagged(bio, BIO_BOUNCED))
+			mapped_bio = blk_get_bounced_bio(bio);
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
 
@@ -2432,11 +2521,8 @@ int blk_rq_map_kern(request_queue_t *q, 
 	if (rq_data_dir(rq) == WRITE)
 		bio->bi_rw |= (1 << BIO_RW);
 
-	rq->bio = rq->biotail = bio;
 	blk_rq_bio_prep(q, rq, bio);
-
 	rq->buffer = rq->data = NULL;
-	rq->data_len = len;
 	return 0;
 }
 
@@ -3469,8 +3555,9 @@ void blk_rq_bio_prep(request_queue_t *q,
 	rq->hard_cur_sectors = rq->current_nr_sectors;
 	rq->hard_nr_sectors = rq->nr_sectors = bio_sectors(bio);
 	rq->buffer = bio_data(bio);
+	rq->data_len = bio->bi_size;
 
-	rq->bio = rq->biotail = bio;
+	rq->bio = rq->biotail = rq->biohead_orig = bio;
 }
 
 EXPORT_SYMBOL(blk_rq_bio_prep);
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
index f38ad35..0975f82 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -230,6 +230,7 @@ struct request {
 
 	struct bio *bio;
 	struct bio *biotail;
+	struct bio *biohead_orig;
 
 	void *elevator_private;
 	void *completion_data;
@@ -605,6 +606,10 @@ static inline int init_emergency_isa_poo
 static inline void blk_queue_bounce(request_queue_t *q, struct bio **bio)
 {
 }
+static inline struct bio *blk_get_bounced_bio(struct bio *bio)
+{
+	return bio;
+}
 #endif /* CONFIG_MMU */
 
 #define rq_for_each_bio(_bio, rq)	\
@@ -638,10 +643,11 @@ extern void blk_sync_queue(struct reques
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
@@ -649,8 +655,7 @@ extern void blk_execute_rq_nowait(reques
 extern int blk_fill_sghdr_rq(request_queue_t *, struct request *,
 		      struct sg_io_hdr *, int);
 extern int blk_unmap_sghdr_rq(struct request *, struct sg_io_hdr *);
-extern int blk_complete_sghdr_rq(struct request *, struct sg_io_hdr *,
-			  struct bio *);
+extern int blk_complete_sghdr_rq(struct request *, struct sg_io_hdr *); 
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)
 {
@@ -732,6 +737,7 @@ extern request_queue_t *blk_init_queue(r
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void blk_queue_bounce_limit(request_queue_t *, u64);
+extern struct bio *blk_get_bounced_bio(struct bio *);
 extern void blk_queue_max_sectors(request_queue_t *, unsigned int);
 extern void blk_queue_max_phys_segments(request_queue_t *, unsigned short);
 extern void blk_queue_max_hw_segments(request_queue_t *, unsigned short);
diff --git a/mm/highmem.c b/mm/highmem.c
index 9b2a540..41aa46f 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -452,6 +452,13 @@ static void __blk_queue_bounce(request_q
 	*bio_orig = bio;
 }
 
+struct bio *blk_get_bounced_bio(struct bio *bio)
+{
+	return bio->bi_private;
+}
+
+EXPORT_SYMBOL(blk_get_bounced_bio);
+
 void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
 {
 	mempool_t *pool;
-- 
1.4.1



