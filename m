Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315253AbSD3BSm>; Mon, 29 Apr 2002 21:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315254AbSD3BSl>; Mon, 29 Apr 2002 21:18:41 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19900 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315253AbSD3BSd>; Mon, 29 Apr 2002 21:18:33 -0400
Message-Id: <200204300115.g3U1FQc16634@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Apr 2002 18:15:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides generic discontiguous memory support for the i386
numa architecture.  The patch also provides supports for the ia32 IBM
NUMA-Q hardware platform.  

This patch depends on the two patches that modularize setup_arch() and
mem_init().  These two patches were sent to the mailing list about a
week go.  They're available at:

http://prdownloads.sourceforge.net/lse/meminit-2.4.19pre7.patch
http://prdownloads.sourceforge.net/lse/setup_arch-2.4.19pre7.patch

The discontigmem patch is available at:

http://prdownloads.sourceforge.net/lse/x86_discontigmem-2.4.19pre7.patch

Assumptions made: 

        - that the first node has at least 900Mb of memory

Still to do:

	- port to 2.5.11
	- write up a set of instructions (and todo list) so that other
	ia32 numa boxes	can reuse this patch.
        - test on a system with more than 4GB of memory.

Testing done: 

        - single proc desktop pc (CONFIG_DISCONTIGMEM is not set)
        - 4 proc SMP system (CONFIG_DISCONTIGMEM is not set)
        - 8 proc NUMA box with 2GB memory (CONFIG_DISCONTMEM=y)
        - 16 proc NUMA box with 4GB memory (CONFIG_DISCONTMEM=y)

Any and all feedback is greatly appreciated.

Regards,
Pat

--
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

--- linux-2.4.19pre7-cleanup/arch/i386/config.in	Tue Apr 16 15:07:03 2002
+++ linux-2.4.19pre7-multi2/arch/i386/config.in	Tue Apr 23 18:04:28 2002
@@ -199,6 +199,14 @@
    fi
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+	if [ "$CONFIG_MULTIQUAD" = "y" ]; then
+   	bool 'Discontiguous Memory Support' CONFIG_DISCONTIGMEM
+		if [ "$CONFIG_DISCONTIGMEM" = "y" ]; then
+		define_bool CONFIG_DISCONTIGMEM_X86 y
+		define_bool CONFIG_IBMNUMAQ y
+		define_bool CONFIG_NUMA y
+		fi
+	fi
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
--- linux-2.4.19pre7-cleanup/arch/i386/kernel/Makefile	Fri Nov  9 14:21:21 2001
+++ linux-2.4.19pre7-multi2/arch/i386/kernel/Makefile	Tue Apr 23 18:04:28 2002
@@ -29,6 +29,7 @@
 obj-y			+= pci-pc.o pci-irq.o
 endif
 endif
+obj-$(CONFIG_DISCONTIGMEM_X86)	+= core_ibmnumaq.o numa.o
 
 obj-$(CONFIG_MCA)		+= mca.o
 obj-$(CONFIG_MTRR)		+= mtrr.o
--- linux-2.4.19pre7-cleanup/arch/i386/kernel/setup.c	Tue Apr 16 17:32:17 2002
+++ linux-2.4.19pre7-multi2/arch/i386/kernel/setup.c	Tue Apr 23 18:04:28 2002
@@ -115,6 +115,7 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
 /*
  * Machine setup..
  */
@@ -800,20 +801,10 @@
 	}
 }
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
-/*
- * Reserved space for vmalloc and iomap - defined in asm/page.h
- */
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-#define MAX_NONPAE_PFN	(1 << 20)
-
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init find_max_pfn(void)
+unsigned long __init find_max_pfn(void)
 {
 	unsigned long max_pfn;
 	int i;
@@ -838,7 +829,7 @@
 /*
  * Determine low and high memory ranges:
  */
-static unsigned long __init find_max_low_pfn(unsigned long *max_pfn)
+unsigned long __init find_max_low_pfn(unsigned long *max_pfn)
 {
 	unsigned long max_low_pfn;
 
@@ -894,6 +885,7 @@
 	return max_low_pfn;
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 /*
  * Register fully available low RAM pages with the bootmem allocator.
  */
@@ -1015,6 +1007,7 @@
 
 	return max_low_pfn;
 }
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 /*
  * Request address space for all standard RAM and ROM resources
--- linux-2.4.19pre7-cleanup/arch/i386/kernel/core_ibmnumaq.c	Wed Dec 31 
16:00:00 1969
+++ linux-2.4.19pre7-multi2/arch/i386/kernel/core_ibmnumaq.c	Mon Apr 29 
13:39:38 2002
@@ -0,0 +1,140 @@
+/*
+ * Written by: Patricia Gaughen, IBM Corporation
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
+ * Send feedback to <gone@us.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/mmzone.h>
+
+unsigned long long nodes_mem_start[MAX_NUMNODES];
+unsigned long long nodes_mem_size[MAX_NUMNODES];
+
+/*
+ * Function: smp_dump_qct()
+ *
+ * Description: gets memory layout from the quad config table.  This
+ * function also increments numnodes with the number of nodes (quads)
+ * present.
+ */
+static void __init smp_dump_qct(void)
+{
+	int node;
+	struct eachquadmem *eq;
+	struct sys_cfg_data *scd =
+		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
+
+#define	MB_TO_B(addr) ((addr) << 20)
+	numnodes = 0;
+	for(node = 0; node < MAX_NUMNODES; node++) {
+		if(scd->quads_present31_0 & (1 << node)) {
+			numnodes++;
+			eq = &scd->eq[node];
+			/* Convert to bytes */
+			nodes_mem_start[node] = MB_TO_B(eq->hi_shrd_mem_start - eq->priv_mem_size);
+			nodes_mem_size[node] = MB_TO_B(eq->hi_shrd_mem_size + eq->priv_mem_size);
+		}
+	}
+}
+
+/*
+ * -----------------------------------------
+ *
+ * functions related to physnode_map
+ *
+ * -----------------------------------------
+ */
+/*
+ * physnode_map keeps track of the physical memory layout of the
+ * ibmnumaq nodes on a 256Mb break (each element of the array will
+ * represent 256Mb of memory and will be marked by the node id.  so,
+ * if the first gig is on node 0, and the second gig is on node 1
+ * physnode_map will contain:
+ * physnode_map[0-3] = 0;
+ * physnode_map[4-7] = 1;
+ * physnode_map[8- ] = -1;
+ */
+int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+
+#define MB_TO_ELEMENT(x) (x >> ELEMENT_REPRESENTS)
+#define PA_TO_MB(pa) (pa >> 20) 	/* assumption: a physical address is in 
bytes */
+
+int ibmnumaqpa_to_nid(unsigned long long pa)
+{
+	int nid;
+	
+	nid = physnode_map[MB_TO_ELEMENT(PA_TO_MB(pa))];
+
+	/* the physical address passed in is not in the map for the system */
+	if (nid == -1)
+		BUG();
+
+	return nid;
+}
+
+int ibnumaqpfn_to_nid(unsigned long pfn)
+{
+	return ibmnumaqpa_to_nid(pfn << PAGE_SHIFT);
+}
+
+/*
+ * for each node mark the regions
+ *        TOPOFMEM = hi_shrd_mem_start + hi_shrd_mem_size
+ *
+ * need to be very careful to not mark 1024+ as belonging
+ * to node 0. will want 1027 to show as belonging to node 1
+ * example:
+ *  TOPOFMEM = 1024
+ * 1024 >> 8 = 4 (subtract 1 for starting at 0]
+ * tmpvar = TOPOFMEM - 256 = 768
+ * 1024 >> 8 = 4 (subtract 1 for starting at 0]
+ * 
+ */
+static void __init initialize_physnode_map(void)
+{
+	int nid;
+	unsigned int topofmem, cur;
+	struct eachquadmem *eq;
+ 	struct sys_cfg_data *scd =
+		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
+
+	
+	for(nid = 0; nid < numnodes; nid++) {
+		if(scd->quads_present31_0 & (1 << nid)) {
+			eq = &scd->eq[nid];
+			cur = eq->hi_shrd_mem_start;
+			topofmem = eq->hi_shrd_mem_start + eq->hi_shrd_mem_size;
+			while (cur < topofmem) {
+				physnode_map[cur >> 8] = nid;
+				cur += (ELEMENT_REPRESENTS - 1);
+			}
+		}
+	}
+}
+
+void __init get_memcfg_ibmnumaq(void)
+{
+	smp_dump_qct();
+	initialize_physnode_map();
+}
--- linux-2.4.19pre7-cleanup/arch/i386/kernel/numa.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19pre7-multi2/arch/i386/kernel/numa.c	Mon Apr 29 13:43:26 2002
@@ -0,0 +1,331 @@
+/*
+ * Written by: Patricia Gaughen, IBM Corporation
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
+ * Send feedback to <gone@us.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/mmzone.h>
+#include <linux/highmem.h>
+#include <asm/e820.h>
+#include <asm/setup.h>
+
+#ifdef CONFIG_DISCONTIGMEM_X86
+
+struct pfns {
+	unsigned long start_pfn;
+	unsigned long max_pfn;
+};
+
+plat_pg_data_t *plat_node_data[MAX_NUMNODES];
+bootmem_data_t plat_node_bdata;
+struct pfns plat_node_bootpfns[MAX_NUMNODES];
+
+/* extern void get_memcfg_ibmnumaq(void); */
+extern unsigned long find_max_low_pfn(unsigned long *);
+extern unsigned long find_max_pfn(void);
+extern void pagetable_init (void);
+extern void kmap_init(void);
+extern void init_one_highpage(struct page *, int, int);
+extern inline int page_is_ram (unsigned long);
+
+extern unsigned long long nodes_mem_start[], nodes_mem_size[];
+extern struct e820map e820;
+extern char _end;
+extern unsigned long highend_pfn, highstart_pfn;
+extern unsigned long max_low_pfn;
+extern unsigned long totalram_pages;
+extern unsigned long totalhigh_pages;
+
+static void __init find_max_pfn_node(int nid, unsigned long system_max_pfn)
+{
+	unsigned long node_datasz;
+	unsigned long start, end;
+
+	start = plat_node_bootpfns[nid].start_pfn = PFN_UP(nodes_mem_start[nid]);
+	end = PFN_DOWN(nodes_mem_start[nid]) + PFN_DOWN(nodes_mem_size[nid]);
+
+	if (start >= end) {
+		BUG();
+	}
+	if (end > system_max_pfn) {
+		end = system_max_pfn;
+	}
+	plat_node_bootpfns[nid].max_pfn = end;
+
+	node_datasz = PFN_UP(sizeof(plat_pg_data_t));
+	PLAT_NODE_DATA(nid) = (plat_pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+	min_low_pfn += node_datasz;
+}
+
+static void __init register_bootmem_low_pages(unsigned long 
system_max_low_pfn)
+{
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long curr_pfn, last_pfn, size;
+ 		/*
+		 * Reserve usable low memory
+		 */
+		if (e820.map[i].type != E820_RAM)
+			continue;
+		/*
+		 * We are rounding up the start address of usable memory:
+		 */
+		curr_pfn = PFN_UP(e820.map[i].addr);
+		if (curr_pfn >= system_max_low_pfn)
+			continue;
+		/*
+		 * ... and at the end of the usable range downwards:
+		 */
+		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+
+		if (last_pfn > system_max_low_pfn)
+			last_pfn = system_max_low_pfn;
+
+		/*
+		 * .. finally, did all the rounding and playing
+		 * around just make the area go away?
+		 */
+		if (last_pfn <= curr_pfn)
+			continue;
+
+		size = last_pfn - curr_pfn;
+		free_bootmem_node(NODE_DATA(0), PFN_PHYS(curr_pfn), PFN_PHYS(size));
+	}
+}
+
+unsigned long __init setup_memory(void)
+{
+	int nid;
+	unsigned long bootmap_size, system_start_pfn, system_max_low_pfn, 
system_max_pfn;
+
+	get_memcfg_numa();
+
+	/*
+	 * partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	system_start_pfn = min_low_pfn = PFN_UP(__pa(&_end));
+
+	system_max_pfn = find_max_pfn();
+	system_max_low_pfn = max_low_pfn = find_max_low_pfn(&system_max_pfn);
+
+#ifdef CONFIG_HIGHMEM
+		highstart_pfn = highend_pfn = system_max_pfn;
+		if (system_max_pfn > system_max_low_pfn) {
+			highstart_pfn = system_max_low_pfn;
+		}
+		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+		       pages_to_mb(highend_pfn - highstart_pfn));
+#endif
+	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
+			pages_to_mb(system_max_low_pfn));
+	
+	for (nid = 0; nid < numnodes; nid++)
+	{	
+		find_max_pfn_node(nid, system_max_pfn);
+
+	}
+
+	NODE_DATA(0)->bdata = &plat_node_bdata;
+
+	/*
+	 * Initialize the boot-time allocator (with low memory only):
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0, 
system_max_low_pfn);
+
+	register_bootmem_low_pages(system_max_low_pfn);
+
+	/*
+	 * Reserve the bootmem bitmap itself as well. We do this in two
+	 * steps (first step was init_bootmem()) because this catches
+	 * the (very unlikely) case of us accidentally initializing the
+	 * bootmem allocator with an invalid RAM area.
+	 */
+	reserve_bootmem_node(NODE_DATA(0), HIGH_MEMORY, (PFN_PHYS(min_low_pfn) +
+		 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
+
+	/*
+	 * reserve physical page 0 - it's a special BIOS page on many boxes,
+	 * enabling clean reboots, SMP operation, laptop functions.
+	 */
+	reserve_bootmem_node(NODE_DATA(0), 0, PAGE_SIZE);
+
+#ifdef CONFIG_SMP
+	/*
+	 * But first pinch a few for the stack/trampoline stuff
+	 * FIXME: Don't need the extra page at 4K, but need to fix
+	 * trampoline before removing it. (see the GDT stuff)
+	 */
+	reserve_bootmem_node(NODE_DATA(0), PAGE_SIZE, PAGE_SIZE);
+#endif
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * Find and reserve possible boot-time SMP configuration:
+	 */
+	find_smp_config();
+#endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (LOADER_TYPE && INITRD_START) {
+		if (INITRD_START + INITRD_SIZE <= (system_max_low_pfn << PAGE_SHIFT)) {
+			reserve_bootmem(INITRD_START, INITRD_SIZE);
+			initrd_start =
+				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_end = initrd_start+INITRD_SIZE;
+		}
+		else {
+			printk(KERN_ERR "initrd extends beyond end of memory "
+			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			    INITRD_START + INITRD_SIZE,
+			    system_max_low_pfn << PAGE_SHIFT);
+			initrd_start = 0;
+		}
+	}
+#endif
+
+	return system_max_low_pfn;
+}
+
+/*
+ * paging_init() sets up the page tables - note that the first 8MB are
+ * already mapped by head.S.
+ *
+ * This routines also unmaps the page at virtual kernel address 0, so
+ * that we can trap those pesky NULL-reference errors in the kernel.
+ */
+void __init paging_init(void)
+{
+
+	int nid;
+	
+	pagetable_init();
+
+	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+
+#if CONFIG_X86_PAE
+	/*
+	 * We will bail out later - printk doesnt work right now so
+	 * the user would just see a hanging kernel.
+	 */
+	if (cpu_has_pae)
+		set_in_cr4(X86_CR4_PAE);
+#endif
+
+	__flush_tlb_all();
+
+#ifdef CONFIG_HIGHMEM
+	kmap_init();
+#endif
+
+	for (nid = 0; nid < numnodes; nid++) {
+		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+		unsigned int max_dma;
+
+		unsigned long low = max_low_pfn;
+		unsigned long high = plat_node_bootpfns[nid].max_pfn;
+		unsigned long start = plat_node_bootpfns[nid].start_pfn;
+		
+		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+
+		if (start > low) {
+#ifdef CONFIG_HIGHMEM
+		  zones_size[ZONE_HIGHMEM] = high - start;
+#endif
+		} else {
+			if (low < max_dma)
+				zones_size[ZONE_DMA] = low;
+			else {
+				zones_size[ZONE_DMA] = max_dma;
+				zones_size[ZONE_NORMAL] = low - max_dma;
+#ifdef CONFIG_HIGHMEM
+				zones_size[ZONE_HIGHMEM] = high - low;
+#endif
+			}
+		}
+		free_area_init_node(nid, NODE_DATA(nid), 0, zones_size, start << 
PAGE_SHIFT, 0);
+	}
+	return;
+}
+
+
+int __init mem_init_free_pages(int bad_ppro)
+{
+	int reservedpages;
+	int nid;
+	unsigned long pfn;
+
+	/* this will put all low memory onto the freelists */
+	totalram_pages += free_all_bootmem_node(NODE_DATA(0));
+
+	reservedpages = 0;
+	for (pfn = 0; pfn < max_low_pfn; pfn++)
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
+			reservedpages++;
+#ifdef CONFIG_HIGHMEM
+	for (nid = 0; nid < numnodes; nid++) {
+		unsigned long node_pfn, node_high_size, zone_start_pfn;
+		struct page * zone_mem_map;
+		
+		node_high_size = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].size;
+		zone_mem_map = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_mem_map;
+		zone_start_pfn = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_paddr >
> PAGE_SHIFT;
+
+		printk("Initializing highpages for node %d\n", nid);
+		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
+			init_one_highpage((struct page *) (zone_mem_map + node_pfn), 
zone_start_pfn + node_pfn, bad_ppro);
+		}
+	}
+	totalram_pages += totalhigh_pages;
+#endif
+	return reservedpages;
+}
+
+void __init mem_init_set_max_mapnr(void)
+{
+	unsigned long lmax_mapnr;
+	int nid;
+	
+#ifdef CONFIG_HIGHMEM
+	highmem_start_page = mem_map + NODE_DATA(0)->node_zones[ZONE_HIGHMEM].zone_st
art_mapnr;
+	num_physpages = highend_pfn;
+	num_mappedpages = max_low_pfn;
+
+	for (nid = 0; nid < numnodes; nid++) {
+		lmax_mapnr = PLAT_NODE_DATA_STARTNR(nid) + PLAT_NODE_DATA_SIZE(nid);
+		if (lmax_mapnr > max_mapnr) {
+			max_mapnr = lmax_mapnr;
+		}
+	}
+	
+#else
+	max_mapnr = num_mappedpages = num_physpages = max_low_pfn;
+#endif
+}
+#endif /* CONFIG_DISCONTIGMEM_X86 */
--- linux-2.4.19pre7-cleanup/arch/i386/mm/init.c	Thu Apr 18 11:41:10 2002
+++ linux-2.4.19pre7-multi2/arch/i386/mm/init.c	Thu Apr 25 19:05:16 2002
@@ -40,8 +40,8 @@
 
 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
-static unsigned long totalram_pages;
-static unsigned long totalhigh_pages;
+unsigned long totalram_pages;
+unsigned long totalhigh_pages;
 
 int do_check_pgt_cache(int low, int high)
 {
@@ -202,7 +202,7 @@
 	}
 }
 
-static void __init pagetable_init (void)
+void __init pagetable_init (void)
 {
 	unsigned long vaddr, end;
 	pgd_t *pgd, *pgd_base;
@@ -320,6 +320,7 @@
 	flush_tlb_all();
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 /*
  * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
@@ -368,6 +369,7 @@
 	}
 	return;
 }
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 /*
  * Test if the WP bit works in supervisor mode. It isn't supported on 386's
@@ -415,7 +417,7 @@
 	}
 }
 
-static inline int page_is_ram (unsigned long pagenr)
+inline int page_is_ram (unsigned long pagenr)
 {
 	int i;
 
@@ -463,6 +465,7 @@
 	totalhigh_pages++;
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 static int __init mem_init_free_pages(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -489,13 +492,8 @@
 	return reservedpages;
 }
 
-void __init mem_init(void)
+static void __init mem_init_set_max_mapnr(void)
 {
-	int codesize, reservedpages, datasize, initsize;
-
-	if (!mem_map)
-		BUG();
-	
 #ifdef CONFIG_HIGHMEM
 	highmem_start_page = mem_map + highstart_pfn;
 	max_mapnr = num_physpages = highend_pfn;
@@ -503,6 +501,19 @@
 #else
 	max_mapnr = num_mappedpages = num_physpages = max_low_pfn;
 #endif
+}
+
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
+
+void __init mem_init(void)
+{
+	int codesize, reservedpages, datasize, initsize;
+
+	if (!mem_map)
+		BUG();
+	
+	mem_init_set_max_mapnr();
+	
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 	/* clear the zero-page */
--- linux-2.4.19pre7-cleanup/include/asm-i386/page.h	Thu Apr 18 16:23:31 2002
+++ linux-2.4.19pre7-multi2/include/asm-i386/page.h	Mon Apr 29 14:24:47 2002
@@ -131,8 +131,10 @@
 #define MAXMEM			((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
+#ifndef CONFIG_DISCONTIGMEM
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#endif /* !CONFIG_DISCONTIGMEM */
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
--- linux-2.4.19pre7-cleanup/include/asm-i386/io.h	Tue Apr 23 10:44:38 2002
+++ linux-2.4.19pre7-multi2/include/asm-i386/io.h	Mon Apr 29 14:25:07 2002
@@ -100,10 +100,22 @@
  * Change "struct page" to physical address.
  */
 #ifdef CONFIG_HIGHMEM64G
+
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define page_to_phys(page)	((u64)(page - mem_map) << PAGE_SHIFT)
 #else
+#define page_to_phys(page)	(((u64)(page - page_zone(page)->zone_mem_map) << 
PAGE_SHIFT) + page_zone(page)->zone_start_paddr)
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
+
+#else
+
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
-#endif
+#else
+#define page_to_phys(page)	(((page - page_zone(page)->zone_mem_map) << 
PAGE_SHIFT) + page_zone(page)->zone_start_paddr)
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
+
+#endif /* CONFIG_HIGHMEM64G */
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned 
long flags);
 
--- linux-2.4.19pre7-cleanup/include/asm-i386/pgtable.h	Thu Apr 18 16:23:31 
2002
+++ linux-2.4.19pre7-multi2/include/asm-i386/pgtable.h	Mon Apr 29 14:24:47 2002
@@ -297,9 +297,12 @@
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define mk_pte(page, pgprot)	__mk_pte((page) - mem_map, (pgprot))
-
+#else
+#define mk_pte(page, pgprot)	__mk_pte(((page) - page_zone(page)->zone_mem_map 
+ (page_zone(page)->zone_start_paddr >> PAGE_SHIFT)), (pgprot))
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
+ 
 /* This takes a physical page address that is used by the remapping functions 
*/
 #define mk_pte_phys(physpage, pgprot)	__mk_pte((physpage) >> PAGE_SHIFT, 
pgprot)
 
@@ -351,7 +354,10 @@
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define PageSkip(page)		(0)
+
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define kern_addr_valid(addr)	(1)
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 #define io_remap_page_range remap_page_range
 
--- linux-2.4.19pre7-cleanup/include/asm-i386/pgtable-2level.h	Thu Jul 26 
13:40:32 2001
+++ linux-2.4.19pre7-multi2/include/asm-i386/pgtable-2level.h	Mon Apr 29 
14:19:42 2002
@@ -56,7 +56,13 @@
 }
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
+
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define pte_page(x)		(mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
+#else
+#define pte_page(x)		(NODE_MEM_MAP(PHYSADDR_TO_NID((x).pte_low)) + 
PLAT_NODE_DATA_LOCALNR(((unsigned long)((x).pte_low)), 
PHYSADDR_TO_NID((x).pte_low)))
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
+
 #define pte_none(x)		(!(x).pte_low)
 #define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | 
pgprot_val(pgprot))
 
--- linux-2.4.19pre7-cleanup/include/asm-i386/pgtable-3level.h	Thu Jul 26 
13:40:32 2001
+++ linux-2.4.19pre7-multi2/include/asm-i386/pgtable-3level.h	Mon Apr 29 
14:19:42 2002
@@ -86,7 +86,14 @@
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << 
(32 - PAGE_SHIFT))))
+#else
+/* pte_page = lmem_map + nodelocal_pfn */
+#define pte_pfn(x) 	(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - 
PAGE_SHIFT)))
+#define pte_page(x)	(NODE_MEM_MAP(PFN_TO_NID(pte_pfn(x))) + 
PLAT_NODE_DATA_LOCALNR(pte_pfn(x), nid)
+#define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << 
(32 - PAGE_SHIFT))))
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
 
 static inline pte_t __mk_pte(unsigned long page_nr, pgprot_t pgprot)
--- linux-2.4.19pre7-cleanup/include/asm-i386/setup.h	Fri Nov 12 10:12:11 1999
+++ linux-2.4.19pre7-multi2/include/asm-i386/setup.h	Tue Apr 23 18:04:28 2002
@@ -1,10 +1,14 @@
-/*
- *	Just a place holder. We don't want to have to test x86 before
- *	we include stuff
- */
-
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
+#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+/*
+ * Reserved space for vmalloc and iomap - defined in asm/page.h
+ */
+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#define MAX_NONPAE_PFN	(1 << 20)
 
 #endif /* _i386_SETUP_H */
--- linux-2.4.19pre7-cleanup/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19pre7-multi2/include/asm-i386/mmzone.h	Mon Apr 29 14:24:47 2002
@@ -0,0 +1,103 @@
+/*
+ * Written by Pat Gaughen (gone@us.ibm.com) Mar 2002
+ *
+ */
+
+#ifndef _ASM_MMZONE_H_
+#define _ASM_MMZONE_H_
+
+#ifdef CONFIG_DISCONTIGMEM_X86
+
+#ifdef CONFIG_IBMNUMAQ
+#include <asm/core_ibmnumaq.h>
+#else
+#define PHYSADDR_TO_NID(pa)	(0)
+#define PFN_TO_NID(pfn)		(0)
+#define MAX_NUMNODES	1
+#ifdef CONFIG_NUMA
+#define _cpu_to_node(cpu) 0
+#endif /* CONFIG_NUMA */
+#endif /* CONFIG_IBMNUMAQ */
+
+#ifdef CONFIG_NUMA
+#define numa_node_id() _cpu_to_node(smp_processor_id())
+#endif /* CONFIG_NUMA */
+
+typedef struct plat_pglist_data {
+	pg_data_t	gendata;
+} plat_pg_data_t;
+
+extern plat_pg_data_t *plat_node_data[];
+
+/*
+ * Following are macros that are specific to this numa platform.
+ */
+#define reserve_bootmem(addr, size) \
+	reserve_bootmem_node(NODE_DATA(0), (addr), (size))
+#define alloc_bootmem(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, 
__pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_low(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, 0)
+#define alloc_bootmem_pages(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_low_pages(x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
+#define alloc_bootmem_node(ignore, x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, 
__pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_pages_node(ignore, x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
+#define alloc_bootmem_low_pages_node(ignore, x) \
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
+
+#define PLAT_NODE_DATA(n)		(plat_node_data[(n)])
+#define PLAT_NODE_DATA_STARTNR(n)	\
+	(PLAT_NODE_DATA(n)->gendata.node_start_mapnr)
+#define PLAT_NODE_DATA_SIZE(n)		(PLAT_NODE_DATA(n)->gendata.node_size)
+#define PLAT_NODE_DATA_LOCALNR(p, n) \
+	(((p) - PLAT_NODE_DATA(n)->gendata.node_start_paddr) >> PAGE_SHIFT)
+
+/*
+ * Following are macros that each numa implmentation must define.
+ */
+
+/*
+ * Given a kernel address, find the home node of the underlying memory.
+ */
+#define KVADDR_TO_NID(kaddr)	PHYSADDR_TO_NID(__pa(kaddr))
+
+/*
+ * Return a pointer to the node data for node n.
+ */
+#define NODE_DATA(n)	(&((PLAT_NODE_DATA(n))->gendata))
+
+/*
+ * NODE_MEM_MAP gives the kaddr for the mem_map of the node.
+ */
+#define NODE_MEM_MAP(nid)	(NODE_DATA(nid)->node_mem_map)
+
+/*
+ * Given a kaddr, ADDR_TO_MAPBASE finds the owning node of the memory
+ * and returns the the mem_map of that node.
+ */
+#define ADDR_TO_MAPBASE(kaddr) \
+			NODE_MEM_MAP(KVADDR_TO_NID((unsigned long)(kaddr)))
+
+/*
+ * Given a kaddr, LOCAL_BASE_ADDR finds the owning node of the memory
+ * and returns the kaddr corresponding to first physical page in the
+ * node's mem_map.
+ */
+#define LOCAL_BASE_ADDR(kaddr)	((unsigned long)__va(NODE_DATA(KVADDR_TO_NID(ka
ddr))->node_start_paddr))
+
+#define LOCAL_MAP_NR(kvaddr) \
+	(((unsigned long)(kvaddr)-LOCAL_BASE_ADDR(kvaddr)) >> PAGE_SHIFT)
+
+#define kern_addr_valid(kaddr)	test_bit(LOCAL_MAP_NR(kaddr), \
+					 NODE_DATA(KVADDR_TO_NID(kaddr))->valid_addr_bitmap)
+
+#define virt_to_page(kaddr)	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
+/* This does not check the holes between lmem_maps */
+#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
+
+#endif /* CONFIG_DISCONTIGMEM_X86 */
+#endif /* _ASM_MMZONE_H_ */
--- linux-2.4.19pre7-cleanup/include/asm-i386/core_ibmnumaq.h	Wed Dec 31 
16:00:00 1969
+++ linux-2.4.19pre7-multi2/include/asm-i386/core_ibmnumaq.h	Mon Apr 29 
16:11:17 2002
@@ -0,0 +1,179 @@
+/*
+ * Written by: Patricia Gaughen, IBM Corporation
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
+ * Send feedback to <gone@us.ibm.com>
+ */
+
+#ifndef CORE_IBMNUMAQ_H
+#define CORE_IBMNUMAQ_H
+
+#ifdef CONFIG_IBMNUMAQ
+
+#include <asm/smpboot.h>
+
+/*
+ * for now assume that 8Gb is max amount of RAM for whole system
+ *    8Gb * 1024Mb/Gb = 8192 Mb
+ *    8192 Mb / 256Mb = 32
+ */
+#define MAX_ELEMENTS 32
+#define ELEMENT_REPRESENTS 8 /* 256 Mb */
+
+#define PHYSADDR_TO_NID(pa) ibmnumaqpa_to_nid(pa)
+#define PFN_TO_NID(pa) ibmnumaqpfn_to_nid(pa)
+#define MAX_NUMNODES		8
+#ifdef CONFIG_NUMA
+#define _cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+#endif /* CONFIG_NUMA */
+extern int ibmnumaqpa_to_nid(unsigned long long);
+extern int ibmnumaqpfn_to_nid(unsigned long);
+extern void get_memcfg_ibmnumaq(void);
+#define get_memcfg_numa() get_memcfg_ibmnumaq()
+
+/*
+ * SYS_CFG_DATA_PRIV_ADDR, struct eachquadmem, and struct sys_cfg_data are 
the
+ */
+#define SYS_CFG_DATA_PRIV_ADDR		0x0009d000 /* place for scd in private quad 
space */
+
+/*
+ * Communication area for each processor on lynxer-processor tests.
+ *
+ * NOTE: If you change the size of this eachproc structure you need
+ *       to change the definition for EACH_QUAD_SIZE.
+ */
+struct eachquadmem {
+	unsigned int	priv_mem_start;		/* Starting address of this */
+						/* quad's private memory. */
+						/* This is always 0. */
+						/* In MB. */
+	unsigned int	priv_mem_size;		/* Size of this quad's */
+						/* private memory. */
+						/* In MB. */
+	unsigned int	low_shrd_mem_strp_start;/* Starting address of this */
+						/* quad's low shared block */
+						/* (untranslated). */
+						/* In MB. */
+	unsigned int	low_shrd_mem_start;	/* Starting address of this */
+						/* quad's low shared memory */
+						/* (untranslated). */
+						/* In MB. */
+	unsigned int	low_shrd_mem_size;	/* Size of this quad's low */
+						/* shared memory. */
+						/* In MB. */
+	unsigned int	lmmio_copb_start;	/* Starting address of this */
+						/* quad's local memory */
+						/* mapped I/O in the */
+						/* compatibility OPB. */
+						/* In MB. */
+	unsigned int	lmmio_copb_size;	/* Size of this quad's local */
+						/* memory mapped I/O in the */
+						/* compatibility OPB. */
+						/* In MB. */
+	unsigned int	lmmio_nopb_start;	/* Starting address of this */
+						/* quad's local memory */
+						/* mapped I/O in the */
+						/* non-compatibility OPB. */
+						/* In MB. */
+	unsigned int	lmmio_nopb_size;	/* Size of this quad's local */
+						/* memory mapped I/O in the */
+						/* non-compatibility OPB. */
+						/* In MB. */
+	unsigned int	io_apic_0_start;	/* Starting address of I/O */
+						/* APIC 0. */
+	unsigned int	io_apic_0_sz;		/* Size I/O APIC 0. */
+	unsigned int	io_apic_1_start;	/* Starting address of I/O */
+						/* APIC 1. */
+	unsigned int	io_apic_1_sz;		/* Size I/O APIC 1. */
+	unsigned int	hi_shrd_mem_start;	/* Starting address of this */
+						/* quad's high shared memory.*/
+						/* In MB. */
+	unsigned int	hi_shrd_mem_size;	/* Size of this quad's high */
+						/* shared memory. */
+						/* In MB. */
+	unsigned int	mps_table_addr;		/* Address of this quad's */
+						/* MPS tables from BIOS, */
+						/* in system space.*/
+	unsigned int	lcl_MDC_pio_addr;	/* Port-I/O address for */
+						/* local access of MDC. */
+	unsigned int	rmt_MDC_mmpio_addr;	/* MM-Port-I/O address for */
+						/* remote access of MDC. */
+	unsigned int	mm_port_io_start;	/* Starting address of this */
+						/* quad's memory mapped Port */
+						/* I/O space. */
+	unsigned int	mm_port_io_size;	/* Size of this quad's memory*/
+						/* mapped Port I/O space. */
+	unsigned int	mm_rmt_io_apic_start;	/* Starting address of this */
+						/* quad's memory mapped */
+						/* remote I/O APIC space. */
+	unsigned int	mm_rmt_io_apic_size;	/* Size of this quad's memory*/
+						/* mapped remote I/O APIC */
+						/* space. */
+	unsigned int	mm_isa_start;		/* Starting address of this */
+						/* quad's memory mapped ISA */
+						/* space (contains MDC */
+						/* memory space). */
+	unsigned int	mm_isa_size;		/* Size of this quad's memory*/
+						/* mapped ISA space (contains*/
+						/* MDC memory space). */
+	unsigned int	rmt_qmi_addr;		/* Remote addr to access QMI.*/
+	unsigned int	lcl_qmi_addr;		/* Local addr to access QMI. */
+};
+
+/*
+ * Note: This structure must be NOT be changed unless the multiproc and
+ * OS are changed to reflect the new structure.
+ */
+struct sys_cfg_data {
+	unsigned int	quad_id;
+	unsigned int	bsp_proc_id; /* Boot Strap Processor in this quad. */
+	unsigned int	scd_version; /* Version number of this table. */
+	unsigned int	first_quad_id;
+	unsigned int	quads_present31_0; /* 1 bit for each quad */
+	unsigned int	quads_present63_32; /* 1 bit for each quad */
+	unsigned int	config_flags;
+	unsigned int	boot_flags;
+	unsigned int	csr_start_addr; /* Absolute value (not in MB) */
+	unsigned int	csr_size; /* Absolute value (not in MB) */
+	unsigned int	lcl_apic_start_addr; /* Absolute value (not in MB) */
+	unsigned int	lcl_apic_size; /* Absolute value (not in MB) */
+	unsigned int	low_shrd_mem_base; /* 0 or 512MB or 1GB */
+	unsigned int	low_shrd_mem_quad_offset; /* 0,128M,256M,512M,1G */
+					/* may not be totally populated */
+	unsigned int	split_mem_enbl; /* 0 for no low shared memory */ 
+	unsigned int	mmio_sz; /* Size of total system memory mapped I/O */
+				 /* (in MB). */
+	unsigned int	quad_spin_lock; /* Spare location used for quad */
+					/* bringup. */
+	unsigned int	nonzero55; /* For checksumming. */
+	unsigned int	nonzeroaa; /* For checksumming. */
+	unsigned int	scd_magic_number;
+	unsigned int	system_type;
+	unsigned int	checksum;
+	/*
+	 *	memory configuration area for each quad
+	 */
+        struct	eachquadmem eq[MAX_NUMNODES];	/* indexed by quad id */
+};
+
+#endif /* CONFIG_IBMNUMAQ */
+#endif /* CORE_IBNUMAQ_H */
+
--- linux-2.4.19pre7-cleanup/include/linux/bootmem.h	Thu Apr 18 16:24:17 2002
+++ linux-2.4.19pre7-multi2/include/linux/bootmem.h	Mon Apr 29 14:25:07 2002
@@ -31,9 +31,10 @@
 
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
 extern unsigned long __init init_bootmem (unsigned long addr, unsigned long 
memend);
-extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
 extern void * __init __alloc_bootmem (unsigned long size, unsigned long 
align, unsigned long goal);
+#ifndef CONFIG_DISCONTIGMEM_X86
+extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
 	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
@@ -42,6 +43,7 @@
 	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, 0)
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 extern unsigned long __init free_all_bootmem (void);
 
 extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned 
long freepfn, unsigned long startpfn, unsigned long endpfn);
@@ -49,11 +51,13 @@
 extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, 
unsigned long size);
 extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
 extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long 
size, unsigned long align, unsigned long goal);
+#ifndef CONFIG_DISCONTIGMEM_X86
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_pages_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 #endif /* _LINUX_BOOTMEM_H */
--- linux-2.4.19pre7-cleanup/mm/bootmem.c	Fri Dec 21 09:42:04 2001
+++ linux-2.4.19pre7-multi2/mm/bootmem.c	Tue Apr 23 18:04:28 2002
@@ -306,10 +306,12 @@
 	return(init_bootmem_core(&contig_page_data, start, 0, pages));
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 void __init reserve_bootmem (unsigned long addr, unsigned long size)
 {
 	reserve_bootmem_core(contig_page_data.bdata, addr, size);
 }
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 void __init free_bootmem (unsigned long addr, unsigned long size)
 {


