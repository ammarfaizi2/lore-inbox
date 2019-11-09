Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6594C17440
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 03:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B854421019
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 03:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKIDAT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:00:19 -0500
Received: from smtpbgau1.qq.com ([54.206.16.166]:34729 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfKIDAT (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 8 Nov 2019 22:00:19 -0500
X-QQ-mid: bizesmtp21t1573268410t7cbv4j9
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 09 Nov 2019 11:00:10 +0800 (CST)
X-QQ-SSF: 01400000000000T0ZU90B00A0000000
X-QQ-FEAT: vqkrgw89ZsnBgV/E/nevQD3EgMRiIv0S/qEcAv9oq4L7ZL4VUJ0NDYDliBSWH
        zyWmGPpHz2nmn2FMM3NVo26tUEeSZGcVIsjoBG9/jPVf++6fyJfZupvQHK0jVAtln7N6Ho8
        wEY5mn63UXXzi9LikpVeFJYmp0Ox59e8g/JYrCaboflF+qrbB8mjlQRNmnlu7E5UbqAeM1s
        Tm5or2LRqeZVTYm4HaJoVENSFZOnoMNXiwSrF9y06U37WNgUbXwKHFxLQMetROO5vdgYWlC
        Sx2EIUKDNcJ28e9a9NYw2C5/aaLNBbbOj6FP7rQkMKJLi9xRsQQeBzt2kh7XYORtoEzkk7h
        qcrCRB8
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] io_uring: separate the io_free_req and io_free_req_find_next interface
Date:   Sat,  9 Nov 2019 11:00:08 +0800
Message-Id: <1573268409-86058-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Similar to the distinction between io_put_req and io_put_req_find_next,
io_free_req has been modified similarly, with no functional changes.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d2ec37f..859cf8a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -919,7 +919,7 @@ static void io_fail_links(struct io_kiocb *req)
 	io_cqring_ev_posted(ctx);
 }
 
-static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
+static void io_free_req_find_next(struct io_kiocb *req, struct io_kiocb **nxt)
 {
 	if (likely(!(req->flags & REQ_F_LINK))) {
 		__io_free_req(req);
@@ -953,6 +953,11 @@ static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
 	__io_free_req(req);
 }
 
+static void io_free_req(struct io_kiocb *req)
+{
+	io_free_req_find_next(req, NULL);
+}
+
 /*
  * Drop reference to request, return next in chain (if there is one) if this
  * was the last reference to this request.
@@ -962,7 +967,7 @@ static void io_put_req_find_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	struct io_kiocb *nxt = NULL;
 
 	if (refcount_dec_and_test(&req->refs))
-		io_free_req(req, &nxt);
+		io_free_req_find_next(req, &nxt);
 
 	if (nxt) {
 		if (nxtptr)
@@ -975,7 +980,7 @@ static void io_put_req_find_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 static void io_put_req(struct io_kiocb *req)
 {
 	if (refcount_dec_and_test(&req->refs))
-		io_free_req(req, NULL);
+		io_free_req(req);
 }
 
 static void io_double_put_req(struct io_kiocb *req)
@@ -1043,7 +1048,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
 			} else {
-				io_free_req(req, NULL);
+				io_free_req(req);
 			}
 		}
 	}
-- 
2.7.4



