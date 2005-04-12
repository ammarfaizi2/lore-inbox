Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVDLQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVDLQml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVDLQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:40:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:27340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262247AbVDLKl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:41:27 -0400
Message-Id: <200504121031.j3CAVnpl005415@shell0.pdx.osdl.net>
Subject: [patch 072/198] x86_64: Use a VMA for the 32bit vsyscall
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andi Kleen <ak@muc.de>

Use a real VMA to map the 32bit vsyscall page

This interacts better with Hugh's upcomming VMA walk optimization
Also removes some ugly special cases.

Code roughly modelled after the ppc64 vdso version from Ben Herrenschmidt.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/ia32/ia32_binfmt.c |    4 +
 25-akpm/arch/x86_64/ia32/syscall32.c   |   92 +++++++++++++++++----------------
 25-akpm/arch/x86_64/mm/fault.c         |   12 ----
 25-akpm/arch/x86_64/mm/init.c          |   26 ++-------
 25-akpm/include/asm-x86_64/proto.h     |    2 
 5 files changed, 61 insertions(+), 75 deletions(-)

diff -puN arch/x86_64/ia32/ia32_binfmt.c~x86_64-use-a-vma-for-the-32bit-vsyscall arch/x86_64/ia32/ia32_binfmt.c
--- 25/arch/x86_64/ia32/ia32_binfmt.c~x86_64-use-a-vma-for-the-32bit-vsyscall	2005-04-12 03:21:20.642998688 -0700
+++ 25-akpm/arch/x86_64/ia32/ia32_binfmt.c	2005-04-12 03:21:20.651997320 -0700
@@ -312,6 +312,10 @@ MODULE_AUTHOR("Eric Youngdale, Andi Klee
 
 static void elf32_init(struct pt_regs *);
 
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+#define arch_setup_additional_pages syscall32_setup_pages
+extern int syscall32_setup_pages(struct linux_binprm *, int exstack);
+
 #include "../../../fs/binfmt_elf.c" 
 
 static void elf32_init(struct pt_regs *regs)
diff -puN arch/x86_64/ia32/syscall32.c~x86_64-use-a-vma-for-the-32bit-vsyscall arch/x86_64/ia32/syscall32.c
--- 25/arch/x86_64/ia32/syscall32.c~x86_64-use-a-vma-for-the-32bit-vsyscall	2005-04-12 03:21:20.644998384 -0700
+++ 25-akpm/arch/x86_64/ia32/syscall32.c	2005-04-12 03:21:20.652997168 -0700
@@ -9,6 +9,7 @@
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
+#include <linux/security.h>
 #include <asm/proto.h>
 #include <asm/tlbflush.h>
 #include <asm/ia32_unistd.h>
@@ -30,51 +31,57 @@ extern int sysctl_vsyscall32;
 char *syscall32_page; 
 static int use_sysenter = -1;
 
-/*
- * Map the 32bit vsyscall page on demand.
- *
- * RED-PEN: This knows too much about high level VM.
- *
- * Alternative would be to generate a vma with appropriate backing options
- * and let it be handled by generic VM.
- */
-int __map_syscall32(struct mm_struct *mm, unsigned long address)
-{ 
-	pgd_t *pgd;
-	pud_t *pud;
-	pte_t *pte;
-	pmd_t *pmd;
-	int err = -ENOMEM;
-
-	spin_lock(&mm->page_table_lock); 
- 	pgd = pgd_offset(mm, address);
- 	pud = pud_alloc(mm, pgd, address);
- 	if (pud) {
- 		pmd = pmd_alloc(mm, pud, address);
- 		if (pmd && (pte = pte_alloc_map(mm, pmd, address)) != NULL) {
- 			if (pte_none(*pte)) {
- 				set_pte(pte,
- 					mk_pte(virt_to_page(syscall32_page),
- 					       PAGE_KERNEL_VSYSCALL32));
- 			}
- 			/* Flush only the local CPU. Other CPUs taking a fault
- 			   will just end up here again
-			   This probably not needed and just paranoia. */
- 			__flush_tlb_one(address);
- 			err = 0;
-		}
-	}
-	spin_unlock(&mm->page_table_lock);
-	return err;
+static struct page *
+syscall32_nopage(struct vm_area_struct *vma, unsigned long adr, int *type)
+{
+	struct page *p = virt_to_page(adr - vma->vm_start + syscall32_page);
+	get_page(p);
+	return p;
 }
 
-int map_syscall32(struct mm_struct *mm, unsigned long address)
+/* Prevent VMA merging */
+static void syscall32_vma_close(struct vm_area_struct *vma)
 {
-	int err;
-	down_read(&mm->mmap_sem);
-	err = __map_syscall32(mm, address);
-	up_read(&mm->mmap_sem);
-	return err;
+}
+
+static struct vm_operations_struct syscall32_vm_ops = {
+	.close = syscall32_vma_close,
+	.nopage = syscall32_nopage,
+};
+
+struct linux_binprm;
+
+/* Setup a VMA at program startup for the vsyscall page */
+int syscall32_setup_pages(struct linux_binprm *bprm, int exstack)
+{
+	int npages = (VSYSCALL32_END - VSYSCALL32_BASE) >> PAGE_SHIFT;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma)
+		return -ENOMEM;
+	if (security_vm_enough_memory(npages)) {
+		kmem_cache_free(vm_area_cachep, vma);
+		return -ENOMEM;
+	}
+
+	memset(vma, 0, sizeof(struct vm_area_struct));
+	/* Could randomize here */
+	vma->vm_start = VSYSCALL32_BASE;
+	vma->vm_end = VSYSCALL32_END;
+	/* MAYWRITE to allow gdb to COW and set breakpoints */
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYEXEC|VM_MAYWRITE;
+	vma->vm_flags |= mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
+	vma->vm_ops = &syscall32_vm_ops;
+	vma->vm_mm = mm;
+
+	down_write(&mm->mmap_sem);
+	insert_vm_struct(mm, vma);
+	mm->total_vm += npages;
+	up_write(&mm->mmap_sem);
+	return 0;
 }
 
 static int __init init_syscall32(void)
@@ -82,7 +89,6 @@ static int __init init_syscall32(void)
 	syscall32_page = (void *)get_zeroed_page(GFP_KERNEL); 
 	if (!syscall32_page) 
 		panic("Cannot allocate syscall32 page"); 
-	SetPageReserved(virt_to_page(syscall32_page));
  	if (use_sysenter > 0) {
  		memcpy(syscall32_page, syscall32_sysenter,
  		       syscall32_sysenter_end - syscall32_sysenter);
diff -puN arch/x86_64/mm/fault.c~x86_64-use-a-vma-for-the-32bit-vsyscall arch/x86_64/mm/fault.c
--- 25/arch/x86_64/mm/fault.c~x86_64-use-a-vma-for-the-32bit-vsyscall	2005-04-12 03:21:20.645998232 -0700
+++ 25-akpm/arch/x86_64/mm/fault.c	2005-04-12 03:21:20.652997168 -0700
@@ -458,17 +458,6 @@ bad_area:
 	up_read(&mm->mmap_sem);
 
 bad_area_nosemaphore:
-
-#ifdef CONFIG_IA32_EMULATION
-	/* 32bit vsyscall. map on demand. */
-	if (test_thread_flag(TIF_IA32) &&
-	    address >= VSYSCALL32_BASE && address < VSYSCALL32_END) {
-		if (map_syscall32(mm, address) < 0)
-			goto out_of_memory2;
-		return;
-	}
-#endif
-
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
 		if (is_prefetch(regs, address, error_code))
@@ -550,7 +539,6 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-out_of_memory2:
 	if (current->pid == 1) { 
 		yield();
 		goto again;
diff -puN arch/x86_64/mm/init.c~x86_64-use-a-vma-for-the-32bit-vsyscall arch/x86_64/mm/init.c
--- 25/arch/x86_64/mm/init.c~x86_64-use-a-vma-for-the-32bit-vsyscall	2005-04-12 03:21:20.646998080 -0700
+++ 25-akpm/arch/x86_64/mm/init.c	2005-04-12 03:21:20.653997016 -0700
@@ -583,9 +583,9 @@ static __init int x8664_sysctl_init(void
 __initcall(x8664_sysctl_init);
 #endif
 
-/* Pseudo VMAs to allow ptrace access for the vsyscall pages.  x86-64 has two
-   different ones: one for 32bit and one for 64bit. Use the appropiate
-   for the target task. */
+/* A pseudo VMAs to allow ptrace access for the vsyscall page.   This only
+   covers the 64bit vsyscall page now. 32bit has a real VMA now and does
+   not need special handling anymore. */
 
 static struct vm_area_struct gate_vma = {
 	.vm_start = VSYSCALL_START,
@@ -593,22 +593,11 @@ static struct vm_area_struct gate_vma = 
 	.vm_page_prot = PAGE_READONLY
 };
 
-static struct vm_area_struct gate32_vma = {
-	.vm_start = VSYSCALL32_BASE,
-	.vm_end = VSYSCALL32_END,
-	.vm_page_prot = PAGE_READONLY
-};
-
 struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
 {
 #ifdef CONFIG_IA32_EMULATION
-	if (test_tsk_thread_flag(tsk, TIF_IA32)) {
-		/* lookup code assumes the pages are present. set them up
-		   now */
-		if (__map_syscall32(tsk->mm, VSYSCALL32_BASE) < 0)
-			return NULL;
-		return &gate32_vma;
-	}
+	if (test_tsk_thread_flag(tsk, TIF_IA32))
+		return NULL;
 #endif
 	return &gate_vma;
 }
@@ -616,6 +605,8 @@ struct vm_area_struct *get_gate_vma(stru
 int in_gate_area(struct task_struct *task, unsigned long addr)
 {
 	struct vm_area_struct *vma = get_gate_vma(task);
+	if (!vma)
+		return 0;
 	return (addr >= vma->vm_start) && (addr < vma->vm_end);
 }
 
@@ -625,6 +616,5 @@ int in_gate_area(struct task_struct *tas
  */
 int in_gate_area_no_task(unsigned long addr)
 {
-	return (((addr >= VSYSCALL_START) && (addr < VSYSCALL_END)) ||
-		((addr >= VSYSCALL32_BASE) && (addr < VSYSCALL32_END)));
+	return (addr >= VSYSCALL_START) && (addr < VSYSCALL_END);
 }
diff -puN include/asm-x86_64/proto.h~x86_64-use-a-vma-for-the-32bit-vsyscall include/asm-x86_64/proto.h
--- 25/include/asm-x86_64/proto.h~x86_64-use-a-vma-for-the-32bit-vsyscall	2005-04-12 03:21:20.648997776 -0700
+++ 25-akpm/include/asm-x86_64/proto.h	2005-04-12 03:21:20.653997016 -0700
@@ -69,8 +69,6 @@ extern void __die(const char * str, stru
 extern void __show_regs(struct pt_regs * regs);
 extern void show_regs(struct pt_regs * regs);
 
-extern int map_syscall32(struct mm_struct *mm, unsigned long address);
-extern int __map_syscall32(struct mm_struct *mm, unsigned long address);
 extern char *syscall32_page;
 extern void syscall32_cpu_init(void);
 
_
