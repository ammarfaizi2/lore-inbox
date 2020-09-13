Return-Path: <SRS0=V8kG=CW=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E318C43461
	for <io-uring@archiver.kernel.org>; Sun, 13 Sep 2020 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2465C2158C
	for <io-uring@archiver.kernel.org>; Sun, 13 Sep 2020 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIMNEe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 13 Sep 2020 09:04:34 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52005 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgIMNEd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 13 Sep 2020 09:04:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U8mbAOy_1600002270;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0U8mbAOy_1600002270)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Sep 2020 21:04:30 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, asml.silence@gmail.com,
        joseph.qi@linux.alibaba.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [RFC PATCH for-next] io_uring: assign ctx->ring_file and ctx->ring_fd early in io_uring_create()
Date:   Sun, 13 Sep 2020 21:04:26 +0800
Message-Id: <20200913130426.6273-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

While testing the feature which supports multiple rings to share same poll
thread by specifying same cpu, fio often hangs in fio_ioring_getevents()
infinitely. After some investigations, I find it's because ctx->ring_file
is NULL, so io_sq_thread doest not submit this ctx's requests.

While ring initialization completes, IORING_SQ_NEED_WAKEUP will be not
set initially, app may already submit some reqs and the corresponding
io_sq_thread may already see these reqs, but will not submit them because
ring_file is NULL. Some apps just check IORING_SQ_NEED_WAKEUP beforce
submitting reqs, for example, fio just checks it in fio_ioring_commit()
and will not check it in fio_ioring_getevents(), then fio will hang
forever. To fix this issue, we assign ctx->ring_file and ctx->ring_fd
early in io_uring_create().

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/io_uring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 321a430ff3f7..5ddb2cddc695 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9034,6 +9034,11 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 		goto err;
 	}
 
+	if (p->flags & IORING_SETUP_SQPOLL) {
+		ctx->ring_fd = fd;
+		ctx->ring_file = file;
+	}
+
 	ret = io_sq_offload_create(ctx, p);
 	if (ret)
 		goto err;
-- 
2.17.2

