Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWEWACF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWEWACF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEWABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:01:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54404 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751192AbWEWABh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:01:37 -0400
Date: Tue, 23 May 2006 02:01:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: [patch 3/3] vdso: randomize the i386 vDSO by moving it into a vma
Message-ID: <20060523000132.GD9934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

move the i386 VDSO down into a vma and thus randomize it.

besides the security implications, this feature also helps debuggers,
which can COW a vma-backed VDSO just like a normal DSO and can thus do
single-stepping and other debugging features.

It's good for hypervisors (Xen, VMWare) too, which typically live in the
same high-mapped address space as the VDSO, hence whenever the VDSO is
used, they get lots of guest pagefaults and have to fix such guest
accesses up - which slows things down instead of speeding things up
(the primary purpose of the VDSO).

there's a new CONFIG_COMPAT_VDSO (default=y) option, which provides support
for older glibcs that still rely on a prelinked high-mapped VDSO.
Newer distributions (using glibc 2.3.3 or later) can turn this option
off. Turning it off is also recommended for security reasons: attackers
cannot use the predictable high-mapped VDSO page as syscall trampoline
anymore.

there is a new vdso=[0|1] boot option as well, and a runtime
/proc/sys/vm/vdso_enabled sysctl switch, that allows the VDSO
to be turned on/off.

(this version of the VDSO-randomization patch also has working ELF
coredumping, the previous patch crashed in the coredumping code.)

This code is a combined work of the exec-shield VDSO randomization
code and Gerd Hoffmann's hypervisor-centric VDSO patch. Rusty Russell
started this patch and i completed it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
---
 Documentation/kernel-parameters.txt  |    4 +
 arch/i386/Kconfig                    |   11 ++
 arch/i386/kernel/asm-offsets.c       |    4 -
 arch/i386/kernel/entry.S             |    8 +-
 arch/i386/kernel/signal.c            |    4 -
 arch/i386/kernel/sysenter.c          |  131 +++++++++++++++++++++++++++++++++--
 arch/i386/kernel/vsyscall-sysenter.S |    4 -
 arch/i386/kernel/vsyscall.lds.S      |    4 -
 fs/proc/task_mmu.c                   |   30 ++++----
 include/asm-i386/elf.h               |   53 ++++++++++----
 include/asm-i386/fixmap.h            |   10 --
 include/asm-i386/mmu.h               |    1 
 include/asm-i386/page.h              |    6 +
 include/asm-i386/thread_info.h       |    1 
 include/linux/sched.h                |    1 
 include/linux/sysctl.h               |    1 
 kernel/sysctl.c                      |   13 +++
 17 files changed, 237 insertions(+), 49 deletions(-)

Index: linux-vdso-rand.q/Documentation/kernel-parameters.txt
===================================================================
--- linux-vdso-rand.q.orig/Documentation/kernel-parameters.txt
+++ linux-vdso-rand.q/Documentation/kernel-parameters.txt
@@ -1652,6 +1652,10 @@ running once the system is up.
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
 
+	vdso=		[IA-32]
+			vdso=1: enable VDSO (default)
+			vdso=0: disable VDSO mapping
+
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
 
Index: linux-vdso-rand.q/arch/i386/Kconfig
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/Kconfig
+++ linux-vdso-rand.q/arch/i386/Kconfig
@@ -762,6 +762,17 @@ config HOTPLUG_CPU
 	  enable suspend on SMP systems. CPUs can be controlled through
 	  /sys/devices/system/cpu.
 
+config COMPAT_VDSO
+	bool "Compat VDSO support"
+	default y
+	help
+	  Map the VDSO to the predictable old-style address too.
+	---help---
+	  Say N here if you are running a sufficiently recent glibc
+	  version (2.3.3 or later), to remove the high-mapped
+	  VDSO mapping and to exclusively use the randomized VDSO.
+
+	  If unsure, say Y.
 
 endmenu
 
Index: linux-vdso-rand.q/arch/i386/kernel/asm-offsets.c
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/asm-offsets.c
+++ linux-vdso-rand.q/arch/i386/kernel/asm-offsets.c
@@ -13,6 +13,7 @@
 #include <asm/fixmap.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
+#include <asm/elf.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -53,6 +54,7 @@ void foo(void)
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
+	OFFSET(TI_sysenter_return, thread_info, sysenter_return);
 	BLANK();
 
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
@@ -68,5 +70,5 @@ void foo(void)
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
-	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
+	DEFINE(VDSO_PRELINK, VDSO_PRELINK);
 }
Index: linux-vdso-rand.q/arch/i386/kernel/entry.S
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/entry.S
+++ linux-vdso-rand.q/arch/i386/kernel/entry.S
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
Index: linux-vdso-rand.q/arch/i386/kernel/signal.c
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/signal.c
+++ linux-vdso-rand.q/arch/i386/kernel/signal.c
@@ -351,7 +351,7 @@ static int setup_frame(int sig, struct k
 			goto give_sigsegv;
 	}
 
-	restorer = &__kernel_sigreturn;
+	restorer = (void *)VDSO_SYM(&__kernel_sigreturn);
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -447,7 +447,7 @@ static int setup_rt_frame(int sig, struc
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	restorer = &__kernel_rt_sigreturn;
+	restorer = (void *)VDSO_SYM(&__kernel_rt_sigreturn);
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
Index: linux-vdso-rand.q/arch/i386/kernel/sysenter.c
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/sysenter.c
+++ linux-vdso-rand.q/arch/i386/kernel/sysenter.c
@@ -2,6 +2,8 @@
  * linux/arch/i386/kernel/sysenter.c
  *
  * (C) Copyright 2002 Linus Torvalds
+ * Portions based on the vdso-randomization code from exec-shield:
+ * Copyright(C) 2005-2006, Red Hat, Inc., Ingo Molnar
  *
  * This file contains the needed initializations to support sysenter.
  */
@@ -13,12 +15,31 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/elf.h>
+#include <linux/mm.h>
+#include <linux/module.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
 
+/*
+ * Should the kernel map a VDSO page into processes and pass its
+ * address down to glibc upon exec()?
+ */
+unsigned int __read_mostly vdso_enabled = 1;
+
+EXPORT_SYMBOL_GPL(vdso_enabled);
+
+static int __init vdso_setup(char *s)
+{
+	vdso_enabled = simple_strtoul(s, NULL, 0);
+
+	return 1;
+}
+
+__setup("vdso=", vdso_setup);
+
 extern asmlinkage void sysenter_entry(void);
 
 void enable_sep_cpu(void)
@@ -45,23 +66,125 @@ void enable_sep_cpu(void)
  */
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
+static void *syscall_page;
 
 int __init sysenter_setup(void)
 {
-	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
+	syscall_page = (void *)get_zeroed_page(GFP_ATOMIC);
 
-	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
+#ifdef CONFIG_COMPAT_VDSO
+	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_READONLY);
+	printk("Compat vDSO mapped to %08lx.\n", __fix_to_virt(FIX_VDSO));
+#else
+	/*
+	 * In the non-compat case the ELF coredumping code needs the fixmap:
+	 */
+	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_KERNEL_RO);
+#endif
 
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
+static struct page *syscall_nopage(struct vm_area_struct *vma,
+				unsigned long adr, int *type)
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
+extern void SYSENTER_RETURN;
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
+	vma = kmem_cache_zalloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma) {
+		ret = -ENOMEM;
+		goto up_fail;
+	}
+
+	vma->vm_start = addr;
+	vma->vm_end = addr + PAGE_SIZE;
+	/* MAYWRITE to allow gdb to COW and set breakpoints */
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
+	vma->vm_flags |= mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
+	vma->vm_ops = &syscall_vm_ops;
+	vma->vm_mm = mm;
+
+	ret = insert_vm_struct(mm, vma);
+	if (ret)
+		goto free_vma;
+
+	current->mm->context.vdso = (void *)addr;
+	current_thread_info()->sysenter_return =
+				    (void *)VDSO_SYM(&SYSENTER_RETURN);
+	mm->total_vm++;
+	up_write(&mm->mmap_sem);
+
+	return 0;
+
+free_vma:
+	kmem_cache_free(vm_area_cachep, vma);
+up_fail:
+	up_write(&mm->mmap_sem);
+
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
Index: linux-vdso-rand.q/arch/i386/kernel/vsyscall-sysenter.S
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/vsyscall-sysenter.S
+++ linux-vdso-rand.q/arch/i386/kernel/vsyscall-sysenter.S
@@ -42,10 +42,10 @@ __kernel_vsyscall:
 	/* 7: align return point with nop's to make disassembly easier */
 	.space 7,0x90
 
-	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
+	/* 14: System call restart point is here! (SYSENTER_RETURN-2) */
 	jmp .Lenter_kernel
 	/* 16: System call normal return point is here! */
-	.globl SYSENTER_RETURN	/* Symbol used by entry.S.  */
+	.globl SYSENTER_RETURN	/* Symbol used by sysenter.c  */
 SYSENTER_RETURN:
 	pop %ebp
 .Lpop_ebp:
Index: linux-vdso-rand.q/arch/i386/kernel/vsyscall.lds.S
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/vsyscall.lds.S
+++ linux-vdso-rand.q/arch/i386/kernel/vsyscall.lds.S
@@ -7,7 +7,7 @@
 
 SECTIONS
 {
-  . = VSYSCALL_BASE + SIZEOF_HEADERS;
+  . = VDSO_PRELINK + SIZEOF_HEADERS;
 
   .hash           : { *(.hash) }		:text
   .dynsym         : { *(.dynsym) }
@@ -20,7 +20,7 @@ SECTIONS
      For the layouts to match, we need to skip more than enough
      space for the dynamic symbol table et al.  If this amount
      is insufficient, ld -shared will barf.  Just increase it here.  */
-  . = VSYSCALL_BASE + 0x400;
+  . = VDSO_PRELINK + 0x400;
 
   .text           : { *(.text) }		:text =0x90909090
   .note		  : { *(.note.*) }		:text :note
Index: linux-vdso-rand.q/fs/proc/task_mmu.c
===================================================================
--- linux-vdso-rand.q.orig/fs/proc/task_mmu.c
+++ linux-vdso-rand.q/fs/proc/task_mmu.c
@@ -118,6 +118,11 @@ struct mem_size_stats
 	unsigned long private_dirty;
 };
 
+__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 static int show_map_internal(struct seq_file *m, void *v, struct mem_size_stats *mss)
 {
 	struct task_struct *task = m->private;
@@ -153,22 +158,23 @@ static int show_map_internal(struct seq_
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
Index: linux-vdso-rand.q/include/asm-i386/elf.h
===================================================================
--- linux-vdso-rand.q.orig/include/asm-i386/elf.h
+++ linux-vdso-rand.q/include/asm-i386/elf.h
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/system.h>		/* for savesegment */
 #include <asm/auxvec.h>
+#include <asm/desc.h>
 
 #include <linux/utsname.h>
 
@@ -129,15 +130,41 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
 
-#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
-#define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
-#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
+#define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
+#define VDSO_BASE		((unsigned long)current->mm->context.vdso)
+
+#ifdef CONFIG_COMPAT_VDSO
+# define VDSO_COMPAT_BASE	VDSO_HIGH_BASE
+# define VDSO_PRELINK		VDSO_HIGH_BASE
+#else
+# define VDSO_COMPAT_BASE	VDSO_BASE
+# define VDSO_PRELINK		0
+#endif
+
+#define VDSO_COMPAT_SYM(x) \
+		(VDSO_COMPAT_BASE + (unsigned long)(x) - VDSO_PRELINK)
+
+#define VDSO_SYM(x) \
+		(VDSO_BASE + (unsigned long)(x) - VDSO_PRELINK)
+
+#define VDSO_HIGH_EHDR		((const struct elfhdr *) VDSO_HIGH_BASE)
+#define VDSO_EHDR		((const struct elfhdr *) VDSO_COMPAT_BASE)
+
 extern void __kernel_vsyscall;
 
+#define VDSO_ENTRY		VDSO_SYM(&__kernel_vsyscall)
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+                                       int executable_stack);
+
+extern unsigned int vdso_enabled;
+
 #define ARCH_DLINFO						\
-do {								\
-		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+do if (vdso_enabled) {						\
+		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);		\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_COMPAT_BASE);	\
 } while (0)
 
 /*
@@ -148,15 +175,15 @@ do {								\
  * Dumping its extra ELF program headers includes all the other information
  * a debugger needs to easily find how the vsyscall DSO was being used.
  */
-#define ELF_CORE_EXTRA_PHDRS		(VSYSCALL_EHDR->e_phnum)
+#define ELF_CORE_EXTRA_PHDRS		(VDSO_HIGH_EHDR->e_phnum)
 #define ELF_CORE_WRITE_EXTRA_PHDRS					      \
 do {									      \
 	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+		(const struct elf_phdr *) (VDSO_HIGH_BASE		      \
+					   + VDSO_HIGH_EHDR->e_phoff);    \
 	int i;								      \
 	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+	for (i = 0; i < VDSO_HIGH_EHDR->e_phnum; ++i) {		      \
 		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
 		if (phdr.p_type == PT_LOAD) {				      \
 			BUG_ON(ofs != 0);				      \
@@ -174,10 +201,10 @@ do {									      \
 #define ELF_CORE_WRITE_EXTRA_DATA					      \
 do {									      \
 	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+		(const struct elf_phdr *) (VDSO_HIGH_BASE		      \
+					   + VDSO_HIGH_EHDR->e_phoff);    \
 	int i;								      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
+	for (i = 0; i < VDSO_HIGH_EHDR->e_phnum; ++i) {		      \
 		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
 			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
 				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
Index: linux-vdso-rand.q/include/asm-i386/fixmap.h
===================================================================
--- linux-vdso-rand.q.orig/include/asm-i386/fixmap.h
+++ linux-vdso-rand.q/include/asm-i386/fixmap.h
@@ -52,7 +52,7 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
-	FIX_VSYSCALL,
+	FIX_VDSO,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
@@ -116,14 +116,6 @@ extern void __set_fixmap (enum fixed_add
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
Index: linux-vdso-rand.q/include/asm-i386/mmu.h
===================================================================
--- linux-vdso-rand.q.orig/include/asm-i386/mmu.h
+++ linux-vdso-rand.q/include/asm-i386/mmu.h
@@ -12,6 +12,7 @@ typedef struct { 
 	int size;
 	struct semaphore sem;
 	void *ldt;
+	void *vdso;
 } mm_context_t;
 
 #endif
Index: linux-vdso-rand.q/include/asm-i386/page.h
===================================================================
--- linux-vdso-rand.q.orig/include/asm-i386/page.h
+++ linux-vdso-rand.q/include/asm-i386/page.h
@@ -97,6 +97,8 @@ typedef struct { unsigned long pgprot; }
 
 #ifndef __ASSEMBLY__
 
+struct vm_area_struct;
+
 /*
  * This much address space is reserved for vmalloc() and iomap()
  * as well as fixmap mappings.
@@ -107,6 +109,7 @@ extern int sysctl_legacy_va_layout;
 
 extern int page_is_ram(unsigned long pagenr);
 
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
Index: linux-vdso-rand.q/include/asm-i386/thread_info.h
===================================================================
--- linux-vdso-rand.q.orig/include/asm-i386/thread_info.h
+++ linux-vdso-rand.q/include/asm-i386/thread_info.h
@@ -38,6 +38,7 @@ struct thread_info {
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	void			*sysenter_return;
 	struct restart_block    restart_block;
 
 	unsigned long           previous_esp;   /* ESP of the previous stack in case
Index: linux-vdso-rand.q/include/linux/sched.h
===================================================================
--- linux-vdso-rand.q.orig/include/linux/sched.h
+++ linux-vdso-rand.q/include/linux/sched.h
@@ -40,6 +40,7 @@
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
 struct exec_domain;
+extern int print_fatal_signals;
 
 /*
  * cloning flags:
Index: linux-vdso-rand.q/include/linux/sysctl.h
===================================================================
--- linux-vdso-rand.q.orig/include/linux/sysctl.h
+++ linux-vdso-rand.q/include/linux/sysctl.h
@@ -187,6 +187,7 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
+	VM_VDSO_ENABLED=33,	/* map VDSO into new processes? */
 };
 
 
Index: linux-vdso-rand.q/kernel/sysctl.c
===================================================================
--- linux-vdso-rand.q.orig/kernel/sysctl.c
+++ linux-vdso-rand.q/kernel/sysctl.c
@@ -72,7 +72,6 @@ extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
-extern int print_fatal_signals;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -924,6 +923,18 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_X86_32
+	{
+		.ctl_name	= VM_VDSO_ENABLED,
+		.procname	= "vdso_enabled",
+		.data		= &vdso_enabled,
+		.maxlen		= sizeof(vdso_enabled),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
