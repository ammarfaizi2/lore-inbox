Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E5C4338F
	for <io-uring@archiver.kernel.org>; Fri, 20 Aug 2021 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F32261056
	for <io-uring@archiver.kernel.org>; Fri, 20 Aug 2021 18:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhHTSk6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:40:58 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55252 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhHTSk6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 20 Aug 2021 14:40:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UkSmjRN_1629484813;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UkSmjRN_1629484813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Aug 2021 02:40:19 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH for-5.15] io_uring: fix lacking of protection for compl_nr
Date:   Sat, 21 Aug 2021 02:40:13 +0800
Message-Id: <20210820184013.195812-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

coml_nr in ctx_flush_and_put() is not protected by uring_lock, this
may cause problems when accessing it parallelly.

Fixes: d10299e14aae ("io_uring: inline struct io_comp_state")
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c755efdac71f..420f8dfa5327 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2003,11 +2003,10 @@ static void ctx_flush_and_put(struct io_ring_ctx *ctx)
 {
 	if (!ctx)
 		return;
-	if (ctx->submit_state.compl_nr) {
-		mutex_lock(&ctx->uring_lock);
+	mutex_lock(&ctx->uring_lock);
+	if (ctx->submit_state.compl_nr)
 		io_submit_flush_completions(ctx);
-		mutex_unlock(&ctx->uring_lock);
-	}
+	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.24.4

