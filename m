Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUJVUgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUJVUgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJVUe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:34:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:8420 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267807AbUJVU3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:29:52 -0400
Date: Fri, 22 Oct 2004 13:29:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
In-Reply-To: <20041022154219.GY17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410221318370.9833@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com>
 <20041022103708.GK17038@holomorphy.com> <Pine.LNX.4.58.0410220829200.7868@schroedinger.engr.sgi.com>
 <20041022154219.GY17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:

> update_mmu_cache() is stage (3). Linux' software pagetable
> modifications are step (2). Generally, architectures are trying to fold
> stages (2) and (3) together in set_huge_pte(), so update_mmu_cache() is
> not so much of an issue for them (and it's actually incorrect to do
> this multiple times or without the architectures' awareness of hugepages
> in update_mmu_cache() and so on). To completely regularize the hugetlb
> case, merely move the commitment to cpu-native structures or other TLB
> insertion done within set_huge_pte() to a new case in update_mmu_cache()
> for large pages.

Ok. I have done so in the following patch but no for all archs yet. Will
work on that next week and then post V2 of the patch.

> What is in fact far more pressing is flush_dcache_page(), without a
> correct implementation of which for hugetlb, user-visible data
> corruption follows.

When is flush_dcache_page used on a huge page?

It seems that the i386 simply does nothing for flush_dcache_page. IA64
defers to update_mmu_cache by setting PG_arch_1. So these two are ok as
is.

The other archs are likely much more involved than this. I tried to find
an simple way to identify a page as a huge page via struct page but
that is not that easy and its likely not good to follow
pointers to pointers in such a critical function. Maybe we need to add a
new page flag?

Index: linux-2.6.9/arch/ia64/mm/init.c
===================================================================
--- linux-2.6.9.orig/arch/ia64/mm/init.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/ia64/mm/init.c	2004-10-22 13:07:36.000000000 -0700
@@ -95,6 +95,26 @@
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }

+void
+huge_update_mmu_cache_hpte (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte)
+{
+	unsigned long addr;
+	struct page *page;
+
+	if (!pte_exec(pte))
+		return;				/* not an executable page... */
+
+	page = pte_page(pte);
+	/* don't use VADDR: it may not be mapped on this CPU (or may have just been flushed): */
+	addr = (unsigned long) page_address(page);
+
+	if (test_bit(PG_arch_1, &page->flags))
+		return;				/* i-cache is already coherent with d-cache */
+
+	flush_icache_range(addr, addr + HPAGE_SIZE);
+	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
+}
+
 inline void
 ia64_set_rbs_bot (void)
 {
Index: linux-2.6.9/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-ia64/pgtable.h	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/include/asm-ia64/pgtable.h	2004-10-22 13:23:55.000000000 -0700
@@ -482,6 +482,7 @@
  * flushing that may be necessary.
  */
 extern void update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);
+extern void huge_update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);

 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 /*
Index: linux-2.6.9/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-i386/pgtable.h	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/include/asm-i386/pgtable.h	2004-10-22 13:09:46.000000000 -0700
@@ -389,6 +389,7 @@
  * bit at the same time.
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
+#define huge_update_mmu_cache(vma,address,pte) do { } while (0)
 #define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
 	do {								  \
Index: linux-2.6.9/include/asm-sparc64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-sparc64/pgtable.h	2004-10-18 14:53:06.000000000 -0700
+++ linux-2.6.9/include/asm-sparc64/pgtable.h	2004-10-22 13:13:40.000000000 -0700
@@ -347,6 +347,7 @@

 struct vm_area_struct;
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
+extern void huge_update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);

 /* Make a non-present pseudo-TTE. */
 static inline pte_t mk_pte_io(unsigned long page, pgprot_t prot, int space)
Index: linux-2.6.9/include/asm-sh64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-sh64/pgtable.h	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/include/asm-sh64/pgtable.h	2004-10-22 13:11:52.000000000 -0700
@@ -462,6 +462,7 @@

 extern void update_mmu_cache(struct vm_area_struct * vma,
 			     unsigned long address, pte_t pte);
+#define huge_update_mmu_cache update_mmu_cache

 /* Encode and decode a swap entry */
 #define __swp_type(x)			(((x).val & 3) + (((x).val >> 1) & 0x3c))
