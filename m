Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21CCC43331
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6484E21D7B
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YSquqJRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfKGQAw (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:00:52 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34374 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfKGQAw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 11:00:52 -0500
Received: by mail-il1-f193.google.com with SMTP id p6so2279143ilp.1
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trPc/xFhKbDetKzWlPpVCYqtRz6fU5xOWDIUCsoZ1J0=;
        b=YSquqJRc4B/duU/BYphnfh+346VR98NXHa7zTIxxplLaD2ugAYbBcW+0Ejse3BSCAf
         FF/AruEvhyDyHMFtywHRmvYrMAzK16pg4O78HGr8yqsGgRLqUJPQGZPHZ0U7PdCLHmE8
         ThFowdz8Z8ZsXZ0Zldisw6joazMp7QLUFFK1NPH5BEenQDMcPuvleMx1S85ZWNWQluR3
         +If8M2P88RJGfJPz18Ok41dsfIRYIJVZlmLJrOibhzgxHKrhP7aoHcHnlnXiyvECCZe6
         7ztb0EZBV36/c9vXut6JDF3kAnrFbFO1XBymk3mpa06hQSfRylDr3UIdRk9AWglFKZnq
         p7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trPc/xFhKbDetKzWlPpVCYqtRz6fU5xOWDIUCsoZ1J0=;
        b=oxCgYdPWNyLcHshC1V9ZTUiD2w6iDYCJPtnazxsv+dZ6mHHIDo3f1Rhoz21GS1llS3
         Sdcj6z+SR+OSkpFlaawzmYyond0FIF7l4V/5XrPQKAa/lnNrqtOAPJDh5CrvpEN/sOxm
         5QUxdDmoQjYjGPYJqWKgsdnN8ccwQeoFrQumy03jIOYuMyyslkUugpAHhqxbd8y6Jz4K
         nkHykXKsCZTRLaI9OHLvjr4GROjOc5CO26oyfe31InbSZ0DpDqlS+mcYBr8AHigIzy/V
         oT9izGNBt9deJqNokKZsq9LMU3b9GVhYz9ZfPvhq9vnGsnrDGkEAxvbKeVCnUnt8n6qg
         lvgg==
X-Gm-Message-State: APjAAAXTq7RUE1O1FjpXrcRSLninZfGtC+fzANOEQvhwPqfP5z5QQIg2
        orG4S/A/GQlkyMaYeX5t6Qkt+erwuZU=
X-Google-Smtp-Source: APXvYqwhjabl40/v0tLbI4h1sHNdwi1XSJv2QZSBKAgrQAwt13GDDem98Rt1cbSrYTMnr5uL21HA3g==
X-Received: by 2002:a92:c08c:: with SMTP id h12mr5084584ile.183.1573142450218;
        Thu, 07 Nov 2019 08:00:50 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v130sm210438iod.32.2019.11.07.08.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:00:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] io_uring: pass in io_kiocb to fill/add CQ handlers
Date:   Thu,  7 Nov 2019 09:00:42 -0700
Message-Id: <20191107160043.31725-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107160043.31725-1-axboe@kernel.dk>
References: <20191107160043.31725-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is in preparation for handling CQ ring overflow a bit smarter. We
should not have any functional changes in this patch. Most of the
changes are fairly straight forward, the only ones that stick out a bit
are the ones that change __io_free_req() to take the reference count
into account. If the request hasn't been submitted yet, we know it's
safe to simply ignore references and free it. But let's clean these up
too, as later patches will depend on the caller doing the right thing if
the completion logging grabs a reference to the request.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 96 +++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index da0fac4275d3..f69d9794ce17 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -369,10 +369,10 @@ struct io_submit_state {
 };
 
 static void io_wq_submit_work(struct io_wq_work **workptr);
-static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
-				 long res);
+static void io_cqring_fill_event(struct io_kiocb *req, long res);
 static void __io_free_req(struct io_kiocb *req);
 static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
+static void io_double_put_req(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
 
@@ -535,8 +535,8 @@ static void io_kill_timeout(struct io_kiocb *req)
 	if (ret != -1) {
 		atomic_inc(&req->ctx->cq_timeouts);
 		list_del_init(&req->list);
-		io_cqring_fill_event(req->ctx, req->user_data, 0);
-		__io_free_req(req);
+		io_cqring_fill_event(req, 0);
+		io_put_req(req, NULL);
 	}
 }
 
@@ -588,12 +588,12 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	return &rings->cqes[tail & ctx->cq_mask];
 }
 
-static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
-				 long res)
+static void io_cqring_fill_event(struct io_kiocb *req, long res)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_uring_cqe *cqe;
 
-	trace_io_uring_complete(ctx, ki_user_data, res);
+	trace_io_uring_complete(ctx, req->user_data, res);
 
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
@@ -602,7 +602,7 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 	 */
 	cqe = io_get_cqring(ctx);
 	if (cqe) {
-		WRITE_ONCE(cqe->user_data, ki_user_data);
+		WRITE_ONCE(cqe->user_data, req->user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
@@ -621,13 +621,13 @@ static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
 		eventfd_signal(ctx->cq_ev_fd, 1);
 }
 
-static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data,
-				long res)
+static void io_cqring_add_event(struct io_kiocb *req, long res)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	io_cqring_fill_event(ctx, user_data, res);
+	io_cqring_fill_event(req, res);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
@@ -721,10 +721,10 @@ static bool io_link_cancel_timeout(struct io_ring_ctx *ctx,
 
 	ret = hrtimer_try_to_cancel(&req->timeout.timer);
 	if (ret != -1) {
-		io_cqring_fill_event(ctx, req->user_data, -ECANCELED);
+		io_cqring_fill_event(req, -ECANCELED);
 		io_commit_cqring(ctx);
 		req->flags &= ~REQ_F_LINK;
-		__io_free_req(req);
+		io_put_req(req, NULL);
 		return true;
 	}
 
@@ -795,8 +795,8 @@ static void io_fail_links(struct io_kiocb *req)
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(ctx, link);
 		} else {
-			io_cqring_fill_event(ctx, link->user_data, -ECANCELED);
-			__io_free_req(link);
+			io_cqring_fill_event(link, -ECANCELED);
+			io_double_put_req(link);
 		}
 	}
 
@@ -866,6 +866,13 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	}
 }
 
+static void io_double_put_req(struct io_kiocb *req)
+{
+	/* drop both submit and complete references */
+	if (refcount_sub_and_test(2, &req->refs))
+		__io_free_req(req);
+}
+
 static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
 	struct io_rings *rings = ctx->rings;
@@ -898,7 +905,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
 
-		io_cqring_fill_event(ctx, req->user_data, req->result);
+		io_cqring_fill_event(req, req->result);
 		(*nr_events)++;
 
 		if (refcount_dec_and_test(&req->refs)) {
@@ -1094,7 +1101,7 @@ static void io_complete_rw_common(struct kiocb *kiocb, long res)
 
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, req->user_data, res);
+	io_cqring_add_event(req, res);
 }
 
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
@@ -1595,15 +1602,14 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 /*
  * IORING_OP_NOP just posts a completion event, nothing else.
  */
-static int io_nop(struct io_kiocb *req, u64 user_data)
+static int io_nop(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	long err = 0;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 
-	io_cqring_add_event(ctx, user_data, err);
+	io_cqring_add_event(req, 0);
 	io_put_req(req, NULL);
 	return 0;
 }
@@ -1650,7 +1656,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -1697,7 +1703,7 @@ static int io_sync_file_range(struct io_kiocb *req,
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -1733,7 +1739,7 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			return ret;
 	}
 
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, nxt);
@@ -1789,7 +1795,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 #else
@@ -1850,7 +1856,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, NULL);
@@ -1861,7 +1867,7 @@ static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			     __poll_t mask)
 {
 	req->poll.done = true;
-	io_cqring_fill_event(ctx, req->user_data, mangle_poll(mask));
+	io_cqring_fill_event(req, mangle_poll(mask));
 	io_commit_cqring(ctx);
 }
 
@@ -2055,7 +2061,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 		list_del_init(&req->list);
 	}
 
-	io_cqring_fill_event(ctx, req->user_data, -ETIME);
+	io_cqring_fill_event(req, -ETIME);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
@@ -2099,7 +2105,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 	/* didn't find timeout */
 	if (ret) {
 fill_ev:
-		io_cqring_fill_event(ctx, req->user_data, ret);
+		io_cqring_fill_event(req, ret);
 		io_commit_cqring(ctx);
 		spin_unlock_irq(&ctx->completion_lock);
 		io_cqring_ev_posted(ctx);
@@ -2115,8 +2121,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 		goto fill_ev;
 	}
 
-	io_cqring_fill_event(ctx, req->user_data, 0);
-	io_cqring_fill_event(ctx, treq->user_data, -ECANCELED);
+	io_cqring_fill_event(req, 0);
+	io_cqring_fill_event(treq, -ECANCELED);
 	io_commit_cqring(ctx);
 	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
@@ -2256,7 +2262,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -2295,12 +2301,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	int ret, opcode;
 	struct sqe_submit *s = &req->submit;
 
-	req->user_data = READ_ONCE(s->sqe->user_data);
-
 	opcode = READ_ONCE(s->sqe->opcode);
 	switch (opcode) {
 	case IORING_OP_NOP:
-		ret = io_nop(req, req->user_data);
+		ret = io_nop(req);
 		break;
 	case IORING_OP_READV:
 		if (unlikely(s->sqe->buf_index))
@@ -2409,7 +2413,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	if (ret) {
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_cqring_add_event(ctx, sqe->user_data, ret);
+		io_cqring_add_event(req, ret);
 		io_put_req(req, NULL);
 	}
 
@@ -2539,7 +2543,7 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 		ret = io_async_cancel_one(ctx, user_data);
 	}
 
-	io_cqring_add_event(ctx, req->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, NULL);
 	return HRTIMER_NORESTART;
 }
@@ -2582,7 +2586,7 @@ static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
 		 * failed by the regular submission path.
 		 */
 		list_del(&nxt->list);
-		io_cqring_fill_event(ctx, nxt->user_data, ret);
+		io_cqring_fill_event(nxt, ret);
 		trace_io_uring_fail_link(req, nxt);
 		io_commit_cqring(ctx);
 		io_put_req(nxt, NULL);
@@ -2655,7 +2659,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 
 	/* and drop final reference, if we failed */
 	if (ret) {
-		io_cqring_add_event(ctx, req->user_data, ret);
+		io_cqring_add_event(req, ret);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
 		io_put_req(req, NULL);
@@ -2671,8 +2675,8 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
-			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
-			io_free_req(req, NULL);
+			io_cqring_add_event(req, ret);
+			io_double_put_req(req);
 		}
 		return 0;
 	}
@@ -2698,8 +2702,8 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
-			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
-			io_free_req(req, NULL);
+			io_cqring_add_event(req, ret);
+			io_double_put_req(req);
 			__io_free_req(shadow);
 			return 0;
 		}
@@ -2732,6 +2736,8 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	struct sqe_submit *s = &req->submit;
 	int ret;
 
+	req->user_data = s->sqe->user_data;
+
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
 		ret = -EINVAL;
@@ -2741,13 +2747,11 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = io_req_set_file(ctx, state, req);
 	if (unlikely(ret)) {
 err_req:
-		io_cqring_add_event(ctx, s->sqe->user_data, ret);
-		io_free_req(req, NULL);
+		io_cqring_add_event(req, ret);
+		io_double_put_req(req);
 		return;
 	}
 
-	req->user_data = s->sqe->user_data;
-
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
-- 
2.24.0

