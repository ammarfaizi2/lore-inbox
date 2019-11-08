Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C80C5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A7920679
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfKHOsc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:48:32 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:56829 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKHOsc (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 09:48:32 -0500
X-QQ-mid: bizesmtp23t1573224504txe4fd09
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 22:48:24 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZU90000A0000000
X-QQ-FEAT: 9MsTBLS6yXEVc/dKb7uMwhU27QNqHHzxXeEHzg3ywT7VEW9mATheKdDmJ875I
        QpQ0g7zsSy8NNBhSOYAvNm4Le2dYgKNSoydfH3sGmy6HHJjAHajYcLhUr+YTze+/1uPJmRv
        +UftRj4aldxPTRq4WbryobHrkp4oQjkZ04OCIzjhfZivLBmCNWCY+KoICuwaVxTWue0FbDa
        rJVxvzN00zgJdXgU7gviDHQAphKiSGxFZd4zB5wA6dPAvcCp+0gAgDdMPLoWcmPPNC2CfGH
        dBchdPyQBJCJAOjeLczU7uW6c7UtGVOEHTBn0Z8vNRghrSpCSE1pjJYjI1xN3InaeA+l4Pk
        jj/W79lpEpv7fBuidILQyh+hr+VIJYYbMX4bZZN
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH v3 2/2] io_uring: keep io_put_req only responsible for release and put req
Date:   Fri,  8 Nov 2019 22:47:59 +0800
Message-Id: <1573224479-59295-2-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573224479-59295-1-git-send-email-liuyun01@kylinos.cn>
References: <1573224479-59295-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We already have io_put_req_find_next to find the next req of the link.
we should not use the io_put_req function to find them. They should be
functions of the same level.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 67 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2cc53e3..2ee9e55 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -372,10 +372,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
-static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
 
 static struct kmem_cache *req_cachep;
-
 static const struct file_operations io_uring_fops;
 
 struct sock *io_uring_get_socket(struct file *file)
@@ -843,21 +841,13 @@ static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
  * Drop reference to request, return next in chain (if there is one) if this
  * was the last reference to this request.
  */
-static struct io_kiocb *io_put_req_find_next(struct io_kiocb *req)
+static void io_put_req_find_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
 	struct io_kiocb *nxt = NULL;
 
 	if (refcount_dec_and_test(&req->refs))
 		io_free_req(req, &nxt);
 
-	return nxt;
-}
-
-static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
-{
-	struct io_kiocb *nxt;
-
-	nxt = io_put_req_find_next(req);
 	if (nxt) {
 		if (nxtptr)
 			*nxtptr = nxt;
@@ -866,6 +856,12 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	}
 }
 
+static void io_put_req(struct io_kiocb *req)
+{
+	if (refcount_dec_and_test(&req->refs))
+		io_free_req(req, NULL);
+}
+
 static unsigned io_cqring_events(struct io_rings *rings)
 {
 	/* See comment at the top of this file */
@@ -1100,15 +1096,18 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
 	io_complete_rw_common(kiocb, res);
-	io_put_req(req, NULL);
+	io_put_req(req);
 }
 
 static struct io_kiocb *__io_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	struct io_kiocb *nxt = NULL;
 
 	io_complete_rw_common(kiocb, res);
-	return io_put_req_find_next(req);
+	io_put_req_find_next(req, &nxt);
+
+	return nxt;
 }
 
 static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
@@ -1602,7 +1601,7 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 		return -EINVAL;
 
 	io_cqring_add_event(ctx, user_data, err);
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return 0;
 }
 
@@ -1649,7 +1648,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -1696,7 +1695,7 @@ static int io_sync_file_range(struct io_kiocb *req,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -1734,7 +1733,7 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 #endif
@@ -1788,7 +1787,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -1851,7 +1850,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return 0;
 }
 
@@ -1899,7 +1898,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 
 	io_cqring_ev_posted(ctx);
 
-	io_put_req(req, &nxt);
+	io_put_req_find_next(req, &nxt);
 	if (nxt)
 		*workptr = &nxt->work;
 }
@@ -1926,7 +1925,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 		io_cqring_ev_posted(ctx);
-		io_put_req(req, NULL);
+		io_put_req(req);
 	} else {
 		io_queue_async_work(req);
 	}
@@ -2019,7 +2018,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (mask) {
 		io_cqring_ev_posted(ctx);
-		io_put_req(req, nxt);
+		io_put_req_find_next(req, nxt);
 	}
 	return ipt.error;
 }
@@ -2061,7 +2060,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	io_cqring_ev_posted(ctx);
 	if (req->flags & REQ_F_LINK)
 		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return HRTIMER_NORESTART;
 }
 
@@ -2104,7 +2103,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 		io_cqring_ev_posted(ctx);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req, NULL);
+		io_put_req(req);
 		return 0;
 	}
 
@@ -2120,8 +2119,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
 
-	io_put_req(treq, NULL);
-	io_put_req(req, NULL);
+	io_put_req(treq);
+	io_put_req(req);
 	return 0;
 }
 
@@ -2256,7 +2255,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -2405,13 +2404,13 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	}
 
 	/* drop submission reference */
-	io_put_req(req, NULL);
+	io_put_req(req);
 
 	if (ret) {
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
 		io_cqring_add_event(ctx, sqe->user_data, ret);
-		io_put_req(req, NULL);
+		io_put_req(req);
 	}
 
 	/* async context always use a copy of the sqe */
@@ -2542,7 +2541,7 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	}
 
 	io_cqring_add_event(ctx, req->user_data, ret);
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return HRTIMER_NORESTART;
 }
 
@@ -2574,7 +2573,7 @@ static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
 	ret = 0;
 err:
 	/* drop submission reference */
-	io_put_req(nxt, NULL);
+	io_put_req(nxt);
 
 	if (ret) {
 		struct io_ring_ctx *ctx = req->ctx;
@@ -2587,7 +2586,7 @@ static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
 		io_cqring_fill_event(ctx, nxt->user_data, ret);
 		trace_io_uring_fail_link(req, nxt);
 		io_commit_cqring(ctx);
-		io_put_req(nxt, NULL);
+		io_put_req(nxt);
 		ret = -ECANCELED;
 	}
 
@@ -2654,14 +2653,14 @@ static int __io_queue_sqe(struct io_kiocb *req)
 
 	/* drop submission reference */
 err:
-	io_put_req(req, NULL);
+	io_put_req(req);
 
 	/* and drop final reference, if we failed */
 	if (ret) {
 		io_cqring_add_event(ctx, req->user_data, ret);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req, NULL);
+		io_put_req(req);
 	}
 
 	return ret;
-- 
2.7.4



