Return-Path: <SRS0=ly1X=DW=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D81C433E7
	for <io-uring@archiver.kernel.org>; Thu, 15 Oct 2020 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA508218AC
	for <io-uring@archiver.kernel.org>; Thu, 15 Oct 2020 09:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgJOJNo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 15 Oct 2020 05:13:44 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37874 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgJOJNo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 15 Oct 2020 05:13:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UC5QV.m_1602753222;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UC5QV.m_1602753222)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 17:13:42 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH] io_uring: fix possible use after free to sqd
Date:   Thu, 15 Oct 2020 17:13:35 +0800
Message-Id: <20201015091335.1667-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Reading codes finds a possible use after free issue to sqd:
          thread1              |       thread2
==> io_attach_sq_data()        |
===> sqd = ctx_attach->sq_data;|
                               | ==> io_put_sq_data()
                               | ===> refcount_dec_and_test(&sqd->refs)
                               |     If sqd->refs is zero, will free sqd.
                               |
===> refcount_inc(&sqd->refs); |
                               |
                               | ====> kfree(sqd);
===> now use after free to sqd |

Use refcount_inc_not_zero() to fix this issue.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/io_uring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 33b5cf18bb51..48e230feb704 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6868,7 +6868,11 @@ static struct io_sq_data *io_attach_sq_data(struct io_uring_params *p)
 		return ERR_PTR(-EINVAL);
 	}
 
-	refcount_inc(&sqd->refs);
+	if (!refcount_inc_not_zero(&sqd->refs)) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
 	fdput(f);
 	return sqd;
 }
-- 
2.17.2

