Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSFFShU>; Thu, 6 Jun 2002 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSFFSgV>; Thu, 6 Jun 2002 14:36:21 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:62123
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317047AbSFFSed>; Thu, 6 Jun 2002 14:34:33 -0400
Date: Thu, 6 Jun 2002 11:33:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move vmalloc wrappers out of include/linux/vmalloc.h
Message-ID: <20020606183359.GB14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the vmalloc wrappers from <linux/vmalloc.h> into mm/vmalloc.c.

Doing this will later allow us to remove <linux/mm.h> from <linux/vmalloc.h>,
along with some other #include fixups.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== include/linux/vmalloc.h 1.2 vs edited =====
--- 1.2/include/linux/vmalloc.h	Fri Feb  8 20:10:55 2002
+++ edited/include/linux/vmalloc.h	Thu Jun  6 09:54:55 2002
@@ -24,33 +24,13 @@
 extern void vmfree_area_pages(unsigned long address, unsigned long size);
 extern int vmalloc_area_pages(unsigned long address, unsigned long size,
                               int gfp_mask, pgprot_t prot);
-
-/*
- *	Allocate any pages
- */
- 
-static inline void * vmalloc (unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
-}
-
 /*
- *	Allocate ISA addressable pages for broke crap
+ * Various ways to allocate pages.
  */
 
-static inline void * vmalloc_dma (unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
-}
-
-/*
- *	vmalloc 32bit PA addressable pages - eg for PCI 32bit devices
- */
- 
-static inline void * vmalloc_32(unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
-}
+extern void * vmalloc(unsigned long size);
+extern void * vmalloc_dma(unsigned long size);
+extern void * vmalloc_32(unsigned long size);
 
 /*
  * vmlist_lock is a read-write spinlock that protects vmlist
===== mm/vmalloc.c 1.14 vs edited =====
--- 1.14/mm/vmalloc.c	Fri May  3 04:27:09 2002
+++ edited/mm/vmalloc.c	Thu Jun  6 09:50:13 2002
@@ -232,6 +232,33 @@
 	printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n", addr);
 }
 
+/*
+ *	Allocate any pages
+ */
+
+void * vmalloc (unsigned long size)
+{
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+}
+
+/*
+ *	Allocate ISA addressable pages for broke crap
+ */
+
+void * vmalloc_dma (unsigned long size)
+{
+	return __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
+}
+
+/*
+ *	vmalloc 32bit PA addressable pages - eg for PCI 32bit devices
+ */
+
+void * vmalloc_32(unsigned long size)
+{
+	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
+}
+
 void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	void * addr;
