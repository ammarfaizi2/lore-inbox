Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWEPRob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWEPRob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWEPRoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:44:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6152 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932360AbWEPRoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:23 -0400
Date: Tue, 16 May 2006 19:44:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] block/ll_rw_blk.c: possible cleanups
Message-ID: <20060516174421.GM10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- proper prototype for the following function:
  - blk_dev_init()
- #if 0 the following unused global function:
  - blk_queue_invalidate_tags()
- make the following needlessly global functions static:
  - blk_alloc_queue_node()
  - current_io_context()
- remove the following unused EXPORT_SYMBOL's:
  - blk_put_queue
  - blk_get_queue
  - blk_rq_map_user_iov

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Apr 2006

 block/genhd.c          |    2 --
 block/ll_rw_blk.c      |   27 +++++++++++----------------
 include/linux/blkdev.h |    5 ++---
 3 files changed, 13 insertions(+), 21 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/blkdev.h.old	2006-04-20 22:57:41.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/blkdev.h	2006-04-20 23:09:31.000000000 +0200
@@ -105,7 +105,6 @@
 
 void put_io_context(struct io_context *ioc);
 void exit_io_context(void);
-struct io_context *current_io_context(gfp_t gfp_flags);
 struct io_context *get_io_context(gfp_t gfp_flags);
 void copy_io_context(struct io_context **pdst, struct io_context **psrc);
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
@@ -599,6 +598,8 @@
 	unsigned block_size_bits;
 };
 
+int blk_dev_init(void);
+
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern void register_disk(struct gendisk *dev);
@@ -738,7 +739,6 @@
 
 int blk_get_queue(request_queue_t *);
 request_queue_t *blk_alloc_queue(gfp_t);
-request_queue_t *blk_alloc_queue_node(gfp_t, int);
 extern void blk_put_queue(request_queue_t *);
 
 /*
@@ -753,7 +753,6 @@
 extern int blk_queue_init_tags(request_queue_t *, int, struct blk_queue_tag *);
 extern void blk_queue_free_tags(request_queue_t *);
 extern int blk_queue_resize_tags(request_queue_t *, int);
-extern void blk_queue_invalidate_tags(request_queue_t *);
 extern long blk_congestion_wait(int rw, long timeout);
 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
--- linux-2.6.17-rc1-mm3-full/block/ll_rw_blk.c.old	2006-04-20 22:58:01.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/block/ll_rw_blk.c	2006-04-20 23:08:04.000000000 +0200
@@ -40,6 +40,7 @@
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
 static void init_request_from_bio(struct request *req, struct bio *bio);
 static int __make_request(request_queue_t *q, struct bio *bio);
+static struct io_context *current_io_context(gfp_t gfp_flags);
 
 /*
  * For the allocated request tables
@@ -1119,6 +1120,7 @@
 
 EXPORT_SYMBOL(blk_queue_start_tag);
 
+#if 0
 /**
  * blk_queue_invalidate_tags - invalidate all pending tags
  * @q:  the request queue for the device
@@ -1152,8 +1154,8 @@
 		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 0);
 	}
 }
-
 EXPORT_SYMBOL(blk_queue_invalidate_tags);
+#endif  /*  0  */
 
 static const char * const rq_flags[] = {
 	"REQ_RW",
@@ -1777,7 +1779,6 @@
 {
 	kobject_put(&q->kobj);
 }
-EXPORT_SYMBOL(blk_put_queue);
 
 void blk_cleanup_queue(request_queue_t * q)
 {
@@ -1812,15 +1813,9 @@
 	return 0;
 }
 
-request_queue_t *blk_alloc_queue(gfp_t gfp_mask)
-{
-	return blk_alloc_queue_node(gfp_mask, -1);
-}
-EXPORT_SYMBOL(blk_alloc_queue);
-
 static struct kobj_type queue_ktype;
 
-request_queue_t *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
+static request_queue_t *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	request_queue_t *q;
 
@@ -1842,7 +1837,12 @@
 
 	return q;
 }
-EXPORT_SYMBOL(blk_alloc_queue_node);
+
+request_queue_t *blk_alloc_queue(gfp_t gfp_mask)
+{
+	return blk_alloc_queue_node(gfp_mask, -1);
+}
+EXPORT_SYMBOL(blk_alloc_queue);
 
 /**
  * blk_init_queue  - prepare a request queue for use with a block device
@@ -1945,8 +1945,6 @@
 	return 1;
 }
 
-EXPORT_SYMBOL(blk_get_queue);
-
 static inline void blk_free_request(request_queue_t *q, struct request *rq)
 {
 	if (rq->flags & REQ_ELVPRIV)
@@ -2405,8 +2403,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(blk_rq_map_user_iov);
-
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @bio:	bio to be unmapped
@@ -3642,7 +3638,7 @@
  * but since the current task itself holds a reference, the context can be
  * used in general code, so long as it stays within `current` context.
  */
-struct io_context *current_io_context(gfp_t gfp_flags)
+static struct io_context *current_io_context(gfp_t gfp_flags)
 {
 	struct task_struct *tsk = current;
 	struct io_context *ret;
@@ -3665,7 +3661,6 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(current_io_context);
 
 /*
  * If the current task has no IO context then create one and initialise it.
--- linux-2.6.17-rc1-mm3-full/block/genhd.c.old	2006-04-20 23:09:42.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/block/genhd.c	2006-04-20 23:09:51.000000000 +0200
@@ -285,8 +285,6 @@
 #endif
 
 
-extern int blk_dev_init(void);
-
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
 	if (request_module("block-major-%d-%d", MAJOR(dev), MINOR(dev)) > 0)

