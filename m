Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbULQDtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbULQDtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 22:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbULQDrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 22:47:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1233 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262744AbULQDjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 22:39:12 -0500
Date: Thu, 16 Dec 2004 19:39:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V13 [8/8]: Prefaulting using ptep_cmpxchg
In-Reply-To: <Pine.LNX.4.58.0412161931460.11341@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412161938250.11341@schroedinger.engr.sgi.com>
References: <41BBF923.6040207@yahoo.com.au>
 <Pine.LNX.4.44.0412120914190.3476-100000@localhost.localdomain>
 <20041212212456.GB2714@holomorphy.com> <Pine.LNX.4.58.0412161931460.11341@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page fault handler for anonymous pages can generate significant overhead
apart from its essential function which is to clear and setup a new page
table entry for a never accessed memory location. This overhead increases
significantly in an SMP environment.

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

The order of preallocation may be controlled through setting the maximum order
in /proc/sys/vm/max_prealloc_order. Setting it to zero will disable
preallocations.

Signed_off_by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/linux/sched.h
===================================================================
--- linux-2.6.9.orig/include/linux/sched.h	2004-12-16 10:59:26.000000000 -0800
+++ linux-2.6.9/include/linux/sched.h	2004-12-16 11:06:37.000000000 -0800
@@ -548,6 +548,9 @@
 	struct list_head ptrace_list;

 	struct mm_struct *mm, *active_mm;
+	/* Prefaulting */
+	unsigned long anon_fault_next_addr;
+	int anon_fault_order;
 	/* Split counters from mm */
 	long rss;
 	long anon_rss;
Index: linux-2.6.9/mm/memory.c
===================================================================
--- linux-2.6.9.orig/mm/memory.c	2004-12-16 10:59:26.000000000 -0800
+++ linux-2.6.9/mm/memory.c	2004-12-16 11:06:37.000000000 -0800
@@ -1437,6 +1437,8 @@
 	return ret;
 }

+int sysctl_max_prealloc_order = 3;
+
 /*
  * We are called with the MM semaphore held.
  */
@@ -1445,57 +1447,103 @@
 		pte_t *page_table, pmd_t *pmd, int write_access,
 		unsigned long addr, pte_t orig_entry)
 {
-	pte_t entry;
-	struct page * page = ZERO_PAGE(addr);
+	unsigned long end_addr;
+
+	addr &= PAGE_MASK;
+
+	/* Check if there is a sequential allocation of pages */
+	if (likely((vma->vm_flags & VM_RAND_READ) || current->anon_fault_next_addr != addr)) {
+
+		/* Single page */
+		current->anon_fault_order = 0;
+		end_addr = addr + PAGE_SIZE;
+
+	} else {
+		int order = ++current->anon_fault_order;
+
+		/*
+		 * Calculate the number of pages to preallocate. The order of preallocations
+		 * increases with each successful prediction
+		 */
+		if (unlikely(order > sysctl_max_prealloc_order))
+			order = current->anon_fault_order = sysctl_max_prealloc_order;

-	/* Read-only mapping of ZERO_PAGE. */
-	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+		end_addr = addr + (PAGE_SIZE << order);
+
+		/* Do not prefault beyond vm limits */
+		if (end_addr > vma->vm_end)
+			end_addr = vma->vm_end;
+
+		/* Stay in pmd */
+		if ((addr & PMD_MASK) != (end_addr & PMD_MASK))
+		end_addr &= PMD_MASK;
+	}

-	/* ..except if it's a write access */
 	if (write_access) {
-		/* Allocate our own private page. */
-		pte_unmap(page_table);
+		int count = 0;

 		if (unlikely(anon_vma_prepare(vma)))
-			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-		if (!page)
-			goto no_mem;
-		clear_user_highpage(page, addr);
+			return VM_FAULT_OOM;

-		page_table = pte_offset_map(pmd, addr);
+		do {
+			pte_t entry;
+			struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+
+			if (unlikely(!page)) {
+				if (!count)
+					return VM_FAULT_OOM;
+				else
+					break;
+			}
+
+			clear_user_highpage(page, addr);
+
+			entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
+							vma->vm_page_prot)),
+						vma);
+
+			/* update the entry */
+			if (unlikely(!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry))) {
+				pte_unmap(page_table);
+				page_cache_release(page);
+				break;
+			}
+
+			page_add_anon_rmap(page, vma, addr);
+			lru_cache_add_active(page);
+			count++;

-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
-	}
+			pte_unmap(page_table);
+			addr += PAGE_SIZE;
+			if (addr >= end_addr)
+				break;
+			page_table = pte_offset_map(pmd, addr);
+			orig_entry = *page_table;
+
+		} while (pte_none(orig_entry));
+
+		current->rss += count;
+		current->anon_rss += count;
+
+	} else {
+		pte_t entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+		/* Read */
+		do {
+			if (unlikely(!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry)))
+			break;

-	/* update the entry */
-	if (!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry)) {
-		if (write_access) {
 			pte_unmap(page_table);
-			page_cache_release(page);
-		}
-		goto out;
-	}
-	if (write_access) {
-		/*
-		 * These two functions must come after the cmpxchg
-		 * because if the page is on the LRU then try_to_unmap may come
-		 * in and unmap the pte.
-		 */
-		page_add_anon_rmap(page, vma, addr);
-		lru_cache_add_active(page);
-		mm->rss++;
-		mm->anon_rss++;
-
+			addr += PAGE_SIZE;
+
+			if (addr >= end_addr)
+				break;
+			page_table = pte_offset_map(pmd, addr);
+			orig_entry = *page_table;
+		} while (pte_none(orig_entry));
 	}
-	pte_unmap(page_table);

-out:
-	return VM_FAULT_MINOR;
-no_mem:
-	return VM_FAULT_OOM;
+	current->anon_fault_next_addr = addr;
+        return VM_FAULT_MINOR;
 }

 /*
Index: linux-2.6.9/kernel/sysctl.c
===================================================================
--- linux-2.6.9.orig/kernel/sysctl.c	2004-12-15 15:00:22.000000000 -0800
+++ linux-2.6.9/kernel/sysctl.c	2004-12-16 11:06:37.000000000 -0800
@@ -56,6 +56,7 @@
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
+extern int sysctl_max_prealloc_order;
 extern int max_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
@@ -816,6 +817,16 @@
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

Index: linux-2.6.9/include/linux/sysctl.h
===================================================================
--- linux-2.6.9.orig/include/linux/sysctl.h	2004-12-15 15:00:22.000000000 -0800
+++ linux-2.6.9/include/linux/sysctl.h	2004-12-16 11:06:37.000000000 -0800
@@ -168,6 +168,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_MAX_PREFAULT_ORDER=29, /* max prefault order during anonymous page faults */
 };



