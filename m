Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVAEAfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVAEAfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVAEAex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:34:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57489 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261761AbVAEAaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:30:10 -0500
Date: Tue, 4 Jan 2005 16:29:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Adam Litke <agl@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Akinobu Mita <amgta@yacht.ocn.ne.jp>, nickpiggin@yahoo.com.au,
       Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Anticipatory prefaulting in the page fault handler V4
In-Reply-To: <1103052678.28318.446.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501041628320.1980@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
  <156610000.1102546207@flay>  <Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com>
  <200412132330.23893.amgta@yacht.ocn.ne.jp> 
 <Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com>  <8880000.1102976179@flay>
  <Pine.LNX.4.58.0412131730410.817@schroedinger.engr.sgi.com>
 <1103052678.28318.446.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes from V3 to V4:
- Add /proc/sys/vm/max_prealloc_order to limit preallocations
- Tested against 2.6.10-bk7

(This version of the patch is not depending on atomic pte operations and will
conflict with the page fault scalabilty patchset. I have another patch
that works with atomic pte operations)

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

Patch against 2.6.10-bk7:

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-01-04 13:55:00.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-01-04 14:00:27.000000000 -0800
@@ -537,6 +537,8 @@
 #endif

 	struct list_head tasks;
+	unsigned long anon_fault_next_addr;	/* Predicted sequential fault address */
+	int anon_fault_order;			/* Last order of allocation on fault */
 	/*
 	 * ptrace_list/ptrace_children forms the list of my children
 	 * that were stolen by a ptracer.
Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-04 13:55:00.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-04 14:00:27.000000000 -0800
@@ -57,6 +57,7 @@

 #include <linux/swapops.h>
 #include <linux/elf.h>
+#include <linux/pagevec.h>

 #ifndef CONFIG_DISCONTIGMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
@@ -1626,6 +1627,8 @@
 	return ret;
 }

+int sysctl_max_prealloc_order = 4;
+
 /*
  * We are called with the MM semaphore and page_table_lock
  * spinlock held to protect against concurrent faults in
@@ -1637,52 +1640,105 @@
 		unsigned long addr)
 {
 	pte_t entry;
-	struct page * page = ZERO_PAGE(addr);
+ 	unsigned long end_addr;
+
+	addr &= PAGE_MASK;

-	/* Read-only mapping of ZERO_PAGE. */
-	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+ 	if (likely((vma->vm_flags & VM_RAND_READ)
+		|| current->anon_fault_next_addr != addr)
+		|| current->anon_fault_order >= sysctl_max_prealloc_order) {
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
+			page_table = pte_offset_map(pmd, addr);
+			if (likely(pte_none(*page_table)))
+				goto nextread;
 		}
-		mm->rss++;
-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
-		lru_cache_add_active(page);
-		SetPageReferenced(page);
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
Index: linux-2.6.10/kernel/sysctl.c
===================================================================
--- linux-2.6.10.orig/kernel/sysctl.c	2005-01-04 13:55:00.000000000 -0800
+++ linux-2.6.10/kernel/sysctl.c	2005-01-04 14:00:27.000000000 -0800
@@ -56,6 +56,7 @@
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
+extern int sysctl_max_prealloc_order;
 extern int max_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
@@ -826,6 +827,16 @@
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_MAX_PREFAULT_ORDER,
+		.procname	= "max_prealloc_order",
+		.data		= &sysctl_max_prealloc_order,
+		.maxlen		= sizeof(sysctl_max_prealloc_order),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };

Index: linux-2.6.10/include/linux/sysctl.h
===================================================================
--- linux-2.6.10.orig/include/linux/sysctl.h	2005-01-04 13:55:00.000000000 -0800
+++ linux-2.6.10/include/linux/sysctl.h	2005-01-04 14:00:27.000000000 -0800
@@ -169,6 +169,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_MAX_PREFAULT_ORDER=29, /* max prefault order during anonymous page faults */
 };


