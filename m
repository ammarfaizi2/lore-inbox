Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWHKJTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWHKJTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWHKJTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:19:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2734 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751001AbWHKJTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:19:33 -0400
Date: Fri, 11 Aug 2006 02:19:32 -0700
Message-Id: <200608110919.k7B9JWJh023348@zach-dev.vmware.com>
Subject: [PATCH 5/9] 00mm6 kpte flush.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:19:32.0778 (UTC) FILETIME=[418D20A0:01C6BD27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new PTE function which combines clearing a kernel PTE with the
subsequent flush.  This allows the two to be easily combined into a single
hypercall or paravirt-op.  More subtly, reverse the order of the flush for
kmap_atomic.  Instead of flushing on establishing a mapping, flush on
clearing a mapping.  This eliminates the possibility of leaving stale
kmap entries which may still have valid TLB mappings.  This is required
for direct mode hypervisors, which need to reprotect all mappings of a
given page when changing the page type from a normal page to a protected
page (such as a page table or descriptor table page).  But it also provides
some nicer semantics for real hardware, by providing extra debug-proofing
against using stale mappings, as well as ensuring that no stale mappings
exist when changing the cacheability attributes of a page, which could
lead to cache conflicts when two different types of mappings exist for the
same page.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/mm/highmem.c
+++ b/arch/i386/mm/highmem.c
@@ -44,22 +44,19 @@ void *kmap_atomic(struct page *page, enu
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
 	if (!pte_none(*(kmap_pte-idx)))
 		BUG();
-#endif
 	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
-	__flush_tlb_one(vaddr);
 
 	return (void*) vaddr;
 }
 
 void kunmap_atomic(void *kvaddr, enum km_type type)
 {
-#ifdef CONFIG_DEBUG_HIGHMEM
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
+#ifdef CONFIG_DEBUG_HIGHMEM
 	if (vaddr >= PAGE_OFFSET && vaddr < (unsigned long)high_memory) {
 		dec_preempt_count();
 		preempt_check_resched();
@@ -68,14 +65,14 @@ void kunmap_atomic(void *kvaddr, enum km
 
 	if (vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx))
 		BUG();
-
+#endif
 	/*
-	 * force other mappings to Oops if they'll try to access
-	 * this pte without first remap it
+	 * Force other mappings to Oops if they'll try to access this pte
+	 * without first remap it.  Keeping stale mappings around is a bad idea
+	 * also, in case the page changes cacheability attributes or becomes
+	 * a protected page in a hypervisor.
 	 */
-	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	__flush_tlb_one(vaddr);
-#endif
+	kpte_clear_flush(kmap_pte-idx, vaddr);
 
 	dec_preempt_count();
 	preempt_check_resched();
@@ -94,7 +91,6 @@ void *kmap_atomic_pfn(unsigned long pfn,
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
-	__flush_tlb_one(vaddr);
 
 	return (void*) vaddr;
 }
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -441,6 +441,13 @@ extern pte_t *lookup_address(unsigned lo
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
 
+/* Clear a kernel PTE and flush it from the TLB */
+#define kpte_clear_flush(ptep, vaddr)					\
+do {									\
+	pte_clear(&init_mm, vaddr, ptep);				\
+	__flush_tlb_one(vaddr);						\
+} while (0)
+
 /*
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
