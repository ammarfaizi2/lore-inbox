Return-Path: <linux-kernel-owner+w=401wt.eu-S932234AbWLLRPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWLLRPs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWLLRPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:15:22 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:34651 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbWLLRPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:15:08 -0500
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/4] Optimize D-cache alias handling on fork
Date: Tue, 12 Dec 2006 17:14:57 +0000
Message-Id: <11659437012606-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11659436971966-git-send-email-ralf@linux-mips.org>
References: <11659436971966-git-send-email-ralf@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Virtually index, physically tagged cache architectures can get away
without cache flushing when forking.  This patch adds a new cache
flushing function flush_cache_dup_mm(struct mm_struct *) which for the
moment I've implemented to do the same thing on all architectures
except on MIPS where it's a no-op.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 Documentation/cachetlb.txt          |   23 +++++++++++++++++------
 include/asm-alpha/cacheflush.h      |    1 +
 include/asm-arm/cacheflush.h        |    2 ++
 include/asm-arm26/cacheflush.h      |    1 +
 include/asm-avr32/cacheflush.h      |    1 +
 include/asm-cris/cacheflush.h       |    1 +
 include/asm-frv/cacheflush.h        |    1 +
 include/asm-h8300/cacheflush.h      |    1 +
 include/asm-i386/cacheflush.h       |    1 +
 include/asm-ia64/cacheflush.h       |    1 +
 include/asm-m32r/cacheflush.h       |    3 +++
 include/asm-m68k/cacheflush.h       |    2 ++
 include/asm-m68knommu/cacheflush.h  |    1 +
 include/asm-mips/cacheflush.h       |    2 ++
 include/asm-parisc/cacheflush.h     |    2 ++
 include/asm-powerpc/cacheflush.h    |    1 +
 include/asm-s390/cacheflush.h       |    1 +
 include/asm-sh/cpu-sh2/cacheflush.h |    2 ++
 include/asm-sh/cpu-sh3/cacheflush.h |    3 +++
 include/asm-sh/cpu-sh4/cacheflush.h |    1 +
 include/asm-sh64/cacheflush.h       |    2 ++
 include/asm-sparc/cacheflush.h      |    1 +
 include/asm-sparc64/cacheflush.h    |    1 +
 include/asm-v850/cacheflush.h       |    1 +
 include/asm-x86_64/cacheflush.h     |    1 +
 include/asm-xtensa/cacheflush.h     |    2 ++
 kernel/fork.c                       |    2 +-
 27 files changed, 54 insertions(+), 7 deletions(-)

Index: upstream-alias/include/asm-alpha/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-alpha/cacheflush.h
+++ upstream-alias/include/asm-alpha/cacheflush.h
@@ -6,6 +6,7 @@
 /* Caches aren't brain-dead on the Alpha. */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-arm/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-arm/cacheflush.h
+++ upstream-alias/include/asm-arm/cacheflush.h
@@ -319,6 +319,8 @@ extern void flush_ptrace_access(struct v
 				unsigned long len, int write);
 #endif
 
+#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
+
 /*
  * flush_cache_user_range is used when we want to ensure that the
  * Harvard caches are synchronised for the user space address range.
Index: upstream-alias/include/asm-arm26/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-arm26/cacheflush.h
+++ upstream-alias/include/asm-arm26/cacheflush.h
@@ -22,6 +22,7 @@
 
 #define flush_cache_all()                       do { } while (0)
 #define flush_cache_mm(mm)                      do { } while (0)
+#define flush_cache_dup_mm(mm)                  do { } while (0)
 #define flush_cache_range(vma,start,end)        do { } while (0)
 #define flush_cache_page(vma,vmaddr,pfn)        do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
Index: upstream-alias/include/asm-avr32/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-avr32/cacheflush.h
+++ upstream-alias/include/asm-avr32/cacheflush.h
@@ -87,6 +87,7 @@ void invalidate_icache_region(void *star
  */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
Index: upstream-alias/include/asm-cris/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-cris/cacheflush.h
+++ upstream-alias/include/asm-cris/cacheflush.h
@@ -9,6 +9,7 @@
  */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-frv/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-frv/cacheflush.h
+++ upstream-alias/include/asm-frv/cacheflush.h
@@ -20,6 +20,7 @@
  */
 #define flush_cache_all()			do {} while(0)
 #define flush_cache_mm(mm)			do {} while(0)
+#define flush_cache_dup_mm(mm)			do {} while(0)
 #define flush_cache_range(mm, start, end)	do {} while(0)
 #define flush_cache_page(vma, vmaddr, pfn)	do {} while(0)
 #define flush_cache_vmap(start, end)		do {} while(0)
Index: upstream-alias/include/asm-h8300/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-h8300/cacheflush.h
+++ upstream-alias/include/asm-h8300/cacheflush.h
@@ -12,6 +12,7 @@
 
 #define flush_cache_all()
 #define	flush_cache_mm(mm)
+#define	flush_cache_dup_mm(mm)		do { } while (0)
 #define	flush_cache_range(vma,a,b)
 #define	flush_cache_page(vma,p,pfn)
 #define	flush_dcache_page(page)
Index: upstream-alias/include/asm-i386/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-i386/cacheflush.h
+++ upstream-alias/include/asm-i386/cacheflush.h
@@ -7,6 +7,7 @@
 /* Caches aren't brain-dead on the intel. */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-ia64/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-ia64/cacheflush.h
+++ upstream-alias/include/asm-ia64/cacheflush.h
@@ -18,6 +18,7 @@
 
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_icache_page(vma,page)		do { } while (0)
Index: upstream-alias/include/asm-m32r/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-m32r/cacheflush.h
+++ upstream-alias/include/asm-m32r/cacheflush.h
@@ -9,6 +9,7 @@ extern void _flush_cache_copyback_all(vo
 #if defined(CONFIG_CHIP_M32700) || defined(CONFIG_CHIP_OPSP) || defined(CONFIG_CHIP_M32104)
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
@@ -29,6 +30,7 @@ extern void smp_flush_cache_all(void);
 #elif defined(CONFIG_CHIP_M32102)
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
@@ -41,6 +43,7 @@ extern void smp_flush_cache_all(void);
 #else
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-m68k/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-m68k/cacheflush.h
+++ upstream-alias/include/asm-m68k/cacheflush.h
@@ -89,6 +89,8 @@ static inline void flush_cache_mm(struct
 		__flush_cache_030();
 }
 
+#define flush_cache_dup_mm(mm)			flush_cache_mm(mm)
+
 /* flush_cache_range/flush_cache_page must be macros to avoid
    a dependency on linux/mm.h, which includes this file... */
 static inline void flush_cache_range(struct vm_area_struct *vma,
Index: upstream-alias/include/asm-m68knommu/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-m68knommu/cacheflush.h
+++ upstream-alias/include/asm-m68knommu/cacheflush.h
@@ -8,6 +8,7 @@
 
 #define flush_cache_all()			__flush_cache_all()
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	__flush_cache_all()
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_range(start,len)		__flush_cache_all()
Index: upstream-alias/include/asm-mips/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-mips/cacheflush.h
+++ upstream-alias/include/asm-mips/cacheflush.h
@@ -17,6 +17,7 @@
  *
  *  - flush_cache_all() flushes entire cache
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
+ *  - flush_cache_dup mm(mm) handles cache flushing when forking
  *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *  - flush_icache_range(start, end) flush a range of instructions
@@ -31,6 +32,7 @@
 extern void (*flush_cache_all)(void);
 extern void (*__flush_cache_all)(void);
 extern void (*flush_cache_mm)(struct mm_struct *mm);
+#define flush_cache_dup_mm(mm)	do { (void) (mm); } while (0)
 extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
Index: upstream-alias/include/asm-parisc/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-parisc/cacheflush.h
+++ upstream-alias/include/asm-parisc/cacheflush.h
@@ -15,6 +15,8 @@
 #define flush_cache_mm(mm) flush_cache_all_local()
 #endif
 
+#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
+
 #define flush_kernel_dcache_range(start,size) \
 	flush_kernel_dcache_range_asm((start), (start)+(size));
 
Index: upstream-alias/include/asm-powerpc/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-powerpc/cacheflush.h
+++ upstream-alias/include/asm-powerpc/cacheflush.h
@@ -18,6 +18,7 @@
  */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_icache_page(vma, page)		do { } while (0)
Index: upstream-alias/include/asm-s390/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-s390/cacheflush.h
+++ upstream-alias/include/asm-s390/cacheflush.h
@@ -7,6 +7,7 @@
 /* Caches aren't brain-dead on the s390. */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-sh/cpu-sh2/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-sh/cpu-sh2/cacheflush.h
+++ upstream-alias/include/asm-sh/cpu-sh2/cacheflush.h
@@ -15,6 +15,7 @@
  *
  *  - flush_cache_all() flushes entire cache
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
+ *  - flush_cache_dup mm(mm) handles cache flushing when forking
  *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *
@@ -27,6 +28,7 @@
  */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-sh/cpu-sh3/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-sh/cpu-sh3/cacheflush.h
+++ upstream-alias/include/asm-sh/cpu-sh3/cacheflush.h
@@ -15,6 +15,7 @@
  *
  *  - flush_cache_all() flushes entire cache
  *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
+ *  - flush_cache_dup mm(mm) handles cache flushing when forking
  *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
  *  - flush_cache_range(vma, start, end) flushes a range of pages
  *
@@ -39,6 +40,7 @@
 
 void flush_cache_all(void);
 void flush_cache_mm(struct mm_struct *mm);
+#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
                               unsigned long end);
 void flush_cache_page(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn);
@@ -48,6 +50,7 @@ void flush_icache_page(struct vm_area_st
 #else
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-sh/cpu-sh4/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-sh/cpu-sh4/cacheflush.h
+++ upstream-alias/include/asm-sh/cpu-sh4/cacheflush.h
@@ -18,6 +18,7 @@
  */
 void flush_cache_all(void);
 void flush_cache_mm(struct mm_struct *mm);
+#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end);
 void flush_cache_page(struct vm_area_struct *vma, unsigned long addr,
Index: upstream-alias/include/asm-sh64/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-sh64/cacheflush.h
+++ upstream-alias/include/asm-sh64/cacheflush.h
@@ -21,6 +21,8 @@ extern void flush_icache_user_range(stru
 				    struct page *page, unsigned long addr,
 				    int len);
 
+#define flush_cache_dup_mm(mm)	flush_cache_mm(mm)
+
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
Index: upstream-alias/include/asm-sparc/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-sparc/cacheflush.h
+++ upstream-alias/include/asm-sparc/cacheflush.h
@@ -48,6 +48,7 @@ BTFIXUPDEF_CALL(void, flush_cache_page, 
 
 #define flush_cache_all() BTFIXUP_CALL(flush_cache_all)()
 #define flush_cache_mm(mm) BTFIXUP_CALL(flush_cache_mm)(mm)
+#define flush_cache_dup_mm(mm) BTFIXUP_CALL(flush_cache_mm)(mm)
 #define flush_cache_range(vma,start,end) BTFIXUP_CALL(flush_cache_range)(vma,start,end)
 #define flush_cache_page(vma,addr,pfn) BTFIXUP_CALL(flush_cache_page)(vma,addr)
 #define flush_icache_range(start, end)		do { } while (0)
Index: upstream-alias/include/asm-sparc64/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-sparc64/cacheflush.h
+++ upstream-alias/include/asm-sparc64/cacheflush.h
@@ -12,6 +12,7 @@
 /* These are the same regardless of whether this is an SMP kernel or not. */
 #define flush_cache_mm(__mm) \
 	do { if ((__mm) == current->mm) flushw_user(); } while(0)
+#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
 #define flush_cache_range(vma, start, end) \
 	flush_cache_mm((vma)->vm_mm)
 #define flush_cache_page(vma, page, pfn) \
Index: upstream-alias/include/asm-v850/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-v850/cacheflush.h
+++ upstream-alias/include/asm-v850/cacheflush.h
@@ -24,6 +24,7 @@
    systems with MMUs, so we don't need them.  */
 #define flush_cache_all()			((void)0)
 #define flush_cache_mm(mm)			((void)0)
+#define flush_cache_dup_mm(mm)			((void)0)
 #define flush_cache_range(vma, start, end)	((void)0)
 #define flush_cache_page(vma, vmaddr, pfn)	((void)0)
 #define flush_dcache_page(page)			((void)0)
Index: upstream-alias/include/asm-x86_64/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-x86_64/cacheflush.h
+++ upstream-alias/include/asm-x86_64/cacheflush.h
@@ -7,6 +7,7 @@
 /* Caches aren't brain-dead on the intel. */
 #define flush_cache_all()			do { } while (0)
 #define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
Index: upstream-alias/include/asm-xtensa/cacheflush.h
===================================================================
--- upstream-alias.orig/include/asm-xtensa/cacheflush.h
+++ upstream-alias/include/asm-xtensa/cacheflush.h
@@ -75,6 +75,7 @@ extern void __flush_invalidate_dcache_ra
 
 #define flush_cache_all()		__flush_invalidate_cache_all();
 #define flush_cache_mm(mm)		__flush_invalidate_cache_all();
+#define flush_cache_dup_mm(mm)		__flush_invalidate_cache_all();
 
 #define flush_cache_vmap(start,end)	__flush_invalidate_cache_all();
 #define flush_cache_vunmap(start,end)	__flush_invalidate_cache_all();
@@ -88,6 +89,7 @@ extern void flush_cache_page(struct vm_a
 
 #define flush_cache_all()				do { } while (0)
 #define flush_cache_mm(mm)				do { } while (0)
+#define flush_cache_dup_mm(mm)				do { } while (0)
 
 #define flush_cache_vmap(start,end)			do { } while (0)
 #define flush_cache_vunmap(start,end)			do { } while (0)
Index: upstream-alias/kernel/fork.c
===================================================================
--- upstream-alias.orig/kernel/fork.c
+++ upstream-alias/kernel/fork.c
@@ -203,7 +203,7 @@ static inline int dup_mmap(struct mm_str
 	struct mempolicy *pol;
 
 	down_write(&oldmm->mmap_sem);
-	flush_cache_mm(oldmm);
+	flush_cache_dup_mm(oldmm);
 	/*
 	 * Not linked in yet - no deadlock potential:
 	 */
Index: upstream-alias/Documentation/cachetlb.txt
===================================================================
--- upstream-alias.orig/Documentation/cachetlb.txt
+++ upstream-alias/Documentation/cachetlb.txt
@@ -179,10 +179,21 @@ Here are the routines, one by one:
 	lines associated with 'mm'.
 
 	This interface is used to handle whole address space
-	page table operations such as what happens during
-	fork, exit, and exec.
+	page table operations such as what happens during exit and exec.
 
-2) void flush_cache_range(struct vm_area_struct *vma,
+2) void flush_cache_dup_mm(struct mm_struct *mm)
+
+	This interface flushes an entire user address space from
+	the caches.  That is, after running, there will be no cache
+	lines associated with 'mm'.
+
+	This interface is used to handle whole address space
+	page table operations such as what happens during fork.
+
+	This option is separate from flush_cache_mm to allow some
+	optimizations for VIPT caches.
+
+3) void flush_cache_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end)
 
 	Here we are flushing a specific range of (user) virtual
@@ -199,7 +210,7 @@ Here are the routines, one by one:
 	call flush_cache_page (see below) for each entry which may be
 	modified.
 
-3) void flush_cache_page(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
+4) void flush_cache_page(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
 
 	This time we need to remove a PAGE_SIZE sized range
 	from the cache.  The 'vma' is the backing structure used by
@@ -220,7 +231,7 @@ Here are the routines, one by one:
 
 	This is used primarily during fault processing.
 
-4) void flush_cache_kmaps(void)
+5) void flush_cache_kmaps(void)
 
 	This routine need only be implemented if the platform utilizes
 	highmem.  It will be called right before all of the kmaps
@@ -232,7 +243,7 @@ Here are the routines, one by one:
 
 	This routing should be implemented in asm/highmem.h
 
-5) void flush_cache_vmap(unsigned long start, unsigned long end)
+6) void flush_cache_vmap(unsigned long start, unsigned long end)
    void flush_cache_vunmap(unsigned long start, unsigned long end)
 
 	Here in these two interfaces we are flushing a specific range
