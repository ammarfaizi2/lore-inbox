Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUITQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUITQqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUITQpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:45:18 -0400
Received: from fmr03.intel.com ([143.183.121.5]:34183 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266837AbUITQi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:38:29 -0400
Date: Mon, 20 Sep 2004 09:38:19 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Len Brown <len.brown@intel.com>,
       ACPI Developer <acpi-devel@lists.sourceforge.net>
Cc: "Brown, Len" <len.brown@intel.com>,
       ACPI Developer <acpi-devel@lists.sourceforge.net>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
Message-ID: <20040920093819.E14208@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040920092520.A14208@unix-os.sc.intel.com>; from anil.s.keshavamurthy@intel.com on Mon, Sep 20, 2004 at 09:25:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---
Name:acpi_hotplug_arch.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends:	
Version: applies on 2.6.9-rc2	
Description: 
This patch provides the architecture specifice support for mapping lsapic to cpu array.
Currently this supports just IA64. Support for IA32 and x86_64 is in progress
---

 linux-2.6.9-rc2-askeshav/arch/i386/kernel/acpi/boot.c |   22 +++
 linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c      |  127 +++++++++++++++++-
 linux-2.6.9-rc2-askeshav/include/linux/acpi.h         |    6 
 3 files changed, 153 insertions(+), 2 deletions(-)

diff -puN include/linux/acpi.h~acpi_hotplug_arch include/linux/acpi.h
--- linux-2.6.9-rc2/include/linux/acpi.h~acpi_hotplug_arch	2004-09-17 17:56:49.136826616 -0700
+++ linux-2.6.9-rc2-askeshav/include/linux/acpi.h	2004-09-17 17:56:49.231553178 -0700
@@ -396,6 +396,12 @@ void acpi_numa_processor_affinity_init (
 void acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
 void acpi_numa_arch_fixup(void);
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+/* Arch dependent functions for cpu hotplug support */
+int acpi_map_lsapic(acpi_handle handle, int *pcpu);
+int acpi_unmap_lsapic(int cpu);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 extern int acpi_mp_config;
 
 extern u32 pci_mmcfg_base_addr;
diff -puN arch/ia64/kernel/acpi.c~acpi_hotplug_arch arch/ia64/kernel/acpi.c
--- linux-2.6.9-rc2/arch/ia64/kernel/acpi.c~acpi_hotplug_arch	2004-09-17 17:56:49.140732866 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c	2004-09-17 17:56:49.232529740 -0700
@@ -354,11 +354,11 @@ acpi_parse_madt (unsigned long phys_addr
 #define PXM_FLAG_LEN ((MAX_PXM_DOMAINS + 1)/32)
 
 static int __initdata srat_num_cpus;			/* number of cpus */
-static u32 __initdata pxm_flag[PXM_FLAG_LEN];
+static u32 __devinitdata pxm_flag[PXM_FLAG_LEN];
 #define pxm_bit_set(bit)	(set_bit(bit,(void *)pxm_flag))
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
 /* maps to convert between proximity domain and logical node ID */
-int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS];
+int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
 int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
@@ -650,4 +650,127 @@ acpi_gsi_to_irq (u32 gsi, unsigned int *
 	return 0;
 }
 
+/*
+ *  ACPI based hotplug support for CPU
+ */
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+static
+int
+acpi_map_cpu2node(acpi_handle handle, int cpu, long physid)
+{
+#ifdef CONFIG_ACPI_NUMA
+	int 			pxm_id = 0;
+	union acpi_object 	*obj;
+	struct acpi_buffer 	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PXM", NULL, &buffer)))
+		goto pxm_id_0;
+
+	if ((!buffer.length) || (!buffer.pointer))
+		goto pxm_id_0;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		acpi_os_free(buffer.pointer);
+		goto pxm_id_0;
+	}
+
+	pxm_id = obj->integer.value;
+
+pxm_id_0:
+	/*
+	 * Assuming that the container driver would have set the proximity
+	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
+	 */
+
+	/* Return Error if proximity domain is not set */
+	if (!pxm_bit_test(pxm_id))
+		return -EINVAL;
+
+	node_cpuid[cpu].phys_id =  physid;
+	node_cpuid[cpu].nid = pxm_to_nid_map[pxm_id];
+
+#endif
+	return(0);
+}
+
+
+int
+acpi_map_lsapic(acpi_handle handle, int *pcpu)
+{
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	struct acpi_table_lsapic *lsapic;
+	cpumask_t tmp_map;
+	long physid;
+	int cpu;
+ 
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
+		return -EINVAL;
+
+	if (!buffer.length ||  !buffer.pointer)
+		return -EINVAL;
+ 
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*lsapic)) {
+		acpi_os_free(buffer.pointer);
+		return -EINVAL;
+	}
+
+	lsapic = (struct acpi_table_lsapic *)obj->buffer.pointer;
+
+	if ((lsapic->header.type != ACPI_MADT_LSAPIC) ||
+	    (!lsapic->flags.enabled)) {
+		acpi_os_free(buffer.pointer);
+		return -EINVAL;
+	}
+
+	physid = ((lsapic->id <<8) | (lsapic->eid));
+
+	acpi_os_free(buffer.pointer);
+	buffer.length = ACPI_ALLOCATE_BUFFER;
+	buffer.pointer = NULL;
+
+	cpus_complement(tmp_map, cpu_present_map);
+	cpu = first_cpu(tmp_map);
+	if(cpu >= NR_CPUS)
+		return -EINVAL;
+
+	if (ACPI_FAILURE(acpi_map_cpu2node(handle, cpu, physid)))
+	return -ENODEV;
+
+ 	cpu_set(cpu, cpu_present_map);
+	ia64_cpu_to_sapicid[cpu] = physid;
+	ia64_acpiid_to_sapicid[lsapic->acpi_id] = ia64_cpu_to_sapicid[cpu];
+
+	*pcpu = cpu;
+	return(0);
+}
+EXPORT_SYMBOL(acpi_map_lsapic);
+
+
+int
+acpi_unmap_lsapic(int cpu)
+{
+	int i;
+
+	for (i=0; i<MAX_SAPICS; i++) {
+ 		if (ia64_acpiid_to_sapicid[i] == ia64_cpu_to_sapicid[cpu]) {
+ 			ia64_acpiid_to_sapicid[i] = -1;
+ 			break;
+ 		}
+ 	}
+	ia64_cpu_to_sapicid[cpu] = -1;
+	cpu_clear(cpu,cpu_present_map);
+
+#ifdef CONFIG_ACPI_NUMA
+	/* NUMA specific cleanup's */
+#endif
+
+	return(0);
+}
+EXPORT_SYMBOL(acpi_unmap_lsapic);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+ 
 #endif /* CONFIG_ACPI_BOOT */
diff -puN arch/i386/kernel/acpi/boot.c~acpi_hotplug_arch arch/i386/kernel/acpi/boot.c
--- linux-2.6.9-rc2/arch/i386/kernel/acpi/boot.c~acpi_hotplug_arch	2004-09-17 17:56:49.145615679 -0700
+++ linux-2.6.9-rc2-askeshav/arch/i386/kernel/acpi/boot.c	2004-09-17 17:56:49.233506303 -0700
@@ -478,6 +478,28 @@ unsigned int acpi_register_gsi(u32 gsi, 
 }
 EXPORT_SYMBOL(acpi_register_gsi);
 
+/*
+ *  ACPI based hotplug support for CPU
+ */
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+int
+acpi_map_lsapic(acpi_handle handle, int *pcpu)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_map_lsapic);
+
+
+int
+acpi_unmap_lsapic(int cpu)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_unmap_lsapic);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 static unsigned long __init
 acpi_scan_rsdp (
 	unsigned long		start,
_
