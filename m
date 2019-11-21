Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C252CC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 09:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859C82071C
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 09:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXaa0lps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKUJCb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:02:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45402 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJCb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 04:02:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL8wviF066367;
        Thu, 21 Nov 2019 09:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=d2LATW1ru7S69uRwdbB+8Jhe2ahhZ/+JOAYLVmH+F3E=;
 b=JXaa0lpsKslGaF5XjLGx/jnPosDT8C5DfsWV6nxRP32HwCeZ4iBUkaGYLxmDFT/xvj0a
 clDVbjSPWcjJ9vJv+BVuJI7j+a1K48uanwo5TCo3vRTDu5iyTyGSWzz88sUlLKym2y/G
 AYGc2mAHwgpLAHrk/T7SV1pA5vcwaSZVzSV6N9TiKAJEMmwkX35LoTDyYxRbOvN2lX5L
 N0z0yxQMltxsvTNC5xypCRwhum9JdyLaRfhJLM/cngXlnsuP9YpQy+0w5K0nHxGFiwtI
 h6KMr6nWjRG0IaI0GKSz89WtyWzESNIQB744dlAgGLTqlB35NuYi7WYpUNNSlaebAC3Z Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8hu2qg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 09:02:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL8rsjl115015;
        Thu, 21 Nov 2019 09:00:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wd46xxurr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 09:00:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAL90QEm015078;
        Thu, 21 Nov 2019 09:00:27 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:00:26 -0800
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH] io_uring: introduce add/post event and put function
Date:   Thu, 21 Nov 2019 17:00:04 +0800
Message-Id: <20191121090004.20139-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210081
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

* Only complie-tested right now. *
There are so many duplicated code doing add/post event and then put req.
Put them to common funcs io_cqring_event_posted_and_put() and
io_cqring_add_event_and_put().

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 fs/io_uring.c | 145 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 74 insertions(+), 71 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 299a218..816eef3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1039,6 +1039,56 @@ static void io_double_put_req(struct io_kiocb *req)
 		io_free_req(req);
 }
 
+/*
+ * Add event to io_cqring and put req.
+ */
+static void io_cqring_add_event_and_put(struct io_kiocb *req, long ret,
+		int should_fail_link, bool double_put, struct io_kiocb **nxt)
+{
+	if (should_fail_link == 1) {
+		if (ret < 0 && (req->flags & REQ_F_LINK))
+			req->flags |= REQ_F_FAIL_LINK;
+	} else if (should_fail_link == 2) {
+		/* Don't care about ret < 0 when should_fail_link == 2 */
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
+	}
+
+	io_cqring_add_event(req, ret);
+
+	if (double_put)
+		io_double_put_req(req);
+	else {
+		if (nxt)
+			io_put_req_find_next(req, nxt);
+		else
+			io_put_req(req);
+	}
+}
+
+/*
+ * Post event and put req.
+ */
+static void io_cqring_event_posted_and_put(struct io_kiocb *req, long ret,
+		int should_fail_link, struct io_kiocb **nxt)
+{
+	if (should_fail_link == 1) {
+		if (ret < 0 && (req->flags & REQ_F_LINK))
+			req->flags |= REQ_F_FAIL_LINK;
+	} else if (should_fail_link == 2) {
+		/* Don't care about ret < 0 when should_fail_link == 2 */
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
+	}
+
+	io_cqring_ev_posted(req->ctx);
+
+	if (nxt)
+		io_put_req_find_next(req, nxt);
+	else
+		io_put_req(req);
+}
+
 static unsigned io_cqring_events(struct io_ring_ctx *ctx, bool noflush)
 {
 	struct io_rings *rings = ctx->rings;
@@ -1789,8 +1839,7 @@ static int io_nop(struct io_kiocb *req)
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 
-	io_cqring_add_event(req, 0);
-	io_put_req(req);
+	io_cqring_add_event_and_put(req, 0, 0, false, NULL);
 	return 0;
 }
 
@@ -1834,10 +1883,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 				end > 0 ? end : LLONG_MAX,
 				fsync_flags & IORING_FSYNC_DATASYNC);
 
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_put(req, ret, 1, false, nxt);
 	return 0;
 }
 
@@ -1880,11 +1926,8 @@ static int io_sync_file_range(struct io_kiocb *req,
 	flags = READ_ONCE(sqe->sync_range_flags);
 
 	ret = sync_file_range(req->rw.ki_filp, sqe_off, sqe_len, flags);
+	io_cqring_add_event_and_put(req, ret, 1, false, nxt);
 
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
 	return 0;
 }
 
@@ -1919,10 +1962,8 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			return ret;
 	}
 
-	io_cqring_add_event(req, ret);
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_put(req, ret, 1, false, nxt);
+
 	return 0;
 }
 #endif
@@ -1975,10 +2016,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_put(req, ret, 1, false, nxt);
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -2061,10 +2099,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	ret = io_poll_cancel(ctx, READ_ONCE(sqe->addr));
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_add_event(req, ret);
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req);
+	io_cqring_add_event_and_put(req, ret, 1, false, NULL);
 	return 0;
 }
 
@@ -2118,11 +2153,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	io_poll_complete(req, mask, ret);
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_ev_posted(ctx);
-
-	if (ret < 0 && req->flags & REQ_F_LINK)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req_find_next(req, &nxt);
+	io_cqring_event_posted_and_put(req, ret, 1, &nxt);
 	if (nxt)
 		*workptr = &nxt->work;
 }
@@ -2267,10 +2298,9 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
-	if (mask) {
-		io_cqring_ev_posted(ctx);
-		io_put_req_find_next(req, nxt);
-	}
+	if (mask)
+		io_cqring_event_posted_and_put(req, 0, 0, nxt);
+
 	return ipt.error;
 }
 
@@ -2308,10 +2338,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	io_cqring_ev_posted(ctx);
-	if (req->flags & REQ_F_LINK)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req);
+	io_cqring_event_posted_and_put(req, 0, 2, NULL);
 	return HRTIMER_NORESTART;
 }
 
@@ -2366,10 +2393,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irq(&ctx->completion_lock);
-	io_cqring_ev_posted(ctx);
-	if (ret < 0 && req->flags & REQ_F_LINK)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req);
+	io_cqring_event_posted_and_put(req, ret, 1, NULL);
 	return 0;
 }
 
@@ -2530,11 +2554,7 @@ static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
 	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
-	io_cqring_ev_posted(ctx);
-
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req_find_next(req, nxt);
+	io_cqring_event_posted_and_put(req, ret, 1, nxt);
 }
 
 static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
@@ -2722,12 +2742,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	/* drop submission reference */
 	io_put_req(req);
 
-	if (ret) {
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_cqring_add_event(req, ret);
-		io_put_req(req);
-	}
+	if (ret)
+		io_cqring_add_event_and_put(req, ret, 2, false, NULL);
 
 	/* if a dependent link is ready, pass it back */
 	if (!ret && nxt) {
@@ -2870,8 +2886,7 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 						-ETIME);
 		io_put_req(prev);
 	} else {
-		io_cqring_add_event(req, -ETIME);
-		io_put_req(req);
+		io_cqring_add_event_and_put(req, -ETIME, 0, false, NULL);
 	}
 	return HRTIMER_NORESTART;
 }
@@ -2962,12 +2977,8 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	}
 
 	/* and drop final reference, if we failed */
-	if (ret) {
-		io_cqring_add_event(req, ret);
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req);
-	}
+	if (ret)
+		io_cqring_add_event_and_put(req, ret, 2, false, NULL);
 }
 
 static void io_queue_sqe(struct io_kiocb *req)
@@ -2975,14 +2986,10 @@ static void io_queue_sqe(struct io_kiocb *req)
 	int ret;
 
 	ret = io_req_defer(req);
-	if (!ret) {
+	if (!ret)
 		__io_queue_sqe(req);
-	} else if (ret != -EIOCBQUEUED) {
-		io_cqring_add_event(req, ret);
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_double_put_req(req);
-	}
+	else if (ret != -EIOCBQUEUED)
+		io_cqring_add_event_and_put(req, ret, 2, true, NULL);
 }
 
 static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
@@ -3010,10 +3017,7 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 err:
-			io_cqring_add_event(req, ret);
-			if (req->flags & REQ_F_LINK)
-				req->flags |= REQ_F_FAIL_LINK;
-			io_double_put_req(req);
+			io_cqring_add_event_and_put(req, ret, 2, true, NULL);
 			if (shadow)
 				__io_free_req(shadow);
 			return;
@@ -3057,8 +3061,7 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	ret = io_req_set_file(state, req);
 	if (unlikely(ret)) {
 err_req:
-		io_cqring_add_event(req, ret);
-		io_double_put_req(req);
+		io_cqring_add_event_and_put(req, ret, 0, true, NULL);
 		return;
 	}
 
-- 
2.9.5

