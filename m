Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSG2V4P>; Mon, 29 Jul 2002 17:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318114AbSG2V4P>; Mon, 29 Jul 2002 17:56:15 -0400
Received: from verein.lst.de ([212.34.181.86]:31251 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318113AbSG2V4N>;
	Mon, 29 Jul 2002 17:56:13 -0400
Date: Mon, 29 Jul 2002 23:59:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] implement kmem_cache_size()
Message-ID: <20020729235932.A6889@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no way to find out the effective object size of a slab
cache.  XFS has lots of IRIX-derived code that want to do zalloc() style
allocations on zones (which are implemented as slab caches in XFS/Linux)
and thus needs to know about it.  There are three ways do implement it:

a) implement kmem_cache_zalloc
b) make the xfs zone a struct of kmem_cache_t and a size variable
c) implement kmem_cache_size

The current XFS tree does a) but I absolutely don't like it as encourages
people to use kmem_cache_zalloc for new code instead of thinking about how
to utilize slab object reuse.  b) would be easy, but I guess kmem_cache_size
is usefull enough to get into the kernel.  Here's the patch:


--- a/include/linux/slab.h	Mon Jul 15 16:39:25 2002
+++ b/include/linux/slab.h	Mon Jul 15 16:39:25 2002
@@ -57,6 +57,7 @@
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
+extern unsigned int kmem_cache_size(kmem_cache_t *);
 
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
--- a/kernel/ksyms.c	Mon Jul 15 16:39:25 2002
+++ b/kernel/ksyms.c	Mon Jul 15 16:39:25 2002
@@ -105,6 +105,7 @@
 EXPORT_SYMBOL(kmem_cache_shrink);
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(kmem_cache_size);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
--- a/mm/slab.c	Mon Jul 15 16:39:25 2002
+++ b/mm/slab.c	Mon Jul 15 16:39:25 2002
@@ -1637,6 +1637,15 @@
 	local_irq_restore(flags);
 }
 
+unsigned int kmem_cache_size(kmem_cache_t *cachep)
+{
+#if DEBUG
+	if (cachep->flags & SLAB_RED_ZONE)
+		return (cachep->objsize - 2*BYTES_PER_WORD);
+#endif
+	return cachep->objsize;
+}
+
 kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
 {
 	cache_sizes_t *csizep = cache_sizes;
