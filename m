Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSHIUwh>; Fri, 9 Aug 2002 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHIUwh>; Fri, 9 Aug 2002 16:52:37 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:9971 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S315870AbSHIUv7>; Fri, 9 Aug 2002 16:51:59 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI_NUMA for SRAT/SLIT table parsing
Date: Fri, 9 Aug 2002 22:55:01 +0200
User-Agent: KMail/1.4.1
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Takayoshi Kouchi <t-kouchi@mvf.biglobe.ne.jp>,
       Tony Luck <tony.luck@intel.com>, David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PRGLNQ40DS60L5DJUYOB"
Message-Id: <200208092255.01201.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_PRGLNQ40DS60L5DJUYOB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The attached patch implements the parsing of the ACPI SRAT (Static
Resource Affinity Table) and SLIT (System Locality Information Table)
which are meanwhile the standard for providing NUMA information on
IA64 platforms and started to spread on IA32, too. The patch consists
of an architecture independent part (posted by Tak Kouchi on the acpi
and discontig mailing lists) and the architecture-dependent functions
used for setting up the NUMA structures needed for initialising and
running discontigmem on IA64. CONFIG_ACPI_NUMA controls the usage of
this path.

The arch-dependent part could well be used by other architectures, too,
which might need SRAT/SLIT tables in near future. It does not depend on
discontigmem any more and can be used separately e.g for setting up the
NUMA tables needed with a config_nonlinear patch or with a NUMA scheduler=
=2E
It is absolutely necessary for the IA64 discontigmem.

I'm interested in comments, opinions, usage on other architectures...
Please consider the inclusion in 2.5.X. A BK changeset against the
latest 2.5.30 which can be "bk received" can be downloaded from
http://home.arcor.de/efocht/disc/acpi_numa-2.5.30.bkpatch

Thanks,
Erich

--------------Boundary-00=_PRGLNQ40DS60L5DJUYOB
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="acpi_numa-2.5.30.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpi_numa-2.5.30.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.470   -> 1.471  
#	include/linux/acpi.h	1.9     -> 1.10   
#	arch/ia64/kernel/setup.c	1.16    -> 1.17   
#	arch/ia64/mm/Makefile	1.1     -> 1.2    
#	include/asm-ia64/acpi.h	1.2     -> 1.3    
#	drivers/acpi/tables.c	1.5     -> 1.6    
#	arch/ia64/kernel/acpi.c	1.12    -> 1.13   
#	drivers/acpi/Config.in	1.5     -> 1.6    
#	               (new)	        -> 1.1     include/asm-ia64/numa.h
#	               (new)	        -> 1.1     arch/ia64/mm/numa.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/09	focht@beast.ess.nec.de	1.471
# Added ACPI SRAT (Static Resource Affinity Table) and SLIT
# (System Locality Information Table) parsing code as suggested
# by Tak Kouchi. Tables are parsed if CONFIG_ACPI_NUMA=y.
# 
# The ACPI SRAT and SLIT parsing routines are actually quite
# arch-independent, but currently this setup is used only on IA64.
# The NUMA related variables touched are:
#  node_memblk : physical memory blocks, node to which they belong
#  node_cpuid : hardware cpu IDs and nodes to which they belong
#  numa_slit : locality matrix with "distances" between nodes.
# 
# This setup is needed for CONFIG_DISCONTIGMEM on IA64 but can be
# used for other NUMA purposes, too.
# --------------------------------------------
#
diff -Nru a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c	Fri Aug  9 17:58:36 2002
+++ b/arch/ia64/kernel/acpi.c	Fri Aug  9 17:58:36 2002
@@ -8,6 +8,9 @@
  *  Copyright (C) 2000 Intel Corp.
  *  Copyright (C) 2000,2001 J.I. Lee <jung-ik.lee@intel.com>
  *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2001 Jenna Hall <jenna.s.hall@intel.com>
+ *  Copyright (C) 2001 Takayoshi Kochi <t-kouchi@cq.jp.nec.com>
+ *  Copyright (C) 2002 Erich Focht <efocht@ess.nec.de>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -43,6 +46,7 @@
 #include <asm/machvec.h>
 #include <asm/page.h>
 #include <asm/system.h>
+#include <asm/numa.h>
 
 
 #define PREFIX			"ACPI: "
@@ -441,6 +445,168 @@
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_NUMA
+
+#define SRAT_DEBUG
+#define SLIT_DEBUG
+
+#define PXM_FLAG_LEN ((MAX_PXM_DOMAINS + 1)/32)
+
+static int __initdata srat_num_cpus = 0;		/* number of cpus */
+static u32 __initdata pxm_flag[PXM_FLAG_LEN] = { [0 ... PXM_FLAG_LEN-1] = 0};
+#define PXM_BIT_SET(bit)	(set_bit(bit,(void *)pxm_flag))
+#define PXM_BIT_CLEAR(bit)	(clear_bit(bit,(void *)pxm_flag))
+#define PXM_BIT_TEST(bit)	(test_bit(bit,(void *)pxm_flag))
+/* maps to convert between proximity domain and logical node ID */
+int pxm_to_nid_map[MAX_PXM_DOMAINS] = { [0 ... MAX_PXM_DOMAINS-1] = -1};
+int nid_to_pxm_map[NR_NODES] = { [0 ... NR_NODES-1] = -1};
+
+/*
+ * ACPI 2.0 SLIT (System Locality Information Table)
+ * http://devresource.hp.com/devresource/Docs/TechPapers/IA64/
+ */
+void __init
+acpi_numa_slit_init (struct acpi_table_slit *slit)
+{
+	int i, j, node_from, node_to;
+	u32 len;
+
+	len = sizeof(struct acpi_table_header) + 8 
+		+ slit->localities * slit->localities;
+	if (slit->header.length != len) {
+		printk("ACPI 2.0 SLIT: size mismatch: %d expected, %d actual\n",
+		      len, slit->header.length);
+		memset(numa_slit, 10, sizeof(numa_slit));
+		return;
+	}
+
+	memset(numa_slit, -1, sizeof(numa_slit));
+	for (i=0; i<slit->localities; i++) {
+		if (!PXM_BIT_TEST(i))
+			continue;
+		node_from = pxm_to_nid_map[i];
+		for (j=0; j<slit->localities; j++) {
+			if (!PXM_BIT_TEST(j))
+				continue;
+			node_to = pxm_to_nid_map[j];
+			node_distance(node_from, node_to) = 
+				slit->entry[i*slit->localities + j];
+		}
+	}
+
+#ifdef SLIT_DEBUG
+	printk("ACPI 2.0 SLIT locality table:\n");
+	for (i = 0; i < numnodes; i++) {
+		for (j = 0; j < numnodes; j++)
+			printk("%03d ", node_distance(i,j));
+		printk("\n");
+	}
+#endif
+}
+
+void __init
+acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa)
+{
+	/* record this node in proximity bitmap */
+	PXM_BIT_SET(pa->proximity_domain);
+
+	node_cpuid[srat_num_cpus].phys_id = (pa->apic_id << 8) | (pa->lsapic_eid);
+	/* nid should be overridden as logical node id later */
+	node_cpuid[srat_num_cpus].nid = pa->proximity_domain;
+	srat_num_cpus++;
+
+#ifdef SRAT_DEBUG
+	printk("CPU %x in proximity domain %x %s\n",
+	       pa->apic_id, pa->proximity_domain,
+	       pa->flags.enabled ? "enabled" : "disabled");
+#endif
+}
+
+void __init
+acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma)
+{
+	unsigned long paddr, size;
+	u8 pxm;
+	struct node_memblk_s *p, *q, *pend;
+
+	pxm = ma->proximity_domain;
+
+	/* record this node in proximity bitmap */
+	PXM_BIT_SET(pxm);
+
+	/* fill node memory chunk structure */
+	paddr = ma->base_addr_hi;
+	paddr = (paddr << 32) | ma->base_addr_lo;
+	size = ma->length_hi;
+	size = (size << 32) | ma->length_lo;
+
+	if (num_memblks >= NR_MEMBLKS) {
+		printk("Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
+			size/(1024*1024), paddr);
+		return;
+	}
+
+	/* Insertion sort based on base address */
+	pend = &node_memblk[num_memblks];
+	for (p = &node_memblk[0]; p < pend; p++) {
+		if (paddr < p->start_paddr)
+			break;
+	}
+	if (p < pend) {
+		for (q = pend; q >= p; q--)
+			*(q + 1) = *q;
+	}
+	p->start_paddr = paddr;
+	p->size = size;
+	p->nid = pxm;
+	num_memblks++;
+
+#ifdef SRAT_DEBUG
+	printk("Memory range 0x%lx to 0x%lx (type %x) in proximity domain %x %s\n",
+	       paddr, paddr + size - 1,
+	       ma->memory_type, ma->proximity_domain,
+	       ma->flags.enabled ? (ma->flags.hot_pluggable ? 
+				    "enabled and removable" : "enabled" )
+	       : "disabled");
+#endif
+}
+
+void __init
+acpi_numa_arch_fixup(void)
+{
+	int i, j;
+
+	/* calculate total number of nodes in system from PXM bitmap */
+	numnodes = 0;		/* init total nodes in system */
+	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
+		if (PXM_BIT_TEST(i)) {
+			pxm_to_nid_map[i] = numnodes;
+			nid_to_pxm_map[numnodes++] = i;
+		}
+	}
+
+	/* set logical node id in memory chunk structure */
+	for (i = 0; i < num_memblks; i++)
+		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
+
+	/* assign memory bank numbers for each chunk on each node */
+	for (i = 0; i < numnodes; i++) {
+		int bank;
+
+		bank = 0;
+		for (j = 0; j < num_memblks; j++)
+			if (node_memblk[j].nid == i)
+				node_memblk[j].bank = bank++;
+	}
+
+	/* set logical node id in cpu structure */
+	for (i = 0; i < srat_num_cpus; i++)
+		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
+
+	printk("Number of logical nodes in system = %d\n", numnodes);
+	printk("Number of memory chunks in system = %d\n", num_memblks);
+}
+#endif /* CONFIG_ACPI_NUMA */
 
 int __init
 acpi_find_rsdp (unsigned long *rsdp_phys)
@@ -528,11 +694,6 @@
 acpi_boot_init (char *cmdline)
 {
 	int result = 0;
-
-	/* Initialize the ACPI boot-time table parser */
-	result = acpi_table_init(cmdline);
-	if (0 != result)
-		return result;
 
 	/*
 	 * MADT
diff -Nru a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c	Fri Aug  9 17:58:36 2002
+++ b/arch/ia64/kernel/setup.c	Fri Aug  9 17:58:36 2002
@@ -297,6 +297,16 @@
 
 	efi_init();
 
+#ifdef CONFIG_ACPI_BOOT
+	/* Initialize the ACPI boot-time table parser */
+	acpi_table_init(*cmdline_p);
+
+#ifdef CONFIG_ACPI_NUMA
+	acpi_numa_init();
+#endif
+
+#endif /* CONFIG_APCI_BOOT */
+
 	find_memory();
 
 #if 0
diff -Nru a/arch/ia64/mm/Makefile b/arch/ia64/mm/Makefile
--- a/arch/ia64/mm/Makefile	Fri Aug  9 17:58:36 2002
+++ b/arch/ia64/mm/Makefile	Fri Aug  9 17:58:36 2002
@@ -10,5 +10,6 @@
 O_TARGET := mm.o
 
 obj-y	 := init.o fault.o tlb.o extable.o
+obj-$(CONFIG_NUMA) += numa.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ia64/mm/numa.c	Fri Aug  9 17:58:36 2002
@@ -0,0 +1,46 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file contains NUMA specific variables and functions which can
+ * be split away from DISCONTIGMEM and are used on NUMA machines with
+ * contiguous memory.
+ * 
+ *                         2002/08/07 Erich Focht <efocht@ess.nec.de>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mmzone.h>
+#include <asm/numa.h>
+
+/*
+ * The following structures are usually initialized by ACPI or
+ * similar mechanisms and describe the NUMA characteristics of the machine.
+ */
+int num_memblks = 0;
+struct node_memblk_s node_memblk[NR_MEMBLKS];
+struct node_cpuid_s node_cpuid[NR_CPUS];
+/*
+ * This is a matrix with "distances" between nodes, they should be
+ * proportional to the memory access latency ratios.
+ */
+u8 numa_slit[NR_NODES * NR_NODES];
+
+/* Identify which cnode a physical address resides on */
+int
+paddr_to_nid(unsigned long paddr)
+{
+	int	i;
+
+	for (i = 0; i < num_memblks; i++)
+		if (paddr >= node_memblk[i].start_paddr &&
+		    paddr < node_memblk[i].start_paddr + node_memblk[i].size)
+			break;
+
+	return (i < num_memblks) ? node_memblk[i].nid : -1;
+}
diff -Nru a/drivers/acpi/Config.in b/drivers/acpi/Config.in
--- a/drivers/acpi/Config.in	Fri Aug  9 17:58:36 2002
+++ b/drivers/acpi/Config.in	Fri Aug  9 17:58:36 2002
@@ -58,6 +58,7 @@
     define_bool CONFIG_ACPI_FAN		n
     define_bool CONFIG_ACPI_PROCESSOR	n
     define_bool CONFIG_ACPI_THERMAL	n
+    define_bool CONFIG_ACPI_NUMA	y
     endmenu
   fi
 
@@ -78,6 +79,9 @@
     tristate     '  Fan'		CONFIG_ACPI_FAN
     tristate     '  Processor'		CONFIG_ACPI_PROCESSOR
     dep_tristate '  Thermal Zone' CONFIG_ACPI_THERMAL $CONFIG_ACPI_PROCESSOR
+    if [ "$CONFIG_NUMA" = "y" ]; then
+       bool         '  NUMA support' 	CONFIG_ACPI_NUMA
+    fi
     bool         '  Debug Statements' 	CONFIG_ACPI_DEBUG
     endmenu
   fi
diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Fri Aug  9 17:58:36 2002
+++ b/drivers/acpi/tables.c	Fri Aug  9 17:58:36 2002
@@ -204,6 +204,47 @@
 }
 
 
+#ifdef CONFIG_ACPI_NUMA
+void
+acpi_table_print_srat_entry (
+	acpi_table_entry_header	*header)
+{
+	if (!header)
+		return;
+
+	switch (header->type) {
+
+	case ACPI_SRAT_PROCESSOR_AFFINITY:
+	{
+		struct acpi_table_processor_affinity *p =
+			(struct acpi_table_processor_affinity*) header;
+		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		       p->apic_id, p->lsapic_eid, p->proximity_domain,
+		       p->flags.enabled?"enabled":"disabled");
+	}
+		break;
+
+	case ACPI_SRAT_MEMORY_AFFINITY:
+	{
+		struct acpi_table_memory_affinity *p =
+			(struct acpi_table_memory_affinity*) header;
+		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
+		       p->memory_type, p->proximity_domain,
+		       p->flags.enabled ? "enabled" : "disabled",
+		       p->flags.hot_pluggable ? " hot-pluggable" : "");
+	}
+		break;
+
+	default:
+		printk(KERN_WARNING PREFIX "Found unsupported SRAT entry (type = 0x%x)\n",
+			header->type);
+		break;
+	}
+}
+#endif /* CONFIG_ACPI_NUMA */
+
+
 static int
 acpi_table_compute_checksum (
 	void			*table_pointer,
@@ -223,12 +264,14 @@
 }
 
 
-int __init
-acpi_table_parse_madt (
+static int __init
+acpi_table_parse_madt_family (
 	enum acpi_table_id	id,
+	unsigned long		madt_size,
+	int			entry_id,
 	acpi_madt_entry_handler	handler)
 {
-	struct acpi_table_madt	*madt = NULL;
+	void			*madt = NULL;
 	acpi_table_entry_header	*entry = NULL;
 	unsigned long		count = 0;
 	unsigned long		madt_end = 0;
@@ -240,19 +283,21 @@
 	/* Locate the MADT (if exists). There should only be one. */
 
 	for (i = 0; i < sdt.count; i++) {
-		if (sdt.entry[i].id != ACPI_APIC)
+		if (sdt.entry[i].id != id)
 			continue;
-		madt = (struct acpi_table_madt *)
+		madt = (void *)
 			__acpi_map_table(sdt.entry[i].pa, sdt.entry[i].size);
 		if (!madt) {
-			printk(KERN_WARNING PREFIX "Unable to map MADT\n");
+			printk(KERN_WARNING PREFIX "Unable to map %s\n",
+			       acpi_table_signatures[id]);
 			return -ENODEV;
 		}
 		break;
 	}
 
 	if (!madt) {
-		printk(KERN_WARNING PREFIX "MADT not present\n");
+		printk(KERN_WARNING PREFIX "%s not present\n",
+		       acpi_table_signatures[id]);
 		return -ENODEV;
 	}
 
@@ -261,10 +306,10 @@
 	/* Parse all entries looking for a match. */
 
 	entry = (acpi_table_entry_header *)
-		((unsigned long) madt + sizeof(struct acpi_table_madt));
+		((unsigned long) madt + madt_size);
 
 	while (((unsigned long) entry) < madt_end) {
-		if (entry->type == id) {
+		if (entry->type == entry_id) {
 			count++;
 			handler(entry);
 		}
@@ -275,6 +320,138 @@
 	return count;
 }
 
+
+int __init
+acpi_table_parse_madt (
+	enum acpi_madt_entry_id	id,
+	acpi_madt_entry_handler	handler)
+{
+	return acpi_table_parse_madt_family(ACPI_APIC, sizeof(struct acpi_table_madt),
+					    id, handler);
+}
+
+
+#ifdef CONFIG_ACPI_NUMA
+static int __init
+acpi_parse_slit (unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_slit	*slit;
+	u32			localities;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	slit = (struct acpi_table_slit *) __va(phys_addr);
+	if (!slit) {
+		printk(KERN_WARNING PREFIX "Unable to map SLIT\n");
+		return -ENODEV;
+	}
+
+	/* downcast just for %llu vs %lu for i386/ia64  */
+	localities = (u32) slit->localities;
+
+	printk(KERN_INFO PREFIX "SLIT localities %ux%u\n", localities, localities);
+
+	acpi_numa_slit_init(slit);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_processor_affinity (acpi_table_entry_header *header)
+{
+	struct acpi_table_processor_affinity *processor_affinity = NULL;
+
+	processor_affinity = (struct acpi_table_processor_affinity*) header;
+	if (!processor_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_processor_affinity_init(processor_affinity);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_memory_affinity (acpi_table_entry_header *header)
+{
+	struct acpi_table_memory_affinity *memory_affinity = NULL;
+
+	memory_affinity = (struct acpi_table_memory_affinity*) header;
+	if (!memory_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_memory_affinity_init(memory_affinity);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_srat (unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_srat	*srat = NULL;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	srat = (struct acpi_table_srat *) __va(phys_addr);
+	if (!srat) {
+		printk(KERN_WARNING PREFIX "Unable to map SRAT\n");
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO PREFIX "SRAT revision %d\n", srat->table_revision);
+
+	return 0;
+}
+
+
+int __init
+acpi_numa_init()
+{
+	int			result;
+
+	/* SRAT: Static Resource Affinity Table */
+	result = acpi_table_parse(ACPI_SRAT, acpi_parse_srat);
+
+	if (result > 0) {
+		result = acpi_table_parse_srat(ACPI_SRAT_PROCESSOR_AFFINITY,
+					       acpi_parse_processor_affinity);
+		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY,
+					       acpi_parse_memory_affinity);
+	} else {
+		/* FIXME */
+		printk("Warning: acpi_table_parse(ACPI_SRAT) returned %d!\n",result);
+	}
+
+	/* SLIT: System Locality Information Table */
+	result = acpi_table_parse(ACPI_SLIT, acpi_parse_slit);
+	if (result < 1) {
+		/* FIXME */
+		printk("Warning: acpi_table_parse(ACPI_SLIT) returned %d!\n",result);
+	}
+	acpi_numa_arch_fixup();
+	return 0;
+}
+
+
+int __init
+acpi_table_parse_srat (
+	enum acpi_srat_entry_id	id,
+	acpi_madt_entry_handler	handler)
+{
+	return acpi_table_parse_madt_family(ACPI_SRAT, sizeof(struct acpi_table_srat),
+					    id, handler);
+}
+#endif /* CONFIG_ACPI_NUMA */
 
 int __init
 acpi_table_parse (
diff -Nru a/include/asm-ia64/acpi.h b/include/asm-ia64/acpi.h
--- a/include/asm-ia64/acpi.h	Fri Aug  9 17:58:36 2002
+++ b/include/asm-ia64/acpi.h	Fri Aug  9 17:58:36 2002
@@ -33,17 +33,17 @@
 #define __acpi_map_table(phys_addr, size) __va(phys_addr)
 
 const char *acpi_get_sysname (void);
-int acpi_boot_init (char *cdline);
 int acpi_find_rsdp (unsigned long *phys_addr);
 int acpi_request_vector (u32 int_type);
 int acpi_get_prt (struct pci_vector_struct **vectors, int *count);
 int acpi_get_interrupt_model(int *type);
 
-#ifdef CONFIG_DISCONTIGMEM
-#define NODE_ARRAY_INDEX(x)	((x) / 8)	/* 8 bits/char */
-#define NODE_ARRAY_OFFSET(x)	((x) % 8)	/* 8 bits/char */
-#define MAX_PXM_DOMAINS		(256)
-#endif /* CONFIG_DISCONTIGMEM */
+#ifdef CONFIG_ACPI_NUMA
+/* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
+#define MAX_PXM_DOMAINS (256)
+extern int pxm_to_nid_map[MAX_PXM_DOMAINS];
+extern int nid_to_pxm_map[NR_NODES];
+#endif
 
 #endif /*__KERNEL__*/
 
diff -Nru a/include/asm-ia64/numa.h b/include/asm-ia64/numa.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ia64/numa.h	Fri Aug  9 17:58:36 2002
@@ -0,0 +1,64 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file contains NUMA specific prototypes and definitions.
+ * 
+ * 2002/08/05 Erich Focht <efocht@ess.nec.de>
+ *
+ */
+#ifndef _ASM_IA64_NUMA_H
+#define _ASM_IA64_NUMA_H
+
+#ifdef CONFIG_NUMA
+
+#ifdef CONFIG_DISCONTIGMEM
+# include <asm/mmzone.h>
+# define NR_NODES     (PLAT_MAX_COMPACT_NODES)
+# define NR_MEMBLKS   (PLAT_MAXCLUMPS)
+#else
+# define NR_NODES     (8)
+# define NR_MEMBLKS   (NR_NODES * 8)
+#endif
+
+/* Stuff below this line could be architecture independent */
+
+extern int num_memblks;		/* total number of memory chunks */
+
+/*
+ * List of node memory chunks. Filled when parsing SRAT table to
+ * obtain information about memory nodes.
+*/
+
+struct node_memblk_s {
+	unsigned long start_paddr;
+	unsigned long size;
+	int nid;		/* which logical node contains this chunk? */
+	int bank;		/* which mem bank on this node */
+};
+
+struct node_cpuid_s {
+	u16	phys_id;	/* id << 8 | eid */
+	int	nid;		/* logical node containing this CPU */
+};
+
+extern struct node_memblk_s node_memblk[NR_MEMBLKS];
+extern struct node_cpuid_s node_cpuid[NR_CPUS];
+
+/*
+ * ACPI 2.0 SLIT (System Locality Information Table)
+ * http://devresource.hp.com/devresource/Docs/TechPapers/IA64/
+ *
+ * This is a matrix with "distances" between nodes, they should be
+ * proportional to the memory access latency ratios.
+ */
+
+extern u8 numa_slit[NR_NODES * NR_NODES];
+#define node_distance(from,to) (numa_slit[from * numnodes + to])
+
+extern int paddr_to_nid(unsigned long paddr);
+
+#endif /* CONFIG_NUMA */
+
+#endif /* _ASM_IA64_NUMA_H */
diff -Nru a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h	Fri Aug  9 17:58:36 2002
+++ b/include/linux/acpi.h	Fri Aug  9 17:58:36 2002
@@ -336,12 +336,21 @@
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
 int acpi_boot_init (char *cmdline);
+int acpi_numa_init (void);
 
 int acpi_table_init (char *cmdline);
 int acpi_table_parse (enum acpi_table_id, acpi_table_handler);
-int acpi_table_parse_madt (enum acpi_table_id, acpi_madt_entry_handler);
+int acpi_table_parse_madt (enum acpi_madt_entry_id, acpi_madt_entry_handler);
+int acpi_table_parse_srat (enum acpi_srat_entry_id, acpi_madt_entry_handler);
 void acpi_table_print (struct acpi_table_header *, unsigned long);
 void acpi_table_print_madt_entry (acpi_table_entry_header *);
+void acpi_table_print_srat_entry (acpi_table_entry_header *);
+
+/* the following four functions are architecture-dependent */
+extern void __init acpi_numa_slit_init (struct acpi_table_slit *slit);
+extern void __init acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa);
+extern void __init acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
+extern void __init acpi_numa_arch_fixup(void);
 
 extern int acpi_mp_config;
 

--------------Boundary-00=_PRGLNQ40DS60L5DJUYOB--

