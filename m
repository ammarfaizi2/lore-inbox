Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F821C432BE
	for <io-uring@archiver.kernel.org>; Sun,  8 Aug 2021 10:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090946101C
	for <io-uring@archiver.kernel.org>; Sun,  8 Aug 2021 10:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhHHKNO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 8 Aug 2021 06:13:14 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47640 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhHHKNO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 8 Aug 2021 06:13:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UiISL52_1628417568;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UiISL52_1628417568)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Aug 2021 18:12:53 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 2/3] io-wq: fix lack of acct->nr_workers < acct->max_workers judgement
Date:   Sun,  8 Aug 2021 18:12:46 +0800
Message-Id: <20210808101247.189083-3-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210808101247.189083-1-haoxu@linux.alibaba.com>
References: <20210808101247.189083-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There should be this judgement before we create an io-worker

Fixes: 685fe7feedb9 ("io-wq: eliminate the need for a manager thread")
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io-wq.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 6788666c65de..d8684b4d0654 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -281,10 +281,26 @@ static void create_worker_cb(struct callback_head *cb)
 {
 	struct create_worker_data *cwd;
 	struct io_wq *wq;
+	struct io_wqe *wqe;
+	struct io_wqe_acct *acct;
+	bool need_create = false;
 
 	cwd = container_of(cb, struct create_worker_data, work);
-	wq = cwd->wqe->wq;
-	create_io_worker(wq, cwd->wqe, cwd->index);
+	wqe = cwd->wqe;
+	wq = wqe->wq;
+	acct = &wqe->acct[cwd->index];
+	raw_spin_lock_irq(&wqe->lock);
+	if (acct->nr_workers < acct->max_workers) {
+		acct->nr_workers++;
+		need_create = true;
+	}
+	raw_spin_unlock_irq(&wqe->lock);
+	if (need_create) {
+		create_io_worker(wq, wqe, cwd->index);
+	} else {
+		atomic_dec(&acct->nr_running);
+		io_worker_ref_put(wq);
+	}
 	kfree(cwd);
 }
 
-- 
2.24.4

