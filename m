Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVEQOQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVEQOQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEQOQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:16:05 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:40531 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261238AbVEQOOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=slPO87efu0RPbTV3eTZxOBAVmVAe64eZh572hZlAKPRgmH9beJBQ3ZyqScEBvgvfvrICVz8CVKLs2aIgOkPfcn4Aae9781ZtOnEpHEuPoVurcmOUYPWqDYwqAlBCHgVKfNkNJw6KMuFB9nZNKurAXj3MhI0kEvvkw9Zm0rd6OLY=
Date: Tue, 17 May 2005 23:14:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6.12-rc4] block: cfq request selection improvement
Message-ID: <20050517141441.GA26769@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 Previously, each cfqq used separate sliding window (find_best_crq ==
1) or selected the first request (find_best_crq == 0).  This patch
implements global sliding window (find_bset_crq == 2) for request
selection from cfqq.

 The idea and implementation are straight-forward.  Global sliding
window is tracked with cfqd->last_sector and when selecting a request
from a cfqq, we try to find the first request after cfqd->last_sector
+ 2 * cfq_back_max.  After finding the first request from a cfqq, we
cache the next request for further selection from the queue.

 The end result looks pretty good with my own very synthetic
benchmark.  IMO, this patch should generally increase IO throughput.
One concern I have is, depending on sequence of events, this patch can
be unfair when choosing among requests inside a cfqq.  I don't think
this can cause any real problem (even if it does, we always have the
fifo), but that's just speculation.

 This patch assumes that the previous cfq dispatch sort fix patch is
applied.  Benchmark result follows.  The same benchmarking method has
been used as in the previous post.  I duplicated benchmark results of
the previous post and appended the new result to ease comparison.

 Again, the benchmark is somewhat extreme.  Take it with a grain of
salt.

nr_blocks=4 concurrency=10 nr_processes=4 duration=180s

original
---------------------------------------------------------------
nr_succeeded=3433 nr_failed=       0
nr_succeeded=3512 nr_failed=       0
nr_succeeded=3682 nr_failed=       0
nr_succeeded=3583 nr_failed=       0
tot=14210

nr_succeeded=3560 nr_failed=       0
nr_succeeded=3352 nr_failed=       0
nr_succeeded=3667 nr_failed=       0
nr_succeeded=3623 nr_failed=       0
tot=14202

nr_succeeded=3709 nr_failed=       0
nr_succeeded=3680 nr_failed=       0
nr_succeeded=3087 nr_failed=       0
nr_succeeded=3659 nr_failed=       0
tot=14135

AVG=14182 (100%)

sort fixed
---------------------------------------------------------------
nr_succeeded=3907 nr_failed=       0
nr_succeeded=3806 nr_failed=       0
nr_succeeded=3668 nr_failed=       0
nr_succeeded=3909 nr_failed=       0
tot=15290

nr_succeeded=3807 nr_failed=       0
nr_succeeded=3851 nr_failed=       0
nr_succeeded=3813 nr_failed=       0
nr_succeeded=3732 nr_failed=       0
tot=15203

nr_succeeded=3882 nr_failed=       0
nr_succeeded=3733 nr_failed=       0
nr_succeeded=3909 nr_failed=       0
nr_succeeded=3811 nr_failed=       0
tot=15335

AVG=15276 (107.8%)

sort fixed, sort boundary fixed
---------------------------------------------------------------
nr_succeeded=4462 nr_failed=       0
nr_succeeded=4425 nr_failed=       0
nr_succeeded=4429 nr_failed=       0
nr_succeeded=4427 nr_failed=       0
tot=17743

nr_succeeded=4446 nr_failed=       0
nr_succeeded=4450 nr_failed=       0
nr_succeeded=4488 nr_failed=       0
nr_succeeded=4414 nr_failed=       0
tot=17798

nr_succeeded=4462 nr_failed=       0
nr_succeeded=4472 nr_failed=       0
nr_succeeded=4424 nr_failed=       0
nr_succeeded=4449 nr_failed=       0
tot=17807

AVG=17782 (125.4%)

sort fixed, sort boundary fixed, backward seek
---------------------------------------------------------------
nr_succeeded=4467 nr_failed=       0
nr_succeeded=4433 nr_failed=       0
nr_succeeded=4432 nr_failed=       0
nr_succeeded=4435 nr_failed=       0
tot=17767

nr_succeeded=4480 nr_failed=       0
nr_succeeded=4418 nr_failed=       0
nr_succeeded=4460 nr_failed=       0
nr_succeeded=4461 nr_failed=       0
tot=17819

nr_succeeded=4459 nr_failed=       0
nr_succeeded=4460 nr_failed=       0
nr_succeeded=4471 nr_failed=       0
nr_succeeded=4449 nr_failed=       0
tot=17839

AVG=17808 (125.6%)

sort fixed, sort boundary fixed, backward seek, global_best_crq
---------------------------------------------------------------
nr_succeeded=4827 nr_failed=       0
nr_succeeded=4808 nr_failed=       0
nr_succeeded=4867 nr_failed=       0
nr_succeeded=4842 nr_failed=       0
tot=19344

nr_succeeded=4798 nr_failed=       0
nr_succeeded=4791 nr_failed=       0
nr_succeeded=4829 nr_failed=       0
nr_succeeded=4827 nr_failed=       0
tot=19245

nr_succeeded=4792 nr_failed=       0
nr_succeeded=4816 nr_failed=       0
nr_succeeded=4895 nr_failed=       0
nr_succeeded=4849 nr_failed=       0
tot=19352

AVG=19313 (136.2%)


### PATCH ###


Index: drivers/block/cfq-iosched.c
===================================================================
--- 832f30b9fd82e60a88b58868fe1933a3e1d94d03/drivers/block/cfq-iosched.c  (mode:100644)
+++ 9456f770505e1d155ce2e1a4c7c1afe15601373f/drivers/block/cfq-iosched.c  (mode:100644)
@@ -153,6 +153,8 @@
 	struct rb_root sort_list;
 	/* if fifo isn't expired, next request to serve */
 	struct cfq_rq *next_crq;
+	/* used for next_crq caching by global_find_best_crq */
+	struct cfq_rq *global_next_crq;
 	/* requests queued in sort_list */
 	int queued[2];
 	/* currently allocated requests */
@@ -798,6 +800,58 @@
 }
 
 /*
+ * choose the best request from cfqq considering cfqd->last_sector
+ */
+static inline struct cfq_rq *
+cfq_global_find_best_crq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	struct rb_node *n;
+	struct cfq_rq *crq = NULL;
+
+	if (cfqq->global_next_crq == NULL) {
+		sector_t last = cfqd->last_sector;
+
+		/* Allow backward seek upto cfqd->cfq_back_max KiB. */
+		if (last >= cfqd->cfq_back_max * 2)
+			last -= cfqd->cfq_back_max * 2;
+
+		n = cfqq->sort_list.rb_node;
+		while (n) {
+			crq = rb_entry_crq(n);
+
+			if (last < crq->rb_key)
+				n = n->rb_left;
+			else if (last > crq->rb_key)
+				n = n->rb_right;
+			else
+				break;
+		}
+
+		if (crq && crq->rb_key < last) {
+			if ((n = rb_next(&crq->rb_node)))
+				crq = rb_entry_crq(n);
+			else
+				crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+		}
+	} else
+		crq = cfqq->global_next_crq;
+
+	if (crq) {
+		if ((n = rb_next(&crq->rb_node)))
+			cfqq->global_next_crq = rb_entry_crq(n);
+		else {
+			n = rb_first(&cfqq->sort_list);
+			if (n != &crq->rb_node)
+				cfqq->global_next_crq = rb_entry_crq(n);
+			else
+				cfqq->global_next_crq = NULL;
+		}
+	}
+
+	return crq;
+}
+
+/*
  * dispatch a single request from given queue
  */
 static inline void
@@ -810,10 +864,17 @@
 	 * follow expired path, else get first next available
 	 */
 	if ((crq = cfq_check_fifo(cfqq)) == NULL) {
-		if (cfqd->find_best_crq)
+		switch (cfqd->find_best_crq) {
+		case 2:
+			crq = cfq_global_find_best_crq(cfqd, cfqq);
+			break;
+		case 1:
 			crq = cfqq->next_crq;
-		else
+			break;
+		case 0:
 			crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+			break;
+		}
 	}
 
 	/*
@@ -842,11 +903,16 @@
 		BUG_ON(RB_EMPTY(&cfqq->sort_list));
 
 		/*
-		 * first round of queueing, only select from queues that
-		 * don't already have io in-flight
+		 * first round of queueing
+		 * - clear global_next_crq caching field
+		 * - only select from queues that don't already have io
+		 *   in-flight
 		 */
-		if (first_round && cfqq->in_flight)
-			continue;
+		if (first_round) {
+			cfqq->global_next_crq = NULL;
+			if (cfqq->in_flight)
+				continue;
+		}
 
 		cfq_dispatch_request(q, cfqd, cfqq);
 
@@ -1544,7 +1610,7 @@
 	cfqd->max_queued = q->nr_requests / 16;
 	q->nr_batching = cfq_queued;
 	cfqd->key_type = CFQ_KEY_TGID;
-	cfqd->find_best_crq = 1;
+	cfqd->find_best_crq = 2;
 	atomic_set(&cfqd->ref, 1);
 
 	cfqd->cfq_queued = cfq_queued;
@@ -1700,7 +1766,7 @@
 STORE_FUNCTION(cfq_fifo_expire_r_store, &cfqd->cfq_fifo_expire_r, 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_fifo_expire_w_store, &cfqd->cfq_fifo_expire_w, 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_fifo_batch_expire_store, &cfqd->cfq_fifo_batch_expire, 0, UINT_MAX, 1);
-STORE_FUNCTION(cfq_find_best_store, &cfqd->find_best_crq, 0, 1, 0);
+STORE_FUNCTION(cfq_find_best_store, &cfqd->find_best_crq, 0, 2, 0);
 STORE_FUNCTION(cfq_back_max_store, &cfqd->cfq_back_max, 0, UINT_MAX, 0);
 STORE_FUNCTION(cfq_back_penalty_store, &cfqd->cfq_back_penalty, 1, UINT_MAX, 0);
 #undef STORE_FUNCTION
