Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUI0Us2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUI0Us2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUI0Ure
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:47:34 -0400
Received: from fmr04.intel.com ([143.183.121.6]:36060 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S267358AbUI0Uoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:44:30 -0400
Date: Mon, 27 Sep 2004 13:44:12 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       Len Brown <len.brown@intel.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       alex.williamson@hp.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
Message-ID: <20040927134411.A31264@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920093819.E14208@unix-os.sc.intel.com> <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com> <1095864779.6105.3.camel@tdi> <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com> <20040924163632.C27778@unix-os.sc.intel.com> <20040927215027.52fd48b7.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927215027.52fd48b7.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Mon, Sep 27, 2004 at 09:50:27PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 09:50:27PM +0900, Keiichiro Tokunaga wrote:
> One more thing.  Did you modify my acpi_get_pxm.patch by hand?
> That causes an infinite loop.  Please apply my fix patch.

OOPS!! Now applying cleanly. Refreshing my patch again. Thanks.

Hi Len,
	I hope all of my ACPI based CPU hotplug patches[1-6] have been reviewed
extensively and I have fixed all the issues that were raised. Do you think
it is reasonable now to have it in your test tree? Please let me know.

Once this goes to your test tree, I will work with the community to provide
ACPI based NUMA NODE hotplug support patches.

thanks,
Anil

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
 linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c      |  107 +++++++++++++++++-
 linux-2.6.9-rc2-askeshav/drivers/acpi/numa.c          |   21 +++
 linux-2.6.9-rc2-askeshav/include/asm-ia64/acpi.h      |    2 
 linux-2.6.9-rc2-askeshav/include/linux/acpi.h         |   14 ++
 5 files changed, 162 insertions(+), 4 deletions(-)

diff -puN include/linux/acpi.h~acpi_hotplug_arch include/linux/acpi.h
--- linux-2.6.9-rc2/include/linux/acpi.h~acpi_hotplug_arch	2004-09-27 09:55:27.378549543 -0700
+++ linux-2.6.9-rc2-askeshav/include/linux/acpi.h	2004-09-27 09:55:27.488901104 -0700
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
--- linux-2.6.9-rc2/arch/ia64/kernel/acpi.c~acpi_hotplug_arch	2004-09-27 09:55:27.383432355 -0700
+++ linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c	2004-09-27 09:55:27.489877666 -0700
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
--- linux-2.6.9-rc2/arch/i386/kernel/acpi/boot.c~acpi_hotplug_arch	2004-09-27 09:55:27.390268292 -0700
+++ linux-2.6.9-rc2-askeshav/arch/i386/kernel/acpi/boot.c	2004-09-27 09:55:27.490854229 -0700
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
--- linux-2.6.9-rc2/drivers/acpi/numa.c~acpi_hotplug_arch	2004-09-27 09:55:27.394174542 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/numa.c	2004-09-27 10:04:23.009402356 -0700
@@ -22,7 +22,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
-
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -195,3 +195,22 @@ acpi_numa_init()
 	acpi_numa_arch_fixup();
 	return 0;
 }
+
+int
+acpi_get_pxm(acpi_handle h)
+{
+	unsigned long pxm;
+	acpi_status status;
+	acpi_handle handle;
+	acpi_handle phandle = h;
+
+	do {
+		handle = phandle;
+		status = acpi_evaluate_integer(handle, "_PXM", NULL, &pxm);
+		if (ACPI_SUCCESS(status))
+			return (int)pxm;
+		status = acpi_get_parent(handle, &phandle);
+	} while(ACPI_SUCCESS(status));
+	return -1;
+}
+EXPORT_SYMBOL(acpi_get_pxm);
diff -puN include/asm-ia64/acpi.h~acpi_hotplug_arch include/asm-ia64/acpi.h
--- linux-2.6.9-rc2/include/asm-ia64/acpi.h~acpi_hotplug_arch	2004-09-27 09:59:44.901983888 -0700
+++ linux-2.6.9-rc2-askeshav/include/asm-ia64/acpi.h	2004-09-27 10:00:16.970342870 -0700
@@ -101,7 +101,7 @@ int acpi_gsi_to_irq (u32 gsi, unsigned i
 #ifdef CONFIG_ACPI_NUMA
 /* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
 #define MAX_PXM_DOMAINS (256)
-extern int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS];
+extern int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
 extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
_
