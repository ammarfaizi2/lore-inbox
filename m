Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD71CC4338F
	for <io-uring@archiver.kernel.org>; Tue, 10 Aug 2021 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C220D60E9B
	for <io-uring@archiver.kernel.org>; Tue, 10 Aug 2021 12:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhHJM4Y (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:56:24 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39089 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237431AbhHJM4Y (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Aug 2021 08:56:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uiaz1mG_1628600155;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Uiaz1mG_1628600155)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Aug 2021 20:56:01 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH for-5.15] io-wq: move nr_running and worker_refs out of wqe->lock protection
Date:   Tue, 10 Aug 2021 20:55:54 +0800
Message-Id: <20210810125554.99229-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We don't need to protect nr_running and worker_refs by wqe->lock, so
narrow the range of raw_spin_lock_irq - raw_spin_unlock_irq

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io-wq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 4ce83bb48021..8da9bb103916 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -256,16 +256,17 @@ static void io_wqe_wake_worker(struct io_wqe *wqe, struct io_wqe_acct *acct)
 
 		raw_spin_lock_irq(&wqe->lock);
 		if (acct->nr_workers < acct->max_workers) {
-			atomic_inc(&acct->nr_running);
-			atomic_inc(&wqe->wq->worker_refs);
 			if (!acct->nr_workers)
 				first = true;
 			acct->nr_workers++;
 			do_create = true;
 		}
 		raw_spin_unlock_irq(&wqe->lock);
-		if (do_create)
+		if (do_create) {
+			atomic_inc(&acct->nr_running);
+			atomic_inc(&wqe->wq->worker_refs);
 			create_io_worker(wqe->wq, wqe, acct->index, first);
+		}
 	}
 }
 
-- 
2.24.4

