Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTCOBkh>; Fri, 14 Mar 2003 20:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTCOBkh>; Fri, 14 Mar 2003 20:40:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:61652 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261290AbTCOBkc>; Fri, 14 Mar 2003 20:40:32 -0500
Message-ID: <3E7284CA.6010907@us.ibm.com>
Date: Fri, 14 Mar 2003 17:41:30 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [patch] Summit support for pcibus <-> cpumask topology [1/2]
References: <1047676332.5409.374.camel@mulgrave>
Content-Type: multipart/mixed;
 boundary="------------040108060806090908000507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040108060806090908000507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
> 
>>This patch adds a new file, arch/i386/kernel/summit.c, for 
>>summit-specific code.  Adds some structures to mach_mpparse.h.  Also 
>>adds a hook in setup_arch() to dig out the PCI info, and stores it in 
>>the mp_bus_id_to_node[] array, where it can be read by the topology 
>>functions.
> 
> 
> Wouldn't this file be better in arch/i386/mach-summit in keeping with
> all the other subarch stuff?
> 
> While you're creating a separate file for summit, could you move the
> summit specific variables (mpparse.c:x86_summit is the only one, I
> think) into it so we can clean all the summit references out of the main
> line?
> 
> Thanks,
> 
> James

Ok...  Split into two patches now.  Patch 1 moves summit stuff into 
subarch.  Just creates the directory and populates it with setup.c, 
topology.c, and the Makefile from mach-default.  Also creates a summit.c 
which only has the x86_summit variable you referred to.

Patch 2 adds all pcimapping code, but adds it in the subarch dir, not 
i386/kernel/.

Cheers!

-Matt

--------------040108060806090908000507
Content-Type: text/plain;
 name="summit_subarch-2.5.64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="summit_subarch-2.5.64.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/Makefile linux-2.5.64-summit_subarch/arch/i386/Makefile
--- linux-2.5.64-vanilla/arch/i386/Makefile	Tue Mar  4 19:29:16 2003
+++ linux-2.5.64-summit_subarch/arch/i386/Makefile	Fri Mar 14 17:32:48 2003
@@ -71,7 +71,7 @@
 
 #Summit subarch support
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
-mcore-$(CONFIG_X86_SUMMIT)  := mach-default
+mcore-$(CONFIG_X86_SUMMIT)  := mach-summit
 
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/kernel/mpparse.c linux-2.5.64-summit_subarch/arch/i386/kernel/mpparse.c
--- linux-2.5.64-vanilla/arch/i386/kernel/mpparse.c	Tue Mar  4 19:29:05 2003
+++ linux-2.5.64-summit_subarch/arch/i386/kernel/mpparse.c	Fri Mar 14 17:32:48 2003
@@ -72,7 +72,6 @@
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
-int x86_summit = 0;
 u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /*
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-summit/Makefile linux-2.5.64-summit_subarch/arch/i386/mach-summit/Makefile
--- linux-2.5.64-vanilla/arch/i386/mach-summit/Makefile	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-summit_subarch/arch/i386/mach-summit/Makefile	Fri Mar 14 17:32:48 2003
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= setup.o topology.o summit.o
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-summit/setup.c linux-2.5.64-summit_subarch/arch/i386/mach-summit/setup.c
--- linux-2.5.64-vanilla/arch/i386/mach-summit/setup.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-summit_subarch/arch/i386/mach-summit/setup.c	Fri Mar 14 17:32:48 2003
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-summit/summit.c linux-2.5.64-summit_subarch/arch/i386/mach-summit/summit.c
--- linux-2.5.64-vanilla/arch/i386/mach-summit/summit.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-summit_subarch/arch/i386/mach-summit/summit.c	Fri Mar 14 17:32:48 2003
@@ -0,0 +1,29 @@
+/*
+ * arch/i386/kernel/summit.c - IBM Summit-Specific Code
+ *
+ * Written By: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (c) 2003 IBM Corp.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
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
+ *
+ */
+
+int x86_summit = 0;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-summit/topology.c linux-2.5.64-summit_subarch/arch/i386/mach-summit/topology.c
--- linux-2.5.64-vanilla/arch/i386/mach-summit/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-summit_subarch/arch/i386/mach-summit/topology.c	Fri Mar 14 17:32:48 2003
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

--------------040108060806090908000507--

