Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJVJRk>; Tue, 22 Oct 2002 05:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbSJVJRk>; Tue, 22 Oct 2002 05:17:40 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:64984 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262322AbSJVJRi>; Tue, 22 Oct 2002 05:17:38 -0400
From: Erich Focht <efocht@ess.nec.de>
To: davidm@hpl.hp.com, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] topology for ia64
Date: Tue, 22 Oct 2002 11:23:37 +0200
User-Agent: KMail/1.4.1
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       "linux-ia64" <linux-ia64@linuxia64.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200210051904.22480.efocht@ess.nec.de> <15796.38594.516266.130894@napali.hpl.hp.com>
In-Reply-To: <15796.38594.516266.130894@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D3MD3INMM409GMQ1AW19"
Message-Id: <200210221123.37145.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_D3MD3INMM409GMQ1AW19
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 22 October 2002 02:07, David Mosberger wrote:
> Why does the cpu_to_node_map[] exist for non-NUMA configurations?  It
> seems to me that it would be better to make cpu_to_node_map a macro
> that uses an array-check for NUMA configurations and a simple test
> against phys_cpu_present_map() for non-NUMA.

Attached is a modified patch for implementing the topology stuff on ia64.
It's on top of your 2.5.39 tree including acpi_numa and the acpi_numa fix
which I've sent you separately.

I dropped the cpu_to_node_map array for the non-NUMA case. The macro
__cpu_to_node() returns 0 in this case. In the places where it is used
(e.g. in the NUMA scheduler) we either run on a valid CPU or have
cpu_online() checks before using it, therefore I also removed the
phys_cpu_present_map check when building the cpu to node map.

Hope this can be included now...

Regards,
Erich

--------------Boundary-00=_D3MD3INMM409GMQ1AW19
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="00_topology-ia64-2.5.39-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="00_topology-ia64-2.5.39-2.patch"

diff -urNp 2.5.39-ia64-acpi-dmf/arch/ia64/kernel/acpi.c 2.5.39-ia64-acpi-dmf-top/arch/ia64/kernel/acpi.c
--- 2.5.39-ia64-acpi-dmf/arch/ia64/kernel/acpi.c	Mon Oct 14 15:34:40 2002
+++ 2.5.39-ia64-acpi-dmf-top/arch/ia64/kernel/acpi.c	Tue Oct 22 10:44:26 2002
@@ -784,6 +784,9 @@ acpi_boot_init (char *cmdline)
 	smp_boot_data.cpu_count = total_cpus;
 
 	smp_build_cpu_map();
+#ifdef CONFIG_NUMA
+	build_cpu_to_node_map();
+#endif
 #endif
 	/* Make boot-up look pretty */
 	printk("%d CPUs available, %d CPUs total\n", available_cpus, total_cpus);
diff -urNp 2.5.39-ia64-acpi-dmf/arch/ia64/kernel/smpboot.c 2.5.39-ia64-acpi-dmf-top/arch/ia64/kernel/smpboot.c
--- 2.5.39-ia64-acpi-dmf/arch/ia64/kernel/smpboot.c	Fri Sep 27 23:49:16 2002
+++ 2.5.39-ia64-acpi-dmf-top/arch/ia64/kernel/smpboot.c	Tue Oct 22 10:57:22 2002
@@ -16,6 +16,7 @@
 
 #include <linux/config.h>
 
+#include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -427,6 +428,32 @@ smp_build_cpu_map (void)
 	}
 }
 
+#ifdef CONFIG_NUMA
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
+		/*
+		 * All Itanium NUMA platforms I know use ACPI, so maybe we
+		 * can drop this ifdef completely.                    [EF] 
+		 */
+#ifdef CONFIG_ACPI_NUMA
+		for(i=0; i<NR_CPUS; i++)
+			if (cpu_physical_id(cpu) == node_cpuid[i].phys_id) {
+				cpu_to_node_map[cpu]=node_cpuid[i].nid;
+				break;
+			}
+#endif
+	}
+}
+#endif
+
 /*
  * Cycle through the APs sending Wakeup IPIs to boot each.
  */
diff -urNp 2.5.39-ia64-acpi-dmf/include/asm-ia64/numa.h 2.5.39-ia64-acpi-dmf-top/include/asm-ia64/numa.h
--- 2.5.39-ia64-acpi-dmf/include/asm-ia64/numa.h	Mon Oct 14 15:34:14 2002
+++ 2.5.39-ia64-acpi-dmf-top/include/asm-ia64/numa.h	Tue Oct 22 11:04:05 2002
@@ -22,6 +22,8 @@
 # define NR_MEMBLKS   (NR_NODES * 8)
 #endif
 
+extern char cpu_to_node_map[NR_CPUS] __cacheline_aligned;
+
 /* Stuff below this line could be architecture independent */
 
 extern int num_memblks;		/* total number of memory chunks */
diff -urNp 2.5.39-ia64-acpi-dmf/include/asm-ia64/topology.h 2.5.39-ia64-acpi-dmf-top/include/asm-ia64/topology.h
--- 2.5.39-ia64-acpi-dmf/include/asm-ia64/topology.h	Thu Jan  1 01:00:00 1970
+++ 2.5.39-ia64-acpi-dmf-top/include/asm-ia64/topology.h	Tue Oct 22 10:43:06 2002
@@ -0,0 +1,79 @@
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
+#ifdef CONFIG_NUMA
+#define __cpu_to_node(cpu) cpu_to_node_map[cpu]
+#else
+#define __cpu_to_node(cpu) (0)
+#endif
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
+ * Slow in the current implementation.
+ * Who needs this?
+ */
+/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
+static inline int __node_to_first_cpu(int node)
+{
+	int i, cpu;
+
+	for (i=0; i<NR_CPUS; i++)
+		if (__cpu_to_node(i)==node)
+			return i;
+	BUG(); /* couldn't find a cpu on given node */
+	return -1;
+}
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

--------------Boundary-00=_D3MD3INMM409GMQ1AW19--

