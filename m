Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbUAVP0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUAVP0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:26:40 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:59268 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265528AbUAVPZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:25:36 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
References: <E1AiZ5h-00043I-00@jaguar.mkp.net>
	<4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com>
	<20040120022452.GA27294@sgi.com> <20040120031222.GA15435@sgi.com>
	<11450000.1074579922@[10.10.2.4]> <yq0d69erilj.fsf@wildopensource.com>
	<18520000.1074615108@[10.10.2.4]>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Jan 2004 10:24:44 -0500
In-Reply-To: <18520000.1074615108@[10.10.2.4]>
Message-ID: <yq0d69cj9ab.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:

>>  Martin,
>> 
>> Tried it, no go! It conflicts with arch/ia64/mm/numa.c and
>> arch/ia64/mm,/discontig.c as Jack had suggested.

Martin> Can you send me the build output? It shouldn't conflict
Martin> ... there are two separate uses of the term "memblk" by the
Martin> looks of it.

Ok,

This version boots, it seems we had to different uses of NR_MEMBLK in
the kernel, I renamed one of them to NR_NODE_MEMBLK and it works.

Cheers,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/arch/i386/mach-default/topology.c linux-2.6.2-rc1/arch/i386/mach-default/topology.c
--- orig/linux-2.6.2-rc1/arch/i386/mach-default/topology.c	Tue Jan 20 19:50:30 2004
+++ linux-2.6.2-rc1/arch/i386/mach-default/topology.c	Thu Jan 22 06:27:04 2004
@@ -34,10 +34,8 @@
 #ifdef CONFIG_NUMA
 #include <linux/mmzone.h>
 #include <asm/node.h>
-#include <asm/memblk.h>
 
 struct i386_node node_devices[MAX_NUMNODES];
-struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
 static int __init topology_init(void)
 {
@@ -47,8 +45,6 @@
 		arch_register_node(i);
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_possible(i)) arch_register_cpu(i);
-	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
 	return 0;
 }
 
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/arch/i386/mach-es7000/topology.c linux-2.6.2-rc1/arch/i386/mach-es7000/topology.c
--- orig/linux-2.6.2-rc1/arch/i386/mach-es7000/topology.c	Tue Jan 20 19:50:32 2004
+++ linux-2.6.2-rc1/arch/i386/mach-es7000/topology.c	Thu Jan 22 06:27:04 2004
@@ -34,10 +34,8 @@
 #ifdef CONFIG_NUMA
 #include <linux/mmzone.h>
 #include <asm/node.h>
-#include <asm/memblk.h>
 
 struct i386_node node_devices[MAX_NUMNODES];
-struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
 static int __init topology_init(void)
 {
@@ -47,8 +45,6 @@
 		arch_register_node(i);
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_possible(i)) arch_register_cpu(i);
-	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
 	return 0;
 }
 
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/arch/ia64/kernel/acpi.c linux-2.6.2-rc1/arch/ia64/kernel/acpi.c
--- orig/linux-2.6.2-rc1/arch/ia64/kernel/acpi.c	Tue Jan 20 19:49:59 2004
+++ linux-2.6.2-rc1/arch/ia64/kernel/acpi.c	Thu Jan 22 07:19:58 2004
@@ -395,7 +395,7 @@
 	size = ma->length_hi;
 	size = (size << 32) | ma->length_lo;
 
-	if (num_memblks >= NR_MEMBLKS) {
+	if (num_node_memblks >= NR_NODE_MEMBLKS) {
 		printk(KERN_ERR "Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
 		       size/(1024*1024), paddr);
 		return;
@@ -409,7 +409,7 @@
 	pxm_bit_set(pxm);
 
 	/* Insertion sort based on base address */
-	pend = &node_memblk[num_memblks];
+	pend = &node_memblk[num_node_memblks];
 	for (p = &node_memblk[0]; p < pend; p++) {
 		if (paddr < p->start_paddr)
 			break;
@@ -421,7 +421,7 @@
 	p->start_paddr = paddr;
 	p->size = size;
 	p->nid = pxm;
-	num_memblks++;
+	num_node_memblks++;
 }
 
 void __init
@@ -448,7 +448,7 @@
 	}
 
 	/* set logical node id in memory chunk structure */
-	for (i = 0; i < num_memblks; i++)
+	for (i = 0; i < num_node_memblks; i++)
 		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
 
 	/* assign memory bank numbers for each chunk on each node */
@@ -456,7 +456,7 @@
 		int bank;
 
 		bank = 0;
-		for (j = 0; j < num_memblks; j++)
+		for (j = 0; j < num_node_memblks; j++)
 			if (node_memblk[j].nid == i)
 				node_memblk[j].bank = bank++;
 	}
@@ -466,7 +466,7 @@
 		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
 
 	printk(KERN_INFO "Number of logical nodes in system = %d\n", numnodes);
-	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_memblks);
+	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_node_memblks);
 
 	if (!slit_table) return;
 	memset(numa_slit, -1, sizeof(numa_slit));
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/arch/ia64/mm/discontig.c linux-2.6.2-rc1/arch/ia64/mm/discontig.c
--- orig/linux-2.6.2-rc1/arch/ia64/mm/discontig.c	Tue Jan 20 19:50:31 2004
+++ linux-2.6.2-rc1/arch/ia64/mm/discontig.c	Thu Jan 22 06:47:33 2004
@@ -419,14 +419,14 @@
 
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
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/arch/ia64/mm/numa.c linux-2.6.2-rc1/arch/ia64/mm/numa.c
--- orig/linux-2.6.2-rc1/arch/ia64/mm/numa.c	Tue Jan 20 19:49:36 2004
+++ linux-2.6.2-rc1/arch/ia64/mm/numa.c	Thu Jan 22 06:34:46 2004
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
 
@@ -29,8 +27,8 @@
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
@@ -44,12 +42,12 @@
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
@@ -63,18 +61,8 @@
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
@@ -85,11 +73,6 @@
 		if ((err = register_node(&sysfs_nodes[i], i, 0)))
 			goto out;
 
-	for (i = 0; i < num_memblks; i++)
-		if ((err = register_memblk(&sysfs_memblks[i], i,
-					   &sysfs_nodes[memblk_to_node(i)])))
-			goto out;
-
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_online(i))
 			if((err = register_cpu(&sysfs_cpus[i], i,
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/drivers/base/Makefile linux-2.6.2-rc1/drivers/base/Makefile
--- orig/linux-2.6.2-rc1/drivers/base/Makefile	Tue Jan 20 19:50:30 2004
+++ linux-2.6.2-rc1/drivers/base/Makefile	Thu Jan 22 06:27:04 2004
@@ -5,4 +5,4 @@
 			   cpu.o firmware.o init.o map.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
-obj-$(CONFIG_NUMA)	+= node.o  memblk.o
+obj-$(CONFIG_NUMA)	+= node.o
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/drivers/base/memblk.c linux-2.6.2-rc1/drivers/base/memblk.c
--- orig/linux-2.6.2-rc1/drivers/base/memblk.c	Tue Jan 20 19:50:42 2004
+++ linux-2.6.2-rc1/drivers/base/memblk.c	Wed Dec 31 16:00:00 1969
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
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-alpha/topology.h linux-2.6.2-rc1/include/asm-alpha/topology.h
--- orig/linux-2.6.2-rc1/include/asm-alpha/topology.h	Tue Jan 20 19:49:36 2004
+++ linux-2.6.2-rc1/include/asm-alpha/topology.h	Thu Jan 22 06:27:04 2004
@@ -39,9 +39,6 @@
 	return node_cpu_mask;
 }
 
-# define node_to_memblk(node)		(node)
-# define memblk_to_node(memblk)	(memblk)
-
 /* Cross-node load balancing interval. */
 # define NODE_BALANCE_RATE 10
 
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-generic/topology.h linux-2.6.2-rc1/include/asm-generic/topology.h
--- orig/linux-2.6.2-rc1/include/asm-generic/topology.h	Tue Jan 20 19:49:22 2004
+++ linux-2.6.2-rc1/include/asm-generic/topology.h	Thu Jan 22 06:27:04 2004
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
@@ -44,9 +41,6 @@
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
 #endif
-#ifndef node_to_memblk
-#define node_to_memblk(node)	(0)
-#endif
 #ifndef pcibus_to_cpumask
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 #endif
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-i386/memblk.h linux-2.6.2-rc1/include/asm-i386/memblk.h
--- orig/linux-2.6.2-rc1/include/asm-i386/memblk.h	Tue Jan 20 19:50:03 2004
+++ linux-2.6.2-rc1/include/asm-i386/memblk.h	Wed Dec 31 16:00:00 1969
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
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-i386/topology.h linux-2.6.2-rc1/include/asm-i386/topology.h
--- orig/linux-2.6.2-rc1/include/asm-i386/topology.h	Tue Jan 20 19:49:28 2004
+++ linux-2.6.2-rc1/include/asm-i386/topology.h	Thu Jan 22 06:27:04 2004
@@ -43,9 +43,6 @@
 	return cpu_2_node[cpu];
 }
 
-/* Returns the number of the node containing MemBlk 'memblk' */
-#define memblk_to_node(memblk) (memblk)
-
 /* Returns the number of the node containing Node 'node'.  This architecture is flat, 
    so it is a pretty simple function! */
 #define parent_node(node) (node)
@@ -63,9 +60,6 @@
 	return first_cpu(mask);
 }
 
-/* Returns the number of the first MemBlk on Node 'node' */
-#define node_to_memblk(node) (node)
-
 /* Returns the number of the node containing PCI bus 'bus' */
 static inline cpumask_t pcibus_to_cpumask(int bus)
 {
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-ia64/mmzone.h linux-2.6.2-rc1/include/asm-ia64/mmzone.h
--- orig/linux-2.6.2-rc1/include/asm-ia64/mmzone.h	Tue Jan 20 19:50:51 2004
+++ linux-2.6.2-rc1/include/asm-ia64/mmzone.h	Thu Jan 22 06:37:58 2004
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
@@ -34,6 +34,6 @@
 #define pfn_to_page(pfn)	(vmem_map + (pfn))
 
 #else /* CONFIG_DISCONTIGMEM */
-# define NR_MEMBLKS		1
+# define NR_NODE_MEMBLKS	4
 #endif /* CONFIG_DISCONTIGMEM */
 #endif /* _ASM_IA64_MMZONE_H */
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-ia64/numa.h linux-2.6.2-rc1/include/asm-ia64/numa.h
--- orig/linux-2.6.2-rc1/include/asm-ia64/numa.h	Tue Jan 20 19:49:47 2004
+++ linux-2.6.2-rc1/include/asm-ia64/numa.h	Thu Jan 22 06:41:26 2004
@@ -28,7 +28,7 @@
 
 /* Stuff below this line could be architecture independent */
 
-extern int num_memblks;		/* total number of memory chunks */
+extern int num_node_memblks;		/* total number of memory chunks */
 
 /*
  * List of node memory chunks. Filled when parsing SRAT table to
@@ -47,7 +47,7 @@
 	int	nid;		/* logical node containing this CPU */
 };
 
-extern struct node_memblk_s node_memblk[NR_MEMBLKS];
+extern struct node_memblk_s node_memblk[NR_NODE_MEMBLKS];
 extern struct node_cpuid_s node_cpuid[NR_CPUS];
 
 /*
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-ia64/topology.h linux-2.6.2-rc1/include/asm-ia64/topology.h
--- orig/linux-2.6.2-rc1/include/asm-ia64/topology.h	Tue Jan 20 19:49:18 2004
+++ linux-2.6.2-rc1/include/asm-ia64/topology.h	Thu Jan 22 06:27:04 2004
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
@@ -49,12 +40,6 @@
  */
 #define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
 
-/*
- * Returns the number of the first MemBlk on Node 'node'
- * Should be fixed when IA64 discontigmem goes in.
- */
-#define node_to_memblk(node) (node)
-
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 10
 
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-ppc64/topology.h linux-2.6.2-rc1/include/asm-ppc64/topology.h
--- orig/linux-2.6.2-rc1/include/asm-ppc64/topology.h	Tue Jan 20 19:50:40 2004
+++ linux-2.6.2-rc1/include/asm-ppc64/topology.h	Thu Jan 22 06:27:04 2004
@@ -19,8 +19,6 @@
 	return node;
 }
 
-#define memblk_to_node(memblk)	(memblk)
-
 #define parent_node(node)	(node)
 
 static inline cpumask_t node_to_cpumask(int node)
@@ -35,8 +33,6 @@
 	return first_cpu(tmp);
 }
 
-#define node_to_memblk(node)	(node)
-
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 
 #define nr_cpus_node(node)	(nr_cpus_in_node[node])
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/asm-x86_64/topology.h linux-2.6.2-rc1/include/asm-x86_64/topology.h
--- orig/linux-2.6.2-rc1/include/asm-x86_64/topology.h	Tue Jan 20 19:50:11 2004
+++ linux-2.6.2-rc1/include/asm-x86_64/topology.h	Thu Jan 22 06:27:04 2004
@@ -15,11 +15,9 @@
 extern unsigned long cpu_online_map;
 
 #define cpu_to_node(cpu)		(fake_node ? 0 : (cpu))
-#define memblk_to_node(memblk) 	(fake_node ? 0 : (memblk))
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(fake_node ? 0 : (node))
 #define node_to_cpumask(node)	(fake_node ? cpu_online_map : (1UL << (node)))
-#define node_to_memblk(node)		(node)
 
 static inline unsigned long pcibus_to_cpumask(int bus)
 {
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/linux/memblk.h linux-2.6.2-rc1/include/linux/memblk.h
--- orig/linux-2.6.2-rc1/include/linux/memblk.h	Tue Jan 20 19:50:39 2004
+++ linux-2.6.2-rc1/include/linux/memblk.h	Wed Dec 31 16:00:00 1969
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
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/include/linux/mmzone.h linux-2.6.2-rc1/include/linux/mmzone.h
--- orig/linux-2.6.2-rc1/include/linux/mmzone.h	Tue Jan 20 19:50:03 2004
+++ linux-2.6.2-rc1/include/linux/mmzone.h	Thu Jan 22 06:27:04 2004
@@ -295,12 +295,6 @@
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
@@ -343,7 +337,6 @@
 #endif
 
 extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
-extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 
 #if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
 
@@ -361,20 +354,6 @@
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
@@ -385,14 +364,6 @@
 	({ BUG_ON((node) != 0); clear_bit(node, node_online_map); })
 #define num_online_nodes()	1
 
-#define memblk_online(memblk) \
-	({ BUG_ON((memblk) != 0); test_bit(memblk, memblk_online_map); })
-#define memblk_set_online(memblk) \
-	({ BUG_ON((memblk) != 0); set_bit(memblk, memblk_online_map); })
-#define memblk_set_offline(memblk) \
-	({ BUG_ON((memblk) != 0); clear_bit(memblk, memblk_online_map); })
-#define num_online_memblks()		1
-
 #endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.2-rc1/mm/page_alloc.c linux-2.6.2-rc1/mm/page_alloc.c
--- orig/linux-2.6.2-rc1/mm/page_alloc.c	Tue Jan 20 19:49:21 2004
+++ linux-2.6.2-rc1/mm/page_alloc.c	Thu Jan 22 06:27:04 2004
@@ -35,7 +35,6 @@
 #include <asm/tlbflush.h>
 
 DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
-DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -1392,7 +1391,6 @@
 	pgdat->node_mem_map = node_mem_map;
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
-	memblk_set_online(node_to_memblk(nid));
 
 	calculate_zone_bitmap(pgdat, zones_size);
 }
