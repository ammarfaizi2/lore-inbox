Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUHXH4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUHXH4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUHXH4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:56:45 -0400
Received: from holomorphy.com ([207.189.100.168]:17281 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267165AbUHXHzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:55:46 -0400
Date: Tue, 24 Aug 2004 00:55:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: O(1) proc_pid_statm()
Message-ID: <20040824075539.GA2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040823202158.GJ4418@holomorphy.com> <20040823231454.62734afb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823231454.62734afb.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 11:14:54PM -0700, Andrew Morton wrote:
> I'd prefer it if you (and everyone else) could give a meaningful
> English-language Subject: to patches, please.
> A well-chosen patch Subject: becomes a sort of globally-unique key by which
> the patch is tracked - I munge it into a patch filename and it propagates
> all the way into bitkeeper.  It can be used for searching email folders,
> googling, inter-developer discussion, etc, etc.

Is this better?

Merely removing down_read(&mm->mmap_sem) from task_vsize() is too
half-assed to let stand. The following patch removes the vma iteration
as well as the down_read(&mm->mmap_sem) from both task_mem() and
task_statm() and callers for the CONFIG_MMU=y case in favor of
accounting the various stats reported at the times of vma creation,
destruction, and modification. Unlike the 2.4.x patches of the same
name, this has no per-pte-modification overhead whatsoever.

This patch quashes end user complaints of top(1) being slow as well as
kernel hacker complaints of per-pte accounting overhead simultaneously.

Incremental atop the task_vsize() de-mmap_sem-ification of 2.6.8.1-mm4:


Index: mm4-2.6.8.1/arch/ia64/ia32/binfmt_elf32.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/ia32/binfmt_elf32.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/ia32/binfmt_elf32.c	2004-08-23 23:29:21.860506592 -0700
@@ -187,7 +187,7 @@
 		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC)?
 					PAGE_COPY_EXEC: PAGE_COPY;
 		insert_vm_struct(current->mm, mpnt);
-		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+		current->mm->stack_vm = current->mm->total_vm = vma_pages(mpnt);
 	}
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
Index: mm4-2.6.8.1/arch/ia64/kernel/perfmon.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/kernel/perfmon.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/kernel/perfmon.c	2004-08-23 23:38:30.710068776 -0700
@@ -2352,7 +2352,7 @@
 	insert_vm_struct(mm, vma);
 
 	mm->total_vm  += size >> PAGE_SHIFT;
-
+	vm_stat_account(vma);
 	up_write(&task->mm->mmap_sem);
 
 	/*
Index: mm4-2.6.8.1/arch/ia64/mm/fault.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/mm/fault.c	2004-08-23 16:10:56.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/mm/fault.c	2004-08-23 23:39:35.187266752 -0700
@@ -41,6 +41,7 @@
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
 	return 0;
 }
 
Index: mm4-2.6.8.1/arch/s390/kernel/compat_exec.c
===================================================================
--- mm4-2.6.8.1.orig/arch/s390/kernel/compat_exec.c	2004-08-14 03:56:01.000000000 -0700
+++ mm4-2.6.8.1/arch/s390/kernel/compat_exec.c	2004-08-23 23:30:04.183072584 -0700
@@ -69,7 +69,7 @@
 		mpnt->vm_page_prot = PAGE_COPY;
 		mpnt->vm_flags = VM_STACK_FLAGS;
 		insert_vm_struct(mm, mpnt);
-		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
Index: mm4-2.6.8.1/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/ia32/ia32_binfmt.c	2004-08-23 16:11:09.000000000 -0700
+++ mm4-2.6.8.1/arch/x86_64/ia32/ia32_binfmt.c	2004-08-23 23:28:07.283843968 -0700
@@ -368,7 +368,7 @@
  		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
  			PAGE_COPY_EXEC : PAGE_COPY;
 		insert_vm_struct(mm, mpnt);
-		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
Index: mm4-2.6.8.1/fs/exec.c
===================================================================
--- mm4-2.6.8.1.orig/fs/exec.c	2004-08-23 16:11:15.000000000 -0700
+++ mm4-2.6.8.1/fs/exec.c	2004-08-23 18:29:33.000000000 -0700
@@ -434,7 +434,7 @@
 		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
 		insert_vm_struct(mm, mpnt);
-		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
Index: mm4-2.6.8.1/fs/proc/array.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/array.c	2004-08-23 18:29:08.000000000 -0700
+++ mm4-2.6.8.1/fs/proc/array.c	2004-08-23 20:23:43.000000000 -0700
@@ -279,7 +279,6 @@
 			    cap_t(p->cap_effective));
 }
 
-extern char *task_mem(struct mm_struct *, char *);
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
@@ -415,17 +414,13 @@
 	return res;
 }
 
-extern int task_statm(struct mm_struct *, int *, int *, int *, int *);
 int proc_pid_statm(struct task_struct *task, char *buffer)
 {
 	int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data = 0;
 	struct mm_struct *mm = get_task_mm(task);
 	
 	if (mm) {
-		down_read(&mm->mmap_sem);
 		size = task_statm(mm, &shared, &text, &data, &resident);
-		up_read(&mm->mmap_sem);
-
 		mmput(mm);
 	}
 
Index: mm4-2.6.8.1/fs/proc/task_mmu.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/task_mmu.c	2004-08-14 03:54:50.000000000 -0700
+++ mm4-2.6.8.1/fs/proc/task_mmu.c	2004-08-23 18:29:33.000000000 -0700
@@ -6,27 +6,11 @@
 
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
-	unsigned long data = 0, stack = 0, exec = 0, lib = 0;
-	struct vm_area_struct *vma;
+	unsigned long data, text, lib;
 
-	down_read(&mm->mmap_sem);
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-		if (!vma->vm_file) {
-			data += len;
-			if (vma->vm_flags & VM_GROWSDOWN)
-				stack += len;
-			continue;
-		}
-		if (vma->vm_flags & VM_WRITE)
-			continue;
-		if (vma->vm_flags & VM_EXEC) {
-			exec += len;
-			if (vma->vm_flags & VM_EXECUTABLE)
-				continue;
-			lib += len;
-		}
-	}
+	data = mm->total_vm - mm->shared_vm - mm->stack_vm;
+	text = (mm->end_code - mm->start_code) >> 10;
+	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
 	buffer += sprintf(buffer,
 		"VmSize:\t%8lu kB\n"
 		"VmLck:\t%8lu kB\n"
@@ -38,9 +22,8 @@
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
-		data - stack, stack,
-		exec - lib, lib);
-	up_read(&mm->mmap_sem);
+		data << (PAGE_SHIFT-10),
+		mm->stack_vm << (PAGE_SHIFT-10), text, lib);
 	return buffer;
 }
 
@@ -52,28 +35,11 @@
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	struct vm_area_struct *vma;
-	int size = 0;
-
+	*shared = mm->shared_vm;
+	*text = mm->exec_vm - ((mm->end_code - mm->start_code) >> PAGE_SHIFT);
+	*data = mm->total_vm - mm->shared_vm;
 	*resident = mm->rss;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-
-		size += pages;
-		if (is_vm_hugetlb_page(vma)) {
-			if (!(vma->vm_flags & VM_DONTCOPY))
-				*shared += pages;
-			continue;
-		}
-		if (vma->vm_file)
-			*shared += pages;
-		if (vma->vm_flags & VM_EXECUTABLE)
-			*text += pages;
-		else
-			*data += pages;
-	}
-
-	return size;
+	return mm->total_vm;
 }
 
 static int show_map(struct seq_file *m, void *v)
Index: mm4-2.6.8.1/fs/proc/task_nommu.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/task_nommu.c	2004-08-23 18:29:08.000000000 -0700
+++ mm4-2.6.8.1/fs/proc/task_nommu.c	2004-08-23 18:29:33.000000000 -0700
@@ -82,7 +82,8 @@
 {
 	struct mm_tblock_struct *tbp;
 	int size = kobjsize(mm);
-	
+
+	down_read(&mm->mmap_sem);
 	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
 		if (tbp->next)
 			size += kobjsize(tbp->next);
@@ -94,7 +95,7 @@
 
 	size += (*text = mm->end_code - mm->start_code);
 	size += (*data = mm->start_stack - mm->start_data);
-
+	up_read(&mm->mmap_sem);
 	*resident = size;
 	return size;
 }
Index: mm4-2.6.8.1/include/linux/mm.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/mm.h	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/include/linux/mm.h	2004-08-23 18:29:33.000000000 -0700
@@ -754,6 +754,19 @@
 		int write);
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
+void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
+
+static inline void vm_stat_account(struct vm_area_struct *vma)
+{
+	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
+							vma_pages(vma));
+}
+
+static inline void vm_stat_unaccount(struct vm_area_struct *vma)
+{
+	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
+							-vma_pages(vma));
+}
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
Index: mm4-2.6.8.1/include/linux/proc_fs.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/proc_fs.h	2004-08-23 20:23:29.000000000 -0700
+++ mm4-2.6.8.1/include/linux/proc_fs.h	2004-08-23 20:23:43.000000000 -0700
@@ -91,6 +91,8 @@
 void proc_pid_flush(struct dentry *proc_dentry);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
 unsigned long task_vsize(struct mm_struct *);
+int task_statm(struct mm_struct *, int *, int *, int *, int *);
+char *task_mem(struct mm_struct *, char *);
 
 extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 						struct proc_dir_entry *parent);
Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-23 16:11:20.000000000 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-23 18:29:33.000000000 -0700
@@ -225,8 +225,8 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rlimit_rss, rss, total_vm, locked_vm;
-	unsigned long def_flags;
+	unsigned long rlimit_rss, rss, total_vm, locked_vm, shared_vm;
+	unsigned long exec_vm, stack_vm, def_flags;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
Index: mm4-2.6.8.1/mm/mmap.c
===================================================================
--- mm4-2.6.8.1.orig/mm/mmap.c	2004-08-23 16:11:20.000000000 -0700
+++ mm4-2.6.8.1/mm/mmap.c	2004-08-23 23:33:42.411896760 -0700
@@ -729,6 +729,28 @@
 	return NULL;
 }
 
+void __vm_stat_account(struct mm_struct *mm, unsigned long flags,
+						struct file *file, long pages)
+{
+	const unsigned long stack_flags
+		= VM_STACK_FLAGS & (VM_GROWSUP|VM_GROWSDOWN);
+
+#ifdef CONFIG_HUGETLB
+	if (flags & VM_HUGETLB) {
+		if (!(flags & VM_DONTCOPY))
+			mm->shared_vm += pages;
+		return;
+	}
+#endif /* CONFIG_HUGETLB */
+
+	if (file)
+		mm->shared_vm += pages;
+	else if (flags & stack_flags)
+		mm->stack_vm += pages;
+	if (flags & VM_EXEC)
+		mm->exec_vm += pages;
+}
+
 /*
  * The caller must hold down_write(current->mm->mmap_sem).
  */
@@ -987,6 +1009,7 @@
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
+	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	return addr;
 
 unmap_and_free_vma:
@@ -1330,6 +1353,7 @@
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1392,6 +1416,7 @@
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
 	anon_vma_unlock(vma);
 	return 0;
 }
@@ -1497,6 +1522,7 @@
 	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
 	if (area->vm_flags & VM_LOCKED)
 		area->vm_mm->locked_vm -= len >> PAGE_SHIFT;
+	vm_stat_unaccount(area);
 	area->vm_mm->unmap_area(area);
 	remove_vm_struct(area);
 }
Index: mm4-2.6.8.1/mm/mprotect.c
===================================================================
--- mm4-2.6.8.1.orig/mm/mprotect.c	2004-08-14 03:56:26.000000000 -0700
+++ mm4-2.6.8.1/mm/mprotect.c	2004-08-23 18:29:33.000000000 -0700
@@ -175,9 +175,11 @@
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
 	 */
+	vm_stat_unaccount(vma);
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
 	change_protection(vma, start, end, newprot);
+	vm_stat_account(vma);
 	return 0;
 
 fail:
Index: mm4-2.6.8.1/mm/mremap.c
===================================================================
--- mm4-2.6.8.1.orig/mm/mremap.c	2004-08-23 16:11:13.000000000 -0700
+++ mm4-2.6.8.1/mm/mremap.c	2004-08-24 00:01:28.808565960 -0700
@@ -224,6 +224,7 @@
 	}
 
 	mm->total_vm += new_len >> PAGE_SHIFT;
+	__vm_stat_account(mm, vma->vm_flags, vma->vm_file, new_len>>PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		if (new_len > old_len)
@@ -360,6 +361,8 @@
 				addr + new_len, vma->vm_pgoff, NULL);
 
 			current->mm->total_vm += pages;
+			__vm_stat_account(vma->vm_mm, vma->vm_flags,
+							vma->vm_file, pages);
 			if (vma->vm_flags & VM_LOCKED) {
 				current->mm->locked_vm += pages;
 				make_pages_present(addr + old_len,
