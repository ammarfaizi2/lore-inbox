Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265110AbSJaC35>; Wed, 30 Oct 2002 21:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJaC35>; Wed, 30 Oct 2002 21:29:57 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61593 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265110AbSJaC3m>;
	Wed, 30 Oct 2002 21:29:42 -0500
Message-ID: <3DC09613.9070203@us.ibm.com>
Date: Wed, 30 Oct 2002 18:31:47 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Mochel <mochel@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] (resend) i386 sysfs Topology 2.5.45 (2/5)
References: <3DC09475.2040303@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010801080607020304040408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010801080607020304040408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to clear out the patch at the bottom the first time.  Resending 
for clarity's sake.

Matthew Dobson wrote:
> Linus,
>     This series of patches creates a directory-based Topology in sysfs 
> (driverfs).  This includes the per-node meminfo patch you wanted, as 
> well as UP/SMP/NUMA topology.
>     There were discussions between myself, Andrew, Rusty, and Patrick, 
> and these are what we agreed on.
> 
> (1/5) Core sysfs Topology:
>     This patch creates the generic structures that are (will be)
>     embedded in the per-arch structures.  Also creates calls to
>     register these generic structures (CPUs, MemBlks, & Nodes).
> 
>     Note that without arch-specific structures in which to embed
>     these structures, and an arch-specific initialization routine,
>     these functions/structures remain unused.
> 
> (2/5) i386 sysfs Topology
>     This patch creates the i386 specific files/functions/structures
>     to implement driverfs Topology.  These structures have the
>     generic CPU/MemBlk/Node structures embedded in them.
> 
>     This patch also creates the arch-specific initialization routine
>     to instantiate the topology.
> 
> (3/5) per-node (NUMA) meminfo for sysfs Topology
>     This patch adds code to DriverFS Topology to expose per-node
>     memory statistics.
>     This information is exposed via the nodeX/meminfo file.
> 
>     The patch also adds 2 helper functions to gather per-node memory
>     info.
> 
> (4/5) memblk_online_map
>     This patch creates a memblk_online_map, much like
>     cpu_online_map.  It also creates the standard helper functions,
>     ie: memblk_online(), num_online_memblks(), memblk_set_online(),
>     memblk_set_offline().
> 
>     This is used by driverFS topology to keep track of which memory
>     blocks are in the system and online.
> 
> (5/5) node_online_map
>     This patch creates a node_online_map, much like cpu_online_map.
>     It also creates the standard helper functions, ie:
>     node_online(), num_online_nodes(), node_set_online(),
>     node_set_offline().
> 
>     This is used by driverFS topology to keep track of which Nodes
>     are in the system and online.
> 
> Cheers!
> 
> -Matt

--------------010801080607020304040408
Content-Type: text/plain;
 name="02-arch_additions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-arch_additions.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/arch/i386/mach-generic/Makefile linux-2.5.45-arch_additions/arch/i386/mach-generic/Makefile
--- linux-2.5.45-base/arch/i386/mach-generic/Makefile	Wed Oct 30 16:42:22 2002
+++ linux-2.5.45-arch_additions/arch/i386/mach-generic/Makefile	Wed Oct 30 17:54:32 2002
@@ -4,6 +4,6 @@
 
 EXTRA_CFLAGS	+= -I../kernel
 
-obj-y				:= setup.o
+obj-y				:= setup.o topology.o
 
 include $(TOPDIR)/Rules.make
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/arch/i386/mach-generic/topology.c linux-2.5.45-arch_additions/arch/i386/mach-generic/topology.c
--- linux-2.5.45-base/arch/i386/mach-generic/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.45-arch_additions/arch/i386/mach-generic/topology.c	Wed Oct 30 17:54:32 2002
@@ -0,0 +1,69 @@
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
+extern int numnodes;
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < numnodes; i++)
+		arch_register_node(i);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i = 0; i < numnodes; i++)
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/asm-i386/cpu.h linux-2.5.45-arch_additions/include/asm-i386/cpu.h
--- linux-2.5.45-base/include/asm-i386/cpu.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.45-arch_additions/include/asm-i386/cpu.h	Wed Oct 30 17:54:32 2002
@@ -0,0 +1,28 @@
+#ifndef _ASM_I386_CPU_H_
+#define _ASM_I386_CPU_H_
+
+#include <linux/device.h>
+#include <linux/cpu.h>
+
+#include <asm/topology.h>
+#include <asm/node.h>
+
+struct i386_cpu {
+	struct cpu cpu;
+};
+extern struct i386_cpu cpu_devices[NR_CPUS];
+
+
+static inline int arch_register_cpu(int num){
+	int error, p_node = __cpu_to_node(num);
+	struct node *parent = NULL;
+	
+#ifdef CONFIG_NUMA
+	parent = &node_devices[p_node].node;
+#endif /* CONFIG_NUMA */
+
+	error = register_cpu(&cpu_devices[num].cpu, num, parent);
+	return error;
+}
+
+#endif /* _ASM_I386_CPU_H_ */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/asm-i386/memblk.h linux-2.5.45-arch_additions/include/asm-i386/memblk.h
--- linux-2.5.45-base/include/asm-i386/memblk.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.45-arch_additions/include/asm-i386/memblk.h	Wed Oct 30 17:54:32 2002
@@ -0,0 +1,23 @@
+#ifndef _ASM_I386_MEMBLK_H_
+#define _ASM_I386_MEMBLK_H_
+
+#include <linux/device.h>
+#include <linux/mmzone.h>
+#include <linux/memblk.h>
+
+#include <asm/topology.h>
+#include <asm/node.h>
+
+struct i386_memblk {
+	struct memblk memblk;
+};
+extern struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static inline int arch_register_memblk(int num){
+	int p_node = __memblk_to_node(num);
+
+	return register_memblk(&memblk_devices[num].memblk, num, 
+				&node_devices[p_node].node);
+}
+
+#endif /* _ASM_I386_MEMBLK_H_ */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/asm-i386/node.h linux-2.5.45-arch_additions/include/asm-i386/node.h
--- linux-2.5.45-base/include/asm-i386/node.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.45-arch_additions/include/asm-i386/node.h	Wed Oct 30 17:54:32 2002
@@ -0,0 +1,25 @@
+#ifndef _ASM_I386_NODE_H_
+#define _ASM_I386_NODE_H_
+
+#include <linux/device.h>
+#include <linux/mmzone.h>
+#include <linux/node.h>
+
+#include <asm/topology.h>
+
+struct i386_node {
+	struct node node;
+};
+extern struct i386_node node_devices[MAX_NUMNODES];
+
+static inline int arch_register_node(int num){
+	int p_node = __parent_node(num);
+	struct node *parent = NULL;
+
+	if (p_node != num)
+		parent = &node_devices[p_node].node;
+
+	return register_node(&node_devices[num].node, num, parent);
+}
+
+#endif /* _ASM_I386_NODE_H_ */

--------------010801080607020304040408--

