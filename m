Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263248AbSJCMVV>; Thu, 3 Oct 2002 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbSJCMVV>; Thu, 3 Oct 2002 08:21:21 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:23216 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263248AbSJCMUn>;
	Thu, 3 Oct 2002 08:20:43 -0400
Message-ID: <3D9C3763.5090203@colorfullife.com>
Date: Thu, 03 Oct 2002 14:26:11 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [CFT] slab cleanup
Content-Type: multipart/mixed;
 boundary="------------030806000803050005000207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806000803050005000207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've performed a larger modification of slab.c, as a preparation for 
NUMA awareness.

Could you please test it? Especially SMP, or non-x86 platforms would be 
interesting.

A kernprof profile, with function counts, for several loads would be 
great, but I don't know if kernprof works with recent 2.5 kernels.

With slab debugging enabled, it's possible to measure the efficiency of 
the headarrays: The block after the last ":" list the hits/misses:

names_cache  [snip] : 262924    118 263042      0

262924 times kmem_cache_alloc(names_cache) found an object in the 
headarray, only 118 times it had to go back into the slab lists.
263042 times kmem_cache_free(names_cache) could store an object directly 
in the per-cpu array, it never had to flush the array. Note that 
additional flushing can happen in a timer, which is not counted right now.

The patch is against 2.5.40. It relies on Ingo's smptimers.

Changes:
- always enable head arrays, right now they are SMP only.
- make the per-cpu arrays strictly LIFO.
- move slabs during kmem_cache_free to the end of the partial
	list, that should reduce the internal fragmentation.
- smp_call_function() doesn't break disable_irq() anymore,
	remove the workarounds that were necessary.
- Add head arrays to all caches, remove the  fallback to no-headarray.
- Add a dynamic limit to the lengh of the free list
- Do not flush headarrays if they were recently accessed.
- Do not flush free slabs, if the free slab list was recently
	accessed.
- Remove the GROWN flag: activity matters, not when the cache
	was grown last.
- flush free list and head array in a per-cpu timer
- remove kmem_ from slab internal functions.
- poison all objects, even objects with constructors
- add further debug checks [wrong interrupt flags, might_sleep]

--
	Manfred

--------------030806000803050005000207
Content-Type: text/plain;
 name="patch-slab-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-2"

--- 2.5/mm/slab.c	Tue Oct  1 23:28:02 2002
+++ build-2.5/mm/slab.c	Thu Oct  3 11:59:27 2002
@@ -8,6 +8,9 @@
  * Major cleanup, different bufctl logic, per-cpu arrays
  *	(c) 2000 Manfred Spraul
  *
+ * Cleanup, make the head arrays unconditional, preparation for NUMA
+ * 	(c) 2002 Manfred Spraul
+ *
  * An implementation of the Slab Allocator as described in outline in;
  *	UNIX Internals: The New Frontiers by Uresh Vahalia
  *	Pub: Prentice Hall	ISBN 0-13-101908-2
@@ -16,7 +19,6 @@
  *	Jeff Bonwick (Sun Microsystems).
  *	Presented at: USENIX Summer 1994 Technical Conference
  *
- *
  * The memory is organized in caches, one cache for each object type.
  * (e.g. inode_cache, dentry_cache, buffer_head, vm_area_struct)
  * Each cache consists out of many slabs (they are small (usually one
@@ -38,12 +40,14 @@
  * kmem_cache_destroy() CAN CRASH if you try to allocate from the cache
  * during kmem_cache_destroy(). The caller must prevent concurrent allocs.
  *
- * On SMP systems, each cache has a short per-cpu head array, most allocs
+ * Each cache has a short per-cpu head array, most allocs
  * and frees go into that array, and if that array overflows, then 1/2
  * of the entries in the array are given back into the global cache.
- * This reduces the number of spinlock operations.
+ * The head array is strictly LIFO and should improve the cache hit rates.
+ * On SMP, it additionally reduces the spinlock operations.
  *
- * The c_cpuarray may not be read with enabled local interrupts.
+ * The c_cpuarray may not be read with enabled local interrupts - 
+ * it's changed with a smp_call_function().
  *
  * SMP synchronization:
  *  constructors and destructors are called without any locking.
@@ -53,6 +57,10 @@
  *  	and local interrupts are disabled so slab code is preempt-safe.
  *  The non-constant members are protected with a per-cache irq spinlock.
  *
+ * Many thanks to Mark Hemment, who wrote another per-cpu slab patch
+ * in 2000 - many ideas in the current implementation are derived from
+ * his patch.
+ *
  * Further notes from the original documentation:
  *
  * 11 April '97.  Started multi-threading - markhe
@@ -61,10 +69,6 @@
  *	can never happen inside an interrupt (kmem_cache_create(),
  *	kmem_cache_shrink() and kmem_cache_reap()).
  *
- *	To prevent kmem_cache_shrink() trying to shrink a 'growing' cache (which
- *	maybe be sleeping and therefore not holding the semaphore/lock), the
- *	growing field is used.  This also prevents reaping from a cache.
- *
  *	At present, each engine can be growing a cache.  This should be blocked.
  *
  */
@@ -77,6 +81,7 @@
 #include	<linux/init.h>
 #include	<linux/compiler.h>
 #include	<linux/seq_file.h>
+#include	<linux/notifier.h>
 #include	<asm/uaccess.h>
 
 /*
@@ -100,11 +105,8 @@
 #define	FORCED_DEBUG	0
 #endif
 
-/*
- * Parameters for kmem_cache_reap
- */
-#define REAP_SCANLEN	10
-#define REAP_PERFECT	10
+
+static unsigned long g_cache_count;
 
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
@@ -144,7 +146,7 @@
 typedef unsigned int kmem_bufctl_t;
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.
- * Needed to avoid a possible looping condition in kmem_cache_grow().
+ * Needed to avoid a possible looping condition in cache_grow().
  */
 static unsigned long offslab_limit;
 
@@ -170,39 +172,96 @@
  * cpucache_t
  *
  * Per cpu structures
+ * Purpose:
+ * - LIFO ordering, to hand out cache-warm objects from _alloc
+ * - reduce spinlock operations
+ *
  * The limit is stored in the per-cpu structure to reduce the data cache
  * footprint.
+ * On NUMA systems, 2 per-cpu structures exist: one for the current
+ * node, one for wrong node free calls.
+ * Memory from the wrong node is never returned by alloc, it's returned
+ * to the home node as soon as the cpu cache is filled
+ *
  */
 typedef struct cpucache_s {
 	unsigned int avail;
 	unsigned int limit;
+	unsigned int batchcount;
+	unsigned int touched;
 } cpucache_t;
 
+/* bootstrap: The caches do not work without cpuarrays anymore,
+ * but the cpuarrays are allocated from the generic caches...
+ */
+#define BOOT_CPUCACHE_ENTRIES	1
+struct cpucache_int {
+	cpucache_t cache;
+	void * entries[BOOT_CPUCACHE_ENTRIES];
+};
+
 #define cc_entry(cpucache) \
 	((void **)(((cpucache_t*)(cpucache))+1))
 #define cc_data(cachep) \
 	((cachep)->cpudata[smp_processor_id()])
 /*
+ * NUMA: check if 'ptr' points into the current node,
+ * 	use the alternate cpudata cache if wrong
+ */
+#define cc_data_ptr(cachep, ptr) \
+		cc_data(cachep)
+
+/*
+ * The slab lists of all objects.
+ * They provide some aging, and hopefully reduce the 
+ * internal fragmentation
+ * TODO: The spinlock should be moved from the kmem_cache_t
+ * into this structure, too.
+ */
+struct kmem_list3 {
+	struct list_head	slabs_partial;	/* partial list first, better asm code */
+	struct list_head	slabs_full;
+	struct list_head	slabs_free;
+	unsigned long	free_objects;
+	int		free_touched;
+	unsigned long	next_reap;
+};
+
+#define LIST3_INIT(parent) \
+	{ \
+		.slabs_full	= LIST_HEAD_INIT(parent.slabs_full), \
+		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
+		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
+	}
+#define list3_data(cachep) \
+	(&(cachep)->lists)
+
+/* NUMA: per-node */
+#define list3_data_ptr(cachep, ptr) \
+		list3_data(cachep)
+
+/*
  * kmem_cache_t
  *
  * manages a cache.
  */
-
+	
 struct kmem_cache_s {
-/* 1) each alloc & free */
-	/* full, partial first, then free */
-	struct list_head	slabs_full;
-	struct list_head	slabs_partial;
-	struct list_head	slabs_free;
+/* 1) per-cpu data, touched during every alloc/free */
+	cpucache_t		*cpudata[NR_CPUS];
+	/* NUMA: cpucache_t	*cpudata_othernode[NR_CPUS]; */
+	unsigned int		batchcount;
+	unsigned int		limit;
+/* 2) touched by every alloc & free from the backend */
+	struct kmem_list3	lists;
+	/* NUMA: kmem_3list_t	*nodelists[NR_NODES] */
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
+	unsigned int		free_limit; /* upper limit of objects in the lists */
 	spinlock_t		spinlock;
-#ifdef CONFIG_SMP
-	unsigned int		batchcount;
-#endif
 
-/* 2) slab additions /removals */
+/* 3) cache_grow/shrink */
 	/* order of pgs per slab (2^n) */
 	unsigned int		gfporder;
 
@@ -213,7 +272,6 @@
 	unsigned int		colour_off;	/* colour offset */
 	unsigned int		colour_next;	/* cache colouring */
 	kmem_cache_t		*slabp_cache;
-	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
 
 	/* constructor func */
@@ -222,15 +280,11 @@
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
-	unsigned long		failures;
-
-/* 3) cache creation/removal */
+/* 4) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
-#ifdef CONFIG_SMP
-/* 4) per-cpu data */
-	cpucache_t		*cpudata[NR_CPUS];
-#endif
+
+/* 5) statistics */
 #if STATS
 	unsigned long		num_active;
 	unsigned long		num_allocations;
@@ -238,25 +292,28 @@
 	unsigned long		grown;
 	unsigned long		reaped;
 	unsigned long 		errors;
-#ifdef CONFIG_SMP
+	unsigned long		max_freeable;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
 	atomic_t		freemiss;
 #endif
-#endif
 };
 
 /* internal c_flags */
 #define	CFLGS_OFF_SLAB	0x010000UL	/* slab management in own cache */
-#define	CFLGS_OPTIMIZE	0x020000UL	/* optimized slab lookup */
-
-/* c_dflags (dynamic flags). Need to hold the spinlock to access this member */
-#define	DFLGS_GROWN	0x000001UL	/* don't reap a recently grown */
 
 #define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
-#define	OPTIMIZE(x)	((x)->flags & CFLGS_OPTIMIZE)
-#define	GROWN(x)	((x)->dlags & DFLGS_GROWN)
+
+#define BATCHREFILL_LIMIT	16
+/* Optimization question: fewer reaps means less 
+ * probability for unnessary cpucache drain/refill cycles.
+ *
+ * OTHO the cpuarrays can contain lots of objects,
+ * which could lock up otherwise freeable slabs.
+ */
+#define REAPTIMEOUT_CPUC	(2*HZ)
+#define REAPTIMEOUT_LIST3	(4*HZ)
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -268,6 +325,15 @@
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
@@ -276,18 +342,14 @@
 #define	STATS_INC_REAPED(x)	do { } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
-#endif
+#define	STATS_SET_FREEABLE(x, i) \
+				do { } while (0)
 
-#if STATS && defined(CONFIG_SMP)
-#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
-#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
-#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
-#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
-#else
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
 #define STATS_INC_FREEHIT(x)	do { } while (0)
 #define STATS_INC_FREEMISS(x)	do { } while (0)
+
 #endif
 
 #if DEBUG
@@ -382,11 +444,15 @@
 }; 
 #undef CN
 
+struct cpucache_int cpuarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
+struct cpucache_int cpuarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
+
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.slabs_full	= LIST_HEAD_INIT(cache_cache.slabs_full),
-	.slabs_partial	= LIST_HEAD_INIT(cache_cache.slabs_partial),
-	.slabs_free	= LIST_HEAD_INIT(cache_cache.slabs_free),
+	.lists		= LIST3_INIT(cache_cache.lists),
+	.cpudata	= { [0] = &cpuarray_cache.cache },
+	.batchcount	= 1,
+	.limit		= BOOT_CPUCACHE_ENTRIES,
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
@@ -396,25 +462,31 @@
 
 /* Guard access to the cache-chain. */
 static struct semaphore	cache_chain_sem;
+static rwlock_t cache_chain_lock = RW_LOCK_UNLOCKED;
 
 /* Place maintainer for reaping. */
-static kmem_cache_t *clock_searchp = &cache_cache;
+static kmem_cache_t *clock_searchp[NR_CPUS] = { [0 ... NR_CPUS -1] = &cache_cache};
 
 #define cache_chain (cache_cache.next)
 
-#ifdef CONFIG_SMP
 /*
  * chicken and egg problem: delay the per-cpu array allocation
  * until the general caches are up.
  */
-static int g_cpucache_up;
+enum {
+	NONE,
+	PARTIAL,
+	FULL
+} g_cpucache_up;
+
+static struct timer_list reap_timer[NR_CPUS];
+
+static void reap_timer_fnc(unsigned long data);
 
 static void enable_cpucache (kmem_cache_t *cachep);
-static void enable_all_cpucaches (void);
-#endif
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void kmem_cache_estimate (unsigned long gfporder, size_t size,
+static void cache_estimate (unsigned long gfporder, size_t size,
 		 int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
@@ -441,6 +513,110 @@
 	*left_over = wastage;
 }
 
+#ifdef CONFIG_SMP
+static void do_timerstart(void *arg)
+{
+	int cpu = smp_processor_id();
+	if (reap_timer[cpu].expires == 0) {
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
+/*
+ * CPU HOTPLUG: 
+ * This is racy.
+ *
+ * If an interrupt is scheduled to the new cpu, and that
+ * interrupt calls kmem_cache_alloc(), then it will oops.
+ */
+static int __devinit cpuup_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	int cpu = (int)hcpu;
+	if (action == CPU_ONLINE) {
+		struct list_head *p;
+		cpucache_t *nc;
+
+		down(&cache_chain_sem);
+
+		p = &cache_cache.next;
+		do {
+			int memsize;
+
+			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
+			memsize = sizeof(void*)*cachep->limit+sizeof(cpucache_t);
+			nc = kmalloc(memsize, GFP_KERNEL);
+			if (!nc)
+				goto bad;
+			nc->avail = 0;
+			nc->limit = cachep->limit;
+			nc->batchcount = cachep->batchcount;
+			nc->touched = 0;
+
+			cachep->cpudata[cpu] = nc;
+
+			p = cachep->next.next;
+		} while (p != &cache_cache.next);
+
+		if (g_cpucache_up == FULL)
+			do_cpucall(do_timerstart, NULL, cpu);
+		up(&cache_chain_sem);
+	}
+
+	return NOTIFY_OK;
+bad:
+	up(&cache_chain_sem);
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
+#endif
+
 /* Initialisation - setup the `cache' cache. */
 void __init kmem_cache_init(void)
 {
@@ -449,13 +625,31 @@
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
 
-	kmem_cache_estimate(0, cache_cache.objsize, 0,
+	cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
+
+	g_cache_count = 1;
+
+#ifdef CONFIG_SMP
+	/* Register a cpu startup notifier callback
+	 * that initializes cc_data for all new cpus
+	 */
+	register_cpu_notifier(&cpucache_notifier);
+#endif
+	
+	/* 
+	 * Register the timer that return unneeded
+	 * pages to gfp.
+	 */
+	init_timer(&reap_timer[smp_processor_id()]);
+	reap_timer[smp_processor_id()].expires = jiffies + HZ;
+	reap_timer[smp_processor_id()].function = reap_timer_fnc;
+	add_timer(&reap_timer[smp_processor_id()]);
 }
 
 
@@ -465,6 +659,7 @@
 void __init kmem_cache_sizes_init(void)
 {
 	cache_sizes_t *sizes = cache_sizes;
+
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -497,14 +692,51 @@
 			BUG();
 		sizes++;
 	} while (sizes->cs_size);
+	/*
+	 * The generic caches are running - time to kick out the
+	 * bootstrap cpucaches.
+	 */
+	{
+		void * ptr;
+		
+		ptr = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+		local_irq_disable();
+		BUG_ON(cc_data(&cache_cache) != &cpuarray_cache.cache);
+		memcpy(ptr, cc_data(&cache_cache), sizeof(struct cpucache_int));
+		cc_data(&cache_cache) = ptr;
+		local_irq_enable();
+	
+		ptr = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+		local_irq_disable();
+		BUG_ON(cc_data(cache_sizes[0].cs_cachep) != &cpuarray_generic.cache);
+		memcpy(ptr, cc_data(cache_sizes[0].cs_cachep),
+				sizeof(struct cpucache_int));
+		cc_data(cache_sizes[0].cs_cachep) = ptr;
+		local_irq_enable();
+	}
 }
 
 int __init kmem_cpucache_init(void)
 {
-#ifdef CONFIG_SMP
-	g_cpucache_up = 1;
-	enable_all_cpucaches();
-#endif
+	struct list_head* p;
+	int i;
+
+	down(&cache_chain_sem);
+	g_cpucache_up = FULL;
+
+	p = &cache_cache.next;
+	do {
+		kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
+		enable_cpucache(cachep);
+		p = cachep->next.next;
+	} while (p != &cache_cache.next);
+
+	for (i=0;i<NR_CPUS;i++) {
+		if (cpu_online(i))
+			do_cpucall(do_timerstart, NULL, i);
+	}
+	up(&cache_chain_sem);
+
 	return 0;
 }
 
@@ -552,7 +784,7 @@
 }
 
 #if DEBUG
-static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
+static void poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -563,7 +795,7 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
+static int check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;
@@ -582,39 +814,36 @@
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
-static void kmem_slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
+static void slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
 {
-	if (cachep->dtor
 #if DEBUG
-		|| cachep->flags & (SLAB_POISON | SLAB_RED_ZONE)
-#endif
-	) {
+	int i;
+	for (i = 0; i < cachep->num; i++) {
+		void* objp = slabp->s_mem+cachep->objsize*i;
+		if (cachep->flags & SLAB_POISON)
+			check_poison_obj(cachep, objp);
+
+		if (cachep->flags & SLAB_RED_ZONE) {
+			if (*((unsigned long*)(objp)) != RED_MAGIC1)
+				BUG();
+			if (*((unsigned long*)(objp + cachep->objsize -
+					BYTES_PER_WORD)) != RED_MAGIC1)
+				BUG();
+			objp += BYTES_PER_WORD;
+		}
+		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
+			(cachep->dtor)(objp, cachep, 0);
+	}
+#else
+	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
 			void* objp = slabp->s_mem+cachep->objsize*i;
-#if DEBUG
-			if (cachep->flags & SLAB_RED_ZONE) {
-				if (*((unsigned long*)(objp)) != RED_MAGIC1)
-					BUG();
-				if (*((unsigned long*)(objp + cachep->objsize
-						-BYTES_PER_WORD)) != RED_MAGIC1)
-					BUG();
-				objp += BYTES_PER_WORD;
-			}
-#endif
-			if (cachep->dtor)
-				(cachep->dtor)(objp, cachep, 0);
-#if DEBUG
-			if (cachep->flags & SLAB_RED_ZONE) {
-				objp -= BYTES_PER_WORD;
-			}	
-			if ((cachep->flags & SLAB_POISON)  &&
-				kmem_check_poison_obj(cachep, objp))
-				BUG();
-#endif
+			(cachep->dtor)(objp, cachep, 0);
 		}
 	}
-
+#endif
+	
 	kmem_freepages(cachep, slabp->s_mem-slabp->colouroff);
 	if (OFF_SLAB(cachep))
 		kmem_cache_free(cachep->slabp_cache, slabp);
@@ -701,8 +930,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
@@ -745,7 +973,6 @@
 	if (flags & SLAB_HWCACHE_ALIGN) {
 		/* Need to adjust size so that objs are cache aligned. */
 		/* Small obj size, can get at least two per cache line. */
-		/* FIXME: only power of 2 supported, was better */
 		while (size < align/2)
 			align /= 2;
 		size = (size+align-1)&(~(align-1));
@@ -759,7 +986,7 @@
 	do {
 		unsigned int break_flag = 0;
 cal_wastage:
-		kmem_cache_estimate(cachep->gfporder, size, flags,
+		cache_estimate(cachep->gfporder, size, flags,
 						&left_over, &cachep->num);
 		if (break_flag)
 			break;
@@ -812,19 +1039,16 @@
 	cachep->colour_off = offset;
 	cachep->colour = left_over/offset;
 
-	/* init remaining fields */
-	if (!cachep->gfporder && !(flags & CFLGS_OFF_SLAB))
-		flags |= CFLGS_OPTIMIZE;
-
 	cachep->flags = flags;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	INIT_LIST_HEAD(&cachep->slabs_full);
-	INIT_LIST_HEAD(&cachep->slabs_partial);
-	INIT_LIST_HEAD(&cachep->slabs_free);
+	/* NUMA */
+	INIT_LIST_HEAD(&cachep->lists.slabs_full);
+	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
+	INIT_LIST_HEAD(&cachep->lists.slabs_free);
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -832,10 +1056,32 @@
 	cachep->dtor = dtor;
 	cachep->name = name;
 
-#ifdef CONFIG_SMP
-	if (g_cpucache_up)
+	if (g_cpucache_up == FULL) {
 		enable_cpucache(cachep);
-#endif
+	} else {
+		if (g_cpucache_up == NONE) {
+			/* Note: the first kmem_cache_create must create
+			 * the cache that's used by kmalloc(24), otherwise
+			 * the creation of further caches will BUG().
+			 */
+			cc_data(cachep) = &cpuarray_generic.cache;
+			g_cpucache_up = PARTIAL;
+		} else {
+			cc_data(cachep) = kmalloc(sizeof(struct cpucache_int),GFP_KERNEL);
+		}
+		BUG_ON(!cc_data(cachep));
+		cc_data(cachep)->avail = 0;
+		cc_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
+		cc_data(cachep)->batchcount = 1;
+		cc_data(cachep)->touched = 0;
+		cachep->batchcount = 1;
+		cachep->limit = BOOT_CPUCACHE_ENTRIES;
+		cachep->free_limit = (1+NR_CPUS)*cachep->batchcount + cachep->num;
+	} 
+
+	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
+					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
 	{
@@ -864,130 +1110,62 @@
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
+	g_cache_count++;
 opps:
 	return cachep;
 }
 
+static void drain_cpu_caches(kmem_cache_t *cachep);
 
-#if DEBUG
-/*
- * This check if the kmem_cache_t pointer is chained in the cache_cache
- * list. -arca
- */
-static int is_chained_kmem_cache(kmem_cache_t * cachep)
+static inline void check_irq_off(void)
 {
-	struct list_head *p;
-	int ret = 0;
-
-	/* Find the cache in the chain of caches. */
-	down(&cache_chain_sem);
-	list_for_each(p, &cache_chain) {
-		if (p == &cachep->next) {
-			ret = 1;
-			break;
-		}
-	}
-	up(&cache_chain_sem);
-
-	return ret;
-}
-#else
-#define is_chained_kmem_cache(x) 1
+#if DEBUG
+	BUG_ON(!irqs_disabled());
 #endif
-
-#ifdef CONFIG_SMP
-/*
- * Waits for all CPUs to execute func().
- */
-static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
-{
-	local_irq_disable();
-	func(arg);
-	local_irq_enable();
-
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
-}
-typedef struct ccupdate_struct_s
-{
-	kmem_cache_t *cachep;
-	cpucache_t *new[NR_CPUS];
-} ccupdate_struct_t;
-
-static void do_ccupdate_local(void *info)
-{
-	ccupdate_struct_t *new = (ccupdate_struct_t *)info;
-	cpucache_t *old = cc_data(new->cachep);
-	
-	cc_data(new->cachep) = new->new[smp_processor_id()];
-	new->new[smp_processor_id()] = old;
 }
 
-static void free_block (kmem_cache_t* cachep, void** objpp, int len);
-
-static void drain_cpu_caches(kmem_cache_t *cachep)
+static inline void check_irq_on(void)
 {
-	ccupdate_struct_t new;
-	int i;
-
-	memset(&new.new,0,sizeof(new.new));
-
-	new.cachep = cachep;
-
-	down(&cache_chain_sem);
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		cpucache_t* ccold = new.new[i];
-		if (!ccold || (ccold->avail == 0))
-			continue;
-		local_irq_disable();
-		free_block(cachep, cc_entry(ccold), ccold->avail);
-		local_irq_enable();
-		ccold->avail = 0;
-	}
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-	up(&cache_chain_sem);
+#if DEBUG
+	BUG_ON(irqs_disabled());
+#endif
 }
 
-#else
-#define drain_cpu_caches(cachep)	do { } while (0)
-#endif
 
-static int __kmem_cache_shrink(kmem_cache_t *cachep)
+/* NUMA shrink all list3s */
+static int __cache_shrink(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
 	int ret;
 
 	drain_cpu_caches(cachep);
 
+	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 
-	/* If the cache is growing, stop shrinking. */
-	while (!cachep->growing) {
+	for(;;) {
 		struct list_head *p;
 
-		p = cachep->slabs_free.prev;
-		if (p == &cachep->slabs_free)
+		p = cachep->lists.slabs_free.prev;
+		if (p == &cachep->lists.slabs_free)
 			break;
 
-		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
+		slabp = list_entry(cachep->lists.slabs_free.prev, slab_t, list);
+		BUG_ON(slabp->inuse);
 		list_del(&slabp->list);
 
+		cachep->lists.free_objects -= cachep->num;
 		spin_unlock_irq(&cachep->spinlock);
-		kmem_slab_destroy(cachep, slabp);
+		slab_destroy(cachep, slabp);
 		spin_lock_irq(&cachep->spinlock);
 	}
-	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
+	ret = !list_empty(&cachep->lists.slabs_full) ||
+		!list_empty(&cachep->lists.slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
@@ -1001,10 +1179,9 @@
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	if (!cachep || in_interrupt() || !is_chained_kmem_cache(cachep))
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
-	return __kmem_cache_shrink(cachep);
+	return __cache_shrink(cachep);
 }
 
 /**
@@ -1024,40 +1201,46 @@
  */
 int kmem_cache_destroy (kmem_cache_t * cachep)
 {
-	if (!cachep || in_interrupt() || cachep->growing)
-		BUG();
+	int i;
+	BUG_ON(!cachep || in_interrupt());
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
 	/* the chain is never empty, cache_cache is never destroyed */
-	if (clock_searchp == cachep)
-		clock_searchp = list_entry(cachep->next.next,
-						kmem_cache_t, next);
+	write_lock_bh(&cache_chain_lock);
+	for (i=0;i<NR_CPUS;i++) {
+		if (clock_searchp[i] == cachep)
+			clock_searchp[i] = list_entry(cachep->next.next,
+							kmem_cache_t, next);
+	}
 	list_del(&cachep->next);
+	write_unlock_bh(&cache_chain_lock);
 	up(&cache_chain_sem);
 
-	if (__kmem_cache_shrink(cachep)) {
+	if (__cache_shrink(cachep)) {
 		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
 		       cachep);
 		down(&cache_chain_sem);
+		write_lock_bh(&cache_chain_lock);
 		list_add(&cachep->next,&cache_chain);
+		write_unlock_bh(&cache_chain_lock);
 		up(&cache_chain_sem);
 		return 1;
 	}
-#ifdef CONFIG_SMP
 	{
 		int i;
 		for (i = 0; i < NR_CPUS; i++)
 			kfree(cachep->cpudata[i]);
+		/* NUMA: free the list3 structures */
 	}
-#endif
 	kmem_cache_free(&cache_cache, cachep);
+	g_cache_count--;
 
 	return 0;
 }
 
 /* Get the memory for a slab management obj. */
-static inline slab_t * kmem_cache_slabmgmt (kmem_cache_t *cachep,
+static inline slab_t * cache_slabmgmt (kmem_cache_t *cachep,
 			void *objp, int colour_off, int local_flags)
 {
 	slab_t *slabp;
@@ -1068,10 +1251,6 @@
 		if (!slabp)
 			return NULL;
 	} else {
-		/* FIXME: change to
-			slabp = objp
-		 * if you enable OPTIMIZE
-		 */
 		slabp = objp+colour_off;
 		colour_off += L1_CACHE_ALIGN(cachep->num *
 				sizeof(kmem_bufctl_t) + sizeof(slab_t));
@@ -1083,7 +1262,7 @@
 	return slabp;
 }
 
-static inline void kmem_cache_init_objs (kmem_cache_t * cachep,
+static inline void cache_init_objs (kmem_cache_t * cachep,
 			slab_t * slabp, unsigned long ctor_flags)
 {
 	int i;
@@ -1091,34 +1270,30 @@
 	for (i = 0; i < cachep->num; i++) {
 		void* objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
+		/* need to poison the objs? */
+		if (cachep->flags & SLAB_POISON)
+			poison_obj(cachep, objp);
+
 		if (cachep->flags & SLAB_RED_ZONE) {
 			*((unsigned long*)(objp)) = RED_MAGIC1;
 			*((unsigned long*)(objp + cachep->objsize -
 					BYTES_PER_WORD)) = RED_MAGIC1;
 			objp += BYTES_PER_WORD;
 		}
-#endif
-
-		/*
-		 * Constructors are not allowed to allocate memory from
-		 * the same cache which they are a constructor for.
-		 * Otherwise, deadlock. They must also be threaded.
-		 */
-		if (cachep->ctor)
+		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
 			cachep->ctor(objp, cachep, ctor_flags);
-#if DEBUG
-		if (cachep->flags & SLAB_RED_ZONE)
-			objp -= BYTES_PER_WORD;
-		if (cachep->flags & SLAB_POISON)
-			/* need to poison the objs */
-			kmem_poison_obj(cachep, objp);
+
 		if (cachep->flags & SLAB_RED_ZONE) {
+			objp -= BYTES_PER_WORD;
 			if (*((unsigned long*)(objp)) != RED_MAGIC1)
 				BUG();
 			if (*((unsigned long*)(objp + cachep->objsize -
 					BYTES_PER_WORD)) != RED_MAGIC1)
 				BUG();
 		}
+#else
+		if (cachep->ctor)
+			cachep->ctor(objp, cachep, ctor_flags);
 #endif
 		slab_bufctl(slabp)[i] = i+1;
 	}
@@ -1126,11 +1301,27 @@
 	slabp->free = 0;
 }
 
-/*
- * Grow (by 1) the number of slabs within a cache.  This is called by
+static void kmem_flagcheck(kmem_cache_t *cachep, int flags)
+{
+#if DEBUG
+	if (flags & __GFP_WAIT)
+		might_sleep();
+
+	if (flags & SLAB_DMA) {
+		if (!(cachep->gfpflags & GFP_DMA))
+			BUG();
+	} else {
+		if (cachep->gfpflags & GFP_DMA)
+			BUG();
+	}
+#endif
+}
+
+/*
+ * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int kmem_cache_grow (kmem_cache_t * cachep, int flags)
+static int cache_grow (kmem_cache_t * cachep, int flags)
 {
 	slab_t	*slabp;
 	struct page	*page;
@@ -1138,7 +1329,6 @@
 	size_t		 offset;
 	unsigned int	 i, local_flags;
 	unsigned long	 ctor_flags;
-	unsigned long	 save_flags;
 
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -1148,15 +1338,6 @@
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
-	/*
-	 * The test for missing atomic flag is performed here, rather than
-	 * the more obvious place, simply to reduce the critical path length
-	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
-	 * will eventually be caught here (where it matters).
-	 */
-	if (in_interrupt() && (flags & __GFP_WAIT))
-		BUG();
-
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 	local_flags = (flags & SLAB_LEVEL_MASK);
 	if (!(local_flags & __GFP_WAIT))
@@ -1167,7 +1348,8 @@
 		ctor_flags |= SLAB_CTOR_ATOMIC;
 
 	/* About to mess with non-constant members - lock. */
-	spin_lock_irqsave(&cachep->spinlock, save_flags);
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
 
 	/* Get colour for the slab, and cal the next value. */
 	offset = cachep->colour_next;
@@ -1175,26 +1357,27 @@
 	if (cachep->colour_next >= cachep->colour)
 		cachep->colour_next = 0;
 	offset *= cachep->colour_off;
-	cachep->dflags |= DFLGS_GROWN;
 
-	cachep->growing++;
-	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
+	spin_unlock(&cachep->spinlock);
+
+	if (local_flags & __GFP_WAIT)
+		local_irq_enable();
 
-	/* A series of memory allocations for a new slab.
-	 * Neither the cache-chain semaphore, or cache-lock, are
-	 * held, but the incrementing c_growing prevents this
-	 * cache from being reaped or shrunk.
-	 * Note: The cache could be selected in for reaping in
-	 * kmem_cache_reap(), but when the final test is made the
-	 * growing value will be seen.
+	/*
+	 * The test for missing atomic flag is performed here, rather than
+	 * the more obvious place, simply to reduce the critical path length
+	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
+	 * will eventually be caught here (where it matters).
 	 */
+	kmem_flagcheck(cachep, flags);
+
 
 	/* Get mem for the objs. */
 	if (!(objp = kmem_getpages(cachep, flags)))
 		goto failed;
 
 	/* Get slab management. */
-	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
+	if (!(slabp = cache_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
 
 	/* Nasty!!!!!! I hope this is OK. */
@@ -1208,67 +1391,113 @@
 		page++;
 	} while (--i);
 
-	kmem_cache_init_objs(cachep, slabp, ctor_flags);
+	cache_init_objs(cachep, slabp, ctor_flags);
 
-	spin_lock_irqsave(&cachep->spinlock, save_flags);
-	cachep->growing--;
+	if (local_flags & __GFP_WAIT)
+		local_irq_disable();
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list, &cachep->slabs_free);
+	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
 	STATS_INC_GROWN(cachep);
-	cachep->failures = 0;
-
-	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
+	list3_data(cachep)->free_objects += cachep->num;
+	spin_unlock(&cachep->spinlock);
 	return 1;
 opps1:
 	kmem_freepages(cachep, objp);
 failed:
-	spin_lock_irqsave(&cachep->spinlock, save_flags);
-	cachep->growing--;
-	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
 	return 0;
 }
 
 /*
  * Perform extra freeing checks:
- * - detect double free
  * - detect bad pointers.
- * Called with the cache-lock held.
+ * - POISON/RED_ZONE checking
+ * - destructor calls, for caches with POISON+dtor
  */
-
-#if DEBUG
-static int kmem_extra_free_checks (kmem_cache_t * cachep,
-			slab_t *slabp, void * objp)
+static inline void kfree_debugcheck(const void *objp)
 {
-	int i;
-	unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
+#if DEBUG
+	struct page *page;
 
-	if (objnr >= cachep->num)
-		BUG();
-	if (objp != slabp->s_mem + objnr*cachep->objsize)
+	if (!virt_addr_valid(objp)) {
+		printk(KERN_ERR "kfree_debugcheck: out of range ptr %lxh.\n",
+			(unsigned long)objp);	
+		BUG();	
+	}
+	page = virt_to_page(objp);
+	if (!PageSlab(page)) {
+		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n", (unsigned long)objp);
 		BUG();
-
-	/* Check slab's freelist to see if this obj is there. */
-	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
-		if (i == objnr)
-			BUG();
 	}
-	return 0;
+#endif 
 }
-#endif
 
-static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
+static inline void *cache_free_debugcheck (kmem_cache_t * cachep, void * objp)
 {
-	if (flags & SLAB_DMA) {
-		if (!(cachep->gfpflags & GFP_DMA))
+#if DEBUG
+	struct page *page;
+	unsigned int objnr;
+	slab_t *slabp;
+
+	kfree_debugcheck(objp);
+	page = virt_to_page(objp);
+
+	BUG_ON(GET_PAGE_CACHE(page) != cachep);
+	slabp = GET_PAGE_SLAB(page);
+
+	if (cachep->flags & SLAB_RED_ZONE) {
+		objp -= BYTES_PER_WORD;
+		if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
+			/* Either write before start, or a double free. */
 			BUG();
-	} else {
-		if (cachep->gfpflags & GFP_DMA)
+		if (xchg((unsigned long *)(objp+cachep->objsize -
+				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
+			/* Either write past end, or a double free. */
 			BUG();
 	}
+
+	objnr = (objp-slabp->s_mem)/cachep->objsize;
+
+	BUG_ON(objnr >= cachep->num);
+	BUG_ON(objp != slabp->s_mem + objnr*cachep->objsize);
+
+	if (cachep->flags & SLAB_DEBUG_INITIAL) {
+		/* Need to call the slab's constructor so the
+		 * caller can perform a verify of its state (debugging).
+		 * Called without the cache-lock held.
+		 */
+		cachep->ctor(objp, cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
+	}
+	if (cachep->flags & SLAB_POISON && cachep->dtor) {
+		/* we want to cache poison the object,
+		 * call the destruction callback
+		 */
+		cachep->dtor(objp, cachep, 0);
+	}
+	if (cachep->flags & SLAB_POISON) {
+		poison_obj(cachep, objp);
+	}
+#endif
+	return objp;
 }
 
-static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
+static inline void check_slabp(kmem_cache_t *cachep, slab_t *slabp)
+{
+#if DEBUG
+	int i;
+	int entries = 0;
+	/* Check slab's freelist to see if this obj is there. */
+	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
+		entries++;
+		BUG_ON(entries > cachep->num);
+	}
+	BUG_ON(entries != cachep->num - slabp->inuse);
+#endif
+}
+
+static inline void * cache_alloc_one_tail (kmem_cache_t *cachep,
 						slab_t *slabp)
 {
 	void *objp;
@@ -1282,13 +1511,95 @@
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
 	slabp->free=slab_bufctl(slabp)[slabp->free];
 
-	if (unlikely(slabp->free == BUFCTL_END)) {
-		list_del(&slabp->list);
-		list_add(&slabp->list, &cachep->slabs_full);
+	return objp;
+}
+
+static inline void cache_alloc_listfixup(struct kmem_list3 *l3, slab_t *slabp)
+{
+	list_del(&slabp->list);
+	if (slabp->free == BUFCTL_END) {
+		list_add(&slabp->list, &l3->slabs_full);
+	} else {
+		list_add(&slabp->list, &l3->slabs_partial);
+	}
+}
+
+static void* cache_alloc_refill(kmem_cache_t* cachep, int flags)
+{
+	int batchcount;
+	struct kmem_list3 *l3;
+	cpucache_t *cc;
+
+retry:
+	cc = cc_data(cachep);
+	batchcount = cc->batchcount;
+	if (!cc->touched && batchcount > BATCHREFILL_LIMIT) {
+		/* if there was little recent activity on this
+		 * cache, then perform only a partial refill.
+		 * Otherwise we could generate refill bouncing.
+		 */
+		batchcount = BATCHREFILL_LIMIT;
+	}
+	l3 = list3_data(cachep);
+
+	check_irq_off();
+	BUG_ON(cc->avail > 0);
+	spin_lock(&cachep->spinlock);
+	while (batchcount > 0) {
+		struct list_head *entry;
+		slab_t *slabp;
+		/* Get slab alloc is to come from. */
+		entry = l3->slabs_partial.next;
+		if (entry == &l3->slabs_partial) {
+			l3->free_touched = 1;
+			entry = l3->slabs_free.next;
+			if (entry == &l3->slabs_free)
+				goto must_grow;
+		}
+
+		slabp = list_entry(entry, slab_t, list);
+		check_slabp(cachep, slabp);
+		while (slabp->inuse < cachep->num && batchcount--)
+			cc_entry(cc)[cc->avail++] =
+				cache_alloc_one_tail(cachep, slabp);
+		check_slabp(cachep, slabp);
+		cache_alloc_listfixup(l3, slabp);
+	}
+
+must_grow:
+	l3->free_objects -= cc->avail;
+	spin_unlock(&cachep->spinlock);
+
+	if (unlikely(!cc->avail)) {
+		int x;
+		x = cache_grow(cachep, flags);
+		
+		// cache_grow can reenable interrupts, then cc could change.
+		cc = cc_data(cachep);
+		if (!x && cc->avail == 0)	// no objects in sight? abort
+			return NULL;
+
+		if (!cc->avail)		// objects refilled by interrupt?
+			goto retry;
 	}
+	cc->touched = 1;
+	return cc_entry(cc)[--cc->avail];
+}
+
+static inline void cache_alloc_debugcheck_before(kmem_cache_t *cachep, int flags)
+{
+#if DEBUG
+	kmem_flagcheck(cachep, flags);
+#endif
+}
+
+static inline void *cache_alloc_debugcheck_after (kmem_cache_t *cachep, unsigned long flags, void *objp)
+{
 #if DEBUG
+	if (!objp)	
+		return objp;
 	if (cachep->flags & SLAB_POISON)
-		if (kmem_check_poison_obj(cachep, objp))
+		if (check_poison_obj(cachep, objp))
 			BUG();
 	if (cachep->flags & SLAB_RED_ZONE) {
 		/* Set alloc red-zone, and check old one. */
@@ -1299,264 +1610,149 @@
 			  BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1)
 			BUG();
 		objp += BYTES_PER_WORD;
+		if (cachep->ctor) {
+			unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+
+			if (!flags & __GFP_WAIT)
+				ctor_flags |= SLAB_CTOR_ATOMIC;
+
+			cachep->ctor(objp, cachep, ctor_flags);
+		}	
 	}
 #endif
 	return objp;
 }
 
-/*
- * Returns a ptr to an obj in the given cache.
- * caller must guarantee synchronization
- * #define for the goto optimization 8-)
- */
-#define kmem_cache_alloc_one(cachep)				\
-({								\
-	struct list_head * slabs_partial, * entry;		\
-	slab_t *slabp;						\
-								\
-	slabs_partial = &(cachep)->slabs_partial;		\
-	entry = slabs_partial->next;				\
-	if (unlikely(entry == slabs_partial)) {			\
-		struct list_head * slabs_free;			\
-		slabs_free = &(cachep)->slabs_free;		\
-		entry = slabs_free->next;			\
-		if (unlikely(entry == slabs_free))		\
-			goto alloc_new_slab;			\
-		list_del(entry);				\
-		list_add(entry, slabs_partial);			\
-	}							\
-								\
-	slabp = list_entry(entry, slab_t, list);		\
-	kmem_cache_alloc_one_tail(cachep, slabp);		\
-})
 
-#ifdef CONFIG_SMP
-void* kmem_cache_alloc_batch(kmem_cache_t* cachep, int flags)
-{
-	int batchcount = cachep->batchcount;
-	cpucache_t* cc = cc_data(cachep);
-
-	spin_lock(&cachep->spinlock);
-	while (batchcount--) {
-		struct list_head * slabs_partial, * entry;
-		slab_t *slabp;
-		/* Get slab alloc is to come from. */
-		slabs_partial = &(cachep)->slabs_partial;
-		entry = slabs_partial->next;
-		if (unlikely(entry == slabs_partial)) {
-			struct list_head * slabs_free;
-			slabs_free = &(cachep)->slabs_free;
-			entry = slabs_free->next;
-			if (unlikely(entry == slabs_free))
-				break;
-			list_del(entry);
-			list_add(entry, slabs_partial);
-		}
-
-		slabp = list_entry(entry, slab_t, list);
-		cc_entry(cc)[cc->avail++] =
-				kmem_cache_alloc_one_tail(cachep, slabp);
-	}
-	spin_unlock(&cachep->spinlock);
-
-	if (cc->avail)
-		return cc_entry(cc)[--cc->avail];
-	return NULL;
-}
-#endif
-
-static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
+static inline void * __cache_alloc (kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
 	void* objp;
+	cpucache_t *cc;
 
-	if (flags & __GFP_WAIT)
-		might_sleep();
+	cache_alloc_debugcheck_before(cachep, flags);
 
-	kmem_cache_alloc_head(cachep, flags);
-try_again:
 	local_irq_save(save_flags);
-#ifdef CONFIG_SMP
-	{
-		cpucache_t *cc = cc_data(cachep);
-
-		if (cc) {
-			if (cc->avail) {
-				STATS_INC_ALLOCHIT(cachep);
-				objp = cc_entry(cc)[--cc->avail];
-			} else {
-				STATS_INC_ALLOCMISS(cachep);
-				objp = kmem_cache_alloc_batch(cachep,flags);
-				local_irq_restore(save_flags);
-				if (!objp)
-					goto alloc_new_slab_nolock;
-				return objp;
-			}
-		} else {
-			spin_lock(&cachep->spinlock);
-			objp = kmem_cache_alloc_one(cachep);
-			spin_unlock(&cachep->spinlock);
-		}
+	cc = cc_data(cachep);
+	if (likely(cc->avail)) {
+		STATS_INC_ALLOCHIT(cachep);
+		cc->touched = 1;
+		objp = cc_entry(cc)[--cc->avail];
+	} else {
+		STATS_INC_ALLOCMISS(cachep);
+		objp = cache_alloc_refill(cachep, flags);
 	}
-#else
-	objp = kmem_cache_alloc_one(cachep);
-#endif
 	local_irq_restore(save_flags);
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp);
 	return objp;
-alloc_new_slab:
-#ifdef CONFIG_SMP
-	spin_unlock(&cachep->spinlock);
-#endif
-	local_irq_restore(save_flags);
-#ifdef CONFIG_SMP
-alloc_new_slab_nolock:
-#endif
-	if (kmem_cache_grow(cachep, flags))
-		/* Someone may have stolen our objs.  Doesn't matter, we'll
-		 * just come back here again.
-		 */
-		goto try_again;
-	return NULL;
 }
 
-/*
- * Release an obj back to its cache. If the obj has a constructed
- * state, it should be in this state _before_ it is released.
- * - caller is responsible for the synchronization
+/* 
+ * NUMA: different approach needed if the spinlock is moved into
+ * the l3 structure
  */
 
-#if DEBUG
-# define CHECK_NR(pg)						\
-	do {							\
-		if (!virt_addr_valid(pg)) {			\
-			printk(KERN_ERR "kfree: out of range ptr %lxh.\n", \
-				(unsigned long)objp);		\
-			BUG();					\
-		} \
-	} while (0)
-# define CHECK_PAGE(addr)					\
-	do {							\
-		struct page *page = virt_to_page(addr);		\
-		CHECK_NR(addr);					\
-		if (!PageSlab(page)) {				\
-			printk(KERN_ERR "kfree: bad ptr %lxh.\n", \
-				(unsigned long)objp);		\
-			BUG();					\
-		}						\
-	} while (0)
-
-#else
-# define CHECK_PAGE(pg)	do { } while (0)
-#endif
-
-static inline void kmem_cache_free_one(kmem_cache_t *cachep, void *objp)
+static inline void __free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
-	slab_t* slabp;
+	/* NUMA: move add into loop */
+	cachep->lists.free_objects += len;
 
-	CHECK_PAGE(objp);
-	/* reduces memory footprint
-	 *
-	if (OPTIMIZE(cachep))
-		slabp = (void*)((unsigned long)objp&(~(PAGE_SIZE-1)));
-	 else
-	 */
-	slabp = GET_PAGE_SLAB(virt_to_page(objp));
+	for ( ; len > 0; len--, objpp++) {
+		slab_t* slabp;
+		void *objp = *objpp;
 
-#if DEBUG
-	if (cachep->flags & SLAB_DEBUG_INITIAL)
-		/* Need to call the slab's constructor so the
-		 * caller can perform a verify of its state (debugging).
-		 * Called without the cache-lock held.
-		 */
-		cachep->ctor(objp, cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
-
-	if (cachep->flags & SLAB_RED_ZONE) {
-		objp -= BYTES_PER_WORD;
-		if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
-			/* Either write before start, or a double free. */
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
-			/* Either write past end, or a double free. */
-			BUG();
-	}
-	if (cachep->flags & SLAB_POISON)
-		kmem_poison_obj(cachep, objp);
-	if (kmem_extra_free_checks(cachep, slabp, objp))
-		return;
-#endif
-	{
-		unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
+		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		list_del(&slabp->list);
+		{
+			unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
 
-		slab_bufctl(slabp)[objnr] = slabp->free;
-		slabp->free = objnr;
-	}
-	STATS_DEC_ACTIVE(cachep);
+			slab_bufctl(slabp)[objnr] = slabp->free;
+			slabp->free = objnr;
+		}
+		STATS_DEC_ACTIVE(cachep);
 	
-	/* fixup slab chains */
-	{
-		int inuse = slabp->inuse;
+		/* fixup slab chains */
 		if (unlikely(!--slabp->inuse)) {
-			/* Was partial or full, now empty. */
-			list_del(&slabp->list);
-			/* We only buffer a single page */
-			if (list_empty(&cachep->slabs_free))
-				list_add(&slabp->list, &cachep->slabs_free);
-			else
-				kmem_slab_destroy(cachep, slabp);
-		} else if (unlikely(inuse == cachep->num)) {
-			/* Was full. */
-			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_partial);
+			if (cachep->lists.free_objects > cachep->free_limit) {
+				cachep->lists.free_objects -= cachep->num;
+				slab_destroy(cachep, slabp);
+			} else {
+				list_add(&slabp->list,
+						&list3_data_ptr(cachep, objp)->slabs_free);
+			}
+		} else {
+			/* Unconditionally move a slab to the end of the
+			 * partial list on free - maximum time for the
+			 * other objects to be freed, too.
+			 */
+			list_add_tail(&slabp->list, &list3_data_ptr(cachep, objp)->slabs_partial);
 		}
 	}
 }
 
-#ifdef CONFIG_SMP
-static inline void __free_block (kmem_cache_t* cachep,
-							void** objpp, int len)
+static void free_block(kmem_cache_t* cachep, void** objpp, int len)
 {
-	for ( ; len > 0; len--, objpp++)
-		kmem_cache_free_one(cachep, *objpp);
+	__free_block(cachep, objpp, len);
 }
 
-static void free_block (kmem_cache_t* cachep, void** objpp, int len)
+static void cache_flusharray (kmem_cache_t* cachep, cpucache_t *cc)
 {
+	int batchcount;
+
+	batchcount = cc->batchcount;
+#if DEBUG
+	BUG_ON(!batchcount || batchcount > cc->avail);
+#endif
+	check_irq_off();
 	spin_lock(&cachep->spinlock);
-	__free_block(cachep, objpp, len);
+	__free_block(cachep, &cc_entry(cc)[0], batchcount);
+
+#if STATS
+	{
+		int i = 0;
+		struct list_head *p;
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
+	}
+#endif
+
 	spin_unlock(&cachep->spinlock);
+	cc->avail -= batchcount;
+	memmove(&cc_entry(cc)[0], &cc_entry(cc)[batchcount],
+			sizeof(void*)*cc->avail);
 }
-#endif
 
 /*
- * __kmem_cache_free
- * called with disabled ints
+ * __cache_free
+ * Release an obj back to its cache. If the obj has a constructed
+ * state, it must be in this state _before_ it is released.
+ *
+ * Called with disabled ints.
  */
-static inline void __kmem_cache_free (kmem_cache_t *cachep, void* objp)
+static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
-#ifdef CONFIG_SMP
-	cpucache_t *cc = cc_data(cachep);
+	cpucache_t *cc = cc_data_ptr(cachep, objp);
 
-	CHECK_PAGE(objp);
-	if (cc) {
-		int batchcount;
-		if (cc->avail < cc->limit) {
-			STATS_INC_FREEHIT(cachep);
-			cc_entry(cc)[cc->avail++] = objp;
-			return;
-		}
-		STATS_INC_FREEMISS(cachep);
-		batchcount = cachep->batchcount;
-		cc->avail -= batchcount;
-		free_block(cachep, &cc_entry(cc)[cc->avail], batchcount);
+	objp = cache_free_debugcheck(cachep, objp);
+
+	if (likely(cc->avail < cc->limit)) {
+		STATS_INC_FREEHIT(cachep);
 		cc_entry(cc)[cc->avail++] = objp;
 		return;
 	} else {
-		free_block(cachep, &objp, 1);
+		STATS_INC_FREEMISS(cachep);
+		cache_flusharray(cachep, cc);
+		cc_entry(cc)[cc->avail++] = objp;
 	}
-#else
-	kmem_cache_free_one(cachep, objp);
-#endif
 }
 
 /**
@@ -1569,7 +1765,7 @@
  */
 void * kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
-	return __kmem_cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags);
 }
 
 /**
@@ -1600,7 +1796,14 @@
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
+#if DEBUG
+		/* This happens if someone tries to call
+		 * kmem_cache_create(), or kmalloc(), before
+		 * the generic caches are initialized.
+		 */
+		BUG_ON(csizep->cs_cachep == NULL);
+#endif
+		return __cache_alloc(flags & GFP_DMA ?
 			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
 	}
 	return NULL;
@@ -1617,14 +1820,9 @@
 void kmem_cache_free (kmem_cache_t *cachep, void *objp)
 {
 	unsigned long flags;
-#if DEBUG
-	CHECK_PAGE(objp);
-	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
-		BUG();
-#endif
 
 	local_irq_save(flags);
-	__kmem_cache_free(cachep, objp);
+	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
 
@@ -1643,9 +1841,9 @@
 	if (!objp)
 		return;
 	local_irq_save(flags);
-	CHECK_PAGE(objp);
+	kfree_debugcheck(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
-	__kmem_cache_free(c, (void*)objp);
+	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }
 
@@ -1674,234 +1872,216 @@
 	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
 }
 
-#ifdef CONFIG_SMP
+/*
+ * Waits for all CPUs to execute func().
+ */
+static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
+{
+	local_irq_disable();
+	func(arg);
+	local_irq_enable();
+
+	if (smp_call_function(func, arg, 1, 1))
+		BUG();
+}
 
-/* called with cache_chain_sem acquired.  */
-static int kmem_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
+static void do_drain(void *arg)
 {
-	ccupdate_struct_t new;
-	int i;
+	kmem_cache_t *cachep = (kmem_cache_t*)arg;
+	cpucache_t *cc;
 
-	/*
-	 * These are admin-provided, so we are more graceful.
-	 */
-	if (limit < 0)
-		return -EINVAL;
-	if (batchcount < 0)
-		return -EINVAL;
-	if (batchcount > limit)
-		return -EINVAL;
-	if (limit != 0 && !batchcount)
-		return -EINVAL;
+	cc = cc_data(cachep);
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
+	__free_block(cachep, &cc_entry(cc)[0], cc->avail);
+	spin_unlock(&cachep->spinlock);
+	cc->avail = 0;
+}
+
+static void drain_cpu_caches(kmem_cache_t *cachep)
+{
+	smp_call_function_all_cpus(do_drain, cachep);
+}
+
+
+struct ccupdate_struct {
+	kmem_cache_t *cachep;
+	cpucache_t *new[NR_CPUS];
+};
+
+static void do_ccupdate_local(void *info)
+{
+	struct ccupdate_struct *new = (struct ccupdate_struct *)info;
+	cpucache_t *old;
+	old = cc_data(new->cachep);
+	
+	cc_data(new->cachep) = new->new[smp_processor_id()];
+	new->new[smp_processor_id()] = old;
+}
+
+
+static int do_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
+{
+	struct ccupdate_struct new;
+	int i;
 
 	memset(&new.new,0,sizeof(new.new));
-	if (limit) {
-		for (i = 0; i < NR_CPUS; i++) {
-			cpucache_t* ccnew;
-
-			ccnew = kmalloc(sizeof(void*)*limit+
-					sizeof(cpucache_t), GFP_KERNEL);
-			if (!ccnew) {
-				for (i--; i >= 0; i--) kfree(new.new[i]);
-				return -ENOMEM;
-			}
-			ccnew->limit = limit;
-			ccnew->avail = 0;
-			new.new[i] = ccnew;
+	for (i = 0; i < NR_CPUS; i++) {
+		cpucache_t* ccnew;
+
+		ccnew = kmalloc(sizeof(void*)*limit+
+				sizeof(cpucache_t), GFP_KERNEL);
+		if (!ccnew) {
+			for (i--; i >= 0; i--) kfree(new.new[i]);
+			return -ENOMEM;
 		}
+		ccnew->avail = 0;
+		ccnew->limit = limit;
+		ccnew->batchcount = batchcount;
+		ccnew->touched = 0;
+		new.new[i] = ccnew;
 	}
 	new.cachep = cachep;
+
+	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
+	
+	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	cachep->batchcount = batchcount;
+	cachep->limit = limit;
+	cachep->free_limit = (1+NR_CPUS)*cachep->batchcount + cachep->num;
 	spin_unlock_irq(&cachep->spinlock);
 
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-
 	for (i = 0; i < NR_CPUS; i++) {
 		cpucache_t* ccold = new.new[i];
 		if (!ccold)
 			continue;
 		local_irq_disable();
-		free_block(cachep, cc_entry(ccold), ccold->avail);
+		__free_block(cachep, cc_entry(ccold), ccold->avail);
 		local_irq_enable();
 		kfree(ccold);
 	}
 	return 0;
 }
 
-/* 
- * If slab debugging is enabled, don't batch slabs
- * on the per-cpu lists by defaults.
- */
+
 static void enable_cpucache (kmem_cache_t *cachep)
 {
-#ifndef CONFIG_DEBUG_SLAB
 	int err;
 	int limit;
 
-	/* FIXME: optimize */
 	if (cachep->objsize > PAGE_SIZE)
-		return;
-	if (cachep->objsize > 1024)
-		limit = 60;
+		limit = 8;
+	else if (cachep->objsize > 1024)
+		limit = 54;
 	else if (cachep->objsize > 256)
-		limit = 124;
+		limit = 120;
 	else
-		limit = 252;
+		limit = 248;
 
-	err = kmem_tune_cpucache(cachep, limit, limit/2);
+	err = do_tune_cpucache(cachep, limit, limit/2);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
 					cachep->name, -err);
-#endif
 }
 
-static void enable_all_cpucaches (void)
-{
-	struct list_head* p;
-
-	down(&cache_chain_sem);
-
-	p = &cache_cache.next;
-	do {
-		kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
-
-		enable_cpucache(cachep);
-		p = cachep->next.next;
-	} while (p != &cache_cache.next);
-
-	up(&cache_chain_sem);
-}
-#endif
+#define REAP_SCANLEN	10
 
 /**
- * kmem_cache_reap - Reclaim memory from caches.
- * @gfp_mask: the type of memory required.
+ * cache_reap - Reclaim memory from caches.
  *
- * Called from do_try_to_free_pages() and __alloc_pages()
+ * Called from a timer, 10 times/second.
+ * Purpuse:
+ * - clear the per-cpu caches
+ * - return freeable pages to gfp.
  */
-int kmem_cache_reap (int gfp_mask)
+static void cache_reap (void)
 {
-	slab_t *slabp;
+	int todo;
 	kmem_cache_t *searchp;
-	kmem_cache_t *best_cachep;
-	unsigned int best_pages;
-	unsigned int best_len;
-	unsigned int scan;
-	int ret = 0;
 
-	if (gfp_mask & __GFP_WAIT)
-		down(&cache_chain_sem);
-	else
-		if (down_trylock(&cache_chain_sem))
-			return 0;
+	read_lock(&cache_chain_lock);
+
+	todo = (g_cache_count+REAP_SCANLEN-1)/REAP_SCANLEN;
+	searchp = clock_searchp[smp_processor_id()];
 
-	scan = REAP_SCANLEN;
-	best_len = 0;
-	best_pages = 0;
-	best_cachep = NULL;
-	searchp = clock_searchp;
 	do {
-		unsigned int pages;
 		struct list_head* p;
-		unsigned int full_free;
+		int tofree;
+		cpucache_t *cc;
+		slab_t *slabp;
 
-		/* It's safe to test this without holding the cache-lock. */
 		if (searchp->flags & SLAB_NO_REAP)
 			goto next;
-		spin_lock_irq(&searchp->spinlock);
-		if (searchp->growing)
-			goto next_unlock;
-		if (searchp->dflags & DFLGS_GROWN) {
-			searchp->dflags &= ~DFLGS_GROWN;
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
+			}
+			free_block(searchp, cc_entry(cc), tofree);
+			cc->avail -= tofree;
+			memmove(&cc_entry(cc)[0], &cc_entry(cc)[tofree],
+					sizeof(void*)*cc->avail);
+		}
+		if(time_after(searchp->lists.next_reap, jiffies))
+			goto next_irqon;
+
+		spin_lock(&searchp->spinlock);
+		if(time_after(searchp->lists.next_reap, jiffies)) {
 			goto next_unlock;
 		}
-#ifdef CONFIG_SMP
-		{
-			cpucache_t *cc = cc_data(searchp);
-			if (cc && cc->avail) {
-				__free_block(searchp, cc_entry(cc), cc->avail);
-				cc->avail = 0;
-			}
+		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
+		if (searchp->lists.free_touched) {
+			searchp->lists.free_touched = 0;
+			goto next_unlock;
 		}
-#endif
 
-		full_free = 0;
-		p = searchp->slabs_free.next;
-		while (p != &searchp->slabs_free) {
+		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
+		do {
+			p = list3_data(searchp)->slabs_free.next;
+			if (p == &(list3_data(searchp)->slabs_free))
+				break;
+
 			slabp = list_entry(p, slab_t, list);
-#if DEBUG
-			if (slabp->inuse)
-				BUG();
-#endif
-			full_free++;
-			p = p->next;
-		}
+			BUG_ON(slabp->inuse);
+			list_del(&slabp->list);
+			STATS_INC_REAPED(searchp);
 
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
-		}
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
 next_unlock:
-		spin_unlock_irq(&searchp->spinlock);
+		spin_unlock(&searchp->spinlock);
+next_irqon:
+		local_irq_enable();
 next:
 		searchp = list_entry(searchp->next.next,kmem_cache_t,next);
-	} while (--scan && searchp != clock_searchp);
+	} while (--todo);
+	check_irq_on();
 
-	clock_searchp = searchp;
-
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
+	clock_searchp[smp_processor_id()] = searchp;
+	read_unlock(&cache_chain_lock);
+}
 
-		if (best_cachep->growing)
-			break;
-		p = best_cachep->slabs_free.prev;
-		if (p == &best_cachep->slabs_free)
-			break;
-		slabp = list_entry(p,slab_t,list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
-		list_del(&slabp->list);
-		STATS_INC_REAPED(best_cachep);
+static void reap_timer_fnc(unsigned long data)
+{
+	cache_reap();
 
-		/* Safe to drop the lock. The slab is no longer linked to the
-		 * cache.
-		 */
-		spin_unlock_irq(&best_cachep->spinlock);
-		kmem_slab_destroy(best_cachep, slabp);
-		spin_lock_irq(&best_cachep->spinlock);
-	}
-	spin_unlock_irq(&best_cachep->spinlock);
-	ret = scan * (1 << best_cachep->gfporder);
-out:
-	up(&cache_chain_sem);
-	return ret;
+	reap_timer[smp_processor_id()].expires = jiffies + REAPTIMEOUT_CPUC/REAP_SCANLEN;
+	add_timer(&reap_timer[smp_processor_id()]);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1954,41 +2134,38 @@
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
-		seq_puts(m, "slabinfo - version: 1.1"
+		seq_puts(m, "slabinfo - version: 1.2"
 #if STATS
 				" (statistics)"
 #endif
-#ifdef CONFIG_SMP
-				" (SMP)"
-#endif
 				"\n");
 		return 0;
 	}
 
+	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	list_for_each(q,&cachep->slabs_full) {
+	list_for_each(q,&cachep->lists.slabs_full) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse != cachep->num)
-			BUG();
+		BUG_ON(slabp->inuse != cachep->num);
 		active_objs += cachep->num;
 		active_slabs++;
 	}
-	list_for_each(q,&cachep->slabs_partial) {
+	list_for_each(q,&cachep->lists.slabs_partial) {
 		slabp = list_entry(q, slab_t, list);
-		BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
+		BUG_ON(slabp->inuse == cachep->num || slabp->inuse == 0);
 		active_objs += slabp->inuse;
 		active_slabs++;
 	}
-	list_for_each(q,&cachep->slabs_free) {
+	list_for_each(q,&cachep->lists.slabs_free) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 		num_slabs++;
 	}
 	num_slabs+=active_slabs;
 	num_objs = num_slabs*cachep->num;
+	BUG_ON(num_objs - active_objs != cachep->lists.free_objects);
 
 	name = cachep->name; 
 	{
@@ -2006,36 +2183,27 @@
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
-#ifdef CONFIG_SMP
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
-#endif
-#if STATS && defined(CONFIG_SMP)
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
@@ -2077,7 +2245,6 @@
 ssize_t slabinfo_write(struct file *file, const char *buffer,
 				size_t count, loff_t *ppos)
 {
-#ifdef CONFIG_SMP
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
 	int limit, batchcount, res;
 	struct list_head *p;
@@ -2105,7 +2272,13 @@
 		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
 
 		if (!strcmp(cachep->name, kbuf)) {
-			res = kmem_tune_cpucache(cachep, limit, batchcount);
+			if (limit < 1 ||
+			    batchcount < 1 ||
+			    batchcount > limit) {
+				res = -EINVAL;
+			} else {
+				res = do_tune_cpucache(cachep, limit, batchcount);
+			}
 			break;
 		}
 	}
@@ -2113,8 +2286,5 @@
 	if (res >= 0)
 		res = count;
 	return res;
-#else
-	return -EINVAL;
-#endif
 }
 #endif

--------------030806000803050005000207--

