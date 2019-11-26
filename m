Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50995C432C3
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD1A20727
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBITTIye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfKZSKa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:10:30 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40927 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKZSK3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 13:10:29 -0500
Received: by mail-qt1-f202.google.com with SMTP id 6so13012245qtu.7
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OALSh94rEmxgGcEOjsjMu0vRTzgbsWcJ+FcsMweXvcg=;
        b=CBITTIyeewci4O7GYY1HCN5cCif6l6QXOj4YE19eUjc0jPXZ076WtLMvpdaaeHU8cO
         TUWo7mK977ZhnupouKNHhBvU5gdR3AJ279D03WSvPaCH4JiE1BcKYqNBvPT3JMFi4mD1
         IktO60cZ7klZSoN0vjylmLD/m10ZRVr8EWCY+7/EkmWSMikOVBPlipLldkfFeEiMr1PI
         T7s8ztxakIcqNssu3TpLE/pOpGRKESztnfEm1Iy76wJKIU9qGZ8FSsIVFpx3WjQsFE/w
         IgYUzWXxTTJ5bocNeG1RTd/vMI0d3oJoMlZOXZvPc5HH1zMg9b15pqHz3wtz2xNeLa6x
         9eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OALSh94rEmxgGcEOjsjMu0vRTzgbsWcJ+FcsMweXvcg=;
        b=B8RVUuk6TUeht8/tIXCoH2K6cacVlPnzI2OAPVWFprO8Dbsyf5RmQbkyt24eMtOVct
         AJw7bUSnoHnzXmau9KO5kJcNLvWoecEreFXGN4Humd2sU3S+FSWLMSBH9Lq5NrG1bJ+l
         pmkfRH7T//rBXsaTKRRP8JNbPveww89Y/L2351i5xZXQjgc3NldIfHICAvJ/2y4nm+d4
         Zrhfc/6REv0p+16bOJhEu7JxnraSqamrV7zvrHuS/nWoM5spxu9hnIX8HqMlJ/hcE2hg
         IXPQzphZ/YZF8QiWa25CNQzaZJSyYyYYda6o6fpxj1Y6Ova5sLEDA/yzVqZ306cGV3FB
         dlGA==
X-Gm-Message-State: APjAAAX8WhzkF9bICy143Pum9sBqFe/NgQE4aleiyQ6SGFG3elRCk5VY
        uLA/4cTYBR4wpgzHEyOhuSjgo9zC9g==
X-Google-Smtp-Source: APXvYqx73ohAr/RbVxUoAM03YmNe+uvxfOPu+6k8JrvHq/avVajEQmxbjUl8MewuQjl5rpQ7pq9luP9+jw==
X-Received: by 2002:ad4:5183:: with SMTP id b3mr35298126qvp.144.1574791827803;
 Tue, 26 Nov 2019 10:10:27 -0800 (PST)
Date:   Tue, 26 Nov 2019 19:10:20 +0100
Message-Id: <20191126181020.17593-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] io-wq: fix handling of NUMA node IDs
From:   Jann Horn <jannh@google.com>
To:     Jens Axboe <axboe@kernel.dk>, jannh@google.com
Cc:     io-uring@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There are several things that can go wrong in the current code on NUMA
systems, especially if not all nodes are online all the time:

 - If the identifiers of the online nodes do not form a single contiguous
   block starting at zero, wq->wqes will be too small, and OOB memory
   accesses will occur e.g. in the loop in io_wq_create().
 - If a node comes online between the call to num_online_nodes() and the
   for_each_node() loop in io_wq_create(), an OOB write will occur.
 - If a node comes online between io_wq_create() and io_wq_enqueue(), a
   lookup is performed for an element that doesn't exist, and an OOB read
   will probably occur.

Fix it by:

 - using nr_node_ids instead of num_online_nodes() for the allocation size;
   nr_node_ids is calculated by setup_nr_node_ids() to be bigger than the
   highest node ID that could possibly come online at some point, even if
   those nodes' identifiers are not a contiguous block
 - creating workers for all possible CPUs, not just all online ones

This is basically what the normal workqueue code also does, as far as I can
tell.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    compile-tested only.
    
    While I think I probably got this stuff right, it might be good if
    someone more familiar with the NUMA logic could give an opinion on this.
    
    An alternative might be to only allocate workers for online nodes, but
    then we'd have to either fiddle together logic to create more workers
    on demand or punt requests on newly-onlined nodes over to older nodes.
    Both of those don't seem very nice to me.

 fs/io-wq.c | 80 +++++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 465f1a1eb52c..f27071e5cae2 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -105,7 +105,6 @@ struct io_wqe {
 struct io_wq {
 	struct io_wqe **wqes;
 	unsigned long state;
-	unsigned nr_wqes;
 
 	get_work_fn *get_work;
 	put_work_fn *put_work;
@@ -632,21 +631,22 @@ static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 static int io_wq_manager(void *data)
 {
 	struct io_wq *wq = data;
-	int i;
+	int workers_to_create = num_possible_nodes();
+	int node;
 
 	/* create fixed workers */
-	refcount_set(&wq->refs, wq->nr_wqes);
-	for (i = 0; i < wq->nr_wqes; i++) {
-		if (create_io_worker(wq, wq->wqes[i], IO_WQ_ACCT_BOUND))
-			continue;
-		goto err;
+	refcount_set(&wq->refs, workers_to_create);
+	for_each_node(node) {
+		if (!create_io_worker(wq, wq->wqes[node], IO_WQ_ACCT_BOUND))
+			goto err;
+		workers_to_create--;
 	}
 
 	complete(&wq->done);
 
 	while (!kthread_should_stop()) {
-		for (i = 0; i < wq->nr_wqes; i++) {
-			struct io_wqe *wqe = wq->wqes[i];
+		for_each_node(node) {
+			struct io_wqe *wqe = wq->wqes[node];
 			bool fork_worker[2] = { false, false };
 
 			spin_lock_irq(&wqe->lock);
@@ -668,7 +668,7 @@ static int io_wq_manager(void *data)
 err:
 	set_bit(IO_WQ_BIT_ERROR, &wq->state);
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
-	if (refcount_sub_and_test(wq->nr_wqes - i, &wq->refs))
+	if (refcount_sub_and_test(workers_to_create, &wq->refs))
 		complete(&wq->done);
 	return 0;
 }
@@ -776,7 +776,7 @@ static bool io_wq_for_each_worker(struct io_wqe *wqe,
 
 void io_wq_cancel_all(struct io_wq *wq)
 {
-	int i;
+	int node;
 
 	set_bit(IO_WQ_BIT_CANCEL, &wq->state);
 
@@ -785,8 +785,8 @@ void io_wq_cancel_all(struct io_wq *wq)
 	 * to a worker and the worker putting itself on the busy_list
 	 */
 	rcu_read_lock();
-	for (i = 0; i < wq->nr_wqes; i++) {
-		struct io_wqe *wqe = wq->wqes[i];
+	for_each_node(node) {
+		struct io_wqe *wqe = wq->wqes[node];
 
 		io_wq_for_each_worker(wqe, io_wqe_worker_send_sig, NULL);
 	}
@@ -859,10 +859,10 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
 				  void *data)
 {
 	enum io_wq_cancel ret = IO_WQ_CANCEL_NOTFOUND;
-	int i;
+	int node;
 
-	for (i = 0; i < wq->nr_wqes; i++) {
-		struct io_wqe *wqe = wq->wqes[i];
+	for_each_node(node) {
+		struct io_wqe *wqe = wq->wqes[node];
 
 		ret = io_wqe_cancel_cb_work(wqe, cancel, data);
 		if (ret != IO_WQ_CANCEL_NOTFOUND)
@@ -936,10 +936,10 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork)
 {
 	enum io_wq_cancel ret = IO_WQ_CANCEL_NOTFOUND;
-	int i;
+	int node;
 
-	for (i = 0; i < wq->nr_wqes; i++) {
-		struct io_wqe *wqe = wq->wqes[i];
+	for_each_node(node) {
+		struct io_wqe *wqe = wq->wqes[node];
 
 		ret = io_wqe_cancel_work(wqe, cwork);
 		if (ret != IO_WQ_CANCEL_NOTFOUND)
@@ -970,10 +970,10 @@ static void io_wq_flush_func(struct io_wq_work **workptr)
 void io_wq_flush(struct io_wq *wq)
 {
 	struct io_wq_flush_data data;
-	int i;
+	int node;
 
-	for (i = 0; i < wq->nr_wqes; i++) {
-		struct io_wqe *wqe = wq->wqes[i];
+	for_each_node(node) {
+		struct io_wqe *wqe = wq->wqes[node];
 
 		init_completion(&data.done);
 		INIT_IO_WORK(&data.work, io_wq_flush_func);
@@ -985,15 +985,14 @@ void io_wq_flush(struct io_wq *wq)
 
 struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 {
-	int ret = -ENOMEM, i, node;
+	int ret = -ENOMEM, node;
 	struct io_wq *wq;
 
 	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
-	wq->nr_wqes = num_online_nodes();
-	wq->wqes = kcalloc(wq->nr_wqes, sizeof(struct io_wqe *), GFP_KERNEL);
+	wq->wqes = kcalloc(nr_node_ids, sizeof(struct io_wqe *), GFP_KERNEL);
 	if (!wq->wqes) {
 		kfree(wq);
 		return ERR_PTR(-ENOMEM);
@@ -1006,14 +1005,13 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	wq->user = data->user;
 	wq->creds = data->creds;
 
-	i = 0;
-	for_each_online_node(node) {
+	for_each_node(node) {
 		struct io_wqe *wqe;
 
 		wqe = kzalloc_node(sizeof(struct io_wqe), GFP_KERNEL, node);
 		if (!wqe)
-			break;
-		wq->wqes[i] = wqe;
+			goto err;
+		wq->wqes[node] = wqe;
 		wqe->node = node;
 		wqe->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 		atomic_set(&wqe->acct[IO_WQ_ACCT_BOUND].nr_running, 0);
@@ -1029,15 +1027,10 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		INIT_HLIST_NULLS_HEAD(&wqe->free_list, 0);
 		INIT_HLIST_NULLS_HEAD(&wqe->busy_list, 1);
 		INIT_LIST_HEAD(&wqe->all_list);
-
-		i++;
 	}
 
 	init_completion(&wq->done);
 
-	if (i != wq->nr_wqes)
-		goto err;
-
 	/* caller must have already done mmgrab() on this mm */
 	wq->mm = data->mm;
 
@@ -1056,8 +1049,8 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	ret = PTR_ERR(wq->manager);
 	complete(&wq->done);
 err:
-	for (i = 0; i < wq->nr_wqes; i++)
-		kfree(wq->wqes[i]);
+	for_each_node(node)
+		kfree(wq->wqes[node]);
 	kfree(wq->wqes);
 	kfree(wq);
 	return ERR_PTR(ret);
@@ -1071,26 +1064,21 @@ static bool io_wq_worker_wake(struct io_worker *worker, void *data)
 
 void io_wq_destroy(struct io_wq *wq)
 {
-	int i;
+	int node;
 
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
 	if (wq->manager)
 		kthread_stop(wq->manager);
 
 	rcu_read_lock();
-	for (i = 0; i < wq->nr_wqes; i++) {
-		struct io_wqe *wqe = wq->wqes[i];
-
-		if (!wqe)
-			continue;
-		io_wq_for_each_worker(wqe, io_wq_worker_wake, NULL);
-	}
+	for_each_node(node)
+		io_wq_for_each_worker(wq->wqes[node], io_wq_worker_wake, NULL);
 	rcu_read_unlock();
 
 	wait_for_completion(&wq->done);
 
-	for (i = 0; i < wq->nr_wqes; i++)
-		kfree(wq->wqes[i]);
+	for_each_node(node)
+		kfree(wq->wqes[node]);
 	kfree(wq->wqes);
 	kfree(wq);
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

