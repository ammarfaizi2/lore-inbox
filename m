Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTJKMij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTJKMij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:38:39 -0400
Received: from gprs147-20.eurotel.cz ([160.218.147.20]:52096 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263282AbTJKMig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:38:36 -0400
Date: Sat, 11 Oct 2003 14:38:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [x86-64] cpus are not properly registered with sysfs (=> cpufreq fails)
Message-ID: <20031011123815.GA1201@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found why cpufreq fails on x86-64: cpus are not properly
registered. Fix is trivial, but invoves adding 2 files from i386.

Cpufreq actually works with this fix. [It is possible to piggyback
cpu-registering code to some existing source file, making for smaller
diff. If you want me to do that, let me know, ideally also tell me
what file to piggyback at. But I think that would be too ugly.]

Not sure what to do with CONFIG_NUMA there. It might be safer to make
it #if 0 for now.

							Pavel

Index: arch/x86_64/kernel/Makefile
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/arch/x86_64/kernel/Makefile,v
retrieving revision 1.27
diff -u -r1.27 Makefile
--- arch/x86_64/kernel/Makefile	6 Oct 2003 22:15:45 -0000	1.27
+++ arch/x86_64/kernel/Makefile	11 Oct 2003 12:20:16 -0000
@@ -10,6 +10,7 @@
 		setup64.o bluesmoke.o bootflag.o e820.o reboot.o warmreboot.o
 
 obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_ACPI)		+= acpi/
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
@@ -23,8 +24,8 @@
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 
 obj-$(CONFIG_MODULES)		+= module.o
+obj-y				+= topology.o
 
 bootflag-y			+= ../../i386/kernel/bootflag.o
 cpuid-$(CONFIG_X86_CPUID)	+= ../../i386/kernel/cpuid.o
 
-obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/


--- /dev/null	2003-03-23 07:08:21.000000000 +0100
+++ arch/x86_64/kernel/topology.c	2003-10-13 09:58:20.000000000 +0200
@@ -0,0 +1,43 @@
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
+static int __init topology_init(void)
+{
+  int i;
+
+  for (i = 0; i < NR_CPUS; i++)
+    if (cpu_possible(i)) arch_register_cpu(i);
+  return 0;
+}
+
+subsys_initcall(topology_init);
--- /dev/null	2003-03-23 07:08:21.000000000 +0100
+++ include/asm-x86_64/cpu.h	2003-10-13 09:57:54.000000000 +0200
@@ -0,0 +1,24 @@
+#ifndef _ASM_I386_CPU_H_
+#define _ASM_I386_CPU_H_
+
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <linux/topology.h>
+
+struct i386_cpu {
+	struct cpu cpu;
+};
+extern struct i386_cpu cpu_devices[NR_CPUS];
+
+
+static inline int arch_register_cpu(int num){
+	struct node *parent = NULL;
+	
+#ifdef CONFIG_NUMA
+	parent = &node_devices[cpu_to_node(num)].node;
+#endif /* CONFIG_NUMA */
+
+	return register_cpu(&cpu_devices[num].cpu, num, parent);
+}
+
+#endif /* _ASM_I386_CPU_H_ */


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

