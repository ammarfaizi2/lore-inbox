Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbSK2TL2>; Fri, 29 Nov 2002 14:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbSK2TL2>; Fri, 29 Nov 2002 14:11:28 -0500
Received: from host194.steeleye.com ([66.206.164.34]:2064 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267131AbSK2TLV>; Fri, 29 Nov 2002 14:11:21 -0500
Message-Id: <200211291918.gATJIUQ03127@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: "Martin J. Bligh" <mbligh@aracnet.com>, wli@holomorphy.com,
       mochel@osdl.org, James.Bottomley@HansenPartnership.com
Subject: [RFC] rethinking the topology functions
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-16826176640"
Date: Fri, 29 Nov 2002 13:18:30 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-16826176640
Content-Type: text/plain; charset=us-ascii

The attached represents an initial stab at implementing topology functions (or 
actually indirecting topology through the subarchitecture features).

Getting this far made me realise that the current topology infrastructure is 
rather inadequate (being geared towards the needs of NUMA machines).

All I really need for voyager is the concept of cpu_nodes (voyager CPU cards 
have huge L3 caches and up to 4 CPUs each, so scheduling between CPU cards can 
end up rather expensive in terms of cache invalidation).  I have no use for 
memory affinities since the voyager memory map is uniform.

I'd like to rework the current sysfs cpu/node pieces to provide two separate 
topologies (one for CPU and one for memory).

Ultimately, the scheduler could be tuned to use the topologies to make 
scheduling decisions.  When that happens, we can probably fold the current 
Pentium Hyperthreading stuff into a simple topology map as well.

I believe Martin Bligh and Bill Irwin are working (or at least thinking) 
somewhat along these lines, so I thought I'd gather feedback before jumping 
into a wholesale rewrite.

James Bottomley


--==_Exmh_-16826176640
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.934   -> 1.935  
#	include/asm-i386/voyager.h	1.3     -> 1.4    
#	   arch/i386/Kconfig	1.16    -> 1.17   
#	 drivers/base/node.c	1.3     -> 1.4    
#	include/asm-i386/topology.h	1.2     -> 1.3    
#	include/asm-i386/numnodes.h	1.2     -> 1.3    
#	arch/i386/mach-voyager/voyager_cat.c	1.7     -> 1.8    
#	include/asm-i386/vic.h	1.4     -> 1.5    
#	arch/i386/mach-voyager/Makefile	1.9     -> 1.10   
#	drivers/base/Makefile	1.16    -> 1.17   
#	               (new)	        -> 1.1     arch/i386/mach-generic/machine_topology.h
#	               (new)	        -> 1.1     arch/i386/mach-voyager/topology.c
#	               (new)	        -> 1.1     arch/i386/mach-voyager/machine_topology.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/29	jejb@malley.(none)	1.935
# add topology to voyager
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Nov 29 13:01:29 2002
+++ b/arch/i386/Kconfig	Fri Nov 29 13:01:29 2002
@@ -1698,3 +1698,13 @@
 	bool
 	depends on SMP
 	default y
+
+config BASE_NODE
+	bool
+	depends on NUMA || VOYAGER
+	default y
+
+config X86_NUMNODES
+	int
+	default "8" if VOYAGER
+	default "1" if !VOYAGER
diff -Nru a/arch/i386/mach-generic/machine_topology.h b/arch/i386/mach-generic/machine_topology.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-generic/machine_topology.h	Fri Nov 29 13:01:29 2002
@@ -0,0 +1,96 @@
+/*
+ * linux/include/asm-i386/topology.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
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
+#ifndef _MACHINE_TOPOLOGY_H
+#define _MACHINE_TOPOLOGY_H
+
+#ifdef CONFIG_X86_NUMAQ
+
+#include <asm/smpboot.h>
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define __cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+
+/* Returns the number of the node containing MemBlk 'memblk' */
+#define __memblk_to_node(memblk) (memblk)
+
+/* Returns the number of the node containing Node 'node'.  This architecture is flat, 
+   so it is a pretty simple function! */
+#define __parent_node(node) (node)
+
+/* Returns the number of the first CPU on Node 'node'.
+ * This should be changed to a set of cached values
+ * but this will do for now.
+ */
+static inline int __node_to_first_cpu(int node)
+{
+	int i, cpu, logical_apicid = node << 4;
+
+	for(i = 1; i < 16; i <<= 1)
+		/* check to see if the cpu is in the system */
+		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
+			/* if yes, return it to caller */
+			return cpu;
+
+	BUG(); /* couldn't find a cpu on given node */
+	return -1;
+}
+
+/* Returns a bitmask of CPUs on Node 'node'.
+ * This should be changed to a set of cached bitmasks
+ * but this will do for now.
+ */
+static inline unsigned long __node_to_cpu_mask(int node)
+{
+	int i, cpu, logical_apicid = node << 4;
+	unsigned long mask = 0UL;
+
+	if (sizeof(unsigned long) * 8 < NR_CPUS)
+		BUG();
+
+	for(i = 1; i < 16; i <<= 1)
+		/* check to see if the cpu is in the system */
+		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
+			/* if yes, add to bitmask */
+			mask |= 1 << cpu;
+
+	return mask;
+}
+
+/* Returns the number of the first MemBlk on Node 'node' */
+#define __node_to_memblk(node) (node)
+
+#else /* !CONFIG_X86_NUMAQ */
+/*
+ * Other i386 platforms should define their own version of the 
+ * above macros here.
+ */
+
+#include <asm-generic/topology.h>
+
+#endif /* CONFIG_X86_NUMAQ */
+
+#endif
diff -Nru a/arch/i386/mach-voyager/Makefile b/arch/i386/mach-voyager/Makefile
--- a/arch/i386/mach-voyager/Makefile	Fri Nov 29 13:01:29 2002
+++ b/arch/i386/mach-voyager/Makefile	Fri Nov 29 13:01:29 2002
@@ -10,7 +10,7 @@
 EXTRA_CFLAGS	+= -I../kernel
 export-objs	:=
 
-obj-y			:= setup.o voyager_basic.o voyager_thread.o
+obj-y			:= setup.o voyager_basic.o voyager_thread.o topology.o
 
 obj-$(CONFIG_SMP)	+= voyager_smp.o voyager_cat.o
 
diff -Nru a/arch/i386/mach-voyager/machine_topology.h b/arch/i386/mach-voyager/machine_topology.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-voyager/machine_topology.h	Fri Nov 29 13:01:29 2002
@@ -0,0 +1,45 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* Copyright (C) 1999,2001
+ *
+ * Author: J.E.J.Bottomley@HansenPartnership.com
+ *
+ * linux/arch/i386/mach-voyager/machine_topology.h
+ */
+#include <asm/voyager.h>
+
+extern u32 voyager_node_to_cpu_mask[MAX_PROCESSOR_BOARDS];
+extern u8 voyager_cpu_to_node[NR_CPUS];
+extern u8 voyager_num_nodes;
+
+static inline u8 num_online_nodes(void)
+{
+	return voyager_num_nodes;
+}
+
+static inline int __cpu_to_node(int cpu)
+{
+	return voyager_cpu_to_node[cpu];
+}
+ 
+static inline int __node_to_first_cpu(int node)
+{
+	return ffs(voyager_node_to_cpu_mask[node]);
+}
+
+static inline unsigned long __node_to_cpu_mask(int node)
+{
+	return voyager_node_to_cpu_mask[node];
+}
+
+static inline int __parent_node(int node)
+{
+	return node;
+}
+
+/* FIXME: these are useless defines just to get topology to compile
+ * The code needs to be NUMA cleaned up to separate node from what
+ * NUMA thinks of as a node */
+#define __node_to_memblk(node) (node)
+#define si_meminfo_node(i, j)
+
diff -Nru a/arch/i386/mach-voyager/topology.c b/arch/i386/mach-voyager/topology.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/mach-voyager/topology.c	Fri Nov 29 13:01:29 2002
@@ -0,0 +1,51 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* Copyright (C) 2002
+ *
+ * Author: J.E.J.Bottomley@HansenPartnership.com
+ *
+ * voyager topology functions
+ */
+
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/cpu.h>
+#include <linux/smp.h>
+#include <asm/topology.h>
+
+/* Topology mapping functions */
+u32 voyager_node_to_cpu_mask[MAX_PROCESSOR_BOARDS] = { 0 };
+u8 voyager_cpu_to_node[NR_CPUS] = { 0 };
+u8 voyager_num_nodes = 0;
+
+struct i386_cpu cpu_devices[NR_CPUS];
+struct i386_node node_devices[MAX_NUMNODES];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	printk("VOYAGER BEGINNING TOPOLOGY INITIALISATION %d\n", MAX_NUMNODES);
+	memset(cpu_devices, 0, sizeof(cpu_devices));
+	memset(node_devices, 0, sizeof(node_devices));
+
+	for (i = 0; i < num_online_nodes(); i++)
+		arch_register_node(i);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+
+	printk("NODES %d\n", num_online_nodes());
+	printk("CPU TO NODE: ");
+	for(i=0; i<NR_CPUS; i++)
+		if(cpu_possible(i))
+			printk("%d->%d ", i, voyager_cpu_to_node[i]);
+	printk("\nNODE TO CPU MASK: ");
+	for(i=0; i<voyager_num_nodes; i++)
+		printk("%d->0x%04x ", i, voyager_node_to_cpu_mask[i]);
+	printk("\n");
+
+
+	return 0;
+}
+
+subsys_initcall(topology_init);
diff -Nru a/arch/i386/mach-voyager/voyager_cat.c b/arch/i386/mach-voyager/voyager_cat.c
--- a/arch/i386/mach-voyager/voyager_cat.c	Fri Nov 29 13:01:29 2002
+++ b/arch/i386/mach-voyager/voyager_cat.c	Fri Nov 29 13:01:29 2002
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <asm/topology.h>
 #include <asm/io.h>
 
 #ifdef VOYAGER_CAT_DEBUG
@@ -575,6 +576,7 @@
 	__u8 qabc_data[0x20];
 	__u8 num_submodules, val;
 	voyager_eprom_hdr_t *eprom_hdr = (voyager_eprom_hdr_t *)&eprom_buf[0];
+	__u8 processor_cards = 0;
 	
 	__u8 cmos[4];
 	unsigned long addr;
@@ -721,8 +723,13 @@
 			printk("Module \"%s\": Dyadic Processor Card\n",
 			       cat_module_name(i));
 			voyager_extended_vic_processors |= (1<<cpu);
+			voyager_node_to_cpu_mask[processor_cards] |= (1<<cpu);
+			voyager_cpu_to_node[cpu] = processor_cards;
 			cpu += 4;
 			voyager_extended_vic_processors |= (1<<cpu);
+			voyager_node_to_cpu_mask[processor_cards] |= (1<<cpu);
+			voyager_cpu_to_node[cpu] = processor_cards;
+			processor_cards++;
 			outb(VOYAGER_CAT_END, CAT_CMD);
 			continue;
 		}
@@ -884,18 +891,20 @@
 			voyager_quad_processors |= (1<<cpu);
 			voyager_quad_cpi_addr[cpu] = (struct voyager_qic_cpi *)
 				(qic_addr+(j<<8));
+			voyager_cpu_to_node[cpu] = processor_cards;
+			voyager_node_to_cpu_mask[processor_cards] |= (1<<cpu);
 			CDEBUG(("CPU%d: CPI address 0x%lx\n", cpu,
 				(unsigned long)voyager_quad_cpi_addr[cpu]));
 		}
 		outb(VOYAGER_CAT_END, CAT_CMD);
-
-		
+		processor_cards++;
 		
 		*asicpp = NULL;
 		modpp = &((*modpp)->next);
 	}
 	*modpp = NULL;
 	printk("CAT Bus Initialisation finished: extended procs 0x%x, quad procs 0x%x, allowed vic boot = 0x%x\n", voyager_extended_vic_processors, voyager_quad_processors, voyager_allowed_boot_processors);
+	voyager_num_nodes = processor_cards;
 	request_resource(&ioport_resource, &vic_res);
 	if(voyager_quad_processors)
 		request_resource(&ioport_resource, &qic_res);
diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Fri Nov 29 13:01:29 2002
+++ b/drivers/base/Makefile	Fri Nov 29 13:01:29 2002
@@ -4,7 +4,8 @@
 			driver.o class.o intf.o platform.o \
 			cpu.o firmware.o
 
-obj-$(CONFIG_NUMA)	+= node.o  memblk.o
+obj-$(CONFIG_BASE_NODE)	+= node.o
+obj-$(CONFIG_NUMA)	+= memblk.o
 
 obj-y		+= fs/
 
diff -Nru a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c	Fri Nov 29 13:01:29 2002
+++ b/drivers/base/node.c	Fri Nov 29 13:01:29 2002
@@ -93,7 +93,8 @@
 
 static int __init register_node_type(void)
 {
+	devclass_register(&node_devclass);
 	driver_register(&node_driver);
-	return devclass_register(&node_devclass);
+	return 0; //devclass_register(&node_devclass);
 }
 postcore_initcall(register_node_type);
diff -Nru a/include/asm-i386/numnodes.h b/include/asm-i386/numnodes.h
--- a/include/asm-i386/numnodes.h	Fri Nov 29 13:01:29 2002
+++ b/include/asm-i386/numnodes.h	Fri Nov 29 13:01:29 2002
@@ -6,7 +6,7 @@
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
 #else
-#define MAX_NUMNODES	1
+#define MAX_NUMNODES	CONFIG_X86_NUMNODES
 #endif /* CONFIG_X86_NUMAQ */
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nru a/include/asm-i386/topology.h b/include/asm-i386/topology.h
--- a/include/asm-i386/topology.h	Fri Nov 29 13:01:29 2002
+++ b/include/asm-i386/topology.h	Fri Nov 29 13:01:29 2002
@@ -27,70 +27,7 @@
 #ifndef _ASM_I386_TOPOLOGY_H
 #define _ASM_I386_TOPOLOGY_H
 
-#ifdef CONFIG_X86_NUMAQ
-
-#include <asm/smpboot.h>
-
-/* Returns the number of the node containing CPU 'cpu' */
-#define __cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
-
-/* Returns the number of the node containing MemBlk 'memblk' */
-#define __memblk_to_node(memblk) (memblk)
-
-/* Returns the number of the node containing Node 'node'.  This architecture is flat, 
-   so it is a pretty simple function! */
-#define __parent_node(node) (node)
-
-/* Returns the number of the first CPU on Node 'node'.
- * This should be changed to a set of cached values
- * but this will do for now.
- */
-static inline int __node_to_first_cpu(int node)
-{
-	int i, cpu, logical_apicid = node << 4;
-
-	for(i = 1; i < 16; i <<= 1)
-		/* check to see if the cpu is in the system */
-		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
-			/* if yes, return it to caller */
-			return cpu;
-
-	BUG(); /* couldn't find a cpu on given node */
-	return -1;
-}
-
-/* Returns a bitmask of CPUs on Node 'node'.
- * This should be changed to a set of cached bitmasks
- * but this will do for now.
- */
-static inline unsigned long __node_to_cpu_mask(int node)
-{
-	int i, cpu, logical_apicid = node << 4;
-	unsigned long mask = 0UL;
-
-	if (sizeof(unsigned long) * 8 < NR_CPUS)
-		BUG();
-
-	for(i = 1; i < 16; i <<= 1)
-		/* check to see if the cpu is in the system */
-		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
-			/* if yes, add to bitmask */
-			mask |= 1 << cpu;
-
-	return mask;
-}
-
-/* Returns the number of the first MemBlk on Node 'node' */
-#define __node_to_memblk(node) (node)
-
-#else /* !CONFIG_X86_NUMAQ */
-/*
- * Other i386 platforms should define their own version of the 
- * above macros here.
- */
-
-#include <asm-generic/topology.h>
-
-#endif /* CONFIG_X86_NUMAQ */
+/* get the machine specific topology file */
+#include "machine_topology.h"
 
 #endif /* _ASM_I386_TOPOLOGY_H */
diff -Nru a/include/asm-i386/vic.h b/include/asm-i386/vic.h
--- a/include/asm-i386/vic.h	Fri Nov 29 13:01:29 2002
+++ b/include/asm-i386/vic.h	Fri Nov 29 13:01:29 2002
@@ -3,6 +3,8 @@
  * Author: J.E.J.Bottomley@HansenPartnership.com
  *
  * Standard include definitions for the NCR Voyager Interrupt Controller */
+#ifndef _ASM_VIC_H
+#define _ASM_VIC_H
 
 /* The eight CPI vectors.  To activate a CPI, you write a bit mask
  * corresponding to the processor set to be interrupted into the
@@ -59,3 +61,5 @@
 #define VIC_BOOT_INTERRUPT_MASK		0xfe
 
 extern void smp_vic_timer_interrupt(struct pt_regs *regs);
+
+#endif
diff -Nru a/include/asm-i386/voyager.h b/include/asm-i386/voyager.h
--- a/include/asm-i386/voyager.h	Fri Nov 29 13:01:29 2002
+++ b/include/asm-i386/voyager.h	Fri Nov 29 13:01:29 2002
@@ -3,6 +3,8 @@
  * Author: J.E.J.Bottomley@HansenPartnership.com
  *
  * Standard include definitions for the NCR Voyager system */
+#ifndef _ASM_VOYAGER_H_
+#define _ASM_VOYAGER_H_
 
 #undef	VOYAGER_DEBUG
 #undef	VOYAGER_CAT_DEBUG
@@ -519,3 +521,5 @@
 #define VOYAGER_PSI_SUBREAD	2
 #define VOYAGER_PSI_SUBWRITE	3
 extern void voyager_cat_psi(__u8, __u16, __u8 *);
+
+#endif

--==_Exmh_-16826176640--


