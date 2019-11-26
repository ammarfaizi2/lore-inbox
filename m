Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC6C432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9242080F
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+mXHRaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKZQkF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:40:05 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:59763 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfKZQkE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 11:40:04 -0500
Received: by mail-wm1-f73.google.com with SMTP id 20so809248wmo.9
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 08:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bsMKnsm6BU+j7GBhTDGgQDZMIMmNsCX7EiiRZdOKVO4=;
        b=t+mXHRaNh31TK7+M8aLV8RloHdemtRD1G6BlSgNTiF6L3Wft8Ctd+OT+MoEiVMO4Yt
         uFqO73jUQXF/Iji2pzLPgKJmyEcvUeiVaXfmZftD0k2K8UV1siPuoa5A50si0R+xgmDy
         VwQ/88IamPbUXiLJBXT6Q141qJHxbfOcJeZ+2ZjULTtiFxajRzqBVjw3nYU8A0/0/tyG
         eVUQCu9jRL1tXA/eJvZXIlZ5/RL9Y5pVaF5BJRAh25S/aX3dPeTxNBDM0h0t8zMmtmAH
         c1Lu/DRBtzMckRnC3C2IL0HfSrC4aGnJRIHW7izB0Q5UIvyZi2bB4z6ZFKLBPMc5a0/7
         wOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bsMKnsm6BU+j7GBhTDGgQDZMIMmNsCX7EiiRZdOKVO4=;
        b=k2WKXgA0+zyxX5gq0R0/WTxToIJGqysYTaiJJYNJraeCgbV+UUxWq/JRAZauW2lR4V
         lpewXrtd7GJEmiCEBpJX5pDOBkmfyiBkUon4JkToZN7zCMrkPoyPa34poZFo1L3FVBS4
         KiccRI7I2gKzZa18H/Ufuz6SVeGGXLfc7TsrPZbFUL2Ssq/kbf7Hyo0WG2MVS/90OSBz
         vnu+Ule4zfojwdww5Xk/ZRkgtYfcS1D864QnEOkzosXYIE1gef1cufDRWMKXTZFRadPL
         7Dk/aJKRwOUIxttqRnZn55GuOGZ4Bs+zSlLIfOmCR6pY2uHS3RjfdhwbSkMAAkRwqOc6
         aPIw==
X-Gm-Message-State: APjAAAW9Ov9aYEt+GHGxBiwfeGgqnTnEiX25/Xb+9lxU93HRwEVlfiro
        9nY0kgwmZFjJ7haZfAEoKloR26azog==
X-Google-Smtp-Source: APXvYqx7FzFPI9/9T3lC595tB1YNibLUtQkU6wKblfquMfrGgGbdTHwzjIAuIXkRiZYJj4Jk3HNidOnCkQ==
X-Received: by 2002:adf:e301:: with SMTP id b1mr37537741wrj.280.1574786401333;
 Tue, 26 Nov 2019 08:40:01 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:39:45 +0100
Message-Id: <20191126163945.185849-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] io_uring: use kzalloc instead of kcalloc for single-element allocations
From:   Jann Horn <jannh@google.com>
To:     Jens Axboe <axboe@kernel.dk>, jannh@google.com
Cc:     io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

These allocations are single-element allocations, so don't use the array
allocation wrapper for them.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/io-wq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 85c0090b2717..465f1a1eb52c 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -580,7 +580,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	struct io_wqe_acct *acct =&wqe->acct[index];
 	struct io_worker *worker;
 
-	worker = kcalloc_node(1, sizeof(*worker), GFP_KERNEL, wqe->node);
+	worker = kzalloc_node(sizeof(*worker), GFP_KERNEL, wqe->node);
 	if (!worker)
 		return false;
 
@@ -988,7 +988,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	int ret = -ENOMEM, i, node;
 	struct io_wq *wq;
 
-	wq = kcalloc(1, sizeof(*wq), GFP_KERNEL);
+	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
@@ -1010,7 +1010,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	for_each_online_node(node) {
 		struct io_wqe *wqe;
 
-		wqe = kcalloc_node(1, sizeof(struct io_wqe), GFP_KERNEL, node);
+		wqe = kzalloc_node(sizeof(struct io_wqe), GFP_KERNEL, node);
 		if (!wqe)
 			break;
 		wq->wqes[i] = wqe;
-- 
2.24.0.432.g9d3f5f5b63-goog

