Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWC3QlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWC3QlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWC3QlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:41:22 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:62426 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932242AbWC3QlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:41:21 -0500
Date: Thu, 30 Mar 2006 09:41:20 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ioremap_cached()
Message-ID: <20060330164120.GJ13590@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We currently have three ways for getting access to device memory --
ioremap(), ioremap_nocache() and pci_iomap().  99% of the callers of
ioremap() are doing it to access device registers, and really, really
want to use ioremap_nocache() instead.  I presume nobody notices on PCs
because they have write-through caches, but it ought to trip up people
trying to flush writes.

pci_iomap() gets this right -- it calls ioremap() if the resource is
tagged with IORESOURCE_CACHEABLE and ioremap_nocache() if it isn't.
Unfortunately, the only resources tagged with IORESOURCE_CACHEABLE
are PCI ROM resources, so even frame buffers and similar that could be
cached aren't.

It seems clear to me that ioremap() and ioremap_nocache() are the
wrong way around.  The default needs to be uncached -- and the obvious
(rare) alternative becomes ioremap_cached().

So here's a patch for i386 to add ioremap_cached() and make ioremap()
uncached.  ioremap_nocache() remains as an alias for ioremap() so we
don't needlessly break old drivers.  Architecture maintainers will need
to fix up their ports if this patch is accepted.


Index: include/asm-i386/io.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/io.h,v
retrieving revision 1.10
diff -u -p -r1.10 io.h
--- a/include/asm-i386/io.h	17 Jan 2006 14:52:36 -0000	1.10
+++ b/include/asm-i386/io.h	30 Mar 2006 16:39:22 -0000
@@ -115,12 +115,13 @@ extern void __iomem * __ioremap(unsigned
  * address. 
  */
 
-static inline void __iomem * ioremap(unsigned long offset, unsigned long size)
+static inline void __iomem * ioremap_cached(unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
 
-extern void __iomem * ioremap_nocache(unsigned long offset, unsigned long size);
+#define ioremap_nocache(a, b) ioremap(a, b)
+extern void __iomem * ioremap(unsigned long offset, unsigned long size);
 extern void iounmap(volatile void __iomem *addr);
 
 /*
Index: arch/i386/mm/ioremap.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/mm/ioremap.c,v
retrieving revision 1.13
diff -u -p -r1.13 ioremap.c
--- a/arch/i386/mm/ioremap.c	19 Dec 2005 12:42:12 -0000	1.13
+++ b/arch/i386/mm/ioremap.c	30 Mar 2006 16:39:22 -0000
@@ -167,11 +167,11 @@ void __iomem * __ioremap(unsigned long p
 EXPORT_SYMBOL(__ioremap);
 
 /**
- * ioremap_nocache     -   map bus memory into CPU space
+ * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
  * @size:      size of the resource to map
  *
- * ioremap_nocache performs a platform specific sequence of operations to
+ * ioremap performs a platform specific sequence of operations to
  * make bus memory CPU accessible via the readb/readw/readl/writeb/
  * writew/writel functions and the other mmio helpers. The returned
  * address is not guaranteed to be usable directly as a virtual
@@ -188,7 +188,7 @@ EXPORT_SYMBOL(__ioremap);
  * Must be freed with iounmap.
  */
 
-void __iomem *ioremap_nocache (unsigned long phys_addr, unsigned long size)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	unsigned long last_addr;
 	void __iomem *p = __ioremap(phys_addr, size, _PAGE_PCD);
@@ -221,7 +221,7 @@ void __iomem *ioremap_nocache (unsigned 
 
 	return p;					
 }
-EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(ioremap);
 
 /**
  * iounmap - Free a IO remapping
