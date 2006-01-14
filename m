Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWANMrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWANMrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWANMrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:47:23 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10402 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932241AbWANMqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:09 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:06 +0200
Message-Id: <20060114122444.781396000@localhost>
References: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 10/10] slab: replace kmem_cache_t with struct kmem_cache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch replaces uses of kmem_cache_t with proper struct kmem_cache in
mm/slab.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  193 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 97 insertions(+), 96 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -55,7 +55,7 @@
  *
  * SMP synchronization:
  *  constructors and destructors are called without any locking.
- *  Several members in kmem_cache_t and struct slab never change, they
+ *  Several members in struct kmem_cache and struct slab never change, they
  *	are accessed without any locking.
  *  The per-cpu arrays are never accessed from the wrong cpu, no locking,
  *  	and local interrupts are disabled so slab code is preempt-safe.
@@ -242,7 +242,7 @@ struct slab {
  */
 struct slab_rcu {
 	struct rcu_head head;
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 	void *addr;
 };
 
@@ -361,7 +361,7 @@ static void kmem_list3_init(struct kmem_
 	} while (0)
 
 /*
- * kmem_cache_t
+ * struct kmem_cache
  *
  * manages a cache.
  */
@@ -389,15 +389,15 @@ struct kmem_cache {
 	size_t colour;		/* cache colouring range */
 	unsigned int colour_off;	/* colour offset */
 	unsigned int colour_next;	/* cache colouring */
-	kmem_cache_t *slabp_cache;
+	struct kmem_cache *slabp_cache;
 	unsigned int slab_size;
 	unsigned int dflags;	/* dynamic flags */
 
 	/* constructor func */
-	void (*ctor) (void *, kmem_cache_t *, unsigned long);
+	void (*ctor) (void *, struct kmem_cache *, unsigned long);
 
 	/* de-constructor func */
-	void (*dtor) (void *, kmem_cache_t *, unsigned long);
+	void (*dtor) (void *, struct kmem_cache *, unsigned long);
 
 /* 4) cache creation/removal */
 	const char *name;
@@ -507,23 +507,23 @@ struct kmem_cache {
  * cachep->buffer_size - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
  * cachep->buffer_size - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
  */
-static int obj_offset(kmem_cache_t *cachep)
+static int obj_offset(struct kmem_cache *cachep)
 {
 	return cachep->obj_offset;
 }
 
-static int obj_size(kmem_cache_t *cachep)
+static int obj_size(struct kmem_cache *cachep)
 {
 	return cachep->obj_size;
 }
 
-static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	return (unsigned long*) (objp+obj_offset(cachep)-BYTES_PER_WORD);
 }
 
-static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
@@ -532,7 +532,7 @@ static unsigned long *dbg_redzone2(kmem_
 	return (unsigned long *)(objp + cachep->buffer_size - BYTES_PER_WORD);
 }
 
-static void **dbg_userword(kmem_cache_t *cachep, void *objp)
+static void **dbg_userword(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
 	return (void **)(objp + cachep->buffer_size - BYTES_PER_WORD);
@@ -634,16 +634,16 @@ static struct arraycache_init initarray_
     { {0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 
 /* internal cache of cache description objs */
-static kmem_cache_t cache_cache = {
+static struct kmem_cache cache_cache = {
 	.batchcount = 1,
 	.limit = BOOT_CPUCACHE_ENTRIES,
 	.shared = 1,
-	.buffer_size = sizeof(kmem_cache_t),
+	.buffer_size = sizeof(struct kmem_cache),
 	.flags = SLAB_NO_REAP,
 	.spinlock = SPIN_LOCK_UNLOCKED,
 	.name = "kmem_cache",
 #if DEBUG
-	.obj_size = sizeof(kmem_cache_t),
+	.obj_size = sizeof(struct kmem_cache),
 #endif
 };
 
@@ -672,17 +672,17 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t *cachep, void **objpp, int len, int node);
-static void enable_cpucache(kmem_cache_t *cachep);
+static void free_block(struct kmem_cache *cachep, void **objpp, int len, int node);
+static void enable_cpucache(struct kmem_cache *cachep);
 static void cache_reap(void *unused);
-static int __node_shrink(kmem_cache_t *cachep, int node);
+static int __node_shrink(struct kmem_cache *cachep, int node);
 
-static inline struct array_cache *cpu_cache_get(kmem_cache_t *cachep)
+static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
 {
 	return cachep->array[smp_processor_id()];
 }
 
-static inline kmem_cache_t *__find_general_cachep(size_t size, gfp_t gfpflags)
+static inline struct kmem_cache *__find_general_cachep(size_t size, gfp_t gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
@@ -706,7 +706,7 @@ static inline kmem_cache_t *__find_gener
 	return csizep->cs_cachep;
 }
 
-kmem_cache_t *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
+struct kmem_cache *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
 {
 	return __find_general_cachep(size, gfpflags);
 }
@@ -779,7 +779,7 @@ static void cache_estimate(unsigned long
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)
 
-static void __slab_error(const char *function, kmem_cache_t *cachep, char *msg)
+static void __slab_error(const char *function, struct kmem_cache *cachep, char *msg)
 {
 	printk(KERN_ERR "slab error in %s(): cache `%s': %s\n",
 	       function, cachep->name, msg);
@@ -866,7 +866,7 @@ static void free_alien_cache(struct arra
 	kfree(ac_ptr);
 }
 
-static void __drain_alien_cache(kmem_cache_t *cachep,
+static void __drain_alien_cache(struct kmem_cache *cachep,
 				struct array_cache *ac, int node)
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
@@ -879,7 +879,7 @@ static void __drain_alien_cache(kmem_cac
 	}
 }
 
-static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
+static void drain_alien_cache(struct kmem_cache *cachep, struct kmem_list3 *l3)
 {
 	int i = 0;
 	struct array_cache *ac;
@@ -904,7 +904,7 @@ static int __devinit cpuup_callback(stru
 				    unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 	struct kmem_list3 *l3 = NULL;
 	int node = cpu_to_node(cpu);
 	int memsize = sizeof(struct kmem_list3);
@@ -1042,7 +1042,7 @@ static struct notifier_block cpucache_no
 /*
  * swap the static kmem_list3 with kmalloced memory
  */
-static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list, int nodeid)
+static void init_list(struct kmem_cache *cachep, struct kmem_list3 *list, int nodeid)
 {
 	struct kmem_list3 *ptr;
 
@@ -1082,14 +1082,14 @@ void __init kmem_cache_init(void)
 
 	/* Bootstrap is tricky, because several objects are allocated
 	 * from caches that do not exist yet:
-	 * 1) initialize the cache_cache cache: it contains the kmem_cache_t
+	 * 1) initialize the cache_cache cache: it contains the struct kmem_cache
 	 *    structures of all caches, except cache_cache itself: cache_cache
 	 *    is statically allocated.
 	 *    Initially an __init data area is used for the head array and the
 	 *    kmem_list3 structures, it's replaced with a kmalloc allocated
 	 *    array at the end of the bootstrap.
 	 * 2) Create the first kmalloc cache.
-	 *    The kmem_cache_t for the new cache is allocated normally.
+	 *    The struct kmem_cache for the new cache is allocated normally.
 	 *    An __init data area is used for the head array.
 	 * 3) Create the remaining kmalloc caches, with minimally sized
 	 *    head arrays.
@@ -1221,7 +1221,7 @@ void __init kmem_cache_init(void)
 
 	/* 6) resize the head arrays to their final sizes */
 	{
-		kmem_cache_t *cachep;
+		struct kmem_cache *cachep;
 		down(&cache_chain_sem);
 		list_for_each_entry(cachep, &cache_chain, next)
 		    enable_cpucache(cachep);
@@ -1264,7 +1264,7 @@ __initcall(cpucache_init);
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
  */
-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *kmem_getpages(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct page *page;
 	void *addr;
@@ -1290,7 +1290,7 @@ static void *kmem_getpages(kmem_cache_t 
 /*
  * Interface to system's page release.
  */
-static void kmem_freepages(kmem_cache_t *cachep, void *addr)
+static void kmem_freepages(struct kmem_cache *cachep, void *addr)
 {
 	unsigned long i = (1 << cachep->gfporder);
 	struct page *page = virt_to_page(addr);
@@ -1312,7 +1312,7 @@ static void kmem_freepages(kmem_cache_t 
 static void kmem_rcu_free(struct rcu_head *head)
 {
 	struct slab_rcu *slab_rcu = (struct slab_rcu *)head;
-	kmem_cache_t *cachep = slab_rcu->cachep;
+	struct kmem_cache *cachep = slab_rcu->cachep;
 
 	kmem_freepages(cachep, slab_rcu->addr);
 	if (OFF_SLAB(cachep))
@@ -1322,7 +1322,7 @@ static void kmem_rcu_free(struct rcu_hea
 #if DEBUG
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
+static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
 			    unsigned long caller)
 {
 	int size = obj_size(cachep);
@@ -1355,7 +1355,7 @@ static void store_stackinfo(kmem_cache_t
 }
 #endif
 
-static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
+static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
 {
 	int size = obj_size(cachep);
 	addr = &((char *)addr)[obj_offset(cachep)];
@@ -1377,7 +1377,7 @@ static void dump_line(char *data, int of
 
 #if DEBUG
 
-static void print_objinfo(kmem_cache_t *cachep, void *objp, int lines)
+static void print_objinfo(struct kmem_cache *cachep, void *objp, int lines)
 {
 	int i, size;
 	char *realobj;
@@ -1406,7 +1406,7 @@ static void print_objinfo(kmem_cache_t *
 	}
 }
 
-static void check_poison_obj(kmem_cache_t *cachep, void *objp)
+static void check_poison_obj(struct kmem_cache *cachep, void *objp)
 {
 	char *realobj;
 	int size, i;
@@ -1473,7 +1473,7 @@ static void check_poison_obj(kmem_cache_
  * slab_destroy_objs - call the registered destructor for each object in
  *      a slab that is to be destroyed.
  */
-static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy_objs(struct kmem_cache *cachep, struct slab *slabp)
 {
 	int i;
 	for (i = 0; i < cachep->num; i++) {
@@ -1505,7 +1505,7 @@ static void slab_destroy_objs(kmem_cache
 	}
 }
 #else
-static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy_objs(struct kmem_cache *cachep, struct slab *slabp)
 {
 	if (cachep->dtor) {
 		int i;
@@ -1522,7 +1522,7 @@ static void slab_destroy_objs(kmem_cache
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
-static void slab_destroy(kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy(struct kmem_cache *cachep, struct slab *slabp)
 {
 	void *addr = slabp->s_mem - slabp->colouroff;
 
@@ -1543,7 +1543,7 @@ static void slab_destroy(kmem_cache_t *c
 
 /* For setting up all the kmem_list3s for cache whose buffer_size is same
    as size of kmem_list3. */
-static void set_up_list3s(kmem_cache_t *cachep, int index)
+static void set_up_list3s(struct kmem_cache *cachep, int index)
 {
 	int node;
 
@@ -1563,7 +1563,7 @@ static void set_up_list3s(kmem_cache_t *
  * high order pages for slabs.  When the gfp() functions are more friendly
  * towards high-order requests, this should be changed.
  */
-static inline size_t calculate_slab_order(kmem_cache_t *cachep, size_t size,
+static inline size_t calculate_slab_order(struct kmem_cache *cachep, size_t size,
 					  size_t align, gfp_t flags)
 {
 	size_t left_over = 0;
@@ -1635,13 +1635,13 @@ static inline size_t calculate_slab_orde
  * cacheline.  This can be beneficial if you're counting cycles as closely
  * as davem.
  */
-kmem_cache_t *
+struct kmem_cache *
 kmem_cache_create (const char *name, size_t size, size_t align,
-	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
-	void (*dtor)(void*, kmem_cache_t *, unsigned long))
+	unsigned long flags, void (*ctor)(void*, struct kmem_cache *, unsigned long),
+	void (*dtor)(void*, struct kmem_cache *, unsigned long))
 {
 	size_t left_over, slab_size, ralign;
-	kmem_cache_t *cachep = NULL;
+	struct kmem_cache *cachep = NULL;
 	struct list_head *p;
 
 	/*
@@ -1659,7 +1659,7 @@ kmem_cache_create (const char *name, siz
 	down(&cache_chain_sem);
 
 	list_for_each(p, &cache_chain) {
-		kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
+		struct kmem_cache *pc = list_entry(p, struct kmem_cache, next);
 		mm_segment_t old_fs = get_fs();
 		char tmp;
 		int res;
@@ -1759,10 +1759,10 @@ kmem_cache_create (const char *name, siz
 	align = ralign;
 
 	/* Get cache's description obj. */
-	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
+	cachep = kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
 		goto oops;
-	memset(cachep, 0, sizeof(kmem_cache_t));
+	memset(cachep, 0, sizeof(struct kmem_cache));
 
 #if DEBUG
 	cachep->obj_size = size;
@@ -1938,7 +1938,7 @@ static void check_irq_on(void)
 	BUG_ON(irqs_disabled());
 }
 
-static void check_spinlock_acquired(kmem_cache_t *cachep)
+static void check_spinlock_acquired(struct kmem_cache *cachep)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
@@ -1946,7 +1946,7 @@ static void check_spinlock_acquired(kmem
 #endif
 }
 
-static void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+static void check_spinlock_acquired_node(struct kmem_cache *cachep, int node)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
@@ -1979,12 +1979,12 @@ static void smp_call_function_all_cpus(v
 	preempt_enable();
 }
 
-static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
+static void drain_array_locked(struct kmem_cache *cachep, struct array_cache *ac,
 				int force, int node);
 
 static void do_drain(void *arg)
 {
-	kmem_cache_t *cachep = (kmem_cache_t *) arg;
+	struct kmem_cache *cachep = (struct kmem_cache *) arg;
 	struct array_cache *ac;
 	int node = numa_node_id();
 
@@ -1996,7 +1996,7 @@ static void do_drain(void *arg)
 	ac->avail = 0;
 }
 
-static void drain_cpu_caches(kmem_cache_t *cachep)
+static void drain_cpu_caches(struct kmem_cache *cachep)
 {
 	struct kmem_list3 *l3;
 	int node;
@@ -2017,7 +2017,7 @@ static void drain_cpu_caches(kmem_cache_
 	spin_unlock_irq(&cachep->spinlock);
 }
 
-static int __node_shrink(kmem_cache_t *cachep, int node)
+static int __node_shrink(struct kmem_cache *cachep, int node)
 {
 	struct slab *slabp;
 	struct kmem_list3 *l3 = cachep->nodelists[node];
@@ -2046,7 +2046,7 @@ static int __node_shrink(kmem_cache_t *c
 	return ret;
 }
 
-static int __cache_shrink(kmem_cache_t *cachep)
+static int __cache_shrink(struct kmem_cache *cachep)
 {
 	int ret = 0, i = 0;
 	struct kmem_list3 *l3;
@@ -2072,7 +2072,7 @@ static int __cache_shrink(kmem_cache_t *
  * Releases as many slabs as possible for a cache.
  * To help debugging, a zero exit status indicates all slabs were released.
  */
-int kmem_cache_shrink(kmem_cache_t *cachep)
+int kmem_cache_shrink(struct kmem_cache *cachep)
 {
 	if (!cachep || in_interrupt())
 		BUG();
@@ -2085,7 +2085,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * kmem_cache_destroy - delete a cache
  * @cachep: the cache to destroy
  *
- * Remove a kmem_cache_t object from the slab cache.
+ * Remove a struct kmem_cache object from the slab cache.
  * Returns 0 on success.
  *
  * It is expected this function will be called by a module when it is
@@ -2098,7 +2098,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * The caller must guarantee that noone will allocate memory from the cache
  * during the kmem_cache_destroy().
  */
-int kmem_cache_destroy(kmem_cache_t *cachep)
+int kmem_cache_destroy(struct kmem_cache *cachep)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2149,7 +2149,7 @@ int kmem_cache_destroy(kmem_cache_t *cac
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab *alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
+static struct slab *alloc_slabmgmt(struct kmem_cache *cachep, void *objp,
 				   int colour_off, gfp_t local_flags)
 {
 	struct slab *slabp;
@@ -2175,7 +2175,7 @@ static inline kmem_bufctl_t *slab_bufctl
 	return (kmem_bufctl_t *) (slabp + 1);
 }
 
-static void cache_init_objs(kmem_cache_t *cachep,
+static void cache_init_objs(struct kmem_cache *cachep,
 			    struct slab *slabp, unsigned long ctor_flags)
 {
 	int i;
@@ -2224,7 +2224,7 @@ static void cache_init_objs(kmem_cache_t
 	slabp->free = 0;
 }
 
-static void kmem_flagcheck(kmem_cache_t *cachep, gfp_t flags)
+static void kmem_flagcheck(struct kmem_cache *cachep, gfp_t flags)
 {
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
@@ -2235,7 +2235,7 @@ static void kmem_flagcheck(kmem_cache_t 
 	}
 }
 
-static void *slab_get_obj(kmem_cache_t *cachep, struct slab *slabp, int nodeid)
+static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slabp, int nodeid)
 {
 	void *objp = slabp->s_mem + (slabp->free * cachep->buffer_size);
 	kmem_bufctl_t next;
@@ -2251,7 +2251,7 @@ static void *slab_get_obj(kmem_cache_t *
 	return objp;
 }
 
-static void slab_put_obj(kmem_cache_t *cachep, struct slab *slabp, void *objp,
+static void slab_put_obj(struct kmem_cache *cachep, struct slab *slabp, void *objp,
 			  int nodeid)
 {
 	unsigned int objnr = (objp - slabp->s_mem) / cachep->buffer_size;
@@ -2271,7 +2271,7 @@ static void slab_put_obj(kmem_cache_t *c
 	slabp->inuse--;
 }
 
-static void set_slab_attr(kmem_cache_t *cachep, struct slab *slabp, void *objp)
+static void set_slab_attr(struct kmem_cache *cachep, struct slab *slabp, void *objp)
 {
 	int i;
 	struct page *page;
@@ -2290,7 +2290,7 @@ static void set_slab_attr(kmem_cache_t *
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static int cache_grow(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct slab *slabp;
 	void *objp;
@@ -2401,7 +2401,7 @@ static void kfree_debugcheck(const void 
 	}
 }
 
-static void *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
+static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 				   void *caller)
 {
 	struct page *page;
@@ -2475,7 +2475,7 @@ static void *cache_free_debugcheck(kmem_
 	return objp;
 }
 
-static void check_slabp(kmem_cache_t *cachep, struct slab *slabp)
+static void check_slabp(struct kmem_cache *cachep, struct slab *slabp)
 {
 	kmem_bufctl_t i;
 	int entries = 0;
@@ -2508,7 +2508,7 @@ static void check_slabp(kmem_cache_t *ca
 #define check_slabp(x,y) do { } while(0)
 #endif
 
-static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
+static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2599,7 +2599,7 @@ static void *cache_alloc_refill(kmem_cac
 }
 
 static inline void
-cache_alloc_debugcheck_before(kmem_cache_t *cachep, gfp_t flags)
+cache_alloc_debugcheck_before(struct kmem_cache *cachep, gfp_t flags)
 {
 	might_sleep_if(flags & __GFP_WAIT);
 #if DEBUG
@@ -2608,7 +2608,7 @@ cache_alloc_debugcheck_before(kmem_cache
 }
 
 #if DEBUG
-static void *cache_alloc_debugcheck_after(kmem_cache_t *cachep, gfp_t flags,
+static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep, gfp_t flags,
 					void *objp, void *caller)
 {
 	if (!objp)
@@ -2657,7 +2657,7 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
@@ -2675,7 +2675,7 @@ static inline void *____cache_alloc(kmem
 	return objp;
 }
 
-static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *__cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -2695,7 +2695,7 @@ static inline void *__cache_alloc(kmem_c
 /*
  * A interface to enable slab creation on nodeid
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *__cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct list_head *entry;
 	struct slab *slabp;
@@ -2757,7 +2757,7 @@ static void *__cache_alloc_node(kmem_cac
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects,
+static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects,
 		       int node)
 {
 	int i;
@@ -2795,7 +2795,7 @@ static void free_block(kmem_cache_t *cac
 	}
 }
 
-static void cache_flusharray(kmem_cache_t *cachep, struct array_cache *ac)
+static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2854,7 +2854,7 @@ static void cache_flusharray(kmem_cache_
  *
  * Called with disabled ints.
  */
-static inline void __cache_free(kmem_cache_t *cachep, void *objp)
+static inline void __cache_free(struct kmem_cache *cachep, void *objp)
 {
 	struct array_cache *ac = cpu_cache_get(cachep);
 
@@ -2913,7 +2913,7 @@ static inline void __cache_free(kmem_cac
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	return __cache_alloc(cachep, flags);
 }
@@ -2933,7 +2933,7 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  *
  * Currently only used for dentry validation.
  */
-int fastcall kmem_ptr_validate(kmem_cache_t *cachep, void *ptr)
+int fastcall kmem_ptr_validate(struct kmem_cache *cachep, void *ptr)
 {
 	unsigned long addr = (unsigned long)ptr;
 	unsigned long min_addr = PAGE_OFFSET;
@@ -2974,7 +2974,7 @@ int fastcall kmem_ptr_validate(kmem_cach
  * New and improved: it will now make sure that the object gets
  * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	unsigned long save_flags;
 	void *ptr;
@@ -2998,7 +2998,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
@@ -3031,7 +3031,7 @@ EXPORT_SYMBOL(kmalloc_node);
  */
 void *__kmalloc(size_t size, gfp_t flags)
 {
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3102,7 +3102,7 @@ EXPORT_SYMBOL(__alloc_percpu);
  * Free an object which was previously allocated from this
  * cache.
  */
-void kmem_cache_free(kmem_cache_t *cachep, void *objp)
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 {
 	unsigned long flags;
 
@@ -3123,7 +3123,7 @@ EXPORT_SYMBOL(kmem_cache_free);
  */
 void kfree(const void *objp)
 {
-	kmem_cache_t *c;
+	struct kmem_cache *c;
 	unsigned long flags;
 
 	if (unlikely(!objp))
@@ -3160,13 +3160,13 @@ void free_percpu(const void *objp)
 EXPORT_SYMBOL(free_percpu);
 #endif
 
-unsigned int kmem_cache_size(kmem_cache_t *cachep)
+unsigned int kmem_cache_size(struct kmem_cache *cachep)
 {
 	return obj_size(cachep);
 }
 EXPORT_SYMBOL(kmem_cache_size);
 
-const char *kmem_cache_name(kmem_cache_t *cachep)
+const char *kmem_cache_name(struct kmem_cache *cachep)
 {
 	return cachep->name;
 }
@@ -3175,7 +3175,7 @@ EXPORT_SYMBOL_GPL(kmem_cache_name);
 /*
  * This initializes kmem_list3 for all nodes.
  */
-static int alloc_kmemlist(kmem_cache_t *cachep)
+static int alloc_kmemlist(struct kmem_cache *cachep)
 {
 	int node;
 	struct kmem_list3 *l3;
@@ -3231,7 +3231,7 @@ static int alloc_kmemlist(kmem_cache_t *
 }
 
 struct ccupdate_struct {
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 	struct array_cache *new[NR_CPUS];
 };
 
@@ -3247,7 +3247,7 @@ static void do_ccupdate_local(void *info
 	new->new[smp_processor_id()] = old;
 }
 
-static int do_tune_cpucache(kmem_cache_t *cachep, int limit, int batchcount,
+static int do_tune_cpucache(struct kmem_cache *cachep, int limit, int batchcount,
 			    int shared)
 {
 	struct ccupdate_struct new;
@@ -3293,7 +3293,7 @@ static int do_tune_cpucache(kmem_cache_t
 	return 0;
 }
 
-static void enable_cpucache(kmem_cache_t *cachep)
+static void enable_cpucache(struct kmem_cache *cachep)
 {
 	int err;
 	int limit, shared;
@@ -3345,7 +3345,7 @@ static void enable_cpucache(kmem_cache_t
 		       cachep->name, -err);
 }
 
-static void drain_array_locked(kmem_cache_t *cachep, struct array_cache *ac,
+static void drain_array_locked(struct kmem_cache *cachep, struct array_cache *ac,
 				int force, int node)
 {
 	int tofree;
@@ -3390,12 +3390,12 @@ static void cache_reap(void *unused)
 	}
 
 	list_for_each(walk, &cache_chain) {
-		kmem_cache_t *searchp;
+		struct kmem_cache *searchp;
 		struct list_head *p;
 		int tofree;
 		struct slab *slabp;
 
-		searchp = list_entry(walk, kmem_cache_t, next);
+		searchp = list_entry(walk, struct kmem_cache, next);
 
 		if (searchp->flags & SLAB_NO_REAP)
 			goto next;
@@ -3498,15 +3498,15 @@ static void *s_start(struct seq_file *m,
 		if (p == &cache_chain)
 			return NULL;
 	}
-	return list_entry(p, kmem_cache_t, next);
+	return list_entry(p, struct kmem_cache, next);
 }
 
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	kmem_cache_t *cachep = p;
+	struct kmem_cache *cachep = p;
 	++*pos;
 	return cachep->next.next == &cache_chain ? NULL
-	    : list_entry(cachep->next.next, kmem_cache_t, next);
+	    : list_entry(cachep->next.next, struct kmem_cache, next);
 }
 
 static void s_stop(struct seq_file *m, void *p)
@@ -3516,7 +3516,7 @@ static void s_stop(struct seq_file *m, v
 
 static int s_show(struct seq_file *m, void *p)
 {
-	kmem_cache_t *cachep = p;
+	struct kmem_cache *cachep = p;
 	struct list_head *q;
 	struct slab *slabp;
 	unsigned long active_objs;
@@ -3666,7 +3666,8 @@ ssize_t slabinfo_write(struct file *file
 	down(&cache_chain_sem);
 	res = -EINVAL;
 	list_for_each(p, &cache_chain) {
-		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
+		struct kmem_cache *cachep = list_entry(p, struct kmem_cache,
+						       next);
 
 		if (!strcmp(cachep->name, kbuf)) {
 			if (limit < 1 ||

--

