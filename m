Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTAGUdQ>; Tue, 7 Jan 2003 15:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTAGUcR>; Tue, 7 Jan 2003 15:32:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17613 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267491AbTAGUbL>; Tue, 7 Jan 2003 15:31:11 -0500
Date: Tue, 07 Jan 2003 12:20:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2/7) make i386 topology caching
Message-ID: <594450000.1041970813@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch originally by Matt Dobson. Reworked a little by me.

Stores the mappings between cpus and nodes in an array, instead of
working them out every time. Gives about 4% off systime for kernel
compile (we use these for every page allocation), and removes one
of the two only usages of apicid->cpu mapping, which is really awkward
to keep for systems with large apic spaces, and is genererally pretty
useless anyway (later patch removes).

diff -urpN -X /home/fletch/.diff.exclude 01-apicid_to_node/arch/i386/kernel/smpboot.c 02-i386_caching_topo/arch/i386/kernel/smpboot.c
--- 01-apicid_to_node/arch/i386/kernel/smpboot.c	Thu Jan  2 22:04:58 2003
+++ 02-i386_caching_topo/arch/i386/kernel/smpboot.c	Tue Jan  7 09:24:51 2003
@@ -503,6 +503,39 @@ static struct task_struct * __init fork_
 	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }

+#ifdef CONFIG_NUMA
+
+/* which logical CPUs are on which nodes */
+volatile unsigned long node_2_cpu_mask[MAX_NR_NODES] =
+						{ [0 ... MAX_NR_NODES-1] = 0 };
+/* which node each logical CPU is on */
+volatile int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
+
+/* set up a mapping between cpu and node. */
+static inline void map_cpu_to_node(int cpu, int node)
+{
+	printk("Mapping cpu %d to node %d\n", cpu, node);
+	node_2_cpu_mask[node] |= (1 << cpu);
+	cpu_2_node[cpu] = node;
+}
+
+/* undo a mapping between cpu and node. */
+static inline void unmap_cpu_to_node(int cpu)
+{
+	int node;
+
+	printk("Unmapping cpu %d from all nodes\n", cpu);
+	for (node = 0; node < MAX_NR_NODES; node ++)
+		node_2_cpu_mask[node] &= ~(1 << cpu);
+	cpu_2_node[cpu] = -1;
+}
+#else /* !CONFIG_NUMA */
+
+#define map_cpu_to_node(cpu, node)	({})
+#define unmap_cpu_to_node(cpu)	({})
+
+#endif /* CONFIG_NUMA */
+
 /* which physical APIC ID maps to which logical CPU number */
 volatile int physical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
@@ -537,6 +570,7 @@ static inline void map_cpu_to_boot_apici
 	if (clustered_apic_mode) {
 		logical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_logical_apicid[cpu] = apicid;
+		map_cpu_to_node(cpu, apicid_to_node(apicid));
 	} else {
 		physical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_physical_apicid[cpu] = apicid;
@@ -552,6 +586,7 @@ static inline void unmap_cpu_to_boot_api
 	if (clustered_apic_mode) {
 		logical_apicid_2_cpu[apicid] = -1;	
 		cpu_2_logical_apicid[cpu] = -1;
+		unmap_cpu_to_node(cpu);
 	} else {
 		physical_apicid_2_cpu[apicid] = -1;	
 		cpu_2_physical_apicid[cpu] = -1;
diff -urpN -X /home/fletch/.diff.exclude 01-apicid_to_node/include/asm-i386/topology.h 02-i386_caching_topo/include/asm-i386/topology.h
--- 01-apicid_to_node/include/asm-i386/topology.h	Sun Nov 17 20:29:26 2002
+++ 02-i386_caching_topo/include/asm-i386/topology.h	Tue Jan  7 09:24:51 2003
@@ -27,12 +27,17 @@
 #ifndef _ASM_I386_TOPOLOGY_H
 #define _ASM_I386_TOPOLOGY_H

-#ifdef CONFIG_X86_NUMAQ
+#ifdef CONFIG_NUMA

-#include <asm/smpboot.h>
+/* Mappings between logical cpu number and node number */
+extern volatile unsigned long node_2_cpu_mask[];
+extern volatile int cpu_2_node[];

 /* Returns the number of the node containing CPU 'cpu' */
-#define __cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+static inline int __cpu_to_node(int cpu)
+{
+	return cpu_2_node[cpu];
+}

 /* Returns the number of the node containing MemBlk 'memblk' */
 #define __memblk_to_node(memblk) (memblk)
@@ -41,49 +46,22 @@
    so it is a pretty simple function! */
 #define __parent_node(node) (node)

-/* Returns the number of the first CPU on Node 'node'.
- * This should be changed to a set of cached values
- * but this will do for now.
- */
-static inline int __node_to_first_cpu(int node)
-{
-	int i, cpu, logical_apicid = node << 4;
-
-	for(i = 1; i < 16; i <<= 1)
-		/* check to see if the cpu is in the system */
-		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
-			/* if yes, return it to caller */
-			return cpu;
-
-	BUG(); /* couldn't find a cpu on given node */
-	return -1;
-}
-
-/* Returns a bitmask of CPUs on Node 'node'.
- * This should be changed to a set of cached bitmasks
- * but this will do for now.
- */
+/* Returns a bitmask of CPUs on Node 'node'. */
 static inline unsigned long __node_to_cpu_mask(int node)
 {
-	int i, cpu, logical_apicid = node << 4;
-	unsigned long mask = 0UL;
-
-	if (sizeof(unsigned long) * 8 < NR_CPUS)
-		BUG();
-
-	for(i = 1; i < 16; i <<= 1)
-		/* check to see if the cpu is in the system */
-		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
-			/* if yes, add to bitmask */
-			mask |= 1 << cpu;
+	return node_2_cpu_mask[node];
+}

-	return mask;
+/* Returns the number of the first CPU on Node 'node'. */
+static inline int __node_to_first_cpu(int node)
+{
+	return __ffs(__node_to_cpu_mask(node));
 }

 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)

-#else /* !CONFIG_X86_NUMAQ */
+#else /* !CONFIG_NUMA */
 /*
  * Other i386 platforms should define their own version of the
  * above macros here.
@@ -91,6 +69,6 @@ static inline unsigned long __node_to_cp

 #include <asm-generic/topology.h>

-#endif /* CONFIG_X86_NUMAQ */
+#endif /* CONFIG_NUMA */

 #endif /* _ASM_I386_TOPOLOGY_H */

