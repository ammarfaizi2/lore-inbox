Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUAWIJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 03:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbUAWIJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 03:09:59 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:26243 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265384AbUAWIJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 03:09:43 -0500
Date: Thu, 22 Jan 2004 23:35:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: akpm@us.ibm.com
cc: linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: [PATCH] Remove memblks from the kernel
Message-ID: <237770000.1074843321@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes memblks from the kernel ... we don't use them, and
the NUMA API that was planning to use them when they were originally 
designed isn't going to use them anymore. They're just unnecessary 
added complexity now ... time for them to go.

There's a slight complication in that ia64 uses something with a similar
name for part of its memory layout, but Jes Sorensen kindly untangled them
from each other for us. The patch with his modifications is below. Jes 
tested it on ia64, and I testbuilt it with every config in my arsenal.

Please apply ... thanks,

M.

diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/arch/i386/mach-default/topology.c 2.6.2-rc1-no_memblk2/arch/i386/mach-default/topology.c
--- 2.6.2-rc1/arch/i386/mach-default/topology.c	Mon Dec 23 23:01:45 2002
+++ 2.6.2-rc1-no_memblk2/arch/i386/mach-default/topology.c	Thu Jan 22 22:06:03 2004
@@ -34,10 +34,8 @@ struct i386_cpu cpu_devices[NR_CPUS];
 #ifdef CONFIG_NUMA
 #include <linux/mmzone.h>
 #include <asm/node.h>
-#include <asm/memblk.h>
 
 struct i386_node node_devices[MAX_NUMNODES];
-struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
 static int __init topology_init(void)
 {
@@ -47,8 +45,6 @@ static int __init topology_init(void)
 		arch_register_node(i);
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_possible(i)) arch_register_cpu(i);
-	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
 	return 0;
 }
 
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/arch/i386/mach-es7000/topology.c 2.6.2-rc1-no_memblk2/arch/i386/mach-es7000/topology.c
--- 2.6.2-rc1/arch/i386/mach-es7000/topology.c	Tue Jun 17 20:58:51 2003
+++ 2.6.2-rc1-no_memblk2/arch/i386/mach-es7000/topology.c	Thu Jan 22 22:06:03 2004
@@ -34,10 +34,8 @@ struct i386_cpu cpu_devices[NR_CPUS];
 #ifdef CONFIG_NUMA
 #include <linux/mmzone.h>
 #include <asm/node.h>
-#include <asm/memblk.h>
 
 struct i386_node node_devices[MAX_NUMNODES];
-struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
 static int __init topology_init(void)
 {
@@ -47,8 +45,6 @@ static int __init topology_init(void)
 		arch_register_node(i);
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_possible(i)) arch_register_cpu(i);
-	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
 	return 0;
 }
 
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/arch/ia64/kernel/acpi.c 2.6.2-rc1-no_memblk2/arch/ia64/kernel/acpi.c
--- 2.6.2-rc1/arch/ia64/kernel/acpi.c	Thu Jan 22 21:57:05 2004
+++ 2.6.2-rc1-no_memblk2/arch/ia64/kernel/acpi.c	Thu Jan 22 22:06:03 2004
@@ -395,7 +395,7 @@ acpi_numa_memory_affinity_init (struct a
 	size = ma->length_hi;
 	size = (size << 32) | ma->length_lo;
 
-	if (num_memblks >= NR_MEMBLKS) {
+	if (num_node_memblks >= NR_NODE_MEMBLKS) {
 		printk(KERN_ERR "Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
 		       size/(1024*1024), paddr);
 		return;
@@ -409,7 +409,7 @@ acpi_numa_memory_affinity_init (struct a
 	pxm_bit_set(pxm);
 
 	/* Insertion sort based on base address */
-	pend = &node_memblk[num_memblks];
+	pend = &node_memblk[num_node_memblks];
 	for (p = &node_memblk[0]; p < pend; p++) {
 		if (paddr < p->start_paddr)
 			break;
@@ -421,7 +421,7 @@ acpi_numa_memory_affinity_init (struct a
 	p->start_paddr = paddr;
 	p->size = size;
 	p->nid = pxm;
-	num_memblks++;
+	num_node_memblks++;
 }
 
 void __init
@@ -448,7 +448,7 @@ acpi_numa_arch_fixup (void)
 	}
 
 	/* set logical node id in memory chunk structure */
-	for (i = 0; i < num_memblks; i++)
+	for (i = 0; i < num_node_memblks; i++)
 		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
 
 	/* assign memory bank numbers for each chunk on each node */
@@ -456,7 +456,7 @@ acpi_numa_arch_fixup (void)
 		int bank;
 
 		bank = 0;
-		for (j = 0; j < num_memblks; j++)
+		for (j = 0; j < num_node_memblks; j++)
 			if (node_memblk[j].nid == i)
 				node_memblk[j].bank = bank++;
 	}
@@ -466,7 +466,7 @@ acpi_numa_arch_fixup (void)
 		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
 
 	printk(KERN_INFO "Number of logical nodes in system = %d\n", numnodes);
-	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_memblks);
+	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_node_memblks);
 
 	if (!slit_table) return;
 	memset(numa_slit, -1, sizeof(numa_slit));
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/arch/ia64/mm/discontig.c 2.6.2-rc1-no_memblk2/arch/ia64/mm/discontig.c
--- 2.6.2-rc1/arch/ia64/mm/discontig.c	Fri Jan  9 17:40:00 2004
+++ 2.6.2-rc1-no_memblk2/arch/ia64/mm/discontig.c	Thu Jan 22 22:06:03 2004
@@ -419,14 +419,14 @@ void call_pernode_memory(unsigned long s
 
 	func = arg;
 
-	if (!num_memblks) {
-		/* No SRAT table, to assume one node (node 0) */
+	if (!num_node_memblks) {
+		/* No SRAT table, so assume one node (node 0) */
 		if (start < end)
 			(*func)(start, len, 0);
 		return;
 	}
 
-	for (i = 0; i < num_memblks; i++) {
+	for (i = 0; i < num_node_memblks; i++) {
 		rs = max(start, node_memblk[i].start_paddr);
 		re = min(end, node_memblk[i].start_paddr +
 			 node_memblk[i].size);
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/arch/ia64/mm/numa.c 2.6.2-rc1-no_memblk2/arch/ia64/mm/numa.c
--- 2.6.2-rc1/arch/ia64/mm/numa.c	Thu Jan 22 21:57:05 2004
+++ 2.6.2-rc1-no_memblk2/arch/ia64/mm/numa.c	Thu Jan 22 22:06:03 2004
@@ -13,7 +13,6 @@
 #include <linux/config.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
-#include <linux/memblk.h>
 #include <linux/mm.h>
 #include <linux/node.h>
 #include <linux/init.h>
@@ -21,7 +20,6 @@
 #include <asm/mmzone.h>
 #include <asm/numa.h>
 
-static struct memblk *sysfs_memblks;
 static struct node *sysfs_nodes;
 static struct cpu *sysfs_cpus;
 
@@ -29,8 +27,8 @@ static struct cpu *sysfs_cpus;
  * The following structures are usually initialized by ACPI or
  * similar mechanisms and describe the NUMA characteristics of the machine.
  */
-int num_memblks;
-struct node_memblk_s node_memblk[NR_MEMBLKS];
+int num_node_memblks;
+struct node_memblk_s node_memblk[NR_NODE_MEMBLKS];
 struct node_cpuid_s node_cpuid[NR_CPUS];
 /*
  * This is a matrix with "distances" between nodes, they should be
@@ -44,12 +42,12 @@ paddr_to_nid(unsigned long paddr)
 {
 	int	i;
 
-	for (i = 0; i < num_memblks; i++)
+	for (i = 0; i < num_node_memblks; i++)
 		if (paddr >= node_memblk[i].start_paddr &&
 		    paddr < node_memblk[i].start_paddr + node_memblk[i].size)
 			break;
 
-	return (i < num_memblks) ? node_memblk[i].nid : (num_memblks ? -1 : 0);
+	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
 }
 
 static int __init topology_init(void)
@@ -63,18 +61,8 @@ static int __init topology_init(void)
 	}
 	memset(sysfs_nodes, 0, sizeof(struct node) * numnodes);
 
-	sysfs_memblks = kmalloc(sizeof(struct memblk) * num_memblks,
-				GFP_KERNEL);
-	if (!sysfs_memblks) {
-		kfree(sysfs_nodes);
-		err = -ENOMEM;
-		goto out;
-	}
-	memset(sysfs_memblks, 0, sizeof(struct memblk) * num_memblks);
-
 	sysfs_cpus = kmalloc(sizeof(struct cpu) * NR_CPUS, GFP_KERNEL);
 	if (!sysfs_cpus) {
-		kfree(sysfs_memblks);
 		kfree(sysfs_nodes);
 		err = -ENOMEM;
 		goto out;
@@ -83,11 +71,6 @@ static int __init topology_init(void)
 
 	for (i = 0; i < numnodes; i++)
 		if ((err = register_node(&sysfs_nodes[i], i, 0)))
-			goto out;
-
-	for (i = 0; i < num_memblks; i++)
-		if ((err = register_memblk(&sysfs_memblks[i], i,
-					   &sysfs_nodes[memblk_to_node(i)])))
 			goto out;
 
 	for (i = 0; i < NR_CPUS; i++)
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/drivers/base/Makefile 2.6.2-rc1-no_memblk2/drivers/base/Makefile
--- 2.6.2-rc1/drivers/base/Makefile	Thu Jan 22 21:57:12 2004
+++ 2.6.2-rc1-no_memblk2/drivers/base/Makefile	Thu Jan 22 22:06:03 2004
@@ -5,4 +5,4 @@ obj-y			:= core.o sys.o interface.o bus.
 			   cpu.o firmware.o init.o map.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
-obj-$(CONFIG_NUMA)	+= node.o  memblk.o
+obj-$(CONFIG_NUMA)	+= node.o
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/drivers/base/memblk.c 2.6.2-rc1-no_memblk2/drivers/base/memblk.c
--- 2.6.2-rc1/drivers/base/memblk.c	Mon Nov 17 18:28:10 2003
+++ 2.6.2-rc1-no_memblk2/drivers/base/memblk.c	Wed Dec 31 16:00:00 1969
@@ -1,43 +0,0 @@
-/*
- * drivers/base/memblk.c - basic Memory Block class support
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/memblk.h>
-#include <linux/node.h>
-#include <linux/topology.h>
-
-
-static struct sysdev_class memblk_class = {
-	set_kset_name("memblk"),
-};
-
-/*
- * register_memblk - Setup a driverfs device for a MemBlk
- * @num - MemBlk number to use when creating the device.
- *
- * Initialize and register the MemBlk device.
- */
-int __init register_memblk(struct memblk *memblk, int num, struct node *root)
-{
-	int error;
-
-	memblk->node_id = memblk_to_node(num);
-	memblk->sysdev.cls = &memblk_class,
-	memblk->sysdev.id = num;
-
-	error = sys_device_register(&memblk->sysdev);
-	if (!error) 
-		error = sysfs_create_link(&root->sysdev.kobj,
-					  &memblk->sysdev.kobj,
-					  kobject_name(&memblk->sysdev.kobj));
-	return error;
-}
-
-
-int __init register_memblk_type(void)
-{
-	return sysdev_class_register(&memblk_class);
-}
-postcore_initcall(register_memblk_type);
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-alpha/topology.h 2.6.2-rc1-no_memblk2/include/asm-alpha/topology.h
--- 2.6.2-rc1/include/asm-alpha/topology.h	Thu Jan 22 21:57:33 2004
+++ 2.6.2-rc1-no_memblk2/include/asm-alpha/topology.h	Thu Jan 22 22:06:03 2004
@@ -39,9 +39,6 @@ static inline int node_to_cpumask(int no
 	return node_cpu_mask;
 }
 
-# define node_to_memblk(node)		(node)
-# define memblk_to_node(memblk)	(memblk)
-
 /* Cross-node load balancing interval. */
 # define NODE_BALANCE_RATE 10
 
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-generic/topology.h 2.6.2-rc1-no_memblk2/include/asm-generic/topology.h
--- 2.6.2-rc1/include/asm-generic/topology.h	Wed Mar  5 07:37:06 2003
+++ 2.6.2-rc1-no_memblk2/include/asm-generic/topology.h	Thu Jan 22 22:06:03 2004
@@ -32,9 +32,6 @@
 #ifndef cpu_to_node
 #define cpu_to_node(cpu)	(0)
 #endif
-#ifndef memblk_to_node
-#define memblk_to_node(memblk)	(0)
-#endif
 #ifndef parent_node
 #define parent_node(node)	(0)
 #endif
@@ -43,9 +40,6 @@
 #endif
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
-#endif
-#ifndef node_to_memblk
-#define node_to_memblk(node)	(0)
 #endif
 #ifndef pcibus_to_cpumask
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-i386/memblk.h 2.6.2-rc1-no_memblk2/include/asm-i386/memblk.h
--- 2.6.2-rc1/include/asm-i386/memblk.h	Sat Jun 14 18:37:35 2003
+++ 2.6.2-rc1-no_memblk2/include/asm-i386/memblk.h	Wed Dec 31 16:00:00 1969
@@ -1,23 +0,0 @@
-#ifndef _ASM_I386_MEMBLK_H_
-#define _ASM_I386_MEMBLK_H_
-
-#include <linux/device.h>
-#include <linux/mmzone.h>
-#include <linux/memblk.h>
-#include <linux/topology.h>
-
-#include <asm/node.h>
-
-struct i386_memblk {
-	struct memblk memblk;
-};
-extern struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
-
-static inline int arch_register_memblk(int num){
-	int p_node = memblk_to_node(num);
-
-	return register_memblk(&memblk_devices[num].memblk, num, 
-				&node_devices[p_node].node);
-}
-
-#endif /* _ASM_I386_MEMBLK_H_ */
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-i386/topology.h 2.6.2-rc1-no_memblk2/include/asm-i386/topology.h
--- 2.6.2-rc1/include/asm-i386/topology.h	Tue Sep  2 09:55:53 2003
+++ 2.6.2-rc1-no_memblk2/include/asm-i386/topology.h	Thu Jan 22 22:06:03 2004
@@ -43,9 +43,6 @@ static inline int cpu_to_node(int cpu)
 	return cpu_2_node[cpu];
 }
 
-/* Returns the number of the node containing MemBlk 'memblk' */
-#define memblk_to_node(memblk) (memblk)
-
 /* Returns the number of the node containing Node 'node'.  This architecture is flat, 
    so it is a pretty simple function! */
 #define parent_node(node) (node)
@@ -62,9 +59,6 @@ static inline int node_to_first_cpu(int 
 	cpumask_t mask = node_to_cpumask(node);
 	return first_cpu(mask);
 }
-
-/* Returns the number of the first MemBlk on Node 'node' */
-#define node_to_memblk(node) (node)
 
 /* Returns the number of the node containing PCI bus 'bus' */
 static inline cpumask_t pcibus_to_cpumask(int bus)
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-ia64/mmzone.h 2.6.2-rc1-no_memblk2/include/asm-ia64/mmzone.h
--- 2.6.2-rc1/include/asm-ia64/mmzone.h	Thu Jan 22 21:57:34 2004
+++ 2.6.2-rc1-no_memblk2/include/asm-ia64/mmzone.h	Thu Jan 22 22:06:03 2004
@@ -20,11 +20,11 @@
 #ifdef CONFIG_IA64_DIG /* DIG systems are small */
 # define MAX_PHYSNODE_ID	8
 # define NR_NODES		8
-# define NR_MEMBLKS		(NR_NODES * 32)
+# define NR_NODE_MEMBLKS	(NR_NODES * 8)
 #else /* sn2 is the biggest case, so we use that if !DIG */
 # define MAX_PHYSNODE_ID	2048
 # define NR_NODES		256
-# define NR_MEMBLKS		(NR_NODES)
+# define NR_NODE_MEMBLKS	(NR_NODES * 4)
 #endif
 
 extern unsigned long max_low_pfn;
@@ -34,6 +34,6 @@ extern unsigned long max_low_pfn;
 #define pfn_to_page(pfn)	(vmem_map + (pfn))
 
 #else /* CONFIG_DISCONTIGMEM */
-# define NR_MEMBLKS		1
+# define NR_NODE_MEMBLKS	4
 #endif /* CONFIG_DISCONTIGMEM */
 #endif /* _ASM_IA64_MMZONE_H */
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-ia64/numa.h 2.6.2-rc1-no_memblk2/include/asm-ia64/numa.h
--- 2.6.2-rc1/include/asm-ia64/numa.h	Thu Jan 22 21:57:34 2004
+++ 2.6.2-rc1-no_memblk2/include/asm-ia64/numa.h	Thu Jan 22 22:06:03 2004
@@ -28,7 +28,7 @@ extern volatile cpumask_t node_to_cpu_ma
 
 /* Stuff below this line could be architecture independent */
 
-extern int num_memblks;		/* total number of memory chunks */
+extern int num_node_memblks;		/* total number of memory chunks */
 
 /*
  * List of node memory chunks. Filled when parsing SRAT table to
@@ -47,7 +47,7 @@ struct node_cpuid_s {
 	int	nid;		/* logical node containing this CPU */
 };
 
-extern struct node_memblk_s node_memblk[NR_MEMBLKS];
+extern struct node_memblk_s node_memblk[NR_NODE_MEMBLKS];
 extern struct node_cpuid_s node_cpuid[NR_CPUS];
 
 /*
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-ia64/topology.h 2.6.2-rc1-no_memblk2/include/asm-ia64/topology.h
--- 2.6.2-rc1/include/asm-ia64/topology.h	Wed Jul  2 21:59:12 2003
+++ 2.6.2-rc1-no_memblk2/include/asm-ia64/topology.h	Thu Jan 22 22:06:03 2004
@@ -29,15 +29,6 @@
 #define node_to_cpumask(node) (node_to_cpu_mask[node])
 
 /*
- * Returns the number of the node containing MemBlk 'memblk'
- */
-#ifdef CONFIG_ACPI_NUMA
-#define memblk_to_node(memblk) (node_memblk[memblk].nid)
-#else
-#define memblk_to_node(memblk) (memblk)
-#endif
-
-/*
  * Returns the number of the node containing Node 'nid'.
  * Not implemented here. Multi-level hierarchies detected with
  * the help of node_distance().
@@ -48,12 +39,6 @@
  * Returns the number of the first CPU on Node 'node'.
  */
 #define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
-
-/*
- * Returns the number of the first MemBlk on Node 'node'
- * Should be fixed when IA64 discontigmem goes in.
- */
-#define node_to_memblk(node) (node)
 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 10
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-ppc64/topology.h 2.6.2-rc1-no_memblk2/include/asm-ppc64/topology.h
--- 2.6.2-rc1/include/asm-ppc64/topology.h	Thu Jan 22 21:57:35 2004
+++ 2.6.2-rc1-no_memblk2/include/asm-ppc64/topology.h	Thu Jan 22 22:06:03 2004
@@ -19,8 +19,6 @@ static inline int cpu_to_node(int cpu)
 	return node;
 }
 
-#define memblk_to_node(memblk)	(memblk)
-
 #define parent_node(node)	(node)
 
 static inline cpumask_t node_to_cpumask(int node)
@@ -34,8 +32,6 @@ static inline int node_to_first_cpu(int 
 	tmp = node_to_cpumask(node);
 	return first_cpu(tmp);
 }
-
-#define node_to_memblk(node)	(node)
 
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-x86_64/memblk.h 2.6.2-rc1-no_memblk2/include/asm-x86_64/memblk.h
--- 2.6.2-rc1/include/asm-x86_64/memblk.h	Fri Jan  9 17:40:08 2004
+++ 2.6.2-rc1-no_memblk2/include/asm-x86_64/memblk.h	Wed Dec 31 16:00:00 1969
@@ -1 +0,0 @@
-#include <asm-i386/memblk.h>
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/asm-x86_64/topology.h 2.6.2-rc1-no_memblk2/include/asm-x86_64/topology.h
--- 2.6.2-rc1/include/asm-x86_64/topology.h	Mon Dec  8 09:55:53 2003
+++ 2.6.2-rc1-no_memblk2/include/asm-x86_64/topology.h	Thu Jan 22 22:06:03 2004
@@ -15,11 +15,9 @@ extern int fake_node;
 extern unsigned long cpu_online_map;
 
 #define cpu_to_node(cpu)		(fake_node ? 0 : (cpu))
-#define memblk_to_node(memblk) 	(fake_node ? 0 : (memblk))
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(fake_node ? 0 : (node))
 #define node_to_cpumask(node)	(fake_node ? cpu_online_map : (1UL << (node)))
-#define node_to_memblk(node)		(node)
 
 static inline unsigned long pcibus_to_cpumask(int bus)
 {
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/linux/memblk.h 2.6.2-rc1-no_memblk2/include/linux/memblk.h
--- 2.6.2-rc1/include/linux/memblk.h	Sun Nov 17 20:29:56 2002
+++ 2.6.2-rc1-no_memblk2/include/linux/memblk.h	Wed Dec 31 16:00:00 1969
@@ -1,32 +0,0 @@
-/*
- * include/linux/memblk.h - generic memblk definition
- *
- * This is mainly for topological representation. We define the 
- * basic 'struct memblk' here, which can be embedded in per-arch 
- * definitions of memory blocks.
- *
- * Basic handling of the devices is done in drivers/base/memblk.c
- * and system devices are handled in drivers/base/sys.c. 
- *
- * MemBlks are exported via driverfs in the class/memblk/devices/
- * directory. 
- *
- * Per-memblk interfaces can be implemented using a struct device_interface. 
- * See the following for how to do this: 
- * - drivers/base/intf.c 
- * - Documentation/driver-model/interface.txt
- */
-#ifndef _LINUX_MEMBLK_H_
-#define _LINUX_MEMBLK_H_
-
-#include <linux/device.h>
-#include <linux/node.h>
-
-struct memblk {
-	int node_id;		/* The node which contains the MemBlk */
-	struct sys_device sysdev;
-};
-
-extern int register_memblk(struct memblk *, int, struct node *);
-
-#endif /* _LINUX_MEMBLK_H_ */
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/include/linux/mmzone.h 2.6.2-rc1-no_memblk2/include/linux/mmzone.h
--- 2.6.2-rc1/include/linux/mmzone.h	Thu Jan 22 21:57:37 2004
+++ 2.6.2-rc1-no_memblk2/include/linux/mmzone.h	Thu Jan 22 22:06:03 2004
@@ -295,12 +295,6 @@ struct file;
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, struct file *, 
 					  void *, size_t *);
 
-#ifdef CONFIG_NUMA
-#define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
-#else /* !CONFIG_NUMA */
-#define MAX_NR_MEMBLKS	1
-#endif /* CONFIG_NUMA */
-
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(smp_processor_id()))
@@ -343,7 +337,6 @@ extern struct pglist_data contig_page_da
 #endif
 
 extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
-extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 
 #if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
 
@@ -361,20 +354,6 @@ static inline unsigned int num_online_no
 	return num;
 }
 
-#define memblk_online(memblk)		test_bit(memblk, memblk_online_map)
-#define memblk_set_online(memblk)	set_bit(memblk, memblk_online_map)
-#define memblk_set_offline(memblk)	clear_bit(memblk, memblk_online_map)
-static inline unsigned int num_online_memblks(void)
-{
-	int i, num = 0;
-
-	for(i = 0; i < MAX_NR_MEMBLKS; i++){
-		if (memblk_online(i))
-			num++;
-	}
-	return num;
-}
-
 #else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
 
 #define node_online(node) \
@@ -384,14 +363,6 @@ static inline unsigned int num_online_me
 #define node_set_offline(node) \
 	({ BUG_ON((node) != 0); clear_bit(node, node_online_map); })
 #define num_online_nodes()	1
-
-#define memblk_online(memblk) \
-	({ BUG_ON((memblk) != 0); test_bit(memblk, memblk_online_map); })
-#define memblk_set_online(memblk) \
-	({ BUG_ON((memblk) != 0); set_bit(memblk, memblk_online_map); })
-#define memblk_set_offline(memblk) \
-	({ BUG_ON((memblk) != 0); clear_bit(memblk, memblk_online_map); })
-#define num_online_memblks()		1
 
 #endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
 #endif /* !__ASSEMBLY__ */
diff -aurpN -X /home/fletch/.diff.exclude 2.6.2-rc1/mm/page_alloc.c 2.6.2-rc1-no_memblk2/mm/page_alloc.c
--- 2.6.2-rc1/mm/page_alloc.c	Thu Jan 22 21:57:38 2004
+++ 2.6.2-rc1-no_memblk2/mm/page_alloc.c	Thu Jan 22 22:06:03 2004
@@ -35,7 +35,6 @@
 #include <asm/tlbflush.h>
 
 DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
-DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -1392,7 +1391,6 @@ void __init free_area_init_node(int nid,
 	pgdat->node_mem_map = node_mem_map;
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
-	memblk_set_online(node_to_memblk(nid));
 
 	calculate_zone_bitmap(pgdat, zones_size);
 }

