Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265425AbSKEAzT>; Mon, 4 Nov 2002 19:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266474AbSKEAyX>; Mon, 4 Nov 2002 19:54:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:20967 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266443AbSKEAyB>;
	Mon, 4 Nov 2002 19:54:01 -0500
Message-ID: <3DC7172D.8090400@us.ibm.com>
Date: Mon, 04 Nov 2002 16:56:13 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Martin Bligh <mjbligh@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] i386 Topology Fix
Content-Type: multipart/mixed;
 boundary="------------010606070506090301080603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606070506090301080603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	The following patch modifies the i386 Topology macros to use an array of 
cached values for cpu <-> node mapping data, and is a vast performance 
win over the old macros.

Please apply...

[mcd@arrakis patches]$ diffstat i386_topology_fixup-2.5.46.patch
  arch/i386/kernel/smpboot.c  |   43 
+++++++++++++++++++++++++++++++++++++++++++
  include/asm-i386/smpboot.h  |    8 ++++++++
  include/asm-i386/topology.h |   43 
+++++--------------------------------------
  3 files changed, 56 insertions(+), 38 deletions(-)

Cheers!

-Matt

--------------010606070506090301080603
Content-Type: text/plain;
 name="i386_topology_fixup-2.5.46.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_topology_fixup-2.5.46.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.46-vanilla/arch/i386/kernel/smpboot.c linux-2.5.46-i386_topo_fix/arch/i386/kernel/smpboot.c
--- linux-2.5.46-vanilla/arch/i386/kernel/smpboot.c	Mon Nov  4 14:30:27 2002
+++ linux-2.5.46-i386_topo_fix/arch/i386/kernel/smpboot.c	Mon Nov  4 16:43:49 2002
@@ -501,6 +501,46 @@
 	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
+#ifdef CONFIG_X86_NUMAQ
+/* which logical CPUs are on which nodes */
+volatile unsigned long node_2_cpu_mask[MAX_NR_NODES];
+/* which node each logical CPU is on */
+volatile int cpu_2_node[NR_CPUS];
+
+/* Initialize all maps between cpu number and node */
+static inline void init_cpu_to_node_mapping(void)
+{
+	int node, cpu;
+
+	for (node = 0; node < MAX_NR_NODES; node++) {
+		node_2_cpu_mask[node] = 0;
+	}
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cpu_2_node[cpu] = -1;
+	}
+}
+
+/* set up a mapping between cpu and node. */
+static inline void map_cpu_to_node(int cpu, int node)
+{
+	node_2_cpu_mask[node] |= (1 << cpu);
+	cpu_2_node[cpu] = node;
+}
+
+/* undo a mapping between cpu and node. */
+static inline void unmap_cpu_to_node(int cpu, int node)
+{
+	node_2_cpu_mask[node] &= ~(1 << cpu);
+	cpu_2_node[cpu] = -1;
+}
+#else /* !CONFIG_X86_NUMAQ */
+
+#define init_cpu_to_node_mapping()	({})
+#define map_cpu_to_node(cpu, node)	({})
+#define unmap_cpu_to_node(cpu, node)	({})
+
+#endif /* CONFIG_X86_NUMAQ */
+
 /* which physical APIC ID maps to which logical CPU number */
 volatile int physical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
@@ -524,6 +564,7 @@
 		cpu_2_physical_apicid[cpu] = -1;
 		cpu_2_logical_apicid[cpu] = -1;
 	}
+	init_cpu_to_node_mapping();
 }
 
 static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
@@ -535,6 +576,7 @@
 	if (clustered_apic_mode) {
 		logical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_logical_apicid[cpu] = apicid;
+		map_cpu_to_node(cpu, apicid >> 4);
 	} else {
 		physical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_physical_apicid[cpu] = apicid;
@@ -550,6 +592,7 @@
 	if (clustered_apic_mode) {
 		logical_apicid_2_cpu[apicid] = -1;	
 		cpu_2_logical_apicid[cpu] = -1;
+		unmap_cpu_to_node(cpu, apicid >> 4);
 	} else {
 		physical_apicid_2_cpu[apicid] = -1;	
 		cpu_2_physical_apicid[cpu] = -1;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.46-vanilla/include/asm-i386/smpboot.h linux-2.5.46-i386_topo_fix/include/asm-i386/smpboot.h
--- linux-2.5.46-vanilla/include/asm-i386/smpboot.h	Mon Nov  4 14:30:51 2002
+++ linux-2.5.46-i386_topo_fix/include/asm-i386/smpboot.h	Mon Nov  4 16:43:49 2002
@@ -23,6 +23,14 @@
  #define boot_cpu_apicid boot_cpu_physical_apicid
 #endif /* CONFIG_CLUSTERED_APIC */
 
+#ifdef CONFIG_X86_NUMAQ
+/*
+ * Mappings between logical cpu number and node number
+ */
+extern volatile unsigned long node_2_cpu_mask[];
+extern volatile int cpu_2_node[];
+#endif /* CONFIG_X86_NUMAQ */
+
 /*
  * Mappings between logical cpu number and logical / physical apicid
  * The first four macros are trivial, but it keeps the abstraction consistent
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.46-vanilla/include/asm-i386/topology.h linux-2.5.46-i386_topo_fix/include/asm-i386/topology.h
--- linux-2.5.46-vanilla/include/asm-i386/topology.h	Mon Nov  4 14:30:10 2002
+++ linux-2.5.46-i386_topo_fix/include/asm-i386/topology.h	Mon Nov  4 16:43:49 2002
@@ -32,7 +32,7 @@
 #include <asm/smpboot.h>
 
 /* Returns the number of the node containing CPU 'cpu' */
-#define __cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+#define __cpu_to_node(cpu) (cpu_2_node[cpu])
 
 /* Returns the number of the node containing MemBlk 'memblk' */
 #define __memblk_to_node(memblk) (memblk)
@@ -41,44 +41,11 @@
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
-static inline unsigned long __node_to_cpu_mask(int node)
-{
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
+/* Returns a bitmask of CPUs on Node 'node'. */
+#define __node_to_cpu_mask(node) (node_2_cpu_mask[node])
 
-	return mask;
-}
+/* Returns the number of the first CPU on Node 'node'. */
+#define __node_to_first_cpu(node) (__ffs(__node_to_cpu_mask(node)))
 
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)

--------------010606070506090301080603--

