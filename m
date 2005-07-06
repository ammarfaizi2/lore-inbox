Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVGFC4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVGFC4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGFCqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:46:35 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:64664 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262051AbVGFCTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:23 -0400
Subject: [PATCH] [19/48] Suspend2 2.1.9.8 for 2.6.12: 510-version-specific-mac.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164411926@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 520-version-specific-x86_64.patch-old/arch/x86_64/kernel/asm-offsets.c 520-version-specific-x86_64.patch-new/arch/x86_64/kernel/asm-offsets.c
--- 520-version-specific-x86_64.patch-old/arch/x86_64/kernel/asm-offsets.c	2005-06-20 11:46:49.000000000 +1000
+++ 520-version-specific-x86_64.patch-new/arch/x86_64/kernel/asm-offsets.c	2005-07-04 23:14:19.000000000 +1000
@@ -62,8 +62,10 @@ int main(void)
 	       offsetof (struct rt_sigframe32, uc.uc_mcontext));
 	BLANK();
 #endif
+#ifdef CONFIG_PM
 	DEFINE(pbe_address, offsetof(struct pbe, address));
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
 	DEFINE(pbe_next, offsetof(struct pbe, next));
+#endif
 	return 0;
 }
diff -ruNp 520-version-specific-x86_64.patch-old/arch/x86_64/kernel/Makefile 520-version-specific-x86_64.patch-new/arch/x86_64/kernel/Makefile
--- 520-version-specific-x86_64.patch-old/arch/x86_64/kernel/Makefile	2005-06-20 11:46:49.000000000 +1000
+++ 520-version-specific-x86_64.patch-new/arch/x86_64/kernel/Makefile	2005-07-04 23:14:19.000000000 +1000
@@ -22,6 +22,7 @@ obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o m
 		genapic.o genapic_cluster.o genapic_flat.o
 obj-$(CONFIG_PM)		+= suspend.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
+obj-$(CONFIG_SUSPEND2)		+= suspend2.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
diff -ruNp 520-version-specific-x86_64.patch-old/arch/x86_64/kernel/suspend.c 520-version-specific-x86_64.patch-new/arch/x86_64/kernel/suspend.c
--- 520-version-specific-x86_64.patch-old/arch/x86_64/kernel/suspend.c	2004-11-03 21:53:44.000000000 +1100
+++ 520-version-specific-x86_64.patch-new/arch/x86_64/kernel/suspend.c	2005-07-04 23:14:19.000000000 +1000
@@ -26,6 +26,7 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/proto.h>
+#include <asm/i387.h>
 
 struct saved_context saved_context;
 
@@ -35,6 +36,8 @@ unsigned long saved_context_r08, saved_c
 unsigned long saved_context_r12, saved_context_r13, saved_context_r14, saved_context_r15;
 unsigned long saved_context_eflags;
 
+void fix_processor_context(void);
+
 void __save_processor_state(struct saved_context *ctxt)
 {
 	kernel_fpu_begin();
diff -ruNp 520-version-specific-x86_64.patch-old/arch/x86_64/mm/init.c 520-version-specific-x86_64.patch-new/arch/x86_64/mm/init.c
--- 520-version-specific-x86_64.patch-old/arch/x86_64/mm/init.c	2005-06-20 11:46:49.000000000 +1000
+++ 520-version-specific-x86_64.patch-new/arch/x86_64/mm/init.c	2005-07-04 23:14:19.000000000 +1000
@@ -618,3 +618,22 @@ int in_gate_area_no_task(unsigned long a
 {
 	return (addr >= VSYSCALL_START) && (addr < VSYSCALL_END);
 }
+
+#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_SUSPEND2)
+/*
+ * Software suspend & friends need this for resume because things like the intel-agp
+ * driver might have split up a kernel 4MB mapping.
+ */
+char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+	__attribute__ ((aligned (PAGE_SIZE)));
+
+static inline void save_pg_dir(void)
+{
+	memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
+}
+#else
+static inline void save_pg_dir(void)
+{
+}
+#endif
+
diff -ruNp 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend2.h 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend2.h
--- 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend2.h	1970-01-01 10:00:00.000000000 +1000
+++ 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend2.h	2005-07-05 23:56:15.000000000 +1000
@@ -0,0 +1,432 @@
+ /*
+  * Copyright 2005 Nigel Cunningham <nigel@suspend2.net>
+  * Based on code
+  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+  * Based on code
+  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+  */
+#include <linux/irq.h>
+#include <asm/desc.h>
+#include <asm/i387.h>
+#include <asm/tlbflush.h>
+#include <asm/desc.h>
+#include <asm/suspend.h>
+#undef inline
+#define inline	__inline__ __attribute__((always_inline))
+
+/* image of the saved processor states */
+struct suspend2_saved_context {
+	unsigned long eax, ebx, ecx, edx;
+	unsigned long esp, ebp, esi, edi;
+	unsigned long r8, r9, r10, r11;
+	unsigned long r12, r13, r14, r15;
+
+#if 0
+	u16 es, fs, gs, ss;
+	u32 cr0, cr2, cr3, cr4;
+	u16 gdt_pad;
+	u16 gdt_limit;
+	u32 gdt_base;
+	u16 idt_pad;
+	u16 idt_limit;
+	u32 idt_base;
+	u16 ldt;
+	u16 tss;
+	u32 tr;
+	u32 safety;
+	u32 return_address;
+#endif
+	unsigned long eflags;
+} __attribute__((packed));
+
+extern struct suspend2_saved_context suspend2_saved_context;	/* temporary storage */
+
+#ifdef CONFIG_MTRR
+/* MTRR functions */
+extern int mtrr_save(void);
+extern int mtrr_restore_one_cpu(void);
+extern void mtrr_restore_finish(void);
+#else
+#define mtrr_save() do { } while(0)
+#define mtrr_restore_one_cpu() do { } while(0)
+#define mtrr_restore_finish() do { } while(0)
+#endif
+		  
+#ifndef CONFIG_SMP
+#undef cpu_clear
+#define cpu_clear(a, b) do { } while(0)
+#endif
+
+extern struct suspend2_saved_context suspend2_saved_context;	/* temporary storage */
+
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make _too_
+ * many assumptions about the layout of the stack this far down.) Also, the 
+ * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void suspend2_save_processor_context(void)
+{
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%rsp, (%0)" : "=m" (suspend2_saved_context.esp));
+	asm volatile ("movl %%rax, (%0)" : "=m" (suspend2_saved_context.eax));
+	asm volatile ("movl %%rbx, (%0)" : "=m" (suspend2_saved_context.ebx));
+	asm volatile ("movl %%rcx, (%0)" : "=m" (suspend2_saved_context.ecx));
+	asm volatile ("movl %%rdx, (%0)" : "=m" (suspend2_saved_context.edx));
+	asm volatile ("movl %%rbp, (%0)" : "=m" (suspend2_saved_context.ebp));
+	asm volatile ("movl %%rsi, (%0)" : "=m" (suspend2_saved_context.esi));
+	asm volatile ("movl %%rdi, (%0)" : "=m" (suspend2_saved_context.edi));
+	asm volatile ("movl %%r8, (%0)" : "=m" (suspend2_saved_context.r8));
+	asm volatile ("movl %%r9, (%0)" : "=m" (suspend2_saved_context.r9));
+	asm volatile ("movl %%r10, (%0)" : "=m" (suspend2_saved_context.r10));
+	asm volatile ("movl %%r11, (%0)" : "=m" (suspend2_saved_context.r11));
+	asm volatile ("movl %%r12, (%0)" : "=m" (suspend2_saved_context.r12));
+	asm volatile ("movl %%r13, (%0)" : "=m" (suspend2_saved_context.r13));
+	asm volatile ("movl %%r14, (%0)" : "=m" (suspend2_saved_context.r14));
+	asm volatile ("movl %%r15, (%0)" : "=m" (suspend2_saved_context.r15));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (suspend2_saved_context.eflags));
+
+	kernel_fpu_begin();
+
+	/*
+	 * descriptor tables
+	 */
+	asm volatile ("sgdt (%0)" : "=m" (suspend2_saved_context.gdt_limit));
+	asm volatile ("sidt (%0)" : "=m" (suspend2_saved_context.idt_limit));
+	asm volatile ("sldt (%0)" : "=m" (suspend2_saved_context.ldt));
+	asm volatile ("str (%0)"  : "=m" (suspend2_saved_context.tr));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%ds, %0" : "=r" (suspend2_saved_context.ds));
+	asm volatile ("movw %%es, %0" : "=r" (suspend2_saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (suspend2_saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (suspend2_saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (suspend2_saved_context.ss));
+
+	rdmsrl(MSR_FS_BASE, suspend2_saved_context.fs_base);
+	rdmsrl(MSR_GS_BASE, suspend2_saved_context.gs_base);
+	rdmsrl(MSR_KERNEL_GS_BASE, suspend2_saved_context.gs_kernel_base);
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (suspend2_saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (suspend2_saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (suspend2_saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (suspend2_saved_context.cr4));
+
+}
+
+static void fix_processor_context(void)
+{
+	int nr = _smp_processor_id();
+	struct tss_struct * t = &per_cpu(init_tss,nr);
+
+	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+	cpu_gdt_table[nr][GDT_ENTRY_TSS].type = 9;
+
+	syscall_init();                         /* This sets MSR_*STAR and related */
+	load_TR_desc();
+	load_LDT(&current->active_mm->context);	/* This does lldt */
+
+	/*
+	 * Now maybe reload the debug registers
+	 */
+	if (current->thread.debugreg7){
+                loaddebug(&current->thread, 0);
+                loaddebug(&current->thread, 1);
+                loaddebug(&current->thread, 2);
+                loaddebug(&current->thread, 3);
+                /* no 4 and 5 */
+                loaddebug(&current->thread, 6);
+                loaddebug(&current->thread, 7);
+	}
+}
+
+static void do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+        kernel_fpu_end();
+	mxcsr_feature_mask_init();
+}
+
+/*
+ * restore_processor_context
+ * 
+ * Restore the processor context as it was before we went to sleep
+ * - descriptor tables
+ * - control registers
+ * - segment registers
+ * - flags
+ * 
+ * Note that it is critical that this function is declared inline.  
+ * It was separated out from restore_state to make that function
+ * a little clearer, but it needs to be inlined because we won't have a
+ * stack when we get here (so we can't push a return address).
+ */
+static inline void restore_processor_context(void)
+{
+	/*
+	 * first restore %ds, so we can access our data properly
+	 */
+	//asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
+	
+	__flush_tlb_global(); /* INLINE? */
+
+	asm volatile ("movl	$24, %eax");
+	asm volatile ("movl	%eax, %ds");
+
+	/*
+	 * the other general registers
+	 *
+	 * note that even though gcc has constructs to specify memory 
+	 * input into certain registers, it will try to be too smart
+	 * and save them at the beginning of the function.  This is esp.
+	 * bad since we don't have a stack set up when we enter, and we 
+	 * want to preserve the values on exit. So, we set them manually.
+	 */
+	asm volatile ("movl %0, %%rsp" :: "m" (suspend2_saved_context.esp));
+	asm volatile ("movl %0, %%rbp" :: "m" (suspend2_saved_context.ebp));
+	//asm volatile ("movl %0, %%eax" :: "m" (suspend2_saved_context.eax));
+	asm volatile ("movl %0, %%rbx" :: "m" (suspend2_saved_context.ebx));
+	asm volatile ("movl %0, %%rcx" :: "m" (suspend2_saved_context.ecx));
+	asm volatile ("movl %0, %%rdx" :: "m" (suspend2_saved_context.edx));
+	asm volatile ("movl %0, %%rsi" :: "m" (suspend2_saved_context.esi));
+	asm volatile ("movl %0, %%rdi" :: "m" (suspend2_saved_context.edi));
+	asm volatile ("movl %0, %%r8" :: "m" (suspend2_saved_context.r8));
+	asm volatile ("movl %0, %%r9" :: "m" (suspend2_saved_context.r9));
+	asm volatile ("movl %0, %%r10" :: "m" (suspend2_saved_context.r10));
+	asm volatile ("movl %0, %%r11" :: "m" (suspend2_saved_context.r11));
+	asm volatile ("movl %0, %%r12" :: "m" (suspend2_saved_context.r12));
+	asm volatile ("movl %0, %%r13" :: "m" (suspend2_saved_context.r13));
+	asm volatile ("movl %0, %%r14" :: "m" (suspend2_saved_context.r14));
+	asm volatile ("movl %0, %%r15" :: "m" (suspend2_saved_context.r15));
+
+	/*
+	 * the flags
+	 */
+	asm volatile ("pushl %0 ; popfl" :: "m" (suspend2_saved_context.eflags));
+	
+	asm volatile ("xorq	%rax, %rax");
+
+	/*
+	 * control registers
+	 */
+	asm volatile ("movl %0, %%cr4" :: "r" (suspend2_saved_context.cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (suspend2_saved_context.cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (suspend2_saved_context.cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (suspend2_saved_context.cr0));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %0, %%ds" :: "r" (suspend2_saved_context.ds));
+	asm volatile ("movw %0, %%es" :: "r" (suspend2_saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (suspend2_saved_context.fs));
+	load_gs_index(suspend2_saved_context.gs);
+	asm volatile ("movw %0, %%ss" :: "r" (suspend2_saved_context.ss));
+
+	wrmsrl(MSR_FS_BASE, suspend2_saved_context.fs_base);
+	wrmsrl(MSR_GS_BASE, suspend2_saved_context.gs_base);
+	wrmsrl(MSR_KERNEL_GS_BASE, suspend2_saved_context.gs_kernel_base);
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 * ltr is done in fix_processor_context().
+	 */
+
+	asm volatile ("lgdt (%0)" :: "m" (suspend2_saved_context.gdt_limit));
+	asm volatile ("lidt (%0)" :: "m" (suspend2_saved_context.idt_limit));
+	asm volatile ("lldt (%0)" :: "m" (suspend2_saved_context.ldt));
+
+	fix_processor_context();
+
+	do_fpu_end();
+}
+
+#if defined(CONFIG_SUSPEND2) || defined(CONFIG_SMP)
+extern atomic_t suspend_cpu_counter __nosavedata;
+extern unsigned char * my_saved_context __nosavedata;
+static unsigned long c_loops_per_jiffy_ref[NR_CPUS] __nosavedata;
+#endif
+
+#ifdef CONFIG_SUSPEND2
+#ifndef CONFIG_SMP
+extern unsigned long loops_per_jiffy;
+volatile static unsigned long cpu_khz_ref __nosavedata = 0;
+#endif
+
+/* 
+ * APIC support: These routines save the APIC
+ * configuration for the CPU on which they are
+ * being executed
+ */
+extern void suspend_apic_save_state(void);
+extern void suspend_apic_reload_state(void);
+
+#ifdef CONFIG_SMP
+/* ------------------------------------------------
+ * BEGIN Irq affinity code, based on code from LKCD.
+ *
+ * IRQ affinity support:
+ * Save and restore IRQ affinities, and set them
+ * all to CPU 0.
+ *
+ * Section between dashes taken from LKCD code.
+ * Perhaps we should be working toward a shared library
+ * of such routines for kexec, lkcd, software suspend
+ * and whatever other similar projects there are?
+ */
+
+extern irq_desc_t irq_desc[];
+extern cpumask_t irq_affinity[];
+extern cpumask_t saved_affinity[NR_IRQS];
+
+/*
+ * Routine to save the old irq affinities and change affinities of all irqs to
+ * the dumping cpu.
+ */
+static void save_and_set_irq_affinity(void)
+{
+	int i;
+	int cpu = _smp_processor_id();
+
+	memcpy(saved_affinity, irq_affinity, NR_IRQS * sizeof(cpumask_t));
+	for (i = 0; i < NR_IRQS; i++) {
+		if (irq_desc[i].handler == NULL)
+			continue;
+		irq_affinity[i] = cpumask_of_cpu(cpu);
+		if (irq_desc[i].handler->set_affinity != NULL)
+			irq_desc[i].handler->set_affinity(i, irq_affinity[i]);
+	}
+}
+
+/*
+ * Restore old irq affinities.
+ */
+static void reset_irq_affinity(void)
+{
+	int i;
+
+	memcpy(irq_affinity, saved_affinity, NR_IRQS * sizeof(cpumask_t));
+	for (i = 0; i < NR_IRQS; i++) {
+		if (irq_desc[i].handler == NULL)
+			continue;
+		if (irq_desc[i].handler->set_affinity != NULL)
+			irq_desc[i].handler->set_affinity(i, irq_affinity[i]);
+	}
+}
+
+/*
+ * END of IRQ affinity code, based on LKCD code.
+ * -----------------------------------------------------------------
+ */
+#else
+#define save_and_set_irq_affinity() do { } while(0)
+#define reset_irq_affinity() do { } while(0)
+#endif
+
+static inline void suspend2_pre_copy(void)
+{
+	/*
+	 * Save the irq affinities before we freeze the
+	 * other processors!
+	 */
+	save_and_set_irq_affinity();
+	mtrr_save();
+}
+
+static inline void suspend2_post_copy(void)
+{
+}
+
+static inline void suspend2_pre_copyback(void)
+{
+
+	/* Send all IRQs to CPU 0. We will replace the saved affinities
+	 * with the suspend-time ones when we copy the original kernel
+	 * back in place
+	 */
+	save_and_set_irq_affinity();
+	
+	c_loops_per_jiffy_ref[_smp_processor_id()] = current_cpu_data.loops_per_jiffy;
+#ifndef CONFIG_SMP
+	cpu_khz_ref = cpu_khz;
+	c_loops_per_jiffy_ref[_smp_processor_id()] = loops_per_jiffy;
+#endif
+	
+	/* We want to run from swsusp_pg_dir, since swsusp_pg_dir is stored in constant
+	 * place in memory 
+	 */
+
+        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));
+	__asm__( "leaq	init_level4_pgt(%rip),%rax");
+	__asm__( "subq	$__START_KERNEL_map,%rax");
+	__asm__( "movq	%rax,%cr3");
+}
+
+static inline void suspend2_restore_processor_context(void)
+{
+	restore_processor_context();
+}
+	
+static inline void suspend2_flush_caches(void)
+{
+	cpu_clear(_smp_processor_id(), per_cpu(cpu_tlbstate, _smp_processor_id()).active_mm->cpu_vm_mask);
+	wbinvd();
+	__flush_tlb_all();
+	
+}
+
+static inline void suspend2_post_copyback(void)
+{
+	mtrr_restore_one_cpu();
+
+	/* Get other CPUs to restore their contexts and flush their tlbs. */
+	clear_suspend_state(SUSPEND_FREEZE_SMP);
+	
+	do {
+		cpu_relax();
+		barrier();
+	} while (atomic_read(&suspend_cpu_counter));
+	mtrr_restore_finish();
+	
+	BUG_ON(!irqs_disabled());
+
+	/* put the irq affinity tables back */
+	reset_irq_affinity();
+	
+	current_cpu_data.loops_per_jiffy = c_loops_per_jiffy_ref[_smp_processor_id()];
+#ifndef CONFIG_SMP
+	loops_per_jiffy = c_loops_per_jiffy_ref[_smp_processor_id()];
+	cpu_khz = cpu_khz_ref;
+#endif
+}
+
+#endif
diff -ruNp 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend.h 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend.h
--- 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend.h	2005-06-20 11:47:28.000000000 +1000
+++ 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend.h	2005-07-04 23:14:19.000000000 +1000
@@ -43,7 +43,7 @@ extern unsigned long saved_context_eflag
                        : /* no output */ \
                        :"r" ((thread)->debugreg##register))
 
-extern void fix_processor_context(void);
+/* extern void fix_processor_context(void); */
 
 #ifdef CONFIG_ACPI_SLEEP
 extern unsigned long saved_eip;

