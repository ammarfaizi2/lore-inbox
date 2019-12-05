Return-Path: <SRS0=lMt9=Z3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B14C43603
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15743206DF
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 13:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Yvgk7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfLENQT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:16:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfLENQT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 5 Dec 2019 08:16:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so3507856wrf.9;
        Thu, 05 Dec 2019 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZH84HPNreWtotycUDHC/DTlMQk+vV5ojMrCEDiTK38=;
        b=C0Yvgk7pvQ+PYPsCtkWKERII8rsduUXaiaVraS2N4NK+802/fojqgHV6dRHx9saEzr
         UCvLustwKcy1/VBEdSrV8+7+B4LaiUexIf5maiGxCJ58BFAM9YBM3MxDv+yesi+xuD/U
         NTZEGGIEOJZlIZPegwGBCj3PQWVTnF7Z9ti8sAjVfzsV75uP9uW1/MHWt76WIaC+zixY
         cM9xdkGp9KcBYBWd9vxujtdeIS6vJUWpWlbOrQxfN6paT7ooPaiY+0NaPGhNW/m5Ge0m
         d1yHaqcC6W5xZ83bTVEespfg3Ce1iHdBtirSWnB4meAo0ZTeUHXnq455jFX0I44RkLsv
         lstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZH84HPNreWtotycUDHC/DTlMQk+vV5ojMrCEDiTK38=;
        b=Homh0E4RjJJ/Kl13EgX9KXsUbQfZ75SvypLnVcXufPXdhtlLqR40aF6Mq0N8yYXene
         Yndu8OgMWgax/T4L9VD+tkbE6+2/gnkRhhArbLo+SM+49YOkUV0CkaF43vsbrI09qzeg
         iIJhhkC750M13SwIMHJ+2gyzjilUs6aQAQhrMX0tzkGYUSMNOR3Jhgo166PHx7RPPhMa
         n6mEebTmKNbmIdpiU8zMdhhoFyHMkeu4PnBT3bxsXfAiN86sG4njgUZ23ghVMgLvsxyh
         lbQXTXsJmPBHSR3vW0IFsb4yhQeV9PdpEHzTnnHal39qnAR/FuxfAQV0OjkuXS9R4u7I
         mmsg==
X-Gm-Message-State: APjAAAXNv71koHu0Z/xa++9WDVR4J3o3MZ8Ec/+St6lCaLF6xEWbjKey
        zDLZm+QSKX/FfCYTnI4eK4DHHhHq
X-Google-Smtp-Source: APXvYqy/DNCxkrLf/HXthIOSRd0pC7iRqh7lnHkd81DjgnVeN9e9/gn8HPcZT9lrS25w+EceWnX4jg==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr9723709wrn.28.1575551777038;
        Thu, 05 Dec 2019 05:16:17 -0800 (PST)
Received: from localhost.localdomain ([109.126.146.231])
        by smtp.gmail.com with ESMTPSA id b10sm12385490wrt.90.2019.12.05.05.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 05:16:16 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: fix error handling in io_queue_link_head
Date:   Thu,  5 Dec 2019 16:15:45 +0300
Message-Id: <d3151624354a37ec5510af32b00475574aa60aca.1575551692.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

In case of an error io_submit_sqe() drops a request and continues
without it, even if the request was a part of a link. Not only it
doesn't cancel links, but also may execute wrong sequence of actions.

Stop consuming sqes, and let the user handle errors.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2efe1ac7352a..6c2b2afe985e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3318,7 +3318,7 @@ static inline void io_queue_link_head(struct io_kiocb *req)
 
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
-static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
+static bool io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 			  struct io_kiocb **link)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -3337,7 +3337,7 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 err_req:
 		io_cqring_add_event(req, ret);
 		io_double_put_req(req);
-		return;
+		return false;
 	}
 
 	/*
@@ -3376,6 +3376,8 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	} else {
 		io_queue_sqe(req);
 	}
+
+	return true;
 }
 
 /*
@@ -3505,6 +3507,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			}
 		}
 
+		submitted++;
 		sqe_flags = req->sqe->flags;
 
 		req->ring_file = ring_file;
@@ -3514,9 +3517,8 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		req->needs_fixed_file = async;
 		trace_io_uring_submit_sqe(ctx, req->sqe->user_data,
 					  true, async);
-		io_submit_sqe(req, statep, &link);
-		submitted++;
-
+		if (!io_submit_sqe(req, statep, &link))
+			break;
 		/*
 		 * If previous wasn't linked and we have a linked command,
 		 * that's the end of the chain. Submit the previous link.
-- 
2.24.0

