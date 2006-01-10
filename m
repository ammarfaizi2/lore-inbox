Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWAJMok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWAJMok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWAJMok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:44:40 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:1714 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750810AbWAJMoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:44:39 -0500
Date: Tue, 10 Jan 2006 21:43:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: keith <kmannth@us.ibm.com>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060110201604.38B0.Y-GOTO@jp.fujitsu.com>
References: <1136837348.31043.105.camel@knk> <20060110201604.38B0.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060110214140.38B2.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC, SRAT is just for booting time. So, when hotplug occured,
> it is not reliable. DSDT should be used for it in order to SRAT
> like following 2 patches. 
> First is to get pxm from physical address.
> I'll post the second patch after this post.

Second one is here.
This is map/unmap between pxm to nid. This is just for ia64.
But I guess for x86-64 is not so difference.


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: current_source/arch/ia64/kernel/acpi.c
===================================================================
--- current_source.orig/arch/ia64/kernel/acpi.c	2005-12-27 17:05:19.000000000 +0900
+++ current_source/arch/ia64/kernel/acpi.c	2005-12-27 17:08:18.000000000 +0900
@@ -67,6 +67,7 @@ EXPORT_SYMBOL(pm_power_off);
 
 unsigned char acpi_kbd_controller_present = 1;
 unsigned char acpi_legacy_devices;
+static nodemask_t node_present_map = NODE_MASK_NONE;
 
 static unsigned int __initdata acpi_madt_rev;
 
@@ -408,10 +409,11 @@ static int __init acpi_parse_madt(unsign
 static int __initdata srat_num_cpus;	/* number of cpus */
 static u32 __devinitdata pxm_flag[PXM_FLAG_LEN];
 #define pxm_bit_set(bit)	(set_bit(bit,(void *)pxm_flag))
+#define pxm_bit_clear(bit)	(clear_bit(bit,(void *)pxm_flag))
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
 /* maps to convert between proximity domain and logical node ID */
 int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-int __initdata nid_to_pxm_map[MAX_NUMNODES];
+int __devinitdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
 /*
@@ -447,6 +449,36 @@ acpi_numa_processor_affinity_init(struct
 	srat_num_cpus++;
 }
 
+int __devinit
+acpi_map_pxm_to_nid(int pxm)
+{
+	int nid;
+	nodemask_t tmp_map;
+
+	if (pxm_to_nid_map[pxm] != -1)
+		nid = pxm_to_nid_map[pxm];
+	else {
+		nodes_complement(tmp_map, node_present_map);
+		nid = first_node(tmp_map);
+		pxm_to_nid_map[pxm] = nid;
+		nid_to_pxm_map[nid] = pxm;
+		pxm_bit_set(pxm);
+	}
+
+	set_bit(nid, node_present_map.bits);
+
+	return nid;
+}
+
+void
+acpi_unmap_pxm_to_nid(int nid)
+{
+
+	if ((node_items[nid].num_cpus == 0) &&
+	    (node_items[nid].num_memblks == 0))
+		clear_bit(nid, node_present_map.bits);
+}
+
 void __init
 acpi_numa_memory_affinity_init(struct acpi_table_memory_affinity *ma)
 {
@@ -504,18 +536,19 @@ void __init acpi_numa_arch_fixup(void)
 	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
 	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
 	nodes_clear(node_online_map);
+	nodes_clear(node_present_map);
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
-			int nid = num_online_nodes();
-			pxm_to_nid_map[i] = nid;
-			nid_to_pxm_map[nid] = i;
+			int nid = acpi_map_pxm_to_nid(i);
 			node_set_online(nid);
 		}
 	}
 
 	/* set logical node id in memory chunk structure */
-	for (i = 0; i < num_node_memblks; i++)
+	for (i = 0; i < num_node_memblks; i++) {
 		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
+		node_items[node_memblk[i].nid].num_memblks++;
+	}
 
 	/* assign memory bank numbers for each chunk on each node */
 	for_each_online_node(i) {
@@ -528,8 +561,10 @@ void __init acpi_numa_arch_fixup(void)
 	}
 
 	/* set logical node id in cpu structure */
-	for (i = 0; i < srat_num_cpus; i++)
+	for (i = 0; i < srat_num_cpus; i++) {
 		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
+		node_items[node_cpuid[i].nid].num_cpus++;
+	}
 
 	printk(KERN_INFO "Number of logical nodes in system = %d\n",
 	       num_online_nodes());
@@ -751,16 +786,50 @@ int acpi_map_cpu2node(acpi_handle handle
 	pxm_id = acpi_get_pxm(handle);
 
 	/*
-	 * Assuming that the container driver would have set the proximity
-	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
+	 * Assuming that if at least one processor's PXM < 0, the system does
+	 * not have multiple PXMs.  In this case, there is one PXM and all the
+	 * devices belong to it.
 	 */
-	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_nid_map[pxm_id];
+	if (pxm_id < 0)
+		pxm_id = 0;
+
+	/*
+	 * Container driver might call cpu hotplug driver before memory hot-add.
+	 * So, pxm_to_nid must be mapped here.
+	 */
+	if ((pxm_id >= 0) && (pxm_id < MAX_PXM_DOMAINS)){
+		acpi_map_pxm_to_nid(pxm_id);
+		arch_register_node(pxm_to_nid_map[pxm_id]);
+	}
+
+	node_cpuid[cpu].nid = pxm_to_nid_map[pxm_id];
 
 	node_cpuid[cpu].phys_id = physid;
+	node_items[node_cpuid[cpu].nid].num_cpus++;
 #endif
 	return (0);
 }
 
+static
+void acpi_unmap_cpu2node(int cpu)
+{
+#ifdef CONFIG_ACPI_NUMA
+	int nid;
+	int pxm_id;
+
+	nid = node_cpuid[cpu].nid;
+	pxm_id = nid_to_pxm_map[nid];
+
+	if (node_items[nid].num_cpus > 0)
+		node_items[nid].num_cpus--;
+
+	acpi_unmap_pxm_to_nid(pxm_id);
+
+	node_cpuid[cpu].phys_id = 0;
+	node_cpuid[cpu].nid = 0;
+#endif
+}
+
 int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -828,7 +897,7 @@ int acpi_unmap_lsapic(int cpu)
 	cpu_clear(cpu, cpu_present_map);
 
 #ifdef CONFIG_ACPI_NUMA
-	/* NUMA specific cleanup's */
+	acpi_unmap_cpu2node(cpu);
 #endif
 
 	return (0);
Index: current_source/arch/ia64/mm/numa.c
===================================================================
--- current_source.orig/arch/ia64/mm/numa.c	2005-12-27 17:05:19.000000000 +0900
+++ current_source/arch/ia64/mm/numa.c	2005-12-27 17:08:18.000000000 +0900
@@ -28,6 +28,7 @@
 int num_node_memblks;
 struct node_memblk_s node_memblk[NR_NODE_MEMBLKS];
 struct node_cpuid_s node_cpuid[NR_CPUS];
+struct node_items_s node_items[MAX_NUMNODES];
 /*
  * This is a matrix with "distances" between nodes, they should be
  * proportional to the memory access latency ratios.
Index: current_source/include/asm-ia64/acpi.h
===================================================================
--- current_source.orig/include/asm-ia64/acpi.h	2005-12-27 17:05:19.000000000 +0900
+++ current_source/include/asm-ia64/acpi.h	2005-12-27 17:08:18.000000000 +0900
@@ -111,7 +111,7 @@ extern unsigned int get_cpei_target_cpu(
 /* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
 #define MAX_PXM_DOMAINS (256)
 extern int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
+extern int __devinitdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
 extern u16 ia64_acpiid_to_sapicid[];
Index: current_source/include/asm-ia64/numa.h
===================================================================
--- current_source.orig/include/asm-ia64/numa.h	2005-12-27 17:05:19.000000000 +0900
+++ current_source/include/asm-ia64/numa.h	2005-12-27 18:44:16.000000000 +0900
@@ -47,8 +47,14 @@ struct node_cpuid_s {
 	int	nid;		/* logical node containing this CPU */
 };
 
+struct node_items_s {
+	int num_cpus;		/* total num of cpus in a node */
+	int num_memblks;	/* total num of memblks in a node */
+};
+
 extern struct node_memblk_s node_memblk[NR_NODE_MEMBLKS];
 extern struct node_cpuid_s node_cpuid[NR_CPUS];
+extern struct node_items_s node_items[MAX_NUMNODES];
 
 /*
  * ACPI 2.0 SLIT (System Locality Information Table)
@@ -68,11 +74,17 @@ extern int paddr_to_nid(unsigned long pa
 extern int acpi_search_node_id(u64, u64);
 #define firmware_phys_to_nid(start_addr, size) acpi_search_node_id(start_addr, size)
 
+extern int acpi_map_pxm_to_nid(int);
+extern void acpi_unmap_pxm_to_nid(int);
+#define arch_release_node_id(nid) acpi_unmap_pxm_to_nid(nid)
+
 #else /* !CONFIG_NUMA */
 
 #define paddr_to_nid(addr)	0
 #define firmware_phys_to_nid(start_addr, size)   0
 
+#define acpi_map_pxm_to_nid(pxm) 0
+#define acpi_unmap_pxm_to_nid(pxm) {}
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_IA64_NUMA_H */

-- 
Yasunori Goto 


