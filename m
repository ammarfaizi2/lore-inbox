Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263716AbTCUTQp>; Fri, 21 Mar 2003 14:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263717AbTCUTOU>; Fri, 21 Mar 2003 14:14:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41860
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262726AbTCUTNl>; Fri, 21 Mar 2003 14:13:41 -0500
Date: Fri, 21 Mar 2003 20:28:57 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212028.h2LKSv5c026353@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add pc9800 setup and topology code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/mach-pc9800/Makefile linux-2.5.65-ac2/arch/i386/mach-pc9800/Makefile
--- linux-2.5.65/arch/i386/mach-pc9800/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/mach-pc9800/Makefile	2003-02-20 16:28:14.000000000 +0000
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= setup.o topology.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/mach-pc9800/setup.c linux-2.5.65-ac2/arch/i386/mach-pc9800/setup.c
--- linux-2.5.65/arch/i386/mach-pc9800/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/mach-pc9800/setup.c	2003-03-20 18:43:51.000000000 +0000
@@ -0,0 +1,117 @@
+/*
+ *	Machine specific setup for pc9800
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/apm_bios.h>
+#include <asm/setup.h>
+#include <asm/arch_hooks.h>
+
+struct sys_desc_table_struct {
+	unsigned short length;
+	unsigned char table[0];
+};
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
+ * IRQ7 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq7 = { no_action, 0, 0, "cascade", NULL, NULL};
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
+	setup_irq(7, &irq7);
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
+	SYS_DESC_TABLE.length = 0;
+	MCA_bus = 0;
+	/* In PC-9800, APM BIOS version is written in BCD...?? */
+	APM_BIOS_INFO.version = (APM_BIOS_INFO.version & 0xff00)
+				| ((APM_BIOS_INFO.version & 0x00f0) >> 4);
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
+ *	The MCA (Microchannel Architecture) has an NMI chain for NMI sources
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/mach-pc9800/topology.c linux-2.5.65-ac2/arch/i386/mach-pc9800/topology.c
--- linux-2.5.65/arch/i386/mach-pc9800/topology.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/arch/i386/mach-pc9800/topology.c	2003-03-14 01:21:57.000000000 +0000
@@ -0,0 +1,44 @@
+/*
+ * arch/i386/mach-pc9800/topology.c - Populate driverfs with topology information
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
+ * Modify for PC-9800 by Osamu Tomita <tomita@cinet.co.jp>
+ *
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/cpu.h>
+
+struct i386_cpu cpu_devices[NR_CPUS];
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
+subsys_initcall(topology_init);
