Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F79C5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 06:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C5F2087E
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 06:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHGaP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 01:30:15 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:34227 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKHGaP (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 01:30:15 -0500
X-QQ-mid: bizesmtp29t1573194592tegdkof1
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 14:29:51 +0800 (CST)
X-QQ-SSF: 01400000002000S0ZU90000A0000000
X-QQ-FEAT: Bm45Mp3kYYqvk2Ikf8KIHzW69Iw6UdSnL4rFhIX5P1V36TOHUwyiWKZimewkY
        FzgA+dHlGkPQdSd9EDeBHii7JA2nZsU5deHvT612ZnzulL1AlxFayxhz38J7jMuYJPCapZh
        4ot81Ik/hEJ+uJoJwCqHUu6aNlVDfPLluJ2hOSFROmXrR6bjTLQ2DqroVPq4oeN0GUovAdz
        MsCpN+zDdyncZe03XE81eOAj8qvfWj7NhS1ci6W8gezpBJxvNG8bJ2yEWO2UWkNFg/1a71y
        rqf6ixIh+j3BpwVfatnbg7OfwPa5GmDlBXpzx30crMngck82cUmE0G0LXel/xC7xq+jmQgw
        ++oWEbaqkSN7Gb9/X3Hw1gAHinrQQ==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] io_uring: reduced function parameter ctx if possible
Date:   Fri,  8 Nov 2019 14:29:37 +0800
Message-Id: <1573194577-155725-1-git-send-email-liuyun01@kylinos.cn>
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
 [base on branch for-5.5/io_uring]

 fs/io_uring.c | 90 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index eadd19a..e83327c 100644
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
 
@@ -765,7 +765,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 			*nxtptr = nxt;
 			break;
 		} else {
-			io_queue_async_work(req->ctx, nxt);
+			io_queue_async_work(nxt);
 			break;
 		}
 	}
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
 
@@ -1927,7 +1927,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		io_cqring_ev_posted(ctx);
 		io_put_req(req, NULL);
 	} else {
-		io_queue_async_work(ctx, req);
+		io_queue_async_work(req);
 	}
 
 	return 1;
@@ -2259,12 +2259,13 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
@@ -2272,7 +2273,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
 		return -EAGAIN;
 
 	spin_lock_irq(&ctx->completion_lock);
-	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list)) {
+	if (!io_sequence_defer(req) && list_empty(&ctx->defer_list)) {
 		spin_unlock_irq(&ctx->completion_lock);
 		kfree(sqe_copy);
 		return 0;
@@ -2287,11 +2288,12 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req)
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
 
@@ -2389,7 +2391,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
 		s->in_async = true;
 		do {
-			ret = __io_submit_sqe(ctx, req, &nxt, false);
+			ret = __io_submit_sqe(req, &nxt, false);
 			/*
 			 * We can get EAGAIN for polled IO even though we're
 			 * forcing a sync submission from here, since we can't
@@ -2443,10 +2445,10 @@ static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
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
 
@@ -2486,9 +2488,10 @@ static int io_req_set_file(struct io_ring_ctx *ctx,
 	return 0;
 }
 
-static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static int io_grab_files(struct io_kiocb *req)
 {
 	int ret = -EBADF;
+	struct io_ring_ctx *ctx = req->ctx;
 
 	rcu_read_lock();
 	spin_lock_irq(&ctx->inflight_lock);
@@ -2604,8 +2607,9 @@ static inline struct io_kiocb *io_get_linked_timeout(struct io_kiocb *req)
 	return NULL;
 }
 
-static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
+static int __io_queue_sqe(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *nxt;
 	int ret;
 
@@ -2616,7 +2620,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 			goto err;
 	}
 
-	ret = __io_submit_sqe(ctx, req, NULL, true);
+	ret = __io_submit_sqe(req, NULL, true);
 
 	/*
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
@@ -2631,7 +2635,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 		if (sqe_copy) {
 			s->sqe = sqe_copy;
 			if (req->work.flags & IO_WQ_WORK_NEEDS_FILES) {
-				ret = io_grab_files(ctx, req);
+				ret = io_grab_files(req);
 				if (ret) {
 					kfree(sqe_copy);
 					goto err;
@@ -2642,7 +2646,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 			 * Queued up for async execution, worker will release
 			 * submit reference when the iocb is actually submitted.
 			 */
-			io_queue_async_work(ctx, req);
+			io_queue_async_work(req);
 			return 0;
 		}
 	}
@@ -2662,11 +2666,12 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
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
@@ -2675,17 +2680,17 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
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
@@ -2693,7 +2698,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * list.
 	 */
 	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(ctx, req);
+	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
@@ -2716,18 +2721,19 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
@@ -2736,7 +2742,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		goto err_req;
 	}
 
-	ret = io_req_set_file(ctx, state, req);
+	ret = io_req_set_file(state, req);
 	if (unlikely(ret)) {
 err_req:
 		io_cqring_add_event(ctx, s->sqe->user_data, ret);
@@ -2775,7 +2781,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = -EINVAL;
 		goto err_req;
 	} else {
-		io_queue_sqe(ctx, req);
+		io_queue_sqe(req);
 	}
 }
 
@@ -2919,7 +2925,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		req->submit.needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
 					  true, async);
-		io_submit_sqe(ctx, req, statep, &link);
+		io_submit_sqe(req, statep, &link);
 		submitted++;
 
 		/*
@@ -2927,14 +2933,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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



