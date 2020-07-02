Return-Path: <SRS0=yY1C=AN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09410C433E1
	for <io-uring@archiver.kernel.org>; Thu,  2 Jul 2020 01:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC5020CC7
	for <io-uring@archiver.kernel.org>; Thu,  2 Jul 2020 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653130;
	bh=hVnObDxVcx1RGwFLMx3QUPjXV49Wc2ghcsfqJzOTPC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iahGF33oDNzjNFJhbRqpRn0Tws+A22jPnOrx1udhdzA/+jp93Jzlu7EReT2WO9xVq
	 arl8wMly9AO9xtwUQFIs3lNTNYOsVIbOhLIFcggf8PJaYPHpZK23WEVof4yQFwczG5
	 14ugNaB4N1UNHWDoSCs4tUGO71mkOzv8HBZiXGoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgGBBZ0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgGBBXo (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2F620885;
        Thu,  2 Jul 2020 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653023;
        bh=hVnObDxVcx1RGwFLMx3QUPjXV49Wc2ghcsfqJzOTPC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HbT+18n77Dp4VD448UuLPBCw5oukfo1SXQXVtRnflduA9ShOVyDi9ic8vBLwto6U
         Ey98YBOQJkzamtsrCjUg6cH2NPQF/VNAy0s7cqDQeAfFFOuuNUx3sD45yK/nS3iSDZ
         O2kOja7fEC7muaij5pw6U3LQ3IvC/HNnie8ViO6M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 39/53] io_uring: fix io_sq_thread no schedule when busy
Date:   Wed,  1 Jul 2020 21:21:48 -0400
Message-Id: <20200702012202.2700645-39-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit b772f07add1c0b22e02c0f1e96f647560679d3a9 ]

When the user consumes and generates sqe at a fast rate,
io_sqring_entries can always get sqe, and ret will not be equal to -EBUSY,
so that io_sq_thread will never call cond_resched or schedule, and then
we will get the following system error prompt:

rcu: INFO: rcu_sched self-detected stall on CPU
or
watchdog: BUG: soft lockup-CPU#23 stuck for 112s! [io_uring-sq:1863]

This patch checks whether need to call cond_resched() by checking
the need_resched() function every cycle.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1829be7f63a35..6cf9d509371e2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6071,7 +6071,7 @@ static int io_sq_thread(void *data)
 		 * If submit got -EBUSY, flag us as needing the application
 		 * to enter the kernel to reap and flush events.
 		 */
-		if (!to_submit || ret == -EBUSY) {
+		if (!to_submit || ret == -EBUSY || need_resched()) {
 			/*
 			 * Drop cur_mm before scheduling, we can't hold it for
 			 * long periods (or over schedule()). Do this before
@@ -6087,7 +6087,7 @@ static int io_sq_thread(void *data)
 			 * more IO, we should wait for the application to
 			 * reap events and wake us up.
 			 */
-			if (!list_empty(&ctx->poll_list) ||
+			if (!list_empty(&ctx->poll_list) || need_resched() ||
 			    (!time_after(jiffies, timeout) && ret != -EBUSY &&
 			    !percpu_ref_is_dying(&ctx->refs))) {
 				if (current->task_works)
-- 
2.25.1

