Return-Path: <SRS0=7ph7=2K=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC8C43603
	for <io-uring@archiver.kernel.org>; Fri, 20 Dec 2019 23:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840BC2146E
	for <io-uring@archiver.kernel.org>; Fri, 20 Dec 2019 23:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLTXd0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:33:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59026 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfLTXd0 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 20 Dec 2019 18:33:26 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iiRlr-0001A8-48; Fri, 20 Dec 2019 23:33:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] io_uring: fix missing error return when percpu_ref_init fails
Date:   Fri, 20 Dec 2019 23:33:22 +0000
Message-Id: <20191220233322.13599-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the call to percpu_ref_init fails ctx->file_data is
set to null and because there is a missing return statement the
following statement dereferences this null pointer causing an oops.
Fix this by adding the missing -ENOMEM return to avoid the oops.

Addresses-Coverity: ("Explicit null dereference")
Fixes: cbb537634780 ("io_uring: avoid ring quiesce for fixed file set unregister and update")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c756b8fc44c6..1d31294f5914 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4937,6 +4937,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		kfree(ctx->file_data->table);
 		kfree(ctx->file_data);
 		ctx->file_data = NULL;
+		return -ENOMEM;
 	}
 	ctx->file_data->put_llist.first = NULL;
 	INIT_WORK(&ctx->file_data->ref_work, io_ring_file_ref_switch);
-- 
2.24.0

