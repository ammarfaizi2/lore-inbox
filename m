Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281684AbRKUJIw>; Wed, 21 Nov 2001 04:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281685AbRKUJIm>; Wed, 21 Nov 2001 04:08:42 -0500
Received: from sun.fadata.bg ([80.72.64.67]:34565 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S281684AbRKUJIb>;
	Wed, 21 Nov 2001 04:08:31 -0500
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab: avoid linear search in kmalloc? (GCC Guru wanted :)
In-Reply-To: <20011121024525.A18750@lina.inka.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20011121024525.A18750@lina.inka.de>
Date: 21 Nov 2001 11:14:55 +0200
Message-ID: <873d38wkmo.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bernd" == Bernd Eckenfels <ecki@lina.inka.de> writes:

Bernd> Hello,
Bernd> I noticed that kmalloc and kmem_find_general_cachep are doing a linear
Bernd> search in the cache_sizes array. Isnt it better to speed that up by doing a
Bernd> binary search or a b-tree if like the following patch?

Here is a patch using a gcc extension. gcc generates binary search for the case.  

Regards,
-velco

--- slab.c.orig	Wed Sep 19 00:16:26 2001
+++ slab.c	Wed Nov 21 11:11:09 2001
@@ -1533,15 +1533,9 @@ void * kmem_cache_alloc (kmem_cache_t *c
  */
 void * kmalloc (size_t size, int flags)
 {
-	cache_sizes_t *csizep = cache_sizes;
-
-	for (; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
-			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
-	}
-	return NULL;
+	kmem_cache_t *cp = kmem_find_general_cachep (size, flags);
+	
+	return cp == NULL ? NULL : __kmem_cache_alloc(cp, flags);
 }
 
 /**
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
