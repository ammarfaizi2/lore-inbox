Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA89C432C3
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 06:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E093A2068E
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 06:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfKVGHo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:07:44 -0500
Received: from smtpbg517.qq.com ([203.205.250.89]:56962 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727563AbfKVGHo (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 22 Nov 2019 01:07:44 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 01:07:43 EST
X-QQ-mid: Xesmtp7t1574402493t51z6x70i
Received: from byteisland.com (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 22 Nov 2019 14:01:32 +0800 (CST)
X-QQ-SSF: 01000000000000B0SF101F00000000K
X-QQ-FEAT: Tubeh+4qKFS7sjk6AufHFIR1LIWFeJx04Mr96yD05nP6UvwMIYRuP+0NUWeWo
        yZBEnfGgZHfm+VumlnwCA7FAjBItfs+QGXWG9vT9yARz0YdMp9NcMK3RVWZXlf+WvCkHgET
        LkGAQJcppiAUiYpihjyulQRK/uJzpbmhm9lWk1sQ8qXaxDs/EEijc1r2OWYrEyXHhDdzaiF
        g1UFTGRFRNPnh1L8e5rUjoQYmCAwlrUcYni2Bt+iT0qyHkjrBD8WmRVDq1i6Or/voRydcXp
        +spR6ui9UkIcE3o4477RX3Rk/NAZ8cMAdWhg==
X-QQ-GoodBg: 0
From:   Jackie Liu <jackieliu@byteisland.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        liuyun01@kylinos.cn
Subject: [PATCH RESEND] io_uring: a small optimization for REQ_F_DRAIN_LINK
Date:   Fri, 22 Nov 2019 14:01:29 +0800
Message-Id: <20191122060129.40251-2-jackieliu@byteisland.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122060129.40251-1-jackieliu@byteisland.com>
References: <20191122060129.40251-1-jackieliu@byteisland.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb5
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

We don't need to set drain_next every time, make a small judgment
and add unlikely, it looks like there will be a little optimization.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 resend that patch, because reject by mail-list.

 fs/io_uring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 013e5ed..f4ec44a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2938,12 +2938,14 @@ static void __io_queue_sqe(struct io_kiocb *req)
 static void io_queue_sqe(struct io_kiocb *req)
 {
 	int ret;
+	bool drain_link = req->flags & REQ_F_DRAIN_LINK;
 
-	if (unlikely(req->ctx->drain_next)) {
+	if (unlikely(req->ctx->drain_next && !drain_link)) {
 		req->flags |= REQ_F_IO_DRAIN;
 		req->ctx->drain_next = false;
+	} else if (unlikely(drain_link)) {
+		req->ctx->drain_next = true;
 	}
-	req->ctx->drain_next = (req->flags & REQ_F_DRAIN_LINK);
 
 	ret = io_req_defer(req);
 	if (ret) {
-- 
2.7.4

