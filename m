Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946252AbWBDBPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946252AbWBDBPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946254AbWBDBPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:15:31 -0500
Received: from ns1.siteground.net ([207.218.208.2]:56802 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1946252AbWBDBPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:15:30 -0500
Date: Fri, 3 Feb 2006 17:15:39 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: [patch 1/3] NUMA slab locking fixes -- move color_next to l3
Message-ID: <20060204011539.GH3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain> <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com> <20060204010857.GG3653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204010857.GG3653@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

colour_next is used as an index to add a colouring offset to a new slab 
in the cache (colour_off * colour_next).  Now with the NUMA aware slab 
allocator, it makes sense to colour slabs added on the same node 
sequentially with colour_next.

This patch moves the colouring index "colour_next" per-node by placing it
on kmem_list3 rather than kmem_cache.

This also helps sinplify locking for cup up and down paths.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc2/mm/slab.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/slab.c	2006-02-03 14:31:01.000000000 -0800
+++ linux-2.6.16-rc2/mm/slab.c	2006-02-03 14:35:21.000000000 -0800
@@ -294,6 +294,7 @@ struct kmem_list3 {
 	unsigned long next_reap;
 	int free_touched;
 	unsigned int free_limit;
+	unsigned int colour_next;	/* Per-node cache coloring */
 	spinlock_t list_lock;
 	struct array_cache *shared;	/* shared per node */
 	struct array_cache **alien;	/* on other nodes */
@@ -344,6 +345,7 @@ static void kmem_list3_init(struct kmem_
 	INIT_LIST_HEAD(&parent->slabs_free);
 	parent->shared = NULL;
 	parent->alien = NULL;
+	parent->colour_next = 0;
 	spin_lock_init(&parent->list_lock);
 	parent->free_objects = 0;
 	parent->free_touched = 0;
@@ -390,7 +392,6 @@ struct kmem_cache {
 
 	size_t colour;		/* cache colouring range */
 	unsigned int colour_off;	/* colour offset */
-	unsigned int colour_next;	/* cache colouring */
 	struct kmem_cache *slabp_cache;
 	unsigned int slab_size;
 	unsigned int dflags;	/* dynamic flags */
@@ -1119,7 +1120,6 @@ void __init kmem_cache_init(void)
 		BUG();
 
 	cache_cache.colour = left_over / cache_cache.colour_off;
-	cache_cache.colour_next = 0;
 	cache_cache.slab_size = ALIGN(cache_cache.num * sizeof(kmem_bufctl_t) +
 				      sizeof(struct slab), cache_line_size());
 
@@ -2324,18 +2324,19 @@ static int cache_grow(struct kmem_cache 
 		 */
 		ctor_flags |= SLAB_CTOR_ATOMIC;
 
-	/* About to mess with non-constant members - lock. */
+	/* Take the l3 list lock to change the colour_next on this node */
 	check_irq_off();
-	spin_lock(&cachep->spinlock);
+	l3 = cachep->nodelists[nodeid];
+	spin_lock(&l3->list_lock);
 
 	/* Get colour for the slab, and cal the next value. */
-	offset = cachep->colour_next;
-	cachep->colour_next++;
-	if (cachep->colour_next >= cachep->colour)
-		cachep->colour_next = 0;
-	offset *= cachep->colour_off;
+	offset = l3->colour_next;
+	l3->colour_next++;
+	if (l3->colour_next >= cachep->colour)
+		l3->colour_next = 0;
+	spin_unlock(&l3->list_lock);
 
-	spin_unlock(&cachep->spinlock);
+	offset *= cachep->colour_off;
 
 	check_irq_off();
 	if (local_flags & __GFP_WAIT)
@@ -2367,7 +2368,6 @@ static int cache_grow(struct kmem_cache 
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	check_irq_off();
-	l3 = cachep->nodelists[nodeid];
 	spin_lock(&l3->list_lock);
 
 	/* Make slab active. */
