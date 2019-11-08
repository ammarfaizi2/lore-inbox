Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D55FA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE0420679
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfKHOsa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:48:30 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:47295 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKHOsa (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 09:48:30 -0500
X-QQ-mid: bizesmtp23t1573224500tm6u4ipc
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 22:48:19 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZU90000A0000000
X-QQ-FEAT: Srnz+tFH5kyC21JFgHStwGKnTqGotHu4VWDr8wtAuW8x0+qmk7US84VUCWs/c
        PGd0Vz/or438ba7jnPHmHgxIuK0W4BcyUJmFM4Bvg5CtHSbKQacs1L2cNNzOeI2ZP0aHeMo
        Bp/aVZD0zDmtYf/d4TUV+IsGrJemPHxiWisAN81ojJAvOAYMmgXjzzTIllCdmypBqyE6MRs
        i1GPRT8gILayzg33UlBo1KZX9f/TwOlXbrM3eUtSVXd/O50DwhL/UaMUD2MTHdj7dwkf/fU
        iS2a5RRxfSkSAskj4F1ZWGiGCCApH85KH3xqu1FxCBtlarvYJmdkltTIknaF5piL0f97tq3
        5ssU0uDh5OBu28z8IGZ8VRrXSxAtA==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH v3 1/2] io_uring: reduced function parameter ctx if possible
Date:   Fri,  8 Nov 2019 22:47:58 +0800
Message-Id: <1573224479-59295-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Many times, the core of the function is req, and req has already set
req->ctx at initialization time, so there is no need to pass in from
outside.

Cleanup, no function change.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 109 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 51 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index eadd19a..2cc53e3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -429,20 +429,20 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	return ctx;
 }
 
-static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
-				       struct io_kiocb *req)
+static inline bool __io_sequence_defer(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
+
 	return req->sequence != ctx->cached_cq_tail + ctx->cached_sq_dropped
 					+ atomic_read(&ctx->cached_cq_overflow);
 }
 
-static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
-				     struct io_kiocb *req)
+static inline bool io_sequence_defer(struct io_kiocb *req)
 {
 	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
 		return false;
 
-	return __io_sequence_defer(ctx, req);
+	return __io_sequence_defer(req);
 }
 
 static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
@@ -450,7 +450,7 @@ static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
 	struct io_kiocb *req;
 
 	req = list_first_entry_or_null(&ctx->defer_list, struct io_kiocb, list);
-	if (req && !io_sequence_defer(ctx, req)) {
+	if (req && !io_sequence_defer(req)) {
 		list_del_init(&req->list);
 		return req;
 	}
@@ -463,7 +463,7 @@ static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
 	struct io_kiocb *req;
 
 	req = list_first_entry_or_null(&ctx->timeout_list, struct io_kiocb, list);
-	if (req && !__io_sequence_defer(ctx, req)) {
+	if (req && !__io_sequence_defer(req)) {
 		list_del_init(&req->list);
 		return req;
 	}
@@ -512,10 +512,10 @@ static inline bool io_prep_async_work(struct io_kiocb *req)
 	return do_hashed;
 }
 
-static inline void io_queue_async_work(struct io_ring_ctx *ctx,
-				       struct io_kiocb *req)
+static inline void io_queue_async_work(struct io_kiocb *req)
 {
 	bool do_hashed = io_prep_async_work(req);
+	struct io_ring_ctx *ctx = req->ctx;
 
 	trace_io_uring_queue_async_work(ctx, do_hashed, req, &req->work,
 					req->flags);
@@ -566,7 +566,7 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 			continue;
 		}
 		req->flags |= REQ_F_IO_DRAINED;
-		io_queue_async_work(ctx, req);
+		io_queue_async_work(req);
 	}
 }
 
@@ -714,9 +714,9 @@ static void __io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
-static bool io_link_cancel_timeout(struct io_ring_ctx *ctx,
-				   struct io_kiocb *req)
+static bool io_link_cancel_timeout(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
 	ret = hrtimer_try_to_cancel(&req->timeout.timer);
@@ -756,7 +756,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		 * in this context instead of having to queue up new async work.
 		 */
 		if (req->flags & REQ_F_LINK_TIMEOUT) {
-			wake_ev = io_link_cancel_timeout(ctx, nxt);
+			wake_ev = io_link_cancel_timeout(nxt);
 
 			/* we dropped this link, get next */
 			nxt = list_first_entry_or_null(&req->link_list,
@@ -765,7 +765,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 			*nxtptr = nxt;
 			break;
 		} else {
-			io_queue_async_work(req->ctx, nxt);
+			io_queue_async_work(nxt);
 			break;
 		}
 	}
@@ -793,7 +793,7 @@ static void io_fail_links(struct io_kiocb *req)
 
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
-			io_link_cancel_timeout(ctx, link);
+			io_link_cancel_timeout(link);
 		} else {
 			io_cqring_fill_event(ctx, link->user_data, -ECANCELED);
 			__io_free_req(link);
@@ -862,7 +862,7 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		if (nxtptr)
 			*nxtptr = nxt;
 		else
-			io_queue_async_work(nxt->ctx, nxt);
+			io_queue_async_work(nxt);
 	}
 }
 
@@ -1803,7 +1803,7 @@ static void io_poll_remove_one(struct io_kiocb *req)
 	WRITE_ONCE(poll->canceled, true);
 	if (!list_empty(&poll->wait.entry)) {
 		list_del_init(&poll->wait.entry);
-		io_queue_async_work(req->ctx, req);
+		io_queue_async_work(req);
 	}
 	spin_unlock(&poll->head->lock);
 
@@ -1855,9 +1855,10 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
-static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			     __poll_t mask)
+static void io_poll_complete(struct io_kiocb *req, __poll_t mask)
 {
+	struct io_ring_ctx *ctx = req->ctx;
+
 	req->poll.done = true;
 	io_cqring_fill_event(ctx, req->user_data, mangle_poll(mask));
 	io_commit_cqring(ctx);
@@ -1893,7 +1894,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 		return;
 	}
 	list_del_init(&req->list);
-	io_poll_complete(ctx, req, mask);
+	io_poll_complete(req, mask);
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_ev_posted(ctx);
@@ -1921,13 +1922,13 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
 		list_del(&req->list);
-		io_poll_complete(ctx, req, mask);
+		io_poll_complete(req, mask);
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 		io_cqring_ev_posted(ctx);
 		io_put_req(req, NULL);
 	} else {
-		io_queue_async_work(ctx, req);
+		io_queue_async_work(req);
 	}
 
 	return 1;
@@ -2012,7 +2013,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	if (mask) { /* no async, we'd stolen it */
 		ipt.error = 0;
-		io_poll_complete(ctx, req, mask);
+		io_poll_complete(req, mask);
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2259,12 +2260,13 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static int io_req_defer(struct io_kiocb *req)
 {
 	const struct io_uring_sqe *sqe = req->submit.sqe;
 	struct io_uring_sqe *sqe_copy;
+	struct io_ring_ctx *ctx = req->ctx;
 
-	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list))
+	if (!io_sequence_defer(req) && list_empty(&ctx->defer_list))
 		return 0;
 
 	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
@@ -2272,7 +2274,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
 		return -EAGAIN;
 
 	spin_lock_irq(&ctx->completion_lock);
-	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list)) {
+	if (!io_sequence_defer(req) && list_empty(&ctx->defer_list)) {
 		spin_unlock_irq(&ctx->completion_lock);
 		kfree(sqe_copy);
 		return 0;
@@ -2287,11 +2289,12 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	return -EIOCBQUEUED;
 }
 
-static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   struct io_kiocb **nxt, bool force_nonblock)
+static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
+			   bool force_nonblock)
 {
 	int ret, opcode;
 	struct sqe_submit *s = &req->submit;
+	struct io_ring_ctx *ctx = req->ctx;
 
 	req->user_data = READ_ONCE(s->sqe->user_data);
 
@@ -2389,7 +2392,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
 		s->in_async = true;
 		do {
-			ret = __io_submit_sqe(ctx, req, &nxt, false);
+			ret = __io_submit_sqe(req, &nxt, false);
 			/*
 			 * We can get EAGAIN for polled IO even though we're
 			 * forcing a sync submission from here, since we can't
@@ -2443,10 +2446,10 @@ static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
 	return table->files[index & IORING_FILE_TABLE_MASK];
 }
 
-static int io_req_set_file(struct io_ring_ctx *ctx,
-			   struct io_submit_state *state, struct io_kiocb *req)
+static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
 {
 	struct sqe_submit *s = &req->submit;
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned flags;
 	int fd;
 
@@ -2486,9 +2489,10 @@ static int io_req_set_file(struct io_ring_ctx *ctx,
 	return 0;
 }
 
-static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static int io_grab_files(struct io_kiocb *req)
 {
 	int ret = -EBADF;
+	struct io_ring_ctx *ctx = req->ctx;
 
 	rcu_read_lock();
 	spin_lock_irq(&ctx->inflight_lock);
@@ -2604,8 +2608,9 @@ static inline struct io_kiocb *io_get_linked_timeout(struct io_kiocb *req)
 	return NULL;
 }
 
-static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static int __io_queue_sqe(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *nxt;
 	int ret;
 
@@ -2616,7 +2621,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 			goto err;
 	}
 
-	ret = __io_submit_sqe(ctx, req, NULL, true);
+	ret = __io_submit_sqe(req, NULL, true);
 
 	/*
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
@@ -2631,7 +2636,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 		if (sqe_copy) {
 			s->sqe = sqe_copy;
 			if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
-				ret = io_grab_files(ctx, req);
+				ret = io_grab_files(req);
 				if (ret) {
 					kfree(sqe_copy);
 					goto err;
@@ -2642,7 +2647,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 			 * Queued up for async execution, worker will release
 			 * submit reference when the iocb is actually submitted.
 			 */
-			io_queue_async_work(ctx, req);
+			io_queue_async_work(req);
 			return 0;
 		}
 	}
@@ -2662,11 +2667,12 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	return ret;
 }
 
-static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static int io_queue_sqe(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
-	ret = io_req_defer(ctx, req);
+	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
@@ -2675,17 +2681,17 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 		return 0;
 	}
 
-	return __io_queue_sqe(ctx, req);
+	return __io_queue_sqe(req);
 }
 
-static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			      struct io_kiocb *shadow)
+static int io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 {
 	int ret;
 	int need_submit = false;
+	struct io_ring_ctx *ctx = req->ctx;
 
 	if (!shadow)
-		return io_queue_sqe(ctx, req);
+		return io_queue_sqe(req);
 
 	/*
 	 * Mark the first IO in link list as DRAIN, let all the following
@@ -2693,7 +2699,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * list.
 	 */
 	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(ctx, req);
+	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
@@ -2716,18 +2722,19 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	spin_unlock_irq(&ctx->completion_lock);
 
 	if (need_submit)
-		return __io_queue_sqe(ctx, req);
+		return __io_queue_sqe(req);
 
 	return 0;
 }
 
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
-static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			  struct io_submit_state *state, struct io_kiocb **link)
+static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
+			  struct io_kiocb **link)
 {
 	struct io_uring_sqe *sqe_copy;
 	struct sqe_submit *s = &req->submit;
+	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
 	/* enforce forwards compatibility on users */
@@ -2736,7 +2743,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		goto err_req;
 	}
 
-	ret = io_req_set_file(ctx, state, req);
+	ret = io_req_set_file(state, req);
 	if (unlikely(ret)) {
 err_req:
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
@@ -2775,7 +2782,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = -EINVAL;
 		goto err_req;
 	} else {
-		io_queue_sqe(ctx, req);
+		io_queue_sqe(req);
 	}
 }
 
@@ -2919,7 +2926,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		req->submit.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
 					  true, async);
-		io_submit_sqe(ctx, req, statep, &link);
+		io_submit_sqe(req, statep, &link);
 		submitted++;
 
 		/*
@@ -2927,14 +2934,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!(sqe_flags & IOSQE_IO_LINK) && link) {
-			io_queue_link_head(ctx, link, shadow_req);
+			io_queue_link_head(link, shadow_req);
 			link = NULL;
 			shadow_req = NULL;
 		}
 	}
 
 	if (link)
-		io_queue_link_head(ctx, link, shadow_req);
+		io_queue_link_head(link, shadow_req);
 	if (statep)
 		io_submit_state_end(&state);
 
-- 
2.7.4



