Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVKNUWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVKNUWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVKNUWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:22:13 -0500
Received: from [194.90.237.34] ([194.90.237.34]:44492 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S932096AbVKNUV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:21:59 -0500
Date: Mon, 14 Nov 2005 22:23:49 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Gleb Natapov <gleb@minantech.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114202349.GA3603@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051114150022.GG5492@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114150022.GG5492@minantech.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gleb Natapov <gleb@minantech.com>:
> It seams now you broke MADV_NORMAL.

Right. How's this?

---

Add madvise options to control whether memory range is inherited across fork.
Useful e.g. for when hardware is doing DMA from/into these pages.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.14-dontcopy/kernel/fork.c
===================================================================
--- linux-2.6.14-dontcopy.orig/kernel/fork.c	2005-11-08 23:41:30.000000000 +0200
+++ linux-2.6.14-dontcopy/kernel/fork.c	2005-11-14 16:59:05.000000000 +0200
@@ -209,7 +209,7 @@ static inline int dup_mmap(struct mm_str
 	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
 		struct file *file;
 
-		if (mpnt->vm_flags & VM_DONTCOPY) {
+		if (mpnt->vm_flags & (VM_DONTCOPY | VM_DONTFORK)) {
 			long pages = vma_pages(mpnt);
 			mm->total_vm -= pages;
 			__vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
Index: linux-2.6.14-dontcopy/mm/mmap.c
===================================================================
--- linux-2.6.14-dontcopy.orig/mm/mmap.c	2005-11-08 23:42:01.000000000 +0200
+++ linux-2.6.14-dontcopy/mm/mmap.c	2005-11-14 17:02:37.000000000 +0200
@@ -840,7 +840,7 @@ void __vm_stat_account(struct mm_struct 
 
 #ifdef CONFIG_HUGETLB
 	if (flags & VM_HUGETLB) {
-		if (!(flags & VM_DONTCOPY))
+		if (!(flags & (VM_DONTCOPY|VM_DONTFORK)))
 			mm->shared_vm += pages;
 		return;
 	}
Index: linux-2.6.14-dontcopy/mm/madvise.c
===================================================================
--- linux-2.6.14-dontcopy.orig/mm/madvise.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-dontcopy/mm/madvise.c	2005-11-14 22:40:43.000000000 +0200
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
 
@@ -150,6 +157,8 @@ madvise_vma(struct vm_area_struct *vma, 
 	case MADV_NORMAL:
 	case MADV_SEQUENTIAL:
 	case MADV_RANDOM:
+	case MADV_DONTFORK:
+	case MADV_DOFORK:
 		error = madvise_behavior(vma, prev, start, end, behavior);
 		break;
 
Index: linux-2.6.14-dontcopy/include/linux/mm.h
===================================================================
--- linux-2.6.14-dontcopy.orig/include/linux/mm.h	2005-11-08 23:24:58.000000000 +0200
+++ linux-2.6.14-dontcopy/include/linux/mm.h	2005-11-14 16:58:51.000000000 +0200
@@ -162,6 +162,7 @@ extern unsigned int kobjsize(const void 
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
+#define VM_DONTFORK	0x02000000      /* App wants to set VM_DONTCOPY */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
Index: linux-2.6.14-dontcopy/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.14-dontcopy.orig/include/asm-x86_64/mman.h	2005-11-08 23:19:35.000000000 +0200
+++ linux-2.6.14-dontcopy/include/asm-x86_64/mman.h	2005-11-14 16:57:29.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_DONTFORK	0x30		/* dont inherit across fork */
+#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
-- 
MST
