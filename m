Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVCFVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVCFVVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVCFVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:21:55 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:36759 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261507AbVCFVVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:21:49 -0500
Message-ID: <422B746B.1010406@free.fr>
Date: Sun, 06 Mar 2005 22:21:47 +0100
From: Renaud Lienhart <renaud.lienhart@free.fr>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050305)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] slab.[ch]: kmalloc() cleanups
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While studying the slab code, I found 2 strange things:
- kmalloc(size, ...); checks "size" validity only if size is a constant
known at compile-time.
- __kmalloc(...) contains code which is redundant with
kmem_find_general_cachep().

The following patch solves these two problems:
- It creates a (rather ugly) macro in kmalloc_sizes.h in order to check
kmalloc(size)'s validity at run-time in O(1).
- It replaces redundant code in __kmalloc() by a call to
kmem_find_general_cachep(). The debug checks are moved in the latter.

Please comment, as it is my first patch to the linux kernel.

Signed-off-by: Renaud Lienhart <renaud.lienhart@free.fr>

diff -Nrpu linux-2.6.11-orig/include/linux/kmalloc_sizes.h linux-2.6.11-new/include/linux/kmalloc_sizes.h
--- linux-2.6.11-orig/include/linux/kmalloc_sizes.h	2005-03-02 08:38:20.000000000 +0100
+++ linux-2.6.11-new/include/linux/kmalloc_sizes.h	2005-03-06 21:34:34.000000000 +0100
@@ -19,15 +19,20 @@
  	CACHE(32768)
  	CACHE(65536)
  	CACHE(131072)
+#define MAX_KMALLOC 131072
  #ifndef CONFIG_MMU
  	CACHE(262144)
  	CACHE(524288)
  	CACHE(1048576)
+#undef MAX_KMALLOC
+#define MAX_KMALLOC 1048576
  #ifdef CONFIG_LARGE_ALLOCS
  	CACHE(2097152)
  	CACHE(4194304)
  	CACHE(8388608)
  	CACHE(16777216)
  	CACHE(33554432)
+#undef MAX_KMALLOC
+#define MAX_KMALLOC 33554432
  #endif /* CONFIG_LARGE_ALLOCS */
  #endif /* CONFIG_MMU */
diff -Nrpu linux-2.6.11-orig/include/linux/slab.h
linux-2.6.11-new/include/linux/slab.h
--- linux-2.6.11-orig/include/linux/slab.h	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11-new/include/linux/slab.h	2005-03-06 21:34:14.000000000 +0100
@@ -102,6 +102,8 @@ found:
  			malloc_sizes[i].cs_dmacachep :
  			malloc_sizes[i].cs_cachep, flags);
  	}
+	if (unlikely(size > MAX_KMALLOC))
+		return NULL;
  	return __kmalloc(size, flags);
  }

diff -Nrpu linux-2.6.11-orig/mm/slab.c linux-2.6.11-new/mm/slab.c
--- linux-2.6.11-orig/mm/slab.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.11-new/mm/slab.c	2005-03-06 21:33:58.000000000 +0100
@@ -507,7 +507,7 @@ static int slab_break_gfp_order = BREAK_
  struct cache_sizes malloc_sizes[] = {
  #define CACHE(x) { .cs_size = (x) },
  #include <linux/kmalloc_sizes.h>
-	{ 0, }
+	CACHE(0)
  #undef CACHE
  };

@@ -584,19 +584,24 @@ static inline struct array_cache *ac_dat
  	return cachep->array[smp_processor_id()];
  }

-static kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
+static inline kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
  {
  	struct cache_sizes *csizep = malloc_sizes;

-	/* This function could be moved to the header file, and
-	 * made inline so consumers can quickly determine what
-	 * cache pointer they require.
-	 */
  	for ( ; csizep->cs_size; csizep++) {
  		if (size > csizep->cs_size)
  			continue;
  		break;
  	}
+#if DEBUG
+	/* we are a bit too optimistic and size > MAX_KMALLOC */
+	BUG_ON(csizep->cs_size == 0);
+	/* This happens if someone tries to call
+	 * kmem_cache_create(), or __kmalloc(), before
+	 * the generic caches are initialized.
+	 */
+	BUG_ON(csizep->cs_cachep == NULL);
+#endif
  	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
  }

@@ -2453,22 +2458,10 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
   */
  void * __kmalloc (size_t size, int flags)
  {
-	struct cache_sizes *csizep = malloc_sizes;
+	kmem_cache_t *cachep;

-	for (; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
-#if DEBUG
-		/* This happens if someone tries to call
-		 * kmem_cache_create(), or kmalloc(), before
-		 * the generic caches are initialized.
-		 */
-		BUG_ON(csizep->cs_cachep == NULL);
-#endif
-		return __cache_alloc(flags & GFP_DMA ?
-			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
-	}
-	return NULL;
+	cachep = kmem_find_general_cachep(size, flags);
+	return __cache_alloc(cachep, flags);
  }

  EXPORT_SYMBOL(__kmalloc);


