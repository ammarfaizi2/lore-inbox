Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbTCOBoQ>; Fri, 14 Mar 2003 20:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTCOBoP>; Fri, 14 Mar 2003 20:44:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:61142 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261300AbTCOBoC>; Fri, 14 Mar 2003 20:44:02 -0500
Message-ID: <3E7285E7.8080802@us.ibm.com>
Date: Fri, 14 Mar 2003 17:46:15 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [patch] NUMAQ subarchification
References: <1047676332.5409.374.camel@mulgrave> <3E7284CA.6010907@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010605090306000306060002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010605090306000306060002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
>> This patch adds a new file, arch/i386/kernel/summit.c, for 
>> summit-specific code.  Adds some structures to mach_mpparse.h.  Also 
>> adds a hook in setup_arch() to dig out the PCI info, and stores it in 
>> the mp_bus_id_to_node[] array, where it can be read by the topology 
>> functions.
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

While I was at it, I subarchified (I'll cc Websters with the new word ;) 
numaq as well.  Copied mach-defaults setup.c, topology.c, and Makefile. 
  Moved arch/i386/kernel/numaq.c into mach-numaq.  Compiles.

Cheers!

-Matt

--------------010605090306000306060002
Content-Type: text/plain;
 name="numaq_subarch-2.5.64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numaq_subarch-2.5.64.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/Makefile linux-2.5.64-numaq_subarch/arch/i386/Makefile
--- linux-2.5.64-vanilla/arch/i386/Makefile	Tue Mar  4 19:29:16 2003
+++ linux-2.5.64-numaq_subarch/arch/i386/Makefile	Fri Mar 14 15:28:53 2003
@@ -61,14 +61,14 @@
 mflags-$(CONFIG_X86_VISWS)	:= -Iinclude/asm-i386/mach-visws
 mcore-$(CONFIG_X86_VISWS)	:= mach-visws
 
-# NUMAQ subarch support
-mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
-mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
-
 # BIGSMP subarch support
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
 mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
 
+# NUMAQ subarch support
+mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
+mcore-$(CONFIG_X86_NUMAQ)	:= mach-numaq
+
 #Summit subarch support
 mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
 mcore-$(CONFIG_X86_SUMMIT)  := mach-default
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/kernel/Makefile linux-2.5.64-numaq_subarch/arch/i386/kernel/Makefile
--- linux-2.5.64-vanilla/arch/i386/kernel/Makefile	Tue Mar  4 19:29:01 2003
+++ linux-2.5.64-numaq_subarch/arch/i386/kernel/Makefile	Fri Mar 14 15:29:40 2003
@@ -24,7 +24,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
-obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/kernel/numaq.c linux-2.5.64-numaq_subarch/arch/i386/kernel/numaq.c
--- linux-2.5.64-vanilla/arch/i386/kernel/numaq.c	Tue Mar  4 19:29:32 2003
+++ linux-2.5.64-numaq_subarch/arch/i386/kernel/numaq.c	Wed Dec 31 16:00:00 1969
@@ -1,127 +0,0 @@
-/*
- * Written by: Patricia Gaughen, IBM Corporation
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
- * Send feedback to <gone@us.ibm.com>
- */
-
-#include <linux/config.h>
-#include <linux/mm.h>
-#include <linux/bootmem.h>
-#include <linux/mmzone.h>
-#include <linux/module.h>
-#include <asm/numaq.h>
-
-/* These are needed before the pgdat's are created */
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
-
-#define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
-
-/*
- * Function: smp_dump_qct()
- *
- * Description: gets memory layout from the quad config table.  This
- * function also increments numnodes with the number of nodes (quads)
- * present.
- */
-static void __init smp_dump_qct(void)
-{
-	int node;
-	struct eachquadmem *eq;
-	struct sys_cfg_data *scd =
-		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
-
-	numnodes = 0;
-	for(node = 0; node < MAX_NUMNODES; node++) {
-		if(scd->quads_present31_0 & (1 << node)) {
-			node_set_online(node);
-			numnodes++;
-			eq = &scd->eq[node];
-			/* Convert to pages */
-			node_start_pfn[node] = MB_TO_PAGES(
-				eq->hi_shrd_mem_start - eq->priv_mem_size);
-			node_end_pfn[node] = MB_TO_PAGES(
-				eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
-		}
-	}
-}
-
-/*
- * -----------------------------------------
- *
- * functions related to physnode_map
- *
- * -----------------------------------------
- */
-/*
- * physnode_map keeps track of the physical memory layout of the
- * numaq nodes on a 256Mb break (each element of the array will
- * represent 256Mb of memory and will be marked by the node id.  so,
- * if the first gig is on node 0, and the second gig is on node 1
- * physnode_map will contain:
- * physnode_map[0-3] = 0;
- * physnode_map[4-7] = 1;
- * physnode_map[8- ] = -1;
- */
-int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
-EXPORT_SYMBOL(physnode_map);
-
-/*
- * for each node mark the regions
- *        TOPOFMEM = hi_shrd_mem_start + hi_shrd_mem_size
- *
- * need to be very careful to not mark 1024+ as belonging
- * to node 0. will want 1027 to show as belonging to node 1
- * example:
- *  TOPOFMEM = 1024
- * 1024 >> 8 = 4 (subtract 1 for starting at 0]
- * tmpvar = TOPOFMEM - 256 = 768
- * 1024 >> 8 = 4 (subtract 1 for starting at 0]
- * 
- */
-static void __init initialize_physnode_map(void)
-{
-	int nid;
-	unsigned int topofmem, cur;
-	struct eachquadmem *eq;
- 	struct sys_cfg_data *scd =
-		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
-
-	
-	for(nid = 0; nid < numnodes; nid++) {
-		if(scd->quads_present31_0 & (1 << nid)) {
-			eq = &scd->eq[nid];
-			cur = eq->hi_shrd_mem_start;
-			topofmem = eq->hi_shrd_mem_start + eq->hi_shrd_mem_size;
-			while (cur < topofmem) {
-				physnode_map[cur >> 8] = nid;
-				cur ++;
-			}
-		}
-	}
-}
-
-void __init get_memcfg_numaq(void)
-{
-	smp_dump_qct();
-	initialize_physnode_map();
-}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-numaq/Makefile linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/Makefile
--- linux-2.5.64-vanilla/arch/i386/mach-numaq/Makefile	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/Makefile	Fri Mar 14 15:40:55 2003
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux kernel.
+#
+
+EXTRA_CFLAGS	+= -I../kernel
+
+obj-y				:= setup.o topology.o numaq.o
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-numaq/numaq.c linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/numaq.c
--- linux-2.5.64-vanilla/arch/i386/mach-numaq/numaq.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/numaq.c	Tue Mar  4 19:29:32 2003
@@ -0,0 +1,127 @@
+/*
+ * Written by: Patricia Gaughen, IBM Corporation
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
+ * Send feedback to <gone@us.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/mmzone.h>
+#include <linux/module.h>
+#include <asm/numaq.h>
+
+/* These are needed before the pgdat's are created */
+unsigned long node_start_pfn[MAX_NUMNODES];
+unsigned long node_end_pfn[MAX_NUMNODES];
+
+#define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
+
+/*
+ * Function: smp_dump_qct()
+ *
+ * Description: gets memory layout from the quad config table.  This
+ * function also increments numnodes with the number of nodes (quads)
+ * present.
+ */
+static void __init smp_dump_qct(void)
+{
+	int node;
+	struct eachquadmem *eq;
+	struct sys_cfg_data *scd =
+		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
+
+	numnodes = 0;
+	for(node = 0; node < MAX_NUMNODES; node++) {
+		if(scd->quads_present31_0 & (1 << node)) {
+			node_set_online(node);
+			numnodes++;
+			eq = &scd->eq[node];
+			/* Convert to pages */
+			node_start_pfn[node] = MB_TO_PAGES(
+				eq->hi_shrd_mem_start - eq->priv_mem_size);
+			node_end_pfn[node] = MB_TO_PAGES(
+				eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
+		}
+	}
+}
+
+/*
+ * -----------------------------------------
+ *
+ * functions related to physnode_map
+ *
+ * -----------------------------------------
+ */
+/*
+ * physnode_map keeps track of the physical memory layout of the
+ * numaq nodes on a 256Mb break (each element of the array will
+ * represent 256Mb of memory and will be marked by the node id.  so,
+ * if the first gig is on node 0, and the second gig is on node 1
+ * physnode_map will contain:
+ * physnode_map[0-3] = 0;
+ * physnode_map[4-7] = 1;
+ * physnode_map[8- ] = -1;
+ */
+int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+EXPORT_SYMBOL(physnode_map);
+
+/*
+ * for each node mark the regions
+ *        TOPOFMEM = hi_shrd_mem_start + hi_shrd_mem_size
+ *
+ * need to be very careful to not mark 1024+ as belonging
+ * to node 0. will want 1027 to show as belonging to node 1
+ * example:
+ *  TOPOFMEM = 1024
+ * 1024 >> 8 = 4 (subtract 1 for starting at 0]
+ * tmpvar = TOPOFMEM - 256 = 768
+ * 1024 >> 8 = 4 (subtract 1 for starting at 0]
+ * 
+ */
+static void __init initialize_physnode_map(void)
+{
+	int nid;
+	unsigned int topofmem, cur;
+	struct eachquadmem *eq;
+ 	struct sys_cfg_data *scd =
+		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
+
+	
+	for(nid = 0; nid < numnodes; nid++) {
+		if(scd->quads_present31_0 & (1 << nid)) {
+			eq = &scd->eq[nid];
+			cur = eq->hi_shrd_mem_start;
+			topofmem = eq->hi_shrd_mem_start + eq->hi_shrd_mem_size;
+			while (cur < topofmem) {
+				physnode_map[cur >> 8] = nid;
+				cur ++;
+			}
+		}
+	}
+}
+
+void __init get_memcfg_numaq(void)
+{
+	smp_dump_qct();
+	initialize_physnode_map();
+}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-numaq/setup.c linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/setup.c
--- linux-2.5.64-vanilla/arch/i386/mach-numaq/setup.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/setup.c	Fri Mar 14 15:42:17 2003
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/arch/i386/mach-numaq/topology.c linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/topology.c
--- linux-2.5.64-vanilla/arch/i386/mach-numaq/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.64-numaq_subarch/arch/i386/mach-numaq/topology.c	Fri Mar 14 15:42:17 2003
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

--------------010605090306000306060002--

