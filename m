Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272973AbTHFAjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHFAjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:39:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40183 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S272973AbTHFAjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:39:32 -0400
Subject: Re: [patch] real-time enhanced page allocator and throttling
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       piggin@cyberone.com.au, kernel@kolivas.org, linux-mm@kvack.org
In-Reply-To: <20030805170954.59385c78.akpm@osdl.org>
References: <1060121638.4494.111.camel@localhost>
	 <20030805170954.59385c78.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1060130368.4494.166.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 05 Aug 2003 17:39:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 17:09, Andrew Morton wrote:

> -void balance_dirty_pages(struct address_space *mapping)
> +static void balance_dirty_pages(struct address_space *mapping)

Hrm. void? I have this as an int in my tree (test2-mm4), did you change
something? The function returns stuff.. I made it a 'static int'

>  		dirty_exceeded = 1;
> +		if (rt_task(current))
> +			break;

OK, this was my other option. I think this is better because, as we have
both said, it allows us to wake up pdflush.

Here is what I have right now, now ..

	Robert Love


 include/linux/sched.h |    4 +++-
 kernel/sched.c        |    1 -
 mm/page-writeback.c   |   11 +++++++++--
 mm/page_alloc.c       |   31 ++++++++++++++++++++++---------
 4 files changed, 34 insertions(+), 13 deletions(-)


diff -urN linux-2.6.0-test2-mm4/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.0-test2-mm4/include/linux/sched.h	2003-08-05 14:53:47.000000000 -0700
+++ linux/include/linux/sched.h	2003-08-05 12:38:41.000000000 -0700
@@ -282,7 +282,9 @@
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
- 
+
+#define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+
 /*
  * Some day this will be a full-fledged user tracking system..
  */
diff -urN linux-2.6.0-test2-mm4/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.0-test2-mm4/kernel/sched.c	2003-08-05 14:53:47.000000000 -0700
+++ linux/kernel/sched.c	2003-08-05 12:38:29.000000000 -0700
@@ -199,7 +199,6 @@
 #define this_rq()		(cpu_rq(smp_processor_id())) /* not __get_cpu_var(runqueues)! */
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
-#define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
 /*
  * Default context-switch locking:
diff -urN linux-2.6.0-test2-mm4/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.6.0-test2-mm4/mm/page_alloc.c	2003-08-05 14:48:38.000000000 -0700
+++ linux/mm/page_alloc.c	2003-08-05 17:22:30.000000000 -0700
@@ -518,7 +518,8 @@
  *
  * Herein lies the mysterious "incremental min".  That's the
  *
- *	min += z->pages_low;
+ *	local_low = z->pages_low;
+ *	min += local_low;
  *
  * thing.  The intent here is to provide additional protection to low zones for
  * allocation requests which _could_ use higher zones.  So a GFP_HIGHMEM
@@ -536,10 +537,11 @@
 	unsigned long min;
 	struct zone **zones, *classzone;
 	struct page *page;
+	struct reclaim_state reclaim_state;
+	struct task_struct *p = current;
 	int i;
 	int cold;
 	int do_retry;
-	struct reclaim_state reclaim_state;
 
 	if (wait)
 		might_sleep();
@@ -557,8 +559,17 @@
 	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
+		unsigned long local_low;
+
+		/*
+		 * This is the fabled 'incremental min'. We let real-time tasks
+		 * dip their real-time paws a little deeper into reserves.
+		 */
+		local_low = z->pages_low;
+		if (rt_task(p))
+			local_low >>= 1;
+		min += local_low;
 
-		min += z->pages_low;
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
@@ -581,6 +592,8 @@
 		local_min = z->pages_min;
 		if (gfp_mask & __GFP_HIGH)
 			local_min >>= 2;
+		if (rt_task(p))
+			local_min >>= 1;
 		min += local_min;
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
@@ -594,7 +607,7 @@
 	/* here we're in the low on memory slow path */
 
 rebalance:
-	if ((current->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
+	if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; zones[i] != NULL; i++) {
 			struct zone *z = zones[i];
@@ -610,14 +623,14 @@
 	if (!wait)
 		goto nopage;
 
-	current->flags |= PF_MEMALLOC;
+	p->flags |= PF_MEMALLOC;
 	reclaim_state.reclaimed_slab = 0;
-	current->reclaim_state = &reclaim_state;
+	p->reclaim_state = &reclaim_state;
 
 	try_to_free_pages(classzone, gfp_mask, order);
 
-	current->reclaim_state = NULL;
-	current->flags &= ~PF_MEMALLOC;
+	p->reclaim_state = NULL;
+	p->flags &= ~PF_MEMALLOC;
 
 	/* go through the zonelist yet one more time */
 	min = 1UL << order;
@@ -657,7 +670,7 @@
 	if (!(gfp_mask & __GFP_NOWARN)) {
 		printk("%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
-			current->comm, order, gfp_mask);
+			p->comm, order, gfp_mask);
 	}
 	return NULL;
 got_pg:
diff -urN linux-2.6.0-test2-mm4/mm/page-writeback.c linux/mm/page-writeback.c
--- linux-2.6.0-test2-mm4/mm/page-writeback.c	2003-08-05 14:53:47.000000000 -0700
+++ linux/mm/page-writeback.c	2003-08-05 17:35:36.095648523 -0700
@@ -145,7 +145,7 @@
  * If we're over `background_thresh' then pdflush is woken to perform some
  * writeout.
  */
-int balance_dirty_pages(struct address_space *mapping)
+static int balance_dirty_pages(struct address_space *mapping)
 {
 	struct page_state ps;
 	long nr_reclaimable;
@@ -169,9 +169,16 @@
 		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
 		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 			break;
-
 		dirty_exceeded = 1;
 
+		/*
+		 * We do not want to throttle a real-time task here. Ever.
+		 * But we do want to update the accounting and possibly poke
+		 * pdflush below.
+		 */
+		if (rt_task(current))
+			break;
+
 		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
 		 * Unstable writes are a feature of certain networked
 		 * filesystems (i.e. NFS) in which data may have been


