Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E74C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C89207FD
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RDf9rvLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKYJEj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:04:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYJEj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 04:04:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP94amp133884;
        Mon, 25 Nov 2019 09:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=ZTxSMz5DvCDSJswRNy3Gy8+gP9E8s+Uc3NGUl3V9T+s=;
 b=RDf9rvLmBPCbw6DEB8tQAxK668DwPiBX47gbrXvP4wMLR5vEWlRIvEpx8R5KbVhlLAzM
 BNawalee4MU7f52pBN7tNB52C9m0xTC20gzHH8wKPYOTtvW/1UaxcrmqhqYHCKWfZxnv
 E4hGOltszmJqoD5A0S4YgETfiH/aE4CqZODeQRS6imiPOVReabFqcjVMmbTshhBugzhg
 rZO2VQca4mxUBxgTtjcQh6wVCbZtPJgqcuZXR6s0brCbwHAAVzCX7K2yVTVLwyyvByVF
 Sv1DV/3lFocDpNW8OnamsNFfGtspJi36xRvuZgHodkxQage9N8/u2XgHk/9gCFEveaJ3 GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wev6tx5dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 09:04:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP938he041043;
        Mon, 25 Nov 2019 09:04:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wfe7yknpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 09:04:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAP94Xu1016482;
        Mon, 25 Nov 2019 09:04:34 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 01:04:33 -0800
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v2] io_uring: introduce add/post_event_and_complete function
Date:   Mon, 25 Nov 2019 17:04:12 +0800
Message-Id: <20191125090412.24045-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250085
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

* Only complie-tested right now. *
There are many duplicated code doing add/post event, set REQ_F_FAIL_LINK and
then put req. Put them into common funcs io_cqring_event_posted_and_complete()
and io_cqring_add_event_and_complete().

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
Changes since v1:
- Using FAIL_LINK_* enums.

---
 fs/io_uring.c | 131 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9f9c2d4..d91864e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -363,6 +363,12 @@ struct io_kiocb {
 	struct io_wq_work	work;
 };
 
+enum set_f_fail_link {
+	FAIL_LINK_NONE,
+	FAIL_LINK_ON_NEGATIVE,
+	FAIL_LINK_ON_NOTEQUAL_RES,
+	FAIL_LINK_ALWAYS,
+};
 #define IO_PLUG_THRESHOLD		2
 #define IO_IOPOLL_BATCH			8
 
@@ -1253,34 +1259,66 @@ static void kiocb_end_write(struct io_kiocb *req)
 	file_end_write(req->file);
 }
 
-static void io_complete_rw_common(struct kiocb *kiocb, long res)
+void set_f_fail_link(struct io_kiocb *req, long ret, unsigned int fail_link)
+{
+	if (fail_link == FAIL_LINK_ALWAYS) {
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
+	} else if (fail_link == FAIL_LINK_ON_NEGATIVE) {
+		if (ret < 0 && (req->flags & REQ_F_LINK))
+			req->flags |= REQ_F_FAIL_LINK;
+	} else if (fail_link == FAIL_LINK_ON_NOTEQUAL_RES) {
+		if ((ret != req->result) && (req->flags & REQ_F_LINK))
+			req->flags |= REQ_F_FAIL_LINK;
+	}
+}
+
+static void io_cqring_add_event_and_complete(struct io_kiocb *req, long ret,
+		unsigned int fail_link, struct io_kiocb **nxt)
+{
+	set_f_fail_link(req, ret, fail_link);
+	io_cqring_add_event(req, ret);
+
+	if (nxt)
+		io_put_req_find_next(req, nxt);
+	else
+		io_put_req(req);
+}
+
+static void io_cqring_ev_posted_and_complete(struct io_kiocb *req, long ret,
+		unsigned int fail_link, struct io_kiocb **nxt)
+{
+	io_cqring_ev_posted(req->ctx);
+	set_f_fail_link(req, ret, fail_link);
+
+	if (nxt)
+		io_put_req_find_next(req, nxt);
+	else
+		io_put_req(req);
+}
+
+static void io_complete_rw_common(struct kiocb *kiocb, long res,
+		struct io_kiocb **nxt)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
 		kiocb_end_write(req);
 
-	if ((req->flags & REQ_F_LINK) && res != req->result)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, res);
+	io_cqring_add_event_and_complete(req, res,
+			FAIL_LINK_ON_NOTEQUAL_RES, nxt);
 }
 
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
-	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
-
-	io_complete_rw_common(kiocb, res);
-	io_put_req(req);
+	io_complete_rw_common(kiocb, res, NULL);
 }
 
 static struct io_kiocb *__io_complete_rw(struct kiocb *kiocb, long res)
 {
-	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 	struct io_kiocb *nxt = NULL;
 
-	io_complete_rw_common(kiocb, res);
-	io_put_req_find_next(req, &nxt);
-
+	io_complete_rw_common(kiocb, res, &nxt);
 	return nxt;
 }
 
@@ -1831,10 +1869,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 				end > 0 ? end : LLONG_MAX,
 				fsync_flags & IORING_FSYNC_DATASYNC);
 
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
 	return 0;
 }
 
@@ -1878,10 +1913,7 @@ static int io_sync_file_range(struct io_kiocb *req,
 
 	ret = sync_file_range(req->rw.ki_filp, sqe_off, sqe_len, flags);
 
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
 	return 0;
 }
 
@@ -1916,10 +1948,7 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			return ret;
 	}
 
-	io_cqring_add_event(req, ret);
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
 	return 0;
 }
 #endif
@@ -1972,10 +2001,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -2005,10 +2031,8 @@ static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		return -EAGAIN;
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+
+	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -2091,10 +2115,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	ret = io_poll_cancel(ctx, READ_ONCE(sqe->addr));
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_add_event(req, ret);
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req);
+	io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, NULL);
 	return 0;
 }
 
@@ -2148,11 +2169,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 	io_poll_complete(req, mask, ret);
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_ev_posted(ctx);
-
-	if (ret < 0 && req->flags & REQ_F_LINK)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req_find_next(req, &nxt);
+	io_cqring_ev_posted_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, &nxt);
 	if (nxt)
 		*workptr = &nxt->work;
 }
@@ -2338,10 +2355,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	io_cqring_ev_posted(ctx);
-	if (req->flags & REQ_F_LINK)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req);
+	io_cqring_ev_posted_and_complete(req, 0, FAIL_LINK_ALWAYS, NULL);
 	return HRTIMER_NORESTART;
 }
 
@@ -2396,10 +2410,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irq(&ctx->completion_lock);
-	io_cqring_ev_posted(ctx);
-	if (ret < 0 && req->flags & REQ_F_LINK)
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req(req);
+	io_cqring_ev_posted_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, NULL);
 	return 0;
 }
 
@@ -2560,11 +2571,7 @@ static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
 	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
-	io_cqring_ev_posted(ctx);
-
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_put_req_find_next(req, nxt);
+	io_cqring_ev_posted_and_complete(req, ret, FAIL_LINK_ON_NEGATIVE, nxt);
 }
 
 static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
@@ -2738,12 +2745,8 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	/* drop submission reference */
 	io_put_req(req);
 
-	if (ret) {
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_cqring_add_event(req, ret);
-		io_put_req(req);
-	}
+	if (ret)
+		io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ALWAYS, NULL);
 
 	/* if a dependent link is ready, pass it back */
 	if (!ret && nxt) {
@@ -2981,12 +2984,8 @@ static void __io_queue_sqe(struct io_kiocb *req)
 	}
 
 	/* and drop final reference, if we failed */
-	if (ret) {
-		io_cqring_add_event(req, ret);
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req);
-	}
+	if (ret)
+		io_cqring_add_event_and_complete(req, ret, FAIL_LINK_ALWAYS, NULL);
 }
 
 static void io_queue_sqe(struct io_kiocb *req)
-- 
2.9.5

