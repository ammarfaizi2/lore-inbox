Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUCVJ4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 04:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCVJ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 04:56:11 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64451 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261848AbUCVJ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 04:56:00 -0500
Date: Mon, 22 Mar 2004 04:56:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhcs-devel@lists.sourceforge.net
Subject: Re: [PATCH] Hotplug CPU toy for i386
In-Reply-To: <1079937266.5759.42.camel@bach>
Message-ID: <Pine.LNX.4.58.0403220153520.28727@montezuma.fsmlabs.com>
References: <405C1F42.9030901@cyberone.com.au> <1079937266.5759.42.camel@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Rusty Russell wrote:

> @@ -1035,6 +1036,10 @@ inline void smp_local_timer_interrupt(st
>  {
>  	int cpu = smp_processor_id();
>
> +	/* FIXME: Actually remove timer interrupt in __cpu_disable() --RR */
> +	if (cpu_is_offline(cpu))
> +		return;
> +

We could setup an offline cpu idt with nop type interrupt stubs, this
could also take care of the irq_stabilizing problem later on...

> +static int irqs_stabilizing;
> +
>  /*
>   * do_IRQ handles all normal device IRQ's (the special
>   * SMP cross-CPU interrupts have their own specific
> @@ -429,6 +429,12 @@ asmlinkage unsigned int do_IRQ(struct pt
>
>  	irq_enter();
>
> +	if (cpu_is_offline(smp_processor_id())
> +	    && system_running
> +	    && !irqs_stabilizing)
> +		printk(KERN_ERR "IRQ %i on offline %i\n",
> +		       irq, smp_processor_id());
> +

Ok, i got tempted, see below...

> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <mach_apic.h>
> +
> +void fixup_irqs(void)
> +{
> +	unsigned int irq;
> +	static int warned;
> +
> +	for (irq = 0; irq < NR_IRQS; irq++) {
> +		cpumask_t mask;
> +		cpus_and(mask, irq_affinity[irq], cpu_online_map);
> +		if (any_online_cpu(mask) == NR_CPUS) {
> +			printk("Breaking affinity for irq %i\n", irq);
> +			mask = cpu_online_map;
> +		}
> +		if (irq_desc[irq].handler->set_affinity)
> +			irq_desc[irq].handler->set_affinity(irq, mask);
> +		else if (irq_desc[irq].action && !(warned++))
> +			printk("Cannot set affinity for irq %i\n", irq);
> +	}

for the (!set_affinity && action) we're safe since the BSP will be
servicing those interrupts. So we can remove the warning completely.

So... the following patch sets up an offline cpu IDT, this way we can move
a dying cpu's interrupt servicing out of the normal interrupt handler fast
paths. If folks are interested i can clean it up, but it passes simple
offlining.

Index: linux-2.6.5-rc2-mm1/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc2-mm1/arch/i386/kernel/process.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 process.c
--- linux-2.6.5-rc2-mm1/arch/i386/kernel/process.c	22 Mar 2004 07:09:00 -0000	1.2
+++ linux-2.6.5-rc2-mm1/arch/i386/kernel/process.c	22 Mar 2004 09:44:49 -0000
@@ -142,7 +142,7 @@ static inline void play_dead(void)
 {
 	/* Ack it */
 	__get_cpu_var(cpu_state) = CPU_DEAD;
-
+
 	disable_timer_nmi_watchdog();

 	/* We shouldn't have to disable interrupts while dead, but
@@ -153,6 +153,7 @@ static inline void play_dead(void)
 		cpu_relax();

 	local_irq_disable();
+	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
 	__flush_tlb_all();
 	cpu_set(smp_processor_id(), cpu_online_map);
 	local_irq_enable();
Index: linux-2.6.5-rc2-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc2-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 smpboot.c
--- linux-2.6.5-rc2-mm1/arch/i386/kernel/smpboot.c	22 Mar 2004 07:09:00 -0000	1.2
+++ linux-2.6.5-rc2-mm1/arch/i386/kernel/smpboot.c	22 Mar 2004 09:45:29 -0000
@@ -1401,6 +1401,11 @@ int __cpu_disable(void)
 		return -EBUSY;

 	fixup_irqs();
+	/*
+	 * Now load the nop IDT so that this cpu goes out of the normal
+	 * irq handling paths.
+	 */
+	__asm__ __volatile__("lidt %0" : : "m" (nop_idt_descr));
 	return 0;
 }

Index: linux-2.6.5-rc2-mm1/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc2-mm1/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.5-rc2-mm1/arch/i386/kernel/traps.c	21 Mar 2004 17:02:13 -0000	1.1.1.1
+++ linux-2.6.5-rc2-mm1/arch/i386/kernel/traps.c	22 Mar 2004 09:13:55 -0000
@@ -942,6 +942,22 @@ do { \
 	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
 } while (0)

+#ifdef CONFIG_HOTPLUG_CPU
+struct desc_struct nop_idt_table[256] = { {0, 0}, };
+extern void dead_cpu_interrupt(void);
+
+__asm__ (".section .text\n"
+	 ".globl nop_idt_descr\n"
+	 ".word 0\n"
+	 "nop_idt_descr:\n"
+	 ".word 256*8-1\n"
+	 ".long nop_idt_table\n"
+	 ".align 4\n"
+	 "dead_cpu_interrupt:\n"
+	 "add $0x4, %esp\n"
+	 "iret;\n"
+);
+#endif

 /*
  * This needs to use 'idt_table' rather than 'idt', and
@@ -983,6 +999,13 @@ static void __init set_task_gate(unsigne

 void __init trap_init(void)
 {
+#ifdef CONFIG_HOTPLUG_CPU
+	int i;
+
+	for (i = 0; i < 256; i++)
+		_set_gate(nop_idt_table+i,14,0,dead_cpu_interrupt,__KERNEL_CS);
+#endif
+
 #ifdef CONFIG_EISA
 	if (isa_readl(0x0FFFD9) == 'E'+('I'<<8)+('S'<<16)+('A'<<24)) {
 		EISA_bus = 1;
Index: linux-2.6.5-rc2-mm1/include/asm-i386/desc.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc2-mm1/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 desc.h
--- linux-2.6.5-rc2-mm1/include/asm-i386/desc.h	21 Mar 2004 17:02:15 -0000	1.1.1.1
+++ linux-2.6.5-rc2-mm1/include/asm-i386/desc.h	22 Mar 2004 08:04:19 -0000
@@ -20,7 +20,9 @@ struct Xgt_desc_struct {
 } __attribute__ ((packed));

 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
-
+#ifdef CONFIG_HOTPLUG_CPU
+extern struct Xgt_desc_struct nop_idt_descr;
+#endif
 extern void trap_init_virtual_IDT(void);
 extern void trap_init_virtual_GDT(void);

