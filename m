Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUGNSKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUGNSKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUGNSKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:10:04 -0400
Received: from [192.48.179.6] ([192.48.179.6]:10239 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267495AbUGNSJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:09:52 -0400
Date: Wed, 14 Jul 2004 13:09:42 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lse-tech@lists.sourceforge.net
Subject: [PATCH] Move cache_reap out of timer context
Message-ID: <20040714180942.GA18425@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm submitting two patches associated with moving cache_reap functionality
out of timer context.  Note that these patches do not make any further
optimizations to cache_reap at this time.

The first patch adds a function similiar to schedule_delayed_work to
allow work to be scheduled on another cpu.

The second patch makes use of schedule_delayed_work_on to schedule
cache_reap to run from keventd.

These patches apply to 2.6.8-rc1.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>


Index: linux/include/linux/workqueue.h
===================================================================
--- linux.orig/include/linux/workqueue.h
+++ linux/include/linux/workqueue.h
@@ -63,6 +63,8 @@
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
+
+extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
Index: linux/kernel/workqueue.c
===================================================================
--- linux.orig/kernel/workqueue.c
+++ linux/kernel/workqueue.c
@@ -398,6 +398,26 @@
 	return queue_delayed_work(keventd_wq, work, delay);
 }
 
+int schedule_delayed_work_on(int cpu,
+			struct work_struct *work, unsigned long delay)
+{
+	int ret = 0;
+	struct timer_list *timer = &work->timer;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(timer_pending(timer));
+		BUG_ON(!list_empty(&work->entry));
+		/* This stores keventd_wq for the moment, for the timer_fn */
+		work->wq_data = keventd_wq;
+		timer->expires = jiffies + delay;
+		timer->data = (unsigned long)work;
+		timer->function = delayed_work_timer_fn;
+		add_timer_on(timer, cpu);
+		ret = 1;
+	}
+	return ret;
+}
+
 void flush_scheduled_work(void)
 {
 	flush_workqueue(keventd_wq);




Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -519,11 +519,11 @@
 	FULL
 } g_cpucache_up;
 
-static DEFINE_PER_CPU(struct timer_list, reap_timers);
+static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void reap_timer_fnc(unsigned long data);
 static void free_block(kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
+static void cache_reap (void *unused);
 
 static inline void ** ac_entry(struct array_cache *ac)
 {
@@ -573,35 +573,25 @@
 }
 
 /*
- * Start the reap timer running on the target CPU.  We run at around 1 to 2Hz.
- * Add the CPU number into the expiry time to minimize the possibility of the
+ * Initiate the reap timer running on the target CPU.  We run at around 1 to 2Hz
+ * via the workqueue/eventd.
+ * Add the CPU number into the expiration time to minimize the possibility of the
  * CPUs getting into lockstep and contending for the global cache chain lock.
  */
 static void __devinit start_cpu_timer(int cpu)
 {
-	struct timer_list *rt = &per_cpu(reap_timers, cpu);
+	struct work_struct *reap_work = &per_cpu(reap_work, cpu);
 
-	if (rt->function == NULL) {
-		init_timer(rt);
-		rt->expires = jiffies + HZ + 3*cpu;
-		rt->data = cpu;
-		rt->function = reap_timer_fnc;
-		add_timer_on(rt, cpu);
-	}
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-static void stop_cpu_timer(int cpu)
-{
-	struct timer_list *rt = &per_cpu(reap_timers, cpu);
-
-	if (rt->function) {
-		del_timer_sync(rt);
-		WARN_ON(timer_pending(rt));
-		rt->function = NULL;
+	/*
+	 * When this gets called from do_initcalls via cpucache_init(),
+	 * init_workqueues() has already run, so keventd will be setup
+	 * at that time.
+	 */
+	if (keventd_up() && reap_work->func == NULL) {
+		INIT_WORK(reap_work, cache_reap, NULL);
+		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
 	}
 }
-#endif
 
 static struct array_cache *alloc_arraycache(int cpu, int entries, int batchcount)
 {
@@ -654,7 +644,6 @@
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
-		stop_cpu_timer(cpu);
 		/* fall thru */
 	case CPU_UP_CANCELED:
 		down(&cache_chain_sem);
@@ -2674,15 +2663,15 @@
 /**
  * cache_reap - Reclaim memory from caches.
  *
- * Called from a timer, every few seconds
+ * Called from workqueue/eventd every few seconds.
  * Purpose:
  * - clear the per-cpu caches for this CPU.
  * - return freeable pages to the main free memory pool.
  *
  * If we cannot acquire the cache chain semaphore then just give up - we'll
- * try again next timer interrupt.
+ * try again on the next iteration.
  */
-static void cache_reap (void)
+static void cache_reap (void *unused)
 {
 	struct list_head *walk;
 
@@ -2690,8 +2679,11 @@
 	BUG_ON(!in_interrupt());
 	BUG_ON(in_irq());
 #endif
-	if (down_trylock(&cache_chain_sem))
+	if (down_trylock(&cache_chain_sem)) {
+		/* Give up. Setup the next iteration. */
+		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
 		return;
+	}
 
 	list_for_each(walk, &cache_chain) {
 		kmem_cache_t *searchp;
@@ -2755,22 +2747,8 @@
 	}
 	check_irq_on();
 	up(&cache_chain_sem);
-}
-
-/*
- * This is a timer handler.  There is one per CPU.  It is called periodially
- * to shrink this CPU's caches.  Otherwise there could be memory tied up
- * for long periods (or for ever) due to load changes.
- */
-static void reap_timer_fnc(unsigned long cpu)
-{
-	struct timer_list *rt = &__get_cpu_var(reap_timers);
-
-	/* CPU hotplug can drag us off cpu: don't run on wrong CPU */
-	if (!cpu_is_offline(cpu)) {
-		cache_reap();
-		mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
-	}
+	/* Setup the next iteration */
+	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
 }
 
 #ifdef CONFIG_PROC_FS
