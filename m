Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCAHQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCAHQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 02:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVCAHQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 02:16:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61347 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261285AbVCAHQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 02:16:23 -0500
Subject: Re: [PATCH 3/5] abstract discontigmem setup
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>, kmannth@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Yasunori Goto <ygoto@us.fujitsu.com>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20050228222159.0c21a48e.akpm@osdl.org>
References: <E1D5q2Q-0007eV-00@kernel.beaverton.ibm.com>
	 <20050228222159.0c21a48e.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-rtPDPb7ekMQ9PQcr3A7E"
Date: Mon, 28 Feb 2005 23:16:11 -0800
Message-Id: <1109661371.6921.90.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rtPDPb7ekMQ9PQcr3A7E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-02-28 at 22:21 -0800, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > memory_present() is how each arch/subarch will tell sparsemem
> >  and discontigmem where all of its memory is.  This is what
> >  triggers sparse to go out and create its mappings for the memory,
> >  as well as allocate the mem_map[].
> 
> There are cross-compilers at http://developer.osdl.org/dev/plm/cross_compile/
> 
> This also needs runtime testing on ppc64, does it not?

It does, indeed.  Because they are independent, we can drop the ppc64
portion for now, and we'll submit the tested changes at least before the
sparsemem merge for that arch.

I've attached the i386-only version, along with the NUMA-Q fix, which
replaces the original patch.  I can also wait until the next -mm to
ensure that it is tested properly.

-- Dave

--=-rtPDPb7ekMQ9PQcr3A7E
Content-Disposition: attachment; filename=A3.1-abstract-discontig.patch
Content-Type: text/x-patch; name=A3.1-abstract-discontig.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


memory_present() is how each arch/subarch will tell sparsemem
and discontigmem where all of its memory is.  This is what
triggers sparse to go out and create its mappings for the memory,
as well as allocate the mem_map[].

By: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/Kconfig        |   10 ++++++
 memhotplug-dave/arch/i386/kernel/numaq.c |    8 ++++-
 memhotplug-dave/arch/i386/kernel/srat.c  |    9 +++++
 memhotplug-dave/arch/i386/mm/discontig.c |   49 +++++++++++++++++++------------
 memhotplug-dave/arch/ppc64/mm/numa.c     |   19 ++++++++----
 memhotplug-dave/include/linux/mmzone.h   |   11 ++++++
 6 files changed, 81 insertions(+), 25 deletions(-)

diff -puN arch/i386/kernel/numaq.c~A3.1-abstract-discontig arch/i386/kernel/numaq.c
--- memhotplug/arch/i386/kernel/numaq.c~A3.1-abstract-discontig	2005-02-28 22:42:18.000000000 -0800
+++ memhotplug-dave/arch/i386/kernel/numaq.c	2005-02-28 22:45:48.000000000 -0800
@@ -32,7 +32,7 @@
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
-extern long node_start_pfn[], node_end_pfn[];
+extern long node_start_pfn[], node_end_pfn[], node_remap_size[];
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -59,6 +59,12 @@ static void __init smp_dump_qct(void)
 				eq->hi_shrd_mem_start - eq->priv_mem_size);
 			node_end_pfn[node] = MB_TO_PAGES(
 				eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
+
+			memory_present(node,
+				node_start_pfn[node], node_end_pfn[node]);
+			node_remap_size[node] = node_memmap_size_bytes(node,
+							node_start_pfn[node],
+							node_end_pfn[node]);
 		}
 	}
 }
diff -puN arch/i386/kernel/srat.c~A3.1-abstract-discontig arch/i386/kernel/srat.c
--- memhotplug/arch/i386/kernel/srat.c~A3.1-abstract-discontig	2005-02-28 22:42:18.000000000 -0800
+++ memhotplug-dave/arch/i386/kernel/srat.c	2005-02-28 22:45:48.000000000 -0800
@@ -58,7 +58,7 @@ static int num_memory_chunks;		/* total 
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
 
-extern unsigned long node_start_pfn[], node_end_pfn[];
+extern unsigned long node_start_pfn[], node_end_pfn[], node_remap_size[];
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -286,6 +286,13 @@ static int __init acpi20_parse_srat(stru
 			}
 		}
 	}
+	for_each_online_node(nid) {
+		unsigned long start = node_start_pfn[nid];
+		unsigned long end = node_end_pfn[nid];
+
+		memory_present(nid, start, end);
+		node_remap_size[nid] = node_memmap_size_bytes(nid, start, end);
+	}
 	return 1;
 out_fail:
 	return 0;
diff -puN arch/i386/mm/discontig.c~A3.1-abstract-discontig arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~A3.1-abstract-discontig	2005-02-28 22:42:18.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-02-28 22:45:48.000000000 -0800
@@ -60,6 +60,32 @@ bootmem_data_t node0_bdata;
  */
 s8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
 
+void memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long pfn;
+
+	printk(KERN_INFO "Node: %d, start_pfn: %ld, end_pfn: %ld\n",
+			nid, start, end);
+	printk(KERN_DEBUG "  Setting physnode_map array to node %d for pfns:\n", nid);
+	printk(KERN_DEBUG "  ");
+	for (pfn = start; pfn < end; pfn += PAGES_PER_ELEMENT) {
+		physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
+		printk(KERN_DEBUG "%ld ", pfn);
+	}
+	printk(KERN_DEBUG "\n");
+}
+
+unsigned long node_memmap_size_bytes(int nid, unsigned long start_pfn,
+					      unsigned long end_pfn)
+{
+	unsigned long nr_pages = end_pfn - start_pfn;
+
+	if (!nr_pages)
+		return 0;
+
+	return (nr_pages + 1) * sizeof(struct page);
+}
+
 unsigned long node_start_pfn[MAX_NUMNODES];
 unsigned long node_end_pfn[MAX_NUMNODES];
 
@@ -162,9 +188,9 @@ static unsigned long calculate_numa_rema
 	for_each_online_node(nid) {
 		if (nid == 0)
 			continue;
-		/* calculate the size of the mem_map needed in bytes */
-		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
-			* sizeof(struct page) + sizeof(pg_data_t);
+		/* ensure the remap includes space for the pgdat. */
+		size = node_remap_size[nid] + sizeof(pg_data_t);
+
 		/* convert size to large (pmd size) pages, rounding up */
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
@@ -189,7 +215,7 @@ unsigned long __init setup_memory(void)
 {
 	int nid;
 	unsigned long system_start_pfn, system_max_low_pfn;
-	unsigned long reserve_pages, pfn;
+	unsigned long reserve_pages;
 
 	/*
 	 * When mapping a NUMA machine we allocate the node_mem_map arrays
@@ -198,22 +224,9 @@ unsigned long __init setup_memory(void)
 	 * this space and use it to adjust the boundry between ZONE_NORMAL
 	 * and ZONE_HIGHMEM.
 	 */
+	find_max_pfn();
 	get_memcfg_numa();
 
-	/* Fill in the physnode_map */
-	for_each_online_node(nid) {
-		printk("Node: %d, start_pfn: %ld, end_pfn: %ld\n",
-				nid, node_start_pfn[nid], node_end_pfn[nid]);
-		printk("  Setting physnode_map array to node %d for pfns:\n  ",
-				nid);
-		for (pfn = node_start_pfn[nid]; pfn < node_end_pfn[nid];
-	       				pfn += PAGES_PER_ELEMENT) {
-			physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
-			printk("%ld ", pfn);
-		}
-		printk("\n");
-	}
-
 	reserve_pages = calculate_numa_remap_pages();
 
 	/* partially used pages are not usable - thus round upwards */
diff -puN include/linux/mmzone.h~A3.1-abstract-discontig include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~A3.1-abstract-discontig	2005-02-28 22:42:18.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-02-28 22:43:10.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -278,6 +279,16 @@ void wakeup_kswapd(struct zone *zone, in
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		int alloc_type, int can_try_harder, int gfp_high);
 
+#ifdef CONFIG_HAVE_MEMORY_PRESENT
+void memory_present(int nid, unsigned long start, unsigned long end);
+#else
+static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
+#endif
+
+#ifdef CONFIG_NEED_NODE_MEMMAP_SIZE
+unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
+#endif
+
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
diff -puN arch/i386/Kconfig~A3.1-abstract-discontig arch/i386/Kconfig
--- memhotplug/arch/i386/Kconfig~A3.1-abstract-discontig	2005-02-28 22:42:18.000000000 -0800
+++ memhotplug-dave/arch/i386/Kconfig	2005-02-28 22:43:10.000000000 -0800
@@ -769,6 +769,16 @@ config HAVE_ARCH_BOOTMEM_NODE
 	depends on NUMA
 	default y
 
+config HAVE_MEMORY_PRESENT
+	bool
+	depends on DISCONTIGMEM
+	default y
+
+config NEED_NODE_MEMMAP_SIZE
+	bool
+	depends on DISCONTIGMEM
+	default y
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM4G || HIGHMEM64G
_

--=-rtPDPb7ekMQ9PQcr3A7E--

