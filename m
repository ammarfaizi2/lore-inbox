Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbVITFGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVITFGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVITFGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:06:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37580 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932725AbVITFGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:06:14 -0400
Date: Mon, 19 Sep 2005 14:20:03 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: vandrove@vc.cvut.cz, alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <20050919122847.4322df95.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org>
 <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
 <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Andrew Morton wrote:

> 	list_for_each(walk, &cache_chain) {
> 		kmem_cache_t *searchp;
> 		struct list_head* p;
> 		int tofree;
> 		struct slab *slabp;
> 
> 		searchp = list_entry(walk, kmem_cache_t, next);
> 
> 		if (searchp->flags & SLAB_NO_REAP)
> 			goto next;
> 
> 		check_irq_on();
> 
> 		l3 = searchp->nodelists[numa_node_id()];
> 		if (l3->alien)
> 			drain_alien_cache(searchp, l3);
> ->preempt here
> 		spin_lock_irq(&l3->list_lock);
> 
> 		drain_array_locked(searchp, ac_data(searchp), 0,
> 				numa_node_id());
> ->oops, wrong node.

This is called from keventd which exists per processor. Hmmm... This looks 
as if it can change processors after all but the slab allocator depends on 
it running on the right processor. So does the page allocator. sigh. What 
is the point of having per processor workqueues if they do not stay on 
the assigned processor?

The fast fix for this case is to get the node number once and then use it 
consistently. But we really need to audit the slab and page allocator for 
additional cases like this or disable preempt and check for the right 
processor in cache_reap().

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2005-09-19 14:10:33.489800899 -0700
+++ linux-2.6/mm/slab.c	2005-09-19 14:10:44.555105862 -0700
@@ -3262,6 +3262,7 @@
 {
 	struct list_head *walk;
 	struct kmem_list3 *l3;
+	int node = numa_node_id();
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
@@ -3282,13 +3283,13 @@
 
 		check_irq_on();
 
-		l3 = searchp->nodelists[numa_node_id()];
+		l3 = searchp->nodelists[node];
 		if (l3->alien)
 			drain_alien_cache(searchp, l3);
 		spin_lock_irq(&l3->list_lock);
 
 		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+				node);
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
@@ -3297,7 +3298,7 @@
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+				node);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
