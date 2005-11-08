Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVKHVa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVKHVa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVKHVa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:30:58 -0500
Received: from [194.90.237.34] ([194.90.237.34]:16750 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S965189AbVKHVa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:30:58 -0500
Date: Tue, 8 Nov 2005 23:34:07 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051108213407.GB31746@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> In the time since we discussed before, I've rather come full circle
> round to my original position: abandoning such ideas of trying to
> handle it from get_user_pages itself, appreciating the simplicity
> of the original PROT_DONTCOPY idea from you guys; but sticking to my
> initial reaction that this is better done by madvise(MADV_DONTCOPY),
> not by the mmap/mprotect route in Michael's patch.  (I never bought
> the "racy" argument advanced in favour of the mmap flag.)
> 
> One of the factors which has swayed me to the DONTCOPY approach, is
> Nick's 2.6.14 optimization in fork's copy_page_range, where areas
> which can be safely faulted later are not copied pte by pte.  But
> that doesn't apply to all areas, and in particular cannot apply to
> VM_NONLINEAR shared areas.  It should be of benefit to apps which
> use large such areas, and also do a lot of forking children who don't
> need those areas, to be able to mark them VM_DONTCOPY.  Or any other
> vmas the children won't need.  (But there's one big distinction between
> the optimization and VM_DONTCOPY: the optimization copies vma but
> doesn't fill in its ptes, VM_DONTCOPY doesn't even copy the vma.)
> 
> Two warnings if someone would like to post a MADV_DONTCOPY patch.
> It should include a matching MADV_DOCOPY to clear the condition, but
> that must not be allowed to clear VM_DONTCOPY set originally by driver:
> perhaps you'll end up with a VM_UDONTCOPY or something like that.
> 
> And Badari has a MADV_REMOVE patch in the works, taking the next
> slot (just after MADV_DONTNEED in most of the arches): probably
> best for you to base yours on top of his (though yours is simpler
> and might jump ahead).
> 
> Hugh
> 

Hugh, did you have something like the following in mind
(this is only boot-tested and only on x86-64)?
Hmm, maybe MADV_INHERIT and MADV_DONT_INHERIT would be better names,
since the copy is only dont one write ...

Comments?

----

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.14-dontcopy/kernel/fork.c
===================================================================
--- linux-2.6.14-dontcopy.orig/kernel/fork.c	2005-11-08 23:41:30.000000000 +0200
+++ linux-2.6.14-dontcopy/kernel/fork.c	2005-11-08 23:41:08.000000000 +0200
@@ -209,7 +209,7 @@ static inline int dup_mmap(struct mm_str
 	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
 		struct file *file;
 
-		if (mpnt->vm_flags & VM_DONTCOPY) {
+		if (mpnt->vm_flags & (VM_DONTCOPY | VM_UDONTCOPY)) {
 			long pages = vma_pages(mpnt);
 			mm->total_vm -= pages;
 			__vm_stat_account(mm, mpnt->vm_flags, mpnt->vm_file,
Index: linux-2.6.14-dontcopy/mm/mmap.c
===================================================================
--- linux-2.6.14-dontcopy.orig/mm/mmap.c	2005-11-08 23:42:01.000000000 +0200
+++ linux-2.6.14-dontcopy/mm/mmap.c	2005-11-08 23:41:48.000000000 +0200
@@ -840,7 +840,7 @@ void __vm_stat_account(struct mm_struct 
 
 #ifdef CONFIG_HUGETLB
 	if (flags & VM_HUGETLB) {
-		if (!(flags & VM_DONTCOPY))
+		if (!(flags & (VM_DONTCOPY|VM_UDONTCOPY)))
 			mm->shared_vm += pages;
 		return;
 	}
Index: linux-2.6.14-dontcopy/mm/madvise.c
===================================================================
--- linux-2.6.14-dontcopy.orig/mm/madvise.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-dontcopy/mm/madvise.c	2005-11-08 23:28:56.000000000 +0200
@@ -31,6 +31,12 @@ static long madvise_behavior(struct vm_a
 	case MADV_RANDOM:
 		new_flags |= VM_RAND_READ;
 		break;
+	case MADV_DONTCOPY:
+		new_flags |= VM_UDONTCOPY;
+		break;
+	case MADV_DOCOPY:
+		new_flags &= ~VM_UDONTCOPY;
+		break;
 	default:
 		break;
 	}
@@ -150,6 +156,8 @@ madvise_vma(struct vm_area_struct *vma, 
 	case MADV_NORMAL:
 	case MADV_SEQUENTIAL:
 	case MADV_RANDOM:
+	case MADV_DONTCOPY:
+	case MADV_DOCOPY:
 		error = madvise_behavior(vma, prev, start, end, behavior);
 		break;
 
Index: linux-2.6.14-dontcopy/include/linux/mm.h
===================================================================
--- linux-2.6.14-dontcopy.orig/include/linux/mm.h	2005-11-08 23:24:58.000000000 +0200
+++ linux-2.6.14-dontcopy/include/linux/mm.h	2005-11-08 23:25:09.000000000 +0200
@@ -154,6 +154,7 @@ extern unsigned int kobjsize(const void 
 					/* Used by sys_madvise() */
 #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
 #define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
+#define VM_UDONTCOPY	0x02000000      /* App wants to set VM_DONTCOPY */
 
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
Index: linux-2.6.14-dontcopy/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.14-dontcopy.orig/include/asm-x86_64/mman.h	2005-11-08 23:19:35.000000000 +0200
+++ linux-2.6.14-dontcopy/include/asm-x86_64/mman.h	2005-11-08 23:19:46.000000000 +0200
@@ -36,6 +36,8 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_DONTCOPY	0x30		/* dont inherit across fork */
+#define MADV_DOCOPY	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS

-- 
MST
