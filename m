Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUFISB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUFISB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUFISBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:01:46 -0400
Received: from holomorphy.com ([207.189.100.168]:8070 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265861AbUFIR7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:59:20 -0400
Date: Wed, 9 Jun 2004 10:59:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609175910.GS1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
References: <20040609015001.31d249ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609015001.31d249ca.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 01:50:01AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/
> - Included the dreaded cpumask rework.
> - Lots of little fixes.
> - Added support for the NX (no execute) pagetable flag on ia32.

Last time I tested this on sparc64 (the only current user of ->mask) it
appeared to work. The following patch makes irqaction's ->mask a cpumask
as it was intended to be and wraps up the rest of the sweep. Only struct
irqaction is usefully greppable, so there may be some assignments to
->mask missing still. This removes more code than it adds.

Compiletested i386 and sparc64, runtime tested on sparc64 in a prior
incarnation. vs. 2.6.7-rc3-mm1


-- wli

Index: mm1-2.6.7-rc3/include/linux/interrupt.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/linux/interrupt.h	2004-06-07 12:14:25.000000000 -0700
+++ mm1-2.6.7-rc3/include/linux/interrupt.h	2004-06-09 10:40:12.684107000 -0700
@@ -7,6 +7,7 @@
 #include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <linux/preempt.h>
+#include <linux/cpumask.h>
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>
@@ -35,7 +36,7 @@
 struct irqaction {
 	irqreturn_t (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
-	unsigned long mask;
+	cpumask_t mask;
 	const char *name;
 	void *dev_id;
 	struct irqaction *next;
Index: mm1-2.6.7-rc3/include/linux/cpumask.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/linux/cpumask.h	2004-06-09 07:11:49.439889000 -0700
+++ mm1-2.6.7-rc3/include/linux/cpumask.h	2004-06-09 10:44:34.137360000 -0700
@@ -248,9 +248,9 @@
 #endif
 
 #define CPU_MASK_NONE							\
-{ {									\
+((cpumask_t){ {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
-} }
+} })
 
 #define cpus_addr(src) ((src).bits)
 
Index: mm1-2.6.7-rc3/arch/ppc/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/ppc/kernel/irq.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/ppc/kernel/irq.c	2004-06-09 10:40:12.760095000 -0700
@@ -241,7 +241,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;			
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->dev_id = dev_id;
 	action->next = NULL;
Index: mm1-2.6.7-rc3/arch/alpha/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/alpha/kernel/irq.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/alpha/kernel/irq.c	2004-06-09 10:40:12.844083000 -0700
@@ -457,7 +457,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/arm/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/arm/kernel/irq.c	2004-06-07 12:13:34.000000000 -0700
+++ mm1-2.6.7-rc3/arch/arm/kernel/irq.c	2004-06-09 10:40:12.895075000 -0700
@@ -674,7 +674,7 @@
 
 	action->handler = handler;
 	action->flags = irq_flags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/arm/mach-clps7500/core.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/arm/mach-clps7500/core.c	2004-06-07 12:14:33.000000000 -0700
+++ mm1-2.6.7-rc3/arch/arm/mach-clps7500/core.c	2004-06-09 10:40:12.944067000 -0700
@@ -187,7 +187,7 @@
 	.unmask	= cl7500_no_action,
 };
 
-static struct irqaction irq_isa = { no_action, 0, 0, "isa", NULL, NULL };
+static struct irqaction irq_isa = { no_action, 0, CPU_MASK_NONE, "isa", NULL, NULL };
 
 static void __init clps7500_init_irq(void)
 {
Index: mm1-2.6.7-rc3/arch/arm26/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/arm26/kernel/irq.c	2004-06-07 12:14:58.000000000 -0700
+++ mm1-2.6.7-rc3/arch/arm26/kernel/irq.c	2004-06-09 10:40:13.024055000 -0700
@@ -549,7 +549,7 @@
 
 	action->handler = handler;
 	action->flags = irq_flags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/cris/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/cris/kernel/irq.c	2004-06-07 12:15:12.000000000 -0700
+++ mm1-2.6.7-rc3/arch/cris/kernel/irq.c	2004-06-09 10:40:13.065049000 -0700
@@ -240,7 +240,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/cris/arch-v10/kernel/time.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/cris/arch-v10/kernel/time.c	2004-06-07 12:14:42.000000000 -0700
+++ mm1-2.6.7-rc3/arch/cris/arch-v10/kernel/time.c	2004-06-09 10:40:13.155035000 -0700
@@ -253,7 +253,7 @@
  */
 
 static struct irqaction irq2  = { timer_interrupt, SA_SHIRQ | SA_INTERRUPT,
-				  0, "timer", NULL, NULL};
+				  CPU_MASK_NONE, "timer", NULL, NULL};
 
 void __init
 time_init(void)
Index: mm1-2.6.7-rc3/arch/i386/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/irq.c	2004-06-09 07:10:49.966930000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/irq.c	2004-06-09 10:40:13.221025000 -0700
@@ -654,7 +654,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/i386/kernel/i8259.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/i8259.c	2004-06-09 07:11:34.007235000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/i8259.c	2004-06-09 10:40:13.230024000 -0700
@@ -333,7 +333,7 @@
  * New motherboards sometimes make IRQ 13 be a PCI interrupt,
  * so allow interrupt sharing.
  */
-static struct irqaction fpu_irq = { math_error_irq, 0, 0, "fpu", NULL, NULL };
+static struct irqaction fpu_irq = { math_error_irq, 0, CPU_MASK_NONE, "fpu", NULL, NULL };
 
 void __init init_ISA_irqs (void)
 {
Index: mm1-2.6.7-rc3/arch/i386/mach-default/setup.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/mach-default/setup.c	2004-06-07 12:14:05.000000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/mach-default/setup.c	2004-06-09 10:40:13.267018000 -0700
@@ -27,7 +27,7 @@
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq2 = { no_action, 0, 0, "cascade", NULL, NULL};
+static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 /**
  * intr_init_hook - post gate setup interrupt initialisation
@@ -71,7 +71,7 @@
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
 
 /**
  * time_init_hook - do any specific initialisations for the system timer.
Index: mm1-2.6.7-rc3/arch/i386/mach-pc9800/setup.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/mach-pc9800/setup.c	2004-06-07 12:13:34.000000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/mach-pc9800/setup.c	2004-06-09 10:40:13.287015000 -0700
@@ -34,7 +34,7 @@
 /*
  * IRQ7 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq7 = { no_action, 0, 0, "cascade", NULL, NULL};
+static struct irqaction irq7 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 /**
  * intr_init_hook - post gate setup interrupt initialisation
@@ -82,7 +82,7 @@
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
 
 /**
  * time_init_hook - do any specific initialisations for the system timer.
Index: mm1-2.6.7-rc3/arch/ia64/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/ia64/kernel/irq.c	2004-06-09 07:10:24.000000000 -0700
+++ mm1-2.6.7-rc3/arch/ia64/kernel/irq.c	2004-06-09 10:40:13.355005000 -0700
@@ -612,7 +612,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/ia64/lib/kgdb_serial.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/ia64/lib/kgdb_serial.c	2004-06-09 07:10:25.000000000 -0700
+++ mm1-2.6.7-rc3/arch/ia64/lib/kgdb_serial.c	2004-06-09 10:40:13.429993000 -0700
@@ -486,7 +486,7 @@
 		irq_desc_t *desc;
 		kgdb_action.handler = gdb_interrupt;
 		kgdb_action.flags = IRQ_T(gdb_async_info);
-		kgdb_action.mask = 0;
+		kgdb_action.mask = CPU_MASK_NONE;
 		kgdb_action.name = "KGDB-stub";
 		kgdb_action.next = NULL;
 		kgdb_action.dev_id = NULL;
Index: mm1-2.6.7-rc3/arch/mips/baget/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/baget/irq.c	2004-06-07 12:14:42.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/baget/irq.c	2004-06-09 10:40:13.512981000 -0700
@@ -325,7 +325,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
@@ -389,7 +389,7 @@
 }
 
 static struct irqaction irq0  =
-{ write_err_interrupt, SA_INTERRUPT, 0, "bus write error", NULL, NULL};
+{ write_err_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "bus write error", NULL, NULL};
 
 void __init init_IRQ(void)
 {
Index: mm1-2.6.7-rc3/arch/mips/baget/time.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/baget/time.c	2004-06-07 12:13:34.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/baget/time.c	2004-06-09 10:40:13.545976000 -0700
@@ -67,7 +67,7 @@
 }
 
 static struct irqaction timer_irq  =
-{ timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+{ timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
 
 void __init time_init(void)
 {
Index: mm1-2.6.7-rc3/arch/mips/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/kernel/irq.c	2004-06-07 12:13:39.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/kernel/irq.c	2004-06-09 10:40:13.578971000 -0700
@@ -487,7 +487,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/mips/vr4181/common/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/vr4181/common/irq.c	2004-06-07 12:15:11.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/vr4181/common/irq.c	2004-06-09 10:40:13.634962000 -0700
@@ -180,9 +180,9 @@
 extern void mips_cpu_irq_init(u32 irq_base);
 
 static struct irqaction cascade =
-	{ no_action, SA_INTERRUPT, 0, "cascade", NULL, NULL };
+	{ no_action, SA_INTERRUPT, CPU_MASK_NONE, "cascade", NULL, NULL };
 static struct irqaction reserved =
-	{ no_action, SA_INTERRUPT, 0, "cascade", NULL, NULL };
+	{ no_action, SA_INTERRUPT, CPU_MASK_NONE, "cascade", NULL, NULL };
 
 void __init init_IRQ(void)
 {
Index: mm1-2.6.7-rc3/arch/mips/gt64120/common/time.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/gt64120/common/time.c	2004-06-07 12:14:58.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/gt64120/common/time.c	2004-06-09 10:40:13.676956000 -0700
@@ -80,7 +80,7 @@
 	timer.name = "timer";
 	timer.dev_id = NULL;
 	timer.next = NULL;
-	timer.mask = 0;
+	timer.mask = CPU_MASK_NONE;
 	irq_desc[GT_TIMER].action = &timer;
 
 	enable_irq(GT_TIMER);
Index: mm1-2.6.7-rc3/arch/mips/vr41xx/common/giu.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/vr41xx/common/giu.c	2004-06-07 12:13:38.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/vr41xx/common/giu.c	2004-06-09 10:40:13.722949000 -0700
@@ -209,7 +209,7 @@
 };
 
 static struct vr41xx_giuint_cascade giuint_cascade[GIUINT_NR_IRQS];
-static struct irqaction giu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
+static struct irqaction giu_cascade = {no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 static int no_irq_number(int irq)
 {
Index: mm1-2.6.7-rc3/arch/mips/vr41xx/common/icu.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/vr41xx/common/icu.c	2004-06-07 12:13:35.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/vr41xx/common/icu.c	2004-06-09 10:40:13.738946000 -0700
@@ -288,7 +288,7 @@
 
 /*=======================================================================*/
 
-static struct irqaction icu_cascade = {no_action, 0, 0, "cascade", NULL, NULL};
+static struct irqaction icu_cascade = {no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 static void __init vr41xx_icu_init(void)
 {
Index: mm1-2.6.7-rc3/arch/mips/momentum/jaguar_atx/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/momentum/jaguar_atx/irq.c	2004-06-07 12:14:34.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/momentum/jaguar_atx/irq.c	2004-06-09 10:40:13.781940000 -0700
@@ -42,7 +42,7 @@
 extern asmlinkage void jaguar_handle_int(void);
 
 static struct irqaction cascade_mv64340 = {
-	no_action, SA_INTERRUPT, 0, "MV64340-Cascade", NULL, NULL
+	no_action, SA_INTERRUPT, CPU_MASK_NONE, "MV64340-Cascade", NULL, NULL
 };
 
 void __init init_IRQ(void)
Index: mm1-2.6.7-rc3/arch/mips/momentum/ocelot_c/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/momentum/ocelot_c/irq.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/momentum/ocelot_c/irq.c	2004-06-09 10:40:13.806936000 -0700
@@ -53,11 +53,11 @@
 extern void cpci_irq_init(void);
 
 static struct irqaction cascade_fpga = {
-	no_action, SA_INTERRUPT, 0, "cascade via FPGA", NULL, NULL
+	no_action, SA_INTERRUPT, CPU_MASK_NONE, "cascade via FPGA", NULL, NULL
 };
 
 static struct irqaction cascade_mv64340 = {
-	no_action, SA_INTERRUPT, 0, "cascade via MV64340", NULL, NULL
+	no_action, SA_INTERRUPT, CPU_MASK_NONE, "cascade via MV64340", NULL, NULL
 };
 
 void __init init_IRQ(void)
Index: mm1-2.6.7-rc3/arch/mips/jmr3927/rbhma3100/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/jmr3927/rbhma3100/irq.c	2004-06-07 12:14:10.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/jmr3927/rbhma3100/irq.c	2004-06-09 10:40:13.850929000 -0700
@@ -301,7 +301,7 @@
 }
 
 static struct irqaction ioc_action = {
-	jmr3927_ioc_interrupt, 0, 0, "IOC", NULL, NULL,
+	jmr3927_ioc_interrupt, 0, CPU_MASK_NONE, "IOC", NULL, NULL,
 };
 
 static void jmr3927_isac_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -318,7 +318,7 @@
 }
 
 static struct irqaction isac_action = {
-	jmr3927_isac_interrupt, 0, 0, "ISAC", NULL, NULL,
+	jmr3927_isac_interrupt, 0, CPU_MASK_NONE, "ISAC", NULL, NULL,
 };
 
 
@@ -327,7 +327,7 @@
 	printk(KERN_WARNING "ISA error interrupt (irq 0x%x).\n", irq);
 }
 static struct irqaction isaerr_action = {
-	jmr3927_isaerr_interrupt, 0, 0, "ISA error", NULL, NULL,
+	jmr3927_isaerr_interrupt, 0, CPU_MASK_NONE, "ISA error", NULL, NULL,
 };
 
 static void jmr3927_pcierr_interrupt(int irq, void * dev_id, struct pt_regs * regs)
@@ -337,7 +337,7 @@
 	       tx3927_pcicptr->pcistat, tx3927_pcicptr->lbstat);
 }
 static struct irqaction pcierr_action = {
-	jmr3927_pcierr_interrupt, 0, 0, "PCI error", NULL, NULL,
+	jmr3927_pcierr_interrupt, 0, CPU_MASK_NONE, "PCI error", NULL, NULL,
 };
 
 int jmr3927_ether1_irq = 0;
Index: mm1-2.6.7-rc3/arch/mips/ddb5xxx/ddb5074/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/ddb5xxx/ddb5074/irq.c	2004-06-07 12:15:11.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/ddb5xxx/ddb5074/irq.c	2004-06-09 10:40:13.880925000 -0700
@@ -24,7 +24,7 @@
 
 extern asmlinkage void ddbIRQ(void);
 
-static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
+static struct irqaction irq_cascade = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL };
 
 #define M1543_PNP_CONFIG	0x03f0	/* PnP Config Port */
 #define M1543_PNP_INDEX		0x03f0	/* PnP Index Port */
Index: mm1-2.6.7-rc3/arch/mips/ddb5xxx/ddb5477/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/ddb5xxx/ddb5477/irq.c	2004-06-07 12:13:39.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/ddb5xxx/ddb5477/irq.c	2004-06-09 10:40:13.901922000 -0700
@@ -77,7 +77,7 @@
 extern void mips_cpu_irq_init(u32 base);
 extern asmlinkage void ddb5477_handle_int(void);
 extern int setup_irq(unsigned int irq, struct irqaction *irqaction);  
-static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
+static struct irqaction irq_cascade = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL };
 
 void
 ddb5477_irq_setup(void)
Index: mm1-2.6.7-rc3/arch/mips/ddb5xxx/ddb5476/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/ddb5xxx/ddb5476/irq.c	2004-06-07 12:14:57.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/ddb5xxx/ddb5476/irq.c	2004-06-09 10:40:13.924918000 -0700
@@ -107,8 +107,8 @@
 	/* memory resource acquire in ddb_setup */
 }
 
-static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
-static struct irqaction irq_error = { no_action, 0, 0, "error", NULL, NULL };
+static struct irqaction irq_cascade = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL };
+static struct irqaction irq_error = { no_action, 0, CPU_MASK_NONE, "error", NULL, NULL };
 
 extern asmlinkage void ddb5476_handle_int(void);
 extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
Index: mm1-2.6.7-rc3/arch/mips/sibyte/sb1250/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/sibyte/sb1250/irq.c	2004-06-07 12:14:59.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/sibyte/sb1250/irq.c	2004-06-09 10:40:13.969911000 -0700
@@ -279,7 +279,7 @@
 static struct irqaction sb1250_dummy_action = {
 	.handler = sb1250_dummy_handler,
 	.flags   = 0,
-	.mask    = 0,
+	.mask    = CPU_MASK_NONE,
 	.name    = "sb1250-private",
 	.next    = NULL,
 	.dev_id  = 0
Index: mm1-2.6.7-rc3/arch/mips/tx4927/common/tx4927_irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/tx4927/common/tx4927_irq.c	2004-06-07 12:15:11.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/tx4927/common/tx4927_irq.c	2004-06-09 10:40:14.010905000 -0700
@@ -172,7 +172,7 @@
 	.set_affinity	= NULL
 };
 
-#define TX4927_PIC_ACTION(s) { no_action, 0, 0, s, NULL, NULL }
+#define TX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
 static struct irqaction tx4927_irq_pic_action =
 TX4927_PIC_ACTION(TX4927_PIC_NAME);
 
Index: mm1-2.6.7-rc3/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2004-06-07 12:14:04.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2004-06-09 10:40:14.037901000 -0700
@@ -337,8 +337,8 @@
 	return (sw_irq);
 }
 
-//#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, 0, 0, s, NULL, NULL }
-#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, SA_SHIRQ, 0, s, NULL, NULL }
+//#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
+#define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, SA_SHIRQ, CPU_MASK_NONE, s, NULL, NULL }
 static struct irqaction toshiba_rbtx4927_irq_ioc_action =
 TOSHIBA_RBTX4927_PIC_ACTION(TOSHIBA_RBTX4927_IOC_NAME);
 #ifdef CONFIG_TOSHIBA_FPCIB0
Index: mm1-2.6.7-rc3/arch/mips/sgi-ip32/ip32-irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/mips/sgi-ip32/ip32-irq.c	2004-06-07 12:14:24.000000000 -0700
+++ mm1-2.6.7-rc3/arch/mips/sgi-ip32/ip32-irq.c	2004-06-09 10:40:14.082894000 -0700
@@ -123,9 +123,9 @@
 				      struct pt_regs *regs);
 
 struct irqaction memerr_irq = { crime_memerr_intr, SA_INTERRUPT,
-				0, "CRIME memory error", NULL, NULL };
+			CPU_MASK_NONE, "CRIME memory error", NULL, NULL };
 struct irqaction cpuerr_irq = { crime_cpuerr_intr, SA_INTERRUPT,
-				0, "CRIME CPU error", NULL, NULL };
+			CPU_MASK_NONE, "CRIME CPU error", NULL, NULL };
 
 extern void ip32_handle_int(void);
 
Index: mm1-2.6.7-rc3/arch/parisc/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/parisc/kernel/irq.c	2004-06-07 12:14:05.000000000 -0700
+++ mm1-2.6.7-rc3/arch/parisc/kernel/irq.c	2004-06-09 10:40:14.151884000 -0700
@@ -644,7 +644,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/ppc64/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/ppc64/kernel/irq.c	2004-06-09 07:11:49.715847000 -0700
+++ mm1-2.6.7-rc3/arch/ppc64/kernel/irq.c	2004-06-09 10:40:14.181879000 -0700
@@ -206,7 +206,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->dev_id = dev_id;
 	action->next = NULL;
Index: mm1-2.6.7-rc3/arch/sh/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sh/kernel/irq.c	2004-06-07 12:14:05.000000000 -0700
+++ mm1-2.6.7-rc3/arch/sh/kernel/irq.c	2004-06-09 10:40:14.243870000 -0700
@@ -436,7 +436,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/sh/kernel/time.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sh/kernel/time.c	2004-06-07 12:13:34.000000000 -0700
+++ mm1-2.6.7-rc3/arch/sh/kernel/time.c	2004-06-09 10:40:14.278864000 -0700
@@ -391,7 +391,7 @@
 }
 __setup("sh_pclk=", sh_pclk_setup);
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
 
 void get_current_frequency_divisors(unsigned int *ifc, unsigned int *bfc, unsigned int *pfc)
 {
Index: mm1-2.6.7-rc3/arch/sh/cchips/hd6446x/hd64465/setup.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sh/cchips/hd6446x/hd64465/setup.c	2004-06-07 12:15:12.000000000 -0700
+++ mm1-2.6.7-rc3/arch/sh/cchips/hd6446x/hd64465/setup.c	2004-06-09 10:40:14.334856000 -0700
@@ -154,7 +154,7 @@
 	return irq;
 }
 
-static struct irqaction irq0  = { hd64465_interrupt, SA_INTERRUPT, 0, "HD64465", NULL, NULL};
+static struct irqaction irq0  = { hd64465_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "HD64465", NULL, NULL};
 
 
 static int __init setup_hd64465(void)
Index: mm1-2.6.7-rc3/arch/sh/cchips/hd6446x/hd64461/setup.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sh/cchips/hd6446x/hd64461/setup.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/sh/cchips/hd6446x/hd64461/setup.c	2004-06-09 10:40:14.355853000 -0700
@@ -134,7 +134,7 @@
 	return __irq_demux(irq);
 }
 
-static struct irqaction irq0 = { hd64461_interrupt, SA_INTERRUPT, 0, "HD64461", NULL, NULL };
+static struct irqaction irq0 = { hd64461_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "HD64461", NULL, NULL };
 
 int __init setup_hd64461(void)
 {
Index: mm1-2.6.7-rc3/arch/sparc/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sparc/kernel/irq.c	2004-06-07 12:13:36.000000000 -0700
+++ mm1-2.6.7-rc3/arch/sparc/kernel/irq.c	2004-06-09 10:40:14.433841000 -0700
@@ -449,7 +449,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->dev_id = NULL;
 	action->next = NULL;
@@ -529,7 +529,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/sparc/kernel/sun4d_irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sparc/kernel/sun4d_irq.c	2004-06-07 12:13:34.000000000 -0700
+++ mm1-2.6.7-rc3/arch/sparc/kernel/sun4d_irq.c	2004-06-09 10:40:14.477834000 -0700
@@ -336,7 +336,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/sparc64/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sparc64/kernel/irq.c	2004-06-09 07:11:45.739451000 -0700
+++ mm1-2.6.7-rc3/arch/sparc64/kernel/irq.c	2004-06-09 10:55:57.626454000 -0700
@@ -118,10 +118,6 @@
 		action->flags |= __irq_ino(irq) << 48;
 #define get_ino_in_irqaction(action)	(action->flags >> 48)
 
-#if NR_CPUS > 64
-#error irqaction embedded smp affinity does not work with > 64 cpus, FIXME
-#endif
-
 #define put_smpaff_in_irqaction(action, smpaff)	(action)->mask = (smpaff)
 #define get_smpaff_in_irqaction(action) 	((action)->mask)
 
@@ -454,7 +450,7 @@
 	action->next = NULL;
 	action->dev_id = dev_id;
 	put_ino_in_irqaction(action, irq);
-	put_smpaff_in_irqaction(action, 0);
+	put_smpaff_in_irqaction(action, CPU_MASK_NONE);
 
 	if (tmp)
 		tmp->next = action;
@@ -690,7 +686,7 @@
 	cpumask_t cpu_mask;
 	unsigned int buddy, ticks;
 
-	cpus_addr(cpu_mask)[0] = get_smpaff_in_irqaction(ap);
+	cpu_mask = get_smpaff_in_irqaction(ap);
 	cpus_and(cpu_mask, cpu_mask, cpu_online_map);
 	if (cpus_empty(cpu_mask))
 		cpu_mask = cpu_online_map;
@@ -711,7 +707,7 @@
 		if (++buddy >= NR_CPUS)
 			buddy = 0;
 		if (++ticks > NR_CPUS) {
-			put_smpaff_in_irqaction(ap, 0);
+			put_smpaff_in_irqaction(ap, CPU_MASK_NONE);
 			goto out;
 		}
 	}
@@ -945,7 +941,7 @@
 	action->name = name;
 	action->next = NULL;
 	put_ino_in_irqaction(action, irq);
-	put_smpaff_in_irqaction(action, 0);
+	put_smpaff_in_irqaction(action, CPU_MASK_NONE);
 
 	*(bucket->pil + irq_action) = action;
 	enable_irq(irq);
@@ -1163,45 +1159,6 @@
 
 #ifdef CONFIG_SMP
 
-#define HEX_DIGITS 16
-
-static unsigned int parse_hex_value (const char __user *buffer,
-		unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value = 0;
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		value = (value << 4) | c;
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -1210,7 +1167,7 @@
 	cpumask_t mask;
 	int len;
 
-	cpus_addr(mask)[0] = get_smpaff_in_irqaction(ap);
+	mask = get_smpaff_in_irqaction(ap);
 	if (cpus_empty(mask))
 		mask = cpu_online_map;
 
@@ -1221,7 +1178,7 @@
 	return len;
 }
 
-static inline void set_intr_affinity(int irq, unsigned long hw_aff)
+static inline void set_intr_affinity(int irq, cpumask_t hw_aff)
 {
 	struct ino_bucket *bp = ivector_table + irq;
 
@@ -1239,22 +1196,17 @@
 					unsigned long count, void *data)
 {
 	int irq = (long) data, full_count = count, err;
-	unsigned long new_value, i;
+	cpumask_t new_value;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 	/*
 	 * Do not allow disabling IRQs completely - it's a too easy
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	for (i = 0; i < NR_CPUS; i++) {
-		if ((new_value & (1UL << i)) != 0 &&
-		    !cpu_online(i))
-			new_value &= ~(1UL << i);
-	}
-
-	if (!new_value)
+	cpus_and(new_value, new_value, cpu_online_map);
+	if (cpus_empty(new_value))
 		return -EINVAL;
 
 	set_intr_affinity(irq, new_value);
Index: mm1-2.6.7-rc3/arch/sparc64/kernel/smp.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/sparc64/kernel/smp.c	2004-06-09 07:11:49.087942000 -0700
+++ mm1-2.6.7-rc3/arch/sparc64/kernel/smp.c	2004-06-09 10:40:14.539825000 -0700
@@ -414,9 +414,6 @@
  * packet, but we have no use for that.  However we do take advantage of
  * the new pipelining feature (ie. dispatch to multiple cpus simultaneously).
  */
-#if NR_CPUS > 32
-#error Fixup cheetah_xcall_deliver Dave...
-#endif
 static void cheetah_xcall_deliver(u64 data0, u64 data1, u64 data2, cpumask_t mask)
 {
 	u64 pstate, ver;
Index: mm1-2.6.7-rc3/arch/um/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/um/kernel/irq.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/um/kernel/irq.c	2004-06-09 10:40:14.575819000 -0700
@@ -419,7 +419,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/v850/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/v850/kernel/irq.c	2004-06-07 12:14:56.000000000 -0700
+++ mm1-2.6.7-rc3/arch/v850/kernel/irq.c	2004-06-09 10:40:14.611814000 -0700
@@ -392,7 +392,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/v850/kernel/time.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/v850/kernel/time.c	2004-06-07 12:14:42.000000000 -0700
+++ mm1-2.6.7-rc3/arch/v850/kernel/time.c	2004-06-09 10:40:14.628811000 -0700
@@ -203,7 +203,7 @@
 static struct irqaction timer_irqaction = {
 	timer_interrupt,
 	SA_INTERRUPT,
-	0,
+	CPU_MASK_NONE,
 	"timer",
 	&timer_dev_id,
 	NULL
Index: mm1-2.6.7-rc3/arch/v850/kernel/fpga85e2c.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/v850/kernel/fpga85e2c.c	2004-06-07 12:14:58.000000000 -0700
+++ mm1-2.6.7-rc3/arch/v850/kernel/fpga85e2c.c	2004-06-09 10:40:14.642809000 -0700
@@ -168,5 +168,5 @@
 
 static int reg_snap_dev_id;
 static struct irqaction reg_snap_action = {
-	make_reg_snap, 0, 0, "reg_snap", &reg_snap_dev_id, 0
+	make_reg_snap, 0, CPU_MASK_NONE, "reg_snap", &reg_snap_dev_id, 0
 };
Index: mm1-2.6.7-rc3/arch/x86_64/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/x86_64/kernel/irq.c	2004-06-09 07:10:24.000000000 -0700
+++ mm1-2.6.7-rc3/arch/x86_64/kernel/irq.c	2004-06-09 10:40:14.688802000 -0700
@@ -491,7 +491,7 @@
 
 	action->handler = handler;
 	action->flags = irqflags;
-	action->mask = 0;
+	cpus_clear(action->mask);
 	action->name = devname;
 	action->next = NULL;
 	action->dev_id = dev_id;
Index: mm1-2.6.7-rc3/arch/x86_64/kernel/i8259.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/x86_64/kernel/i8259.c	2004-06-09 07:11:50.439737000 -0700
+++ mm1-2.6.7-rc3/arch/x86_64/kernel/i8259.c	2004-06-09 10:40:14.701800000 -0700
@@ -390,7 +390,7 @@
  * IRQ2 is cascade interrupt to second interrupt controller
  */
 
-static struct irqaction irq2 = { no_action, 0, 0, "cascade", NULL, NULL};
+static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 void __init init_ISA_irqs (void)
 {
Index: mm1-2.6.7-rc3/arch/x86_64/kernel/time.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/x86_64/kernel/time.c	2004-06-07 12:14:42.000000000 -0700
+++ mm1-2.6.7-rc3/arch/x86_64/kernel/time.c	2004-06-09 10:40:14.736795000 -0700
@@ -689,7 +689,7 @@
 }
 
 static struct irqaction irq0 = {
-	timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL
+	timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL
 };
 
 extern void __init config_acpi_tables(void);
