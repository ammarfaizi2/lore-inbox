Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWHKJWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWHKJWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWHKJWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:22:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:41350 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750979AbWHKJWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:22:02 -0400
Date: Fri, 11 Aug 2006 02:22:01 -0700
Message-Id: <200608110922.k7B9M1Zt023372@zach-dev.vmware.com>
Subject: [PATCH 9/9] 00mme update pte hook.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:22:01.0567 (UTC) FILETIME=[9A3C86F0:01C6BD27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pte_update_hook which notifies about pte changes that have been made
without using the set_pte / clear_pte interfaces.  This allows shadow mode
hypervisors which do not trap on page table access to maintain synchronized
shadows.

It also turns out, there was one pte update in PAE mode that wasn't using
any accessor interface at all for setting NX protection.  Considering it
is PAE specific, and the accessor is i386 specific, I didn't want to add
a generic encapsulation of this behavior yet.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -493,6 +493,7 @@ int __init set_kernel_exec(unsigned long
 		pte->pte_high &= ~(1 << (_PAGE_BIT_NX - 32));
 	else
 		pte->pte_high |= 1 << (_PAGE_BIT_NX - 32);
+	pte_update_defer(&init_mm, vaddr, pte);
 	__flush_tlb_all();
 out:
 	return ret;
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -247,6 +247,23 @@ static inline pte_t pte_mkhuge(pte_t pte
 #endif
 
 /*
+ * Rules for using pte_update - it must be called after any PTE update which
+ * has not been done using the set_pte / clear_pte interfaces.  It is used by
+ * shadow mode hypervisors to resynchronize the shadow page tables.  Kernel PTE
+ * updates should either be sets, clears, or set_pte_atomic for P->P
+ * transitions, which means this hook should only be called for user PTEs.
+ * This hook implies a P->P protection or access change has taken place, which
+ * requires a subsequent TLB flush.  The notification can optionally be delayed
+ * until the TLB flush event by using the pte_update_defer form of the
+ * interface, but care must be taken to assure that the flush happens while
+ * still holding the same page table lock so that the shadow and primary pages
+ * do not become out of sync on SMP.
+ */
+#define pte_update(mm, addr, ptep)		do { } while (0)
+#define pte_update_defer(mm, addr, ptep)	do { } while (0)
+
+
+/*
  * We only update the dirty/accessed state if we set
  * the dirty bit by hand in the kernel, since the hardware
  * will do the accessed bit for us, and we don't want to
@@ -258,6 +275,7 @@ do {									\
 do {									\
 	if (dirty) {							\
 		(ptep)->pte_low = (entry).pte_low;			\
+		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
 		flush_tlb_page(vma, address);				\
 	}								\
 } while (0)
@@ -287,6 +305,7 @@ do {									\
 	__dirty = pte_dirty(*(ptep));					\
 	if (__dirty) {							\
 		clear_bit(_PAGE_BIT_DIRTY, &(ptep)->pte_low);		\
+		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
 		flush_tlb_page(vma, address);				\
 	}								\
 	__dirty;							\
@@ -299,6 +318,7 @@ do {									\
 	__young = pte_young(*(ptep));					\
 	if (__young) {							\
 		clear_bit(_PAGE_BIT_ACCESSED, &(ptep)->pte_low);	\
+		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
 		flush_tlb_page(vma, address);				\
 	}								\
 	__young;							\
@@ -321,6 +341,7 @@ static inline void ptep_set_wrprotect(st
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
+	pte_update(mm, addr, ptep);
 }
 
 /*
