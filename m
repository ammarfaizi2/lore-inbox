Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbUJZCEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUJZCEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUJZCCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:02:14 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63432 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261844AbUJZBbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:31:12 -0400
Date: Mon, 25 Oct 2004 18:30:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [6/8]: sparc64 arch modifications
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410251830010.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Extend update_mmu_cache to handle compound pages
	* Extend flush_dcache_page to handle compound pages
	* Not built and not tested

Index: linux-2.6.9/include/asm-sparc64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-sparc64/pgtable.h	2004-10-18 14:53:06.000000000 -0700
+++ linux-2.6.9/include/asm-sparc64/pgtable.h	2004-10-25 16:56:34.000000000 -0700
@@ -347,6 +347,7 @@

 struct vm_area_struct;
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
+#define huge_update_mmu_cache update_mmu_cache

 /* Make a non-present pseudo-TTE. */
 static inline pte_t mk_pte_io(unsigned long page, pgprot_t prot, int space)
Index: linux-2.6.9/arch/sparc64/mm/init.c
===================================================================
--- linux-2.6.9.orig/arch/sparc64/mm/init.c	2004-10-18 14:53:50.000000000 -0700
+++ linux-2.6.9/arch/sparc64/mm/init.c	2004-10-25 17:32:43.000000000 -0700
@@ -192,6 +192,30 @@
 			     : "g5", "g7");
 }

+static int flush_dcache_pages(struct page *page) {
+	int nr;
+
+	if (!PageCompound(page))
+		return flush_dcache_page_impl(page);
+
+	page = page->private;
+	nr = 1 << page[1].index;
+	while (nr-- >0)
+		flush_dcache_impl(page++)
+}
+
+static int smp_flush_dcache_pages(struct page *page, int cpu) {
+	int nr;
+
+	if (!PageCompound(page))
+		return smp_flush_dcache_page_impl(page, cpu);
+
+	page = page->private;
+	nr = 1 << page[1].index;
+	while (nr-- >0)
+		smp_flush_dcache_impl(page++, cpu)
+}
+
 extern void __update_mmu_cache(unsigned long mmu_context_hw, unsigned long address, pte_t pte, int code);

 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
@@ -211,17 +235,32 @@
 		 * in the SMP case.
 		 */
 		if (cpu == this_cpu)
-			flush_dcache_page_impl(page);
+			flush_dcache_pages(page);
 		else
-			smp_flush_dcache_page_impl(page, cpu);
+			smp_flush_dcache_pages(page, cpu);

 		clear_dcache_dirty_cpu(page, cpu);

 		put_cpu();
 	}
-	if (get_thread_fault_code())
-		__update_mmu_cache(vma->vm_mm->context & TAG_CONTEXT_BITS,
+	if (get_thread_fault_code()) {
+
+		if (PageCompound(page)) {
+			int nr;
+
+			page = page->private;
+			nr = 1 << page[1].index;
+			address = page_address(page);
+			while (nr-- > 0) {
+				__update_mmu_cache(vma->vm_mm->context & TAG_CONTEXT_BITS,
+				   address, pte, get_thread_fault_code());
+				address += PAGE_SIZE;
+			}
+		} else
+			__update_mmu_cache(vma->vm_mm->context & TAG_CONTEXT_BITS,
 				   address, pte, get_thread_fault_code());
+
+	}
 }

 void flush_dcache_page(struct page *page)
@@ -235,9 +274,18 @@
 		if (dirty) {
 			if (dirty_cpu == this_cpu)
 				goto out;
-			smp_flush_dcache_page_impl(page, dirty_cpu);
+			smp_flush_dcache_pages(page, dirty_cpu);
 		}
-		set_dcache_dirty(page, this_cpu);
+
+		if (PageCompound(page)) {
+			int nr=1;
+
+			page = page->private;
+			nr = 1 << page[1].index;
+			while (nr-- >0)
+				set_dcache_dirty(page++, this_cpu);
+		} else
+			set_dcache_dirty(page, this_cpu);
 	} else {
 		/* We could delay the flush for the !page_mapping
 		 * case too.  But that case is for exec env/arg

