Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSKCRJ1>; Sun, 3 Nov 2002 12:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSKCRJ1>; Sun, 3 Nov 2002 12:09:27 -0500
Received: from verein.lst.de ([212.34.181.86]:54027 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262201AbSKCRJ0>;
	Sun, 3 Nov 2002 12:09:26 -0500
Date: Sun, 3 Nov 2002 18:15:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] implement ksize()
Message-ID: <20021103181555.A6977@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's used to find out the effective allocation size of objects allocated
by kmalloc().  This is needed by the uClinux ports in many places but
seems also usefull for mmu-using ports.


--- 1.13/include/linux/slab.h	Wed Sep 25 20:41:05 2002
+++ edited/include/linux/slab.h	Sun Nov  3 03:08:32 2002
@@ -60,6 +60,7 @@
 
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
+extern unsigned int ksize(const void *);
 
 extern int FASTCALL(kmem_cache_reap(int));
 
--- 1.156/kernel/ksyms.c	Thu Oct 31 10:28:34 2002
+++ edited/kernel/ksyms.c	Sun Nov  3 03:09:00 2002
@@ -104,6 +104,7 @@
 EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
+EXPORT_SYMBOL(ksize);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
 EXPORT_SYMBOL(vmalloc);
--- 1.46/mm/slab.c	Fri Nov  1 16:34:38 2002
+++ edited/mm/slab.c	Sun Nov  3 13:18:29 2002
@@ -1871,6 +1871,22 @@
 	return cachep->objsize;
 }
 
+unsigned int ksize(const void *objp)
+{
+	kmem_cache_t *c;
+	unsigned long flags;
+	unsigned int size = 0;
+
+	if (objp) {
+		local_irq_save(flags);
+		c = GET_PAGE_CACHE(virt_to_page(objp));
+		size = kmem_cache_size(c);
+		local_irq_restore(flags);
+	}
+
+	return size;
+}
+
 kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
