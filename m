Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVBCV21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVBCV21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVBCV20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:28:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9660 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263241AbVBCVWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:22:41 -0500
Date: Thu, 3 Feb 2005 13:22:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
Subject: Re: move-accounting-function-calls-out-of-critical-vm-code-paths.patch
Message-ID: <Pine.LNX.4.58.0502031322180.25289@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As requested by Andrew:

In the 2.6.11 development cycle function calls have been added to lots
of hot vm paths to do accounting. I think these should not go into the
final 2.6.1 release because these statistics can be collected in a different
way that does not require the updating of counters from frequently used
vm code paths and is consistent with the methods use elsewhere in the kernel
to obtain statistics.

These function calls are

acct_update_integrals	-> Account for processes based on stime changes
update_mem_hiwater	-> takes rss and total_vm hiwater marks.

acct_update_integrals is only useful to call if stime changes otherwise
it will simply return. It is therefore best to relocate the function call
to acct_update_integral into the function that updates stime which is
account_system_time and remove it from the vm code paths.

update_mem_hiwater finds the rss hiwater mark. RSS limits are checked in
account_system_time(). Thus is makes most sense to also move the function
call to update_mem_hiwater there. Otherwise a process may have a higher
rss hiwater mark than allowed by rss limits!

This means that the rss limit is not always updated if rss is increased
and thus not as accurate. But the benefit is that the rss checks do no
pollute the vm paths and that it is consistent with the rss limit check.

The following patch removes acct_update_integrals and update_mem_hiwater
from the hot vm paths. This patch is against 2.6.11-rc3.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/mmap.c
===================================================================
--- linux-2.6.10.orig/mm/mmap.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/mm/mmap.c	2005-02-03 12:55:15.000000000 -0800
@@ -21,7 +21,6 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
-#include <linux/acct.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
@@ -1121,8 +1120,6 @@ out:
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
-	acct_update_integrals();
-	update_mem_hiwater();
 	return addr;

 unmap_and_free_vma:
@@ -1463,8 +1460,6 @@ static int acct_stack_growth(struct vm_a
 	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm += grow;
 	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, grow);
-	acct_update_integrals();
-	update_mem_hiwater();
 	return 0;
 }

@@ -1970,8 +1965,6 @@ out:
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
-	acct_update_integrals();
-	update_mem_hiwater();
 	return addr;
 }

Index: linux-2.6.10/mm/mremap.c
===================================================================
--- linux-2.6.10.orig/mm/mremap.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/mm/mremap.c	2005-02-03 12:55:15.000000000 -0800
@@ -16,7 +16,6 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
-#include <linux/acct.h>
 #include <linux/syscalls.h>

 #include <asm/uaccess.h>
@@ -255,9 +254,6 @@ static unsigned long move_vma(struct vm_
 					   new_addr + new_len);
 	}

-	acct_update_integrals();
-	update_mem_hiwater();
-
 	return new_addr;
 }

@@ -394,8 +390,6 @@ unsigned long do_mremap(unsigned long ad
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
-			acct_update_integrals();
-			update_mem_hiwater();
 			ret = addr;
 			goto out;
 		}
Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-02-03 12:55:15.000000000 -0800
@@ -46,7 +46,6 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
 #include <linux/module.h>
 #include <linux/init.h>

@@ -732,7 +731,6 @@ void zap_page_range(struct vm_area_struc
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
-	acct_update_integrals();
 	spin_unlock(&mm->page_table_lock);
 }

@@ -1334,11 +1332,9 @@ static int do_wp_page(struct mm_struct *
 	if (likely(pte_same(*page_table, pte))) {
 		if (PageAnon(old_page))
 			mm->anon_rss--;
-		if (PageReserved(old_page)) {
+		if (PageReserved(old_page))
 			++mm->rss;
-			acct_update_integrals();
-			update_mem_hiwater();
-		} else
+		else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
@@ -1743,9 +1739,6 @@ static int do_swap_page(struct mm_struct
 		remove_exclusive_swap_page(page);

 	mm->rss++;
-	acct_update_integrals();
-	update_mem_hiwater();
-
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1810,8 +1803,6 @@ do_anonymous_page(struct mm_struct *mm,
 			goto out;
 		}
 		mm->rss++;
-		acct_update_integrals();
-		update_mem_hiwater();
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1928,8 +1919,6 @@ retry:
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
 			++mm->rss;
-		acct_update_integrals();
-		update_mem_hiwater();

 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
@@ -2249,10 +2238,8 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
  * update_mem_hiwater
  *	- update per process rss and vm high water data
  */
-void update_mem_hiwater(void)
+void update_mem_hiwater(struct task_struct *tsk)
 {
-	struct task_struct *tsk = current;
-
 	if (tsk->mm) {
 		if (tsk->mm->hiwater_rss < tsk->mm->rss)
 			tsk->mm->hiwater_rss = tsk->mm->rss;
Index: linux-2.6.10/mm/swapfile.c
===================================================================
--- linux-2.6.10.orig/mm/swapfile.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/mm/swapfile.c	2005-02-03 12:55:15.000000000 -0800
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
-#include <linux/acct.h>
 #include <linux/backing-dev.h>
 #include <linux/syscalls.h>

@@ -437,8 +436,6 @@ unuse_pte(struct vm_area_struct *vma, un
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
-	acct_update_integrals();
-	update_mem_hiwater();
 }

 /* vma->vm_mm->page_table_lock is held */
Index: linux-2.6.10/include/linux/mm.h
===================================================================
--- linux-2.6.10.orig/include/linux/mm.h	2005-02-03 12:55:09.000000000 -0800
+++ linux-2.6.10/include/linux/mm.h	2005-02-03 12:55:15.000000000 -0800
@@ -836,7 +836,7 @@ static inline void vm_stat_unaccount(str
 }

 /* update per process rss and vm hiwater data */
-extern void update_mem_hiwater(void);
+extern void update_mem_hiwater(struct task_struct *tsk);

 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
Index: linux-2.6.10/mm/nommu.c
===================================================================
--- linux-2.6.10.orig/mm/nommu.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/mm/nommu.c	2005-02-03 12:55:15.000000000 -0800
@@ -955,10 +955,8 @@ void arch_unmap_area(struct vm_area_stru
 {
 }

-void update_mem_hiwater(void)
+void update_mem_hiwater(struct task_struct *tsk)
 {
-	struct task_struct *tsk = current;
-
 	if (likely(tsk->mm)) {
 		if (tsk->mm->hiwater_rss < tsk->mm->rss)
 			tsk->mm->hiwater_rss = tsk->mm->rss;
Index: linux-2.6.10/include/linux/acct.h
===================================================================
--- linux-2.6.10.orig/include/linux/acct.h	2005-02-03 12:55:09.000000000 -0800
+++ linux-2.6.10/include/linux/acct.h	2005-02-03 12:55:15.000000000 -0800
@@ -120,12 +120,12 @@ struct acct_v3
 struct super_block;
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_process(long exitcode);
-extern void acct_update_integrals(void);
+extern void acct_update_integrals(struct task_struct *tsk);
 extern void acct_clear_integrals(struct task_struct *tsk);
 #else
 #define acct_auto_close(x)	do { } while (0)
 #define acct_process(x)		do { } while (0)
-#define acct_update_integrals()		do { } while (0)
+#define acct_update_integrals(x)		do { } while (0)
 #define acct_clear_integrals(task)	do { } while (0)
 #endif

Index: linux-2.6.10/kernel/acct.c
===================================================================
--- linux-2.6.10.orig/kernel/acct.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/kernel/acct.c	2005-02-03 12:55:15.000000000 -0800
@@ -534,10 +534,8 @@ void acct_process(long exitcode)
  * acct_update_integrals
  *    -  update mm integral fields in task_struct
  */
-void acct_update_integrals(void)
+void acct_update_integrals(struct task_struct *tsk)
 {
-	struct task_struct *tsk = current;
-
 	if (likely(tsk->mm)) {
 		long delta = tsk->stime - tsk->acct_stimexpd;

Index: linux-2.6.10/kernel/sched.c
===================================================================
--- linux-2.6.10.orig/kernel/sched.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/kernel/sched.c	2005-02-03 12:55:15.000000000 -0800
@@ -45,6 +45,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
+#include <linux/acct.h>
 #include <asm/tlb.h>

 #include <asm/unistd.h>
@@ -2373,6 +2374,10 @@ void account_system_time(struct task_str
 		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
+	/* Account for system time used */
+	acct_update_integrals(p);
+	/* Update rss highwater mark */
+	update_mem_hiwater(p);
 }

 /*
Index: linux-2.6.10/mm/rmap.c
===================================================================
--- linux-2.6.10.orig/mm/rmap.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/mm/rmap.c	2005-02-03 12:55:15.000000000 -0800
@@ -51,7 +51,6 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/acct.h>
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>

@@ -600,7 +599,6 @@ static int try_to_unmap_one(struct page
 	}

 	mm->rss--;
-	acct_update_integrals();
 	page_remove_rmap(page);
 	page_cache_release(page);

@@ -705,7 +703,6 @@ static void try_to_unmap_cluster(unsigne

 		page_remove_rmap(page);
 		page_cache_release(page);
-		acct_update_integrals();
 		mm->rss--;
 		(*mapcount)--;
 	}
Index: linux-2.6.10/fs/exec.c
===================================================================
--- linux-2.6.10.orig/fs/exec.c	2005-02-03 12:55:08.000000000 -0800
+++ linux-2.6.10/fs/exec.c	2005-02-03 13:02:37.000000000 -0800
@@ -1191,8 +1191,6 @@ int do_execve(char * filename,

 		/* execve success */
 		security_bprm_free(bprm);
-		acct_update_integrals();
-		update_mem_hiwater();
 		kfree(bprm);
 		return retval;
 	}
Index: linux-2.6.10/kernel/exit.c
===================================================================
--- linux-2.6.10.orig/kernel/exit.c	2005-02-03 12:55:10.000000000 -0800
+++ linux-2.6.10/kernel/exit.c	2005-02-03 12:55:15.000000000 -0800
@@ -806,8 +806,8 @@ fastcall NORET_TYPE void do_exit(long co
 				current->comm, current->pid,
 				preempt_count());

-	acct_update_integrals();
-	update_mem_hiwater();
+	acct_update_integrals(tsk);
+	update_mem_hiwater(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead)
 		acct_process(code);
