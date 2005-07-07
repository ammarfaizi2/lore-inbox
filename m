Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVGGVdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVGGVdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGGVa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:30:59 -0400
Received: from coderock.org ([193.77.147.115]:13196 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262103AbVGGVaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:30:18 -0400
Message-Id: <20050707212952.400193000@homer>
Date: Thu, 07 Jul 2005 23:29:52 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 1/4] fix sparse warnings
Content-Disposition: inline; filename=sparse-drivers_block_ll_rw_blk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"


Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>



---
 drivers/block/elevator.c  |    2 +-
 drivers/block/ll_rw_blk.c |   17 ++++++++++-------
 include/linux/blkdev.h    |   10 +++++-----
 include/linux/elevator.h  |    6 ++++--
 4 files changed, 20 insertions(+), 15 deletions(-)

Index: quilt/drivers/block/ll_rw_blk.c
===================================================================
--- quilt.orig/drivers/block/ll_rw_blk.c
+++ quilt/drivers/block/ll_rw_blk.c
@@ -1639,13 +1639,14 @@ static int blk_init_free_list(request_qu
 
 static int __make_request(request_queue_t *, struct bio *);
 
-request_queue_t *blk_alloc_queue(int gfp_mask)
+request_queue_t *blk_alloc_queue(unsigned int __nocast gfp_mask)
 {
 	return blk_alloc_queue_node(gfp_mask, -1);
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
-request_queue_t *blk_alloc_queue_node(int gfp_mask, int node_id)
+request_queue_t *blk_alloc_queue_node(unsigned int __nocast gfp_mask,
+                                      int node_id)
 {
 	request_queue_t *q;
 
@@ -1774,7 +1775,8 @@ static inline void blk_free_request(requ
 }
 
 static inline struct request *
-blk_alloc_request(request_queue_t *q, int rw, struct bio *bio, int gfp_mask)
+blk_alloc_request(request_queue_t *q, int rw, struct bio *bio,
+                  unsigned int __nocast gfp_mask)
 {
 	struct request *rq = mempool_alloc(q->rq.rq_pool, gfp_mask);
 
@@ -1872,7 +1874,7 @@ static void freed_request(request_queue_
  * Returns !NULL on success, with queue_lock *not held*.
  */
 static struct request *get_request(request_queue_t *q, int rw, struct bio *bio,
-				   int gfp_mask)
+				   unsigned int __nocast gfp_mask)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
@@ -2006,7 +2008,8 @@ static struct request *get_request_wait(
 	return rq;
 }
 
-struct request *blk_get_request(request_queue_t *q, int rw, int gfp_mask)
+struct request *blk_get_request(request_queue_t *q, int rw,
+                                unsigned int __nocast gfp_mask)
 {
 	struct request *rq;
 
@@ -3285,7 +3288,7 @@ void exit_io_context(void)
  * but since the current task itself holds a reference, the context can be
  * used in general code, so long as it stays within `current` context.
  */
-struct io_context *current_io_context(int gfp_flags)
+struct io_context *current_io_context( unsigned int __nocast gfp_flags)
 {
 	struct task_struct *tsk = current;
 	struct io_context *ret;
@@ -3316,7 +3319,7 @@ EXPORT_SYMBOL(current_io_context);
  *
  * This is always called in the context of the task which submitted the I/O.
  */
-struct io_context *get_io_context(int gfp_flags)
+struct io_context *get_io_context(unsigned int __nocast gfp_flags)
 {
 	struct io_context *ret;
 	ret = current_io_context(gfp_flags);
Index: quilt/include/linux/blkdev.h
===================================================================
--- quilt.orig/include/linux/blkdev.h
+++ quilt/include/linux/blkdev.h
@@ -96,8 +96,8 @@ struct io_context {
 
 void put_io_context(struct io_context *ioc);
 void exit_io_context(void);
-struct io_context *current_io_context(int gfp_flags);
-struct io_context *get_io_context(int gfp_flags);
+struct io_context *current_io_context(unsigned int __nocast gfp_flags);
+struct io_context *get_io_context(unsigned int __nocast gfp_flags);
 void copy_io_context(struct io_context **pdst, struct io_context **psrc);
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
@@ -549,7 +549,7 @@ extern void generic_make_request(struct 
 extern void blk_put_request(struct request *);
 extern void blk_end_sync_rq(struct request *rq);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
-extern struct request *blk_get_request(request_queue_t *, int, int);
+extern struct request *blk_get_request(request_queue_t *, int, unsigned int __nocast);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
@@ -651,8 +651,8 @@ extern void blk_wait_queue_drained(reque
 extern void blk_finish_queue_drain(request_queue_t *);
 
 int blk_get_queue(request_queue_t *);
-request_queue_t *blk_alloc_queue(int gfp_mask);
-request_queue_t *blk_alloc_queue_node(int,int);
+request_queue_t *blk_alloc_queue(unsigned int __nocast gfp_mask);
+request_queue_t *blk_alloc_queue_node(unsigned int __nocast, int);
 #define blk_put_queue(q) blk_cleanup_queue((q))
 
 /*
Index: quilt/include/linux/elevator.h
===================================================================
--- quilt.orig/include/linux/elevator.h
+++ quilt/include/linux/elevator.h
@@ -18,7 +18,8 @@ typedef struct request *(elevator_reques
 typedef void (elevator_completed_req_fn) (request_queue_t *, struct request *);
 typedef int (elevator_may_queue_fn) (request_queue_t *, int, struct bio *);
 
-typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, struct bio *, int);
+typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, struct bio *,
+                                   unsigned int __nocast);
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_deactivate_req_fn) (request_queue_t *, struct request *);
 
@@ -98,7 +99,8 @@ extern int elv_register_queue(request_qu
 extern void elv_unregister_queue(request_queue_t *q);
 extern int elv_may_queue(request_queue_t *, int, struct bio *);
 extern void elv_completed_request(request_queue_t *, struct request *);
-extern int elv_set_request(request_queue_t *, struct request *, struct bio *, int);
+extern int elv_set_request(request_queue_t *, struct request *, struct bio *,
+                           unsigned int __nocast);
 extern void elv_put_request(request_queue_t *, struct request *);
 
 /*
Index: quilt/drivers/block/elevator.c
===================================================================
--- quilt.orig/drivers/block/elevator.c
+++ quilt/drivers/block/elevator.c
@@ -487,7 +487,7 @@ struct request *elv_former_request(reque
 }
 
 int elv_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		    int gfp_mask)
+		    unsigned int __nocast gfp_mask)
 {
 	elevator_t *e = q->elevator;
 

--
