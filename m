Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSGZHLC>; Fri, 26 Jul 2002 03:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSGZHLC>; Fri, 26 Jul 2002 03:11:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:9689 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317221AbSGZHLB>;
	Fri, 26 Jul 2002 03:11:01 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] implement kmem_cache_size
Date: Fri, 26 Jul 2002 16:45:33 +1000
Message-Id: <20020726071520.361F44806@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Christoph Hellwig <hch@lst.de>

  Currently there is no way to find out the effective object size of a slab
  cache.  XFS has lots of IRIX-derived code that want to do zalloc() style
  allocations on zones (which are implemented as slab caches in XFS/Linux)
  and thus needs to know about it.  There are three ways do implement it:
  
  a) implement kmem_cache_zalloc
  b) make the xfs zone a struct of kmem_cache_t and a size variable
  c) implement kmem_cache_size
  
  The current XFS tree does a) but I absolutely don't like it as encourages
  people to use kmem_cache_zalloc for new code instead of thinking about
  how to utilize slab object reuse.  b) would be easy, but I guess
  kmem_cache_size is usefull enough to get into the kernel.
  
  Trivial patch to implement  kmem_cache_size (doesn't change any existing
  code) appended:
  
  

--- trivial-2.5.28/include/linux/slab.h.orig	Fri Jul 26 16:37:00 2002
+++ trivial-2.5.28/include/linux/slab.h	Fri Jul 26 16:37:00 2002
@@ -57,6 +57,7 @@
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
+extern unsigned int kmem_cache_size(kmem_cache_t *);
 
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
--- trivial-2.5.28/kernel/ksyms.c.orig	Fri Jul 26 16:37:00 2002
+++ trivial-2.5.28/kernel/ksyms.c	Fri Jul 26 16:37:00 2002
@@ -105,6 +105,7 @@
 EXPORT_SYMBOL(kmem_cache_shrink);
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(kmem_cache_size);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
--- trivial-2.5.28/mm/slab.c.orig	Fri Jul 26 16:37:00 2002
+++ trivial-2.5.28/mm/slab.c	Fri Jul 26 16:37:00 2002
@@ -1647,6 +1647,15 @@
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
-- 
  Don't blame me: the Monkey is driving
