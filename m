Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272916AbTHEWOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272920AbTHEWOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:14:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43508 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S272916AbTHEWOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:14:08 -0400
Subject: [patch] real-time enhanced page allocator and throttling
From: Robert Love <rml@tech9.net>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Valdis.Kletnieks@vt.edu, piggin@cyberone.com.au, kernel@kolivas.org,
       linux-mm@kvack.org
Content-Type: text/plain
Message-Id: <1060121638.4494.111.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 05 Aug 2003 15:13:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-04 at 22:55, Andrew Morton wrote:

> There is a very good argument for giving !SCHED_OTHER tasks
> "special treatment" in the VM.

Yes, there is.

Attached patch is against 2.6.0-test2-mm4. It does two main things:

	- Let real-time tasks dip further into the reserves than
	  usual in __alloc_pages(). There are a lot of ways to
	  special case this. This patch just cuts z->pages_low in
	  half, before doing the incremental min thing, for
	  real-time tasks. I do not do anything in the low memory
	  slow path. We can be a _lot_ more aggressive if we want.
	  Right now, we just give real-time tasks a little help.

	- Never ever call balance_dirty_pages() on a real-time
	  task. Where and how exactly we handle this is up for
	  debate. We could, for example, special case real-time
	  tasks inside balance_dirty_pages(). This would allow
	  us to perform some of the work (say, waking up pdflush)
	  but not other work (say, the active throttling). As it
	  stands now, we do the per-processor accounting in
	  balance_dirty_pages_ratelimited() but we never call
	  balance_dirty_pages(). Lots of approaches work. What
	  we want to do is never engage the real-time task in
	  forced writeback.

It compiles, it boots, and it does not crash. I have not tested whether
it prevents any starvation in real-time applications that are being
observed -- mostly because I am not sure if my approach is what you
want. There are multiple ways to handle the real-time task path. I
picked one. I do not know.

	Robert Love


 include/linux/sched.h |    4 +++-
 kernel/sched.c        |    1 -
 mm/page-writeback.c   |    6 +++++-
 mm/page_alloc.c       |   29 ++++++++++++++++++++---------
 4 files changed, 28 insertions(+), 12 deletions(-)


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
+++ linux/mm/page_alloc.c	2003-08-05 14:40:56.000000000 -0700
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
@@ -594,7 +605,7 @@
 	/* here we're in the low on memory slow path */
 
 rebalance:
-	if ((current->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
+	if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; zones[i] != NULL; i++) {
 			struct zone *z = zones[i];
@@ -610,14 +621,14 @@
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
@@ -657,7 +668,7 @@
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
+++ linux/mm/page-writeback.c	2003-08-05 13:48:43.000000000 -0700
@@ -227,7 +227,11 @@
 	if (dirty_exceeded)
 		ratelimit = 8;
 
-	if (get_cpu_var(ratelimits)++ >= ratelimit) {
+	/*
+	 * Check the rate limiting. Also, we do not want to throttle real-time
+	 * tasks in balance_dirty_pages(). Period.
+	 */
+	if (get_cpu_var(ratelimits)++ >= ratelimit && !rt_task(current)) {
 		__get_cpu_var(ratelimits) = 0;
 		put_cpu_var(ratelimits);
 		return balance_dirty_pages(mapping);



