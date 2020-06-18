Return-Path: <SRS0=792S=77=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08EEC433E0
	for <io-uring@archiver.kernel.org>; Thu, 18 Jun 2020 07:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42C1217A0
	for <io-uring@archiver.kernel.org>; Thu, 18 Jun 2020 07:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgFRHCF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:02:05 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48248 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgFRHCF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 18 Jun 2020 03:02:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U.x0cQu_1592463722;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0U.x0cQu_1592463722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jun 2020 15:02:02 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, asml.silence@gmail.com,
        joseph.qi@linux.alibaba.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH] io_uring: fix possible race condition against REQ_F_NEED_CLEANUP
Date:   Thu, 18 Jun 2020 15:01:56 +0800
Message-Id: <20200618070156.17508-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

In io_read() or io_write(), when io request is submitted successfully,
it'll go through below codes:
    kfree(iovec);
    req->flags &= ~REQ_F_NEED_CLEANUP;
    return ret;

But indeed the "req->flags &= ~REQ_F_NEED_CLEANUP;" maybe dangerous,
io request may already have been completed, then io_complete_rw_iopoll()
and io_complete_rw() will be called, both of them will also modify
req->flags if needed, race condition will occur, concurrent modifaction
will happen, which is neither protected by locks nor atomic operations.

To eliminate this race, in io_read() or io_write(), if io request is
submitted successfully, we don't remove REQ_F_NEED_CLEANUP flag. If
REQ_F_NEED_CLEANUP is set, we'll leave __io_req_aux_free() to the
iovec cleanup work correspondingly.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/io_uring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2038d52c5450..a78201b96179 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2670,8 +2670,8 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 		}
 	}
 out_free:
-	kfree(iovec);
-	req->flags &= ~REQ_F_NEED_CLEANUP;
+	if (!(req->flags & REQ_F_NEED_CLEANUP))
+		kfree(iovec);
 	return ret;
 }
 
@@ -2793,8 +2793,8 @@ static int io_write(struct io_kiocb *req, bool force_nonblock)
 		}
 	}
 out_free:
-	req->flags &= ~REQ_F_NEED_CLEANUP;
-	kfree(iovec);
+	if (!(req->flags & REQ_F_NEED_CLEANUP))
+		kfree(iovec);
 	return ret;
 }
 
-- 
2.17.2

