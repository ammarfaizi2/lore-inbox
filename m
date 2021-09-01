Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228AAC432BE
	for <io-uring@archiver.kernel.org>; Wed,  1 Sep 2021 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14355610E8
	for <io-uring@archiver.kernel.org>; Wed,  1 Sep 2021 12:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344079AbhIAMqc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:46:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56797 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345548AbhIAMo2 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 1 Sep 2021 08:44:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Umw3D8n_1630500202;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Umw3D8n_1630500202)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Sep 2021 20:43:29 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, cgroups@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v4 0/2] refactor sqthread cpu binding logic
Date:   Wed,  1 Sep 2021 20:43:20 +0800
Message-Id: <20210901124322.164238-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This patchset is to enhance sqthread cpu binding logic, we didn't
consider cgroup setting before. In container environment, theoretically
sqthread is in its container's task group, it shouldn't occupy cpu out
of its container. Otherwise it may cause some problems, for example:
resource balancer may controll cpu resource allocation by a container's
current cpu usage, here sqthread should be counted in.

v1-->v2
 - add helper to do cpu in current-cpuset test

v2-->v3
 - split it to 2 patches, first as prep one, second as comsumer
 - remove warnning, since cpuset may change anytime, we cannot catch
   all cases, so make the behaviour consistent.

v3-->v4
 - remove sqthread cpu binding helper since the logic is now very simple

Hao Xu (2):
  cpuset: add a helper to check if cpu in cpuset of current task
  io_uring: consider cgroup setting when binding sqpoll cpu

 fs/io_uring.c          | 11 ++++++-----
 include/linux/cpuset.h |  7 +++++++
 kernel/cgroup/cpuset.c | 11 +++++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.24.4

