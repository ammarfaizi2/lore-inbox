Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSG0NiT>; Sat, 27 Jul 2002 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318753AbSG0NiS>; Sat, 27 Jul 2002 09:38:18 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:49129 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318752AbSG0NiO>; Sat, 27 Jul 2002 09:38:14 -0400
Subject: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 27 Jul 2002 14:41:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17YRp5-0006H6-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch introduces 64-bit versions of PAGE_{CACHE_,}MASK and
PAGE_{CACHE_,}ALIGN:
	PAGE_{CACHE_,}MASK_LL and PAGE_{CACHE_,}ALIGN_LL.

These are needed when 64-bit values are worked with on 32-bit
architectures, otherwise the high 32-bits are destroyed.

For example:

	my64bitval &= PAGE_CACHE_MASK;

is broken on 32-bit architectures... As is:

	my64bitval = PAGE_ALIGN(other64bitval);

Jes mentioned that on MIPS32 with HIGHMEM something like this is
also needed due to 64-bit physical addresses.

These are also needed by the XFS patch so they would want to
introduce these anyway. In fact I borrowed the _LL naming from XFS.

This patch together with the two follow up patches fixing bugs I
found can also be taken from bkbits.net:

	bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm

Comments?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 include/asm-alpha/page.h   |    2 ++
 include/asm-arm/page.h     |    2 ++
 include/asm-cris/page.h    |    2 ++
 include/asm-i386/page.h    |    2 ++
 include/asm-ia64/page.h    |    2 ++
 include/asm-m68k/page.h    |    2 ++
 include/asm-mips/page.h    |    2 ++
 include/asm-mips64/page.h  |    2 ++
 include/asm-parisc/page.h  |    2 ++
 include/asm-ppc/page.h     |    2 ++
 include/asm-ppc64/page.h   |    2 ++
 include/asm-s390/page.h    |    2 ++
 include/asm-s390x/page.h   |    2 ++
 include/asm-sh/page.h      |    2 ++
 include/asm-sparc/page.h   |    2 ++
 include/asm-sparc64/page.h |    2 ++
 include/asm-x86_64/page.h  |    2 ++
 include/linux/pagemap.h    |    3 +++
 18 files changed, 37 insertions(+)

through these ChangeSets:

<aia21@cantab.net> (02/07/27 1.477)
   Introduce 64-bit versions of PAGE_{CACHE_,}MASK and PAGE_{CACHE_,}ALIGN:
          PAGE_{CACHE_,}MASK_LL and PAGE_{CACHE_,}ALIGN_LL.
   
   These are needed when 64-bit values are worked with on 32-bit
   architectures, otherwise the high 32-bits are destroyed.
   
   Jes tells me, on MIPS32 with HIGHMEM these are also needed due to
   64-bit physical addresses.
   
   These are also needed by the XFS patch so they would want to
   introduce these anyway. In fact I borrowed the _LL naming from XFS.


diff -Nru a/include/asm-alpha/page.h b/include/asm-alpha/page.h
--- a/include/asm-alpha/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-alpha/page.h	Sat Jul 27 14:20:05 2002
@@ -7,6 +7,7 @@
 #define PAGE_SHIFT	13
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 
@@ -85,6 +86,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 #ifdef USE_48_BIT_KSEG
 #define PAGE_OFFSET		0xffff800000000000
diff -Nru a/include/asm-arm/page.h b/include/asm-arm/page.h
--- a/include/asm-arm/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-arm/page.h	Sat Jul 27 14:20:05 2002
@@ -89,9 +89,11 @@
 
 #define PAGE_SIZE		(1UL << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL		(~(u64)(PAGE_SIZE-1))
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff -Nru a/include/asm-cris/page.h b/include/asm-cris/page.h
--- a/include/asm-cris/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-cris/page.h	Sat Jul 27 14:20:05 2002
@@ -8,6 +8,7 @@
 #define PAGE_SHIFT	13
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 
@@ -61,6 +62,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /* This handles the memory map.. */
 
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-i386/page.h	Sat Jul 27 14:20:05 2002
@@ -5,6 +5,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
 #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
@@ -67,6 +68,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /*
  * This handles the memory map.. We could make this a config
diff -Nru a/include/asm-ia64/page.h b/include/asm-ia64/page.h
--- a/include/asm-ia64/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-ia64/page.h	Sat Jul 27 14:20:05 2002
@@ -28,7 +28,9 @@
 
 #define PAGE_SIZE		(__IA64_UL_CONST(1) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE - 1))
+#define PAGE_MASK_LL		(~(u64)(PAGE_SIZE - 1))
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK_LL)
 
 #ifdef __ASSEMBLY__
 # define __pa(x)		((x) - PAGE_OFFSET)
diff -Nru a/include/asm-m68k/page.h b/include/asm-m68k/page.h
--- a/include/asm-m68k/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-m68k/page.h	Sat Jul 27 14:20:05 2002
@@ -12,6 +12,7 @@
 #define PAGE_SIZE	(8192)
 #endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 
@@ -99,6 +100,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
diff -Nru a/include/asm-mips/page.h b/include/asm-mips/page.h
--- a/include/asm-mips/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-mips/page.h	Sat Jul 27 14:20:05 2002
@@ -15,6 +15,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 
@@ -67,6 +68,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /*
  * This handles the memory map.
diff -Nru a/include/asm-mips64/page.h b/include/asm-mips64/page.h
--- a/include/asm-mips64/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-mips64/page.h	Sat Jul 27 14:20:05 2002
@@ -15,6 +15,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 
@@ -53,6 +54,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /*
  * This handles the memory map.
diff -Nru a/include/asm-parisc/page.h b/include/asm-parisc/page.h
--- a/include/asm-parisc/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-parisc/page.h	Sat Jul 27 14:20:05 2002
@@ -5,6 +5,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -51,6 +52,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /*
  * Tell the user there is some problem. Beep too, so we can
diff -Nru a/include/asm-ppc/page.h b/include/asm-ppc/page.h
--- a/include/asm-ppc/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-ppc/page.h	Sat Jul 27 14:20:05 2002
@@ -8,6 +8,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 #include <linux/config.h>
@@ -84,6 +85,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 struct page;
 extern void clear_page(void *page);
diff -Nru a/include/asm-ppc64/page.h b/include/asm-ppc64/page.h
--- a/include/asm-ppc64/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-ppc64/page.h	Sat Jul 27 14:20:05 2002
@@ -16,6 +16,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 #define PAGE_OFFSET_MASK (PAGE_SIZE-1)
 
 #define SID_SHIFT       28
@@ -149,6 +150,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN_LL(addr)	_ALIGN(addr, (u64)PAGE_SIZE)
 
 #ifdef MODULE
 #define __page_aligned __attribute__((__aligned__(PAGE_SIZE)))
diff -Nru a/include/asm-s390/page.h b/include/asm-s390/page.h
--- a/include/asm-s390/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-s390/page.h	Sat Jul 27 14:20:05 2002
@@ -16,6 +16,7 @@
 #define PAGE_SHIFT      12
 #define PAGE_SIZE       (1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -112,6 +113,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)        (((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 #define __PAGE_OFFSET           0x0UL
 #define PAGE_OFFSET             0x0UL
diff -Nru a/include/asm-s390x/page.h b/include/asm-s390x/page.h
--- a/include/asm-s390x/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-s390x/page.h	Sat Jul 27 14:20:05 2002
@@ -15,6 +15,7 @@
 #define PAGE_SHIFT      12
 #define PAGE_SIZE       (1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -109,6 +110,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)        (((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 #define __PAGE_OFFSET           0x0UL
 #define PAGE_OFFSET             0x0UL
diff -Nru a/include/asm-sh/page.h b/include/asm-sh/page.h
--- a/include/asm-sh/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-sh/page.h	Sat Jul 27 14:20:05 2002
@@ -19,6 +19,7 @@
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 #define PTE_MASK	PAGE_MASK
 
 #ifdef __KERNEL__
@@ -59,6 +60,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /*
  * IF YOU CHANGE THIS, PLEASE ALSO CHANGE
diff -Nru a/include/asm-sparc/page.h b/include/asm-sparc/page.h
--- a/include/asm-sparc/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-sparc/page.h	Sat Jul 27 14:20:05 2002
@@ -21,6 +21,7 @@
 #define PAGE_SIZE    (1 << PAGE_SHIFT)
 #endif
 #define PAGE_MASK    (~(PAGE_SIZE-1))
+#define PAGE_MASK_LL (~(u64)(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
 
@@ -172,6 +173,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)  (((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 #define PAGE_OFFSET	0xf0000000
 #define __pa(x)                 ((unsigned long)(x) - PAGE_OFFSET)
diff -Nru a/include/asm-sparc64/page.h b/include/asm-sparc64/page.h
--- a/include/asm-sparc64/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-sparc64/page.h	Sat Jul 27 14:20:05 2002
@@ -12,6 +12,7 @@
 #endif
 
 #define PAGE_MASK    (~(PAGE_SIZE-1))
+#define PAGE_MASK_LL (~(u64)(PAGE_SIZE-1))
 
 
 #ifdef __KERNEL__
@@ -106,6 +107,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /* We used to stick this into a hard-coded global register (%g4)
  * but that does not make sense anymore.
diff -Nru a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
--- a/include/asm-x86_64/page.h	Sat Jul 27 14:20:05 2002
+++ b/include/asm-x86_64/page.h	Sat Jul 27 14:20:05 2002
@@ -9,6 +9,7 @@
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
+#define PAGE_MASK_LL	(~(u64)(PAGE_SIZE-1))
 #define PHYSICAL_PAGE_MASK	(~(PAGE_SIZE-1) & (__PHYSICAL_MASK << PAGE_SHIFT))
 #define THREAD_SIZE (2*PAGE_SIZE)
 #define CURRENT_MASK (~(THREAD_SIZE-1))
@@ -49,6 +50,7 @@
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+#define PAGE_ALIGN_LL(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK_LL)
 
 /* See Documentation/x86_64/mm.txt for a description of the layout. */
 #define __START_KERNEL		0xffffffff80100000
diff -Nru a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	Sat Jul 27 14:20:05 2002
+++ b/include/linux/pagemap.h	Sat Jul 27 14:20:05 2002
@@ -20,7 +20,10 @@
 #define PAGE_CACHE_SHIFT	PAGE_SHIFT
 #define PAGE_CACHE_SIZE		PAGE_SIZE
 #define PAGE_CACHE_MASK		PAGE_MASK
+#define PAGE_CACHE_MASK_LL	PAGE_MASK_LL
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
+#define PAGE_CACHE_ALIGN_LL(addr)	\
+				(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK_LL)
 
 #define page_cache_get(x)	get_page(x)
 extern void FASTCALL(page_cache_release(struct page *));

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020727131954|59561
## Wrapped with gzip_uu ##


begin 664 bkpatch21816
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
*_!<6L\'C1SH`````
`
end
