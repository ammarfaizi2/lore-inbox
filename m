Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268143AbTCFQlj>; Thu, 6 Mar 2003 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268144AbTCFQlj>; Thu, 6 Mar 2003 11:41:39 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19843 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S268143AbTCFQlg>; Thu, 6 Mar 2003 11:41:36 -0500
Date: Thu, 6 Mar 2003 16:53:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] nonlinear oddities
Message-ID: <Pine.LNX.4.44.0303061618460.2422-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  Revert MAP_NONLINEAR and VM_NONLINEAR: I can easily imagine wanting
VM_NONLINEAR in future, warning that vma is unusual, but currently it's
not useful: install_page just needs to SetPageAnon if the page is put
somewhere try_to_unmap_obj_one wouldn't be able to find it.

2.  filemap_populate and shmem_populate expect an absolute pgoff, but
try_to_unmap_one is forgetting to add in vm_pgoff when doing set_pte.
Could be done the other way round, with relative pgoff in the pte?
No, that would make splitting a vma tedious.

3.  No patch included, but I believe 2.5.64-mm1 is testing Ingo's
file-offset-in-pte very much less than you imagine (I've yet to hit
a breakpoint on do_file_page, and I don't think that's down to the
patches above): Dave's work means that the file pages don't arrive
at Ingo's code to set the pte with file offset (unless you actually
use Ingo's syscall) - difficult to test both at once, I think.

Hugh 

--- 2.5.64-mm1/include/asm-i386/mman.h	Thu Mar  6 08:24:23 2003
+++ linux/include/asm-i386/mman.h	Thu Mar  6 15:59:49 2003
@@ -20,7 +20,6 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_NONLINEAR	0x20000		/* will be used for remap_file_pages */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
--- 2.5.64-mm1/include/asm-ppc64/mman.h	Thu Mar  6 08:24:23 2003
+++ linux/include/asm-ppc64/mman.h	Thu Mar  6 15:59:49 2003
@@ -36,7 +36,6 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_NONLINEAR	0x20000		/* Mapping may use remap_file_pages */
 
 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */
--- 2.5.64-mm1/include/linux/mm.h	Thu Mar  6 08:24:24 2003
+++ linux/include/linux/mm.h	Thu Mar  6 15:59:49 2003
@@ -107,7 +107,6 @@
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_NONLINEAR	0x00800000	/* Nonlinear area */
 
 #ifdef CONFIG_STACK_GROWSUP
 #define VM_STACK_FLAGS	(VM_GROWSUP | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
--- 2.5.64-mm1/mm/fremap.c	Thu Mar  6 08:24:24 2003
+++ linux/mm/fremap.c	Thu Mar  6 15:59:49 2003
@@ -1,5 +1,5 @@
 /*
- *   linux/mm/mpopulate.c
+ *   linux/mm/fremap.c
  * 
  * Explicit pagetable population and nonlinear (random) mappings support.
  *
@@ -57,6 +57,7 @@
 	pgd_t *pgd;
 	pmd_t *pmd;
 	struct pte_chain *pte_chain;
+	unsigned long pgidx;
 
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
@@ -79,7 +80,10 @@
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, prot);
 	set_pte(pte, entry);
-	if (vma->vm_flags & VM_NONLINEAR)
+	pgidx = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgidx += vma->vm_pgoff;
+	pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+	if (page->index != pgidx)
 		SetPageAnon(page);
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
@@ -139,8 +143,7 @@
 	 * and that the remapped range is valid and fully within
 	 * the single existing vma:
 	 */
-	if (vma &&
-	    ((vma->vm_flags & (VM_SHARED|VM_NONLINEAR)) == (VM_SHARED|VM_NONLINEAR)) &&
+	if (vma && (vma->vm_flags & VM_SHARED) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end)
--- 2.5.64-mm1/mm/mmap.c	Thu Mar  6 08:24:24 2003
+++ linux/mm/mmap.c	Thu Mar  6 15:59:49 2003
@@ -219,7 +219,6 @@
 	flag_bits =
 		_trans(flags, MAP_GROWSDOWN, VM_GROWSDOWN) |
 		_trans(flags, MAP_DENYWRITE, VM_DENYWRITE) |
-		_trans(flags, MAP_NONLINEAR, VM_NONLINEAR) |
 		_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE);
 	return prot_bits | flag_bits;
 #undef _trans
--- 2.5.64-mm1/mm/rmap.c	Thu Mar  6 08:24:24 2003
+++ linux/mm/rmap.c	Thu Mar  6 15:59:49 2003
@@ -598,6 +598,8 @@
 		 * in the pte.
 		 */
 		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
+		pgidx += vma->vm_pgoff;
+		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 		if (1 || page->index != pgidx) {
 			set_pte(ptep, pgoff_to_pte(page->index));
 			BUG_ON(!pte_file(*ptep));

