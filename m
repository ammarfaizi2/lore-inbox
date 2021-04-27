Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D5C433B4
	for <io-uring@archiver.kernel.org>; Tue, 27 Apr 2021 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9490960FF1
	for <io-uring@archiver.kernel.org>; Tue, 27 Apr 2021 12:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhD0MqS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 27 Apr 2021 08:46:18 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28708 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235489AbhD0MqS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 27 Apr 2021 08:46:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UX-Z1zZ_1619527526;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UX-Z1zZ_1619527526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Apr 2021 20:45:33 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 5.13] io_uring: don't set IORING_SQ_NEED_WAKEUP when sqthread is dying
Date:   Tue, 27 Apr 2021 20:45:26 +0800
Message-Id: <1619527526-103300-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

we don't need to re-fork the sqthread over exec, so no need to set
IORING_SQ_NEED_WAKEUP when sqthread is dying.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6b578c380e73..92dcd1c21516 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6897,8 +6897,6 @@ static int io_sq_thread(void *data)
 
 	io_uring_cancel_sqpoll(sqd);
 	sqd->thread = NULL;
-	list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
-		io_ring_set_wakeup_flag(ctx);
 	io_run_task_work();
 	io_run_task_work_head(&sqd->park_task_work);
 	mutex_unlock(&sqd->lock);
-- 
1.8.3.1

