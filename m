Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSHXJ3T>; Sat, 24 Aug 2002 05:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHXJ3T>; Sat, 24 Aug 2002 05:29:19 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:20497 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315440AbSHXJ3S>; Sat, 24 Aug 2002 05:29:18 -0400
Date: Sat, 24 Aug 2002 11:33:04 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org
Subject: [patch] 2.4.20-pre4 sparc32 fixup
Message-ID: <20020824093304.GU14278@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 80 days, 1:31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch inlined below gets 2.4.20-pre4 to compile (and boot) on my
testmachine again. Trivial stuff mostly, dunno about the page_to_phys
macro, though -- DaveM, could you have a look at it?

Aurora people united please try booting this on your sparc32 oldtimers
if you find the time.

Tomas


diff -urN linux-2.4.20-pre4/include/asm-sparc/io.h linux-2.4.20-pre4-sparc32/include/asm-sparc/io.h
--- linux-2.4.20-pre4/include/asm-sparc/io.h	2001-11-23 14:25:29.000000000 +0100
+++ linux-2.4.20-pre4-sparc32/include/asm-sparc/io.h	2002-08-24 10:47:55.000000000 +0200
@@ -14,6 +14,9 @@
 #define virt_to_bus virt_to_phys
 #define bus_to_virt phys_to_virt
 
+extern unsigned long phys_base;
+#define page_to_phys(page)	((((page) - mem_map) << PAGE_SHIFT) + phys_base)
+
 static __inline__ u32 flip_dword (u32 d)
 {
 	return ((d&0xff)<<24) | (((d>>8)&0xff)<<16) | (((d>>16)&0xff)<<8)| ((d>>24)&0xff);
diff -urN linux-2.4.20-pre4/include/asm-sparc/pci.h linux-2.4.20-pre4-sparc32/include/asm-sparc/pci.h
--- linux-2.4.20-pre4/include/asm-sparc/pci.h	2002-02-26 14:10:15.000000000 +0100
+++ linux-2.4.20-pre4-sparc32/include/asm-sparc/pci.h	2002-08-24 10:48:38.000000000 +0200
@@ -27,6 +27,12 @@
 /* Dynamic DMA mapping stuff.
  */
 
+/* The PCI address space does not equal the physical memory
+ * address space.  The networking and block device layers use
+ * this boolean for bounce buffer decisions.
+ */
+#define PCI_DMA_BUS_IS_PHYS	(0)
+
 #include <asm/scatterlist.h>
 
 struct pci_dev;
diff -urN linux-2.4.20-pre4/include/asm-sparc/types.h linux-2.4.20-pre4-sparc32/include/asm-sparc/types.h
--- linux-2.4.20-pre4/include/asm-sparc/types.h	2000-02-01 08:37:19.000000000 +0100
+++ linux-2.4.20-pre4-sparc32/include/asm-sparc/types.h	2002-08-24 10:28:09.000000000 +0200
@@ -46,6 +46,7 @@
 #define BITS_PER_LONG 32
 
 typedef u32 dma_addr_t;
+typedef u64 dma64_addr_t;
 
 #endif /* __KERNEL__ */
 
diff -urN linux-2.4.20-pre4/include/asm-sparc64/io.h linux-2.4.20-pre4-sparc32/include/asm-sparc64/io.h
--- linux-2.4.20-pre4/include/asm-sparc64/io.h	2002-02-26 14:10:15.000000000 +0100
+++ linux-2.4.20-pre4-sparc32/include/asm-sparc64/io.h	2002-08-24 10:37:45.000000000 +0200
@@ -19,7 +19,7 @@
 #define bus_to_virt bus_to_virt_not_defined_use_pci_map
 
 extern unsigned long phys_base;
-#define page_to_phys(page)	((((page) - mem_map) << PAGE_SHIFT)+phys_base)
+#define page_to_phys(page)	((((page) - mem_map) << PAGE_SHIFT) + phys_base)
 
 /* Different PCI controllers we support have their PCI MEM space
  * mapped to an either 2GB (Psycho) or 4GB (Sabre) aligned area,
diff -urN linux-2.4.20-pre4/include/linux/blkdev.h linux-2.4.20-pre4-sparc32/include/linux/blkdev.h
--- linux-2.4.20-pre4/include/linux/blkdev.h	2002-08-24 10:55:21.000000000 +0200
+++ linux-2.4.20-pre4-sparc32/include/linux/blkdev.h	2002-08-24 10:48:08.000000000 +0200
@@ -6,6 +6,7 @@
 #include <linux/genhd.h>
 #include <linux/tqueue.h>
 #include <linux/list.h>
+#include <linux/mm.h>
 
 #include <asm/io.h>
 
