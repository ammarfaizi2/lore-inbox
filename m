Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUJNWEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUJNWEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUJNUpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:45:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51446 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267251AbUJNSuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:50:50 -0400
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041011153830.495b7c2d.akpm@osdl.org>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011214304.GD31731@wotan.suse.de>
	 <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011221519.GA11702@wotan.suse.de>
	 <20041011153830.495b7c2d.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-tfBh56jvGX/5xdor0twZ"
Organization: 
Message-Id: <1097779232.2861.9.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Oct 2004 11:40:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tfBh56jvGX/5xdor0twZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-10-11 at 15:38, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > > Console: colour VGA+ 80x25
> > > Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> > > Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> > > Bad page state at free_hot_cold_page (in process 'swapper', page
> > > 000001017ac06070)
> > > flags:0x00000000 mapping:0000000000000000 mapcount:1 count:0
> > 
> > Some memory corruption or confused memory allocator.

Sorry for taking this long to track this down ..
I was looking at all wrong patches to backout. I had
to resolve to binary search to track this down :)

This is the patch "x86-64-optimize-numa-lookup.patch" Andi made, 
that broke my AMD64 melody box. Backing this out, fixed the OOPS
on boot.

I will leave it capable hands of Andi to figure out whats wrong
with it. Andi, if you want me to test the fix, send it my way.

Thanks,
Badari

--=-tfBh56jvGX/5xdor0twZ
Content-Disposition: attachment; filename=x86-64-optimize-numa-lookup.patch
Content-Type: text/plain; name=x86-64-optimize-numa-lookup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


From: Andi Kleen <ak@muc.de>

Shrink the page_to_pfn / pfn_to_page macros for NUMA kernels.

This is done by precomputing some terms used for it and caching it in an
array and avoiding redundant computation that was not optimized away by the
compiler.  In particular the node map is now directly looked up in an
single array instead of going through two array lookups.

This patch saves around 2k of .text on a defconfig kernel and generates a
lot better code.

Out of lining them would save even more space (10k), but this is not done
for performance.  One reason they're so big inline is that gcc 3.3
generated an very long lea multiplication chain, even though a single mult
would have been faster on K8.  gcc 3.5 seems to have fixed that.

Some numbers:

   text    data     bss     dec     hex filename
   3586142  906809  496088 4989039  4c206f vmlinux
		Current version implemented by this patch (saves ~2k) 
   
   3586574  906844  496088 4989506  4c2242 vmlinux-noinline
		Old macros, out of line (saves 1.6k) 
   
   3575166  906955  496088 4978209  4bf621 vmlinux-opt-ool
   		Optimized macros out of line (- saves ~13k) 
		
   3588255  906750  494040 4989045  4c2075 vmlinux-standard
   		Original version

Also remove the unused nodes_present variable.		

Original suggestion for this optimization came from Bill Irwin.		

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/mm/k8topology.c |   11 ++--
 25-akpm/arch/x86_64/mm/numa.c       |   84 ++++++++++++++++++++++++++++++------
 25-akpm/include/asm-x86_64/mmzone.h |   36 +++++++++------
 3 files changed, 100 insertions(+), 31 deletions(-)

diff -puN arch/x86_64/mm/k8topology.c~x86-64-optimize-numa-lookup arch/x86_64/mm/k8topology.c
--- 25/arch/x86_64/mm/k8topology.c~x86-64-optimize-numa-lookup	Tue Oct  5 16:38:20 2004
+++ 25-akpm/arch/x86_64/mm/k8topology.c	Tue Oct  5 16:38:20 2004
@@ -143,19 +143,20 @@ int __init k8_scan_nodes(unsigned long s
 	if (!found)
 		return -1; 
 
-	memnode_shift = compute_hash_shift(nodes);
-	if (memnode_shift < 0) { 
+	memnode_addr_shift = compute_hash_shift(nodes);
+	if (memnode_addr_shift < 0) {
 		printk(KERN_ERR "No NUMA node hash function found. Contact maintainer\n"); 
 		return -1; 
 	} 
-	printk(KERN_INFO "Using node hash shift of %d\n", memnode_shift); 
+	memnode_pfn_shift = memnode_addr_shift - PAGE_SHIFT;
+	printk(KERN_INFO "Using node hash shift of %d\n", memnode_addr_shift);
 
 	for (i = 0; i < MAXNODE; i++) { 
 		if (nodes[i].start != nodes[i].end) { 
 			/* assume 1:1 NODE:CPU */
 			cpu_to_node[i] = i; 
-		setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
-	} 
+			setup_node_bootmem(i, nodes[i].start, nodes[i].end);
+		}
 	}
 
 	numa_init_array();
diff -puN arch/x86_64/mm/numa.c~x86-64-optimize-numa-lookup arch/x86_64/mm/numa.c
--- 25/arch/x86_64/mm/numa.c~x86-64-optimize-numa-lookup	Tue Oct  5 16:38:20 2004
+++ 25-akpm/arch/x86_64/mm/numa.c	Tue Oct  5 16:38:20 2004
@@ -10,6 +10,7 @@
 #include <linux/mmzone.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 #include <asm/e820.h>
 #include <asm/proto.h>
 #include <asm/dma.h>
@@ -19,28 +20,58 @@
 #define Dprintk(x...)
 #endif
 
+/*
+ * NUMA data structures. These describe the NUMA topology to the kernel
+ */
+
 struct pglist_data *node_data[MAXNODE];
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
 
-int memnode_shift;
+static struct nodemap_update {
+	DECLARE_BITMAP(map, NODEMAPSIZE);
+} nodemap_update[MAXNODE] __initdata;
+
+int memnode_addr_shift;
+int memnode_pfn_shift;
 u8  memnodemap[NODEMAPSIZE];
 
+/* This is a special biased mem_map per node table.
+   It contains the mem_map for a node minus the start pfn.
+   This trick makes some common inline functions faster and smaller. */
+struct page *memnode_rel_memmap[NODEMAPSIZE];
+
 unsigned char cpu_to_node[NR_CPUS];  
 cpumask_t     node_to_cpumask[MAXNODE]; 
 
 static int numa_off __initdata; 
 
-unsigned long nodes_present; 
+/* Mark node for later update */
+static inline __init void mark_memnode(long index, long node)
+{
+	set_bit(index, &nodemap_update[node].map);
+}
+
+static void __init
+update_memnode_table(long node, struct page *mem_map, unsigned long start_pfn)
+{
+	int i;
+	for (i = 0; i < NODEMAPSIZE; i++) {
+		if (!test_bit(i, &nodemap_update[node].map))
+			continue;
+		memnode_rel_memmap[i] = mem_map - start_pfn;
+	}
+}
 
 int __init compute_hash_shift(struct node *nodes)
 {
-	int i; 
+	long i;
 	int shift = 24;
 	u64 addr;
 	
 	/* When in doubt use brute force. */
 	while (shift < 48) { 
 		memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE); 
+		memset(memnode_rel_memmap,0,sizeof(*memnode_rel_memmap) * NODEMAPSIZE);
 		for (i = 0; i < numnodes; i++) { 
 			if (nodes[i].start == nodes[i].end) 
 				continue;
@@ -50,11 +81,12 @@ int __init compute_hash_shift(struct nod
 				if (memnodemap[addr >> shift] != 0xff && 
 				    memnodemap[addr >> shift] != i) { 
 					printk(KERN_INFO 
-					    "node %d shift %d addr %Lx conflict %d\n", 
+					    "node %ld shift %d addr %Lx conflict %d\n",
 					       i, shift, addr, memnodemap[addr>>shift]);
 					goto next; 
 				} 
 				memnodemap[addr >> shift] = i; 
+				mark_memnode(addr >> shift, i);
 			} 
 		} 
 		return shift; 
@@ -62,6 +94,7 @@ int __init compute_hash_shift(struct nod
 		shift++; 
 	} 
 	memset(memnodemap,0,sizeof(*memnodemap) * NODEMAPSIZE); 
+	memset(memnode_rel_memmap,0,sizeof(*memnode_rel_memmap) * NODEMAPSIZE);
 	return -1; 
 }
 
@@ -112,13 +145,26 @@ void __init setup_node_bootmem(int nodei
 	node_set_online(nodeid);
 } 
 
+static void __init my_node_alloc_mem_map(struct pglist_data *pgdat, long npages)
+{
+	unsigned long size;
+
+	size = (npages + 1) * sizeof(struct page);
+	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+#ifndef CONFIG_DISCONTIGMEM
+	mem_map = contig_page_data.node_mem_map;
+#endif
+}
+
 /* Initialize final allocator for a zone */
 void __init setup_node_zones(int nodeid)
 { 
 	unsigned long start_pfn, end_pfn; 
 	unsigned long zones[MAX_NR_ZONES];
 	unsigned long dma_end_pfn;
+	DECLARE_BITMAP(nodemapbits, NODEMAPSIZE);
 
+	memset(nodemapbits, 0, sizeof(nodemapbits));
 	memset(zones, 0, sizeof(unsigned long) * MAX_NR_ZONES); 
 
 	start_pfn = node_start_pfn(nodeid);
@@ -134,7 +180,14 @@ void __init setup_node_zones(int nodeid)
 	} else { 
 		zones[ZONE_NORMAL] = end_pfn - start_pfn; 
 	} 
-    
+
+	/* Allocate mem_map */
+	my_node_alloc_mem_map(NODE_DATA(nodeid), end_pfn - start_pfn);
+
+	/* Set up pfn_to_page */
+	update_memnode_table(nodeid, NODE_DATA(nodeid)->node_mem_map, start_pfn);
+
+	/* And initialise the node in main VM */
 	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
 			    start_pfn, NULL); 
 } 
@@ -195,14 +248,17 @@ static int numa_emulation(unsigned long 
  		       (nodes[i].end - nodes[i].start) >> 20);
  	}
  	numnodes = numa_fake;
- 	memnode_shift = compute_hash_shift(nodes);
- 	if (memnode_shift < 0) {
- 		memnode_shift = 0;
+ 	memnode_addr_shift = compute_hash_shift(nodes);
+	memnode_pfn_shift = memnode_addr_shift - PAGE_SHIFT;
+ 	if (memnode_addr_shift < 0) {
+ 		memnode_addr_shift = 0;
+ 		memnode_pfn_shift = 0;
  		printk(KERN_ERR "No NUMA hash function found. Emulation disabled.\n");
  		return -1;
  	}
- 	for (i = 0; i < numa_fake; i++)
+ 	for (i = 0; i < numa_fake; i++) {
  		setup_node_bootmem(i, nodes[i].start, nodes[i].end);
+	}
  	numa_init_array();
  	return 0;
 }
@@ -224,9 +280,11 @@ void __init numa_initmem_init(unsigned l
 	printk(KERN_INFO "Faking a node at %016lx-%016lx\n", 
 	       start_pfn << PAGE_SHIFT,
 	       end_pfn << PAGE_SHIFT); 
-		/* setup dummy node covering all memory */ 
-	memnode_shift = 63; 
+	/* set up dummy node covering all memory */
+	memnode_addr_shift = 63;
+	memnode_pfn_shift = 63;
 	memnodemap[0] = 0;
+	mark_memnode(0,0);
 	numnodes = 1;
 	for (i = 0; i < NR_CPUS; i++)
 		cpu_to_node[i] = 0;
@@ -274,6 +332,8 @@ __init int numa_setup(char *opt) 
 
 EXPORT_SYMBOL(cpu_to_node);
 EXPORT_SYMBOL(node_to_cpumask);
-EXPORT_SYMBOL(memnode_shift);
+EXPORT_SYMBOL(memnode_addr_shift);
+EXPORT_SYMBOL(memnode_pfn_shift);
 EXPORT_SYMBOL(memnodemap);
 EXPORT_SYMBOL(node_data);
+EXPORT_SYMBOL(memnode_rel_memmap);
diff -puN include/asm-x86_64/mmzone.h~x86-64-optimize-numa-lookup include/asm-x86_64/mmzone.h
--- 25/include/asm-x86_64/mmzone.h~x86-64-optimize-numa-lookup	Tue Oct  5 16:38:20 2004
+++ 25-akpm/include/asm-x86_64/mmzone.h	Tue Oct  5 16:38:20 2004
@@ -16,8 +16,11 @@
 #define NODEMAPSIZE 0xff
 
 /* Simple perfect hash to map physical addresses to node numbers */
-extern int memnode_shift; 
+extern int memnode_addr_shift;
+extern int memnode_pfn_shift;
 extern u8  memnodemap[NODEMAPSIZE]; 
+/* pgdat->node_mem_map - pgdat->node_start_pfn. cached for fast pfn_to_page */
+extern struct page *memnode_rel_memmap[NODEMAPSIZE];
 extern int maxnode;
 
 extern struct pglist_data *node_data[];
@@ -25,13 +28,20 @@ extern struct pglist_data *node_data[];
 static inline __attribute__((pure)) int phys_to_nid(unsigned long addr) 
 { 
 	int nid; 
-	VIRTUAL_BUG_ON((addr >> memnode_shift) >= NODEMAPSIZE);
-	nid = memnodemap[addr >> memnode_shift]; 
+	VIRTUAL_BUG_ON((addr >> memnode_addr_shift) >= NODEMAPSIZE);
+	nid = memnodemap[addr >> memnode_addr_shift];
 	VIRTUAL_BUG_ON(nid > maxnode); 
 	return nid; 
 } 
 
-#define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
+static inline __attribute__((pure)) int pfn_to_nid(unsigned long pfn)
+{
+	int nid;
+	VIRTUAL_BUG_ON((pfn >> memnode_pfn_shift) >= NODEMAPSIZE);
+	nid = memnodemap[pfn >> memnode_pfn_shift];
+	VIRTUAL_BUG_ON(nid > maxnode);
+	return nid;
+}
 
 #define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
 #define NODE_DATA(nid)		(node_data[nid])
@@ -46,20 +56,18 @@ static inline __attribute__((pure)) int 
 #define local_mapnr(kvaddr) \
 	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) )
 
-/* AK: this currently doesn't deal with invalid addresses. We'll see 
-   if the 2.5 kernel doesn't pass them
-   (2.4 used to). */
-#define pfn_to_page(pfn) ({ \
-	int nid = phys_to_nid(((unsigned long)(pfn)) << PAGE_SHIFT); 	\
-	((pfn) - node_start_pfn(nid)) + node_mem_map(nid);		\
-})
+/* These must be macros due to some broken include dependencies */
+
+#define pfn_to_page(pfn) ((pfn) + memnode_rel_memmap[(pfn) >> memnode_pfn_shift])
 
-#define page_to_pfn(page) \
-	(long)(((page) - page_zone(page)->zone_mem_map) + page_zone(page)->zone_start_pfn)
+#define page_to_pfn(page) ({ \
+	struct zone *z = page_zone(page); 				\
+	/* Could also cache zone_mem_map + zone_start_pfn. Worth it? */ \
+	((page) - z->zone_mem_map) + z->zone_start_pfn;			\
+})
 
 /* AK: !DISCONTIGMEM just forces it to 1. Can't we too? */
 #define pfn_valid(pfn)          ((pfn) < num_physpages)
 
-
 #endif
 #endif
_

--=-tfBh56jvGX/5xdor0twZ--

