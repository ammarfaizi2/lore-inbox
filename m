Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbULNBdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbULNBdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULNBdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:33:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:9857 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261364AbULNBcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:32:53 -0500
Date: Mon, 13 Dec 2004 17:32:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Akinobu Mita <amgta@yacht.ocn.ne.jp>, nickpiggin@yahoo.com.au,
       Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Anticipatory prefaulting in the page fault handler V2
In-Reply-To: <8880000.1102976179@flay>
Message-ID: <Pine.LNX.4.58.0412131730410.817@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain><156610000.1102546207@flay>
 <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com><200412132330.23893.amgta@yacht.ocn.ne.jp>
 <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com> <8880000.1102976179@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V1 to V2:
- Eliminate duplicate code and reorganize things
- Use SetReferenced instead of mark_accessed (Hugh Dickins)
- Fix the problem of the preallocation order increasing out of bounds
(leading to memory being overwritten with pointers to struct page)
- Return VM_FAULT_OOM if not able to allocate a single page
- Tested on i386 and ia64
- New performance test for low cpu counts (up to 8 so that this does not
seem to be too exotic)

The page fault handler for anonymous pages can generate significant overhead
apart from its essential function which is to clear and setup a new page
table entry for a never accessed memory location. This overhead increases
significantly in an SMP environment.

In the page table scalability patches, we addressed the issue by changing
the locking scheme so that multiple fault handlers are able to be processed
concurrently on multiple cpus. This patch attempts to aggregate multiple
page faults into a single one. It does that by noting
anonymous page faults generated in sequence by an application.

If a fault occurred for page x and is then followed by page x+1 then it may
be reasonable to expect another page fault at x+2 in the future. If page
table entries for x+1 and x+2 would be prepared in the fault handling for
page x+1 then the overhead of taking a fault for x+2 is avoided. However
page x+2 may never be used and thus we may have increased the rss
of an application unnecessarily. The swapper will take care of removing
that page if memory should get tight.

The following patch makes the anonymous fault handler anticipate future
faults. For each fault a prediction is made where the fault would occur
(assuming linear acccess by the application). If the prediction turns out to
be right (next fault is where expected) then a number of pages is
preallocated in order to avoid a series of future faults. The order of the
preallocation increases by the power of two for each success in sequence.

The first successful prediction leads to an additional page being allocated.
Second successful prediction leads to 2 additional pages being allocated.
Third to 4 pages and so on. The max order is 3 by default. In a large
continous allocation the number of faults is reduced by a factor of 8.

Standard Kernel on a 8 Cpu machine allocating 1 and 4GB with an increasing
number of threads (and thus increasing parallellism of page faults):

ia64 2.6.10-rc3-bk7

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  1   3    1    0.047s      2.163s   2.021s 88925.153  88859.030
  1   3    2    0.040s      3.215s   1.069s 60385.889 115677.685
  1   3    4    0.041s      3.509s   1.023s 55370.338 158971.609
  1   3    8    0.047s      4.130s   1.014s 47049.904 172405.990

Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4   3    1    0.155s     11.277s  11.043s 68788.420  68747.223
  4   3    2    0.161s     16.459s   8.061s 47315.277  91322.962
  4   3    4    0.170s     14.708s   4.079s 52852.007 164043.773
  4   3    8    0.171s     23.257s   4.028s 33565.604 183348.574

ia64 Patched kernel:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  1   3    1    0.008s      2.080s   2.008s 94121.792  94101.359
  1   3    2    0.015s      3.128s   1.064s 62523.771 119563.496
  1   3    4    0.008s      2.714s   1.012s 72185.910 175020.971
  1   3    8    0.016s      2.963s   0.087s 65965.457 223921.949

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4   3    1    0.034s     10.861s  10.089s 72179.444  72181.353
  4   3    2    0.050s     14.303s   7.072s 54786.447 101738.901
  4   3    4    0.038s     13.478s   4.044s 58182.649 176913.840
  4   3    8    0.063s     13.584s   3.007s 57620.638 256109.927

i386 2.6.10-rc3-bk3 256M allocation 2x Pentium III 500 Mhz

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   3    1    0.020s      1.566s   1.058s123827.513 123842.098
  0   3    2    0.017s      2.439s   1.043s 79999.154 136931.671

i386 2.6.10-rc3-bk3 patches

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   3    1    0.020s      1.527s   1.039s126945.181 140930.664
  0   3    2    0.016s      2.417s   1.026s 80754.809 155162.903

Patch against 2.6.10-rc3-bk7:

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/linux/sched.h
===================================================================
--- linux-2.6.9.orig/include/linux/sched.h	2004-12-13 15:14:40.000000000 -0800
+++ linux-2.6.9/include/linux/sched.h	2004-12-13 15:15:55.000000000 -0800
@@ -537,6 +537,8 @@
 #endif

 	struct list_head tasks;
+	unsigned long anon_fault_next_addr;	/* Predicted sequential fault address */
+	int anon_fault_order;			/* Last order of allocation on fault */
 	/*
 	 * ptrace_list/ptrace_children forms the list of my children
 	 * that were stolen by a ptracer.
Index: linux-2.6.9/mm/memory.c
===================================================================
--- linux-2.6.9.orig/mm/memory.c	2004-12-13 15:14:40.000000000 -0800
+++ linux-2.6.9/mm/memory.c	2004-12-13 16:49:31.000000000 -0800
@@ -55,6 +55,7 @@

 #include <linux/swapops.h>
 #include <linux/elf.h>
+#include <linux/pagevec.h>

 #ifndef CONFIG_DISCONTIGMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
@@ -1432,52 +1433,102 @@
 		unsigned long addr)
 {
 	pte_t entry;
-	struct page * page = ZERO_PAGE(addr);
-
-	/* Read-only mapping of ZERO_PAGE. */
-	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+ 	unsigned long end_addr;
+
+	addr &= PAGE_MASK;
+
+ 	if (likely((vma->vm_flags & VM_RAND_READ) || current->anon_fault_next_addr != addr)) {
+		/* Single page */
+		current->anon_fault_order = 0;
+		end_addr = addr + PAGE_SIZE;
+	} else {
+		/* Sequence of faults detect. Perform preallocation */
+ 		int order = ++current->anon_fault_order;
+
+		if ((1 << order) < PAGEVEC_SIZE)
+			end_addr = addr + (PAGE_SIZE << order);
+		else {
+			end_addr = addr + PAGEVEC_SIZE * PAGE_SIZE;
+			current->anon_fault_order = 3;
+		}

-	/* ..except if it's a write access */
+		if (end_addr > vma->vm_end)
+			end_addr = vma->vm_end;
+		if ((addr & PMD_MASK) != (end_addr & PMD_MASK))
+			end_addr &= PMD_MASK;
+	}
 	if (write_access) {
-		/* Allocate our own private page. */
+
+		unsigned long a;
+		int i;
+		struct pagevec pv;
+
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);

+		pagevec_init(&pv, 0);
+
 		if (unlikely(anon_vma_prepare(vma)))
-			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-		if (!page)
-			goto no_mem;
-		clear_user_highpage(page, addr);
+			return VM_FAULT_OOM;
+
+		/* Allocate the necessary pages */
+		for(a = addr; a < end_addr ; a += PAGE_SIZE) {
+			struct page *p = alloc_page_vma(GFP_HIGHUSER, vma, a);
+
+			if (likely(p)) {
+				clear_user_highpage(p, a);
+				pagevec_add(&pv, p);
+			} else {
+				if (a == addr)
+					return VM_FAULT_OOM;
+				break;
+			}
+		}

 		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);

-		if (!pte_none(*page_table)) {
+		for(i = 0; addr < a; addr += PAGE_SIZE, i++) {
+			struct page *p = pv.pages[i];
+
+			page_table = pte_offset_map(pmd, addr);
+			if (unlikely(!pte_none(*page_table))) {
+				/* Someone else got there first */
+				pte_unmap(page_table);
+				page_cache_release(p);
+				continue;
+			}
+
+ 			entry = maybe_mkwrite(pte_mkdirty(mk_pte(p,
+ 						 vma->vm_page_prot)),
+ 					      vma);
+
+			mm->rss++;
+			lru_cache_add_active(p);
+			SetPageReferenced(p);
+			page_add_anon_rmap(p, vma, addr);
+
+			set_pte(page_table, entry);
 			pte_unmap(page_table);
-			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
+
+ 			/* No need to invalidate - it was non-present before */
+ 			update_mmu_cache(vma, addr, entry);
+		}
+ 	} else {
+ 		/* Read */
+		entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+nextread:
+		set_pte(page_table, entry);
+		pte_unmap(page_table);
+		update_mmu_cache(vma, addr, entry);
+		addr += PAGE_SIZE;
+		if (unlikely(addr < end_addr)) {
+			pte_offset_map(pmd, addr);
+			goto nextread;
 		}
-		mm->rss++;
-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
-		lru_cache_add_active(page);
-		mark_page_accessed(page);
-		page_add_anon_rmap(page, vma, addr);
 	}
-
-	set_pte(page_table, entry);
-	pte_unmap(page_table);
-
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, addr, entry);
+	current->anon_fault_next_addr = addr;
 	spin_unlock(&mm->page_table_lock);
-out:
 	return VM_FAULT_MINOR;
-no_mem:
-	return VM_FAULT_OOM;
 }

 /*
