Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWCOIZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWCOIZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 03:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWCOIZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 03:25:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:16315 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750788AbWCOIZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 03:25:44 -0500
Message-ID: <4417CFDA.1060806@suse.de>
Date: Wed, 15 Mar 2006 09:27:06 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com> <20060314215616.GM12807@sorel.sous-sol.org> <4417454F.2080908@vmware.com> <20060315043108.GP12807@sorel.sous-sol.org>
In-Reply-To: <20060315043108.GP12807@sorel.sous-sol.org>
Content-Type: multipart/mixed;
 boundary="------------020601070909000009060608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601070909000009060608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>> The complications in my patch come 
>> from the fact that the vsyscall page has to be relocated dynamically, 
>> requiring, basically run time linking on the page and some tweaks to get 
>> sysenter to work.  If you don't use vsyscall (say, non-TLS glibc), then 
>> you don't need that complexity.  But I think it might be needed now, 
>> even for Xen.
> 
> I believe both Xen and execshield move vsyscall out of fixmap, and then
> map into userspace as normal vma.

Yep, my patch (attached below for reference) moves the vsyscall page
into user address space, just below PAGE_OFFSET.  Works basically the
same way the vsyscall page is mapped in the ia32 emulation of the x86_64
 architecture.  Address stays fixed, thus the relocation magic isn't needed.

Once the vsyscall page is moved out of fixmap it's easy to make fixmap
movable and thus have a runtime-resizable address space hole at the top
of address space.  Patch is attached too, although that one is more
proof-of-concept, it doesn't make much sense as-is.  It has a kernel
command line option to specify the top of address space so you can play
around with it ...

Both patches are against -rc3 and most likely still apply just fine,
havn't tested that though.

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg

--------------020601070909000009060608
Content-Type: text/x-patch;
 name="move-gate-page.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="move-gate-page.diff"

Index: vanilla-2.6.16-rc3/arch/i386/kernel/asm-offsets.c
===================================================================
--- vanilla-2.6.16-rc3.orig/arch/i386/kernel/asm-offsets.c	2006-01-03 04:21:10.000000000 +0100
+++ vanilla-2.6.16-rc3/arch/i386/kernel/asm-offsets.c	2006-02-15 10:59:41.000000000 +0100
@@ -68,5 +68,5 @@ void foo(void)
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
-	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
+	DEFINE(VSYSCALL_BASE, (PAGE_OFFSET - 2*PAGE_SIZE));
 }
Index: vanilla-2.6.16-rc3/arch/i386/kernel/sysenter.c
===================================================================
--- vanilla-2.6.16-rc3.orig/arch/i386/kernel/sysenter.c	2006-01-03 04:21:10.000000000 +0100
+++ vanilla-2.6.16-rc3/arch/i386/kernel/sysenter.c	2006-02-13 09:57:36.000000000 +0100
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
Index: vanilla-2.6.16-rc3/include/asm-i386/a.out.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/a.out.h	2006-01-03 04:21:10.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/a.out.h	2006-02-13 09:57:36.000000000 +0100
@@ -19,7 +19,7 @@ struct exec
 
 #ifdef __KERNEL__
 
-#define STACK_TOP	TASK_SIZE
+#define STACK_TOP	(TASK_SIZE - 3*PAGE_SIZE)
 
 #endif
 
Index: vanilla-2.6.16-rc3/include/asm-i386/elf.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/elf.h	2006-01-03 04:21:10.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/elf.h	2006-02-13 09:57:36.000000000 +0100
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
Index: vanilla-2.6.16-rc3/include/asm-i386/fixmap.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/fixmap.h	2006-01-03 04:21:10.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/fixmap.h	2006-02-14 14:40:15.000000000 +0100
@@ -52,7 +52,6 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
-	FIX_VSYSCALL,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
@@ -116,14 +115,6 @@ extern void __set_fixmap (enum fixed_add
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
Index: vanilla-2.6.16-rc3/include/asm-i386/page.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/page.h	2006-02-13 09:42:02.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/page.h	2006-02-14 14:40:15.000000000 +0100
@@ -139,6 +139,8 @@ extern int page_is_ram(unsigned long pag
 	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
 		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define __HAVE_ARCH_GATE_AREA 1
+
 #endif /* __KERNEL__ */
 
 #include <asm-generic/page.h>
Index: vanilla-2.6.16-rc3/include/asm-i386/processor.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/processor.h	2006-02-13 09:42:02.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/processor.h	2006-02-14 14:43:25.000000000 +0100
@@ -318,7 +318,7 @@ extern int bootloader_type;
 /*
  * User space process size: 3GB (default).
  */
-#define TASK_SIZE	(PAGE_OFFSET)
+#define TASK_SIZE	(PAGE_OFFSET - 3*PAGE_SIZE)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.

--------------020601070909000009060608
Content-Type: text/plain;
 name="unfix-fixmap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unfix-fixmap"

Index: vanilla-2.6.16-rc3/arch/i386/kernel/setup.c
===================================================================
--- vanilla-2.6.16-rc3.orig/arch/i386/kernel/setup.c	2006-02-13 09:39:33.000000000 +0100
+++ vanilla-2.6.16-rc3/arch/i386/kernel/setup.c	2006-02-13 09:57:36.000000000 +0100
@@ -922,6 +922,12 @@ static void __init parse_cmdline_early (
 		else if (!memcmp(from, "vmalloc=", 8))
 			__VMALLOC_RESERVE = memparse(from+8, &from);
 
+		/*
+		 * fixmap=addr
+		 */
+		else if (!memcmp(from, "fixmap=", 7))
+			set_fixaddr_top(simple_strtoul(from+7, NULL, 16));
+
 	next_char:
 		c = *(from++);
 		if (!c)
Index: vanilla-2.6.16-rc3/arch/i386/mm/init.c
===================================================================
--- vanilla-2.6.16-rc3.orig/arch/i386/mm/init.c	2006-02-13 09:39:33.000000000 +0100
+++ vanilla-2.6.16-rc3/arch/i386/mm/init.c	2006-02-13 14:33:40.000000000 +0100
@@ -628,6 +628,42 @@ void __init mem_init(void)
 		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10))
 	       );
 
+#if 1 /* double-sanity-check paranoia */
+	printk("virtual kernel memory layout:\n"
+	       "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+	       "    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+	       "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+	       "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+	       "      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+	       "      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+	       "      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
+	       FIXADDR_START, FIXADDR_TOP,
+	       (FIXADDR_TOP - FIXADDR_START) >> 10,
+
+	       PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
+	       (LAST_PKMAP*PAGE_SIZE) >> 10,
+
+	       VMALLOC_START, VMALLOC_END,
+	       (VMALLOC_END - VMALLOC_START) >> 20,
+
+	       (unsigned long)__va(0), (unsigned long)high_memory,
+	       ((unsigned long)high_memory - (unsigned long)__va(0)) >> 20,
+
+	       (unsigned long)&__init_begin, (unsigned long)&__init_end,
+	       ((unsigned long)&__init_end - (unsigned long)&__init_begin) >> 10,
+
+	       (unsigned long)&_etext, (unsigned long)&_edata,
+	       ((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
+
+	       (unsigned long)&_text, (unsigned long)&_etext,
+	       ((unsigned long)&_etext - (unsigned long)&_text) >> 10);
+
+	BUG_ON(PKMAP_BASE+LAST_PKMAP*PAGE_SIZE > FIXADDR_START);
+	BUG_ON(VMALLOC_END                     > PKMAP_BASE);
+	BUG_ON(VMALLOC_START                   > VMALLOC_END);
+	BUG_ON((unsigned long)high_memory      > VMALLOC_START);
+#endif /* double-sanity-check paranoia */
+
 #ifdef CONFIG_X86_PAE
 	if (!cpu_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
Index: vanilla-2.6.16-rc3/arch/i386/mm/pgtable.c
===================================================================
--- vanilla-2.6.16-rc3.orig/arch/i386/mm/pgtable.c	2006-01-03 04:21:10.000000000 +0100
+++ vanilla-2.6.16-rc3/arch/i386/mm/pgtable.c	2006-02-13 09:57:36.000000000 +0100
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
 
+static int fixmaps = 0;
+unsigned long __FIXADDR_TOP = 0xfffff000;
+EXPORT_SYMBOL(__FIXADDR_TOP);
+
 void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
 {
 	unsigned long address = __fix_to_virt(idx);
@@ -147,6 +152,14 @@ void __set_fixmap (enum fixed_addresses 
 		return;
 	}
 	set_pte_pfn(address, phys >> PAGE_SHIFT, flags);
+	fixmaps++;
+}
+
+void set_fixaddr_top(unsigned long top)
+{
+	BUG_ON(fixmaps > 0);
+	printk("%s: addr=0x%lx\n", __FUNCTION__, top);
+	__FIXADDR_TOP = top - PAGE_SIZE;
 }
 
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
Index: vanilla-2.6.16-rc3/include/asm-i386/fixmap.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/fixmap.h	2006-02-13 09:57:36.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/fixmap.h	2006-02-13 09:57:36.000000000 +0100
@@ -20,7 +20,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+extern unsigned long __FIXADDR_TOP;
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
@@ -93,6 +93,7 @@ enum fixed_addresses {
 
 extern void __set_fixmap (enum fixed_addresses idx,
 					unsigned long phys, pgprot_t flags);
+extern void set_fixaddr_top(unsigned long top);
 
 #define set_fixmap(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL)
Index: vanilla-2.6.16-rc3/include/asm-i386/page.h
===================================================================
--- vanilla-2.6.16-rc3.orig/include/asm-i386/page.h	2006-02-13 09:57:36.000000000 +0100
+++ vanilla-2.6.16-rc3/include/asm-i386/page.h	2006-02-13 14:21:36.000000000 +0100
@@ -121,7 +121,7 @@ extern int page_is_ram(unsigned long pag
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)

--------------020601070909000009060608--
