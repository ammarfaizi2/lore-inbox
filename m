Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUJIUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUJIUlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJIUlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:41:06 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:26583 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267374AbUJIUh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:37:26 -0400
Message-ID: <41684BF3.5070108@colorfullife.com>
Date: Sat, 09 Oct 2004 22:37:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pbadari@us.ibm.com
Subject: [PATCH] reduce fragmentation due to kmem_cache_alloc_node
Content-Type: multipart/mixed;
 boundary="------------040509020600000603000806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509020600000603000806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

attached is a patch that fixes the fragmentation that Badri noticed with 
kmem_cache_alloc_node. Could you add it to the mm tree? The patch is 
against 2.6.9-rc3-mm3.

Description:
kmem_cache_alloc_node tries to allocate memory from a given node. The 
current implementation contains two bugs:
- the node aware code was used even for !CONFIG_NUMA systems. Fix: 
inline function that redefines kmem_cache_alloc_node as kmem_cache_alloc 
for !CONFIG_NUMA.
- the code always allocated a new slab for each new allocation. This 
caused severe fragmentation. Fix: walk the slabp lists and search for a 
matching page instead of allocating a new page.
- the patch also adds a new statistics field for node-local allocs. They 
should be rare - the codepath is quite slow, especially compared to the 
normal kmem_cache_alloc.

Badri: Could you test it?
Andrew, could you add the patch to the next -mm kernel? I'm running it 
right now, no obvious problems.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>


--------------040509020600000603000806
Content-Type: text/plain;
 name="patch-nodealloc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-nodealloc"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 9
//  EXTRAVERSION = -rc3-mm3
--- 2.6/include/linux/slab.h	2004-10-09 21:49:45.000000000 +0200
+++ build-2.6/include/linux/slab.h	2004-10-09 21:55:19.660780713 +0200
@@ -61,7 +61,14 @@
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
+#ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
+#else
+static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
+{
+	return kmem_cache_alloc(cachep, GFP_KERNEL);
+}
+#endif
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
--- 2.6/mm/slab.c	2004-10-09 21:49:59.000000000 +0200
+++ build-2.6/mm/slab.c	2004-10-09 21:57:58.705171317 +0200
@@ -327,6 +327,7 @@
 	unsigned long		reaped;
 	unsigned long 		errors;
 	unsigned long		max_freeable;
+	unsigned long		node_allocs;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
@@ -361,6 +362,7 @@
 					(x)->high_mark = (x)->num_active; \
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
+#define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { if ((x)->max_freeable < i) \
 					(x)->max_freeable = i; \
@@ -378,6 +380,7 @@
 #define	STATS_INC_REAPED(x)	do { } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
+#define	STATS_INC_NODEALLOCS(x)	do { } while (0)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { } while (0)
 
@@ -1747,7 +1750,7 @@
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow (kmem_cache_t * cachep, int flags)
+static int cache_grow (kmem_cache_t * cachep, int flags, int nodeid)
 {
 	struct slab	*slabp;
 	void		*objp;
@@ -1798,7 +1801,7 @@
 
 
 	/* Get mem for the objs. */
-	if (!(objp = kmem_getpages(cachep, flags, -1)))
+	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
 		goto failed;
 
 	/* Get slab management. */
@@ -2032,7 +2035,7 @@
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags);
+		x = cache_grow(cachep, flags, -1);
 		
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
@@ -2313,6 +2316,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
@@ -2325,69 +2329,80 @@
  */
 void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid)
 {
-	size_t offset;
+	int loop;
 	void *objp;
 	struct slab *slabp;
 	kmem_bufctl_t next;
 
-	/* The main algorithms are not node aware, thus we have to cheat:
-	 * We bypass all caches and allocate a new slab.
-	 * The following code is a streamlined copy of cache_grow().
-	 */
+	for (loop = 0;;loop++) {
+		struct list_head *q;
 
-	/* Get colour for the slab, and update the next value. */
-	spin_lock_irq(&cachep->spinlock);
-	offset = cachep->colour_next;
-	cachep->colour_next++;
-	if (cachep->colour_next >= cachep->colour)
-		cachep->colour_next = 0;
-	offset *= cachep->colour_off;
-	spin_unlock_irq(&cachep->spinlock);
-
-	/* Get mem for the objs. */
-	if (!(objp = kmem_getpages(cachep, GFP_KERNEL, nodeid)))
-		goto failed;
+		objp = NULL;
+		check_irq_on();
+		spin_lock_irq(&cachep->spinlock);
+		/* walk through all partial and empty slab and find one
+		 * from the right node */
+		list_for_each(q,&cachep->lists.slabs_partial) {
+			slabp = list_entry(q, struct slab, list);
+
+			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
+					loop > 2)
+				goto got_slabp;
+		}
+		list_for_each(q, &cachep->lists.slabs_free) {
+			slabp = list_entry(q, struct slab, list);
+
+			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
+					loop > 2)
+				goto got_slabp;
+		}
+		spin_unlock_irq(&cachep->spinlock);
 
-	/* Get slab management. */
-	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, GFP_KERNEL)))
-		goto opps1;
+		local_irq_disable();
+		if (!cache_grow(cachep, GFP_KERNEL, nodeid)) {
+			local_irq_enable();
+			return NULL;
+		}
+		local_irq_enable();
+	}
+got_slabp:
+	/* found one: allocate object */
+	check_slabp(cachep, slabp);
+	check_spinlock_acquired(cachep);
 
-	set_slab_attr(cachep, slabp, objp);
-	cache_init_objs(cachep, slabp, SLAB_CTOR_CONSTRUCTOR);
+	STATS_INC_ALLOCED(cachep);
+	STATS_INC_ACTIVE(cachep);
+	STATS_SET_HIGH(cachep);
+	STATS_INC_NODEALLOCS(cachep);
 
-	/* The first object is ours: */
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
+
 	slabp->inuse++;
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
 	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
 #endif
 	slabp->free = next;
-
-	/* add the remaining objects into the cache */
-	spin_lock_irq(&cachep->spinlock);
 	check_slabp(cachep, slabp);
-	STATS_INC_GROWN(cachep);
-	/* Make slab active. */
-	if (slabp->free == BUFCTL_END) {
-		list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_full));
-	} else {
-		list_add_tail(&slabp->list,
-				&(list3_data(cachep)->slabs_partial));
-		list3_data(cachep)->free_objects += cachep->num-1;
-	}
+
+	/* move slabp to correct slabp list: */
+	list_del(&slabp->list);
+	if (slabp->free == BUFCTL_END)
+		list_add(&slabp->list, &cachep->lists.slabs_full);
+	else
+		list_add(&slabp->list, &cachep->lists.slabs_partial);
+
+	list3_data(cachep)->free_objects--;
 	spin_unlock_irq(&cachep->spinlock);
+
 	objp = cache_alloc_debugcheck_after(cachep, GFP_KERNEL, objp,
 					__builtin_return_address(0));
 	return objp;
-opps1:
-	kmem_freepages(cachep, objp);
-failed:
-	return NULL;
-
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+#endif
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
@@ -2812,15 +2827,16 @@
 		 * without _too_ many complaints.
 		 */
 #if STATS
-		seq_puts(m, "slabinfo - version: 2.0 (statistics)\n");
+		seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
 #else
-		seq_puts(m, "slabinfo - version: 2.0\n");
+		seq_puts(m, "slabinfo - version: 2.1\n");
 #endif
 		seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
 		seq_puts(m, " : tunables <batchcount> <limit> <sharedfactor>");
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
-		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit>");
+		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"
+				" <error> <maxfreeable> <freelimit> <nodeallocs>");
 		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_putc(m, '\n');
@@ -2911,10 +2927,11 @@
 		unsigned long errors = cachep->errors;
 		unsigned long max_freeable = cachep->max_freeable;
 		unsigned long free_limit = cachep->free_limit;
+		unsigned long node_allocs = cachep->node_allocs;
 
-		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu",
+		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu %4lu",
 				allocs, high, grown, reaped, errors, 
-				max_freeable, free_limit);
+				max_freeable, free_limit, node_allocs);
 	}
 	/* cpu stats */
 	{

--------------040509020600000603000806--
