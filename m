Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWBXUTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWBXUTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWBXUTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:19:22 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:54277 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932461AbWBXUTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:19:22 -0500
Date: Fri, 24 Feb 2006 12:19:09 -0800
Message-Id: <200602242019.k1OKJ9ZW017291@zach-dev.vmware.com>
Subject: [PATCH 1/1] Topology c fix
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Paul Jackson <pj@sgi.com>,
       Ingo Molnar <mingo@redhat.com>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Feb 2006 20:19:20.0554 (UTC) FILETIME=[984E5CA0:01C6397F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling a non-default subarch, topology.c is missing from the kernel
build.  This causes builds with CONFIG_HOTPLUG_CPU to fail.  In addition,
on Intel processors with cpuid level > 4, it causes intel_cacheinfo.c to
reference uninitialized data that should have been set up by the initcall
in topology.c which calls register_cpu.  This causes a kernel panic on
boot on newer Intel processors.  Moving topology.c to arch/i386/kernel
fixes both of these problems.

Thanks to Dan Hecht for finding and fixing this problem.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Dan Hecht <dhect@vmware.com>

Index: linux-2.6.16-rc3/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.16-rc3.orig/arch/i386/kernel/Makefile	2006-02-14 14:28:22.000000000 -0800
+++ linux-2.6.16-rc3/arch/i386/kernel/Makefile	2006-02-24 10:10:43.000000000 -0800
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		quirks.o i8237.o
+		quirks.o i8237.o topology.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
Index: linux-2.6.16-rc3/arch/i386/kernel/topology.c
===================================================================
--- linux-2.6.16-rc3.orig/arch/i386/kernel/topology.c	2006-02-24 10:11:16.000000000 -0800
+++ linux-2.6.16-rc3/arch/i386/kernel/topology.c	2006-02-24 10:11:58.000000000 -0800
@@ -0,0 +1,97 @@
+/*
+ * arch/i386/kernel/topology.c - Populate driverfs with topology information
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
+#include <linux/nodemask.h>
+#include <asm/cpu.h>
+
+static struct i386_cpu cpu_devices[NR_CPUS];
+
+int arch_register_cpu(int num){
+	struct node *parent = NULL;
+	
+#ifdef CONFIG_NUMA
+	int node = cpu_to_node(num);
+	if (node_online(node))
+		parent = &node_devices[node].node;
+#endif /* CONFIG_NUMA */
+
+	return register_cpu(&cpu_devices[num].cpu, num, parent);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+void arch_unregister_cpu(int num) {
+	struct node *parent = NULL;
+
+#ifdef CONFIG_NUMA
+	int node = cpu_to_node(num);
+	if (node_online(node))
+		parent = &node_devices[node].node;
+#endif /* CONFIG_NUMA */
+
+	return unregister_cpu(&cpu_devices[num].cpu, parent);
+}
+EXPORT_SYMBOL(arch_register_cpu);
+EXPORT_SYMBOL(arch_unregister_cpu);
+#endif /*CONFIG_HOTPLUG_CPU*/
+
+
+
+#ifdef CONFIG_NUMA
+#include <linux/mmzone.h>
+#include <asm/node.h>
+
+struct i386_node node_devices[MAX_NUMNODES];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for_each_online_node(i)
+		arch_register_node(i);
+
+	for_each_present_cpu(i)
+		arch_register_cpu(i);
+	return 0;
+}
+
+#else /* !CONFIG_NUMA */
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for_each_present_cpu(i)
+		arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
Index: linux-2.6.16-rc3/arch/i386/mach-default/Makefile
===================================================================
--- linux-2.6.16-rc3.orig/arch/i386/mach-default/Makefile	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc3/arch/i386/mach-default/Makefile	2006-02-24 10:10:53.000000000 -0800
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o topology.o
+obj-y				:= setup.o
Index: linux-2.6.16-rc3/arch/i386/mach-default/topology.c
===================================================================
--- linux-2.6.16-rc3.orig/arch/i386/mach-default/topology.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc3/arch/i386/mach-default/topology.c	2003-01-30 02:24:37.000000000 -0800
@@ -1,97 +0,0 @@
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
-#include <linux/nodemask.h>
-#include <asm/cpu.h>
-
-static struct i386_cpu cpu_devices[NR_CPUS];
-
-int arch_register_cpu(int num){
-	struct node *parent = NULL;
-	
-#ifdef CONFIG_NUMA
-	int node = cpu_to_node(num);
-	if (node_online(node))
-		parent = &node_devices[node].node;
-#endif /* CONFIG_NUMA */
-
-	return register_cpu(&cpu_devices[num].cpu, num, parent);
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-void arch_unregister_cpu(int num) {
-	struct node *parent = NULL;
-
-#ifdef CONFIG_NUMA
-	int node = cpu_to_node(num);
-	if (node_online(node))
-		parent = &node_devices[node].node;
-#endif /* CONFIG_NUMA */
-
-	return unregister_cpu(&cpu_devices[num].cpu, parent);
-}
-EXPORT_SYMBOL(arch_register_cpu);
-EXPORT_SYMBOL(arch_unregister_cpu);
-#endif /*CONFIG_HOTPLUG_CPU*/
-
-
-
-#ifdef CONFIG_NUMA
-#include <linux/mmzone.h>
-#include <asm/node.h>
-
-struct i386_node node_devices[MAX_NUMNODES];
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_online_node(i)
-		arch_register_node(i);
-
-	for_each_present_cpu(i)
-		arch_register_cpu(i);
-	return 0;
-}
-
-#else /* !CONFIG_NUMA */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_present_cpu(i)
-		arch_register_cpu(i);
-	return 0;
-}
-
-#endif /* CONFIG_NUMA */
-
-subsys_initcall(topology_init);
