Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310317AbSCKSBw>; Mon, 11 Mar 2002 13:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSCKSBj>; Mon, 11 Mar 2002 13:01:39 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41718 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310304AbSCKSBV>;
	Mon, 11 Mar 2002 13:01:21 -0500
Date: Mon, 11 Mar 2002 10:00:45 -0800
Message-Id: <200203111800.g2BI0jN09908@localhost.localdomain>
From: Paul Dorwin <padorwin@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Adding cpus and numa nodes to driverfs
cc: hohnbaum@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider this patch for inclusion in 2.5.7. What it does:

- Re-introduce the system bus which Patrick Mochel has previoulsy discussed.
- Places cpus in the #MNT/root/sys directory.
- On a MULTIQUAD system, it creates $MNT/root/node[0-N]/sys and 
  places the cpus in their respective nodes
- Makes use of a part of Matthew Dobson's NUMA API work.

This patch has been tested on a single proc desktop, 4-way SMP, 
and 8-way IBM Numa-Q using a 2.5.6-pre3 kernel.

Many thanks to Patrick Mochel for his help in creating this patch.

Paul Dorwin
padorwin@us.ibm.com

diff -Nru a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	Fri Mar  8 05:39:03 2002
+++ b/arch/i386/Config.help	Fri Mar  8 05:39:03 2002
@@ -48,6 +48,13 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
+CONFIG_NUMA_API
+  This option is used to turn on support for the NUMA API, which allows
+  the binding of processes to specific processors/nodes/memory blocks.
+  This option is also used for some of the NUMA Topology features.
+  Please email Matthew Dobson <colpatch@us.ibm.com> with questions
+  and/or concers.
+
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Fri Mar  8 05:39:03 2002
+++ b/arch/i386/config.in	Fri Mar  8 05:39:03 2002
@@ -190,6 +190,7 @@
    fi
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Non-Uniform Memory Access API support' CONFIG_NUMA_API
 fi
 
 if [ "$CONFIG_SMP" = "y" -o "$CONFIG_PREEMPT" = "y" ]; then
diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Fri Mar  8 05:39:03 2002
+++ b/drivers/base/Makefile	Fri Mar  8 05:39:03 2002
@@ -1,7 +1,7 @@
 O_TARGET	:= base.o
 
-obj-y		:= core.o interface.o fs.o
+obj-y		:= core.o interface.o fs.o sys.o sysdev.o
 
-export-objs	:= core.o interface.o fs.o 
+export-objs	:= core.o interface.o fs.o sys.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/sys.c	Fri Mar  8 05:39:03 2002
@@ -0,0 +1,48 @@
+/*
+ * sys.c - pseudo-bus for system 'devices' (cpus, PICs, timers, etc)
+ *
+ * Copyright (c) 2002 Patrick Mochel
+ *              2002 Open Source Development Lab
+ * 
+ * This exports a 'system' bus type. 
+ * By default, a 'sys' bus gets added to the root of the system. There will
+ * always be core system devices. Devices can use register_sys_device() to
+ * add themselves as children of the system bus.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+static struct device system_bus = {
+       name:           "System Bus",
+       bus_id:         "sys",
+};
+
+int register_sys_device(struct device * dev)
+{
+       int error = -EINVAL;
+
+       if (dev) {
+               if (!dev->parent)
+                       dev->parent = &system_bus;
+               error = device_register(dev);
+       }
+       return error;
+}
+
+void unregister_sys_device(struct device * dev)
+{
+       if (dev)
+               put_device(dev);
+}
+
+static int sys_bus_init(void)
+{
+       return device_register(&system_bus);
+}
+
+subsys_initcall(sys_bus_init);
+EXPORT_SYMBOL(register_sys_device);
+EXPORT_SYMBOL(unregister_sys_device);
diff -Nru a/drivers/base/sysdev.c b/drivers/base/sysdev.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/sysdev.c	Fri Mar  8 05:39:03 2002
@@ -0,0 +1,154 @@
+/*
+ * drivers/base/sysdev.c - Populate driverfs with system devices
+ *
+ * Written by: Paul Dorwin, IBM Corporation
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
+ * Send feedback to <padorwin@us.ibm.com>
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/numa_api.h>
+
+/**
+ * Node device initialization
+ */
+
+struct node_dev {
+	int nd_nid;
+	unsigned long nd_cpumap;	/* Map of cpus on the node */
+	struct device nd_dev;
+	struct device nd_sysdev;
+};
+
+static struct node_dev * node_devs[MAX_NUMNODES];
+
+static ssize_t node_show_cpumap(struct device * dev, char * buf, size_t count, loff_t off)
+{
+	struct node_dev * node_dev = list_entry(dev,struct node_dev, nd_dev);
+	return off ? 0 : sprintf(buf,"0x%08lx\n",node_dev->nd_cpumap);
+}
+
+static struct driver_file_entry node_cpumap_entry = {
+	name:	"cpumap",
+	mode:	S_IRUGO,
+	show:	node_show_cpumap,
+};
+/**
+ * init_nodedev - Setup a driverfs device for a node
+ * @node - Node number to use when creating the device.
+ *
+ * Check to see if the node is already initialized.
+ * Allocate, initialize, and register the node device.
+ */
+static __init void init_nodedev(int node)
+{
+	struct node_dev *dev;
+
+	if (node_devs[node]) {
+		return;
+	}
+	
+	DBG("%s: init node %d \n", __FUNCTION__, node);
+	if ((dev = kmalloc(sizeof(*dev), GFP_KERNEL)) == NULL) {
+		DBG("%s: kmalloc failed\n", __FUNCTION__);
+		return;
+	}
+	
+	memset(dev, 0, sizeof(*dev));
+	sprintf(dev->nd_dev.bus_id, "node%d", node);
+	sprintf(dev->nd_dev.name, "NUMA Node");
+	dev->nd_nid = node;
+	device_register(&dev->nd_dev);
+	device_create_file(&dev->nd_dev, &node_cpumap_entry);
+	node_devs[node] = dev;
+	/*
+	 * Now create node/sys device
+	 */
+	sprintf(dev->nd_sysdev.bus_id, "sys");
+	sprintf(dev->nd_sysdev.name, "NUMA Node System Bus");
+	dev->nd_sysdev.parent = &dev->nd_dev;
+	device_register(&dev->nd_sysdev);
+}
+
+/**
+ * CPU device initialization
+ */
+struct cpu_dev {
+	int cd_cpuid;		/* The system cpuid - not persistant */
+	int cd_nid;		/* The node which contains the cpu */
+	struct device cd_dev;
+};
+
+/**
+ * init_cpudev - Setup a driverfs device for a CPU
+ * @cpu: Cpu number to use when creating the device.
+ *
+ * Setup current node.
+ * Allocate, initialize, and register the CPU device.
+ * Add this cpu to the containing node's nd_cpumap
+ */
+static __init void init_cpudev(int cpu)
+{
+	struct cpu_dev * dev;
+
+	DBG("%s: init cpu %d\n", __FUNCTION__, cpu);
+	if ((dev = (struct cpu_dev *)kmalloc(sizeof(*dev), GFP_KERNEL)) == NULL) {
+		DBG("%s: kmalloc failed\n", __FUNCTION__);
+		return;
+	}
+
+	memset(dev, 0, sizeof(*dev));
+	sprintf(dev->cd_dev.bus_id, "cpu%d", cpu);
+	sprintf(dev->cd_dev.name, "System Processor");
+	dev->cd_cpuid = cpu;
+	if (numa_topology) {
+		int nid = _cpu_to_node(cpu);
+		dev->cd_nid = nid;
+		dev->cd_dev.parent = &node_devs[nid]->nd_sysdev;
+		node_devs[nid]->nd_cpumap |= 1 << cpu;
+	} else {
+		dev->cd_nid = -1;
+	}
+	register_sys_device(&dev->cd_dev);
+}
+
+/**
+ * Populate driverfs with the system devices (nodes and cpus)
+ */
+static int __init sysdev_init(void)
+{
+	int cpu = 0;
+	int node = 0;
+
+	if (numa_topology) {
+		for (node = 0; node < numnodes; node++)
+			init_nodedev(node);
+	}
+	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+		init_cpudev(cpu);
+	}
+	return 0;
+}
+
+subsys_initcall(sysdev_init);
diff -Nru a/include/asm-i386/numa_api.h b/include/asm-i386/numa_api.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/numa_api.h	Fri Mar  8 05:39:03 2002
@@ -0,0 +1,21 @@
+/*
+ * linux/include/asm-i386/mmzone.h
+ *
+ * Pre-cursor to work by Matthew Dobson, IBM Corporation
+ */
+#ifndef _ASM_MMZONE_H_
+#define _ASM_MMZONE_H_
+
+#include <asm/smpboot.h>
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define _cpu_to_node(cpu)	(cpu_to_logical_apicid(cpu) >> 4)
+
+#ifdef CONFIG_MULTIQUAD
+#define MAX_NUMNODES 32
+#define numa_topology 1
+#else
+#define MAX_NUMNODES 1
+#endif
+
+#endif /* _ASM_MMZONE_H_ */
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Fri Mar  8 05:39:03 2002
+++ b/include/linux/device.h	Fri Mar  8 05:39:03 2002
@@ -107,6 +107,9 @@
 extern int device_create_file(struct device *device, struct driver_file_entry * entry);
 extern void device_remove_file(struct device * dev, const char * name);
 
+extern int register_sys_device(struct device * dev);
+extern void unregister_sys_device(struct device * dev);
+
 /*
  * Platform "fixup" functions - allow the platform to have their say
  * about devices and actions that the general device layer doesn't
diff -Nru a/include/linux/numa_api.h b/include/linux/numa_api.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/numa_api.h	Fri Mar  8 05:39:03 2002
@@ -0,0 +1,27 @@
+/*
+ *  linux/include/linux/numa.h
+ *
+ * Pre-cursor to work by Matthew Dobson, IBM Corporation
+ */
+#ifndef _LINUX_NUMA_H_
+#define _LINUX_NUMA_H_
+
+#include <linux/types.h>
+
+#define NUMA_API_DEBUG
+
+#ifdef NUMA_API_DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+#ifdef CONFIG_NUMA_API
+#include <asm/numa_api.h>
+
+#else /*! CONFIG_NUMA_API - Keep gcc happy */
+#define _cpu_to_node(cpu) (0)
+#define MAX_NUMNODES 1
+#define numa_topology 0
+#endif /* CONFIG_NUMA_API */
+#endif /* _LINUX_NUMA_H_ */
