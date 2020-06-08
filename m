Return-Path: <SRS0=bTi1=7W=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B61C433E1
	for <io-uring@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF220737
	for <io-uring@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663554;
	bh=WoBvXvBT7w5MB1Ci7HGCPSvkE9k4I+qGx8ouhuGbpBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ift+VtqJLCplQ5uAVJl9grt8RLcchUvWcrS8APVvC37EOYMPMRWQFx9+FeMfZ/jVv
	 4SpDgwU8AiG4Qa176I48mRNK/atOIOo+EDDFv0OTBSpRpfzVgr2uAXUlfNtJze6Oy7
	 zniGPdKNCmvKmgkojtAUJs8FX7e1yshIO4U7WZsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgFIApn (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgFHXLq (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 661652151B;
        Mon,  8 Jun 2020 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657906;
        bh=WoBvXvBT7w5MB1Ci7HGCPSvkE9k4I+qGx8ouhuGbpBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KADOENpzi4cxP4t4Fq7cuHlZ+5+7c1TbQP4G88ziw1qCEC+1L9sJp2GKhvxGgdMQ2
         l4eA1wsaLnUV3WAsW4j5Cgcha+p0byqn6nqlFFaNd3Q6SH2HHJSuOmk5hNMC+a95ga
         jKtfn/peoNXyE3+wmbjOHOwWjB2T35S+OQRVoqO4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 258/274] io_uring: fix overflowed reqs cancellation
Date:   Mon,  8 Jun 2020 19:05:51 -0400
Message-Id: <20200608230607.3361041-258-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 7b53d59859bc932b37895d2d37388e7fa29af7a5 ]

Overflowed requests in io_uring_cancel_files() should be shed only of
inflight and overflowed refs. All other left references are owned by
someone else.

If refcount_sub_and_test() fails, it will go further and put put extra
ref, don't do that. Also, don't need to do io_wq_cancel_work()
for overflowed reqs, they will be let go shortly anyway.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index dd90c3fcd4f5..4038ed0a5c39 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7467,10 +7467,11 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 				finish_wait(&ctx->inflight_wait, &wait);
 				continue;
 			}
+		} else {
+			io_wq_cancel_work(ctx->io_wq, &cancel_req->work);
+			io_put_req(cancel_req);
 		}
 
-		io_wq_cancel_work(ctx->io_wq, &cancel_req->work);
-		io_put_req(cancel_req);
 		schedule();
 		finish_wait(&ctx->inflight_wait, &wait);
 	}
-- 
2.25.1

