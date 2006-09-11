Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWIKWw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWIKWw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIKWw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:52:57 -0400
Received: from gw.goop.org ([64.81.55.164]:29154 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932236AbWIKWw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:52:56 -0400
Message-ID: <4505E8C1.7010906@goop.org>
Date: Mon, 11 Sep 2006 15:52:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386-pda: Initialize the PDA early, before any C code runs.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the PDA early, before any C code runs.

This patch makes sure the PDA is usable in head.S, before any C code
is run.

On the boot CPU, this is done by using a temporary boot_pda which is
initialized appropriately.  It is replaced with a proper PDA when the
proper GDT is installed.

For secondary CPUs, the GDT and PDA are pre-allocated and initialized.
head.S just needs to set %gs and load the GDT.

In the process, this removes the need for early_smp_processor_id() and
early_current().

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/common.c |  123 ++++++++++++++++----------------
 arch/i386/kernel/head.S       |   33 +++++++-
 arch/i386/kernel/smpboot.c    |   41 +++++-----
 include/asm-i386/current.h    |    7 -
 include/asm-i386/pda.h        |    2 
 include/asm-i386/processor.h  |    4 -
 include/asm-i386/smp.h        |    4 -

===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -13,7 +13,6 @@
 #include <asm/mmu_context.h>
 #include <asm/mtrr.h>
 #include <asm/mce.h>
-#include <asm/smp.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>
@@ -596,7 +595,7 @@ struct pt_regs * __devinit idle_regs(str
 	return regs;
 }
 
-__cpuinit int alloc_gdt(int cpu)
+static __cpuinit int alloc_gdt(int cpu)
 {
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	struct desc_struct *gdt;
@@ -642,19 +641,12 @@ __cpuinit int alloc_gdt(int cpu)
 	return 1;
 }
 
-static __cpuinit void pda_init(int cpu, struct task_struct *curr)
-{
-	struct i386_pda *pda = cpu_pda(cpu);
-
-	memset(pda, 0, sizeof(*pda));
-
-	pda->_pda = pda;
-
-	pda->cpu_number = cpu;
-	pda->pcurrent = curr;
-
-	printk("cpu %d current %p\n", cpu, curr);
-}
+/* Initial PDA used by boot CPU */
+struct i386_pda boot_pda = {
+	._pda = &boot_pda,
+	.cpu_number = 0,
+	.pcurrent = &init_task,
+};
 
 static inline void set_kernel_gs(void)
 {
@@ -664,11 +656,10 @@ static inline void set_kernel_gs(void)
 	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
 }
 
-/* Initialize the CPU's GDT and PDA */
-static __cpuinit void init_gdt(void)
-{
-	int cpu = early_smp_processor_id();
-	struct task_struct *curr = early_current();
+/* Initialize the CPU's GDT and PDA.  The boot CPU does this for
+   itself, but secondaries find this done for them. */
+__cpuinit int init_gdt(int cpu, struct task_struct *idle)
+{
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 	struct desc_struct *gdt;
@@ -678,8 +669,7 @@ static __cpuinit void init_gdt(void)
 	   allocated. */
 	if (!alloc_gdt(cpu)) {
 		printk(KERN_CRIT "CPU%d failed to allocate GDT or PDA\n", cpu);
-		for (;;)
-			local_irq_enable();
+		return 0;
 	}
 
 	gdt = (struct desc_struct *)cpu_gdt_descr->address;
@@ -705,52 +695,32 @@ static __cpuinit void init_gdt(void)
 			(unsigned long)pda, sizeof(*pda) - 1,
 			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
 
+
+	memset(pda, 0, sizeof(*pda));
+	pda->_pda = pda;
+	pda->cpu_number = cpu;
+	pda->pcurrent = idle;
+
+	return 1;
+}
+
+/* Common CPU init for both boot and secondary CPUs */
+static void __cpuinit _cpu_init(int cpu, struct task_struct *curr)
+{
+	struct tss_struct * t = &per_cpu(init_tss, cpu);
+	struct thread_struct *thread = &curr->thread;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+
+	/* Reinit these anyway, even if they've already been done (on
+	   the boot CPU, this will transition from the boot gdt+pda to
+	   the real ones). */
 	load_gdt(cpu_gdt_descr);
 	set_kernel_gs();
-
-	/* Do this once everything GDT-related has been set up. */
-	pda_init(cpu, curr);
-}
-
-/* Set up a very early PDA for the boot CPU so that smp_processor_id()
-   and current will work. */
-void __init smp_setup_processor_id(void)
-{
-	static __initdata struct i386_pda boot_pda;
-
-	pack_descriptor((u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].a,
-			(u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].b,
-			(unsigned long)&boot_pda, sizeof(struct i386_pda) - 1,
-			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
-
-	boot_pda.pcurrent = early_current();
-
-	/* Set %gs for this CPU's PDA */
-	set_kernel_gs();
-}
-
-/*
- * cpu_init() initializes state that is per-CPU. Some data is already
- * initialized (naturally) in the bootstrap process, such as the GDT
- * and IDT. We reload them nevertheless, this function acts as a
- * 'CPU state barrier', nothing should get across.
- */
-void __cpuinit cpu_init(void)
-{
-	int cpu = early_smp_processor_id();
-	struct task_struct *curr = early_current();
-
-	struct tss_struct * t = &per_cpu(init_tss, cpu);
-	struct thread_struct *thread = &curr->thread;
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) local_irq_enable();
 	}
-
-	/* Init the GDT and PDA early, before calling printk(),
-	   since it may end up using the PDA indirectly. */
-	init_gdt();
 
 	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
 
@@ -803,6 +773,37 @@ void __cpuinit cpu_init(void)
 	mxcsr_feature_mask_init();
 }
 
+/* Entrypoint to initialize secondary CPU */
+void __cpuinit secondary_cpu_init(void)
+{
+	int cpu = smp_processor_id();
+	struct task_struct *curr = current;
+
+	_cpu_init(cpu, curr);
+}
+
+/*
+ * cpu_init() initializes state that is per-CPU. Some data is already
+ * initialized (naturally) in the bootstrap process, such as the GDT
+ * and IDT. We reload them nevertheless, this function acts as a
+ * 'CPU state barrier', nothing should get across.
+ */
+void __cpuinit cpu_init(void)
+{
+	int cpu = smp_processor_id();
+	struct task_struct *curr = current;
+
+	/* Set up the real GDT and PDA, so we can transition from the
+	   boot versions. */
+	if (!init_gdt(cpu, curr)) {
+		/* failed to allocate something; not much we can do... */
+		for (;;)
+			local_irq_enable();
+	}
+
+	_cpu_init(cpu, curr);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 void __cpuinit cpu_uninit(void)
 {
===================================================================
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -302,6 +302,7 @@ 2:	movl %cr0,%eax
 	movl %eax,%cr0
 
 	call check_x87
+	call setup_pda
 	lgdt cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
@@ -312,10 +313,13 @@ 1:	movl $(__KERNEL_DS),%eax	# reload all
 	movl %eax,%ds
 	movl %eax,%es
 
-	xorl %eax,%eax			# Clear FS/GS and LDT
+	xorl %eax,%eax			# Clear FS and LDT
 	movl %eax,%fs
-	movl %eax,%gs
 	lldt %ax
+
+	movl $(__KERNEL_PDA),%eax
+	mov  %eax,%gs
+	
 	cld			# gcc2 wants the direction flag cleared at all times
 	pushl %eax		# fake return address
 #ifdef CONFIG_SMP
@@ -345,6 +349,23 @@ 1:	movb $1,X86_HARD_MATH
 	.byte 0xDB,0xE4		/* fsetpm for 287, ignored by 387 */
 	ret
 
+/*
+ * Point the GDT at this CPU's PDA.  On boot this will be
+ * cpu_gdt_table and boot_pda; for secondary CPUs, these will be
+ * that CPU's GDT and PDA.
+ */
+setup_pda:
+	/* get the PDA pointer */
+	movl start_pda, %eax
+
+	/* slot the PDA address into the GDT */
+	mov cpu_gdt_descr+2, %ecx
+	mov %ax, (__KERNEL_PDA+0+2)(%ecx)		/* base & 0x0000ffff */
+	shr $16, %eax
+	mov %al, (__KERNEL_PDA+4+0)(%ecx)		/* base & 0x00ff0000 */
+	mov %ah, (__KERNEL_PDA+4+3)(%ecx)		/* base & 0xff000000 */
+	ret
+	
 /*
  *  setup_idt
  *
@@ -484,7 +505,9 @@ ENTRY(empty_zero_page)
  * This starts the data section.
  */
 .data
-
+ENTRY(start_pda)
+	.long boot_pda
+	
 ENTRY(stack_start)
 	.long init_thread_union+THREAD_SIZE
 	.long __BOOT_DS
@@ -525,7 +548,7 @@ idt_descr:
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
-cpu_gdt_descr:
+ENTRY(cpu_gdt_descr)
 	.word GDT_ENTRIES*8-1
 	.long cpu_gdt_table
 
@@ -585,7 +608,7 @@ ENTRY(cpu_gdt_table)
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - PDA */
+	.quad 0x00cf92000000ffff	/* 0xd8 - PDA */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -536,11 +536,11 @@ static void __devinit start_secondary(vo
 static void __devinit start_secondary(void *unused)
 {
 	/*
-	 * Don't put *anything* before cpu_init(), SMP
+	 * Don't put *anything* before secondary_cpu_init(), SMP
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
-	cpu_init();
+	secondary_cpu_init();
 	preempt_disable();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
@@ -590,8 +590,6 @@ static void __devinit start_secondary(vo
  */
 void __devinit initialize_secondary(void)
 {
-	struct task_struct *curr = early_current();
-
 	/*
 	 * We don't actually need to load the full TSS,
 	 * basically just the stack pointer and the eip.
@@ -601,13 +599,16 @@ void __devinit initialize_secondary(void
 		"movl %0,%%esp\n\t"
 		"jmp *%1"
 		:
-		:"r" (curr->thread.esp),"r" (curr->thread.eip));
-}
-
+		:"m" (current->thread.esp),"m" (current->thread.eip));
+}
+
+/* Static state in head.S used to set up a CPU */
 extern struct {
 	void * esp;
 	unsigned short ss;
 } stack_start;
+extern struct i386_pda *start_pda;
+extern struct Xgt_desc_struct cpu_gdt_descr;
 
 #ifdef CONFIG_NUMA
 
@@ -934,17 +935,6 @@ static int __devinit do_boot_cpu(int api
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
-	/* Pre-allocate the CPU's GDT and PDA so it doesn't have to do
-	   any memory allocation during the delicate CPU-bringup
-	   phase. */
-	if (!alloc_gdt(cpu)) {
-		printk(KERN_INFO "Couldn't allocate GDT/PDA for CPU %d\n", cpu);
-		return -1;	/* ? */
-	}
-
-	++cpucount;
-	alternatives_smp_switch(1);
-
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -952,14 +942,29 @@ static int __devinit do_boot_cpu(int api
 	idle = alloc_idle_task(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
+
+	/* Pre-allocate and initialize the CPU's GDT and PDA so it
+	   doesn't have to do any memory allocation during the
+	   delicate CPU-bringup phase. */
+	if (!init_gdt(cpu, idle)) {
+		printk(KERN_INFO "Couldn't allocate GDT/PDA for CPU %d\n", cpu);
+		return -1;	/* ? */
+	}
+
 	idle->thread.eip = (unsigned long) start_secondary;
 	/* start_eip had better be page-aligned! */
 	start_eip = setup_trampoline();
+
+	++cpucount;
+	alternatives_smp_switch(1);
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
 	/* Stack for startup_32 can be just as for start_secondary onwards */
 	stack_start.esp = (void *) idle->thread.esp;
+
+	start_pda = cpu_pda(cpu);
+	cpu_gdt_descr = per_cpu(cpu_gdt_descr, cpu);
 
 	irq_ctx_init(cpu);
 
===================================================================
--- a/include/asm-i386/current.h
+++ b/include/asm-i386/current.h
@@ -1,15 +1,10 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-#include <linux/thread_info.h>
 #include <asm/pda.h>
+#include <linux/compiler.h>
 
 struct task_struct;
-
-static __always_inline struct task_struct *early_current(void)
-{
-	return current_thread_info()->task;
-}
 
 static __always_inline struct task_struct *get_current(void)
 {
===================================================================
--- a/include/asm-i386/pda.h
+++ b/include/asm-i386/pda.h
@@ -1,5 +1,7 @@
 #ifndef _I386_PDA_H
 #define _I386_PDA_H
+
+#include <linux/stddef.h>
 
 struct i386_pda
 {
===================================================================
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -728,6 +728,8 @@ extern unsigned long boot_option_idle_ov
 extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
-extern int alloc_gdt(int cpu);
+
+extern int init_gdt(int cpu, struct task_struct *idle);
+extern void secondary_cpu_init(void);
 
 #endif /* __ASM_I386_PROCESSOR_H */
===================================================================
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -60,9 +60,6 @@ extern void cpu_uninit(void);
  * so this is correct in the x86 case.
  */
 #define raw_smp_processor_id() (read_pda(cpu_number))
-/* This is valid from the very earliest point in boot that we care
-   about. */
-#define early_smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
@@ -99,7 +96,6 @@ extern unsigned int num_processors;
 
 #define safe_smp_processor_id()		0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
-#define early_smp_processor_id()	0
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 


