Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTI2JMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTI2JMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:12:49 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:45441 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S262960AbTI2JMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:12:00 -0400
Message-ID: <3F77F752.7020404@externet.hu>
Date: Mon, 29 Sep 2003 11:11:46 +0200
From: Boszormenyi Zoltan <zboszor@externet.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.2.1) Gecko/20030225
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
Content-Type: multipart/mixed;
 boundary="------------040802030503060409050001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802030503060409050001
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

this is a version against -test6-mm1.
Three differences from -test6-G3:
- Makefile EXTRAVERSION
- include/asm-i386/mmu.h trivial reject fix
- fs/proc/array.c, {task|current}->[e]uid replaced
   with tsk_[e]uid({task|current}) to compile.

The system is RH9, all errata fixes applied.
X does not start up. After
echo "0|1" >/proc/sys/kernel/exec-shield
it starts.

echo "0" >/proc/sys/kernel/exec-shield-randomize
does not make a difference when exec-shield is 2.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

--------------040802030503060409050001
Content-Type: text/plain;
 name="exec-shield-2.6.0-test6mm1-G3-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="exec-shield-2.6.0-test6mm1-G3-1"

diff -ur linux-2.6.0-test6-mm1/arch/i386/kernel/process.c linux-2.6.0-test6-mm1-exec-shield/arch/i386/kernel/process.c
--- linux-2.6.0-test6-mm1/arch/i386/kernel/process.c	2003-09-29 10:10:48.180773923 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/arch/i386/kernel/process.c	2003-09-29 09:12:15.000000000 +0200
@@ -37,9 +37,12 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/ldt.h>
@@ -512,6 +515,8 @@
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
 	__unlazy_fpu(prev_p);
+	if (next_p->mm)
+		load_user_cs_desc(cpu, next_p->mm);
 
 #ifdef CONFIG_X86_HIGH_ENTRY
 	/*
@@ -813,3 +818,305 @@
 	return 0;
 }
 
+/*
+ * In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
+ * by the processes running on the same package. One thing we can do
+ * is to shuffle the initial stack for them.
+ *
+ * (Plus, wiggling the stack a bit also makes it a bit harder for
+ * attackers to guess the stack pointer.)
+ */
+
+static inline unsigned int get_random_int(void)
+{
+	unsigned int jitter, tsc = 0;
+
+	if (!exec_shield_randomize)
+		return 0;
+	/*
+	 * This is a pretty fast call, so no performance worries:
+	 */
+       	get_random_bytes(&jitter, sizeof(jitter));
+#ifdef CONFIG_X86_HAS_TSC
+	rdtscl(tsc);
+#endif
+	jitter += current->pid + (int)&tsc + jiffies + tsc;
+
+	return jitter;
+}
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (current->flags & PF_RELOCEXEC)
+		sp -= ((get_random_int() % 65536) << 4);
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
+static unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len)
+{
+	unsigned long range = end - len - start;
+	if (end <= start + len)
+		return 0;
+	return PAGE_ALIGN(get_random_int() % range + start);
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
+		addr = randomize_range(SHLIB_BASE, 0x01000000, len);
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
+			/*
+			 * Up until the brk area we randomize addresses
+			 * as much as possible:
+			 */
+			if (ascii_shield && (addr >= 0x01000000)) {
+				tmp = randomize_range(0x01000000, mm->brk, len);
+				vma = find_vma(mm, tmp);
+				if (TASK_SIZE - len >= tmp &&
+				    (!vma || tmp + len <= vma->vm_start))
+					return tmp;
+			}
+			/*
+			 * Ok, randomization didnt work out - return
+			 * the result of the linear search:
+			 */
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
+ * Generate random brk address between 128MB and 196MB. (if the layout
+ * allows it.)
+ */
+void randomize_brk(unsigned long old_brk)
+{
+	unsigned long new_brk, range_start, range_end;
+
+	range_start = 0x08000000;
+	if (current->mm->brk >= range_start)
+		range_start = current->mm->brk;
+	range_end = range_start + 0x02000000;
+	new_brk = randomize_range(range_start, range_end, 0);
+	if (new_brk)
+		current->mm->brk = new_brk;
+}
+
+/*
+ * Top of mmap area (just below the process stack).
+ * leave an at least ~128 MB hole. Randomize it.
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
+	gap = arch_align_stack(gap) & PAGE_MASK;
+
+	return TASK_SIZE - gap;
+}
+
diff -ur linux-2.6.0-test6-mm1/arch/i386/kernel/setup.c linux-2.6.0-test6-mm1-exec-shield/arch/i386/kernel/setup.c
--- linux-2.6.0-test6-mm1/arch/i386/kernel/setup.c	2003-09-29 10:10:48.185773643 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/arch/i386/kernel/setup.c	2003-09-29 09:12:15.000000000 +0200
@@ -949,6 +949,14 @@
 
 __setup("noreplacement", noreplacement_setup); 
 
+static int __init setup_exec_shield(char *str)
+{
+	get_option (&str, &exec_shield);
+
+	return 1;
+}
+__setup("exec-shield=", setup_exec_shield);
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
diff -ur linux-2.6.0-test6-mm1/arch/i386/kernel/traps.c linux-2.6.0-test6-mm1-exec-shield/arch/i386/kernel/traps.c
--- linux-2.6.0-test6-mm1/arch/i386/kernel/traps.c	2003-09-29 10:10:48.205772521 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/arch/i386/kernel/traps.c	2003-09-29 09:12:15.000000000 +0200
@@ -435,6 +435,10 @@
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
 
+/*
+ * the original non-exec stack patch was written by
+ * Solar Designer <solar at openwall.com>. Thanks!
+ */
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
 	if (regs->eflags & VM_MASK)
@@ -443,6 +447,31 @@
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
 
+	/*
+	 * lazy-check for CS validity on exec-shield binaries:
+	 */
+	if (current->mm) {
+		int cpu = smp_processor_id();
+		struct desc_struct *desc1, *desc2;
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
diff -ur linux-2.6.0-test6-mm1/include/linux/elf.h linux-2.6.0-test6-mm1-exec-shield/include/linux/elf.h
--- linux-2.6.0-test6-mm1/include/linux/elf.h	2003-09-29 10:10:52.508531237 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/linux/elf.h	2003-09-29 09:12:15.475754585 +0200
@@ -35,6 +35,8 @@
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
 
+#define PT_GNU_STACK		(PT_LOOS + 0x474e551)
+
 /* These constants define the different elf file types */
 #define ET_NONE   0
 #define ET_REL    1
diff -ur linux-2.6.0-test6-mm1/include/linux/binfmts.h linux-2.6.0-test6-mm1-exec-shield/include/linux/binfmts.h
--- linux-2.6.0-test6-mm1/include/linux/binfmts.h	2003-09-08 21:50:06.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/linux/binfmts.h	2003-09-29 09:12:15.000000000 +0200
@@ -58,7 +58,7 @@
 extern void remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
-extern int setup_arg_pages(struct linux_binprm * bprm);
+extern int setup_arg_pages(struct linux_binprm * bprm, int exec_stack);
 extern int copy_strings(int argc,char __user * __user * argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
diff -ur linux-2.6.0-test6-mm1/include/linux/mm.h linux-2.6.0-test6-mm1-exec-shield/include/linux/mm.h
--- linux-2.6.0-test6-mm1/include/linux/mm.h	2003-09-29 10:10:52.597526246 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/linux/mm.h	2003-09-29 09:12:15.497753352 +0200
@@ -515,7 +515,7 @@
 extern void build_mmap_rb(struct mm_struct *);
 extern void exit_mmap(struct mm_struct *);
 
-extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
 extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
diff -ur linux-2.6.0-test6-mm1/include/linux/sched.h linux-2.6.0-test6-mm1-exec-shield/include/linux/sched.h
--- linux-2.6.0-test6-mm1/include/linux/sched.h	2003-09-29 10:10:52.770516546 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/linux/sched.h	2003-09-29 09:12:15.505752903 +0200
@@ -31,6 +31,9 @@
 #include <linux/percpu.h>
 
 struct exec_domain;
+extern int exec_shield;
+extern int exec_shield_randomize;
+extern int print_fatal_signals;
 
 /*
  * cloning flags:
@@ -188,6 +191,8 @@
 	struct rb_root mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
 	unsigned long free_area_cache;		/* first hole */
+	unsigned long non_executable_cache;	/* last hole top */
+	unsigned long mmap_top;			/* top of mmap area */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
@@ -603,6 +608,8 @@
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_RELOCEXEC	0x00400000	/* relocate shared libraries */
+
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
diff -ur linux-2.6.0-test6-mm1/include/linux/resource.h linux-2.6.0-test6-mm1-exec-shield/include/linux/resource.h
--- linux-2.6.0-test6-mm1/include/linux/resource.h	2003-09-08 21:49:53.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/linux/resource.h	2003-09-29 09:12:15.508752735 +0200
@@ -52,8 +52,11 @@
 /*
  * Limit the stack by to some sane default: root can always
  * increase this limit if needed..  8MB seems reasonable.
+ *
+ * (2MB more to cover randomization effects.)
  */
-#define _STK_LIM	(8*1024*1024)
+#define _STK_LIM	(10*1024*1024)
+#define STACK_BIAS	(2*1024*1024)
 
 /*
  * Due to binary compatibility, the actual resource numbers
diff -ur linux-2.6.0-test6-mm1/include/asm-i386/elf.h linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/elf.h
--- linux-2.6.0-test6-mm1/include/asm-i386/elf.h	2003-09-08 21:50:16.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/elf.h	2003-09-29 09:12:15.519752118 +0200
@@ -117,7 +117,8 @@
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+/* child inherits the personality of the parent */
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
@@ -139,8 +140,8 @@
 
 #define ARCH_DLINFO						\
 do {								\
-		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+		/*NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);*/	\
+		/*NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);*/	\
 } while (0)
 
 /*
@@ -186,4 +187,7 @@
 
 #endif
 
+#define __HAVE_ARCH_RANDOMIZE_BRK
+extern void randomize_brk(unsigned long old_brk);
+
 #endif
diff -ur linux-2.6.0-test6-mm1/include/asm-i386/mmu.h linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/mmu.h
--- linux-2.6.0-test6-mm1/include/asm-i386/mmu.h	2003-09-29 10:10:51.958562077 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/mmu.h	2003-09-29 09:14:26.414411987 +0200
@@ -7,6 +7,9 @@
  * we put the segment information here.
  *
  * cpu_vm_mask is used to optimize ldt flushing.
+ *
+ * exec_limit is used to track the range PROT_EXEC
+ * mappings span.
  */
 
 #define MAX_LDT_PAGES 16
@@ -15,6 +18,8 @@
 	int size;
 	struct semaphore sem;
 	struct page *ldt_pages[MAX_LDT_PAGES];
+	struct desc_struct user_cs;
+	unsigned long exec_limit;
 } mm_context_t;
 
 #endif
diff -ur linux-2.6.0-test6-mm1/include/asm-i386/page.h linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/page.h
--- linux-2.6.0-test6-mm1/include/asm-i386/page.h	2003-09-29 10:10:51.963561797 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/page.h	2003-09-29 09:12:15.523751894 +0200
@@ -142,8 +142,10 @@
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS \
+		(VM_READ | VM_WRITE | \
+			((current->flags & PF_RELOCEXEC) ? 0 : VM_EXEC) | \
+				VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif /* __KERNEL__ */
 
diff -ur linux-2.6.0-test6-mm1/include/asm-i386/pgalloc.h linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/pgalloc.h
--- linux-2.6.0-test6-mm1/include/asm-i386/pgalloc.h	2003-09-08 21:49:52.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/pgalloc.h	2003-09-29 09:12:15.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/fixmap.h>
+#include <asm/desc.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
 
@@ -52,4 +53,20 @@
 
 #define check_pgt_cache()	do { } while (0)
 
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
+#define HAVE_ARCH_UNMAPPED_AREA 1
+
 #endif /* _I386_PGALLOC_H */
diff -ur linux-2.6.0-test6-mm1/include/asm-i386/processor.h linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/processor.h
--- linux-2.6.0-test6-mm1/include/asm-i386/processor.h	2003-09-29 10:10:51.969561461 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/processor.h	2003-09-29 09:12:15.537751109 +0200
@@ -294,7 +294,15 @@
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
@@ -470,6 +478,7 @@
 	regs->xcs = __USER_CS;					\
 	regs->eip = new_eip;					\
 	regs->esp = new_esp;					\
+	load_user_cs_desc(smp_processor_id(), current->mm);	\
 } while (0)
 
 /* Forward declaration, a strange C thing */
diff -ur linux-2.6.0-test6-mm1/include/asm-i386/system.h linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/system.h
--- linux-2.6.0-test6-mm1/include/asm-i386/system.h	2003-09-08 21:49:51.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/include/asm-i386/system.h	2003-09-29 09:12:15.549750436 +0200
@@ -55,6 +55,10 @@
 	 "0" (limit) \
         ); } while(0)
 
+struct desc_struct;
+
+extern void set_desc_limit(struct desc_struct *desc, unsigned long limit);
+
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
 #define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
 
diff -ur linux-2.6.0-test6-mm1/fs/proc/array.c linux-2.6.0-test6-mm1-exec-shield/fs/proc/array.c
--- linux-2.6.0-test6-mm1/fs/proc/array.c	2003-09-29 10:10:51.388594039 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/fs/proc/array.c	2003-09-29 09:59:56.000000000 +0200
@@ -317,7 +317,10 @@
 		up_read(&mm->mmap_sem);
 	}
 
-	wchan = get_wchan(task);
+	wchan = 0;
+	if (tsk_uid(current) == tsk_uid(task) || tsk_euid(current) == tsk_uid(task) ||
+							capable(CAP_SYS_NICE))
+		wchan = get_wchan(task);
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
diff -ur linux-2.6.0-test6-mm1/fs/proc/base.c linux-2.6.0-test6-mm1-exec-shield/fs/proc/base.c
--- linux-2.6.0-test6-mm1/fs/proc/base.c	2003-09-29 10:10:51.393593759 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/fs/proc/base.c	2003-09-29 09:12:15.000000000 +0200
@@ -108,7 +108,7 @@
 	E(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
+	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUSR),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
@@ -129,7 +129,7 @@
 	E(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO),
 	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
+	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUSR),
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
diff -ur linux-2.6.0-test6-mm1/fs/binfmt_aout.c linux-2.6.0-test6-mm1-exec-shield/fs/binfmt_aout.c
--- linux-2.6.0-test6-mm1/fs/binfmt_aout.c	2003-09-29 10:07:37.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/fs/binfmt_aout.c	2003-09-29 09:12:15.000000000 +0200
@@ -308,7 +308,8 @@
 	current->mm->brk = ex.a_bss +
 		(current->mm->start_brk = N_BSSADDR(ex));
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
-
+	/* unlimited stack is larger than TASK_SIZE */
+	current->mm->non_executable_cache = current->mm->mmap_top;
 	current->mm->rss = 0;
 	current->mm->mmap = NULL;
 	compute_creds(bprm);
@@ -413,7 +414,7 @@
 
 	set_brk(current->mm->start_brk, current->mm->brk);
 
-	retval = setup_arg_pages(bprm); 
+	retval = setup_arg_pages(bprm, 1); 
 	if (retval < 0) { 
 		/* Someone check-me: is this error path enough? */ 
 		send_sig(SIGKILL, current, 0); 
diff -ur linux-2.6.0-test6-mm1/fs/binfmt_elf.c linux-2.6.0-test6-mm1-exec-shield/fs/binfmt_elf.c
--- linux-2.6.0-test6-mm1/fs/binfmt_elf.c	2003-09-29 10:10:51.078611422 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/fs/binfmt_elf.c	2003-09-29 09:12:15.000000000 +0200
@@ -45,7 +45,7 @@
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
-static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
+static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int, unsigned int);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
 #ifndef elf_addr_t
@@ -125,7 +125,7 @@
 static void
 create_elf_tables(struct linux_binprm *bprm, struct elfhdr * exec,
 		int interp_aout, unsigned long load_addr,
-		unsigned long interp_load_addr)
+		unsigned long interp_load_addr, int exec_stack)
 {
 	unsigned long p = bprm->p;
 	int argc = bprm->argc;
@@ -149,20 +149,8 @@
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
 		u_platform = (elf_addr_t *) STACK_ALLOC(p, len);
 		__copy_to_user(u_platform, k_platform, len);
@@ -260,17 +248,25 @@
 
 #ifndef elf_map
 
-static unsigned long elf_map(struct file *filep, unsigned long addr,
-			struct elf_phdr *eppnt, int prot, int type)
+
+static unsigned long elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type, unsigned int total_size)
 {
 	unsigned long map_addr;
+	unsigned int size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	if (total_size)
+		size = total_size;
+
+	addr = ELF_PAGESTART(addr);
+
+
 
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
+	map_addr = do_mmap(filep, ELF_PAGESTART(addr), size, prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
 	up_write(&current->mm->mmap_sem);
-	return(map_addr);
+
+	return map_addr;
 }
 
 #endif /* !elf_map */
@@ -290,6 +286,7 @@
 	int load_addr_set = 0;
 	unsigned long last_bss = 0, elf_bss = 0;
 	unsigned long error = ~0UL;
+	unsigned int total_size;
 	int retval, i, size;
 
 	/* First of all, some simple consistency checks */
@@ -325,6 +322,15 @@
 		goto out_close;
 
 	eppnt = elf_phdata;
+	total_size = 0;
+	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++)
+		if (eppnt->p_type == PT_LOAD)
+			total_size += PAGE_ALIGN(eppnt->p_filesz +
+					ELF_PAGEOFFSET(eppnt->p_vaddr));
+	if ((int)total_size <= 0)
+		goto out_close;
+
+	eppnt = elf_phdata;
 	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
 	  if (eppnt->p_type == PT_LOAD) {
 	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
@@ -339,7 +345,8 @@
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;
 
-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type, total_size);
+	    total_size = 0;
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;
 
@@ -461,6 +468,8 @@
 	struct elfhdr interp_elf_ex;
   	struct exec interp_ex;
 	char passed_fileno[6];
+	int exec_stack, relocexec, old_relocexec = current->flags & PF_RELOCEXEC;
+	unsigned int total_size;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -573,6 +582,30 @@
 		elf_ppnt++;
 	}
 
+	relocexec = 0;
+	exec_stack = 1;
+
+	if (current->personality == PER_LINUX)
+	switch (exec_shield) {
+	case 1:
+		elf_ppnt = elf_phdata;
+		for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
+			if (elf_ppnt->p_type == PT_GNU_STACK) {
+				if (!(elf_ppnt->p_flags & PF_X))
+					exec_stack = 0;
+				current->flags |= PF_RELOCEXEC;
+				relocexec = PF_RELOCEXEC;
+				break;
+			}
+		break;
+
+	case 2:
+		exec_stack = 0;
+		current->flags |= PF_RELOCEXEC;
+		relocexec = PF_RELOCEXEC;
+		break;
+	}
+
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
 		interpreter_type = INTERPRETER_ELF | INTERPRETER_AOUT;
@@ -621,6 +654,16 @@
 	retval = flush_old_exec(bprm);
 	if (retval)
 		goto out_free_dentry;
+	current->flags |= relocexec;
+
+#ifdef CONFIG_X86
+	/*
+	 * In the exec-shield-disabled case turn off the CS limit
+	 * completely:
+	 */
+	if (!exec_shield)
+		arch_add_exec_range(current->mm, -1);
+#endif
 
 	/* OK, This is the point of no return */
 	current->mm->start_data = 0;
@@ -637,7 +680,8 @@
 	   change some of these later */
 	current->mm->rss = 0;
 	current->mm->free_area_cache = TASK_UNMAPPED_BASE;
-	retval = setup_arg_pages(bprm);
+	current->mm->non_executable_cache = current->mm->mmap_top;
+	retval = setup_arg_pages(bprm, exec_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
@@ -646,9 +690,21 @@
 	current->mm->start_stack = bprm->p;
 
 	/* Now we do a little grungy work by mmaping the ELF image into
-	   the correct location in memory.  At this point, we assume that
-	   the image should be loaded at fixed address, not at a variable
-	   address. */
+	   the correct location in memory.
+	 
+	   We first calculate the total mapping size, which the first
+	   mmap request uses - after that point we use MAP_FIXED to
+	   overmap the existing range. This ensures that a continuous
+	   VM region is allocated - even if VM addresses are randomized.
+	 */
+
+	total_size = 0;
+	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++)
+		if (elf_ppnt->p_type == PT_LOAD)
+			total_size += PAGE_ALIGN(elf_ppnt->p_filesz +
+					ELF_PAGEOFFSET(elf_ppnt->p_vaddr));
+	if ((int)total_size <= 0)
+		goto out_free_dentry;
 
 	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
@@ -680,16 +736,13 @@
 		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
-		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (elf_ex.e_type == ET_EXEC || load_addr_set)
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex.e_type == ET_DYN) {
-			/* Try and get dynamic programs out of the way of the default mmap
-			   base, as well as whatever program they might try to exec.  This
-			   is because the brk will follow the loader, and is not movable.  */
-			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-		}
+		else if (elf_ex.e_type == ET_DYN)
+			load_bias = 0;
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
+		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags, total_size);
+		total_size = 0;
 		if (BAD_ADDR(error))
 			continue;
 
@@ -763,7 +816,7 @@
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
 	create_elf_tables(bprm, &elf_ex, (interpreter_type == INTERPRETER_AOUT),
-			load_addr, interp_load_addr);
+			load_addr, interp_load_addr, exec_stack);
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
@@ -780,6 +833,10 @@
 
 	padzero(elf_bss);
 
+#ifdef __HAVE_ARCH_RANDOMIZE_BRK
+	if (current->flags & PF_RELOCEXEC)
+		randomize_brk(elf_brk);
+#endif
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
 		   and some applications "depend" upon this behavior.
@@ -828,6 +885,8 @@
 	sys_close(elf_exec_fileno);
 out_free_ph:
 	kfree(elf_phdata);
+	current->flags &= ~PF_RELOCEXEC;
+	current->flags |= old_relocexec;
 	goto out;
 }
 
diff -ur linux-2.6.0-test6-mm1/fs/exec.c linux-2.6.0-test6-mm1-exec-shield/fs/exec.c
--- linux-2.6.0-test6-mm1/fs/exec.c	2003-09-29 10:10:51.155607104 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/fs/exec.c	2003-09-29 09:12:15.000000000 +0200
@@ -335,7 +335,7 @@
 	return;
 }
 
-int setup_arg_pages(struct linux_binprm *bprm)
+int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -388,7 +388,12 @@
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
@@ -419,7 +424,10 @@
 		mpnt->vm_end = STACK_TOP;
 #endif
 		mpnt->vm_page_prot = protection_map[VM_STACK_FLAGS & 0x7];
-		mpnt->vm_flags = VM_STACK_FLAGS;
+		if (executable_stack)
+			mpnt->vm_flags = VM_STACK_FLAGS | VM_MAYEXEC | VM_EXEC;
+		else
+			mpnt->vm_flags = (VM_STACK_FLAGS | VM_MAYEXEC) & ~VM_EXEC;
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
@@ -802,6 +810,7 @@
 	}
 	current->comm[i] = '\0';
 
+	current->flags &= ~PF_RELOCEXEC;
 	flush_thread();
 
 	if (bprm->e_uid != tsk_euid(current) ||
@@ -858,8 +867,13 @@
 
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
@@ -867,8 +881,13 @@
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
diff -ur linux-2.6.0-test6-mm1/fs/binfmt_som.c linux-2.6.0-test6-mm1-exec-shield/fs/binfmt_som.c
--- linux-2.6.0-test6-mm1/fs/binfmt_som.c	2003-09-08 21:50:02.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/fs/binfmt_som.c	2003-09-29 09:12:15.000000000 +0200
@@ -254,7 +254,7 @@
 
 	set_binfmt(&som_format);
 	compute_creds(bprm);
-	setup_arg_pages(bprm);
+	setup_arg_pages(bprm, 1);
 
 	create_som_tables(bprm);
 
diff -ur linux-2.6.0-test6-mm1/kernel/fork.c linux-2.6.0-test6-mm1-exec-shield/kernel/fork.c
--- linux-2.6.0-test6-mm1/kernel/fork.c	2003-09-29 10:10:52.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/kernel/fork.c	2003-09-29 09:12:15.000000000 +0200
@@ -359,6 +359,9 @@
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
+#ifdef __HAVE_ARCH_MMAP_TOP
+		mm->mmap_top = mmap_top();
+#endif
 		return mm;
 	}
 	free_mm(mm);
diff -ur linux-2.6.0-test6-mm1/kernel/signal.c linux-2.6.0-test6-mm1-exec-shield/kernel/signal.c
--- linux-2.6.0-test6-mm1/kernel/signal.c	2003-09-29 10:10:52.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/kernel/signal.c	2003-09-29 09:12:15.000000000 +0200
@@ -1527,6 +1527,32 @@
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+int print_fatal_signals = 0;
+
+static void print_fatal_signal(struct pt_regs *regs, int signr)
+{
+	int i;
+	unsigned char insn;
+
+	printk("%s/%d: potentially unexpected fatal signal %d.\n",
+		current->comm, current->pid, signr);
+	printk("code at %08lx: ", regs->eip);
+	for (i = 0; i < 16; i++) {
+		__get_user(insn, (unsigned char *)(regs->eip + i));
+		printk("%02x ", insn);
+	}
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
 
@@ -1718,6 +1744,8 @@
 		if (!signr)
 			break; /* will return 0 */
 
+		if ((signr == SIGSEGV) && print_fatal_signals)
+			print_fatal_signal(regs, signr);
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
@@ -1822,6 +1850,8 @@
 		 * Anything else is fatal, maybe with a core dump.
 		 */
 		current->flags |= PF_SIGNALED;
+		if (print_fatal_signals)
+			print_fatal_signal(regs, signr);
 		if (sig_kernel_coredump(signr) &&
 		    do_coredump((long)signr, signr, regs)) {
 			/*
diff -ur linux-2.6.0-test6-mm1/kernel/sysctl.c linux-2.6.0-test6-mm1-exec-shield/kernel/sysctl.c
--- linux-2.6.0-test6-mm1/kernel/sysctl.c	2003-09-29 10:10:52.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/kernel/sysctl.c	2003-09-29 09:12:15.000000000 +0200
@@ -60,6 +60,9 @@
 extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
 
+int exec_shield = 2;
+int exec_shield_randomize = 1;
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -255,6 +258,30 @@
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
+		.procname	= "exec-shield-randomize",
+		.data		= &exec_shield_randomize,
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
+	{
 		.ctl_name	= KERN_CORE_USES_PID,
 		.procname	= "core_uses_pid",
 		.data		= &core_uses_pid,
diff -ur linux-2.6.0-test6-mm1/mm/mmap.c linux-2.6.0-test6-mm1-exec-shield/mm/mmap.c
--- linux-2.6.0-test6-mm1/mm/mmap.c	2003-09-29 10:07:42.827167929 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/mm/mmap.c	2003-09-29 09:12:15.000000000 +0200
@@ -23,6 +23,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/desc.h>
 
 /*
  * WARNING: the debugging will use recursive algorithms so never enable this
@@ -252,6 +253,8 @@
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(mm, vma->vm_end);
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	__vma_link_file(vma);
@@ -404,6 +407,11 @@
 			return 1;
 		}
 		spin_unlock(lock);
+		/*
+		 * Just extended 'prev':
+		 */
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(mm, prev->vm_end);
 		if (need_up)
 			up(&inode->i_mapping->i_shared_sem);
 		return 1;
@@ -469,7 +477,7 @@
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
-	addr = get_unmapped_area(file, addr, len, pgoff, flags);
+	addr = get_unmapped_area(file, addr, len, pgoff, flags, prot & PROT_EXEC);
 	if (addr & ~PAGE_MASK)
 		return addr;
 
@@ -695,7 +703,7 @@
 #ifndef HAVE_ARCH_UNMAPPED_AREA
 static inline unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+		unsigned long len, unsigned long pgoff, unsigned long flags, unsigned long exec)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -740,12 +748,12 @@
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
@@ -776,7 +784,7 @@
 		return file->f_op->get_unmapped_area(file, addr, len,
 						pgoff, flags);
 
-	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
+	return arch_get_unmapped_area(file, addr, len, pgoff, flags, exec);
 }
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
@@ -877,7 +885,7 @@
 		return -ENOMEM;
 	}
 	
-	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (address - vma->vm_start > (current->rlim[RLIMIT_STACK].rlim_cur + STACK_BIAS) ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
@@ -931,7 +939,7 @@
 		return -ENOMEM;
 	}
 	
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (vma->vm_end - address > (current->rlim[RLIMIT_STACK].rlim_cur + STACK_BIAS) ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
@@ -1054,8 +1062,15 @@
 	if (area->vm_start >= TASK_UNMAPPED_BASE &&
 				area->vm_start < area->vm_mm->free_area_cache)
 	      area->vm_mm->free_area_cache = area->vm_start;
+	/*
+	 * Is this a new hole at the highest possible address?
+	 */
+	if (area->vm_start > area->vm_mm->non_executable_cache)
+		area->vm_mm->non_executable_cache = area->vm_start;
 
 	remove_shared_vm_struct(area);
+	if (unlikely(area->vm_flags & VM_EXEC))
+		arch_remove_exec_range(mm, area->vm_end);
 
 	if (area->vm_ops && area->vm_ops->close)
 		area->vm_ops->close(area);
@@ -1154,9 +1169,13 @@
 		vma->vm_start = addr;
 		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
 	} else {
+		unsigned long old_end = vma->vm_end;
+
 		vma->vm_end = addr;
 		new->vm_start = addr;
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
+		if (vma->vm_flags & VM_EXEC)
+			arch_remove_exec_range(mm, old_end);
 	}
 
 	if (new->vm_file)
@@ -1387,6 +1406,7 @@
 	mm->rss = 0;
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
+	arch_flush_exec_range(mm);
 
 	spin_unlock(&mm->page_table_lock);
 
diff -ur linux-2.6.0-test6-mm1/mm/mprotect.c linux-2.6.0-test6-mm1-exec-shield/mm/mprotect.c
--- linux-2.6.0-test6-mm1/mm/mprotect.c	2003-09-29 10:07:42.829167817 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/mm/mprotect.c	2003-09-29 09:12:15.000000000 +0200
@@ -134,6 +134,8 @@
 		prev->vm_end = end;
 		__vma_unlink(mm, vma, prev);
 		spin_unlock(&mm->page_table_lock);
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(current->mm, prev->vm_end);
 
 		kmem_cache_free(vm_area_cachep, vma);
 		mm->map_count--;
@@ -147,6 +149,8 @@
 	prev->vm_end = end;
 	vma->vm_start = end;
 	spin_unlock(&mm->page_table_lock);
+	if (prev->vm_flags & VM_EXEC)
+		arch_add_exec_range(current->mm, prev->vm_end);
 	return 1;
 }
 
@@ -213,6 +217,8 @@
 	vma->vm_page_prot = newprot;
 	spin_unlock(&mm->page_table_lock);
 success:
+	if (vma->vm_flags & VM_EXEC)
+		arch_add_exec_range(current->mm, vma->vm_end);
 	change_protection(vma, start, end, newprot);
 	return 0;
 
@@ -324,6 +330,8 @@
 
 		kmem_cache_free(vm_area_cachep, next);
 		prev->vm_mm->map_count--;
+		if (prev->vm_flags & VM_EXEC)
+			arch_add_exec_range(current->mm, prev->vm_end);
 	}
 out:
 	up_write(&current->mm->mmap_sem);
diff -ur linux-2.6.0-test6-mm1/mm/mremap.c linux-2.6.0-test6-mm1-exec-shield/mm/mremap.c
--- linux-2.6.0-test6-mm1/mm/mremap.c	2003-09-08 21:50:06.000000000 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/mm/mremap.c	2003-09-29 09:12:15.000000000 +0200
@@ -424,7 +424,8 @@
 				map_flags |= MAP_SHARED;
 
 			new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-						vma->vm_pgoff, map_flags);
+					vma->vm_pgoff, map_flags,
+						vma->vm_flags & VM_EXEC);
 			ret = new_addr;
 			if (new_addr & ~PAGE_MASK)
 				goto out;
diff -ur linux-2.6.0-test6-mm1/Makefile linux-2.6.0-test6-mm1-exec-shield/Makefile
--- linux-2.6.0-test6-mm1/Makefile	2003-09-29 10:10:53.016502752 +0200
+++ linux-2.6.0-test6-mm1-exec-shield/Makefile	2003-09-29 09:13:09.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test6-mm1
+EXTRAVERSION = -test6-mm1-exec-shield-nptl
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

--------------040802030503060409050001--

