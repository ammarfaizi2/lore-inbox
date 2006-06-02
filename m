Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWFBOIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWFBOIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWFBOIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:08:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35212 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932119AbWFBOIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:08:37 -0400
Subject: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
	vma close
From: Adam Litke <agl@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: linux-mm@kvack.org, David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org, "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 02 Jun 2006 09:08:06 -0500
Message-Id: <1149257287.9693.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc: Close hugetlb regions when unmapping VMAs

On powerpc, each segment can contain pages of only one size.  When a
hugetlb mapping is requested, a segment is located and marked for use
with huge pages.  This is a uni-directional operation -- hugetlb
segments are never marked for use again with normal pages.  For long
running processes which make use of a combination of normal and hugetlb
mappings, this behavior can unduly constrain the virtual address space.

The following patch introduces a architecture-specific vm_ops.close()
hook.  For all architectures besides powerpc, this is a no-op.  On
powerpc, the low and high segments are scanned to locate empty hugetlb
segments which can be made available for normal mappings.  Comments?

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c |   39 ++++++++++++++++++++++++++++++++++++++-
 include/asm-powerpc/pgtable.h |    1 +
 include/linux/hugetlb.h       |    6 ++++++
 mm/hugetlb.c                  |    1 +
 4 files changed, 46 insertions(+), 1 deletion(-)
diff -upN reference/arch/powerpc/mm/hugetlbpage.c current/arch/powerpc/mm/hugetlbpage.c
--- reference/arch/powerpc/mm/hugetlbpage.c
+++ current/arch/powerpc/mm/hugetlbpage.c
@@ -297,7 +297,6 @@ void hugetlb_free_pgd_range(struct mmu_g
 	start = addr;
 	pgd = pgd_offset((*tlb)->mm, addr);
 	do {
-		BUG_ON(! in_hugepage_area((*tlb)->mm->context, addr));
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
@@ -494,6 +493,44 @@ static int open_high_hpage_areas(struct 
 	return 0;
 }
 
+/*
+ * Called when tearing down a hugetlb vma.  See if we can free up any
+ * htlb areas so normal pages can be mapped there again.
+ */
+void arch_hugetlb_close_vma(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long i;
+	struct slb_flush_info fi;
+	u16 inuse, hiflush, loflush;
+
+	if (!mm)
+		return;
+
+	inuse = mm->context.low_htlb_areas;
+	for (i = 0; i < NUM_LOW_AREAS; i++)
+		if (prepare_low_area_for_htlb(mm, i) == 0)
+			inuse &= ~(1 << i);
+	loflush = inuse ^ mm->context.low_htlb_areas;
+	mm->context.low_htlb_areas = inuse;
+
+	inuse = mm->context.high_htlb_areas;
+	for (i = 0; i < NUM_HIGH_AREAS; i++)
+		if (prepare_high_area_for_htlb(mm, i) == 0)
+			inuse &= ~(1 << i);
+	hiflush = inuse ^ mm->context.high_htlb_areas;
+	mm->context.high_htlb_areas = inuse;
+
+	/* the context changes must make it to memory before the flush,
+	 * so that further SLB misses do the right thing. */
+	mb();
+	fi.mm = mm;
+	if ((fi.newareas = loflush))
+		on_each_cpu(flush_low_segments, &fi, 0, 1);
+	if ((fi.newareas = hiflush))
+		on_each_cpu(flush_high_segments, &fi, 0, 1);
+}
+
 int prepare_hugepage_range(unsigned long addr, unsigned long len)
 {
 	int err = 0;
diff -upN reference/include/asm-powerpc/pgtable.h current/include/asm-powerpc/pgtable.h
--- reference/include/asm-powerpc/pgtable.h
+++ current/include/asm-powerpc/pgtable.h
@@ -155,6 +155,7 @@ extern unsigned long empty_zero_page[PAG
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define ARCH_HAS_HUGETLB_CLOSE_VMA
 
 #endif
 
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h
+++ current/include/linux/hugetlb.h
@@ -85,6 +85,12 @@ pte_t huge_ptep_get_and_clear(struct mm_
 void hugetlb_prefault_arch_hook(struct mm_struct *mm);
 #endif
 
+#ifndef ARCH_HAS_HUGETLB_CLOSE_VMA
+#define arch_hugetlb_close_vma(x)	0
+#else
+void arch_hugetlb_close_vma(struct vm_area_struct *vma);
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -399,6 +399,7 @@ static struct page *hugetlb_nopage(struc
 
 struct vm_operations_struct hugetlb_vm_ops = {
 	.nopage = hugetlb_nopage,
+	.close = arch_hugetlb_close_vma,
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

