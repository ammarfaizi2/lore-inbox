Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVKRTp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVKRTp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKRTp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:45:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4498 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932304AbVKRTpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:45:55 -0500
Message-ID: <437E2F6F.4010509@us.ibm.com>
Date: Fri, 18 Nov 2005 11:45:51 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 7/8] __cache_grow()
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090408010301040100020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408010301040100020904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Create a helper for cache_grow() that handles doing the cache coloring and
allocating & initializing the struct slab.

-Matt

--------------090408010301040100020904
Content-Type: text/x-patch;
 name="slab_prep-__cache_grow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab_prep-__cache_grow.patch"

Create a helper function, __cache_grow(), called by cache_grow().  This allows
us to move the cache coloring and struct slab allocation & initialization to
its own discrete function.

Also, move both functions below some debugging function definitions, so they can be used
in these functions by the next patch without needing forward declarations.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc1+critical_pool/mm/slab.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/mm/slab.c	2005-11-17 16:45:09.979876248 -0800
+++ linux-2.6.15-rc1+critical_pool/mm/slab.c	2005-11-17 16:49:45.118048888 -0800
@@ -2209,95 +2209,6 @@ static void set_slab_attr(kmem_cache_t *
 	}
 }
 
-/*
- * Grow (by 1) the number of slabs within a cache.  This is called by
- * kmem_cache_alloc() when there are no active objs left in a cache.
- */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nid)
-{
-	struct slab *slabp;
-	void *objp;
-	size_t offset;
-	gfp_t local_flags;
-	unsigned long ctor_flags;
-	struct kmem_list3 *l3;
-
-	/*
-	 * Be lazy and only check for valid flags here,
-	 * keeping it out of the critical path in kmem_cache_alloc().
-	 */
-	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
-		BUG();
-	if (flags & SLAB_NO_GROW)
-		return 0;
-
-	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
-	local_flags = (flags & SLAB_LEVEL_MASK);
-	if (!(local_flags & __GFP_WAIT))
-		/*
-		 * Not allowed to sleep.  Need to tell a constructor about
-		 * this - it might need to know...
-		 */
-		ctor_flags |= SLAB_CTOR_ATOMIC;
-
-	/* About to mess with non-constant members - lock. */
-	check_irq_off();
-	spin_lock(&cachep->spinlock);
-
-	/* Get colour for the slab, and cal the next value. */
-	offset = cachep->colour_next;
-	cachep->colour_next++;
-	if (cachep->colour_next >= cachep->colour)
-		cachep->colour_next = 0;
-	offset *= cachep->colour_off;
-
-	spin_unlock(&cachep->spinlock);
-
-	check_irq_off();
-	if (local_flags & __GFP_WAIT)
-		local_irq_enable();
-
-	/*
-	 * Ensure caller isn't asking for DMA memory if the slab wasn't created
-	 * with the SLAB_DMA flag.
-	 * Also ensure the caller *is* asking for DMA memory if the slab was
-	 * created with the SLAB_DMA flag.
-	 */
-	kmem_flagcheck(cachep, flags);
-
-	/* Get mem for the objects by allocating a physical page from 'nid' */
-	if (!(objp = kmem_getpages(cachep, flags, nid)))
-		goto out_nomem;
-
-	/* Get slab management. */
-	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
-		goto out_freepages;
-
-	slabp->nid = nid;
-	set_slab_attr(cachep, slabp, objp);
-
-	cache_init_objs(cachep, slabp, ctor_flags);
-
-	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
-	check_irq_off();
-	l3 = cachep->nodelists[nid];
-	spin_lock(&l3->list_lock);
-
-	/* Make slab active. */
-	list_add_tail(&slabp->list, &(l3->slabs_free));
-	STATS_INC_GROWN(cachep);
-	l3->free_objects += cachep->num;
-	spin_unlock(&l3->list_lock);
-	return 1;
-out_freepages:
-	kmem_freepages(cachep, objp);
-out_nomem:
-	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
-	return 0;
-}
-
 #if DEBUG
 /*
  * Perform extra freeing checks:
@@ -2430,6 +2341,105 @@ bad:
 #define check_slabp(x,y)			do { } while(0)
 #endif
 
+/**
+ * Helper function for cache_grow().  Handle cache coloring, allocating a
+ * struct slab and initializing the slab.
+ */
+static struct slab *__cache_grow(kmem_cache_t *cachep, void *objp, gfp_t flags)
+{
+	struct slab *slabp;
+	size_t offset;
+	unsigned int local_flags;
+	unsigned long ctor_flags;
+
+	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+	local_flags = (flags & SLAB_LEVEL_MASK);
+	if (!(local_flags & __GFP_WAIT))
+		/*
+		 * Not allowed to sleep.  Need to tell a constructor about
+		 * this - it might need to know...
+		 */
+		ctor_flags |= SLAB_CTOR_ATOMIC;
+
+	/* About to mess with non-constant members - lock. */
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
+
+	/* Get colour for the slab, and cal the next value. */
+	offset = cachep->colour_next;
+	cachep->colour_next++;
+	if (cachep->colour_next >= cachep->colour)
+		cachep->colour_next = 0;
+	offset *= cachep->colour_off;
+
+	spin_unlock(&cachep->spinlock);
+
+	check_irq_off();
+	if (local_flags & __GFP_WAIT)
+		local_irq_enable();
+
+	/* Get slab management. */
+	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
+		goto out;
+
+	set_slab_attr(cachep, slabp, objp);
+	cache_init_objs(cachep, slabp, ctor_flags);
+
+out:
+	if (local_flags & __GFP_WAIT)
+		local_irq_disable();
+	check_irq_off();
+	return slabp;
+}
+
+/**
+ * Grow (by 1) the number of slabs within a cache.  This is called by
+ * kmem_cache_alloc() when there are no active objs left in a cache.
+ */
+static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nid)
+{
+	struct slab *slabp = NULL;
+	void *objp = NULL;
+
+	/*
+	 * Be lazy and only check for valid flags here,
+ 	 * keeping it out of the critical path in kmem_cache_alloc().
+	 */
+	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
+		BUG();
+	if (flags & SLAB_NO_GROW)
+		goto out;
+
+	/*
+	 * Ensure caller isn't asking for DMA memory if the slab wasn't created
+	 * with the SLAB_DMA flag.
+	 * Also ensure the caller *is* asking for DMA memory if the slab was
+	 * created with the SLAB_DMA flag.
+	 */
+	kmem_flagcheck(cachep, flags);
+
+	/* Get mem for the objects by allocating a physical page from 'nid' */
+	if ((objp = kmem_getpages(cachep, flags, nid))) {
+		struct kmem_list3 *l3 = cachep->nodelists[nid];
+
+		if (!(slabp = __cache_grow(cachep, objp, flags))) {
+			kmem_freepages(cachep, objp);
+			objp = NULL;
+			goto out;
+		}
+		slabp->nid = nid;
+
+		STATS_INC_GROWN(cachep);
+		/* Make slab active. */
+		spin_lock(&l3->list_lock);
+		list_add_tail(&slabp->list, &l3->slabs_free);
+		l3->free_objects += cachep->num;
+		spin_unlock(&l3->list_lock);
+	}
+out:
+	return objp != NULL;
+}
+
 static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
 {
 	int batchcount;

--------------090408010301040100020904--
