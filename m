Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751954AbWCOOI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWCOOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCOOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:08:26 -0500
Received: from web26505.mail.ukl.yahoo.com ([217.146.176.42]:18298 "HELO
	web26505.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751954AbWCOOIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:08:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ttIM/ejtDahFCYDREib1tdLzEWbA/ozBLg6AdK345Mvu0wTp8L4kfSQRy739Ykn2vPctaoFhqbo0UL0TNIOkBmmxAPLO0f0QKm/lR/1xuVI3m+uYJ+hGx9oVCTgJv4r6aNFNOMpc6hPiP8Hj+RunBplXkpgFF8dCx2Jwtk/gEM8=  ;
Message-ID: <20060315140824.61797.qmail@web26505.mail.ukl.yahoo.com>
Date: Wed, 15 Mar 2006 15:08:23 +0100 (CET)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was: realtime-preempt patch-2.6.15-rt18 issues)
To: Ingo Molnar <mingo@elte.hu>, Jan Altenberg <tb10alj@tglx.de>
Cc: karsten wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060315110458.GA15012@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-307501419-1142431703=:57081"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-307501419-1142431703=:57081
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline


--- Ingo Molnar <mingo@elte.hu> schrieb:

> 
> * Jan Altenberg <tb10alj@tglx.de> wrote:
> 
> > > a better fix would be the one below - it still does
> the call on the 
> > > current CPU, and skips other CPUs (on SMP). Does this
> solve the problem 
> > > on your box too?
> > 
> > Tested in all a hurry and it seems to work for me too.
> 
> a full fix is below: this re-enables the full SLAB
> related smp-call 
> functionality on PREEMPT_RT too (without any hackery),
> and fixes a 
> couple of rt-NUMA bugs as well.
> 
Hand applied your full fix against 2.6.15-rt21 (local diff
attached).
Works fine here on uniprocessor, Thanks!

      Karsten


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
--0-307501419-1142431703=:57081
Content-Type: text/x-diff; name="slab_fix.diff"
Content-Description: 3654053042-slab_fix.diff
Content-Disposition: inline; filename="slab_fix.diff"

--- linux-2.6.15/rt21/mm/slab_0.c	2006-03-15 15:04:01.000000000 +0100
+++ linux-2.6.15/rt21/mm/slab.c	2006-03-15 15:04:01.000000000 +0100
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
@@ -944,6 +944,24 @@
 	}
 }
 
+/*
+ * Called from cache_reap() to regularly drain alien caches round robin.
+ */
+static void
+reap_alien(struct kmem_cache *cachep, struct kmem_list3 *l3, int *this_cpu)
+{
+	int node = __get_cpu_var(reap_node);
+
+	if (l3->alien) {
+		struct array_cache *ac = l3->alien[node];
+		if (ac && ac->avail) {
+			spin_lock_irq(&ac->lock);
+			__drain_alien_cache(cachep, ac, node, this_cpu);
+			spin_unlock_irq(&ac->lock);
+		}
+	}
+}
+
 static void drain_alien_cache(struct kmem_cache *cachep, struct array_cache **alien)
 {
 	int i = 0;
@@ -963,6 +981,7 @@
 #else
 
 #define drain_alien_cache(cachep, alien) do { } while (0)
+#define reap_alien(cachep, l3, this_cpu) do { } while (0)
 
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -2101,14 +2120,6 @@
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
@@ -2120,39 +2131,57 @@
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
@@ -2162,14 +2191,25 @@
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
@@ -2696,7 +2736,7 @@
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = cachep->nodelists[numa_node_id()];
+	l3 = cachep->nodelists[cpu_to_node(*this_cpu)];
 
 	BUG_ON(ac->avail > 0 || !l3);
 	spin_lock(&l3->list_lock);
@@ -2729,14 +2769,14 @@
 
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
 
@@ -2755,7 +2795,7 @@
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, numa_node_id(), this_cpu);
+		x = cache_grow(cachep, flags, cpu_to_node(*this_cpu), this_cpu);
 
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = cpu_cache_get(cachep, *this_cpu);
@@ -2838,7 +2878,7 @@
 	if (unlikely(current->mempolicy && !in_interrupt())) {
 		int nid = slab_node(current->mempolicy);
 
-		if (nid != numa_node_id())
+		if (nid != cpu_to_node(*this_cpu))
 			return __cache_alloc_node(cachep, flags, nid, this_cpu);
 	}
 #endif
@@ -2980,11 +3020,12 @@
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
@@ -3054,11 +3095,11 @@
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
@@ -3168,7 +3209,7 @@
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	slab_irq_save(save_flags, this_cpu);
-	if (nodeid == -1 || nodeid == numa_node_id() ||
+	if (nodeid == -1 || nodeid == cpu_to_node(this_cpu) ||
 	    !cachep->nodelists[nodeid])
 		ptr = ____cache_alloc(cachep, flags, &this_cpu);
 	else
@@ -3444,18 +3485,31 @@
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
@@ -3590,9 +3644,9 @@
  */
 static void cache_reap(void *unused)
 {
+	int this_cpu = raw_smp_processor_id();
 	struct list_head *walk;
 	struct kmem_list3 *l3;
-	int this_cpu;
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
@@ -3614,13 +3668,13 @@
 
 		check_irq_on();
 
-		l3 = searchp->nodelists[numa_node_id()];
-		if (l3->alien)
-			drain_alien_cache(searchp, l3->alien);
+		l3 = searchp->nodelists[cpu_to_node(this_cpu)];
+		reap_alien(searchp, l3, &this_cpu);
+
 		slab_spin_lock_irq(&l3->list_lock, this_cpu);
 
 		drain_array_locked(searchp, cpu_cache_get(searchp, this_cpu), 0,
-				   numa_node_id());
+				   cpu_to_node(this_cpu));
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
@@ -3629,7 +3683,7 @@
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-					   numa_node_id());
+					   cpu_to_node(this_cpu));
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;

--0-307501419-1142431703=:57081--
