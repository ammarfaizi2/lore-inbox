Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVLUCJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVLUCJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVLUCJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:09:31 -0500
Received: from fmr23.intel.com ([143.183.121.15]:41640 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932252AbVLUCJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:09:30 -0500
Date: Tue, 20 Dec 2005 18:09:29 -0800
From: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org
Cc: yanmin.zhang@intel.com, suresh.b.siddha@intel.com, rajesh.shah@intel.com,
       venkatesh.pallipadi@intel.com
Subject: [PATCH v2:3/3]Export cpu topology by sysfs
Message-ID: <20051220180929.B19129@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

The third patch implements the topology exportation by sysfs.

Items (attributes) are similar to /proc/cpuinfo.

1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
represent the physical package id of  cpu X;
2) /sys/devices/system/cpu/cpuX/topology/core_id:
represent the cpu core id to cpu X;
3) /sys/devices/system/cpu/cpuX/topology/thread_id:
represent the cpu thread id  to cpu X;
4) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
represent the thread siblings to cpu X in the same core;
5) /sys/devices/system/cpu/cpuX/topology/core_siblings:
represent the thread siblings to cpu X in the same physical package;

If one architecture wants to support this feature, it just needs to
implement 5 defines, typically in file include/asm-XXX/topology.h.
The 5 defines are:
#define topology_physical_package_id(cpu)
#define topology_core_id(cpu)
#define topology_thread_id(cpu)
#define topology_thread_siblings(cpu)
#define topology_core_siblings(cpu)

The type of siblings is cpumask_t.

If an attribute isn't defined on an architecture, it won't be exported.

The patch against 2.6.15-rc5 provides defines for i386/x86_64/ia64.

Signed-off-by: Zhang, Yanmin <yanmin.zhang@intel.com>

#diffstat export_topology_2.6.15-rc5_v4.patch
 Documentation/cputopology.txt |   31 ++++++
 arch/ia64/kernel/topology.c   |    2
 drivers/base/Makefile         |    1
 drivers/base/topology.c       |  201 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/topology.h   |    8 +
 include/asm-ia64/topology.h   |    8 +
 include/asm-x86_64/topology.h |    8 +
 7 files changed, 258 insertions, 1 deletion

---

diff -Nraup linux-2.6.15-rc5/arch/ia64/kernel/topology.c linux-2.6.15-rc5_topology/arch/ia64/kernel/topology.c
--- linux-2.6.15-rc5/arch/ia64/kernel/topology.c	2005-11-07 02:34:06.000000000 +0800
+++ linux-2.6.15-rc5_topology/arch/ia64/kernel/topology.c	2005-12-14 21:20:54.000000000 +0800
@@ -98,4 +98,4 @@ out:
 	return err;
 }
 
-__initcall(topology_init);
+subsys_initcall(topology_init);
diff -Nraup linux-2.6.15-rc5/Documentation/cputopology.txt linux-2.6.15-rc5_topology/Documentation/cputopology.txt
--- linux-2.6.15-rc5/Documentation/cputopology.txt	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.15-rc5_topology/Documentation/cputopology.txt	2005-12-20 17:55:26.000000000 +0800
@@ -0,0 +1,31 @@
+
+Export cpu topology info by sysfs. Items (attributes) are similar
+to /proc/cpuinfo.
+
+1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
+represent the physical package id of  cpu X;
+2) /sys/devices/system/cpu/cpuX/topology/core_id:
+represent the cpu core id to cpu X;
+3) /sys/devices/system/cpu/cpuX/topology/thread_id:
+represent the cpu thread id  to cpu X;
+4) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
+represent the thread siblings to cpu X in the same core;
+5) /sys/devices/system/cpu/cpuX/topology/core_siblings:
+represent the thread siblings to cpu X in the same physical package;
+
+To implement it in an architecture-neutral way, a new source file,
+driver/base/topology.c, is to export the 5 attributes.
+
+If one architecture wants to support this feature, it just needs to
+implement 5 defines, typically in file include/asm-XXX/topology.h.
+The 5 defines are:
+#define topology_physical_package_id(cpu)
+#define topology_core_id(cpu)
+#define topology_thread_id(cpu)
+#define topology_thread_siblings(cpu)
+#define topology_core_siblings(cpu)
+
+The type of siblings is cpumask_t.
+
+If an attribute isn't defined on an architecture, it won't be exported.
+
diff -Nraup linux-2.6.15-rc5/drivers/base/Makefile linux-2.6.15-rc5_topology/drivers/base/Makefile
--- linux-2.6.15-rc5/drivers/base/Makefile	2005-12-13 23:07:35.000000000 +0800
+++ linux-2.6.15-rc5_topology/drivers/base/Makefile	2005-12-14 20:47:00.000000000 +0800
@@ -8,6 +8,7 @@ obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
+obj-$(CONFIG_SMP)	+= topology.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nraup linux-2.6.15-rc5/drivers/base/topology.c linux-2.6.15-rc5_topology/drivers/base/topology.c
--- linux-2.6.15-rc5/drivers/base/topology.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.15-rc5_topology/drivers/base/topology.c	2005-12-20 00:33:49.000000000 +0800
@@ -0,0 +1,201 @@
+/*
+ * driver/base/topology.c - Populate driverfs with cpu topology information
+ *
+ * Written by: Zhang Yanmin, Intel Corporation
+ *
+ * Copyright (C) 2005, Intel Corp.
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
+struct _topology_attr {
+	struct attribute attr;
+	ssize_t (*show)(int cpu, char *);
+	ssize_t (*store)(const char *, size_t count);
+};
+
+#define to_attr(a) container_of(a, struct _topology_attr, attr)
+
+/* pointer to kobject for cpuX/topology */
+static struct kobject cpu_topology_kobject[NR_CPUS];
+
+#define define_one_ro(_name) 		\
+static struct _topology_attr _name =	\
+	__ATTR(_name, 0444, show_##_name, NULL)
+
+#define define_id_show_func(name)				\
+static ssize_t show_##name(int cpu, char *buf)			\
+{								\
+	return sprintf(buf, "%d\n", topology_##name(cpu));	\
+}
+
+#define define_siblings_show_func(name)					\
+static ssize_t show_##name(int cpu, char *buf)				\
+{									\
+	ssize_t len = -1;						\
+	len = cpumask_scnprintf(buf, NR_CPUS+1, topology_##name(cpu));	\
+	return (len + sprintf(buf + len, "\n"));			\
+}
+
+#ifdef	topology_physical_package_id
+define_id_show_func(physical_package_id);
+define_one_ro(physical_package_id);
+#define ref_physical_package_id_attr	&physical_package_id.attr,
+#else
+#define ref_physical_package_id_attr
+#endif
+
+#ifdef topology_core_id
+define_id_show_func(core_id);
+define_one_ro(core_id);
+#define ref_core_id_attr		&core_id.attr,
+#else
+#define ref_core_id_attr
+#endif
+
+#ifdef topology_thread_id
+define_id_show_func(thread_id);
+define_one_ro(thread_id);
+#define ref_thread_id_attr		&thread_id.attr,
+#else
+#define ref_thread_id_attr
+#endif
+
+#ifdef topology_thread_siblings
+define_siblings_show_func(thread_siblings);
+define_one_ro(thread_siblings);
+#define ref_thread_siblings_attr	&thread_siblings.attr,
+#else
+#define ref_thread_siblings_attr
+#endif
+
+#ifdef topology_core_siblings
+define_siblings_show_func(core_siblings);
+define_one_ro(core_siblings);
+#define ref_core_siblings_attr		&core_siblings.attr,
+#else
+#define ref_core_siblings_attr
+#endif
+
+static struct attribute * topology_default_attrs[] = {
+	ref_physical_package_id_attr
+	ref_core_id_attr
+	ref_thread_id_attr
+	ref_thread_siblings_attr
+	ref_core_siblings_attr
+	NULL
+};
+
+static ssize_t topology_show(struct kobject * kobj, struct attribute * attr, char * buf)
+{
+	unsigned int cpu;
+        struct _topology_attr *fattr = to_attr(attr);
+        ssize_t ret;
+
+	cpu = container_of(kobj->parent, struct sys_device, kobj)->id;
+        ret = fattr->show ? fattr->show(cpu, buf): 0;
+        return ret;
+}
+
+static ssize_t topology_store(struct kobject * kobj, struct attribute * attr,
+		     const char * buf, size_t count)
+{
+	return 0;
+}
+
+static struct sysfs_ops topology_sysfs_ops = {
+	.show   = topology_show,
+	.store  = topology_store,
+};
+
+static struct kobj_type topology_ktype = {
+	.sysfs_ops	= &topology_sysfs_ops,
+	.default_attrs	= topology_default_attrs,
+};
+
+/* Add/Remove cpu_topology interface for CPU device */
+static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+
+	memset(&cpu_topology_kobject[cpu], 0, sizeof(struct kobject));
+
+	cpu_topology_kobject[cpu].parent = &sys_dev->kobj;
+	kobject_set_name(&cpu_topology_kobject[cpu], "%s", "topology");
+	cpu_topology_kobject[cpu].ktype = &topology_ktype;
+
+	return  kobject_register(&cpu_topology_kobject[cpu]);
+}
+
+static int __cpuexit topology_remove_dev(struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+
+	kobject_unregister(&cpu_topology_kobject[cpu]);
+
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
+#ifdef	CONFIG_HOTPLUG_CPU
+		case CPU_DEAD:
+			topology_remove_dev(sys_dev);
+			break;
+#endif
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
+++ linux-2.6.15-rc5_topology/include/asm-i386/topology.h	2005-12-15 19:15:47.000000000 +0800
@@ -27,6 +27,14 @@
 #ifndef _ASM_I386_TOPOLOGY_H
 #define _ASM_I386_TOPOLOGY_H
 
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)	phys_proc_id[cpu]
+#define topology_core_id(cpu)			cpu_core_id[cpu]
+#define topology_thread_id(cpu)			cpu_thread_id[cpu]
+#define topology_core_siblings(cpu)		cpu_core_map[cpu]
+#define topology_thread_siblings(cpu)		cpu_sibling_map[cpu]
+#endif
+
 #ifdef CONFIG_NUMA
 
 #include <asm/mpspec.h>
diff -Nraup linux-2.6.15-rc5/include/asm-ia64/topology.h linux-2.6.15-rc5_topology/include/asm-ia64/topology.h
--- linux-2.6.15-rc5/include/asm-ia64/topology.h	2005-11-07 02:34:08.000000000 +0800
+++ linux-2.6.15-rc5_topology/include/asm-ia64/topology.h	2005-12-14 23:21:58.000000000 +0800
@@ -100,6 +100,14 @@ void build_cpu_to_node_map(void);
 
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)	cpu_data(cpu)->socket_id
+#define topology_core_id(cpu)		cpu_data(cpu)->core_id
+#define topology_thread_id(cpu)		cpu_data(cpu)->thread_id
+#define topology_core_siblings(cpu)		cpu_core_map[cpu]
+#define topology_thread_siblings(cpu)	cpu_sibling_map[cpu]
+#endif
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_IA64_TOPOLOGY_H */
diff -Nraup linux-2.6.15-rc5/include/asm-x86_64/topology.h linux-2.6.15-rc5_topology/include/asm-x86_64/topology.h
--- linux-2.6.15-rc5/include/asm-x86_64/topology.h	2005-12-13 23:07:39.000000000 +0800
+++ linux-2.6.15-rc5_topology/include/asm-x86_64/topology.h	2005-12-15 19:16:05.000000000 +0800
@@ -58,6 +58,14 @@ extern int __node_distance(int, int);
 
 #endif
 
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)	phys_proc_id[cpu]
+#define topology_core_id(cpu)			cpu_core_id[cpu]
+#define topology_thread_id(cpu)			cpu_thread_id[cpu]
+#define topology_core_siblings(cpu)		cpu_core_map[cpu]
+#define topology_thread_siblings(cpu)		cpu_sibling_map[cpu]
+#endif
+
 #include <asm-generic/topology.h>
 
 #endif
