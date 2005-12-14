Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVLNH7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVLNH7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVLNH7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:59:33 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:41672 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751119AbVLNH7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:59:32 -0500
Message-ID: <439FD0E1.2060908@us.ibm.com>
Date: Tue, 13 Dec 2005 23:59:29 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrea@suse.de, Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 5/6] Slab Prep: Move cache_grow()
References: <439FCECA.3060909@us.ibm.com>
In-Reply-To: <439FCECA.3060909@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040209050301070403090206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040209050301070403090206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Move cache_grow() a few lines further down in mm/slab.c to gain access to a
couple debugging functions that will be used by the next patch.  Also,
rename a goto label and fixup a couple comments.

-Matt

--------------040209050301070403090206
Content-Type: text/x-patch;
 name="slab_prep-cache_grow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab_prep-cache_grow.patch"

Move cache_grow() below some debugging function definitions, so those debugging
functions can be inserted into cache_grow() by the next patch without needing
forward declarations.

Also, do a few small cleanups:
	Tidy up a few comments
	Rename a label to something readable

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc5+critical_pool/mm/slab.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/mm/slab.c	2005-12-13 16:08:04.123634776 -0800
+++ linux-2.6.15-rc5+critical_pool/mm/slab.c	2005-12-13 16:14:25.757617592 -0800
@@ -2203,96 +2203,6 @@ static void set_slab_attr(kmem_cache_t *
 	} while (--i);
 }
 
-/*
- * Grow (by 1) the number of slabs within a cache.  This is called by
- * kmem_cache_alloc() when there are no active objs left in a cache.
- */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
-{
-	struct slab	*slabp;
-	void		*objp;
-	size_t		 offset;
-	gfp_t	 	 local_flags;
-	unsigned long	 ctor_flags;
-	struct kmem_list3 *l3;
-
-	/* Be lazy and only check for valid flags here,
- 	 * keeping it out of the critical path in kmem_cache_alloc().
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
-	 * The test for missing atomic flag is performed here, rather than
-	 * the more obvious place, simply to reduce the critical path length
-	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
-	 * will eventually be caught here (where it matters).
-	 */
-	kmem_flagcheck(cachep, flags);
-
-	/* Get mem for the objs.
-	 * Attempt to allocate a physical page from 'nodeid',
-	 */
-	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
-		goto failed;
-
-	/* Get slab management. */
-	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
-		goto opps1;
-
-	slabp->nodeid = nodeid;
-	set_slab_attr(cachep, slabp, objp);
-
-	cache_init_objs(cachep, slabp, ctor_flags);
-
-	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
-	check_irq_off();
-	l3 = cachep->nodelists[nodeid];
-	spin_lock(&l3->list_lock);
-
-	/* Make slab active. */
-	list_add_tail(&slabp->list, &(l3->slabs_free));
-	STATS_INC_GROWN(cachep);
-	l3->free_objects += cachep->num;
-	spin_unlock(&l3->list_lock);
-	return 1;
-opps1:
-	kmem_freepages(cachep, objp);
-failed:
-	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
-	return 0;
-}
-
 #if DEBUG
 
 /*
@@ -2414,6 +2324,90 @@ bad:
 #define check_slabp(x,y) do { } while(0)
 #endif
 
+/**
+ * Grow (by 1) the number of slabs within a cache.  This is called by
+ * kmem_cache_alloc() when there are no active objs left in a cache.
+ */
+static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+{
+	struct slab *slabp;
+	void *objp;
+	size_t offset;
+	gfp_t local_flags;
+	unsigned long ctor_flags;
+	struct kmem_list3 *l3;
+
+	/*
+	 * Be lazy and only check for valid flags here,
+	 * keeping it out of the critical path in kmem_cache_alloc().
+	 */
+	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
+		BUG();
+	if (flags & SLAB_NO_GROW)
+		return 0;
+
+	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+	local_flags = (flags & SLAB_LEVEL_MASK);
+	if (!(local_flags & __GFP_WAIT))
+		/* The constructor might need to know it can't sleep */
+		ctor_flags |= SLAB_CTOR_ATOMIC;
+
+	/* About to mess with non-constant members - lock. */
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
+	/* Get colour for the slab, and calculate the next value. */
+	offset = cachep->colour_next;
+	cachep->colour_next++;
+	if (cachep->colour_next >= cachep->colour)
+		cachep->colour_next = 0;
+	offset *= cachep->colour_off;
+	/* done...  Unlock. */
+	spin_unlock(&cachep->spinlock);
+
+	check_irq_off();
+	if (local_flags & __GFP_WAIT)
+		local_irq_enable();
+
+	/*
+	 * Ensure caller isn't asking for DMA memory if the slab wasn't created
+	 * with the SLAB_DMA flag.
+	 * Also ensure the caller *is* asking for DMA memory if the slab was
+	 * created with the SLAB_DMA flag.
+	 */
+	kmem_flagcheck(cachep, flags);
+
+	/* Get memory for the objects by allocating a page from 'nodeid'. */
+	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
+		goto failed;
+
+	/* Get slab management. */
+	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
+		goto failed_freepages;
+
+	slabp->nodeid = nodeid;
+	set_slab_attr(cachep, slabp, objp);
+	cache_init_objs(cachep, slabp, ctor_flags);
+
+	if (local_flags & __GFP_WAIT)
+		local_irq_disable();
+	check_irq_off();
+	l3 = cachep->nodelists[nodeid];
+	spin_lock(&l3->list_lock);
+
+	/* Make slab active. */
+	list_add_tail(&slabp->list, &(l3->slabs_free));
+	STATS_INC_GROWN(cachep);
+	l3->free_objects += cachep->num;
+	spin_unlock(&l3->list_lock);
+	return 1;
+failed_freepages:
+	kmem_freepages(cachep, objp);
+failed:
+	if (local_flags & __GFP_WAIT)
+		local_irq_disable();
+	return 0;
+}
+
 static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
 {
 	int batchcount;

--------------040209050301070403090206--
