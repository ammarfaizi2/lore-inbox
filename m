Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWCVC3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWCVC3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWCVC3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:29:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4227 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751437AbWCVC3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:29:45 -0500
Date: Tue, 21 Mar 2006 18:29:38 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: jesper.juhl@gmail.com, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try
 #3)
In-Reply-To: <20060321174623.2f92331b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603211828080.14503@schroedinger.engr.sgi.com>
References: <200603182137.08521.jesper.juhl@gmail.com>
 <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
 <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
 <200603220154.16266.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603211732420.14503@schroedinger.engr.sgi.com>
 <20060321174623.2f92331b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it will work this way? (Testing may be difficult without proper 
failure scenarios, not tested yet).


Fix memory leak in alloc_kmemlist

We have had this memory leak for awhile now. The situation is complicated by
the use of alloc_kmemlist() as a function to resize various caches by
do_tune_cpucache().

What we do here is first of all make sure that we deallocate properly
in the loop over all the nodes.

If we are just resizing caches then we can simply return with -ENOMEM
if an allocation fails.

If the cache is new then we need to rollback and remove all earlier
allocations.

We detect that a cache is new by checking if the link to the global
cache chain has been setup. This is a bit hackish ....

(also fix up too overlong lines that I added in the last patch...)

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/slab.c	2006-03-21 17:49:16.000000000 -0800
+++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-21 18:27:28.000000000 -0800
@@ -3415,7 +3415,7 @@ const char *kmem_cache_name(struct kmem_
 EXPORT_SYMBOL_GPL(kmem_cache_name);
 
 /*
- * This initializes kmem_list3 for all nodes.
+ * This initializes kmem_list3 or resizes varioius caches for all nodes.
  */
 static int alloc_kmemlist(struct kmem_cache *cachep)
 {
@@ -3430,10 +3430,13 @@ static int alloc_kmemlist(struct kmem_ca
 		if (!new_alien)
 			goto fail;
 
-		new_shared = alloc_arraycache(node, cachep->shared*cachep->batchcount,
+		new_shared = alloc_arraycache(node,
+				cachep->shared*cachep->batchcount,
 					0xbaadf00d);
-		if (!new_shared)
+		if (!new_shared) {
+			free_alien_cache(new_alien);
 			goto fail;
+		}
 
 		l3 = cachep->nodelists[node];
 		if (l3) {
@@ -3442,7 +3445,8 @@ static int alloc_kmemlist(struct kmem_ca
 			spin_lock_irq(&l3->list_lock);
 
 			if (shared)
-				free_block(cachep, shared->entry, shared->avail, node);
+				free_block(cachep, shared->entry,
+						shared->avail, node);
 
 			l3->shared = new_shared;
 			if (!l3->alien) {
@@ -3457,8 +3461,11 @@ static int alloc_kmemlist(struct kmem_ca
 			continue;
 		}
 		l3 = kmalloc_node(sizeof(struct kmem_list3), GFP_KERNEL, node);
-		if (!l3)
+		if (!l3) {
+			free_alien_cache(new_alien);
+			kfree(new_shared);
 			goto fail;
+		}
 
 		kmem_list3_init(l3);
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
@@ -3470,7 +3477,21 @@ static int alloc_kmemlist(struct kmem_ca
 		cachep->nodelists[node] = l3;
 	}
 	return 0;
+
 fail:
+	if (!cachep->next.next) {
+		/* Cache is not active yet. Roll back what we did */
+		node--;
+		while (node >= 0 && cachep->nodelists[node]) {
+			l3 = cachep->nodelists[node];
+
+			kfree(l3->shared);
+			free_alien_cache(l3->alien);
+			kfree(l3);
+			cachep->nodelists[node] = NULL;
+			node--;
+		}
+	}
 	return -ENOMEM;
 }
 
