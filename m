Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbULLKs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbULLKs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 05:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbULLKs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 05:48:27 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:40904 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262063AbULLKsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 05:48:12 -0500
Message-ID: <41BC21E2.6000600@colorfullife.com>
Date: Sun, 12 Dec 2004 11:48:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@Linux-SH.ORG>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
References: <41B37E06.3030702@colorfullife.com> <20041205222001.GB25689@linux-sh.org> <41B4D9F8.6000309@colorfullife.com> <20041206225934.GA30317@linux-sh.org>
In-Reply-To: <20041206225934.GA30317@linux-sh.org>
Content-Type: multipart/mixed;
 boundary="------------010203040206080703040805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203040206080703040805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

Sorry for the late reply, attached is my proposal:
I've added the ARCH_SLAB_MINALIGN flag, together with some documentation 
and a small restructuring.
What do you think? It's just the mm/slab.c change, you would have to add

#ifndef CONFIG_DEBUG_SLAB
#define ARCH_SLAB_MINALIGN   8
#endif

into your sh64 header files. ARCH_SLAB_MINALIGN includes 
ARCH_KMALLOC_MINALIGN, so you do not have to set that flag. It doesn't 
hurt, though.

Not really tested - it boots on x86, but that probably doesn't count.

--
    Manfred

--------------010203040206080703040805
Content-Type: text/plain;
 name="patch-slab-forcealign"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-forcealign"

--- 2.6/mm/slab.c	2004-12-05 16:22:55.000000000 +0100
+++ build-2.6/mm/slab.c	2004-12-12 11:42:31.000000000 +0100
@@ -128,9 +128,28 @@
 #endif
 
 #ifndef ARCH_KMALLOC_MINALIGN
+/*
+ * Enforce a minimum alignment for the kmalloc caches.
+ * Usually, the kmalloc caches are cache_line_size() aligned, except when
+ * DEBUG and FORCED_DEBUG are enabled, then they are BYTES_PER_WORD aligned.
+ * Some archs want to perform DMA into kmalloc caches and need a guaranteed
+ * alignment larger than BYTES_PER_WORD. ARCH_KMALLOC_MINALIGN allows that.
+ * Note that this flag disables some debug features.
+ */
 #define ARCH_KMALLOC_MINALIGN 0
 #endif
 
+#ifndef ARCH_SLAB_MINALIGN
+/*
+ * Enforce a minimum alignment for all caches.
+ * Intended for archs that get misalignment faults even for BYTES_PER_WORD
+ * aligned buffers.
+ * If possible: Do not enable this flag for CONFIG_DEBUG_SLAB, it disables
+ * some debug features.
+ */
+#define ARCH_SLAB_MINALIGN 0
+#endif
+
 #ifndef ARCH_KMALLOC_FLAGS
 #define ARCH_KMALLOC_FLAGS SLAB_HWCACHE_ALIGN
 #endif
@@ -1172,7 +1191,7 @@
 	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
 	void (*dtor)(void*, kmem_cache_t *, unsigned long))
 {
-	size_t left_over, slab_size;
+	size_t left_over, slab_size, ralign;
 	kmem_cache_t *cachep = NULL;
 
 	/*
@@ -1222,24 +1241,44 @@
 	if (flags & ~CREATE_MASK)
 		BUG();
 
-	if (align) {
-		/* combinations of forced alignment and advanced debugging is
-		 * not yet implemented.
+	/* Check that size is in terms of words.  This is needed to avoid
+	 * unaligned accesses for some archs when redzoning is used, and makes
+	 * sure any on-slab bufctl's are also correctly aligned.
+	 */
+	if (size & (BYTES_PER_WORD-1)) {
+		size += (BYTES_PER_WORD-1);
+		size &= ~(BYTES_PER_WORD-1);
+	}
+	
+	/* calculate out the final buffer alignment: */
+	/* 1) arch recommendation: can be overridden for debug */
+	if (flags & SLAB_HWCACHE_ALIGN) {
+		/* Default alignment: as specified by the arch code.
+		 * Except if an object is really small, then squeeze multiple
+		 * objects into one cacheline.
 		 */
-		flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
+		ralign = cache_line_size();
+		while (size <= ralign/2)
+			ralign /= 2;
 	} else {
-		if (flags & SLAB_HWCACHE_ALIGN) {
-			/* Default alignment: as specified by the arch code.
-			 * Except if an object is really small, then squeeze multiple
-			 * into one cacheline.
-			 */
-			align = cache_line_size();
-			while (size <= align/2)
-				align /= 2;
-		} else {
-			align = BYTES_PER_WORD;
-		}
+		ralign = BYTES_PER_WORD;
+	}
+	/* 2) arch mandated alignment: disables debug if necessary */
+	if (ralign < ARCH_SLAB_MINALIGN) {
+		ralign = ARCH_SLAB_MINALIGN;
+		if (ralign > BYTES_PER_WORD)
+			flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
+	}
+	/* 3) caller mandated alignment: disables debug if necessary */
+	if (ralign < align) {
+		ralign = align;
+		if (ralign > BYTES_PER_WORD)
+			flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
 	}
+	/* 4) Store it. Note that the debug code below can reduce
+	 *    the alignment to BYTES_PER_WORD.
+	 */
+	align = ralign;
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
@@ -1247,15 +1286,6 @@
 		goto opps;
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
-	/* Check that size is in terms of words.  This is needed to avoid
-	 * unaligned accesses for some archs when redzoning is used, and makes
-	 * sure any on-slab bufctl's are also correctly aligned.
-	 */
-	if (size & (BYTES_PER_WORD-1)) {
-		size += (BYTES_PER_WORD-1);
-		size &= ~(BYTES_PER_WORD-1);
-	}
-	
 #if DEBUG
 	cachep->reallen = size;
 

--------------010203040206080703040805--
