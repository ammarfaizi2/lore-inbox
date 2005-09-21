Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVIUMTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVIUMTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 08:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVIUMTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 08:19:17 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:40355 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750856AbVIUMTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 08:19:16 -0400
Date: Wed, 21 Sep 2005 14:19:15 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921121915.GA14645@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.

Signed-off-by: Frank van Maarseveen <frankvm@frankvm.com>

diff -ru a/arch/ppc64/kernel/vdso.c b/arch/ppc64/kernel/vdso.c
--- a/arch/ppc64/kernel/vdso.c	2005-09-21 11:05:11.000000000 +0200
+++ b/arch/ppc64/kernel/vdso.c	2005-09-21 11:17:06.053426000 +0200
@@ -272,6 +272,7 @@
 	}
 	mm->total_vm += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	up_write(&mm->mmap_sem);
+	update_mem_hiwater(mm);
 
 	return 0;
 }
diff -ru a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
--- a/arch/x86_64/ia32/syscall32.c	2005-09-21 11:05:24.000000000 +0200
+++ b/arch/x86_64/ia32/syscall32.c	2005-09-21 11:17:06.130574000 +0200
@@ -72,6 +72,7 @@
 	}
 	mm->total_vm += npages;
 	up_write(&mm->mmap_sem);
+	update_mem_hiwater(mm);
 	return 0;
 }
 
diff -ru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	2005-09-21 11:06:43.000000000 +0200
+++ b/fs/exec.c	2005-09-21 11:17:06.218465000 +0200
@@ -1207,7 +1207,7 @@
 		/* execve success */
 		security_bprm_free(bprm);
 		acct_update_integrals(current);
-		update_mem_hiwater(current);
+		update_mem_hiwater(current->mm);
 		kfree(bprm);
 		return retval;
 	}
diff -ru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2005-09-14 14:27:39.000000000 +0200
+++ b/include/linux/mm.h	2005-09-21 11:17:06.327839000 +0200
@@ -949,7 +949,7 @@
 }
 
 /* update per process rss and vm hiwater data */
-extern void update_mem_hiwater(struct task_struct *tsk);
+extern void update_mem_hiwater(struct mm_struct *mm);
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
diff -ru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2005-09-21 11:07:38.000000000 +0200
+++ b/kernel/exit.c	2005-09-21 11:17:06.395222000 +0200
@@ -839,7 +839,7 @@
 				preempt_count());
 
 	acct_update_integrals(tsk);
-	update_mem_hiwater(tsk);
+	update_mem_hiwater(tsk->mm);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
  		del_timer_sync(&tsk->signal->real_timer);
diff -ru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2005-09-21 11:07:39.000000000 +0200
+++ b/kernel/sched.c	2005-09-21 11:17:06.462605000 +0200
@@ -2512,7 +2512,7 @@
 	/* Account for system time used */
 	acct_update_integrals(p);
 	/* Update rss highwater mark */
-	update_mem_hiwater(p);
+	update_mem_hiwater(p->mm);
 }
 
 /*
diff -ru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2005-09-21 11:07:40.000000000 +0200
+++ b/mm/memory.c	2005-09-21 11:17:06.602253000 +0200
@@ -2210,15 +2210,16 @@
  * update_mem_hiwater
  *	- update per process rss and vm high water data
  */
-void update_mem_hiwater(struct task_struct *tsk)
+void update_mem_hiwater(struct mm_struct *mm)
 {
-	if (tsk->mm) {
-		unsigned long rss = get_mm_counter(tsk->mm, rss);
+	unsigned long rss;
 
-		if (tsk->mm->hiwater_rss < rss)
-			tsk->mm->hiwater_rss = rss;
-		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
-			tsk->mm->hiwater_vm = tsk->mm->total_vm;
+	if (likely(mm)) {
+		rss = get_mm_counter(mm, rss);
+		if (mm->hiwater_rss < rss)
+			mm->hiwater_rss = rss;
+		if (mm->hiwater_vm < mm->total_vm)
+			mm->hiwater_vm = mm->total_vm;
 	}
 }
 
diff -ru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	2005-09-21 11:07:40.000000000 +0200
+++ b/mm/mmap.c	2005-09-21 11:17:06.755572000 +0200
@@ -854,6 +854,7 @@
 		mm->stack_vm += pages;
 	if (flags & (VM_RESERVED|VM_IO))
 		mm->reserved_vm += pages;
+	update_mem_hiwater(mm);
 }
 #endif /* CONFIG_PROC_FS */
 
@@ -1915,6 +1916,7 @@
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
+	update_mem_hiwater(mm);
 	if (flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
diff -ru a/mm/nommu.c b/mm/nommu.c
--- a/mm/nommu.c	2005-09-21 11:07:40.000000000 +0200
+++ b/mm/nommu.c	2005-09-21 12:26:02.166764000 +0200
@@ -839,6 +839,7 @@
 	show_process_blocks();
 #endif
 
+	update_mem_hiwater(mm);
 	return (unsigned long) result;
 
  error:
@@ -1079,16 +1080,16 @@
 {
 }
 
-void update_mem_hiwater(struct task_struct *tsk)
+void update_mem_hiwater(struct mm_struct *mm)
 {
 	unsigned long rss;
 
-	if (likely(tsk->mm)) {
-		rss = get_mm_counter(tsk->mm, rss);
-		if (tsk->mm->hiwater_rss < rss)
-			tsk->mm->hiwater_rss = rss;
-		if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
-			tsk->mm->hiwater_vm = tsk->mm->total_vm;
+	if (likely(mm)) {
+		rss = get_mm_counter(mm, rss);
+		if (mm->hiwater_rss < rss)
+			mm->hiwater_rss = rss;
+		if (mm->hiwater_vm < mm->total_vm)
+			mm->hiwater_vm = mm->total_vm;
 	}
 }
 

-- 
Frank
