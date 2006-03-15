Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWCOLHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWCOLHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCOLHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:07:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46748 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750873AbWCOLHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:07:17 -0500
Date: Wed, 15 Mar 2006 12:04:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jan Altenberg <tb10alj@tglx.de>
Cc: karsten wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was: realtime-preempt patch-2.6.15-rt18 issues)
Message-ID: <20060315110458.GA15012@elte.hu>
References: <36944.195.245.190.93.1141734835.squirrel@www.rncbc.org> <20060314231344.44688.qmail@web26506.mail.ukl.yahoo.com> <20060315093122.GA1682@elte.hu> <4417EA34.20802@tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4417EA34.20802@tglx.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Altenberg <tb10alj@tglx.de> wrote:

> > a better fix would be the one below - it still does the call on the 
> > current CPU, and skips other CPUs (on SMP). Does this solve the problem 
> > on your box too?
> 
> Tested in all a hurry and it seems to work for me too.

a full fix is below: this re-enables the full SLAB related smp-call 
functionality on PREEMPT_RT too (without any hackery), and fixes a 
couple of rt-NUMA bugs as well.

	Ingo

Index: linux-rt.q/mm/slab.c
===================================================================
--- linux-rt.q.orig/mm/slab.c
+++ linux-rt.q/mm/slab.c
@@ -147,9 +147,9 @@
 # define slab_spin_unlock_irqrestore(lock, flags, cpu) \
  	do { spin_unlock_irqrestore(lock, flags); } while (0)
 #else
-DEFINE_PER_CPU_LOCKED(int, slab_locks) = { 0, };
-# define slab_irq_disable(cpu)		get_cpu_var_locked(slab_locks, &(cpu))
-# define slab_irq_enable(cpu)		put_cpu_var_locked(slab_locks, cpu)
+DEFINE_PER_CPU_LOCKED(int, slab_irq_locks) = { 0, };
+# define slab_irq_disable(cpu)		get_cpu_var_locked(slab_irq_locks, &(cpu))
+# define slab_irq_enable(cpu)		put_cpu_var_locked(slab_irq_locks, cpu)
 # define slab_irq_save(flags, cpu) \
 	do { slab_irq_disable(cpu); (void) (flags); } while (0)
 # define slab_irq_restore(flags, cpu) \
@@ -989,7 +989,8 @@ static void __drain_alien_cache(struct k
 /*
  * Called from cache_reap() to regularly drain alien caches round robin.
  */
-static void reap_alien(struct kmem_cache *cachep, struct kmem_list3 *l3)
+static void
+reap_alien(struct kmem_cache *cachep, struct kmem_list3 *l3, int *this_cpu)
 {
 	int node = __get_cpu_var(reap_node);
 
@@ -997,7 +998,7 @@ static void reap_alien(struct kmem_cache
 		struct array_cache *ac = l3->alien[node];
 		if (ac && ac->avail) {
 			spin_lock_irq(&ac->lock);
-			__drain_alien_cache(cachep, ac, node);
+			__drain_alien_cache(cachep, ac, node, this_cpu);
 			spin_unlock_irq(&ac->lock);
 		}
 	}
@@ -1022,7 +1023,7 @@ static void drain_alien_cache(struct kme
 #else
 
 #define drain_alien_cache(cachep, alien) do { } while (0)
-#define reap_alien(cachep, l3) do { } while (0)
+#define reap_alien(cachep, l3, this_cpu) do { } while (0)
 
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -2164,14 +2165,6 @@ static void check_irq_on(void)
 #endif
 }
 
-static void check_spinlock_acquired(struct kmem_cache *cachep)
-{
-#ifdef CONFIG_SMP
-	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[numa_node_id()]->list_lock);
-#endif
-}
-
 static void check_spinlock_acquired_node(struct kmem_cache *cachep, int node)
 {
 #ifdef CONFIG_SMP
@@ -2183,39 +2176,57 @@ static void check_spinlock_acquired_node
 #else
 #define check_irq_off()	do { } while(0)
 #define check_irq_on()	do { } while(0)
-#define check_spinlock_acquired(x) do { } while(0)
 #define check_spinlock_acquired_node(x, y) do { } while(0)
 #endif
 
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * execute func() for all CPUs. On PREEMPT_RT we dont actually have
+ * to run on the remote CPUs - we only have to take their CPU-locks.
+ * (This is a rare operation, so cacheline bouncing is not an issue.)
+ */
+static void
+smp_call_function_all_cpus(void (*func)(void *arg, int this_cpu), void *arg)
+{
+	unsigned int i;
+
+	check_irq_on();
+	for_each_online_cpu(i) {
+		spin_lock(&__get_cpu_lock(slab_irq_locks, i));
+		func(arg, i);
+		spin_unlock(&__get_cpu_lock(slab_irq_locks, i));
+	}
+}
+#else
 /*
  * Waits for all CPUs to execute func().
  */
 static void smp_call_function_all_cpus(void (*func)(void *arg), void *arg)
 {
-	unsigned long flags;
+	unsigned int this_cpu;
 
 	check_irq_on();
 	preempt_disable();
 
-	slab_irq_disable(flags);
+	slab_irq_disable(this_cpu);
 	func(arg);
-	slab_irq_enable(flags);
+	slab_irq_enable(this_cpu);
 
 	if (smp_call_function(func, arg, 1, 1))
 		BUG();
 
 	preempt_enable();
 }
+#endif
 
 static void drain_array_locked(struct kmem_cache *cachep, struct array_cache *ac,
 				int force, int node);
 
-static void do_drain(void *arg)
+static void __do_drain(void *arg, int this_cpu)
 {
 	struct kmem_cache *cachep = (struct kmem_cache *) arg;
+	int node = cpu_to_node(this_cpu);
 	struct array_cache *ac;
-	int node = numa_node_id();
-	int this_cpu = smp_processor_id();
 
 	check_irq_off();
 	ac = cpu_cache_get(cachep, this_cpu);
@@ -2225,14 +2236,25 @@ static void do_drain(void *arg)
 	ac->avail = 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void do_drain(void *arg, int this_cpu)
+{
+	__do_drain(arg, this_cpu);
+}
+#else
+static void do_drain(void *arg)
+{
+	__do_drain(arg, smp_processor_id());
+}
+#endif
+
 static void drain_cpu_caches(struct kmem_cache *cachep)
 {
 	struct kmem_list3 *l3;
 	int this_cpu;
 	int node;
 
-// FIXME:
-//	smp_call_function_all_cpus(do_drain, cachep);
+	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
@@ -2759,7 +2781,7 @@ cache_alloc_refill(struct kmem_cache *ca
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = cachep->nodelists[numa_node_id()];
+	l3 = cachep->nodelists[cpu_to_node(*this_cpu)];
 
 	BUG_ON(ac->avail > 0 || !l3);
 	spin_lock(&l3->list_lock);
@@ -2792,14 +2814,14 @@ cache_alloc_refill(struct kmem_cache *ca
 
 		slabp = list_entry(entry, struct slab, list);
 		check_slabp(cachep, slabp);
-		check_spinlock_acquired(cachep);
+		check_spinlock_acquired_node(cachep, cpu_to_node(*this_cpu));
 		while (slabp->inuse < cachep->num && batchcount--) {
 			STATS_INC_ALLOCED(cachep);
 			STATS_INC_ACTIVE(cachep);
 			STATS_SET_HIGH(cachep);
 
 			ac->entry[ac->avail++] = slab_get_obj(cachep, slabp,
-							    numa_node_id());
+						    cpu_to_node(*this_cpu));
 		}
 		check_slabp(cachep, slabp);
 
@@ -2818,7 +2840,7 @@ cache_alloc_refill(struct kmem_cache *ca
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, numa_node_id(), this_cpu);
+		x = cache_grow(cachep, flags, cpu_to_node(*this_cpu), this_cpu);
 
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = cpu_cache_get(cachep, *this_cpu);
@@ -2901,7 +2923,7 @@ ____cache_alloc(struct kmem_cache *cache
 	if (unlikely(current->mempolicy && !in_interrupt())) {
 		int nid = slab_node(current->mempolicy);
 
-		if (nid != numa_node_id())
+		if (nid != cpu_to_node(*this_cpu))
 			return __cache_alloc_node(cachep, flags, nid, this_cpu);
 	}
 #endif
@@ -3043,11 +3065,12 @@ static void free_block(struct kmem_cache
 	}
 }
 
-static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac, int *this_cpu)
+static void
+cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac, int *this_cpu)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
-	int node = numa_node_id();
+	int node = cpu_to_node(*this_cpu);
 
 	batchcount = ac->batchcount;
 #if DEBUG
@@ -3117,11 +3140,11 @@ __cache_free(struct kmem_cache *cachep, 
 	{
 		struct slab *slabp;
 		slabp = virt_to_slab(objp);
-		if (unlikely(slabp->nodeid != numa_node_id())) {
+		if (unlikely(slabp->nodeid != cpu_to_node(*this_cpu))) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
 			struct kmem_list3 *l3 =
-			    cachep->nodelists[numa_node_id()];
+			    cachep->nodelists[cpu_to_node(*this_cpu)];
 
 			STATS_INC_NODEFREES(cachep);
 			if (l3->alien && l3->alien[nodeid]) {
@@ -3231,7 +3254,7 @@ void *kmem_cache_alloc_node(struct kmem_
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	slab_irq_save(save_flags, this_cpu);
-	if (nodeid == -1 || nodeid == numa_node_id() ||
+	if (nodeid == -1 || nodeid == cpu_to_node(this_cpu) ||
 	    !cachep->nodelists[nodeid])
 		ptr = ____cache_alloc(cachep, flags, &this_cpu);
 	else
@@ -3508,18 +3531,31 @@ struct ccupdate_struct {
 	struct array_cache *new[NR_CPUS];
 };
 
-static void do_ccupdate_local(void *info)
+static void __do_ccupdate_local(void *info, int this_cpu)
 {
 	struct ccupdate_struct *new = (struct ccupdate_struct *)info;
 	struct array_cache *old;
 
 	check_irq_off();
-	old = cpu_cache_get(new->cachep, smp_processor_id());
+	old = cpu_cache_get(new->cachep, this_cpu);
 
-	new->cachep->array[smp_processor_id()] = new->new[smp_processor_id()];
-	new->new[smp_processor_id()] = old;
+	new->cachep->array[this_cpu] = new->new[this_cpu];
+	new->new[this_cpu] = old;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void do_ccupdate_local(void *arg, int this_cpu)
+{
+	__do_ccupdate_local(arg, this_cpu);
+}
+#else
+static void do_ccupdate_local(void *info)
+{
+	__do_ccupdate_local(arg, smp_processor_id());
+}
+#endif
+
+
 static int do_tune_cpucache(struct kmem_cache *cachep, int limit, int batchcount,
 			    int shared)
 {
@@ -3654,9 +3690,9 @@ static void drain_array_locked(struct km
  */
 static void cache_reap(void *unused)
 {
+	int this_cpu = raw_smp_processor_id();
 	struct list_head *walk;
 	struct kmem_list3 *l3;
-	int this_cpu;
 
 	if (!mutex_trylock(&cache_chain_mutex)) {
 		/* Give up. Setup the next iteration. */
@@ -3678,12 +3714,13 @@ static void cache_reap(void *unused)
 
 		check_irq_on();
 
-		l3 = searchp->nodelists[numa_node_id()];
-		reap_alien(searchp, l3);
+		l3 = searchp->nodelists[cpu_to_node(this_cpu)];
+		reap_alien(searchp, l3, &this_cpu);
+
 		slab_spin_lock_irq(&l3->list_lock, this_cpu);
 
 		drain_array_locked(searchp, cpu_cache_get(searchp, this_cpu), 0,
-				   numa_node_id());
+				   cpu_to_node(this_cpu));
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
@@ -3692,7 +3729,7 @@ static void cache_reap(void *unused)
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-					   numa_node_id());
+					   cpu_to_node(this_cpu));
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
