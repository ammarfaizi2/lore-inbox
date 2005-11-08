Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVKHAxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVKHAxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVKHAxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:53:38 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12482 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030214AbVKHAxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:53:37 -0500
Message-ID: <436FF70D.6040604@us.ibm.com>
Date: Mon, 07 Nov 2005 16:53:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com>
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020307090606060803060704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307090606060803060704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Cleanup kmem_cache_create()

mcd@arrakis:~/linux/source/linux-2.6.14+slab_cleanup/patches $ diffstat
kmem_cache_create.patch
 slab.c |   69
++++++++++++++++++++++++++++-------------------------------------
 1 files changed, 30 insertions(+), 39 deletions(-)

-Matt


--------------020307090606060803060704
Content-Type: text/x-patch;
 name="kmem_cache_create.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmem_cache_create.patch"

General readability fixes.

* Reformat a looong if statement
* Replace a constant (4096) with what it represents (PAGE_SIZE)
* Replace a confusing label (opps) with a more sensible one (out)
* Refactor a do {} while loop w/ a couple labels and gotos into
     a for loop with breaks and continues.
* Rewrite some confusing slab alignment code for readability
* Replace a list_for_each/list_entry combo with an identical but
     more readable list_for_each_entry loop.

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-07 15:58:48.547771048 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-07 15:58:50.495474952 -0800
@@ -1499,21 +1499,18 @@ kmem_cache_t *kmem_cache_create(const ch
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
@@ -1531,7 +1528,7 @@ kmem_cache_t *kmem_cache_create(const ch
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
+	if (size < PAGE_SIZE || fls(size-1) == fls(size-1 + 3*BYTES_PER_WORD))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
@@ -1594,7 +1591,7 @@ kmem_cache_t *kmem_cache_create(const ch
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
-		goto opps;
+		goto out;
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
 #if DEBUG
@@ -1652,9 +1649,9 @@ kmem_cache_t *kmem_cache_create(const ch
 		 * gfp() funcs are more friendly towards high-order requests,
 		 * this should be changed.
 		 */
-		do {
-			unsigned int break_flag = 0;
-cal_wastage:
+		unsigned int break_flag = 0;
+
+		for ( ; ; cachep->gfporder++) {
 			cache_estimate(cachep->gfporder, size, align, flags,
 						&left_over, &cachep->num);
 			if (break_flag)
@@ -1662,13 +1659,13 @@ cal_wastage:
 			if (cachep->gfporder >= MAX_GFP_ORDER)
 				break;
 			if (!cachep->num)
-				goto next;
-			if (flags & CFLGS_OFF_SLAB &&
-					cachep->num > offslab_limit) {
+				continue;
+			if ((flags & CFLGS_OFF_SLAB) &&
+			    (cachep->num > offslab_limit)) {
 				/* This num of objs will cause problems. */
-				cachep->gfporder--;
+				cachep->gfporder -= 2;
 				break_flag++;
-				goto cal_wastage;
+				continue;
 			}
 
 			/*
@@ -1680,33 +1677,29 @@ cal_wastage:
 
 			if ((left_over*8) <= (PAGE_SIZE<<cachep->gfporder))
 				break;	/* Acceptable internal fragmentation. */
-next:
-			cachep->gfporder++;
-		} while (1);
+		}
 	}
 
 	if (!cachep->num) {
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
@@ -1789,13 +1782,12 @@ next:
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
@@ -1821,10 +1813,9 @@ next:
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

--------------020307090606060803060704--
