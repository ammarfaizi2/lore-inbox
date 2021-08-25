Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14EC432BE
	for <io-uring@archiver.kernel.org>; Wed, 25 Aug 2021 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B426023E
	for <io-uring@archiver.kernel.org>; Wed, 25 Aug 2021 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhHYR7t (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:59:49 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58878 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231995AbhHYR7t (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 25 Aug 2021 13:59:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ulv-7ih_1629914336;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Ulv-7ih_1629914336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Aug 2021 01:59:02 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH for-5.15 v2] io_uring: don't free request to slab
Date:   Thu, 26 Aug 2021 01:58:56 +0800
Message-Id: <20210825175856.194299-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

It's not necessary to free the request back to slab when we fail to
get sqe, just move it to state->free_list.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 74b606990d7e..c53b084668fc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6899,7 +6899,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 		}
 		sqe = io_get_sqe(ctx);
 		if (unlikely(!sqe)) {
-			kmem_cache_free(req_cachep, req);
+			list_add(&req->inflight_entry, &ctx->submit_state.free_list);
 			break;
 		}
 		/* will complete beyond this point, count as submitted */
-- 
2.24.4

