Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUIITUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUIITUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUIITTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:19:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36272 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266741AbUIITOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:14:18 -0400
Message-ID: <4140AAEB.1010209@engr.sgi.com>
Date: Thu, 09 Sep 2004 12:11:39 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       CSA-ML <csa@oss.sgi.com>, Arthur Corliss <corliss@digitalmages.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Erik Jacobson <erikj@dbear.engr.sgi.com>, Limin Gu <limin@engr.sgi.com>
Subject: [PATCH 2.6.8.1 2/4] CSA  csa_mm: accounting mm data gathering
References: <4140A9D2.3010602@engr.sgi.com>
In-Reply-To: <4140A9D2.3010602@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------080108070403060202040704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080108070403060202040704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linux Comprehensive System Accounting (CSA) is a set of C programs and
shell scripts that, like other accounting packages, provide methods for
collecting per-process resource usage data, monitoring disk usage, and
charging fees to specific login accounts.

The CSA patchset includes csa_io, csa_mm, csa_eop and csa_module.
Patches csa_io, csa_mm, and csa_eop are responsible for system
accounting data collection and are independent of each other.

The csa_mm is a patch that gathers mm activity data.

Please find CSA project at http://oss.sgi.com/projects/csa. This set of
csa patches has been tested with the pagg and job kernel patches.
The information of pagg and job project can be found at
http://oss.sgi.com/projects/pagg/


Signed-off-by: Jay Lan <jlan@sgi.com>


--------------080108070403060202040704
Content-Type: text/plain;
 name="linux-2.6.8.1.csa_mm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8.1.csa_mm.patch"

Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2004-09-03 12:59:18.000000000 -0700
+++ linux/fs/exec.c	2004-09-03 16:22:11.000000000 -0700
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1145,6 +1146,9 @@
 
 		/* execve success */
 		security_bprm_free(&bprm);
+		/* no-op if CONFIG_CSA not set */
+                csa_update_integrals();
+                update_mem_hiwater();
 		return retval;
 	}
 
Index: linux/include/linux/csa_internal.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/csa_internal.h	2004-09-03 16:22:11.000000000 -0700
@@ -0,0 +1,70 @@
+/*
+ * Copyright (c) 2000-2002 Silicon Graphics, Inc and LANL  All Rights Reserved.
+ * Copyright (c) 2004 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1500 Crittenden Lane,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ */
+
+/*
+ *  CSA (Comprehensive System Accounting)
+ *  Job Accounting for Linux
+ *
+ *  This header file contains the definitions needed for communication
+ *  between the kernel and the CSA module.
+ */
+
+#ifndef _LINUX_CSA_INTERNAL_H
+#define _LINUX_CSA_INTERNAL_H
+
+#include <linux/config.h>
+
+#if defined (CONFIG_CSA) || defined (CONFIG_CSA_MODULE)
+
+#include <linux/linkage.h>
+#include <linux/ptrace.h>
+
+static inline void csa_update_integrals(void)
+{
+	long delta;
+
+	if (current->mm) {
+		delta = current->stime - current->csa_stimexpd;
+		current->csa_stimexpd = current->stime;
+		current->csa_rss_mem1 += delta * current->mm->rss;
+		current->csa_vm_mem1 += delta * current->mm->total_vm;
+	}
+}
+
+static inline void csa_clear_integrals(struct task_struct *tsk)
+{
+	if (tsk) {
+		tsk->csa_stimexpd = 0;
+		tsk->csa_rss_mem1 = 0;
+		tsk->csa_vm_mem1 = 0;
+	}	
+}
+
+#else	/* CONFIG_CSA || CONFIG_CSA_MODULE */
+
+#define csa_update_integrals()		do { } while (0)
+#define csa_clear_integrals(task)	do { } while (0)
+#endif	/* CONFIG_CSA || CONFIG_CSA_MODULE */
+
+#endif	/* _LINUX_CSA_INTERNAL_H */
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-09-03 16:18:31.000000000 -0700
+++ linux/include/linux/sched.h	2004-09-03 16:27:19.000000000 -0700
@@ -229,6 +229,8 @@
 	struct kioctx		*ioctx_list;
 
 	struct kioctx		default_kioctx;
+
+	unsigned long hiwater_rss, hiwater_vm;
 };
 
 extern int mmlist_nr;
@@ -525,6 +527,10 @@
 
 /* i/o counters(bytes read/written, #syscalls, waittime */
         unsigned long rchar, wchar, syscr, syscw, bwtime;
+#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)
+	u64 csa_rss_mem1, csa_vm_mem1;
+	clock_t csa_stimexpd;
+#endif
 
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
@@ -873,6 +879,19 @@
 /* Remove the current tasks stale references to the old mm_struct */
 extern void mm_release(struct task_struct *, struct mm_struct *);
 
+/* Update highwater values */
+static inline void update_mem_hiwater(void)
+{
+	if (current->mm) {
+		if (current->mm->hiwater_rss < current->mm->rss) {
+			current->mm->hiwater_rss = current->mm->rss;
+		}
+		if (current->mm->hiwater_vm < current->mm->total_vm) {
+			current->mm->hiwater_vm = current->mm->total_vm;
+		}
+	}
+}
+
 extern int  copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
 extern void flush_thread(void);
 extern void exit_thread(void);
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2004-09-03 12:59:18.000000000 -0700
+++ linux/kernel/exit.c	2004-09-03 16:22:11.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
 #include <linux/pagg.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -821,6 +822,9 @@
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	acct_process(code);
 	__exit_mm(tsk);
 
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-09-03 16:21:20.000000000 -0700
+++ linux/kernel/fork.c	2004-09-03 16:22:11.000000000 -0700
@@ -37,7 +37,7 @@
 #include <linux/audit.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
-
+#include <linux/csa_internal.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -576,6 +576,9 @@
 	if (retval)
 		goto free_pt;
 
+	mm->hiwater_rss = mm->rss;
+	mm->hiwater_vm = mm->total_vm;	
+
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
@@ -966,6 +969,8 @@
 	p->cutime = p->cstime = 0;
 	p->rchar = p->wchar = p->syscr = p->syscw = 0;
 	p->bwtime = 0;
+	/* no-op if CONFIG_CSA not set */
+	csa_clear_integrals(p);
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2004-08-13 22:36:57.000000000 -0700
+++ linux/mm/memory.c	2004-09-03 16:22:11.000000000 -0700
@@ -44,6 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/csa_internal.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -605,6 +606,8 @@
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
+	/* no-op unless CONFIG_CSA is set */
+        csa_update_integrals();
 	spin_unlock(&mm->page_table_lock);
 }
 
@@ -1095,9 +1098,12 @@
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
-		if (PageReserved(old_page))
+		if (PageReserved(old_page)) {
 			++mm->rss;
-		else
+			/* no-op if CONFIG_CSA not set */
+			csa_update_integrals();
+			update_mem_hiwater();
+		} else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
@@ -1378,6 +1384,10 @@
 		remove_exclusive_swap_page(page);
 
 	mm->rss++;
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
+  
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1443,6 +1453,9 @@
 			goto out;
 		}
 		mm->rss++;
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
+		update_mem_hiwater();
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1552,6 +1565,10 @@
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
 			++mm->rss;
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
+		update_mem_hiwater();
+
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
Index: linux/mm/mmap.c
===================================================================
--- linux.orig/mm/mmap.c	2004-08-13 22:37:15.000000000 -0700
+++ linux/mm/mmap.c	2004-09-03 16:22:11.000000000 -0700
@@ -20,6 +20,7 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
+#include <linux/csa_internal.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
@@ -988,6 +989,9 @@
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return addr;
 
 unmap_and_free_vma:
@@ -1227,6 +1231,9 @@
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	/* no-op if CONFIG_CSA_JOB_ACCT not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1688,6 +1695,9 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 	return addr;
 }
 
Index: linux/mm/mremap.c
===================================================================
--- linux.orig/mm/mremap.c	2004-08-13 22:36:59.000000000 -0700
+++ linux/mm/mremap.c	2004-09-03 16:22:11.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/csa_internal.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -231,6 +232,10 @@
 					   new_addr + new_len);
 	}
 
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
+
 	return new_addr;
 }
 
@@ -363,6 +368,9 @@
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
+			/* no-op if CONFIG_CSA not set */
+			csa_update_integrals();
+			update_mem_hiwater();
 			ret = addr;
 			goto out;
 		}
Index: linux/mm/rmap.c
===================================================================
--- linux.orig/mm/rmap.c	2004-08-13 22:37:42.000000000 -0700
+++ linux/mm/rmap.c	2004-09-03 16:22:11.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/csa_internal.h>
 #include <linux/rmap.h>
 
 #include <asm/tlbflush.h>
@@ -515,6 +516,8 @@
 	mm->rss--;
 	BUG_ON(!page->mapcount);
 	page->mapcount--;
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
 	page_cache_release(page);
 
 out_unmap:
@@ -614,6 +617,8 @@
 
 		page_remove_rmap(page);
 		page_cache_release(page);
+		/* no-op if CONFIG_CSA not set */
+		csa_update_integrals();
 		mm->rss--;
 		(*mapcount)--;
 	}
Index: linux/mm/swapfile.c
===================================================================
--- linux.orig/mm/swapfile.c	2004-08-13 22:36:32.000000000 -0700
+++ linux/mm/swapfile.c	2004-09-03 16:22:11.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
+#include <linux/csa_internal.h>
 #include <linux/backing-dev.h>
 
 #include <asm/pgtable.h>
@@ -435,6 +436,9 @@
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
+	/* no-op if CONFIG_CSA not set */
+	csa_update_integrals();
+	update_mem_hiwater();
 }
 
 /* vma->vm_mm->page_table_lock is held */

--------------080108070403060202040704--

