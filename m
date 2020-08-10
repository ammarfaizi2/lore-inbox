Return-Path: <SRS0=nfrT=BU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5EDC433DF
	for <io-uring@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF6D22BF3
	for <io-uring@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087588;
	bh=5YK53QyrZe61Fi3EOiVKr+EVL03o7jNCj4h9lKRxGYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1vzMWJsiZr7qYR/GTfOdUQL9nvAeFnAprAVLniuJ4v4/4qbRbXvwQYck42Nq8ow1g
	 RLVHiGmKanHnwgyJRCrXN2q6pZT8r8qQAHywtWjH9Z4UlvkxvG3SQT68dhcJeLFKlS
	 nIG171y8qC/i2LbMa85EVaSlyNpNJ072qzmk2uEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgHJTLt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgHJTLt (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 10 Aug 2020 15:11:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B3022BEB;
        Mon, 10 Aug 2020 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086708;
        bh=5YK53QyrZe61Fi3EOiVKr+EVL03o7jNCj4h9lKRxGYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Hsxc/Lzu4+geJyhTQTKs9tFSNNFdhSXtQ9c8YIKJMtedK2naKy+cboyFo+qX2NYw
         NuRqrN2j0j3R62TWwOEvcnLJDpn0kUPSrh53YnTIo7rokYXRWuT/P0YiGaHcmIIZFA
         KBZFUKg+Yo9SOw5ehqV7XtA/sK/fio0L14qi9n1o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 58/60] io_uring: fix stalled deferred requests
Date:   Mon, 10 Aug 2020 15:10:26 -0400
Message-Id: <20200810191028.3793884-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191028.3793884-1-sashal@kernel.org>
References: <20200810191028.3793884-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit dd9dfcdf5a603680458f5e7b0d2273c66e5417db ]

Always do io_commit_cqring() after completing a request, even if it was
accounted as overflowed on the CQ side. Failing to do that may lead to
not to pushing deferred requests when needed, and so stalling the whole
ring.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d04fede20acb8..5d33c05de02e5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7575,6 +7575,7 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 			}
 			WRITE_ONCE(ctx->rings->cq_overflow,
 				atomic_inc_return(&ctx->cached_cq_overflow));
+			io_commit_cqring(ctx);
 			spin_unlock_irq(&ctx->completion_lock);
 
 			/*
-- 
2.25.1

