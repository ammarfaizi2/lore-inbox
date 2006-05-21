Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWEUJfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWEUJfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEUJfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:35:25 -0400
Received: from ozlabs.org ([203.10.76.45]:20927 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932306AbWEUJfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:35:24 -0400
Subject: Re: [patch] i386, vdso=[0|1] boot option and
	/proc/sys/vm/vdso_enabled
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>
Cc: virtualization@lists.osdl.org, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1148186298.29161.8.camel@localhost.localdomain>
References: <1147759423.5492.102.camel@localhost.localdomain>
	 <20060516064723.GA14121@elte.hu>
	 <1147852189.1749.28.camel@localhost.localdomain>
	 <20060519174303.5fd17d12.akpm@osdl.org>	<20060520010303.GA17858@elte.hu>
	 <20060519181125.5c8e109e.akpm@osdl.org>
	 <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	 <20060520085351.GA28716@elte.hu>	<20060520022650.46b048f8.akpm@osdl.org>
	 <446EE1C2.7060400@vmware.com> <20060520024842.69c77aaf.akpm@osdl.org>
	 <446EE992.4020604@vmware.com>
	 <1148186298.29161.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 21 May 2006 19:35:17 +1000
Message-Id: <1148204118.31087.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 14:38 +1000, Rusty Russell wrote:
> Indeed.  And I really hate the idea of a global switch for this, too: it
> should just work, or autodetect (esp if it's init that failing, this
> might be possible).
> 
> Off to find FC1...

Well, after three hours of downloading, it doesn't boot under qemu
anyway 8(

But it turns out that this is a known problem with FC1's glibc and the
exec-shield patches (google for FC1 glibc vdso).  When Ingo and Arjan
convinced me to push their code from exec-shield, they conveniently
didn't mention this.

So, below is Gerd's original "just place the damn thing above the stack"
patch.  Does this work?  If so, I'm happy for someone else to figure out
a decent way of auto-detecting FC1-style problems.

Thanks,
Rusty.
PS.  Patch was not signed off by Gerd.  Went through Xen tree.

Name: Move vsyscall page out of fixmap, above stack
Author: Gerd Hoffmann <kraxel@suse.de>

Hypervisors want to use memory at the top of the address space
(eg. 64MB for Xen, or 168MB for Xen w/ PAE).  Creating this hole means
moving the vsyscall page away from 0xffffe000.

If we create this hole statically with a config option, we give up,
say, 256MB of lowmem for the case where a hypervisor-capable kernel is
actually running on native hardware.

If we create this hole dynamically and leave the vsyscall page at the
top of kernel memory, we would have to patch up the vsyscall elf
header at boot time to reflect where we put it.

Instead, this patch moves the vsyscall page into the user address
region, just below PAGE_OFFSET: it's still at a fixed address, but
it's not where the hypervisor wants to be, so resizing the hole is
trivial.

Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/arch/i386/kernel/asm-offsets.c working-2.6.17-rc4-vsyscall-above-stack/arch/i386/kernel/asm-offsets.c
--- linux-2.6.17-rc4/arch/i386/kernel/asm-offsets.c	2005-07-15 04:38:36.000000000 +1000
+++ working-2.6.17-rc4-vsyscall-above-stack/arch/i386/kernel/asm-offsets.c	2006-05-16 14:24:00.000000000 +1000
@@ -13,6 +13,7 @@
 #include <asm/fixmap.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
+#include <asm/elf.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -68,5 +69,5 @@ void foo(void)
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
-	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
+	DEFINE(VSYSCALL_BASE, VSYSCALL_BASE);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/arch/i386/kernel/sysenter.c working-2.6.17-rc4-vsyscall-above-stack/arch/i386/kernel/sysenter.c
--- linux-2.6.17-rc4/arch/i386/kernel/sysenter.c	2006-03-23 12:42:01.000000000 +1100
+++ working-2.6.17-rc4-vsyscall-above-stack/arch/i386/kernel/sysenter.c	2006-05-16 14:27:05.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/elf.h>
+#include <linux/mm.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -45,23 +46,88 @@ void enable_sep_cpu(void)
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
+/* Setup a VMA at program startup for the vsyscall page */
+int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma)
+		return -ENOMEM;
+
+	memset(vma, 0, sizeof(struct vm_area_struct));
+	/* Could randomize here */
+	vma->vm_start = VSYSCALL_BASE;
+	vma->vm_end = VSYSCALL_BASE + PAGE_SIZE;
+	/* MAYWRITE to allow gdb to COW and set breakpoints */
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
+	vma->vm_flags |= mm->def_flags;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
+	vma->vm_ops = &syscall_vm_ops;
+	vma->vm_mm = mm;
+
+	down_write(&mm->mmap_sem);
+	if ((ret = insert_vm_struct(mm, vma))) {
+		up_write(&mm->mmap_sem);
+		kmem_cache_free(vm_area_cachep, vma);
+		return ret;
+	}
+	mm->total_vm++;
+	up_write(&mm->mmap_sem);
+	return 0;
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/arch/i386/mm/pgtable.c working-2.6.17-rc4-vsyscall-above-stack/arch/i386/mm/pgtable.c
--- linux-2.6.17-rc4/arch/i386/mm/pgtable.c	2006-05-16 10:50:48.000000000 +1000
+++ working-2.6.17-rc4-vsyscall-above-stack/arch/i386/mm/pgtable.c	2006-05-16 14:24:47.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/include/asm-i386/a.out.h working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/a.out.h
--- linux-2.6.17-rc4/include/asm-i386/a.out.h	2004-02-04 14:43:43.000000000 +1100
+++ working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/a.out.h	2006-05-16 14:24:47.000000000 +1000
@@ -19,7 +19,7 @@ struct exec
 
 #ifdef __KERNEL__
 
-#define STACK_TOP	TASK_SIZE
+#define STACK_TOP	(TASK_SIZE - 3*PAGE_SIZE)
 
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/include/asm-i386/elf.h working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/elf.h
--- linux-2.6.17-rc4/include/asm-i386/elf.h	2006-03-23 12:44:01.000000000 +1100
+++ working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/elf.h	2006-05-16 14:24:47.000000000 +1000
@@ -129,11 +129,16 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
 
-#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
+#define VSYSCALL_BASE	(PAGE_OFFSET - 2*PAGE_SIZE)
 #define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
 #define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
 extern void __kernel_vsyscall;
 
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+                                       int executable_stack);
+
 #define ARCH_DLINFO						\
 do {								\
 		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/include/asm-i386/fixmap.h working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/fixmap.h
--- linux-2.6.17-rc4/include/asm-i386/fixmap.h	2006-03-23 12:43:10.000000000 +1100
+++ working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/fixmap.h	2006-05-16 14:24:47.000000000 +1000
@@ -20,7 +20,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+extern unsigned long __FIXADDR_TOP;
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
@@ -52,7 +52,6 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
-	FIX_VSYSCALL,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
@@ -95,6 +94,8 @@ enum fixed_addresses {
 extern void __set_fixmap (enum fixed_addresses idx,
 					unsigned long phys, pgprot_t flags);
 
+extern void set_fixaddr_top(unsigned long top);
+
 #define set_fixmap(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL)
 /*
@@ -116,14 +117,6 @@ extern void __set_fixmap (enum fixed_add
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.17-rc4/include/asm-i386/page.h working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/page.h
--- linux-2.6.17-rc4/include/asm-i386/page.h	2006-05-16 10:51:38.000000000 +1000
+++ working-2.6.17-rc4-vsyscall-above-stack/include/asm-i386/page.h	2006-05-16 14:24:47.000000000 +1000
@@ -121,7 +121,7 @@ extern int page_is_ram(unsigned long pag
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
@@ -137,6 +137,8 @@ extern int page_is_ram(unsigned long pag
 	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
 		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define __HAVE_ARCH_GATE_AREA 1
+
 #endif /* __KERNEL__ */
 
 #include <asm-generic/memory_model.h>

-- 
 ccontrol: http://ccontrol.ozlabs.org

