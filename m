Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSJUVtD>; Mon, 21 Oct 2002 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJUVtC>; Mon, 21 Oct 2002 17:49:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11239 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261425AbSJUVsv>;
	Mon, 21 Oct 2002 17:48:51 -0400
Message-ID: <3DB476A1.3090307@us.ibm.com>
Date: Mon, 21 Oct 2002 14:50:25 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
       Martin Bligh <mjbligh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo
References: <Pine.LNX.4.44.0210211447110.983-100000@cherise.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------060101030001000000090001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101030001000000090001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patrick Mochel wrote:
> Hey there. 
> 
> 
>>	Here's I've been sitting on a bit too long.  This patch adds Topology 
>>information to driverfs, and adds a meminfo file to each node's 
>>directory which contains: <drum roll> that nodes memory info!
>>	Pat, I got rid of the per-arch callbacks, since they weren't doing 
>>anything even remotely useful yet, and they bloated the patch even 
>>further.  I left in the arch_info pointers so we can put the arch 
>>specific callbacks back in if anyone wants...  I've also rolled Martin's 
>>/proc/meminfo.numa patch into this.
>>	BTW, I have a patch that will changes the usage of 'int numnodes' into 
>>the more generic 'num_online_nodes()' and 'node_set_online()' calls. 
>>I'll be sending that patch momentarily also.
>>	As always: comment, question, and flame away!
> 
> 
> 
> Do we get to see the patch, or was it typed in that pesky invisible font? 
> ;)
> 
> 	-pat
This patch left as an exercise for the reader.

;)

Sorry about that!  I've really got to find a MUA that knows what I'm 
trying to do, and does it for me.  I mean, Mozilla clearly should have 
seen, from the body of the message, that I meant to attatch that patch, 
so why didn't it do it for me?  Computers are supposed to make our lives 
easier, right?  It is almost 2003 after all!  Where's my flying car and 
telepathic computer!?!?  ;)

-Matt

--------------060101030001000000090001
Content-Type: text/plain;
 name="driverfs-additions-2.5.44.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driverfs-additions-2.5.44.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/kernel/cpu/common.c linux-2.5.44-additions/arch/i386/kernel/cpu/common.c
--- linux-2.5.44-vanilla/arch/i386/kernel/cpu/common.c	Fri Oct 18 21:01:09 2002
+++ linux-2.5.44-additions/arch/i386/kernel/cpu/common.c	Sun Oct 20 14:06:12 2002
@@ -1,7 +1,6 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/delay.h>
-#include <linux/cpu.h>
 #include <linux/smp.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
@@ -507,37 +506,3 @@
 	current->used_math = 0;
 	stts();
 }
-
-/*
- * Bulk registration of the cpu devices with the system.
- * Some of this stuff could possibly be moved into a shared 
- * location..
- * Also, these devices should be integrated with other CPU data..
- */
-
-static struct cpu cpu_devices[NR_CPUS];
-
-static struct device_driver cpu_driver = {
-	.name		= "cpu",
-	.bus		= &system_bus_type,
-	.devclass	= &cpu_devclass,
-};
-
-static int __init register_cpus(void)
-{
-	int i;
-
-	driver_register(&cpu_driver);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		struct sys_device * sysdev = &cpu_devices[i].sysdev;
-		sysdev->name = "cpu";
-		sysdev->id = i;
-		sysdev->dev.driver = &cpu_driver;
-		if (cpu_possible(i))
-			sys_device_register(sysdev);
-	}
-	return 0;
-}
-
-subsys_initcall(register_cpus);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/kernel/numaq.c linux-2.5.44-additions/arch/i386/kernel/numaq.c
--- linux-2.5.44-vanilla/arch/i386/kernel/numaq.c	Fri Oct 18 21:01:17 2002
+++ linux-2.5.44-additions/arch/i386/kernel/numaq.c	Mon Oct 21 14:05:25 2002
@@ -52,6 +52,7 @@
 	numnodes = 0;
 	for(node = 0; node < MAX_NUMNODES; node++) {
 		if(scd->quads_present31_0 & (1 << node)) {
+			node_set_online(node);
 			numnodes++;
 			eq = &scd->eq[node];
 			/* Convert to pages */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/mach-generic/Makefile linux-2.5.44-additions/arch/i386/mach-generic/Makefile
--- linux-2.5.44-vanilla/arch/i386/mach-generic/Makefile	Fri Oct 18 21:01:19 2002
+++ linux-2.5.44-additions/arch/i386/mach-generic/Makefile	Sun Oct 20 14:06:12 2002
@@ -4,6 +4,6 @@
 
 EXTRA_CFLAGS	+= -I../kernel
 
-obj-y				:= setup.o
+obj-y				:= setup.o topology.o
 
 include $(TOPDIR)/Rules.make
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/mach-generic/topology.c linux-2.5.44-additions/arch/i386/mach-generic/topology.c
--- linux-2.5.44-vanilla/arch/i386/mach-generic/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-additions/arch/i386/mach-generic/topology.c	Sun Oct 20 14:06:12 2002
@@ -0,0 +1,51 @@
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
+#include <linux/mmzone.h>
+#include <linux/node.h>
+#include <linux/cpu.h>
+#include <linux/memblk.h>
+
+#include <asm/topology.h>
+
+/*
+ * Populate driverfs with the system topology
+ */
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < num_online_nodes(); i++)
+		register_node(i);
+	for (i = 0; i < num_online_cpus(); i++)
+		register_cpu(i);
+	for (i = 0; i < num_online_memblks(); i++)
+		register_memblk(i);
+	return 0;
+}
+subsys_initcall(topology_init);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/drivers/base/Makefile linux-2.5.44-additions/drivers/base/Makefile
--- linux-2.5.44-vanilla/drivers/base/Makefile	Fri Oct 18 21:01:19 2002
+++ linux-2.5.44-additions/drivers/base/Makefile	Sun Oct 20 14:06:12 2002
@@ -2,13 +2,14 @@
 
 obj-y		:= core.o sys.o interface.o power.o bus.o \
 			driver.o class.o intf.o platform.o \
-			cpu.o
+			node.o cpu.o memblk.o
 
 obj-y		+= fs/
 
 obj-$(CONFIG_HOTPLUG)	+= hotplug.o
 
 export-objs	:= core.o power.o sys.o bus.o driver.o \
-			class.o intf.o platform.o cpu.o 
+			class.o intf.o platform.o node.o \
+			cpu.o memblk.o
 
 include $(TOPDIR)/Rules.make
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/drivers/base/cpu.c linux-2.5.44-additions/drivers/base/cpu.c
--- linux-2.5.44-vanilla/drivers/base/cpu.c	Fri Oct 18 21:01:21 2002
+++ linux-2.5.44-additions/drivers/base/cpu.c	Sun Oct 20 14:06:12 2002
@@ -1,28 +1,59 @@
 /*
- * cpu.c - basic cpu class support
+ * drivers/base/cpu.c - basic CPU class support
  */
 
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/node.h>
 #include <linux/cpu.h>
 
+#include <asm/topology.h>
+
+
+struct cpu cpu_devices[NR_CPUS];
+
 static int cpu_add_device(struct device * dev)
 {
 	return 0;
 }
-
 struct device_class cpu_devclass = {
 	.name		= "cpu",
 	.add_device	= cpu_add_device,
 };
 
 
-static int __init cpu_devclass_init(void)
+struct device_driver cpu_driver = {
+	.name		= "cpu",
+	.bus		= &system_bus_type,
+	.devclass	= &cpu_devclass,
+};
+
+
+/*
+ * register_cpu - Setup a driverfs device for a CPU.
+ * @num - CPU number to use when creating the device.
+ *
+ * Initialize and register the CPU device.
+ */
+void __init register_cpu(int num)
 {
-	return devclass_register(&cpu_devclass);
+	int node_id = __cpu_to_node(num);
+	struct sys_device *cpu = &cpu_devices[num].sysdev;
+
+	cpu_devices[num].node_id = node_id;
+	cpu->name = "cpu";
+	cpu->id = num;
+	cpu->root = &node_devices[node_id].sysroot;
+	snprintf(cpu->dev.name, DEVICE_NAME_SIZE, "CPU %u", num);
+	cpu->dev.driver = &cpu_driver;
+	sys_device_register(cpu);
 }
 
-postcore_initcall(cpu_devclass_init);
 
-EXPORT_SYMBOL(cpu_devclass);
+static int __init register_cpu_type(void)
+{
+	driver_register(&cpu_driver);
+	return devclass_register(&cpu_devclass);
+}
+postcore_initcall(register_cpu_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/drivers/base/memblk.c linux-2.5.44-additions/drivers/base/memblk.c
--- linux-2.5.44-vanilla/drivers/base/memblk.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-additions/drivers/base/memblk.c	Sun Oct 20 14:06:12 2002
@@ -0,0 +1,59 @@
+/*
+ * drivers/base/memblk.c - basic Memory Block class support
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/node.h>
+#include <linux/memblk.h>
+
+#include <asm/topology.h>
+
+
+struct memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static int memblk_add_device(struct device * dev)
+{
+	return 0;
+}
+struct device_class memblk_devclass = {
+	.name		= "memblk",
+	.add_device	= memblk_add_device,
+};
+
+
+struct device_driver memblk_driver = {
+	.name		= "memblk",
+	.bus		= &system_bus_type,
+	.devclass	= &memblk_devclass,
+};
+
+
+/*
+ * register_memblk - Setup a driverfs device for a MemBlk
+ * @num - MemBlk number to use when creating the device.
+ *
+ * Initialize and register the MemBlk device.
+ */
+void __init register_memblk(int num)
+{
+	int node_id = __memblk_to_node(num);
+	struct sys_device *memblk = &memblk_devices[num].sysdev;
+
+	memblk_devices[num].node_id = node_id;
+	memblk->name = "memblk";
+	memblk->id = num;
+	memblk->root = &node_devices[node_id].sysroot;
+	snprintf(memblk->dev.name, DEVICE_NAME_SIZE, "Memory Block %u", num);
+	memblk->dev.driver = &memblk_driver;
+	sys_device_register(memblk);
+}
+
+
+static int __init register_memblk_type(void)
+{
+	driver_register(&memblk_driver);
+	return devclass_register(&memblk_devclass);
+}
+postcore_initcall(register_memblk_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/drivers/base/node.c linux-2.5.44-additions/drivers/base/node.c
--- linux-2.5.44-vanilla/drivers/base/node.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-additions/drivers/base/node.c	Mon Oct 21 10:59:08 2002
@@ -0,0 +1,109 @@
+/*
+ * drivers/base/node.c - basic Node class support
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/node.h>
+#include <linux/mm.h>
+
+#include <asm/topology.h>
+
+
+struct node node_devices[MAX_NUMNODES];
+
+static int node_add_device(struct device * dev)
+{
+	return 0;
+}
+struct device_class node_devclass = {
+	.name		= "node",
+	.add_device	= node_add_device,
+};
+
+
+struct device_driver node_driver = {
+	.name		= "node",
+	.bus		= &system_bus_type,
+	.devclass	= &node_devclass,
+};
+
+
+static ssize_t node_read_cpumap(struct device * dev, char * buf, size_t count, loff_t off)
+{
+	struct node *node_dev = to_node(to_root(dev));
+        return off ? 0 : sprintf(buf,"%lx\n",node_dev->cpumap);
+}
+static DEVICE_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
+
+#define K(x) ((x) << (PAGE_SHIFT - 10))
+static ssize_t node_read_meminfo(struct device * dev, char * buf, size_t count, loff_t off)
+{
+	struct sys_root *node = to_root(dev);
+	int nid = node->id;
+	struct sysinfo i;
+#ifdef CONFIG_NUMA
+	si_meminfo_node(&i, nid);
+#else
+	si_meminfo(&i);
+#endif
+	return off ? 0 : sprintf(buf, "\n"
+			"Node %d MemTotal:     %8lu kB\n"
+			"Node %d MemFree:      %8lu kB\n"
+			"Node %d MemUsed:      %8lu kB\n"
+			"Node %d HighTotal:    %8lu kB\n"
+			"Node %d HighFree:     %8lu kB\n"
+			"Node %d LowTotal:     %8lu kB\n"
+			"Node %d LowFree:      %8lu kB\n",
+			nid, K(i.totalram),
+			nid, K(i.freeram),
+			nid, K(i.totalram-i.freeram),
+			nid, K(i.totalhigh),
+			nid, K(i.freehigh),
+			nid, K(i.totalram-i.totalhigh),
+			nid, K(i.freeram-i.freehigh));
+
+	return 0;
+}
+#undef K 
+static DEVICE_ATTR(meminfo,S_IRUGO,node_read_meminfo,NULL);
+
+
+/*
+ * register_node - Setup a driverfs device for a node.
+ * @num - Node number to use when creating the device.
+ *
+ * Initialize and register the node device.
+ */
+void __init register_node(int num)
+{
+	int parent = __parent_node(num);
+	struct sys_root *node = &node_devices[num].sysroot;
+
+	node_devices[num].cpumap = __node_to_cpu_mask(num);
+	node->id = num;
+	/* Check for hierarchical nodes */
+	if (parent != num)
+		node->dev.parent = &node_devices[parent].sysroot.sysdev;
+	else
+		node->dev.parent = &system_bus;
+	snprintf(node->dev.name, DEVICE_NAME_SIZE, "Node %u", num);
+	snprintf(node->dev.bus_id, BUS_ID_SIZE, "node%u", num);
+	node->dev.bus = &system_bus_type;
+	node->dev.driver = &node_driver;
+	if (sys_register_root(node)){
+		printk("ERROR CREATING NODE!!!\n");
+		BUG();
+	}
+	device_create_file(&node->dev, &dev_attr_cpumap);
+	device_create_file(&node->dev, &dev_attr_meminfo);
+}
+
+
+static int __init register_node_type(void)
+{
+	driver_register(&node_driver);
+	return devclass_register(&node_devclass);
+}
+postcore_initcall(register_node_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/cpu.h linux-2.5.44-additions/include/linux/cpu.h
--- linux-2.5.44-vanilla/include/linux/cpu.h	Fri Oct 18 21:01:17 2002
+++ linux-2.5.44-additions/include/linux/cpu.h	Sun Oct 20 14:06:12 2002
@@ -1,8 +1,8 @@
 /*
- * cpu.h - generic cpu defition
+ * include/linux/cpu.h - generic cpu definition
  *
  * This is mainly for topological representation. We define the 
- * basic 'struct cpu' here, which can be embedded in per-arch 
+ * basic 'struct cpu' here, which has embedded per-arch 
  * definitions of processors.
  *
  * Basic handling of the devices is done in drivers/base/cpu.c
@@ -15,14 +15,15 @@
  * See the following for how to do this: 
  * - drivers/base/intf.c 
  * - Documentation/driver-model/interface.txt
- *
  */
 
 #include <linux/device.h>
 
-extern struct device_class cpu_devclass;
-
 struct cpu {
+	int node_id;		/* The node which contains the CPU */
+	void *arch_info;	/* Points to arch specific CPU info */
 	struct sys_device sysdev;
 };
+extern struct cpu cpu_devices[NR_CPUS];
 
+extern void register_cpu(int);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/memblk.h linux-2.5.44-additions/include/linux/memblk.h
--- linux-2.5.44-vanilla/include/linux/memblk.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-additions/include/linux/memblk.h	Sun Oct 20 14:06:12 2002
@@ -0,0 +1,30 @@
+/*
+ * include/linux/memblk.h - generic memblk definition
+ *
+ * This is mainly for topological representation. We define the 
+ * basic 'struct memblk' here, which has embedded per-arch 
+ * definitions of memory blocks.
+ *
+ * Basic handling of the devices is done in drivers/base/memblk.c
+ * and system devices are handled in drivers/base/sys.c. 
+ *
+ * MemBlks are exported via driverfs in the class/memblk/devices/
+ * directory. 
+ *
+ * Per-memblk interfaces can be implemented using a struct device_interface. 
+ * See the following for how to do this: 
+ * - drivers/base/intf.c 
+ * - Documentation/driver-model/interface.txt
+ */
+
+#include <linux/device.h>
+#include <linux/mmzone.h>
+
+struct memblk {
+	int node_id;		/* The node which contains the MemBlk */
+	void *arch_info;	/* Points to arch specific MemBlk info */
+	struct sys_device sysdev;
+};
+extern struct memblk memblk_devices[MAX_NR_MEMBLKS];
+
+extern void register_memblk(int);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/mm.h linux-2.5.44-additions/include/linux/mm.h
--- linux-2.5.44-vanilla/include/linux/mm.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-additions/include/linux/mm.h	Sun Oct 20 14:06:12 2002
@@ -450,6 +450,9 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
+#ifdef CONFIG_NUMA
+extern void si_meminfo_node(struct sysinfo *val, int nid);
+#endif
 extern void swapin_readahead(swp_entry_t);
 
 extern int can_share_swap_page(struct page *);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/mmzone.h linux-2.5.44-additions/include/linux/mmzone.h
--- linux-2.5.44-vanilla/include/linux/mmzone.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-additions/include/linux/mmzone.h	Mon Oct 21 14:12:03 2002
@@ -262,6 +262,65 @@
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
+
+extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
+extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
+
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
+
+#define node_online(node)	test_bit(node, node_online_map)
+#define node_set_online(node)	set_bit(node, node_online_map)
+#define node_set_offline(node)	clear_bit(node, node_online_map)
+static inline unsigned int num_online_nodes(void)
+{
+	int i, num = 0;
+
+	for(i = 0; i < MAX_NUMNODES; i++){
+		if (node_online(i))
+			num++;
+	}
+	return num;
+}
+
+#define memblk_online(memblk)		test_bit(memblk, memblk_online_map)
+#define memblk_set_online(memblk)	set_bit(memblk, memblk_online_map)
+#define memblk_set_offline(memblk)	clear_bit(memblk, memblk_online_map)
+static inline unsigned int num_online_memblks(void)
+{
+	int i, num = 0;
+
+	for(i = 0; i < MAX_NR_MEMBLKS; i++){
+		if (memblk_online(i))
+			num++;
+	}
+	return num;
+}
+
+#else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
+
+#define test(num)	BUG_ON((num) != 0)
+
+#define node_online(node) \
+	({ test(node); test_bit(node, node_online_map); })
+#define node_set_online(node) \
+	({ test(node); set_bit(node, node_online_map); })
+#define node_set_offline(node) \
+	({ test(node); clear_bit(node, node_online_map); })
+#define num_online_nodes()	1
+
+#define memblk_online(memblk) \
+	({ test(memblk); test_bit(memblk, memblk_online_map); })
+#define memblk_set_online(memblk) \
+	({ test(memblk); set_bit(memblk, memblk_online_map); })
+#define memblk_set_offline(memblk) \
+	({ test(memblk); clear_bit(memblk, memblk_online_map); })
+#define num_online_memblks()		1
+
+#undef test
+
+#endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
+
+
 #define MAP_ALIGN(x)	((((x) % sizeof(struct page)) == 0) ? (x) : ((x) + \
 		sizeof(struct page) - ((x) % sizeof(struct page))))
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/node.h linux-2.5.44-additions/include/linux/node.h
--- linux-2.5.44-vanilla/include/linux/node.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-additions/include/linux/node.h	Sun Oct 20 14:06:12 2002
@@ -0,0 +1,33 @@
+/*
+ * include/linux/node.h - generic node definition
+ *
+ * This is mainly for topological representation. We define the 
+ * basic 'struct node' here, which has embedded per-arch 
+ * definitions of processors.
+ *
+ * Basic handling of the devices is done in drivers/base/node.c
+ * and system devices are handled in drivers/base/sys.c. 
+ *
+ * NODEs are exported via driverfs in the class/node/devices/
+ * directory. 
+ *
+ * Per-node interfaces can be implemented using a struct device_interface. 
+ * See the following for how to do this: 
+ * - drivers/base/intf.c 
+ * - Documentation/driver-model/interface.txt
+ */
+
+#include <linux/device.h>
+#include <linux/mmzone.h>
+
+struct node {
+	unsigned long cpumap;	/* Bitmap of CPUs on the Node */
+	void *arch_info;	/* Points to arch specific Node info */
+	struct sys_root sysroot;
+};
+extern struct node node_devices[MAX_NUMNODES];
+
+extern void register_node(int);
+
+#define to_node(_root) container_of(_root, struct node, sysroot)
+#define to_root(_dev) container_of(_dev, struct sys_root, dev)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/swap.h linux-2.5.44-additions/include/linux/swap.h
--- linux-2.5.44-vanilla/include/linux/swap.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-additions/include/linux/swap.h	Sun Oct 20 14:06:12 2002
@@ -131,6 +131,7 @@
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 extern unsigned int nr_free_pages(void);
+extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/mm/page_alloc.c linux-2.5.44-additions/mm/page_alloc.c
--- linux-2.5.44-vanilla/mm/page_alloc.c	Fri Oct 18 21:01:09 2002
+++ linux-2.5.44-additions/mm/page_alloc.c	Mon Oct 21 14:17:51 2002
@@ -26,6 +26,10 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 
+#include <asm/topology.h>
+
+DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
+DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -504,6 +508,16 @@
 	return pages;
 }
 
+unsigned int nr_free_pages_pgdat(pg_data_t *pgdat)
+{
+	unsigned int i, sum = 0;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += pgdat->node_zones[i].free_pages;
+
+	return sum;
+}
+
 static unsigned int nr_free_zone_pages(int offset)
 {
 	pg_data_t *pgdat;
@@ -631,6 +645,22 @@
 	val->mem_unit = PAGE_SIZE;
 }
 
+void si_meminfo_node(struct sysinfo *val, int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	val->totalram = pgdat->node_size;
+	val->freeram = nr_free_pages_pgdat(pgdat);
+#ifdef CONFIG_HIGHMEM
+	val->totalhigh = pgdat->node_zones[ZONE_HIGHMEM].spanned_pages;
+	val->freehigh = pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+#else
+	val->totalhigh = 0;
+	val->freehigh = 0;
+#endif
+	val->mem_unit = PAGE_SIZE;
+}
+
 #define K(x) ((x) << (PAGE_SHIFT-10))
 
 /*
@@ -1014,6 +1044,7 @@
 	pgdat->node_mem_map = node_mem_map;
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
+	memblk_set_online(__node_to_memblk(nid));
 
 	calculate_zone_bitmap(pgdat, zones_size);
 }

--------------060101030001000000090001--

