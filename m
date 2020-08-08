Return-Path: <SRS0=Z07o=BS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B543C433DF
	for <io-uring@archiver.kernel.org>; Sat,  8 Aug 2020 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617E22053B
	for <io-uring@archiver.kernel.org>; Sat,  8 Aug 2020 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930248;
	bh=MSunwvLv3Trjrfwn2RFcEZKCnI8t5YnAcdNsxlHDt9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZKhwbjhlXQ+3hkVPzXUyDznNUx/Gk9d+fWHtI5SzEJIMNvjhBS794wR9/Y2MNLGO3
	 zwyfx4K5HPOymjIPZa2qv7QaivQ9KrmqxcmnBdmc+GtdHWXou2mYeeLe2KcDfh9Mk0
	 BKPkFnoiIb+TtRCUn+00XCBrlNfDW/FZliiEm5JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgHHXoH (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgHHXj2 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sat, 8 Aug 2020 19:39:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F7020748;
        Sat,  8 Aug 2020 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929968;
        bh=MSunwvLv3Trjrfwn2RFcEZKCnI8t5YnAcdNsxlHDt9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnnzQzjkK8C/Mpek1AsK1jwESJ0CjViCdw2N7cylN1j4K+wbA4OD4WY7ZzAmi1g28
         7WXKFYTVicAdyW7vhAeba4L8GriZrtYvFwo2aoMAD+LxNCsn1OO/eFTzPyFokBg3Qa
         +6Sg0hgiuH8JHdKY+TZuelvl8m5yUHjP7F5kRBSA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Hristo Venev <hristo@venev.name>, io-uring@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 30/40] io_uring: fix sq array offset calculation
Date:   Sat,  8 Aug 2020 19:38:34 -0400
Message-Id: <20200808233844.3618823-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233844.3618823-1-sashal@kernel.org>
References: <20200808233844.3618823-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

[ Upstream commit b36200f543ff07a1cb346aa582349141df2c8068 ]

rings_size() sets sq_offset to the total size of the rings (the returned
value which is used for memory allocation). This is wrong: sq array should
be located within the rings, not after them. Set sq_offset to where it
should be.

Fixes: 75b28affdd6a ("io_uring: allocate the two rings together")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Hristo Venev <hristo@venev.name>
Cc: io-uring@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e0200406765c3..265981ca3109c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3400,6 +3400,9 @@ static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
 		return SIZE_MAX;
 #endif
 
+	if (sq_offset)
+		*sq_offset = off;
+
 	sq_array_size = array_size(sizeof(u32), sq_entries);
 	if (sq_array_size == SIZE_MAX)
 		return SIZE_MAX;
@@ -3407,9 +3410,6 @@ static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
 	if (check_add_overflow(off, sq_array_size, &off))
 		return SIZE_MAX;
 
-	if (sq_offset)
-		*sq_offset = off;
-
 	return off;
 }
 
-- 
2.25.1

