Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283223AbRLDSwo>; Tue, 4 Dec 2001 13:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283163AbRLDSvO>; Tue, 4 Dec 2001 13:51:14 -0500
Received: from host62-7-27-19.btinternet.com ([62.7.27.19]:19974 "EHLO
	Wasteland") by vger.kernel.org with ESMTP id <S283273AbRLDSuU>;
	Tue, 4 Dec 2001 13:50:20 -0500
Message-Id: <m16BKdv-000CgdC@Wasteland>
Content-Type: text/plain; charset=US-ASCII
From: Matthew M <matthew.macleod@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kmem_find_general_cachep to static inline
Date: Tue, 4 Dec 2001 18:49:48 +0000
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com
X-Operating-System: Debian Linux 2.2 Kernel 2.5
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Inlined patch against 2.5.1-pre5 moves kmem_find_general_cachep and the 
cache_sizes struct to slab.h and declares it static inline, prompted by a 
comment in the source. Compiles and runs fine here.

First patch, please explain what I did wrong :)

*MatthewM*

-- 
<Addi> Alter.net seems to have replaced one of its router with a zucchini.
--

--- ./include/linux/slab.h~	Mon Dec  3 20:23:27 2001
+++ ./include/linux/slab.h	Mon Dec  3 20:26:01 2001
@@ -45,6 +45,44 @@
 #define SLAB_CTOR_ATOMIC	0x002UL		/* tell constructor it can't sleep */
 #define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */

+/* Size description struct for general caches. */
+typedef struct cache_sizes {
+	size_t		 cs_size;
+	kmem_cache_t	*cs_cachep;
+	kmem_cache_t	*cs_dmacachep;
+} cache_sizes_t;
+
+static cache_sizes_t cache_sizes[] = {
+#if PAGE_SIZE == 4096
+	{    32,	NULL, NULL},
+#endif
+	{    64,	NULL, NULL},
+	{   128,	NULL, NULL},
+	{   256,	NULL, NULL},
+	{   512,	NULL, NULL},
+	{  1024,	NULL, NULL},
+	{  2048,	NULL, NULL},
+	{  4096,	NULL, NULL},
+	{  8192,	NULL, NULL},
+	{ 16384,	NULL, NULL},
+	{ 32768,	NULL, NULL},
+	{ 65536,	NULL, NULL},
+	{131072,	NULL, NULL},
+	{     0,	NULL, NULL}
+};
+
+static inline kmem_cache_t * kmem_find_general_cachep (size_t size, int 
gfpflags)
+{
+	cache_sizes_t *csizep = cache_sizes;
+
+	for ( ; csizep->cs_size; csizep++) {
+		if (size > csizep->cs_size)
+			continue;
+		break;
+	}
+	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
+}
+
 /* prototypes */
 extern void kmem_cache_init(void);
 extern void kmem_cache_sizes_init(void);
--- ./mm/slab.c~	Tue Dec  4 18:12:45 2001
+++ ./mm/slab.c	Tue Dec  4 18:12:50 2001
@@ -326,32 +326,6 @@
 #define	SET_PAGE_SLAB(pg,x)   ((pg)->list.prev = (struct list_head *)(x))
 #define	GET_PAGE_SLAB(pg)     ((slab_t *)(pg)->list.prev)
 
-/* Size description struct for general caches. */
-typedef struct cache_sizes {
-	size_t		 cs_size;
-	kmem_cache_t	*cs_cachep;
-	kmem_cache_t	*cs_dmacachep;
-} cache_sizes_t;
-
-static cache_sizes_t cache_sizes[] = {
-#if PAGE_SIZE == 4096
-	{    32,	NULL, NULL},
-#endif
-	{    64,	NULL, NULL},
-	{   128,	NULL, NULL},
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
-	{     0,	NULL, NULL}
-};
-
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
 	slabs_full:	LIST_HEAD_INIT(cache_cache.slabs_full),
@@ -1587,22 +1561,6 @@
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
-}
-
-kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
-{
-	cache_sizes_t *csizep = cache_sizes;
-
-	/* This function could be moved to the header file, and
-	 * made inline so consumers can quickly determine what
-	 * cache pointer they require.
-	 */
-	for ( ; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
-		break;
-	}
-	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
 }

 #ifdef CONFIG_SMP
