Return-Path: <SRS0=/ybh=DQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C2CC433DF
	for <io-uring@archiver.kernel.org>; Fri,  9 Oct 2020 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0849222B8
	for <io-uring@archiver.kernel.org>; Fri,  9 Oct 2020 12:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjLWf5a5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbgJIMuB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 9 Oct 2020 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgJIMt5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 9 Oct 2020 08:49:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1EC0613D2;
        Fri,  9 Oct 2020 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rLSi4NEBCbExwXvm/pRFj+GUlAa/v7ZLeOor4ugKrkw=; b=SjLWf5a5NnbekpzKv4YpzX7VzD
        4+/f849aBEgjgAuAs0IWKnLDBZUGj++SW29GTYvPGZwRpiKbQt195nlM8Q4Qv3+j24gXTp77pnjHR
        sIuxbbgHKLXmv63wtwdel/wDcA9b/Xv2z3YORnjgVb1jKljjDLLtVjBRXd+83C8Ild9Z7yBQkmwXh
        TuniGP7uoJTVsLfNVUgTiHZshMPmAiATAdrZbas09WdbmH6Td8PeWEwRUxWx+cwmNpcRA5Ej3+6mz
        uzS5J2yyuO8IF1MqP15DCmFCa37lYHn8O1OBKbETAMXlKdRFmSt5h8DGXbc9pH81YCBAy8V+o9LnW
        mkjX/eGg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQrqN-0008I9-AL; Fri, 09 Oct 2020 12:49:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/3] io_uring: Fix use of XArray in __io_uring_files_cancel
Date:   Fri,  9 Oct 2020 13:49:51 +0100
Message-Id: <20201009124954.31830-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We have to drop the lock during each iteration, so there's no advantage
to using the advanced API.  Convert this to a standard xa_for_each() loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/io_uring.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 299c530c66f9..2978cc78538a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8665,28 +8665,19 @@ static void io_uring_attempt_task_drop(struct file *file, bool exiting)
 void __io_uring_files_cancel(struct files_struct *files)
 {
 	struct io_uring_task *tctx = current->io_uring;
-	XA_STATE(xas, &tctx->xa, 0);
+	struct file *file;
+	unsigned long index;
 
 	/* make sure overflow events are dropped */
 	tctx->in_idle = true;
 
-	do {
-		struct io_ring_ctx *ctx;
-		struct file *file;
-
-		xas_lock(&xas);
-		file = xas_next_entry(&xas, ULONG_MAX);
-		xas_unlock(&xas);
-
-		if (!file)
-			break;
-
-		ctx = file->private_data;
+	xa_for_each(&tctx->xa, index, file) {
+		struct io_ring_ctx *ctx = file->private_data;
 
 		io_uring_cancel_task_requests(ctx, files);
 		if (files)
 			io_uring_del_task_file(file);
-	} while (1);
+	}
 }
 
 static inline bool io_uring_task_idle(struct io_uring_task *tctx)
-- 
2.28.0

