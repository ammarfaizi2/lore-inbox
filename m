Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272562AbRIKUnn>; Tue, 11 Sep 2001 16:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272563AbRIKUne>; Tue, 11 Sep 2001 16:43:34 -0400
Received: from colorfullife.com ([216.156.138.34]:56592 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272562AbRIKUnW>;
	Tue, 11 Sep 2001 16:43:22 -0400
Message-ID: <3B9E777C.BA29918B@colorfullife.com>
Date: Tue, 11 Sep 2001 22:43:40 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random> <001201c13942$b1bec9a0$010411ac@local> <20010909173313.V11329@athlon.random> <004101c13af1$6c099060$010411ac@local> <20010911213602.C715@athlon.random>
Content-Type: multipart/mixed;
 boundary="------------376DA87A4B7739A04530220E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------376DA87A4B7739A04530220E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> 
> >
> > Ok, so you agree that your changes are only beneficial in one case:
> >
> > kmem_cache_free(), uniprocessor or SMP not-per-cpu cached.
> 
> I wouldn't say "not only in such case" but "mainly in such case"
> (there's not infinite ram in the per-cpu caches).
>
Large object were LIFO even without your patch.

Small objects on UP with partial slabs were LIFO without your patch.

Small objects on UP without any partial slabs were not LIFO, but it was
simple to fix that (patch attached, not yet fully tested).
Small objects on SMP are managed in the per-cpu arrays - and transfered
in batches (by default 30-120 objects, depending on the size) to the
backend slab lists. The backend was not LIFO (also fixed in the patch).

> 
> Also I believe there are more interesting parts to optimize on the
> design side rather than making the slab.c implementation more complex
> with the object of microoptimization for microbenchmarks (as you told me
> you couldn't measure any decrease in performance in real life in a
> sendfile benchmark, infact the first run with the patch was a little
> faster and the second a little slower).
>
Interesting: you loose all microbenchmarks, your patch doesn't improve
LIFO ordering, and you still think your patch is better? Could you
explain why?

Btw, I didn't merge the current slab.c directly: Ingo Molnar compared it
with his own version and sent it to Linus because it was faster than his
version (8-way, tux optimization).

But I agree that redesign is probably a good idea for 2.5, but that's
2.5 stuff:

* microoptimization: try to avoid the division in kmem_cache_free_one.
Might give a 20 % boost on UP i386, even more on cpus without an
efficient hardware division. I have an (ugly) patch. Mark Hemment's
version avoided the division in some cases, and that really helps.
* redesign: the code relies on a fast virt_to_page(). Is that realistic
with NUMA/CONFIG_DISCONTIGMEM?
* redesign: inode and dcache currently drain the per-cpu caches very
often to reduce the fragmentation - perhaps another, stronger
defragmenting allocator for inode & dcache? CPU crosscalls can't be the
perfect solution.
* redesign: NUMA.

But that redesign - virt_to_page is the first function in
kmem_cache_free and kfree - you won't need a backend simplification,
more a rewrite.

--
	Manfred
--------------376DA87A4B7739A04530220E
Content-Type: text/plain; charset=us-ascii;
 name="patch-slab-lifo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-lifo"

--- 2.4/mm/slab.c	Tue Sep 11 21:32:23 2001
+++ build-2.4/mm/slab.c	Tue Sep 11 22:39:54 2001
@@ -85,9 +85,9 @@
  * FORCED_DEBUG	- 1 enables SLAB_RED_ZONE and SLAB_POISON (if possible)
  */
 
-#define	DEBUG		0
-#define	STATS		0
-#define	FORCED_DEBUG	0
+#define	DEBUG		1
+#define	STATS		1
+#define	FORCED_DEBUG	1
 
 /*
  * Parameters for kmem_cache_reap
@@ -448,7 +448,7 @@
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
 			offslab_limit = sizes->cs_size-sizeof(slab_t);
-			offslab_limit /= 2;
+			offslab_limit /= sizeof(kmem_bufctl_t);
 		}
 		sprintf(name, "size-%Zd(DMA)",sizes->cs_size);
 		sizes->cs_dmacachep = kmem_cache_create(name, sizes->cs_size, 0,
@@ -1411,16 +1411,31 @@
 moveslab_free:
 	/*
 	 * was partial, now empty.
-	 * c_firstnotfull might point to slabp
-	 * FIXME: optimize
+	 * c_firstnotfull might point to slabp.
+	 * The code ensures LIFO ordering if there are no partial slabs.
+	 * (allocation from partial slabs has higher priority that LIFO
+	 *  - we just found a freeable page!)
 	 */
 	{
-		struct list_head *t = cachep->firstnotfull->prev;
-
-		list_del(&slabp->list);
-		list_add_tail(&slabp->list, &cachep->slabs);
-		if (cachep->firstnotfull == &slabp->list)
-			cachep->firstnotfull = t->next;
+		slab_t* next = list_entry(slabp->list.next, slab_t, list);
+		if (&next->list != &cachep->slabs) {
+			if (next->inuse != cachep->num) {
+				if (&slabp->list == cachep->firstnotfull)
+					cachep->firstnotfull = &next->list;
+				list_del(&slabp->list);
+				list_add_tail(&slabp->list, &cachep->slabs);
+			} /* else {
+			     The next slab is a free slab. That means
+			     the slab with the freed object in in it's
+			     correct position: behind all partial slabs,
+			     in front of all other free slabs to ensure
+			     LIFO.
+			} */
+		}/* else {
+		    the slab the freed object was in was the last slab in
+		    the cache. That means it's already in the correct 
+	 	    position: behind all partial slabs (if any).
+		} */
 		return;
 	}
 }
@@ -1473,6 +1488,46 @@
 #endif
 }
 
+#if DEBUG
+static void kmem_slabchain_test(kmem_cache_t *cachep)
+{
+	int pos = 0;
+	slab_t* walk;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cachep->spinlock, flags);
+
+	walk = list_entry(cachep->slabs.next, slab_t, list);
+	while(&walk->list != &cachep->slabs) {
+		if (walk->inuse == cachep->num) {
+			if (pos >  0)
+				BUG();
+		} else if (walk->inuse > 0) {
+			if (pos == 0) {
+				if (cachep->firstnotfull != &walk->list)
+					BUG();
+			}
+			if (pos >  1)
+				BUG();
+			pos = 1; /* found partial slabp */
+		} else {
+			if (pos == 0) {
+				if (cachep->firstnotfull != &walk->list)
+					BUG();
+			}
+			pos = 2; /* found free slabp */
+		}
+		walk = list_entry(walk->list.next, slab_t, list);
+	}
+	if (pos == 0) {
+		if (cachep->firstnotfull != &cachep->slabs)
+			BUG();
+	}
+	spin_unlock_irqrestore(&cachep->spinlock, flags);
+}
+#else
+#define kmem_slabchain_test(cachep)	do { } while(0)
+#endif
 /**
  * kmem_cache_alloc - Allocate an object
  * @cachep: The cache to allocate from.
@@ -1540,6 +1595,7 @@
 	local_irq_save(flags);
 	__kmem_cache_free(cachep, objp);
 	local_irq_restore(flags);
+	kmem_slabchain_test(cachep);
 }
 
 /**
@@ -1561,6 +1617,7 @@
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
+	kmem_slabchain_test(c);
 }
 
 kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)

--------------376DA87A4B7739A04530220E--

