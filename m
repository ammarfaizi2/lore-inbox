Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUJZCEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUJZCEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUJZCBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:01:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47247 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262066AbUJZBaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:30:10 -0400
Date: Mon, 25 Oct 2004 18:29:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [4/8]: ia64 arch modifications
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410251828550.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Provide huge_update_mmu_cache that flushes an huge page from the icache if necessary
	* flush_dcache_page does nothing on ia64 and thus does not need to be extended
	* Built and tested

Index: linux-2.6.9/arch/ia64/mm/init.c
===================================================================
--- linux-2.6.9.orig/arch/ia64/mm/init.c	2004-10-21 12:01:21.000000000 -0700
+++ linux-2.6.9/arch/ia64/mm/init.c	2004-10-25 15:32:35.000000000 -0700
@@ -95,6 +95,26 @@
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }

+void
+huge_update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte)
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
+++ linux-2.6.9/include/asm-ia64/pgtable.h	2004-10-25 15:31:39.000000000 -0700
@@ -481,7 +481,8 @@
  * information.  However, we use this routine to take care of any (delayed) i-cache
  * flushing that may be necessary.
  */
-extern void update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);
+extern void update_mmu_cache(struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);
+extern void huge_update_mmu_cache(struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);

 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 /*

