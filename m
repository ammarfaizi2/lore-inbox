Return-Path: <SRS0=lMt9=Z3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D881FC43603
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 13:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3B620675
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3G7CSIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLENRI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:17:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32776 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfLENRI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 5 Dec 2019 08:17:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so3582416wrq.0;
        Thu, 05 Dec 2019 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNVy28uDYQvmGOvC3k7avc+06MFa2IjqLxanx0z2n2k=;
        b=N3G7CSIOH4avKnU+pKRcoavsjJB3q1iZL5SvMPfuqkU77Eb3XULeIbvPaOrZmqKjil
         wVkDRPjLY5EquVQ6wBpyV4sLRsAnMrj8bOq63IZXY1e1lnX4tETHWUKA6AYhwe7er2sb
         u5B5oV+KnRljkMonOFideS63CZo47qsoJMzMZ7XFlsbqJ4SgEIdsXjKJgycV5Rsv9z8r
         uDollXuaN7182huRLAcp9jLs+Q37eSOV3DfRQN13c04nVOT9Tirs/2oVIHBKknCEJlSz
         y6VRAKncPjN9mCHZFtEw/f732bSJxJA2jLSq+gkn8XcyEOGct/cLIP9ry2AjpFgOzl2F
         duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNVy28uDYQvmGOvC3k7avc+06MFa2IjqLxanx0z2n2k=;
        b=HedTYlgied7rLppF7V88eg0mZPT9EfP/lmR203t+uHj20XxksjUb01QkXyGs+oaEB4
         EyQWkE32xGd57YONKoesoqNjGFFLxktB/bxavWmBaoZHI94sGtWJbt4Og+RlHJ7jOVwJ
         XwiEIWp4uCKjAL0xjjICkH4urRThePvNO85nGfISmguQTfJq7j9uuJdwcbg7xzwVml2j
         q21VXUoaV6to4muwh/HMSXnZLJQVDTv0HzAMXy/uVslA/glySneuecR2Q8aAVClGYMq8
         mR5wusjniaL+zmIhyNdHrfvUpwcP4AwySfsgxXmF2/OCjzs1P5CntFhNBaSIYpNcO4cW
         TwKw==
X-Gm-Message-State: APjAAAW83GCNxRzVODhX37nAm/dPKP5h/ygPWh0XW1QO9npeSor5epxc
        xW1LXyPcY8vai8306hSZULQ=
X-Google-Smtp-Source: APXvYqyX/Q9DbbSwBDnsHR4XeRRskSshAkQo8iMxGADyt/KjKHcr5eADrnvv8w8C2vIUSUOWw33TAQ==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr9969287wrm.210.1575551824947;
        Thu, 05 Dec 2019 05:17:04 -0800 (PST)
Received: from localhost.localdomain ([109.126.146.231])
        by smtp.gmail.com with ESMTPSA id l7sm12208003wrq.61.2019.12.05.05.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 05:17:04 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: hook all linked requests via link_list
Date:   Thu,  5 Dec 2019 16:16:35 +0300
Message-Id: <49ba20e17803a7caf1cb87792b36dd40b4a99806.1575551693.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Links are created by chaining requests through req->list with an
exception that head uses req->link_list. (e.g. link_list->list->list)
Because of that, io_req_link_next() needs complex splicing to advance.

Link them all through list_list. Also, it seems to be simpler and more
consistent IMHO.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6c2b2afe985e..806d9c72d0c9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -899,7 +899,6 @@ static bool io_link_cancel_timeout(struct io_kiocb *req)
 static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct io_kiocb *nxt;
 	bool wake_ev = false;
 
 	/* Already got next link */
@@ -911,24 +910,21 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * potentially happen if the chain is messed up, check to be on the
 	 * safe side.
 	 */
-	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	while (nxt) {
-		list_del_init(&nxt->list);
+	while (!list_empty(&req->link_list)) {
+		struct io_kiocb *nxt = list_first_entry(&req->link_list,
+						struct io_kiocb, link_list);
 
-		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
-		    (nxt->flags & REQ_F_TIMEOUT)) {
+		if (unlikely((req->flags & REQ_F_LINK_TIMEOUT) &&
+			     (nxt->flags & REQ_F_TIMEOUT))) {
+			list_del_init(&nxt->link_list);
 			wake_ev |= io_link_cancel_timeout(nxt);
-			nxt = list_first_entry_or_null(&req->link_list,
-							struct io_kiocb, list);
 			req->flags &= ~REQ_F_LINK_TIMEOUT;
 			continue;
 		}
-		if (!list_empty(&req->link_list)) {
-			INIT_LIST_HEAD(&nxt->link_list);
-			list_splice(&req->link_list, &nxt->link_list);
-			nxt->flags |= REQ_F_LINK;
-		}
 
+		list_del_init(&req->link_list);
+		if (!list_empty(&nxt->link_list))
+			nxt->flags |= REQ_F_LINK;
 		*nxtptr = nxt;
 		break;
 	}
@@ -944,15 +940,15 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 static void io_fail_links(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct io_kiocb *link;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
 
 	while (!list_empty(&req->link_list)) {
-		link = list_first_entry(&req->link_list, struct io_kiocb, list);
-		list_del_init(&link->list);
+		struct io_kiocb *link = list_first_entry(&req->link_list,
+						struct io_kiocb, link_list);
 
+		list_del_init(&link->link_list);
 		trace_io_uring_fail_link(req, link);
 
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
@@ -3173,10 +3169,11 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	 * We don't expect the list to be empty, that will only happen if we
 	 * race with the completion of the linked work.
 	 */
-	if (!list_empty(&req->list)) {
-		prev = list_entry(req->list.prev, struct io_kiocb, link_list);
+	if (!list_empty(&req->link_list)) {
+		prev = list_entry(req->link_list.prev, struct io_kiocb,
+				  link_list);
 		if (refcount_inc_not_zero(&prev->refs)) {
-			list_del_init(&req->list);
+			list_del_init(&req->link_list);
 			prev->flags &= ~REQ_F_LINK_TIMEOUT;
 		} else
 			prev = NULL;
@@ -3206,7 +3203,7 @@ static void io_queue_linked_timeout(struct io_kiocb *req)
 	 * we got a chance to setup the timer
 	 */
 	spin_lock_irq(&ctx->completion_lock);
-	if (!list_empty(&req->list)) {
+	if (!list_empty(&req->link_list)) {
 		struct io_timeout_data *data = &req->io->timeout;
 
 		data->timer.function = io_link_timeout_fn;
@@ -3226,7 +3223,8 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 	if (!(req->flags & REQ_F_LINK))
 		return NULL;
 
-	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
+	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb,
+					link_list);
 	if (!nxt || nxt->sqe->opcode != IORING_OP_LINK_TIMEOUT)
 		return NULL;
 
@@ -3367,7 +3365,7 @@ static bool io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			goto err_req;
 		}
 		trace_io_uring_link(ctx, req, prev);
-		list_add_tail(&req->list, &prev->link_list);
+		list_add_tail(&req->link_list, &prev->link_list);
 	} else if (req->sqe->flags & IOSQE_IO_LINK) {
 		req->flags |= REQ_F_LINK;
 
-- 
2.24.0

