Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTKFQqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKFQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:46:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:63214 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263681AbTKFQqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:46:31 -0500
Message-ID: <3FAA7ABD.9050804@mvista.com>
Date: Thu, 06 Nov 2003 09:45:49 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, marcelo@logos.cnet
Subject: PATCH (2.4.x) - Interrupts disabled for a long time
Content-Type: multipart/mixed;
 boundary="------------020300090607080403040303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020300090607080403040303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

While running some file system and NFS benchmarks I noticed that 
interrupts were being diabled for long periods of time (up to 625+ us on 
my 1.6 Ghz Xeon). The culprit was in kmem_cache_reap.
This is a 2.6 inspired, minimally invasive patch that fixes the problem 
(nothing longer than 40 us now).

mark


--------------020300090607080403040303
Content-Type: text/plain;
 name="slab-2-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab-2-patch"

Index: slab.c
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/mm/slab.c,v
retrieving revision 1.8.6.1.6.1
diff -a -u -r1.8.6.1.6.1 slab.c
--- slab.c	22 Aug 2003 23:26:57 -0000	1.8.6.1.6.1
+++ slab.c	5 Nov 2003 23:42:42 -0000
@@ -194,6 +194,7 @@
 	struct list_head	slabs_full;
 	struct list_head	slabs_partial;
 	struct list_head	slabs_free;
+	unsigned int		slab_free_count;
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
@@ -359,6 +360,7 @@
 	slabs_full:	LIST_HEAD_INIT(cache_cache.slabs_full),
 	slabs_partial:	LIST_HEAD_INIT(cache_cache.slabs_partial),
 	slabs_free:	LIST_HEAD_INIT(cache_cache.slabs_free),
+	slab_free_count:0,
 	objsize:	sizeof(kmem_cache_t),
 	flags:		SLAB_NO_REAP,
 	spinlock:	SPIN_LOCK_UNLOCKED,
@@ -791,6 +793,7 @@
 	INIT_LIST_HEAD(&cachep->slabs_full);
 	INIT_LIST_HEAD(&cachep->slabs_partial);
 	INIT_LIST_HEAD(&cachep->slabs_free);
+	cachep->slab_free_count = 0;
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -936,6 +939,7 @@
 			BUG();
 #endif
 		list_del(&slabp->list);
+		cachep->slab_free_count--;
 
 		spin_unlock_irq(&cachep->spinlock);
 		conditional_schedule();
@@ -1190,6 +1194,7 @@
 
 	/* Make slab active. */
 	list_add_tail(&slabp->list, &cachep->slabs_free);
+	cachep->slab_free_count++;
 	STATS_INC_GROWN(cachep);
 	cachep->failures = 0;
 
@@ -1298,6 +1303,7 @@
 		if (unlikely(entry == slabs_free))		\
 			goto alloc_new_slab;			\
 		list_del(entry);				\
+		cachep->slab_free_count--;			\
 		list_add(entry, slabs_partial);			\
 	}							\
 								\
@@ -1324,6 +1330,7 @@
 			if (unlikely(entry == slabs_free))
 				break;
 			list_del(entry);
+			cachep->slab_free_count--;
 			list_add(entry, slabs_partial);
 		}
 
@@ -1466,6 +1473,7 @@
 			/* Was partial or full, now empty. */
 			list_del(&slabp->list);
 			list_add(&slabp->list, &cachep->slabs_free);
+			cachep->slab_free_count++;
 		} else if (unlikely(inuse == cachep->num)) {
 			/* Was full. */
 			list_del(&slabp->list);
@@ -1762,7 +1770,6 @@
 	searchp = clock_searchp;
 	do {
 		unsigned int pages;
-		struct list_head* p;
 		unsigned int full_free;
 
 		/* It's safe to test this without holding the cache-lock. */
@@ -1785,18 +1792,29 @@
 		}
 #endif
 
+#if DEBUG
+{
+		struct list_head* p;
+
 		full_free = 0;
 		p = searchp->slabs_free.next;
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
-#if DEBUG
+
 			if (slabp->inuse)
 				BUG();
-#endif
+
 			full_free++;
 			p = p->next;
 		}
 
+		if (full_free != searchp->slab_free_count)
+			BUG();
+}
+#else
+		full_free = searchp->slab_free_count;
+#endif
+
 		/*
 		 * Try to avoid slabs with constructors and/or
 		 * more than one page per slab (as it can be difficult
@@ -1847,6 +1865,7 @@
 			BUG();
 #endif
 		list_del(&slabp->list);
+		best_cachep->slab_free_count--;
 		STATS_INC_REAPED(best_cachep);
 
 		/* Safe to drop the lock. The slab is no longer linked to the

--------------020300090607080403040303--

