Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUIGQpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUIGQpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUIGOi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:38:26 -0400
Received: from verein.lst.de ([213.95.11.210]:30617 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268130AbUIGOgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:36:39 -0400
Date: Tue, 7 Sep 2004 16:36:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make kmem_find_general_cachep static in slab.c
Message-ID: <20040907143632.GA8480@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	manfred@colorfullife.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.35/include/linux/slab.h	2004-09-03 11:08:25 +02:00
+++ edited/include/linux/slab.h	2004-09-07 14:47:58 +02:00
@@ -55,7 +55,6 @@
 /* prototypes */
 extern void kmem_cache_init(void);
 
-extern kmem_cache_t *kmem_find_general_cachep(size_t, int gfpflags);
 extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
 				       void (*)(void *, kmem_cache_t *, unsigned long),
 				       void (*)(void *, kmem_cache_t *, unsigned long));
--- 1.146/mm/slab.c	2004-09-03 11:08:25 +02:00
+++ edited/mm/slab.c	2004-09-07 14:48:33 +02:00
@@ -562,6 +562,22 @@
 	return cachep->array[smp_processor_id()];
 }
 
+static kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
+{
+	struct cache_sizes *csizep = malloc_sizes;
+
+	/* This function could be moved to the header file, and
+	 * made inline so consumers can quickly determine what
+	 * cache pointer they require.
+	 */
+	for ( ; csizep->cs_size; csizep++) {
+		if (size > csizep->cs_size)
+			continue;
+		break;
+	}
+	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
+}
+
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void cache_estimate (unsigned long gfporder, size_t size, size_t align,
 		 int flags, size_t *left_over, unsigned int *num)
@@ -2554,24 +2570,6 @@
 }
 
 EXPORT_SYMBOL(kmem_cache_size);
-
-kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
-{
-	struct cache_sizes *csizep = malloc_sizes;
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
-}
-
-EXPORT_SYMBOL(kmem_find_general_cachep);
 
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
