Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161764AbWKOVtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161764AbWKOVtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161766AbWKOVtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:49:39 -0500
Received: from usea-naimss1.unisys.com ([192.61.61.103]:47877 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1161764AbWKOVtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:49:39 -0500
Subject: [PATCH] x86_64: Make the NUMA hash function nodemap allocation
	dynamic and remove NODEMAPSIZE
From: Amul Shah <amul.shah@unisys.com>
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Eric Dumazet <dada1@cosmosbay.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 16:48:32 -0500
Message-Id: <1163627312.3553.199.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2006 21:49:31.0632 (UTC) FILETIME=[EE9D5700:01C708FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the statically allocated memory to NUMA node hash map
in favor of a dynamically allocated memory to node hash map (it is cache
aligned).

This patch has the nice side effect in that it allows the hash map to
grow for systems with large amounts of memory (256GB - 1TB), but suffer
from having small PCI space tacked onto the boot node (which is
somewhere between 192MB to 512MB on the ES7000).

Signed-off-by: Amul Shah <amul.shah@unisys.com>

---
Patch applies to 2.6.19-rc4 and has been tested.
This patch needs testing on a K8 NUMA platform.
Thanks to Eric Dumazet and Andi Kleen for their improvement suggestions.

diff -upNr linux-2.6.19-rc4/arch/x86_64/kernel/e820.c linux-2.6.19-rc4-az/arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc4/arch/x86_64/kernel/e820.c	2006-10-31 17:38:41.000000000 -0500
+++ linux-2.6.19-rc4-az/arch/x86_64/kernel/e820.c	2006-11-08 17:55:48.000000000 -0500
@@ -83,6 +83,12 @@ static inline int bad_addr(unsigned long
 		return 1;
 	}
 
+	/* NUMA memory to node map */
+	if (last >= nodemap_addr && addr < nodemap_addr + nodemap_size) {
+		*addrp = nodemap_addr + nodemap_size;
+		return 1;
+	}
+
 	/* XXX ramdisk image here? */ 
 	return 0;
 } 
diff -upNr linux-2.6.19-rc4/arch/x86_64/kernel/setup.c linux-2.6.19-rc4-az/arch/x86_64/kernel/setup.c
--- linux-2.6.19-rc4/arch/x86_64/kernel/setup.c	2006-10-31 17:38:41.000000000 -0500
+++ linux-2.6.19-rc4-az/arch/x86_64/kernel/setup.c	2006-11-08 17:55:48.000000000 -0500
@@ -445,6 +445,10 @@ void __init setup_arch(char **cmdline_p)
 	if (ebda_addr)
 		reserve_bootmem_generic(ebda_addr, ebda_size);
 
+	/* reserve nodemap region */
+	if (nodemap_addr)
+		reserve_bootmem_generic(nodemap_addr, nodemap_size);
+
 #ifdef CONFIG_SMP
 	/*
 	 * But first pinch a few for the stack/trampoline stuff
diff -upNr linux-2.6.19-rc4/arch/x86_64/mm/numa.c linux-2.6.19-rc4-az/arch/x86_64/mm/numa.c
--- linux-2.6.19-rc4/arch/x86_64/mm/numa.c	2006-10-31 17:38:41.000000000 -0500
+++ linux-2.6.19-rc4-az/arch/x86_64/mm/numa.c	2006-11-15 15:54:55.000000000 -0500
@@ -36,6 +36,8 @@ unsigned char apicid_to_node[MAX_LOCAL_A
 cpumask_t node_to_cpumask[MAX_NUMNODES] __read_mostly;
 
 int numa_off __initdata;
+unsigned long __initdata nodemap_addr;
+unsigned long __initdata nodemap_size;
 
 
 /*
@@ -52,34 +54,87 @@ populate_memnodemap(const struct bootnod
 	int res = -1;
 	unsigned long addr, end;
 
-	if (shift >= 64)
-		return -1;
-	memset(memnodemap, 0xff, sizeof(memnodemap));
+	memset(memnodemap, 0xff, memnodemapsize);
 	for (i = 0; i < numnodes; i++) {
 		addr = nodes[i].start;
 		end = nodes[i].end;
 		if (addr >= end)
 			continue;
-		if ((end >> shift) >= NODEMAPSIZE)
+		if ((end >> shift) >= memnodemapsize)
 			return 0;
 		do {
 			if (memnodemap[addr >> shift] != 0xff)
 				return -1;
 			memnodemap[addr >> shift] = i;
-                       addr += (1UL << shift);
+			addr += (1UL << shift);
 		} while (addr < end);
 		res = 1;
 	} 
 	return res;
 }
 
-int __init compute_hash_shift(struct bootnode *nodes, int numnodes)
+static int __init allocate_cachealigned_memnodemap(void)
 {
-	int shift = 20;
+	unsigned long pad, pad_addr;
 
-	while (populate_memnodemap(nodes, numnodes, shift + 1) >= 0)
-		shift++;
+	memnodemap = memnode.embedded_map;
+	if (memnodemapsize <= 48) {
+		printk(KERN_DEBUG "NUMA: Allocated memnodemap from %lx - %lx\n",
+		       nodemap_addr, nodemap_addr + nodemap_size);
+		return 0;
+	}
+	
+	pad = L1_CACHE_BYTES - 1;
+	pad_addr = 0x8000;
+	nodemap_size = pad + memnodemapsize;
+	nodemap_addr = find_e820_area(pad_addr, end_pfn<<PAGE_SHIFT,
+				      nodemap_size);
+	if (nodemap_addr == -1UL) {
+		printk(KERN_ERR
+		       "NUMA: Unable to allocate Memory to Node hash map\n");
+		nodemap_addr = nodemap_size = 0;
+		return -1;
+	}
+	pad_addr = (nodemap_addr + pad) & ~pad;
+	memnodemap = phys_to_virt(pad_addr);
+	
+	printk(KERN_DEBUG "NUMA: Allocated memnodemap from %lx - %lx\n",
+	       nodemap_addr, nodemap_addr + nodemap_size);
+	return 0;
+}
 
+/*
+ * The LSB of all start and end addresses in the node map is the value of the
+ * maximum possible shift.
+ */
+static int __init 
+extract_lsb_from_nodes (const struct bootnode *nodes, int numnodes)
+{
+	int i;
+	unsigned long start, end;
+	unsigned long bitfield = 0, memtop = 0;
+	
+	for (i = 0; i < numnodes; i++) {
+		start = nodes[i].start;
+		end = nodes[i].end;
+		if (start >= end) 
+			continue;
+		bitfield |= start | end;
+		if (end > memtop)
+			memtop = end;
+	}
+	i = find_first_bit(&bitfield, sizeof(unsigned long)*8);
+	memnodemapsize = (memtop >> i)+1;
+	return i;
+}
+
+int __init compute_hash_shift(struct bootnode *nodes, int numnodes)
+{
+	int shift;
+
+	shift = extract_lsb_from_nodes(nodes, numnodes);
+	if (allocate_cachealigned_memnodemap())
+		return -1;
 	printk(KERN_DEBUG "NUMA: Using %d for the hash shift.\n",
 		shift);
 
diff -upNr linux-2.6.19-rc4/include/asm-x86_64/e820.h linux-2.6.19-rc4-az/include/asm-x86_64/e820.h
--- linux-2.6.19-rc4/include/asm-x86_64/e820.h	2006-10-31 17:39:24.000000000 -0500
+++ linux-2.6.19-rc4-az/include/asm-x86_64/e820.h	2006-11-08 17:55:48.000000000 -0500
@@ -56,6 +56,7 @@ extern void finish_e820_parsing(void);
 extern struct e820map e820;
 
 extern unsigned ebda_addr, ebda_size;
+extern unsigned long nodemap_addr, nodemap_size;
 #endif/*!__ASSEMBLY__*/
 
 #endif/*__E820_HEADER*/
diff -upNr linux-2.6.19-rc4/include/asm-x86_64/mmzone.h linux-2.6.19-rc4-az/include/asm-x86_64/mmzone.h
--- linux-2.6.19-rc4/include/asm-x86_64/mmzone.h	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.19-rc4-az/include/asm-x86_64/mmzone.h	2006-11-15 15:26:16.000000000 -0500
@@ -11,24 +11,25 @@
 
 #include <asm/smp.h>
 
-/* Should really switch to dynamic allocation at some point */
-#define NODEMAPSIZE 0x4fff
-
 /* Simple perfect hash to map physical addresses to node numbers */
 struct memnode {
 	int shift;
-	u8 map[NODEMAPSIZE];
-} ____cacheline_aligned;
+	unsigned int mapsize;
+	u8 *map;
+	u8 embedded_map[64-16];
+} ____cacheline_aligned; /* total size = 64 bytes */
 extern struct memnode memnode;
 #define memnode_shift memnode.shift
 #define memnodemap memnode.map
+#define memnodemapsize memnode.mapsize
 
 extern struct pglist_data *node_data[];
 
 static inline __attribute__((pure)) int phys_to_nid(unsigned long addr) 
 { 
 	unsigned nid; 
-	VIRTUAL_BUG_ON((addr >> memnode_shift) >= NODEMAPSIZE);
+	VIRTUAL_BUG_ON(!memnodemap);
+	VIRTUAL_BUG_ON((addr >> memnode_shift) >= memnodemapsize);
 	nid = memnodemap[addr >> memnode_shift]; 
 	VIRTUAL_BUG_ON(nid >= MAX_NUMNODES || !node_data[nid]); 
 	return nid; 


