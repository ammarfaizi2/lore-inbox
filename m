Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUE1Urp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUE1Urp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUE1Urp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:47:45 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:944 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261638AbUE1Url (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:47:41 -0400
Message-ID: <40B7A562.8040104@colorfullife.com>
Date: Fri, 28 May 2004 22:47:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dean Nelson <dcn@sgi.com>
Subject: [RFC, PATCH] set SLAB_HWCACHE_ALIGN for kmalloc caches
Content-Type: multipart/mixed;
 boundary="------------000506060601000005050305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506060601000005050305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The recent patches that changed the default alignment for slab caches 
affected the alignment of the kmalloc caches:
Initially the default was word alignment and it was increased for the 
kmalloc caches by setting SLAB_HWCACHE_ALIGN.
The "align" patch changed the default to cache line alignment and 
removed the SLAB_HWCACHE_ALIGN flag from the kmem_cache_create calls for 
kmalloc.
But when the default was changed back to word alignment the flag was not 
reintroduced for kmalloc.

I think the kmalloc caches should remain cache line aligned: the object 
sizes are powers of two, so there is virtually no wasted memory. What 
about the attached patch? I've added an arch override, perhaps someone 
wants unaligned kmalloc caches (caused by word offsets for coloring 
instead of cache line offsets).

An arch override is definitively needed: One of SGI's drivers needs 
cache line alignment due to hardware constraints.
--
    Manfred

--------------000506060601000005050305
Content-Type: text/plain;
 name="patch-slab-kmallocalign"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-kmallocalign"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm5
--- 2.6/mm/slab.c	2004-05-23 21:11:54.000000000 +0200
+++ build-2.6/mm/slab.c	2004-05-28 22:14:36.000000000 +0200
@@ -129,6 +129,10 @@
 #define ARCH_KMALLOC_MINALIGN 0
 #endif
 
+#ifndef ARCH_KMALLOC_FLAGS
+#define ARCH_KMALLOC_FLAGS SLAB_HWCACHE_ALIGN
+#endif
+
 /* Legal flag mask for kmem_cache_create(). */
 #if DEBUG
 # define CREATE_MASK	(SLAB_DEBUG_INITIAL | SLAB_RED_ZONE | \
@@ -756,7 +760,7 @@
 		 * allow tighter packing of the smaller caches. */
 		sizes->cs_cachep = kmem_cache_create(
 			names->name, sizes->cs_size,
-			ARCH_KMALLOC_MINALIGN, 0, NULL, NULL);
+			ARCH_KMALLOC_MINALIGN, ARCH_KMALLOC_FLAGS, NULL, NULL);
 		if (!sizes->cs_cachep)
 			BUG();
 
@@ -768,7 +772,8 @@
 
 		sizes->cs_dmacachep = kmem_cache_create(
 			names->name_dma, sizes->cs_size,
-			ARCH_KMALLOC_MINALIGN, SLAB_CACHE_DMA, NULL, NULL);
+			ARCH_KMALLOC_MINALIGN, ARCH_KMALLOC_FLAGS|SLAB_CACHE_DMA,
+			NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
 
@@ -1118,8 +1123,9 @@
  * %SLAB_NO_REAP - Don't automatically reap this cache when we're under
  * memory pressure.
  *
- * %SLAB_HWCACHE_ALIGN - This flag has no effect and will be removed soon.
- *
+ * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
+ * cacheline.  This can be beneficial if you're counting cycles as closely
+ * as davem.
  */
 kmem_cache_t *
 kmem_cache_create (const char *name, size_t size, size_t align,

--------------000506060601000005050305--

