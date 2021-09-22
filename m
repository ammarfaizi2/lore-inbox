Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03553C4332F
	for <io-uring@archiver.kernel.org>; Wed, 22 Sep 2021 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E520E611B0
	for <io-uring@archiver.kernel.org>; Wed, 22 Sep 2021 10:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhIVKOe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:14:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45463 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234809AbhIVKOR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 22 Sep 2021 06:14:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpDsdJl_1632305558;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UpDsdJl_1632305558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 18:12:46 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 2/3] io_uring: fix lacking of EPOLLONESHOT
Date:   Wed, 22 Sep 2021 18:12:37 +0800
Message-Id: <20210922101238.7177-3-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210922101238.7177-1-haoxu@linux.alibaba.com>
References: <20210922101238.7177-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We should set EPOLLONESHOT if cqring_fill_event() returns false since
io_poll_add() decides to put req or not by it.

Fixes: 5082620fb2ca ("io_uring: terminate multishot poll for CQ ring overflow")
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4b0a40ad28b0..b7c9fcce2de2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5340,8 +5340,10 @@ static bool __io_poll_complete(struct io_kiocb *req, __poll_t mask)
 	}
 	if (req->poll.events & EPOLLONESHOT)
 		flags = 0;
-	if (!io_cqring_fill_event(ctx, req->user_data, error, flags))
+	if (!io_cqring_fill_event(ctx, req->user_data, error, flags)) {
+		req->poll.events |= EPOLLONESHOT;
 		flags = 0;
+	}
 	if (flags & IORING_CQE_F_MORE)
 		ctx->cq_extra++;
 
-- 
2.24.4

