Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWBMXnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWBMXnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWBMXnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:43:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:54699 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030295AbWBMXnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:43:45 -0500
Date: Mon, 13 Feb 2006 23:44:27 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, William Irwin <wli@holomorphy.com>,
       Roland Dreier <rdreier@cisco.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <20060213230100.GF13603@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0602132331130.4877@goblin.wat.veritas.com>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
 <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
 <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
 <20060213220947.GD13603@mellanox.co.il> <Pine.LNX.4.61.0602132249150.4526@goblin.wat.veritas.com>
 <20060213230100.GF13603@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 23:43:45.0348 (UTC) FILETIME=[54262840:01C630F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Michael S. Tsirkin wrote:
> Here's the final version of MADV_DONTFORK/MADV_DOFORK patch.
> Hugh, I gather you'll forward this to Andrew, correct?

Oh, if you like, here we go - but it would have been perfectly okay
for you to send it to him directly yourself.  (And he's probably
been watching and already taken it anyway.)  It seems to me that
it's sufficiently harmless that it could still be 2.6.16 material,
but let's leave Linus and Andrew to decide on that.

Hugh

---
From: Michael S. Tsirkin <mst@mellanox.co.il>

Currently, copy-on-write may change the physical address of a page even if the
user requested that the page is pinned in memory (either by mlock or by
get_user_pages). This happens if the process forks meanwhile, and the parent
writes to that page.  As a result, the page is orphaned: in case of
get_user_pages, the application will never see any data hardware DMAs into this
page after the COW.  In case of mlock'd memory, the parent is not getting the
real-time/security benefits of mlock.

In particular, this affects the Infiniband modules which do DMA from and into
user pages all the time.

This patch adds madvise options to control whether memory range is inherited
across fork. Useful e.g. for when hardware is doing DMA from/into these pages.
Could also be useful to an application wanting to speed up its forks by cutting
large areas out of consideration.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Hugh Dickins <hugh@veritas.com>

Index: linux-2.6.16-rc2/mm/madvise.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/madvise.c	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/mm/madvise.c	2006-02-14 03:40:22.000000000 +0200
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
+		new_flags |= VM_DONTCOPY;
+		break;
+	case MADV_DOFORK:
+		new_flags &= ~VM_DONTCOPY;
 		break;
 	}
 
@@ -177,6 +184,12 @@ madvise_vma(struct vm_area_struct *vma, 
 	long error;
 
 	switch (behavior) {
+	case MADV_DOFORK:
+		if (vma->vm_flags & VM_IO) {
+			error = -EINVAL;
+			break;
+		}
+	case MADV_DONTFORK:
 	case MADV_NORMAL:
 	case MADV_SEQUENTIAL:
 	case MADV_RANDOM:
Index: linux-2.6.16-rc2/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.16-rc2.orig/include/asm-x86_64/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-x86_64/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-powerpc/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-powerpc/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-cris/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-cris/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-arm26/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-arm26/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-alpha/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-alpha/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-m68k/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-m68k/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-xtensa/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-xtensa/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-mips/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-mips/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-sparc64/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-sparc64/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-v850/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-v850/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-s390/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-s390/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-parisc/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-parisc/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-i386/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-i386/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-sh/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-sh/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-ia64/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-ia64/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-sparc/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-sparc/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-m32r/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-m32r/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-frv/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-frv/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-h8300/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-h8300/mman.h	2006-02-14 01:24:57.000000000 +0200
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
--- linux-2.6.16-rc2.orig/include/asm-arm/mman.h	2006-02-14 01:22:27.000000000 +0200
+++ linux-2.6.16-rc2/include/asm-arm/mman.h	2006-02-14 01:24:57.000000000 +0200
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
