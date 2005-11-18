Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVKRTrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVKRTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKRTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:47:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:11489 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932370AbVKRTrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:47:11 -0500
Message-ID: <437E2FB9.7050808@us.ibm.com>
Date: Fri, 18 Nov 2005 11:47:05 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 8/8] Add support critical pool support to the slab allocator
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080704030309040208080407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704030309040208080407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Finally, teach the slab allocator how to deal with critical pages and how
to keep them for use exclusively by __GFP_CRITICAL allocations.

-Matt

--------------080704030309040208080407
Content-Type: text/x-patch;
 name="slab_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab_support.patch"

Modify the Slab Allocator to support the addition of a Critical Pool to the VM.
What we want is to ensure that if a cache is allocated a new slab page from the
Critical Pool during an Emergency situation, that only other __GFP_CRITICAL
allocations are satisfied from that slab.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc1+critical_pool/mm/slab.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/mm/slab.c	2005-11-17 16:51:22.965173864 -0800
+++ linux-2.6.15-rc1+critical_pool/mm/slab.c	2005-11-17 17:22:03.056437472 -0800
@@ -220,6 +220,7 @@ struct slab {
 	unsigned long		colouroff;
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* # of objs active in slab */
+	unsigned short		critical;	/* is this an critical slab? */
 	kmem_bufctl_t		free;
 	unsigned short          nid;		/* node number slab is on */
 };
@@ -395,6 +396,9 @@ struct kmem_cache {
 	unsigned int		slab_size;
 	unsigned int		dflags;		/* dynamic flags */
 
+	/* list of critical slabs for this cache */
+	struct list_head	slabs_crit;
+
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
 
@@ -1770,6 +1774,7 @@ kmem_cache_t *kmem_cache_create(const ch
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
+	INIT_LIST_HEAD(&cachep->slabs_crit);
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
@@ -2090,6 +2095,7 @@ static struct slab *alloc_slabmgmt(kmem_
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;
 	slabp->s_mem = objp + colour_off;
+	slabp->critical = 0;
 
 	return slabp;
 }
@@ -2182,7 +2188,8 @@ static void return_object(kmem_cache_t *
 
 #if DEBUG
 	/* Verify that the slab belongs to the intended node */
-	WARN_ON(slabp->nid != nid);
+	if (nid >= 0)
+		WARN_ON(slabp->nid != nid);
 
 	if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 		printk(KERN_ERR "slab: double free detected in cache "
@@ -2341,6 +2348,24 @@ bad:
 #define check_slabp(x,y)			do { } while(0)
 #endif
 
+static inline struct slab *get_critical_slab(kmem_cache_t *cachep, gfp_t flags)
+{
+	struct slab *slabp = NULL;
+
+	spin_lock(&cachep->spinlock);
+	/* search for any partially free critical slabs */
+	if (!list_empty(&cachep->slabs_crit)) {
+		list_for_each_entry(slabp, &cachep->slabs_crit, list)
+			if (slabp->free != BUFCTL_END)
+				goto found;
+		slabp = NULL;
+	}
+found:
+	spin_unlock(&cachep->spinlock);
+
+	return slabp;
+}
+
 /**
  * Helper function for cache_grow().  Handle cache coloring, allocating a
  * struct slab and initializing the slab.
@@ -2396,10 +2421,11 @@ out:
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nid)
+static void *cache_grow(kmem_cache_t *cachep, gfp_t flags, int nid)
 {
 	struct slab *slabp = NULL;
 	void *objp = NULL;
+	int critical = is_emergency_alloc(flags);
 
 	/*
 	 * Be lazy and only check for valid flags here,
@@ -2411,6 +2437,13 @@ static int cache_grow(kmem_cache_t *cach
 		goto out;
 
 	/*
+	 * We are in an emergency situation and this is a 'critical' alloc,
+	 * so check if we've got an existing critical slab first
+	 */
+	if (critical && (slabp = get_critical_slab(cachep, flags)))
+		goto got_critical_slab;
+
+	/*
 	 * Ensure caller isn't asking for DMA memory if the slab wasn't created
 	 * with the SLAB_DMA flag.
 	 * Also ensure the caller *is* asking for DMA memory if the slab was
@@ -2431,13 +2464,34 @@ static int cache_grow(kmem_cache_t *cach
 
 		STATS_INC_GROWN(cachep);
 		/* Make slab active. */
-		spin_lock(&l3->list_lock);
-		list_add_tail(&slabp->list, &l3->slabs_free);
-		l3->free_objects += cachep->num;
-		spin_unlock(&l3->list_lock);
+		if (!critical) {
+			spin_lock(&l3->list_lock);
+			list_add_tail(&slabp->list, &l3->slabs_free);
+			l3->free_objects += cachep->num;
+			spin_unlock(&l3->list_lock);
+		} else {
+			spin_lock(&cachep->spinlock);
+			list_add_tail(&slabp->list, &cachep->slabs_crit);
+			slabp->critical = 1;
+			spin_unlock(&cachep->spinlock);
+got_critical_slab:
+			objp = get_object(cachep, slabp, nid);
+			check_slabp(cachep, slabp);
+		}
 	}
 out:
-	return objp != NULL;
+	return objp;
+}
+
+static inline int is_critical_object(void *obj)
+{
+	struct slab *slabp;
+
+	if (!obj)
+		return 0;
+
+	slabp = GET_PAGE_SLAB(virt_to_page(obj));
+	return slabp->critical;
 }
 
 static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
@@ -2516,12 +2570,15 @@ alloc_done:
 	spin_unlock(&l3->list_lock);
 
 	if (unlikely(!ac->avail)) {
-		int x;
-		x = cache_grow(cachep, flags, numa_node_id());
+		void *obj = cache_grow(cachep, flags, numa_node_id());
+
+		/* critical objects don't "grow" the slab, just return 'obj' */
+		if (is_critical_object(obj))
+			return obj;
 
 		/* cache_grow can reenable interrupts, then ac could change. */
 		ac = ac_data(cachep);
-		if (!x && ac->avail == 0) /* no objects in sight? abort      */
+		if (!obj && ac->avail == 0) /* No objects in sight?  Abort.  */
 			return NULL;
 
 		if (!ac->avail)		  /* objects refilled by interrupt?  */
@@ -2633,7 +2690,6 @@ static void *__cache_alloc_node(kmem_cac
 	struct slab *slabp;
 	struct kmem_list3 *l3;
 	void *obj;
-	int x;
 
 	l3 = cachep->nodelists[nid];
 	BUG_ON(!l3);
@@ -2675,11 +2731,15 @@ retry:
 
 must_grow:
 	spin_unlock(&l3->list_lock);
-	x = cache_grow(cachep, flags, nid);
+	obj = cache_grow(cachep, flags, nid);
 
-	if (!x)
+	if (!obj)
 		return NULL;
 
+	/* critical objects don't "grow" the slab, just return 'obj' */
+	if (is_critical_object(obj))
+		goto done;
+
 	goto retry;
 done:
 	return obj;
@@ -2780,6 +2840,22 @@ free_done:
 		sizeof(void *) * ac->avail);
 }
 
+static inline void free_critical_object(kmem_cache_t *cachep, void *objp)
+{
+	struct slab *slabp = GET_PAGE_SLAB(virt_to_page(objp));
+
+	check_slabp(cachep, slabp);
+	return_object(cachep, slabp, objp, -1);
+	check_slabp(cachep, slabp);
+
+	if (slabp->inuse == 0) {
+		BUG_ON(cachep->flags & SLAB_DESTROY_BY_RCU);
+		BUG_ON(cachep->gfporder);
+
+		list_del(&slabp->list);
+		slab_destroy(cachep, slabp);
+	}
+}
 
 /**
  * __cache_free
@@ -2795,6 +2871,11 @@ static inline void __cache_free(kmem_cac
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
+	if (is_critical_object(objp)) {
+		free_critical_object(cachep, objp);
+		return;
+	}
+
 	/*
 	 * Make sure we are not freeing a object from another
 	 * node to the array cache on this cpu.

--------------080704030309040208080407--
