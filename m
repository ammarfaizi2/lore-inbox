Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbSLWGaL>; Mon, 23 Dec 2002 01:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbSLWGaL>; Mon, 23 Dec 2002 01:30:11 -0500
Received: from franka.aracnet.com ([216.99.193.44]:57488 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266627AbSLWG33>; Mon, 23 Dec 2002 01:29:29 -0500
Date: Sun, 22 Dec 2002 22:36:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1/8 Move NUMA-Q support into subarch
Message-ID: <21810000.1040625399@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from John Stultz. This just reorganises the subarch files to
put all the headers under the include dir, instead of mixing them
up with the C files. The only interesting part is the top section
where he makes it fall back from the subarch dir to the default dir
if there's no .h file under the subarch dir.

This patch means we can create multiple subarches without copying
every single file that any subarch wants into all the directories.
And is much tidier, IMHO.

diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/Makefile 01-subarch/arch/i386/Makefile
--- 00-virgin/arch/i386/Makefile	Fri Dec 13 23:17:51 2002
+++ 01-subarch/arch/i386/Makefile	Sun Dec 22 12:08:42 2002
@@ -46,25 +46,31 @@ cflags-$(CONFIG_MCYRIXIII)	+= $(call che
 
 CFLAGS += $(cflags-y)
 
-ifdef CONFIG_VISWS
-MACHINE	:= mach-visws
-else
-MACHINE	:= mach-generic
-endif
+#default subarch .c files
+mcore-y  := mach-default
+
+#VISWS subarch support
+mflags-$(CONFIG_VISWS) := -Iinclude/asm-i386/mach-visws
+mcore-$(CONFIG_VISWS)  := mach-visws
+
+#add other subarch support here
+
+#default subarch .h files
+mflags-y += -Iinclude/asm-i386/mach-default
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
-					   arch/i386/$(MACHINE)/
+					   arch/i386/$(mcore-y)/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
 # FIXME: is drivers- right ?
 drivers-$(CONFIG_OPROFILE)		+= arch/i386/oprofile/
 
-CFLAGS += -Iarch/i386/$(MACHINE)
-AFLAGS += -Iarch/i386/$(MACHINE)
+CFLAGS += $(mflags-y)
+AFLAGS += $(mflags-y)
 
 makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/i386/boot $(1)
 
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/kernel/apic.c 01-subarch/arch/i386/kernel/apic.c
--- 00-virgin/arch/i386/kernel/apic.c	Sun Nov 17 20:29:58 2002
+++ 01-subarch/arch/i386/kernel/apic.c	Sun Dec 22 12:08:42 2002
@@ -31,7 +31,8 @@
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
-#include "mach_apic.h"
+
+#include <mach_apic.h>
 
 void __init apic_intr_init(void)
 {
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/kernel/io_apic.c 01-subarch/arch/i386/kernel/io_apic.c
--- 00-virgin/arch/i386/kernel/io_apic.c	Fri Dec 13 23:17:51 2002
+++ 01-subarch/arch/i386/kernel/io_apic.c	Sun Dec 22 12:08:42 2002
@@ -35,7 +35,8 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
-#include "mach_apic.h"
+
+#include <mach_apic.h>
 
 #undef APIC_LOCKUP_DEBUG
 
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/kernel/mpparse.c 01-subarch/arch/i386/kernel/mpparse.c
--- 00-virgin/arch/i386/kernel/mpparse.c	Sun Nov 17 20:29:30 2002
+++ 01-subarch/arch/i386/kernel/mpparse.c	Sun Dec 22 12:08:42 2002
@@ -30,7 +30,8 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
-#include "mach_apic.h"
+
+#include <mach_apic.h>
 
 /* Have we found an MP table */
 int smp_found_config;
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/kernel/smpboot.c 01-subarch/arch/i386/kernel/smpboot.c
--- 00-virgin/arch/i386/kernel/smpboot.c	Sun Dec  1 09:59:46 2002
+++ 01-subarch/arch/i386/kernel/smpboot.c	Sun Dec 22 12:08:42 2002
@@ -51,7 +51,8 @@
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include "smpboot_hooks.h"
-#include "mach_apic.h"
+
+#include <mach_apic.h>
 
 /* Set if we find a B stepping CPU */
 static int __initdata smp_b_stepping;
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-default/Makefile 01-subarch/arch/i386/mach-default/Makefile
--- 00-virgin/arch/i386/mach-default/Makefile	Wed Dec 31 16:00:00 1969
+++ 01-subarch/arch/i386/mach-default/Makefile	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= setup.o topology.o
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-default/setup.c 01-subarch/arch/i386/mach-default/setup.c
--- 00-virgin/arch/i386/mach-default/setup.c	Wed Dec 31 16:00:00 1969
+++ 01-subarch/arch/i386/mach-default/setup.c	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,104 @@
+/*
+ *	Machine specific setup for generic
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq2 = { no_action, 0, 0, "cascade", NULL, NULL};
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+	setup_irq(2, &irq2);
+}
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to initialise
+ *	the various board specific APIC traps.
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
+
+#ifdef CONFIG_MCA
+/**
+ * mca_nmi_hook - hook into MCA specific NMI chain
+ *
+ * Description:
+ *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI sources
+ *	along the MCA bus.  Use this to hook into that chain if you will need
+ *	it.
+ **/
+void __init mca_nmi_hook(void)
+{
+	/* If I recall correctly, there's a whole bunch of other things that
+	 * we can do to check for NMI problems, but that's all I know about
+	 * at the moment.
+	 */
+
+	printk("NMI generated from unknown source!\n");
+}
+#endif
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-default/topology.c 01-subarch/arch/i386/mach-default/topology.c
--- 00-virgin/arch/i386/mach-default/topology.c	Wed Dec 31 16:00:00 1969
+++ 01-subarch/arch/i386/mach-default/topology.c	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,68 @@
+/*
+ * arch/i386/mach-generic/topology.c - Populate driverfs with topology information
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/cpu.h>
+
+struct i386_cpu cpu_devices[NR_CPUS];
+
+#ifdef CONFIG_NUMA
+#include <linux/mmzone.h>
+#include <asm/node.h>
+#include <asm/memblk.h>
+
+struct i386_node node_devices[MAX_NUMNODES];
+struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < num_online_nodes(); i++)
+		arch_register_node(i);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i = 0; i < num_online_memblks(); i++)
+		arch_register_memblk(i);
+	return 0;
+}
+
+#else /* !CONFIG_NUMA */
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/Makefile 01-subarch/arch/i386/mach-generic/Makefile
--- 00-virgin/arch/i386/mach-generic/Makefile	Mon Dec 16 21:50:37 2002
+++ 01-subarch/arch/i386/mach-generic/Makefile	Wed Dec 31 16:00:00 1969
@@ -1,7 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-EXTRA_CFLAGS	+= -I../kernel
-
-obj-y				:= setup.o topology.o
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/do_timer.h 01-subarch/arch/i386/mach-generic/do_timer.h
--- 00-virgin/arch/i386/mach-generic/do_timer.h	Sun Nov 17 20:29:54 2002
+++ 01-subarch/arch/i386/mach-generic/do_timer.h	Wed Dec 31 16:00:00 1969
@@ -1,82 +0,0 @@
-/* defines for inline arch setup functions */
-
-#include <asm/apic.h>
-
-/**
- * do_timer_interrupt_hook - hook into timer tick
- * @regs:	standard registers from interrupt
- *
- * Description:
- *	This hook is called immediately after the timer interrupt is ack'd.
- *	It's primary purpose is to allow architectures that don't possess
- *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
- *	timer interrupt as a means of triggering reschedules etc.
- **/
-
-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
-{
-	do_timer(regs);
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	x86_do_profile(regs);
-#else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
-#endif
-}
-
-
-/* you can safely undefine this if you don't have the Neptune chipset */
-
-#define BUGGY_NEPTUN_TIMER
-
-/**
- * do_timer_overflow - process a detected timer overflow condition
- * @count:	hardware timer interrupt count on overflow
- *
- * Description:
- *	This call is invoked when the jiffies count has not incremented but
- *	the hardware timer interrupt has.  It means that a timer tick interrupt
- *	came along while the previous one was pending, thus a tick was missed
- **/
-static inline int do_timer_overflow(int count)
-{
-	int i;
-
-	spin_lock(&i8259A_lock);
-	/*
-	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
-	 */
-	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
-	
-	/* assumption about timer being IRQ0 */
-	if (i & 0x01) {
-		/*
-		 * We cannot detect lost timer interrupts ... 
-		 * well, that's why we call them lost, don't we? :)
-		 * [hmm, on the Pentium and Alpha we can ... sort of]
-		 */
-		count -= LATCH;
-	} else {
-#ifdef BUGGY_NEPTUN_TIMER
-		/*
-		 * for the Neptun bug we know that the 'latch'
-		 * command doesnt latch the high and low value
-		 * of the counter atomically. Thus we have to 
-		 * substract 256 from the counter 
-		 * ... funny, isnt it? :)
-		 */
-		
-		count -= 256;
-#else
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-#endif
-	}
-	return count;
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/entry_arch.h 01-subarch/arch/i386/mach-generic/entry_arch.h
--- 00-virgin/arch/i386/mach-generic/entry_arch.h	Sun Nov 17 20:29:20 2002
+++ 01-subarch/arch/i386/mach-generic/entry_arch.h	Wed Dec 31 16:00:00 1969
@@ -1,34 +0,0 @@
-/*
- * This file is designed to contain the BUILD_INTERRUPT specifications for
- * all of the extra named interrupt vectors used by the architecture.
- * Usually this is the Inter Process Interrupts (IPIs)
- */
-
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs)
- */
-#ifdef CONFIG_X86_SMP
-BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
-BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
-#endif
-
-/*
- * every pentium local APIC has two 'local interrupts', with a
- * soft-definable vector attached to both interrupts, one of
- * which is a timer interrupt, the other one is error counter
- * overflow. Linux uses the local APIC timer interrupt to get
- * a much simpler SMP time architecture:
- */
-#ifdef CONFIG_X86_LOCAL_APIC
-BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
-BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
-
-#ifdef CONFIG_X86_MCE_P4THERMAL
-BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
-#endif
-
-#endif
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/irq_vectors.h 01-subarch/arch/i386/mach-generic/irq_vectors.h
--- 00-virgin/arch/i386/mach-generic/irq_vectors.h	Sun Nov 17 20:29:29 2002
+++ 01-subarch/arch/i386/mach-generic/irq_vectors.h	Wed Dec 31 16:00:00 1969
@@ -1,85 +0,0 @@
-/*
- * This file should contain #defines for all of the interrupt vector
- * numbers used by this architecture.
- *
- * In addition, there are some standard defines:
- *
- *	FIRST_EXTERNAL_VECTOR:
- *		The first free place for external interrupts
- *
- *	SYSCALL_VECTOR:
- *		The IRQ vector a syscall makes the user to kernel transition
- *		under.
- *
- *	TIMER_IRQ:
- *		The IRQ number the timer interrupt comes in at.
- *
- *	NR_IRQS:
- *		The total number of interrupt vectors (including all the
- *		architecture specific interrupts) needed.
- *
- */			
-#ifndef _ASM_IRQ_VECTORS_H
-#define _ASM_IRQ_VECTORS_H
-
-/*
- * IDT vectors usable for external interrupt sources start
- * at 0x20:
- */
-#define FIRST_EXTERNAL_VECTOR	0x20
-
-#define SYSCALL_VECTOR		0x80
-
-/*
- * Vectors 0x20-0x2f are used for ISA interrupts.
- */
-
-/*
- * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
- *
- *  some of the following vectors are 'rare', they are merged
- *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
- *  TLB, reschedule and local APIC vectors are performance-critical.
- *
- *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
- */
-#define SPURIOUS_APIC_VECTOR	0xff
-#define ERROR_APIC_VECTOR	0xfe
-#define INVALIDATE_TLB_VECTOR	0xfd
-#define RESCHEDULE_VECTOR	0xfc
-#define CALL_FUNCTION_VECTOR	0xfb
-
-#define THERMAL_APIC_VECTOR	0xf0
-/*
- * Local APIC timer IRQ vector is on a different priority level,
- * to work around the 'lost local interrupt if more than 2 IRQ
- * sources per level' errata.
- */
-#define LOCAL_TIMER_VECTOR	0xef
-
-/*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
- * levels. (0x80 is the syscall vector)
- */
-#define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
-
-#define TIMER_IRQ 0
-
-/*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
- * Right now the APIC is mostly only used for SMP.
- * 256 vectors is an architectural limit. (we can have
- * more than 256 devices theoretically, but they will
- * have to use shared interrupts)
- * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
- */
-#ifdef CONFIG_X86_IO_APIC
-#define NR_IRQS 224
-#else
-#define NR_IRQS 16
-#endif
-
-#endif /* _ASM_IRQ_VECTORS_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/mach_apic.h 01-subarch/arch/i386/mach-generic/mach_apic.h
--- 00-virgin/arch/i386/mach-generic/mach_apic.h	Sun Nov 17 20:29:58 2002
+++ 01-subarch/arch/i386/mach-generic/mach_apic.h	Wed Dec 31 16:00:00 1969
@@ -1,46 +0,0 @@
-#ifndef __ASM_MACH_APIC_H
-#define __ASM_MACH_APIC_H
-
-static inline unsigned long calculate_ldr(unsigned long old)
-{
-	unsigned long id;
-
-	id = 1UL << smp_processor_id();
-	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
-}
-
-#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
-
-#ifdef CONFIG_SMP
- #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
-#else
- #define TARGET_CPUS 0x01
-#endif
-
-#define APIC_BROADCAST_ID      0x0F
-#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
-
-static inline void summit_check(char *oem, char *productid) 
-{
-}
-
-static inline void clustered_apic_check(void)
-{
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-		(clustered_apic_mode ? "NUMA-Q" : "Flat"), nr_ioapics);
-}
-
-static inline int cpu_present_to_apicid(int mps_cpu)
-{
-	if (clustered_apic_mode)
-		return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
-	else
-		return mps_cpu;
-}
-
-static inline unsigned long apicid_to_cpu_present(int apicid)
-{
-	return (1ul << apicid);
-}
-
-#endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/setup.c 01-subarch/arch/i386/mach-generic/setup.c
--- 00-virgin/arch/i386/mach-generic/setup.c	Sun Nov 17 20:29:31 2002
+++ 01-subarch/arch/i386/mach-generic/setup.c	Wed Dec 31 16:00:00 1969
@@ -1,104 +0,0 @@
-/*
- *	Machine specific setup for generic
- */
-
-#include <linux/config.h>
-#include <linux/smp.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <asm/arch_hooks.h>
-
-/**
- * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
- *
- * Description:
- *	Perform any necessary interrupt initialisation prior to setting up
- *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
- *	interrupts should be initialised here if the machine emulates a PC
- *	in any way.
- **/
-void __init pre_intr_init_hook(void)
-{
-	init_ISA_irqs();
-}
-
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = { no_action, 0, 0, "cascade", NULL, NULL};
-
-/**
- * intr_init_hook - post gate setup interrupt initialisation
- *
- * Description:
- *	Fill in any interrupts that may have been left out by the general
- *	init_IRQ() routine.  interrupts having to do with the machine rather
- *	than the devices on the I/O bus (like APIC interrupts in intel MP
- *	systems) are started here.
- **/
-void __init intr_init_hook(void)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	apic_intr_init();
-#endif
-
-	setup_irq(2, &irq2);
-}
-
-/**
- * pre_setup_arch_hook - hook called prior to any setup_arch() execution
- *
- * Description:
- *	generally used to activate any machine specific identification
- *	routines that may be needed before setup_arch() runs.  On VISWS
- *	this is used to get the board revision and type.
- **/
-void __init pre_setup_arch_hook(void)
-{
-}
-
-/**
- * trap_init_hook - initialise system specific traps
- *
- * Description:
- *	Called as the final act of trap_init().  Used in VISWS to initialise
- *	the various board specific APIC traps.
- **/
-void __init trap_init_hook(void)
-{
-}
-
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
-
-/**
- * time_init_hook - do any specific initialisations for the system timer.
- *
- * Description:
- *	Must plug the system timer interrupt source at HZ into the IRQ listed
- *	in irq_vectors.h:TIMER_IRQ
- **/
-void __init time_init_hook(void)
-{
-	setup_irq(0, &irq0);
-}
-
-#ifdef CONFIG_MCA
-/**
- * mca_nmi_hook - hook into MCA specific NMI chain
- *
- * Description:
- *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI sources
- *	along the MCA bus.  Use this to hook into that chain if you will need
- *	it.
- **/
-void __init mca_nmi_hook(void)
-{
-	/* If I recall correctly, there's a whole bunch of other things that
-	 * we can do to check for NMI problems, but that's all I know about
-	 * at the moment.
-	 */
-
-	printk("NMI generated from unknown source!\n");
-}
-#endif
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/setup_arch_post.h 01-subarch/arch/i386/mach-generic/setup_arch_post.h
--- 00-virgin/arch/i386/mach-generic/setup_arch_post.h	Sun Nov 17 20:29:52 2002
+++ 01-subarch/arch/i386/mach-generic/setup_arch_post.h	Wed Dec 31 16:00:00 1969
@@ -1,40 +0,0 @@
-/**
- * machine_specific_memory_setup - Hook for machine specific memory setup.
- *
- * Description:
- *	This is included late in kernel/setup.c so that it can make
- *	use of all of the static functions.
- **/
-
-static inline char * __init machine_specific_memory_setup(void)
-{
-	char *who;
-
-
-	who = "BIOS-e820";
-
-	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
-	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/setup_arch_pre.h 01-subarch/arch/i386/mach-generic/setup_arch_pre.h
--- 00-virgin/arch/i386/mach-generic/setup_arch_pre.h	Sun Nov 17 20:29:22 2002
+++ 01-subarch/arch/i386/mach-generic/setup_arch_pre.h	Wed Dec 31 16:00:00 1969
@@ -1,5 +0,0 @@
-/* Hook to call BIOS initialisation function */
-
-/* no action for generic */
-
-#define ARCH_SETUP
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/smpboot_hooks.h 01-subarch/arch/i386/mach-generic/smpboot_hooks.h
--- 00-virgin/arch/i386/mach-generic/smpboot_hooks.h	Sun Nov 17 20:29:30 2002
+++ 01-subarch/arch/i386/mach-generic/smpboot_hooks.h	Wed Dec 31 16:00:00 1969
@@ -1,33 +0,0 @@
-/* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
- * which needs to alter them. */
-
-static inline void smpboot_clear_io_apic_irqs(void)
-{
-	io_apic_irqs = 0;
-}
-
-static inline void smpboot_setup_warm_reset_vector(void)
-{
-	/*
-	 * Install writable page 0 entry to set BIOS data area.
-	 */
-	local_flush_tlb();
-
-	/*
-	 * Paranoid:  Set warm reset code and vector here back
-	 * to default values.
-	 */
-	CMOS_WRITE(0, 0xf);
-
-	*((volatile long *) phys_to_virt(0x467)) = 0;
-}
-
-static inline void smpboot_setup_io_apic(void)
-{
-	/*
-	 * Here we can be sure that there is an IO-APIC in the system. Let's
-	 * go and set it up:
-	 */
-	if (!skip_ioapic_setup && nr_ioapics)
-		setup_IO_APIC();
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-generic/topology.c 01-subarch/arch/i386/mach-generic/topology.c
--- 00-virgin/arch/i386/mach-generic/topology.c	Sun Dec  1 09:59:46 2002
+++ 01-subarch/arch/i386/mach-generic/topology.c	Wed Dec 31 16:00:00 1969
@@ -1,68 +0,0 @@
-/*
- * arch/i386/mach-generic/topology.c - Populate driverfs with topology information
- *
- * Written by: Matthew Dobson, IBM Corporation
- * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.          
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <colpatch@us.ibm.com>
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <asm/cpu.h>
-
-struct i386_cpu cpu_devices[NR_CPUS];
-
-#ifdef CONFIG_NUMA
-#include <linux/mmzone.h>
-#include <asm/node.h>
-#include <asm/memblk.h>
-
-struct i386_node node_devices[MAX_NUMNODES];
-struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for (i = 0; i < num_online_nodes(); i++)
-		arch_register_node(i);
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
-	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
-	return 0;
-}
-
-#else /* !CONFIG_NUMA */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
-	return 0;
-}
-
-#endif /* CONFIG_NUMA */
-
-subsys_initcall(topology_init);
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-summit/mach_apic.h 01-subarch/arch/i386/mach-summit/mach_apic.h
--- 00-virgin/arch/i386/mach-summit/mach_apic.h	Sun Nov 17 20:29:48 2002
+++ 01-subarch/arch/i386/mach-summit/mach_apic.h	Wed Dec 31 16:00:00 1969
@@ -1,57 +0,0 @@
-#ifndef __ASM_MACH_APIC_H
-#define __ASM_MACH_APIC_H
-
-extern int x86_summit;
-
-#define XAPIC_DEST_CPUS_MASK    0x0Fu
-#define XAPIC_DEST_CLUSTER_MASK 0xF0u
-
-#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
-		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
-
-static inline unsigned long calculate_ldr(unsigned long old)
-{
-	unsigned long id;
-
-	if (x86_summit)
-		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
-	else
-		id = 1UL << smp_processor_id();
-	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
-}
-
-#define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
-#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
-
-#define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
-#define check_apicid_used(bitmap, apicid) (0)
-
-static inline void summit_check(char *oem, char *productid)
-{
-	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
-		x86_summit = 1;
-}
-
-static inline void clustered_apic_check(void)
-{
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
-}
-
-static inline int cpu_present_to_apicid(int mps_cpu)
-{
-	if (x86_summit)
-		return (int) raw_phys_apicid[mps_cpu];
-	else
-		return mps_cpu;
-}
-
-static inline unsigned long apicid_to_phys_cpu_present(int apicid)
-{
-	if (x86_summit)
-		return (1ul << (((apicid >> 4) << 2) | (apicid & 0x3)));
-	else
-		return (1ul << apicid);
-}
-
-#endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-visws/do_timer.h 01-subarch/arch/i386/mach-visws/do_timer.h
--- 00-virgin/arch/i386/mach-visws/do_timer.h	Sun Nov 17 20:29:30 2002
+++ 01-subarch/arch/i386/mach-visws/do_timer.h	Wed Dec 31 16:00:00 1969
@@ -1,49 +0,0 @@
-/* defines for inline arch setup functions */
-
-#include <asm/fixmap.h>
-#include <asm/cobalt.h>
-
-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
-{
-	/* Clear the interrupt */
-	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
-
-	do_timer(regs);
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	x86_do_profile(regs);
-#else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
-#endif
-}
-
-static inline int do_timer_overflow(int count)
-{
-	int i;
-
-	spin_lock(&i8259A_lock);
-	/*
-	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
-	 */
-	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
-	
-	/* assumption about timer being IRQ0 */
-	if (i & 0x01) {
-		/*
-		 * We cannot detect lost timer interrupts ... 
-		 * well, that's why we call them lost, don't we? :)
-		 * [hmm, on the Pentium and Alpha we can ... sort of]
-		 */
-		count -= LATCH;
-	} else {
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-	}
-	return count;
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-visws/entry_arch.h 01-subarch/arch/i386/mach-visws/entry_arch.h
--- 00-virgin/arch/i386/mach-visws/entry_arch.h	Sun Nov 17 20:29:53 2002
+++ 01-subarch/arch/i386/mach-visws/entry_arch.h	Wed Dec 31 16:00:00 1969
@@ -1,23 +0,0 @@
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs)
- */
-#ifdef CONFIG_X86_SMP
-BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
-BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
-#endif
-
-/*
- * every pentium local APIC has two 'local interrupts', with a
- * soft-definable vector attached to both interrupts, one of
- * which is a timer interrupt, the other one is error counter
- * overflow. Linux uses the local APIC timer interrupt to get
- * a much simpler SMP time architecture:
- */
-#ifdef CONFIG_X86_LOCAL_APIC
-BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
-BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
-#endif
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-visws/irq_vectors.h 01-subarch/arch/i386/mach-visws/irq_vectors.h
--- 00-virgin/arch/i386/mach-visws/irq_vectors.h	Sun Nov 17 20:29:22 2002
+++ 01-subarch/arch/i386/mach-visws/irq_vectors.h	Wed Dec 31 16:00:00 1969
@@ -1,64 +0,0 @@
-#ifndef _ASM_IRQ_VECTORS_H
-#define _ASM_IRQ_VECTORS_H
-
-/*
- * IDT vectors usable for external interrupt sources start
- * at 0x20:
- */
-#define FIRST_EXTERNAL_VECTOR	0x20
-
-#define SYSCALL_VECTOR		0x80
-
-/*
- * Vectors 0x20-0x2f are used for ISA interrupts.
- */
-
-/*
- * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
- *
- *  some of the following vectors are 'rare', they are merged
- *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
- *  TLB, reschedule and local APIC vectors are performance-critical.
- *
- *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
- */
-#define SPURIOUS_APIC_VECTOR	0xff
-#define ERROR_APIC_VECTOR	0xfe
-#define INVALIDATE_TLB_VECTOR	0xfd
-#define RESCHEDULE_VECTOR	0xfc
-#define CALL_FUNCTION_VECTOR	0xfb
-
-#define THERMAL_APIC_VECTOR	0xf0
-/*
- * Local APIC timer IRQ vector is on a different priority level,
- * to work around the 'lost local interrupt if more than 2 IRQ
- * sources per level' errata.
- */
-#define LOCAL_TIMER_VECTOR	0xef
-
-/*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
- * we start at 0x31 to spread out vectors evenly between priority
- * levels. (0x80 is the syscall vector)
- */
-#define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
-
-#define TIMER_IRQ 0
-
-/*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
- * Right now the APIC is mostly only used for SMP.
- * 256 vectors is an architectural limit. (we can have
- * more than 256 devices theoretically, but they will
- * have to use shared interrupts)
- * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
- */
-#ifdef CONFIG_X86_IO_APIC
-#define NR_IRQS 224
-#else
-#define NR_IRQS 16
-#endif
-
-#endif /* _ASM_IRQ_VECTORS_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-visws/setup_arch_post.h 01-subarch/arch/i386/mach-visws/setup_arch_post.h
--- 00-virgin/arch/i386/mach-visws/setup_arch_post.h	Sun Nov 17 20:29:46 2002
+++ 01-subarch/arch/i386/mach-visws/setup_arch_post.h	Wed Dec 31 16:00:00 1969
@@ -1,37 +0,0 @@
-/* Hook for machine specific memory setup.
- *
- * This is included late in kernel/setup.c so that it can make use of all of
- * the static functions. */
-
-static inline char * __init machine_specific_memory_setup(void)
-{
-	char *who;
-
-
-	who = "BIOS-e820";
-
-	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
-	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-visws/setup_arch_pre.h 01-subarch/arch/i386/mach-visws/setup_arch_pre.h
--- 00-virgin/arch/i386/mach-visws/setup_arch_pre.h	Sun Nov 17 20:29:30 2002
+++ 01-subarch/arch/i386/mach-visws/setup_arch_pre.h	Wed Dec 31 16:00:00 1969
@@ -1,5 +0,0 @@
-/* Hook to call BIOS initialisation function */
-
-/* no action for visws */
-
-#define ARCH_SETUP
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-visws/smpboot_hooks.h 01-subarch/arch/i386/mach-visws/smpboot_hooks.h
--- 00-virgin/arch/i386/mach-visws/smpboot_hooks.h	Sun Nov 17 20:29:25 2002
+++ 01-subarch/arch/i386/mach-visws/smpboot_hooks.h	Wed Dec 31 16:00:00 1969
@@ -1,13 +0,0 @@
-/* for visws do nothing for any of these */
-
-static inline void smpboot_clear_io_apic_irqs(void)
-{
-}
-
-static inline void smpboot_setup_warm_reset_vector(void)
-{
-}
-
-static inline void smpboot_setup_io_apic(void)
-{
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-voyager/do_timer.h 01-subarch/arch/i386/mach-voyager/do_timer.h
--- 00-virgin/arch/i386/mach-voyager/do_timer.h	Sun Nov 17 20:29:51 2002
+++ 01-subarch/arch/i386/mach-voyager/do_timer.h	Wed Dec 31 16:00:00 1969
@@ -1,22 +0,0 @@
-/* defines for inline arch setup functions */
-#include <asm/voyager.h>
-
-static inline void do_timer_interrupt_hook(struct pt_regs *regs)
-{
-	do_timer(regs);
-
-	voyager_timer_interrupt(regs);
-}
-
-static inline int do_timer_overflow(int count)
-{
-	/* can't read the ISR, just assume 1 tick
-	   overflow */
-	if(count > LATCH || count < 0) {
-		printk(KERN_ERR "VOYAGER PROBLEM: count is %d, latch is %d\n", count, LATCH);
-		count = LATCH;
-	}
-	count -= LATCH;
-
-	return count;
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-voyager/entry_arch.h 01-subarch/arch/i386/mach-voyager/entry_arch.h
--- 00-virgin/arch/i386/mach-voyager/entry_arch.h	Sun Nov 17 20:29:52 2002
+++ 01-subarch/arch/i386/mach-voyager/entry_arch.h	Wed Dec 31 16:00:00 1969
@@ -1,26 +0,0 @@
-/* -*- mode: c; c-basic-offset: 8 -*- */
-
-/* Copyright (C) 2002
- *
- * Author: James.Bottomley@HansenPartnership.com
- *
- * linux/arch/i386/voyager/entry_arch.h
- *
- * This file builds the VIC and QIC CPI gates
- */
-
-/* initialise the voyager interrupt gates 
- *
- * This uses the macros in irq.h to set up assembly jump gates.  The
- * calls are then redirected to the same routine with smp_ prefixed */
-BUILD_INTERRUPT(vic_sys_interrupt, VIC_SYS_INT)
-BUILD_INTERRUPT(vic_cmn_interrupt, VIC_CMN_INT)
-BUILD_INTERRUPT(vic_cpi_interrupt, VIC_CPI_LEVEL0);
-
-/* do all the QIC interrupts */
-BUILD_INTERRUPT(qic_timer_interrupt, QIC_TIMER_CPI);
-BUILD_INTERRUPT(qic_invalidate_interrupt, QIC_INVALIDATE_CPI);
-BUILD_INTERRUPT(qic_reschedule_interrupt, QIC_RESCHEDULE_CPI);
-BUILD_INTERRUPT(qic_enable_irq_interrupt, QIC_ENABLE_IRQ_CPI);
-BUILD_INTERRUPT(qic_call_function_interrupt, QIC_CALL_FUNCTION_CPI);
-
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-voyager/irq_vectors.h 01-subarch/arch/i386/mach-voyager/irq_vectors.h
--- 00-virgin/arch/i386/mach-voyager/irq_vectors.h	Sun Nov 17 20:29:28 2002
+++ 01-subarch/arch/i386/mach-voyager/irq_vectors.h	Wed Dec 31 16:00:00 1969
@@ -1,71 +0,0 @@
-/* -*- mode: c; c-basic-offset: 8 -*- */
-
-/* Copyright (C) 2002
- *
- * Author: James.Bottomley@HansenPartnership.com
- *
- * linux/arch/i386/voyager/irq_vectors.h
- *
- * This file provides definitions for the VIC and QIC CPIs
- */
-
-#ifndef _ASM_IRQ_VECTORS_H
-#define _ASM_IRQ_VECTORS_H
-
-/*
- * IDT vectors usable for external interrupt sources start
- * at 0x20:
- */
-#define FIRST_EXTERNAL_VECTOR	0x20
-
-#define SYSCALL_VECTOR		0x80
-
-/*
- * Vectors 0x20-0x2f are used for ISA interrupts.
- */
-
-/* These define the CPIs we use in linux */
-#define VIC_CPI_LEVEL0			0
-#define VIC_CPI_LEVEL1			1
-/* now the fake CPIs */
-#define VIC_TIMER_CPI			2
-#define VIC_INVALIDATE_CPI		3
-#define VIC_RESCHEDULE_CPI		4
-#define VIC_ENABLE_IRQ_CPI		5
-#define VIC_CALL_FUNCTION_CPI		6
-
-/* Now the QIC CPIs:  Since we don't need the two initial levels,
- * these are 2 less than the VIC CPIs */
-#define QIC_CPI_OFFSET			1
-#define QIC_TIMER_CPI			(VIC_TIMER_CPI - QIC_CPI_OFFSET)
-#define QIC_INVALIDATE_CPI		(VIC_INVALIDATE_CPI - QIC_CPI_OFFSET)
-#define QIC_RESCHEDULE_CPI		(VIC_RESCHEDULE_CPI - QIC_CPI_OFFSET)
-#define QIC_ENABLE_IRQ_CPI		(VIC_ENABLE_IRQ_CPI - QIC_CPI_OFFSET)
-#define QIC_CALL_FUNCTION_CPI		(VIC_CALL_FUNCTION_CPI - QIC_CPI_OFFSET)
-
-#define VIC_START_FAKE_CPI		VIC_TIMER_CPI
-#define VIC_END_FAKE_CPI		VIC_CALL_FUNCTION_CPI
-
-/* this is the SYS_INT CPI. */
-#define VIC_SYS_INT			8
-#define VIC_CMN_INT			15
-
-/* This is the boot CPI for alternate processors.  It gets overwritten
- * by the above once the system has activated all available processors */
-#define VIC_CPU_BOOT_CPI		VIC_CPI_LEVEL0
-#define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
-
-#define NR_IRQS 224
-
-#ifndef __ASSEMBLY__
-extern asmlinkage void vic_cpi_interrupt(void);
-extern asmlinkage void vic_sys_interrupt(void);
-extern asmlinkage void vic_cmn_interrupt(void);
-extern asmlinkage void qic_timer_interrupt(void);
-extern asmlinkage void qic_invalidate_interrupt(void);
-extern asmlinkage void qic_reschedule_interrupt(void);
-extern asmlinkage void qic_enable_irq_interrupt(void);
-extern asmlinkage void qic_call_function_interrupt(void);
-#endif /* !__ASSEMBLY__ */
-
-#endif /* _ASM_IRQ_VECTORS_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-voyager/setup_arch_post.h 01-subarch/arch/i386/mach-voyager/setup_arch_post.h
--- 00-virgin/arch/i386/mach-voyager/setup_arch_post.h	Sun Nov 17 20:29:31 2002
+++ 01-subarch/arch/i386/mach-voyager/setup_arch_post.h	Wed Dec 31 16:00:00 1969
@@ -1,73 +0,0 @@
-/* Hook for machine specific memory setup.
- *
- * This is included late in kernel/setup.c so that it can make use of all of
- * the static functions. */
-
-static inline char * __init machine_specific_memory_setup(void)
-{
-	char *who;
-
-	who = "NOT VOYAGER";
-
-	if(voyager_level == 5) {
-		__u32 addr, length;
-		int i;
-
-		who = "Voyager-SUS";
-
-		e820.nr_map = 0;
-		for(i=0; voyager_memory_detect(i, &addr, &length); i++) {
-			add_memory_region(addr, length, E820_RAM);
-		}
-		return who;
-	} else if(voyager_level == 4) {
-		__u32 tom;
-		__u16 catbase = inb(VOYAGER_SSPB_RELOCATION_PORT)<<8;
-		/* select the DINO config space */
-		outb(VOYAGER_DINO, VOYAGER_CAT_CONFIG_PORT);
-		/* Read DINO top of memory register */
-		tom = ((inb(catbase + 0x4) & 0xf0) << 16)
-			+ ((inb(catbase + 0x5) & 0x7f) << 24);
-
-		if(inb(catbase) != VOYAGER_DINO) {
-			printk(KERN_ERR "Voyager: Failed to get DINO for L4, setting tom to EXT_MEM_K\n");
-			tom = (EXT_MEM_K)<<10;
-		}
-		who = "Voyager-TOM";
-		add_memory_region(0, 0x9f000, E820_RAM);
-		/* map from 1M to top of memory */
-		add_memory_region(1*1024*1024, tom - 1*1024*1024, E820_RAM);
-		/* FIXME: Should check the ASICs to see if I need to
-		 * take out the 8M window.  Just do it at the moment
-		 * */
-		add_memory_region(8*1024*1024, 8*1024*1024, E820_RESERVED);
-		return who;
-	}
-
-	who = "BIOS-e820";
-
-	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
-	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
-}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/arch/i386/mach-voyager/setup_arch_pre.h 01-subarch/arch/i386/mach-voyager/setup_arch_pre.h
--- 00-virgin/arch/i386/mach-voyager/setup_arch_pre.h	Sun Nov 17 20:29:32 2002
+++ 01-subarch/arch/i386/mach-voyager/setup_arch_pre.h	Wed Dec 31 16:00:00 1969
@@ -1,10 +0,0 @@
-#include <asm/voyager.h>
-#define VOYAGER_BIOS_INFO ((struct voyager_bios_info *)(PARAM+0x40))
-
-/* Hook to call BIOS initialisation function */
-
-/* for voyager, pass the voyager BIOS/SUS info area to the detection 
- * routines */
-
-#define ARCH_SETUP	voyager_detect(VOYAGER_BIOS_INFO);
-
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/do_timer.h 01-subarch/include/asm-i386/mach-default/do_timer.h
--- 00-virgin/include/asm-i386/mach-default/do_timer.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/do_timer.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,82 @@
+/* defines for inline arch setup functions */
+
+#include <asm/apic.h>
+
+/**
+ * do_timer_interrupt_hook - hook into timer tick
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	This hook is called immediately after the timer interrupt is ack'd.
+ *	It's primary purpose is to allow architectures that don't possess
+ *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	do_timer(regs);
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	x86_do_profile(regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+}
+
+
+/* you can safely undefine this if you don't have the Neptune chipset */
+
+#define BUGGY_NEPTUN_TIMER
+
+/**
+ * do_timer_overflow - process a detected timer overflow condition
+ * @count:	hardware timer interrupt count on overflow
+ *
+ * Description:
+ *	This call is invoked when the jiffies count has not incremented but
+ *	the hardware timer interrupt has.  It means that a timer tick interrupt
+ *	came along while the previous one was pending, thus a tick was missed
+ **/
+static inline int do_timer_overflow(int count)
+{
+	int i;
+
+	spin_lock(&i8259A_lock);
+	/*
+	 * This is tricky when I/O APICs are used;
+	 * see do_timer_interrupt().
+	 */
+	i = inb(0x20);
+	spin_unlock(&i8259A_lock);
+	
+	/* assumption about timer being IRQ0 */
+	if (i & 0x01) {
+		/*
+		 * We cannot detect lost timer interrupts ... 
+		 * well, that's why we call them lost, don't we? :)
+		 * [hmm, on the Pentium and Alpha we can ... sort of]
+		 */
+		count -= LATCH;
+	} else {
+#ifdef BUGGY_NEPTUN_TIMER
+		/*
+		 * for the Neptun bug we know that the 'latch'
+		 * command doesnt latch the high and low value
+		 * of the counter atomically. Thus we have to 
+		 * substract 256 from the counter 
+		 * ... funny, isnt it? :)
+		 */
+		
+		count -= 256;
+#else
+		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+#endif
+	}
+	return count;
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/entry_arch.h 01-subarch/include/asm-i386/mach-default/entry_arch.h
--- 00-virgin/include/asm-i386/mach-default/entry_arch.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/entry_arch.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,34 @@
+/*
+ * This file is designed to contain the BUILD_INTERRUPT specifications for
+ * all of the extra named interrupt vectors used by the architecture.
+ * Usually this is the Inter Process Interrupts (IPIs)
+ */
+
+/*
+ * The following vectors are part of the Linux architecture, there
+ * is no hardware IRQ pin equivalent for them, they are triggered
+ * through the ICC by us (IPIs)
+ */
+#ifdef CONFIG_X86_SMP
+BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
+BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
+BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+#endif
+
+/*
+ * every pentium local APIC has two 'local interrupts', with a
+ * soft-definable vector attached to both interrupts, one of
+ * which is a timer interrupt, the other one is error counter
+ * overflow. Linux uses the local APIC timer interrupt to get
+ * a much simpler SMP time architecture:
+ */
+#ifdef CONFIG_X86_LOCAL_APIC
+BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+
+#ifdef CONFIG_X86_MCE_P4THERMAL
+BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
+#endif
+
+#endif
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/irq_vectors.h 01-subarch/include/asm-i386/mach-default/irq_vectors.h
--- 00-virgin/include/asm-i386/mach-default/irq_vectors.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/irq_vectors.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,85 @@
+/*
+ * This file should contain #defines for all of the interrupt vector
+ * numbers used by this architecture.
+ *
+ * In addition, there are some standard defines:
+ *
+ *	FIRST_EXTERNAL_VECTOR:
+ *		The first free place for external interrupts
+ *
+ *	SYSCALL_VECTOR:
+ *		The IRQ vector a syscall makes the user to kernel transition
+ *		under.
+ *
+ *	TIMER_IRQ:
+ *		The IRQ number the timer interrupt comes in at.
+ *
+ *	NR_IRQS:
+ *		The total number of interrupt vectors (including all the
+ *		architecture specific interrupts) needed.
+ *
+ */			
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+#define INVALIDATE_TLB_VECTOR	0xfd
+#define RESCHEDULE_VECTOR	0xfc
+#define CALL_FUNCTION_VECTOR	0xfb
+
+#define THERMAL_APIC_VECTOR	0xf0
+/*
+ * Local APIC timer IRQ vector is on a different priority level,
+ * to work around the 'lost local interrupt if more than 2 IRQ
+ * sources per level' errata.
+ */
+#define LOCAL_TIMER_VECTOR	0xef
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+#define TIMER_IRQ 0
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+#ifdef CONFIG_X86_IO_APIC
+#define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
+
+#endif /* _ASM_IRQ_VECTORS_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/mach_apic.h 01-subarch/include/asm-i386/mach-default/mach_apic.h
--- 00-virgin/include/asm-i386/mach-default/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,46 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
+
+#ifdef CONFIG_SMP
+ #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
+#else
+ #define TARGET_CPUS 0x01
+#endif
+
+#define APIC_BROADCAST_ID      0x0F
+#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+
+static inline void summit_check(char *oem, char *productid) 
+{
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		(clustered_apic_mode ? "NUMA-Q" : "Flat"), nr_ioapics);
+}
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	if (clustered_apic_mode)
+		return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
+	else
+		return mps_cpu;
+}
+
+static inline unsigned long apicid_to_cpu_present(int apicid)
+{
+	return (1ul << apicid);
+}
+
+#endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/setup_arch_post.h 01-subarch/include/asm-i386/mach-default/setup_arch_post.h
--- 00-virgin/include/asm-i386/mach-default/setup_arch_post.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/setup_arch_post.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,40 @@
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+static inline char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+
+
+	who = "BIOS-e820";
+
+	/*
+	 * Try to copy the BIOS-supplied E820-map.
+	 *
+	 * Otherwise fake a memory map; one section from 0k->640k,
+	 * the next section from 1mb->appropriate_mem_k
+	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
+	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+		unsigned long mem_size;
+
+		/* compare results from other methods and take the greater */
+		if (ALT_MEM_K < EXT_MEM_K) {
+			mem_size = EXT_MEM_K;
+			who = "BIOS-88";
+		} else {
+			mem_size = ALT_MEM_K;
+			who = "BIOS-e801";
+		}
+
+		e820.nr_map = 0;
+		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+  	}
+	return who;
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/setup_arch_pre.h 01-subarch/include/asm-i386/mach-default/setup_arch_pre.h
--- 00-virgin/include/asm-i386/mach-default/setup_arch_pre.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/setup_arch_pre.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,5 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for generic */
+
+#define ARCH_SETUP
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-default/smpboot_hooks.h 01-subarch/include/asm-i386/mach-default/smpboot_hooks.h
--- 00-virgin/include/asm-i386/mach-default/smpboot_hooks.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-default/smpboot_hooks.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,33 @@
+/* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
+ * which needs to alter them. */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+	io_apic_irqs = 0;
+}
+
+static inline void smpboot_setup_warm_reset_vector(void)
+{
+	/*
+	 * Install writable page 0 entry to set BIOS data area.
+	 */
+	local_flush_tlb();
+
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	CMOS_WRITE(0, 0xf);
+
+	*((volatile long *) phys_to_virt(0x467)) = 0;
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+	/*
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-summit/mach_apic.h 01-subarch/include/asm-i386/mach-summit/mach_apic.h
--- 00-virgin/include/asm-i386/mach-summit/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-summit/mach_apic.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,57 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+extern int x86_summit;
+
+#define XAPIC_DEST_CPUS_MASK    0x0Fu
+#define XAPIC_DEST_CLUSTER_MASK 0xF0u
+
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
+		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	if (x86_summit)
+		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	else
+		id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
+#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+
+#define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
+#define check_apicid_used(bitmap, apicid) (0)
+
+static inline void summit_check(char *oem, char *productid)
+{
+	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
+		x86_summit = 1;
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
+}
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	if (x86_summit)
+		return (int) raw_phys_apicid[mps_cpu];
+	else
+		return mps_cpu;
+}
+
+static inline unsigned long apicid_to_phys_cpu_present(int apicid)
+{
+	if (x86_summit)
+		return (1ul << (((apicid >> 4) << 2) | (apicid & 0x3)));
+	else
+		return (1ul << apicid);
+}
+
+#endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-visws/do_timer.h 01-subarch/include/asm-i386/mach-visws/do_timer.h
--- 00-virgin/include/asm-i386/mach-visws/do_timer.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-visws/do_timer.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,49 @@
+/* defines for inline arch setup functions */
+
+#include <asm/fixmap.h>
+#include <asm/cobalt.h>
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	/* Clear the interrupt */
+	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
+
+	do_timer(regs);
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	x86_do_profile(regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+}
+
+static inline int do_timer_overflow(int count)
+{
+	int i;
+
+	spin_lock(&i8259A_lock);
+	/*
+	 * This is tricky when I/O APICs are used;
+	 * see do_timer_interrupt().
+	 */
+	i = inb(0x20);
+	spin_unlock(&i8259A_lock);
+	
+	/* assumption about timer being IRQ0 */
+	if (i & 0x01) {
+		/*
+		 * We cannot detect lost timer interrupts ... 
+		 * well, that's why we call them lost, don't we? :)
+		 * [hmm, on the Pentium and Alpha we can ... sort of]
+		 */
+		count -= LATCH;
+	} else {
+		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+	}
+	return count;
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-visws/entry_arch.h 01-subarch/include/asm-i386/mach-visws/entry_arch.h
--- 00-virgin/include/asm-i386/mach-visws/entry_arch.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-visws/entry_arch.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,23 @@
+/*
+ * The following vectors are part of the Linux architecture, there
+ * is no hardware IRQ pin equivalent for them, they are triggered
+ * through the ICC by us (IPIs)
+ */
+#ifdef CONFIG_X86_SMP
+BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
+BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
+BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+#endif
+
+/*
+ * every pentium local APIC has two 'local interrupts', with a
+ * soft-definable vector attached to both interrupts, one of
+ * which is a timer interrupt, the other one is error counter
+ * overflow. Linux uses the local APIC timer interrupt to get
+ * a much simpler SMP time architecture:
+ */
+#ifdef CONFIG_X86_LOCAL_APIC
+BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+#endif
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-visws/irq_vectors.h 01-subarch/include/asm-i386/mach-visws/irq_vectors.h
--- 00-virgin/include/asm-i386/mach-visws/irq_vectors.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-visws/irq_vectors.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,64 @@
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+#define INVALIDATE_TLB_VECTOR	0xfd
+#define RESCHEDULE_VECTOR	0xfc
+#define CALL_FUNCTION_VECTOR	0xfb
+
+#define THERMAL_APIC_VECTOR	0xf0
+/*
+ * Local APIC timer IRQ vector is on a different priority level,
+ * to work around the 'lost local interrupt if more than 2 IRQ
+ * sources per level' errata.
+ */
+#define LOCAL_TIMER_VECTOR	0xef
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+#define TIMER_IRQ 0
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+#ifdef CONFIG_X86_IO_APIC
+#define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
+
+#endif /* _ASM_IRQ_VECTORS_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-visws/setup_arch_post.h 01-subarch/include/asm-i386/mach-visws/setup_arch_post.h
--- 00-virgin/include/asm-i386/mach-visws/setup_arch_post.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-visws/setup_arch_post.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,37 @@
+/* Hook for machine specific memory setup.
+ *
+ * This is included late in kernel/setup.c so that it can make use of all of
+ * the static functions. */
+
+static inline char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+
+
+	who = "BIOS-e820";
+
+	/*
+	 * Try to copy the BIOS-supplied E820-map.
+	 *
+	 * Otherwise fake a memory map; one section from 0k->640k,
+	 * the next section from 1mb->appropriate_mem_k
+	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
+	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+		unsigned long mem_size;
+
+		/* compare results from other methods and take the greater */
+		if (ALT_MEM_K < EXT_MEM_K) {
+			mem_size = EXT_MEM_K;
+			who = "BIOS-88";
+		} else {
+			mem_size = ALT_MEM_K;
+			who = "BIOS-e801";
+		}
+
+		e820.nr_map = 0;
+		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+  	}
+	return who;
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-visws/setup_arch_pre.h 01-subarch/include/asm-i386/mach-visws/setup_arch_pre.h
--- 00-virgin/include/asm-i386/mach-visws/setup_arch_pre.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-visws/setup_arch_pre.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,5 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for visws */
+
+#define ARCH_SETUP
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-visws/smpboot_hooks.h 01-subarch/include/asm-i386/mach-visws/smpboot_hooks.h
--- 00-virgin/include/asm-i386/mach-visws/smpboot_hooks.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-visws/smpboot_hooks.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,13 @@
+/* for visws do nothing for any of these */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+}
+
+static inline void smpboot_setup_warm_reset_vector(void)
+{
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-voyager/do_timer.h 01-subarch/include/asm-i386/mach-voyager/do_timer.h
--- 00-virgin/include/asm-i386/mach-voyager/do_timer.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-voyager/do_timer.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,22 @@
+/* defines for inline arch setup functions */
+#include <asm/voyager.h>
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	do_timer(regs);
+
+	voyager_timer_interrupt(regs);
+}
+
+static inline int do_timer_overflow(int count)
+{
+	/* can't read the ISR, just assume 1 tick
+	   overflow */
+	if(count > LATCH || count < 0) {
+		printk(KERN_ERR "VOYAGER PROBLEM: count is %d, latch is %d\n", count, LATCH);
+		count = LATCH;
+	}
+	count -= LATCH;
+
+	return count;
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-voyager/entry_arch.h 01-subarch/include/asm-i386/mach-voyager/entry_arch.h
--- 00-virgin/include/asm-i386/mach-voyager/entry_arch.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-voyager/entry_arch.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,26 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* Copyright (C) 2002
+ *
+ * Author: James.Bottomley@HansenPartnership.com
+ *
+ * linux/arch/i386/voyager/entry_arch.h
+ *
+ * This file builds the VIC and QIC CPI gates
+ */
+
+/* initialise the voyager interrupt gates 
+ *
+ * This uses the macros in irq.h to set up assembly jump gates.  The
+ * calls are then redirected to the same routine with smp_ prefixed */
+BUILD_INTERRUPT(vic_sys_interrupt, VIC_SYS_INT)
+BUILD_INTERRUPT(vic_cmn_interrupt, VIC_CMN_INT)
+BUILD_INTERRUPT(vic_cpi_interrupt, VIC_CPI_LEVEL0);
+
+/* do all the QIC interrupts */
+BUILD_INTERRUPT(qic_timer_interrupt, QIC_TIMER_CPI);
+BUILD_INTERRUPT(qic_invalidate_interrupt, QIC_INVALIDATE_CPI);
+BUILD_INTERRUPT(qic_reschedule_interrupt, QIC_RESCHEDULE_CPI);
+BUILD_INTERRUPT(qic_enable_irq_interrupt, QIC_ENABLE_IRQ_CPI);
+BUILD_INTERRUPT(qic_call_function_interrupt, QIC_CALL_FUNCTION_CPI);
+
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-voyager/irq_vectors.h 01-subarch/include/asm-i386/mach-voyager/irq_vectors.h
--- 00-virgin/include/asm-i386/mach-voyager/irq_vectors.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-voyager/irq_vectors.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,71 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* Copyright (C) 2002
+ *
+ * Author: James.Bottomley@HansenPartnership.com
+ *
+ * linux/arch/i386/voyager/irq_vectors.h
+ *
+ * This file provides definitions for the VIC and QIC CPIs
+ */
+
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/* These define the CPIs we use in linux */
+#define VIC_CPI_LEVEL0			0
+#define VIC_CPI_LEVEL1			1
+/* now the fake CPIs */
+#define VIC_TIMER_CPI			2
+#define VIC_INVALIDATE_CPI		3
+#define VIC_RESCHEDULE_CPI		4
+#define VIC_ENABLE_IRQ_CPI		5
+#define VIC_CALL_FUNCTION_CPI		6
+
+/* Now the QIC CPIs:  Since we don't need the two initial levels,
+ * these are 2 less than the VIC CPIs */
+#define QIC_CPI_OFFSET			1
+#define QIC_TIMER_CPI			(VIC_TIMER_CPI - QIC_CPI_OFFSET)
+#define QIC_INVALIDATE_CPI		(VIC_INVALIDATE_CPI - QIC_CPI_OFFSET)
+#define QIC_RESCHEDULE_CPI		(VIC_RESCHEDULE_CPI - QIC_CPI_OFFSET)
+#define QIC_ENABLE_IRQ_CPI		(VIC_ENABLE_IRQ_CPI - QIC_CPI_OFFSET)
+#define QIC_CALL_FUNCTION_CPI		(VIC_CALL_FUNCTION_CPI - QIC_CPI_OFFSET)
+
+#define VIC_START_FAKE_CPI		VIC_TIMER_CPI
+#define VIC_END_FAKE_CPI		VIC_CALL_FUNCTION_CPI
+
+/* this is the SYS_INT CPI. */
+#define VIC_SYS_INT			8
+#define VIC_CMN_INT			15
+
+/* This is the boot CPI for alternate processors.  It gets overwritten
+ * by the above once the system has activated all available processors */
+#define VIC_CPU_BOOT_CPI		VIC_CPI_LEVEL0
+#define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
+
+#define NR_IRQS 224
+
+#ifndef __ASSEMBLY__
+extern asmlinkage void vic_cpi_interrupt(void);
+extern asmlinkage void vic_sys_interrupt(void);
+extern asmlinkage void vic_cmn_interrupt(void);
+extern asmlinkage void qic_timer_interrupt(void);
+extern asmlinkage void qic_invalidate_interrupt(void);
+extern asmlinkage void qic_reschedule_interrupt(void);
+extern asmlinkage void qic_enable_irq_interrupt(void);
+extern asmlinkage void qic_call_function_interrupt(void);
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_IRQ_VECTORS_H */
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-voyager/setup_arch_post.h 01-subarch/include/asm-i386/mach-voyager/setup_arch_post.h
--- 00-virgin/include/asm-i386/mach-voyager/setup_arch_post.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-voyager/setup_arch_post.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,73 @@
+/* Hook for machine specific memory setup.
+ *
+ * This is included late in kernel/setup.c so that it can make use of all of
+ * the static functions. */
+
+static inline char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+
+	who = "NOT VOYAGER";
+
+	if(voyager_level == 5) {
+		__u32 addr, length;
+		int i;
+
+		who = "Voyager-SUS";
+
+		e820.nr_map = 0;
+		for(i=0; voyager_memory_detect(i, &addr, &length); i++) {
+			add_memory_region(addr, length, E820_RAM);
+		}
+		return who;
+	} else if(voyager_level == 4) {
+		__u32 tom;
+		__u16 catbase = inb(VOYAGER_SSPB_RELOCATION_PORT)<<8;
+		/* select the DINO config space */
+		outb(VOYAGER_DINO, VOYAGER_CAT_CONFIG_PORT);
+		/* Read DINO top of memory register */
+		tom = ((inb(catbase + 0x4) & 0xf0) << 16)
+			+ ((inb(catbase + 0x5) & 0x7f) << 24);
+
+		if(inb(catbase) != VOYAGER_DINO) {
+			printk(KERN_ERR "Voyager: Failed to get DINO for L4, setting tom to EXT_MEM_K\n");
+			tom = (EXT_MEM_K)<<10;
+		}
+		who = "Voyager-TOM";
+		add_memory_region(0, 0x9f000, E820_RAM);
+		/* map from 1M to top of memory */
+		add_memory_region(1*1024*1024, tom - 1*1024*1024, E820_RAM);
+		/* FIXME: Should check the ASICs to see if I need to
+		 * take out the 8M window.  Just do it at the moment
+		 * */
+		add_memory_region(8*1024*1024, 8*1024*1024, E820_RESERVED);
+		return who;
+	}
+
+	who = "BIOS-e820";
+
+	/*
+	 * Try to copy the BIOS-supplied E820-map.
+	 *
+	 * Otherwise fake a memory map; one section from 0k->640k,
+	 * the next section from 1mb->appropriate_mem_k
+	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
+	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+		unsigned long mem_size;
+
+		/* compare results from other methods and take the greater */
+		if (ALT_MEM_K < EXT_MEM_K) {
+			mem_size = EXT_MEM_K;
+			who = "BIOS-88";
+		} else {
+			mem_size = ALT_MEM_K;
+			who = "BIOS-e801";
+		}
+
+		e820.nr_map = 0;
+		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+  	}
+	return who;
+}
diff -urpN -X /home/fletch/.diff.exclude 00-virgin/include/asm-i386/mach-voyager/setup_arch_pre.h 01-subarch/include/asm-i386/mach-voyager/setup_arch_pre.h
--- 00-virgin/include/asm-i386/mach-voyager/setup_arch_pre.h	Wed Dec 31 16:00:00 1969
+++ 01-subarch/include/asm-i386/mach-voyager/setup_arch_pre.h	Sun Dec 22 12:08:42 2002
@@ -0,0 +1,10 @@
+#include <asm/voyager.h>
+#define VOYAGER_BIOS_INFO ((struct voyager_bios_info *)(PARAM+0x40))
+
+/* Hook to call BIOS initialisation function */
+
+/* for voyager, pass the voyager BIOS/SUS info area to the detection 
+ * routines */
+
+#define ARCH_SETUP	voyager_detect(VOYAGER_BIOS_INFO);
+

