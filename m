Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264188AbUEHWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbUEHWAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUEHWAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:00:11 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3434 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264188AbUEHV6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:58:45 -0400
Date: Sat, 8 May 2004 22:58:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 26 __setup_arg_pages
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082256380.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anon_vma will need to pass vma to "put_dirty_page"; but instead of just
adding that arg to its callers, try to tidy this area up a little with
__setup_arg_pages(bprm, stack_top, vm_stack_flags), cutting duplicated
code out of the 64-bit support for 32-bit execs.  Still fairly horrid
(they tend to #include fs/binfmt_elf.c after #defining setup_arg_pages
to local variant), I'd break their builds if we went further.

Rename put_dirty_page to install_arg_page, now static to fs/exec.c.
While there, moved its flush_dcache_page up before page_table_lock -
doesn't in fact matter at all, just saves one worry when researching
flush_dcache_page locking constraints.

 arch/ia64/ia32/binfmt_elf32.c  |   59 +++----------------------------
 arch/ia64/mm/init.c            |    2 -
 arch/s390/kernel/compat_exec.c |   78 +----------------------------------------
 arch/x86_64/ia32/ia32_binfmt.c |   65 ++++------------------------------
 fs/exec.c                      |   52 +++++++++++++++------------
 include/linux/binfmts.h        |    2 +
 include/linux/mm.h             |    2 -
 7 files changed, 49 insertions(+), 211 deletions(-)

--- rmap25/arch/ia64/ia32/binfmt_elf32.c	2004-05-05 13:29:08.000000000 +0100
+++ rmap26/arch/ia64/ia32/binfmt_elf32.c	2004-05-08 20:54:54.347237808 +0100
@@ -152,61 +152,14 @@ ia64_elf32_init (struct pt_regs *regs)
 int
 ia32_setup_arg_pages (struct linux_binprm *bprm, int executable_stack)
 {
-	unsigned long stack_base;
-	struct vm_area_struct *mpnt;
-	struct mm_struct *mm = current->mm;
-	int i;
+	unsigned long vm_stack_flags = VM_STACK_FLAGS;
 
-	stack_base = IA32_STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
-	mm->arg_start = bprm->p + stack_base;
+	if (executable_stack == EXSTACK_ENABLE_X)
+		vm_stack_flags |= VM_EXEC;
+	else if (executable_stack == EXSTACK_DISABLE_X)
+		vm_stack_flags &= ~VM_EXEC;
 
-	bprm->p += stack_base;
-	if (bprm->loader)
-		bprm->loader += stack_base;
-	bprm->exec += stack_base;
-
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!mpnt)
-		return -ENOMEM;
-
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
-
-	down_write(&current->mm->mmap_sem);
-	{
-		mpnt->vm_mm = current->mm;
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = IA32_STACK_TOP;
-		if (executable_stack == EXSTACK_ENABLE_X)
-			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
-		else if (executable_stack == EXSTACK_DISABLE_X)
-			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
-		else
-			mpnt->vm_flags = VM_STACK_FLAGS;
-		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC)?
-					PAGE_COPY_EXEC: PAGE_COPY;
-		mpnt->vm_ops = NULL;
-		mpnt->vm_pgoff = 0;
-		mpnt->vm_file = NULL;
-		mpnt->vm_private_data = 0;
-		mpol_set_vma_default(mpnt);
-		insert_vm_struct(current->mm, mpnt);
-		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-	}
-
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page *page = bprm->page[i];
-		if (page) {
-			bprm->page[i] = NULL;
-			put_dirty_page(current, page, stack_base, mpnt->vm_page_prot);
-		}
-		stack_base += PAGE_SIZE;
-	}
-	up_write(&current->mm->mmap_sem);
-
-	return 0;
+	return __setup_arg_pages(bprm, IA32_STACK_TOP, vm_stack_flags);
 }
 
 static void
--- rmap25/arch/ia64/mm/init.c	2004-05-05 13:29:12.000000000 +0100
+++ rmap26/arch/ia64/mm/init.c	2004-05-08 20:54:54.349237504 +0100
@@ -222,7 +222,7 @@ free_initrd_mem (unsigned long start, un
 }
 
 /*
- * This is like put_dirty_page() but installs a clean page in the kernel's page table.
+ * This installs a clean page in the kernel's page table.
  */
 struct page *
 put_kernel_page (struct page *page, unsigned long address, pgprot_t pgprot)
--- rmap25/arch/s390/kernel/compat_exec.c	2004-05-05 13:29:08.000000000 +0100
+++ rmap26/arch/s390/kernel/compat_exec.c	2004-05-08 20:54:54.350237352 +0100
@@ -8,87 +8,13 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/slab.h>
-#include <linux/file.h>
-#include <linux/mman.h>
-#include <linux/a.out.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
-#include <linux/pagemap.h>
 #include <linux/mm.h>
-#include <linux/highmem.h>
-#include <linux/spinlock.h>
 #include <linux/binfmts.h>
 #include <linux/module.h>
-#include <linux/security.h>
-
-#include <asm/uaccess.h>
-#include <asm/pgalloc.h>
-#include <asm/mmu_context.h>
-
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
-
-
-#undef STACK_TOP
-#define STACK_TOP TASK31_SIZE
 
 int setup_arg_pages32(struct linux_binprm *bprm, int executable_stack)
 {
-	unsigned long stack_base;
-	struct vm_area_struct *mpnt;
-	struct mm_struct *mm = current->mm;
-	int i;
-
-	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
-	mm->arg_start = bprm->p + stack_base;
-
-	bprm->p += stack_base;
-	if (bprm->loader)
-		bprm->loader += stack_base;
-	bprm->exec += stack_base;
-
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!mpnt) 
-		return -ENOMEM; 
-	
-	if (security_vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
-
-	down_write(&mm->mmap_sem);
-	{
-		mpnt->vm_mm = mm;
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = STACK_TOP;
-		/* executable stack setting would be applied here */
-		mpnt->vm_page_prot = PAGE_COPY;
-		mpnt->vm_flags = VM_STACK_FLAGS;
-		mpnt->vm_ops = NULL;
-		mpnt->vm_pgoff = 0;
-		mpnt->vm_file = NULL;
-		mpol_set_vma_default(mpnt);
-		mpnt->vm_private_data = (void *) 0;
-		insert_vm_struct(mm, mpnt);
-		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-	} 
-
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page *page = bprm->page[i];
-		if (page) {
-			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base,PAGE_COPY);
-		}
-		stack_base += PAGE_SIZE;
-	}
-	up_write(&mm->mmap_sem);
-	
-	return 0;
+	/* executable_stack argument is currently ignored */
+	return __setup_arg_pages(bprm, TASK31_SIZE, VM_STACK_FLAGS);
 }
-
 EXPORT_SYMBOL(setup_arg_pages32);
--- rmap25/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 13:29:08.000000000 +0100
+++ rmap26/arch/x86_64/ia32/ia32_binfmt.c	2004-05-08 20:54:54.351237200 +0100
@@ -325,63 +325,16 @@ static void elf32_init(struct pt_regs *r
 	me->thread.es = __USER_DS;
 }
 
-int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
+int ia32_setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
-	unsigned long stack_base;
-	struct vm_area_struct *mpnt;
-	struct mm_struct *mm = current->mm;
-	int i;
-
-	stack_base = IA32_STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
-	mm->arg_start = bprm->p + stack_base;
-
-	bprm->p += stack_base;
-	if (bprm->loader)
-		bprm->loader += stack_base;
-	bprm->exec += stack_base;
-
-	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!mpnt) 
-		return -ENOMEM; 
-	
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
-
-	down_write(&mm->mmap_sem);
-	{
-		mpnt->vm_mm = mm;
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = IA32_STACK_TOP;
-		if (executable_stack == EXSTACK_ENABLE_X)
-			mpnt->vm_flags = vm_stack_flags32 |  VM_EXEC;
-		else if (executable_stack == EXSTACK_DISABLE_X)
-			mpnt->vm_flags = vm_stack_flags32 & ~VM_EXEC;
-		else
-			mpnt->vm_flags = vm_stack_flags32;
- 		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
- 			PAGE_COPY_EXEC : PAGE_COPY;
-		mpnt->vm_ops = NULL;
-		mpnt->vm_pgoff = 0;
-		mpnt->vm_file = NULL;
-		mpol_set_vma_default(mpnt);
-		mpnt->vm_private_data = (void *) 0;
-		insert_vm_struct(mm, mpnt);
-		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-	} 
-
-	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
-		struct page *page = bprm->page[i];
-		if (page) {
-			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base,mpnt->vm_page_prot);
-		}
-		stack_base += PAGE_SIZE;
-	}
-	up_write(&mm->mmap_sem);
-	
-	return 0;
+	unsigned long vm_stack_flags = vm_stack_flags32;
+
+	if (executable_stack == EXSTACK_ENABLE_X)
+		vm_stack_flags |= VM_EXEC;
+	else if (executable_stack == EXSTACK_DISABLE_X)
+		vm_stack_flags &= ~VM_EXEC;
+
+	return __setup_arg_pages(bprm, IA32_STACK_TOP, vm_stack_flags);
 }
 
 static unsigned long
--- rmap25/fs/exec.c	2004-05-05 13:29:10.000000000 +0100
+++ rmap26/fs/exec.c	2004-05-08 20:54:54.354236744 +0100
@@ -293,17 +293,19 @@ EXPORT_SYMBOL(copy_strings_kernel);
  * This routine is used to map in a page into an address space: needed by
  * execve() for the initial stack and environment pages.
  *
- * tsk->mm->mmap_sem is held for writing.
+ * vma->vm_mm->mmap_sem is held for writing.
  */
-void put_dirty_page(struct task_struct *tsk, struct page *page,
-			unsigned long address, pgprot_t prot)
+static void install_arg_page(struct vm_area_struct *vma,
+			struct page *page, unsigned long address)
 {
-	struct mm_struct *mm = tsk->mm;
+	struct mm_struct *mm = vma->vm_mm;
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte;
 
+	flush_dcache_page(page);
 	pgd = pgd_offset(mm, address);
+
 	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);
 	if (!pmd)
@@ -317,8 +319,8 @@ void put_dirty_page(struct task_struct *
 	}
 	mm->rss++;
 	lru_cache_add_active(page);
-	flush_dcache_page(page);
-	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
+	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
+					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, mm, address);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
@@ -328,10 +330,11 @@ void put_dirty_page(struct task_struct *
 out:
 	spin_unlock(&mm->page_table_lock);
 	__free_page(page);
-	force_sig(SIGKILL, tsk);
+	force_sig(SIGKILL, current);
 }
 
-int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
+int __setup_arg_pages(struct linux_binprm *bprm,
+		unsigned long stack_top, unsigned long vm_stack_flags)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -375,7 +378,7 @@ int setup_arg_pages(struct linux_binprm 
 	stack_base = current->rlim[RLIMIT_STACK].rlim_max;
 	if (stack_base > (1 << 30))
 		stack_base = 1 << 30;
-	stack_base = PAGE_ALIGN(STACK_TOP - stack_base);
+	stack_base = PAGE_ALIGN(stack_top - stack_base);
 
 	mm->arg_start = stack_base;
 	arg_size = i << PAGE_SHIFT;
@@ -384,9 +387,9 @@ int setup_arg_pages(struct linux_binprm 
 	while (i < MAX_ARG_PAGES)
 		bprm->page[i++] = NULL;
 #else
-	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
+	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
-	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
+	arg_size = stack_top - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
 
 	bprm->p += stack_base;
@@ -412,17 +415,9 @@ int setup_arg_pages(struct linux_binprm 
 			(PAGE_SIZE - 1 + (unsigned long) bprm->p);
 #else
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = STACK_TOP;
+		mpnt->vm_end = stack_top;
 #endif
-		/* Adjust stack execute permissions; explicitly enable
-		 * for EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X
-		 * and leave alone (arch default) otherwise. */
-		if (unlikely(executable_stack == EXSTACK_ENABLE_X))
-			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
-		else if (executable_stack == EXSTACK_DISABLE_X)
-			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
-		else
-			mpnt->vm_flags = VM_STACK_FLAGS;
+		mpnt->vm_flags = vm_stack_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
@@ -437,8 +432,7 @@ int setup_arg_pages(struct linux_binprm 
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current, page, stack_base,
-					mpnt->vm_page_prot);
+			install_arg_page(mpnt, page, stack_base);
 		}
 		stack_base += PAGE_SIZE;
 	}
@@ -446,7 +440,19 @@ int setup_arg_pages(struct linux_binprm 
 	
 	return 0;
 }
+EXPORT_SYMBOL(__setup_arg_pages);
 
+int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
+{
+	unsigned long vm_stack_flags = VM_STACK_FLAGS;
+
+	if (executable_stack == EXSTACK_ENABLE_X)
+		vm_stack_flags |= VM_EXEC;
+	else if (executable_stack == EXSTACK_DISABLE_X)
+		vm_stack_flags &= ~VM_EXEC;
+
+	return __setup_arg_pages(bprm, STACK_TOP, vm_stack_flags);
+}
 EXPORT_SYMBOL(setup_arg_pages);
 
 #define free_arg_pages(bprm) do { } while (0)
--- rmap25/include/linux/binfmts.h	2004-05-05 13:29:09.000000000 +0100
+++ rmap26/include/linux/binfmts.h	2004-05-08 20:54:54.355236592 +0100
@@ -69,6 +69,8 @@ extern int flush_old_exec(struct linux_b
 #define EXSTACK_ENABLE_X  2	/* Enable executable stacks */
 
 extern int setup_arg_pages(struct linux_binprm * bprm, int executable_stack);
+extern int __setup_arg_pages(struct linux_binprm *bprm,
+		unsigned long stack_top, unsigned long vm_flags);
 extern int copy_strings(int argc,char __user * __user * argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
--- rmap25/include/linux/mm.h	2004-05-05 13:29:08.000000000 +0100
+++ rmap26/include/linux/mm.h	2004-05-08 20:54:54.356236440 +0100
@@ -495,8 +495,6 @@ extern int install_file_pte(struct mm_st
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
-void put_dirty_page(struct task_struct *tsk, struct page *page,
-			unsigned long address, pgprot_t prot);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);

