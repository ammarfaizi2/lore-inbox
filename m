Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265874AbUFDQ2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUFDQ2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUFDQ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:27:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39332 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265847AbUFDQYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:24:20 -0400
Date: Fri, 4 Jun 2004 18:25:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] exec-shield patch for 2.6.7-rc2-bk2, integrated with NX
Message-ID: <20040604162524.GA32680@elte.hu>
References: <20040602210421.GA22011@elte.hu> <20040604155906.GA1378@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604155906.GA1378@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> > Here's the latest exec-shield patch for 2.6.7-rc2-bk2, integrated with
> > the 'NX' feature (see the announcement from earlier today):
> > 
> >   http://redhat.com/~mingo/exec-shield/exec-shield-on-nx-2.6.7-rc2-bk2-A7
> 
> Any chance to split this up a bit?  Having the pure non-exec stack
> (and maybe heap) would be really nice while the randomization feature
> are a litte bit too much security by obscurity for my taste.

below is a version of the -A9 exec-shield that has all randomization
code removed (ontop of the -AF version of the NX patch). The
address-space layout changes are still needed to 1) get near the maximum
possible amount for data mmap() and malloc() space and to 2) move all
executable mappings close to each other to get a maximum effect from the
segment limit.

(but i still think randomization is useful as a last-resort barrier,
against worm-alike mass attacks. There's a huge difference between a
1-packet infection and a 2-hour brute-force search over broadband, in
terms of the 'economy' of worms.)

	Ingo

--- linux/drivers/char/drm/ffb_drv.c.orig	
+++ linux/drivers/char/drm/ffb_drv.c	
@@ -285,19 +285,19 @@ static unsigned long ffb_get_unmapped_ar
 	unsigned long addr = -ENOMEM;
 
 	if (!map)
-		return get_unmapped_area(NULL, hint, len, pgoff, flags);
+		return get_unmapped_area(NULL, hint, len, pgoff, flags, 0);
 
 	if (map->type == _DRM_FRAME_BUFFER ||
 	    map->type == _DRM_REGISTERS) {
 #ifdef HAVE_ARCH_FB_UNMAPPED_AREA
 		addr = get_fb_unmapped_area(filp, hint, len, pgoff, flags);
 #else
-		addr = get_unmapped_area(NULL, hint, len, pgoff, flags);
+		addr = get_unmapped_area(NULL, hint, len, pgoff, flags, 0);
 #endif
 	} else if (map->type == _DRM_SHM && SHMLBA > PAGE_SIZE) {
 		unsigned long slack = SHMLBA - PAGE_SIZE;
 
-		addr = get_unmapped_area(NULL, hint, len + slack, pgoff, flags);
+		addr = get_unmapped_area(NULL, hint, len + slack, pgoff, flags, 0);
 		if (!(addr & ~PAGE_MASK)) {
 			unsigned long kvirt = (unsigned long) map->handle;
 
@@ -313,7 +313,7 @@ static unsigned long ffb_get_unmapped_ar
 			}
 		}
 	} else {
-		addr = get_unmapped_area(NULL, hint, len, pgoff, flags);
+		addr = get_unmapped_area(NULL, hint, len, pgoff, flags, 0);
 	}
 
 	return addr;
--- linux/arch/sparc64/kernel/sys_sparc32.c.orig	
+++ linux/arch/sparc64/kernel/sys_sparc32.c	
@@ -1731,7 +1731,7 @@ asmlinkage unsigned long sys32_mremap(un
 		/* MREMAP_FIXED checked above. */
 		new_addr = get_unmapped_area(file, addr, new_len,
 				    vma ? vma->vm_pgoff : 0,
-				    map_flags);
+				    map_flags, vma->vm_flags & VM_EXEC);
 		ret = new_addr;
 		if (new_addr & ~PAGE_MASK)
 			goto out_sem;
--- linux/arch/sparc64/kernel/sys_sparc.c.orig	
+++ linux/arch/sparc64/kernel/sys_sparc.c	
@@ -127,7 +127,7 @@ unsigned long get_fb_unmapped_area(struc
 
 	if (flags & MAP_FIXED) {
 		/* Ok, don't mess with it. */
-		return get_unmapped_area(NULL, addr, len, pgoff, flags);
+		return get_unmapped_area(NULL, addr, len, pgoff, flags, 0);
 	}
 	flags &= ~MAP_SHARED;
 
@@ -140,7 +140,7 @@ unsigned long get_fb_unmapped_area(struc
 		align_goal = (64UL * 1024);
 
 	do {
-		addr = get_unmapped_area(NULL, orig_addr, len + (align_goal - PAGE_SIZE), pgoff, flags);
+		addr = get_unmapped_area(NULL, orig_addr, len + (align_goal - PAGE_SIZE), pgoff, flags, 0);
 		if (!(addr & ~PAGE_MASK)) {
 			addr = (addr + (align_goal - 1UL)) & ~(align_goal - 1UL);
 			break;
@@ -158,7 +158,7 @@ unsigned long get_fb_unmapped_area(struc
 	 * be obtained.
 	 */
 	if (addr & ~PAGE_MASK)
-		addr = get_unmapped_area(NULL, orig_addr, len, pgoff, flags);
+		addr = get_unmapped_area(NULL, orig_addr, len, pgoff, flags, 0);
 
 	return addr;
 }
@@ -394,7 +394,7 @@ asmlinkage unsigned long sys64_mremap(un
 		/* MREMAP_FIXED checked above. */
 		new_addr = get_unmapped_area(file, addr, new_len,
 				    vma ? vma->vm_pgoff : 0,
-				    map_flags);
+				    map_flags, vma->vm_flags & VM_EXEC);
 		ret = new_addr;
 		if (new_addr & ~PAGE_MASK)
 			goto out_sem;
--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -238,8 +238,12 @@ sysenter_past_esp:
 	pushl %ebp
 	pushfl
 	pushl $(__USER_CS)
-	pushl $SYSENTER_RETURN
-
+	/*
+	 * Push current_thread_info()->sysenter_return to the stack.
+	 * A tiny bit of offset fixup is necessary - 4*4 means the 4 words
+	 * pushed above, and the word being pushed now:
+	 */
+	pushl (TI_sysenter_return-THREAD_SIZE+4*4)(%esp)
 /*
  * Load the potential sixth argument from user stack.
  * Careful about security.
--- linux/arch/i386/kernel/asm-offsets.c.orig	
+++ linux/arch/i386/kernel/asm-offsets.c	
@@ -52,6 +52,7 @@ void foo(void)
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
+	OFFSET(TI_sysenter_return, thread_info, sysenter_return);
 	BLANK();
 
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
--- linux/arch/i386/kernel/process.c.orig	
+++ linux/arch/i386/kernel/process.c	
@@ -36,6 +36,8 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -512,6 +514,8 @@ struct task_struct fastcall * __switch_t
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
 	__unlazy_fpu(prev_p);
+	if (next_p->mm)
+		load_user_cs_desc(cpu, next_p->mm);
 
 	/*
 	 * Reload esp0, LDT and the page table pointer:
@@ -776,3 +780,234 @@ asmlinkage int sys_get_thread_area(struc
 	return 0;
 }
 
+unsigned long arch_align_stack(unsigned long sp)
+{
+	return sp & ~0xf;
+}
+
+#if SHLIB_BASE >= 0x01000000
+# error SHLIB_BASE must be under 16MB!
+#endif
+
+static unsigned long
+arch_get_unmapped_nonexecutable_area(struct mm_struct *mm, unsigned long addr, unsigned long len)
+{
+	struct vm_area_struct *vma, *prev_vma;
+	unsigned long stack_limit;
+	int first_time = 1;	
+
+	if (!mm->mmap_top) {
+		printk("hm, %s:%d, !mmap_top.\n", current->comm, current->pid);
+		mm->mmap_top = mmap_top();
+	}
+	stack_limit = mm->mmap_top;
+
+	/* requested length too big for entire address space */
+	if (len > TASK_SIZE) 
+		return -ENOMEM;
+
+	/* dont allow allocations above current stack limit */
+	if (mm->non_executable_cache > stack_limit)
+		mm->non_executable_cache = stack_limit;
+
+	/* requesting a specific address */
+        if (addr) {
+                addr = PAGE_ALIGN(addr);
+                vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr && 
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+        }
+
+	/* make sure it can fit in the remaining address space */
+	if (mm->non_executable_cache < len)
+		return -ENOMEM;
+
+	/* either no address requested or cant fit in requested address hole */
+try_again:
+        addr = (mm->non_executable_cache - len)&PAGE_MASK;
+	do {
+       	 	if (!(vma = find_vma_prev(mm, addr, &prev_vma)))
+                        return -ENOMEM;
+
+		/* new region fits between prev_vma->vm_end and vma->vm_start, use it */
+		if (addr+len <= vma->vm_start && (!prev_vma || (addr >= prev_vma->vm_end))) {
+			/* remember the address as a hint for next time */
+			mm->non_executable_cache = addr;
+			return addr;
+
+		/* pull non_executable_cache down to the first hole */
+		} else if (mm->non_executable_cache == vma->vm_end)
+				mm->non_executable_cache = vma->vm_start;	
+
+		/* try just below the current vma->vm_start */
+		addr = vma->vm_start-len;
+        } while (len <= vma->vm_start);
+	/* if hint left us with no space for the requested mapping try again */
+	if (first_time) {
+		first_time = 0;
+		mm->non_executable_cache = stack_limit;
+		goto try_again;
+	}
+	return -ENOMEM;
+}
+
+static inline unsigned long
+stock_arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long start_addr;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	start_addr = addr = mm->free_area_cache;
+
+full_search:
+	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (TASK_SIZE - len < addr) {
+			/*
+			 * Start a new search - just in case we missed
+			 * some holes.
+			 */
+			if (start_addr != TASK_UNMAPPED_BASE) {
+				start_addr = addr = TASK_UNMAPPED_BASE;
+				goto full_search;
+			}
+			return -ENOMEM;
+		}
+		if (!vma || addr + len <= vma->vm_start) {
+			/*
+			 * Remember the place where we stopped the search:
+			 */
+			mm->free_area_cache = addr + len;
+			return addr;
+		}
+		addr = vma->vm_end;
+	}
+}
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr0,
+		unsigned long len0, unsigned long pgoff, unsigned long flags,
+		unsigned long prot)
+{
+	unsigned long addr = addr0, len = len0;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int ascii_shield = 0;
+	unsigned long tmp;
+
+	/*
+	 * Fall back to the old layout:
+	 */
+	if (!(current->flags & PF_RELOCEXEC))
+	       return stock_arch_get_unmapped_area(filp, addr0, len0, pgoff, flags);
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (!addr && (prot & PROT_EXEC) && !(flags & MAP_FIXED))
+		addr = SHLIB_BASE;
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start)) {
+			return addr;
+		}
+	}
+
+	if (prot & PROT_EXEC) {
+		ascii_shield = 1;
+		addr = SHLIB_BASE;
+	} else {
+		/* this can fail if the stack was unlimited */
+		if ((tmp = arch_get_unmapped_nonexecutable_area(mm, addr, len)) != -ENOMEM)
+			return tmp;
+search_upper:
+		addr = PAGE_ALIGN(arch_align_stack(TASK_UNMAPPED_BASE));
+	}
+
+	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (TASK_SIZE - len < addr) {
+			return -ENOMEM;
+		}
+		if (!vma || addr + len <= vma->vm_start) {
+			/*
+			 * Must not let a PROT_EXEC mapping get into the
+			 * brk area:
+			 */
+			if (ascii_shield && (addr + len > mm->brk)) {
+				ascii_shield = 0;
+				goto search_upper;
+			}
+			return addr;
+		}
+		addr = vma->vm_end;
+	}
+}
+
+void arch_add_exec_range(struct mm_struct *mm, unsigned long limit)
+{
+	if (limit > mm->context.exec_limit) {
+		mm->context.exec_limit = limit;
+		set_user_cs(&mm->context.user_cs, limit);
+		if (mm == current->mm)
+			load_user_cs_desc(smp_processor_id(), mm);
+	}
+}
+
+void arch_remove_exec_range(struct mm_struct *mm, unsigned long old_end)
+{
+	struct vm_area_struct *vma;
+	unsigned long limit = 0;
+
+	if (old_end == mm->context.exec_limit) {
+		for (vma = mm->mmap; vma; vma = vma->vm_next)
+			if ((vma->vm_flags & VM_EXEC) && (vma->vm_end > limit))
+				limit = vma->vm_end;
+
+		mm->context.exec_limit = limit;
+		set_user_cs(&mm->context.user_cs, limit);
+		if (mm == current->mm)
+			load_user_cs_desc(smp_processor_id(), mm);
+	}
+}
+
+void arch_flush_exec_range(struct mm_struct *mm)
+{
+	mm->context.exec_limit = 0;
+	set_user_cs(&mm->context.user_cs, 0);
+}
+
+/*
+ * Top of mmap area (just below the process stack).
+ * leave an at least ~128 MB hole.
+ */
+#define MIN_GAP (128*1024*1024)
+#define MAX_GAP (TASK_SIZE/6*5)
+
+unsigned long mmap_top(void)
+{
+	unsigned long gap = 0;
+
+	gap = current->rlim[RLIMIT_STACK].rlim_cur;
+	if (gap < MIN_GAP)
+		gap = MIN_GAP;
+	else if (gap > MAX_GAP)
+		gap = MAX_GAP;
+
+	return TASK_SIZE - (gap & PAGE_MASK);
+}
+
--- linux/arch/i386/kernel/signal.c.orig	
+++ linux/arch/i386/kernel/signal.c	
@@ -333,7 +333,7 @@ get_sigframe(struct k_sigaction *ka, str
 
 /* These symbols are defined with the addresses in the vsyscall page.
    See vsyscall-sigreturn.S.  */
-extern void __kernel_sigreturn, __kernel_rt_sigreturn;
+extern char __kernel_sigreturn, __kernel_rt_sigreturn, SYSENTER_RETURN;
 
 static void setup_frame(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
@@ -367,7 +367,7 @@ static void setup_frame(int sig, struct 
 	if (err)
 		goto give_sigsegv;
 
-	restorer = &__kernel_sigreturn;
+	restorer = current->mm->context.vdso + (long)&__kernel_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -450,9 +450,10 @@ static void setup_rt_frame(int sig, stru
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	restorer = &__kernel_rt_sigreturn;
+	restorer = current->mm->context.vdso + (long)&__kernel_rt_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
+
 	err |= __put_user(restorer, &frame->pretcode);
 	 
 	/*
--- linux/arch/i386/kernel/traps.c.orig	
+++ linux/arch/i386/kernel/traps.c	
@@ -430,6 +430,10 @@ DO_ERROR(11, SIGBUS,  "segment not prese
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
 
+/*
+ * the original non-exec stack patch was written by
+ * Solar Designer <solar at openwall.com>. Thanks!
+ */
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
 	if (regs->eflags & X86_EFLAGS_IF)
@@ -441,6 +445,46 @@ asmlinkage void do_general_protection(st
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
 
+	/*
+	 * lazy-check for CS validity on exec-shield binaries:
+	 */
+	if (current->mm) {
+		int cpu = smp_processor_id();
+		struct desc_struct *desc1, *desc2;
+		struct vm_area_struct *vma;
+		unsigned long limit = 0;
+		
+		spin_lock(&current->mm->page_table_lock);
+		for (vma = current->mm->mmap; vma; vma = vma->vm_next)
+			if ((vma->vm_flags & VM_EXEC) && (vma->vm_end > limit))
+				limit = vma->vm_end;
+		spin_unlock(&current->mm->page_table_lock);
+
+		current->mm->context.exec_limit = limit;
+		set_user_cs(&current->mm->context.user_cs, limit);
+
+		desc1 = &current->mm->context.user_cs;
+		desc2 = cpu_gdt_table[cpu] + GDT_ENTRY_DEFAULT_USER_CS;
+
+		/*
+		 * The CS was not in sync - reload it and retry the
+		 * instruction. If the instruction still faults then
+		 * we wont hit this branch next time around.
+		 */
+		if (desc1->a != desc2->a || desc1->b != desc2->b) {
+			if (print_fatal_signals >= 2) {
+				printk("#GPF fixup (%ld[seg:%lx]) at %08lx, CPU#%d.\n", error_code, error_code/8, regs->eip, smp_processor_id());
+				printk(" exec_limit: %08lx, user_cs: %08lx/%08lx, CPU_cs: %08lx/%08lx.\n", current->mm->context.exec_limit, desc1->a, desc1->b, desc2->a, desc2->b);
+			}
+			load_user_cs_desc(cpu, current->mm);
+			return;
+		}
+	}
+	if (print_fatal_signals) {
+		printk("#GPF(%ld[seg:%lx]) at %08lx, CPU#%d.\n", error_code, error_code/8, regs->eip, smp_processor_id());
+		printk(" exec_limit: %08lx, user_cs: %08lx/%08lx.\n", current->mm->context.exec_limit, current->mm->context.user_cs.a, current->mm->context.user_cs.b);
+	}
+
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
 	force_sig(SIGSEGV, current);
--- linux/arch/i386/kernel/sysenter.c.orig	
+++ linux/arch/i386/kernel/sysenter.c	
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/elf.h>
+#include <linux/mman.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -41,11 +42,14 @@ void enable_sep_cpu(void *info)
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
 
+struct page *sysenter_page;
+
 static int __init sysenter_setup(void)
 {
 	unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
-	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY_EXEC);
+	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_KERNEL_RO);
+	sysenter_page = virt_to_page(page);
 
 	if (!boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy((void *) page,
@@ -59,7 +63,51 @@ static int __init sysenter_setup(void)
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
 	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
+
 	return 0;
 }
 
 __initcall(sysenter_setup);
+
+extern void SYSENTER_RETURN_OFFSET;
+
+unsigned int vdso_enabled = 1;
+
+void map_vsyscall(void)
+{
+	struct thread_info *ti = current_thread_info();
+	struct vm_area_struct *vma;
+	unsigned long addr;
+
+	if (unlikely(!vdso_enabled)) {
+		current->mm->context.vdso = NULL;
+		return;
+	}
+
+	/*
+	 * Map the vDSO:
+	 */
+	down_write(&current->mm->mmap_sem);
+	addr = do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC, MAP_PRIVATE, 0);
+	current->mm->context.vdso = (void *)addr;
+	ti->sysenter_return = (void *)addr + (long)&SYSENTER_RETURN_OFFSET;
+	if (addr != -1) {
+		vma = find_vma(current->mm, addr);
+		if (vma) {
+			pgprot_val(vma->vm_page_prot) &= ~_PAGE_RW;
+			get_page(sysenter_page);
+			install_page(current->mm, vma, addr,
+					sysenter_page, vma->vm_page_prot);
+			
+		}
+	}
+	up_write(&current->mm->mmap_sem);
+}
+
+static int __init vdso_setup(char *str)
+{
+        vdso_enabled = simple_strtoul(str, NULL, 0);
+        return 1;
+}
+__setup("vdso=", vdso_setup);
+
--- linux/arch/i386/kernel/vsyscall.lds.orig	
+++ linux/arch/i386/kernel/vsyscall.lds	
@@ -1,15 +1,12 @@
 /*
  * Linker script for vsyscall DSO.  The vsyscall page is an ELF shared
- * object prelinked to its virtual address, and with only one read-only
- * segment (that fits in one page).  This script controls its layout.
+ * object with only one read-only segment (that fits in one page).
+ * This script controls its layout.
  */
 
-/* This must match <asm/fixmap.h>.  */
-VSYSCALL_BASE = 0xffffe000;
-
 SECTIONS
 {
-  . = VSYSCALL_BASE + SIZEOF_HEADERS;
+  . = SIZEOF_HEADERS;
 
   .hash           : { *(.hash) }		:text
   .dynsym         : { *(.dynsym) }
@@ -22,7 +19,7 @@ SECTIONS
      For the layouts to match, we need to skip more than enough
      space for the dynamic symbol table et al.  If this amount
      is insufficient, ld -shared will barf.  Just increase it here.  */
-  . = VSYSCALL_BASE + 0x400;
+  . = 0x400;
 
   .text           : { *(.text) }		:text =0x90909090
 
--- linux/arch/i386/kernel/vsyscall-sysenter.S.orig	
+++ linux/arch/i386/kernel/vsyscall-sysenter.S	
@@ -24,11 +24,11 @@ __kernel_vsyscall:
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
--- linux/arch/i386/mm/init.c.orig	
+++ linux/arch/i386/mm/init.c	
@@ -414,6 +414,7 @@ extern void zone_sizes_init(void);
 
 static int disable_nx __initdata = 0;
 u64 __supported_pte_mask = ~_PAGE_NX;
+int use_nx = 0;
 
 /*
  * noexec = on|off
@@ -421,7 +422,7 @@ u64 __supported_pte_mask = ~_PAGE_NX;
  * Control non executable mappings.
  *
  * on      Enable
- * off     Disable
+ * off     Disable (disables exec-shield too)
  */
 static int __init noexec_setup(char *str)
 {
@@ -431,6 +432,7 @@ static int __init noexec_setup(char *str
 	} else if (!strncmp(str,"off",3)) {
 		disable_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
+		exec_shield = 0;
 	}
 	return 1;
 }
@@ -438,7 +440,6 @@ static int __init noexec_setup(char *str
 __setup("noexec=", noexec_setup);
 
 #ifdef CONFIG_X86_PAE
-static int use_nx = 0;
 
 static void __init set_nx(void)
 {
@@ -471,8 +472,11 @@ void __init paging_init(void)
 	set_nx();
 	if (use_nx)
 		printk("NX (Execute Disable) protection: active\n");
-	else
+	else {
 		printk("NX (Execute Disable) protection: not present!\n");
+		if (exec_shield)
+			printk("Using x86 segment limits to approximate NX protection\n");
+	}
 #endif
 
 	pagetable_init();
--- linux/arch/sparc/kernel/sys_sparc.c.orig	
+++ linux/arch/sparc/kernel/sys_sparc.c	
@@ -332,7 +332,7 @@ asmlinkage unsigned long sparc_mremap(un
 
 		new_addr = get_unmapped_area(file, addr, new_len,
 				     vma ? vma->vm_pgoff : 0,
-				     map_flags);
+				     map_flags, vma->vm_flags & VM_EXEC);
 		ret = new_addr;
 		if (new_addr & ~PAGE_MASK)
 			goto out_sem;
--- linux/arch/ia64/kernel/perfmon.c.orig	
+++ linux/arch/ia64/kernel/perfmon.c	
@@ -599,7 +599,7 @@ pfm_do_munmap(struct mm_struct *mm, unsi
 static inline unsigned long 
 pfm_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags, unsigned long exec)
 {
-	return get_unmapped_area(file, addr, len, pgoff, flags);
+	return get_unmapped_area(file, addr, len, pgoff, flags, 0);
 }
 
 
--- linux/arch/ia64/ia32/binfmt_elf32.c.orig	
+++ linux/arch/ia64/ia32/binfmt_elf32.c	
@@ -211,7 +211,7 @@ elf32_set_personality (void)
 }
 
 static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type, unsigned long unused)
 {
 	unsigned long pgoff = (eppnt->p_vaddr) & ~IA32_PAGE_MASK;
 
--- linux/arch/x86_64/ia32/ia32_binfmt.c.orig	
+++ linux/arch/x86_64/ia32/ia32_binfmt.c	
@@ -382,7 +382,7 @@ int setup_arg_pages(struct linux_binprm 
 }
 
 static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type, unsigned long unused)
 {
 	unsigned long map_addr;
 	struct task_struct *me = current; 
--- linux/include/asm-x86_64/pgalloc.h.orig	
+++ linux/include/asm-x86_64/pgalloc.h	
@@ -7,6 +7,11 @@
 #include <linux/threads.h>
 #include <linux/mm.h>
 
+#define arch_add_exec_range(mm, limit) do { ; } while (0)
+#define arch_flush_exec_range(mm)      do { ; } while (0)
+#define arch_remove_exec_range(mm, limit) do { ; } while (0)
+
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE | __pa(pte)))
 #define pgd_populate(mm, pgd, pmd) \
--- linux/include/linux/mm.h.orig	
+++ linux/include/linux/mm.h	
@@ -630,7 +630,7 @@ extern struct vm_area_struct *copy_vma(s
 	unsigned long addr, unsigned long len, pgoff_t pgoff);
 extern void exit_mmap(struct mm_struct *);
 
-extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
--- linux/include/linux/resource.h.orig	
+++ linux/include/linux/resource.h	
@@ -52,8 +52,11 @@ struct rlimit {
 /*
  * Limit the stack by to some sane default: root can always
  * increase this limit if needed..  8MB seems reasonable.
+ *
+ * (2MB more to cover randomization effects.)
  */
-#define _STK_LIM	(8*1024*1024)
+#define _STK_LIM	(10*1024*1024)
+#define EXEC_STACK_BIAS	(2*1024*1024)
 
 /*
  * Due to binary compatibility, the actual resource numbers
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -31,6 +31,8 @@
 #include <linux/percpu.h>
 
 struct exec_domain;
+extern int exec_shield;
+extern int print_fatal_signals;
 
 /*
  * cloning flags:
@@ -196,6 +198,8 @@ struct mm_struct {
 	struct rb_root mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
 	unsigned long free_area_cache;		/* first hole */
+	unsigned long non_executable_cache;	/* last hole top */
+	unsigned long mmap_top;			/* top of mmap area */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
@@ -549,6 +553,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_RELOCEXEC	0x00400000	/* relocate shared libraries */
+
 
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
--- linux/include/asm-ppc64/pgalloc.h.orig	
+++ linux/include/asm-ppc64/pgalloc.h	
@@ -10,6 +10,11 @@
 
 extern kmem_cache_t *zero_cache;
 
+/* Dummy functions since we don't support execshield on ppc */
+#define arch_add_exec_range(mm, limit) do { ; } while (0)
+#define arch_flush_exec_range(mm)      do { ; } while (0)
+#define arch_remove_exec_range(mm, limit) do { ; } while (0)
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
--- linux/include/asm-ia64/pgalloc.h.orig	
+++ linux/include/asm-ia64/pgalloc.h	
@@ -23,6 +23,10 @@
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 
+#define arch_add_exec_range(mm, limit)		do { ; } while (0)
+#define arch_flush_exec_range(mm)		do { ; } while (0)
+#define arch_remove_exec_range(mm, limit)	do { ; } while (0)
+
 /*
  * Very stupidly, we used to get new pgd's and pmd's, init their contents
  * to point to the NULL versions of the next level page table, later on
--- linux/include/asm-ppc/pgalloc.h.orig	
+++ linux/include/asm-ppc/pgalloc.h	
@@ -40,5 +40,10 @@ extern void pte_free(struct page *pte);
 
 #define check_pgt_cache()	do { } while (0)
 
+#define arch_add_exec_range(mm, limit)         do { ; } while (0)
+#define arch_flush_exec_range(mm)              do { ; } while (0)
+#define arch_remove_exec_range(mm, limit)      do { ; } while (0)
+
+
 #endif /* _PPC_PGALLOC_H */
 #endif /* __KERNEL__ */
--- linux/include/asm-sparc/pgalloc.h.orig	
+++ linux/include/asm-sparc/pgalloc.h	
@@ -66,4 +66,8 @@ BTFIXUPDEF_CALL(void, pte_free, struct p
 #define pte_free(pte)		BTFIXUP_CALL(pte_free)(pte)
 #define __pte_free_tlb(tlb, pte)	pte_free(pte)
 
+#define arch_add_exec_range(mm, limit)		do { ; } while (0)
+#define arch_flush_exec_range(mm)		do { ; } while (0)
+#define arch_remove_exec_range(mm, limit)	do { ; } while (0)
+
 #endif /* _SPARC_PGALLOC_H */
--- linux/include/asm-s390/pgalloc.h.orig	
+++ linux/include/asm-s390/pgalloc.h	
@@ -19,6 +19,10 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 
+#define arch_add_exec_range(mm, limit) do { ; } while (0)
+#define arch_flush_exec_range(mm)      do { ; } while (0)
+#define arch_remove_exec_range(mm, limit) do { ; } while (0)
+
 #define check_pgt_cache()	do {} while (0)
 
 extern void diag10(unsigned long addr);
--- linux/include/asm-i386/desc.h.orig	
+++ linux/include/asm-i386/desc.h	
@@ -123,6 +123,20 @@ static inline void load_LDT(mm_context_t
 	put_cpu();
 }
 
+static inline void set_user_cs(struct desc_struct *desc, unsigned long limit)
+{
+	limit = (limit - 1) / PAGE_SIZE;
+	desc->a = limit & 0xffff;
+	desc->b = (limit & 0xf0000) | 0x00c0fb00;
+}
+
+#define load_user_cs_desc(cpu, mm) \
+    	cpu_gdt_table[(cpu)][GDT_ENTRY_DEFAULT_USER_CS] = (mm)->context.user_cs
+
+extern void arch_add_exec_range(struct mm_struct *mm, unsigned long limit);
+extern void arch_remove_exec_range(struct mm_struct *mm, unsigned long limit);
+extern void arch_flush_exec_range(struct mm_struct *mm);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
--- linux/include/asm-i386/elf.h.orig	
+++ linux/include/asm-i386/elf.h	
@@ -9,6 +9,7 @@
 #include <asm/user.h>
 #include <asm/processor.h>
 #include <asm/system.h>		/* for savesegment */
+#include <asm/desc.h>
 
 #include <linux/utsname.h>
 
@@ -117,7 +118,8 @@ typedef struct user_fxsr_struct elf_fpxr
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+/* child inherits the personality of the parent */
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
@@ -127,15 +129,22 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
 
-#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
-#define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
-#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
 extern void __kernel_vsyscall;
+#define VSYSCALL_BASE	((unsigned long)current->mm->context.vdso)
+#define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
+#define VSYSCALL_OFFSET	((unsigned long) &__kernel_vsyscall)
+#define VSYSCALL_ENTRY	(VSYSCALL_BASE + VSYSCALL_OFFSET)
 
-#define ARCH_DLINFO						\
-do {								\
-		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+/* kernel-internal fixmap address: */
+#define __VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
+#define __VSYSCALL_EHDR	((const struct elfhdr *) __VSYSCALL_BASE)
+
+#define ARCH_DLINFO							\
+do {									\
+	if (VSYSCALL_BASE) {						\
+		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);		\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);		\
+	}								\
 } while (0)
 
 /*
@@ -146,15 +155,15 @@ do {								\
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
@@ -172,10 +181,10 @@ do {									      \
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
@@ -184,4 +193,7 @@ do {									      \
 
 #endif
 
+#define __HAVE_ARCH_VSYSCALL
+extern void map_vsyscall(void);
+
 #endif
--- linux/include/asm-i386/mmu.h.orig	
+++ linux/include/asm-i386/mmu.h	
@@ -7,11 +7,17 @@
  * we put the segment information here.
  *
  * cpu_vm_mask is used to optimize ldt flushing.
+ *
+ * exec_limit is used to track the range PROT_EXEC
+ * mappings span.
  */
 typedef struct { 
 	int size;
 	struct semaphore sem;
 	void *ldt;
+	struct desc_struct user_cs;
+	unsigned long exec_limit;
+	void *vdso;
 } mm_context_t;
 
 #endif
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -138,8 +138,10 @@ static __inline__ int get_order(unsigned
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS \
+		(VM_READ | VM_WRITE | \
+			((current->flags & PF_RELOCEXEC) ? 0 : VM_EXEC) | \
+				VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif /* __KERNEL__ */
 
--- linux/include/asm-i386/pgalloc.h.orig	
+++ linux/include/asm-i386/pgalloc.h	
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/fixmap.h>
+#include <asm/desc.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
 
@@ -52,4 +53,6 @@ static inline void pte_free(struct page 
 
 #define check_pgt_cache()	do { } while (0)
 
+#define HAVE_ARCH_UNMAPPED_AREA 1
+
 #endif /* _I386_PGALLOC_H */
--- linux/include/asm-i386/processor.h.orig	
+++ linux/include/asm-i386/processor.h	
@@ -300,7 +300,15 @@ extern unsigned int mca_pentium_flag;
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE/3)
+
+#define SHLIB_BASE		0x00111000
+ 
+#define __HAVE_ARCH_ALIGN_STACK
+extern unsigned long arch_align_stack(unsigned long sp);
+
+#define __HAVE_ARCH_MMAP_TOP
+extern unsigned long mmap_top(void);
 
 /*
  * Size of io_bitmap, covering ports 0 to 0x3ff.
@@ -462,6 +470,8 @@ static inline void load_esp0(struct tss_
 	}
 }
 
+extern int use_nx;
+
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
 	set_fs(USER_DS);					\
@@ -471,6 +481,7 @@ static inline void load_esp0(struct tss_
 	regs->xcs = __USER_CS;					\
 	regs->eip = new_eip;					\
 	regs->esp = new_esp;					\
+	load_user_cs_desc(smp_processor_id(), current->mm);	\
 } while (0)
 
 /* Forward declaration, a strange C thing */
--- linux/include/asm-i386/thread_info.h.orig	
+++ linux/include/asm-i386/thread_info.h	
@@ -37,6 +37,7 @@ struct thread_info {
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	void			*sysenter_return;
 	struct restart_block    restart_block;
 
 	unsigned long           previous_esp;   /* ESP of the previous stack in case
--- linux/include/asm-sparc64/pgalloc.h.orig	
+++ linux/include/asm-sparc64/pgalloc.h	
@@ -236,4 +236,8 @@ static __inline__ void free_pte_slow(pte
 #define pgd_free(pgd)		free_pgd_fast(pgd)
 #define pgd_alloc(mm)		get_pgd_fast()
 
+#define arch_add_exec_range(mm, limit)		do { ; } while (0)
+#define arch_flush_exec_range(mm)		do { ; } while (0)
+#define arch_remove_exec_range(mm, limit)	do { ; } while (0)
+
 #endif /* _SPARC64_PGALLOC_H */
--- linux/fs/proc/array.c.orig	
+++ linux/fs/proc/array.c	
@@ -324,7 +324,10 @@ int proc_pid_stat(struct task_struct *ta
 		up_read(&mm->mmap_sem);
 	}
 
-	wchan = get_wchan(task);
+	wchan = 0;
+	if (current->uid == task->uid || current->euid == task->uid ||
+							capable(CAP_SYS_NICE))
+		wchan = get_wchan(task);
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
--- linux/fs/proc/base.c.orig	
+++ linux/fs/proc/base.c	
@@ -111,7 +111,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
+	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUSR),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
@@ -133,7 +133,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
+	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUSR),
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
--- linux/fs/proc/task_mmu.c.orig	
+++ linux/fs/proc/task_mmu.c	
@@ -34,12 +34,23 @@ char *task_mem(struct mm_struct *mm, cha
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"VmLib:\t%8lu kB\n"
+		"StaBrk:\t%08lx kB\n"
+		"Brk:\t%08lx kB\n"
+		"StaStk:\t%08lx kB\n"
+#if __i386__
+		"ExecLim:\t%08lx\n"
+#endif
+		,
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data - stack, stack,
-		exec - lib, lib);
+		exec - lib, lib, mm->start_brk, mm->brk, mm->start_stack
+#if __i386__
+		, mm->context.exec_limit
+#endif
+		);
 	up_read(&mm->mmap_sem);
 	return buffer;
 }
--- linux/fs/binfmt_aout.c.orig	
+++ linux/fs/binfmt_aout.c	
@@ -308,7 +308,8 @@ static int load_aout_binary(struct linux
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
-
+	/* unlimited stack is larger than TASK_SIZE */
+	current->mm->non_executable_cache = current->mm->mmap_top;
 	current->mm->rss = 0;
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -390,7 +390,12 @@ int setup_arg_pages(struct linux_binprm 
 	while (i < MAX_ARG_PAGES)
 		bprm->page[i++] = NULL;
 #else
+#ifdef __HAVE_ARCH_ALIGN_STACK
+	stack_base = arch_align_stack(STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = PAGE_ALIGN(stack_base);
+#else
 	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
+#endif
 	mm->arg_start = bprm->p + stack_base;
 	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
@@ -836,6 +841,7 @@ int flush_old_exec(struct linux_binprm *
 	}
 	current->comm[i] = '\0';
 
+	current->flags &= ~PF_RELOCEXEC;
 	flush_thread();
 
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
@@ -886,8 +892,13 @@ int prepare_binprm(struct linux_binprm *
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
 			bprm->e_uid = inode->i_uid;
+#ifdef __i386__
+			/* reset personality */
+			current->personality = PER_LINUX;
+#endif
+		}
 
 		/* Set-gid? */
 		/*
@@ -895,8 +906,13 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			bprm->e_gid = inode->i_gid;
+#ifdef __i386__
+			/* reset personality */
+			current->personality = PER_LINUX;
+#endif
+		}
 	}
 
 	/* fill in binprm security blob */
--- linux/fs/binfmt_elf.c.orig	
+++ linux/fs/binfmt_elf.c	
@@ -46,7 +46,7 @@
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
-static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
+static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int, unsigned long);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
 #ifndef elf_addr_t
@@ -156,20 +156,8 @@ create_elf_tables(struct linux_binprm *b
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
-#ifdef CONFIG_X86_HT
-		/*
-		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
-		 * evictions by the processes running on the same package. One
-		 * thing we can do is to shuffle the initial stack for them.
-		 *
-		 * The conditionals here are unneeded, but kept in to make the
-		 * code behaviour the same as pre change unless we have
-		 * hyperthreaded processors. This should be cleaned up
-		 * before 2.6
-		 */
-	 
-		if (smp_num_siblings > 1)
-			STACK_ALLOC(p, ((current->pid % 64) << 7));
+#ifdef __HAVE_ARCH_ALIGN_STACK
+		p = (unsigned long)arch_align_stack((unsigned long)p);
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
 		__copy_to_user(u_platform, k_platform, len);
@@ -273,20 +261,59 @@ create_elf_tables(struct linux_binprm *b
 #ifndef elf_map
 
 static unsigned long elf_map(struct file *filep, unsigned long addr,
-			struct elf_phdr *eppnt, int prot, int type)
+			     struct elf_phdr *eppnt, int prot, int type,
+			     unsigned long total_size)
 {
 	unsigned long map_addr;
+	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	addr = ELF_PAGESTART(addr);
+	size = ELF_PAGEALIGN(size);
 
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+	/*
+	 * total_size is the size of the ELF (interpreter) image.
+	 * The _first_ mmap needs to know the full size, otherwise
+	 * randomization might put this image into an overlapping
+	 * position with the ELF binary image. (since size < total_size)
+	 * So we first map the 'big' image - and unmap the remainder at
+	 * the end. (which unmap is needed for ELF images with holes.)
+	 */
+	if (total_size) {
+		total_size = ELF_PAGEALIGN(total_size);
+		map_addr = do_mmap(filep, addr, total_size, prot, type, off);
+		if (!BAD_ADDR(map_addr))
+			do_munmap(current->mm, map_addr+size, total_size-size);
+	} else
+		map_addr = do_mmap(filep, addr, size, prot, type, off);
+		
 	up_write(&current->mm->mmap_sem);
-	return(map_addr);
+
+	return map_addr;
 }
 
 #endif /* !elf_map */
 
+static inline unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
+{
+	int i, first_idx = -1, last_idx = -1;
+
+	for (i = 0; i < nr; i++)
+		if (cmds[i].p_type == PT_LOAD) {
+			last_idx = i;
+			if (first_idx == -1)
+				first_idx = i;
+		}
+
+	if (first_idx == -1)
+		return 0;
+
+	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
+				ELF_PAGESTART(cmds[first_idx].p_vaddr);
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -294,7 +321,8 @@ static unsigned long elf_map(struct file
 
 static unsigned long load_elf_interp(struct elfhdr * interp_elf_ex,
 				     struct file * interpreter,
-				     unsigned long *interp_load_addr)
+				     unsigned long *interp_load_addr,
+				     unsigned long no_base)
 {
 	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
@@ -302,6 +330,7 @@ static unsigned long load_elf_interp(str
 	int load_addr_set = 0;
 	unsigned long last_bss = 0, elf_bss = 0;
 	unsigned long error = ~0UL;
+	unsigned long total_size;
 	int retval, i, size;
 
 	/* First of all, some simple consistency checks */
@@ -336,6 +365,10 @@ static unsigned long load_elf_interp(str
 	if (retval < 0)
 		goto out_close;
 
+	total_size = total_mapping_size(elf_phdata, interp_elf_ex->e_phnum);
+	if (!total_size)
+		goto out_close;
+
 	eppnt = elf_phdata;
 	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
 	  if (eppnt->p_type == PT_LOAD) {
@@ -350,8 +383,11 @@ static unsigned long load_elf_interp(str
 	    vaddr = eppnt->p_vaddr;
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;
+	    else if (no_base && interp_elf_ex->e_type == ET_DYN)
+		load_addr = -vaddr;
 
-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type, total_size);
+	    total_size = 0;
 	    error = map_addr;
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;
@@ -490,7 +526,7 @@ static int load_elf_binary(struct linux_
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
-	int executable_stack = EXSTACK_DEFAULT;
+	int executable_stack, relocexec, old_relocexec = current->flags & PF_RELOCEXEC;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -616,14 +652,35 @@ static int load_elf_binary(struct linux_
 	}
 
 	elf_ppnt = elf_phdata;
+	executable_stack = EXSTACK_DEFAULT;
+
 	for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
 		if (elf_ppnt->p_type == PT_GNU_STACK) {
 			if (elf_ppnt->p_flags & PF_X)
 				executable_stack = EXSTACK_ENABLE_X;
 			else
 				executable_stack = EXSTACK_DISABLE_X;
+			break;
 		}
 
+	relocexec = 0;
+
+	if (current->personality == PER_LINUX)
+	switch (exec_shield) {
+	case 1:
+		if (executable_stack != EXSTACK_DEFAULT) {
+			current->flags |= PF_RELOCEXEC;
+			relocexec = PF_RELOCEXEC;
+		}
+		break;
+
+	case 2:
+		executable_stack = EXSTACK_DISABLE_X;
+		current->flags |= PF_RELOCEXEC;
+		relocexec = PF_RELOCEXEC;
+		break;
+	}
+
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
 		interpreter_type = INTERPRETER_ELF | INTERPRETER_AOUT;
@@ -676,6 +733,16 @@ static int load_elf_binary(struct linux_
 	retval = flush_old_exec(bprm);
 	if (retval)
 		goto out_free_dentry;
+	current->flags |= relocexec;
+
+#ifdef __i386__
+	/*
+	 * Turn off the CS limit completely if exec-shield disabled or
+	 * NX active:
+	 */
+	if (!exec_shield || use_nx)
+		arch_add_exec_range(current->mm, -1);
+#endif
 
 	/* Discard our unneeded old files struct */
 	if (files) {
@@ -689,6 +756,9 @@ static int load_elf_binary(struct linux_
 	current->mm->end_data = 0;
 	current->mm->end_code = 0;
 	current->mm->mmap = NULL;
+#ifdef __HAVE_ARCH_MMAP_TOP
+	current->mm->mmap_top = mmap_top();
+#endif
 	current->flags &= ~PF_FORKNOEXEC;
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
@@ -699,6 +769,7 @@ static int load_elf_binary(struct linux_
 	   change some of these later */
 	current->mm->rss = 0;
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
+	current->mm->non_executable_cache = current->mm->mmap_top;
 	retval = setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
@@ -707,10 +778,10 @@ static int load_elf_binary(struct linux_
 	
 	current->mm->start_stack = bprm->p;
 
+
 	/* Now we do a little grungy work by mmaping the ELF image into
-	   the correct location in memory.  At this point, we assume that
-	   the image should be loaded at fixed address, not at a variable
-	   address. */
+	   the correct location in memory.
+	 */
 
 	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
@@ -747,16 +818,16 @@ static int load_elf_binary(struct linux_
 		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
-		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (elf_ex.e_type == ET_EXEC || load_addr_set)
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex.e_type == ET_DYN) {
-			/* Try and get dynamic programs out of the way of the default mmap
-			   base, as well as whatever program they might try to exec.  This
-			   is because the brk will follow the loader, and is not movable.  */
+		else if (elf_ex.e_type == ET_DYN)
+#ifdef __i386__
+			load_bias = 0;
+#else
 			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-		}
+#endif
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
+		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags, 0);
 		if (BAD_ADDR(error))
 			continue;
 
@@ -827,7 +898,8 @@ static int load_elf_binary(struct linux_
 		else
 			elf_entry = load_elf_interp(&interp_elf_ex,
 						    interpreter,
-						    &interp_load_addr);
+						    &interp_load_addr,
+						    load_bias);
 		if (BAD_ADDR(elf_entry)) {
 			printk(KERN_ERR "Unable to load interpreter\n");
 			send_sig(SIGSEGV, current, 0);
@@ -850,6 +922,14 @@ static int load_elf_binary(struct linux_
 
 	set_binfmt(&elf_format);
 
+	/*
+	 * Map the vsyscall trampoline. This address is then passed via
+	 * AT_SYSINFO.
+	 */
+#ifdef __HAVE_ARCH_VSYSCALL
+	map_vsyscall();
+#endif
+
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
 	create_elf_tables(bprm, &elf_ex, (interpreter_type == INTERPRETER_AOUT),
@@ -916,6 +996,8 @@ out_free_fh:
 	}
 out_free_ph:
 	kfree(elf_phdata);
+	current->flags &= ~PF_RELOCEXEC;
+	current->flags |= old_relocexec;
 	goto out;
 }
 
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -416,6 +416,9 @@ static struct mm_struct * mm_init(struct
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
+#ifdef __HAVE_ARCH_MMAP_TOP
+		mm->mmap_top = mmap_top();
+#endif
 		return mm;
 	}
 	free_mm(mm);
--- linux/kernel/signal.c.orig	
+++ linux/kernel/signal.c	
@@ -1546,6 +1546,34 @@ do_notify_parent_cldstop(struct task_str
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+int print_fatal_signals = 0;
+
+static void print_fatal_signal(struct pt_regs *regs, int signr)
+{
+	int i;
+	unsigned char insn;
+	printk("%s/%d: potentially unexpected fatal signal %d.\n",
+		current->comm, current->pid, signr);
+		
+#ifdef __i386__
+	printk("code at %08lx: ", regs->eip);
+	for (i = 0; i < 16; i++) {
+		__get_user(insn, (unsigned char *)(regs->eip + i));
+		printk("%02x ", insn);
+	}
+#endif	
+	printk("\n");
+	show_regs(regs);
+}
+
+static int __init setup_print_fatal_signals(char *str)
+{
+	get_option (&str, &print_fatal_signals);
+
+	return 1;
+}
+
+__setup("print-fatal-signals=", setup_print_fatal_signals);
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
@@ -1737,6 +1765,11 @@ relock:
 		if (!signr)
 			break; /* will return 0 */
 
+		if ((signr == SIGSEGV) && print_fatal_signals) {
+			spin_unlock_irq(&current->sighand->siglock);
+			print_fatal_signal(regs, signr);
+			spin_lock_irq(&current->sighand->siglock);
+		}
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
@@ -1841,6 +1874,8 @@ relock:
 		 * Anything else is fatal, maybe with a core dump.
 		 */
 		current->flags |= PF_SIGNALED;
+		if (print_fatal_signals)
+			print_fatal_signal(regs, signr);
 		if (sig_kernel_coredump(signr) &&
 		    do_coredump((long)signr, signr, regs)) {
 			/*
--- linux/kernel/sysctl.c.orig	
+++ linux/kernel/sysctl.c	
@@ -65,6 +65,19 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 
+extern unsigned int vdso_enabled;
+
+int exec_shield = 1;
+
+static int __init setup_exec_shield(char *str)
+{
+        get_option (&str, &exec_shield);
+
+        return 1;
+}
+
+__setup("exec-shield=", setup_exec_shield);
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -268,6 +281,32 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "exec-shield",
+		.data		= &exec_shield,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "print-fatal-signals",
+		.data		= &print_fatal_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#if __i386__
+	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "vdso",
+		.data		= &vdso_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+	{
 		.ctl_name	= KERN_CORE_USES_PID,
 		.procname	= "core_uses_pid",
 		.data		= &core_uses_pid,
--- linux/mm/mmap.c.orig	
+++ linux/mm/mmap.c	
@@ -245,6 +245,8 @@ static inline void
 __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct rb_node *rb_parent)
 {
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(mm, vma->vm_end);
 	if (prev) {
 		vma->vm_next = prev->vm_next;
 		prev->vm_next = vma;
@@ -350,6 +352,8 @@ __vma_unlink(struct mm_struct *mm, struc
 	rb_erase(&vma->vm_rb, &mm->mm_rb);
 	if (mm->mmap_cache == vma)
 		mm->mmap_cache = prev;
+	if (vma->vm_flags & VM_EXEC)
+		arch_remove_exec_range(mm, vma->vm_end);
 }
 
 /*
@@ -619,6 +623,8 @@ struct vm_area_struct *vma_merge(struct 
 		} else					/* cases 2, 5, 7 */
 			vma_adjust(prev, prev->vm_start,
 				end, prev->vm_pgoff, NULL);
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(mm, prev->vm_end);
 		return prev;
 	}
 
@@ -755,7 +761,7 @@ unsigned long do_mmap_pgoff(struct file 
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
-	addr = get_unmapped_area(file, addr, len, pgoff, flags);
+	addr = get_unmapped_area(file, addr, len, pgoff, flags, prot & PROT_EXEC);
 	if (addr & ~PAGE_MASK)
 		return addr;
 
@@ -989,7 +995,7 @@ EXPORT_SYMBOL(do_mmap_pgoff);
 #ifndef HAVE_ARCH_UNMAPPED_AREA
 static inline unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+		unsigned long len, unsigned long pgoff, unsigned long flags, unsigned long exec)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -1034,12 +1040,12 @@ full_search:
 #else
 extern unsigned long
 arch_get_unmapped_area(struct file *, unsigned long, unsigned long,
-			unsigned long, unsigned long);
+			unsigned long, unsigned long, unsigned long);
 #endif	
 
 unsigned long
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+		unsigned long pgoff, unsigned long flags, unsigned long exec)
 {
 	if (flags & MAP_FIXED) {
 		unsigned long ret;
@@ -1071,7 +1077,7 @@ get_unmapped_area(struct file *file, uns
 		return file->f_op->get_unmapped_area(file, addr, len,
 						pgoff, flags);
 
-	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
+	return arch_get_unmapped_area(file, addr, len, pgoff, flags, exec);
 }
 
 EXPORT_SYMBOL(get_unmapped_area);
@@ -1149,6 +1155,14 @@ out:
 	return prev ? prev->vm_next : vma;
 }
 
+
+static int over_stack_limit(unsigned long sz)
+{
+	if (sz < EXEC_STACK_BIAS)
+		return 0;
+	return (sz - EXEC_STACK_BIAS) > current->rlim[RLIMIT_STACK].rlim_cur;
+}
+
 #ifdef CONFIG_STACK_GROWSUP
 /*
  * vma is the first one with address > vma->vm_end.  Have to extend vma.
@@ -1183,7 +1197,7 @@ int expand_stack(struct vm_area_struct *
 		return -ENOMEM;
 	}
 	
-	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (over_stack_limit(address - vma->vm_start) ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		anon_vma_unlock(vma);
@@ -1244,7 +1258,7 @@ int expand_stack(struct vm_area_struct *
 		return -ENOMEM;
 	}
 	
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (over_stack_limit(vma->vm_end - address) ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		anon_vma_unlock(vma);
@@ -1357,6 +1371,7 @@ no_mmaps:
 static void unmap_vma(struct mm_struct *mm, struct vm_area_struct *area)
 {
 	size_t len = area->vm_end - area->vm_start;
+	unsigned long old_end = area->vm_end;
 
 	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
 	if (area->vm_flags & VM_LOCKED)
@@ -1367,8 +1382,14 @@ static void unmap_vma(struct mm_struct *
 	if (area->vm_start >= TASK_UNMAPPED_BASE &&
 				area->vm_start < area->vm_mm->free_area_cache)
 	      area->vm_mm->free_area_cache = area->vm_start;
-
+	/*
+	 * Is this a new hole at the highest possible address?
+	 */
+	if (area->vm_start > area->vm_mm->non_executable_cache)
+		area->vm_mm->non_executable_cache = area->vm_start;
 	remove_vm_struct(area);
+	if (unlikely(area->vm_flags & VM_EXEC))
+		arch_remove_exec_range(mm, old_end);
 }
 
 /*
@@ -1477,10 +1498,14 @@ int split_vma(struct mm_struct * mm, str
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	if (new_below)
+	if (new_below) {
+		unsigned long old_end = vma->vm_end;
+
 		vma_adjust(vma, addr, vma->vm_end, vma->vm_pgoff +
 			((addr - new->vm_start) >> PAGE_SHIFT), new);
-	else
+		if (vma->vm_flags & VM_EXEC)
+			arch_remove_exec_range(mm, old_end);
+	} else
 		vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
 
 	return 0;
@@ -1688,6 +1713,7 @@ void exit_mmap(struct mm_struct *mm)
 	mm->rss = 0;
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
+	arch_flush_exec_range(mm);
 
 	spin_unlock(&mm->page_table_lock);
 
--- linux/mm/mprotect.c.orig	
+++ linux/mm/mprotect.c	
@@ -21,6 +21,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
@@ -113,8 +114,9 @@ mprotect_fixup(struct vm_area_struct *vm
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
 	struct mm_struct * mm = vma->vm_mm;
-	unsigned long charged = 0;
+	unsigned long charged = 0, old_end = vma->vm_end;
 	pgprot_t newprot;
+	unsigned int oldflags;
 	pgoff_t pgoff;
 	int error;
 
@@ -175,8 +177,11 @@ success:
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
 	 */
+	oldflags = vma->vm_flags;
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
+	if (oldflags & VM_EXEC)
+		arch_remove_exec_range(current->mm, old_end);
 	change_protection(vma, start, end, newprot);
 	return 0;
 
--- linux/mm/mremap.c.orig	
+++ linux/mm/mremap.c	
@@ -381,7 +381,8 @@ unsigned long do_mremap(unsigned long ad
 				map_flags |= MAP_SHARED;
 
 			new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-						vma->vm_pgoff, map_flags);
+					vma->vm_pgoff, map_flags,
+						vma->vm_flags & VM_EXEC);
 			ret = new_addr;
 			if (new_addr & ~PAGE_MASK)
 				goto out;
--- linux/mm/fremap.c.orig	
+++ linux/mm/fremap.c	
@@ -61,12 +61,6 @@ int install_page(struct mm_struct *mm, s
 	pmd_t *pmd;
 	pte_t pte_val;
 
-	/*
-	 * We use page_add_file_rmap below: if install_page is
-	 * ever extended to anonymous pages, this will warn us.
-	 */
-	BUG_ON(!page_mapping(page));
-
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 
