Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVEKPXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEKPXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEKPXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:23:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28394 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261195AbVEKPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:17:29 -0400
Date: Wed, 11 May 2005 08:17:08 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, shai@scalex86.org
Subject: NUMA aware slab allocator V2
Message-ID: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA API change that introduced kmalloc_node was accepted last week by
Linus. Now it is possible to do slab allocations on a node to localize
memory structures. This API was used by the pageset localization patch and
the block layer localization patch now in mm. The existing kmalloc_node is
slow since it simply searches through all pages of the slab to find a page
that is on the node requested. The two patches do a one time allocation of
slab structures at initialization and therefore the speed of kmalloc node
does not matter.

This patch allows kmalloc_node to be as fast as kmalloc by introducing
node specific page lists for partial, free and full slabs. Slab allocation
improves in a NUMA system so that we are seeing a performance gain in
AIM7 of about 5% with this patch alone.

More NUMA localizations are possible if kmalloc_node operates
in an fast way like kmalloc.

Test run on a 32p systems with 32G Ram.

w/o patch
Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      485.36  100       485.3640     11.99      1.91   Sat Apr 30 14:01:51 2005
  100    26582.63   88       265.8263     21.89    144.96   Sat Apr 30 14:02:14 2005
  200    29866.83   81       149.3342     38.97    286.08   Sat Apr 30 14:02:53 2005
  300    33127.16   78       110.4239     52.71    426.54   Sat Apr 30 14:03:46 2005
  400    34889.47   80        87.2237     66.72    568.90   Sat Apr 30 14:04:53 2005
  500    35654.34   76        71.3087     81.62    714.55   Sat Apr 30 14:06:15 2005
  600    36460.83   75        60.7681     95.77    853.42   Sat Apr 30 14:07:51 2005
  700    35957.00   75        51.3671    113.30    990.67   Sat Apr 30 14:09:45 2005
  800    33380.65   73        41.7258    139.48   1140.86   Sat Apr 30 14:12:05 2005
  900    35095.01   76        38.9945    149.25   1281.30   Sat Apr 30 14:14:35 2005
 1000    36094.37   74        36.0944    161.24   1419.66   Sat Apr 30 14:17:17 2005

w/patch
Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      484.27  100       484.2736     12.02      1.93   Sat Apr 30 15:59:45 2005
  100    28262.03   90       282.6203     20.59    143.57   Sat Apr 30 16:00:06 2005
  200    32246.45   82       161.2322     36.10    282.89   Sat Apr 30 16:00:42 2005
  300    37945.80   83       126.4860     46.01    418.75   Sat Apr 30 16:01:28 2005
  400    40000.69   81       100.0017     58.20    561.48   Sat Apr 30 16:02:27 2005
  500    40976.10   78        81.9522     71.02    696.95   Sat Apr 30 16:03:38 2005
  600    41121.54   78        68.5359     84.92    834.86   Sat Apr 30 16:05:04 2005
  700    44052.77   78        62.9325     92.48    971.53   Sat Apr 30 16:06:37 2005
  800    41066.89   79        51.3336    113.38   1111.15   Sat Apr 30 16:08:31 2005
  900    38918.77   79        43.2431    134.59   1252.57   Sat Apr 30 16:10:46 2005
 1000    41842.21   76        41.8422    139.09   1392.33   Sat Apr 30 16:13:05 2005

These are measurement taken directly after boot and show a greater improvement than 5%.
However, the performance improvements become less over time if the AIM7 runs are repeated
and settle down at around 5%.

Link to earlier discussions:
http://marc.theaimsgroup.com/?t=111094594500003&r=1&w=2

Changelog:
- Batching for freeing of wrong-node objects (alien caches)
- Locking changes and NUMA #ifdefs as requested by Manfred

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/slab.c
===================================================================
--- linux-2.6.11.orig/mm/slab.c	2005-04-30 11:41:28.000000000 -0700
+++ linux-2.6.11/mm/slab.c	2005-05-04 09:18:16.000000000 -0700
@@ -75,6 +75,13 @@
  *
  *	At present, each engine can be growing a cache.  This should be blocked.
  *
+ * 15 March 2005. NUMA slab allocator.
+ *	Shobhit Dayal <shobhit@calsoftinc.com>
+ *	Alok N Kataria <alokk@calsoftinc.com>
+ *
+ *	Modified the slab allocator to be node aware on NUMA systems.
+ *	Each node has its own list of partial, free and full slabs.
+ *	All object allocations for a node occur from node specific slab lists.
  */

 #include	<linux/config.h>
@@ -92,7 +99,7 @@
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
 #include	<linux/rcupdate.h>
-
+#include	<linux/nodemask.h>
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
 #include	<asm/tlbflush.h>
@@ -210,6 +217,9 @@ struct slab {
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* num of objs active in slab */
 	kmem_bufctl_t		free;
+#ifdef CONFIG_NUMA
+	unsigned short          nodeid;
+#endif
 };

 /*
@@ -252,6 +262,10 @@ struct array_cache {
 	unsigned int limit;
 	unsigned int batchcount;
 	unsigned int touched;
+#ifdef CONFIG_NUMA
+	spinlock_t lock;
+#endif
+	void *entry[];
 };

 /* bootstrap: The caches do not work without cpuarrays anymore,
@@ -275,24 +289,77 @@ struct kmem_list3 {
 	struct list_head	slabs_full;
 	struct list_head	slabs_free;
 	unsigned long	free_objects;
-	int		free_touched;
 	unsigned long	next_reap;
+	int		free_touched;
+	unsigned int 	free_limit;
+	spinlock_t      list_lock;
 	struct array_cache	*shared;
+#ifdef CONFIG_NUMA
+	struct array_cache	**alien;
+#endif
 };

+/*
+ * Need this for bootstrapping a per node allocator.
+ */
+#define NUM_INIT_LISTS 3
+struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
+struct kmem_list3 __initdata kmem64_list3[MAX_NUMNODES];
+
+#ifdef CONFIG_NUMA
+
 #define LIST3_INIT(parent) \
-	{ \
-		.slabs_full	= LIST_HEAD_INIT(parent.slabs_full), \
-		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
-		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
-	}
+	do {	\
+		INIT_LIST_HEAD(&(parent)->slabs_full);	\
+		INIT_LIST_HEAD(&(parent)->slabs_partial);	\
+		INIT_LIST_HEAD(&(parent)->slabs_free);	\
+		(parent)->shared = NULL; \
+		(parent)->alien = NULL; \
+		(parent)->list_lock = SPIN_LOCK_UNLOCKED;	\
+		(parent)->free_objects = 0;	\
+		(parent)->free_touched = 0;	\
+	} while(0)
+#else
+
+#define LIST3_INIT(parent) \
+	do {	\
+		INIT_LIST_HEAD(&(parent)->slabs_full);	\
+		INIT_LIST_HEAD(&(parent)->slabs_partial);	\
+		INIT_LIST_HEAD(&(parent)->slabs_free);	\
+		(parent)->shared = NULL; \
+		(parent)->list_lock = SPIN_LOCK_UNLOCKED;	\
+		(parent)->free_objects = 0;	\
+		(parent)->free_touched = 0;	\
+	} while(0)
+#endif
+
+#define MAKE_LIST(cachep, listp, slab, nodeid)	\
+	do {	\
+		INIT_LIST_HEAD(listp);		\
+		list_splice(&(cachep->nodelists[nodeid]->slab), listp); \
+	}while(0)
+
+#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)			\
+	do {					\
+	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
+	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid);	\
+	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
+	}while(0)
+
 #define list3_data(cachep) \
-	(&(cachep)->lists)
+	((cachep->nodelists[numa_node_id()]))

 /* NUMA: per-node */
 #define list3_data_ptr(cachep, ptr) \
 		list3_data(cachep)

+#ifdef CONFIG_NUMA
+#define is_node_online(node) node_online(node)
+#else
+#define is_node_online(node) \
+	({ BUG_ON(node != 0); 1; })
+#endif /* CONFIG_NUMA */
+
 /*
  * kmem_cache_t
  *
@@ -304,13 +371,12 @@ struct kmem_cache_s {
 	struct array_cache	*array[NR_CPUS];
 	unsigned int		batchcount;
 	unsigned int		limit;
-/* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	lists;
-	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
+	unsigned int 		shared;
 	unsigned int		objsize;
+/* 2) touched by every alloc & free from the backend */
+	struct kmem_list3	*nodelists[MAX_NUMNODES];
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
-	unsigned int		free_limit; /* upper limit of objects in the lists */
 	spinlock_t		spinlock;

 /* 3) cache_grow/shrink */
@@ -347,6 +413,7 @@ struct kmem_cache_s {
 	unsigned long 		errors;
 	unsigned long		max_freeable;
 	unsigned long		node_allocs;
+	unsigned long		node_frees;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
@@ -382,6 +449,7 @@ struct kmem_cache_s {
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
 #define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
+#define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { if ((x)->max_freeable < i) \
 					(x)->max_freeable = i; \
@@ -400,6 +468,7 @@ struct kmem_cache_s {
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
+#define	STATS_INC_NODEFREES(x)	do { } while (0)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { } while (0)

@@ -532,9 +601,9 @@ static struct arraycache_init initarray_

 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.lists		= LIST3_INIT(cache_cache.lists),
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
+	.shared		= 1,
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
@@ -567,16 +636,20 @@ static enum {
 	FULL
 } g_cpucache_up;

+static enum {
+	CACHE_CACHE,
+	SIZE_32,
+	SIZE_DMA_32,
+	SIZE_64,
+	ALL
+} cpucache_up_64;
+
 static DEFINE_PER_CPU(struct work_struct, reap_work);

 static void free_block(kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
-
-static inline void **ac_entry(struct array_cache *ac)
-{
-	return (void**)(ac+1);
-}
+static int __node_shrink(kmem_cache_t *cachep, int node);

 static inline struct array_cache *ac_data(kmem_cache_t *cachep)
 {
@@ -678,42 +751,151 @@ static struct array_cache *alloc_arrayca
 	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
 	struct array_cache *nc = NULL;

-	if (cpu == -1)
-		nc = kmalloc(memsize, GFP_KERNEL);
-	else
-		nc = kmalloc_node(memsize, GFP_KERNEL, cpu_to_node(cpu));
-
+	nc = kmalloc_node(memsize, GFP_KERNEL, cpu_to_node(cpu));
 	if (nc) {
 		nc->avail = 0;
 		nc->limit = entries;
 		nc->batchcount = batchcount;
 		nc->touched = 0;
+#ifdef CONFIG_NUMA
+		spin_lock_init(&nc->lock);
+#endif
 	}
 	return nc;
 }
+#ifdef CONFIG_NUMA
+static inline struct array_cache **alloc_alien_cache(int cpu, int limit)
+{
+	struct array_cache **ac_ptr;
+	int memsize = sizeof(void*)*MAX_NUMNODES;
+	int node = cpu_to_node(cpu);
+	int i;
+
+	if (limit > 1)
+		limit = 12;
+	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
+	if(ac_ptr) {
+		for (i = 0; i < MAX_NUMNODES; i++) {
+			if (i == node) {
+				ac_ptr[i] = NULL;
+				continue;
+			}
+			ac_ptr[i] = alloc_arraycache(cpu, limit, 0xbaadf00d);
+			if(!ac_ptr[i]) {
+				for(i--; i <=0; i--)
+					kfree(ac_ptr[i]);
+				kfree(ac_ptr);
+				return NULL;
+			}
+		}
+	}
+	return ac_ptr;
+}
+
+static inline void free_alien_cache(struct array_cache **ac_ptr)
+{
+	int i;
+
+	if(!ac_ptr)
+		return;
+	for (i = 0; i < MAX_NUMNODES; i++)
+		kfree(ac_ptr[i]);
+
+	kfree(ac_ptr);
+}
+
+static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
+{
+	struct kmem_list3 *rl3 = cachep->nodelists[node];
+
+	if(ac->avail) {
+		spin_lock(&rl3->list_lock);
+		free_block(cachep, ac->entry, ac->avail);
+		ac->avail = 0;
+		spin_unlock(&rl3->list_lock);
+	}
+}
+
+static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
+{
+	int i=0;
+	struct array_cache *ac;
+	unsigned long flags;
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		ac = l3->alien[i];
+		if(ac) {
+			spin_lock_irqsave(&ac->lock, flags);
+			__drain_alien_cache(cachep, ac, i);
+			spin_unlock_irqrestore(&ac->lock, flags);
+		}
+	}
+}
+#endif

 static int __devinit cpuup_callback(struct notifier_block *nfb,
 				  unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
 	kmem_cache_t* cachep;
+	struct kmem_list3 *l3 = NULL;
+	int node = cpu_to_node(cpu);
+	int memsize = sizeof(struct kmem_list3);
+	struct array_cache *nc = NULL;

 	switch (action) {
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
+		/* we need to do this right in the begining since
+		 * alloc_arraycache's are going to use this list.
+		 * kmalloc_node allows us to add the slab to the right
+		 * kmem_list3 and not this cpu's kmem_list3
+		 */
+
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc;
+			/* setup the size64 kmemlist for hcpu before we can
+			 * begin anything. Make sure some other cpu on this
+			 * node has not already allocated this
+			 */
+			if (!cachep->nodelists[node]) {
+				if(!(l3 = kmalloc_node(memsize,
+						GFP_KERNEL, node)))
+					goto bad;
+				LIST3_INIT(l3);
+				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+					((unsigned long)cachep)%REAPTIMEOUT_LIST3;

-			nc = alloc_arraycache(cpu, cachep->limit, cachep->batchcount);
+				cachep->nodelists[node] = l3;
+			}
+
+			spin_lock_irq(&cachep->nodelists[node]->list_lock);
+			cachep->nodelists[node]->free_limit =
+				(1 + nr_cpus_node(node)) *
+				cachep->batchcount + cachep->num;
+			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
+		}
+
+		/* Now we can go ahead with allocating the shared array's
+		  & array cache's */
+		list_for_each_entry(cachep, &cache_chain, next) {
+			nc = alloc_arraycache(cpu, cachep->limit,
+					cachep->batchcount);
 			if (!nc)
 				goto bad;
-
-			spin_lock_irq(&cachep->spinlock);
 			cachep->array[cpu] = nc;
-			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
-						+ cachep->num;
-			spin_unlock_irq(&cachep->spinlock);

+			l3 = cachep->nodelists[node];
+			BUG_ON(!l3);
+			if(!l3->shared) {
+				if(!(nc = alloc_arraycache(cpu,
+					cachep->shared*cachep->batchcount,
+					0xbaadf00d)))
+					goto  bad;
+
+				/* we are serialised from CPU_DEAD or
+				  CPU_UP_CANCELLED by the cpucontrol lock */
+				l3->shared = nc;
+			}
 		}
 		up(&cache_chain_sem);
 		break;
@@ -728,13 +910,53 @@ static int __devinit cpuup_callback(stru

 		list_for_each_entry(cachep, &cache_chain, next) {
 			struct array_cache *nc;
+			cpumask_t mask;

+			mask = node_to_cpumask(node);
 			spin_lock_irq(&cachep->spinlock);
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
-			cachep->free_limit -= cachep->batchcount;
-			free_block(cachep, ac_entry(nc), nc->avail);
+			l3 = cachep->nodelists[node];
+
+			if(!l3)
+				goto unlock_cache;
+
+			spin_lock(&l3->list_lock);
+
+			/* Free limit for this kmem_list3 */
+			l3->free_limit -= cachep->batchcount;
+			if(nc)
+				free_block(cachep, nc->entry, nc->avail);
+
+			if(!cpus_empty(mask)) {
+                                spin_unlock(&l3->list_lock);
+                                goto unlock_cache;
+                        }
+
+			if(l3->shared) {
+				free_block(cachep, l3->shared->entry,
+						l3->shared->avail);
+				kfree(l3->shared);
+				l3->shared = NULL;
+			}
+#ifdef CONFIG_NUMA
+			if(l3->alien) {
+				drain_alien_cache(cachep, l3);
+				free_alien_cache(l3->alien);
+				l3->alien = NULL;
+			}
+#endif
+
+			/* free slabs belonging to this node */
+			if(__node_shrink(cachep, node)) {
+				cachep->nodelists[node] = NULL;
+				spin_unlock(&l3->list_lock);
+				kfree(l3);
+			}
+			else
+				spin_unlock(&l3->list_lock);
+unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
 		}
@@ -750,6 +972,25 @@ bad:

 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };

+/*
+ * swap the static kmem_list3 with kmalloced memory
+ */
+static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list,
+		int nodeid)
+{
+	struct kmem_list3 *ptr;
+
+	BUG_ON((cachep->nodelists[nodeid]) != list);
+	ptr = kmalloc_node(sizeof(struct kmem_list3), GFP_KERNEL, nodeid);
+	BUG_ON(!ptr);
+
+	local_irq_disable();
+	memcpy(ptr, list, sizeof(struct kmem_list3));
+	MAKE_ALL_LISTS(cachep, ptr, nodeid);
+	cachep->nodelists[nodeid] = ptr;
+	local_irq_enable();
+}
+
 /* Initialisation.
  * Called after the gfp() functions have been enabled, and before smp_init().
  */
@@ -758,7 +999,15 @@ void __init kmem_cache_init(void)
 	size_t left_over;
 	struct cache_sizes *sizes;
 	struct cache_names *names;
+	int i;

+	for(i = 0; i < NUM_INIT_LISTS; i++)
+		LIST3_INIT(&initkmem_list3[i]);
+
+	for(i = 0; i < MAX_NUMNODES; i++) {
+		LIST3_INIT(&kmem64_list3[i]);
+		cache_cache.nodelists[i] = NULL;
+	}
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -766,21 +1015,24 @@ void __init kmem_cache_init(void)
 	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
 		slab_break_gfp_order = BREAK_GFP_ORDER_HI;

-
 	/* Bootstrap is tricky, because several objects are allocated
 	 * from caches that do not exist yet:
 	 * 1) initialize the cache_cache cache: it contains the kmem_cache_t
 	 *    structures of all caches, except cache_cache itself: cache_cache
 	 *    is statically allocated.
-	 *    Initially an __init data area is used for the head array, it's
-	 *    replaced with a kmalloc allocated array at the end of the bootstrap.
+	 *    Initially an __init data area is used for the head array and the
+	 *    kmem_list3 structures, it's replaced with a kmalloc allocated
+	 *    array at the end of the bootstrap.
 	 * 2) Create the first kmalloc cache.
-	 *    The kmem_cache_t for the new cache is allocated normally. An __init
-	 *    data area is used for the head array.
-	 * 3) Create the remaining kmalloc caches, with minimally sized head arrays.
+	 *    The kmem_cache_t for the new cache is allocated normally.
+	 *    An __init data area is used for the head array.
+	 * 3) Create the remaining kmalloc caches, with minimally sized
+	 *    head arrays.
 	 * 4) Replace the __init data head arrays for cache_cache and the first
 	 *    kmalloc cache with kmalloc allocated arrays.
-	 * 5) Resize the head arrays of the kmalloc caches to their final sizes.
+	 * 5) Replace the __init data for kmem_list3 for cache_cache and
+	 *    the other cache's with kmalloc allocated memory.
+	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
 	 */

 	/* 1) create the cache_cache */
@@ -789,6 +1041,7 @@ void __init kmem_cache_init(void)
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
+	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];

 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());

@@ -833,24 +1086,54 @@ void __init kmem_cache_init(void)
 	/* 4) Replace the bootstrap head arrays */
 	{
 		void * ptr;
-
+
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+
 		local_irq_disable();
 		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
-		memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init));
+		memcpy(ptr, ac_data(&cache_cache),
+				sizeof(struct arraycache_init));
 		cache_cache.array[smp_processor_id()] = ptr;
 		local_irq_enable();
-
+
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+
 		local_irq_disable();
-		BUG_ON(ac_data(malloc_sizes[0].cs_cachep) != &initarray_generic.cache);
+		BUG_ON(ac_data(malloc_sizes[0].cs_cachep)
+				!= &initarray_generic.cache);
 		memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),
 				sizeof(struct arraycache_init));
 		malloc_sizes[0].cs_cachep->array[smp_processor_id()] = ptr;
+	}
+	/* 5) Replace the bootstrap kmem_list3's */
+	{
+		int i, j;
+		for (i=0; malloc_sizes[i].cs_size &&
+			(malloc_sizes[i].cs_size < sizeof(struct kmem_list3));
+			i++);
+
+		BUG_ON(!malloc_sizes[i].cs_size);
+		/* Replace the static kmem_list3 structures for the boot cpu */
+		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
+				numa_node_id());
+		if(i) {
+			init_list(malloc_sizes[0].cs_cachep,
+					&initkmem_list3[SIZE_32],
+					numa_node_id());
+			init_list(malloc_sizes[0].cs_dmacachep,
+					&initkmem_list3[SIZE_DMA_32],
+					numa_node_id());
+		}
+
+		for (j=0; j < MAX_NUMNODES; j++) {
+			if(is_node_online(j))
+				init_list(malloc_sizes[i].cs_cachep,
+						&kmem64_list3[j], j);
+		}
 		local_irq_enable();
 	}

-	/* 5) resize the head arrays to their final sizes */
+	/* 6) resize the head arrays to their final sizes */
 	{
 		kmem_cache_t *cachep;
 		down(&cache_chain_sem);
@@ -866,7 +1149,6 @@ void __init kmem_cache_init(void)
 	 * that initializes ac_data for all new cpus
 	 */
 	register_cpu_notifier(&cpucache_notifier);
-

 	/* The reap timers are started later, with a module init call:
 	 * That part of the kernel is not yet operational.
@@ -1163,6 +1445,21 @@ static void slab_destroy (kmem_cache_t *
 	}
 }

+/* For setting up all the kmem_list3s for cache whose objsize is same
+   as size of kmem_list3. */
+static inline void set_up_list3s(kmem_cache_t *cachep)
+{
+	int i;
+	for(i = 0; i < MAX_NUMNODES; i++) {
+		if(is_node_online(i)) {
+			cachep->nodelists[i] = &kmem64_list3[i];
+			cachep->nodelists[i]->next_reap = jiffies +
+				REAPTIMEOUT_LIST3 +
+				((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+		}
+	}
+}
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -1418,10 +1715,6 @@ next:
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	/* NUMA */
-	INIT_LIST_HEAD(&cachep->lists.slabs_full);
-	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
-	INIT_LIST_HEAD(&cachep->lists.slabs_free);

 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -1436,28 +1729,66 @@ next:
 		enable_cpucache(cachep);
 	} else {
 		if (g_cpucache_up == NONE) {
+			int i;
 			/* Note: the first kmem_cache_create must create
 			 * the cache that's used by kmalloc(24), otherwise
 			 * the creation of further caches will BUG().
 			 */
-			cachep->array[smp_processor_id()] = &initarray_generic.cache;
+			cachep->array[smp_processor_id()] =
+				&initarray_generic.cache;
+
+			/* If the cache that's used by
+			 * kmalloc(sizeof(kmem_list3)) is the first cache,
+			 * then we need to set up all its list3s, otherwise
+			 * the creation of further caches will BUG().
+			 */
+			for (i=0; malloc_sizes[i].cs_size &&
+					(malloc_sizes[i].cs_size <
+					 sizeof(struct kmem_list3)); i++);
+			if(i == 0) {
+				set_up_list3s(cachep);
+				cpucache_up_64 = ALL;
+			}
+			else {
+				cachep->nodelists[numa_node_id()] =
+					&initkmem_list3[SIZE_32];
+				cpucache_up_64 = SIZE_DMA_32;
+			}
+
 			g_cpucache_up = PARTIAL;
 		} else {
-			cachep->array[smp_processor_id()] = kmalloc(sizeof(struct arraycache_init),GFP_KERNEL);
+			cachep->array[smp_processor_id()] =
+				kmalloc(sizeof(struct arraycache_init),
+						GFP_KERNEL);
+			if(cpucache_up_64 == SIZE_DMA_32) {
+				cachep->nodelists[numa_node_id()] =
+					&initkmem_list3[SIZE_DMA_32];
+				cpucache_up_64 = SIZE_64;
+			}
+			else if(cpucache_up_64 == SIZE_64) {
+				set_up_list3s(cachep);
+				cpucache_up_64 = ALL;
+			}
+			else {
+				cachep->nodelists[numa_node_id()] =
+					kmalloc(sizeof(struct kmem_list3),
+							GFP_KERNEL);
+				LIST3_INIT(cachep->nodelists[numa_node_id()]);
+			}
 		}
+		cachep->nodelists[numa_node_id()]->next_reap =
+			jiffies + REAPTIMEOUT_LIST3 +
+			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
 		BUG_ON(!ac_data(cachep));
+		BUG_ON(!cachep->nodelists[numa_node_id()]);
 		ac_data(cachep)->avail = 0;
 		ac_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
 		ac_data(cachep)->batchcount = 1;
 		ac_data(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
-		cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
-					+ cachep->num;
-	}
-
-	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
-					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+	}

 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
@@ -1515,13 +1846,23 @@ static void check_spinlock_acquired(kmem
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	BUG_ON(spin_trylock(&cachep->spinlock));
+	BUG_ON(spin_trylock(&list3_data(cachep)->list_lock));
 #endif
 }
+
+static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+{
+#ifdef CONFIG_SMP
+	check_irq_off();
+	BUG_ON(spin_trylock(&(cachep->nodelists[node])->list_lock));
+#endif
+}
+
 #else
 #define check_irq_off()	do { } while(0)
 #define check_irq_on()	do { } while(0)
 #define check_spinlock_acquired(x) do { } while(0)
+#define check_spinlock_acquired_node(x, y) do { } while(0)
 #endif

 /*
@@ -1543,7 +1884,7 @@ static void smp_call_function_all_cpus(v
 }

 static void drain_array_locked(kmem_cache_t* cachep,
-				struct array_cache *ac, int force);
+				struct array_cache *ac, int force, int node);

 static void do_drain(void *arg)
 {
@@ -1552,59 +1893,84 @@ static void do_drain(void *arg)

 	check_irq_off();
 	ac = ac_data(cachep);
-	spin_lock(&cachep->spinlock);
-	free_block(cachep, &ac_entry(ac)[0], ac->avail);
-	spin_unlock(&cachep->spinlock);
+	spin_lock(&list3_data(cachep)->list_lock);
+	free_block(cachep, ac->entry, ac->avail);
+	spin_unlock(&list3_data(cachep)->list_lock);
 	ac->avail = 0;
 }

 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
+	struct kmem_list3 *l3;
+	int i;
+
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	if (cachep->lists.shared)
-		drain_array_locked(cachep, cachep->lists.shared, 1);
+	for(i = 0; i < MAX_NUMNODES; i++)  {
+		l3 = cachep->nodelists[i];
+		if (l3) {
+			spin_lock(&l3->list_lock);
+			drain_array_locked(cachep, l3->shared, 1, i);
+			spin_unlock(&l3->list_lock);
+#ifdef CONFIG_NUMA
+			if(l3->alien)
+				drain_alien_cache(cachep, l3);
+#endif
+		}
+	}
 	spin_unlock_irq(&cachep->spinlock);
 }

-
-/* NUMA shrink all list3s */
-static int __cache_shrink(kmem_cache_t *cachep)
+static int __node_shrink(kmem_cache_t *cachep, int node)
 {
 	struct slab *slabp;
+	struct kmem_list3 *l3 = cachep->nodelists[node];
 	int ret;

-	drain_cpu_caches(cachep);
-
-	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
-
 	for(;;) {
 		struct list_head *p;

-		p = cachep->lists.slabs_free.prev;
-		if (p == &cachep->lists.slabs_free)
+		p = l3->slabs_free.prev;
+		if (p == &l3->slabs_free)
 			break;

-		slabp = list_entry(cachep->lists.slabs_free.prev, struct slab, list);
+		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
 #if DEBUG
 		if (slabp->inuse)
 			BUG();
 #endif
 		list_del(&slabp->list);

-		cachep->lists.free_objects -= cachep->num;
-		spin_unlock_irq(&cachep->spinlock);
+		l3->free_objects -= cachep->num;
+		spin_unlock_irq(&l3->list_lock);
 		slab_destroy(cachep, slabp);
-		spin_lock_irq(&cachep->spinlock);
+		spin_lock_irq(&l3->list_lock);
 	}
-	ret = !list_empty(&cachep->lists.slabs_full) ||
-		!list_empty(&cachep->lists.slabs_partial);
-	spin_unlock_irq(&cachep->spinlock);
+	ret = !list_empty(&l3->slabs_full) ||
+		!list_empty(&l3->slabs_partial);
 	return ret;
 }

+static int __cache_shrink(kmem_cache_t *cachep)
+{
+	int ret = 0, i = 0;
+	struct kmem_list3 *l3;
+
+	drain_cpu_caches(cachep);
+
+	check_irq_on();
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		l3 = cachep->nodelists[i];
+		if(l3) {
+			spin_lock_irq(&l3->list_lock);
+			ret += __node_shrink(cachep, i);
+			spin_unlock_irq(&l3->list_lock);
+		}
+	}
+	return (ret ? 1 : 0);
+}
+
 /**
  * kmem_cache_shrink - Shrink a cache.
  * @cachep: The cache to shrink.
@@ -1641,6 +2007,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
 int kmem_cache_destroy(kmem_cache_t * cachep)
 {
 	int i;
+	struct kmem_list3 *l3;

 	if (!cachep || in_interrupt())
 		BUG();
@@ -1675,8 +2042,15 @@ int kmem_cache_destroy(kmem_cache_t * ca
 		kfree(cachep->array[i]);

 	/* NUMA: free the list3 structures */
-	kfree(cachep->lists.shared);
-	cachep->lists.shared = NULL;
+	for(i = 0; i < MAX_NUMNODES; i++) {
+		if((l3 = cachep->nodelists[i])) {
+			kfree(l3->shared);
+#ifdef CONFIG_NUMA
+			free_alien_cache(l3->alien);
+#endif
+			kfree(l3);
+		}
+	}
 	kmem_cache_free(&cache_cache, cachep);

 	unlock_cpu_hotplug();
@@ -1795,6 +2169,7 @@ static int cache_grow(kmem_cache_t *cach
 	size_t		 offset;
 	unsigned int	 local_flags;
 	unsigned long	 ctor_flags;
+	struct kmem_list3 *l3;

 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -1826,6 +2201,7 @@ static int cache_grow(kmem_cache_t *cach

 	spin_unlock(&cachep->spinlock);

+	check_irq_off();
 	if (local_flags & __GFP_WAIT)
 		local_irq_enable();

@@ -1837,8 +2213,9 @@ static int cache_grow(kmem_cache_t *cach
 	 */
 	kmem_flagcheck(cachep, flags);

-
-	/* Get mem for the objs. */
+	/* Get mem for the objs.
+	 * Attempt to allocate a physical page from 'nodeid',
+	 */
 	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
 		goto failed;

@@ -1846,6 +2223,9 @@ static int cache_grow(kmem_cache_t *cach
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;

+#ifdef CONFIG_NUMA
+	slabp->nodeid = nodeid;
+#endif
 	set_slab_attr(cachep, slabp, objp);

 	cache_init_objs(cachep, slabp, ctor_flags);
@@ -1853,13 +2233,14 @@ static int cache_grow(kmem_cache_t *cach
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	check_irq_off();
-	spin_lock(&cachep->spinlock);
+	l3 = cachep->nodelists[nodeid];
+	spin_lock(&l3->list_lock);

 	/* Make slab active. */
-	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
+	list_add_tail(&slabp->list, &(l3->slabs_free));
 	STATS_INC_GROWN(cachep);
-	list3_data(cachep)->free_objects += cachep->num;
-	spin_unlock(&cachep->spinlock);
+	l3->free_objects += cachep->num;
+	spin_unlock(&l3->list_lock);
 	return 1;
 opps1:
 	kmem_freepages(cachep, objp);
@@ -1965,7 +2346,6 @@ static void check_slabp(kmem_cache_t *ca
 	kmem_bufctl_t i;
 	int entries = 0;

-	check_spinlock_acquired(cachep);
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
 		entries++;
@@ -2010,8 +2390,9 @@ retry:
 	}
 	l3 = list3_data(cachep);

-	BUG_ON(ac->avail > 0);
-	spin_lock(&cachep->spinlock);
+	BUG_ON(ac->avail > 0 || !l3);
+	spin_lock(&l3->list_lock);
+
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		if (shared_array->avail) {
@@ -2019,8 +2400,9 @@ retry:
 				batchcount = shared_array->avail;
 			shared_array->avail -= batchcount;
 			ac->avail = batchcount;
-			memcpy(ac_entry(ac), &ac_entry(shared_array)[shared_array->avail],
-					sizeof(void*)*batchcount);
+			memcpy(ac->entry,
+				&(shared_array->entry[shared_array->avail]),
+				sizeof(void*)*batchcount);
 			shared_array->touched = 1;
 			goto alloc_done;
 		}
@@ -2047,7 +2429,8 @@ retry:
 			STATS_SET_HIGH(cachep);

 			/* get obj pointer */
-			ac_entry(ac)[ac->avail++] = slabp->s_mem + slabp->free*cachep->objsize;
+			ac->entry[ac->avail++] = slabp->s_mem +
+				slabp->free*cachep->objsize;

 			slabp->inuse++;
 			next = slab_bufctl(slabp)[slabp->free];
@@ -2069,12 +2452,12 @@ retry:
 must_grow:
 	l3->free_objects -= ac->avail;
 alloc_done:
-	spin_unlock(&cachep->spinlock);
+	spin_unlock(&l3->list_lock);

 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, -1);
-
+		x = cache_grow(cachep, flags, numa_node_id());
+
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
 		if (!x && ac->avail == 0)	// no objects in sight? abort
@@ -2084,7 +2467,7 @@ alloc_done:
 			goto retry;
 	}
 	ac->touched = 1;
-	return ac_entry(ac)[--ac->avail];
+	return ac->entry[--ac->avail];
 }

 static inline void
@@ -2156,7 +2539,7 @@ static inline void *__cache_alloc(kmem_c
 	if (likely(ac->avail)) {
 		STATS_INC_ALLOCHIT(cachep);
 		ac->touched = 1;
-		objp = ac_entry(ac)[--ac->avail];
+		objp = ac->entry[--ac->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
@@ -2166,29 +2549,102 @@ static inline void *__cache_alloc(kmem_c
 	return objp;
 }

-/*
- * NUMA: different approach needed if the spinlock is moved into
- * the l3 structure
+#ifdef CONFIG_NUMA
+/*
+ * A interface to enable slab creation on nodeid
  */
+static void *__cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
+{
+	struct list_head *entry;
+	struct slab *slabp;
+	struct kmem_list3 *l3;
+	void *obj;
+	kmem_bufctl_t next;
+	int x;
+
+	l3 = cachep->nodelists[nodeid];
+	BUG_ON(!l3);
+
+retry:
+	spin_lock(&l3->list_lock);
+	entry = l3->slabs_partial.next;
+	if (entry == &l3->slabs_partial) {
+		l3->free_touched = 1;
+		entry = l3->slabs_free.next;
+		if (entry == &l3->slabs_free)
+			goto must_grow;
+	}
+
+	slabp = list_entry(entry, struct slab, list);
+	check_spinlock_acquired_node(cachep, nodeid);
+	check_slabp(cachep, slabp);
+
+	STATS_INC_NODEALLOCS(cachep);
+	STATS_INC_ACTIVE(cachep);
+	STATS_SET_HIGH(cachep);

+	BUG_ON(slabp->inuse == cachep->num);
+
+	/* get obj pointer */
+	obj =  slabp->s_mem + slabp->free*cachep->objsize;
+	slabp->inuse++;
+	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+#endif
+	slabp->free = next;
+	check_slabp(cachep, slabp);
+	l3->free_objects--;
+	/* move slabp to correct slabp list: */
+	list_del(&slabp->list);
+
+	if (slabp->free == BUFCTL_END) {
+		list_add(&slabp->list, &l3->slabs_full);
+	}
+	else {
+		list_add(&slabp->list, &l3->slabs_partial);
+	}
+
+	spin_unlock(&l3->list_lock);
+	goto done;
+
+must_grow:
+	spin_unlock(&l3->list_lock);
+	x = cache_grow(cachep, flags, nodeid);
+
+	if (!x)
+		return NULL;
+
+	goto retry;
+done:
+	return obj;
+}
+#endif
+
+/*
+ * Caller needs to acquire correct kmem_list's list_lock
+ */
 static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
 {
 	int i;
-
-	check_spinlock_acquired(cachep);
-
-	/* NUMA: move add into loop */
-	cachep->lists.free_objects += nr_objects;
+	struct kmem_list3 *l3;

 	for (i = 0; i < nr_objects; i++) {
 		void *objp = objpp[i];
 		struct slab *slabp;
 		unsigned int objnr;
+		int nodeid = 0;

 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+#ifdef CONFIG_NUMA
+		nodeid = slabp->nodeid;
+#endif
+		l3 = cachep->nodelists[nodeid];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
+		check_spinlock_acquired_node(cachep, nodeid);
 		check_slabp(cachep, slabp);
+
 #if DEBUG
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
@@ -2200,24 +2656,23 @@ static void free_block(kmem_cache_t *cac
 		slabp->free = objnr;
 		STATS_DEC_ACTIVE(cachep);
 		slabp->inuse--;
+		l3->free_objects++;
 		check_slabp(cachep, slabp);

 		/* fixup slab chains */
 		if (slabp->inuse == 0) {
-			if (cachep->lists.free_objects > cachep->free_limit) {
-				cachep->lists.free_objects -= cachep->num;
+			if (l3->free_objects > l3->free_limit) {
+				l3->free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
-				list_add(&slabp->list,
-				&list3_data_ptr(cachep, objp)->slabs_free);
+				list_add(&slabp->list, &l3->slabs_free);
 			}
 		} else {
 			/* Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
-			list_add_tail(&slabp->list,
-				&list3_data_ptr(cachep, objp)->slabs_partial);
+			list_add_tail(&slabp->list, &l3->slabs_partial);
 		}
 	}
 }
@@ -2225,36 +2680,38 @@ static void free_block(kmem_cache_t *cac
 static void cache_flusharray(kmem_cache_t *cachep, struct array_cache *ac)
 {
 	int batchcount;
+	struct kmem_list3 *l3;

 	batchcount = ac->batchcount;
 #if DEBUG
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	spin_lock(&cachep->spinlock);
-	if (cachep->lists.shared) {
-		struct array_cache *shared_array = cachep->lists.shared;
+	l3 = list3_data(cachep);
+	spin_lock(&l3->list_lock);
+	if (l3->shared) {
+		struct array_cache *shared_array = l3->shared;
 		int max = shared_array->limit-shared_array->avail;
 		if (max) {
 			if (batchcount > max)
 				batchcount = max;
-			memcpy(&ac_entry(shared_array)[shared_array->avail],
-					&ac_entry(ac)[0],
+			memcpy(&(shared_array->entry[shared_array->avail]),
+					ac->entry,
 					sizeof(void*)*batchcount);
 			shared_array->avail += batchcount;
 			goto free_done;
 		}
 	}

-	free_block(cachep, &ac_entry(ac)[0], batchcount);
+	free_block(cachep, ac->entry, batchcount);
 free_done:
 #if STATS
 	{
 		int i = 0;
 		struct list_head *p;

-		p = list3_data(cachep)->slabs_free.next;
-		while (p != &(list3_data(cachep)->slabs_free)) {
+		p = l3->slabs_free.next;
+		while (p != &(l3->slabs_free)) {
 			struct slab *slabp;

 			slabp = list_entry(p, struct slab, list);
@@ -2266,12 +2723,13 @@ free_done:
 		STATS_SET_FREEABLE(cachep, i);
 	}
 #endif
-	spin_unlock(&cachep->spinlock);
+	spin_unlock(&l3->list_lock);
 	ac->avail -= batchcount;
-	memmove(&ac_entry(ac)[0], &ac_entry(ac)[batchcount],
+	memmove(ac->entry, &(ac->entry[batchcount]),
 			sizeof(void*)*ac->avail);
 }

+
 /*
  * __cache_free
  * Release an obj back to its cache. If the obj has a constructed
@@ -2286,14 +2744,47 @@ static inline void __cache_free(kmem_cac
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));

+	/* Make sure we are not freeing a object from another
+	 * node to the array cache on this cpu.
+	 */
+#ifdef CONFIG_NUMA
+	{
+		struct slab *slabp;
+		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		if(unlikely(slabp->nodeid != numa_node_id())) {
+			struct array_cache *alien = NULL;
+			int nodeid = slabp->nodeid;
+			struct kmem_list3 *l3 = list3_data(cachep);
+
+			STATS_INC_NODEFREES(cachep);
+			if(l3->alien && l3->alien[nodeid]) {
+				alien = l3->alien[nodeid];
+				spin_lock(&alien->lock);
+				if(unlikely(alien->avail == alien->limit))
+					__drain_alien_cache(cachep,
+							alien, nodeid);
+				alien->entry[alien->avail++] = objp;
+				spin_unlock(&alien->lock);
+			}
+			else {
+				spin_lock(&(cachep->nodelists[nodeid])->
+						list_lock);
+				free_block(cachep, &objp, 1);
+				spin_unlock(&(cachep->nodelists[nodeid])->
+						list_lock);
+			}
+			return;
+		}
+	}
+#endif
 	if (likely(ac->avail < ac->limit)) {
 		STATS_INC_FREEHIT(cachep);
-		ac_entry(ac)[ac->avail++] = objp;
+		ac->entry[ac->avail++] = objp;
 		return;
 	} else {
 		STATS_INC_FREEMISS(cachep);
 		cache_flusharray(cachep, ac);
-		ac_entry(ac)[ac->avail++] = objp;
+		ac->entry[ac->avail++] = objp;
 	}
 }

@@ -2363,78 +2854,24 @@ out:
  * Identical to kmem_cache_alloc, except that this function is slow
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
+ * New and improved: it will now make sure that the object gets
+ * put on the correct node list so that there is no false sharing.
  */
 void *kmem_cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
 {
-	int loop;
-	void *objp;
-	struct slab *slabp;
-	kmem_bufctl_t next;
-
-	for (loop = 0;;loop++) {
-		struct list_head *q;
-
-		objp = NULL;
-		check_irq_on();
-		spin_lock_irq(&cachep->spinlock);
-		/* walk through all partial and empty slab and find one
-		 * from the right node */
-		list_for_each(q,&cachep->lists.slabs_partial) {
-			slabp = list_entry(q, struct slab, list);
-
-			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
-					loop > 2)
-				goto got_slabp;
-		}
-		list_for_each(q, &cachep->lists.slabs_free) {
-			slabp = list_entry(q, struct slab, list);
-
-			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
-					loop > 2)
-				goto got_slabp;
-		}
-		spin_unlock_irq(&cachep->spinlock);
-
-		local_irq_disable();
-		if (!cache_grow(cachep, flags, nodeid)) {
-			local_irq_enable();
-			return NULL;
-		}
-		local_irq_enable();
-	}
-got_slabp:
-	/* found one: allocate object */
-	check_slabp(cachep, slabp);
-	check_spinlock_acquired(cachep);
-
-	STATS_INC_ALLOCED(cachep);
-	STATS_INC_ACTIVE(cachep);
-	STATS_SET_HIGH(cachep);
-	STATS_INC_NODEALLOCS(cachep);
-
-	objp = slabp->s_mem + slabp->free*cachep->objsize;
-
-	slabp->inuse++;
-	next = slab_bufctl(slabp)[slabp->free];
-#if DEBUG
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-#endif
-	slabp->free = next;
-	check_slabp(cachep, slabp);
+	unsigned long save_flags;
+	void *ptr;

-	/* move slabp to correct slabp list: */
-	list_del(&slabp->list);
-	if (slabp->free == BUFCTL_END)
-		list_add(&slabp->list, &cachep->lists.slabs_full);
-	else
-		list_add(&slabp->list, &cachep->lists.slabs_partial);
+	if(nodeid == numa_node_id() || nodeid == -1)
+		return __cache_alloc(cachep, flags);

-	list3_data(cachep)->free_objects--;
-	spin_unlock_irq(&cachep->spinlock);
+	cache_alloc_debugcheck_before(cachep, flags);
+	local_irq_save(save_flags);
+	ptr = __cache_alloc_node(cachep, flags, nodeid);
+	local_irq_restore(save_flags);
+	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));

-	objp = cache_alloc_debugcheck_after(cachep, GFP_KERNEL, objp,
-					__builtin_return_address(0));
-	return objp;
+	return ptr;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);

@@ -2620,6 +3057,81 @@ unsigned int kmem_cache_size(kmem_cache_
 }
 EXPORT_SYMBOL(kmem_cache_size);

+/*
+ * This initializes kmem_list3 for all nodes.
+ */
+static int alloc_kmemlist(kmem_cache_t *cachep)
+{
+	int node, i;
+	struct kmem_list3 *l3;
+	int err = 0;
+
+	for(i=0; i < NR_CPUS; i++) {
+		if(cpu_online(i)) {
+			struct array_cache *nc = NULL, *new;
+#ifdef CONFIG_NUMA
+			struct array_cache **new_alien = NULL;
+#endif
+			node = cpu_to_node(i);
+#ifdef CONFIG_NUMA
+			if(!(new_alien = alloc_alien_cache(i, cachep->limit)))
+				goto fail;
+#endif
+			if(!(new = alloc_arraycache(i, (cachep->shared*
+					cachep->batchcount), 0xbaadf00d)))
+				goto fail;
+			if((l3 = cachep->nodelists[node])) {
+
+				spin_lock_irq(&l3->list_lock);
+
+				if((nc = cachep->nodelists[node]->shared))
+					free_block(cachep, nc->entry,
+							nc->avail);
+
+				l3->shared = new;
+#ifdef CONFIG_NUMA
+				if(!cachep->nodelists[node]->alien) {
+					l3->alien = new_alien;
+					new_alien = NULL;
+				}
+				l3->free_limit = (1 + nr_cpus_node(node))*
+					cachep->batchcount + cachep->num;
+#else
+				l3->free_limit = (1 + num_online_cpus())*
+					cachep->batchcount + cachep->num;
+#endif
+				spin_unlock_irq(&l3->list_lock);
+				kfree(nc);
+#ifdef CONFIG_NUMA
+				free_alien_cache(new_alien);
+#endif
+				continue;
+			}
+			if(!(l3 = kmalloc_node(sizeof(struct kmem_list3),
+							GFP_KERNEL, node)))
+				goto fail;
+
+			LIST3_INIT(l3);
+			l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+				((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+			l3->shared = new;
+#ifdef CONFIG_NUMA
+			l3->alien = new_alien;
+			l3->free_limit = (1 + nr_cpus_node(node))*
+				cachep->batchcount + cachep->num;
+#else
+			l3->free_limit = (1 + num_online_cpus())*
+				cachep->batchcount + cachep->num;
+#endif
+			cachep->nodelists[node] = l3;
+		}
+	}
+	return err;
+fail:
+	err = -ENOMEM;
+	return err;
+}
+
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
 	struct array_cache *new[NR_CPUS];
@@ -2642,8 +3154,7 @@ static int do_tune_cpucache(kmem_cache_t
 				int shared)
 {
 	struct ccupdate_struct new;
-	struct array_cache *new_shared;
-	int i;
+	int i, err;

 	memset(&new.new,0,sizeof(new.new));
 	for (i = 0; i < NR_CPUS; i++) {
@@ -2660,36 +3171,30 @@ static int do_tune_cpucache(kmem_cache_t
 	new.cachep = cachep;

 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-
+
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	cachep->batchcount = batchcount;
 	cachep->limit = limit;
-	cachep->free_limit = (1+num_online_cpus())*cachep->batchcount + cachep->num;
+	cachep->shared = shared;
 	spin_unlock_irq(&cachep->spinlock);

 	for (i = 0; i < NR_CPUS; i++) {
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
-		spin_lock_irq(&cachep->spinlock);
-		free_block(cachep, ac_entry(ccold), ccold->avail);
-		spin_unlock_irq(&cachep->spinlock);
+		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
+		free_block(cachep, ccold->entry, ccold->avail);
+		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
 		kfree(ccold);
 	}
-	new_shared = alloc_arraycache(-1, batchcount*shared, 0xbaadf00d);
-	if (new_shared) {
-		struct array_cache *old;
-
-		spin_lock_irq(&cachep->spinlock);
-		old = cachep->lists.shared;
-		cachep->lists.shared = new_shared;
-		if (old)
-			free_block(cachep, ac_entry(old), old->avail);
-		spin_unlock_irq(&cachep->spinlock);
-		kfree(old);
-	}

+	err = alloc_kmemlist(cachep);
+	if (err) {
+		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
+				cachep->name, -err);
+		BUG();
+	}
 	return 0;
 }

@@ -2747,11 +3252,11 @@ static void enable_cpucache(kmem_cache_t
 }

 static void drain_array_locked(kmem_cache_t *cachep,
-				struct array_cache *ac, int force)
+				struct array_cache *ac, int force, int node)
 {
 	int tofree;

-	check_spinlock_acquired(cachep);
+	check_spinlock_acquired_node(cachep, node);
 	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
@@ -2759,9 +3264,9 @@ static void drain_array_locked(kmem_cach
 		if (tofree > ac->avail) {
 			tofree = (ac->avail+1)/2;
 		}
-		free_block(cachep, ac_entry(ac), tofree);
+		free_block(cachep, ac->entry, tofree);
 		ac->avail -= tofree;
-		memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
+		memmove(ac->entry, &(ac->entry[tofree]),
 					sizeof(void*)*ac->avail);
 	}
 }
@@ -2780,6 +3285,7 @@ static void drain_array_locked(kmem_cach
 static void cache_reap(void *unused)
 {
 	struct list_head *walk;
+	struct kmem_list3 *l3;

 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
@@ -2800,27 +3306,35 @@ static void cache_reap(void *unused)

 		check_irq_on();

-		spin_lock_irq(&searchp->spinlock);
+		l3 = list3_data(searchp);
+#ifdef CONFIG_NUMA
+		if(l3->alien)
+			drain_alien_cache(searchp, l3);
+#endif
+
+		spin_lock_irq(&l3->list_lock);

-		drain_array_locked(searchp, ac_data(searchp), 0);
+		drain_array_locked(searchp, ac_data(searchp), 0,
+				numa_node_id());

-		if(time_after(searchp->lists.next_reap, jiffies))
+		if(time_after(l3->next_reap, jiffies))
 			goto next_unlock;

-		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
+		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;

-		if (searchp->lists.shared)
-			drain_array_locked(searchp, searchp->lists.shared, 0);
+		if (l3->shared)
+			drain_array_locked(searchp, l3->shared, 0,
+					numa_node_id());

-		if (searchp->lists.free_touched) {
-			searchp->lists.free_touched = 0;
+		if (l3->free_touched) {
+			l3->free_touched = 0;
 			goto next_unlock;
 		}

-		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
+		tofree = (l3->free_limit+5*searchp->num-1)/(5*searchp->num);
 		do {
-			p = list3_data(searchp)->slabs_free.next;
-			if (p == &(list3_data(searchp)->slabs_free))
+			p = l3->slabs_free.next;
+			if (p == &(l3->slabs_free))
 				break;

 			slabp = list_entry(p, struct slab, list);
@@ -2833,13 +3347,13 @@ static void cache_reap(void *unused)
 			 * searchp cannot disappear, we hold
 			 * cache_chain_lock
 			 */
-			searchp->lists.free_objects -= searchp->num;
-			spin_unlock_irq(&searchp->spinlock);
+			l3->free_objects -= searchp->num;
+			spin_unlock_irq(&l3->list_lock);
 			slab_destroy(searchp, slabp);
-			spin_lock_irq(&searchp->spinlock);
+			spin_lock_irq(&l3->list_lock);
 		} while(--tofree > 0);
 next_unlock:
-		spin_unlock_irq(&searchp->spinlock);
+		spin_unlock_irq(&l3->list_lock);
 next:
 		cond_resched();
 	}
@@ -2872,7 +3386,7 @@ static void *s_start(struct seq_file *m,
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"
-				" <error> <maxfreeable> <freelimit> <nodeallocs>");
+				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
 		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_putc(m, '\n');
@@ -2907,39 +3421,53 @@ static int s_show(struct seq_file *m, vo
 	unsigned long	active_objs;
 	unsigned long	num_objs;
 	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs;
-	const char *name;
+	unsigned long	num_slabs, free_objects = 0, shared_avail = 0;
+	const char *name;
 	char *error = NULL;
+	int i;
+	struct kmem_list3 *l3;

 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	list_for_each(q,&cachep->lists.slabs_full) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse != cachep->num && !error)
-			error = "slabs_full accounting error";
-		active_objs += cachep->num;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_partial) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse == cachep->num && !error)
-			error = "slabs_partial inuse accounting error";
-		if (!slabp->inuse && !error)
-			error = "slabs_partial/inuse accounting error";
-		active_objs += slabp->inuse;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_free) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse && !error)
-			error = "slabs_free/inuse accounting error";
-		num_slabs++;
+	for( i=0; i<MAX_NUMNODES; i++) {
+		l3 = cachep->nodelists[i];
+		if(!l3 || !is_node_online(i))
+			continue;
+
+		spin_lock(&l3->list_lock);
+
+		list_for_each(q,&l3->slabs_full) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse != cachep->num && !error)
+				error = "slabs_full accounting error";
+			active_objs += cachep->num;
+			active_slabs++;
+		}
+		list_for_each(q,&l3->slabs_partial) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse == cachep->num && !error)
+				error = "slabs_partial inuse accounting error";
+			if (!slabp->inuse && !error)
+				error = "slabs_partial/inuse accounting error";
+			active_objs += slabp->inuse;
+			active_slabs++;
+		}
+		list_for_each(q,&l3->slabs_free) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse && !error)
+				error = "slabs_free/inuse accounting error";
+			num_slabs++;
+		}
+		free_objects += l3->free_objects;
+		shared_avail += l3->shared->avail;
+
+		spin_unlock(&l3->list_lock);
 	}
 	num_slabs+=active_slabs;
 	num_objs = num_slabs*cachep->num;
-	if (num_objs - active_objs != cachep->lists.free_objects && !error)
+	if (num_objs - active_objs != free_objects && !error)
 		error = "free_objects accounting error";

 	name = cachep->name;
@@ -2951,9 +3479,9 @@ static int s_show(struct seq_file *m, vo
 		cachep->num, (1<<cachep->gfporder));
 	seq_printf(m, " : tunables %4u %4u %4u",
 			cachep->limit, cachep->batchcount,
-			cachep->lists.shared->limit/cachep->batchcount);
-	seq_printf(m, " : slabdata %6lu %6lu %6u",
-			active_slabs, num_slabs, cachep->lists.shared->avail);
+			cachep->shared);
+	seq_printf(m, " : slabdata %6lu %6lu %6lu",
+			active_slabs, num_slabs, shared_avail);
 #if STATS
 	{	/* list3 stats */
 		unsigned long high = cachep->high_mark;
@@ -2962,12 +3490,13 @@ static int s_show(struct seq_file *m, vo
 		unsigned long reaped = cachep->reaped;
 		unsigned long errors = cachep->errors;
 		unsigned long max_freeable = cachep->max_freeable;
-		unsigned long free_limit = cachep->free_limit;
 		unsigned long node_allocs = cachep->node_allocs;
+		unsigned long node_frees = cachep->node_frees;

-		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu %4lu",
-				allocs, high, grown, reaped, errors,
-				max_freeable, free_limit, node_allocs);
+		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu \
+				%4lu %4lu %4lu %4lu",
+				allocs, high, grown, reaped, errors,
+				max_freeable, node_allocs, node_frees);
 	}
 	/* cpu stats */
 	{
@@ -3048,7 +3577,8 @@ ssize_t slabinfo_write(struct file *file
 			    shared < 0) {
 				res = -EINVAL;
 			} else {
-				res = do_tune_cpucache(cachep, limit, batchcount, shared);
+				res = do_tune_cpucache(cachep, limit,
+						batchcount, shared);
 			}
 			break;
 		}
