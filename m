Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVAFA5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVAFA5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVAFA5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:57:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:65171 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262680AbVAFAzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:55:20 -0500
Date: Wed, 5 Jan 2005 16:55:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvads@osdl.org
cc: akpm@osdl.org, jlan@sgi.com, linux-kernel@vger.kernel.org
Subject: Move accounting function calls out of critical vm code paths
Message-ID: <Pine.LNX.4.58.0501051651140.10377@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new accounting patches add function calls to critical code paths.
These statistics have traditionally be gathered during
the timer tick. Accounting is dependent on stime being incremented:

void acct_update_integrals(void)
{
        struct task_struct *tsk = current;

        if (likely(tsk->mm)) {
                long delta = tsk->stime - tsk->acct_stimexpd;

                tsk->acct_stimexpd = tsk->stime;
                tsk->acct_rss_mem1 += delta * tsk->mm->rss;
                tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
        }
}

If stime has not increased then delta == 0 and nothing happens just
a multiplication with zero....

Thus one may move the calls to the timer interrupt and only call
acct_update_integrals if stime has been incremented. This will avoid
having to spent time to gather statistics in the hot paths of the vm.

One disadvantage is that rss etc may now peak between stime increments without
being noticed. But I think we are mostly interested in prolonged memory use
rather than accurate data on the max rss ever reached.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/kernel/timer.c
===================================================================
--- linux-2.6.10.orig/kernel/timer.c	2005-01-05 16:23:39.000000000 -0800
+++ linux-2.6.10/kernel/timer.c	2005-01-05 16:35:51.000000000 -0800
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/acct.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -815,6 +816,10 @@
 		if (psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_max)
 			send_sig(SIGKILL, p, 1);
 	}
+	if (system) {
+		acct_update_integrals(p);
+		update_mem_hiwater(p);
+	}
 }

 static inline void do_it_virt(struct task_struct * p, unsigned long ticks)
Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-05 16:23:39.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-05 16:23:41.000000000 -0800
@@ -46,7 +46,6 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
-#include <linux/acct.h>
 #include <linux/module.h>
 #include <linux/init.h>

@@ -739,7 +738,6 @@
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
-	acct_update_integrals();
 	spin_unlock(&mm->page_table_lock);
 }

@@ -1336,8 +1334,6 @@
 			mm->anon_rss--;
 		if (PageReserved(old_page)) {
 			++mm->rss;
-			acct_update_integrals();
-			update_mem_hiwater();
 		} else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
@@ -1620,8 +1616,6 @@
 		remove_exclusive_swap_page(page);

 	mm->rss++;
-	acct_update_integrals();
-	update_mem_hiwater();

 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
@@ -1688,8 +1682,6 @@
 			goto out;
 		}
 		mm->rss++;
-		acct_update_integrals();
-		update_mem_hiwater();
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1799,8 +1791,6 @@
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
 			++mm->rss;
-		acct_update_integrals();
-		update_mem_hiwater();

 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
@@ -2124,10 +2114,8 @@
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
Index: linux-2.6.10/kernel/exit.c
===================================================================
--- linux-2.6.10.orig/kernel/exit.c	2005-01-05 16:23:38.000000000 -0800
+++ linux-2.6.10/kernel/exit.c	2005-01-05 16:23:41.000000000 -0800
@@ -801,8 +801,8 @@
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}

-	acct_update_integrals();
-	update_mem_hiwater();
+	acct_update_integrals(current);
+	update_mem_hiwater(current);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead)
 		acct_process(code);
Index: linux-2.6.10/mm/swapfile.c
===================================================================
--- linux-2.6.10.orig/mm/swapfile.c	2005-01-05 16:23:39.000000000 -0800
+++ linux-2.6.10/mm/swapfile.c	2005-01-05 16:23:41.000000000 -0800
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
-#include <linux/acct.h>
 #include <linux/backing-dev.h>
 #include <linux/syscalls.h>

@@ -437,8 +436,6 @@
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
-	acct_update_integrals();
-	update_mem_hiwater();
 }

 /* vma->vm_mm->page_table_lock is held */
Index: linux-2.6.10/include/linux/mm.h
===================================================================
--- linux-2.6.10.orig/include/linux/mm.h	2005-01-05 16:23:38.000000000 -0800
+++ linux-2.6.10/include/linux/mm.h	2005-01-05 16:31:49.000000000 -0800
@@ -835,7 +835,7 @@
 }

 /* update per process rss and vm hiwater data */
-extern void update_mem_hiwater(void);
+extern void update_mem_hiwater(struct task_struct *tsk);

 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
Index: linux-2.6.10/include/linux/acct.h
===================================================================
--- linux-2.6.10.orig/include/linux/acct.h	2005-01-05 16:23:38.000000000 -0800
+++ linux-2.6.10/include/linux/acct.h	2005-01-05 16:31:33.000000000 -0800
@@ -120,12 +120,12 @@
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
+#define acct_update_integrals(x)	do { } while (0)
 #define acct_clear_integrals(task)	do { } while (0)
 #endif

Index: linux-2.6.10/kernel/acct.c
===================================================================
--- linux-2.6.10.orig/kernel/acct.c	2005-01-05 16:23:38.000000000 -0800
+++ linux-2.6.10/kernel/acct.c	2005-01-05 16:28:00.000000000 -0800
@@ -534,10 +534,8 @@
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

Index: linux-2.6.10/mm/rmap.c
===================================================================
--- linux-2.6.10.orig/mm/rmap.c	2005-01-05 16:23:39.000000000 -0800
+++ linux-2.6.10/mm/rmap.c	2005-01-05 16:23:41.000000000 -0800
@@ -51,7 +51,6 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/acct.h>
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>

@@ -607,7 +606,6 @@
 	}

 	mm->rss--;
-	acct_update_integrals();
 	page_remove_rmap(page);
 	page_cache_release(page);

@@ -712,7 +710,6 @@

 		page_remove_rmap(page);
 		page_cache_release(page);
-		acct_update_integrals();
 		mm->rss--;
 		(*mapcount)--;
 	}
Index: linux-2.6.10/mm/mmap.c
===================================================================
--- linux-2.6.10.orig/mm/mmap.c	2005-01-05 16:23:39.000000000 -0800
+++ linux-2.6.10/mm/mmap.c	2005-01-05 16:24:24.000000000 -0800
@@ -21,7 +21,6 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
-#include <linux/acct.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
@@ -1021,8 +1020,6 @@
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
-	acct_update_integrals();
-	update_mem_hiwater();
 	return addr;

 unmap_and_free_vma:
@@ -1369,8 +1366,6 @@
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
-	acct_update_integrals();
-	update_mem_hiwater();
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1434,8 +1429,6 @@
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
-	acct_update_integrals();
-        update_mem_hiwater();
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1823,8 +1816,6 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
-	acct_update_integrals();
-	update_mem_hiwater();
 	return addr;
 }

Index: linux-2.6.10/mm/mremap.c
===================================================================
--- linux-2.6.10.orig/mm/mremap.c	2005-01-05 16:23:39.000000000 -0800
+++ linux-2.6.10/mm/mremap.c	2005-01-05 16:25:30.000000000 -0800
@@ -16,7 +16,6 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
-#include <linux/acct.h>
 #include <linux/syscalls.h>

 #include <asm/uaccess.h>
@@ -251,9 +250,6 @@
 					   new_addr + new_len);
 	}

-	acct_update_integrals();
-	update_mem_hiwater();
-
 	return new_addr;
 }

@@ -390,8 +386,6 @@
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
-			acct_update_integrals();
-			update_mem_hiwater();
 			ret = addr;
 			goto out;
 		}
Index: linux-2.6.10/fs/exec.c
===================================================================
--- linux-2.6.10.orig/fs/exec.c	2005-01-05 16:23:38.000000000 -0800
+++ linux-2.6.10/fs/exec.c	2005-01-05 16:34:16.000000000 -0800
@@ -1165,8 +1165,8 @@

 		/* execve success */
 		security_bprm_free(bprm);
-		acct_update_integrals();
-		update_mem_hiwater();
+		acct_update_integrals(current);
+		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}
