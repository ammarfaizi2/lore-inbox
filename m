Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbUKXNyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUKXNyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKXNx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:53:57 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28311 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262701AbUKXN3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:29:10 -0500
Subject: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101296166.5805.279.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lowlevel code for i386. This is the code responsible for saving and
restoring CPU state, and for restoring the original kernel (except LRU
pages, which are loaded afterwards).

diff -ruN 700-suspend2-lowlevel-old/arch/i386/power/Makefile 700-suspend2-lowlevel-new/arch/i386/power/Makefile
--- 700-suspend2-lowlevel-old/arch/i386/power/Makefile	2004-11-03 21:52:57.000000000 +1100
+++ 700-suspend2-lowlevel-new/arch/i386/power/Makefile	2004-11-04 16:27:40.000000000 +1100
@@ -1,2 +1,4 @@
-obj-$(CONFIG_PM)		+= cpu.o
+CFLAGS_suspend2.o = -O0
+
+obj-$(CONFIG_PM)		+= cpu.o suspend2.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
diff -ruN 700-suspend2-lowlevel-old/arch/i386/power/suspend2.c 700-suspend2-lowlevel-new/arch/i386/power/suspend2.c
--- 700-suspend2-lowlevel-old/arch/i386/power/suspend2.c	1970-01-01 10:00:00.000000000 +1000
+++ 700-suspend2-lowlevel-new/arch/i386/power/suspend2.c	2004-11-17 19:43:08.000000000 +1100
@@ -0,0 +1,639 @@
+ /*
+  * Copyright 2003-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+  * Based on code
+  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+  * Based on code
+  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+  */
+#include <linux/init.h>
+#include <linux/version.h>
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <asm/desc.h>
+#include <asm/i387.h>
+#include <asm/apic.h>
+#include <asm/tlbflush.h>
+#include "../../../kernel/power/suspend.h"
+
+extern volatile struct suspend2_core_ops * suspend2_core_ops;
+extern struct pagedir pagedir_resume;
+extern volatile int suspend_io_time[2][2];
+extern char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+                  __attribute__ ((aligned (PAGE_SIZE)));
+#include <asm/processor.h>
+#undef inline
+#define inline	__inline__ __attribute__((always_inline))
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
+/* image of the saved processor states */
+struct suspend2_saved_context {
+	u32 eax, ebx, ecx, edx;
+	u32 esp, ebp, esi, edi;
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
+	u32 eflags;
+} __attribute__((packed));
+
+#ifdef CONFIG_SMP
+static struct suspend2_saved_context suspend2_saved_contexts[NR_CPUS];
+#else
+#undef cpu_clear
+#define cpu_clear(a, b) do { } while(0)
+#endif
+static struct suspend2_saved_context suspend2_saved_context;	/* temporary storage */
+
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
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
+static inline void save_processor_context(void)
+{
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
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, (%0)" : "=m" (suspend2_saved_context.esp));
+	asm volatile ("movl %%eax, (%0)" : "=m" (suspend2_saved_context.eax));
+	asm volatile ("movl %%ebx, (%0)" : "=m" (suspend2_saved_context.ebx));
+	asm volatile ("movl %%ecx, (%0)" : "=m" (suspend2_saved_context.ecx));
+	asm volatile ("movl %%edx, (%0)" : "=m" (suspend2_saved_context.edx));
+	asm volatile ("movl %%ebp, (%0)" : "=m" (suspend2_saved_context.ebp));
+	asm volatile ("movl %%esi, (%0)" : "=m" (suspend2_saved_context.esi));
+	asm volatile ("movl %%edi, (%0)" : "=m" (suspend2_saved_context.edi));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%es, %0" : "=r" (suspend2_saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (suspend2_saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (suspend2_saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (suspend2_saved_context.ss));
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (suspend2_saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (suspend2_saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (suspend2_saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (suspend2_saved_context.cr4));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (suspend2_saved_context.eflags));
+}
+
+static void fix_processor_context(void)
+{
+	int nr = smp_processor_id();
+	struct tss_struct * t = &per_cpu(init_tss,nr);
+
+	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+        per_cpu(cpu_gdt_table,nr)[GDT_ENTRY_TSS].b &= 0xfffffdff;
+
+	load_TR_desc();
+
+	load_LDT(&current->active_mm->context);	/* This does lldt */
+
+	/*
+	 * Now maybe reload the debug registers
+	 */
+	if (current->thread.debugreg[7]){
+                loaddebug(&current->thread, 0);
+                loaddebug(&current->thread, 1);
+                loaddebug(&current->thread, 2);
+                loaddebug(&current->thread, 3);
+                /* no 4 and 5 */
+                loaddebug(&current->thread, 6);
+                loaddebug(&current->thread, 7);
+	}
+
+}
+
+static void do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+        kernel_fpu_end();
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
+	asm volatile (".align 4");
+	asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
+
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
+	asm volatile ("movw %0, %%es" :: "r" (suspend2_saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (suspend2_saved_context.fs));
+	asm volatile ("movw %0, %%gs" :: "r" (suspend2_saved_context.gs));
+	asm volatile ("movw %0, %%ss" :: "r" (suspend2_saved_context.ss));
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
+	asm volatile ("movl %0, %%esp" :: "m" (suspend2_saved_context.esp));
+	asm volatile ("movl %0, %%ebp" :: "m" (suspend2_saved_context.ebp));
+	asm volatile ("movl %0, %%eax" :: "m" (suspend2_saved_context.eax));
+	asm volatile ("movl %0, %%ebx" :: "m" (suspend2_saved_context.ebx));
+	asm volatile ("movl %0, %%ecx" :: "m" (suspend2_saved_context.ecx));
+	asm volatile ("movl %0, %%edx" :: "m" (suspend2_saved_context.edx));
+	asm volatile ("movl %0, %%esi" :: "m" (suspend2_saved_context.esi));
+	asm volatile ("movl %0, %%edi" :: "m" (suspend2_saved_context.edi));
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 * ltr is done i fix_processor_context().
+	 */
+
+	asm volatile ("lgdt (%0)" :: "m" (suspend2_saved_context.gdt_limit));
+	asm volatile ("lidt (%0)" :: "m" (suspend2_saved_context.idt_limit));
+	asm volatile ("lldt (%0)" :: "m" (suspend2_saved_context.ldt));
+
+	fix_processor_context();
+
+	/*
+	 * the flags
+	 */
+	asm volatile ("pushl %0 ; popfl" :: "m" (suspend2_saved_context.eflags));
+
+	do_fpu_end();
+}
+
+#if defined(CONFIG_SOFTWARE_SUSPEND2) || defined(CONFIG_SMP)
+volatile static int loop __nosavedata = 0;
+extern atomic_t suspend_cpu_counter __nosavedata;
+volatile unsigned char * my_saved_context __nosavedata;
+volatile static unsigned long c_loops_per_jiffy_ref[NR_CPUS] __nosavedata;
+#endif
+
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+/* Local variables for do_suspend2_lowlevel */
+volatile static int state1 __nosavedata = 0;
+volatile static int state2 __nosavedata = 0;
+volatile static int state3 __nosavedata = 0;
+volatile static struct range *origrange __nosavedata;
+volatile static struct range *copyrange __nosavedata;
+volatile static int origoffset __nosavedata;
+volatile static int copyoffset __nosavedata;
+volatile static unsigned long * origpage __nosavedata;
+volatile static unsigned long * copypage __nosavedata;
+volatile static int io_speed_save[2][2] __nosavedata;
+#ifndef CONFIG_SMP
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
+cpumask_t saved_affinity[NR_IRQS];
+
+/*
+ * Routine to save the old irq affinities and change affinities of all irqs to
+ * the dumping cpu.
+ */
+static void save_and_set_irq_affinity(void)
+{
+	int i;
+	int cpu = smp_processor_id();
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
+/*
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
+ *
+ * SMP support:
+ * All SMP processors enter this routine during suspend. The one through
+ * which the suspend is initiated (which, for simplicity, is always CPU 0)
+ * sends the others here using an IPI during do_suspend2_suspend_1. They
+ * remain here until after the atomic copy of the kernel is made, to ensure
+ * that they don't mess with memory in the meantime (even just idling will
+ * do that). Once the atomic copy is made, they are free to carry on idling.
+ * Note that we must let them go, because if we're using compression, the
+ * vfree calls in the compressors will result in IPIs being called and hanging
+ * because the CPUs are still here.
+ *
+ * At resume time, we do a similar thing. CPU 0 sends the others in here using
+ * an IPI. It then copies the original kernel back, restores its own processor
+ * context and flushes local tlbs before freeing the others to do the same.
+ * They can then go back to idling while CPU 0 reloads pageset 2, cleans up
+ * and unfreezes the processes.
+ *
+ * (Remember that freezing and thawing processes also uses IPIs, as may
+ * decompressing the data. Again, therefore, we cannot leave the other processors
+ * in here).
+ * 
+ * At the moment, we do nothing about APICs, even though the code is there.
+ */
+void do_suspend2_lowlevel(int resume)
+{
+	int processor_id = smp_processor_id();
+
+	if (!resume) {
+		/*
+		 * Save the irq affinities before we freeze the
+		 * other processors!
+		 */
+		save_and_set_irq_affinity();
+		mtrr_save();
+
+		suspend2_core_ops->suspend1();
+		save_processor_context();	/* We need to capture registers and memory at "same time" */
+		suspend2_core_ops->suspend2();		/* If everything goes okay, this function does not return */
+		return;
+	}
+
+	state1 = suspend_action;
+	state2 = suspend_debug_state;
+	state3 = console_loglevel;
+	for (loop = 0; loop < 4; loop++)
+		io_speed_save[loop/2][loop%2] = 
+			suspend_io_time[loop/2][loop%2];
+
+	/* Send all IRQs to CPU 0. We will replace the saved affinities
+	 * with the suspend-time ones when we copy the original kernel
+	 * back in place
+	 */
+	save_and_set_irq_affinity();
+	
+	c_loops_per_jiffy_ref[processor_id] = current_cpu_data.loops_per_jiffy;
+#ifndef CONFIG_SMP
+	cpu_khz_ref = cpu_khz;
+#endif
+	
+	/* We want to run from swsusp_pg_dir, since swsusp_pg_dir is stored in constant
+	 * place in memory 
+	 */
+
+        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));
+
+/*
+ * Final function for resuming: after copying the pages to their original
+ * position, it restores the register state.
+ *
+ * What about page tables? Writing data pages may toggle
+ * accessed/dirty bits in our page tables. That should be no problems
+ * with 4MB page tables. That's why we require have_pse.  
+ *
+ * This loops destroys stack from under itself, so it better should
+ * not use any stack space, itself. When this function is entered at
+ * resume time, we move stack to _old_ place.  This is means that this
+ * function must use no stack and no local variables in registers,
+ * until calling restore_processor_context();
+ *
+ * Critical section here: noone should touch saved memory after
+ * do_suspend2_resume_1; copying works, because nr_copy_pages,
+ * pagedir_resume, loop and loop2 are nosavedata.
+ *
+ * If we're running with DEBUG_PAGEALLOC, the boot and resume kernels both have
+ * all the pages we need mapped into kernel space, so we don't need to change
+ * page protections while doing the copy-back.
+ */
+
+	suspend2_core_ops->resume1();
+
+	origrange = pagedir_resume.origranges.first;
+	copyrange = pagedir_resume.destranges.first;
+	origoffset = origrange->minimum;
+	copyoffset = copyrange->minimum;
+	origpage = (unsigned long *) (lowmem_page_address(mem_map + origoffset));
+	copypage = (unsigned long *) (lowmem_page_address(mem_map + copyoffset));
+
+	BUG_ON(!irqs_disabled());
+
+	/* As of 2.0.0.51, pageset1 can include highmem pages. If
+	 * !CONFIG_HIGHMEM, highstart_pfn == 0, hence the #ifdef.
+	 */
+#ifdef CONFIG_HIGHMEM
+	while ((origrange) && (origoffset < highstart_pfn)) {
+#else
+	while (origrange) {
+#endif
+		for (loop=0; loop < (PAGE_SIZE / sizeof(unsigned long)); loop++) {
+			*(origpage + loop) = *(copypage + loop);
+			*(copypage + loop) = 0xb000b000;
+		}
+		
+		if (origoffset < origrange->maximum) {
+			origoffset++;
+			origpage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			origrange = origrange->next;
+			if (origrange) {
+				origoffset = origrange->minimum;
+				origpage = (unsigned long *) (lowmem_page_address(mem_map + origoffset));
+			}
+		}
+
+		if (copyoffset < copyrange->maximum) {
+			copyoffset++;
+			copypage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			copyrange = copyrange->next;
+			if (copyrange) {
+				copyoffset = copyrange->minimum;
+				copypage = (unsigned long *) (lowmem_page_address(mem_map + copyoffset));
+			}
+		}
+	}
+	
+	restore_processor_context();
+	cpu_clear(processor_id, per_cpu(cpu_tlbstate, processor_id).active_mm->cpu_vm_mask);
+	wbinvd();
+	__flush_tlb_all();
+	
+	BUG_ON(!irqs_disabled());
+	
+	/* Now we are running with our old stack, and with registers copied
+	 * from suspend time. Let's copy back those remaining Highmem pages. */
+
+#ifdef CONFIG_HIGHMEM
+	while (origrange) {
+		unsigned long * origpage = (unsigned long *) kmap_atomic(mem_map + origoffset, KM_USER1);
+		for (loop=0; loop < (PAGE_SIZE / sizeof(unsigned long)); loop++) {
+			*(origpage + loop) = *(copypage + loop);
+			*(copypage + loop) = 0xb000b000;
+		}
+		kunmap_atomic(origpage, KM_USER1);
+		
+		if (origoffset < origrange->maximum)
+			origoffset++;
+		else {
+			origrange = origrange->next;
+			if (origrange)
+				origoffset = origrange->minimum;
+		}
+
+		if (copyoffset < copyrange->maximum) {
+			copyoffset++;
+			copypage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			copyrange = copyrange->next;
+			if (copyrange) {
+				copyoffset = copyrange->minimum;
+				copypage = (unsigned long *) (page_address(mem_map + copyoffset));
+			}
+		}
+	}
+#endif
+
+	suspend2_verify_checksums();
+
+	BUG_ON(!irqs_disabled());
+
+	cpu_clear(processor_id, per_cpu(cpu_tlbstate, processor_id).active_mm->cpu_vm_mask);
+	wbinvd();
+	__flush_tlb_all();
+	mtrr_restore_one_cpu();
+
+	/* Get other CPUs to restore their contexts and flush their tlbs. */
+	clear_suspend_state(SUSPEND_FREEZE_SMP);
+	
+	do {
+		cpu_relax();
+		barrier();
+	} while (atomic_read(&suspend_cpu_counter));
+
+	mtrr_restore_finish();
+	
+	BUG_ON(!irqs_disabled());
+
+	/* put the irq affinity tables back */
+	reset_irq_affinity();
+	
+	current_cpu_data.loops_per_jiffy = c_loops_per_jiffy_ref[processor_id];
+#ifndef CONFIG_SMP
+	loops_per_jiffy = c_loops_per_jiffy_ref[processor_id];
+	cpu_khz = cpu_khz_ref;
+#endif
+	suspend_action = state1;
+	suspend_debug_state = state2;
+	console_loglevel = state3;
+
+	for (loop = 0; loop < 4; loop++)
+		suspend_io_time[loop/2][loop%2] =
+			io_speed_save[loop/2][loop%2];
+
+	suspend2_core_ops->resume2();
+}
+EXPORT_SYMBOL(do_suspend2_lowlevel);
+#endif
+
+#ifdef CONFIG_SMP
+/*
+ * Save and restore processor state for secondary processors.
+ * IRQs (and therefore preemption) are already disabled 
+ * when we enter here (IPI).
+ */
+
+void __smp_suspend_lowlevel(void * info)
+{
+	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));
+
+	if (test_suspend_state(SUSPEND_NOW_RESUMING)) {
+		BUG_ON(!irqs_disabled());
+		kernel_fpu_begin();
+		c_loops_per_jiffy_ref[smp_processor_id()] = current_cpu_data.loops_per_jiffy;
+		atomic_inc(&suspend_cpu_counter);
+
+		/* Only image copied back while we spin in this loop. Our
+		 * task info should not be looked at while this is happening
+		 * (which smp_processor_id() will do( */
+		while (test_suspend_state(SUSPEND_FREEZE_SMP)) { 
+			cpu_relax();
+			barrier();
+		}
+
+		while (atomic_read(&suspend_cpu_counter) != smp_processor_id()) {
+			cpu_relax();
+			barrier();
+		}
+	       	my_saved_context = (unsigned char *) (suspend2_saved_contexts + smp_processor_id());
+		for (loop = sizeof(struct suspend2_saved_context); loop--; loop)
+			*(((unsigned char *) &suspend2_saved_context) + loop - 1) = *(my_saved_context + loop - 1);
+		restore_processor_context();
+		cpu_clear(smp_processor_id(), per_cpu(cpu_tlbstate, smp_processor_id()).active_mm->cpu_vm_mask);
+		load_cr3(swapper_pg_dir);
+		wbinvd();
+		__flush_tlb_all();
+		current_cpu_data.loops_per_jiffy = c_loops_per_jiffy_ref[smp_processor_id()];
+		mtrr_restore_one_cpu();
+		atomic_dec(&suspend_cpu_counter);
+	} else {	/* suspending */
+		BUG_ON(!irqs_disabled());
+		/* 
+		 *Save context and go back to idling.
+		 * Note that we cannot leave the processor
+		 * here. It must be able to receive IPIs if
+		 * the LZF compression driver (eg) does a
+		 * vfree after compressing the kernel etc
+		 */
+		while (test_suspend_state(SUSPEND_FREEZE_SMP) &&
+			(atomic_read(&suspend_cpu_counter) != (smp_processor_id() - 1))) {
+			cpu_relax();
+			barrier();
+		}
+		save_processor_context();
+		my_saved_context = (unsigned char *) (suspend2_saved_contexts + smp_processor_id());
+		for (loop = sizeof(struct suspend2_saved_context); loop--; loop)
+			*(my_saved_context + loop - 1) = *(((unsigned char *) &suspend2_saved_context) + loop - 1);
+		atomic_inc(&suspend_cpu_counter);
+		/* Now spin until the atomic copy of the kernel is made. */
+		while (test_suspend_state(SUSPEND_FREEZE_SMP)) {
+			cpu_relax();
+			barrier();
+		}
+		atomic_dec(&suspend_cpu_counter);
+		kernel_fpu_end();
+	}
+}
+
+EXPORT_SYMBOL(__smp_suspend_lowlevel);
+#endif  /* SMP */


