Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4CAFA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDDA215EA
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKHPu4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:50:56 -0500
Received: from smtpbgeu2.qq.com ([18.194.254.142]:43178 "EHLO smtpbgeu2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfKHPu4 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 10:50:56 -0500
X-QQ-mid: bizesmtp21t1573228249tc32y7bk
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 23:50:48 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZU90000A0000000
X-QQ-FEAT: lRUSrEWtKQDexlrbuWGuI/0114eOETV7zS+YP7td1Xagvs7K88Wt1tKqPOq65
        SWdaEoDvOzl78fWjfK32Yre5K/gomhATYytOHWdbv405WDp92PaPoXzfrSLy0lHbEX+mYbQ
        kA3KnOMYbwXABeH7lS0L58G1CEcjMwuEJfg8OOoRqh7ZV+9VC6Z5kWiA09ofho6IzjcGhcn
        PUNjBnnmeWke737xBD0UVT+ezgCVOrRwYdBLjKrachf2R7Mxr/w0TP71Vpkg7flk1Lw3/PD
        oXKq6S4GIzfA6Ija7AONk77TBWQIbgRF7OsSXYoz2I4LlK2/fX8CknkV8BdfxSObUH+qA+4
        yFFPseyIMf1lJo4fOZ0Mto+eN7baP2sBgJNNT/e
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH v4] io_uring: keep io_put_req only responsible for release and put req
Date:   Fri,  8 Nov 2019 23:50:36 +0800
Message-Id: <1573228236-69222-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
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
V4:
 - rebase to for-5.5/io_uring-test

 fs/io_uring.c | 73 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 94ec44c..577bc96 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -372,7 +372,7 @@ struct io_submit_state {
 static void io_wq_submit_work(struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_kiocb *req, long res);
 static void __io_free_req(struct io_kiocb *req);
-static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
+static void io_put_req(struct io_kiocb *req);
 static void io_double_put_req(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
@@ -558,7 +558,7 @@ static void io_kill_timeout(struct io_kiocb *req)
 		atomic_inc(&req->ctx->cq_timeouts);
 		list_del_init(&req->list);
 		io_cqring_fill_event(req, 0);
-		io_put_req(req, NULL);
+		io_put_req(req);
 	}
 }
 
@@ -658,7 +658,7 @@ static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 	while (!list_empty(&list)) {
 		req = list_first_entry(&list, struct io_kiocb, list);
 		list_del(&req->list);
-		io_put_req(req, NULL);
+		io_put_req(req);
 	}
 }
 
@@ -832,7 +832,7 @@ static bool io_link_cancel_timeout(struct io_kiocb *req)
 		io_cqring_fill_event(req, -ECANCELED);
 		io_commit_cqring(ctx);
 		req->flags &= ~REQ_F_LINK;
-		io_put_req(req, NULL);
+		io_put_req(req);
 		return true;
 	}
 
@@ -951,21 +951,13 @@ static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
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
@@ -974,6 +966,12 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	}
 }
 
+static void io_put_req(struct io_kiocb *req)
+{
+	if (refcount_dec_and_test(&req->refs))
+		io_free_req(req, NULL);
+}
+
 static void io_double_put_req(struct io_kiocb *req)
 {
 	/* drop both submit and complete references */
@@ -1220,15 +1218,18 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
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
@@ -1721,7 +1722,7 @@ static int io_nop(struct io_kiocb *req)
 		return -EINVAL;
 
 	io_cqring_add_event(req, 0);
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return 0;
 }
 
@@ -1768,7 +1769,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -1815,7 +1816,7 @@ static int io_sync_file_range(struct io_kiocb *req,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -1853,7 +1854,7 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	io_cqring_add_event(req, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 #endif
@@ -1907,7 +1908,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -1970,7 +1971,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	io_cqring_add_event(req, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return 0;
 }
 
@@ -2018,7 +2019,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 
 	io_cqring_ev_posted(ctx);
 
-	io_put_req(req, &nxt);
+	io_put_req_find_next(req, &nxt);
 	if (nxt)
 		*workptr = &nxt->work;
 }
@@ -2045,7 +2046,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 		io_cqring_ev_posted(ctx);
-		io_put_req(req, NULL);
+		io_put_req(req);
 	} else {
 		io_queue_async_work(req);
 	}
@@ -2138,7 +2139,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (mask) {
 		io_cqring_ev_posted(ctx);
-		io_put_req(req, nxt);
+		io_put_req_find_next(req, nxt);
 	}
 	return ipt.error;
 }
@@ -2180,7 +2181,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	io_cqring_ev_posted(ctx);
 	if (req->flags & REQ_F_LINK)
 		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return HRTIMER_NORESTART;
 }
 
@@ -2223,7 +2224,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 		io_cqring_ev_posted(ctx);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req, NULL);
+		io_put_req(req);
 		return 0;
 	}
 
@@ -2239,8 +2240,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
 
-	io_put_req(treq, NULL);
-	io_put_req(req, NULL);
+	io_put_req(treq);
+	io_put_req(req);
 	return 0;
 }
 
@@ -2375,7 +2376,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_cqring_add_event(req, ret);
-	io_put_req(req, nxt);
+	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -2521,13 +2522,13 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	}
 
 	/* drop submission reference */
-	io_put_req(req, NULL);
+	io_put_req(req);
 
 	if (ret) {
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
 		io_cqring_add_event(req, ret);
-		io_put_req(req, NULL);
+		io_put_req(req);
 	}
 
 	/* async context always use a copy of the sqe */
@@ -2658,7 +2659,7 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	}
 
 	io_cqring_add_event(req, ret);
-	io_put_req(req, NULL);
+	io_put_req(req);
 	return HRTIMER_NORESTART;
 }
 
@@ -2690,7 +2691,7 @@ static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
 	ret = 0;
 err:
 	/* drop submission reference */
-	io_put_req(nxt, NULL);
+	io_put_req(nxt);
 
 	if (ret) {
 		struct io_ring_ctx *ctx = req->ctx;
@@ -2703,7 +2704,7 @@ static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
 		io_cqring_fill_event(nxt, ret);
 		trace_io_uring_fail_link(req, nxt);
 		io_commit_cqring(ctx);
-		io_put_req(nxt, NULL);
+		io_put_req(nxt);
 		ret = -ECANCELED;
 	}
 
@@ -2769,14 +2770,14 @@ static int __io_queue_sqe(struct io_kiocb *req)
 
 	/* drop submission reference */
 err:
-	io_put_req(req, NULL);
+	io_put_req(req);
 
 	/* and drop final reference, if we failed */
 	if (ret) {
 		io_cqring_add_event(req, ret);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req, NULL);
+		io_put_req(req);
 	}
 
 	return ret;
-- 
2.7.4



