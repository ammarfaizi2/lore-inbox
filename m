Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbULMRQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbULMRQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbULMRQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:16:02 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15014 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261283AbULMRLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:11:42 -0500
Date: Mon, 13 Dec 2004 09:10:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, nickpiggin@yahoo.com.au,
       Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
In-Reply-To: <200412132330.23893.amgta@yacht.ocn.ne.jp>
Message-ID: <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <156610000.1102546207@flay> <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com>
 <200412132330.23893.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Akinobu Mita wrote:

> I also encountered processes segfault.
> Below patch fix several problems.
>
> 1) if no pages could allocated, returns VM_FAULT_OOM
> 2) fix duplicated pte_offset_map() call

I also saw these two issues and I think I dealt with them in a forthcoming
patch.

> 3) don't set_pte() for the entry which already have been set

Not sure how this could have happened in the patch.

Could you try my updated version:

Index: linux-2.6.9/include/linux/sched.h
===================================================================
--- linux-2.6.9.orig/include/linux/sched.h	2004-12-08 15:01:48.801457702 -0800
+++ linux-2.6.9/include/linux/sched.h	2004-12-08 15:02:04.286479345 -0800
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
--- linux-2.6.9.orig/mm/memory.c	2004-12-08 15:01:50.668339751 -0800
+++ linux-2.6.9/mm/memory.c	2004-12-09 14:21:17.090061608 -0800
@@ -55,6 +55,7 @@

 #include <linux/swapops.h>
 #include <linux/elf.h>
+#include <linux/pagevec.h>

 #ifndef CONFIG_DISCONTIGMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
@@ -1432,52 +1433,99 @@
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
+		else
+			end_addr = addr + PAGEVEC_SIZE * PAGE_SIZE;

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
+		struct page **p;
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
+		for(p = pv.pages; addr < a; addr += PAGE_SIZE, p++) {
+
+			page_table = pte_offset_map(pmd, addr);
+			if (unlikely(!pte_none(*page_table))) {
+				/* Someone else got there first */
+				pte_unmap(page_table);
+				page_cache_release(*p);
+				continue;
+			}
+
+ 			entry = maybe_mkwrite(pte_mkdirty(mk_pte(*p,
+ 						 vma->vm_page_prot)),
+ 					      vma);
+
+			mm->rss++;
+			lru_cache_add_active(*p);
+			mark_page_accessed(*p);
+			page_add_anon_rmap(*p, vma, addr);
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

