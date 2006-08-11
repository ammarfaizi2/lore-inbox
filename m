Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWHKJSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWHKJSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWHKJSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:18:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:60845 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750959AbWHKJSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:18:20 -0400
Date: Fri, 11 Aug 2006 02:18:18 -0700
Message-Id: <200608110918.k7B9IIcU023336@zach-dev.vmware.com>
Subject: [PATCH 3/9] 00mm3 lazy mmu mode hooks.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:18:18.0524 (UTC) FILETIME=[154ADDC0:01C6BD27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement lazy MMU update hooks which are SMP safe for both direct and
shadow page tables.  The idea is that PTE updates and page invalidations
while in lazy mode can be batched into a single hypercall.  We use this
in VMI for shadow page table synchronization, and it is a win.  It also
can be used by PPC and for direct page tables on Xen.

For SMP, the enter / leave must happen under protection of the page table
locks for page tables which are being modified.  This is because otherwise,
you end up with stale state in the batched hypercall, which other CPUs can
race ahead of.  Doing this under the protection of the locks guarantees
the synchronization is correct, and also means that spurious faults which
are generated during this window by remote CPUs are properly handled, as
the page fault handler must re-check the PTE under protection of the same
lock.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: linux-mm@kvack.org

===================================================================
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -171,6 +171,26 @@ static inline void ptep_set_wrprotect(st
 #endif
 
 /*
+ * A facility to provide lazy MMU batching.  This allows PTE updates and
+ * page invalidations to be delayed until a call to leave lazy MMU mode
+ * is issued.  Some architectures may benefit from doing this, and it is
+ * beneficial for both shadow and direct mode hypervisors, which may batch
+ * the PTE updates which happen during this window.  Note that using this
+ * interface requires that read hazards be removed from the code.  A read
+ * hazard could result in the direct mode hypervisor case, since the actual
+ * write to the page tables may not yet have taken place, so reads though
+ * a raw PTE pointer after it has been modified are not guaranteed to be
+ * up to date.  This mode can only be entered and left under the protection of
+ * the page table locks for all page tables which may be modified.  In the UP
+ * case, this is required so that preemption is disabled, and in the SMP case,
+ * it must synchronize the delayed page table writes properly on other CPUs.
+ */
+#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+#define arch_enter_lazy_mmu_mode()	do {} while (0)
+#define arch_leave_lazy_mmu_mode()	do {} while (0)
+#endif
+
+/*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
  * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
===================================================================
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -506,6 +506,7 @@ again:
 	src_pte = pte_offset_map_nested(src_pmd, addr);
 	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+	arch_enter_lazy_mmu_mode();
 
 	do {
 		/*
@@ -527,6 +528,7 @@ again:
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
+	arch_leave_lazy_mmu_mode();
 	spin_unlock(src_ptl);
 	pte_unmap_nested(src_pte - 1);
 	add_mm_rss(dst_mm, rss[0], rss[1]);
@@ -628,6 +630,7 @@ static unsigned long zap_pte_range(struc
 	int anon_rss = 0;
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = *pte;
 		if (pte_none(ptent)) {
@@ -694,6 +697,7 @@ static unsigned long zap_pte_range(struc
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
 
 	add_mm_rss(mm, file_rss, anon_rss);
+	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
 
 	return addr;
@@ -1109,6 +1113,7 @@ static int zeromap_pte_range(struct mm_s
 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
+	arch_enter_lazy_mmu_mode();
 	do {
 		struct page *page = ZERO_PAGE(addr);
 		pte_t zero_pte = pte_wrprotect(mk_pte(page, prot));
@@ -1118,6 +1123,7 @@ static int zeromap_pte_range(struct mm_s
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
 	return 0;
 }
@@ -1275,11 +1281,13 @@ static int remap_pte_range(struct mm_str
 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
+	arch_enter_lazy_mmu_mode();
 	do {
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
 	return 0;
 }
===================================================================
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -34,6 +34,7 @@ static void change_pte_range(struct mm_s
 	spinlock_t *ptl;
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	arch_enter_lazy_mmu_mode();
 	do {
 		oldpte = *pte;
 		if (pte_present(oldpte)) {
@@ -70,6 +71,7 @@ static void change_pte_range(struct mm_s
 		}
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
 }
 
===================================================================
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -98,6 +98,7 @@ static void move_ptes(struct vm_area_str
 	new_ptl = pte_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+	arch_enter_lazy_mmu_mode();
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
@@ -109,6 +110,7 @@ static void move_ptes(struct vm_area_str
 		set_pte_at(mm, new_addr, new_pte, pte);
 	}
 
+	arch_leave_lazy_mmu_mode();
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	pte_unmap_nested(new_pte - 1);
