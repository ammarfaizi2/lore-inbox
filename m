Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUIXXiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUIXXiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUIXXiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:38:11 -0400
Received: from fmr04.intel.com ([143.183.121.6]:29063 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269063AbUIXXgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:36:44 -0400
Date: Fri, 24 Sep 2004 16:36:32 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Alex Williamson <alex.williamson@hp.com>, anil.s.keshavamurthy@intel.com,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
Message-ID: <20040924163632.C27778@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920093819.E14208@unix-os.sc.intel.com> <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com> <1095864779.6105.3.camel@tdi> <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Thu, Sep 23, 2004 at 02:10:31AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 02:10:31AM +0900, Keiichiro Tokunaga wrote:
> On Wed, 22 Sep 2004 08:52:59 -0600, Alex Williamson wrote:
> > On Wed, 2004-09-22 at 22:15 +0900, Keiichiro Tokunaga wrote:
> > > 
> > > I would like to suggest introducing a new function 'acpi_get_pxm()'
> > > since other drivers might need it in the future.  Acutally, ACPI container
> > > hotplug will be using it soon.
> > > 
> > > Here is a patch creating the function.
> > > 
> > 
> >    Nice, I have a couple I/O locality patches that could be simplified

Here is the revised patch which now fixes the all issues that were discussed.
	- Now defines and uses acpi_get_pxm
	- small bugfix "change __initdata to __devinitdata for pxm_to_nid_map varable


---
Name:acpi_hotplug_arch.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends:	
Version: applies on 2.6.9-rc2	
Description: 
This patch provides the architecture specifice support for mapping lsapic to cpu array.
Currently this supports just IA64. Support for IA32 and x86_64 is in progress
	changes from previous release:
	- Now defines and uses acpi_get_pxm
	- small bugfix "change __initdata to __devinitdata for pxm_to_nid_map varable
---

 linux-2.6.9-rc2-askeshav/arch/i386/kernel/acpi/boot.c |   22 +++
 linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c      |  107 +++++++++++++++++-
 linux-2.6.9-rc2-askeshav/drivers/acpi/numa.c          |   19 +++
 linux-2.6.9-rc2-askeshav/include/linux/acpi.h         |   14 ++
 4 files changed, 159 insertions(+), 3 deletions(-)

diff -puN include/linux/acpi.h~acpi_hotplug_arch include/linux/acpi.h
--- linux-2.6.9-rc2/include/linux/acpi.h~acpi_hotplug_arch	2004-09-24 15:26:23.528942442 -0700
+++ linux-2.6.9-rc2-askeshav/include/linux/acpi.h	2004-09-24 15:26:23.637340879 -0700
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
@@ -471,4 +477,12 @@ static inline int acpi_blacklisted(void)
 
 #endif /*!CONFIG_ACPI_INTERPRETER*/
 
+#ifdef CONFIG_ACPI_NUMA
+int acpi_get_pxm(acpi_handle handle);
+#else
+static inline int acpi_get_pxm(acpi_handle handle)
+{
+	return 0;
+}
+#endif
 #endif /*_LINUX_ACPI_H*/
diff -puN arch/ia64/kernel/acpi.c~acpi_hotplug_arch arch/ia64/kernel/acpi.c
--- linux-2.6.9-rc2/arch/ia64/kernel/acpi.c~acpi_hotplug_arch	2004-09-24 15:26:23.533825255 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c	2004-09-24 15:26:23.639294003 -0700
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
 
@@ -650,4 +650,107 @@ acpi_gsi_to_irq (u32 gsi, unsigned int *
 	return 0;
 }
 
+/*
+ *  ACPI based hotplug CPU support
+ */
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+static
+int
+acpi_map_cpu2node(acpi_handle handle, int cpu, long physid)
+{
+#ifdef CONFIG_ACPI_NUMA
+	int 			pxm_id;
+
+	pxm_id = acpi_get_pxm(handle);
+
+	/*
+	 * Assuming that the container driver would have set the proximity
+	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
+	 */
+	node_cpuid[cpu].nid = (pxm_id < 0) ? 0:
+			pxm_to_nid_map[pxm_id];
+
+	node_cpuid[cpu].phys_id =  physid;
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
+	acpi_map_cpu2node(handle, cpu, physid);
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
--- linux-2.6.9-rc2/arch/i386/kernel/acpi/boot.c~acpi_hotplug_arch	2004-09-24 15:26:23.540661192 -0700
+++ linux-2.6.9-rc2-askeshav/arch/i386/kernel/acpi/boot.c	2004-09-24 15:26:23.640270566 -0700
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
diff -puN drivers/acpi/numa.c~acpi_hotplug_arch drivers/acpi/numa.c
--- linux-2.6.9-rc2/drivers/acpi/numa.c~acpi_hotplug_arch	2004-09-24 15:26:23.546520567 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/numa.c	2004-09-24 15:26:23.640270566 -0700
@@ -22,7 +22,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
-
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -195,3 +195,20 @@ acpi_numa_init()
 	acpi_numa_arch_fixup();
 	return 0;
 }
+
+int
+acpi_get_pxm(acpi_handle handle)
+{
+	unsigned long pxm;
+	acpi_status status;
+	acpi_handle phandle;
+
+	do {
+		status = acpi_evaluate_integer(handle, "_PXM", NULL, &pxm);
+		if (ACPI_SUCCESS(status))
+			return (int)pxm;
+		status = acpi_get_parent(handle, &phandle);
+	} while(ACPI_SUCCESS(status));
+	return -1;
+}
+EXPORT_SYMBOL(acpi_get_pxm);
_
