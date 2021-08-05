Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B84C432BE
	for <io-uring@archiver.kernel.org>; Thu,  5 Aug 2021 10:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE8600D4
	for <io-uring@archiver.kernel.org>; Thu,  5 Aug 2021 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbhHEKGF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:06:05 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58198 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240017AbhHEKGB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 5 Aug 2021 06:06:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui1e.zi_1628157938;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Ui1e.zi_1628157938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 18:05:45 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 3/3] io-wq: fix lack of acct->nr_workers < acct->max_workers judgement
Date:   Thu,  5 Aug 2021 18:05:38 +0800
Message-Id: <20210805100538.127891-4-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210805100538.127891-1-haoxu@linux.alibaba.com>
References: <20210805100538.127891-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There should be this judgement before we create an io-worker

Fixes: 685fe7feedb9 ("io-wq: eliminate the need for a manager thread")
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io-wq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 88d0ba7be1fb..b7cc31f96fdb 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -276,9 +276,17 @@ static void create_worker_cb(struct callback_head *cb)
 {
 	struct create_worker_data *cwd;
 	struct io_wq *wq;
+	struct io_wqe *wqe;
+	struct io_wqe_acct *acct;
 
 	cwd = container_of(cb, struct create_worker_data, work);
-	wq = cwd->wqe->wq;
+	wqe = cwd->wqe;
+	wq = wqe->wq;
+	acct = &wqe->acct[cwd->index];
+	raw_spin_lock_irq(&wqe->lock);
+	if (acct->nr_workers < acct->max_workers)
+		acct->nr_workers++;
+	raw_spin_unlock_irq(&wqe->lock);
 	create_io_worker(wq, cwd->wqe, cwd->index);
 	kfree(cwd);
 }
-- 
2.24.4

