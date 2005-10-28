Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbVJ1TQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbVJ1TQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030634AbVJ1TQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:16:53 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:37347 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030633AbVJ1TQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:16:51 -0400
Subject: [PATCH 2/3] mm: use struct kmem_cache instead of kmem_cache_t
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ip33z8.9nchrp.cwl9eft5uvbyy7ldhjjcddapd.beaver@cs.helsinki.fi>
In-Reply-To: <ip33z2.vtcnft.4nw33ugftrecz8r4nb1via846.beaver@cs.helsinki.fi>
Date: Fri, 28 Oct 2005 22:11:32 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts mm/ to use struct kmem_cache instead of kmem_cache_t
typedef.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mempolicy.c |    4 -
 mempool.c   |    4 -
 rmap.c      |    4 -
 shmem.c     |    4 -
 slab.c      |  184 ++++++++++++++++++++++++++++++------------------------------
 5 files changed, 100 insertions(+), 100 deletions(-)

Index: 2.6/mm/mempolicy.c
===================================================================
--- 2.6.orig/mm/mempolicy.c
+++ 2.6/mm/mempolicy.c
@@ -79,8 +79,8 @@
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 
-static kmem_cache_t *policy_cache;
-static kmem_cache_t *sn_cache;
+static struct kmem_cache *policy_cache;
+static struct kmem_cache *sn_cache;
 
 #define PDprintk(fmt...)
 
Index: 2.6/mm/mempool.c
===================================================================
--- 2.6.orig/mm/mempool.c
+++ 2.6/mm/mempool.c
@@ -278,14 +278,14 @@ EXPORT_SYMBOL(mempool_free);
  */
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data)
 {
-	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
+	struct kmem_cache *mem = pool_data;
 	return kmem_cache_alloc(mem, gfp_mask);
 }
 EXPORT_SYMBOL(mempool_alloc_slab);
 
 void mempool_free_slab(void *element, void *pool_data)
 {
-	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
+	struct kmem_cache *mem = pool_data;
 	kmem_cache_free(mem, element);
 }
 EXPORT_SYMBOL(mempool_free_slab);
Index: 2.6/mm/rmap.c
===================================================================
--- 2.6.orig/mm/rmap.c
+++ 2.6/mm/rmap.c
@@ -57,7 +57,7 @@
 
 //#define RMAP_DEBUG /* can be enabled only for debugging */
 
-kmem_cache_t *anon_vma_cachep;
+struct kmem_cache *anon_vma_cachep;
 
 static inline void validate_anon_vma(struct vm_area_struct *find_vma)
 {
@@ -165,7 +165,7 @@ void anon_vma_unlink(struct vm_area_stru
 		anon_vma_free(anon_vma);
 }
 
-static void anon_vma_ctor(void *data, kmem_cache_t *cachep, unsigned long flags)
+static void anon_vma_ctor(void *data, struct kmem_cache *cachep, unsigned long flags)
 {
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 						SLAB_CTOR_CONSTRUCTOR) {
Index: 2.6/mm/shmem.c
===================================================================
--- 2.6.orig/mm/shmem.c
+++ 2.6/mm/shmem.c
@@ -2014,7 +2014,7 @@ failed:
 	return err;
 }
 
-static kmem_cache_t *shmem_inode_cachep;
+static struct kmem_cache *shmem_inode_cachep;
 
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
@@ -2034,7 +2034,7 @@ static void shmem_destroy_inode(struct i
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+static void init_once(void *foo, struct kmem_cache *cachep, unsigned long flags)
 {
 	struct shmem_inode_info *p = (struct shmem_inode_info *) foo;
 
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
@@ -243,7 +243,7 @@ struct slab {
  */
 struct slab_rcu {
 	struct rcu_head		head;
-	kmem_cache_t		*cachep;
+	struct kmem_cache	*cachep;
 	void			*addr;
 };
 
@@ -363,7 +363,7 @@ static inline void kmem_list3_init(struc
 	} while (0)
 
 /*
- * kmem_cache_t
+ * struct kmem_cache
  *
  * manages a cache.
  */
@@ -391,15 +391,15 @@ struct kmem_cache {
 	size_t			colour;		/* cache colouring range */
 	unsigned int		colour_off;	/* colour offset */
 	unsigned int		colour_next;	/* cache colouring */
-	kmem_cache_t		*slabp_cache;
+	struct kmem_cache	*slabp_cache;
 	unsigned int		slab_size;
 	unsigned int		dflags;		/* dynamic flags */
 
 	/* constructor func */
-	void (*ctor)(void *, kmem_cache_t *, unsigned long);
+	void (*ctor)(void *, struct kmem_cache *, unsigned long);
 
 	/* de-constructor func */
-	void (*dtor)(void *, kmem_cache_t *, unsigned long);
+	void (*dtor)(void *, struct kmem_cache *, unsigned long);
 
 /* 4) cache creation/removal */
 	const char		*name;
@@ -503,23 +503,23 @@ struct kmem_cache {
  * cachep->objsize - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
  * cachep->objsize - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
  */
-static int obj_dbghead(kmem_cache_t *cachep)
+static int obj_dbghead(struct kmem_cache *cachep)
 {
 	return cachep->dbghead;
 }
 
-static int obj_reallen(kmem_cache_t *cachep)
+static int obj_reallen(struct kmem_cache *cachep)
 {
 	return cachep->reallen;
 }
 
-static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	return (unsigned long*) (objp+obj_dbghead(cachep)-BYTES_PER_WORD);
 }
 
-static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
+static unsigned long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
@@ -527,7 +527,7 @@ static unsigned long *dbg_redzone2(kmem_
 	return (unsigned long*) (objp+cachep->objsize-BYTES_PER_WORD);
 }
 
-static void **dbg_userword(kmem_cache_t *cachep, void *objp)
+static void **dbg_userword(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
 	return (void**)(objp+cachep->objsize-BYTES_PER_WORD);
@@ -570,7 +570,7 @@ static int slab_break_gfp_order = BREAK_
  * With kfree(), these are used to find the cache which an obj belongs to.
  */
 #define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
-#define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
+#define	GET_PAGE_CACHE(pg)    ((struct kmem_cache *)(pg)->lru.next)
 #define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
 
@@ -602,16 +602,16 @@ static struct arraycache_init initarray_
 	{ { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 
 /* internal cache of cache description objs */
-static kmem_cache_t cache_cache = {
+static struct kmem_cache cache_cache = {
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
 	.shared		= 1,
-	.objsize	= sizeof(kmem_cache_t),
+	.objsize	= sizeof(struct kmem_cache),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
 	.name		= "kmem_cache",
 #if DEBUG
-	.reallen	= sizeof(kmem_cache_t),
+	.reallen	= sizeof(struct kmem_cache),
 #endif
 };
 
@@ -640,17 +640,17 @@ static enum {
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t* cachep, void** objpp, int len, int node);
-static void enable_cpucache (kmem_cache_t *cachep);
+static void free_block(struct kmem_cache* cachep, void** objpp, int len, int node);
+static void enable_cpucache (struct kmem_cache *cachep);
 static void cache_reap (void *unused);
-static int __node_shrink(kmem_cache_t *cachep, int node);
+static int __node_shrink(struct kmem_cache *cachep, int node);
 
-static inline struct array_cache *ac_data(kmem_cache_t *cachep)
+static inline struct array_cache *ac_data(struct kmem_cache *cachep)
 {
 	return cachep->array[smp_processor_id()];
 }
 
-static inline kmem_cache_t *__find_general_cachep(size_t size, gfp_t gfpflags)
+static inline struct kmem_cache *__find_general_cachep(size_t size, gfp_t gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
@@ -674,7 +674,7 @@ static inline kmem_cache_t *__find_gener
 	return csizep->cs_cachep;
 }
 
-kmem_cache_t *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
+struct kmem_cache *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
 {
 	return __find_general_cachep(size, gfpflags);
 }
@@ -710,7 +710,7 @@ static void cache_estimate(unsigned long
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)
 
-static void __slab_error(const char *function, kmem_cache_t *cachep, char *msg)
+static void __slab_error(const char *function, struct kmem_cache *cachep, char *msg)
 {
 	printk(KERN_ERR "slab error in %s(): cache `%s': %s\n",
 		function, cachep->name, msg);
@@ -797,7 +797,7 @@ static inline void free_alien_cache(stru
 	kfree(ac_ptr);
 }
 
-static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
+static inline void __drain_alien_cache(struct kmem_cache *cachep, struct array_cache *ac, int node)
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
@@ -809,7 +809,7 @@ static inline void __drain_alien_cache(k
 	}
 }
 
-static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
+static void drain_alien_cache(struct kmem_cache *cachep, struct kmem_list3 *l3)
 {
 	int i=0;
 	struct array_cache *ac;
@@ -834,7 +834,7 @@ static int __devinit cpuup_callback(stru
 				  unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
-	kmem_cache_t* cachep;
+	struct kmem_cache* cachep;
 	struct kmem_list3 *l3 = NULL;
 	int node = cpu_to_node(cpu);
 	int memsize = sizeof(struct kmem_list3);
@@ -970,7 +970,7 @@ static struct notifier_block cpucache_no
 /*
  * swap the static kmem_list3 with kmalloced memory
  */
-static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list,
+static void init_list(struct kmem_cache *cachep, struct kmem_list3 *list,
 		int nodeid)
 {
 	struct kmem_list3 *ptr;
@@ -1011,14 +1011,14 @@ void __init kmem_cache_init(void)
 
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
@@ -1140,7 +1140,7 @@ void __init kmem_cache_init(void)
 
 	/* 6) resize the head arrays to their final sizes */
 	{
-		kmem_cache_t *cachep;
+		struct kmem_cache *cachep;
 		down(&cache_chain_sem);
 		list_for_each_entry(cachep, &cache_chain, next)
 			enable_cpucache(cachep);
@@ -1183,7 +1183,7 @@ __initcall(cpucache_init);
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
  */
-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *kmem_getpages(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct page *page;
 	void *addr;
@@ -1213,7 +1213,7 @@ static void *kmem_getpages(kmem_cache_t 
 /*
  * Interface to system's page release.
  */
-static void kmem_freepages(kmem_cache_t *cachep, void *addr)
+static void kmem_freepages(struct kmem_cache *cachep, void *addr)
 {
 	unsigned long i = (1<<cachep->gfporder);
 	struct page *page = virt_to_page(addr);
@@ -1235,7 +1235,7 @@ static void kmem_freepages(kmem_cache_t 
 static void kmem_rcu_free(struct rcu_head *head)
 {
 	struct slab_rcu *slab_rcu = (struct slab_rcu *) head;
-	kmem_cache_t *cachep = slab_rcu->cachep;
+	struct kmem_cache *cachep = slab_rcu->cachep;
 
 	kmem_freepages(cachep, slab_rcu->addr);
 	if (OFF_SLAB(cachep))
@@ -1245,7 +1245,7 @@ static void kmem_rcu_free(struct rcu_hea
 #if DEBUG
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
+static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
 				unsigned long caller)
 {
 	int size = obj_reallen(cachep);
@@ -1278,7 +1278,7 @@ static void store_stackinfo(kmem_cache_t
 }
 #endif
 
-static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
+static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
 {
 	int size = obj_reallen(cachep);
 	addr = &((char*)addr)[obj_dbghead(cachep)];
@@ -1300,7 +1300,7 @@ static void dump_line(char *data, int of
 
 #if DEBUG
 
-static void print_objinfo(kmem_cache_t *cachep, void *objp, int lines)
+static void print_objinfo(struct kmem_cache *cachep, void *objp, int lines)
 {
 	int i, size;
 	char *realobj;
@@ -1329,7 +1329,7 @@ static void print_objinfo(kmem_cache_t *
 	}
 }
 
-static void check_poison_obj(kmem_cache_t *cachep, void *objp)
+static void check_poison_obj(struct kmem_cache *cachep, void *objp)
 {
 	char *realobj;
 	int size, i;
@@ -1394,7 +1394,7 @@ static void check_poison_obj(kmem_cache_
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
-static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy (struct kmem_cache *cachep, struct slab *slabp)
 {
 	void *addr = slabp->s_mem - slabp->colouroff;
 
@@ -1450,7 +1450,7 @@ static void slab_destroy (kmem_cache_t *
 
 /* For setting up all the kmem_list3s for cache whose objsize is same
    as size of kmem_list3. */
-static inline void set_up_list3s(kmem_cache_t *cachep, int index)
+static inline void set_up_list3s(struct kmem_cache *cachep, int index)
 {
 	int node;
 
@@ -1495,13 +1495,13 @@ static inline void set_up_list3s(kmem_ca
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
 
 	/*
 	 * Sanity checks... these are all serious usage bugs.
@@ -1590,10 +1590,10 @@ kmem_cache_create (const char *name, siz
 	align = ralign;
 
 	/* Get cache's description obj. */
-	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
+	cachep = kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
 		goto opps;
-	memset(cachep, 0, sizeof(kmem_cache_t));
+	memset(cachep, 0, sizeof(struct kmem_cache));
 
 #if DEBUG
 	cachep->reallen = size;
@@ -1790,7 +1790,7 @@ next:
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		list_for_each(p, &cache_chain) {
-			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
+			struct kmem_cache *pc = list_entry(p, struct kmem_cache, next);
 			char tmp;
 			/* This happens when the module gets unloaded and doesn't
 			   destroy its slab cache and noone else reuses the vmalloc
@@ -1833,7 +1833,7 @@ static void check_irq_on(void)
 	BUG_ON(irqs_disabled());
 }
 
-static void check_spinlock_acquired(kmem_cache_t *cachep)
+static void check_spinlock_acquired(struct kmem_cache *cachep)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
@@ -1841,7 +1841,7 @@ static void check_spinlock_acquired(kmem
 #endif
 }
 
-static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+static inline void check_spinlock_acquired_node(struct kmem_cache *cachep, int node)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
@@ -1874,12 +1874,12 @@ static void smp_call_function_all_cpus(v
 	preempt_enable();
 }
 
-static void drain_array_locked(kmem_cache_t* cachep,
+static void drain_array_locked(struct kmem_cache* cachep,
 				struct array_cache *ac, int force, int node);
 
 static void do_drain(void *arg)
 {
-	kmem_cache_t *cachep = (kmem_cache_t*)arg;
+	struct kmem_cache *cachep = (struct kmem_cache*)arg;
 	struct array_cache *ac;
 	int node = numa_node_id();
 
@@ -1891,7 +1891,7 @@ static void do_drain(void *arg)
 	ac->avail = 0;
 }
 
-static void drain_cpu_caches(kmem_cache_t *cachep)
+static void drain_cpu_caches(struct kmem_cache *cachep)
 {
 	struct kmem_list3 *l3;
 	int node;
@@ -1912,7 +1912,7 @@ static void drain_cpu_caches(kmem_cache_
 	spin_unlock_irq(&cachep->spinlock);
 }
 
-static int __node_shrink(kmem_cache_t *cachep, int node)
+static int __node_shrink(struct kmem_cache *cachep, int node)
 {
 	struct slab *slabp;
 	struct kmem_list3 *l3 = cachep->nodelists[node];
@@ -1942,7 +1942,7 @@ static int __node_shrink(kmem_cache_t *c
 	return ret;
 }
 
-static int __cache_shrink(kmem_cache_t *cachep)
+static int __cache_shrink(struct kmem_cache *cachep)
 {
 	int ret = 0, i = 0;
 	struct kmem_list3 *l3;
@@ -1968,7 +1968,7 @@ static int __cache_shrink(kmem_cache_t *
  * Releases as many slabs as possible for a cache.
  * To help debugging, a zero exit status indicates all slabs were released.
  */
-int kmem_cache_shrink(kmem_cache_t *cachep)
+int kmem_cache_shrink(struct kmem_cache *cachep)
 {
 	if (!cachep || in_interrupt())
 		BUG();
@@ -1981,7 +1981,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * kmem_cache_destroy - delete a cache
  * @cachep: the cache to destroy
  *
- * Remove a kmem_cache_t object from the slab cache.
+ * Remove a struct kmem_cache object from the slab cache.
  * Returns 0 on success.
  *
  * It is expected this function will be called by a module when it is
@@ -1994,7 +1994,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
  * The caller must guarantee that noone will allocate memory from the cache
  * during the kmem_cache_destroy().
  */
-int kmem_cache_destroy(kmem_cache_t * cachep)
+int kmem_cache_destroy(struct kmem_cache * cachep)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2045,7 +2045,7 @@ int kmem_cache_destroy(kmem_cache_t * ca
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
+static struct slab* alloc_slabmgmt(struct kmem_cache *cachep, void *objp,
 			int colour_off, gfp_t local_flags)
 {
 	struct slab *slabp;
@@ -2071,7 +2071,7 @@ static inline kmem_bufctl_t *slab_bufctl
 	return (kmem_bufctl_t *)(slabp+1);
 }
 
-static void cache_init_objs(kmem_cache_t *cachep,
+static void cache_init_objs(struct kmem_cache *cachep,
 			struct slab *slabp, unsigned long ctor_flags)
 {
 	int i;
@@ -2117,7 +2117,7 @@ static void cache_init_objs(kmem_cache_t
 	slabp->free = 0;
 }
 
-static void kmem_flagcheck(kmem_cache_t *cachep, unsigned int flags)
+static void kmem_flagcheck(struct kmem_cache *cachep, unsigned int flags)
 {
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
@@ -2128,7 +2128,7 @@ static void kmem_flagcheck(kmem_cache_t 
 	}
 }
 
-static void set_slab_attr(kmem_cache_t *cachep, struct slab *slabp, void *objp)
+static void set_slab_attr(struct kmem_cache *cachep, struct slab *slabp, void *objp)
 {
 	int i;
 	struct page *page;
@@ -2147,7 +2147,7 @@ static void set_slab_attr(kmem_cache_t *
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static int cache_grow(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct slab	*slabp;
 	void		*objp;
@@ -2257,7 +2257,7 @@ static void kfree_debugcheck(const void 
 	}
 }
 
-static void *cache_free_debugcheck(kmem_cache_t *cachep, void *objp,
+static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 					void *caller)
 {
 	struct page *page;
@@ -2324,7 +2324,7 @@ static void *cache_free_debugcheck(kmem_
 	return objp;
 }
 
-static void check_slabp(kmem_cache_t *cachep, struct slab *slabp)
+static void check_slabp(struct kmem_cache *cachep, struct slab *slabp)
 {
 	kmem_bufctl_t i;
 	int entries = 0;
@@ -2354,7 +2354,7 @@ bad:
 #define check_slabp(x,y) do { } while(0)
 #endif
 
-static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
+static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2454,7 +2454,7 @@ alloc_done:
 }
 
 static inline void
-cache_alloc_debugcheck_before(kmem_cache_t *cachep, gfp_t flags)
+cache_alloc_debugcheck_before(struct kmem_cache *cachep, gfp_t flags)
 {
 	might_sleep_if(flags & __GFP_WAIT);
 #if DEBUG
@@ -2464,7 +2464,7 @@ cache_alloc_debugcheck_before(kmem_cache
 
 #if DEBUG
 static void *
-cache_alloc_debugcheck_after(kmem_cache_t *cachep,
+cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 			gfp_t flags, void *objp, void *caller)
 {
 	if (!objp)	
@@ -2508,7 +2508,7 @@ cache_alloc_debugcheck_after(kmem_cache_
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void* objp;
 	struct array_cache *ac;
@@ -2526,7 +2526,7 @@ static inline void *____cache_alloc(kmem
 	return objp;
 }
 
-static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+static inline void *__cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	unsigned long save_flags;
 	void* objp;
@@ -2546,7 +2546,7 @@ static inline void *__cache_alloc(kmem_c
 /*
  * A interface to enable slab creation on nodeid
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
+static void *__cache_alloc_node(struct kmem_cache *cachep, int flags, int nodeid)
 {
 	struct list_head *entry;
  	struct slab *slabp;
@@ -2616,7 +2616,7 @@ done:
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects, int node)
+static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects, int node)
 {
 	int i;
 	struct kmem_list3 *l3;
@@ -2666,7 +2666,7 @@ static void free_block(kmem_cache_t *cac
 	}
 }
 
-static void cache_flusharray(kmem_cache_t *cachep, struct array_cache *ac)
+static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2727,7 +2727,7 @@ free_done:
  *
  * Called with disabled ints.
  */
-static inline void __cache_free(kmem_cache_t *cachep, void *objp)
+static inline void __cache_free(struct kmem_cache *cachep, void *objp)
 {
 	struct array_cache *ac = ac_data(cachep);
 
@@ -2785,7 +2785,7 @@ static inline void __cache_free(kmem_cac
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	return __cache_alloc(cachep, flags);
 }
@@ -2805,7 +2805,7 @@ EXPORT_SYMBOL(kmem_cache_alloc);
  *
  * Currently only used for dentry validation.
  */
-int fastcall kmem_ptr_validate(kmem_cache_t *cachep, void *ptr)
+int fastcall kmem_ptr_validate(struct kmem_cache *cachep, void *ptr)
 {
 	unsigned long addr = (unsigned long) ptr;
 	unsigned long min_addr = PAGE_OFFSET;
@@ -2846,7 +2846,7 @@ out:
  * New and improved: it will now make sure that the object gets
  * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	unsigned long save_flags;
 	void *ptr;
@@ -2875,7 +2875,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
@@ -2908,7 +2908,7 @@ EXPORT_SYMBOL(kmalloc_node);
  */
 void *__kmalloc(size_t size, gfp_t flags)
 {
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -2980,7 +2980,7 @@ EXPORT_SYMBOL(__alloc_percpu);
  * Free an object which was previously allocated from this
  * cache.
  */
-void kmem_cache_free(kmem_cache_t *cachep, void *objp)
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 {
 	unsigned long flags;
 
@@ -3015,7 +3015,7 @@ EXPORT_SYMBOL(kzalloc);
  */
 void kfree(const void *objp)
 {
-	kmem_cache_t *c;
+	struct kmem_cache *c;
 	unsigned long flags;
 
 	if (unlikely(!objp))
@@ -3052,13 +3052,13 @@ free_percpu(const void *objp)
 EXPORT_SYMBOL(free_percpu);
 #endif
 
-unsigned int kmem_cache_size(kmem_cache_t *cachep)
+unsigned int kmem_cache_size(struct kmem_cache *cachep)
 {
 	return obj_reallen(cachep);
 }
 EXPORT_SYMBOL(kmem_cache_size);
 
-const char *kmem_cache_name(kmem_cache_t *cachep)
+const char *kmem_cache_name(struct kmem_cache *cachep)
 {
 	return cachep->name;
 }
@@ -3067,7 +3067,7 @@ EXPORT_SYMBOL_GPL(kmem_cache_name);
 /*
  * This initializes kmem_list3 for all nodes.
  */
-static int alloc_kmemlist(kmem_cache_t *cachep)
+static int alloc_kmemlist(struct kmem_cache *cachep)
 {
 	int node;
 	struct kmem_list3 *l3;
@@ -3123,7 +3123,7 @@ fail:
 }
 
 struct ccupdate_struct {
-	kmem_cache_t *cachep;
+	struct kmem_cache *cachep;
 	struct array_cache *new[NR_CPUS];
 };
 
@@ -3140,7 +3140,7 @@ static void do_ccupdate_local(void *info
 }
 
 
-static int do_tune_cpucache(kmem_cache_t *cachep, int limit, int batchcount,
+static int do_tune_cpucache(struct kmem_cache *cachep, int limit, int batchcount,
 				int shared)
 {
 	struct ccupdate_struct new;
@@ -3185,7 +3185,7 @@ static int do_tune_cpucache(kmem_cache_t
 }
 
 
-static void enable_cpucache(kmem_cache_t *cachep)
+static void enable_cpucache(struct kmem_cache *cachep)
 {
 	int err;
 	int limit, shared;
@@ -3237,7 +3237,7 @@ static void enable_cpucache(kmem_cache_t
 					cachep->name, -err);
 }
 
-static void drain_array_locked(kmem_cache_t *cachep,
+static void drain_array_locked(struct kmem_cache *cachep,
 				struct array_cache *ac, int force, int node)
 {
 	int tofree;
@@ -3280,12 +3280,12 @@ static void cache_reap(void *unused)
 	}
 
 	list_for_each(walk, &cache_chain) {
-		kmem_cache_t *searchp;
+		struct kmem_cache *searchp;
 		struct list_head* p;
 		int tofree;
 		struct slab *slabp;
 
-		searchp = list_entry(walk, kmem_cache_t, next);
+		searchp = list_entry(walk, struct kmem_cache, next);
 
 		if (searchp->flags & SLAB_NO_REAP)
 			goto next;
@@ -3381,15 +3381,15 @@ static void *s_start(struct seq_file *m,
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
-		: list_entry(cachep->next.next, kmem_cache_t, next);
+		: list_entry(cachep->next.next, struct kmem_cache, next);
 }
 
 static void s_stop(struct seq_file *m, void *p)
@@ -3399,7 +3399,7 @@ static void s_stop(struct seq_file *m, v
 
 static int s_show(struct seq_file *m, void *p)
 {
-	kmem_cache_t *cachep = p;
+	struct kmem_cache *cachep = p;
 	struct list_head *q;
 	struct slab	*slabp;
 	unsigned long	active_objs;
@@ -3552,7 +3552,7 @@ ssize_t slabinfo_write(struct file *file
 	down(&cache_chain_sem);
 	res = -EINVAL;
 	list_for_each(p,&cache_chain) {
-		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
+		struct kmem_cache *cachep = list_entry(p, struct kmem_cache, next);
 
 		if (!strcmp(cachep->name, kbuf)) {
 			if (limit < 1 ||
