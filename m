Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRLEG7J>; Wed, 5 Dec 2001 01:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRLEG67>; Wed, 5 Dec 2001 01:58:59 -0500
Received: from quechua.inka.de ([212.227.14.2]:24134 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S283001AbRLEG6o>;
	Wed, 5 Dec 2001 01:58:44 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmem_find_general_cachep to static inline
In-Reply-To: <m16BKdv-000CgdC@Wasteland>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E16BW0v-0005TG-00@calista.inka.de>
Date: Wed, 05 Dec 2001 07:58:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m16BKdv-000CgdC@Wasteland> you wrote:
> First patch, please explain what I did wrong :)

Nothing, but can be improved further.

One can use that function in kmalloc() and then optimize the function using
a binary search.

--- slab.c	2001/09/21 16:28:50	1.27
+++ slab.c	2001/12/05 07:51:58
@@ -1533,14 +1533,13 @@
  */
 void * kmalloc (size_t size, int flags)
 {
-	cache_sizes_t *csizep = cache_sizes;
+	kmem_cache_t *cp;
+	
+	cp = kmem_find_general_cachep(size, flags);
+	
+	if (cp)
+		return __kmem_cache_alloc(cp, flags);
 
-	for (; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
-			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
-	}
 	return NULL;
 }


the patch for having the binary search will look something like:

From: Momchil Velikov <velco@fadata.bg>

@@ -1589,18 +1583,66 @@ void kfree (const void *objp)
 
 kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
 {
-	cache_sizes_t *csizep = cache_sizes;
+	int idx;
 
-	/* This function could be moved to the header file, and
-	 * made inline so consumers can quickly determine what
-	 * cache pointer they require.
-	 */
-	for ( ; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
+	switch (size) {
+#if PAGE_SIZE == 4096
+	case 0 ... 32: 
+		idx = 0;
+		break;
+	case 33 ... 64:
+		idx = 1;
+		break;
+#else
+	case 0 ... 64:
+		idx = 1;
+		break;
+#endif
+	case 65 ... 128:
+		idx = 2;
+		break;
+	case 129 ... 256:
+		idx = 3;
+		break;
+	case 257 ...512:
+		idx = 4;
+		break;
+	case 513 ... 1024:
+		idx = 5;
+		break;
+	case 1025 ... 2048:
+		idx = 6;
+		break;
+	case 2049 ... 4096:
+		idx = 7;
+		break;
+	case 4097 ... 8192:
+		idx = 8;
+		break;
+	case 8193 ... 16384:
+		idx = 9;
+		break;
+	case 16385 ... 32768:
+		idx = 10;
+		break;
+	case 32769 ... 65536:
+		idx = 11;
+		break;
+	case 65537 ... 131072:
+		idx = 12;
+		break;
+	default:
+		idx = -1;
 		break;
 	}
-	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
+
+	if (idx == -1)
+		return NULL;
+
+#if PAGE_SIZE != 4096
+	idx = idx - 1;
+#endif
+	return (gfpflags & GFP_DMA) ? cache_sizes [idx].cs_dmacachep : cache_sizes [idx].cs_cachep;
 }
 
 #ifdef CONFIG_SMP


I have not tested yet if the "idx -1" is optimized good, or if it is better
to have assigend idx the values depending on the #define. But otherwise it
should work well.

Greetings
Bernd
