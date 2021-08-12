Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FAFC4338F
	for <io-uring@archiver.kernel.org>; Thu, 12 Aug 2021 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8148D60EFE
	for <io-uring@archiver.kernel.org>; Thu, 12 Aug 2021 04:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhHLEPn (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 12 Aug 2021 00:15:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41486 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhHLEPm (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 12 Aug 2021 00:15:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UikT1XN_1628741676;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UikT1XN_1628741676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 12:14:46 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 3/3] io_uring: code clean for completion_lock in io_arm_poll_handler()
Date:   Thu, 12 Aug 2021 12:14:36 +0800
Message-Id: <20210812041436.101503-4-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210812041436.101503-1-haoxu@linux.alibaba.com>
References: <20210812041436.101503-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We can merge two spin_unlock() operations to one since we removed some
code not long ago.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b29774aa1f09..9cbc66b52643 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5231,13 +5231,10 @@ static int io_arm_poll_handler(struct io_kiocb *req)
 
 	ret = __io_arm_poll_handler(req, &apoll->poll, &ipt, mask,
 					io_async_wake);
-	if (ret || ipt.error) {
-		spin_unlock(&ctx->completion_lock);
-		if (ret)
-			return IO_APOLL_READY;
-		return IO_APOLL_ABORTED;
-	}
-	spin_unlock(&ctx->completion_lock);
+	spin_unlock_irq(&ctx->completion_lock);
+	if (ret || ipt.error)
+		return ret ? IO_APOLL_READY : IO_APOLL_ABORTED;
+
 	trace_io_uring_poll_arm(ctx, req, req->opcode, req->user_data,
 				mask, apoll->poll.events);
 	return IO_APOLL_OK;
-- 
2.24.4

