Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD49C4332F
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 06:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034D661183
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 06:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhI0GTH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 27 Sep 2021 02:19:07 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53894 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhI0GTG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 27 Sep 2021 02:19:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpiKFOp_1632723441;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UpiKFOp_1632723441)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Sep 2021 14:17:27 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 2/8] io-wq: add helper to merge two wq_lists
Date:   Mon, 27 Sep 2021 14:17:15 +0800
Message-Id: <20210927061721.180806-3-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210927061721.180806-1-haoxu@linux.alibaba.com>
References: <20210927061721.180806-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

add a helper to merge two wq_lists, it will be useful in the next
patches.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/io-wq.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/io-wq.h b/fs/io-wq.h
index 8369a51b65c0..7510b05d4a86 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -39,6 +39,26 @@ static inline void wq_list_add_after(struct io_wq_work_node *node,
 		list->last = node;
 }
 
+/**
+ * wq_list_merge - merge the second list to the first one.
+ * @list0: the first list
+ * @list1: the second list
+ * after merge, list0 contains the merged list.
+ */
+static inline void wq_list_merge(struct io_wq_work_list *list0,
+				     struct io_wq_work_list *list1)
+{
+	if (!list1)
+		return;
+
+	if (!list0) {
+		list0 = list1;
+		return;
+	}
+	list0->last->next = list1->first;
+	list0->last = list1->last;
+}
+
 static inline void wq_list_add_tail(struct io_wq_work_node *node,
 				    struct io_wq_work_list *list)
 {
-- 
2.24.4

