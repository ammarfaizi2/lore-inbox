Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271119AbUJVCGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271119AbUJVCGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271087AbUJVCEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:04:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23239 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S271165AbUJVBfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:35:52 -0400
Message-ID: <417863D3.9060907@engr.sgi.com>
Date: Thu, 21 Oct 2004 18:35:15 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [Lse-tech] [PATCH 2.6.9 2/2] enhanced accounting data collection
References: <41785FE3.806@engr.sgi.com>
In-Reply-To: <41785FE3.806@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------000507030002020900060106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000507030002020900060106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/2: acct_mm

Enhanced MM accounting data collection.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------000507030002020900060106
Content-Type: text/plain;
 name="acct_mm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct_mm"

Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2004-10-01 17:16:34.924263618 -0700
+++ linux/fs/exec.c	2004-10-14 12:13:17.600743917 -0700
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
+#include <linux/acct.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1163,6 +1164,8 @@
 
 		/* execve success */
 		security_bprm_free(bprm);
+		acct_update_integrals();
+		update_mem_hiwater();
 		kfree(bprm);
 		return retval;
 	}
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-10-01 17:16:35.105905373 -0700
+++ linux/include/linux/sched.h	2004-10-14 12:15:33.450280955 -0700
@@ -249,6 +249,8 @@
 	struct kioctx		*ioctx_list;
 
 	struct kioctx		default_kioctx;
+
+	unsigned long hiwater_rss, hiwater_vm;
 };
 
 extern int mmlist_nr;
@@ -593,6 +595,10 @@
 
 /* i/o counters(bytes read/written, #syscalls */
 	unsigned long rchar, wchar, syscr, syscw;
+#if defined(CONFIG_BSD_PROCESS_ACCT)
+	u64 acct_rss_mem1, acct_vm_mem1;
+	clock_t acct_stimexpd;
+#endif
 
 };
 
@@ -817,6 +823,19 @@
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
--- linux.orig/kernel/exit.c	2004-10-01 17:16:34.931099598 -0700
+++ linux/kernel/exit.c	2004-10-14 12:16:36.448747186 -0700
@@ -808,6 +808,8 @@
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	acct_update_integrals();
+	update_mem_hiwater();
 	acct_process(code);
 	__exit_mm(tsk);
 
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-10-01 17:16:35.106881941 -0700
+++ linux/kernel/fork.c	2004-10-14 12:17:21.626782307 -0700
@@ -39,7 +39,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
-
+#include <linux/acct.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -609,6 +609,9 @@
 	if (retval)
 		goto free_pt;
 
+	mm->hiwater_rss = mm->rss;
+	mm->hiwater_vm = mm->total_vm;	
+
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
@@ -996,6 +999,8 @@
 
 	p->utime = p->stime = 0;
 	p->rchar = p->wchar = p->syscr = p->syscw = 0;
+	acct_clear_integrals(p);
+
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2004-09-29 20:04:32.000000000 -0700
+++ linux/mm/memory.c	2004-10-14 12:18:22.611563293 -0700
@@ -44,6 +44,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/acct.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -605,6 +606,7 @@
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
+	acct_update_integrals();
 	spin_unlock(&mm->page_table_lock);
 }
 
@@ -1095,9 +1097,11 @@
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
@@ -1379,6 +1383,9 @@
 		remove_exclusive_swap_page(page);
 
 	mm->rss++;
+	acct_update_integrals();
+	update_mem_hiwater();
+
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -1444,6 +1451,8 @@
 			goto out;
 		}
 		mm->rss++;
+		acct_update_integrals();
+		update_mem_hiwater();
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
@@ -1553,6 +1562,9 @@
 	if (pte_none(*page_table)) {
 		if (!PageReserved(new_page))
 			++mm->rss;
+		acct_update_integrals();
+		update_mem_hiwater();
+
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
Index: linux/mm/mmap.c
===================================================================
--- linux.orig/mm/mmap.c	2004-09-29 20:05:13.000000000 -0700
+++ linux/mm/mmap.c	2004-10-14 12:18:56.394014760 -0700
@@ -20,6 +20,7 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
+#include <linux/acct.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
@@ -1014,6 +1015,8 @@
 		down_write(&mm->mmap_sem);
 	}
 	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
+	acct_update_integrals();
+	update_mem_hiwater();
 	return addr;
 
 unmap_and_free_vma:
@@ -1360,6 +1363,8 @@
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
+	acct_update_integrals();
+	update_mem_hiwater();
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1816,6 +1821,8 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	acct_update_integrals();
+	update_mem_hiwater();
 	return addr;
 }
 
Index: linux/mm/mremap.c
===================================================================
--- linux.orig/mm/mremap.c	2004-09-29 20:04:57.000000000 -0700
+++ linux/mm/mremap.c	2004-10-14 12:19:20.738903400 -0700
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/acct.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -232,6 +233,9 @@
 					   new_addr + new_len);
 	}
 
+	acct_update_integrals();
+	update_mem_hiwater();
+
 	return new_addr;
 }
 
@@ -368,6 +372,8 @@
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
--- linux.orig/mm/rmap.c	2004-09-29 20:05:41.000000000 -0700
+++ linux/mm/rmap.c	2004-10-14 15:22:02.760847036 -0700
@@ -50,6 +50,7 @@
 #include <linux/swapops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/acct.h>
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 
@@ -581,6 +582,7 @@
 	}
 
 	mm->rss--;
+	acct_update_integrals();
 	page_remove_rmap(page);
 	page_cache_release(page);
 
@@ -680,6 +682,7 @@
 
 		page_remove_rmap(page);
 		page_cache_release(page);
+		acct_update_integrals();
 		mm->rss--;
 		(*mapcount)--;
 	}
Index: linux/mm/swapfile.c
===================================================================
--- linux.orig/mm/swapfile.c	2004-09-29 20:04:22.000000000 -0700
+++ linux/mm/swapfile.c	2004-10-14 12:20:00.377839180 -0700
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/rmap.h>
 #include <linux/security.h>
+#include <linux/acct.h>
 #include <linux/backing-dev.h>
 
 #include <asm/pgtable.h>
@@ -435,6 +436,8 @@
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
+	acct_update_integrals();
+	update_mem_hiwater();
 }
 
 /* vma->vm_mm->page_table_lock is held */
Index: linux/include/linux/acct.h
===================================================================
--- linux.orig/include/linux/acct.h	2004-09-29 20:04:21.000000000 -0700
+++ linux/include/linux/acct.h	2004-10-14 12:09:18.730013599 -0700
@@ -120,9 +120,34 @@
 struct super_block;
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_process(long exitcode);
+
+static inline void acct_update_integrals(void)
+{
+	long delta;
+
+	if (current->mm) {
+		delta = current->stime - current->acct_stimexpd;
+		current->acct_stimexpd = current->stime;
+		current->acct_rss_mem1 += delta * current->mm->rss;
+		current->acct_vm_mem1 += delta * current->mm->total_vm;
+	}
+}
+
+static inline void acct_clear_integrals(struct task_struct *tsk)
+{
+	if (tsk) {
+		tsk->acct_stimexpd = 0;
+		tsk->acct_rss_mem1 = 0;
+		tsk->acct_vm_mem1 = 0;
+	}
+}
+
 #else
 #define acct_auto_close(x)	do { } while (0)
 #define acct_process(x)		do { } while (0)
+
+#define acct_update_integrals()		do { } while (0)
+#define acct_clear_integrals(task)	do { } while (0)
 #endif
 
 /*

--------------000507030002020900060106--

