Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVJIGBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVJIGBV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 02:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVJIGBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 02:01:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48293 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932224AbVJIGBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 02:01:21 -0400
Date: Sun, 9 Oct 2005 07:01:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC] gfp flags annotations - part 7 (block layer)
Message-ID: <20051009060118.GL7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	missing gfp_t in block layer (ll_rw_blk, elevator and friends).
Individual drivers left alone for now.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

[That's it for tonight; the next chunk (dma-mapping) is trickier and even
if we want it before 2.6.14, I'd rather give it another look before posting
and after I get some sleep.  The messy part is in arch/* code - changing
prototypes in include/asm-* has to go with corresponding changes in actual
definitions of functions in question and tracking down the related forest
of defines to make sure that nothing is missed...]

diff -urN fs/drivers/block/as-iosched.c block/drivers/block/as-iosched.c
--- fs/drivers/block/as-iosched.c	2005-09-22 14:50:49.000000000 -0400
+++ block/drivers/block/as-iosched.c	2005-10-09 01:24:16.000000000 -0400
@@ -1807,7 +1807,7 @@
 }
 
 static int as_set_request(request_queue_t *q, struct request *rq,
-			  struct bio *bio, int gfp_mask)
+			  struct bio *bio, gfp_t gfp_mask)
 {
 	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
diff -urN fs/drivers/block/cfq-iosched.c block/drivers/block/cfq-iosched.c
--- fs/drivers/block/cfq-iosched.c	2005-09-22 14:50:49.000000000 -0400
+++ block/drivers/block/cfq-iosched.c	2005-10-09 01:24:16.000000000 -0400
@@ -1422,7 +1422,7 @@
 }
 
 static struct cfq_io_context *
-cfq_alloc_io_context(struct cfq_data *cfqd, int gfp_mask)
+cfq_alloc_io_context(struct cfq_data *cfqd, gfp_t gfp_mask)
 {
 	struct cfq_io_context *cic = kmem_cache_alloc(cfq_ioc_pool, gfp_mask);
 
@@ -1517,7 +1517,7 @@
 
 static struct cfq_queue *
 cfq_get_queue(struct cfq_data *cfqd, unsigned int key, unsigned short ioprio,
-	      int gfp_mask)
+	      gfp_t gfp_mask)
 {
 	const int hashval = hash_long(key, CFQ_QHASH_SHIFT);
 	struct cfq_queue *cfqq, *new_cfqq = NULL;
@@ -1578,7 +1578,7 @@
  * cfqq, so we don't need to worry about it disappearing
  */
 static struct cfq_io_context *
-cfq_get_io_context(struct cfq_data *cfqd, pid_t pid, int gfp_mask)
+cfq_get_io_context(struct cfq_data *cfqd, pid_t pid, gfp_t gfp_mask)
 {
 	struct io_context *ioc = NULL;
 	struct cfq_io_context *cic;
@@ -2075,7 +2075,7 @@
  */
 static int
 cfq_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		int gfp_mask)
+		gfp_t gfp_mask)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;
diff -urN fs/drivers/block/deadline-iosched.c block/drivers/block/deadline-iosched.c
--- fs/drivers/block/deadline-iosched.c	2005-09-22 14:50:49.000000000 -0400
+++ block/drivers/block/deadline-iosched.c	2005-10-09 01:24:16.000000000 -0400
@@ -756,7 +756,7 @@
 
 static int
 deadline_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		     int gfp_mask)
+		     gfp_t gfp_mask)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq;
diff -urN fs/drivers/block/elevator.c block/drivers/block/elevator.c
--- fs/drivers/block/elevator.c	2005-09-22 14:50:49.000000000 -0400
+++ block/drivers/block/elevator.c	2005-10-09 01:24:16.000000000 -0400
@@ -487,7 +487,7 @@
 }
 
 int elv_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		    int gfp_mask)
+		    gfp_t gfp_mask)
 {
 	elevator_t *e = q->elevator;
 
diff -urN fs/drivers/block/ll_rw_blk.c block/drivers/block/ll_rw_blk.c
--- fs/drivers/block/ll_rw_blk.c	2005-09-22 14:50:49.000000000 -0400
+++ block/drivers/block/ll_rw_blk.c	2005-10-09 01:24:16.000000000 -0400
@@ -1652,13 +1652,13 @@
 
 static int __make_request(request_queue_t *, struct bio *);
 
-request_queue_t *blk_alloc_queue(int gfp_mask)
+request_queue_t *blk_alloc_queue(gfp_t gfp_mask)
 {
 	return blk_alloc_queue_node(gfp_mask, -1);
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
-request_queue_t *blk_alloc_queue_node(int gfp_mask, int node_id)
+request_queue_t *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	request_queue_t *q;
 
@@ -1787,7 +1787,7 @@
 }
 
 static inline struct request *
-blk_alloc_request(request_queue_t *q, int rw, struct bio *bio, int gfp_mask)
+blk_alloc_request(request_queue_t *q, int rw, struct bio *bio, gfp_t gfp_mask)
 {
 	struct request *rq = mempool_alloc(q->rq.rq_pool, gfp_mask);
 
@@ -1885,7 +1885,7 @@
  * Returns !NULL on success, with queue_lock *not held*.
  */
 static struct request *get_request(request_queue_t *q, int rw, struct bio *bio,
-				   int gfp_mask)
+				   gfp_t gfp_mask)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
@@ -2019,7 +2019,7 @@
 	return rq;
 }
 
-struct request *blk_get_request(request_queue_t *q, int rw, int gfp_mask)
+struct request *blk_get_request(request_queue_t *q, int rw, gfp_t gfp_mask)
 {
 	struct request *rq;
 
@@ -2251,7 +2251,7 @@
  * @gfp_mask:	memory allocation flags
  */
 int blk_rq_map_kern(request_queue_t *q, struct request *rq, void *kbuf,
-		    unsigned int len, unsigned int gfp_mask)
+		    unsigned int len, gfp_t gfp_mask)
 {
 	struct bio *bio;
 
@@ -3393,7 +3393,7 @@
  * but since the current task itself holds a reference, the context can be
  * used in general code, so long as it stays within `current` context.
  */
-struct io_context *current_io_context(int gfp_flags)
+struct io_context *current_io_context(gfp_t gfp_flags)
 {
 	struct task_struct *tsk = current;
 	struct io_context *ret;
@@ -3424,7 +3424,7 @@
  *
  * This is always called in the context of the task which submitted the I/O.
  */
-struct io_context *get_io_context(int gfp_flags)
+struct io_context *get_io_context(gfp_t gfp_flags)
 {
 	struct io_context *ret;
 	ret = current_io_context(gfp_flags);
diff -urN fs/include/linux/blkdev.h block/include/linux/blkdev.h
--- fs/include/linux/blkdev.h	2005-09-22 14:50:53.000000000 -0400
+++ block/include/linux/blkdev.h	2005-10-09 01:24:16.000000000 -0400
@@ -96,8 +96,8 @@
 
 void put_io_context(struct io_context *ioc);
 void exit_io_context(void);
-struct io_context *current_io_context(int gfp_flags);
-struct io_context *get_io_context(int gfp_flags);
+struct io_context *current_io_context(gfp_t gfp_flags);
+struct io_context *get_io_context(gfp_t gfp_flags);
 void copy_io_context(struct io_context **pdst, struct io_context **psrc);
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
@@ -354,7 +354,7 @@
 	 * queue needs bounce pages for pages above this limit
 	 */
 	unsigned long		bounce_pfn;
-	unsigned int		bounce_gfp;
+	gfp_t			bounce_gfp;
 
 	/*
 	 * various queue flags, see QUEUE_* below
@@ -550,7 +550,7 @@
 extern void blk_put_request(struct request *);
 extern void blk_end_sync_rq(struct request *rq);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
-extern struct request *blk_get_request(request_queue_t *, int, int);
+extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
@@ -565,7 +565,7 @@
 extern void blk_queue_activity_fn(request_queue_t *, activity_fn *, void *);
 extern int blk_rq_map_user(request_queue_t *, struct request *, void __user *, unsigned int);
 extern int blk_rq_unmap_user(struct bio *, unsigned int);
-extern int blk_rq_map_kern(request_queue_t *, struct request *, void *, unsigned int, unsigned int);
+extern int blk_rq_map_kern(request_queue_t *, struct request *, void *, unsigned int, gfp_t);
 extern int blk_rq_map_user_iov(request_queue_t *, struct request *, struct sg_iovec *, int);
 extern int blk_execute_rq(request_queue_t *, struct gendisk *,
 			  struct request *, int);
@@ -654,8 +654,8 @@
 extern void blk_finish_queue_drain(request_queue_t *);
 
 int blk_get_queue(request_queue_t *);
-request_queue_t *blk_alloc_queue(int gfp_mask);
-request_queue_t *blk_alloc_queue_node(int,int);
+request_queue_t *blk_alloc_queue(gfp_t);
+request_queue_t *blk_alloc_queue_node(gfp_t, int);
 #define blk_put_queue(q) blk_cleanup_queue((q))
 
 /*
diff -urN fs/include/linux/elevator.h block/include/linux/elevator.h
--- fs/include/linux/elevator.h	2005-09-22 14:50:53.000000000 -0400
+++ block/include/linux/elevator.h	2005-10-09 01:24:16.000000000 -0400
@@ -18,7 +18,7 @@
 typedef void (elevator_completed_req_fn) (request_queue_t *, struct request *);
 typedef int (elevator_may_queue_fn) (request_queue_t *, int, struct bio *);
 
-typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, struct bio *, int);
+typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, struct bio *, gfp_t);
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_deactivate_req_fn) (request_queue_t *, struct request *);
 
@@ -98,7 +98,7 @@
 extern void elv_unregister_queue(request_queue_t *q);
 extern int elv_may_queue(request_queue_t *, int, struct bio *);
 extern void elv_completed_request(request_queue_t *, struct request *);
-extern int elv_set_request(request_queue_t *, struct request *, struct bio *, int);
+extern int elv_set_request(request_queue_t *, struct request *, struct bio *, gfp_t);
 extern void elv_put_request(request_queue_t *, struct request *);
 
 /*
