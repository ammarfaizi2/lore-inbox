Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUIANlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUIANlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUIANky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:40:54 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:51328
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S266511AbUIANjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:39:36 -0400
To: akpm@osdl.org
Subject: [PATCH 2/2] topdown support for ppc64
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Message-Id: <E1C2VKj-0005pk-BU@localhost.localdomain>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 01 Sep 2004 14:39:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent patches introduced a top down user process address space
allocation policy; further patches enable this for ppc64.
Although these work correctly for normal maps, the topdown
algorithm does not take into account stringent mixing constraints
for small and large pages on this architecture.  These patches
introduce a ppc64 specific arch_get_unused_area_topdown() variant.
The first introduces infrastructure to allow replacement of the
generic arch_get_unused_area_topdown() and the second utilises
this infrastructure.

In this patch I have followed the pattern set by the
arch_get_unused_area() using HAVE_ARCH_UNMAPPED_AREA_TOPDOWN to
be consistent.  However, it would also be possible to simply have
a ppc64_get_unused_area_topdown() in the arch/ppc64/mm/mmap.c or
to use weak bindings with the same.

-apw

=== 8< ===
ppc64 has constraints on the mixing of small and large pages, such that
they cannot be mixed in the same 256Mb segment.  This patch provides
an architecture specific arch_get_unmapped_area_topdown() which implements
these contraints.

Revision: $Rev: 591 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 100-flex_mmap_for_ppc64_topdown
---
 arch/ppc64/mm/hugetlbpage.c |  102 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc64/pgtable.h |    1 
 2 files changed, 103 insertions(+)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/mm/hugetlbpage.c current/arch/ppc64/mm/hugetlbpage.c
--- reference/arch/ppc64/mm/hugetlbpage.c	2004-08-25 12:12:13.000000000 +0100
+++ current/arch/ppc64/mm/hugetlbpage.c	2004-08-31 11:02:17.000000000 +0100
@@ -527,6 +527,108 @@ full_search:
 	return -ENOMEM;
 }
 
+/* 
+ * This mmap-allocator allocates new areas top-down from below the
+ * stack's low limit (the base):
+ *
+ * Because we have an exclusive hugepage region which lies within the
+ * normal user address space, we have to take special measures to make
+ * non-huge mmap()s evade the hugepage reserved regions.
+ */
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
+{
+	struct vm_area_struct *vma, *prev_vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long base = mm->mmap_base, addr = addr0;
+	int first_time = 1;
+
+	/* requested length too big for entire address space */
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/* dont allow allocations above current base */
+	if (mm->free_area_cache > base)
+		mm->free_area_cache = base;
+
+	/* requesting a specific address */
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+				(!vma || addr + len <= vma->vm_start)
+				&& !is_hugepage_only_range(addr,len))
+			return addr;
+	}
+
+try_again:
+	/* make sure it can fit in the remaining address space */
+	if (mm->free_area_cache < len)
+		goto fail;
+
+	/* either no address requested or cant fit in requested address hole */
+	addr = (mm->free_area_cache - len) & PAGE_MASK;
+	do {
+hugepage_recheck:
+		if (touches_hugepage_low_range(addr, len)) {
+			addr = (addr & ((~0) << SID_SHIFT)) - len;
+			goto hugepage_recheck;
+		} else if (touches_hugepage_high_range(addr, len)) {
+			addr = TASK_HPAGE_BASE - len;
+		}
+
+		/*
+		 * Lookup failure means no vma is above this address,
+		 * i.e. return with success:
+		 */
+ 	 	if (!(vma = find_vma_prev(mm, addr, &prev_vma)))
+			return addr;
+
+		/*
+		 * new region fits between prev_vma->vm_end and
+		 * vma->vm_start, use it:
+		 */
+		if (addr+len <= vma->vm_start &&
+				(!prev_vma || (addr >= prev_vma->vm_end)))
+			/* remember the address as a hint for next time */
+			return (mm->free_area_cache = addr);
+		else
+			/* pull free_area_cache down to the first hole */
+			if (mm->free_area_cache == vma->vm_end)
+				mm->free_area_cache = vma->vm_start;
+
+		/* try just below the current vma->vm_start */
+		addr = vma->vm_start-len;
+	} while (len <= vma->vm_start);
+
+fail:
+	/*
+	 * if hint left us with no space for the requested
+	 * mapping then try again:
+	 */
+	if (first_time) {
+		mm->free_area_cache = base;
+		first_time = 0;
+		goto try_again;
+	}
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
+	/*
+	 * Restore the topdown base:
+	 */
+	mm->free_area_cache = base;
+
+	return addr;
+}
+
 static unsigned long htlb_get_low_area(unsigned long len, u16 segmask)
 {
 	unsigned long addr = 0;
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-ppc64/pgtable.h current/include/asm-ppc64/pgtable.h
--- reference/include/asm-ppc64/pgtable.h	2004-08-25 12:13:41.000000000 +0100
+++ current/include/asm-ppc64/pgtable.h	2004-08-26 12:29:36.000000000 +0100
@@ -167,6 +167,7 @@ int hash_huge_page(struct mm_struct *mm,
 #endif /* __ASSEMBLY__ */
 
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 #else
 
 #define hash_huge_page(mm,a,ea,vsid,local)	-1
