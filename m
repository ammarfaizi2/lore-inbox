Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWHKJaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWHKJaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWHKJ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:29:54 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:47503 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751069AbWHKJ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:29:51 -0400
Date: Fri, 11 Aug 2006 02:15:21 -0700
Message-Id: <200608110915.k7B9FLcD023284@zach-dev.vmware.com>
Subject: [PATCH 6/9] 00mm9 optimize ptep establish for pae.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, ":"@vmware.com,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:29:49.0658 (UTC) FILETIME=[B13D8BA0:01C6BD28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ptep_establish macro is only used on user-level PTEs, for P->P mapping
changes.  Since these always happen under protection of the pagetable lock, the
strong synchronization of a 64-bit cmpxchg is not needed, in fact, not
even a lock prefix needs to be used.  We can simply instead clear the P-bit,
followed by a normal set.  The write ordering is still important to avoid the
possibility of the TLB snooping a partially written PTE and getting a bad
mapping installed.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -16,6 +16,7 @@
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
+#define set_pte_present(mm,addr,ptep,pteval) set_pte_at(mm,addr,ptep,pteval)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
===================================================================
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -57,6 +57,21 @@ static inline void set_pte(pte_t *ptep, 
 	ptep->pte_low = pte.pte_low;
 }
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+
+/*
+ * Since this is only called on user PTEs, and the page fault handler
+ * must handle the already racy situation of simultaneous page faults,
+ * we are justified in merely clearing the PTE present bit, followed
+ * by a set.  The ordering here is important.
+ */
+static inline void set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
 
 #define __HAVE_ARCH_SET_PTE_ATOMIC
 #define set_pte_atomic(pteptr,pteval) \
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -269,6 +269,17 @@ do {									\
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 
+/*
+ * Rules for using ptep_establish: the pte MUST be a user pte, and
+ * must be a present->present transition.
+ */
+#define __HAVE_ARCH_PTEP_ESTABLISH
+#define ptep_establish(vma, address, ptep, pteval)			\
+do {									\
+	set_pte_present((vma)->vm_mm, address, ptep, pteval);		\
+	flush_tlb_page(vma, address);					\
+} while (0)
+
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define ptep_clear_flush_dirty(vma, address, ptep)			\
 ({									\
