Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E4C17447
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 10:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4682222D0
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dv2+F7vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKMKHC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:07:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfKMKHB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 05:07:01 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADA4VXC054291;
        Wed, 13 Nov 2019 10:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ga1N26yOsYHUA40BUveygxxOytRbe1Lyri9uHHu7Y64=;
 b=Dv2+F7vwtLhbYMncf7gl5WwgmLm4k5HHFbR7XrUjj8tnZXABJMomaMyvoP68FVv8nGxr
 ffbRu6MDayMaujRUe75qrkWSztLZBrjNT67CGrZ3yDGGzso0BDb+Y0W3QJ+El59cQbM3
 Zu59LOPwGzTWJJw1Fk1AMBBRqr5KkB9aaU9OZsYk6VidLiuaGzlra0UHbIfMVnZE7/dK
 38SjMYa2sNGEbkiAQ6G1rX+BYcr3ZLQVhlrEnw/T8TnUq+5LvAPcnC0eGnSrh+hIxpwu
 iHm32qd+rqeo/XMMbVzpJr0g/Ey65WOPMyr+uMlDmEPhrk94Q8YgDoUpQCP2fD0o8EK/ og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w5ndqbadt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 10:06:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADA3skA154898;
        Wed, 13 Nov 2019 10:06:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w7vpp0ry9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 10:06:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADA6wWj003070;
        Wed, 13 Nov 2019 10:06:58 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 02:06:57 -0800
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH 2/2] fs: io_uring: introduce req_need_defer()
Date:   Wed, 13 Nov 2019 18:06:25 +0800
Message-Id: <20191113100625.10774-2-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191113100625.10774-1-bob.liu@oracle.com>
References: <20191113100625.10774-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=911
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=974 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130095
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Make the code easier to read.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 fs/io_uring.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5781bfe..742f6a7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -448,7 +448,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	return NULL;
 }
 
-static inline bool __io_sequence_defer(struct io_kiocb *req)
+static inline bool __req_need_defer(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
@@ -456,12 +456,12 @@ static inline bool __io_sequence_defer(struct io_kiocb *req)
 					+ atomic_read(&ctx->cached_cq_overflow);
 }
 
-static inline bool io_sequence_defer(struct io_kiocb *req)
+static inline bool req_need_defer(struct io_kiocb *req)
 {
-	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
-		return false;
+	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) == REQ_F_IO_DRAIN)
+		return __req_need_defer(req);
 
-	return __io_sequence_defer(req);
+	return false;
 }
 
 static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
@@ -469,7 +469,7 @@ static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
 	struct io_kiocb *req;
 
 	req = list_first_entry_or_null(&ctx->defer_list, struct io_kiocb, list);
-	if (req && !io_sequence_defer(req)) {
+	if (req && !req_need_defer(req)) {
 		list_del_init(&req->list);
 		return req;
 	}
@@ -482,7 +482,7 @@ static struct io_kiocb *io_get_timeout_req(struct io_ring_ctx *ctx)
 	struct io_kiocb *req;
 
 	req = list_first_entry_or_null(&ctx->timeout_list, struct io_kiocb, list);
-	if (req && !__io_sequence_defer(req)) {
+	if (req && !__req_need_defer(req)) {
 		list_del_init(&req->list);
 		return req;
 	}
@@ -2436,7 +2436,8 @@ static int io_req_defer(struct io_kiocb *req)
 	struct io_uring_sqe *sqe_copy;
 	struct io_ring_ctx *ctx = req->ctx;
 
-	if (!io_sequence_defer(req) && list_empty(&ctx->defer_list))
+	/* Still need defer if there is pending req in defer list. */
+	if (!req_need_defer(req) && list_empty(&ctx->defer_list))
 		return 0;
 
 	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
@@ -2444,7 +2445,7 @@ static int io_req_defer(struct io_kiocb *req)
 		return -EAGAIN;
 
 	spin_lock_irq(&ctx->completion_lock);
-	if (!io_sequence_defer(req) && list_empty(&ctx->defer_list)) {
+	if (!req_need_defer(req) && list_empty(&ctx->defer_list)) {
 		spin_unlock_irq(&ctx->completion_lock);
 		kfree(sqe_copy);
 		return 0;
-- 
2.9.5

