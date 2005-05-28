Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVE1CDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVE1CDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 22:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVE1CDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 22:03:38 -0400
Received: from graphe.net ([209.204.138.32]:55264 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261965AbVE1CAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 22:00:14 -0400
Date: Fri, 27 May 2005 18:59:57 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, alokk@calsoftinc.com
Subject: NUMA aware slab allocator V4
In-Reply-To: <4293B292.6010301@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505271858060.27866@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net>
 <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com>
 <Pine.LNX.4.62.0505201210460.390@graphe.net> <428E56EE.4050400@us.ibm.com>
 <Pine.LNX.4.62.0505241436460.3878@graphe.net> <4293B292.6010301@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA API change that introduced kmalloc_node was accepted for 2.6.12-rc3.
Now it is possible to do slab allocations on a node to localize
memory structures.  This API was used by the pageset localization patch and
the block layer localization patch now in mm.  The existing kmalloc_node is
slow since it simply searches through all pages of the slab to find a page
that is on the node requested.  The two patches do a one time allocation of
slab structures at initialization and therefore the speed of kmalloc node
does not matter.

This patch allows kmalloc_node to be as fast as kmalloc by introducing node
specific page lists for partial, free and full slabs.  Slab allocation
improves in a NUMA system so that we are seeing a performance gain in AIM7
of about 5% with this patch alone.

More NUMA localizations are possible if kmalloc_node operates in an fast
way like kmalloc.

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

Links to earlier discussions:
http://marc.theaimsgroup.com/?t=111094594500003&r=1&w=2
http://marc.theaimsgroup.com/?t=111603406600002&r=1&w=2

Changelog V3-V4:
- Patch against 2.6.12-rc5-mm1
- Cleanup patch integrated
- More and better use of for_each_node and for_each_cpu
- GCC 2.95 fix (do not use [] use [0])
- Correct determination of INDEX_AC
- Remove hack to cause an error on platforms that have no CONFIG_NUMA but nodes.
- Remove list3_data and list3_data_ptr macros for better readability

Changelog V2-V3:
- Made to patch against 2.6.12-rc4-mm1
- Revised bootstrap mechanism so that larger size kmem_list3 structs can be
  supported. Do a generic solution so that the right slab can be found
  for the internal structs.
- use for_each_online_node

Changelog V1-V2:
- Batching for freeing of wrong-node objects (alien caches)
- Locking changes and NUMA #ifdefs as requested by Manfred

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.12-rc5/mm/slab.c
===================================================================
--- linux-2.6.12-rc5.orig/mm/slab.c	2005-05-27 19:51:43.000000000 +0000
+++ linux-2.6.12-rc5/mm/slab.c	2005-05-27 20:02:09.000000000 +0000
@@ -75,6 +75,14 @@
  *
  *	At present, each engine can be growing a cache.  This should be blocked.
  *
+ * 15 March 2005. NUMA slab allocator.
+ *	Shobhit Dayal <shobhit@calsoftinc.com>
+ *	Alok N Kataria <alokk@calsoftinc.com>
+ *	Christoph Lameter <christoph@lameter.com>
+ *
+ *	Modified the slab allocator to be node aware on NUMA systems.
+ *	Each node has its own list of partial, free and full slabs.
+ *	All object allocations for a node occur from node specific slab lists.
  */
 
 #include	<linux/config.h>
@@ -93,7 +101,7 @@
 #include	<linux/module.h>
 #include	<linux/rcupdate.h>
 #include	<linux/string.h>
-
+#include	<linux/nodemask.h>
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
 #include	<asm/tlbflush.h>
@@ -211,6 +219,9 @@
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* num of objs active in slab */
 	kmem_bufctl_t		free;
+#ifdef CONFIG_NUMA
+	unsigned short          nodeid;
+#endif
 };
 
 /*
@@ -253,6 +264,15 @@
 	unsigned int limit;
 	unsigned int batchcount;
 	unsigned int touched;
+#ifdef CONFIG_NUMA
+	spinlock_t lock;
+#endif
+	void *entry[0];		/*
+				 * Must have this definition in here for the proper
+				 * alignment of array_cache. Also simplifies accessing
+				 * the entries.
+				 * [0] is for gcc 2.95. It should really be [].
+				 */
 };
 
 /* bootstrap: The caches do not work without cpuarrays anymore,
@@ -265,34 +285,98 @@
 };
 
 /*
- * The slab lists of all objects.
- * Hopefully reduce the internal fragmentation
- * NUMA: The spinlock could be moved from the kmem_cache_t
- * into this structure, too. Figure out what causes
- * fewer cross-node spinlock operations.
+ * The slab lists for all objects.
  */
 struct kmem_list3 {
 	struct list_head	slabs_partial;	/* partial list first, better asm code */
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
+#define NUM_INIT_LISTS (2 + MAX_NUMNODES)
+struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
+#define	CACHE_CACHE 0
+#define	SIZE_AC 1
+#define	SIZE_L3 2
+
+/*
+ * This function may be completely optimized away if
+ * a constant is passed to it. Mostly the same as
+ * what is in linux/slab.h except it returns an
+ * index.
+ */
+static inline int index_of(const size_t size)
+{
+	int i = 0;
+
+#define CACHE(x) \
+	if (size <=x) \
+		return i; \
+	else \
+		i++;
+#include "linux/kmalloc_sizes.h"
+#undef CACHE
+	{
+		extern void __bad_size(void);
+		__bad_size();
+		return 0;
+	}
+}
+
+#define INDEX_AC index_of(sizeof(struct arraycache_init))
+#define INDEX_L3 index_of(sizeof(struct kmem_list3))
+
+#ifdef CONFIG_NUMA
+
 #define LIST3_INIT(parent) \
-	{ \
-		.slabs_full	= LIST_HEAD_INIT(parent.slabs_full), \
-		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
-		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
-	}
-#define list3_data(cachep) \
-	(&(cachep)->lists)
-
-/* NUMA: per-node */
-#define list3_data_ptr(cachep, ptr) \
-		list3_data(cachep)
+	do {	\
+		INIT_LIST_HEAD(&(parent)->slabs_full);	\
+		INIT_LIST_HEAD(&(parent)->slabs_partial);	\
+		INIT_LIST_HEAD(&(parent)->slabs_free);	\
+		(parent)->shared = NULL; \
+		(parent)->alien = NULL; \
+		(parent)->list_lock = SPIN_LOCK_UNLOCKED;	\
+		(parent)->free_objects = 0;	\
+		(parent)->free_touched = 0;	\
+	} while (0)
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
+	} while (0)
+#endif
+
+#define MAKE_LIST(cachep, listp, slab, nodeid)	\
+	do {	\
+		INIT_LIST_HEAD(listp);		\
+		list_splice(&(cachep->nodelists[nodeid]->slab), listp); \
+	} while (0)
+
+#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)			\
+	do {					\
+	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
+	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
+	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
+	} while (0)
 
 /*
  * kmem_cache_t
@@ -305,13 +389,12 @@
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
@@ -348,6 +431,7 @@
 	unsigned long 		errors;
 	unsigned long		max_freeable;
 	unsigned long		node_allocs;
+	unsigned long		node_frees;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
@@ -385,6 +469,7 @@
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
 #define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
+#define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { if ((x)->max_freeable < i) \
 					(x)->max_freeable = i; \
@@ -403,6 +488,7 @@
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
+#define	STATS_INC_NODEFREES(x)	do { } while (0)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { } while (0)
 
@@ -535,9 +621,9 @@
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.lists		= LIST3_INIT(cache_cache.lists),
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
+	.shared		= 1,
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
@@ -565,7 +651,8 @@
  */
 static enum {
 	NONE,
-	PARTIAL,
+	PARTIAL_AC,
+	PARTIAL_L3,
 	FULL
 } g_cpucache_up;
 
@@ -574,11 +661,7 @@
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
@@ -680,42 +763,152 @@
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
+	if (ac_ptr) {
+		for_each_node(i) {
+			if (i == node || !node_online(i)) {
+				ac_ptr[i] = NULL;
+				continue;
+			}
+			ac_ptr[i] = alloc_arraycache(cpu, limit, 0xbaadf00d);
+			if (!ac_ptr[i]) {
+				for (i--; i <=0; i--)
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
+	if (!ac_ptr)
+		return;
+
+	for_each_node(i)
+		kfree(ac_ptr[i]);
+
+	kfree(ac_ptr);
+}
+
+static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
+{
+	struct kmem_list3 *rl3 = cachep->nodelists[node];
+
+	if (ac->avail) {
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
+	for_each_online_node(i) {
+		ac = l3->alien[i];
+		if (ac) {
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
+				if (!(l3 = kmalloc_node(memsize,
+						GFP_KERNEL, node)))
+					goto bad;
+				LIST3_INIT(l3);
+				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+				  ((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
+				cachep->nodelists[node] = l3;
+			}
 
-			nc = alloc_arraycache(cpu, cachep->limit, cachep->batchcount);
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
+			if (!l3->shared) {
+				if (!(nc = alloc_arraycache(cpu,
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
@@ -730,13 +923,53 @@
 
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
+			if (!l3)
+				goto unlock_cache;
+
+			spin_lock(&l3->list_lock);
+
+			/* Free limit for this kmem_list3 */
+			l3->free_limit -= cachep->batchcount;
+			if (nc)
+				free_block(cachep, nc->entry, nc->avail);
+
+			if (!cpus_empty(mask)) {
+                                spin_unlock(&l3->list_lock);
+                                goto unlock_cache;
+                        }
+
+			if (l3->shared) {
+				free_block(cachep, l3->shared->entry,
+						l3->shared->avail);
+				kfree(l3->shared);
+				l3->shared = NULL;
+			}
+#ifdef CONFIG_NUMA
+			if (l3->alien) {
+				drain_alien_cache(cachep, l3);
+				free_alien_cache(l3->alien);
+				l3->alien = NULL;
+			}
+#endif
+
+			/* free slabs belonging to this node */
+			if (__node_shrink(cachep, node)) {
+				cachep->nodelists[node] = NULL;
+				spin_unlock(&l3->list_lock);
+				kfree(l3);
+			} else {
+				spin_unlock(&l3->list_lock);
+			}
+unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
 		}
@@ -752,6 +985,25 @@
 
 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
 
+/*
+ * swap the static kmem_list3 with kmalloced memory
+ */
+static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list,
+		int nodeid)
+{
+	struct kmem_list3 *ptr;
+
+	BUG_ON(cachep->nodelists[nodeid] != list);
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
@@ -760,6 +1012,13 @@
 	size_t left_over;
 	struct cache_sizes *sizes;
 	struct cache_names *names;
+	int i;
+
+	for (i = 0; i < NUM_INIT_LISTS; i++) {
+		LIST3_INIT(&initkmem_list3[i]);
+		if (i < MAX_NUMNODES)
+			cache_cache.nodelists[i] = NULL;
+	}
 
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
@@ -768,21 +1027,24 @@
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
@@ -791,6 +1053,7 @@
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
+	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];
 
 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());
 
@@ -808,15 +1071,33 @@
 	sizes = malloc_sizes;
 	names = cache_names;
 
+	/* Initialize the caches that provide memory for the array cache
+	 * and the kmem_list3 structures first.
+	 * Without this, further allocations will bug
+	 */
+
+	sizes[INDEX_AC].cs_cachep = kmem_cache_create(names[INDEX_AC].name,
+				sizes[INDEX_AC].cs_size, ARCH_KMALLOC_MINALIGN,
+				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+
+	if (INDEX_AC != INDEX_L3)
+		sizes[INDEX_L3].cs_cachep =
+			kmem_cache_create(names[INDEX_L3].name,
+				sizes[INDEX_L3].cs_size, ARCH_KMALLOC_MINALIGN,
+				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+
 	while (sizes->cs_size != ULONG_MAX) {
-		/* For performance, all the general caches are L1 aligned.
+		/*
+		 * For performance, all the general caches are L1 aligned.
 		 * This should be particularly beneficial on SMP boxes, as it
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
-		 * allow tighter packing of the smaller caches. */
-		sizes->cs_cachep = kmem_cache_create(names->name,
-			sizes->cs_size, ARCH_KMALLOC_MINALIGN,
-			(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+		 * allow tighter packing of the smaller caches.
+		 */
+		if(!sizes->cs_cachep)
+			sizes->cs_cachep = kmem_cache_create(names->name,
+				sizes->cs_size, ARCH_KMALLOC_MINALIGN,
+				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
@@ -835,24 +1116,46 @@
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
-		memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),
+		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)
+				!= &initarray_generic.cache);
+		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
 				sizeof(struct arraycache_init));
-		malloc_sizes[0].cs_cachep->array[smp_processor_id()] = ptr;
+		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
+						ptr;
 		local_irq_enable();
 	}
+	/* 5) Replace the bootstrap kmem_list3's */
+	{
+		int node;
+		/* Replace the static kmem_list3 structures for the boot cpu */
+		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
+				numa_node_id());
 
-	/* 5) resize the head arrays to their final sizes */
+		for_each_online_node(node) {
+				init_list(malloc_sizes[INDEX_L3].cs_cachep,
+						&initkmem_list3[SIZE_L3+node], node);
+		}
+		if (INDEX_AC != INDEX_L3) {
+			init_list(malloc_sizes[INDEX_AC].cs_cachep,
+					&initkmem_list3[SIZE_AC],
+					numa_node_id());
+		}
+	}
+
+	/* 6) resize the head arrays to their final sizes */
 	{
 		kmem_cache_t *cachep;
 		down(&cache_chain_sem);
@@ -868,7 +1171,6 @@
 	 * that initializes ac_data for all new cpus
 	 */
 	register_cpu_notifier(&cpucache_notifier);
-	
 
 	/* The reap timers are started later, with a module init call:
 	 * That part of the kernel is not yet operational.
@@ -883,10 +1185,8 @@
 	 * Register the timers that return unneeded
 	 * pages to gfp.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
-			start_cpu_timer(cpu);
-	}
+	for_each_online_cpu(cpu)
+		start_cpu_timer(cpu);
 
 	return 0;
 }
@@ -1165,6 +1465,20 @@
 	}
 }
 
+/* For setting up all the kmem_list3s for cache whose objsize is same
+   as size of kmem_list3. */
+static inline void set_up_list3s(kmem_cache_t *cachep)
+{
+	int node;
+
+	for_each_online_node(node) {
+		cachep->nodelists[node] = &initkmem_list3[SIZE_L3+node];
+		cachep->nodelists[node]->next_reap = jiffies +
+			REAPTIMEOUT_LIST3 +
+			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+	}
+}
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -1420,10 +1734,6 @@
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	/* NUMA */
-	INIT_LIST_HEAD(&cachep->lists.slabs_full);
-	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
-	INIT_LIST_HEAD(&cachep->lists.slabs_free);
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -1442,24 +1752,51 @@
 			 * the cache that's used by kmalloc(24), otherwise
 			 * the creation of further caches will BUG().
 			 */
-			cachep->array[smp_processor_id()] = &initarray_generic.cache;
-			g_cpucache_up = PARTIAL;
+			cachep->array[smp_processor_id()] =
+				&initarray_generic.cache;
+
+			/* If the cache that's used by
+			 * kmalloc(sizeof(kmem_list3)) is the first cache,
+			 * then we need to set up all its list3s, otherwise
+			 * the creation of further caches will BUG().
+			 */
+			if (INDEX_AC == INDEX_L3) {
+				set_up_list3s(cachep);
+				g_cpucache_up = PARTIAL_L3;
+			} else {
+				cachep->nodelists[numa_node_id()] =
+					&initkmem_list3[SIZE_AC];
+				g_cpucache_up = PARTIAL_AC;
+			}
 		} else {
-			cachep->array[smp_processor_id()] = kmalloc(sizeof(struct arraycache_init),GFP_KERNEL);
+			cachep->array[smp_processor_id()] =
+				kmalloc(sizeof(struct arraycache_init),
+						GFP_KERNEL);
+
+			if (g_cpucache_up == PARTIAL_AC) {
+				set_up_list3s(cachep);
+				g_cpucache_up = PARTIAL_L3;
+			} else {
+				cachep->nodelists[numa_node_id()] =
+					kmalloc(sizeof(struct kmem_list3),
+						GFP_KERNEL);
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
 	} 
 
-	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
-					((unsigned long)cachep/L1_CACHE_BYTES)%REAPTIMEOUT_LIST3;
 #if DEBUG
 	cachep->redzonetest = jiffies + REDZONETIMEOUT +
 					((unsigned long)cachep/L1_CACHE_BYTES)%REDZONETIMEOUT;
@@ -1521,13 +1858,23 @@
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	BUG_ON(spin_trylock(&cachep->spinlock));
+	assert_spin_locked(&cachep->nodelists[numa_node_id()]->list_lock);
+#endif
+}
+
+static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+{
+#ifdef CONFIG_SMP
+	check_irq_off();
+	assert_spin_locked(&cachep->nodelists[node]->list_lock);
 #endif
 }
+
 #else
 #define check_irq_off()	do { } while(0)
 #define check_irq_on()	do { } while(0)
 #define check_spinlock_acquired(x) do { } while(0)
+#define check_spinlock_acquired_node(x, y) do { } while(0)
 #endif
 
 /*
@@ -1549,7 +1896,7 @@
 }
 
 static void drain_array_locked(kmem_cache_t* cachep,
-				struct array_cache *ac, int force);
+				struct array_cache *ac, int force, int node);
 
 static void do_drain(void *arg)
 {
@@ -1558,59 +1905,84 @@
 
 	check_irq_off();
 	ac = ac_data(cachep);
-	spin_lock(&cachep->spinlock);
-	free_block(cachep, &ac_entry(ac)[0], ac->avail);
-	spin_unlock(&cachep->spinlock);
+	spin_lock(&cachep->nodelists[numa_node_id()]->list_lock);
+	free_block(cachep, ac->entry, ac->avail);
+	spin_unlock(&cachep->nodelists[numa_node_id()]->list_lock);
 	ac->avail = 0;
 }
 
 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
+	struct kmem_list3 *l3;
+	int node;
+
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	if (cachep->lists.shared)
-		drain_array_locked(cachep, cachep->lists.shared, 1);
+	for_each_online_node(node)  {
+		l3 = cachep->nodelists[node];
+		if (l3) {
+			spin_lock(&l3->list_lock);
+			drain_array_locked(cachep, l3->shared, 1, node);
+			spin_unlock(&l3->list_lock);
+#ifdef CONFIG_NUMA
+			if (l3->alien)
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
-	for(;;) {
+	for (;;) {
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
+	for_each_online_node(i) {
+		l3 = cachep->nodelists[i];
+		if (l3) {
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
@@ -1647,6 +2019,7 @@
 int kmem_cache_destroy(kmem_cache_t * cachep)
 {
 	int i;
+	struct kmem_list3 *l3;
 
 	if (!cachep || in_interrupt())
 		BUG();
@@ -1674,15 +2047,19 @@
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))
 		synchronize_rcu();
 
-	/* no cpu_online check required here since we clear the percpu
-	 * array on cpu offline and set this to NULL.
-	 */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_online_cpu(i)
 		kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
-	kfree(cachep->lists.shared);
-	cachep->lists.shared = NULL;
+	for_each_online_node(i) {
+		if ((l3 = cachep->nodelists[i])) {
+			kfree(l3->shared);
+#ifdef CONFIG_NUMA
+			free_alien_cache(l3->alien);
+#endif
+			kfree(l3);
+		}
+	}
 	kmem_cache_free(&cache_cache, cachep);
 
 	unlock_cpu_hotplug();
@@ -1692,8 +2069,8 @@
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep,
-			void *objp, int colour_off, unsigned int __nocast local_flags)
+static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
+			int colour_off, unsigned int __nocast local_flags)
 {
 	struct slab *slabp;
 	
@@ -1724,7 +2101,7 @@
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void* objp = slabp->s_mem+cachep->objsize*i;
+		void *objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -1801,6 +2178,7 @@
 	size_t		 offset;
 	unsigned int	 local_flags;
 	unsigned long	 ctor_flags;
+	struct kmem_list3 *l3;
 
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -1832,6 +2210,7 @@
 
 	spin_unlock(&cachep->spinlock);
 
+	check_irq_off();
 	if (local_flags & __GFP_WAIT)
 		local_irq_enable();
 
@@ -1843,8 +2222,9 @@
 	 */
 	kmem_flagcheck(cachep, flags);
 
-
-	/* Get mem for the objs. */
+	/* Get mem for the objs.
+	 * Attempt to allocate a physical page from 'nodeid',
+	 */
 	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
 		goto failed;
 
@@ -1852,6 +2232,9 @@
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
 
+#ifdef CONFIG_NUMA
+	slabp->nodeid = nodeid;
+#endif
 	set_slab_attr(cachep, slabp, objp);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
@@ -1859,13 +2242,14 @@
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
@@ -1971,7 +2355,6 @@
 	kmem_bufctl_t i;
 	int entries = 0;
 	
-	check_spinlock_acquired(cachep);
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
 		entries++;
@@ -2014,10 +2397,11 @@
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = list3_data(cachep);
+	l3 = cachep->nodelists[numa_node_id()];
+
+	BUG_ON(ac->avail > 0 || !l3);
+	spin_lock(&l3->list_lock);
 
-	BUG_ON(ac->avail > 0);
-	spin_lock(&cachep->spinlock);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		if (shared_array->avail) {
@@ -2025,8 +2409,9 @@
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
@@ -2053,7 +2438,8 @@
 			STATS_SET_HIGH(cachep);
 
 			/* get obj pointer */
-			ac_entry(ac)[ac->avail++] = slabp->s_mem + slabp->free*cachep->objsize;
+			ac->entry[ac->avail++] = slabp->s_mem +
+				slabp->free*cachep->objsize;
 
 			slabp->inuse++;
 			next = slab_bufctl(slabp)[slabp->free];
@@ -2075,12 +2461,12 @@
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
@@ -2090,7 +2476,7 @@
 			goto retry;
 	}
 	ac->touched = 1;
-	return ac_entry(ac)[--ac->avail];
+	return ac->entry[--ac->avail];
 }
 
 static inline void
@@ -2171,7 +2557,7 @@
 	if (likely(ac->avail)) {
 		STATS_INC_ALLOCHIT(cachep);
 		ac->touched = 1;
-		objp = ac_entry(ac)[--ac->avail];
+		objp = ac->entry[--ac->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
@@ -2181,29 +2567,102 @@
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
+ 	struct slab *slabp;
+ 	struct kmem_list3 *l3;
+ 	void *obj;
+ 	kmem_bufctl_t next;
+ 	int x;
 
+ 	l3 = cachep->nodelists[nodeid];
+ 	BUG_ON(!l3);
+
+retry:
+ 	spin_lock(&l3->list_lock);
+ 	entry = l3->slabs_partial.next;
+ 	if (entry == &l3->slabs_partial) {
+ 		l3->free_touched = 1;
+ 		entry = l3->slabs_free.next;
+ 		if (entry == &l3->slabs_free)
+ 			goto must_grow;
+ 	}
+
+ 	slabp = list_entry(entry, struct slab, list);
+ 	check_spinlock_acquired_node(cachep, nodeid);
+ 	check_slabp(cachep, slabp);
+
+ 	STATS_INC_NODEALLOCS(cachep);
+ 	STATS_INC_ACTIVE(cachep);
+ 	STATS_SET_HIGH(cachep);
+
+ 	BUG_ON(slabp->inuse == cachep->num);
+
+ 	/* get obj pointer */
+ 	obj =  slabp->s_mem + slabp->free*cachep->objsize;
+ 	slabp->inuse++;
+ 	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+ 	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
+#endif
+ 	slabp->free = next;
+ 	check_slabp(cachep, slabp);
+ 	l3->free_objects--;
+ 	/* move slabp to correct slabp list: */
+ 	list_del(&slabp->list);
+
+ 	if (slabp->free == BUFCTL_END) {
+ 		list_add(&slabp->list, &l3->slabs_full);
+ 	} else {
+ 		list_add(&slabp->list, &l3->slabs_partial);
+ 	}
+
+ 	spin_unlock(&l3->list_lock);
+ 	goto done;
+
+must_grow:
+ 	spin_unlock(&l3->list_lock);
+ 	x = cache_grow(cachep, flags, nodeid);
+
+ 	if (!x)
+ 		return NULL;
+
+ 	goto retry;
+done:
+ 	return obj;
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
+
 #if 0	/* disabled, not compatible with leak detection */
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
 			printk(KERN_ERR "slab: double free detected in cache "
@@ -2215,24 +2674,23 @@
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
@@ -2240,36 +2698,38 @@
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
+	l3 = cachep->nodelists[numa_node_id()];
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
@@ -2281,12 +2741,13 @@
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
@@ -2301,14 +2762,46 @@
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
+	/* Make sure we are not freeing a object from another
+	 * node to the array cache on this cpu.
+	 */
+#ifdef CONFIG_NUMA
+	{
+		struct slab *slabp;
+		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		if (unlikely(slabp->nodeid != numa_node_id())) {
+			struct array_cache *alien = NULL;
+			int nodeid = slabp->nodeid;
+			struct kmem_list3 *l3 = cachep->nodelists[numa_node_id()];
+
+			STATS_INC_NODEFREES(cachep);
+			if (l3->alien && l3->alien[nodeid]) {
+				alien = l3->alien[nodeid];
+				spin_lock(&alien->lock);
+				if (unlikely(alien->avail == alien->limit))
+					__drain_alien_cache(cachep,
+							alien, nodeid);
+				alien->entry[alien->avail++] = objp;
+				spin_unlock(&alien->lock);
+			} else {
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
 
@@ -2378,78 +2871,24 @@
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
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
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
+	if (nodeid == numa_node_id() || nodeid == -1)
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
 
@@ -2519,11 +2958,18 @@
 	if (!pdata)
 		return NULL;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL,
-						cpu_to_node(i));
+	/*
+	 * Cannot use for_each_online_cpu since a cpu may come online
+	 * and we have no way of figuring out how to fix the array
+	 * that we have allocated then....
+	 */
+	for_each_cpu(i) {
+		int node = cpu_to_node(i);
+
+		if (node_online(node))
+			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, node);
+		else
+			pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
 
 		if (!pdata->ptrs[i])
 			goto unwind_oom;
@@ -2619,11 +3065,11 @@
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	/*
+	 * We allocate for all cpus so we cannot use for online cpu here.
+	 */
+	for_each_cpu(i)
 		kfree(p->ptrs[i]);
-	}
 	kfree(p);
 }
 EXPORT_SYMBOL(free_percpu);
@@ -2679,43 +3125,124 @@
 {
 	struct list_head *q;
 	struct slab *slabp;
+	int node;
+	struct kmem_list3 *l3;
 
 	check_spinlock_acquired(cachep);
 
-	list_for_each(q,&cachep->lists.slabs_full) {
-		slabp = list_entry(q, struct slab, list);
+	for_each_online_node(node) {
+		l3 = cachep->nodelists[node];
+		if (!l3)
+			continue;
+
+		list_for_each(q,&l3->slabs_full) {
+			slabp = list_entry(q, struct slab, list);
 
-		if (slabp->inuse != cachep->num) {
-			printk(KERN_INFO "slab %s: wrong slabp found in full slab chain at %p (%d/%d).\n",
-					cachep->name, slabp, slabp->inuse, cachep->num);
+			if (slabp->inuse != cachep->num) {
+				printk(KERN_INFO "slab %s: wrong slabp found in full slab chain at %p (%d/%d).\n",
+						cachep->name, slabp, slabp->inuse, cachep->num);
+			}
+			check_slabp(cachep, slabp);
+			check_slabuse(cachep, slabp);
 		}
-		check_slabp(cachep, slabp);
-		check_slabuse(cachep, slabp);
-	}
-	list_for_each(q,&cachep->lists.slabs_partial) {
-		slabp = list_entry(q, struct slab, list);
+		list_for_each(q,&l3->slabs_partial) {
+			slabp = list_entry(q, struct slab, list);
 
-		if (slabp->inuse == cachep->num || slabp->inuse == 0) {
-			printk(KERN_INFO "slab %s: wrong slab found in partial chain at %p (%d/%d).\n",
-					cachep->name, slabp, slabp->inuse, cachep->num);
+			if (slabp->inuse == cachep->num || slabp->inuse == 0) {
+				printk(KERN_INFO "slab %s: wrong slab found in partial chain at %p (%d/%d).\n",
+						cachep->name, slabp, slabp->inuse, cachep->num);
+			}
+			check_slabp(cachep, slabp);
+			check_slabuse(cachep, slabp);
 		}
-		check_slabp(cachep, slabp);
-		check_slabuse(cachep, slabp);
-	}
-	list_for_each(q,&cachep->lists.slabs_free) {
-		slabp = list_entry(q, struct slab, list);
+		list_for_each(q,&l3->slabs_free) {
+			slabp = list_entry(q, struct slab, list);
 
-		if (slabp->inuse != 0) {
-			printk(KERN_INFO "slab %s: wrong slab found in free chain at %p (%d/%d).\n",
-					cachep->name, slabp, slabp->inuse, cachep->num);
+			if (slabp->inuse != 0) {
+				printk(KERN_INFO "slab %s: wrong slab found in free chain at %p (%d/%d).\n",
+						cachep->name, slabp, slabp->inuse, cachep->num);
+			}
+			check_slabp(cachep, slabp);
+			check_slabuse(cachep, slabp);
 		}
-		check_slabp(cachep, slabp);
-		check_slabuse(cachep, slabp);
 	}
 }
 
 #endif
 
+/*
+ * This initializes kmem_list3 for all nodes.
+ */
+static int alloc_kmemlist(kmem_cache_t *cachep)
+{
+	int node, i;
+	struct kmem_list3 *l3;
+	int err = 0;
+
+	for_each_online_cpu(i) {
+		struct array_cache *nc = NULL, *new;
+#ifdef CONFIG_NUMA
+		struct array_cache **new_alien = NULL;
+#endif
+		node = cpu_to_node(i);
+#ifdef CONFIG_NUMA
+		if (!(new_alien = alloc_alien_cache(i, cachep->limit)))
+			goto fail;
+#endif
+		if (!(new = alloc_arraycache(i, (cachep->shared*
+				cachep->batchcount), 0xbaadf00d)))
+			goto fail;
+		if ((l3 = cachep->nodelists[node])) {
+
+			spin_lock_irq(&l3->list_lock);
+
+			if ((nc = cachep->nodelists[node]->shared))
+				free_block(cachep, nc->entry,
+							nc->avail);
+
+			l3->shared = new;
+#ifdef CONFIG_NUMA
+			if (!cachep->nodelists[node]->alien) {
+				l3->alien = new_alien;
+				new_alien = NULL;
+			}
+			l3->free_limit = (1 + nr_cpus_node(node))*
+				cachep->batchcount + cachep->num;
+#else
+			l3->free_limit = (1 + num_online_cpus())*
+				cachep->batchcount + cachep->num;
+#endif
+			spin_unlock_irq(&l3->list_lock);
+			kfree(nc);
+#ifdef CONFIG_NUMA
+			free_alien_cache(new_alien);
+#endif
+			continue;
+		}
+		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
+						GFP_KERNEL, node)))
+			goto fail;
+
+		LIST3_INIT(l3);
+		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+		l3->shared = new;
+#ifdef CONFIG_NUMA
+		l3->alien = new_alien;
+		l3->free_limit = (1 + nr_cpus_node(node))*
+			cachep->batchcount + cachep->num;
+#else
+		l3->free_limit = (1 + num_online_cpus())*
+			cachep->batchcount + cachep->num;
+#endif
+		cachep->nodelists[node] = l3;
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
@@ -2738,54 +3265,43 @@
 				int shared)
 {
 	struct ccupdate_struct new;
-	struct array_cache *new_shared;
-	int i;
+	int i, err;
 
 	memset(&new.new,0,sizeof(new.new));
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i)) {
-			new.new[i] = alloc_arraycache(i, limit, batchcount);
-			if (!new.new[i]) {
-				for (i--; i >= 0; i--) kfree(new.new[i]);
-				return -ENOMEM;
-			}
-		} else {
-			new.new[i] = NULL;
+	for_each_online_cpu(i) {
+		new.new[i] = alloc_arraycache(i, limit, batchcount);
+		if (!new.new[i]) {
+			for (i--; i >= 0; i--) kfree(new.new[i]);
+			return -ENOMEM;
 		}
 	}
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
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_online_cpu(i) {
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
 
@@ -2843,11 +3359,11 @@
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
@@ -2855,9 +3371,9 @@
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
@@ -2876,6 +3392,7 @@
 static void cache_reap(void *unused)
 {
 	struct list_head *walk;
+	struct kmem_list3 *l3;
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
@@ -2896,33 +3413,40 @@
 
 		check_irq_on();
 
-		spin_lock_irq(&searchp->spinlock);
+		l3 = searchp->nodelists[numa_node_id()];
+#ifdef CONFIG_NUMA
+		if (l3->alien)
+			drain_alien_cache(searchp, l3);
+#endif
+		spin_lock_irq(&l3->list_lock);
 
-		drain_array_locked(searchp, ac_data(searchp), 0);
+		drain_array_locked(searchp, ac_data(searchp), 0,
+				numa_node_id());
 
 #if DEBUG
-		if(time_before(searchp->redzonetest, jiffies)) {
+		if (time_before(searchp->redzonetest, jiffies)) {
 			searchp->redzonetest = jiffies + REDZONETIMEOUT;
 			check_redzone(searchp);
 		}
 #endif
-		if(time_after(searchp->lists.next_reap, jiffies))
+		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
 
-		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
+		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
 
-		if (searchp->lists.shared)
-			drain_array_locked(searchp, searchp->lists.shared, 0);
+		if (l3->shared)
+			drain_array_locked(searchp, l3->shared, 0,
+				numa_node_id());
 
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
@@ -2935,13 +3459,13 @@
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
@@ -2974,7 +3498,7 @@
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"
-				" <error> <maxfreeable> <freelimit> <nodeallocs>");
+				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
 		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_putc(m, '\n');
@@ -3009,39 +3533,53 @@
 	unsigned long	active_objs;
 	unsigned long	num_objs;
 	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs;
-	const char *name; 
+	unsigned long	num_slabs, free_objects = 0, shared_avail = 0;
+	const char *name;
 	char *error = NULL;
+	int node;
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
+	for_each_online_node(node) {
+		l3 = cachep->nodelists[node];
+		if (!l3)
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
@@ -3053,9 +3591,9 @@
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
@@ -3064,12 +3602,13 @@
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
@@ -3112,19 +3651,27 @@
 {
 #if DEBUG
 	struct list_head *q;
+	int node;
+	struct kmem_list3 *l3;
 
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	list_for_each(q,&cachep->lists.slabs_full) {
-		struct slab *slabp;
-		int i;
-		slabp = list_entry(q, struct slab, list);
-		for (i = 0; i < cachep->num; i++) {
-			unsigned long sym = slab_bufctl(slabp)[i];
+	for_each_online_node(node) {
+		l3 = cachep->nodelists[node];
+		if (!l3)
+			continue;
 
-			printk("obj %p/%d: %p", slabp, i, (void *)sym);
-			print_symbol(" <%s>", sym);
-			printk("\n");
+		list_for_each(q,&l3->slabs_full) {
+			struct slab *slabp;
+			int i;
+			slabp = list_entry(q, struct slab, list);
+			for (i = 0; i < cachep->num; i++) {
+				unsigned long sym = slab_bufctl(slabp)[i];
+
+				printk("obj %p/%d: %p", slabp, i, (void *)sym);
+				print_symbol(" <%s>", sym);
+				printk("\n");
+			}
 		}
 	}
 	spin_unlock_irq(&cachep->spinlock);
