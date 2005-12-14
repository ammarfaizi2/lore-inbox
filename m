Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLNIC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLNIC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLNIC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:02:58 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51884 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751303AbVLNIC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:02:57 -0500
Message-ID: <439FD1AD.8090405@us.ibm.com>
Date: Wed, 14 Dec 2005 00:02:53 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrea@suse.de, Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 6/6] Critical Page Pool: Slab Support
References: <439FCECA.3060909@us.ibm.com>
In-Reply-To: <439FCECA.3060909@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090008060103020905070605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090008060103020905070605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Finally, add support for the Critical Page Pool to the Slab Allocator.  We
need the slab allocator to be at least marginally aware of the existence of
critical pages, or else we leave open the possibility of non-critical slab
allocations stealing objects from 'critical' slabs.  We add a separate,
node-unspecific list to kmem_cache_t called slabs_crit.  We keep all
partial and full critical slabs on this list.  We don't keep empty critical
slabs around, in the interest of giving this memory back to the VM ASAP in
what is typically a high memory pressure situation.

-Matt

--------------090008060103020905070605
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

Index: linux-2.6.15-rc5+critical_pool/mm/slab.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/mm/slab.c	2005-12-13 16:14:25.757617592 -0800
+++ linux-2.6.15-rc5+critical_pool/mm/slab.c	2005-12-13 16:32:08.300086584 -0800
@@ -221,8 +221,9 @@ struct slab {
 	unsigned long		colouroff;
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* num of objs active in slab */
-	kmem_bufctl_t		free;
+	unsigned short		critical;	/* is this an critical slab? */
 	unsigned short          nodeid;
+	kmem_bufctl_t		free;
 };
 
 /*
@@ -395,6 +396,9 @@ struct kmem_cache {
 	unsigned int		slab_size;
 	unsigned int		dflags;		/* dynamic flags */
 
+	/* list of critical slabs for this cache */
+	struct list_head	slabs_crit;
+
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
 
@@ -1770,6 +1774,7 @@ next:
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
+	INIT_LIST_HEAD(&cachep->slabs_crit);
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
@@ -2086,6 +2091,7 @@ static struct slab* alloc_slabmgmt(kmem_
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;
 	slabp->s_mem = objp+colour_off;
+	slabp->critical = 0;
 
 	return slabp;
 }
@@ -2161,7 +2167,8 @@ static void *get_object(kmem_cache_t *ca
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
 	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-	WARN_ON(slabp->nodeid != nodeid);
+	if (nodeid >= 0)
+		WARN_ON(slabp->nodeid != nodeid);
 #endif
 	slabp->free = next;
 
@@ -2175,7 +2182,8 @@ static void return_object(kmem_cache_t *
 
 #if DEBUG
 	/* Verify that the slab belongs to the intended node */
-	WARN_ON(slabp->nodeid != nodeid);
+	if (nodeid >= 0)
+		WARN_ON(slabp->nodeid != nodeid);
 
 	if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 		printk(KERN_ERR "slab: double free detected in cache "
@@ -2324,18 +2332,64 @@ bad:
 #define check_slabp(x,y) do { } while(0)
 #endif
 
+static inline int is_critical_object(void *obj)
+{
+	struct slab *slabp;
+
+	if (!obj)
+		return 0;
+
+	slabp = page_get_slab(virt_to_page(obj));
+	return slabp->critical;
+}
+
+static inline void *get_critical_object(kmem_cache_t *cachep, gfp_t flags)
+{
+	struct slab *slabp;
+	void *objp = NULL;
+
+	spin_lock(&cachep->spinlock);
+	/* search for any partially free critical slabs */
+	if (!list_empty(&cachep->slabs_crit))
+		list_for_each_entry(slabp, &cachep->slabs_crit, list)
+			if (slabp->free != BUFCTL_END) {
+				objp = get_object(cachep, slabp, -1);
+				check_slabp(cachep, slabp);
+				break;
+			}
+	spin_unlock(&cachep->spinlock);
+
+	return objp;
+}
+
+static inline void free_critical_object(kmem_cache_t *cachep, void *objp)
+{
+	struct slab *slabp = page_get_slab(virt_to_page(objp));
+
+	check_slabp(cachep, slabp);
+	return_object(cachep, slabp, objp, -1);
+	check_slabp(cachep, slabp);
+
+	if (!slabp->inuse) {
+		BUG_ON(cachep->flags & SLAB_DESTROY_BY_RCU);
+
+		list_del(&slabp->list);
+		slab_destroy(cachep, slabp);
+	}
+}
+
 /**
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
 {
 	struct slab *slabp;
 	void *objp;
 	size_t offset;
 	gfp_t local_flags;
 	unsigned long ctor_flags;
-	struct kmem_list3 *l3;
+	int critical = is_emergency_alloc(flags) && !cachep->gfporder;
 
 	/*
 	 * Be lazy and only check for valid flags here,
@@ -2344,7 +2398,14 @@ static int cache_grow(kmem_cache_t *cach
 	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
 		BUG();
 	if (flags & SLAB_NO_GROW)
-		return 0;
+		return NULL;
+
+	/*
+	 * If we are in an emergency situation and this is a 'critical' alloc,
+	 * see if we can get an object from an existing critical slab first.
+	 */
+	if (critical && (objp = get_critical_object(cachep, flags)))
+		return objp;
 
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 	local_flags = (flags & SLAB_LEVEL_MASK);
@@ -2391,21 +2452,30 @@ static int cache_grow(kmem_cache_t *cach
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	check_irq_off();
-	l3 = cachep->nodelists[nodeid];
-	spin_lock(&l3->list_lock);
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list, &(l3->slabs_free));
 	STATS_INC_GROWN(cachep);
-	l3->free_objects += cachep->num;
-	spin_unlock(&l3->list_lock);
-	return 1;
+	if (!critical) {
+		struct kmem_list3 *l3 = cachep->nodelists[nodeid];
+		spin_lock(&l3->list_lock);
+		list_add_tail(&slabp->list, &l3->slabs_free);
+		l3->free_objects += cachep->num;
+		spin_unlock(&l3->list_lock);
+	} else {
+		slabp->critical = 1;
+		spin_lock(&cachep->spinlock);
+		list_add_tail(&slabp->list, &cachep->slabs_crit);
+		spin_unlock(&cachep->spinlock);
+		objp = get_object(cachep, slabp, -1);
+		check_slabp(cachep, slabp);
+	}
+	return objp;
 failed_freepages:
 	kmem_freepages(cachep, objp);
 failed:
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
-	return 0;
+	return NULL;
 }
 
 static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
@@ -2483,15 +2553,18 @@ alloc_done:
 	spin_unlock(&l3->list_lock);
 
 	if (unlikely(!ac->avail)) {
-		int x;
-		x = cache_grow(cachep, flags, numa_node_id());
+		void *obj = cache_grow(cachep, flags, numa_node_id());
+
+		/* critical objects don't "grow" the slab, just return 'obj' */
+		if (is_critical_object(obj))
+			return obj;
 
-		// cache_grow can reenable interrupts, then ac could change.
+		/* cache_grow can reenable interrupts, then ac could change. */
 		ac = ac_data(cachep);
-		if (!x && ac->avail == 0)	// no objects in sight? abort
+		if (!obj && ac->avail == 0) /* No objects in sight?  Abort.  */
 			return NULL;
 
-		if (!ac->avail)		// objects refilled by interrupt?
+		if (!ac->avail)		/* objects refilled by interrupt?    */
 			goto retry;
 	}
 	ac->touched = 1;
@@ -2597,7 +2670,6 @@ static void *__cache_alloc_node(kmem_cac
  	struct slab *slabp;
  	struct kmem_list3 *l3;
  	void *obj;
- 	int x;
 
  	l3 = cachep->nodelists[nodeid];
  	BUG_ON(!l3);
@@ -2639,11 +2711,15 @@ retry:
 
 must_grow:
  	spin_unlock(&l3->list_lock);
- 	x = cache_grow(cachep, flags, nodeid);
+	obj = cache_grow(cachep, flags, nodeid);
 
- 	if (!x)
+	if (!obj)
  		return NULL;
 
+	/* critical objects don't "grow" the slab, just return 'obj' */
+	if (is_critical_object(obj))
+		goto done;
+
  	goto retry;
 done:
  	return obj;
@@ -2758,6 +2834,11 @@ static inline void __cache_free(kmem_cac
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
+	if (is_critical_object(objp)) {
+		free_critical_object(cachep, objp);
+		return;
+	}
+
 	/* Make sure we are not freeing a object from another
 	 * node to the array cache on this cpu.
 	 */

--------------090008060103020905070605--
