Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUKHTPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUKHTPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUKHTOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:14:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:63675 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261188AbUKHTKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:10:50 -0500
Message-ID: <418FC468.3000702@engr.sgi.com>
Date: Mon, 08 Nov 2004 11:09:28 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: [PATCH 2.6.9 2/2] enhanced Memory accounting data collection
References: <418FC082.8090706@engr.sgi.com>
In-Reply-To: <418FC082.8090706@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------080203070903060508020201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080203070903060508020201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/2: acct_mm

Enhanced memory accounting data collection.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------080203070903060508020201
Content-Type: text/plain;
 name="acct_mm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct_mm"

Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2004-10-18 14:53:51.000000000 -0700
+++ linux/fs/exec.c	2004-11-03 18:10:34.126623587 -0800
@@ -46,6 +46,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
+#include <linux/acct.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1161,6 +1162,8 @@ int do_execve(char * filename,
 
 		/* execve success */
 		security_bprm_free(bprm);
+		acct_update_integrals();
+		update_mem_hiwater();
 		kfree(bprm);
 		return retval;
 	}
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-11-03 15:52:01.803397172 -0800
+++ linux/include/linux/sched.h	2004-11-05 14:02:56.240526520 -0800
@@ -249,6 +249,9 @@ struct mm_struct {
 	struct kioctx		*ioctx_list;
 
 	struct kioctx		default_kioctx;
+
+	unsigned long hiwater_rss;	/* High-water RSS usage */
+	unsigned long hiwater_vm;	/* High-water virtual memory usage */
 };
 
 extern int mmlist_nr;
@@ -582,6 +585,11 @@ struct task_struct {
 	wait_queue_t *io_wait;
 /* i/o counters(bytes read/written, #syscalls */
 	u64 rchar, wchar, syscr, syscw;
+#if defined(CONFIG_BSD_PROCESS_ACCT)
+	u64 acct_rss_mem1;	/* accumulated rss usage */
+	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
+	clock_t acct_stimexpd;	/* clock_t-converted stime since last update */
+#endif
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2004-10-18 14:55:06.000000000 -0700
+++ linux/kernel/exit.c	2004-11-03 18:10:34.155920668 -0800
@@ -807,6 +807,8 @@ asmlinkage NORET_TYPE void do_exit(long 
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	acct_update_integrals();
+	update_mem_hiwater();
 	acct_process(code);
 	__exit_mm(tsk);
 
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-11-03 16:44:23.266042599 -0800
+++ linux/kernel/fork.c	2004-11-03 18:14:53.035673250 -0800
@@ -38,6 +38,7 @@
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
+#include <linux/acct.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -605,6 +606,9 @@ static int copy_mm(unsigned long clone_f
 	if (retval)
 		goto free_pt;
 
+	mm->hiwater_rss = mm->rss;
+	mm->hiwater_vm = mm->total_vm;	
+
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
@@ -1000,6 +1004,8 @@ static task_t *copy_process(unsigned lon
 	p->wchar = 0;		/* I/O counter: bytes written */
 	p->syscr = 0;		/* I/O counter: read syscalls */
 	p->syscw = 0;		/* I/O counter: write syscalls */
+	acct_clear_integrals(p);
+
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2004-10-18 14:54:07.000000000 -0700
+++ linux/mm/memory.c	2004-11-05 14:14:00.825358944 -0800
@@ -44,6 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/acct.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -605,6 +606,7 @@ void zap_page_range(struct vm_area_struc
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
+	acct_update_integrals();
 	spin_unlock(&mm->page_table_lock);
 }
 
@@ -1095,9 +1097,11 @@ static int do_wp_page(struct mm_struct *
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
-		if (PageReserved(old_page))
+		if (PageReserved(old_page)) {
 			++mm->rss;
-		else
+			acct_update_integrals();
+			update_mem_hiwater();
+		} else
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
@@ -1379,6 +1383,9 @@ static int do_swap_page(struct mm_struct
 		remove_exclusive_swap_page(page);
 
 	mm->rss++;
+	acct_update_integrals();
+	update_mem_hiwater();
+
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1444,6 +1451,8 @@ do_anonymous_page(struct mm_struct *mm, 
 			goto out;
 		}
 		mm->rss++;
+		acct_update_integrals();
+		update_mem_hiwater();
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1553,6 +1562,9 @@ retry:
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
 			++mm->rss;
+		acct_update_integrals();
+		update_mem_hiwater();
+
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
@@ -1787,6 +1799,24 @@ struct page * vmalloc_to_page(void * vma
 
 EXPORT_SYMBOL(vmalloc_to_page);
 
+/*
+ * update_mem_hiwater
+ *	- update per process rss and vm high water data
+ */
+void update_mem_hiwater(void)
+{
+	struct task_struct *parent = current;
+
+	if (parent->mm) {
+		if (parent->mm->hiwater_rss < parent->mm->rss) {
+			parent->mm->hiwater_rss = parent->mm->rss;
+		}
+		if (parent->mm->hiwater_vm < parent->mm->total_vm) {
+			parent->mm->hiwater_vm = parent->mm->total_vm;
+		}
+	}
+}
+
 #if !defined(CONFIG_ARCH_GATE_AREA)
 
 #if defined(AT_SYSINFO_EHDR)
Index: linux/mm/mmap.c
===================================================================
--- linux.orig/mm/mmap.c	2004-10-18 14:54:37.000000000 -0700
+++ linux/mm/mmap.c	2004-11-05 14:00:13.138780763 -0800
@@ -7,6 +7,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -20,6 +21,7 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
+#include <linux/acct.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
@@ -1016,6 +1018,8 @@ out:	
 		down_write(&mm->mmap_sem);
 	}
 	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
+	acct_update_integrals();
+	update_mem_hiwater();
 	return addr;
 
 unmap_and_free_vma:
@@ -1362,6 +1366,8 @@ int expand_stack(struct vm_area_struct *
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
+	acct_update_integrals();
+	update_mem_hiwater();
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1818,6 +1824,8 @@ out:
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	acct_update_integrals();
+	update_mem_hiwater();
 	return addr;
 }
 
Index: linux/mm/mremap.c
===================================================================
--- linux.orig/mm/mremap.c	2004-10-18 14:54:31.000000000 -0700
+++ linux/mm/mremap.c	2004-11-03 18:10:34.194006874 -0800
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/acct.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -232,6 +233,9 @@ static unsigned long move_vma(struct vm_
 					   new_addr + new_len);
 	}
 
+	acct_update_integrals();
+	update_mem_hiwater();
+
 	return new_addr;
 }
 
@@ -368,6 +372,8 @@ unsigned long do_mremap(unsigned long ad
 				make_pages_present(addr + old_len,
 						   addr + new_len);
 			}
+			acct_update_integrals();
+			update_mem_hiwater();
 			ret = addr;
 			goto out;
 		}
Index: linux/mm/rmap.c
===================================================================
--- linux.orig/mm/rmap.c	2004-10-18 14:55:18.000000000 -0700
+++ linux/mm/rmap.c	2004-11-03 18:10:34.200842860 -0800
@@ -50,6 +50,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/acct.h>
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 
@@ -581,6 +582,7 @@ static int try_to_unmap_one(struct page 
 	}
 
 	mm->rss--;
+	acct_update_integrals();
 	page_remove_rmap(page);
 	page_cache_release(page);
 
@@ -680,6 +682,7 @@ static void try_to_unmap_cluster(unsigne
 
 		page_remove_rmap(page);
 		page_cache_release(page);
+		acct_update_integrals();
 		mm->rss--;
 		(*mapcount)--;
 	}
Index: linux/mm/swapfile.c
===================================================================
--- linux.orig/mm/swapfile.c	2004-10-18 14:53:43.000000000 -0700
+++ linux/mm/swapfile.c	2004-11-03 18:10:34.208655415 -0800
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
+#include <linux/acct.h>
 #include <linux/backing-dev.h>
 
 #include <asm/pgtable.h>
@@ -435,6 +436,8 @@ unuse_pte(struct vm_area_struct *vma, un
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
+	acct_update_integrals();
+	update_mem_hiwater();
 }
 
 /* vma->vm_mm->page_table_lock is held */
Index: linux/include/linux/acct.h
===================================================================
--- linux.orig/include/linux/acct.h	2004-10-18 14:53:43.000000000 -0700
+++ linux/include/linux/acct.h	2004-11-04 17:23:33.595596763 -0800
@@ -120,9 +120,13 @@ struct acct_v3
 struct super_block;
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_process(long exitcode);
+extern void acct_update_integrals(void);
+extern void acct_clear_integrals(struct task_struct *tsk);
 #else
 #define acct_auto_close(x)	do { } while (0)
 #define acct_process(x)		do { } while (0)
+#define acct_update_integrals()		do { } while (0)
+#define acct_clear_integrals(task)	do { } while (0)
 #endif
 
 /*
Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c	2004-10-18 14:54:31.000000000 -0700
+++ linux/kernel/acct.c	2004-11-04 17:47:22.785444845 -0800
@@ -521,3 +521,35 @@ void acct_process(long exitcode)
 	do_acct_process(exitcode, file);
 	fput(file);
 }
+
+
+/*
+ * acct_update_integrals
+ *    -  update mm integral fields in task_struct
+ */
+void acct_update_integrals(void)
+{
+	long delta;
+	struct task_struct *parent = current;
+
+	if (parent->mm) {
+		delta = parent->stime - parent->acct_stimexpd;
+		parent->acct_stimexpd = parent->stime;
+		parent->acct_rss_mem1 += delta * parent->mm->rss;
+		parent->acct_vm_mem1 += delta * parent->mm->total_vm;
+	}
+}
+
+
+/*
+ * acct_clear_integrals
+ *    - clear the mm integral fields in task_struct
+ */
+void acct_clear_integrals(struct task_struct *tsk)
+{
+	if (tsk) {
+		tsk->acct_stimexpd = 0;
+		tsk->acct_rss_mem1 = 0;
+		tsk->acct_vm_mem1 = 0;
+	}
+}
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h	2004-10-18 14:53:07.000000000 -0700
+++ linux/include/linux/mm.h	2004-11-05 14:11:24.004898462 -0800
@@ -782,6 +782,9 @@ static inline void vm_stat_unaccount(str
 							-vma_pages(vma));
 }
 
+/* update per process rss and vm hiwater data */
+extern void update_mem_hiwater(void);
+
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)

--------------080203070903060508020201--

