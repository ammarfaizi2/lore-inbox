Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0981C4338F
	for <io-uring@archiver.kernel.org>; Sun, 22 Aug 2021 21:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA936108B
	for <io-uring@archiver.kernel.org>; Sun, 22 Aug 2021 21:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHVVGo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 22 Aug 2021 17:06:44 -0400
Received: from cloud48395.mywhc.ca ([173.209.37.211]:36416 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhHVVGn (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 22 Aug 2021 17:06:43 -0400
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:52710 helo=localhost)
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1mHufI-0001s6-7Z; Sun, 22 Aug 2021 17:06:00 -0400
Date:   Sun, 22 Aug 2021 17:05:59 -0400
Message-Id: <76eef510a89966e04184893a3c53c6cc67b81579.1629655338.git.olivier@trillion01.com>
In-Reply-To: <cover.1629655338.git.olivier@trillion01.com>
References: <cover.1629655338.git.olivier@trillion01.com>
From:   Olivier Langlois <olivier@trillion01.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] io_uring: Clear TIF_NOTIFY_SIGNAL when cancelling requests
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

It is a reasonable expectation from a function  to leave the task struct
in a clean state. During io_uring_try_cancel_requests TIF_NOTIFY_SIGNAL
can be set.  Make sure that it is cleared by replacing calls to
io_run_task_work with tracehook_notify_signal

Signed-off-by: Olivier Langlois <olivier@trillion01.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a2e20a6fbfed..a9c83a5fc9f1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9032,7 +9032,7 @@ static void io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 		ret |= io_poll_remove_all(ctx, task, cancel_all);
 		ret |= io_kill_timeouts(ctx, task, cancel_all);
 		if (task)
-			ret |= io_run_task_work();
+			ret |= tracehook_notify_signal();
 		if (!ret)
 			break;
 		cond_resched();
-- 
2.32.0

