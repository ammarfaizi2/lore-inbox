Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270127AbUJTK0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270127AbUJTK0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269990AbUJTKX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:23:58 -0400
Received: from asplinux.ru ([195.133.213.194]:10761 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S270158AbUJTKQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:16:01 -0400
Message-ID: <41763AF6.5000105@sw.ru>
Date: Wed, 20 Oct 2004 14:16:22 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] moving some of slab allocator declarations to header files
Content-Type: multipart/mixed;
 boundary="------------020806000807010707090500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020806000807010707090500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] moving some of slab allocator declarations to header files

This patch moves most part of generic slab allocator declarations to new 
header files kmem_cache.h and kmem_slab.h, which can be usefull for 
debuging and making code more splitted from decls.
It doesn't change any functionality.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------020806000807010707090500
Content-Type: text/plain;
 name="diff-kmem_cache-headers-2.6.9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-kmem_cache-headers-2.6.9"

--- ./include/linux/kmem_cache.h.slabh	2004-10-20 13:37:30.000000000 +0400
+++ ./include/linux/kmem_cache.h	2004-10-20 13:40:32.000000000 +0400
@@ -0,0 +1,146 @@
+#ifndef __KMEM_CACHE_H__
+#define __KMEM_CACHE_H__
+
+#include <linux/threads.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <asm/atomic.h>
+
+/*
+ * struct array_cache
+ *
+ * Per cpu structures
+ * Purpose:
+ * - LIFO ordering, to hand out cache-warm objects from _alloc
+ * - reduce the number of linked list operations
+ * - reduce spinlock operations
+ *
+ * The limit is stored in the per-cpu structure to reduce the data cache
+ * footprint.
+ *
+ */
+struct array_cache {
+	unsigned int avail;
+	unsigned int limit;
+	unsigned int batchcount;
+	unsigned int touched;
+};
+
+/* bootstrap: The caches do not work without cpuarrays anymore,
+ * but the cpuarrays are allocated from the generic caches...
+ */
+#define BOOT_CPUCACHE_ENTRIES	1
+struct arraycache_init {
+	struct array_cache cache;
+	void * entries[BOOT_CPUCACHE_ENTRIES];
+};
+
+/*
+ * The slab lists of all objects.
+ * Hopefully reduce the internal fragmentation
+ * NUMA: The spinlock could be moved from the kmem_cache_t
+ * into this structure, too. Figure out what causes
+ * fewer cross-node spinlock operations.
+ */
+struct kmem_list3 {
+	struct list_head	slabs_partial;	/* partial list first, better asm code */
+	struct list_head	slabs_full;
+	struct list_head	slabs_free;
+	unsigned long	free_objects;
+	int		free_touched;
+	unsigned long	next_reap;
+	struct array_cache	*shared;
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
+ * kmem_cache_t
+ *
+ * manages a cache.
+ */
+	
+struct kmem_cache_s {
+/* 1) per-cpu data, touched during every alloc/free */
+	struct array_cache	*array[NR_CPUS];
+	unsigned int		batchcount;
+	unsigned int		limit;
+/* 2) touched by every alloc & free from the backend */
+	struct kmem_list3	lists;
+	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
+	unsigned int		objsize;
+	unsigned int	 	flags;	/* constant flags */
+	unsigned int		num;	/* # of objs per slab */
+	unsigned int		free_limit; /* upper limit of objects in the lists */
+	spinlock_t		spinlock;
+
+/* 3) cache_grow/shrink */
+	/* order of pgs per slab (2^n) */
+	unsigned int		gfporder;
+
+	/* force GFP flags, e.g. GFP_DMA */
+	unsigned int		gfpflags;
+
+	size_t			colour;		/* cache colouring range */
+	unsigned int		colour_off;	/* colour offset */
+	unsigned int		colour_next;	/* cache colouring */
+	kmem_cache_t		*slabp_cache;
+	unsigned int		slab_size;
+	unsigned int		dflags;		/* dynamic flags */
+
+	/* constructor func */
+	void (*ctor)(void *, kmem_cache_t *, unsigned long);
+
+	/* de-constructor func */
+	void (*dtor)(void *, kmem_cache_t *, unsigned long);
+
+/* 4) cache creation/removal */
+	const char		*name;
+	struct list_head	next;
+
+/* 5) statistics */
+#if STATS
+	unsigned long		num_active;
+	unsigned long		num_allocations;
+	unsigned long		high_mark;
+	unsigned long		grown;
+	unsigned long		reaped;
+	unsigned long 		errors;
+	unsigned long		max_freeable;
+	atomic_t		allochit;
+	atomic_t		allocmiss;
+	atomic_t		freehit;
+	atomic_t		freemiss;
+#endif
+#if DEBUG
+	int			dbghead;
+	int			reallen;
+#endif
+};
+
+#define CFLGS_OFF_SLAB		(0x80000000UL)
+#define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
+
+/* Macros for storing/retrieving the cachep and or slab from the
+ * global 'mem_map'. These are used to find the slab an obj belongs to.
+ * With kfree(), these are used to find the cache which an obj belongs to.
+ */
+#define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
+#define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
+#define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
+#define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
+
+#endif /* __KMEM_CACHE_H__ */
--- ./include/linux/kmem_slab.h.slabh	2004-10-20 13:37:30.000000000 +0400
+++ ./include/linux/kmem_slab.h	2004-10-20 13:37:30.000000000 +0400
@@ -0,0 +1,69 @@
+#ifndef __KMEM_SLAB_H__
+#define __KMEM_SLAB_H__
+
+/*
+ * kmem_bufctl_t:
+ *
+ * Bufctl's are used for linking objs within a slab
+ * linked offsets.
+ *
+ * This implementation relies on "struct page" for locating the cache &
+ * slab an object belongs to.
+ * This allows the bufctl structure to be small (one int), but limits
+ * the number of objects a slab (not a cache) can contain when off-slab
+ * bufctls are used. The limit is the size of the largest general cache
+ * that does not use off-slab slabs.
+ * For 32bit archs with 4 kB pages, is this 56.
+ * This is not serious, as it is only for large objects, when it is unwise
+ * to have too many per slab.
+ * Note: This limit can be raised by introducing a general cache whose size
+ * is less than 512 (PAGE_SIZE<<3), but greater than 256.
+ */
+
+#define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
+#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
+#define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
+
+/*
+ * struct slab
+ *
+ * Manages the objs in a slab. Placed either at the beginning of mem allocated
+ * for a slab, or allocated from an general cache.
+ * Slabs are chained into three list: fully used, partial, fully free slabs.
+ */
+struct slab {
+	struct list_head	list;
+	unsigned long		colouroff;
+	void			*s_mem;		/* including colour offset */
+	unsigned int		inuse;		/* num of objs active in slab */
+	kmem_bufctl_t		free;
+};
+
+/*
+ * struct slab_rcu
+ *
+ * slab_destroy on a SLAB_DESTROY_BY_RCU cache uses this structure to
+ * arrange for kmem_freepages to be called via RCU.  This is useful if
+ * we need to approach a kernel structure obliquely, from its address
+ * obtained without the usual locking.  We can lock the structure to
+ * stabilize it and check it's still at the given address, only if we
+ * can be sure that the memory has not been meanwhile reused for some
+ * other kind of object (which our subsystem's lock might corrupt).
+ *
+ * rcu_read_lock before reading the address, then rcu_read_unlock after
+ * taking the spinlock within the structure expected at that address.
+ *
+ * We assume struct slab_rcu can overlay struct slab when destroying.
+ */
+struct slab_rcu {
+	struct rcu_head		head;
+	kmem_cache_t		*cachep;
+	void			*addr;
+};
+
+static inline kmem_bufctl_t *slab_bufctl(struct slab *slabp)
+{
+	return (kmem_bufctl_t *)(slabp+1);
+}
+
+#endif /* __KMEM_SLAB_H__ */
--- ./mm/slab.c.slabh	2004-10-20 13:25:24.000000000 +0400
+++ ./mm/slab.c	2004-10-20 13:43:45.000000000 +0400
@@ -119,6 +119,8 @@
 #define	FORCED_DEBUG	0
 #endif
 
+#include <linux/kmem_slab.h>
+#include <linux/kmem_cache.h>
 
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
@@ -150,197 +152,11 @@
 			 SLAB_DESTROY_BY_RCU)
 #endif
 
-/*
- * kmem_bufctl_t:
- *
- * Bufctl's are used for linking objs within a slab
- * linked offsets.
- *
- * This implementation relies on "struct page" for locating the cache &
- * slab an object belongs to.
- * This allows the bufctl structure to be small (one int), but limits
- * the number of objects a slab (not a cache) can contain when off-slab
- * bufctls are used. The limit is the size of the largest general cache
- * that does not use off-slab slabs.
- * For 32bit archs with 4 kB pages, is this 56.
- * This is not serious, as it is only for large objects, when it is unwise
- * to have too many per slab.
- * Note: This limit can be raised by introducing a general cache whose size
- * is less than 512 (PAGE_SIZE<<3), but greater than 256.
- */
-
-#define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
-#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
-#define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
-
 /* Max number of objs-per-slab for caches which use off-slab slabs.
  * Needed to avoid a possible looping condition in cache_grow().
  */
 static unsigned long offslab_limit;
 
-/*
- * struct slab
- *
- * Manages the objs in a slab. Placed either at the beginning of mem allocated
- * for a slab, or allocated from an general cache.
- * Slabs are chained into three list: fully used, partial, fully free slabs.
- */
-struct slab {
-	struct list_head	list;
-	unsigned long		colouroff;
-	void			*s_mem;		/* including colour offset */
-	unsigned int		inuse;		/* num of objs active in slab */
-	kmem_bufctl_t		free;
-};
-
-/*
- * struct slab_rcu
- *
- * slab_destroy on a SLAB_DESTROY_BY_RCU cache uses this structure to
- * arrange for kmem_freepages to be called via RCU.  This is useful if
- * we need to approach a kernel structure obliquely, from its address
- * obtained without the usual locking.  We can lock the structure to
- * stabilize it and check it's still at the given address, only if we
- * can be sure that the memory has not been meanwhile reused for some
- * other kind of object (which our subsystem's lock might corrupt).
- *
- * rcu_read_lock before reading the address, then rcu_read_unlock after
- * taking the spinlock within the structure expected at that address.
- *
- * We assume struct slab_rcu can overlay struct slab when destroying.
- */
-struct slab_rcu {
-	struct rcu_head		head;
-	kmem_cache_t		*cachep;
-	void			*addr;
-};
-
-/*
- * struct array_cache
- *
- * Per cpu structures
- * Purpose:
- * - LIFO ordering, to hand out cache-warm objects from _alloc
- * - reduce the number of linked list operations
- * - reduce spinlock operations
- *
- * The limit is stored in the per-cpu structure to reduce the data cache
- * footprint.
- *
- */
-struct array_cache {
-	unsigned int avail;
-	unsigned int limit;
-	unsigned int batchcount;
-	unsigned int touched;
-};
-
-/* bootstrap: The caches do not work without cpuarrays anymore,
- * but the cpuarrays are allocated from the generic caches...
- */
-#define BOOT_CPUCACHE_ENTRIES	1
-struct arraycache_init {
-	struct array_cache cache;
-	void * entries[BOOT_CPUCACHE_ENTRIES];
-};
-
-/*
- * The slab lists of all objects.
- * Hopefully reduce the internal fragmentation
- * NUMA: The spinlock could be moved from the kmem_cache_t
- * into this structure, too. Figure out what causes
- * fewer cross-node spinlock operations.
- */
-struct kmem_list3 {
-	struct list_head	slabs_partial;	/* partial list first, better asm code */
-	struct list_head	slabs_full;
-	struct list_head	slabs_free;
-	unsigned long	free_objects;
-	int		free_touched;
-	unsigned long	next_reap;
-	struct array_cache	*shared;
-};
-
-#define LIST3_INIT(parent) \
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
-
-/*
- * kmem_cache_t
- *
- * manages a cache.
- */
-	
-struct kmem_cache_s {
-/* 1) per-cpu data, touched during every alloc/free */
-	struct array_cache	*array[NR_CPUS];
-	unsigned int		batchcount;
-	unsigned int		limit;
-/* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	lists;
-	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
-	unsigned int		objsize;
-	unsigned int	 	flags;	/* constant flags */
-	unsigned int		num;	/* # of objs per slab */
-	unsigned int		free_limit; /* upper limit of objects in the lists */
-	spinlock_t		spinlock;
-
-/* 3) cache_grow/shrink */
-	/* order of pgs per slab (2^n) */
-	unsigned int		gfporder;
-
-	/* force GFP flags, e.g. GFP_DMA */
-	unsigned int		gfpflags;
-
-	size_t			colour;		/* cache colouring range */
-	unsigned int		colour_off;	/* colour offset */
-	unsigned int		colour_next;	/* cache colouring */
-	kmem_cache_t		*slabp_cache;
-	unsigned int		slab_size;
-	unsigned int		dflags;		/* dynamic flags */
-
-	/* constructor func */
-	void (*ctor)(void *, kmem_cache_t *, unsigned long);
-
-	/* de-constructor func */
-	void (*dtor)(void *, kmem_cache_t *, unsigned long);
-
-/* 4) cache creation/removal */
-	const char		*name;
-	struct list_head	next;
-
-/* 5) statistics */
-#if STATS
-	unsigned long		num_active;
-	unsigned long		num_allocations;
-	unsigned long		high_mark;
-	unsigned long		grown;
-	unsigned long		reaped;
-	unsigned long 		errors;
-	unsigned long		max_freeable;
-	atomic_t		allochit;
-	atomic_t		allocmiss;
-	atomic_t		freehit;
-	atomic_t		freemiss;
-#endif
-#if DEBUG
-	int			dbghead;
-	int			reallen;
-#endif
-};
-
-#define CFLGS_OFF_SLAB		(0x80000000UL)
-#define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
-
 #define BATCHREFILL_LIMIT	16
 /* Optimization question: fewer reaps means less 
  * probability for unnessary cpucache drain/refill cycles.
@@ -472,15 +288,6 @@ static void **dbg_userword(kmem_cache_t 
 #define	BREAK_GFP_ORDER_LO	0
 static int slab_break_gfp_order = BREAK_GFP_ORDER_LO;
 
-/* Macros for storing/retrieving the cachep and or slab from the
- * global 'mem_map'. These are used to find the slab an obj belongs to.
- * With kfree(), these are used to find the cache which an obj belongs to.
- */
-#define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
-#define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
-#define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
-#define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)
-
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
@@ -1666,11 +1473,6 @@ static struct slab* alloc_slabmgmt (kmem
 	return slabp;
 }
 
-static inline kmem_bufctl_t *slab_bufctl(struct slab *slabp)
-{
-	return (kmem_bufctl_t *)(slabp+1);
-}
-
 static void cache_init_objs (kmem_cache_t * cachep,
 			struct slab * slabp, unsigned long ctor_flags)
 {

--------------020806000807010707090500--

