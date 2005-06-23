Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVFWGSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVFWGSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFWGQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:16:52 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:4559 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262166AbVFWGLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:11:10 -0400
Date: Thu, 23 Jun 2005 16:10:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] consolidate get_order
Message-Id: <20050623161047.3408e604.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Someone mentioned that almost all the architectures used basically the
same implementation of get_order.  This patch consolidates them into
asm-generic/page.h and includes that in the appropriate places.  The
exceptions are ia64 and ppc which have their own (presumably optimised)
versions.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

This has been built on ppc64.  Please consider for inclusion.

---

 asm-alpha/page.h     |   16 ++--------------
 asm-arm/page.h       |   16 ++--------------
 asm-arm26/page.h     |   16 ++--------------
 asm-cris/page.h      |   15 ++-------------
 asm-frv/page.h       |   17 ++---------------
 asm-generic/page.h   |   26 ++++++++++++++++++++++++++
 asm-h8300/page.h     |   16 ++--------------
 asm-i386/page.h      |   16 ++--------------
 asm-m32r/page.h      |   21 ++-------------------
 asm-m68k/page.h      |   16 ++--------------
 asm-m68knommu/page.h |   16 ++--------------
 asm-mips/page.h      |   16 ++--------------
 asm-parisc/page.h    |   16 ++--------------
 asm-ppc64/page.h     |   17 +++--------------
 asm-s390/page.h      |   16 ++--------------
 asm-sh/page.h        |   20 ++------------------
 asm-sh64/page.h      |   20 ++------------------
 asm-sparc/page.h     |   16 ++--------------
 asm-sparc64/page.h   |   16 ++--------------
 asm-um/page.h        |   16 ++--------------
 asm-v850/page.h      |   21 ++-------------------
 asm-x86_64/page.h    |   16 ++--------------
 22 files changed, 69 insertions(+), 312 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/include/asm-alpha/page.h linus-get_order/include/asm-alpha/page.h
--- linus/include/asm-alpha/page.h	2005-05-20 09:05:17.000000000 +1000
+++ linus-get_order/include/asm-alpha/page.h	2005-06-23 15:36:51.000000000 +1000
@@ -63,20 +63,6 @@
 
 #endif /* STRICT_MM_TYPECHECKS */
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #ifdef USE_48_BIT_KSEG
 #define PAGE_OFFSET		0xffff800000000000UL
 #else
@@ -112,4 +98,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _ALPHA_PAGE_H */
diff -ruN linus/include/asm-arm/page.h linus-get_order/include/asm-arm/page.h
--- linus/include/asm-arm/page.h	2005-05-20 09:05:26.000000000 +1000
+++ linus-get_order/include/asm-arm/page.h	2005-06-23 15:37:15.000000000 +1000
@@ -163,20 +163,6 @@
 /* the upper-most page table pointer */
 extern pmd_t *top_pmd;
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
@@ -186,4 +172,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif
diff -ruN linus/include/asm-arm26/page.h linus-get_order/include/asm-arm26/page.h
--- linus/include/asm-arm26/page.h	2005-05-20 09:05:28.000000000 +1000
+++ linus-get_order/include/asm-arm26/page.h	2005-06-23 15:37:27.000000000 +1000
@@ -89,20 +89,6 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
@@ -112,4 +98,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif
diff -ruN linus/include/asm-cris/page.h linus-get_order/include/asm-cris/page.h
--- linus/include/asm-cris/page.h	2005-05-20 09:05:30.000000000 +1000
+++ linus-get_order/include/asm-cris/page.h	2005-06-23 15:43:53.000000000 +1000
@@ -77,19 +77,6 @@
   printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 } while (0)
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
 #endif /* __ASSEMBLY__ */
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
@@ -97,5 +84,7 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _CRIS_PAGE_H */
 
diff -ruN linus/include/asm-frv/page.h linus-get_order/include/asm-frv/page.h
--- linus/include/asm-frv/page.h	2005-05-20 09:05:31.000000000 +1000
+++ linus-get_order/include/asm-frv/page.h	2005-06-23 15:40:53.000000000 +1000
@@ -45,21 +45,6 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size) __attribute_const__;
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size - 1) >> (PAGE_SHIFT - 1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #define devmem_is_allowed(pfn)	1
 
 #define __pa(vaddr)		virt_to_phys((void *) vaddr)
@@ -102,4 +87,6 @@
 #define WANT_PAGE_VIRTUAL	1
 #endif
 
+#include <asm-generic/page.h>
+
 #endif /* _ASM_PAGE_H */
diff -ruN linus/include/asm-generic/page.h linus-get_order/include/asm-generic/page.h
--- linus/include/asm-generic/page.h	1970-01-01 10:00:00.000000000 +1000
+++ linus-get_order/include/asm-generic/page.h	2005-06-23 15:31:36.000000000 +1000
@@ -0,0 +1,26 @@
+#ifndef _ASM_GENERIC_PAGE_H
+#define _ASM_GENERIC_PAGE_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+
+/* Pure 2^n version of get_order */
+static __inline__ __attribute_const__ int get_order(unsigned long size)
+{
+	int order;
+
+	size = (size - 1) >> (PAGE_SHIFT - 1);
+	order = -1;
+	do {
+		size >>= 1;
+		order++;
+	} while (size);
+	return order;
+}
+
+#endif	/* __ASSEMBLY__ */
+#endif	/* __KERNEL__ */
+
+#endif	/* _ASM_GENERIC_PAGE_H */
diff -ruN linus/include/asm-h8300/page.h linus-get_order/include/asm-h8300/page.h
--- linus/include/asm-h8300/page.h	2005-05-20 09:05:33.000000000 +1000
+++ linus-get_order/include/asm-h8300/page.h	2005-06-23 15:38:03.000000000 +1000
@@ -54,20 +54,6 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
@@ -101,4 +87,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _H8300_PAGE_H */
diff -ruN linus/include/asm-i386/page.h linus-get_order/include/asm-i386/page.h
--- linus/include/asm-i386/page.h	2005-06-22 13:10:23.000000000 +1000
+++ linus-get_order/include/asm-i386/page.h	2005-06-23 15:38:12.000000000 +1000
@@ -104,20 +104,6 @@
  */
 extern unsigned int __VMALLOC_RESERVE;
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 extern int sysctl_legacy_va_layout;
 
 #endif /* __ASSEMBLY__ */
@@ -151,4 +137,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _I386_PAGE_H */
diff -ruN linus/include/asm-m32r/page.h linus-get_order/include/asm-m32r/page.h
--- linus/include/asm-m32r/page.h	2005-05-20 09:05:40.000000000 +1000
+++ linus-get_order/include/asm-m32r/page.h	2005-06-23 15:40:41.000000000 +1000
@@ -61,25 +61,6 @@
 
 /* This handles the memory map.. */
 
-#ifndef __ASSEMBLY__
-
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size - 1) >> (PAGE_SHIFT - 1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-
-	return order;
-}
-
-#endif /* __ASSEMBLY__ */
-
 #define __MEMORY_START  CONFIG_MEMORY_START
 #define __MEMORY_SIZE   CONFIG_MEMORY_SIZE
 
@@ -111,5 +92,7 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _ASM_M32R_PAGE_H */
 
diff -ruN linus/include/asm-m68k/page.h linus-get_order/include/asm-m68k/page.h
--- linus/include/asm-m68k/page.h	2005-05-20 09:05:42.000000000 +1000
+++ linus-get_order/include/asm-m68k/page.h	2005-06-23 15:38:23.000000000 +1000
@@ -107,20 +107,6 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/page_offset.h>
@@ -192,4 +178,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _M68K_PAGE_H */
diff -ruN linus/include/asm-m68knommu/page.h linus-get_order/include/asm-m68knommu/page.h
--- linus/include/asm-m68knommu/page.h	2005-05-20 09:05:45.000000000 +1000
+++ linus-get_order/include/asm-m68knommu/page.h	2005-06-23 15:38:33.000000000 +1000
@@ -48,20 +48,6 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
@@ -92,4 +78,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _M68KNOMMU_PAGE_H */
diff -ruN linus/include/asm-mips/page.h linus-get_order/include/asm-mips/page.h
--- linus/include/asm-mips/page.h	2005-05-20 09:05:48.000000000 +1000
+++ linus-get_order/include/asm-mips/page.h	2005-06-23 15:38:51.000000000 +1000
@@ -103,20 +103,6 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
@@ -148,4 +134,6 @@
 #define WANT_PAGE_VIRTUAL
 #endif
 
+#include <asm-generic/page.h>
+
 #endif /* _ASM_PAGE_H */
diff -ruN linus/include/asm-parisc/page.h linus-get_order/include/asm-parisc/page.h
--- linus/include/asm-parisc/page.h	2005-05-20 09:05:51.000000000 +1000
+++ linus-get_order/include/asm-parisc/page.h	2005-06-23 15:39:00.000000000 +1000
@@ -74,20 +74,6 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 typedef struct __physmem_range {
 	unsigned long start_pfn;
 	unsigned long pages;       /* PAGE_SIZE pages */
@@ -159,4 +145,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _PARISC_PAGE_H */
diff -ruN linus/include/asm-ppc64/page.h linus-get_order/include/asm-ppc64/page.h
--- linus/include/asm-ppc64/page.h	2005-06-22 13:10:23.000000000 +1000
+++ linus-get_order/include/asm-ppc64/page.h	2005-06-23 15:39:11.000000000 +1000
@@ -160,20 +160,6 @@
 
 #endif
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
 
 extern int page_is_ram(unsigned long pfn);
@@ -260,4 +246,7 @@
 	 VM_STACK_DEFAULT_FLAGS32 : VM_STACK_DEFAULT_FLAGS64)
 
 #endif /* __KERNEL__ */
+
+#include <asm-generic/page.h>
+
 #endif /* _PPC64_PAGE_H */
diff -ruN linus/include/asm-s390/page.h linus-get_order/include/asm-s390/page.h
--- linus/include/asm-s390/page.h	2005-05-20 09:05:57.000000000 +1000
+++ linus-get_order/include/asm-s390/page.h	2005-06-23 15:39:21.000000000 +1000
@@ -111,20 +111,6 @@
 #define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-        int order;
-
-        size = (size-1) >> (PAGE_SHIFT-1);
-        order = -1;
-        do {
-                size >>= 1;
-                order++;
-        } while (size);
-        return order;
-}
-
 /*
  * These are used to make use of C type-checking..
  */
@@ -207,4 +193,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _S390_PAGE_H */
diff -ruN linus/include/asm-sh/page.h linus-get_order/include/asm-sh/page.h
--- linus/include/asm-sh/page.h	2005-06-22 13:10:23.000000000 +1000
+++ linus-get_order/include/asm-sh/page.h	2005-06-23 15:39:30.000000000 +1000
@@ -122,24 +122,8 @@
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#ifndef __ASSEMBLY__
-
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
-#endif
-
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* __ASM_SH_PAGE_H */
diff -ruN linus/include/asm-sh64/page.h linus-get_order/include/asm-sh64/page.h
--- linus/include/asm-sh64/page.h	2005-06-22 13:10:23.000000000 +1000
+++ linus-get_order/include/asm-sh64/page.h	2005-06-23 15:40:26.000000000 +1000
@@ -115,24 +115,8 @@
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#ifndef __ASSEMBLY__
-
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
-#endif
-
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* __ASM_SH64_PAGE_H */
diff -ruN linus/include/asm-sparc/page.h linus-get_order/include/asm-sparc/page.h
--- linus/include/asm-sparc/page.h	2005-05-20 09:06:03.000000000 +1000
+++ linus-get_order/include/asm-sparc/page.h	2005-06-23 15:45:36.000000000 +1000
@@ -132,20 +132,6 @@
 
 #define TASK_UNMAPPED_BASE	BTFIXUP_SETHI(sparc_unmapped_base)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #else /* !(__ASSEMBLY__) */
 
 #define __pgprot(x)	(x)
@@ -178,4 +164,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _SPARC_PAGE_H */
diff -ruN linus/include/asm-sparc64/page.h linus-get_order/include/asm-sparc64/page.h
--- linus/include/asm-sparc64/page.h	2005-06-22 13:10:23.000000000 +1000
+++ linus-get_order/include/asm-sparc64/page.h	2005-06-23 15:39:49.000000000 +1000
@@ -150,20 +150,6 @@
 
 extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #endif /* !(__ASSEMBLY__) */
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
@@ -171,4 +157,6 @@
 
 #endif /* !(__KERNEL__) */
 
+#include <asm-generic/page.h>
+
 #endif /* !(_SPARC64_PAGE_H) */
diff -ruN linus/include/asm-um/page.h linus-get_order/include/asm-um/page.h
--- linus/include/asm-um/page.h	2005-05-30 11:19:07.000000000 +1000
+++ linus-get_order/include/asm-um/page.h	2005-06-23 15:39:57.000000000 +1000
@@ -116,24 +116,12 @@
 #define pfn_valid(pfn) ((pfn) < max_mapnr)
 #define virt_addr_valid(v) pfn_valid(phys_to_pfn(__pa(v)))
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 extern struct page *arch_validate(struct page *page, int mask, int order);
 #define HAVE_ARCH_VALIDATE
 
 extern void arch_free_page(struct page *page, int order);
 #define HAVE_ARCH_FREE_PAGE
 
+#include <asm-generic/page.h>
+
 #endif
diff -ruN linus/include/asm-v850/page.h linus-get_order/include/asm-v850/page.h
--- linus/include/asm-v850/page.h	2005-05-20 09:06:08.000000000 +1000
+++ linus-get_order/include/asm-v850/page.h	2005-06-23 15:40:08.000000000 +1000
@@ -98,25 +98,6 @@
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
 
-#ifndef __ASSEMBLY__
-
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order (unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
-#endif /* !__ASSEMBLY__ */
-
-
 /* No current v850 processor has virtual memory.  */
 #define __virt_to_phys(addr)	(addr)
 #define __phys_to_virt(addr)	(addr)
@@ -143,4 +124,6 @@
 
 #endif /* KERNEL */
 
+#include <asm-generic/page.h>
+
 #endif /* __V850_PAGE_H__ */
diff -ruN linus/include/asm-x86_64/page.h linus-get_order/include/asm-x86_64/page.h
--- linus/include/asm-x86_64/page.h	2005-06-22 13:10:23.000000000 +1000
+++ linus-get_order/include/asm-x86_64/page.h	2005-06-23 15:40:17.000000000 +1000
@@ -90,20 +90,6 @@
 
 #include <asm/bug.h>
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #endif /* __ASSEMBLY__ */
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
@@ -137,4 +123,6 @@
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/page.h>
+
 #endif /* _X86_64_PAGE_H */
