Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271843AbRICWST>; Mon, 3 Sep 2001 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271842AbRICWSN>; Mon, 3 Sep 2001 18:18:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13376 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271839AbRICWSD>; Mon, 3 Sep 2001 18:18:03 -0400
Date: Tue, 4 Sep 2001 00:02:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.9-ac7
Message-ID: <20010904000217.Y699@athlon.random>
In-Reply-To: <20010903201813.A8730@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010903201813.A8730@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Mon, Sep 03, 2001 at 08:18:13PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 08:18:13PM +0100, Alan Cox wrote:
> 2.4.9-ac7
> o	Update slab cache to do LIFO handling and clean	(Andrea Arcangeli)
> 	up code somewhat

Thanks Alan for merging those patches.

Linus please apply this below one to mainline too, here it is ready to
be applied on top of 2.4.10pre4:

diff -urN 2.4.3aa/mm/slab.c 2.4.3aa-slab/mm/slab.c
--- 2.4.3aa/mm/slab.c	Sat Mar 31 15:17:34 2001
+++ 2.4.3aa-slab/mm/slab.c	Sun Apr  1 12:25:23 2001
@@ -140,8 +140,7 @@
  *
  * Manages the objs in a slab. Placed either at the beginning of mem allocated
  * for a slab, or allocated from an general cache.
- * Slabs are chained into one ordered list: fully used, partial, then fully
- * free slabs.
+ * Slabs are chained into three list: fully used, partial, fully free slabs.
  */
 typedef struct slab_s {
 	struct list_head	list;
@@ -167,7 +166,7 @@
 } cpucache_t;
 
 #define cc_entry(cpucache) \
-	((void **)(((cpucache_t*)cpucache)+1))
+	((void **)(((cpucache_t*)(cpucache))+1))
 #define cc_data(cachep) \
 	((cachep)->cpudata[smp_processor_id()])
 /*
@@ -181,8 +180,9 @@
 struct kmem_cache_s {
 /* 1) each alloc & free */
 	/* full, partial first, then free */
-	struct list_head	slabs;
-	struct list_head	*firstnotfull;
+	struct list_head	slabs_full;
+	struct list_head	slabs_partial;
+	struct list_head	slabs_free;
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
@@ -345,8 +345,9 @@
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	slabs:		LIST_HEAD_INIT(cache_cache.slabs),
-	firstnotfull:	&cache_cache.slabs,
+	slabs_full:	LIST_HEAD_INIT(cache_cache.slabs_full),
+	slabs_partial:	LIST_HEAD_INIT(cache_cache.slabs_partial),
+	slabs_free:	LIST_HEAD_INIT(cache_cache.slabs_free),
 	objsize:	sizeof(kmem_cache_t),
 	flags:		SLAB_NO_REAP,
 	spinlock:	SPIN_LOCK_UNLOCKED,
@@ -777,8 +778,9 @@
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	INIT_LIST_HEAD(&cachep->slabs);
-	cachep->firstnotfull = &cachep->slabs;
+	INIT_LIST_HEAD(&cachep->slabs_full);
+	INIT_LIST_HEAD(&cachep->slabs_partial);
+	INIT_LIST_HEAD(&cachep->slabs_free);
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -886,23 +888,20 @@
 	while (!cachep->growing) {
 		struct list_head *p;
 
-		p = cachep->slabs.prev;
-		if (p == &cachep->slabs)
+		p = cachep->slabs_free.prev;
+		if (p == &cachep->slabs_free)
 			break;
 
-		slabp = list_entry(cachep->slabs.prev, slab_t, list);
+		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
 		if (slabp->inuse)
-			break;
-
+			BUG();
 		list_del(&slabp->list);
-		if (cachep->firstnotfull == &slabp->list)
-			cachep->firstnotfull = &cachep->slabs;
 
 		spin_unlock_irq(&cachep->spinlock);
 		kmem_slab_destroy(cachep, slabp);
 		spin_lock_irq(&cachep->spinlock);
 	}
-	ret = !list_empty(&cachep->slabs);
+	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
@@ -1128,9 +1127,7 @@
 	cachep->growing--;
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list,&cachep->slabs);
-	if (cachep->firstnotfull == &cachep->slabs)
-		cachep->firstnotfull = &slabp->list;
+	list_add_tail(&slabp->list, &cachep->slabs_free);
 	STATS_INC_GROWN(cachep);
 	cachep->failures = 0;
 
@@ -1187,7 +1184,7 @@
 }
 
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
-							 slab_t *slabp)
+						slab_t *slabp, int partial)
 {
 	void *objp;
 
@@ -1200,9 +1197,15 @@
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
 	slabp->free=slab_bufctl(slabp)[slabp->free];
 
-	if (slabp->free == BUFCTL_END)
-		/* slab now full: move to next slab for next alloc */
-		cachep->firstnotfull = slabp->list.next;
+	if (slabp->free == BUFCTL_END) {
+		list_del(&slabp->list);
+		list_add(&slabp->list, &cachep->slabs_full);
+	} else {
+		if (!partial) {
+			list_del(&slabp->list);
+			list_add(&slabp->list, &cachep->slabs_partial);
+		}
+	}
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
 		if (kmem_check_poison_obj(cachep, objp))
@@ -1228,16 +1231,20 @@
  */
 #define kmem_cache_alloc_one(cachep)				\
 ({								\
-	slab_t	*slabp;					\
+	slab_t	*slabp;						\
+	struct list_head * slab_freelist;			\
+	int partial = 1;					\
 								\
-	/* Get slab alloc is to come from. */			\
-	{							\
-		struct list_head* p = cachep->firstnotfull;	\
-		if (p == &cachep->slabs)			\
+	slab_freelist = &(cachep)->slabs_partial;		\
+	if (list_empty(slab_freelist)) {			\
+		partial = 0;					\
+		slab_freelist = &(cachep)->slabs_free;		\
+		if (list_empty(slab_freelist))			\
 			goto alloc_new_slab;			\
-		slabp = list_entry(p,slab_t, list);	\
 	}							\
-	kmem_cache_alloc_one_tail(cachep, slabp);		\
+								\
+	slabp = list_entry(slab_freelist->next, slab_t, list);	\
+	kmem_cache_alloc_one_tail(cachep, slabp, partial);	\
 })
 
 #ifdef CONFIG_SMP
@@ -1245,18 +1252,25 @@
 {
 	int batchcount = cachep->batchcount;
 	cpucache_t* cc = cc_data(cachep);
+	struct list_head * slab_freelist;
+	int partial;
+	slab_t *slabp;
 
 	spin_lock(&cachep->spinlock);
 	while (batchcount--) {
 		/* Get slab alloc is to come from. */
-		struct list_head *p = cachep->firstnotfull;
-		slab_t *slabp;
+		slab_freelist = &(cachep)->slabs_partial;
+		partial = 1;
+		if (list_empty(slab_freelist)) {
+			partial = 0;
+			slab_freelist = &(cachep)->slabs_free;
+			if (list_empty(slab_freelist))
+				break;
+		}
 
-		if (p == &cachep->slabs)
-			break;
-		slabp = list_entry(p,slab_t, list);
+		slabp = list_entry(slab_freelist->next, slab_t, list);
 		cc_entry(cc)[cc->avail++] =
-				kmem_cache_alloc_one_tail(cachep, slabp);
+				kmem_cache_alloc_one_tail(cachep, slabp, partial);
 	}
 	spin_unlock(&cachep->spinlock);
 
@@ -1386,43 +1400,24 @@
 	}
 	STATS_DEC_ACTIVE(cachep);
 	
-	/* fixup slab chain */
-	if (slabp->inuse-- == cachep->num)
-		goto moveslab_partial;
-	if (!slabp->inuse)
+	/* fixup slab chains */
+	if (!--slabp->inuse)
 		goto moveslab_free;
+	if (slabp->inuse + 1 == cachep->num)
+		goto moveslab_partial;
 	return;
 
 moveslab_partial:
-    	/* was full.
-	 * Even if the page is now empty, we can set c_firstnotfull to
-	 * slabp: there are no partial slabs in this case
-	 */
-	{
-		struct list_head *t = cachep->firstnotfull;
+    	/* Was full. */
+	list_del(&slabp->list);
+	list_add(&slabp->list, &cachep->slabs_partial);
+	return;
 
-		cachep->firstnotfull = &slabp->list;
-		if (slabp->list.next == t)
-			return;
-		list_del(&slabp->list);
-		list_add_tail(&slabp->list, t);
-		return;
-	}
 moveslab_free:
-	/*
-	 * was partial, now empty.
-	 * c_firstnotfull might point to slabp
-	 * FIXME: optimize
-	 */
-	{
-		struct list_head *t = cachep->firstnotfull->prev;
-
-		list_del(&slabp->list);
-		list_add_tail(&slabp->list, &cachep->slabs);
-		if (cachep->firstnotfull == &slabp->list)
-			cachep->firstnotfull = t->next;
-		return;
-	}
+	/* Was partial, now empty. */
+	list_del(&slabp->list);
+	list_add(&slabp->list, &cachep->slabs_free);
+	return;
 }
 
 #ifdef CONFIG_SMP
@@ -1727,13 +1722,13 @@
 #endif
 
 		full_free = 0;
-		p = searchp->slabs.prev;
-		while (p != &searchp->slabs) {
+		p = searchp->slabs_free.next;
+		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
 			if (slabp->inuse)
-				break;
+				BUG();
 			full_free++;
-			p = p->prev;
+			p = p->next;
 		}
 
 		/*
@@ -1750,7 +1745,7 @@
 			best_cachep = searchp;
 			best_len = full_free;
 			best_pages = pages;
-			if (full_free >= REAP_PERFECT) {
+			if (pages >= REAP_PERFECT) {
 				clock_searchp = list_entry(searchp->next.next,
 							kmem_cache_t,next);
 				goto perfect;
@@ -1770,22 +1765,20 @@
 
 	spin_lock_irq(&best_cachep->spinlock);
 perfect:
-	/* free only 80% of the free slabs */
-	best_len = (best_len*4 + 1)/5;
+	/* free only 50% of the free slabs */
+	best_len = (best_len + 1)/2;
 	for (scan = 0; scan < best_len; scan++) {
 		struct list_head *p;
 
 		if (best_cachep->growing)
 			break;
-		p = best_cachep->slabs.prev;
-		if (p == &best_cachep->slabs)
+		p = best_cachep->slabs_free.prev;
+		if (p == &best_cachep->slabs_free)
 			break;
 		slabp = list_entry(p,slab_t,list);
 		if (slabp->inuse)
-			break;
+			BUG();
 		list_del(&slabp->list);
-		if (best_cachep->firstnotfull == &slabp->list)
-			best_cachep->firstnotfull = &best_cachep->slabs;
 		STATS_INC_REAPED(best_cachep);
 
 		/* Safe to drop the lock. The slab is no longer linked to the
@@ -1851,14 +1844,25 @@
 		spin_lock_irq(&cachep->spinlock);
 		active_objs = 0;
 		num_slabs = 0;
-		list_for_each(q,&cachep->slabs) {
+		list_for_each(q,&cachep->slabs_full) {
+			slabp = list_entry(q, slab_t, list);
+			if (slabp->inuse != cachep->num)
+				BUG();
+			active_objs += cachep->num;
+			active_slabs++;
+		}
+		list_for_each(q,&cachep->slabs_partial) {
 			slabp = list_entry(q, slab_t, list);
+			if (slabp->inuse == cachep->num || !slabp->inuse)
+				BUG();
 			active_objs += slabp->inuse;
-			num_objs += cachep->num;
+			active_slabs++;
+		}
+		list_for_each(q,&cachep->slabs_free) {
+			slabp = list_entry(q, slab_t, list);
 			if (slabp->inuse)
-				active_slabs++;
-			else
-				num_slabs++;
+				BUG();
+			num_slabs++;
 		}
 		num_slabs+=active_slabs;
 		num_objs = num_slabs*cachep->num;

> o	Self adjusting syscall table filler		(Andrea Arcangeli)

Same as above, ready to be applyed to 2.4.10pre4:

--- syscall/arch/i386/kernel/entry.S.~1~	Tue Nov 28 18:39:59 2000
+++ syscall/arch/i386/kernel/entry.S	Sun Apr 29 16:59:05 2001
@@ -647,12 +647,6 @@
 	.long SYMBOL_NAME(sys_fcntl64)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
 
-	/*
-	 * NOTE!! This doesn't have to be exact - we just have
-	 * to make sure we have _enough_ of the "sys_ni_syscall"
-	 * entries. Don't panic if you notice that this hasn't
-	 * been shrunk every time we add a new system call.
-	 */
-	.rept NR_syscalls-221
+	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
 	.endr

Andrea
