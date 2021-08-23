Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87037C4320A
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D31613BD
	for <io-uring@archiver.kernel.org>; Mon, 23 Aug 2021 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhHWShj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:37:39 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44198 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhHWShj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 23 Aug 2021 14:37:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UlQutiJ_1629743808;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UlQutiJ_1629743808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Aug 2021 02:36:54 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 1/2] io_uring: run task_work when sqthread is waken up
Date:   Tue, 24 Aug 2021 02:36:47 +0800
Message-Id: <20210823183648.163361-2-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210823183648.163361-1-haoxu@linux.alibaba.com>
References: <20210823183648.163361-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Sqthread may be waken up because of task_work added, since we are
now heavily using task_work, let's run it as soon as possible.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c3bd2b3fc46b..8172f5f893ad 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6962,6 +6962,8 @@ static int io_sq_thread(void *data)
 		}
 
 		finish_wait(&sqd->wait, &wait);
+		if (current->task_works)
+			io_run_task_work();
 		timeout = jiffies + sqd->sq_thread_idle;
 	}
 
-- 
2.24.4

