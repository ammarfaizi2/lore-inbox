Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbTCWSrk>; Sun, 23 Mar 2003 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTCWSrj>; Sun, 23 Mar 2003 13:47:39 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:63108 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S263139AbTCWSrg>; Sun, 23 Mar 2003 13:47:36 -0500
Message-ID: <3E7E03C9.6060804@quark.didntduck.org>
Date: Sun, 23 Mar 2003 13:58:17 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab.c cleanup
Content-Type: multipart/mixed;
 boundary="------------080607030506020303050804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607030506020303050804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Reduce code duplication by putting the kmalloc cache sizes into a 
header file.
- Don't create caches that are not multiples of L1_CACHE_BYTES.
- Tidy up kmem_cache_sizes_init().

--
				Brian Gerst

--------------080607030506020303050804
Content-Type: text/plain;
 name="kmalloc_sizes-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmalloc_sizes-1"

diff -urN linux-2.5.65-bk5/include/linux/kmalloc_sizes.h linux/include/linux/kmalloc_sizes.h
--- linux-2.5.65-bk5/include/linux/kmalloc_sizes.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/kmalloc_sizes.h	2003-03-23 10:39:23.000000000 -0500
@@ -0,0 +1,37 @@
+#if !(32 % L1_CACHE_BYTES) && (PAGE_SIZE == 4096)
+	CACHE(32)
+#endif
+#if !(64 % L1_CACHE_BYTES)
+	CACHE(64)
+#endif
+#if !(96 % L1_CACHE_BYTES)
+	CACHE(96)
+#endif
+#if !(128 % L1_CACHE_BYTES)
+	CACHE(128)
+#endif
+#if !(192 % L1_CACHE_BYTES)
+	CACHE(192)
+#endif
+	CACHE(256)
+	CACHE(512)
+	CACHE(1024)
+	CACHE(2048)
+	CACHE(4096)
+	CACHE(8192)
+	CACHE(16384)
+	CACHE(32768)
+	CACHE(65536)
+	CACHE(131072)
+#ifndef CONFIG_MMU
+	CACHE(262144)
+	CACHE(524288)
+	CACHE(1048576)
+#ifdef CONFIG_LARGE_ALLOCS
+	CACHE(2097152)
+	CACHE(4194304)
+	CACHE(8388608)
+	CACHE(16777216)
+	CACHE(33554432)
+#endif /* CONFIG_LARGE_ALLOCS */
+#endif /* CONFIG_MMU */
diff -urN linux-2.5.65-bk5/mm/slab.c linux/mm/slab.c
--- linux-2.5.65-bk5/mm/slab.c	2003-03-23 09:35:46.000000000 -0500
+++ linux/mm/slab.c	2003-03-23 13:03:12.000000000 -0500
@@ -375,91 +375,26 @@
 #define	SET_PAGE_SLAB(pg,x)   ((pg)->list.prev = (struct list_head *)(x))
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->list.prev)
 
-/* Size description struct for general caches. */
-struct cache_sizes {
+/* These are the default caches for kmalloc. Custom caches can have other sizes. */
+static struct cache_sizes {
 	size_t		 cs_size;
 	kmem_cache_t	*cs_cachep;
 	kmem_cache_t	*cs_dmacachep;
+} malloc_sizes[] = {
+#define CACHE(x) { .cs_size = (x) },
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
 };
 
-/* These are the default caches for kmalloc. Custom caches can have other sizes. */
-static struct cache_sizes malloc_sizes[] = {
-#if PAGE_SIZE == 4096
-	{    32,	NULL, NULL},
-#endif
-	{    64,	NULL, NULL},
-#if L1_CACHE_BYTES < 64
-	{    96,	NULL, NULL},
-#endif
-	{   128,	NULL, NULL},
-#if L1_CACHE_BYTES < 128
-	{   192,	NULL, NULL},
-#endif
-	{   256,	NULL, NULL},
-	{   512,	NULL, NULL},
-	{  1024,	NULL, NULL},
-	{  2048,	NULL, NULL},
-	{  4096,	NULL, NULL},
-	{  8192,	NULL, NULL},
-	{ 16384,	NULL, NULL},
-	{ 32768,	NULL, NULL},
-	{ 65536,	NULL, NULL},
-	{131072,	NULL, NULL},
-#ifndef CONFIG_MMU
-	{262144,	NULL, NULL},
-	{524288,	NULL, NULL},
-	{1048576,	NULL, NULL},
-#ifdef CONFIG_LARGE_ALLOCS
-	{2097152,	NULL, NULL},
-	{4194304,	NULL, NULL},
-	{8388608,	NULL, NULL},
-	{16777216,	NULL, NULL},
-	{33554432,	NULL, NULL},
-#endif /* CONFIG_LARGE_ALLOCS */
-#endif /* CONFIG_MMU */
-	{     0,	NULL, NULL}
-};
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
-#define CN(x) { x, x "(DMA)" }
 static struct { 
 	char *name; 
 	char *name_dma;
 } cache_names[] = { 
-#if PAGE_SIZE == 4096
-	CN("size-32"),
-#endif
-	CN("size-64"),
-#if L1_CACHE_BYTES < 64
-	CN("size-96"),
-#endif
-	CN("size-128"),
-#if L1_CACHE_BYTES < 128
-	CN("size-192"),
-#endif
-	CN("size-256"),
-	CN("size-512"),
-	CN("size-1024"),
-	CN("size-2048"),
-	CN("size-4096"),
-	CN("size-8192"),
-	CN("size-16384"),
-	CN("size-32768"),
-	CN("size-65536"),
-	CN("size-131072"),
-#ifndef CONFIG_MMU
-	CN("size-262144"),
-	CN("size-524288"),
-	CN("size-1048576"),
-#ifdef CONFIG_LARGE_ALLOCS
-	CN("size-2097152"),
-	CN("size-4194304"),
-	CN("size-8388608"),
-	CN("size-16777216"),
-	CN("size-33554432"),
-#endif /* CONFIG_LARGE_ALLOCS */
-#endif /* CONFIG_MMU */
+#define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
 }; 
-#undef CN
 
 struct arraycache_init initarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 struct arraycache_init initarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
@@ -660,39 +595,39 @@
  */
 void __init kmem_cache_sizes_init(void)
 {
-	struct cache_sizes *sizes = malloc_sizes;
+	int i;
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
 	 */
 	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
 		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
-	do {
+
+	for (i = 0; i < ARRAY_SIZE(malloc_sizes); i++) {
+		struct cache_sizes *sizes = malloc_sizes + i;
 		/* For performance, all the general caches are L1 aligned.
 		 * This should be particularly beneficial on SMP boxes, as it
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
-		if (!(sizes->cs_cachep =
-			kmem_cache_create(cache_names[sizes-malloc_sizes].name, 
-					  sizes->cs_size,
-					0, SLAB_HWCACHE_ALIGN, NULL, NULL))) {
+		sizes->cs_cachep = kmem_cache_create(
+			cache_names[i].name, sizes->cs_size,
+			0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+		if (!sizes->cs_cachep)
 			BUG();
-		}
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
 			offslab_limit = sizes->cs_size-sizeof(struct slab);
 			offslab_limit /= sizeof(kmem_bufctl_t);
 		}
+
 		sizes->cs_dmacachep = kmem_cache_create(
-		    cache_names[sizes-malloc_sizes].name_dma, 
-			sizes->cs_size, 0,
-			SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
+			cache_names[i].name_dma, sizes->cs_size,
+			0, SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
-		sizes++;
-	} while (sizes->cs_size);
+	}
 	/*
 	 * The generic caches are running - time to kick out the
 	 * bootstrap cpucaches.

--------------080607030506020303050804--

