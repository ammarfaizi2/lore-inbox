Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTF0Ivj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 04:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTF0Ivj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 04:51:39 -0400
Received: from dp.samba.org ([66.70.73.150]:17315 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263632AbTF0Iuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 04:50:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, davem@redhat.com, anton@samba.org, davidm@hpl.hp.com,
       torvalds@transmeta.com
Subject: [PATCH] On Local Per-Cpu Variables
Date: Fri, 27 Jun 2003 18:54:20 +1000
Message-Id: <20030627090509.A5BEB2C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

	Some people don't seem to be using per-cpu variables as
efficiently as possible.  Among other things, the interface explicitly
allows an arch to optimize the "local cpu" case, as IA64 already does
in fact.

So, please don't use:

	per_cpu(myvar, get_cpu()).counter++;
	put_cpu();

Instead:

	get_cpu_var(myvar).counter++;
	put_cpu_var(myvar);

The non-preemtion-disabling version is, logically:

	__get_cpu_var(myvar).counter++;

This is not just an "wierdass arch" issue.  One longer term
possibility is to implement smp_processor_id() as a per-cpu variable:
ie. the percpu-offset would be kept in thread_info, and the
smp_processor_id derived.  This is because most speed-critical uses of
smp_processor_id are simply to index into a per-cpu data structure:
we're not at the point where its a significant majority, but we're
getting there.

Hope this clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Use Local Percpu Macros for Local Percpu Variables
Author: Rusty Russell
Status: Trivial

D: In general, it is more better to use get_cpu_var() and __get_cpu_var()
D: to access per-cpu variables on this CPU than to use smp_processor_id()
D: and per_cpu().  In the current default implemention they are equivalent,
D: but on IA64 the former is already faster, and other archs will follow.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/fs/buffer.c .4081-linux-2.5.73-bk4.updated/fs/buffer.c
--- .4081-linux-2.5.73-bk4/fs/buffer.c	2003-06-15 11:30:05.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/fs/buffer.c	2003-06-27 18:46:43.000000000 +1000
@@ -1337,7 +1337,7 @@ static void bh_lru_install(struct buffer
 
 	check_irqs_on();
 	bh_lru_lock();
-	lru = &per_cpu(bh_lrus, smp_processor_id());
+	lru = &__get_cpu_var(bh_lrus);
 	if (lru->bhs[0] != bh) {
 		struct buffer_head *bhs[BH_LRU_SIZE];
 		int in;
@@ -1381,7 +1381,7 @@ lookup_bh_lru(struct block_device *bdev,
 
 	check_irqs_on();
 	bh_lru_lock();
-	lru = &per_cpu(bh_lrus, smp_processor_id());
+	lru = &__get_cpu_var(bh_lrus);
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = lru->bhs[i];
 
@@ -1474,15 +1474,14 @@ EXPORT_SYMBOL(__bread);
  */
 static void invalidate_bh_lru(void *arg)
 {
-	const int cpu = get_cpu();
-	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
+	struct bh_lru *b = &get_cpu_var(bh_lrus);
 	int i;
 
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		brelse(b->bhs[i]);
 		b->bhs[i] = NULL;
 	}
-	put_cpu();
+	put_cpu_var(bh_lrus);
 }
 	
 static void invalidate_bh_lrus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/kernel/exit.c .4081-linux-2.5.73-bk4.updated/kernel/exit.c
--- .4081-linux-2.5.73-bk4/kernel/exit.c	2003-06-23 10:52:59.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/kernel/exit.c	2003-06-27 18:46:43.000000000 +1000
@@ -41,7 +41,7 @@ static void __unhash_process(struct task
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
 		if (p->pid)
-			per_cpu(process_counts, smp_processor_id())--;
+			__get_cpu_var(process_counts)--;
 	}
 
 	REMOVE_LINKS(p);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/kernel/fork.c .4081-linux-2.5.73-bk4.updated/kernel/fork.c
--- .4081-linux-2.5.73-bk4/kernel/fork.c	2003-06-23 10:52:59.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/kernel/fork.c	2003-06-27 18:46:43.000000000 +1000
@@ -1006,7 +1006,7 @@ struct task_struct *copy_process(unsigne
 		attach_pid(p, PIDTYPE_PGID, p->pgrp);
 		attach_pid(p, PIDTYPE_SID, p->session);
 		if (p->pid)
-			per_cpu(process_counts, smp_processor_id())++;
+			__get_cpu_var(process_counts)++;
 	} else
 		link_pid(p, p->pids + PIDTYPE_TGID, &p->group_leader->pids[PIDTYPE_TGID].pid);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/kernel/timer.c .4081-linux-2.5.73-bk4.updated/kernel/timer.c
--- .4081-linux-2.5.73-bk4/kernel/timer.c	2003-06-23 10:52:59.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/kernel/timer.c	2003-06-27 18:46:43.000000000 +1000
@@ -156,8 +156,7 @@ static void internal_add_timer(tvec_base
  */
 void add_timer(struct timer_list *timer)
 {
-	int cpu = get_cpu();
-	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+	tvec_base_t *base = &get_cpu_var(tvec_bases);
   	unsigned long flags;
   
   	BUG_ON(timer_pending(timer) || !timer->function);
@@ -168,7 +167,7 @@ void add_timer(struct timer_list *timer)
 	internal_add_timer(base, timer);
 	timer->base = base;
 	spin_unlock_irqrestore(&base->lock, flags);
-	put_cpu();
+	put_cpu_var(tvec_bases);
 }
 
 /***
@@ -231,7 +230,7 @@ int mod_timer(struct timer_list *timer, 
 		return 1;
 
 	spin_lock_irqsave(&timer->lock, flags);
-	new_base = &per_cpu(tvec_bases, smp_processor_id());
+	new_base = &__get_cpu_var(tvec_bases);
 repeat:
 	old_base = timer->base;
 
@@ -789,7 +788,7 @@ seqlock_t xtime_lock __cacheline_aligned
  */
 static void run_timer_softirq(struct softirq_action *h)
 {
-	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
+	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/mm/page-writeback.c .4081-linux-2.5.73-bk4.updated/mm/page-writeback.c
--- .4081-linux-2.5.73-bk4/mm/page-writeback.c	2003-06-23 10:52:59.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/mm/page-writeback.c	2003-06-27 18:46:43.000000000 +1000
@@ -213,21 +213,19 @@ void balance_dirty_pages(struct address_
 void balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
 	static DEFINE_PER_CPU(int, ratelimits) = 0;
-	int cpu;
 	long ratelimit;
 
 	ratelimit = ratelimit_pages;
 	if (dirty_exceeded)
 		ratelimit = 8;
 
-	cpu = get_cpu();
-	if (per_cpu(ratelimits, cpu)++ >= ratelimit) {
-		per_cpu(ratelimits, cpu) = 0;
-		put_cpu();
+	if (get_cpu_var(ratelimits)++ >= ratelimit) {
+		__get_cpu_var(ratelimits) = 0;
+		put_cpu_var(ratelimits);
 		balance_dirty_pages(mapping);
 		return;
 	}
-	put_cpu();
+	put_cpu_var(ratelimits);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/mm/rmap.c .4081-linux-2.5.73-bk4.updated/mm/rmap.c
--- .4081-linux-2.5.73-bk4/mm/rmap.c	2003-04-20 18:05:16.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/mm/rmap.c	2003-06-27 18:46:43.000000000 +1000
@@ -477,16 +477,15 @@ DEFINE_PER_CPU(struct pte_chain *, local
  */
 void __pte_chain_free(struct pte_chain *pte_chain)
 {
-	int cpu = get_cpu();
 	struct pte_chain **pte_chainp;
 
+	pte_chainp = &get_cpu_var(local_pte_chain);
 	if (pte_chain->next_and_idx)
 		pte_chain->next_and_idx = 0;
-	pte_chainp = &per_cpu(local_pte_chain, cpu);
 	if (*pte_chainp)
 		kmem_cache_free(pte_chain_cache, *pte_chainp);
 	*pte_chainp = pte_chain;
-	put_cpu();
+	put_cpu_var(local_pte_chain);
 }
 
 /*
@@ -501,21 +500,19 @@ void __pte_chain_free(struct pte_chain *
  */
 struct pte_chain *pte_chain_alloc(int gfp_flags)
 {
-	int cpu;
 	struct pte_chain *ret;
 	struct pte_chain **pte_chainp;
 
 	if (gfp_flags & __GFP_WAIT)
 		might_sleep();
 
-	cpu = get_cpu();
-	pte_chainp = &per_cpu(local_pte_chain, cpu);
+	pte_chainp = &get_cpu_var(local_pte_chain);
 	if (*pte_chainp) {
 		ret = *pte_chainp;
 		*pte_chainp = NULL;
-		put_cpu();
+		put_cpu_var(local_pte_chain);
 	} else {
-		put_cpu();
+		put_cpu_var(local_pte_chain);
 		ret = kmem_cache_alloc(pte_chain_cache, gfp_flags);
 	}
 	return ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/mm/swap.c .4081-linux-2.5.73-bk4.updated/mm/swap.c
--- .4081-linux-2.5.73-bk4/mm/swap.c	2003-05-05 12:37:13.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/mm/swap.c	2003-06-27 18:46:43.000000000 +1000
@@ -112,35 +112,34 @@ static DEFINE_PER_CPU(struct pagevec, lr
 
 void lru_cache_add(struct page *page)
 {
-	struct pagevec *pvec = &per_cpu(lru_add_pvecs, get_cpu());
+	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
 
 	page_cache_get(page);
 	if (!pagevec_add(pvec, page))
 		__pagevec_lru_add(pvec);
-	put_cpu();
+	put_cpu_var(lru_add_pvecs);
 }
 
 void lru_cache_add_active(struct page *page)
 {
-	struct pagevec *pvec = &per_cpu(lru_add_active_pvecs, get_cpu());
+	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
 
 	page_cache_get(page);
 	if (!pagevec_add(pvec, page))
 		__pagevec_lru_add_active(pvec);
-	put_cpu();
+	put_cpu_var(lru_add_active_pvecs);
 }
 
 void lru_add_drain(void)
 {
-	int cpu = get_cpu();
-	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
+	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
 
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &per_cpu(lru_add_active_pvecs, cpu);
+	pvec = &__get_cpu_var(lru_add_active_pvecs);
 	if (pagevec_count(pvec))
 		__pagevec_lru_add_active(pvec);
-	put_cpu();
+	put_cpu_var(lru_add_pvecs);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4081-linux-2.5.73-bk4/net/ipv4/icmp.c .4081-linux-2.5.73-bk4.updated/net/ipv4/icmp.c
--- .4081-linux-2.5.73-bk4/net/ipv4/icmp.c	2003-06-27 12:48:17.000000000 +1000
+++ .4081-linux-2.5.73-bk4.updated/net/ipv4/icmp.c	2003-06-27 18:46:43.000000000 +1000
@@ -228,7 +228,7 @@ static struct icmp_control icmp_pointers
  *	On SMP we have one ICMP socket per-cpu.
  */
 static DEFINE_PER_CPU(struct socket *, __icmp_socket) = NULL;
-#define icmp_socket	per_cpu(__icmp_socket, smp_processor_id())
+#define icmp_socket	__get_cpu_var(__icmp_socket)
 
 static __inline__ void icmp_xmit_lock(void)
 {
