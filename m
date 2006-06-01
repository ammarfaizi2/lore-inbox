Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWFAJoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFAJoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFAJoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:44:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964773AbWFAJoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:44:05 -0400
Date: Thu, 1 Jun 2006 02:48:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601024813.662b2bca.akpm@osdl.org>
In-Reply-To: <1149154233.12777.14.camel@Homer.TheSimpsons.net>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<1149154233.12777.14.camel@Homer.TheSimpsons.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 11:30:33 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Thu, 2006-06-01 at 01:48 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > 
> > 
> > - A cfq bug was fixed in mainline, so the git-cfq tree has been restored.
> 
> I put the fix for slab corruption into mm1, and it did indeed cure that.
> However, if I add git-cfq.patch, my box still explodes.

OK, thanks.  I put a revert patch into the hot-fixes directory.


--- devel/block/cfq-iosched.c~revert-git-cfq	2006-06-01 02:46:39.000000000 -0700
+++ devel-akpm/block/cfq-iosched.c	2006-06-01 02:46:39.000000000 -0700
@@ -103,9 +103,8 @@ struct cfq_data {
 	 * rr list of queues with requests and the count of them
 	 */
 	struct list_head rr_list[CFQ_PRIO_LISTS];
+	struct list_head busy_rr;
 	struct list_head cur_rr;
-	unsigned short cur_prio;
-
 	struct list_head idle_rr;
 	unsigned int busy_queues;
 
@@ -141,6 +140,7 @@ struct cfq_data {
 
 	struct cfq_queue *active_queue;
 	struct cfq_io_context *active_cic;
+	int cur_prio, cur_end_prio;
 	unsigned int dispatch_slice;
 
 	struct timer_list idle_class_timer;
@@ -199,13 +199,8 @@ struct cfq_queue {
 	int on_dispatch[2];
 
 	/* io prio of this group */
-	unsigned short ioprio_class, ioprio;
-
-	/* current dynamic stair priority */
-	unsigned short dyn_ioprio;
-
-	/* same as real ioprio, except if queue has been elevated */
-	unsigned short org_ioprio_class, org_ioprio;
+	unsigned short ioprio, org_ioprio;
+	unsigned short ioprio_class, org_ioprio_class;
 
 	/* various state flags, see below */
 	unsigned int flags;
@@ -484,13 +479,25 @@ static void cfq_resort_rr_list(struct cf
 		list = &cfqd->cur_rr;
 	else if (cfq_class_idle(cfqq))
 		list = &cfqd->idle_rr;
-	else
-		list = &cfqd->rr_list[cfqq->dyn_ioprio];
+	else {
+		/*
+		 * if cfqq has requests in flight, don't allow it to be
+		 * found in cfq_set_active_queue before it has finished them.
+		 * this is done to increase fairness between a process that
+		 * has lots of io pending vs one that only generates one
+		 * sporadically or synchronously
+		 */
+		if (cfq_cfqq_dispatched(cfqq))
+			list = &cfqd->busy_rr;
+		else
+			list = &cfqd->rr_list[cfqq->ioprio];
+	}
 
 	/*
-	 * if queue was preempted, just add to front to be fair.
+	 * if queue was preempted, just add to front to be fair. busy_rr
+	 * isn't sorted.
 	 */
-	if (preempted) {
+	if (preempted || list == &cfqd->busy_rr) {
 		list_add(&cfqq->cfq_list, list);
 		return;
 	}
@@ -502,8 +509,6 @@ static void cfq_resort_rr_list(struct cf
 	while ((entry = entry->prev) != list) {
 		struct cfq_queue *__cfqq = list_entry_cfqq(entry);
 
-		if (__cfqq->ioprio < cfqq->ioprio)
-			break;
 		if (!__cfqq->service_last)
 			break;
 		if (time_before(__cfqq->service_last, cfqq->service_last))
@@ -729,49 +734,23 @@ cfq_merged_requests(request_queue_t *q, 
 	cfq_remove_request(next);
 }
 
-/*
- * Scale schedule slice based on io priority. Use the sync time slice only
- * if a queue is marked sync and has sync io queued. A sync queue with async
- * io only, should not get full sync slice length.
- */
-static inline int
-cfq_prio_to_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
-{
-	const int base_slice = cfqd->cfq_slice[cfq_cfqq_sync(cfqq)];
-	unsigned short prio = cfqq->dyn_ioprio;
-
-	WARN_ON(prio >= IOPRIO_BE_NR);
-
-	if (cfq_class_rt(cfqq))
-		prio = 0;
-
-	return base_slice + (base_slice / CFQ_SLICE_SCALE * (4 - prio));
-}
-
 static inline void
-cfq_set_prio_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
-{
-	cfqq->slice_end = cfq_prio_to_slice(cfqd, cfqq) + jiffies;
-}
-
-static inline int
-cfq_prio_to_maxrq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+__cfq_set_active_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
-	const int base_rq = cfqd->cfq_slice_async_rq;
-	unsigned short prio = cfqq->dyn_ioprio;
-
-	WARN_ON(cfqq->dyn_ioprio >= IOPRIO_BE_NR);
-
-	if (cfq_class_rt(cfqq))
-		prio = 0;
+	if (cfqq) {
+		/*
+		 * stop potential idle class queues waiting service
+		 */
+		del_timer(&cfqd->idle_class_timer);
 
-	return 2 * (base_rq + base_rq * (CFQ_PRIO_LISTS - 1 - prio));
-}
+		cfqq->slice_start = jiffies;
+		cfqq->slice_end = 0;
+		cfqq->slice_left = 0;
+		cfq_clear_cfqq_must_alloc_slice(cfqq);
+		cfq_clear_cfqq_fifo_expire(cfqq);
+	}
 
-static inline void cfq_prio_inc(unsigned short *p, unsigned int low_p)
-{
-	if (++(*p) == CFQ_PRIO_LISTS)
-		*p = low_p;
+	cfqd->active_queue = cfqq;
 }
 
 /*
@@ -803,8 +782,6 @@ __cfq_slice_expired(struct cfq_data *cfq
 	else
 		cfqq->slice_left = 0;
 
-	cfq_prio_inc(&cfqq->dyn_ioprio, cfqq->ioprio);
-
 	if (cfq_cfqq_on_rr(cfqq))
 		cfq_resort_rr_list(cfqq, preempted);
 
@@ -827,58 +804,73 @@ static inline void cfq_slice_expired(str
 		__cfq_slice_expired(cfqd, cfqq, preempted);
 }
 
-static struct cfq_queue *cfq_get_next_cfqq(struct cfq_data *cfqd)
+/*
+ * 0
+ * 0,1
+ * 0,1,2
+ * 0,1,2,3
+ * 0,1,2,3,4
+ * 0,1,2,3,4,5
+ * 0,1,2,3,4,5,6
+ * 0,1,2,3,4,5,6,7
+ */
+static int cfq_get_next_prio_level(struct cfq_data *cfqd)
 {
-	if (!cfqd->busy_queues)
-		return NULL;
-
-	if (list_empty(&cfqd->cur_rr)) {
-		unsigned short prio = cfqd->cur_prio;
+	int prio, wrap;
 
-		do {
-			struct list_head *list = &cfqd->rr_list[prio];
+	prio = -1;
+	wrap = 0;
+	do {
+		int p;
 
-			if (!list_empty(list)) {
-				list_splice_init(list, &cfqd->cur_rr);
+		for (p = cfqd->cur_prio; p <= cfqd->cur_end_prio; p++) {
+			if (!list_empty(&cfqd->rr_list[p])) {
+				prio = p;
 				break;
 			}
+		}
 
-			cfq_prio_inc(&prio, 0);
-		} while (prio != cfqd->cur_prio);
+		if (prio != -1)
+			break;
+		cfqd->cur_prio = 0;
+		if (++cfqd->cur_end_prio == CFQ_PRIO_LISTS) {
+			cfqd->cur_end_prio = 0;
+			if (wrap)
+				break;
+			wrap = 1;
+		}
+	} while (1);
 
-		cfq_prio_inc(&cfqd->cur_prio, 0);
-	}
+	if (unlikely(prio == -1))
+		return -1;
 
-	if (!list_empty(&cfqd->cur_rr));
-		return list_entry_cfqq(cfqd->cur_rr.next);
+	BUG_ON(prio >= CFQ_PRIO_LISTS);
 
-	return NULL;
-}
+	list_splice_init(&cfqd->rr_list[prio], &cfqd->cur_rr);
 
-static inline void
-__cfq_set_active_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
-{
-	if (cfqq) {
-		WARN_ON(RB_EMPTY(&cfqq->sort_list));
-
-		/*
-		 * stop potential idle class queues waiting service
-		 */
-		del_timer(&cfqd->idle_class_timer);
-
-		cfqq->slice_start = jiffies;
-		cfqq->slice_end = 0;
-		cfqq->slice_left = 0;
-		cfq_clear_cfqq_must_alloc_slice(cfqq);
-		cfq_clear_cfqq_fifo_expire(cfqq);
+	cfqd->cur_prio = prio + 1;
+	if (cfqd->cur_prio > cfqd->cur_end_prio) {
+		cfqd->cur_end_prio = cfqd->cur_prio;
+		cfqd->cur_prio = 0;
+	}
+	if (cfqd->cur_end_prio == CFQ_PRIO_LISTS) {
+		cfqd->cur_prio = 0;
+		cfqd->cur_end_prio = 0;
 	}
 
-	cfqd->active_queue = cfqq;
+	return prio;
 }
 
 static struct cfq_queue *cfq_set_active_queue(struct cfq_data *cfqd)
 {
-	struct cfq_queue *cfqq = cfq_get_next_cfqq(cfqd);
+	struct cfq_queue *cfqq = NULL;
+
+	/*
+	 * if current list is non-empty, grab first entry. if it is empty,
+	 * get next prio level and grab first entry then if any are spliced
+	 */
+	if (!list_empty(&cfqd->cur_rr) || cfq_get_next_prio_level(cfqd) != -1)
+		cfqq = list_entry_cfqq(cfqd->cur_rr.next);
 
 	/*
 	 * if we have idle queues and no rt or be queues had pending
@@ -976,6 +968,37 @@ static inline struct cfq_rq *cfq_check_f
 }
 
 /*
+ * Scale schedule slice based on io priority. Use the sync time slice only
+ * if a queue is marked sync and has sync io queued. A sync queue with async
+ * io only, should not get full sync slice length.
+ */
+static inline int
+cfq_prio_to_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	const int base_slice = cfqd->cfq_slice[cfq_cfqq_sync(cfqq)];
+
+	WARN_ON(cfqq->ioprio >= IOPRIO_BE_NR);
+
+	return base_slice + (base_slice/CFQ_SLICE_SCALE * (4 - cfqq->ioprio));
+}
+
+static inline void
+cfq_set_prio_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	cfqq->slice_end = cfq_prio_to_slice(cfqd, cfqq) + jiffies;
+}
+
+static inline int
+cfq_prio_to_maxrq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	const int base_rq = cfqd->cfq_slice_async_rq;
+
+	WARN_ON(cfqq->ioprio >= IOPRIO_BE_NR);
+
+	return 2 * (base_rq + base_rq * (CFQ_PRIO_LISTS - 1 - cfqq->ioprio));
+}
+
+/*
  * get next queue for service
  */
 static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
@@ -1092,6 +1115,7 @@ cfq_forced_dispatch(struct cfq_data *cfq
 	for (i = 0; i < CFQ_PRIO_LISTS; i++)
 		dispatched += cfq_forced_dispatch_cfqqs(&cfqd->rr_list[i]);
 
+	dispatched += cfq_forced_dispatch_cfqqs(&cfqd->busy_rr);
 	dispatched += cfq_forced_dispatch_cfqqs(&cfqd->cur_rr);
 	dispatched += cfq_forced_dispatch_cfqqs(&cfqd->idle_rr);
 
@@ -1331,11 +1355,6 @@ static void cfq_init_prio_data(struct cf
 	cfqq->org_ioprio = cfqq->ioprio;
 	cfqq->org_ioprio_class = cfqq->ioprio_class;
 
-	/*
-	 * start priority
-	 */
-	cfqq->dyn_ioprio = cfqq->ioprio;
-
 	if (cfq_cfqq_on_rr(cfqq))
 		cfq_resort_rr_list(cfqq, 0);
 
@@ -2210,6 +2229,7 @@ static int cfq_init_queue(request_queue_
 	for (i = 0; i < CFQ_PRIO_LISTS; i++)
 		INIT_LIST_HEAD(&cfqd->rr_list[i]);
 
+	INIT_LIST_HEAD(&cfqd->busy_rr);
 	INIT_LIST_HEAD(&cfqd->cur_rr);
 	INIT_LIST_HEAD(&cfqd->idle_rr);
 	INIT_LIST_HEAD(&cfqd->empty_list);
_

