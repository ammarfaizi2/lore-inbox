Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWD3RdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWD3RdB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWD3Rcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:32:39 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:44498 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751185AbWD3Rch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:37 -0400
Message-Id: <20060430173021.314956000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:29:55 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 02/14] remap_file_pages protection support: add needed macros
Content-Disposition: inline; filename=rfp/01-add-MAP_CHGPROT-wrapper-macros.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add pte_to_pgprot() and pgoff_prot_to_pte() macros, in generic versions; so we
can safely use it and keep the kernel compiling. For some architectures real
definitions of the macros are actually provided.

Also, add the MAP_CHGPROT flag to all arch headers (was MAP_NOINHERIT, changed on
Hugh Dickins' suggestion).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-generic/pgtable.h
+++ linux-2.6.git/include/asm-generic/pgtable.h
@@ -241,4 +241,16 @@ static inline int pmd_none_or_clear_bad(
 }
 #endif /* !__ASSEMBLY__ */
 
+#ifndef __HAVE_ARCH_PTE_TO_PGPROT
+/* Wrappers for architectures which don't support yet page protections for
+ * remap_file_pages. */
+
+/* Dummy define - if the architecture has no special support, access is denied
+ * in VM_MANYPROTS vma's. */
+#define pte_to_pgprot(pte) __P000
+
+#define pgoff_prot_to_pte(off, prot) pgoff_to_pte(off)
+
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
Index: linux-2.6.git/include/asm-alpha/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-alpha/mman.h
+++ linux-2.6.git/include/asm-alpha/mman.h
@@ -28,6 +28,9 @@
 #define MAP_NORESERVE	0x10000		/* don't check for reservations */
 #define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define MAP_CHGPROT	0x80000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
Index: linux-2.6.git/include/asm-arm26/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm26/mman.h
+++ linux-2.6.git/include/asm-arm26/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE    0x8000          /* populate (prefault) page tables */
 #define MAP_NONBLOCK    0x10000         /* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-arm/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-arm/mman.h
+++ linux-2.6.git/include/asm-arm/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-cris/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-cris/mman.h
+++ linux-2.6.git/include/asm-cris/mman.h
@@ -12,6 +12,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-frv/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-frv/mman.h
+++ linux-2.6.git/include/asm-frv/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-h8300/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-h8300/mman.h
+++ linux-2.6.git/include/asm-h8300/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-i386/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/mman.h
+++ linux-2.6.git/include/asm-i386/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-ia64/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-ia64/mman.h
+++ linux-2.6.git/include/asm-ia64/mman.h
@@ -18,6 +18,9 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-m32r/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-m32r/mman.h
+++ linux-2.6.git/include/asm-m32r/mman.h
@@ -12,6 +12,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-m68k/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68k/mman.h
+++ linux-2.6.git/include/asm-m68k/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-mips/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-mips/mman.h
+++ linux-2.6.git/include/asm-mips/mman.h
@@ -46,6 +46,9 @@
 #define MAP_LOCKED	0x8000		/* pages are locked */
 #define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_CHGPROT	0x40000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /*
  * Flags for msync
Index: linux-2.6.git/include/asm-parisc/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-parisc/mman.h
+++ linux-2.6.git/include/asm-parisc/mman.h
@@ -22,6 +22,9 @@
 #define MAP_GROWSDOWN	0x8000		/* stack-like segment */
 #define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_CHGPROT	0x40000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
Index: linux-2.6.git/include/asm-powerpc/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-powerpc/mman.h
+++ linux-2.6.git/include/asm-powerpc/mman.h
@@ -23,5 +23,8 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #endif	/* _ASM_POWERPC_MMAN_H */
Index: linux-2.6.git/include/asm-s390/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-s390/mman.h
+++ linux-2.6.git/include/asm-s390/mman.h
@@ -18,6 +18,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-sh/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-sh/mman.h
+++ linux-2.6.git/include/asm-sh/mman.h
@@ -10,6 +10,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-sparc64/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-sparc64/mman.h
+++ linux-2.6.git/include/asm-sparc64/mman.h
@@ -21,6 +21,9 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /* XXX Need to add flags to SunOS's mctl, mlockall, and madvise system
  * XXX calls.
Index: linux-2.6.git/include/asm-sparc/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-sparc/mman.h
+++ linux-2.6.git/include/asm-sparc/mman.h
@@ -21,6 +21,9 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /* XXX Need to add flags to SunOS's mctl, mlockall, and madvise system
  * XXX calls.
Index: linux-2.6.git/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-x86_64/mman.h
+++ linux-2.6.git/include/asm-x86_64/mman.h
@@ -12,6 +12,9 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_CHGPROT	0x20000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
Index: linux-2.6.git/include/asm-xtensa/mman.h
===================================================================
--- linux-2.6.git.orig/include/asm-xtensa/mman.h
+++ linux-2.6.git/include/asm-xtensa/mman.h
@@ -53,6 +53,9 @@
 #define MAP_LOCKED	0x8000		/* pages are locked */
 #define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x20000		/* do not block on IO */
+#define MAP_CHGPROT	0x40000		/* don't inherit the protection bits of
+					   the underlying vma, to be passed to
+					   remap_file_pages() only */
 
 /*
  * Flags for msync

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
