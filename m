Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265106AbSJaCYh>; Wed, 30 Oct 2002 21:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265107AbSJaCYg>; Wed, 30 Oct 2002 21:24:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46486 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265106AbSJaCXe>;
	Wed, 30 Oct 2002 21:23:34 -0500
Message-ID: <3DC094A3.7030903@us.ibm.com>
Date: Wed, 30 Oct 2002 18:25:39 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Mochel <mochel@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] i386 sysfs Topology 2.5.45 (2/5)
References: <3DC09475.2040303@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050707000608050904060109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707000608050904060109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



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
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/arch/i386/kernel/cpu/common.c linux-2.5.45-core_additions/arch/i386/kernel/cpu/common.c
> --- linux-2.5.45-base/arch/i386/kernel/cpu/common.c	Wed Oct 30 16:41:39 2002
> +++ linux-2.5.45-core_additions/arch/i386/kernel/cpu/common.c	Wed Oct 30 17:51:04 2002
> @@ -1,7 +1,6 @@
>  #include <linux/init.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
> -#include <linux/cpu.h>
>  #include <linux/smp.h>
>  #include <asm/semaphore.h>
>  #include <asm/processor.h>
> @@ -507,37 +506,3 @@
>  	current->used_math = 0;
>  	stts();
>  }
> -
> -/*
> - * Bulk registration of the cpu devices with the system.
> - * Some of this stuff could possibly be moved into a shared 
> - * location..
> - * Also, these devices should be integrated with other CPU data..
> - */
> -
> -static struct cpu cpu_devices[NR_CPUS];
> -
> -static struct device_driver cpu_driver = {
> -	.name		= "cpu",
> -	.bus		= &system_bus_type,
> -	.devclass	= &cpu_devclass,
> -};
> -
> -static int __init register_cpus(void)
> -{
> -	int i;
> -
> -	driver_register(&cpu_driver);
> -
> -	for (i = 0; i < NR_CPUS; i++) {
> -		struct sys_device * sysdev = &cpu_devices[i].sysdev;
> -		sysdev->name = "cpu";
> -		sysdev->id = i;
> -		sysdev->dev.driver = &cpu_driver;
> -		if (cpu_possible(i))
> -			sys_device_register(sysdev);
> -	}
> -	return 0;
> -}
> -
> -subsys_initcall(register_cpus);
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/drivers/base/Makefile linux-2.5.45-core_additions/drivers/base/Makefile
> --- linux-2.5.45-base/drivers/base/Makefile	Wed Oct 30 16:43:38 2002
> +++ linux-2.5.45-core_additions/drivers/base/Makefile	Wed Oct 30 17:51:04 2002
> @@ -4,11 +4,13 @@
>  			driver.o class.o intf.o platform.o \
>  			cpu.o
>  
> +obj-$(CONFIG_NUMA)	+= node.o  memblk.o
> +
>  obj-y		+= fs/
>  
>  obj-$(CONFIG_HOTPLUG)	+= hotplug.o
>  
>  export-objs	:= core.o power.o sys.o bus.o driver.o \
> -			class.o intf.o platform.o cpu.o 
> +			class.o intf.o platform.o
>  
>  include $(TOPDIR)/Rules.make
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/drivers/base/cpu.c linux-2.5.45-core_additions/drivers/base/cpu.c
> --- linux-2.5.45-base/drivers/base/cpu.c	Wed Oct 30 16:42:24 2002
> +++ linux-2.5.45-core_additions/drivers/base/cpu.c	Wed Oct 30 17:51:10 2002
> @@ -1,5 +1,5 @@
>  /*
> - * cpu.c - basic cpu class support
> + * drivers/base/cpu.c - basic CPU class support
>   */
>  
>  #include <linux/device.h>
> @@ -7,22 +7,48 @@
>  #include <linux/init.h>
>  #include <linux/cpu.h>
>  
> +#include <asm/topology.h>
> +
> +
>  static int cpu_add_device(struct device * dev)
>  {
>  	return 0;
>  }
> -
>  struct device_class cpu_devclass = {
>  	.name		= "cpu",
>  	.add_device	= cpu_add_device,
>  };
>  
>  
> -static int __init cpu_devclass_init(void)
> +struct device_driver cpu_driver = {
> +	.name		= "cpu",
> +	.bus		= &system_bus_type,
> +	.devclass	= &cpu_devclass,
> +};
> +
> +
> +/*
> + * register_cpu - Setup a driverfs device for a CPU.
> + * @num - CPU number to use when creating the device.
> + *
> + * Initialize and register the CPU device.
> + */
> +int __init register_cpu(struct cpu *cpu, int num, struct node *root)
>  {
> -	return devclass_register(&cpu_devclass);
> +	cpu->node_id = __cpu_to_node(num);
> +	cpu->sysdev.name = "cpu";
> +	cpu->sysdev.id = num;
> +	if (root)
> +		cpu->sysdev.root = &root->sysroot;
> +	snprintf(cpu->sysdev.dev.name, DEVICE_NAME_SIZE, "CPU %u", num);
> +	cpu->sysdev.dev.driver = &cpu_driver;
> +	return sys_device_register(&cpu->sysdev);
>  }
>  
> -postcore_initcall(cpu_devclass_init);
>  
> -EXPORT_SYMBOL(cpu_devclass);
> +static int __init register_cpu_type(void)
> +{
> +	driver_register(&cpu_driver);
> +	return devclass_register(&cpu_devclass);
> +}
> +postcore_initcall(register_cpu_type);
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/drivers/base/memblk.c linux-2.5.45-core_additions/drivers/base/memblk.c
> --- linux-2.5.45-base/drivers/base/memblk.c	Wed Dec 31 16:00:00 1969
> +++ linux-2.5.45-core_additions/drivers/base/memblk.c	Wed Oct 30 17:51:10 2002
> @@ -0,0 +1,55 @@
> +/*
> + * drivers/base/memblk.c - basic Memory Block class support
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/memblk.h>
> +#include <linux/node.h>
> +
> +#include <asm/topology.h>
> +
> +
> +static int memblk_add_device(struct device * dev)
> +{
> +	return 0;
> +}
> +struct device_class memblk_devclass = {
> +	.name		= "memblk",
> +	.add_device	= memblk_add_device,
> +};
> +
> +
> +struct device_driver memblk_driver = {
> +	.name		= "memblk",
> +	.bus		= &system_bus_type,
> +	.devclass	= &memblk_devclass,
> +};
> +
> +
> +/*
> + * register_memblk - Setup a driverfs device for a MemBlk
> + * @num - MemBlk number to use when creating the device.
> + *
> + * Initialize and register the MemBlk device.
> + */
> +int __init register_memblk(struct memblk *memblk, int num, struct node *root)
> +{
> +	memblk->node_id = __memblk_to_node(num);
> +	memblk->sysdev.name = "memblk";
> +	memblk->sysdev.id = num;
> +	if (root)
> +		memblk->sysdev.root = &root->sysroot;
> +	snprintf(memblk->sysdev.dev.name, DEVICE_NAME_SIZE, "Memory Block %u", num);
> +	memblk->sysdev.dev.driver = &memblk_driver;
> +	return sys_device_register(&memblk->sysdev);
> +}
> +
> +
> +static int __init register_memblk_type(void)
> +{
> +	driver_register(&memblk_driver);
> +	return devclass_register(&memblk_devclass);
> +}
> +postcore_initcall(register_memblk_type);
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/drivers/base/node.c linux-2.5.45-core_additions/drivers/base/node.c
> --- linux-2.5.45-base/drivers/base/node.c	Wed Dec 31 16:00:00 1969
> +++ linux-2.5.45-core_additions/drivers/base/node.c	Wed Oct 30 17:52:41 2002
> @@ -0,0 +1,70 @@
> +/*
> + * drivers/base/node.c - basic Node class support
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/node.h>
> +
> +#include <asm/topology.h>
> +
> +
> +static int node_add_device(struct device * dev)
> +{
> +	return 0;
> +}
> +struct device_class node_devclass = {
> +	.name		= "node",
> +	.add_device	= node_add_device,
> +};
> +
> +
> +struct device_driver node_driver = {
> +	.name		= "node",
> +	.bus		= &system_bus_type,
> +	.devclass	= &node_devclass,
> +};
> +
> +
> +static ssize_t node_read_cpumap(struct device * dev, char * buf, size_t count, loff_t off)
> +{
> +	struct node *node_dev = to_node(to_root(dev));
> +        return off ? 0 : sprintf(buf,"%lx\n",node_dev->cpumap);
> +}
> +static DEVICE_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
> +
> +
> +/*
> + * register_node - Setup a driverfs device for a node.
> + * @num - Node number to use when creating the device.
> + *
> + * Initialize and register the node device.
> + */
> +int __init register_node(struct node *node, int num, struct node *parent)
> +{
> +	int error;
> +
> +	node->cpumap = __node_to_cpu_mask(num);
> +	node->sysroot.id = num;
> +	if (parent)
> +		node->sysroot.dev.parent = &parent->sysroot.sysdev;
> +	snprintf(node->sysroot.dev.name, DEVICE_NAME_SIZE, "Node %u", num);
> +	snprintf(node->sysroot.dev.bus_id, BUS_ID_SIZE, "node%u", num);
> +	node->sysroot.dev.driver = &node_driver;
> +	node->sysroot.dev.bus = &system_bus_type;
> +	error = sys_register_root(&node->sysroot);
> +	if (!error){
> +		device_create_file(&node->sysroot.dev, &dev_attr_cpumap);
> +	}
> +	return error;
> +}
> +
> +
> +static int __init register_node_type(void)
> +{
> +	driver_register(&node_driver);
> +	return devclass_register(&node_devclass);
> +}
> +postcore_initcall(register_node_type);
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/drivers/base/sys.c linux-2.5.45-core_additions/drivers/base/sys.c
> --- linux-2.5.45-base/drivers/base/sys.c	Wed Oct 30 16:41:30 2002
> +++ linux-2.5.45-core_additions/drivers/base/sys.c	Wed Oct 30 17:51:04 2002
> @@ -55,6 +55,9 @@
>  	if (!root)
>  		return -EINVAL;
>  
> +	if (!root->dev.parent)
> +		root->dev.parent = &system_bus;
> +
>  	pr_debug("Registering system board %d\n",root->id);
>  
>  	error = device_register(&root->dev);
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/linux/cpu.h linux-2.5.45-core_additions/include/linux/cpu.h
> --- linux-2.5.45-base/include/linux/cpu.h	Wed Oct 30 16:42:19 2002
> +++ linux-2.5.45-core_additions/include/linux/cpu.h	Wed Oct 30 17:51:10 2002
> @@ -1,5 +1,5 @@
>  /*
> - * cpu.h - generic cpu defition
> + * include/linux/cpu.h - generic cpu definition
>   *
>   * This is mainly for topological representation. We define the 
>   * basic 'struct cpu' here, which can be embedded in per-arch 
> @@ -15,14 +15,18 @@
>   * See the following for how to do this: 
>   * - drivers/base/intf.c 
>   * - Documentation/driver-model/interface.txt
> - *
>   */
> +#ifndef _LINUX_CPU_H_
> +#define _LINUX_CPU_H_
>  
>  #include <linux/device.h>
> -
> -extern struct device_class cpu_devclass;
> +#include <linux/node.h>
>  
>  struct cpu {
> +	int node_id;		/* The node which contains the CPU */
>  	struct sys_device sysdev;
>  };
>  
> +extern int register_cpu(struct cpu *, int, struct node *);
> +
> +#endif /* _LINUX_CPU_H_ */
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/linux/memblk.h linux-2.5.45-core_additions/include/linux/memblk.h
> --- linux-2.5.45-base/include/linux/memblk.h	Wed Dec 31 16:00:00 1969
> +++ linux-2.5.45-core_additions/include/linux/memblk.h	Wed Oct 30 17:51:10 2002
> @@ -0,0 +1,32 @@
> +/*
> + * include/linux/memblk.h - generic memblk definition
> + *
> + * This is mainly for topological representation. We define the 
> + * basic 'struct memblk' here, which can be embedded in per-arch 
> + * definitions of memory blocks.
> + *
> + * Basic handling of the devices is done in drivers/base/memblk.c
> + * and system devices are handled in drivers/base/sys.c. 
> + *
> + * MemBlks are exported via driverfs in the class/memblk/devices/
> + * directory. 
> + *
> + * Per-memblk interfaces can be implemented using a struct device_interface. 
> + * See the following for how to do this: 
> + * - drivers/base/intf.c 
> + * - Documentation/driver-model/interface.txt
> + */
> +#ifndef _LINUX_MEMBLK_H_
> +#define _LINUX_MEMBLK_H_
> +
> +#include <linux/device.h>
> +#include <linux/node.h>
> +
> +struct memblk {
> +	int node_id;		/* The node which contains the MemBlk */
> +	struct sys_device sysdev;
> +};
> +
> +extern int register_memblk(struct memblk *, int, struct node *);
> +
> +#endif /* _LINUX_MEMBLK_H_ */
> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/linux/node.h linux-2.5.45-core_additions/include/linux/node.h
> --- linux-2.5.45-base/include/linux/node.h	Wed Dec 31 16:00:00 1969
> +++ linux-2.5.45-core_additions/include/linux/node.h	Wed Oct 30 17:51:10 2002
> @@ -0,0 +1,34 @@
> +/*
> + * include/linux/node.h - generic node definition
> + *
> + * This is mainly for topological representation. We define the 
> + * basic 'struct node' here, which can be embedded in per-arch 
> + * definitions of processors.
> + *
> + * Basic handling of the devices is done in drivers/base/node.c
> + * and system devices are handled in drivers/base/sys.c. 
> + *
> + * Nodes are exported via driverfs in the class/node/devices/
> + * directory. 
> + *
> + * Per-node interfaces can be implemented using a struct device_interface. 
> + * See the following for how to do this: 
> + * - drivers/base/intf.c 
> + * - Documentation/driver-model/interface.txt
> + */
> +#ifndef _LINUX_NODE_H_
> +#define _LINUX_NODE_H_
> +
> +#include <linux/device.h>
> +
> +struct node {
> +	unsigned long cpumap;	/* Bitmap of CPUs on the Node */
> +	struct sys_root sysroot;
> +};
> +
> +extern int register_node(struct node *, int, struct node *);
> +
> +#define to_node(_root) container_of(_root, struct node, sysroot)
> +#define to_root(_dev) container_of(_dev, struct sys_root, dev)
> +
> +#endif /* _LINUX_NODE_H_ */


--------------050707000608050904060109
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

--------------050707000608050904060109--

