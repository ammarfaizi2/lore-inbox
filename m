Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136826AbRECO4I>; Thu, 3 May 2001 10:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136822AbRECOz7>; Thu, 3 May 2001 10:55:59 -0400
Received: from mail.valinux.com ([198.186.202.175]:17414 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S136826AbRECOzo>;
	Thu, 3 May 2001 10:55:44 -0400
Date: Thu, 3 May 2001 08:54:18 -0600
From: Don Dugger <n0ano@valinux.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Thread core dumps for 2.4.4
Message-ID: <20010503085418.A12123@tlaloc.n0ano.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch allows core dumps from thread processes in the 2.4.4
kernel.  This patch is the same as the last one I sent out except it fixes
the same bug that `kernel/fork.c' had with duplicate info in the `mm'
structure, plus this patch has had more extensive testing.

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838



diff -aur linux-2.4.4-ref/fs/binfmt_aout.c linux/fs/binfmt_aout.c
--- linux-2.4.4-ref/fs/binfmt_aout.c	Mon Mar 19 13:34:56 2001
+++ linux/fs/binfmt_aout.c	Wed May  2 15:50:42 2001
@@ -31,7 +31,8 @@
 
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout_library(struct file*);
-static int aout_core_dump(long signr, struct pt_regs * regs, struct file *file);
+static int aout_core_dump(long signr, struct pt_regs * regs,
+	struct file *file, struct mm_struct * mm);
 
 extern void dump_thread(struct pt_regs *, struct user *);
 
@@ -78,7 +79,8 @@
  * dumping of the process results in another error..
  */
 
-static int aout_core_dump(long signr, struct pt_regs * regs, struct file *file)
+static int aout_core_dump(long signr, struct pt_regs * regs,
+	struct file * file, struct mm_struct * mm)
 {
 	mm_segment_t fs;
 	int has_dumped = 0;
diff -aur linux-2.4.4-ref/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.4.4-ref/fs/binfmt_elf.c	Thu Apr  5 18:13:23 2001
+++ linux/fs/binfmt_elf.c	Wed May  2 15:50:42 2001
@@ -56,7 +56,8 @@
  * don't even try.
  */
 #ifdef USE_ELF_CORE_DUMP
-static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file);
+static int elf_core_dump(long signr, struct pt_regs * regs,
+	struct file * file, struct mm_struct * mm);
 #else
 #define elf_core_dump	NULL
 #endif
@@ -976,7 +977,8 @@
  * and then they are actually written out.  If we run out of core limit
  * we just truncate.
  */
-static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
+static int elf_core_dump(long signr, struct pt_regs * regs,
+	struct file * file, struct mm_struct * mm)
 {
 	int has_dumped = 0;
 	mm_segment_t fs;
@@ -993,7 +995,7 @@
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
 
-	segs = current->mm->map_count;
+	segs = mm->map_count;
 
 #ifdef DEBUG
 	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
@@ -1153,7 +1155,7 @@
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for(vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		struct elf_phdr phdr;
 		size_t sz;
 
@@ -1182,7 +1184,7 @@
 
 	DUMP_SEEK(dataoff);
 
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for(vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		unsigned long addr;
 
 		if (!maydump(vma))
diff -aur linux-2.4.4-ref/fs/exec.c linux/fs/exec.c
--- linux-2.4.4-ref/fs/exec.c	Thu Apr 26 15:11:29 2001
+++ linux/fs/exec.c	Thu May  3 08:18:54 2001
@@ -923,16 +923,18 @@
 
 int do_coredump(long signr, struct pt_regs * regs)
 {
+	struct mm_struct *mm;
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)];
+	char corename[6+sizeof(current->comm)+10];
 	struct file * file;
 	struct inode * inode;
+	int r;
 
 	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
-	if (!current->dumpable || atomic_read(&current->mm->mm_users) != 1)
+	if (!current->dumpable)
 		goto fail;
 	current->dumpable = 0;
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
@@ -944,6 +946,8 @@
 #else
 	corename[4] = '\0';
 #endif
+ 	if (atomic_read(&current->mm->mm_users) != 1)
+ 		sprintf(&corename[4], ".%d", current->pid);
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
@@ -961,11 +965,42 @@
 		goto close_fail;
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
-	if (!binfmt->core_dump(signr, regs, file))
+	/*
+	 *  Copy the mm structure to avoid potential races with
+	 *    other threads
+	 */
+	if ((mm = kmem_cache_alloc(mm_cachep, SLAB_KERNEL)) == NULL)
 		goto close_fail;
+	memcpy(mm, current->mm, sizeof(*mm));
+
+	/* Clear new context for now */
+	memset(&mm->context, 0, sizeof(mm->context));
+
+	if (!mm_init(mm)) {
+		kmem_cache_free(mm_cachep, mm);
+		goto close_fail;
+	}
+	down_write(&current->mm->mmap_sem);
+	r = dup_mmap(mm);
+	up_write(&current->mm->mmap_sem);
+
+	/*
+	 * Add it to the mmlist after the parent.
+	 */
+	spin_lock(&mmlist_lock);
+	list_add(&mm->mmlist, &current->mm->mmlist);
+	mmlist_nr++;
+	spin_unlock(&mmlist_lock);
+
+	if (r) {
+		mmput(mm);
+		goto close_fail;
+	}
+	r = binfmt->core_dump(signr, regs, file, mm);
 	unlock_kernel();
+	mmput(mm);
 	filp_close(file, NULL);
-	return 1;
+	return r;
 
 close_fail:
 	filp_close(file, NULL);
diff -aur linux-2.4.4-ref/include/linux/binfmts.h linux/include/linux/binfmts.h
--- linux-2.4.4-ref/include/linux/binfmts.h	Wed May  2 14:49:42 2001
+++ linux/include/linux/binfmts.h	Wed May  2 15:50:42 2001
@@ -41,7 +41,8 @@
 	struct module *module;
 	int (*load_binary)(struct linux_binprm *, struct  pt_regs * regs);
 	int (*load_shlib)(struct file *);
-	int (*core_dump)(long signr, struct pt_regs * regs, struct file * file);
+	int (*core_dump)(long signr, struct pt_regs * regs,
+			struct file * file, struct mm_struct *mm);
 	unsigned long min_coredump;	/* minimal dump size */
 };
 
diff -aur linux-2.4.4-ref/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.4.4-ref/include/linux/sched.h	Wed May  2 15:57:14 2001
+++ linux/include/linux/sched.h	Wed May  2 16:10:30 2001
@@ -710,6 +710,8 @@
 /*
  * Routines for handling mm_structs
  */
+extern struct mm_struct * mm_init(struct mm_struct * mm);
+extern int dup_mmap(struct mm_struct * mm);
 extern struct mm_struct * mm_alloc(void);
 
 extern struct mm_struct * start_lazy_tlb(void);
diff -aur linux-2.4.4-ref/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.4-ref/kernel/fork.c	Thu Apr 26 07:11:17 2001
+++ linux/kernel/fork.c	Wed May  2 15:50:42 2001
@@ -122,7 +122,7 @@
 	return last_pid;
 }
 
-static inline int dup_mmap(struct mm_struct * mm)
+int dup_mmap(struct mm_struct * mm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
@@ -197,7 +197,7 @@
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
-static struct mm_struct * mm_init(struct mm_struct * mm)
+struct mm_struct * mm_init(struct mm_struct * mm)
 {
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
