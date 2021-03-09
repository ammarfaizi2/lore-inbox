Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24033C433DB
	for <io-uring@archiver.kernel.org>; Tue,  9 Mar 2021 02:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4B565287
	for <io-uring@archiver.kernel.org>; Tue,  9 Mar 2021 02:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCIC5s (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:57:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13454 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCIC5U (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 8 Mar 2021 21:57:20 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DvfwQ2vNnzkWY1;
        Tue,  9 Mar 2021 10:55:50 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 10:57:09 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <asml.silence@gmail.com>
CC:     <io-uring@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
Subject: [PATCH 1/2] io-wq: fix ref leak for req
Date:   Tue, 9 Mar 2021 11:04:10 +0800
Message-ID: <20210309030410.3294078-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

do_work such as io_wq_submit_work that cancel the work will leave ref of
req as 1. Fix it by call io_run_cancel.

Fixes: 4fb6ac326204 ("io-wq: improve manager/worker handling over exec")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/io-wq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 28868eb4cd09..0229fed33b99 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -794,8 +794,7 @@ static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
 	/* Can only happen if manager creation fails after exec */
 	if (io_wq_fork_manager(wqe->wq) ||
 	    test_bit(IO_WQ_BIT_EXIT, &wqe->wq->state)) {
-		work->flags |= IO_WQ_WORK_CANCEL;
-		wqe->wq->do_work(work);
+		io_run_cancel(work, wqe);
 		return;
 	}
 
-- 
2.25.4

