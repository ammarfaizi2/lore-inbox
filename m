Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311472AbSCNEal>; Wed, 13 Mar 2002 23:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311501AbSCNEa1>; Wed, 13 Mar 2002 23:30:27 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31983 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311472AbSCNEaH>; Wed, 13 Mar 2002 23:30:07 -0500
Message-Id: <200203140427.g2E4RPq23092@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net
Subject: [RFC] discontigmem support for ia32 NUMA box in 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Mar 2002 20:27:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I decided that instead of sitting on this patch forever, that I
should instead make it available for others to have a look at it.
This discontigmem patch boots on an IBM NUMAQ box (thanks Martin for
all your help!).

It has a big hack in it right now that I'm working on resolving.  The
hack is that I'm setting the global mem_map equal to the first node's
local mem_map. (see arch/i386/kernel/numa.c
free_area_init_nodehack()). The correct solution, which I'm working on
now, is to fix all of the users of mem_map (mk_pte(), pte_page()....) 
to use the node's mem_map instead.

Assumptions made:
	- that the first node has at least 900Mb of memory

Still to do:
	- move to 2.5.6 (will be doing tomorrow)

	- write up a set of instructions (and todo list) so that other
	ia32 numa boxes	can reuse this patch.

This patch depends on the patch I sent last week (Subject: [RFC]
modularization of i386 setup_arch and mem_init in 2.4.18 -
http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2) to
lkml.  It is available for download at
http://lse.sf.net/numa/discontig/memalloc-setup-2.4.18

You can also get to the patch I'm including in this email at
http://lse.sf.net/numa/discontig/memalloc-discont-2.4.18

Let me know if you have any comments.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
Linux Technology Center

--- linux-2.4.18-cleanup/arch/i386/config.in	Mon Feb 25 11:37:52 2002
+++ linux-2.4.18-multi/arch/i386/config.in	Fri Mar  8 15:38:46 2002
@@ -196,6 +196,14 @@
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
--- linux-2.4.18-cleanup/arch/i386/kernel/Makefile	Fri Nov  9 14:21:21 2001
+++ linux-2.4.18-multi/arch/i386/kernel/Makefile	Wed Mar  6 15:49:56 2002
@@ -20,7 +20,6 @@
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
 
-
 ifdef CONFIG_PCI
 obj-y			+= pci-i386.o
 ifdef CONFIG_VISWS
@@ -40,5 +39,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_DISCONTIGMEM_X86)	+= core_ibmnumaq.o numa.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.18-cleanup/arch/i386/kernel/setup.c	Sun Mar  3 22:05:39 2002
+++ linux-2.4.18-multi/arch/i386/kernel/setup.c	Tue Mar  5 11:42:22 2002
@@ -830,6 +830,7 @@
 	}
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 /*
  * Register fully available low RAM pages with the bootmem allocator.
  */
@@ -945,6 +946,7 @@
 	}
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 /*
  * Request address space for all standard RAM and ROM resources
--- linux-2.4.18-cleanup/arch/i386/kernel/core_ibmnumaq.c	Wed Dec 31 16:00:00 
1969
+++ linux-2.4.18-multi/arch/i386/kernel/core_ibmnumaq.c	Wed Mar  6 18:02:26 
2002
@@ -0,0 +1,135 @@
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
+unsigned int nodes_mem_start[MAX_NUMNODES];
+unsigned int nodes_mem_size[MAX_NUMNODES];
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
+int ibmnumaqpa_to_nid(unsigned long pa)
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
--- linux-2.4.18-cleanup/arch/i386/kernel/numa.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18-multi/arch/i386/kernel/numa.c	Wed Mar 13 19:53:41 2002
@@ -0,0 +1,342 @@
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
+#include <asm/e820.h>
+#include <asm/setup.h>
+
+#ifdef CONFIG_DISCONTIGMEM_X86
+
+plat_pg_data_t *plat_node_data[MAX_NUMNODES];
+bootmem_data_t plat_node_bdata;
+struct pfns plat_node_bootpfns[MAX_NUMNODES];
+
+extern void get_memcfg_ibmnumaq(void);
+extern void find_max_low_pfn(struct pfns *);
+extern void find_max_pfn(struct pfns *);
+extern void pagetable_init (void);
+extern void kmap_init(void);
+extern void init_one_highpage(struct page *, int, int);
+extern inline int page_is_ram (unsigned long);
+
+extern unsigned int nodes_mem_start[], nodes_mem_size[];
+extern struct e820map e820;
+extern char _end;
+extern unsigned long highend_pfn, highstart_pfn;
+extern unsigned long max_low_pfn;
+extern unsigned long totalram_pages;
+extern unsigned long totalhigh_pages;
+
+static void __init find_max_pfn_node(int nid, unsigned long e820_max_pfn, 
struct pfns *system_bootpfns)
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
+	if (end > e820_max_pfn) {
+		end = e820_max_pfn;
+	}
+	plat_node_bootpfns[nid].max_pfn = end;
+
+	if (end > system_bootpfns->max_pfn)
+		system_bootpfns->max_pfn = end;
+	node_datasz = PFN_UP(sizeof(plat_pg_data_t));
+	PLAT_NODE_DATA(nid) = (plat_pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+	min_low_pfn += node_datasz;
+}
+
+static void __init register_bootmem_low_pages(struct pfns *system_bootpfns)
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
+		if (curr_pfn >= system_bootpfns->max_low_pfn)
+			continue;
+		/*
+		 * ... and at the end of the usable range downwards:
+		 */
+		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+
+		if (last_pfn > system_bootpfns->max_low_pfn)
+			last_pfn = system_bootpfns->max_low_pfn;
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
+void __init setup_memory(struct pfns *system_bootpfns)
+{
+	int nid;
+	unsigned long bootmap_size;
+	struct pfns e820_bootpfns;
+
+	get_memcfg_numa();
+
+	/*
+	 * partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	system_bootpfns->start_pfn = min_low_pfn = PFN_UP(__pa(&_end));
+
+	system_bootpfns->max_pfn = 0;
+
+	find_max_pfn(&e820_bootpfns);
+
+	for (nid = 0; nid < numnodes; nid++)
+	{	
+		find_max_pfn_node(nid, e820_bootpfns.max_pfn, system_bootpfns);
+		find_max_low_pfn(system_bootpfns);
+
+#ifdef CONFIG_HIGHMEM
+		highstart_pfn = highend_pfn = system_bootpfns->max_pfn;
+		if (system_bootpfns->max_pfn > MAXMEM_PFN) {
+			highstart_pfn = MAXMEM_PFN;
+			printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+			       pages_to_mb(highend_pfn - highstart_pfn));
+		}
+#endif
+	}
+
+	NODE_DATA(0)->bdata = &plat_node_bdata;
+	max_low_pfn = system_bootpfns->max_low_pfn;
+
+	/*
+	 * Initialize the boot-time allocator (with low memory only):
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0,
+					 system_bootpfns->max_low_pfn);
+
+	register_bootmem_low_pages(system_bootpfns);
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
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init setup_mem_initrd(struct pfns *system_bootpfns)
+{
+	if (LOADER_TYPE && INITRD_START) {
+		if (INITRD_START + INITRD_SIZE <= (system_bootpfns->max_low_pfn << 
PAGE_SHIFT)) {
+			reserve_bootmem_node(NODE_DATA(0), INITRD_START, INITRD_SIZE);
+			initrd_start =
+				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_end = initrd_start+INITRD_SIZE;
+		}
+		else {
+			printk(KERN_ERR "initrd extends beyond end of memory "
+			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			    INITRD_START + INITRD_SIZE,
+			    system_bootpfns->max_low_pfn << PAGE_SHIFT);
+			initrd_start = 0;
+		}
+	}
+}
+#endif
+
+/***
+ ***
+ *** HACK ALERT!
+ ***
+ ***
+ ***/
+#define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
+
+void __init free_area_init_nodehack(int nid, pg_data_t *pgdat, struct page 
*pmap,
+        unsigned long *zones_size, unsigned long zone_start_paddr,
+        unsigned long *zholes_size)
+{
+        int i, size = 0;
+        struct page *discard;
+
+        if (mem_map == (mem_map_t *)NULL)
+                mem_map = (mem_map_t *)PAGE_OFFSET;
+
+	if (nid == 0) {
+		/* hack */
+		free_area_init_core(nid, pgdat, &mem_map, zones_size, zone_start_paddr,
+					zholes_size, pmap);
+	} else {
+		free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_paddr,
+                                        zholes_size, pmap);
+	}
+	
+        pgdat->node_id = nid;
+
+        /*
+         * Get space for the valid bitmap.
+         */
+        for (i = 0; i < MAX_NR_ZONES; i++)
+                size += zones_size[i];
+        size = LONG_ALIGN((size + 7) >> 3);
+        pgdat->valid_addr_bitmap = (unsigned long *)alloc_bootmem_node(pgdat, 
size);
+        memset(pgdat->valid_addr_bitmap, 0, size);
+}
+/***
+ ***
+ *** END HACK ALERT!
+ ***
+ ***
+ ***/
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
+		free_area_init_nodehack(nid, NODE_DATA(nid), 0, zones_size, start << 
PAGE_SHIFT, 0);
+	}
+	return;
+}
+
+int __init mem_init_free_pages(int bad_ppro)
+{
+	int reservedpages;
+	int nid, tmp;
+	unsigned long start, end;
+
+	/* this will put all low memory onto the freelists */
+	totalram_pages += free_all_bootmem_node(NODE_DATA(0));
+
+	reservedpages = 0;
+	for (tmp = 0; tmp < max_low_pfn; tmp++)
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
+			reservedpages++;
+#ifdef CONFIG_HIGHMEM
+	for (nid = 0; nid < numnodes; nid++) {
+		start = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_mapnr;
+		end = start + NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].size;
+		printk("Initializing highpages for node %d\n", nid);
+		for (tmp = start; tmp < end; tmp++) {
+			init_one_highpage((struct page *) (mem_map + tmp), tmp, bad_ppro);
+		}
+	}
+	totalram_pages += totalhigh_pages;
+#endif
+	return reservedpages;
+}
+
+#endif /* CONFIG_DISCONTIGMEM_X86 */
--- linux-2.4.18-cleanup/arch/i386/mm/init.c	Tue Mar  5 11:52:22 2002
+++ linux-2.4.18-multi/arch/i386/mm/init.c	Tue Mar  5 17:12:22 2002
@@ -40,8 +40,8 @@
 
 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
-static unsigned long totalram_pages;
-static unsigned long totalhigh_pages;
+unsigned long totalram_pages;
+unsigned long totalhigh_pages;
 
 int do_check_pgt_cache(int low, int high)
 {
@@ -205,7 +205,7 @@
 	}
 }
 
-static void __init pagetable_init (void)
+void __init pagetable_init (void)
 {
 	unsigned long vaddr, end;
 	pgd_t *pgd, *pgd_base;
@@ -323,6 +323,7 @@
 	flush_tlb_all();
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 /*
  * paging_init() sets up the page tables - note that the first 8MB are
  * already mapped by head.S.
@@ -371,6 +372,7 @@
 	}
 	return;
 }
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 /*
  * Test if the WP bit works in supervisor mode. It isn't supported on 386's
@@ -418,7 +420,7 @@
 	}
 }
 
-static inline int page_is_ram (unsigned long pagenr)
+inline int page_is_ram (unsigned long pagenr)
 {
 	int i;
 
@@ -466,6 +468,7 @@
 	totalhigh_pages++;
 }
 
+#ifndef CONFIG_DISCONTIGMEM_X86
 static int __init mem_init_free_pages(int bad_ppro)
 {
 	int reservedpages;
@@ -489,6 +492,7 @@
 #endif
 	return reservedpages;
 }
+#endif /* !CONFIG_DISCONTIGMEM_X86 */
 
 void __init mem_init(void)
 {
--- linux-2.4.18-cleanup/include/asm-i386/page.h	Tue Mar  5 12:00:43 2002
+++ linux-2.4.18-multi/include/asm-i386/page.h	Wed Mar 13 19:46:42 2002
@@ -129,8 +129,10 @@
 #define MAXMEM			((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
+#ifndef CONFIG_DISCONTIGMEM
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#endif /* !CONFIG_DISCONTIGMEM */
 
 #endif /* __KERNEL__ */
 
--- linux-2.4.18-cleanup/include/asm-i386/pgtable.h	Tue Mar  5 12:00:43 2002
+++ linux-2.4.18-multi/include/asm-i386/pgtable.h	Wed Mar 13 19:46:42 2002
@@ -354,7 +354,10 @@
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define PageSkip(page)		(0)
+
+#ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
+#endif /* !CONFIG_DISCONTIGMEM */
 
 #define io_remap_page_range remap_page_range
 
--- linux-2.4.18-cleanup/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.18-multi/include/asm-i386/mmzone.h	Wed Mar 13 19:46:42 2002
@@ -0,0 +1,100 @@
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
+#define PHYSADDR_TO_NID(pa)		(0)
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
--- linux-2.4.18-cleanup/include/asm-i386/core_ibmnumaq.h	Wed Dec 31 16:00:00 
1969
+++ linux-2.4.18-multi/include/asm-i386/core_ibmnumaq.h	Wed Mar 13 19:46:42 
2002
@@ -0,0 +1,177 @@
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
+#define MAX_NUMNODES		4
+#ifdef CONFIG_NUMA
+#define _cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+#endif /* CONFIG_NUMA */
+extern int ibmnumaqpa_to_nid(unsigned long);
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
--- linux-2.4.18-cleanup/include/linux/bootmem.h	Tue Mar  5 12:01:47 2002
+++ linux-2.4.18-multi/include/linux/bootmem.h	Wed Mar 13 19:47:25 2002
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
--- linux-2.4.18-cleanup/mm/bootmem.c	Fri Dec 21 09:42:04 2001
+++ linux-2.4.18-multi/mm/bootmem.c	Mon Mar  4 18:15:25 2002
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
--- linux-2.4.18-cleanup/mm/page_alloc.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18-multi/mm/page_alloc.c	Wed Mar 13 19:39:53 2002
@@ -317,6 +317,8 @@
 
 	zone = zonelist->zones;
 	classzone = *zone;
+	if (classzone == NULL)
+		return NULL;
 	min = 1UL << order;
 	for (;;) {
 		zone_t *z = *(zone++);


