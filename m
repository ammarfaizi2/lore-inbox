Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUFRWH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUFRWH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFRVzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:55:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37026 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264513AbUFRVhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:37:06 -0400
Date: Fri, 18 Jun 2004 23:38:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040618213814.GA589@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the flexible-mmap-2.6.7-D5 patch (attached) splits the flexible-mmap
layout stuff out of exec-shield. The patch is against 2.6.7 + my latest
NX patch. (i've attached the NX patch too, for convenience.)

the goal of the patch is to change the way virtual memory is allocated,
from:

  0x08000000 ... binary image
  0x08xxxxxx ... brk area, grows upwards
  0x40000000 ... start of mmap, new mmaps go after old ones
  0xbfxxxxxx ... stack

to a more flexible top-down mmap() method:

  0x08000000 ... binary image
  0x08xxxxxx ... brk area, grows upwards
  0xbfxxxxxx ... _end_ of all mmaps, new mmaps go below old ones
  0xbfyyyyyy ... stack

the new layout has a couple of advantages:

- primarily this layout enables both malloc(), mmap()/shmat() users to
  utilize the full address space: 3GB on stock x86, 4GB on x86 4:4 or
  x86-64 running x86 apps.

- the new layout is also in essence 'self-tuning' the mmap() and
  malloc() limits: no hacks like /proc/PID/mmap_base are needed - both
  malloc() and mmap() can grow until all the address space is full.
  With the old layout, malloc() space was limited to 900MB, mmap() space
  to ~2GB.

- The new layout also allows very large continuous mmap()s because the
  'free space' is always a continuous hole (statistically).

- there's also a ~4K pagetable saved per typical process, because we
  dont allocate at 1GB anymore and dont fragment the VM that much -
  there are only 2 main chunks, the binary image + brk(), and the mmap()
  area + stack.

here are the kernel code changes the patch introduces:

- the patch is compatible with existing architectures that either make
  use of HAVE_ARCH_UNMAPPED_AREA or use the default mmap() allocator -
  there is no change in behavior.

- the patch gives a new mechanism to define alternate per-mm mmap()
  layouts via mm->get_unmapped_area(). On x86 i used this mechanism to
  implement a top-down allocator for PT_GNU_STACK applications.

- 64-bit architectures can use the same mechanism to clean up 32-bit
  compatibility layouts: by defining HAVE_ARCH_PICK_MMAP_LAYOUT and
  providing a arch_pick_mmap_layout() function - which can then decide
  between various mmap() layout functions.

- i also introduced a new personality bit (ADDR_COMPAT_LAYOUT) to signal
  older binaries that dont have PT_GNU_STACK. x86 uses this to revert 
  back to the stock layout. I also changed x86 to not clear the
  personality bits upon exec(), like x86-64 already does.

- once every architecture that uses HAVE_ARCH_UNMAPPED_AREA has defined
  its arch_pick_mmap_layout() function, we can get rid of
  HAVE_ARCH_UNMAPPED_AREA altogether, as a final cleanup.

i tested the patch on two distributions: one was an older one without
PT_GNU_STACK, the other had applications was with PT_GNU_STACK. On the
old one we properly generate the compatible VM layout - the PT_GNU_STACK
one got the new layout.

the new layout generation function (__get_unmapped_area()) got
significant testing in Fedora Core 1/2 and RHEL3, so it's pretty robust.

Compatibility: there's one known public application that broke in
Fedora, a serial terminal program. The application bug has been fixed.

Comments, suggestions are welcome,

	Ingo

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="flexible-mmap-2.6.7-D5"

--- linux/arch/i386/mm/mmap.c.orig	
+++ linux/arch/i386/mm/mmap.c	
@@ -0,0 +1,63 @@
+/*
+ *  linux/arch/i386/mm/mmap.c
+ *
+ *  flexible mmap layout support
+ *
+ * Copyright 2003-2004 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ * Started by Ingo Molnar <mingo@elte.hu>
+ */
+
+#include <linux/personality.h>
+#include <linux/mm.h>
+
+/*
+ * Top of mmap area (just below the process stack).
+ *
+ * Leave an at least ~128 MB hole. Limit maximum floor to 5/6 of
+ * the total address space, in case the stack is unlimited.
+ */
+#define MIN_GAP (128*1024*1024)
+#define MAX_GAP (TASK_SIZE/6*5)
+
+/*
+ * This function, called very early during the creation of a new
+ * process VM image, sets up which VM layout function to use:
+ */
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	/*
+	 * If non-PT_GNU_STACK binary then fall back to the
+	 * standard layout:
+	 */
+	if (current->personality & ADDR_COMPAT_LAYOUT) {
+		mm->mmap_base = TASK_UNMAPPED_BASE;
+		mm->get_unmapped_area = arch_get_unmapped_area;
+	} else {
+		unsigned long gap = current->rlim[RLIMIT_STACK].rlim_cur;
+
+		if (gap < MIN_GAP)
+			gap = MIN_GAP;
+		else if (gap > MAX_GAP)
+			gap = MAX_GAP;
+		mm->mmap_base = TASK_SIZE - (gap & PAGE_MASK);
+		mm->get_unmapped_area = get_unmapped_area_topdown;
+	}
+}
+
--- linux/arch/i386/mm/Makefile.orig	
+++ linux/arch/i386/mm/Makefile	
@@ -2,7 +2,7 @@
 # Makefile for the linux i386-specific parts of the memory manager.
 #
 
-obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o 
+obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
 
 obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -191,10 +191,32 @@ extern int sysctl_max_map_count;
 
 #include <linux/aio.h>
 
+extern unsigned long
+arch_get_unmapped_area(struct file *, unsigned long, unsigned long,
+		       unsigned long, unsigned long);
+extern unsigned long
+get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags);
+
+#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
+extern void arch_pick_mmap_layout(struct mm_struct *mm);
+#else
+static inline void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	mm->mmap_base = TASK_UNMAPPED_BASE;
+	mm->get_unmapped_area = arch_get_unmapped_area;
+}
+#endif
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	unsigned long (*get_unmapped_area) (struct file *filp,
+				unsigned long addr, unsigned long len,
+				unsigned long pgoff, unsigned long flags);
+	unsigned long mmap_base;		/* base of mmap area */
 	unsigned long free_area_cache;		/* first hole */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
--- linux/include/linux/personality.h.orig	
+++ linux/include/linux/personality.h	
@@ -30,6 +30,7 @@ extern int abi_fake_utsname;
  */
 enum {
 	MMAP_PAGE_ZERO =	0x0100000,
+	ADDR_COMPAT_LAYOUT =	0x0200000,
 	ADDR_LIMIT_32BIT =	0x0800000,
 	SHORT_INODE =		0x1000000,
 	WHOLE_SECONDS =		0x2000000,
--- linux/include/asm-i386/processor.h.orig	
+++ linux/include/asm-i386/processor.h	
@@ -302,6 +302,8 @@ extern unsigned int mca_pentium_flag;
  */
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
 
+#define HAVE_ARCH_PICK_MMAP_LAYOUT
+
 /*
  * Size of io_bitmap, covering ports 0 to 0x3ff.
  */
--- linux/include/asm-i386/elf.h.orig	
+++ linux/include/asm-i386/elf.h	
@@ -117,7 +117,7 @@ typedef struct user_fxsr_struct elf_fpxr
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
--- linux/fs/binfmt_aout.c.orig	
+++ linux/fs/binfmt_aout.c	
@@ -307,7 +307,7 @@ static int load_aout_binary(struct linux
 		(current->mm->start_data = N_DATADDR(ex));
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));
-	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
+	current->mm->free_area_cache = current->mm->mmap_base;
 
 	current->mm->rss = 0;
 	current->mm->mmap = NULL;
--- linux/fs/binfmt_elf.c.orig	
+++ linux/fs/binfmt_elf.c	
@@ -625,8 +625,10 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
-	if (i == elf_ex.e_phnum)
+	if (i == elf_ex.e_phnum) {
 		def_flags |= VM_EXEC | VM_MAYEXEC;
+		current->personality |= ADDR_COMPAT_LAYOUT;
+	}
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
@@ -703,7 +705,7 @@ static int load_elf_binary(struct linux_
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
-	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
+	current->mm->free_area_cache = current->mm->mmap_base;
 	retval = setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -547,6 +547,7 @@ static int exec_mmap(struct mm_struct *m
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
 	task_unlock(tsk);
+	arch_pick_mmap_layout(mm);
 	if (old_mm) {
 		if (active_mm != old_mm) BUG();
 		mmput(old_mm);
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -279,7 +279,7 @@ static inline int dup_mmap(struct mm_str
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
 	mm->mmap_cache = NULL;
-	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
 	mm->rss = 0;
 	cpus_clear(mm->cpu_vm_mask);
--- linux/mm/mmap.c.orig	
+++ linux/mm/mmap.c	
@@ -1002,7 +1002,7 @@ EXPORT_SYMBOL(do_mmap_pgoff);
  * This function "knows" that -ENOMEM has the bits set.
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA
-static inline unsigned long
+unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
@@ -1046,12 +1046,79 @@ full_search:
 		addr = vma->vm_end;
 	}
 }
-#else
-extern unsigned long
-arch_get_unmapped_area(struct file *, unsigned long, unsigned long,
-			unsigned long, unsigned long);
 #endif	
 
+/*
+ * This mmap-allocator allocates new areas top-down from below the
+ * stack's low limit (the base):
+ */
+unsigned long
+get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
+{
+	struct vm_area_struct *vma, *prev_vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long base = mm->mmap_base;
+	int first_time = 1;
+
+	/* requested length too big for entire address space */
+	if (len > TASK_SIZE) 
+		return -ENOMEM;
+
+	/* dont allow allocations above current base */
+	if (mm->free_area_cache > base)
+		mm->free_area_cache = base;
+
+	/* requesting a specific address */
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr && 
+				(!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	/* make sure it can fit in the remaining address space */
+	if (mm->free_area_cache < len)
+		return -ENOMEM;
+
+	/* either no address requested or cant fit in requested address hole */
+try_again:
+	addr = (mm->free_area_cache - len) & PAGE_MASK;
+	do {
+ 	 	if (!(vma = find_vma_prev(mm, addr, &prev_vma)))
+			return -ENOMEM;
+
+		/*
+		 * new region fits between prev_vma->vm_end and
+		 * vma->vm_start, use it:
+		 */
+		if (addr+len <= vma->vm_start &&
+				(!prev_vma || (addr >= prev_vma->vm_end)))
+			/* remember the address as a hint for next time */
+			return (mm->free_area_cache = addr);
+		else
+			/* pull free_area_cache down to the first hole */
+			if (mm->free_area_cache == vma->vm_end)
+				mm->free_area_cache = vma->vm_start;	
+
+		/* try just below the current vma->vm_start */
+		addr = vma->vm_start-len;
+	} while (len <= vma->vm_start);
+
+	/*
+	 * if hint left us with no space for the requested
+	 * mapping then try again:
+	 */
+	if (first_time) {
+		mm->free_area_cache = base;
+		first_time = 0;
+		goto try_again;
+	}
+	return -ENOMEM;
+}
+
 unsigned long
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
@@ -1086,7 +1153,7 @@ get_unmapped_area(struct file *file, uns
 		return file->f_op->get_unmapped_area(file, addr, len,
 						pgoff, flags);
 
-	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
+	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
 }
 
 EXPORT_SYMBOL(get_unmapped_area);

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx-2.6.7-A1"

--- linux/arch/i386/kernel/cpu/proc.c.orig	
+++ linux/arch/i386/kernel/cpu/proc.c	
@@ -27,7 +27,7 @@ static int show_cpuinfo(struct seq_file 
 		/* AMD-defined */
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
-		NULL, NULL, NULL, "mp", NULL, NULL, "mmxext", NULL,
+		NULL, NULL, NULL, "mp", "nx", NULL, "mmxext", NULL,
 		NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
 
 		/* Transmeta-defined */
--- linux/arch/i386/kernel/head.S.orig	
+++ linux/arch/i386/kernel/head.S	
@@ -153,6 +153,32 @@ ENTRY(startup_32_smp)
 	orl %edx,%eax
 	movl %eax,%cr4
 
+	btl $5, %eax		# check if PAE is enabled
+	jnc 6f
+
+	/* Check if extended functions are implemented */
+	movl $0x80000000, %eax
+	cpuid
+	cmpl $0x80000000, %eax
+	jbe 6f
+	mov $0x80000001, %eax
+	cpuid
+	/* Execute Disable bit supported? */
+	btl $20, %edx
+	jnc 6f
+
+	/* Setup EFER (Extended Feature Enable Register) */
+	movl $0xc0000080, %ecx
+	rdmsr
+
+	btsl $11, %eax
+	/* Make changes effective */
+	wrmsr
+
+6:
+	/* cpuid clobbered ebx, set it up again: */
+	xorl %ebx,%ebx
+	incl %ebx
 3:
 #endif /* CONFIG_SMP */
 
--- linux/arch/i386/kernel/sysenter.c.orig	
+++ linux/arch/i386/kernel/sysenter.c	
@@ -45,7 +45,7 @@ static int __init sysenter_setup(void)
 {
 	unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
-	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY);
+	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
 
 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy((void *) page,
--- linux/arch/i386/kernel/module.c.orig	
+++ linux/arch/i386/kernel/module.c	
@@ -32,7 +32,7 @@ void *module_alloc(unsigned long size)
 {
 	if (size == 0)
 		return NULL;
-	return vmalloc(size);
+	return vmalloc_exec(size);
 }
 
 
--- linux/arch/i386/mm/init.c.orig	
+++ linux/arch/i386/mm/init.c	
@@ -123,6 +123,13 @@ static void __init page_table_range_init
 	}
 }
 
+static inline int is_kernel_text(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr <= (unsigned long)__init_end)
+		return 1;
+	return 0;
+}
+
 /*
  * This maps the physical memory to kernel virtual address space, a total 
  * of max_low_pfn pages, by creating page tables starting from address 
@@ -145,18 +152,29 @@ static void __init kernel_physical_mappi
 		if (pfn >= max_low_pfn)
 			continue;
 		for (pmd_idx = 0; pmd_idx < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_idx++) {
+			unsigned int address = pfn * PAGE_SIZE + PAGE_OFFSET;
+
 			/* Map with big pages if possible, otherwise create normal page tables. */
 			if (cpu_has_pse) {
-				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
+				unsigned int address2 = (pfn + PTRS_PER_PTE - 1) * PAGE_SIZE + PAGE_OFFSET + PAGE_SIZE-1;
+
+				if (is_kernel_text(address) || is_kernel_text(address2))
+					set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE_EXEC));
+				else
+					set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE));
 				pfn += PTRS_PER_PTE;
 			} else {
 				pte = one_page_table_init(pmd);
 
-				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++)
-					set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+				for (pte_ofs = 0; pte_ofs < PTRS_PER_PTE && pfn < max_low_pfn; pte++, pfn++, pte_ofs++) {
+						if (is_kernel_text(address))
+							set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+						else
+							set_pte(pte, pfn_pte(pfn, PAGE_KERNEL));
+				}
 			}
 		}
-	}	
+	}
 }
 
 static inline int page_kills_ppro(unsigned long pagenr)
@@ -273,7 +291,8 @@ extern void set_highmem_pages_init(int);
 #define set_highmem_pages_init(bad_ppro) do { } while (0)
 #endif /* CONFIG_HIGHMEM */
 
-unsigned long __PAGE_KERNEL = _PAGE_KERNEL;
+unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
+unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
 #ifndef CONFIG_DISCONTIGMEM
 #define remap_numa_kva() do {} while (0)
@@ -302,6 +321,7 @@ static void __init pagetable_init (void)
 	if (cpu_has_pge) {
 		set_in_cr4(X86_CR4_PGE);
 		__PAGE_KERNEL |= _PAGE_GLOBAL;
+		__PAGE_KERNEL_EXEC |= _PAGE_GLOBAL;
 	}
 
 	kernel_physical_mapping_init(pgd_base);
@@ -392,6 +412,52 @@ void __init zone_sizes_init(void)
 extern void zone_sizes_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
+static int disable_nx __initdata = 0;
+u64 __supported_pte_mask = ~_PAGE_NX;
+
+/*
+ * noexec = on|off
+ *
+ * Control non executable mappings.
+ *
+ * on      Enable
+ * off     Disable
+ */
+static int __init noexec_setup(char *str)
+{
+	if (!strncmp(str, "on",2) && cpu_has_nx) {
+		__supported_pte_mask |= _PAGE_NX;
+		disable_nx = 0;
+	} else if (!strncmp(str,"off",3)) {
+		disable_nx = 1;
+		__supported_pte_mask &= ~_PAGE_NX;
+	}
+	return 1;
+}
+
+__setup("noexec=", noexec_setup);
+
+#ifdef CONFIG_X86_PAE
+static int use_nx = 0;
+
+static void __init set_nx(void)
+{
+	unsigned int v[4], l, h;
+
+	if (cpu_has_pae && (cpuid_eax(0x80000000) > 0x80000001)) {
+		cpuid(0x80000001, &v[0], &v[1], &v[2], &v[3]);
+		if ((v[3] & (1 << 20)) && !disable_nx) {
+			rdmsr(MSR_EFER, l, h);
+			l |= EFER_NX;
+			wrmsr(MSR_EFER, l, h);
+			use_nx = 1;
+			__supported_pte_mask |= _PAGE_NX;
+		}
+	}
+}
+
+#endif
+
 /*
  * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
@@ -401,6 +467,12 @@ extern void zone_sizes_init(void);
  */
 void __init paging_init(void)
 {
+#ifdef CONFIG_X86_PAE
+	set_nx();
+	if (use_nx)
+		printk("NX (Execute Disable) protection: active\n");
+#endif
+
 	pagetable_init();
 
 	load_cr3(swapper_pg_dir);
--- linux/arch/i386/mm/fault.c.orig	
+++ linux/arch/i386/mm/fault.c	
@@ -406,6 +406,21 @@ no_context:
 
 	bust_spinlocks(1);
 
+#ifdef CONFIG_X86_PAE
+	{
+		pgd_t *pgd;
+		pmd_t *pmd;
+
+
+
+		pgd = init_mm.pgd + pgd_index(address);
+		if (pgd_present(*pgd)) {
+			pmd = pmd_offset(pgd, address);
+			if (pmd_val(*pmd) & _PAGE_NX)
+				printk(KERN_CRIT "kernel tried to access NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
+		}
+	}
+#endif
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
--- linux/arch/x86_64/kernel/module.c.orig	
+++ linux/arch/x86_64/kernel/module.c	
@@ -121,7 +121,7 @@ void *module_alloc(unsigned long size)
 			goto fail;
 	}
 	
-	if (map_vm_area(area, PAGE_KERNEL_EXECUTABLE, &pages))
+	if (map_vm_area(area, PAGE_KERNEL_EXEC, &pages))
 		goto fail;
 	
 	memset(addr, 0, size);
--- linux/arch/x86_64/mm/pageattr.c.orig	
+++ linux/arch/x86_64/mm/pageattr.c	
@@ -180,7 +180,7 @@ int change_page_attr(struct page *page, 
 			unsigned long addr2;
 			addr2 = __START_KERNEL_map + page_to_phys(page);
 			err = __change_page_attr(addr2, page, prot, 
-						 PAGE_KERNEL_EXECUTABLE);
+						 PAGE_KERNEL_EXEC);
 		} 
 	} 	
 	up_write(&init_mm.mmap_sem); 
--- linux/include/asm-x86_64/pgtable.h.orig	
+++ linux/include/asm-x86_64/pgtable.h	
@@ -172,7 +172,7 @@ static inline void set_pml4(pml4_t *dst,
 #define PAGE_READONLY_EXEC __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define __PAGE_KERNEL \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_NX)
-#define __PAGE_KERNEL_EXECUTABLE \
+#define __PAGE_KERNEL_EXEC \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define __PAGE_KERNEL_NOCACHE \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_PCD | _PAGE_ACCESSED | _PAGE_NX)
@@ -188,7 +188,7 @@ static inline void set_pml4(pml4_t *dst,
 #define MAKE_GLOBAL(x) __pgprot((x) | _PAGE_GLOBAL)
 
 #define PAGE_KERNEL MAKE_GLOBAL(__PAGE_KERNEL)
-#define PAGE_KERNEL_EXECUTABLE MAKE_GLOBAL(__PAGE_KERNEL_EXECUTABLE)
+#define PAGE_KERNEL_EXEC MAKE_GLOBAL(__PAGE_KERNEL_EXEC)
 #define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_VSYSCALL MAKE_GLOBAL(__PAGE_KERNEL_VSYSCALL)
--- linux/include/linux/vmalloc.h.orig	
+++ linux/include/linux/vmalloc.h	
@@ -23,6 +23,7 @@ struct vm_struct {
  *	Highlevel APIs for driver use
  */
 extern void *vmalloc(unsigned long size);
+extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot);
 extern void vfree(void *addr);
--- linux/include/asm-i386/msr.h.orig	
+++ linux/include/asm-i386/msr.h	
@@ -217,6 +217,15 @@ static inline void wrmsrl (unsigned long
 #define MSR_K7_FID_VID_CTL		0xC0010041
 #define MSR_K7_FID_VID_STATUS		0xC0010042
 
+/* extended feature register */
+#define MSR_EFER 			0xc0000080
+
+/* EFER bits: */
+
+/* Execute Disable enable */
+#define _EFER_NX			11
+#define EFER_NX				(1<<_EFER_NX)
+
 /* Centaur-Hauls/IDT defined MSRs. */
 #define MSR_IDT_FCR1			0x107
 #define MSR_IDT_FCR2			0x108
--- linux/include/asm-i386/cpufeature.h.orig	
+++ linux/include/asm-i386/cpufeature.h	
@@ -47,6 +47,7 @@
 /* Don't duplicate feature flags which are redundant with Intel! */
 #define X86_FEATURE_SYSCALL	(1*32+11) /* SYSCALL/SYSRET */
 #define X86_FEATURE_MP		(1*32+19) /* MP Capable. */
+#define X86_FEATURE_NX		(1*32+20) /* Execute Disable */
 #define X86_FEATURE_MMXEXT	(1*32+22) /* AMD MMX extensions */
 #define X86_FEATURE_LM		(1*32+29) /* Long Mode (x86-64) */
 #define X86_FEATURE_3DNOWEXT	(1*32+30) /* AMD 3DNow! extensions */
@@ -100,6 +101,7 @@
 #define cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
 #define cpu_has_ht		boot_cpu_has(X86_FEATURE_HT)
 #define cpu_has_mp		boot_cpu_has(X86_FEATURE_MP)
+#define cpu_has_nx		boot_cpu_has(X86_FEATURE_NX)
 #define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
 #define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
 #define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -40,15 +40,18 @@
  * These are used to make use of C type-checking..
  */
 #ifdef CONFIG_X86_PAE
+extern unsigned long long __supported_pte_mask;
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
+typedef struct { unsigned long long pgprot; } pgprot_t;
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define HPAGE_SHIFT	21
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
+typedef struct { unsigned long pgprot; } pgprot_t;
 #define boot_pte_t pte_t /* or would you rather have a typedef */
 #define pte_val(x)	((x).pte_low)
 #define HPAGE_SHIFT	22
@@ -61,7 +64,6 @@ typedef struct { unsigned long pgd; } pg
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #endif
 
-typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pmd_val(x)	((x).pmd)
 #define pgd_val(x)	((x).pgd)
@@ -136,7 +138,7 @@ static __inline__ int get_order(unsigned
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif /* __KERNEL__ */
--- linux/include/asm-i386/pgtable-3level.h.orig	
+++ linux/include/asm-i386/pgtable-3level.h	
@@ -101,18 +101,24 @@ static inline unsigned long pte_pfn(pte_
 		(pte.pte_high << (32 - PAGE_SHIFT));
 }
 
+extern unsigned long long __supported_pte_mask;
+
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	pte_t pte;
 
-	pte.pte_high = page_nr >> (32 - PAGE_SHIFT);
-	pte.pte_low = (page_nr << PAGE_SHIFT) | pgprot_val(pgprot);
+	pte.pte_high = (page_nr >> (32 - PAGE_SHIFT)) | \
+					(pgprot_val(pgprot) >> 32);
+	pte.pte_high &= (__supported_pte_mask >> 32);
+	pte.pte_low = ((page_nr << PAGE_SHIFT) | pgprot_val(pgprot)) & \
+							__supported_pte_mask;
 	return pte;
 }
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
-	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+	return __pmd((((unsigned long long)page_nr << PAGE_SHIFT) | \
+			pgprot_val(pgprot)) & __supported_pte_mask);
 }
 
 /*
--- linux/include/asm-i386/pgtable.h.orig	
+++ linux/include/asm-i386/pgtable.h	
@@ -110,6 +110,7 @@ void paging_init(void);
 #define _PAGE_BIT_UNUSED1	9	/* available for programmer */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
+#define _PAGE_BIT_NX		63
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_RW	0x002
@@ -126,28 +127,51 @@ void paging_init(void);
 
 #define _PAGE_FILE	0x040	/* set:pagecache unset:swap */
 #define _PAGE_PROTNONE	0x080	/* If not present */
+#ifdef CONFIG_X86_PAE
+#define _PAGE_NX	(1ULL<<_PAGE_BIT_NX)
+#else
+#define _PAGE_NX	0
+#endif
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _PAGE_CHG_MASK	(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 
-#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
+#define PAGE_NONE \
+	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
+#define PAGE_SHARED \
+	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED)
+
+#define PAGE_SHARED_EXEC \
+	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED)
+#define PAGE_COPY_NOEXEC \
+	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED | _PAGE_NX)
+#define PAGE_COPY_EXEC \
+	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
+#define PAGE_COPY \
+	PAGE_COPY_NOEXEC
+#define PAGE_READONLY \
+	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED | _PAGE_NX)
+#define PAGE_READONLY_EXEC \
+	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 
 #define _PAGE_KERNEL \
+	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_NX)
+#define _PAGE_KERNEL_EXEC \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
 
-extern unsigned long __PAGE_KERNEL;
-#define __PAGE_KERNEL_RO	(__PAGE_KERNEL & ~_PAGE_RW)
-#define __PAGE_KERNEL_NOCACHE	(__PAGE_KERNEL | _PAGE_PCD)
-#define __PAGE_KERNEL_LARGE	(__PAGE_KERNEL | _PAGE_PSE)
+extern unsigned long long __PAGE_KERNEL, __PAGE_KERNEL_EXEC;
+#define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
+#define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_PCD)
+#define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
+#define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
 
 #define PAGE_KERNEL		__pgprot(__PAGE_KERNEL)
 #define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
+#define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC)
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
+#define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC)
 
 /*
  * The i386 can't do page protection for execute, and considers that
@@ -158,19 +182,19 @@ extern unsigned long __PAGE_KERNEL;
 #define __P001	PAGE_READONLY
 #define __P010	PAGE_COPY
 #define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
+#define __P100	PAGE_READONLY_EXEC
+#define __P101	PAGE_READONLY_EXEC
+#define __P110	PAGE_COPY_EXEC
+#define __P111	PAGE_COPY_EXEC
 
 #define __S000	PAGE_NONE
 #define __S001	PAGE_READONLY
 #define __S010	PAGE_SHARED
 #define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED
+#define __S100	PAGE_READONLY_EXEC
+#define __S101	PAGE_READONLY_EXEC
+#define __S110	PAGE_SHARED_EXEC
+#define __S111	PAGE_SHARED_EXEC
 
 /*
  * Define this if things work differently on an i386 and an i486:
@@ -244,6 +268,15 @@ static inline pte_t pte_modify(pte_t pte
 {
 	pte.pte_low &= _PAGE_CHG_MASK;
 	pte.pte_low |= pgprot_val(newprot);
+#ifdef CONFIG_X86_PAE
+	/*
+	 * Chop off the NX bit (if present), and add the NX portion of
+	 * the newprot (if present):
+	 */
+	pte.pte_high &= -1 ^ (1 << (_PAGE_BIT_NX - 32));
+	pte.pte_high |= (pgprot_val(newprot) >> 32) & \
+					(__supported_pte_mask >> 32);
+#endif
 	return pte;
 }
 
--- linux/fs/binfmt_elf.c.orig	
+++ linux/fs/binfmt_elf.c	
@@ -491,6 +491,7 @@ static int load_elf_binary(struct linux_
 	char passed_fileno[6];
 	struct files_struct *files;
 	int executable_stack = EXSTACK_DEFAULT;
+	unsigned long def_flags = 0;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -622,7 +623,10 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_ENABLE_X;
 			else
 				executable_stack = EXSTACK_DISABLE_X;
+			break;
 		}
+	if (i == elf_ex.e_phnum)
+		def_flags |= VM_EXEC | VM_MAYEXEC;
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
@@ -690,6 +694,7 @@ static int load_elf_binary(struct linux_
 	current->mm->end_code = 0;
 	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
+	current->mm->def_flags = def_flags;
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -431,6 +431,7 @@ int setup_arg_pages(struct linux_binprm 
 			mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
 		else
 			mpnt->vm_flags = VM_STACK_FLAGS;
+		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- linux/mm/vmalloc.c.orig	
+++ linux/mm/vmalloc.c	
@@ -456,6 +456,28 @@ void *vmalloc(unsigned long size)
 EXPORT_SYMBOL(vmalloc);
 
 /**
+ *	vmalloc_exec  -  allocate virtually contiguous, executable memory
+ *
+ *	@size:		allocation size
+ *
+ *	Kernel-internal function to allocate enough pages to cover @size
+ *	the page level allocator and map them into contiguous and
+ *	executable kernel virtual space.
+ *
+ *	For tight cotrol over page level allocator and protection flags
+ *	use __vmalloc() instead.
+ */
+
+#ifndef PAGE_KERNEL_EXEC
+# define PAGE_KERNEL_EXEC PAGE_KERNEL
+#endif
+
+void *vmalloc_exec(unsigned long size)
+{
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC);
+}
+
+/**
  *	vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
  *
  *	@size:		allocation size

--huq684BweRXVnRxX--
