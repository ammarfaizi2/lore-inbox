Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUBRHhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUBRHhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:37:32 -0500
Received: from [211.167.76.68] ([211.167.76.68]:54222 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S263564AbUBRHhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:37:15 -0500
Date: Wed, 18 Feb 2004 15:35:48 +0800
From: Hugang <hugang@soulinfo.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: ppc suspend rewrite using inline.
Message-Id: <20040218153548.2690e905@localhost>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__18_Feb_2004_15_35_48_+0800_r4v+yoyKpEhgAAz0"
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__18_Feb_2004_15_35_48_+0800_r4v+yoyKpEhgAAz0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ben:

I has finished rewriten the suspend code by inline, The swsusp2 works
fine without any problem, But pmdisk can't works, The problem that's,
when resume the current is not same as suspend.

I think the code can reuse by sleep.

I think turn off mmu copyback page is important, but I has looked x86
resume code, it do not. 

Please take a look.

thanks.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Wed__18_Feb_2004_15_35_48_+0800_r4v+yoyKpEhgAAz0
Content-Type: text/plain;
 name="ppc_pmdisk_asm_inline.diff"
Content-Disposition: attachment;
 filename="ppc_pmdisk_asm_inline.diff"
Content-Transfer-Encoding: 7bit

--- orig/arch/ppc/kernel/signal.c
+++ mod/arch/ppc/kernel/signal.c
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -564,6 +565,14 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		signr = 0;
+		ret = regs->gpr[3];
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -588,6 +597,7 @@
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
+no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
--- orig/arch/ppc/kernel/vmlinux.lds.S
+++ mod/arch/ppc/kernel/vmlinux.lds.S
@@ -72,6 +72,12 @@
     CONSTRUCTORS
   }
 
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
--- orig/arch/ppc/Kconfig
+++ mod/arch/ppc/Kconfig
@@ -193,6 +193,8 @@
 
 	  If in doubt, say Y here.
 
+source kernel/power/Kconfig
+
 source arch/ppc/platforms/4xx/Kconfig
 
 config PPC64BRIDGE
--- orig/arch/ppc/Makefile
+++ mod/arch/ppc/Makefile
@@ -40,6 +40,7 @@
 core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
 core-$(CONFIG_APUS)		+= arch/ppc/amiga/
+core-$(CONFIG_PM)       += arch/ppc/power/
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_8260)		+= arch/ppc/8260_io/
--- orig/include/linux/suspend.h
+++ mod/include/linux/suspend.h
@@ -1,9 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
 #include <asm/suspend.h>
-#endif
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/config.h>
--- /dev/null	2004-01-09 16:49:41.000000000 +0800
+++ new-files-archive/arch/ppc/power/Makefile	2004-02-18 15:17:38.000000000 +0800
@@ -0,0 +1 @@
+obj-$(CONFIG_PM_DISK) += pmdisk.o cpu.o #cpu_data.o
--- /dev/null	2004-01-09 16:49:41.000000000 +0800
+++ new-files-archive/arch/ppc/power/cpu.c	2004-02-18 15:17:38.000000000 +0800
@@ -0,0 +1,81 @@
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/tty.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/adb.h>
+#include <linux/cuda.h>
+#include <linux/pmu.h>
+#include <linux/irq.h>
+#include <linux/root_dev.h>
+#include <linux/suspend.h>
+
+#include <asm/suspend.h>
+#include <asm/mmu_context.h>
+
+#define DEBUG
+
+#ifdef DEBUG
+#define dprintk(fmt, arg...) printk(fmt, ## arg)
+#else
+#define dprintk(fmt, arg...)
+#endif
+
+extern void enable_kernel_altivec(void);
+
+unsigned long cpu_reg_save_mem[0x74 + 80];
+
+/* pmu power manager part */
+static inline void do_pmu_suspend(void)
+{
+	dprintk(KERN_DEBUG "suspend pmu\n");	
+	pmu_suspend();
+	dprintk(KERN_DEBUG ".\n");
+}
+
+static inline void do_pmu_resume(void)
+{
+	dprintk(KERN_DEBUG "resume pmu\n");	
+	pmu_resume();	
+	dprintk(KERN_DEBUG ".\n");
+}
+
+void save_processor_state(void)
+{
+	dprintk(KERN_DEBUG "save processor state\n");
+#ifdef CONFIG_PREEMPT
+	preempt_disable();
+#endif
+	pmu_suspend();
+	dprintk(KERN_DEBUG ".\n");
+
+	dprintk(KERN_DEBUG "current is %p", current);
+}
+
+void restore_processor_state(void)
+{
+	dprintk(KERN_DEBUG "current is %p", current);
+
+	dprintk(KERN_DEBUG "seting context\n");
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context, current->active_mm->pgd);
+
+	printk(KERN_DEBUG "do pmu resume\n");
+	do_pmu_resume();
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif
+	dprintk(KERN_DEBUG "enable kernel fp\n");
+	enable_kernel_fp();
+	dprintk(KERN_DEBUG ".\n");
+}
+
+EXPORT_SYMBOL(save_processor_state);
+EXPORT_SYMBOL(restore_processor_state);
--- /dev/null	2004-01-09 16:49:41.000000000 +0800
+++ new-files-archive/arch/ppc/power/pmdisk.c	2004-02-18 15:17:38.000000000 +0800
@@ -0,0 +1,75 @@
+/*
+ * Suspend-to-disk ppc part 
+ *
+ */
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+
+extern suspend_pagedir_t *pm_pagedir_nosave __nosavedata;
+extern int pmdisk_pages __nosavedata;
+
+extern int pmdisk_suspend(void);
+extern int pmdisk_resume(void);
+
+/* in PowerPC, we have lots registers, so this function has safed */
+static inline void 
+pmdisk_copyback(void)
+{
+	register suspend_pagedir_t *pg_dir;
+	register int pages, i;
+	register void *p, *q;
+
+	p = (void*)__pa(&pm_pagedir_nosave);
+	pg_dir = (suspend_pagedir_t *)(__pa(*(unsigned long *)(p)));
+
+	q = (void*)__pa(&pmdisk_pages);
+	pages = *(int*)(q);
+
+	for (i = 0; i <= pages; i++, pg_dir++) {
+		register unsigned long loop;
+		register unsigned long *orig, *cur;
+
+		orig = (unsigned long *)__pa(pg_dir->orig_address);
+		cur = (unsigned long *)__pa(pg_dir->address);
+
+		for (loop = 0; loop < ((PAGE_SIZE / sizeof(*cur)) / 4); loop++) {
+			register long r0, r1, r2, r3;
+			r0 = *(cur);
+			r1 = *(cur + 1);
+			r2 = *(cur + 2);
+			r3 = *(cur + 3);
+			cur += 4;
+			*(orig) = r0;
+			*(orig + 1) = r1;
+			*(orig + 2) = r2;
+			*(orig + 3) = r3;
+			orig += 4;
+		}
+	} 
+}
+
+int 
+pmdisk_arch_suspend(int resume)
+{
+	cpu_context_to_stack();
+
+	if (!resume) {
+		cpu_context_to_mem();
+		//cpu_context_from_mem();
+		cpu_context_from_mem_end();
+		cpu_context_from_stack();
+		return pmdisk_suspend();
+	}
+
+	prepare_copyback();
+
+	pmdisk_copyback();
+	post_copyback();
+
+	cpu_context_from_mem();
+	cpu_context_from_mem_end();
+	cpu_context_from_stack();
+
+	return (pmdisk_resume()); 
+}
--- /dev/null	2004-01-09 16:49:41.000000000 +0800
+++ new-files-archive/include/asm-ppc/suspend.h	2004-02-18 15:17:38.000000000 +0800
@@ -0,0 +1,236 @@
+#ifndef _PPC_SUSPEND_H
+#define _PPC_SUSPEND_H
+
+extern void save_processor_state(void);
+extern void restore_processor_state(void);
+
+#ifdef CONFIG_PM_DISK
+#define __flush_tlb_global flush_tlb_all
+extern int pmdisk_arch_suspend(int resume);
+static inline int arch_prepare_suspend(void)
+{
+	return (0);
+}
+#endif /* CONFIG_PM_DISK */
+
+static inline void flush_tlb_all(void)
+{
+	/* Flush all TLBs */
+	__asm__ __volatile__(
+			"lis 4, 0x1000\n"
+		"1:  addic. 4,4,-0x1000\n"
+			"tlbie 4\n"
+			"blt 1b\n"
+			"sync\n");
+}
+
+static inline void cpu_context_to_mem(void)
+{
+	__asm__ __volatile__(
+			"lis 11, cpu_reg_save_mem@h\n"
+			"ori 11, 11, cpu_reg_save_mem@l\n"
+			"mflr 0\n"
+			"stw 0, 112(11)\n"
+			"mfcr 0\n"
+			"stw 0, 108(11)\n"
+			"stw 1, 0(11)\n"
+			"stw 2, 104(11)\n"
+			"stmw 12, 116(11)\n"
+			/* save msr & sdr1 */
+			"mfmsr 4\n"
+			"stw 4, 8(11)\n"
+			"mfsdr1 4\n"
+			"stw 4, 12(11)\n"
+			/* get a stable timebase and save it */
+		"1: mftbu 4\n"
+			"stw 4, 96(11)\n"
+			"mftbl 5\n"
+			"stw 5, 100(11)\n"
+			"mftbu 3\n"
+			"cmpw 3, 4\n"
+			"bne 1b\n"
+			/* save sprgs */
+			"mfsprg  4,0\n"
+			"stw 4,16(11)\n"
+			"mfsprg  4,1\n"
+		  	"stw 4,20(11)\n"
+		    "mfsprg  4,2\n"
+			"stw 4,24(11)\n"
+			"mfsprg  4,3\n"
+			"stw 4,28(11)\n");
+}
+
+static inline void cpu_context_from_mem(void)
+{
+	__asm__ __volatile__(
+			"lis 11, cpu_reg_save_mem@h\n"
+			"ori 11, 11, cpu_reg_save_mem@l\n"
+			/* tophys */
+			"addis   11,11,16384\n"
+    /* Restore the BATs, and SDR1.  Then we can turn on the MMU. 
+	 * This is a bit hairy as we are running out of those BATs,
+	 * but first, our code is probably in the icache, and we are 
+	 * writing the same value to the BAT, so that should be fine,
+	 * though a better solution will have to be found long-term 
+	 */ 
+			"lwz 4, 12(11)\n"
+			"mtsdr1 4\n"
+			"lwz 4, 16(11)\n"
+			"mtsprg 0,4\n"
+			"lwz 4, 20(11)\n"
+			"mtsprg 1,4\n"
+			"lwz 4, 24(11)\n"
+			"mtsprg 2,4\n"
+			"lwz 4, 28(11)\n"
+			"mtsprg 3,4\n"
+			
+			"li 4, 0\n"
+			"mtspr 568, 4\n"
+			"mtspr 569, 4\n"
+			"mtspr 570, 4\n"
+			"mtspr 571, 4\n"
+			"mtspr 572, 4\n"
+			"mtspr 573, 4\n"
+			"mtspr 574, 4\n"
+			"mtspr 565, 4\n"
+			"mtspr 560, 4\n"
+			"mtspr 561, 4\n"
+			"mtspr 562, 4\n"
+			"mtspr 563, 4\n"
+			"mtspr 564, 4\n"
+			"mtspr 565, 4\n"
+			"mtspr 566, 4\n"
+			"mtspr 567, 4\n"
+			/* flush all tlbs */
+			"lis 4, 4096\n"
+		"1:	 addic 4,4,-4096\n"
+			"tlbie 4\n"
+			"blt 1b\n"
+			"sync\n"
+			/* restore msr and trun on the mmu */
+			"lwz 3,8(11)\n"
+			/*"twi 31,0,0\n"*/
+			"bl turn_on_mmu\n"
+			/* to virt */
+			"addis   11,11,-16384\n"
+			"li 3, 0\n"
+			"mttbl 3\n"
+			"lwz 3, 96(11)\n"
+			"lwz 4, 100(11)\n"
+			"mttbu 3\n"
+			"mttbl 4\n"
+			"lwz 12, 116(11)\n"
+			"lwz 2, 104(11)\n"
+			"lwz 0, 108(11)\n"
+			"mtcr 0\n"
+			"lwz 1, 0(11)\n"
+			"lwz 4, 112(11)\n"
+			"b end_turn_on_mmu\n"
+		"turn_on_mmu:\n"
+			"mflr 4\n"
+			"mtsrr0 4\n"
+			"mtsrr1 3\n"
+			"sync\n"
+			"isync\n"
+			"rfi\n"
+		"end_turn_on_mmu:\n");
+}
+static inline void cpu_context_from_mem_end(void)
+{
+	__asm__ __volatile__(
+			"lis 11, cpu_reg_save_mem@h\n"
+			"ori 11, 11, cpu_reg_save_mem@l\n"
+			"lmw 12,116(11)\n"
+			"lwz 2,104(11)\n"
+			"lwz 1,0(11)\n"
+			"lwz 0,108(11)\n"
+			"mtcr 0\n");
+}
+static inline void cpu_context_to_stack(void)
+{
+	__asm__ __volatile__(
+			/*"addi	1,1,16\n"	 undo the C save stack */
+			"mflr   0\n"
+			"stw 0, 4(1)\n"
+			"stwu 1, -(0x74 + 80)(1)\n"
+			"mfcr 0\n"
+			"stw 0, 0x6c(1)\n"
+			"stw 2, 0x68(1)\n"
+			"stmw 12, 0x74(1)\n"
+			/* save sprgs */
+			"mfsprg 4, 0\n"
+			"stw 4, 0x10(1)\n"
+			"mfsprg 4, 1\n"
+			"stw 4, (0x10 + 4)(1)\n"
+			"mfsprg 4, 2\n"
+			"stw 4, (0x10 + 8)(1)\n"
+			"mfsprg 4, 3\n"
+			"stw 4, (0x10 + 12)(1)\n");
+}
+
+static inline void cpu_context_from_stack(void)
+{
+	__asm__ __volatile__(
+			"lwz 4, 0x10(1)\n"
+			"mtsprg 0, 4\n"
+			"lwz 4, (0x10 + 4)(1)\n"
+			"mtsprg 1, 4\n"
+			"lwz 4, (0x10 + 8)(1)\n"
+			"mtsprg 2, 4\n"
+			"lwz 4, (0x10 + 12)(1)\n"
+			"mtsprg 3, 4\n"
+			"lwz 2, 0x68(1)\n"
+			"lwz 0, 0x6c(1)\n"
+			"mtcr 0\n"
+			"lmw 12, 0x74(1)\n"
+			"addi 1,1,(0x74 + 80)\n"
+			"lwz 0, 4(1)\n"
+			"mtlr 0\n"
+			/*"blr\n" */);
+}
+/* Disable MSR:DR to make sure we don't take a TLB or
+ * hash miss during the copy, as our hash table will
+ * for a while be unuseable. For .text, we assume we are
+ * covered by a BAT. This works only for non-G5 at this
+ * point. G5 will need a better approach, possibly using
+ * a small temporary hash table filled with large mappings,
+ * disabling the MMU completely isn't a good option for
+ * performance reasons.
+ * (Note that 750's may have the same performance issue as
+ * the G5 in this case, we should investigate using moving
+ * BATs for these CPUs)
+ */
+static inline void prepare_copyback(void)
+{
+	__asm__ __volatile__(
+			"dssall\n"
+			"sync\n"
+			"mfmsr 0\n"
+			"sync \n"
+			"rlwinm 0,0,0,28,26\n"	/* clean MSR_DR */
+			"mtmsr 0\n"
+			"sync\n"
+			"isync\n");
+}
+
+static inline void post_copyback(void)
+{
+	__asm__ __volatile__(
+		    "lis 3,0x0002\n"
+			"mtctr   3\n"
+			"li  3, 0\n"
+		"1:  lwz 0,0(3)\n"
+			"addi    3,3,0x0020\n"
+			"bdnz    1b\n"
+			"isync\n"
+			"sync\n"
+			/* Now flush those cache lines */ 
+			"lis 0, 0x2\n"
+			"mtctr 3\n"
+			"li 3,0\n"
+		"1:	 dcbf 0,3\n"
+			"addi 3,3,0x20\n"
+			"bdnz 1b\n");
+}
+
+#endif

--Multipart=_Wed__18_Feb_2004_15_35_48_+0800_r4v+yoyKpEhgAAz0--
