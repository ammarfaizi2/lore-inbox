Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTIPAik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTIPAik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:38:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52141 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261735AbTIPAi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:38:26 -0400
Message-ID: <3F665AC0.7070104@us.ibm.com>
Date: Mon, 15 Sep 2003 17:35:12 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: [PATCH[ Clean up MAX_NR_NODES/NUMNODES/etc. [2/5]
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070000030007080904070203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000030007080904070203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
> Ok, I made an attempt to clean up this mess quite a while ago (2.5.47), 
> but that patch is utterly useless now.  At Martin's urging I've created 
> a new series of patches to resolve this.
> 
> 01 - Make sure MAX_NUMNODES is defined in one and only one place. Remove 
> superfluous definitions.  Instead of defining MAX_NUMNODES in 
> asm/numnodes.h, we define NODES_SHIFT there.  Then in linux/mmzone.h we 
> turn that NODES_SHIFT value into MAX_NUMNODES.
> 
> 02 - Remove MAX_NR_NODES.  This value is only used in a couple of 
> places, and it's incorrectly used in all those places as far as I can 
> tell.  Replace with MAX_NUMNODES.  Create MAX_NODES_SHIFT and use this 
> value to check NODES_SHIFT is appropriate.  A possible future patch 
> should make MAX_NODES_SHIFT vary based on 32 vs. 64 bit archs.
> 
> 03 - Fix up the sh arch.  sh defined NR_NODES, change sh to use standard 
> MAX_NUMNODES instead.
> 
> 04 - Fix up the arm arch.  This needs to be reviewed.  Relatively 
> straightforward replacement of NR_NODES with standard MAX_NUMNODES.
> 
> 05 - Fix up the ia64 arch.  This *definitely* needs to be reviewed. This 
> code made my head hurt.  I think I may have gotten it right. Totally 
> untested.

Cheers!

-Matt

--------------070000030007080904070203
Content-Type: text/plain;
 name="02-remove-max_nr_nodes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-remove-max_nr_nodes.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-max_numnodes2nodes_shift/arch/i386/kernel/smpboot.c linux-2.6.0-test5-remove-max_nr_nodes/arch/i386/kernel/smpboot.c
--- linux-2.6.0-test5-max_numnodes2nodes_shift/arch/i386/kernel/smpboot.c	Mon Sep  8 12:50:03 2003
+++ linux-2.6.0-test5-remove-max_nr_nodes/arch/i386/kernel/smpboot.c	Mon Sep 15 13:44:57 2003
@@ -499,8 +499,8 @@ static struct task_struct * __init fork_
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
-cpumask_t node_2_cpu_mask[MAX_NR_NODES] =
-				{ [0 ... MAX_NR_NODES-1] = CPU_MASK_NONE };
+cpumask_t node_2_cpu_mask[MAX_NUMNODES] =
+				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
 int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
 
@@ -518,7 +518,7 @@ static inline void unmap_cpu_to_node(int
 	int node;
 
 	printk("Unmapping cpu %d from all nodes\n", cpu);
-	for (node = 0; node < MAX_NR_NODES; node ++)
+	for (node = 0; node < MAX_NUMNODES; node ++)
 		cpu_clear(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = -1;
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-max_numnodes2nodes_shift/include/linux/mmzone.h linux-2.6.0-test5-remove-max_nr_nodes/include/linux/mmzone.h
--- linux-2.6.0-test5-max_numnodes2nodes_shift/include/linux/mmzone.h	Mon Sep 15 13:44:27 2003
+++ linux-2.6.0-test5-remove-max_nr_nodes/include/linux/mmzone.h	Mon Sep 15 13:44:57 2003
@@ -304,19 +304,27 @@ extern void setup_per_zone_pages_min(voi
 #define numa_node_id()		(cpu_to_node(smp_processor_id()))
 
 #ifndef CONFIG_DISCONTIGMEM
+
 extern struct pglist_data contig_page_data;
 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
-#define MAX_NR_NODES		1
+#define MAX_NODES_SHIFT		0
+
 #else /* CONFIG_DISCONTIGMEM */
 
 #include <asm/mmzone.h>
-
-/* page->zone is currently 8 bits ... */
-#define MAX_NR_NODES		(255 / MAX_NR_ZONES)
+/*
+ * page->zone is currently 8 bits
+ * there are 3 zones (2 bits)
+ * this leaves 8-2=6 bits for nodes
+ */
+#define MAX_NODES_SHIFT		6
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
+#if NODES_SHIFT > MAX_NODES_SHIFT
+#error NODES_SHIFT > MAX_NODES_SHIFT
+#endif
 
 extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-max_numnodes2nodes_shift/mm/page_alloc.c linux-2.6.0-test5-remove-max_nr_nodes/mm/page_alloc.c
--- linux-2.6.0-test5-max_numnodes2nodes_shift/mm/page_alloc.c	Mon Sep  8 12:49:52 2003
+++ linux-2.6.0-test5-remove-max_nr_nodes/mm/page_alloc.c	Mon Sep 15 13:44:57 2003
@@ -50,7 +50,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
+struct zone *zone_table[MAX_NR_ZONES*MAX_NUMNODES];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };

--------------070000030007080904070203--

