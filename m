Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVACWRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVACWRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVACWQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:16:01 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42934 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261925AbVACWJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:09:37 -0500
Date: Mon, 3 Jan 2005 22:29:22 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: akpm@osdl.org
cc: torvalds@osdl.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH] periodically scan redzone entries and slab control structures
Message-ID: <Pine.LNX.4.44.0501032223360.1865-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The redzone words are only checked during alloc and free - thus objects
that are never/rarely freed are not checked at all.

The attached patch adds a periodic scan over all objects and checks for
wrong redzone data or corrupted bufctl lists.

Most changes are under #ifdef DEBUG, the only exception is a trivial
correction for the initial timeout calculation: divide the cachep address
by L1_CACHE_BYTES before the mod - the low order bits are always 0.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 10
//  EXTRAVERSION =
--- 2.6/mm/slab.c	2004-12-29 15:35:54.000000000 +0100
+++ build-2.6/mm/slab.c	2005-01-03 21:15:55.318889423 +0100
@@ -170,7 +170,7 @@
  */

 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
-#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
+#define BUFCTL_ALLOC	(((kmem_bufctl_t)(~0U))-1)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)

 /* Max number of objs-per-slab for caches which use off-slab slabs.
@@ -336,6 +336,7 @@
 #if DEBUG
 	int			dbghead;
 	int			reallen;
+	unsigned long		redzonetest;
 #endif
 };

@@ -351,6 +352,7 @@
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
 #define REAPTIMEOUT_LIST3	(4*HZ)
+#define REDZONETIMEOUT		(300*HZ)

 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -1417,7 +1419,11 @@
 	}

 	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
-					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+					((unsigned long)cachep/L1_CACHE_BYTES)%REAPTIMEOUT_LIST3;
+#if DEBUG
+	cachep->redzonetest = jiffies + REDZONETIMEOUT +
+					((unsigned long)cachep/L1_CACHE_BYTES)%REDZONETIMEOUT;
+#endif

 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
@@ -2014,7 +2020,7 @@
 			slabp->inuse++;
 			next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
-			slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+			slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
 #endif
 		       	slabp->free = next;
 		}
@@ -2152,7 +2158,7 @@
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
 		check_slabp(cachep, slabp);
 #if DEBUG
-		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
+		if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
 			printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
 						cachep->name, objp);
 			BUG();
@@ -2380,7 +2386,7 @@
 	slabp->inuse++;
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
 #endif
 	slabp->free = next;
 	check_slabp(cachep, slabp);
@@ -2586,6 +2592,86 @@

 EXPORT_SYMBOL(kmem_cache_size);

+#if DEBUG
+static void check_slabuse(kmem_cache_t *cachep, struct slab *slabp)
+{
+	int i;
+
+	if (!(cachep->flags & SLAB_RED_ZONE))
+		return;	/* no redzone data to check */
+
+	for (i=0;i<cachep->num;i++) {
+		void *objp = slabp->s_mem + cachep->objsize * i;
+		unsigned long red1, red2;
+
+		red1 = *dbg_redzone1(cachep, objp);
+		red2 = *dbg_redzone2(cachep, objp);
+
+		/* simplest case: marked as inactive */
+		if (red1 == RED_INACTIVE && red2 == RED_INACTIVE)
+			continue;
+
+		/* tricky case: if the bufctl value is BUFCTL_ALLOC, then
+		 * the object is either allocated or somewhere in a cpu
+		 * cache. The cpu caches are lockless and there might be
+		 * a concurrent alloc/free call, thus we must accept random
+		 * combinations of RED_ACTIVE and _INACTIVE
+		 */
+		if (slab_bufctl(slabp)[i] == BUFCTL_ALLOC &&
+				(red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
+				(red2 == RED_INACTIVE || red2 == RED_ACTIVE))
+			continue;
+
+		printk(KERN_ERR "slab %s: redzone mismatch in slabp %p, objp %p, bufctl 0x%x\n",
+				cachep->name, slabp, objp, slab_bufctl(slabp)[i]);
+		print_objinfo(cachep, objp, 2);
+	}
+}
+
+/*
+ * Perform a self test on all slabs from a cache
+ */
+static void check_redzone(kmem_cache_t *cachep)
+{
+	struct list_head *q;
+	struct slab *slabp;
+
+	check_spinlock_acquired(cachep);
+
+	list_for_each(q,&cachep->lists.slabs_full) {
+		slabp = list_entry(q, struct slab, list);
+
+		if (slabp->inuse != cachep->num) {
+			printk(KERN_INFO "slab %s: wrong slabp found in full slab chain at %p (%d/%d).\n",
+					cachep->name, slabp, slabp->inuse, cachep->num);
+		}
+		check_slabp(cachep, slabp);
+		check_slabuse(cachep, slabp);
+	}
+	list_for_each(q,&cachep->lists.slabs_partial) {
+		slabp = list_entry(q, struct slab, list);
+
+		if (slabp->inuse == cachep->num || slabp->inuse == 0) {
+			printk(KERN_INFO "slab %s: wrong slab found in partial chain at %p (%d/%d).\n",
+					cachep->name, slabp, slabp->inuse, cachep->num);
+		}
+		check_slabp(cachep, slabp);
+		check_slabuse(cachep, slabp);
+	}
+	list_for_each(q,&cachep->lists.slabs_free) {
+		slabp = list_entry(q, struct slab, list);
+
+		if (slabp->inuse != 0) {
+			printk(KERN_INFO "slab %s: wrong slab found in free chain at %p (%d/%d).\n",
+					cachep->name, slabp, slabp->inuse, cachep->num);
+		}
+		check_slabp(cachep, slabp);
+		check_slabuse(cachep, slabp);
+	}
+}
+
+#endif
+
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
 	struct array_cache *new[NR_CPUS];
@@ -2769,6 +2855,12 @@

 		drain_array_locked(searchp, ac_data(searchp), 0);

+#if DEBUG
+		if(time_before(searchp->redzonetest, jiffies)) {
+			searchp->redzonetest = jiffies + REDZONETIMEOUT;
+			check_redzone(searchp);
+		}
+#endif
 		if(time_after(searchp->lists.next_reap, jiffies))
 			goto next_unlock;


