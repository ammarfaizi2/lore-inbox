Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVKJX66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVKJX66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKJX66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:58:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:47289 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932228AbVKJX64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:58:56 -0500
Message-ID: <4373DEBD.7050408@us.ibm.com>
Date: Thu, 10 Nov 2005 15:58:53 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] Use 'nid'
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020508000806090405000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508000806090405000408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rather than various and sundry names for a node's number, let's use 'nid'.

-Matt

--------------020508000806090405000408
Content-Type: text/x-patch;
 name="use_nid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use_nid.patch"

In this file we refer to a node's number as 'nodeid', 'node', and 'nid'.
'nid' is more common than 'nodeid' or 'node' when referring to a node number
in VM code, so, for consistency, change mm/slab.c to reflect this.

Also, save a few dozen characters. :)

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:34:13.565492104 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:43:36.926848160 -0800
@@ -221,7 +221,7 @@ struct slab {
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* # of objs active in slab */
 	kmem_bufctl_t		free;
-	unsigned short          nodeid;
+	unsigned short          nid;		/* node number slab is on */
 };
 
 /*
@@ -350,17 +350,17 @@ static inline void kmem_list3_init(struc
 	parent->free_touched = 0;
 }
 
-#define MAKE_LIST(cachep, listp, slab, nodeid)				\
+#define MAKE_LIST(cachep, listp, slab, nid)				\
 	do {								\
 		INIT_LIST_HEAD(listp);					\
-		list_splice(&(cachep->nodelists[nodeid]->slab), listp);	\
+		list_splice(&(cachep->nodelists[nid]->slab), listp);	\
 	} while (0)
 
-#define MAKE_ALL_LISTS(cachep, ptr, nodeid)				\
+#define MAKE_ALL_LISTS(cachep, ptr, nid)				\
 	do {								\
-	MAKE_LIST((cachep), &(ptr)->slabs_full, slabs_full, nodeid);	\
-	MAKE_LIST((cachep), &(ptr)->slabs_partial, slabs_partial, nodeid);\
-	MAKE_LIST((cachep), &(ptr)->slabs_free, slabs_free, nodeid);	\
+	MAKE_LIST((cachep), &(ptr)->slabs_full, slabs_full, nid);	\
+	MAKE_LIST((cachep), &(ptr)->slabs_partial, slabs_partial, nid);\
+	MAKE_LIST((cachep), &(ptr)->slabs_free, slabs_free, nid);	\
 	} while (0)
 
 /*
@@ -640,10 +640,10 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t *cachep, void **objpp, int len, int node);
+static void free_block(kmem_cache_t *cachep, void **objpp, int len, int nid);
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
-static int __node_shrink(kmem_cache_t *cachep, int node);
+static int __node_shrink(kmem_cache_t *cachep, int nid);
 
 static inline struct array_cache *ac_data(kmem_cache_t *cachep)
 {
@@ -739,13 +739,13 @@ static void __devinit start_cpu_timer(in
 	}
 }
 
-static struct array_cache *alloc_arraycache(int node, int entries,
+static struct array_cache *alloc_arraycache(int nid, int entries,
 					    int batchcount)
 {
 	int memsize = sizeof(void *) * entries + sizeof(struct array_cache);
 	struct array_cache *nc = NULL;
 
-	nc = kmalloc_node(memsize, GFP_KERNEL, node);
+	nc = kmalloc_node(memsize, GFP_KERNEL, nid);
 	if (nc) {
 		nc->avail = 0;
 		nc->limit = entries;
@@ -757,7 +757,7 @@ static struct array_cache *alloc_arrayca
 }
 
 #ifdef CONFIG_NUMA
-static inline struct array_cache **alloc_alien_cache(int node, int limit)
+static inline struct array_cache **alloc_alien_cache(int nid, int limit)
 {
 	struct array_cache **ac_ptr;
 	int memsize = sizeof(void *) * MAX_NUMNODES;
@@ -765,14 +765,14 @@ static inline struct array_cache **alloc
 
 	if (limit > 1)
 		limit = 12;
-	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
+	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, nid);
 	if (ac_ptr) {
 		for_each_node(i) {
-			if (i == node || !node_online(i)) {
+			if (i == nid || !node_online(i)) {
 				ac_ptr[i] = NULL;
 				continue;
 			}
-			ac_ptr[i] = alloc_arraycache(node, limit, 0xbaadf00d);
+			ac_ptr[i] = alloc_arraycache(nid, limit, 0xbaadf00d);
 			if (!ac_ptr[i]) {
 				for (i--; i <= 0; i--)
 					kfree(ac_ptr[i]);
@@ -798,13 +798,13 @@ static inline void free_alien_cache(stru
 }
 
 static inline void __drain_alien_cache(kmem_cache_t *cachep,
-				       struct array_cache *ac, int node)
+				       struct array_cache *ac, int nid)
 {
-	struct kmem_list3 *rl3 = cachep->nodelists[node];
+	struct kmem_list3 *rl3 = cachep->nodelists[nid];
 
 	if (ac->avail) {
 		spin_lock(&rl3->list_lock);
-		free_block(cachep, ac->entry, ac->avail, node);
+		free_block(cachep, ac->entry, ac->avail, nid);
 		ac->avail = 0;
 		spin_unlock(&rl3->list_lock);
 	}
@@ -826,7 +826,7 @@ static void drain_alien_cache(kmem_cache
 	}
 }
 #else
-#define alloc_alien_cache(node, limit)	do { } while (0)
+#define alloc_alien_cache(nid, limit)	do { } while (0)
 #define free_alien_cache(ac_ptr)	do { } while (0)
 #define drain_alien_cache(cachep, l3)	do { } while (0)
 #endif
@@ -837,7 +837,7 @@ static int __devinit cpuup_callback(stru
 	long cpu = (long)hcpu;
 	kmem_cache_t *cachep;
 	struct kmem_list3 *l3 = NULL;
-	int node = cpu_to_node(cpu);
+	int nid = cpu_to_node(cpu);
 	int memsize = sizeof(struct kmem_list3);
 	struct array_cache *nc = NULL;
 
@@ -856,36 +856,36 @@ static int __devinit cpuup_callback(stru
 			 * begin anything. Make sure some other cpu on this
 			 * node has not already allocated this
 			 */
-			if (!cachep->nodelists[node]) {
+			if (!cachep->nodelists[nid]) {
 				if (!(l3 = kmalloc_node(memsize, GFP_KERNEL,
-							node)))
+							nid)))
 					goto bad;
 				kmem_list3_init(l3);
 				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 				  ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
-				cachep->nodelists[node] = l3;
+				cachep->nodelists[nid] = l3;
 			}
 
-			spin_lock_irq(&cachep->nodelists[node]->list_lock);
-			cachep->nodelists[node]->free_limit =
-				(1 + nr_cpus_node(node)) *
+			spin_lock_irq(&cachep->nodelists[nid]->list_lock);
+			cachep->nodelists[nid]->free_limit =
+				(1 + nr_cpus_node(nid)) *
 				cachep->batchcount + cachep->num;
-			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
+			spin_unlock_irq(&cachep->nodelists[nid]->list_lock);
 		}
 
 		/* Now we can allocate the shared arrays & array caches */
 		list_for_each_entry(cachep, &cache_chain, next) {
-			nc = alloc_arraycache(node, cachep->limit,
+			nc = alloc_arraycache(nid, cachep->limit,
 					      cachep->batchcount);
 			if (!nc)
 				goto bad;
 			cachep->array[cpu] = nc;
 
-			l3 = cachep->nodelists[node];
+			l3 = cachep->nodelists[nid];
 			BUG_ON(!l3);
 			if (!l3->shared) {
-				if (!(nc = alloc_arraycache(node,
+				if (!(nc = alloc_arraycache(nid,
 					cachep->shared * cachep->batchcount,
 					0xbaadf00d)))
 					goto bad;
@@ -912,12 +912,12 @@ static int __devinit cpuup_callback(stru
 			struct array_cache *nc;
 			cpumask_t mask;
 
-			mask = node_to_cpumask(node);
+			mask = node_to_cpumask(nid);
 			spin_lock_irq(&cachep->spinlock);
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
-			l3 = cachep->nodelists[node];
+			l3 = cachep->nodelists[nid];
 
 			if (!l3)
 				goto unlock_cache;
@@ -927,7 +927,7 @@ static int __devinit cpuup_callback(stru
 			/* Free limit for this kmem_list3 */
 			l3->free_limit -= cachep->batchcount;
 			if (nc)
-				free_block(cachep, nc->entry, nc->avail, node);
+				free_block(cachep, nc->entry, nc->avail, nid);
 
 			if (!cpus_empty(mask)) {
 				spin_unlock(&l3->list_lock);
@@ -936,7 +936,7 @@ static int __devinit cpuup_callback(stru
 
 			if (l3->shared) {
 				free_block(cachep, l3->shared->entry,
-					   l3->shared->avail, node);
+					   l3->shared->avail, nid);
 				kfree(l3->shared);
 				l3->shared = NULL;
 			}
@@ -947,8 +947,8 @@ static int __devinit cpuup_callback(stru
 			}
 
 			/* free slabs belonging to this node */
-			if (__node_shrink(cachep, node)) {
-				cachep->nodelists[node] = NULL;
+			if (__node_shrink(cachep, nid)) {
+				cachep->nodelists[nid] = NULL;
 				spin_unlock(&l3->list_lock);
 				kfree(l3);
 			} else {
@@ -973,18 +973,18 @@ static struct notifier_block cpucache_no
 /*
  * swap the static kmem_list3 with kmalloced memory
  */
-static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list, int nodeid)
+static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list, int nid)
 {
 	struct kmem_list3 *ptr;
 
-	BUG_ON(cachep->nodelists[nodeid] != list);
-	ptr = kmalloc_node(sizeof(struct kmem_list3), GFP_KERNEL, nodeid);
+	BUG_ON(cachep->nodelists[nid] != list);
+	ptr = kmalloc_node(sizeof(struct kmem_list3), GFP_KERNEL, nid);
 	BUG_ON(!ptr);
 
 	local_irq_disable();
 	memcpy(ptr, list, sizeof(struct kmem_list3));
-	MAKE_ALL_LISTS(cachep, ptr, nodeid);
-	cachep->nodelists[nodeid] = ptr;
+	MAKE_ALL_LISTS(cachep, ptr, nid);
+	cachep->nodelists[nid] = ptr;
 	local_irq_enable();
 }
 
@@ -1125,18 +1125,18 @@ void __init kmem_cache_init(void)
 	}
 	/* 5) Replace the bootstrap kmem_list3's */
 	{
-		int node;
+		int nid;
 		/* Replace the static kmem_list3 structures for the boot cpu */
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
 			  numa_node_id());
 
-		for_each_online_node(node) {
+		for_each_online_node(nid) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
-				  &initkmem_list3[SIZE_AC+node], node);
+				  &initkmem_list3[SIZE_AC+nid], nid);
 
 			if (INDEX_AC != INDEX_L3)
 				init_list(malloc_sizes[INDEX_L3].cs_cachep,
-					  &initkmem_list3[SIZE_L3+node], node);
+					  &initkmem_list3[SIZE_L3+nid], nid);
 		}
 	}
 
@@ -1183,17 +1183,17 @@ __initcall(cpucache_init);
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
  */
-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nid)
 {
 	struct page *page;
 	void *addr;
 	int i;
 
 	flags |= cachep->gfpflags;
-	if (likely(nodeid == -1))
+	if (likely(nid == -1))
 		page = alloc_pages(flags, cachep->gfporder);
 	else
-		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+		page = alloc_pages_node(nid, flags, cachep->gfporder);
 	if (!page)
 		return NULL;
 	addr = page_address(page);
@@ -1452,11 +1452,11 @@ static void slab_destroy(kmem_cache_t *c
  */
 static inline void set_up_list3s(kmem_cache_t *cachep, int index)
 {
-	int node;
+	int nid;
 
-	for_each_online_node(node) {
-		cachep->nodelists[node] = &initkmem_list3[index + node];
-		cachep->nodelists[node]->next_reap = jiffies +
+	for_each_online_node(nid) {
+		cachep->nodelists[nid] = &initkmem_list3[index + nid];
+		cachep->nodelists[nid]->next_reap = jiffies +
 			REAPTIMEOUT_LIST3 +
 			((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 	}
@@ -1764,13 +1764,13 @@ next:
 				set_up_list3s(cachep, SIZE_L3);
 				g_cpucache_up = PARTIAL_L3;
 			} else {
-				int node;
-				for_each_online_node(node) {
-					cachep->nodelists[node] =
+				int nid;
+				for_each_online_node(nid) {
+					cachep->nodelists[nid] =
 						kmalloc_node(sizeof(struct kmem_list3),
-							     GFP_KERNEL, node);
-					BUG_ON(!cachep->nodelists[node]);
-					kmem_list3_init(cachep->nodelists[node]);
+							     GFP_KERNEL, nid);
+					BUG_ON(!cachep->nodelists[nid]);
+					kmem_list3_init(cachep->nodelists[nid]);
 				}
 			}
 		}
@@ -1850,11 +1850,11 @@ static void check_spinlock_acquired(kmem
 #endif
 }
 
-static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int nid)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[node]->list_lock);
+	assert_spin_locked(&cachep->nodelists[nid]->list_lock);
 #endif
 }
 
@@ -1884,35 +1884,35 @@ static void smp_call_function_all_cpus(v
 }
 
 static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
-			       int force, int node);
+			       int force, int nid);
 
 static void do_drain(void *arg)
 {
 	kmem_cache_t *cachep = (kmem_cache_t *)arg;
 	struct array_cache *ac;
-	int node = numa_node_id();
+	int nid = numa_node_id();
 
 	check_irq_off();
 	ac = ac_data(cachep);
-	spin_lock(&cachep->nodelists[node]->list_lock);
-	free_block(cachep, ac->entry, ac->avail, node);
-	spin_unlock(&cachep->nodelists[node]->list_lock);
+	spin_lock(&cachep->nodelists[nid]->list_lock);
+	free_block(cachep, ac->entry, ac->avail, nid);
+	spin_unlock(&cachep->nodelists[nid]->list_lock);
 	ac->avail = 0;
 }
 
 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
 	struct kmem_list3 *l3;
-	int node;
+	int nid;
 
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	for_each_online_node(node) {
-		l3 = cachep->nodelists[node];
+	for_each_online_node(nid) {
+		l3 = cachep->nodelists[nid];
 		if (l3) {
 			spin_lock(&l3->list_lock);
-			drain_array_locked(cachep, l3->shared, 1, node);
+			drain_array_locked(cachep, l3->shared, 1, nid);
 			spin_unlock(&l3->list_lock);
 			if (l3->alien)
 				drain_alien_cache(cachep, l3);
@@ -1921,10 +1921,10 @@ static void drain_cpu_caches(kmem_cache_
 	spin_unlock_irq(&cachep->spinlock);
 }
 
-static int __node_shrink(kmem_cache_t *cachep, int node)
+static int __node_shrink(kmem_cache_t *cachep, int nid)
 {
 	struct slab *slabp;
-	struct kmem_list3 *l3 = cachep->nodelists[node];
+	struct kmem_list3 *l3 = cachep->nodelists[nid];
 	int ret;
 
 	for (;;) {
@@ -2162,7 +2162,7 @@ static void set_slab_attr(kmem_cache_t *
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nid)
 {
 	struct slab *slabp;
 	void *objp;
@@ -2214,15 +2214,15 @@ static int cache_grow(kmem_cache_t *cach
 	 */
 	kmem_flagcheck(cachep, flags);
 
-	/* Get mem for the objects by allocating a physical page from 'nodeid' */
-	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
+	/* Get mem for the objects by allocating a physical page from 'nid' */
+	if (!(objp = kmem_getpages(cachep, flags, nid)))
 		goto out_nomem;
 
 	/* Get slab management. */
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto out_freepages;
 
-	slabp->nodeid = nodeid;
+	slabp->nid = nid;
 	set_slab_attr(cachep, slabp, objp);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
@@ -2230,7 +2230,7 @@ static int cache_grow(kmem_cache_t *cach
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	check_irq_off();
-	l3 = cachep->nodelists[nodeid];
+	l3 = cachep->nodelists[nid];
 	spin_lock(&l3->list_lock);
 
 	/* Make slab active. */
@@ -2573,9 +2573,9 @@ static inline void *__cache_alloc(kmem_c
 
 #ifdef CONFIG_NUMA
 /*
- * A interface to enable slab creation on nodeid
+ * A interface to enable slab creation on nid
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
+static void *__cache_alloc_node(kmem_cache_t *cachep, int flags, int nid)
 {
 	struct list_head *entry;
 	struct slab *slabp;
@@ -2584,7 +2584,7 @@ static void *__cache_alloc_node(kmem_cac
 	kmem_bufctl_t next;
 	int x;
 
-	l3 = cachep->nodelists[nodeid];
+	l3 = cachep->nodelists[nid];
 	BUG_ON(!l3);
 
 retry:
@@ -2598,7 +2598,7 @@ retry:
 	}
 
 	slabp = list_entry(entry, struct slab, list);
-	check_spinlock_acquired_node(cachep, nodeid);
+	check_spinlock_acquired_node(cachep, nid);
 	check_slabp(cachep, slabp);
 
 	STATS_INC_NODEALLOCS(cachep);
@@ -2631,7 +2631,7 @@ retry:
 
 must_grow:
 	spin_unlock(&l3->list_lock);
-	x = cache_grow(cachep, flags, nodeid);
+	x = cache_grow(cachep, flags, nid);
 
 	if (!x)
 		return NULL;
@@ -2646,7 +2646,7 @@ done:
  * Caller needs to acquire correct kmem_list's list_lock
  */
 static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects,
-		       int node)
+		       int nid)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2657,10 +2657,10 @@ static void free_block(kmem_cache_t *cac
 		unsigned int objnr;
 
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
-		l3 = cachep->nodelists[node];
+		l3 = cachep->nodelists[nid];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
-		check_spinlock_acquired_node(cachep, node);
+		check_spinlock_acquired_node(cachep, nid);
 		check_slabp(cachep, slabp);
 
 #if DEBUG
@@ -2700,14 +2700,14 @@ static void cache_flusharray(kmem_cache_
 {
 	int batchcount;
 	struct kmem_list3 *l3;
-	int node = numa_node_id();
+	int nid = numa_node_id();
 
 	batchcount = ac->batchcount;
 #if DEBUG
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	l3 = cachep->nodelists[node];
+	l3 = cachep->nodelists[nid];
 	spin_lock(&l3->list_lock);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
@@ -2722,7 +2722,7 @@ static void cache_flusharray(kmem_cache_
 		}
 	}
 
-	free_block(cachep, ac->entry, batchcount, node);
+	free_block(cachep, ac->entry, batchcount, nid);
 free_done:
 #if STATS
 	{
@@ -2771,24 +2771,24 @@ static inline void __cache_free(kmem_cac
 	{
 		struct slab *slabp;
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
-		if (unlikely(slabp->nodeid != numa_node_id())) {
+		if (unlikely(slabp->nid != numa_node_id())) {
 			struct array_cache *alien = NULL;
-			int nodeid = slabp->nodeid;
+			int nid = slabp->nid;
 			struct kmem_list3 *l3 =
 				cachep->nodelists[numa_node_id()];
 
 			STATS_INC_NODEFREES(cachep);
-			if (l3->alien && l3->alien[nodeid]) {
-				alien = l3->alien[nodeid];
+			if (l3->alien && l3->alien[nid]) {
+				alien = l3->alien[nid];
 				spin_lock(&alien->lock);
 				if (unlikely(alien->avail == alien->limit))
-					__drain_alien_cache(cachep, alien, nodeid);
+					__drain_alien_cache(cachep, alien, nid);
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
-				spin_lock(&(cachep->nodelists[nodeid])->list_lock);
-				free_block(cachep, &objp, 1, nodeid);
-				spin_unlock(&(cachep->nodelists[nodeid])->list_lock);
+				spin_lock(&(cachep->nodelists[nid])->list_lock);
+				free_block(cachep, &objp, 1, nid);
+				spin_unlock(&(cachep->nodelists[nid])->list_lock);
 			}
 			return;
 		}
@@ -2865,7 +2865,7 @@ out:
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
  * @flags: See kmalloc().
- * @nodeid: node number of the target node.
+ * @nid: node number of the target node.
  *
  * Identical to kmem_cache_alloc, except that this function is slow
  * and can sleep. And it will allocate memory on the given node, which
@@ -2873,27 +2873,27 @@ out:
  * New and improved: it will now make sure that the object gets
  * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nid)
 {
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == -1)
+	if (nid == -1)
 		return __cache_alloc(cachep, flags);
 
-	if (unlikely(!cachep->nodelists[nodeid])) {
+	if (unlikely(!cachep->nodelists[nid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
 		printk(KERN_WARNING "slab: not allocating in inactive node %d "
-		       "for cache %s\n", nodeid, cachep->name);
+		       "for cache %s\n", nid, cachep->name);
 		return __cache_alloc(cachep,flags);
 	}
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
+	if (nid == numa_node_id())
 		ptr = ____cache_alloc(cachep, flags);
 	else
-		ptr = __cache_alloc_node(cachep, flags, nodeid);
+		ptr = __cache_alloc_node(cachep, flags, nid);
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
 					   __builtin_return_address(0));
@@ -2902,14 +2902,14 @@ void *kmem_cache_alloc_node(kmem_cache_t
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-void *kmalloc_node(size_t size, gfp_t flags, int node)
+void *kmalloc_node(size_t size, gfp_t flags, int nid)
 {
 	kmem_cache_t *cachep;
 
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return kmem_cache_alloc_node(cachep, flags, node);
+	return kmem_cache_alloc_node(cachep, flags, nid);
 }
 EXPORT_SYMBOL(kmalloc_node);
 #endif
@@ -2973,10 +2973,10 @@ void *__alloc_percpu(size_t size, size_t
 	 * that we have allocated then....
 	 */
 	for_each_cpu(i) {
-		int node = cpu_to_node(i);
+		int nid = cpu_to_node(i);
 
-		if (node_online(node))
-			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, node);
+		if (node_online(nid))
+			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, nid);
 		else
 			pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
 
@@ -3096,40 +3096,40 @@ EXPORT_SYMBOL_GPL(kmem_cache_name);
  */
 static int alloc_kmemlist(kmem_cache_t *cachep)
 {
-	int node;
+	int nid;
 	struct kmem_list3 *l3;
 	int err = 0;
 
-	for_each_online_node(node) {
+	for_each_online_node(nid) {
 		struct array_cache *nc = NULL, *new;
 		struct array_cache **new_alien = NULL;
 #ifdef CONFIG_NUMA
-		if (!(new_alien = alloc_alien_cache(node, cachep->limit)))
+		if (!(new_alien = alloc_alien_cache(nid, cachep->limit)))
 			goto fail;
 #endif
-		if (!(new = alloc_arraycache(node, cachep->shared *
+		if (!(new = alloc_arraycache(nid, cachep->shared *
 					     cachep->batchcount, 0xbaadf00d)))
 			goto fail;
-		if ((l3 = cachep->nodelists[node])) {
+		if ((l3 = cachep->nodelists[nid])) {
 			spin_lock_irq(&l3->list_lock);
 
-			if ((nc = cachep->nodelists[node]->shared))
-				free_block(cachep, nc->entry, nc->avail, node);
+			if ((nc = cachep->nodelists[nid]->shared))
+				free_block(cachep, nc->entry, nc->avail, nid);
 
 			l3->shared = new;
-			if (!cachep->nodelists[node]->alien) {
+			if (!cachep->nodelists[nid]->alien) {
 				l3->alien = new_alien;
 				new_alien = NULL;
 			}
 			l3->free_limit = cachep->num +
-				(1 + nr_cpus_node(node)) * cachep->batchcount;
+				(1 + nr_cpus_node(nid)) * cachep->batchcount;
 			spin_unlock_irq(&l3->list_lock);
 			kfree(nc);
 			free_alien_cache(new_alien);
 			continue;
 		}
 		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
-					GFP_KERNEL, node)))
+					GFP_KERNEL, nid)))
 			goto fail;
 
 		kmem_list3_init(l3);
@@ -3138,8 +3138,8 @@ static int alloc_kmemlist(kmem_cache_t *
 		l3->shared = new;
 		l3->alien = new_alien;
 		l3->free_limit = cachep->num +
-			(1 + nr_cpus_node(node)) * cachep->batchcount;
-		cachep->nodelists[node] = l3;
+			(1 + nr_cpus_node(nid)) * cachep->batchcount;
+		cachep->nodelists[nid] = l3;
 	}
 	return err;
 fail:
@@ -3268,11 +3268,11 @@ static void enable_cpucache(kmem_cache_t
 }
 
 static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
-			       int force, int node)
+			       int force, int nid)
 {
 	int tofree;
 
-	check_spinlock_acquired_node(cachep, node);
+	check_spinlock_acquired_node(cachep, nid);
 	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
@@ -3280,7 +3280,7 @@ static void drain_array_locked(kmem_cach
 		if (tofree > ac->avail) {
 			tofree = (ac->avail + 1) / 2;
 		}
-		free_block(cachep, ac->entry, tofree, node);
+		free_block(cachep, ac->entry, tofree, nid);
 		ac->avail -= tofree;
 		memmove(ac->entry, &(ac->entry[tofree]),
 			sizeof(void *) * ac->avail);
@@ -3439,15 +3439,15 @@ static int s_show(struct seq_file *m, vo
 	unsigned long num_slabs, free_objects = 0, shared_avail = 0;
 	const char *name;
 	char *error = NULL;
-	int node;
+	int nid;
 	struct kmem_list3 *l3;
 
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	for_each_online_node(node) {
-		l3 = cachep->nodelists[node];
+	for_each_online_node(nid) {
+		l3 = cachep->nodelists[nid];
 		if (!l3)
 			continue;
 

--------------020508000806090405000408--
