Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVC3R4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVC3R4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVC3R4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:56:12 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:22192 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262362AbVC3Rzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:55:37 -0500
Message-ID: <424AE7F7.3080508@colorfullife.com>
Date: Wed, 30 Mar 2005 19:55:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shai@scalex86.org
Subject: Re: API changes to the slab allocator for NUMA memory allocation
References: <20050315204110.6664771d.akpm@osdl.org> <42387C2E.4040106@colorfullife.com> <273220000.1110999247@[10.10.2.4]> <4238845E.5060304@colorfullife.com> <Pine.LNX.4.58.0503292126050.32140@server.graphe.net> <424A3FA0.9030403@colorfullife.com> <Pine.LNX.4.58.0503300748320.12816@server.graphe.net>
In-Reply-To: <Pine.LNX.4.58.0503300748320.12816@server.graphe.net>
Content-Type: multipart/mixed;
 boundary="------------090306000807030707050709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306000807030707050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Lameter wrote:

>The -1 is optimized away for the non NUMA case. In the NUMA case its an
>additional parameter that is passed to kmem_cache_alloc. So its one
>additional register load that allows us to not have an additional function
>for the case non node specific allocations.
>  
>
Correct, I was thinking about the NUMA case.
You've decided to add one register load to every call of kmalloc. On 
i386, kmalloc_node() is a 24-byte function. I'd bet that adding the node 
parameter to every call of kmalloc causes a .text increase larger than 
240 bytes. And I have not yet considered that you have increased the 
number of conditional branches in every kmalloc(32,GFP_KERNEL) call by 
33%, i.e. from 3 to 4 conditional branch instructions.
I'd add an explicit kmalloc_node function. Attached is a prototype 
patch. You'd have to reintroduce the flags field to 
kmem_cache_alloc_node() and update kmalloc_node.
The patch was manually edited, I hope it applies to a recent tree ;-)

What do you think?
--
    Manfred




--------------090306000807030707050709
Content-Type: text/plain;
 name="patch-slab-numa-experimental"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-numa-experimental"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 11
//  EXTRAVERSION = -mm2
--- 2.6/include/linux/slab.h	2005-03-12 01:05:50.000000000 +0100
+++ build-2.6/include/linux/slab.h	2005-03-30 19:33:56.158317105 +0200
@@ -62,16 +62,9 @@
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
-#ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
-#else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
-{
-	return kmem_cache_alloc(cachep, GFP_KERNEL);
-}
-#endif
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
+extern kmem_cache_t * kmem_find_general_cachep(size_t size, int gfpflags);
 
 /* Size description struct for general caches. */
 struct cache_sizes {
@@ -109,6 +102,20 @@
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
+#ifdef CONFIG_NUMA
+extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
+extern void *kmalloc_node(size_t size, int flags, int node);
+#else
+static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
+{
+	return kmem_cache_alloc(cachep, GFP_KERNEL);
+}
+static inline void *kmalloc_node(size_t size, int flags, int node)
+{
+	return kmalloc(size, flags);
+}
+#endif
+
 extern int FASTCALL(kmem_cache_reap(int));
 extern int FASTCALL(kmem_ptr_validate(kmem_cache_t *cachep, void *ptr));
 
--- 2.6/mm/slab.c	2005-03-12 12:36:34.000000000 +0100
+++ build-2.6/mm/slab.c	2005-03-30 19:44:15.428757330 +0200
@@ -586,7 +586,7 @@
 	return cachep->array[smp_processor_id()];
 }
 
-static inline kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
+static inline kmem_cache_t *__find_general_cachep(size_t size, int gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
@@ -610,6 +610,12 @@
 	return csizep->cs_cachep;
 }
 
+kmem_cache_t *kmem_find_general_cachep(size_t size, int gfpflags)
+{
+	return __find_general_cachep(size, gfpflags);
+}
+EXPORT_SYMBOL(kmem_find_general_cachep);
+
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void cache_estimate (unsigned long gfporder, size_t size, size_t align,
 		 int flags, size_t *left_over, unsigned int *num)
@@ -2200,7 +2197,7 @@
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
 		check_slabp(cachep, slabp);
-#if 0	/* disabled, not compatible with leak detection */
+#if DEBUG
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
 			printk(KERN_ERR "slab: double free detected in cache "
 					"'%s', objp %p\n", cachep->name, objp);
@@ -2450,6 +2447,16 @@
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+void *kmalloc_node(size_t size, int flags, int node)
+{
+	kmem_cache_t *cachep;
+
+	cachep = kmem_find_general_cachep(size, flags);
+	if (unlikely(cachep == NULL))
+		return NULL;
+	return kmem_cache_alloc_node(cachep, node);
+}
+EXPORT_SYMBOL(kmalloc_node);
 #endif
 
 /**
@@ -2477,7 +2484,12 @@
 {
 	kmem_cache_t *cachep;
 
-	cachep = kmem_find_general_cachep(size, flags);
+	/* If you want to save a few bytes .text space: replace
+	 * __ with kmem_.
+	 * Then kmalloc uses the uninlined functions instead of the inline
+	 * functions.
+	 */
+	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
 	return __cache_alloc(cachep, flags);

--------------090306000807030707050709--
