Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWC3EVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWC3EVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 23:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWC3EVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 23:21:14 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:5386 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751115AbWC3EVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 23:21:13 -0500
Message-ID: <442B5BF8.5000502@vmware.com>
Date: Wed, 29 Mar 2006 20:18:00 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pazke@donpac.ru, James.Bottomley@HansenPartnership.com
Subject: [PATCH] Cleanup subarch definitions in Linux/i386
Content-Type: multipart/mixed;
 boundary="------------090401080907080001060904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090401080907080001060904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There is some redundant code and unnecessary function calls where 
inlines would be more appropriate in many of the sub-arches of i386.  In 
addition, some subarches do not compile with certain kernel config 
options, which needed to be fixed.  I have attempted to clean up the 
subarch implementation of i386 by removing the requirement of 
implementing a complete setup.c; instead, architectures are free to 
define only the hooks they actually need in the subarch headers, by 
introducing mach-xxx/mach_hooks.h and putting the generic definitions in 
arch_hooks.h.

I have tested this as best as I can, and all of the subarches continue 
to compile (in fact, even better with the config fixes).  I don't have 
all of the hardware combinations to actually test the generated kernels, 
but in general, this is fairly straightforward code movement.  One 
liberty I took was removing the sub-arch hook for mca_nmi_handler, as it 
is clear this does not apply to any other subarch than Voyager.

I created a new file, arch/i386/default.c, which has the default 
functions that are appropriate for all kernel compiles, which removes 
the redundant need to redefine IPI mechanisms in all architectures that 
provide a setup.c file.  This was required, since Voyager chooses to 
override the entire functionality of smp.c.

Comments, suggestions, anything welcome.  I think this is a much cleaner 
approach, and both new and existing sub-architectures will benefit.  I 
am sorry this patch is so large, but it is very difficult to separate 
into multiple steps that still allow all the subarches to compile.

Zach

--------------090401080907080001060904
Content-Type: text/plain;
 name="i386-subarch-cleanup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-subarch-cleanup"

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16.1/arch/i386/Kconfig
===================================================================
--- linux-2.6.16.1.orig/arch/i386/Kconfig	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/Kconfig	2006-03-29 19:38:54.000000000 -0800
@@ -218,7 +218,7 @@ config NR_CPUS
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
-	depends on SMP
+	depends on SMP && !X86_VOYAGER
 	default off
 	help
 	  SMT scheduler support improves the CPU scheduler's decision making
@@ -689,7 +689,7 @@ source kernel/Kconfig.hz
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
Index: linux-2.6.16.1/arch/i386/Makefile
===================================================================
--- linux-2.6.16.1.orig/arch/i386/Makefile	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/Makefile	2006-03-29 19:38:54.000000000 -0800
@@ -45,37 +45,32 @@ CFLAGS				+= $(shell if [ $(call cc-vers
 
 CFLAGS += $(cflags-y)
 
-# Default subarch .c files
-mcore-y  := mach-default
+# Default subarch .c files (none)
+mcore-y  := 
 
 # Voyager subarch support
 mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
-mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
+mcore-$(CONFIG_X86_VOYAGER)	:= arch/i386/mach-voyager/
 
 # VISWS subarch support
 mflags-$(CONFIG_X86_VISWS)	:= -Iinclude/asm-i386/mach-visws
-mcore-$(CONFIG_X86_VISWS)	:= mach-visws
+mcore-$(CONFIG_X86_VISWS)	:= arch/i386/mach-visws/
 
 # NUMAQ subarch support
 mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
-mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
 # BIGSMP subarch support
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
-mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
 
 #Summit subarch support
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
-mcore-$(CONFIG_X86_SUMMIT)  := mach-default
 
 # generic subarchitecture
 mflags-$(CONFIG_X86_GENERICARCH) := -Iinclude/asm-i386/mach-generic
-mcore-$(CONFIG_X86_GENERICARCH) := mach-default
 core-$(CONFIG_X86_GENERICARCH) += arch/i386/mach-generic/
 
 # ES7000 subarch support
 mflags-$(CONFIG_X86_ES7000)	:= -Iinclude/asm-i386/mach-es7000
-mcore-$(CONFIG_X86_ES7000)	:= mach-default
 core-$(CONFIG_X86_ES7000)	:= arch/i386/mach-es7000/
 
 # default subarch .h files
@@ -86,7 +81,7 @@ head-y := arch/i386/kernel/head.o arch/i
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
-					   arch/i386/$(mcore-y)/ \
+					   $(mcore-y) \
 					   arch/i386/crypto/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
Index: linux-2.6.16.1/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.16.1.orig/arch/i386/kernel/Makefile	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/kernel/Makefile	2006-03-29 19:38:54.000000000 -0800
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		quirks.o i8237.o topology.o
+		quirks.o i8237.o topology.o default.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
Index: linux-2.6.16.1/arch/i386/kernel/default.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/kernel/default.c	2006-03-29 19:38:54.000000000 -0800
+++ linux-2.6.16.1/arch/i386/kernel/default.c	2006-03-29 19:38:54.000000000 -0800
@@ -0,0 +1,48 @@
+/*
+ * Default architecture definitions used by sub-arch hooks.
+ */
+
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/arch_hooks.h>
+
+/*
+ * IRQ0 is the default timer interrupts.
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+					
+
+/* These can't be moved into smp.c, as some subarchitectures override that */
+#ifdef CONFIG_SMP
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define DEFAULT_SEND_IPI      (1)
+#else
+#define DEFAULT_SEND_IPI      (0)
+#endif
+
+int no_broadcast=DEFAULT_SEND_IPI;
+
+static __init int no_ipi_broadcast(char *str)
+{
+	get_option(&str, &no_broadcast);
+	printk ("Using %s mode\n", no_broadcast ? "No IPI Broadcast" :
+						  "IPI Broadcast");
+	return 1;
+}
+
+__setup("no_ipi_broadcast", no_ipi_broadcast);
+
+static int __init print_ipi_mode(void)
+{
+	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
+						      "Shortcut");
+	return 0;
+}
+
+late_initcall(print_ipi_mode);
+#endif
Index: linux-2.6.16.1/arch/i386/kernel/i8259.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/kernel/i8259.c	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/kernel/i8259.c	2006-03-29 19:38:54.000000000 -0800
@@ -419,6 +419,9 @@ void __init init_IRQ(void)
 	/* setup after call gates are initialised (usually add in
 	 * the architecture specific gates)
 	 */
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
 	intr_init_hook();
 
 	/*
Index: linux-2.6.16.1/arch/i386/kernel/mca.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/kernel/mca.c	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/kernel/mca.c	2006-03-29 19:38:54.000000000 -0800
@@ -463,6 +463,18 @@ static int mca_handle_nmi_callback(struc
 	return 0;
 }
 
+
+#ifdef CONFIG_X86_VOYAGER
+/*
+ * Voyager wants to do something smarter with NMIs.  Rather than add an
+ * arch hook for this, keep the MCA code together where it is in context.
+ * No other subarch requires an MCA NMI hook, and most don't support MCA.
+ */
+extern void mca_nmi_hook(void);
+#else
+#define mca_nmi_hook() printk("NMI generated from unknown source!\n");
+#endif
+
 void mca_handle_nmi(void)
 {
 	/* First try - scan the various adapters and see if a specific
Index: linux-2.6.16.1/arch/i386/mach-default/Makefile
===================================================================
--- linux-2.6.16.1.orig/arch/i386/mach-default/Makefile	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/mach-default/Makefile	2003-01-30 02:24:37.000000000 -0800
@@ -1,5 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-obj-y				:= setup.o
Index: linux-2.6.16.1/arch/i386/mach-default/setup.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/mach-default/setup.c	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/mach-default/setup.c	2003-01-30 02:24:37.000000000 -0800
@@ -1,132 +0,0 @@
-/*
- *	Machine specific setup for generic
- */
-
-#include <linux/config.h>
-#include <linux/smp.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <asm/acpi.h>
-#include <asm/arch_hooks.h>
-
-#ifdef CONFIG_HOTPLUG_CPU
-#define DEFAULT_SEND_IPI	(1)
-#else
-#define DEFAULT_SEND_IPI	(0)
-#endif
-
-int no_broadcast=DEFAULT_SEND_IPI;
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
-static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
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
-	if (!acpi_ioapic)
-		setup_irq(2, &irq2);
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
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
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
-
-static __init int no_ipi_broadcast(char *str)
-{
-	get_option(&str, &no_broadcast);
-	printk ("Using %s mode\n", no_broadcast ? "No IPI Broadcast" :
-											"IPI Broadcast");
-	return 1;
-}
-
-__setup("no_ipi_broadcast", no_ipi_broadcast);
-
-static int __init print_ipi_mode(void)
-{
-	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
-											"Shortcut");
-	return 0;
-}
-
-late_initcall(print_ipi_mode);
Index: linux-2.6.16.1/arch/i386/mach-visws/setup.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/mach-visws/setup.c	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/mach-visws/setup.c	2006-03-29 19:38:54.000000000 -0800
@@ -13,8 +13,6 @@
 #include "cobalt.h"
 #include "piix4.h"
 
-int no_broadcast;
-
 char visws_board_type = -1;
 char visws_board_rev = -1;
 
@@ -94,30 +92,7 @@ void __init visws_get_board_type_and_rev
 		"unknown")), visws_board_rev);
 }
 
-void __init pre_intr_init_hook(void)
-{
-	init_VISWS_APIC_irqs();
-}
-
-void __init intr_init_hook(void)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	apic_intr_init();
-#endif
-}
-
-void __init pre_setup_arch_hook()
-{
-	visws_get_board_type_and_rev();
-}
-
-static struct irqaction irq0 = {
-	.handler =	timer_interrupt,
-	.flags =	SA_INTERRUPT,
-	.name =		"timer",
-};
-
-void __init time_init_hook(void)
+void __init visws_time_init_hook(void)
 {
 	printk(KERN_INFO "Starting Cobalt Timer system clock\n");
 
Index: linux-2.6.16.1/arch/i386/mach-visws/traps.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/mach-visws/traps.c	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/mach-visws/traps.c	2006-03-29 19:38:54.000000000 -0800
@@ -62,7 +62,7 @@ static __init void cobalt_init(void)
 		co_apic_read(CO_APIC_ID));
 }
 
-void __init trap_init_hook(void)
+void __init visws_trap_init_hook(void)
 {
 	lithium_init();
 	cobalt_init();
Index: linux-2.6.16.1/arch/i386/mach-voyager/Makefile
===================================================================
--- linux-2.6.16.1.orig/arch/i386/mach-voyager/Makefile	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/mach-voyager/Makefile	2006-03-29 19:38:54.000000000 -0800
@@ -3,6 +3,6 @@
 #
 
 EXTRA_CFLAGS	+= -I../kernel
-obj-y			:= setup.o voyager_basic.o voyager_thread.o
+obj-y			:= voyager_basic.o voyager_thread.o
 
 obj-$(CONFIG_SMP)	+= voyager_smp.o voyager_cat.o
Index: linux-2.6.16.1/arch/i386/mach-voyager/setup.c
===================================================================
--- linux-2.6.16.1.orig/arch/i386/mach-voyager/setup.c	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/arch/i386/mach-voyager/setup.c	2003-01-30 02:24:37.000000000 -0800
@@ -1,47 +0,0 @@
-/*
- *	Machine specific setup for generic
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <asm/acpi.h>
-#include <asm/arch_hooks.h>
-
-void __init pre_intr_init_hook(void)
-{
-	init_ISA_irqs();
-}
-
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
-
-void __init intr_init_hook(void)
-{
-#ifdef CONFIG_SMP
-	smp_intr_init();
-#endif
-
-	if (!acpi_ioapic)
-		setup_irq(2, &irq2);
-}
-
-void __init pre_setup_arch_hook(void)
-{
-	/* Voyagers run their CPUs from independent clocks, so disable
-	 * the TSC code because we can't sync them */
-	tsc_disable = 1;
-}
-
-void __init trap_init_hook(void)
-{
-}
-
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
-
-void __init time_init_hook(void)
-{
-	setup_irq(0, &irq0);
-}
Index: linux-2.6.16.1/include/asm-i386/acpi.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/acpi.h	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/acpi.h	2006-03-29 19:38:54.000000000 -0800
@@ -31,6 +31,7 @@
 #include <acpi/pdc_intel.h>
 
 #include <asm/system.h>		/* defines cmpxchg */
+#include <asm/processor.h>	/* defines boot_cpu_data */
 
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
Index: linux-2.6.16.1/include/asm-i386/arch_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/arch_hooks.h	2006-03-29 19:38:47.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/arch_hooks.h	2006-03-29 19:38:54.000000000 -0800
@@ -1,7 +1,13 @@
 #ifndef _ASM_ARCH_HOOKS_H
 #define _ASM_ARCH_HOOKS_H
 
+#include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <asm/acpi.h>
+#include <asm/arch_hooks.h>
+#include <asm/desc.h>
 
 /*
  *	linux/include/asm/arch_hooks.h
@@ -16,12 +22,93 @@ extern void apic_intr_init(void);
 extern void smp_intr_init(void);
 extern irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
-/* these are the defined hooks */
-extern void intr_init_hook(void);
-extern void pre_intr_init_hook(void);
-extern void pre_setup_arch_hook(void);
-extern void trap_init_hook(void);
-extern void time_init_hook(void);
-extern void mca_nmi_hook(void);
+/*
+ * There are also some generic structures used by most architectures.
+ *
+ * IRQ0 is the default timer interrupt
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+extern struct irqaction irq0;
+extern struct irqaction irq2;
+
+static inline void legacy_intr_init_hook(void)
+{
+	if (!acpi_ioapic)
+		setup_irq(2, &irq2);
+}
+
+static inline void default_timer_init(void)
+{
+	setup_irq(0, &irq0);
+}
+
+/* include to allow sub-arch override */
+#include <mach_hooks.h>
+
+/* these are the default hooks */
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
+#ifndef pre_intr_init_hook
+#define pre_intr_init_hook() init_ISA_irqs()
+#endif
+
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
+#ifndef intr_init_hook
+#define intr_init_hook() legacy_intr_init_hook()
+#endif
+
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+#ifndef pre_setup_arch_hook
+#define pre_setup_arch_hook()
+#endif
+
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to initialise
+ *	the various board specific APIC traps.
+ **/
+#ifndef trap_init_hook
+#define trap_init_hook()
+#endif
+
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+#ifndef time_init_hook
+#define time_init_hook() default_timer_init()
+#endif
 
 #endif
Index: linux-2.6.16.1/include/asm-i386/mach-default/mach_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/mach-default/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/mach-default/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
@@ -0,0 +1,6 @@
+#ifndef _MACH_HOOKS_H
+#define _MACH_HOOKS_H
+
+/* Fall back to the default hooks in include/asm-i386/arch_hooks.h */
+
+#endif
Index: linux-2.6.16.1/include/asm-i386/mach-visws/mach_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/mach-visws/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/mach-visws/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
@@ -0,0 +1,15 @@
+#ifndef MACH_HOOKS_H
+#define MACH_HOOKS_H
+
+#define pre_intr_init_hook() init_VISWS_APIC_irqs()
+
+extern void visws_get_board_type_and_rev(void);
+#define pre_setup_arch_hook() visws_get_board_type_and_rev()
+
+extern void visws_time_init_hook(void);
+#define time_init_hook() visws_time_init_hook()
+
+extern void visws_trap_init_hook(void);
+#define trap_init_hook() visws_trap_init_hook()
+
+#endif
Index: linux-2.6.16.1/include/asm-i386/mach-voyager/mach_hooks.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-i386/mach-voyager/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
+++ linux-2.6.16.1/include/asm-i386/mach-voyager/mach_hooks.h	2006-03-29 19:38:54.000000000 -0800
@@ -0,0 +1,38 @@
+#ifndef MACH_HOOKS_H
+#define MACH_HOOKS_H
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
+static inline void voyager_intr_init_hook(void)
+{
+#ifdef CONFIG_SMP
+	smp_intr_init();
+#endif
+	legacy_intr_init_hook();
+}
+
+#define intr_init_hook() voyager_intr_init_hook()
+
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs. 
+ *	Voyagers run their CPUs from independent clocks, so disable
+ *	the TSC code because we can't sync them
+ **/
+#define pre_setup_arch_hook()	\
+do { 				\
+	tsc_disable = 1;	\
+} while (0)
+
+#endif

--------------090401080907080001060904--
