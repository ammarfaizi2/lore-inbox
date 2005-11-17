Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVKQTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVKQTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKQTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:36:16 -0500
Received: from silver.veritas.com ([143.127.12.111]:9505 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964803AbVKQTgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:36:15 -0500
Date: Thu, 17 Nov 2005 19:34:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       William Irwin <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] unpaged: VM_UNPAGED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171932440.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:36:15.0049 (UTC) FILETIME=[2C545B90:01C5EBAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although we tend to associate VM_RESERVED with remap_pfn_range, quite a
few drivers set VM_RESERVED on areas which are then populated by nopage.
The PageReserved removal in 2.6.15-rc1 changed VM_RESERVED not to free
pages in zap_pte_range, without changing those drivers not to set it:
so their pages just leak away.

Let's not change miscellaneous drivers now: introduce VM_UNPAGED at the
core, to flag the special areas where the ptes may have no struct page,
or if they have then it's not to be touched.  Replace most instances of
VM_RESERVED in core mm by VM_UNPAGED.  Force it on in remap_pfn_range,
and the sparc and sparc64 io_remap_pfn_range.

Revert addition of VM_RESERVED to powerpc vdso, it's not needed there.
Is it needed anywhere?  It still governs the mm->reserved_vm statistic,
and special vmas not to be merged, and areas not to be core dumped; but
could probably be eliminated later (the drivers are probably specifying
it because in 2.4 it kept swapout off the vma, but in 2.6 we work from
the LRU, which these pages don't get on).

Use the VM_SHM slot for VM_UNPAGED, and define VM_SHM to 0: it serves no
purpose whatsoever, and should be removed from drivers when we clean up.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/powerpc/kernel/vdso.c |    3 +--
 arch/sparc/mm/generic.c    |    2 +-
 arch/sparc64/mm/generic.c  |    2 +-
 include/linux/mm.h         |    5 +++--
 mm/fremap.c                |    4 ++--
 mm/madvise.c               |    2 +-
 mm/memory.c                |   30 ++++++++++++++++++------------
 mm/mempolicy.c             |    2 +-
 mm/msync.c                 |    4 ++--
 9 files changed, 30 insertions(+), 24 deletions(-)

--- unpaged04/arch/powerpc/kernel/vdso.c	2005-11-12 09:00:32.000000000 +0000
+++ unpaged05/arch/powerpc/kernel/vdso.c	2005-11-17 15:11:02.000000000 +0000
@@ -285,8 +285,7 @@ int arch_setup_additional_pages(struct l
 	 * It's fine to use that for setting breakpoints in the vDSO code
 	 * pages though
 	 */
-	vma->vm_flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE |
-		VM_MAYEXEC | VM_RESERVED;
+	vma->vm_flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 	vma->vm_flags |= mm->def_flags;
 	vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
 	vma->vm_ops = &vdso_vmops;
--- unpaged04/arch/sparc/mm/generic.c	2005-11-12 09:00:36.000000000 +0000
+++ unpaged05/arch/sparc/mm/generic.c	2005-11-17 15:11:02.000000000 +0000
@@ -74,7 +74,7 @@ int io_remap_pfn_range(struct vm_area_st
 	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
 
 	/* See comment in mm/memory.c remap_pfn_range */
-	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_flags |= VM_IO | VM_RESERVED | VM_UNPAGED;
 
 	prot = __pgprot(pg_iobits);
 	offset -= from;
--- unpaged04/arch/sparc64/mm/generic.c	2005-11-12 09:00:36.000000000 +0000
+++ unpaged05/arch/sparc64/mm/generic.c	2005-11-17 15:11:02.000000000 +0000
@@ -128,7 +128,7 @@ int io_remap_pfn_range(struct vm_area_st
 	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
 
 	/* See comment in mm/memory.c remap_pfn_range */
-	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_flags |= VM_IO | VM_RESERVED | VM_UNPAGED;
 
 	prot = __pgprot(pg_iobits);
 	offset -= from;
--- unpaged04/include/linux/mm.h	2005-11-17 15:10:50.000000000 +0000
+++ unpaged05/include/linux/mm.h	2005-11-17 15:11:02.000000000 +0000
@@ -144,7 +144,8 @@ extern unsigned int kobjsize(const void 
 
 #define VM_GROWSDOWN	0x00000100	/* general info on the segment */
 #define VM_GROWSUP	0x00000200
-#define VM_SHM		0x00000400	/* shared memory area, don't swap out */
+#define VM_SHM		0x00000000	/* Means nothing: delete it later */
+#define VM_UNPAGED	0x00000400	/* Pages managed without map count */	
 #define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
 
 #define VM_EXECUTABLE	0x00001000
@@ -157,7 +158,7 @@ extern unsigned int kobjsize(const void 
 
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_RESERVED	0x00080000	/* Pages managed in a special way */
+#define VM_RESERVED	0x00080000	/* Count as reserved_vm like IO */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
--- unpaged04/mm/fremap.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged05/mm/fremap.c	2005-11-17 15:11:02.000000000 +0000
@@ -65,7 +65,7 @@ int install_page(struct mm_struct *mm, s
 	pte_t pte_val;
 	spinlock_t *ptl;
 
-	BUG_ON(vma->vm_flags & VM_RESERVED);
+	BUG_ON(vma->vm_flags & VM_UNPAGED);
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
@@ -122,7 +122,7 @@ int install_file_pte(struct mm_struct *m
 	pte_t pte_val;
 	spinlock_t *ptl;
 
-	BUG_ON(vma->vm_flags & VM_RESERVED);
+	BUG_ON(vma->vm_flags & VM_UNPAGED);
 
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
--- unpaged04/mm/madvise.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged05/mm/madvise.c	2005-11-17 15:11:02.000000000 +0000
@@ -126,7 +126,7 @@ static long madvise_dontneed(struct vm_a
 			     unsigned long start, unsigned long end)
 {
 	*prev = vma;
-	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_RESERVED))
+	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_UNPAGED))
 		return -EINVAL;
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
--- unpaged04/mm/memory.c	2005-11-17 15:10:08.000000000 +0000
+++ unpaged05/mm/memory.c	2005-11-17 15:11:02.000000000 +0000
@@ -334,7 +334,7 @@ static inline void add_mm_rss(struct mm_
 
 /*
  * This function is called to print an error when a pte in a
- * !VM_RESERVED region is found pointing to an invalid pfn (which
+ * !VM_UNPAGED region is found pointing to an invalid pfn (which
  * is an error.
  *
  * The calling function must still handle the error.
@@ -381,15 +381,15 @@ copy_one_pte(struct mm_struct *dst_mm, s
 		goto out_set_pte;
 	}
 
-	/* If the region is VM_RESERVED, the mapping is not
+	/* If the region is VM_UNPAGED, the mapping is not
 	 * mapped via rmap - duplicate the pte as is.
 	 */
-	if (vm_flags & VM_RESERVED)
+	if (vm_flags & VM_UNPAGED)
 		goto out_set_pte;
 
 	pfn = pte_pfn(pte);
 	/* If the pte points outside of valid memory but
-	 * the region is not VM_RESERVED, we have a problem.
+	 * the region is not VM_UNPAGED, we have a problem.
 	 */
 	if (unlikely(!pfn_valid(pfn))) {
 		print_bad_pte(vma, pte, addr);
@@ -528,7 +528,7 @@ int copy_page_range(struct mm_struct *ds
 	 * readonly mappings. The tradeoff is that copy_page_range is more
 	 * efficient than faulting.
 	 */
-	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))) {
+	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_UNPAGED))) {
 		if (!vma->anon_vma)
 			return 0;
 	}
@@ -572,7 +572,7 @@ static unsigned long zap_pte_range(struc
 
 			(*zap_work) -= PAGE_SIZE;
 
-			if (!(vma->vm_flags & VM_RESERVED)) {
+			if (!(vma->vm_flags & VM_UNPAGED)) {
 				unsigned long pfn = pte_pfn(ptent);
 				if (unlikely(!pfn_valid(pfn)))
 					print_bad_pte(vma, ptent, addr);
@@ -1191,10 +1191,16 @@ int remap_pfn_range(struct vm_area_struc
 	 * rest of the world about it:
 	 *   VM_IO tells people not to look at these pages
 	 *	(accesses can have side effects).
-	 *   VM_RESERVED tells the core MM not to "manage" these pages
-         *	(e.g. refcount, mapcount, try to swap them out).
+	 *   VM_RESERVED is specified all over the place, because
+	 *	in 2.4 it kept swapout's vma scan off this vma; but
+	 *	in 2.6 the LRU scan won't even find its pages, so this
+	 *	flag means no more than count its pages in reserved_vm,
+	 * 	and omit it from core dump, even when VM_IO turned off.
+	 *   VM_UNPAGED tells the core MM not to "manage" these pages
+         *	(e.g. refcount, mapcount, try to swap them out): in
+	 *	particular, zap_pte_range does not try to free them.
 	 */
-	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_flags |= VM_IO | VM_RESERVED | VM_UNPAGED;
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -1276,7 +1282,7 @@ static int do_wp_page(struct mm_struct *
 	pte_t entry;
 	int ret = VM_FAULT_MINOR;
 
-	BUG_ON(vma->vm_flags & VM_RESERVED);
+	BUG_ON(vma->vm_flags & VM_UNPAGED);
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
@@ -1924,7 +1930,7 @@ retry:
 			inc_mm_counter(mm, anon_rss);
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
-		} else if (!(vma->vm_flags & VM_RESERVED)) {
+		} else if (!(vma->vm_flags & VM_UNPAGED)) {
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
 		}
@@ -2203,7 +2209,7 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_page_prot = PAGE_READONLY;
-	gate_vma.vm_flags = VM_RESERVED;
+	gate_vma.vm_flags = 0;
 	return 0;
 }
 __initcall(gate_vma_init);
--- unpaged04/mm/mempolicy.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged05/mm/mempolicy.c	2005-11-17 15:11:02.000000000 +0000
@@ -269,7 +269,7 @@ check_range(struct mm_struct *mm, unsign
 	first = find_vma(mm, start);
 	if (!first)
 		return ERR_PTR(-EFAULT);
-	if (first->vm_flags & VM_RESERVED)
+	if (first->vm_flags & VM_UNPAGED)
 		return ERR_PTR(-EACCES);
 	prev = NULL;
 	for (vma = first; vma && vma->vm_start < end; vma = vma->vm_next) {
--- unpaged04/mm/msync.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged05/mm/msync.c	2005-11-17 15:11:02.000000000 +0000
@@ -97,9 +97,9 @@ static void msync_page_range(struct vm_a
 	/* For hugepages we can't go walking the page table normally,
 	 * but that's ok, hugetlbfs is memory based, so we don't need
 	 * to do anything more on an msync().
-	 * Can't do anything with VM_RESERVED regions either.
+	 * Can't do anything with VM_UNPAGED regions either.
 	 */
-	if (vma->vm_flags & (VM_HUGETLB|VM_RESERVED))
+	if (vma->vm_flags & (VM_HUGETLB|VM_UNPAGED))
 		return;
 
 	BUG_ON(addr >= end);
