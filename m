Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281144AbRKUBqG>; Tue, 20 Nov 2001 20:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKUBpp>; Tue, 20 Nov 2001 20:45:45 -0500
Received: from quechua.inka.de ([212.227.14.2]:49220 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S281144AbRKUBp3>;
	Tue, 20 Nov 2001 20:45:29 -0500
Date: Wed, 21 Nov 2001 02:45:25 +0100
To: linux-kernel@vger.kernel.org
Subject: slab: avoid linear search in kmalloc? (GCC Guru wanted :)
Message-ID: <20011121024525.A18750@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed that kmalloc and kmem_find_general_cachep are doing a linear
search in the cache_sizes array. Isnt it better to speed that up by doing a
binary search or a b-tree if like the following patch?

I am no gcc expert, so it might not help... any body knows?

I also not sure if removing the elses does produce faster code?

Perhaps we can improve the situation even more by using some fast path
optimization by looking at the usage profile of that function?

btw: the kmem_find_general_cache most likely needs to be inline now... not
sure if my kmalloc rewrite in that case is to bloated, if cut+paste is
better, here.

--- mm/slab.c.org	Wed Nov 21 02:02:27 2001
+++ mm/slab.c	Wed Nov 21 02:35:38 2001
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
 
@@ -1604,20 +1603,67 @@
 	local_irq_restore(flags);
 }
 
-kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
-{
-	cache_sizes_t *csizep = cache_sizes;
+/* This function could be moved to the header file, and
+ * made inline so consumers can quickly determine what
+ * cache pointer they require.
+ */
+
+#if PAGE_SIZE == 4096
+#define CACHE_ENTRY(p, f) (f & GFP_DMA ? cache_sizes[p].cs_dmacachep : cache_sizes[p].cs_cachep)
+#else
+#define CACHE_ENTRY(p, f) (f & ? cache_sizes[p-1]. : cache_sizes[p-1].)
+#endif
 
-	/* This function could be moved to the header file, and
-	 * made inline so consumers can quickly determine what
-	 * cache pointer they require.
-	 */
-	for ( ; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
-		break;
+kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflag)
+{
+	if (size <= 512) {
+	  if (size <= 128) {
+#if PAGE_SIZE == 4096
+#endif
+	    if (size <= 64) {
+#if PAGE_SIZE == 4096
+	      if (size <= 32) {
+	         return CACHE_ENTRY(0, gfpflag); // 32
+	      }
+#endif
+	      return CACHE_ENTRY(1, gfpflag); // 64
+	    } else
+	      return CACHE_ENTRY(2, gfpflag); // 128
+	  } else { 
+	    if (size <= 256)
+	      return CACHE_ENTRY(3, gfpflag); // 256
+	    else
+	      return CACHE_ENTRY(4, gfpflag); // 512
+	  }
 	}
-	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
+	if (size <= 8192) {
+	  if (size <= 2048) {
+	    if (size <= 1024)
+	      return CACHE_ENTRY(5, gfpflag); // 1024
+	    else
+	      return CACHE_ENTRY(6, gfpflag); // 2048
+	  } else {
+	    if (size <= 4096)
+	      return CACHE_ENTRY(7, gfpflag); // 4096
+	    else
+	      return CACHE_ENTRY(8, gfpflag); // 8192
+	  }
+	}
+	if (size <= 131072) {
+	  if (size <= 32768) {
+	    if (size <= 16384)
+	      return CACHE_ENTRY(9, gfpflag); // 16384
+	    else
+	      return CACHE_ENTRY(10, gfpflag); // 32768
+	  } else {
+	    if (size <= 65536)
+	      return CACHE_ENTRY(11, gfpflag); // 65536
+	    else
+	      return CACHE_ENTRY(12, gfpflag); // 131072
+	  }
+	}
+  
+	return NULL;
 }
 
 #ifdef CONFIG_SMP

-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
