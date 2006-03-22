Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWCVBw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWCVBw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWCVBw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:52:57 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5249 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751975AbWCVBw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:52:56 -0500
Date: Tue, 21 Mar 2006 17:52:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: jesper.juhl@gmail.com, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try
 #3)
In-Reply-To: <20060321174623.2f92331b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603211750480.14503@schroedinger.engr.sgi.com>
References: <200603182137.08521.jesper.juhl@gmail.com>
 <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
 <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
 <200603220154.16266.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603211732420.14503@schroedinger.engr.sgi.com>
 <20060321174623.2f92331b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Andrew Morton wrote:

> Well that's a big pickle.  How about allocating everything first, saving it
> locally then, if that all worked out, install it?

That wont work for the tuning case. We need to know somehow if we are 
updating or creating a new kmemlist.

But there is so much messy stuff in there. Maybe we should start with a 
cleanup patch to increase our comprehension of the situation?




alloc_kmemlist: Some cleanup in preparation for a real memory leak fix

Inspired by Jesper Juhl's patch from today

1. Get rid of err
	We do not set it to anything else but zero.

2. Drop the CONFIG_NUMA stuff.
	There are definitions for alloc_alien_cache and free_alien_cache()
	that do the right thing for the non NUMA case.

3. Better naming of variables.

4. Remove redundant cachep->nodelists[node] expressions.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Index: linux-2.6.16-rc6-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/slab.c	2006-03-21 17:45:02.000000000 -0800
+++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-21 17:49:16.000000000 -0800
@@ -3421,37 +3421,38 @@ static int alloc_kmemlist(struct kmem_ca
 {
 	int node;
 	struct kmem_list3 *l3;
-	int err = 0;
+	struct array_cache *new_shared;
+	struct array_cache **new_alien;
 
 	for_each_online_node(node) {
-		struct array_cache *nc = NULL, *new;
-		struct array_cache **new_alien = NULL;
-#ifdef CONFIG_NUMA
+
 		new_alien = alloc_alien_cache(node, cachep->limit);
 		if (!new_alien)
 			goto fail;
-#endif
-		new = alloc_arraycache(node, cachep->shared*cachep->batchcount,
+
+		new_shared = alloc_arraycache(node, cachep->shared*cachep->batchcount,
 					0xbaadf00d);
-		if (!new)
+		if (!new_shared)
 			goto fail;
+
 		l3 = cachep->nodelists[node];
 		if (l3) {
+			struct array_cache *shared = l3->shared;
+
 			spin_lock_irq(&l3->list_lock);
 
-			nc = cachep->nodelists[node]->shared;
-			if (nc)
-				free_block(cachep, nc->entry, nc->avail, node);
+			if (shared)
+				free_block(cachep, shared->entry, shared->avail, node);
 
-			l3->shared = new;
-			if (!cachep->nodelists[node]->alien) {
+			l3->shared = new_shared;
+			if (!l3->alien) {
 				l3->alien = new_alien;
 				new_alien = NULL;
 			}
 			l3->free_limit = (1 + nr_cpus_node(node)) *
 					cachep->batchcount + cachep->num;
 			spin_unlock_irq(&l3->list_lock);
-			kfree(nc);
+			kfree(shared);
 			free_alien_cache(new_alien);
 			continue;
 		}
@@ -3462,16 +3463,15 @@ static int alloc_kmemlist(struct kmem_ca
 		kmem_list3_init(l3);
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 				((unsigned long)cachep) % REAPTIMEOUT_LIST3;
-		l3->shared = new;
+		l3->shared = new_shared;
 		l3->alien = new_alien;
 		l3->free_limit = (1 + nr_cpus_node(node)) *
 					cachep->batchcount + cachep->num;
 		cachep->nodelists[node] = l3;
 	}
-	return err;
+	return 0;
 fail:
-	err = -ENOMEM;
-	return err;
+	return -ENOMEM;
 }
 
 struct ccupdate_struct {
