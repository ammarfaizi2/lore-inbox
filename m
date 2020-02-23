Return-Path: <SRS0=ZkAV=4L=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C4C35671
	for <io-uring@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401BC20659
	for <io-uring@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425469;
	bh=fAl7VpiZ6vtHx5VxgMSWgay7BJztWEmH0iSLtTDS7ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UwaXgk8c0mVEWueo/nm8mLOg+/OqxJoAKOy/jZu5pQc9MhkntPYmzxuall4c4TijO
	 BshJ7Yly69I6G0aPDRiGq7uEqEQxry40W6ib9NiYgPeQsZ2tdft3BLAp9aNCIOzSYq
	 3/FmvjOde+gZd6C75Kxv/XINd/D5Et4sK4Atps+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBWCVd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbgBWCVb (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF302465D;
        Sun, 23 Feb 2020 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424491;
        bh=fAl7VpiZ6vtHx5VxgMSWgay7BJztWEmH0iSLtTDS7ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFz1faAVmywDhFYx8EckosV2YMZ3DHBC2kB5eFFIN/+scfJfc/bBOWZegVLXMds+/
         +a+SE2K+sF12YWyQ3WmE5LtUF+meVcvob3pRR1yPXNfYe4OCYSk/3uXb9B28+GJoP2
         H4MzcF60XKgir4XdRshrKJD7bHIcpQzdPqBrYWmE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 09/58] io_uring: flush overflowed CQ events in the io_uring_poll()
Date:   Sat, 22 Feb 2020 21:20:30 -0500
Message-Id: <20200223022119.707-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 63e5d81f72af1bf370bf8a6745b0a8d71a7bb37d ]

In io_uring_poll() we must flush overflowed CQ events before to
check if there are CQ events available, to avoid missing events.

We call the io_cqring_events() that checks and flushes any overflow
and returns the number of CQ events available.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6ae692b02980d..d3f4afa01731d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4979,7 +4979,7 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	if (READ_ONCE(ctx->rings->sq.tail) - ctx->cached_sq_head !=
 	    ctx->rings->sq_ring_entries)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-	if (READ_ONCE(ctx->rings->cq.head) != ctx->cached_cq_tail)
+	if (io_cqring_events(ctx, false))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	return mask;
-- 
2.20.1

