Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272829AbRILORj>; Wed, 12 Sep 2001 10:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272837AbRILORa>; Wed, 12 Sep 2001 10:17:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16495 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272829AbRILORU>; Wed, 12 Sep 2001 10:17:20 -0400
Date: Wed, 12 Sep 2001 16:18:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010912161806.C695@athlon.random>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random> <001201c13942$b1bec9a0$010411ac@local> <20010909173313.V11329@athlon.random> <004101c13af1$6c099060$010411ac@local> <20010911213602.C715@athlon.random> <3B9E777C.BA29918B@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <3B9E777C.BA29918B@colorfullife.com>; from manfred@colorfullife.com on Tue, Sep 11, 2001 at 10:43:40PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2001 at 10:43:40PM +0200, Manfred Spraul wrote:
> Interesting: you loose all microbenchmarks, your patch doesn't improve
> LIFO ordering, and you still think your patch is better? Could you
> explain why?

I believe it's much cleaner to have proper list. It also shrinks the
caches in fifo order (shrinking is fifo and allocation is lifo).

The main reason it was significantly slower in the microbenchmarks is
that it wasn't microoptimized, the design of the three list wasn't the
real problem. I wrote this microbenchmark:

#include <linux/module.h>
#include <linux/slab.h>
#include <asm/msr.h>

#define NR_MALLOC 1000
#define SIZE 10

int init_module(void)
{
	unsigned long start, stop;
	int i;
	void * malloc[NR_MALLOC];

	rdtscl(start);
	for (i = 0; i < NR_MALLOC; i++)
		malloc[i] = kmalloc(SIZE, GFP_KERNEL);
	rdtscl(stop);

	for (i = 0; i < NR_MALLOC; i++)
		kfree(malloc[i]);

	printk("cycles %lu\n", stop - start);

	return 1;
}

these are the figures on UP PII 450mhz:

mainline pre10 (slabs-list patch applied)

cycles 90236
cycles 89812
cycles 90106

mainline but with slabs-list backed out

cycles 85187
cycles 85386
cycles 85169

mainline but with slabs-list backed out and your latest lifo patch
applied but with debugging turned off (also I didn't checked the
offslab_limit but it was applied)

cycles 85578
cycles 85856
cycles 85596

mainline with this new attached patch applied

cycles 85775
cycles 85963
cycles 85901

So in short I'd prefer to merge in mainline the attached patch that
optimizes the slab lists taking full advantage of the three lists.

Never mind to complain if you still have problems with those
microoptimizations applied. (btw, compiled with gcc 3.0.2)

Andrea

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=00_slab-microoptimize-1

--- 2.4.10pre8aa1/mm/slab.c.~1~	Wed Sep 12 03:23:43 2001
+++ 2.4.10pre8aa1/mm/slab.c	Wed Sep 12 05:02:40 2001
@@ -926,8 +926,10 @@
 			break;
 
 		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
+#if DEBUG
 		if (slabp->inuse)
 			BUG();
+#endif
 		list_del(&slabp->list);
 
 		spin_unlock_irq(&cachep->spinlock);
@@ -1215,7 +1217,7 @@
 }
 
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
-						slab_t *slabp, int partial)
+						slab_t *slabp)
 {
 	void *objp;
 
@@ -1228,14 +1230,9 @@
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
 	slabp->free=slab_bufctl(slabp)[slabp->free];
 
-	if (slabp->free == BUFCTL_END) {
+	if (__builtin_expect(slabp->free == BUFCTL_END, 0)) {
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
-	} else {
-		if (!partial) {
-			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_partial);
-		}
 	}
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
@@ -1262,20 +1259,23 @@
  */
 #define kmem_cache_alloc_one(cachep)				\
 ({								\
-	slab_t	*slabp;						\
-	struct list_head * slab_freelist;			\
-	int partial = 1;					\
+	struct list_head * slabs_partial, * entry;		\
+	slab_t *slabp;						\
 								\
-	slab_freelist = &(cachep)->slabs_partial;		\
-	if (list_empty(slab_freelist)) {			\
-		partial = 0;					\
-		slab_freelist = &(cachep)->slabs_free;		\
-		if (list_empty(slab_freelist))			\
+	slabs_partial = &(cachep)->slabs_partial;		\
+	entry = slabs_partial->next;				\
+	if (__builtin_expect(entry == slabs_partial, 0)) {	\
+		struct list_head * slabs_free;			\
+		slabs_free = &(cachep)->slabs_free;		\
+		entry = slabs_free->next;			\
+		if (__builtin_expect(entry == slabs_free, 0))	\
 			goto alloc_new_slab;			\
+		list_del(entry);				\
+		list_add(entry, slabs_partial);			\
 	}							\
 								\
-	slabp = list_entry(slab_freelist->next, slab_t, list);	\
-	kmem_cache_alloc_one_tail(cachep, slabp, partial);	\
+	slabp = list_entry(entry, slab_t, list);		\
+	kmem_cache_alloc_one_tail(cachep, slabp);		\
 })
 
 #ifdef CONFIG_SMP
@@ -1283,25 +1283,27 @@
 {
 	int batchcount = cachep->batchcount;
 	cpucache_t* cc = cc_data(cachep);
-	struct list_head * slab_freelist;
-	int partial;
-	slab_t *slabp;
 
 	spin_lock(&cachep->spinlock);
 	while (batchcount--) {
+		struct list_head * slabs_partial, * entry;
+		slab_t *slabp;
 		/* Get slab alloc is to come from. */
-		slab_freelist = &(cachep)->slabs_partial;
-		partial = 1;
-		if (list_empty(slab_freelist)) {
-			partial = 0;
-			slab_freelist = &(cachep)->slabs_free;
-			if (list_empty(slab_freelist))
+		slabs_partial = &(cachep)->slabs_partial;
+		entry = slabs_partial->next;
+		if (__builtin_expect(entry == slabs_partial, 0)) {
+			struct list_head * slabs_free;
+			slabs_free = &(cachep)->slabs_free;
+			entry = slabs_free->next;
+			if (__builtin_expect(entry == slabs_free, 0))
 				break;
+			list_del(entry);
+			list_add(entry, slabs_partial);
 		}
 
-		slabp = list_entry(slab_freelist->next, slab_t, list);
+		slabp = list_entry(entry, slab_t, list);
 		cc_entry(cc)[cc->avail++] =
-				kmem_cache_alloc_one_tail(cachep, slabp, partial);
+				kmem_cache_alloc_one_tail(cachep, slabp);
 	}
 	spin_unlock(&cachep->spinlock);
 
@@ -1432,23 +1434,18 @@
 	STATS_DEC_ACTIVE(cachep);
 	
 	/* fixup slab chains */
-	if (!--slabp->inuse)
-		goto moveslab_free;
-	if (slabp->inuse + 1 == cachep->num)
-		goto moveslab_partial;
-	return;
-
-moveslab_partial:
-    	/* Was full. */
-	list_del(&slabp->list);
-	list_add(&slabp->list, &cachep->slabs_partial);
-	return;
-
-moveslab_free:
-	/* Was partial, now empty. */
-	list_del(&slabp->list);
-	list_add(&slabp->list, &cachep->slabs_free);
-	return;
+	{
+		int inuse = slabp->inuse;
+		if (__builtin_expect(!--slabp->inuse, 0)) {
+			/* Was partial or full, now empty. */
+			list_del(&slabp->list);
+			list_add(&slabp->list, &cachep->slabs_free);
+		} else if (__builtin_expect(inuse == cachep->num, 0)) {
+			/* Was full. */
+			list_del(&slabp->list);
+			list_add(&slabp->list, &cachep->slabs_partial);
+		}
+	}
 }
 
 #ifdef CONFIG_SMP
@@ -1756,8 +1753,10 @@
 		p = searchp->slabs_free.next;
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
+#if DEBUG
 			if (slabp->inuse)
 				BUG();
+#endif
 			full_free++;
 			p = p->next;
 		}
@@ -1807,8 +1806,10 @@
 		if (p == &best_cachep->slabs_free)
 			break;
 		slabp = list_entry(p,slab_t,list);
+#if DEBUG
 		if (slabp->inuse)
 			BUG();
+#endif
 		list_del(&slabp->list);
 		STATS_INC_REAPED(best_cachep);
 

--7AUc2qLy4jB3hD7Z--
