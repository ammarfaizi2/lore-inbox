Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSJEWTw>; Sat, 5 Oct 2002 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262735AbSJEWTv>; Sat, 5 Oct 2002 18:19:51 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:12261 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262721AbSJEWTs>; Sat, 5 Oct 2002 18:19:48 -0400
From: Erich Focht <efocht@ess.nec.de>
To: David Mosberger <davidm@hpl.hp.com>
Subject: [PATCH] topology for ia64
Date: Sat, 5 Oct 2002 19:04:22 +0200
User-Agent: KMail/1.4.1
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       "linux-ia64" <linux-ia64@linuxia64.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_A3QID3K7NES4KSP6JOL1"
Message-Id: <200210051904.22480.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_A3QID3K7NES4KSP6JOL1
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi David,

please find attached a first attempt to implement the topology.h
macros/routines for IA64. We need this for the NUMA scheduler setup.

Thanks!
Best regards,
Erich

--------------Boundary-00=_A3QID3K7NES4KSP6JOL1
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.5.39_topology-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.39_topology-ia64.patch"

diff -urNp linux-2.5.39-ia64/arch/ia64/kernel/acpi.c linux-2.5.39-ia64-top/arch/ia64/kernel/acpi.c
--- linux-2.5.39-ia64/arch/ia64/kernel/acpi.c	Fri Sep 27 23:49:54 2002
+++ linux-2.5.39-ia64-top/arch/ia64/kernel/acpi.c	Sat Oct  5 19:02:52 2002
@@ -631,6 +631,7 @@ acpi_boot_init (char *cmdline)
 	smp_boot_data.cpu_count = total_cpus;
 
 	smp_build_cpu_map();
+	build_cpu_to_node_map();
 #endif
 	/* Make boot-up look pretty */
 	printk("%d CPUs available, %d CPUs total\n", available_cpus, total_cpus);
diff -urNp linux-2.5.39-ia64/arch/ia64/kernel/smpboot.c linux-2.5.39-ia64-top/arch/ia64/kernel/smpboot.c
--- linux-2.5.39-ia64/arch/ia64/kernel/smpboot.c	Fri Sep 27 23:49:16 2002
+++ linux-2.5.39-ia64-top/arch/ia64/kernel/smpboot.c	Sat Oct  5 19:02:52 2002
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 
+#include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -427,6 +428,32 @@ smp_build_cpu_map (void)
 	}
 }
 
+char cpu_to_node_map[NR_CPUS] __cacheline_aligned;
+/*
+ * Build cpu to node mapping.
+ */
+void __init
+build_cpu_to_node_map(void)
+{
+	int cpu, i;
+
+	for(cpu=0; cpu<NR_CPUS; cpu++) {
+		if (!(phys_cpu_present_map & (1UL << cpu))) {
+			cpu_to_node_map[cpu] = -1;
+			continue;
+		}
+#ifdef CONFIG_ACPI_NUMA
+		for(i=0; i<NR_CPUS; i++)
+			if (cpu_physical_id(cpu) == node_cpuid[i].phys_id) {
+				cpu_to_node_map[cpu]=node_cpuid[i].nid;
+				break;
+			}
+#else
+		cpu_to_node_map[cpu] = 0;
+#endif
+	}
+}
+
 /*
  * Cycle through the APs sending Wakeup IPIs to boot each.
  */
diff -urNp linux-2.5.39-ia64/include/asm-ia64/smp.h linux-2.5.39-ia64-top/include/asm-ia64/smp.h
--- linux-2.5.39-ia64/include/asm-ia64/smp.h	Fri Sep 27 23:49:54 2002
+++ linux-2.5.39-ia64-top/include/asm-ia64/smp.h	Sat Oct  5 19:02:52 2002
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_SMP
 
+#include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
@@ -44,6 +45,7 @@ extern unsigned char smp_int_redirect;
 
 extern volatile int ia64_cpu_to_sapicid[];
 #define cpu_physical_id(i)	ia64_cpu_to_sapicid[i]
+extern char cpu_to_node_map[NR_CPUS] __cacheline_aligned;
 
 extern unsigned long ap_wakeup_vector;
 
diff -urNp linux-2.5.39-ia64/include/asm-ia64/topology.h linux-2.5.39-ia64-top/include/asm-ia64/topology.h
--- linux-2.5.39-ia64/include/asm-ia64/topology.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.39-ia64-top/include/asm-ia64/topology.h	Sat Oct  5 19:22:33 2002
@@ -0,0 +1,66 @@
+/*
+ * linux/include/asm-ia64/topology.h
+ *
+ * Copyright (C) 2002, Erich Focht, NEC
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef _ASM_IA64_TOPOLOGY_H
+#define _ASM_IA64_TOPOLOGY_H
+
+#include <asm/acpi.h>
+#include <asm/numa.h>
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define __cpu_to_node(cpu) cpu_to_node_map[cpu]
+
+/*
+ * Returns the number of the node containing MemBlk 'memblk'
+ */
+#ifdef CONFIG_ACPI_NUMA
+#define __memblk_to_node(memblk) (node_memblk[memblk].nid)
+#else
+#define __memblk_to_node(memblk) (memblk)
+#endif
+
+/* 
+ * Returns the number of the node containing Node 'nid'.
+ * Not implemented here. Multi-level hierarchies detected with
+ * the help of node_distance().
+ */
+#define __parent_node(nid) (nid)
+
+/* 
+ * Returns the number of the first CPU on Node 'node'.
+ * Temporarily implemented with the help of pool arrays, so
+ * don't use it too early.
+ * Who needs this?
+ */
+/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
+
+/* 
+ * Returns a bitmask of CPUs on Node 'node'.
+ */
+static inline unsigned long __node_to_cpu_mask(int node)
+{
+	int cpu;
+	unsigned long mask = 0UL;
+
+	for(cpu=0; cpu<NR_CPUS; cpu++)
+		if (__cpu_to_node(cpu) == node)
+			mask |= 1UL << cpu;
+	return mask;
+}
+
+/*
+ * Returns the number of the first MemBlk on Node 'node'
+ * Should be fixed when IA64 discontigmem goes in.
+ */
+#define __node_to_memblk(node) (node)
+
+#endif /* _ASM_IA64_TOPOLOGY_H */

--------------Boundary-00=_A3QID3K7NES4KSP6JOL1--

