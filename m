Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTBFHDp>; Thu, 6 Feb 2003 02:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBFHDp>; Thu, 6 Feb 2003 02:03:45 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24981 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265603AbTBFHDg>;
	Thu, 6 Feb 2003 02:03:36 -0500
Message-Id: <200302060710.h167Alf02508@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: chandra.sekharan@us.ibm.com, cleverdj@us.ibm.com, johnstul@us.ibm.com
Subject: [PATCH][RFC] Discontigmem support for the x440 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Feb 2003 23:10:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides discontigmem support for the IBM x440.  This code has 
passed through the hands of several developers:  Chandra Seetharaman, James 
Cleverdon, John Stultz, and last to touch it, me :-)  This patch requires full 
acpi support.

I've tested this patch on an 8 way x440 16 GB of RAM with and without HT 
(acpi=off).

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Wed Feb  5 19:15:58 2003
+++ b/arch/i386/Kconfig	Wed Feb  5 19:15:58 2003
@@ -474,7 +474,7 @@
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
-	depends on X86_NUMAQ
+	depends on (X86_NUMAQ || X86_SUMMIT)
 
 config DISCONTIGMEM
 	bool
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Wed Feb  5 19:15:58 2003
+++ b/arch/i386/kernel/Makefile	Wed Feb  5 19:15:58 2003
@@ -31,6 +31,9 @@
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o
+ifdef CONFIG_NUMA
+obj-$(CONFIG_X86_SUMMIT) 	+= srat.o
+endif
 
 EXTRA_AFLAGS   := -traditional
 
diff -Nru a/arch/i386/kernel/srat.c b/arch/i386/kernel/srat.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/srat.c	Wed Feb  5 19:15:58 2003
@@ -0,0 +1,411 @@
+/*
+ * Some of the code in this file has been gleaned from the 64 bit 
+ * discontigmem support code base.
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
+ * Send feedback to Pat Gaughen <gone@us.ibm.com>
+ */
+
+/*
+ * ACPI 2.0 SRAT Table
+ * http://www.microsoft.com/HWDEV/design/SRAT.htm
+ * Processor and Memory affinity information
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/mmzone.h>
+#include <linux/acpi.h>
+#include <asm/tlbflush.h>
+#include <asm/srat.h>
+
+#define NUM_KLUDGE_PAGES	4	/* Size of page descriptor kludge */
+#define PAGE_KLUDGE_START	((u32 *)empty_zero_page - NUM_KLUDGE_PAGES)
+
+/*
+ * proximity macros and definitions
+ */
+#define NODE_ARRAY_INDEX(x)	((x) / 8)	/* 8 bits/char */
+#define NODE_ARRAY_OFFSET(x)	((x) % 8)	/* 8 bits/char */
+#define BMAP_SET(bmap, bit)	((bmap)[NODE_ARRAY_INDEX(bit)] |= 1 << 
NODE_ARRAY_OFFSET(bit))
+#define BMAP_TEST(bmap, bit)	((bmap)[NODE_ARRAY_INDEX(bit)] & (1 << 
NODE_ARRAY_OFFSET(bit)))
+#define MAX_PXM_DOMAINS		256	/* 1 byte and no promises about values */
+/* bitmap length; _PXM is at most 255 */
+#define PXM_BITMAP_LEN (MAX_PXM_DOMAINS / 8) 
+static u8 pxm_bitmap[PXM_BITMAP_LEN];	/* bitmap of proximity domains */
+
+struct node_memory_chunk_s node_memory_chunk[MAXCLUMPS];
+
+static int num_memory_chunks;		/* total number of memory chunks */
+static unsigned long zholes_size[MAX_NUMNODES];
+
+unsigned long node_start_pfn[MAX_NUMNODES];
+unsigned long node_end_pfn[MAX_NUMNODES];
+
+/* extern unsigned char acpi_checksum(void *buffer, int length); */
+
+/* Identify which cnode a physical address resides on */
+int pfn_to_nid(unsigned long pfn)
+{
+	int	i;
+	struct node_memory_chunk_s *nmcp;
+
+	/* We've got a sorted list.  Binary search here?  Do we care?? */
+	nmcp = node_memory_chunk;
+	for (i = num_memory_chunks; --i >= 0; nmcp++)
+		if (pfn >= nmcp->start_pfn && pfn <= nmcp->end_pfn)
+			return (int)nmcp->nid;
+
+	return -1;
+}
+
+/* Identify CPU proximity domains */
+
+static void __init parse_cpu_affinity_structure(char *p)
+{
+	struct acpi_table_processor_affinity *cpu_affinity = 
+				(struct acpi_table_processor_affinity *) p;
+
+	if (!cpu_affinity->flags.enabled)
+		return;		/* empty entry */
+
+	/* mark this node as "seen" in node bitmap */
+	BMAP_SET(pxm_bitmap, cpu_affinity->proximity_domain);
+
+	printk("CPU 0x%02X in proximity domain 0x%02X\n",
+		cpu_affinity->apic_id, cpu_affinity->proximity_domain);
+}
+
+/*
+ * Identify memory proximity domains and hot-remove capabilities.
+ * Fill node memory chunk list structure.
+ */
+
+static void __init parse_memory_affinity_structure (char *sratp)
+{
+	unsigned long long paddr, size;
+	unsigned long start_pfn, end_pfn; 
+	u8 pxm;
+	struct node_memory_chunk_s *p, *q, *pend;
+	struct acpi_table_memory_affinity *memory_affinity =
+			(struct acpi_table_memory_affinity *) sratp;
+
+	if (!memory_affinity->flags.enabled)
+		return;		/* empty entry */
+
+	/* mark this node as "seen" in node bitmap */
+	BMAP_SET(pxm_bitmap, memory_affinity->proximity_domain);
+
+	/* calculate info for memory chunk structure */
+	paddr = memory_affinity->base_addr_hi;
+	paddr = (paddr << 32) | memory_affinity->base_addr_lo;
+	size = memory_affinity->length_hi;
+	size = (size << 32) | memory_affinity->length_lo;
+	
+	start_pfn = paddr >> PAGE_SHIFT;
+	end_pfn = (paddr + size) >> PAGE_SHIFT;
+	
+	pxm = memory_affinity->proximity_domain;
+
+	if (num_memory_chunks >= MAXCLUMPS) {
+		printk("Too many mem chunks in SRAT. Ignoring %lld MBytes at %llx\n",
+			size/(1024*1024), paddr);
+		return;
+	}
+
+	/* Insertion sort based on base address */
+	pend = &node_memory_chunk[num_memory_chunks];
+	for (p = &node_memory_chunk[0]; p < pend; p++) {
+		if (start_pfn < p->start_pfn)
+			break;
+	}
+	if (p < pend) {
+		for (q = pend; q >= p; q--)
+			*(q + 1) = *q;
+	}
+	p->start_pfn = start_pfn;
+	p->end_pfn = end_pfn;
+	p->pxm = pxm;
+
+	num_memory_chunks++;
+
+
+	printk("Memory range 0x%lX to 0x%lX (type 0x%X) in proximity domain 0x%02X 
%s\n",
+		start_pfn, end_pfn,
+		memory_affinity->memory_type,
+		memory_affinity->proximity_domain,
+		(memory_affinity->flags.hot_pluggable ?
+		 "enabled and removable" : "enabled" ) );
+}
+
+
+/* Parse the ACPI Static Resource Affinity Table */
+static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
+{
+	u8 *start, *end, *p;
+	int i, j, nid;
+	u8 pxm_to_nid_map[MAX_PXM_DOMAINS];/* _PXM to logical node ID map */
+	u8 nid_to_pxm_map[MAX_NUMNODES];/* logical node ID to _PXM map */
+
+	start = (u8 *)(&(sratp->reserved) + 1);	/* skip header */
+	p = start;
+	end = (u8 *)sratp + sratp->header.length;
+
+	memset(pxm_bitmap, 0, sizeof(pxm_bitmap));	/* init proximity domain bitmap */
+	memset(node_memory_chunk, 0, sizeof(node_memory_chunk));
+	memset(zholes_size, 0, sizeof(zholes_size));
+
+	/* -1 in these maps means not available */
+	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
+	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
+
+	num_memory_chunks = 0;
+	while (p < end) {
+		switch (*p) {
+		case ACPI_SRAT_PROCESSOR_AFFINITY:
+			parse_cpu_affinity_structure(p);
+			break;
+		case ACPI_SRAT_MEMORY_AFFINITY:
+			parse_memory_affinity_structure(p);
+			break;
+		default:
+			printk("ACPI 2.0 SRAT: unknown entry skipped: type=0x%02X, len=%d\n", 
p[0], p[1]);
+			break;
+		}
+		p += p[1];
+		if (p[1] == 0) {
+			printk("acpi20_parse_srat: Entry length value is zero;"
+				" can't parse any further!\n");
+			break;
+		}
+	}
+
+	/* Calculate total number of nodes in system from PXM bitmap and create
+	 * a set of sequential node IDs starting at zero.  (ACPI doesn't seem
+	 * to specify the range of _PXM values.)
+	 */
+	numnodes = 0;		/* init total nodes in system */
+	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
+		if (BMAP_TEST(pxm_bitmap, i)) {
+			pxm_to_nid_map[i] = numnodes;
+			nid_to_pxm_map[numnodes] = i;
+			node_set_online(numnodes);
+			++numnodes;
+		}
+	}
+
+	if (numnodes == 0)
+		BUG();
+
+	/* set cnode id in memory chunk structure */
+	for (i = 0; i < num_memory_chunks; i++)
+		node_memory_chunk[i].nid = pxm_to_nid_map[node_memory_chunk[i].pxm];
+
+	printk("pxm bitmap: ");
+	for (i = 0; i < sizeof(pxm_bitmap); i++) {
+		printk("%02X ", pxm_bitmap[i]);
+	}
+	printk("\n");
+	printk("Number of logical nodes in system = %d\n", numnodes);
+	printk("Number of memory chunks in system = %d\n", num_memory_chunks);
+
+	for (j = 0; j < num_memory_chunks; j++){
+		printk("chunk %d nid %d start_pfn %08lx end_pfn %08lx\n",
+		       j, node_memory_chunk[j].nid,
+		       node_memory_chunk[j].start_pfn,
+		       node_memory_chunk[j].end_pfn);
+	}
+ 
+	/*calculate node_start_pfn/node_end_pfn arrays*/
+	for (nid = 0; nid < numnodes; nid++) {
+		int been_here_before = 0;
+
+		for (j = 0; j < num_memory_chunks; j++){
+			if (node_memory_chunk[j].nid == nid) {
+				if (been_here_before == 0) {
+					node_start_pfn[nid] = node_memory_chunk[j].start_pfn;
+					node_end_pfn[nid] = node_memory_chunk[j].end_pfn;
+					been_here_before = 1;
+				} else { /* We've found another chunk of memory for the node */
+					if (node_start_pfn[nid] < node_memory_chunk[j].start_pfn) {
+						printk("found a another chunk on nid %d, chunk %d\n", nid, j);
+
+						zholes_size[nid] = zholes_size[nid] +
+							(node_memory_chunk[j].start_pfn
+							 - node_end_pfn[nid]);
+						node_end_pfn[nid] = node_memory_chunk[j].end_pfn;
+					}
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+#define kludge_to_virt(idx) \
+	(PAGE_SIZE * ((unsigned long)((u32 *)empty_zero_page - (u32 *)pg0) - \
+         NUM_KLUDGE_PAGES + (unsigned long)(idx)) )
+
+#define pde_kludge(idx, phys) \
+	(PAGE_KLUDGE_START[idx] = ((phys) & ~(PAGE_SIZE - 1)) | \
+        (_PAGE_PRESENT | _PAGE_USER | _PAGE_DIRTY | _PAGE_ACCESSED))
+
+/*
+ * Temporarily use the virtual area starting from PAGE_KLUDGE_START,
+ * to map the target physical address.  By using this area, we can
+ * map up to NUM_KLUDGE_PAGES pages temporarily, i.e. until the next
+ * page_kludge() call.
+ */
+static __init void * page_kludge(unsigned long phys, unsigned long size)
+{
+	unsigned long base, offset, mapped_size;
+	int idx;
+
+	offset = phys & (PAGE_SIZE - 1);
+	mapped_size = PAGE_SIZE - offset;
+	pde_kludge(0, phys);
+	base = kludge_to_virt(0);
+	__flush_tlb_one(base);
+	wbinvd();
+
+	printk("page_kludge(0x%lx, 0x%lx): idx=%d mapped at %lx\n", phys, size,
+		FIX_IO_APIC_BASE_END, base);
+
+	/*
+	 * Most cases can be covered by the below.
+	 */
+	idx = 0;
+	while (mapped_size < size) {
+		if (idx >= NUM_KLUDGE_PAGES)
+			return NULL;	/* cannot handle this */
+		phys += PAGE_SIZE;
+		pde_kludge(idx, phys);
+		__flush_tlb_one(kludge_to_virt(idx));
+		mapped_size += PAGE_SIZE;
+		++idx;
+	}
+
+	return((void *)(base + offset));
+}
+
+
+void __init get_memcfg_from_srat(void)
+{
+	struct acpi_table_header *header = NULL;
+	struct acpi_table_rsdp *rsdp = NULL;
+	struct acpi_table_rsdt *rsdt = NULL;
+	struct acpi_pointer *rsdp_address = NULL;
+	struct acpi_table_rsdt saved_rsdt;
+	int tables = 0;
+	int i = 0;
+	u32 pde_save[NUM_KLUDGE_PAGES];
+
+	acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING, rsdp_address);
+
+	if (rsdp_address->pointer_type == ACPI_PHYSICAL_POINTER) {
+		printk("%s: assigning address to rsdp\n", __FUNCTION__);
+		rsdp = (struct acpi_table_rsdp *)rsdp_address->pointer.physical;
+	} else {
+		printk("%s: rsdp_address is not a physical pointer\n", __FUNCTION__);
+		return;
+	}
+	if (!rsdp) {
+		printk("%s: Didn't find ACPI root!\n", __FUNCTION__);
+		return;
+	}
+
+	printk(KERN_INFO "%.8s v%d [%.6s]\n", rsdp->signature, rsdp->revision,
+		rsdp->oem_id);
+
+	if (strncmp(rsdp->signature, RSDP_SIG,strlen(RSDP_SIG))) {
+		printk(KERN_WARNING "%s: RSDP table signature incorrect\n", __FUNCTION__);
+		return;
+	}
+
+	rsdt = (struct acpi_table_rsdt *)
+	    page_kludge(rsdp->rsdt_address, sizeof(struct acpi_table_rsdt));
+
+	if (!rsdt) {
+		printk(KERN_WARNING
+		       "%s: ACPI: Invalid root system description tables (RSDT)\n",
+		       __FUNCTION__);
+		return;
+	}
+
+	header = & rsdt->header;
+
+	if (strncmp(header->signature, RSDT_SIG, strlen(RSDT_SIG))) {
+		printk(KERN_WARNING "ACPI: RSDT signature incorrect\n");
+		return;
+	}
+
+	/* 
+	 * The number of tables is computed by taking the 
+	 * size of all entries (header size minus total 
+	 * size of RSDT) divided by the size of each entry
+	 * (4-byte table pointers).
+	 */
+	tables = (header->length - sizeof(struct acpi_table_header)) / 4;
+
+	memcpy(&saved_rsdt, rsdt, sizeof(saved_rsdt));
+
+	if (saved_rsdt.header.length > sizeof(saved_rsdt)) {
+		printk(KERN_WARNING "ACPI: Too big length in RSDT: %d\n",
+		       saved_rsdt.header.length);
+		return;
+	}
+
+printk("Begin table scan....\n");
+	memcpy(pde_save, PAGE_KLUDGE_START, sizeof(pde_save));
+
+	for (i = 0; i < tables; i++) {
+		/* Map in header, then map in full table length. */
+		header = (struct acpi_table_header *)
+			page_kludge(saved_rsdt.entry[i], sizeof(struct acpi_table_header));
+		if (!header)
+			break;
+		header = (struct acpi_table_header *)
+			page_kludge(saved_rsdt.entry[i], header->length);
+		if (!header)
+			break;
+
+		if (strncmp((char *) &header->signature, "SRAT", 4))
+			continue;
+		acpi20_parse_srat((struct acpi_table_srat *)header);
+		goto out;
+	}
+
+	printk("get_memcfg_from_srat:  no SRAT found!\n");
+ out:
+	/* Undo page kludge. */
+	memcpy(PAGE_KLUDGE_START, pde_save, sizeof(pde_save));
+	__flush_tlb();
+	wbinvd();
+}
+
+unsigned long __init get_zholes_size(int nid)
+{
+	if((nid >= numnodes) | (nid >= MAX_NUMNODES))
+		printk("%s: nid = %d is invalid. numnodes = %d",
+		       __FUNCTION__, nid, numnodes);
+	return zholes_size[nid];
+}
diff -Nru a/arch/i386/mm/discontig.c b/arch/i386/mm/discontig.c
--- a/arch/i386/mm/discontig.c	Wed Feb  5 19:15:58 2003
+++ b/arch/i386/mm/discontig.c	Wed Feb  5 19:15:58 2003
@@ -284,6 +284,7 @@
 
 	for (nid = 0; nid < numnodes; nid++) {
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+		unsigned long zholes_size;
 		unsigned int max_dma;
 
 		unsigned long low = max_low_pfn;
@@ -307,6 +308,7 @@
 #endif
 			}
 		}
+		zholes_size = get_zholes_size(nid);
 		/*
 		 * We let the lmem_map for node 0 be allocated from the
 		 * normal bootmem allocator, but other nodes come from the
@@ -315,10 +317,10 @@
 		if (nid)
 			free_area_init_node(nid, NODE_DATA(nid), 
 				node_remap_start_vaddr[nid], zones_size, 
-				start, 0);
+				start, (unsigned long *)zholes_size);
 		else
 			free_area_init_node(nid, NODE_DATA(nid), 0, 
-				zones_size, start, 0);
+				zones_size, start, (unsigned long *)zholes_size);
 	}
 	return;
 }
diff -Nru a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
--- a/drivers/acpi/events/evevent.c	Wed Feb  5 19:15:58 2003
+++ b/drivers/acpi/events/evevent.c	Wed Feb  5 19:15:58 2003
@@ -104,6 +104,7 @@
 
 	ACPI_FUNCTION_TRACE ("ev_handler_initialize");
 
+	return_ACPI_STATUS (0);
 
 	/* Install the SCI handler */
 
diff -Nru a/include/asm-i386/mmzone.h b/include/asm-i386/mmzone.h
--- a/include/asm-i386/mmzone.h	Wed Feb  5 19:15:58 2003
+++ b/include/asm-i386/mmzone.h	Wed Feb  5 19:15:58 2003
@@ -12,6 +12,8 @@
 
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
+#elif CONFIG_X86_SUMMIT
+#include <asm/srat.h>
 #else
 #define pfn_to_nid(pfn)		(0)
 #endif /* CONFIG_X86_NUMAQ */
diff -Nru a/include/asm-i386/numaq.h b/include/asm-i386/numaq.h
--- a/include/asm-i386/numaq.h	Wed Feb  5 19:15:58 2003
+++ b/include/asm-i386/numaq.h	Wed Feb  5 19:15:58 2003
@@ -168,6 +168,10 @@
         struct	eachquadmem eq[MAX_NUMNODES];	/* indexed by quad id */
 };
 
+static inline unsigned long get_zholes_size(int nid)
+{
+	return 0;
+}
 #endif /* CONFIG_X86_NUMAQ */
 #endif /* NUMAQ_H */
 
diff -Nru a/include/asm-i386/numnodes.h b/include/asm-i386/numnodes.h
--- a/include/asm-i386/numnodes.h	Wed Feb  5 19:15:58 2003
+++ b/include/asm-i386/numnodes.h	Wed Feb  5 19:15:58 2003
@@ -5,6 +5,8 @@
 
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
+#elif CONFIG_X86_SUMMIT
+#include <asm/srat.h>
 #else
 #define MAX_NUMNODES	1
 #endif /* CONFIG_X86_NUMAQ */
diff -Nru a/include/asm-i386/srat.h b/include/asm-i386/srat.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/srat.h	Wed Feb  5 19:15:58 2003
@@ -0,0 +1,52 @@
+/*
+ * Some of the code in this file has been gleaned from the 64 bit 
+ * discontigmem support code base.
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
+ * Send feedback to Pat Gaughen <gone@us.ibm.com>
+ */
+
+#ifndef _ASM_SRAT_H_
+#define _ASM_SRAT_H_
+
+#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
+#define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
+#define MAX_NUMNODES		8
+#define MAX_CLUMPS_PER_NODE	4
+#define MAXCLUMPS		(MAX_CLUMPS_PER_NODE * MAX_NUMNODES)
+extern int pfn_to_nid(unsigned long);
+extern void get_memcfg_from_srat(void);
+extern unsigned long get_zholes_size(int);
+#define get_memcfg_numa() get_memcfg_from_srat()
+
+/*
+ * memory -> pxm_domain structure
+ */
+struct node_memory_chunk_s {
+	unsigned long	start_pfn;
+	unsigned long	end_pfn;
+	u8	pxm;		// proximity domain of node
+	u8	nid;		// which cnode contains this chunk?
+	u8	bank;		// which mem bank on this node
+};
+extern struct node_memory_chunk_s node_memory_chunk[];
+
+#endif /* _ASM_SRAT_H_ */
diff -Nru a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h	Wed Feb  5 19:15:58 2003
+++ b/include/linux/acpi.h	Wed Feb  5 19:15:58 2003
@@ -82,7 +82,7 @@
 
 struct acpi_table_rsdt {
 	struct acpi_table_header header;
-	u32			entry[1];
+	u32			entry[8];
 } __attribute__ ((packed));
 
 /* Extended System Description Table (XSDT) */




