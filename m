Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVKKAEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVKKAEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVKKAEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:04:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:62925 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932277AbVKKAEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:04:36 -0500
Message-ID: <4373E011.9070508@us.ibm.com>
Date: Thu, 10 Nov 2005 16:04:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] Cleanup kmem_cache_create()
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010707030700010700080909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010707030700010700080909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

kmem_cache_create() is a pretty big function, so we'll devote one whole
patch just to cleaning it up.

-Matt

--------------010707030700010700080909
Content-Type: text/x-patch;
 name="kmem_cache_create.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmem_cache_create.patch"

General readability fixes.

* Replace a constant (4096) with a named #define (RED_ZONE_LIMIT)
* Reformat a looong if statement
* Replace a confusing label (opps) with a more sensible one (out)
* Rewrite some confusing slab alignment code for readability
* Replace a list_for_each/list_entry combo with an identical but
     more readable list_for_each_entry loop.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:48:43.827192216 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:48:47.540627688 -0800
@@ -491,6 +491,9 @@ struct kmem_cache_s {
 #define POISON_FREE	0x6b	/* for use-after-free poisoning */
 #define POISON_END	0xa5	/* end-byte of poisoning */
 
+/* Don't use red zoning for ojects greater than this size */
+#define RED_ZONE_LIMIT	4096
+
 /*
  * memory layout of objects:
  * 0		: objp
@@ -1547,21 +1550,18 @@ kmem_cache_t *kmem_cache_create(const ch
 				void (*ctor)(void *, kmem_cache_t *, unsigned long),
 				void (*dtor)(void *, kmem_cache_t *, unsigned long))
 {
-	size_t left_over, slab_size, ralign;
+	size_t left_over, slab_size, aligned_slab_size, ralign;
 	kmem_cache_t *cachep = NULL;
 
 	/*
 	 * Sanity checks... these are all serious usage bugs.
 	 */
-	if ((!name) ||
-		in_interrupt() ||
-		(size < BYTES_PER_WORD) ||
-		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
-		(dtor && !ctor)) {
-			printk(KERN_ERR "%s: Early error in slab %s\n",
-					__FUNCTION__, name);
-			BUG();
-		}
+	if (!name || in_interrupt() || (size < BYTES_PER_WORD) ||
+	    (size > (1 << MAX_OBJ_ORDER) * PAGE_SIZE) || (dtor && !ctor)) {
+		printk(KERN_ERR "%s: Early error in slab %s\n",
+		       __FUNCTION__, name);
+		BUG();
+	}
 
 #if DEBUG
 	WARN_ON(strchr(name, ' '));	/* It confuses parsers */
@@ -1579,7 +1579,8 @@ kmem_cache_t *kmem_cache_create(const ch
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if (size < 4096 || fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD))
+	if (size < RED_ZONE_LIMIT ||
+	    fls(size - 1) == fls(size - 1 + 3 * BYTES_PER_WORD))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
@@ -1642,7 +1643,7 @@ kmem_cache_t *kmem_cache_create(const ch
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
-		goto opps;
+		goto out;
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
 #if DEBUG
@@ -1700,24 +1701,22 @@ kmem_cache_t *kmem_cache_create(const ch
 		printk("kmem_cache_create: couldn't create cache %s.\n", name);
 		kmem_cache_free(&cache_cache, cachep);
 		cachep = NULL;
-		goto opps;
+		goto out;
 	}
-	slab_size = ALIGN(cachep->num*sizeof(kmem_bufctl_t)
-				+ sizeof(struct slab), align);
+	slab_size = cachep->num * sizeof(kmem_bufctl_t) + sizeof(struct slab);
+	aligned_slab_size = ALIGN(slab_size, align);
 
 	/*
 	 * If the slab has been placed off-slab, and we have enough space then
 	 * move it on-slab. This is at the expense of any extra colouring.
 	 */
-	if (flags & CFLGS_OFF_SLAB && left_over >= slab_size) {
+	if (flags & CFLGS_OFF_SLAB && left_over >= aligned_slab_size) {
 		flags &= ~CFLGS_OFF_SLAB;
-		left_over -= slab_size;
-	}
-
-	if (flags & CFLGS_OFF_SLAB) {
-		/* really off slab. No need for manual alignment */
-		slab_size = cachep->num*sizeof(kmem_bufctl_t)+sizeof(struct slab);
+		left_over -= aligned_slab_size;
 	}
+	/* On slab, need manual alignment */
+	if (!(flags & CFLGS_OFF_SLAB))
+		slab_size = aligned_slab_size;
 
 	cachep->colour_off = cache_line_size();
 	/* Offset must be a multiple of the alignment. */
@@ -1799,13 +1798,12 @@ kmem_cache_t *kmem_cache_create(const ch
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
 	{
-		struct list_head *p;
+		kmem_cache_t *pc;
 		mm_segment_t old_fs;
 
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		list_for_each(p, &cache_chain) {
-			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
+		list_for_each_entry(pc, &cache_chain, next) {
 			char tmp;
 			/*
 			 * This happens when the module gets unloaded & doesn't
@@ -1832,10 +1830,9 @@ kmem_cache_t *kmem_cache_create(const ch
 	list_add(&cachep->next, &cache_chain);
 	up(&cache_chain_sem);
 	unlock_cpu_hotplug();
-opps:
+out:
 	if (!cachep && (flags & SLAB_PANIC))
-		panic("kmem_cache_create(): failed to create slab `%s'\n",
-			name);
+		panic("%s: failed to create slab `%s'\n", __FUNCTION__, name);
 	return cachep;
 }
 EXPORT_SYMBOL(kmem_cache_create);

--------------010707030700010700080909--
