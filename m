Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A73C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D8D2075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b48cM3ud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKTUJ4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:09:56 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43420 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTUJ4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:09:56 -0500
Received: by mail-il1-f194.google.com with SMTP id r9so834838ilq.10
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnViyg/WUeYkvselVtczre199GTizZIOaDSslG4jEDs=;
        b=b48cM3udPnYxWsofYl6vHb8uKNrMNHyk6ryXxeOiafEL1dDq2yIzgz0JhYae9K0Thz
         cWMUFCguSkrbdXR4RciOu7rgdt7qmPPq+dK3fXVSulwG9yl2b8QTV50nQ1Jaxvh+2slr
         GD8PB1M2l0uRSHKPRVDKTC7xgy7nbud3UyT6mXYg2ccnMffOEbRr/2pOHSAMdqnw1rFv
         ga0Z3w7cUR+YPnOgY7jcMRaIYKmNSdNv2JfWVoDBVn8N+fhwpnfTk58umtX302JpqDVJ
         w2AwBqaG4KDiCwkdjwKiFgPGZXfzN2HROlM/6g+n7eqGEIAbGYi5AH1D7wtFTBUlEfd7
         j2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnViyg/WUeYkvselVtczre199GTizZIOaDSslG4jEDs=;
        b=YT4DJE8bF0H5IgO/ImmLfQWr6xbBiLUryKEwWVi72p+CGQ/KobZJVL6VlXzKd65cRQ
         M+fDmqXqjAhcYRGs2plvutovfTAzD+cZQ5f5rsXZaV1xJdzJ0ndpDobTUtThTriAuSN4
         lRdpADLAKbwr8OiZgPaSrjoS0G5lCV17u38KmqNbUkBaIG7Z+LY6JXZtnjqSPAXxyVSK
         /I6j+rOLCMEa0EwrfpkN98BX1VvX6ifPnKTsoRC7y6D6nGlPK/EYM+Jbi6uT5FLXVaGE
         xTnjQuSrfWodxNB95tIhG1EvVDYM//9htp8V8tbKCBQVCJguFoPT0mTeHitOQl6hWkDP
         VVGg==
X-Gm-Message-State: APjAAAVywLvuAx4FRVtdVOAAzfFd3vcgjzRP7Yrb6jOfnwqDeVRaS54a
        kb9OrJz53NUJbyhKkQx60CU+gwiiULZhtA==
X-Google-Smtp-Source: APXvYqzP3kluq+IbEhnVexeliJCHSWzGLQPAWxp4bREJL6SpVhGk7Ls7aQxHnUKMikGdVWuZ1F0E3Q==
X-Received: by 2002:a92:c8:: with SMTP id 191mr5677533ila.287.1574280595078;
        Wed, 20 Nov 2019 12:09:55 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm48012iol.36.2019.11.20.12.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 12:09:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: close lookup gap for dependent next work
Date:   Wed, 20 Nov 2019 13:09:32 -0700
Message-Id: <20191120200936.22588-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
References: <20191120200936.22588-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

When we find new work to process within the work handler, we queue the
linked timeout before we have issued the new work. This can be
problematic for very short timeouts, as we have a window where the new
work isn't visible.

Allow the work handler to store a callback function for this in the work
item, and flag it with IO_WQ_WORK_CB if the caller has done so. If that
is set, then io-wq will call the callback when it has setup the new work
item.

Reported-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    |  3 +++
 fs/io-wq.h    | 12 +++++++++++-
 fs/io_uring.c | 14 ++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index b4bc377dda61..2666384aaf44 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -427,6 +427,9 @@ static void io_worker_handle_work(struct io_worker *worker)
 		worker->cur_work = work;
 		spin_unlock_irq(&worker->lock);
 
+		if (work->flags & IO_WQ_WORK_CB)
+			work->cb.fn(work->cb.data);
+
 		if ((work->flags & IO_WQ_WORK_NEEDS_FILES) &&
 		    current->files != work->files) {
 			task_lock(current);
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 4b29f922f80c..892989f3e41e 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -11,6 +11,7 @@ enum {
 	IO_WQ_WORK_NEEDS_FILES	= 16,
 	IO_WQ_WORK_UNBOUND	= 32,
 	IO_WQ_WORK_INTERNAL	= 64,
+	IO_WQ_WORK_CB		= 128,
 
 	IO_WQ_HASH_SHIFT	= 24,	/* upper 8 bits are used for hash key */
 };
@@ -21,8 +22,17 @@ enum io_wq_cancel {
 	IO_WQ_CANCEL_NOTFOUND,	/* work not found */
 };
 
+struct io_wq_work;
+struct io_wq_work_cb {
+	void (*fn)(void *data);
+	void *data;
+};
+
 struct io_wq_work {
-	struct list_head list;
+	union {
+		struct list_head list;
+		struct io_wq_work_cb cb;
+	};
 	void (*func)(struct io_wq_work **);
 	unsigned flags;
 	struct files_struct *files;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 132a890368bf..6175e2e195c0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2664,6 +2664,13 @@ static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 	return 0;
 }
 
+static void io_link_work_cb(void *data)
+{
+	struct io_kiocb *link = data;
+
+	io_queue_linked_timeout(link);
+}
+
 static void io_wq_submit_work(struct io_wq_work **workptr)
 {
 	struct io_wq_work *work = *workptr;
@@ -2710,8 +2717,11 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 
 		io_prep_async_work(nxt, &link);
 		*workptr = &nxt->work;
-		if (link)
-			io_queue_linked_timeout(link);
+		if (link) {
+			nxt->work.flags |= IO_WQ_WORK_CB;
+			nxt->work.cb.fn = io_link_work_cb;
+			nxt->work.cb.data = link;
+		}
 	}
 }
 
-- 
2.24.0

