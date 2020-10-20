Return-Path: <SRS0=CG6/=D3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66869C433DF
	for <io-uring@archiver.kernel.org>; Tue, 20 Oct 2020 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB5D223FB
	for <io-uring@archiver.kernel.org>; Tue, 20 Oct 2020 08:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgJTIXz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:23:55 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35188 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgJTIXz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 20 Oct 2020 04:23:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UCdOUlG_1603182232;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UCdOUlG_1603182232)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 16:23:52 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, asml.silence@gmail.com,
        joseph.qi@linux.alibaba.com,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH 0/2] improve SQPOLL handling
Date:   Tue, 20 Oct 2020 16:23:43 +0800
Message-Id: <20201020082345.19628-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The first patch tries to improve various issues in current implementation:
  The prepare_to_wait() usage in __io_sq_thread() is weird. If multiple ctxs
share one same poll thread, one ctx will put poll thread in TASK_INTERRUPTIBLE,
but if other ctxs have work to do, we don't need to change task's stat at all.
I think only if all ctxs don't have work to do, we can do it.
  We use round-robin strategy to make multiple ctxs share one same poll thread,
but there are various condition in __io_sq_thread(), which seems complicated and
may affect round-robin strategy.
  In io_sq_thread(), we always call io_sq_thread_drop_mm() when we complete a
round of ctxs iteration, which maybe inefficient.

The second patch adds a IORING_SETUP_SQPOLL_PERCPU flag, for those rings which
have SQPOLL enabled and are willing to be bound to one same cpu, hence share
one same poll thread, add a capability that these rings can share one poll thread
by specifying a new IORING_SETUP_SQPOLL_PERCPU flag. FIO tool can integrate this
feature easily, so we can test multiple rings to share same poll thread easily.

Xiaoguang Wang (2):
  io_uring: refactor io_sq_thread() handling
  io_uring: support multiple rings to share same poll thread by
    specifying same cpu

 fs/io_uring.c                 | 307 ++++++++++++++++++++--------------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 181 insertions(+), 127 deletions(-)

-- 
2.17.2

