Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWCDAvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWCDAvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWCDAvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:51:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57295 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751469AbWCDAvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:51:40 -0500
Date: Fri, 3 Mar 2006 16:51:25 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       Pekka Enberg <penberg@gmail.com>
Subject: slab: remove drain_array_locked
In-Reply-To: <Pine.LNX.4.64.0603031649340.15966@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0603031650440.15966@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603031649340.15966@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove drain_array_locked and use that opportunity to limit the
time the l3 lock is taken further.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/mm/slab.c	2006-03-03 16:31:40.000000000 -0800
+++ linux-2.6.16-rc5-mm2/mm/slab.c	2006-03-03 16:43:43.000000000 -0800
@@ -2125,9 +2125,6 @@ static void check_spinlock_acquired_node
 #define check_spinlock_acquired_node(x, y) do { } while(0)
 #endif
 
-static void drain_array_locked(struct kmem_cache *cachep,
-			struct array_cache *ac, int force, int node);
-
 static void drain_array(struct kmem_cache *cachep, struct kmem_list3 *l3,
 			struct array_cache *ac,
 			int force, int node);
@@ -3555,40 +3552,33 @@ static void enable_cpucache(struct kmem_
 		       cachep->name, -err);
 }
 
-static void drain_array_locked(struct kmem_cache *cachep,
-				struct array_cache *ac, int force, int node)
+/*
+ * Drain an array if it contains any elements taking the l3 lock only if
+ * necessary.
+ */
+void drain_array(struct kmem_cache *cachep, struct kmem_list3 *l3,
+			 struct array_cache *ac, int force, int node)
 {
 	int tofree;
 
-	check_spinlock_acquired_node(cachep, node);
+	if (!ac || !ac->avail)
+		return;
+
 	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
 		tofree = force ? ac->avail : (ac->limit + 4) / 5;
 		if (tofree > ac->avail)
 			tofree = (ac->avail + 1) / 2;
+		spin_lock_irq(&l3->list_lock);
 		free_block(cachep, ac->entry, tofree, node);
+		spin_unlock_irq(&l3->list_lock);
 		ac->avail -= tofree;
 		memmove(ac->entry, &(ac->entry[tofree]),
 			sizeof(void *) * ac->avail);
 	}
 }
 
-
-/*
- * Drain an array if it contains any elements taking the l3 lock only if
- * necessary.
- */
-void drain_array(struct kmem_cache *searchp, struct kmem_list3 *l3,
-			 struct array_cache *ac, int force, int node)
-{
-	if (ac && ac->avail) {
-		spin_lock_irq(&l3->list_lock);
-		drain_array_locked(searchp, ac, force, node);
-		spin_unlock_irq(&l3->list_lock);
-	}
-}
-
 /**
  * cache_reap - Reclaim memory from caches.
  * @unused: unused parameter
