Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652C9C433EF
	for <io-uring@archiver.kernel.org>; Tue,  7 Sep 2021 15:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED64610C9
	for <io-uring@archiver.kernel.org>; Tue,  7 Sep 2021 15:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbhIGPSI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:18:08 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41830 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236041AbhIGPSG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 7 Sep 2021 11:18:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UnbRO5v_1631027813;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UnbRO5v_1631027813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Sep 2021 23:16:58 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] io_uring: check file_slot early when accept use fix_file mode
Date:   Tue,  7 Sep 2021 23:16:53 +0800
Message-Id: <20210907151653.18501-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

check file_slot early in io_accept_prep() to avoid wasted effort in
failure cases.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 30d959416eba..917271bd80c5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4868,6 +4868,8 @@ static int io_accept_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	accept->nofile = rlimit(RLIMIT_NOFILE);
 
 	accept->file_slot = READ_ONCE(sqe->file_index);
+	if (accept->file_slot - 1 >= req->ctx->nr_user_files)
+		return -EINVAL;
 	if (accept->file_slot && ((req->open.how.flags & O_CLOEXEC) ||
 				  (accept->flags & SOCK_CLOEXEC)))
 		return -EINVAL;
-- 
2.24.4

