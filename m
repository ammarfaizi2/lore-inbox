Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVCKMtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVCKMtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCKMr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:47:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8686 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262702AbVCKMrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:47:04 -0500
Date: Fri, 11 Mar 2005 04:47:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
cc: linux-mm@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Prefaulting 
Message-ID: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to aggregate multiple page faults into a single one. It
does that by detecting that an application generates a sequence of page
faults.

If a fault occurred for page x and is then followed by page x+1 then it may
be reasonable to expect another page fault at x+2 in the future. If page
table entries for x+1 and x+2 would be prepared in the fault handling for
page x+1 then the overhead of taking a fault for x+2 is avoided. However
page x+2 may never be used and thus we may have increased the rss
of an application unnecessarily and also allocated a page for no use
at all. At some point the swapper will take care of removing that page
if memory should get tight.

The first successful prediction leads to an additional page being allocated.
The second successful prediction leads to 2 additional pages being allocated.
Third to 4 pages and so on. In large continous accesses to pages the number of
page faults is reduced by a factor of 8.

The default for this patch is to disable this functionality because other
pages may be uselessly allocated. The maximum order of pages to preallocate
can be changed by writing a value to /proc/sys/vm/max_preallocate_order
and should be set to 4 for applications that use large amounts of memory.

Results that show the impact of this patch are available at
http://oss.sgi.com/projects/page_fault_performance/

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-03-10 12:39:14.000000000 -0800
+++ linux-2.6.11/include/linux/sched.h	2005-03-10 12:39:39.000000000 -0800
@@ -571,6 +571,8 @@ struct task_struct {
 #endif

 	struct list_head tasks;
+	unsigned long anon_fault_next_addr;	/* Predicted sequential fault address */
+	int anon_fault_order;			/* Last order of allocation on fault */
 	/*
 	 * ptrace_list/ptrace_children forms the list of my children
 	 * that were stolen by a ptracer.
Index: linux-2.6.11/mm/memory.c
===================================================================
--- linux-2.6.11.orig/mm/memory.c	2005-03-10 12:39:15.000000000 -0800
+++ linux-2.6.11/mm/memory.c	2005-03-10 12:43:49.000000000 -0800
@@ -57,6 +57,7 @@

 #include <linux/swapops.h>
 #include <linux/elf.h>
+#include <linux/pagevec.h>

 #ifndef CONFIG_DISCONTIGMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
@@ -1786,6 +1787,8 @@ out:
 	return ret;
 }

+int sysctl_max_prealloc_order = 1;
+
 /*
  * We are called with the MM semaphore and page_table_lock
  * spinlock held to protect against concurrent faults in
@@ -1797,51 +1800,104 @@ do_anonymous_page(struct mm_struct *mm,
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
-		page = alloc_zeroed_user_highpage(vma, addr);
-		if (!page)
-			goto no_mem;
+			return VM_FAULT_OOM;
+
+		/* Allocate the necessary pages */
+		for(a = addr; a < end_addr ; a += PAGE_SIZE) {
+			struct page *p = alloc_zeroed_user_highpage(vma, a);
+
+			if (likely(p)) {
+				pagevec_add(&pv, p);
+			} else {
+				if (a == addr)
+					return VM_FAULT_OOM;
+				break;
+			}
+		}

 		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
+		for(i = 0; addr < a; addr += PAGE_SIZE, i++) {
+			struct page *p = pv.pages[i];

-		if (!pte_none(*page_table)) {
+			page_table = pte_offset_map(pmd, addr);
+			if (unlikely(!pte_none(*page_table))) {
+				/* Someone else got there first */
+				pte_unmap(page_table);
+				page_cache_release(p);
+				mm->rss--;
+				continue;
+			}
+
+ 			entry = maybe_mkwrite(pte_mkdirty(mk_pte(p,
+ 						 vma->vm_page_prot)),
+ 					      vma);
+
+		 	lru_cache_add_active(p);
+			SetPageReferenced(p);
+			page_add_anon_rmap(p, vma, addr);
+
+			set_pte_at(mm, addr, page_table, entry);
 			pte_unmap(page_table);
-			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
-			goto out;
+
+ 			/* No need to invalidate - it was non-present before */
+ 			update_mmu_cache(vma, addr, entry);
+		}
+		mm->rss += pagevec_count(&pv);
+ 	} else {
+ 		/* Read */
+		entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+nextread:
+		set_pte_at(mm, addr, page_table, entry);
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
-	set_pte_at(mm, addr, page_table, entry);
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
Index: linux-2.6.11/kernel/sysctl.c
===================================================================
--- linux-2.6.11.orig/kernel/sysctl.c	2005-03-10 12:39:15.000000000 -0800
+++ linux-2.6.11/kernel/sysctl.c	2005-03-10 12:39:39.000000000 -0800
@@ -55,6 +55,7 @@
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
+extern int sysctl_max_prealloc_order;
 extern int max_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
@@ -836,6 +837,16 @@ static ctl_table vm_table[] = {
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

Index: linux-2.6.11/include/linux/sysctl.h
===================================================================
--- linux-2.6.11.orig/include/linux/sysctl.h	2005-03-10 12:39:15.000000000 -0800
+++ linux-2.6.11/include/linux/sysctl.h	2005-03-10 12:39:39.000000000 -0800
@@ -170,6 +170,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_MAX_PREFAULT_ORDER=29, /* max prefault order during anonymous page faults */
 };


