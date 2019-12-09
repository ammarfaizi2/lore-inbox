Return-Path: <SRS0=o5Q3=Z7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F9C04E30
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAE0206D5
	for <io-uring@archiver.kernel.org>; Mon,  9 Dec 2019 23:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gUSP7RjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLIXTB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:19:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40235 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXTB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 9 Dec 2019 18:19:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id s35so6540286pjb.7
        for <io-uring@vger.kernel.org>; Mon, 09 Dec 2019 15:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNqUpqw7O74f1dMrv2LeoxqBlPeqbctKOiYYE2ughno=;
        b=gUSP7RjOZohmZJsge2urrasgv2WRRhjfIzGR4yQjq51Er59P/1Y0iHQh7HtenAliGH
         2LsQPH1A1C8/X6gPmvmXXDADrbkeQlsYuyi/a9y6StYCCGpTczzJm/qD7mjjIMyNrCgq
         JLosf972CmNLz2d7HL0/xHq8OjQGJMESKwRy6e7VlOIppE6ftFKhsFTCjCiE/49bHZtn
         TUhBv1zYH/lI/XXKf9x3QQw7DWIK6kzWxA18PU38HCE6CAWdB9kdevTLss50KejkKXMW
         Y6ImxANbe4DrM1Z6gDbdGOR1QIXVCu5H8whRj32/kFSc9ivVvlveueKB3oUdwFL2Tfs+
         aa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNqUpqw7O74f1dMrv2LeoxqBlPeqbctKOiYYE2ughno=;
        b=Hg0R8jjcsth2gzHALJQvPWHP71vOP6cj056XMrNn0iP0Qob8uLL11Y1OIFqyuTb6UK
         2GvB+Wv3wQEnGyMrm5VYhSm1EDtipfTvOEPTGqyA/j7wOoGWtmneYzV60Tn7G91NRZSG
         2mxnjO3rAzaj2yjdOOukQ632SinXwoN2b+NpSLgnZZrCEPW1vh8xuOmdcmj/ixCP/JbX
         HEraurrV02ctFQ31aiqjKodWkRo2m6vZT2qG0xCWJ+F4A1G2cCcA9MhRpIzSBOaeF9Xg
         IccCNLsZ9EG8ZZrDIJcwTqP5dIOCirFqYODgaNB2RIRzGon6c5tmrkUopa1frKUTCDX4
         3rPQ==
X-Gm-Message-State: APjAAAUnXXhxEsuIX/F7R46DLwvaUl0YnBS/M7YRvhqrW74jg9/J7CvN
        4XEtYVTazybYUp79Eo9F7NgtZyHikEA=
X-Google-Smtp-Source: APXvYqyzL1gs5aXQ8dcta3jcT50WUy+3Cldc/hiT24MMLsNhl049OanebAaDCMoWXmDhpf6pC/6S9Q==
X-Received: by 2002:a17:90a:d787:: with SMTP id z7mr1833808pju.10.1575933539944;
        Mon, 09 Dec 2019 15:18:59 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::e5cf])
        by smtp.gmail.com with ESMTPSA id 16sm515662pfh.182.2019.12.09.15.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:18:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] io-wq: remove worker->wait waitqueue
Date:   Mon,  9 Dec 2019 16:18:52 -0700
Message-Id: <20191209231854.3767-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209231854.3767-1-axboe@kernel.dk>
References: <20191209231854.3767-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We only have one cases of using the waitqueue to wake the worker, the
rest are using wake_up_process(). Since we can save some cycles not
fiddling with the waitqueue io_wqe_worker(), switch the work activation
to task wakeup and get rid of the now unused wait_queue_head_t in
struct io_worker.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 74b40506c5d9..6b663ddceb42 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -49,7 +49,6 @@ struct io_worker {
 	struct hlist_nulls_node nulls_node;
 	struct list_head all_list;
 	struct task_struct *task;
-	wait_queue_head_t wait;
 	struct io_wqe *wqe;
 
 	struct io_wq_work *cur_work;
@@ -258,7 +257,7 @@ static bool io_wqe_activate_free_worker(struct io_wqe *wqe)
 
 	worker = hlist_nulls_entry(n, struct io_worker, nulls_node);
 	if (io_worker_get(worker)) {
-		wake_up(&worker->wait);
+		wake_up_process(worker->task);
 		io_worker_release(worker);
 		return true;
 	}
@@ -497,13 +496,11 @@ static int io_wqe_worker(void *data)
 	struct io_worker *worker = data;
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
-	DEFINE_WAIT(wait);
 
 	io_worker_start(wqe, worker);
 
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
-		prepare_to_wait(&worker->wait, &wait, TASK_INTERRUPTIBLE);
-
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irq(&wqe->lock);
 		if (io_wqe_run_queue(wqe)) {
 			__set_current_state(TASK_RUNNING);
@@ -526,8 +523,6 @@ static int io_wqe_worker(void *data)
 			break;
 	}
 
-	finish_wait(&worker->wait, &wait);
-
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		spin_lock_irq(&wqe->lock);
 		if (!wq_list_empty(&wqe->work_list))
@@ -589,7 +584,6 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 
 	refcount_set(&worker->ref, 1);
 	worker->nulls_node.pprev = NULL;
-	init_waitqueue_head(&worker->wait);
 	worker->wqe = wqe;
 	spin_lock_init(&worker->lock);
 
-- 
2.24.0

