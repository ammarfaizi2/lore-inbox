Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3F0C433ED
	for <io-uring@archiver.kernel.org>; Mon, 26 Apr 2021 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0096B61075
	for <io-uring@archiver.kernel.org>; Mon, 26 Apr 2021 09:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhDZJsT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:48:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhDZJsT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 26 Apr 2021 05:48:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1laxq4-0001DT-1g; Mon, 26 Apr 2021 09:47:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] io_uring: Fix uninitialized variable up.resv
Date:   Mon, 26 Apr 2021 10:47:35 +0100
Message-Id: <20210426094735.8320-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable up.resv is not initialized and is being checking for a
non-zero value in the call to _io_register_rsrc_update. Fix this by
explicitly setting the pointer to 0.

Addresses-Coverity: ("Uninitialized scalar variable)"
Fixes: c3bdad027183 ("io_uring: add generic rsrc update with tags")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f4ec092c23f4..63f610ee274b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5842,6 +5842,7 @@ static int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 	up.data = req->rsrc_update.arg;
 	up.nr = 0;
 	up.tags = 0;
+	up.resv = 0;
 
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_register_rsrc_update(ctx, IORING_RSRC_FILE,
-- 
2.30.2

