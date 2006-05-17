Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWEQHt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWEQHt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWEQHt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:49:56 -0400
Received: from ozlabs.org ([203.10.76.45]:60313 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750846AbWEQHtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:49:55 -0400
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
	patch
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Gerd Hoffmann <kraxel@suse.de>, Zachary Amsden <zach@vmware.com>
In-Reply-To: <20060516064723.GA14121@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain>
	 <20060516064723.GA14121@elte.hu>
Content-Type: text/plain
Date: Wed, 17 May 2006 17:49:48 +1000
Message-Id: <1147852189.1749.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 08:47 +0200, Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > AFAICT we'll pay one extra TLB entry for this patch.  Zach had a patch 
> > which left the vsyscall page at the top of memory (minus hole for 
> > hypervisor) and patched the ELF header at boot.
> 
> i'd suggest the solution from exec-shield (which has been there for a 
> long time), which also randomizes the vsyscall vma.

Hi Ingo!

	Thanks, I looked at the exec-shield patch.  It has some rough edges (at
least the 2.6.16 version I found).

	Gerd's is basically a minimal subset of the exec-shield: we can go
further towards exec-shield by using get_unmapped_area for the vsyscall
page rather than nailing it above the stack, but it takes us from a
280-line patch to a 480-line patch.

See below...
Rusty.

Name: Move vsyscall page out of fixmap into normal vma as per mmap
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Status: Boots under qemu

Rather than move the stack down, use get_unmapped_area for the
vsyscall page, as the exec-shield patch does.  This means we need a
pointer in the thread_info, too.

This steals half of the code from Gerd Hoffmann's patch which moves
out of fixmap, and most of the rest from Ingo Molnar's exec-shield
patch for 2.6.16.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/asm-offsets.c .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/asm-offsets.c
--- .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/asm-offsets.c	2005-07-15 04:38:36.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/asm-offsets.c	2006-05-17 17:10:49.000000000 +1000
@@ -53,6 +53,7 @@ void foo(void)
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
+	OFFSET(TI_sysenter_return, thread_info, sysenter_return);
 	BLANK();
 
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
@@ -68,5 +69,4 @@ void foo(void)
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
-	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/entry.S .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/entry.S
--- .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/entry.S	2006-05-16 10:50:48.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/entry.S	2006-05-17 17:10:49.000000000 +1000
@@ -184,8 +184,12 @@ sysenter_past_esp:
 	pushl %ebp
 	pushfl
 	pushl $(__USER_CS)
-	pushl $SYSENTER_RETURN
-
+	/*
+	 * Push current_thread_info()->sysenter_return to the stack.
+	 * A tiny bit of offset fixup is necessary - 4*4 means the 4 words
+	 * pushed above; +8 corresponds to copy_thread's esp0 setting.
+	 */
+	pushl (TI_sysenter_return-THREAD_SIZE+8+4*4)(%esp)
 /*
  * Load the potential sixth argument from user stack.
  * Careful about security.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/signal.c .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/signal.c
--- .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/signal.c	2006-05-16 10:50:48.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/signal.c	2006-05-17 17:10:49.000000000 +1000
@@ -351,7 +351,7 @@ static int setup_frame(int sig, struct k
 			goto give_sigsegv;
 	}
 
-	restorer = &__kernel_sigreturn;
+	restorer = current->mm->context.vdso + (long)&__kernel_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -447,7 +447,7 @@ static int setup_rt_frame(int sig, struc
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	restorer = &__kernel_rt_sigreturn;
+	restorer = current->mm->context.vdso + (long)&__kernel_rt_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/sysenter.c .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/sysenter.c
--- .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/sysenter.c	2006-03-23 12:42:01.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/sysenter.c	2006-05-17 17:10:49.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/elf.h>
+#include <linux/mm.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -45,23 +46,111 @@ void enable_sep_cpu(void)
  */
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
+static void *syscall_page;
 
 int __init sysenter_setup(void)
 {
-	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
-
-	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
+	syscall_page = (void *)get_zeroed_page(GFP_ATOMIC);
 
 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
-		memcpy(page,
+		memcpy(syscall_page,
 		       &vsyscall_int80_start,
 		       &vsyscall_int80_end - &vsyscall_int80_start);
 		return 0;
 	}
 
-	memcpy(page,
+	memcpy(syscall_page,
 	       &vsyscall_sysenter_start,
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
 	return 0;
 }
+
+static struct page*
+syscall_nopage(struct vm_area_struct *vma, unsigned long adr, int *type)
+{
+	struct page *p = virt_to_page(adr - vma->vm_start + syscall_page);
+	get_page(p);
+	return p;
+}
+
+/* Prevent VMA merging */
+static void syscall_vma_close(struct vm_area_struct *vma)
+{
+}
+
+static struct vm_operations_struct syscall_vm_ops = {
+	.close = syscall_vma_close,
+	.nopage = syscall_nopage,
+};
+
+/* Defined in vsyscall-sysenter.S */
+extern char SYSENTER_RETURN_OFFSET[];
+
+/* Setup a VMA at program startup for the vsyscall page */
+int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr;
+	int ret;
+
+	down_write(&mm->mmap_sem);
+	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma) {
+		ret = -ENOMEM;
+		goto up_fail;
+	}
+
+	memset(vma, 0, sizeof(struct vm_area_struct));
+	vma->vm_start = addr;
+	vma->vm_end = addr + PAGE_SIZE;
+	/* MAYWRITE to allow gdb to COW and set breakpoints */
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
+	vma->vm_flags |= mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
+	vma->vm_ops = &syscall_vm_ops;
+	vma->vm_mm = mm;
+
+	if ((ret = insert_vm_struct(mm, vma)))
+		goto free_vma;
+	current->mm->context.vdso = (void *)addr;
+	current_thread_info()->sysenter_return = SYSENTER_RETURN_OFFSET + addr;
+	mm->total_vm++;
+	up_write(&mm->mmap_sem);
+	return 0;
+
+free_vma:
+	kmem_cache_free(vm_area_cachep, vma);
+up_fail:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso)
+		return "[vdso]";
+	return NULL;
+}
+
+struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
+{
+	return NULL;
+}
+
+int in_gate_area(struct task_struct *task, unsigned long addr)
+{
+	return 0;
+}
+
+int in_gate_area_no_task(unsigned long addr)
+{
+	return 0;
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/vsyscall-sysenter.S .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/vsyscall-sysenter.S
--- .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/vsyscall-sysenter.S	2006-05-16 10:50:48.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/vsyscall-sysenter.S	2006-05-17 17:10:49.000000000 +1000
@@ -42,11 +42,11 @@ __kernel_vsyscall:
 	/* 7: align return point with nop's to make disassembly easier */
 	.space 7,0x90
 
-	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
+	/* 14: System call restart point is here! (SYSENTER_RETURN_OFFSET-2) */
 	jmp .Lenter_kernel
 	/* 16: System call normal return point is here! */
-	.globl SYSENTER_RETURN	/* Symbol used by entry.S.  */
-SYSENTER_RETURN:
+	.globl SYSENTER_RETURN_OFFSET	/* Symbol used by sysenter.c  */
+SYSENTER_RETURN_OFFSET:
 	pop %ebp
 .Lpop_ebp:
 	pop %edx
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/vsyscall.lds.S .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/vsyscall.lds.S
--- .23560-linux-2.6.17-rc4-git3/arch/i386/kernel/vsyscall.lds.S	2006-03-23 12:42:42.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/kernel/vsyscall.lds.S	2006-05-17 17:10:49.000000000 +1000
@@ -7,7 +7,7 @@
 
 SECTIONS
 {
-  . = VSYSCALL_BASE + SIZEOF_HEADERS;
+  . = SIZEOF_HEADERS;
 
   .hash           : { *(.hash) }		:text
   .dynsym         : { *(.dynsym) }
@@ -20,7 +20,7 @@ SECTIONS
      For the layouts to match, we need to skip more than enough
      space for the dynamic symbol table et al.  If this amount
      is insufficient, ld -shared will barf.  Just increase it here.  */
-  . = VSYSCALL_BASE + 0x400;
+  . = 0x400;
 
   .text           : { *(.text) }		:text =0x90909090
   .note		  : { *(.note.*) }		:text :note
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/arch/i386/mm/pgtable.c .23560-linux-2.6.17-rc4-git3.updated/arch/i386/mm/pgtable.c
--- .23560-linux-2.6.17-rc4-git3/arch/i386/mm/pgtable.c	2006-05-16 10:50:48.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/arch/i386/mm/pgtable.c	2006-05-17 17:10:49.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -138,6 +139,10 @@ void set_pmd_pfn(unsigned long vaddr, un
 	__flush_tlb_one(vaddr);
 }
 
+static int nr_fixmaps = 0;
+unsigned long __FIXADDR_TOP = 0xfffff000;
+EXPORT_SYMBOL(__FIXADDR_TOP);
+
 void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
 {
 	unsigned long address = __fix_to_virt(idx);
@@ -147,6 +152,13 @@ void __set_fixmap (enum fixed_addresses 
 		return;
 	}
 	set_pte_pfn(address, phys >> PAGE_SHIFT, flags);
+	nr_fixmaps++;
+}
+
+void set_fixaddr_top(unsigned long top)
+{
+	BUG_ON(nr_fixmaps > 0);
+	__FIXADDR_TOP = top - PAGE_SIZE;
 }
 
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/fs/proc/task_mmu.c .23560-linux-2.6.17-rc4-git3.updated/fs/proc/task_mmu.c
--- .23560-linux-2.6.17-rc4-git3/fs/proc/task_mmu.c	2006-03-23 12:44:56.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/fs/proc/task_mmu.c	2006-05-17 17:10:49.000000000 +1000
@@ -153,22 +153,23 @@ static int show_map_internal(struct seq_
 		pad_len_spaces(m, len);
 		seq_path(m, file->f_vfsmnt, file->f_dentry, "\n");
 	} else {
-		if (mm) {
-			if (vma->vm_start <= mm->start_brk &&
+		const char *name = arch_vma_name(vma);
+		if (!name) {
+			if (mm) {
+				if (vma->vm_start <= mm->start_brk &&
 						vma->vm_end >= mm->brk) {
-				pad_len_spaces(m, len);
-				seq_puts(m, "[heap]");
-			} else {
-				if (vma->vm_start <= mm->start_stack &&
-					vma->vm_end >= mm->start_stack) {
-
-					pad_len_spaces(m, len);
-					seq_puts(m, "[stack]");
+					name = "[heap]";
+				} else if (vma->vm_start <= mm->start_stack &&
+					   vma->vm_end >= mm->start_stack) {
+					name = "[stack]";
 				}
+			} else {
+				name = "[vdso]";
 			}
-		} else {
+		}
+		if (name) {
 			pad_len_spaces(m, len);
-			seq_puts(m, "[vdso]");
+			seq_puts(m, name);
 		}
 	}
 	seq_putc(m, '\n');
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/include/asm-i386/elf.h .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/elf.h
--- .23560-linux-2.6.17-rc4-git3/include/asm-i386/elf.h	2006-03-23 12:44:01.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/elf.h	2006-05-17 17:10:49.000000000 +1000
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/system.h>		/* for savesegment */
 #include <asm/auxvec.h>
+#include <asm/desc.h>
 
 #include <linux/utsname.h>
 
@@ -129,11 +130,20 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
 
-#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
+#define VSYSCALL_BASE	((unsigned long)current->mm->context.vdso)
 #define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
-#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
+#define VSYSCALL_OFFSET	((unsigned long) &__kernel_vsyscall)
+#define VSYSCALL_ENTRY	(VSYSCALL_BASE + VSYSCALL_OFFSET)
+/* kernel-internal fixmap address: */
+#define __VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
+#define __VSYSCALL_EHDR	((const struct elfhdr *) __VSYSCALL_BASE)
 extern void __kernel_vsyscall;
 
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+                                       int executable_stack);
+
 #define ARCH_DLINFO						\
 do {								\
 		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
@@ -148,15 +158,15 @@ do {								\
  * Dumping its extra ELF program headers includes all the other information
  * a debugger needs to easily find how the vsyscall DSO was being used.
  */
-#define ELF_CORE_EXTRA_PHDRS		(VSYSCALL_EHDR->e_phnum)
+#define ELF_CORE_EXTRA_PHDRS		(__VSYSCALL_EHDR->e_phnum)
 #define ELF_CORE_WRITE_EXTRA_PHDRS					      \
 do {									      \
 	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+		(const struct elf_phdr *) (__VSYSCALL_BASE		      \
+					   + __VSYSCALL_EHDR->e_phoff);	      \
 	int i;								      \
 	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+	for (i = 0; i < __VSYSCALL_EHDR->e_phnum; ++i) {		      \
 		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
 		if (phdr.p_type == PT_LOAD) {				      \
 			BUG_ON(ofs != 0);				      \
@@ -174,10 +184,10 @@ do {									      \
 #define ELF_CORE_WRITE_EXTRA_DATA					      \
 do {									      \
 	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+		(const struct elf_phdr *) (__VSYSCALL_BASE		      \
+					   + __VSYSCALL_EHDR->e_phoff);	      \
 	int i;								      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+	for (i = 0; i < __VSYSCALL_EHDR->e_phnum; ++i) {		      \
 		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
 			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
 				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/include/asm-i386/fixmap.h .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/fixmap.h
--- .23560-linux-2.6.17-rc4-git3/include/asm-i386/fixmap.h	2006-03-23 12:43:10.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/fixmap.h	2006-05-17 17:10:49.000000000 +1000
@@ -20,7 +20,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+extern unsigned long __FIXADDR_TOP;
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
@@ -95,6 +95,8 @@ enum fixed_addresses {
 extern void __set_fixmap (enum fixed_addresses idx,
 					unsigned long phys, pgprot_t flags);
 
+extern void set_fixaddr_top(unsigned long top);
+
 #define set_fixmap(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL)
 /*
@@ -116,14 +118,6 @@ extern void __set_fixmap (enum fixed_add
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
 
-/*
- * This is the range that is readable by user mode, and things
- * acting like user mode such as get_user_pages.
- */
-#define FIXADDR_USER_START	(__fix_to_virt(FIX_VSYSCALL))
-#define FIXADDR_USER_END	(FIXADDR_USER_START + PAGE_SIZE)
-
-
 extern void __this_fixmap_does_not_exist(void);
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/include/asm-i386/mmu.h .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/mmu.h
--- .23560-linux-2.6.17-rc4-git3/include/asm-i386/mmu.h	2004-02-04 14:43:57.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/mmu.h	2006-05-17 17:10:49.000000000 +1000
@@ -12,6 +12,7 @@ typedef struct { 
 	int size;
 	struct semaphore sem;
 	void *ldt;
+	void *vdso;
 } mm_context_t;
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/include/asm-i386/page.h .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/page.h
--- .23560-linux-2.6.17-rc4-git3/include/asm-i386/page.h	2006-05-16 10:51:38.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/page.h	2006-05-17 17:10:49.000000000 +1000
@@ -107,6 +107,9 @@ extern int sysctl_legacy_va_layout;
 
 extern int page_is_ram(unsigned long pagenr);
 
+#define __HAVE_ARCH_VMA_NAME 1
+struct vm_area_struct;
+const char *arch_vma_name(struct vm_area_struct *vma);
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
@@ -121,7 +124,7 @@ extern int page_is_ram(unsigned long pag
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
@@ -137,6 +140,7 @@ extern int page_is_ram(unsigned long pag
 	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
 		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define __HAVE_ARCH_GATE_AREA 1
 #endif /* __KERNEL__ */
 
 #include <asm-generic/memory_model.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/include/asm-i386/thread_info.h .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/thread_info.h
--- .23560-linux-2.6.17-rc4-git3/include/asm-i386/thread_info.h	2006-03-23 12:44:59.000000000 +1100
+++ .23560-linux-2.6.17-rc4-git3.updated/include/asm-i386/thread_info.h	2006-05-17 17:10:49.000000000 +1000
@@ -38,6 +38,7 @@ struct thread_info {
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	void			*sysenter_return;
 	struct restart_block    restart_block;
 
 	unsigned long           previous_esp;   /* ESP of the previous stack in case
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23560-linux-2.6.17-rc4-git3/include/linux/mm.h .23560-linux-2.6.17-rc4-git3.updated/include/linux/mm.h
--- .23560-linux-2.6.17-rc4-git3/include/linux/mm.h	2006-05-16 10:51:43.000000000 +1000
+++ .23560-linux-2.6.17-rc4-git3.updated/include/linux/mm.h	2006-05-17 17:10:49.000000000 +1000
@@ -1042,6 +1042,13 @@ int in_gate_area_no_task(unsigned long a
 #define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
+#ifndef __HAVE_ARCH_VMA_NAME
+static inline const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+#endif	/* __HAVE_ARCH_VMA_NAME */
+
 /* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
 #define OOM_DISABLE -17
 

-- 
 ccontrol: http://ccontrol.ozlabs.org

