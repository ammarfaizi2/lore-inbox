Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWFSSsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWFSSsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWFSSro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:47:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6888 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964839AbWFSSr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:47:26 -0400
Date: Mon, 19 Jun 2006 11:47:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/4] Slab Reclaim logic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kmem_cache_reclaim() function.

This patch adds the new slab reclaim functionalty. For that purpose we add a
new function:

long kmem_cache_reclaim(struct kmem_cache *cache, unsigned long nr_pages)

kmem_cache_reclaim attempts to reclaim nr_pages from the indicated cache.
It returns either the number of reclaimed pages or an error code.

If kmem_cache_reclaim is called on a cache without a destructor and without
the SLAB_RECLAIM flag set then kmem_cache_reclaim simply shrinks the caches
and freelists.

If SLAB_RECLAIM is set then it is assumed that the objects of the slab
have a refcnt as the first element in the object. That refcnt is then used
to guide a slab oriented form of reclaim. It is assummed that a refcount
of zero is designating a free item. A refcount of 1 is an object that
is currently unused.

Reclaim then processes all fully used and partially used slabs looking for
pages that only contain elements with refcount = 1. These are freed by
calling the destructor with the option SLAB_DTOR_FREE. The destructor
must make its best attempt to free the object using kmem_cache_free().

If slabs also contain objects with a higher refcount then a couple of
elements with refcount one will be removed. This done so that new
objects (with potentially higher refcount) can be added again to the
slab. That way slabs develop that are full of long term objects with
higher refcount.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/slab.h	2006-06-19 10:00:33.951924377 -0700
+++ linux-2.6.17-rc6-mm2/include/linux/slab.h	2006-06-19 10:17:49.941653443 -0700
@@ -37,6 +37,7 @@ typedef struct kmem_cache kmem_cache_t;
 #define	SLAB_DEBUG_INITIAL	0x00000200UL	/* Call constructor (as verifier) */
 #define	SLAB_RED_ZONE		0x00000400UL	/* Red zone objs in a cache */
 #define	SLAB_POISON		0x00000800UL	/* Poison objects */
+#define	SLAB_RECLAIM		0x00001000UL	/* Reclaim via destructor calls */
 #define	SLAB_HWCACHE_ALIGN	0x00002000UL	/* align objs on a h/w cache lines */
 #define SLAB_CACHE_DMA		0x00004000UL	/* use GFP_DMA memory */
 #define SLAB_MUST_HWCACHE_ALIGN	0x00008000UL	/* force alignment */
@@ -54,6 +55,7 @@ typedef struct kmem_cache kmem_cache_t;
 
 /* flags passed to a constructor func */
 #define SLAB_DTOR_DESTROY	0x1000UL	/* Called during slab destruction */
+#define SLAB_DTOR_FREE		0x2000UL	/* Called during reclaim */
 
 #ifndef CONFIG_SLOB
 
@@ -225,6 +227,7 @@ extern kmem_cache_t	*bio_cachep;
 
 extern atomic_t slab_reclaim_pages;
 
+extern long kmem_cache_reclaim(struct kmem_cache *, gfp_t flags, unsigned long);
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
Index: linux-2.6.17-rc6-mm2/Documentation/slab_reclaim
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc6-mm2/Documentation/slab_reclaim	2006-06-19 11:17:19.303895253 -0700
@@ -0,0 +1,57 @@
+Slab Reclaim
+-----------
+
+A slab may use slab reclaim if
+
+1. An atomic_t refcounter is the first element of the objects.
+
+2. SLAB_RECLAIM was set when calling kmem_cache_create()
+
+3. A destructor function is provided that frees the object
+   (after some final checks that this is possible and removing
+   all links) by calling kmem_cache_free() on it.
+
+Slab reclaim establishes the state of an object through
+the refcount. It distinguises the following states:
+
+1. refcount = 0
+
+	In that case the object was freed
+	and may have been initialized with
+	a constructor. The object is on the free lists
+	of the allocator or marked free in the slab pages.
+
+2. refcount = 1
+
+	The objects is currently not used but set up with information
+	that may be useful in the future.
+	The entry could be disposed of if memory pressure builds up.
+
+3. refcount > 1
+
+	The object is in active use and cannot be
+	reclaimed.
+
+If slab reclaim attempt to reclaim an object then the destructor
+will be called with SLAB_DTOR_FREE set.
+
+A simple definition of a destructor:
+
+void dtor(kmem_cache_t *cachep, void *p, unsigned long flags)
+{
+	struct object *o = p;
+
+	if (!(flags & SLAB_DTOR_FREE))
+		/* Another type of destructor invocation */
+		return;
+
+	if (!atomic_dec_and_test(&o->refcount))
+		/* Already freed */
+		return;
+
+	remove_references(o);
+	free_attached_structures(o);
+	kmem_cache_free(cachep, o);
+}
+
+
Index: linux-2.6.17-rc6-mm2/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/mm/slab.c	2006-06-17 14:28:47.626589639 -0700
+++ linux-2.6.17-rc6-mm2/mm/slab.c	2006-06-19 11:23:43.960746537 -0700
@@ -173,12 +173,12 @@
 #if DEBUG
 # define CREATE_MASK	(SLAB_DEBUG_INITIAL | SLAB_RED_ZONE | \
 			 SLAB_POISON | SLAB_HWCACHE_ALIGN | \
-			 SLAB_CACHE_DMA | \
+			 SLAB_CACHE_DMA | SLAB_RECLAIM \
 			 SLAB_MUST_HWCACHE_ALIGN | SLAB_STORE_USER | \
 			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
 			 SLAB_DESTROY_BY_RCU | SLAB_MEM_SPREAD)
 #else
-# define CREATE_MASK	(SLAB_HWCACHE_ALIGN | \
+# define CREATE_MASK	(SLAB_HWCACHE_ALIGN | SLAB_RECLAIM \
 			 SLAB_CACHE_DMA | SLAB_MUST_HWCACHE_ALIGN | \
 			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
 			 SLAB_DESTROY_BY_RCU | SLAB_MEM_SPREAD)
@@ -221,8 +221,9 @@ struct slab {
 	unsigned long colouroff;
 	void *s_mem;		/* including colour offset */
 	unsigned int inuse;	/* num of objs active in slab */
-	kmem_bufctl_t free;
 	unsigned short nodeid;
+	unsigned short marker;
+	kmem_bufctl_t free;
 };
 
 /*
@@ -298,6 +299,7 @@ struct kmem_list3 {
 	struct array_cache **alien;	/* on other nodes */
 	unsigned long next_reap;	/* updated without locking */
 	int free_touched;		/* updated without locking */
+	atomic_t reclaim;			/* Reclaim in progress */
 };
 
 /*
@@ -396,7 +398,6 @@ struct kmem_cache {
 	unsigned int colour_off;	/* colour offset */
 	struct kmem_cache *slabp_cache;
 	unsigned int slab_size;
-	unsigned int dflags;		/* dynamic flags */
 
 	/* constructor func */
 	void (*ctor) (void *, struct kmem_cache *, unsigned long);
@@ -3103,7 +3104,12 @@ static void free_block(struct kmem_cache
 
 		/* fixup slab chains */
 		if (slabp->inuse == 0) {
-			if (l3->free_objects > l3->free_limit) {
+			/*
+			 * Destroy the object if we have too many of them
+			 * We cannot destroy during reclaim
+			 */
+			if (l3->free_objects > l3->free_limit &&
+					!atomic_read(&l3->reclaim)) {
 				l3->free_objects -= cachep->num;
 				/*
 				 * It is safe to drop the lock. The slab is
@@ -3792,7 +3798,7 @@ static void cache_reap(void *unused)
 
 		if (l3->free_touched)
 			l3->free_touched = 0;
-		else {
+		else if (!atomic_read(&l3->reclaim)) {
 			int x;
 
 			x = drain_freelist(searchp, l3, (l3->free_limit +
@@ -4242,3 +4248,183 @@ void kmem_set_shrinker(kmem_cache_t *cac
 	cachep->shrinker = shrinker;
 }
 EXPORT_SYMBOL(kmem_set_shrinker);
+
+/*
+ * Reclaim logic based on the per node slab lists.
+ */
+
+/*
+ * Reclaim from a single slab object.
+ */
+static int try_reclaim_one(kmem_cache_t *cachep, struct kmem_list3 *l3,
+	struct list_head *list, unsigned short marker)
+{
+	int max_refcnt;
+	int min_free;
+	struct slab *slabp;
+	struct list_head *p;
+	int i;
+
+	/* Retrieve the last slab under lock and then make the last slab
+	 * the first one so that the next call to try_to_reclaim one
+	 * will cycle through all slab objects.
+	 *
+	 * Note that no slabs will be destroyed and freed via the page
+	 * allocator since we have incremented reclaim. So we are guaranteed that
+	 * the slab will not vanish from under us even after we dropped the
+	 * list_lock.
+	 */
+	spin_lock_irq(&l3->list_lock);
+	p = list->prev;
+	if (unlikely(p == list)) {
+		/* Empty list */
+		spin_unlock_irq(&l3->list_lock);
+		return -1;
+	}
+
+	slabp = list_entry(p, struct slab, list);
+	if (unlikely(slabp->marker == marker)) {
+		/* We already did this one. Pass complete */
+		spin_unlock_irq(&l3->list_lock);
+		return -1;
+	}
+	list_move(p, list);
+	spin_unlock_irq(&l3->list_lock);
+
+	min_free = 0;
+	if (slabp->inuse == cachep->num) {
+		/*
+		 * Full slab object. Free some to bring together
+		 * objects with higher refcounts
+		 */
+		if (cachep->num > 16)
+			/* 1/16th of objects for large slabs */
+			min_free = cachep->num / 16;
+		else if (cachep->num > 3)
+			/* For a smaller object count free at least one */
+			min_free = 1;
+	}
+
+	/*
+	 * First pass over the slab: We free the first min_free objects
+	 * with refcnt one and establish the higest refcnt in the block.
+	 *
+	 * Clearing one or a few refcnt one (=unused) items means that
+	 * slabs will gradually fill up with objects with higher refcnts.
+	 * This means we will create a higher object density.
+	 */
+	max_refcnt = 0;
+	for (i = 0; i < cachep->num; i++) {
+		atomic_t *objp = index_to_obj(cachep, slabp, i);
+		int refcnt = atomic_read(objp);
+
+		if (refcnt == 1 && min_free > 0) {
+			min_free--;
+			cachep->dtor(objp, cachep, SLAB_DTOR_FREE);
+		}
+		max_refcnt = max(max_refcnt, refcnt);
+	}
+
+
+	if (max_refcnt > 1)
+		/* Cannot free the block */
+		return 0;
+
+	/*
+	 * The slab only contains objects with refcnt 1 (=unused)
+	 * this means that we can free the slab object completely
+	 * if we free all the objects.
+	 */
+	for (i = 0; i < cachep->num; i++) {
+		atomic_t *objp = index_to_obj(cachep, slabp, i);
+		int refcnt = atomic_read(objp);
+
+		if (refcnt == 1)
+			cachep->dtor(objp, cachep, SLAB_DTOR_FREE);
+	}
+	return 1;
+}
+
+/*
+ * Scan over a list of slabs and attempt to reclaim each.
+ */
+static int reclaim_scan(kmem_cache_t *cachep, struct kmem_list3 *l3,
+	int slabs_to_free, struct list_head *list, unsigned short marker)
+{
+	int nr_freed = 0;
+
+	while (nr_freed < slabs_to_free) {
+		int x;
+
+		x = try_reclaim_one(cachep, l3, list, marker);
+		if (x > 0)
+			nr_freed += x;
+		else
+			break;
+	}
+	return nr_freed;
+}
+
+/*
+ * Free pages from this nodes pages from the indicated slab. The thread
+ * calling this function must be pinned to this node.
+ */
+long kmem_cache_reclaim(kmem_cache_t *cachep, gfp_t flags, unsigned long pages)
+{
+	struct kmem_list3 *l3 = cachep->nodelists[numa_node_id()];
+	int nr_freed;
+	unsigned short marker = jiffies;	/* Just some unique bit pattern */
+	int slabs_to_free = (pages + ((1 << cachep->gfporder) -1)) >>
+							cachep->gfporder;
+
+	/*
+	 * Push cached objects into the lists. That way more pages may
+	 * be freeable.
+	 */
+	drain_cpu_caches(cachep);
+
+	/* First we reclaim from the freelists */
+	nr_freed = drain_freelist(cachep, l3, slabs_to_free);
+
+	/*
+	 * We can only do more in depth reclaim if we have
+	 * a destructor and the flags indicate that the refcnt
+	 * is the first element in the object.
+	 */
+	if (nr_freed >= slabs_to_free || !cachep->dtor ||
+		!(cachep->flags & SLAB_RECLAIM))
+		goto done;
+
+	/*
+	 * An increased reclaim count stops the freeing of slabs to the
+	 * page allocator. This allows us to inspect slabs without holding
+	 * the list lock.
+	 */
+	if (atomic_read(&l3->reclaim) > 1)
+		goto dec;
+
+	/* Try to free items from the full lists */
+	nr_freed += reclaim_scan(cachep, l3, slabs_to_free - nr_freed,
+					 &l3->slabs_full, marker);
+
+	if (nr_freed >= slabs_to_free)
+		goto dec;
+
+	/* Try to free items from the partial lists */
+	nr_freed += reclaim_scan(cachep, l3, slabs_to_free - nr_freed,
+					&l3->slabs_partial, marker);
+
+	/*
+	 * At this point we have freed all freeable slabs of the cache
+	 * and we have freed a mininum number of objects free for each slab
+	 */
+
+dec:
+	atomic_dec(&l3->reclaim);
+	/* Drop the large free lists that we may have build while scanning */
+	drain_freelist(cachep, l3, slabs_to_free);
+done:
+	return nr_freed << cachep->gfporder;
+
+}
+
