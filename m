Return-Path: <SRS0=zrSU=BG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93194C4345D
	for <io-uring@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D520786
	for <io-uring@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892548;
	bh=ynynujcxmyyhcNW5Tocpx7HlDZIU0je/hY3rdK5Rswg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4m91Tg2fvWU4F0O6TvB0cUvynyHG/Y+bM8O6EV5WStRRDGLM3DDNewFOxlw348nR
	 RyI/8YQGAjs5huk+QWiTWmSNhWeLeAezbM8DLWusB2Cys+7jS/Vh65Rk6azcE6g0sY
	 41YOFfik39fm9BmkPfLz2jikYNMAiYdehcIkCKTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgG0XYR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgG0XYQ (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942A322B43;
        Mon, 27 Jul 2020 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892254;
        bh=ynynujcxmyyhcNW5Tocpx7HlDZIU0je/hY3rdK5Rswg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCgoIiCnqFrO0Z3kiiy8ePsIqUb2D/juIxRRN/hflgFE4WreoqzEiLbXdpEEauBnc
         7x+YkNLlS655vk+t3lEVZf69uvzCKdpXdV7PFB62gPVw+H35guBdN4CNkDxhhNUAYq
         Rijgmf+ymGOYQRn9D/QjJMDh6O56+cWApKM5a3ZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 21/25] io_uring: missed req_init_async() for IOSQE_ASYNC
Date:   Mon, 27 Jul 2020 19:23:41 -0400
Message-Id: <20200727232345.717432-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232345.717432-1-sashal@kernel.org>
References: <20200727232345.717432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 3e863ea3bb1a2203ae648eb272db0ce6a1a2072c ]

IOSQE_ASYNC branch of io_queue_sqe() is another place where an
unitialised req->work can be accessed (i.e. prior io_req_init_async()).
Nothing really bad though, it just looses IO_WQ_WORK_CONCURRENT flag.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 12ab983474dff..5153286345714 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5794,6 +5794,7 @@ static void io_queue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		 * Never try inline submit of IOSQE_ASYNC is set, go straight
 		 * to async execution.
 		 */
+		io_req_init_async(req);
 		req->work.flags |= IO_WQ_WORK_CONCURRENT;
 		io_queue_async_work(req);
 	} else {
-- 
2.25.1

