Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSJEKiA>; Sat, 5 Oct 2002 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262294AbSJEKh5>; Sat, 5 Oct 2002 06:37:57 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:19842 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262291AbSJEKhs>;
	Sat, 5 Oct 2002 06:37:48 -0400
Message-ID: <3D9EBFA9.90806@colorfullife.com>
Date: Sat, 05 Oct 2002 12:32:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-08-reap
Content-Type: multipart/mixed;
 boundary="------------040509060808090805030602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509060808090805030602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

part 8:
- add a reap timer that returns stale objects from the cpu arrays
- use list_for_each instead of while loops
- /proc/slabinfo layout change, for a new field about reaping.

Implementation:
slab contains 2 caches that contain objects that might be usable to the 
systems:
- the cpu arrays contains objects that other cpus could use
- the slabs_free list contains freeable slabs, i.e. pages that someone 
else might want.

The patch now keeps track of accesses to the cpu arrays and to the free 
list. If there were no recent activities in one of the caches, part of 
the cache is flushed.

Unlike <2.5.39, only a small part (~20%) is flushed each time:
The older kernel would refill/drain bounce heavily under memory pressure:

- kmem_cache_alloc: notices that there are no objects in the cpu
	cache, loads 120 objects from the slab lists, return 1.
	[assuming batchcount=120]
- kmem_cache_reap is called due to memory pressure, finds 119
	objects in the cpu array and returns them to the slab lists.
- repeat.

In addition, the lengh of the free list is limited based on the free 
list accesses: a fixed "1" limit hurts the large object caches.

That's the last part for now, next is: [not yet written]
- cleanup: BUG_ON instead of if() BUG
- OOM handling for enable_cpucaches
- remove the unconditional might_sleep() from
	cache_alloc_debugcheck_before, and make that DEBUG dependant.
- initial NUMA support, just to collect some stats:
	Which percentage of the objects are freed on the wrong
	node? 0.1% or 20%?

--
	Manfred

--------------040509060808090805030602
Content-Type: text/plain;
 name="patch-slab-split-08-reap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-08-reap"

--- 2.5/mm/slab.c	Sat Oct  5 11:48:01 2002
+++ build-2.5/mm/slab.c	Sat Oct  5 12:12:10 2002
@@ -105,11 +105,6 @@
 #define	FORCED_DEBUG	0
 #endif
 
-/*
- * Parameters for cache_reap
- */
-#define REAP_SCANLEN	10
-#define REAP_PERFECT	10
 
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
@@ -191,6 +186,7 @@
 	unsigned int avail;
 	unsigned int limit;
 	unsigned int batchcount;
+	unsigned int touched;
 } cpucache_t;
 
 /* bootstrap: The caches do not work without cpuarrays anymore,
@@ -224,6 +220,9 @@
 	struct list_head	slabs_partial;	/* partial list first, better asm code */
 	struct list_head	slabs_full;
 	struct list_head	slabs_free;
+	unsigned long	free_objects;
+	int		free_touched;
+	unsigned long	next_reap;
 };
 
 #define LIST3_INIT(parent) \
@@ -257,6 +256,7 @@
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
+	unsigned int		free_limit; /* upper limit of objects in the lists */
 	spinlock_t		spinlock;
 
 /* 3) cache_grow/shrink */
@@ -290,6 +290,7 @@
 	unsigned long		grown;
 	unsigned long		reaped;
 	unsigned long 		errors;
+	unsigned long		max_freeable;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
@@ -302,6 +303,16 @@
 
 #define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
 
+#define BATCHREFILL_LIMIT	16
+/* Optimization question: fewer reaps means less 
+ * probability for unnessary cpucache drain/refill cycles.
+ *
+ * OTHO the cpuarrays can contain lots of objects,
+ * which could lock up otherwise freeable slabs.
+ */
+#define REAPTIMEOUT_CPUC	(2*HZ)
+#define REAPTIMEOUT_LIST3	(4*HZ)
+
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
 #define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
@@ -312,6 +323,15 @@
 					(x)->high_mark = (x)->num_active; \
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
+#define	STATS_SET_FREEABLE(x, i) \
+				do { if ((x)->max_freeable < i) \
+					(x)->max_freeable = i; \
+				} while (0)
+
+#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
+#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
+#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
+#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
 #else
 #define	STATS_INC_ACTIVE(x)	do { } while (0)
 #define	STATS_DEC_ACTIVE(x)	do { } while (0)
@@ -320,14 +340,9 @@
 #define	STATS_INC_REAPED(x)	do { } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
-#endif
+#define	STATS_SET_FREEABLE(x, i) \
+				do { } while (0)
 
-#if STATS
-#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
-#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
-#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
-#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
-#else
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
 #define STATS_INC_FREEHIT(x)	do { } while (0)
@@ -426,8 +441,8 @@
 }; 
 #undef CN
 
-struct cpucache_int cpuarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1} };
-struct cpucache_int cpuarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1} };
+struct cpucache_int cpuarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
+struct cpucache_int cpuarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
@@ -444,9 +459,7 @@
 
 /* Guard access to the cache-chain. */
 static struct semaphore	cache_chain_sem;
-
-/* Place maintainer for reaping. */
-static kmem_cache_t *clock_searchp = &cache_cache;
+static rwlock_t cache_chain_lock = RW_LOCK_UNLOCKED;
 
 #define cache_chain (cache_cache.next)
 
@@ -460,6 +473,10 @@
 	FULL
 } g_cpucache_up;
 
+static struct timer_list reap_timer[NR_CPUS];
+
+static void reap_timer_fnc(unsigned long data);
+
 static void enable_cpucache (kmem_cache_t *cachep);
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
@@ -490,7 +507,58 @@
 	*left_over = wastage;
 }
 
-#ifdef CONFIG_SMP
+static void do_timerstart(void *arg)
+{
+	int cpu = smp_processor_id();
+	if (reap_timer[cpu].function == 0) {
+		printk(KERN_INFO "slab: reap timer started for cpu %d.\n", cpu);
+		init_timer(&reap_timer[cpu]);
+		reap_timer[cpu].expires = jiffies + HZ + 3*cpu;
+		reap_timer[cpu].function = reap_timer_fnc;
+		add_timer(&reap_timer[cpu]);
+	}
+}
+
+/* This doesn't belong here, should be somewhere in kernel/ */
+struct cpucall_info {
+	int cpu;
+	void (*fnc)(void*arg);
+	void *arg;
+};
+
+static int cpucall_thread(void *__info)
+{
+	struct cpucall_info *info = (struct cpucall_info *)__info;
+
+	/* Migrate to the right CPU */
+	daemonize();
+	set_cpus_allowed(current, 1UL << info->cpu);
+	BUG_ON(smp_processor_id() != info->cpu);
+
+	info->fnc(info->arg);
+	kfree(info);
+	return 0;
+}
+
+static int do_cpucall(void (*fnc)(void *arg), void *arg, int cpu)
+{
+	struct cpucall_info *info;
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_INFO "do_cpucall for cpu %d, callback %p failed at kmalloc.\n",
+				cpu, fnc);
+		return -1;
+	}
+	info->cpu = cpu;
+	info->fnc = fnc;
+	info->arg = arg;
+	if (kernel_thread(cpucall_thread, info, CLONE_KERNEL) < 0) {
+		printk(KERN_INFO "do_cpucall for cpu %d, callback %p failed at kernel_thread.\n",
+				cpu, fnc);
+		return -1;
+	}
+	return 0;
+}
 /*
  * Note: if someone calls kmem_cache_alloc() on the new
  * cpu before the cpuup callback had a chance to allocate
@@ -508,8 +576,7 @@
 
 		down(&cache_chain_sem);
 
-		p = &cache_cache.next;
-		do {
+		list_for_each(p, &cache_chain) {
 			int memsize;
 
 			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
@@ -520,12 +587,18 @@
 			nc->avail = 0;
 			nc->limit = cachep->limit;
 			nc->batchcount = cachep->batchcount;
+			nc->touched = 0;
 
+			spin_lock_irq(&cachep->spinlock);
 			cachep->cpudata[cpu] = nc;
+			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
+						+ cachep->num;
+			spin_unlock_irq(&cachep->spinlock);
 
-			p = cachep->next.next;
-		} while (p != &cache_cache.next);
+		}
 
+		if (g_cpucache_up == FULL)
+			do_cpucall(do_timerstart, NULL, cpu);
 		up(&cache_chain_sem);
 	}
 
@@ -536,7 +609,6 @@
 }
 
 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
-#endif
 
 /* Initialisation - setup the `cache' cache. */
 void __init kmem_cache_init(void)
@@ -554,12 +626,10 @@
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
 
-#ifdef CONFIG_SMP
 	/* Register a cpu startup notifier callback
 	 * that initializes cc_data for all new cpus
 	 */
 	register_cpu_notifier(&cpucache_notifier);
-#endif
 }
 
 
@@ -628,17 +698,26 @@
 int __init cpucache_init(void)
 {
 	struct list_head* p;
+	int i;
 
 	down(&cache_chain_sem);
 	g_cpucache_up = FULL;
 
-	p = &cache_cache.next;
-	do {
+	list_for_each(p, &cache_chain) {
 		kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
 		enable_cpucache(cachep);
 		p = cachep->next.next;
-	} while (p != &cache_cache.next);
+	}
 	
+	/* 
+	 * Register the timers that return unneeded
+	 * pages to gfp.
+	 */
+
+	for (i=0;i<NR_CPUS;i++) {
+		if (cpu_online(i))
+			do_cpucall(do_timerstart, NULL, i);
+	}
 	up(&cache_chain_sem);
 
 	return 0;
@@ -972,10 +1051,16 @@
 		cc_data(cachep)->avail = 0;
 		cc_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
 		cc_data(cachep)->batchcount = 1;
+		cc_data(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
+		cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
+					+ cachep->num;
 	} 
 
+	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
+					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
 	{
@@ -1004,10 +1089,10 @@
 		set_fs(old_fs);
 	}
 
-	/* There is no reason to lock our new cache before we
-	 * link it in - no one knows about it yet...
-	 */
+	/* cache setup completed, link it into the list */
+	write_lock_bh(&cache_chain_lock);
 	list_add(&cachep->next, &cache_chain);
+	write_unlock_bh(&cache_chain_lock);
 	up(&cache_chain_sem);
 opps:
 	return cachep;
@@ -1040,6 +1125,7 @@
  */
 static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
 {
+	check_irq_on();
 	local_irq_disable();
 	func(arg);
 	local_irq_enable();
@@ -1092,6 +1178,7 @@
 #endif
 		list_del(&slabp->list);
 
+		cachep->lists.free_objects -= cachep->num;
 		spin_unlock_irq(&cachep->spinlock);
 		slab_destroy(cachep, slabp);
 		spin_lock_irq(&cachep->spinlock);
@@ -1140,17 +1227,18 @@
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
 	/* the chain is never empty, cache_cache is never destroyed */
-	if (clock_searchp == cachep)
-		clock_searchp = list_entry(cachep->next.next,
-						kmem_cache_t, next);
+	write_lock_bh(&cache_chain_lock);
 	list_del(&cachep->next);
+	write_unlock_bh(&cache_chain_lock);
 	up(&cache_chain_sem);
 
 	if (__cache_shrink(cachep)) {
 		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
 		       cachep);
 		down(&cache_chain_sem);
+		write_lock_bh(&cache_chain_lock);
 		list_add(&cachep->next,&cache_chain);
+		write_unlock_bh(&cache_chain_lock);
 		up(&cache_chain_sem);
 		return 1;
 	}
@@ -1330,6 +1418,7 @@
 	/* Make slab active. */
 	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
 	STATS_INC_GROWN(cachep);
+	list3_data(cachep)->free_objects += cachep->num;
 	spin_unlock(&cachep->spinlock);
 	return 1;
 opps1:
@@ -1474,6 +1563,13 @@
 	cc = cc_data(cachep);
 retry:
 	batchcount = cc->batchcount;
+	if (!cc->touched && batchcount > BATCHREFILL_LIMIT) {
+		/* if there was little recent activity on this
+		 * cache, then perform only a partial refill.
+		 * Otherwise we could generate refill bouncing.
+		 */
+		batchcount = BATCHREFILL_LIMIT;
+	}
 	l3 = list3_data(cachep);
 
 	BUG_ON(cc->avail > 0);
@@ -1484,6 +1580,7 @@
 		/* Get slab alloc is to come from. */
 		entry = l3->slabs_partial.next;
 		if (entry == &l3->slabs_partial) {
+			l3->free_touched = 1;
 			entry = l3->slabs_free.next;
 			if (entry == &l3->slabs_free)
 				goto must_grow;
@@ -1499,6 +1596,7 @@
 	}
 
 must_grow:
+	l3->free_objects -= cc->avail;
 	spin_unlock(&cachep->spinlock);
 
 	if (unlikely(!cc->avail)) {
@@ -1513,6 +1611,7 @@
 		if (!cc->avail)		// objects refilled by interrupt?
 			goto retry;
 	}
+	cc->touched = 1;
 	return cc_entry(cc)[--cc->avail];
 }
 
@@ -1566,6 +1665,7 @@
 	cc = cc_data(cachep);
 	if (likely(cc->avail)) {
 		STATS_INC_ALLOCHIT(cachep);
+		cc->touched = 1;
 		objp = cc_entry(cc)[--cc->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
@@ -1586,6 +1686,7 @@
 	check_irq_off();
 	spin_lock(&cachep->spinlock);
 	/* NUMA: move add into loop */
+	cachep->lists.free_objects += len;
 
 	for ( ; len > 0; len--, objpp++) {
 		slab_t* slabp;
@@ -1603,7 +1704,8 @@
 	
 		/* fixup slab chains */
 		if (unlikely(!--slabp->inuse)) {
-			if (list_empty(&list3_data_ptr(cachep, objp)->slabs_free)) {
+			if (cachep->lists.free_objects > cachep->free_limit) {
+				cachep->lists.free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
 				list_add(&slabp->list,
@@ -1636,6 +1738,26 @@
 	check_irq_off();
 	__free_block(cachep, &cc_entry(cc)[0], batchcount);
 
+#if STATS
+	{
+		int i = 0;
+		struct list_head *p;
+
+		spin_lock(&cachep->spinlock);
+		p = list3_data(cachep)->slabs_free.next;
+		while (p != &(list3_data(cachep)->slabs_free)) {
+			slab_t *slabp;
+
+			slabp = list_entry(p, slab_t, list);
+			BUG_ON(slabp->inuse);
+
+			i++;
+			p = p->next;
+		}
+		STATS_SET_FREEABLE(cachep, i);
+		spin_unlock(&cachep->spinlock);
+	}
+#endif
 	cc->avail -= batchcount;
 	memmove(&cc_entry(cc)[0], &cc_entry(cc)[batchcount],
 			sizeof(void*)*cc->avail);
@@ -1819,6 +1941,7 @@
 		ccnew->avail = 0;
 		ccnew->limit = limit;
 		ccnew->batchcount = batchcount;
+		ccnew->touched = 0;
 		new.new[i] = ccnew;
 	}
 	new.cachep = cachep;
@@ -1829,6 +1952,7 @@
 	spin_lock_irq(&cachep->spinlock);
 	cachep->batchcount = batchcount;
 	cachep->limit = limit;
+	cachep->free_limit = (1+num_online_cpus())*cachep->batchcount + cachep->num;
 	spin_unlock_irq(&cachep->spinlock);
 
 	for (i = 0; i < NR_CPUS; i++) {
@@ -1866,121 +1990,100 @@
 
 /**
  * cache_reap - Reclaim memory from caches.
- * @gfp_mask: the type of memory required.
  *
- * Called from do_try_to_free_pages() and __alloc_pages()
+ * Called from a timer, every few seconds
+ * Purpuse:
+ * - clear the per-cpu caches
+ * - return freeable pages to gfp.
  */
-int cache_reap (int gfp_mask)
+static inline void cache_reap (void)
 {
-	slab_t *slabp;
-	kmem_cache_t *searchp;
-	kmem_cache_t *best_cachep;
-	unsigned int best_pages;
-	unsigned int best_len;
-	unsigned int scan;
-	int ret = 0;
+	struct list_head *walk;
 
-	if (gfp_mask & __GFP_WAIT)
-		down(&cache_chain_sem);
-	else
-		if (down_trylock(&cache_chain_sem))
-			return 0;
+#if DEBUG
+	BUG_ON(!in_interrupt());
+	BUG_ON(in_irq());
+#endif
+	read_lock(&cache_chain_lock);
 
-	scan = REAP_SCANLEN;
-	best_len = 0;
-	best_pages = 0;
-	best_cachep = NULL;
-	searchp = clock_searchp;
-	do {
-		unsigned int pages;
+	list_for_each(walk, &cache_chain) {
+		kmem_cache_t *searchp;
 		struct list_head* p;
-		unsigned int full_free;
+		int tofree;
+		cpucache_t *cc;
+		slab_t *slabp;
+
+		searchp = list_entry(walk, kmem_cache_t, next);
 
-		/* It's safe to test this without holding the cache-lock. */
 		if (searchp->flags & SLAB_NO_REAP)
 			goto next;
-		spin_lock_irq(&searchp->spinlock);
-		{
-			cpucache_t *cc = cc_data(searchp);
-			if (cc && cc->avail) {
-				__free_block(searchp, cc_entry(cc), cc->avail);
-				cc->avail = 0;
+
+		check_irq_on();
+		local_irq_disable();
+		cc = cc_data(searchp);
+		if (cc->touched) {
+			cc->touched = 0;
+		} else if (cc->avail) {
+			tofree = (cc->limit+4)/5;
+			if (tofree > cc->avail) {
+				tofree = (cc->avail+1)/2;
 			}
+			free_block(searchp, cc_entry(cc), tofree);
+			cc->avail -= tofree;
+			memmove(&cc_entry(cc)[0], &cc_entry(cc)[tofree],
+					sizeof(void*)*cc->avail);
 		}
+		if(time_after(searchp->lists.next_reap, jiffies))
+			goto next_irqon;
 
-		full_free = 0;
-		p = searchp->lists.slabs_free.next;
-		while (p != &searchp->lists.slabs_free) {
-			slabp = list_entry(p, slab_t, list);
-#if DEBUG
-			if (slabp->inuse)
-				BUG();
-#endif
-			full_free++;
-			p = p->next;
+		spin_lock(&searchp->spinlock);
+		if(time_after(searchp->lists.next_reap, jiffies)) {
+			goto next_unlock;
 		}
-
-		/*
-		 * Try to avoid slabs with constructors and/or
-		 * more than one page per slab (as it can be difficult
-		 * to get high orders from gfp()).
-		 */
-		pages = full_free * (1<<searchp->gfporder);
-		if (searchp->ctor)
-			pages = (pages*4+1)/5;
-		if (searchp->gfporder)
-			pages = (pages*4+1)/5;
-		if (pages > best_pages) {
-			best_cachep = searchp;
-			best_len = full_free;
-			best_pages = pages;
-			if (pages >= REAP_PERFECT) {
-				clock_searchp = list_entry(searchp->next.next,
-							kmem_cache_t,next);
-				goto perfect;
-			}
+		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
+		if (searchp->lists.free_touched) {
+			searchp->lists.free_touched = 0;
+			goto next_unlock;
 		}
-		spin_unlock_irq(&searchp->spinlock);
-next:
-		searchp = list_entry(searchp->next.next,kmem_cache_t,next);
-	} while (--scan && searchp != clock_searchp);
 
-	clock_searchp = searchp;
+		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
+		do {
+			p = list3_data(searchp)->slabs_free.next;
+			if (p == &(list3_data(searchp)->slabs_free))
+				break;
 
-	if (!best_cachep)
-		/* couldn't find anything to reap */
-		goto out;
-
-	spin_lock_irq(&best_cachep->spinlock);
-perfect:
-	/* free only 50% of the free slabs */
-	best_len = (best_len + 1)/2;
-	for (scan = 0; scan < best_len; scan++) {
-		struct list_head *p;
+			slabp = list_entry(p, slab_t, list);
+			BUG_ON(slabp->inuse);
+			list_del(&slabp->list);
+			STATS_INC_REAPED(searchp);
+
+			/* Safe to drop the lock. The slab is no longer
+			 * linked to the cache.
+			 * searchp cannot disappear, we hold
+			 * cache_chain_lock
+			 */
+			searchp->lists.free_objects -= searchp->num;
+			spin_unlock_irq(&searchp->spinlock);
+			slab_destroy(searchp, slabp);
+			spin_lock_irq(&searchp->spinlock);
+		} while(--tofree > 0);
+next_unlock:
+		spin_unlock(&searchp->spinlock);
+next_irqon:
+		local_irq_enable();
+next:
+	}
+	check_irq_on();
 
-		p = best_cachep->lists.slabs_free.prev;
-		if (p == &best_cachep->lists.slabs_free)
-			break;
-		slabp = list_entry(p,slab_t,list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
-		list_del(&slabp->list);
-		STATS_INC_REAPED(best_cachep);
+	read_unlock(&cache_chain_lock);
+}
 
-		/* Safe to drop the lock. The slab is no longer linked to the
-		 * cache.
-		 */
-		spin_unlock_irq(&best_cachep->spinlock);
-		slab_destroy(best_cachep, slabp);
-		spin_lock_irq(&best_cachep->spinlock);
-	}
-	spin_unlock_irq(&best_cachep->spinlock);
-	ret = scan * (1 << best_cachep->gfporder);
-out:
-	up(&cache_chain_sem);
-	return ret;
+static void reap_timer_fnc(unsigned long data)
+{
+	cache_reap();
+
+	reap_timer[smp_processor_id()].expires = jiffies + REAPTIMEOUT_CPUC;
+	add_timer(&reap_timer[smp_processor_id()]);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -2033,11 +2136,10 @@
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
-		seq_puts(m, "slabinfo - version: 1.1"
+		seq_puts(m, "slabinfo - version: 1.2"
 #if STATS
 				" (statistics)"
 #endif
-				" (SMP)"
 				"\n");
 		return 0;
 	}
@@ -2067,6 +2169,7 @@
 	}
 	num_slabs+=active_slabs;
 	num_objs = num_slabs*cachep->num;
+	BUG_ON(num_objs - active_objs != cachep->lists.free_objects);
 
 	name = cachep->name; 
 	{
@@ -2084,34 +2187,27 @@
 		name, active_objs, num_objs, cachep->objsize,
 		active_slabs, num_slabs, (1<<cachep->gfporder));
 
+	seq_printf(m, " : %4u %4u", cachep->limit, cachep->batchcount);
 #if STATS
-	{
-		unsigned long errors = cachep->errors;
+	{	// list3 stats
 		unsigned long high = cachep->high_mark;
+		unsigned long allocs = cachep->num_allocations;
 		unsigned long grown = cachep->grown;
 		unsigned long reaped = cachep->reaped;
-		unsigned long allocs = cachep->num_allocations;
-
-		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu",
-				high, allocs, grown, reaped, errors);
-	}
-#endif
-	{
-		unsigned int batchcount = cachep->batchcount;
-		unsigned int limit;
+		unsigned long errors = cachep->errors;
+		unsigned long max_freeable = cachep->max_freeable;
+		unsigned long free_limit = cachep->free_limit;
 
-		if (cc_data(cachep))
-			limit = cc_data(cachep)->limit;
-		 else
-			limit = 0;
-		seq_printf(m, " : %4u %4u", limit, batchcount);
+		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu %4lu %4lu",
+				high, allocs, grown, reaped, errors, 
+				max_freeable, free_limit);
 	}
-#if STATS
-	{
+	{	// cpucache stats
 		unsigned long allochit = atomic_read(&cachep->allochit);
 		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
 		unsigned long freehit = atomic_read(&cachep->freehit);
 		unsigned long freemiss = atomic_read(&cachep->freemiss);
+
 		seq_printf(m, " : %6lu %6lu %6lu %6lu",
 				allochit, allocmiss, freehit, freemiss);
 	}

--------------040509060808090805030602--


