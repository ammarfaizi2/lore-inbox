Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWBMPjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWBMPjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBMPjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:39:54 -0500
Received: from [194.90.237.34] ([194.90.237.34]:6995 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1750764AbWBMPjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:39:53 -0500
Date: Mon, 13 Feb 2006 17:41:14 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060213154114.GO32041@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Feb 2006 15:41:42.0656 (UTC) FILETIME=[FCE19800:01C630B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I guess its time to start the push for merging this patch.
Probably not 2.6.16 material, but it would be nice to get this say into -mm to
make it easier to test this. Tested on x86_64 only.

Please Cc me directly with comments, I'm not on the list.

---

Add madvise options to control whether memory range is inherited across fork.
Useful e.g. for when hardware is doing DMA from/into these pages.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.16-rc2/kernel/fork.c
===================================================================
--- linux-2.6.16-rc2.orig/kernel/fork.c	2006-02-10 03:43:19.000000000 +0200
+++ linux-2.6.16-rc2/kernel/fork.c	2006-02-12 20:48:37.000000000 +0200
@@ -210,7 +210,7 @@ static inline int dup_mmap(struct mm_str
 	for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
 		struct file *file;
 
-		if (mpnt->vm_flags & VM_DONTCOPY) {
+		if (mpnt->vm_flags & (VM_DONTCOPY | VM_DONTFORK)) {
 			long pages = vma_pages(mpnt);
 			mm->total_vm -= pages;
 			vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
Index: linux-2.6.16-rc2/mm/mmap.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/mmap.c	2006-02-10 03:43:19.000000000 +0200
+++ linux-2.6.16-rc2/mm/mmap.c	2006-02-12 20:48:37.000000000 +0200
@@ -847,7 +847,7 @@ void vm_stat_account(struct mm_struct *m
 
 #ifdef CONFIG_HUGETLB
 	if (flags & VM_HUGETLB) {
-		if (!(flags & VM_DONTCOPY))
+		if (!(flags & (VM_DONTCOPY|VM_DONTFORK)))
 			mm->shared_vm += pages;
 		return;
 	}
Index: linux-2.6.16-rc2/mm/madvise.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/madvise.c	2006-02-10 03:43:19.000000000 +0200
+++ linux-2.6.16-rc2/mm/madvise.c	2006-02-12 20:48:37.000000000 +0200
@@ -22,16 +22,23 @@ static long madvise_behavior(struct vm_a
 	struct mm_struct * mm = vma->vm_mm;
 	int error = 0;
 	pgoff_t pgoff;
-	int new_flags = vma->vm_flags & ~VM_READHINTMASK;
+	int new_flags = vma->vm_flags;
 
 	switch (behavior) {
+	case MADV_NORMAL:
+		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
+		break;
 	case MADV_SEQUENTIAL:
-		new_flags |= VM_SEQ_READ;
+		new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
 		break;
 	case MADV_RANDOM:
-		new_flags |= VM_RAND_READ;
+		new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
 		break;
-	default:
+	case MADV_DONTFORK:
+		new_flags |= VM_DONTFORK;
+		break;
+	case MADV_DOFORK:
+		new_flags &= ~VM_DONTFORK;
 		break;
 	}
 
@@ -180,6 +187,8 @@ madvise_vma(struct vm_area_struct *vma, 
 	case MADV_NORMAL:
 	case MADV_SEQUENTIAL:
 	case MADV_RANDOM:
+	case MADV_DONTFORK:
+	case MADV_DOFORK:
 		error = madvise_behavior(vma, prev, start, end, behavior);
 		break;
 	case MADV_REMOVE:
Index: linux-2.6.16-rc2/include/linux/mm.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/mm.h	2006-02-10 03:43:19.000000000 +0200
+++ linux-2.6.16-rc2/include/linux/mm.h	2006-02-12 20:52:11.000000000 +0200
@@ -166,6 +166,7 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_DONTFORK	0x04000000      /* App wants to avoid inheriting the vma on fork */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
Index: linux-2.6.16-rc2/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-x86_64/mman.h	2006-02-10 03:43:19.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-x86_64/mman.h	2006-02-12 20:52:21.000000000 +0200
@@ -37,6 +37,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-powerpc/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-powerpc/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-powerpc/mman.h	2006-02-12 20:55:07.000000000 +0200
@@ -45,6 +45,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-cris/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-cris/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-cris/mman.h	2006-02-12 20:54:31.000000000 +0200
@@ -38,6 +38,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-arm26/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-arm26/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-arm26/mman.h	2006-02-12 20:54:27.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-alpha/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-alpha/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-alpha/mman.h	2006-02-12 20:55:44.000000000 +0200
@@ -43,6 +43,8 @@
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
 #define MADV_DONTNEED	6		/* don't need these pages */
 #define MADV_REMOVE	7		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-m68k/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-m68k/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-m68k/mman.h	2006-02-12 20:54:54.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-xtensa/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-xtensa/mman.h	2006-02-10 03:43:19.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-xtensa/mman.h	2006-02-12 20:55:38.000000000 +0200
@@ -73,6 +73,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON       MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-mips/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-mips/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-mips/mman.h	2006-02-12 20:55:00.000000000 +0200
@@ -66,6 +66,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON       MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-sparc64/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-sparc64/mman.h	2006-02-10 03:43:18.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-sparc64/mman.h	2006-02-12 20:55:24.000000000 +0200
@@ -55,6 +55,8 @@
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
 #define MADV_REMOVE	0x6		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-v850/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-v850/mman.h	2006-02-10 03:43:18.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-v850/mman.h	2006-02-12 20:55:31.000000000 +0200
@@ -33,6 +33,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-s390/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-s390/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-s390/mman.h	2006-02-12 20:55:11.000000000 +0200
@@ -44,6 +44,8 @@
 #define MADV_WILLNEED  0x3              /* pre-fault pages */
 #define MADV_DONTNEED  0x4              /* discard these pages */
 #define MADV_REMOVE    0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-parisc/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-parisc/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-parisc/mman.h	2006-02-12 20:55:04.000000000 +0200
@@ -49,6 +49,8 @@
 #define MADV_4M_PAGES   22              /* Use 4 Megabyte pages */
 #define MADV_16M_PAGES  24              /* Use 16 Megabyte pages */
 #define MADV_64M_PAGES  26              /* Use 64 Megabyte pages */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-i386/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-i386/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-i386/mman.h	2006-02-12 20:54:43.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-sh/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-sh/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-sh/mman.h	2006-02-12 20:55:14.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-ia64/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-ia64/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-ia64/mman.h	2006-02-12 20:54:47.000000000 +0200
@@ -44,6 +44,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-sparc/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-sparc/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-sparc/mman.h	2006-02-12 20:55:20.000000000 +0200
@@ -55,6 +55,8 @@
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
 #define MADV_REMOVE	0x6		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-m32r/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-m32r/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-m32r/mman.h	2006-02-12 20:54:51.000000000 +0200
@@ -38,6 +38,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-frv/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-frv/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-frv/mman.h	2006-02-12 20:54:35.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-h8300/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-h8300/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-h8300/mman.h	2006-02-12 20:54:39.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
Index: linux-2.6.16-rc2/include/asm-arm/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-arm/mman.h	2006-02-10 03:43:13.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-arm/mman.h	2006-02-12 20:54:19.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS


-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
