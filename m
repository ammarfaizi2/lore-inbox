Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWADJHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWADJHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWADJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:07:21 -0500
Received: from fmr23.intel.com ([143.183.121.15]:52923 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751624AbWADJHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:07:04 -0500
Date: Wed, 4 Jan 2006 01:06:58 -0800
From: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Nathan Lynch <ntl@pobox.com>, greg@kroah.com, discuss@x86-64.org,
       linux-ia64@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH v3]Export cpu topology by sysfs
Message-ID: <20060104010658.A16342@unix-os.sc.intel.com>
References: <8126E4F969BA254AB43EA03C59F44E84045838F8@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84045838F8@pdsmsx404>; from yanmin.zhang@intel.com on Sat, Dec 31, 2005 at 04:43:24PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is version 3. Based on Nathan's comments, the main changes are:
1) Drop thread id, so the first 2 patches of version 2 are dropped;
2) Set consistent default values for the 4 attributes.

---Detailed descriptions---
From: Zhang, Yanmin <yanmin.zhang@intel.com>

The patch implements the topology exportation by sysfs.

Items (attributes) are similar to /proc/cpuinfo.

1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
represent the physical package id of  cpu X;
2) /sys/devices/system/cpu/cpuX/topology/core_id:
represent the cpu core id to cpu X;
3) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
represent the thread siblings to cpu X in the same core;
4) /sys/devices/system/cpu/cpuX/topology/core_siblings:
represent the thread siblings to cpu X in the same physical package;

To implement it in an architecture-neutral way, a new source file,
driver/base/topology.c, is to export the 5 attributes.

If one architecture wants to support this feature, it just needs to
implement 4 defines, typically in file include/asm-XXX/topology.h.
The 4 defines are:
#define topology_physical_package_id(cpu)
#define topology_core_id(cpu)
#define topology_thread_siblings(cpu)
#define topology_core_siblings(cpu)

The type of **_id is int.
The type of siblings is cpumask_t.

To be consistent on all architectures, the 4 attributes should have
deafult values if their values are unavailable. Below is the rule.
1) physical_package_id: If cpu has no physical package id, -1 is the
default value.
2) core_id: If cpu doesn't support multi-core, its core id is 0.
3) thread_siblings: Just include itself, if the cpu doesn't support
HT/multi-thread.
4) core_siblings: Just include itself, if the cpu doesn't support
multi-core and HT/Multi-thread.

So be careful when declaring the 4 defines in include/asm-XXX/topology.h.

If an attribute isn't defined on an architecture, it won't be exported.

Thank Nathan, Greg, Andi, Paul and Venki.

The patch against 2.6.15-rc5 provides defines for i386/x86_64/ia64.

Signed-off-by: Zhang, Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.15-rc5/arch/ia64/kernel/topology.c linux-2.6.15-rc5_topology/arch/ia64/kernel/topology.c
--- linux-2.6.15-rc5/arch/ia64/kernel/topology.c	2005-11-07 02:34:06.000000000 +0800
+++ linux-2.6.15-rc5_topology/arch/ia64/kernel/topology.c	2006-01-03 22:54:40.000000000 +0800
@@ -98,4 +98,4 @@ out:
 	return err;
 }
 
-__initcall(topology_init);
+subsys_initcall(topology_init);
diff -Nraup linux-2.6.15-rc5/Documentation/cputopology.txt linux-2.6.15-rc5_topology/Documentation/cputopology.txt
--- linux-2.6.15-rc5/Documentation/cputopology.txt	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.15-rc5_topology/Documentation/cputopology.txt	2006-01-04 00:54:38.000000000 +0800
@@ -0,0 +1,41 @@
+
+Export cpu topology info by sysfs. Items (attributes) are similar
+to /proc/cpuinfo.
+
+1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
+represent the physical package id of  cpu X;
+2) /sys/devices/system/cpu/cpuX/topology/core_id:
+represent the cpu core id to cpu X;
+3) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
+represent the thread siblings to cpu X in the same core;
+4) /sys/devices/system/cpu/cpuX/topology/core_siblings:
+represent the thread siblings to cpu X in the same physical package;
+
+To implement it in an architecture-neutral way, a new source file,
+driver/base/topology.c, is to export the 5 attributes.
+
+If one architecture wants to support this feature, it just needs to
+implement 4 defines, typically in file include/asm-XXX/topology.h.
+The 4 defines are:
+#define topology_physical_package_id(cpu)
+#define topology_core_id(cpu)
+#define topology_thread_siblings(cpu)
+#define topology_core_siblings(cpu)
+
+The type of **_id is int.
+The type of siblings is cpumask_t.
+
+To be consistent on all architectures, the 4 attributes should have
+deafult values if their values are unavailable. Below is the rule.
+1) physical_package_id: If cpu has no physical package id, -1 is the
+default value.
+2) core_id: If cpu doesn't support multi-core, its core id is 0.
+3) thread_siblings: Just include itself, if the cpu doesn't support
+HT/multi-thread.
+4) core_siblings: Just include itself, if the cpu doesn't support
+multi-core and HT/Multi-thread.
+
+So be careful when declaring the 4 defines in include/asm-XXX/topology.h.
+
+If an attribute isn't defined on an architecture, it won't be exported.
+
diff -Nraup linux-2.6.15-rc5/drivers/base/Makefile linux-2.6.15-rc5_topology/drivers/base/Makefile
--- linux-2.6.15-rc5/drivers/base/Makefile	2005-12-13 23:07:35.000000000 +0800
+++ linux-2.6.15-rc5_topology/drivers/base/Makefile	2006-01-03 22:54:40.000000000 +0800
@@ -8,6 +8,7 @@ obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
+obj-$(CONFIG_SMP)	+= topology.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nraup linux-2.6.15-rc5/drivers/base/topology.c linux-2.6.15-rc5_topology/drivers/base/topology.c
--- linux-2.6.15-rc5/drivers/base/topology.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.15-rc5_topology/drivers/base/topology.c	2006-01-04 00:54:48.000000000 +0800
@@ -0,0 +1,148 @@
+/*
+ * driver/base/topology.c - Populate sysfs with cpu topology information
+ *
+ * Written by: Zhang Yanmin, Intel Corporation
+ *
+ * Copyright (C) 2006, Intel Corp.
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
+ */
+#include <linux/sysdev.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/topology.h>
+
+#define define_one_ro(_name) 		\
+static SYSDEV_ATTR(_name, 0444, show_##_name, NULL)
+
+#define define_id_show_func(name)				\
+static ssize_t show_##name(struct sys_device *dev, char *buf)	\
+{								\
+	unsigned int cpu = dev->id;				\
+	return sprintf(buf, "%d\n", topology_##name(cpu));	\
+}
+
+#define define_siblings_show_func(name)					\
+static ssize_t show_##name(struct sys_device *dev, char *buf)		\
+{									\
+	ssize_t len = -1;						\
+	unsigned int cpu = dev->id;					\
+	len = cpumask_scnprintf(buf, NR_CPUS+1, topology_##name(cpu));	\
+	return (len + sprintf(buf + len, "\n"));			\
+}
+
+#ifdef	topology_physical_package_id
+define_id_show_func(physical_package_id);
+define_one_ro(physical_package_id);
+#define ref_physical_package_id_attr	&attr_physical_package_id.attr,
+#else
+#define ref_physical_package_id_attr
+#endif
+
+#ifdef topology_core_id
+define_id_show_func(core_id);
+define_one_ro(core_id);
+#define ref_core_id_attr		&attr_core_id.attr,
+#else
+#define ref_core_id_attr
+#endif
+
+#ifdef topology_thread_siblings
+define_siblings_show_func(thread_siblings);
+define_one_ro(thread_siblings);
+#define ref_thread_siblings_attr	&attr_thread_siblings.attr,
+#else
+#define ref_thread_siblings_attr
+#endif
+
+#ifdef topology_core_siblings
+define_siblings_show_func(core_siblings);
+define_one_ro(core_siblings);
+#define ref_core_siblings_attr		&attr_core_siblings.attr,
+#else
+#define ref_core_siblings_attr
+#endif
+
+static struct attribute * default_attrs[] = {
+	ref_physical_package_id_attr
+	ref_core_id_attr
+	ref_thread_siblings_attr
+	ref_core_siblings_attr
+	NULL
+};
+
+static struct attribute_group topology_attr_group = {
+	.attrs = default_attrs,
+	.name = "topology"
+};
+
+/* Add/Remove cpu_topology interface for CPU device */
+static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
+{
+	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
+	return 0;
+}
+
+static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
+{
+	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
+	return 0;
+}
+
+static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
+		unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct sys_device *sys_dev;
+
+	sys_dev = get_cpu_sysdev(cpu);
+	switch (action) {
+		case CPU_ONLINE:
+			topology_add_dev(sys_dev);
+			break;
+		case CPU_DEAD:
+			topology_remove_dev(sys_dev);
+			break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block topology_cpu_notifier =
+{
+	.notifier_call = topology_cpu_callback,
+};
+
+static int __cpuinit topology_sysfs_init(void)
+{
+	int i;
+
+	for_each_online_cpu(i) {
+		topology_cpu_callback(&topology_cpu_notifier, CPU_ONLINE,
+				(void *)(long)i);
+	}
+
+	register_cpu_notifier(&topology_cpu_notifier);
+
+	return 0;
+}
+
+device_initcall(topology_sysfs_init);
+
diff -Nraup linux-2.6.15-rc5/include/asm-i386/topology.h linux-2.6.15-rc5_topology/include/asm-i386/topology.h
--- linux-2.6.15-rc5/include/asm-i386/topology.h	2005-11-07 02:34:08.000000000 +0800
+++ linux-2.6.15-rc5_topology/include/asm-i386/topology.h	2006-01-04 00:16:13.000000000 +0800
@@ -27,6 +27,15 @@
 #ifndef _ASM_I386_TOPOLOGY_H
 #define _ASM_I386_TOPOLOGY_H
 
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)				\
+	((int)(phys_proc_id[cpu] == BAD_APICID ? -1 : phys_proc_id[cpu]))
+#define topology_core_id(cpu)						\
+	((int)(cpu_core_id[cpu] == BAD_APICID ? 0 : cpu_core_id[cpu]))
+#define topology_core_siblings(cpu)		cpu_core_map[cpu]
+#define topology_thread_siblings(cpu)		cpu_sibling_map[cpu]
+#endif
+
 #ifdef CONFIG_NUMA
 
 #include <asm/mpspec.h>
diff -Nraup linux-2.6.15-rc5/include/asm-ia64/topology.h linux-2.6.15-rc5_topology/include/asm-ia64/topology.h
--- linux-2.6.15-rc5/include/asm-ia64/topology.h	2005-11-07 02:34:08.000000000 +0800
+++ linux-2.6.15-rc5_topology/include/asm-ia64/topology.h	2006-01-04 00:07:47.000000000 +0800
@@ -100,6 +100,13 @@ void build_cpu_to_node_map(void);
 
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)	cpu_data(cpu)->socket_id
+#define topology_core_id(cpu)			cpu_data(cpu)->core_id
+#define topology_core_siblings(cpu)		cpu_core_map[cpu]
+#define topology_thread_siblings(cpu)		cpu_sibling_map[cpu]
+#endif
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_IA64_TOPOLOGY_H */
diff -Nraup linux-2.6.15-rc5/include/asm-x86_64/topology.h linux-2.6.15-rc5_topology/include/asm-x86_64/topology.h
--- linux-2.6.15-rc5/include/asm-x86_64/topology.h	2005-12-13 23:07:39.000000000 +0800
+++ linux-2.6.15-rc5_topology/include/asm-x86_64/topology.h	2006-01-04 00:14:22.000000000 +0800
@@ -58,6 +58,15 @@ extern int __node_distance(int, int);
 
 #endif
 
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)				\
+	((int)(phys_proc_id[cpu] == BAD_APICID ? -1 : phys_proc_id[cpu]))
+#define topology_core_id(cpu)						\
+	((int)(cpu_core_id[cpu] == BAD_APICID ? 0 : cpu_core_id[cpu]))
+#define topology_core_siblings(cpu)		cpu_core_map[cpu]
+#define topology_thread_siblings(cpu)		cpu_sibling_map[cpu]
+#endif
+
 #include <asm-generic/topology.h>
 
 #endif
