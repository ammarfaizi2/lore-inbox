Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJABAt>; Mon, 30 Sep 2002 21:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSJABAt>; Mon, 30 Sep 2002 21:00:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50158 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261434AbSJABAl>; Mon, 30 Sep 2002 21:00:41 -0400
Message-ID: <3D98F450.8080003@us.ibm.com>
Date: Mon, 30 Sep 2002 18:03:12 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [rfc][patch] driverfs multi-node(board) patch [2/2]
References: <3D98F3AD.2030607@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050608060201030908090905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050608060201030908090905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patrick,
	Ok..  here are the real changes.  I'd really like to get some feedback on 
what you (or anyone else) thinks of these proposed changes.  This sets 
up a generic topology initialization routine which should discover all 
online nodes (boards), CPUs, and Memory Blocks at boot time.  It also 
makes the CPUs and memblks it discovers children of the appropriate nodes.

Cheers!

-Matt

--------------050608060201030908090905
Content-Type: text/plain;
 name="driverfs-additions-2.5.39.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driverfs-additions-2.5.39.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/arch/i386/kernel/cpu/common.c linux-2.5.39-mm1+pre_reqs+additions/arch/i386/kernel/cpu/common.c
--- linux-2.5.39-mm1+pre_reqs/arch/i386/kernel/cpu/common.c	Fri Sep 27 14:49:02 2002
+++ linux-2.5.39-mm1+pre_reqs+additions/arch/i386/kernel/cpu/common.c	Mon Sep 30 14:37:50 2002
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/drivers/base/Makefile linux-2.5.39-mm1+pre_reqs+additions/drivers/base/Makefile
--- linux-2.5.39-mm1+pre_reqs/drivers/base/Makefile	Fri Sep 27 14:49:17 2002
+++ linux-2.5.39-mm1+pre_reqs+additions/drivers/base/Makefile	Mon Sep 30 14:37:50 2002
@@ -2,13 +2,14 @@
 
 obj-y		:= core.o sys.o interface.o power.o bus.o \
 			driver.o class.o intf.o platform.o \
-			cpu.o
+			node.o cpu.o memblk.o topology.o
 
 obj-y		+= fs/
 
 obj-$(CONFIG_HOTPLUG)	+= hotplug.o
 
 export-objs	:= core.o power.o sys.o bus.o driver.o \
-			class.o intf.o platform.o cpu.o 
+			class.o intf.o platform.o node.o \
+			cpu.o memblk.o
 
 include $(TOPDIR)/Rules.make
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/drivers/base/cpu.c linux-2.5.39-mm1+pre_reqs+additions/drivers/base/cpu.c
--- linux-2.5.39-mm1+pre_reqs/drivers/base/cpu.c	Fri Sep 27 14:49:42 2002
+++ linux-2.5.39-mm1+pre_reqs+additions/drivers/base/cpu.c	Mon Sep 30 14:37:50 2002
@@ -5,7 +5,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/cpu.h>
 
 static int cpu_add_device(struct device * dev)
 {
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/drivers/base/memblk.c linux-2.5.39-mm1+pre_reqs+additions/drivers/base/memblk.c
--- linux-2.5.39-mm1+pre_reqs/drivers/base/memblk.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.39-mm1+pre_reqs+additions/drivers/base/memblk.c	Mon Sep 30 14:37:50 2002
@@ -0,0 +1,27 @@
+/*
+ * memblk.c - basic memblk class support
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+static int memblk_add_device(struct device * dev)
+{
+	return 0;
+}
+
+struct device_class memblk_devclass = {
+	.name		= "memblk",
+	.add_device	= memblk_add_device,
+};
+
+
+static int __init memblk_devclass_init(void)
+{
+	return devclass_register(&memblk_devclass);
+}
+
+postcore_initcall(memblk_devclass_init);
+
+EXPORT_SYMBOL(memblk_devclass);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/drivers/base/node.c linux-2.5.39-mm1+pre_reqs+additions/drivers/base/node.c
--- linux-2.5.39-mm1+pre_reqs/drivers/base/node.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.39-mm1+pre_reqs+additions/drivers/base/node.c	Mon Sep 30 14:37:50 2002
@@ -0,0 +1,27 @@
+/*
+ * node.c - basic node class support
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+static int node_add_device(struct device * dev)
+{
+	return 0;
+}
+
+struct device_class node_devclass = {
+	.name		= "node",
+	.add_device	= node_add_device,
+};
+
+
+static int __init node_devclass_init(void)
+{
+	return devclass_register(&node_devclass);
+}
+
+postcore_initcall(node_devclass_init);
+
+EXPORT_SYMBOL(node_devclass);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/drivers/base/sys.c linux-2.5.39-mm1+pre_reqs+additions/drivers/base/sys.c
--- linux-2.5.39-mm1+pre_reqs/drivers/base/sys.c	Fri Sep 27 14:48:33 2002
+++ linux-2.5.39-mm1+pre_reqs+additions/drivers/base/sys.c	Mon Sep 30 14:37:50 2002
@@ -55,6 +55,9 @@
 
 	pr_debug("Registering system board %d\n",root->id);
 
+	if (!root->dev.parent)
+		root->dev.parent = &system_bus;
+
 	error = device_register(&root->dev);
 	if (!error) {
 		strncpy(root->sysdev.bus_id,"sys",BUS_ID_SIZE);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-mm1+pre_reqs/drivers/base/topology.c linux-2.5.39-mm1+pre_reqs+additions/drivers/base/topology.c
--- linux-2.5.39-mm1+pre_reqs/drivers/base/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.39-mm1+pre_reqs+additions/drivers/base/topology.c	Mon Sep 30 14:37:50 2002
@@ -0,0 +1,175 @@
+/*
+ * drivers/base/topology.c - Populate driverfs with topology information
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
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
+
+extern struct device_class node_devclass;
+extern struct device_class cpu_devclass;
+extern struct device_class memblk_devclass;
+
+/*
+ * Node devices
+ */
+struct node {
+	unsigned long cpumask;	/* Mask of CPUs on the node */
+	struct sys_root sysroot;
+};
+static struct node node_devices[MAX_NR_NODES];
+
+static struct device_driver node_driver = {
+	.name		= "node",
+	.bus		= &system_bus_type,
+	.devclass	= &node_devclass,
+};
+
+/*
+ * register_node - Setup a driverfs device for a node.
+ * @num - Node number to use when creating the device.
+ *
+ * Check to see if the node is already initialized.
+ * Initialize, and register the node device.
+ */
+static void __init register_node(int num)
+{
+	int parent;
+	struct sys_root *node = &node_devices[num].sysroot;
+
+	node_devices[num].cpumask = node_to_cpu_mask(num);
+	node->id = num;
+	if ((parent = parent_node(num)) != num)
+		node->dev.parent = &node_devices[parent].sysroot.sysdev;
+	snprintf(node->dev.name, DEVICE_NAME_SIZE, "Node %u", num);
+	snprintf(node->dev.bus_id, BUS_ID_SIZE, "node%u", num);
+	node->dev.bus = &system_bus_type;
+	node->dev.driver = &node_driver;
+	sys_register_root(node);
+}
+
+
+/*
+ * CPU devices
+ */
+struct cpu {
+	int node_id;	/* The node which contains the CPU */
+	struct sys_device sysdev;
+};
+static struct cpu cpu_devices[NR_CPUS];
+
+static struct device_driver cpu_driver = {
+	.name		= "cpu",
+	.bus		= &system_bus_type,
+	.devclass	= &cpu_devclass,
+};
+
+/*
+ * register_cpu - Setup a driverfs device for a CPU.
+ * @num - CPU number to use when creating the device.
+ *
+ * Check to see if the CPU is already initialized.
+ * Initialize, and register the CPU device.
+ * Also, these devices should be integrated with other CPU data..
+ */
+static void __init register_cpu(int num)
+{
+	int node_id;
+	struct sys_device *cpu = &cpu_devices[num].sysdev;
+
+	if ((node_id = cpu_to_node(num)) < 0)
+		BUG();
+	cpu_devices[num].node_id = node_id;
+	cpu->name = "cpu";
+	cpu->id = num;
+	cpu->root = &node_devices[node_id].sysroot;
+	snprintf(cpu->dev.name, DEVICE_NAME_SIZE, "CPU %u", num);
+	cpu->dev.driver = &cpu_driver;
+	sys_register_device(cpu);
+}
+
+
+/*
+ * MemBlk devices
+ */
+struct memblk {
+	int node_id;	/* The node which contains the MemBlk */
+	struct sys_device sysdev;
+};
+static struct memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static struct device_driver memblk_driver = {
+	.name		= "memblk",
+	.bus		= &system_bus_type,
+	.devclass	= &memblk_devclass,
+};
+
+/*
+ * register_memblk - Setup a driverfs device for a MemBlk
+ * @num: MemBlk number to use when creating the device.
+ *
+ * Initialize, and register the MemBlk device.
+ */
+static __init void register_memblk(int num)
+{
+	int node_id;
+	struct sys_device *memblk = &memblk_devices[num].sysdev;
+
+	if ((node_id = memblk_to_node(num)) < 0)
+		BUG();
+	memblk_devices[num].node_id = node_id;
+	memblk->name = "memblk";
+	memblk->id = num;
+	memblk->root = &node_devices[node_id].sysroot;
+	snprintf(memblk->dev.name, DEVICE_NAME_SIZE, "Memory Block %u", num);
+	memblk->dev.driver = &memblk_driver;
+	sys_register_device(memblk);
+}
+
+
+/*
+ * Populate driverfs with the system topology
+ */
+static int __init topology_init(void)
+{
+	int id;
+
+	driver_register(&node_driver);
+	driver_register(&cpu_driver);
+	driver_register(&memblk_driver);
+
+	for (id = 0; id < numnodes; id++)
+		register_node(id);
+	for (id = 0; id < num_online_cpus(); id++)
+		register_cpu(id);
+	for (id = 0; id < num_online_memblks(); id++)
+		register_memblk(id);
+	return 0;
+}
+
+subsys_initcall(topology_init);

--------------050608060201030908090905--

