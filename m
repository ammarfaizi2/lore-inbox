Return-Path: <SRS0=bqOQ=5Z=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD8C2BA2B
	for <io-uring@archiver.kernel.org>; Thu,  9 Apr 2020 02:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B292074F
	for <io-uring@archiver.kernel.org>; Thu,  9 Apr 2020 02:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDICsp (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:48:45 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34688 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgDICsp (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 8 Apr 2020 22:48:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tv0ab50_1586400505;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Tv0ab50_1586400505)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Apr 2020 10:48:31 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH] io_uring: set error code to be ENOMEM when io_alloc_async_ctx() fails
Date:   Thu,  9 Apr 2020 10:48:20 +0800
Message-Id: <20200409024820.2135-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We should return ENOMEM for memory allocation failures, fix this
issue for io_alloc_async_ctx() calls.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/io_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6ac830b2b4fb..42a49a7e7792 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4993,7 +4993,7 @@ static int io_req_defer(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return 0;
 
 	if (!req->io && io_alloc_async_ctx(req))
-		return -EAGAIN;
+		return -ENOMEM;
 
 	ret = io_req_defer_prep(req, sqe);
 	if (ret < 0)
@@ -5695,7 +5695,7 @@ static bool io_submit_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			ctx->drain_next = 1;
 		}
 		if (io_alloc_async_ctx(req)) {
-			ret = -EAGAIN;
+			ret = -ENOMEM;
 			goto err_req;
 		}
 
@@ -5723,7 +5723,7 @@ static bool io_submit_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			INIT_LIST_HEAD(&req->link_list);
 
 			if (io_alloc_async_ctx(req)) {
-				ret = -EAGAIN;
+				ret = -ENOMEM;
 				goto err_req;
 			}
 			ret = io_req_defer_prep(req, sqe);
-- 
2.17.2

