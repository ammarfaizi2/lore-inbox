Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTFITZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTFITZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:25:19 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:58068 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264523AbTFITZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:25:08 -0400
Message-ID: <3EE4E23E.4070307@colorfullife.com>
Date: Mon, 09 Jun 2003 21:38:38 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC,PATCH] optimize fixed size kmalloc calls
Content-Type: multipart/mixed;
 boundary="------------080500070205020805010406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500070205020805010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

kmalloc(constant,GFP_KERNEL) spends a singificant amount of time in the 
initial loop that finds the correct cache. For constant allocations, the 
correct cache can be indentified at compile time.

What do you think about the attached patch? It's not pretty, but it 
should work will all gcc versions. Any other ideas?
Just FYI: The function that forced me to use use switch/case instead of 
if is interrupts_open in fs/proc/proc_misc.c.

--
    Manfred

--------------080500070205020805010406
Content-Type: text/plain;
 name="patch-kmalloc-fixed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kmalloc-fixed"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 70
//  EXTRAVERSION = -mm4
--- 2.5/include/linux/slab.h	2003-06-08 23:32:03.000000000 +0200
+++ build-2.5/include/linux/slab.h	2003-06-08 23:30:41.000000000 +0200
@@ -62,7 +62,52 @@
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
-extern void *kmalloc(size_t, int);
+/* Size description struct for general caches. */
+struct cache_sizes {
+	size_t		 cs_size;
+	kmem_cache_t	*cs_cachep;
+	kmem_cache_t	*cs_dmacachep;
+};
+extern struct cache_sizes malloc_sizes[];
+extern void *__kmalloc(size_t, int);
+
+/*
+ * gcc's brain is lossy: is forgets that a number is known at compile
+ * time after a few accesses and produces bogus code if a sequence of
+ * if clauses is used. This is avoided by using select.
+ */
+static inline void * kmalloc(size_t size, int flags)
+{
+	if (__builtin_constant_p(size)) {
+extern void __you_cannot_kmalloc_that_much(void);
+		unsigned int i,j;
+		j = 0;
+		switch(size) {
+		case 0 ...
+#define CACHE(x) \
+			(x): j++; \
+		case (x+1) ...
+#define LCACHE(x) \
+			(x): j++; break;
+#include "kmalloc_sizes.h"
+#undef CACHE
+#undef LCACHE
+		default:
+				__you_cannot_kmalloc_that_much();
+		}
+		i = 0;
+#define CACHE(x) \
+		i++;
+#include "kmalloc_sizes.h"
+#undef CACHE
+		return kmem_cache_alloc( (flags & GFP_DMA)?
+					malloc_sizes[i-j].cs_dmacachep
+					: malloc_sizes[i-j].cs_cachep,
+					flags);
+	}
+	return __kmalloc(size,flags);
+}
+
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
--- 2.5/mm/slab.c	2003-06-08 23:32:06.000000000 +0200
+++ build-2.5/mm/slab.c	2003-06-07 21:57:59.000000000 +0200
@@ -388,11 +388,7 @@
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->list.prev)
 
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
-static struct cache_sizes {
-	size_t		 cs_size;
-	kmem_cache_t	*cs_cachep;
-	kmem_cache_t	*cs_dmacachep;
-} malloc_sizes[] = {
+struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
 #include <linux/kmalloc_sizes.h>
 	{ 0, }
@@ -2039,7 +2035,7 @@
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void * kmalloc (size_t size, int flags)
+void * __kmalloc (size_t size, int flags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
--- 2.5/kernel/ksyms.c	2003-06-08 23:32:04.000000000 +0200
+++ build-2.5/kernel/ksyms.c	2003-06-07 21:56:55.000000000 +0200
@@ -95,7 +95,8 @@
 EXPORT_SYMBOL(kmem_cache_size);
 EXPORT_SYMBOL(set_shrinker);
 EXPORT_SYMBOL(remove_shrinker);
-EXPORT_SYMBOL(kmalloc);
+EXPORT_SYMBOL(malloc_sizes);
+EXPORT_SYMBOL(__kmalloc);
 EXPORT_SYMBOL(kfree);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(__alloc_percpu);
--- 2.5/include/linux/kmalloc_sizes.h	2003-06-05 19:01:42.000000000 +0200
+++ build-2.5/include/linux/kmalloc_sizes.h	2003-06-08 23:23:11.000000000 +0200
@@ -1,3 +1,14 @@
+/*
+ * kmalloc cache sizes.
+ * - CACHE(x) is called for every entry except the last
+ * - for the last entry, LCACHE is called. LCACHE defaults
+ *   to CACHE.
+ */
+#ifndef LCACHE
+#define LCACHE(x)	CACHE(x)
+#define __LCACHE_DEFINED
+#endif
+
 #if (PAGE_SIZE == 4096)
 	CACHE(32)
 #endif
@@ -18,16 +29,25 @@
 	CACHE(16384)
 	CACHE(32768)
 	CACHE(65536)
+#ifdef CONFIG_MMU
+	LCACHE(131072)
+#else
 	CACHE(131072)
-#ifndef CONFIG_MMU
 	CACHE(262144)
 	CACHE(524288)
+#ifndef CONFIG_LARGE_ALLOCS
+	LCACHE(1048576)
+#else
 	CACHE(1048576)
-#ifdef CONFIG_LARGE_ALLOCS
 	CACHE(2097152)
 	CACHE(4194304)
 	CACHE(8388608)
 	CACHE(16777216)
-	CACHE(33554432)
+	LCACHE(33554432)
 #endif /* CONFIG_LARGE_ALLOCS */
 #endif /* CONFIG_MMU */
+
+#ifdef __LCACHE_DEFINED
+#undef __LCACHE_DEFINIED
+#undef LCACHE
+#endif

--------------080500070205020805010406--

