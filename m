Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbTIKBPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbTIKBPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:15:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9879 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265905AbTIKBP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:15:27 -0400
Subject: [PATCH] allow x86 NUMA architecture detection to fail
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Patricia Gaughen <gone@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andi Kleen <ak@muc.de>
Content-Type: multipart/mixed; boundary="=-QSovcLyx1z3Gh+kffBJM"
Organization: 
Message-Id: <1063242888.32125.243.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Sep 2003 18:14:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QSovcLyx1z3Gh+kffBJM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As described in this bug: http://bugme.osdl.org/show_bug.cgi?id=653 , if
you enable Summit support and NUMA Discontigmem support but boot on a
non-Summit box, the kernel will fail to boot.  The problem is that the
Summit code can not correctly get the NUMA memory configuration of a
flat box.  The code to do that is in get_memcfg_numa_flat(), but it
never gets called.  

This patch implements a fallback to the generic NUMA code in
get_memcfg_numa_flat() if the Summit detection fails.  The patch also
adds the necessary bits to the Summit code so that it *knows* when it
fails.  

BTW, this doesn't address NUMA-Q.  I think I have posession of more than
50% of the NUMA-Q's running Linux on the planet, and I'm too lazy to fix
it for just myself.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-QSovcLyx1z3Gh+kffBJM
Content-Disposition: attachment; filename=get_memcfg_numa-2.6.0-test5-0.patch
Content-Type: text/x-patch; name=get_memcfg_numa-2.6.0-test5-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -rup linux-2.6.0-test5-summit-include/arch/i386/kernel/numaq.c linux-2.6.0-test5-summit/arch/i386/kernel/numaq.c
--- linux-2.6.0-test5-summit-include/arch/i386/kernel/numaq.c	Wed Sep 10 17:50:14 2003
+++ linux-2.6.0-test5-summit/arch/i386/kernel/numaq.c	Wed Sep 10 17:45:07 2003
@@ -99,8 +99,14 @@ static void __init initialize_physnode_m
 	}
 }
 
-void __init get_memcfg_numaq(void)
+/*
+ * Unlike Summit, we don't really care to let the NUMA-Q
+ * fall back to flat mode.  Don't compile for NUMA-Q
+ * unless you really need it!
+ */
+int __init get_memcfg_numaq(void)
 {
 	smp_dump_qct();
 	initialize_physnode_map();
+	return 1;
 }
diff -rup linux-2.6.0-test5-summit-include/arch/i386/kernel/srat.c linux-2.6.0-test5-summit/arch/i386/kernel/srat.c
--- linux-2.6.0-test5-summit-include/arch/i386/kernel/srat.c	Wed Sep 10 17:50:14 2003
+++ linux-2.6.0-test5-summit/arch/i386/kernel/srat.c	Wed Sep 10 17:31:59 2003
@@ -239,6 +239,11 @@ static int __init acpi20_parse_srat(stru
 		}
 	}
 
+	if (num_memory_chunks == 0) {
+		printk("could not finy any ACPI SRAT memory areas.\n");
+		goto out_fail;
+	}
+	
 	/* Calculate total number of nodes in system from PXM bitmap and create
 	 * a set of sequential node IDs starting at zero.  (ACPI doesn't seem
 	 * to specify the range of _PXM values.)
@@ -295,10 +300,12 @@ static int __init acpi20_parse_srat(stru
 			}
 		}
 	}
+	return 1;
+out_fail:
 	return 0;
 }
 
-void __init get_memcfg_from_srat(void)
+int __init get_memcfg_from_srat(void)
 {
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_rsdp *rsdp = NULL;
@@ -316,11 +323,11 @@ void __init get_memcfg_from_srat(void)
 				(u32)rsdp_address->pointer.physical;
 	} else {
 		printk("%s: rsdp_address is not a physical pointer\n", __FUNCTION__);
-		return;
+		goto out_err;
 	}
 	if (!rsdp) {
 		printk("%s: Didn't find ACPI root!\n", __FUNCTION__);
-		return;
+		goto out_err;
 	}
 
 	printk(KERN_INFO "%.8s v%d [%.6s]\n", rsdp->signature, rsdp->revision,
@@ -328,7 +335,7 @@ void __init get_memcfg_from_srat(void)
 
 	if (strncmp(rsdp->signature, RSDP_SIG,strlen(RSDP_SIG))) {
 		printk(KERN_WARNING "%s: RSDP table signature incorrect\n", __FUNCTION__);
-		return;
+		goto out_err;
 	}
 
 	rsdt = (struct acpi_table_rsdt *)
@@ -338,14 +345,14 @@ void __init get_memcfg_from_srat(void)
 		printk(KERN_WARNING
 		       "%s: ACPI: Invalid root system description tables (RSDT)\n",
 		       __FUNCTION__);
-		return;
+		goto out_err;
 	}
 
 	header = & rsdt->header;
 
 	if (strncmp(header->signature, RSDT_SIG, strlen(RSDT_SIG))) {
 		printk(KERN_WARNING "ACPI: RSDT signature incorrect\n");
-		return;
+		goto out_err;
 	}
 
 	/* 
@@ -356,15 +363,18 @@ void __init get_memcfg_from_srat(void)
 	 */
 	tables = (header->length - sizeof(struct acpi_table_header)) / 4;
 
+	if (!tables)
+		goto out_err;
+	
 	memcpy(&saved_rsdt, rsdt, sizeof(saved_rsdt));
 
 	if (saved_rsdt.header.length > sizeof(saved_rsdt)) {
 		printk(KERN_WARNING "ACPI: Too big length in RSDT: %d\n",
 		       saved_rsdt.header.length);
-		return;
+		goto out_err;
 	}
 
-printk("Begin table scan....\n");
+	printk("Begin SRAT table scan....\n");
 
 	for (i = 0; i < tables; i++) {
 		/* Map in header, then map in full table length. */
@@ -379,10 +389,13 @@ printk("Begin table scan....\n");
 
 		if (strncmp((char *) &header->signature, "SRAT", 4))
 			continue;
-		acpi20_parse_srat((struct acpi_table_srat *)header);
+		
 		/* we've found the srat table. don't need to look at any more tables */
-		break;
+		return acpi20_parse_srat((struct acpi_table_srat *)header);
 	}
+out_err:
+	printk("failed to get NUMA memory information from SRAT table\n");
+	return 0;
 }
 
 /* For each node run the memory list to determine whether there are
diff -rup linux-2.6.0-test5-summit-include/arch/i386/mm/discontig.c linux-2.6.0-test5-summit/arch/i386/mm/discontig.c
--- linux-2.6.0-test5-summit-include/arch/i386/mm/discontig.c	Wed Sep 10 17:50:14 2003
+++ linux-2.6.0-test5-summit/arch/i386/mm/discontig.c	Wed Sep 10 17:42:52 2003
@@ -30,6 +30,7 @@
 #include <linux/initrd.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
+#include <asm/mmzone.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 bootmem_data_t node0_bdata;
@@ -84,7 +85,7 @@ void set_pmd_pfn(unsigned long vaddr, un
  *        a single node with all available processors in it with a flat
  *        memory map.
  */
-void __init get_memcfg_numa_flat(void)
+int __init get_memcfg_numa_flat(void)
 {
 	int pfn;
 
@@ -107,6 +108,7 @@ void __init get_memcfg_numa_flat(void)
          /* Indicate there is one node available. */
 	node_set_online(0);
 	numnodes = 1;
+	return 1;
 }
 
 /*
@@ -351,21 +353,24 @@ void __init zone_sizes_init(void)
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 		unsigned long *zholes_size;
 		unsigned int max_dma;
-
+		
 		unsigned long low = max_low_pfn;
 		unsigned long start = node_start_pfn[nid];
 		unsigned long high = node_end_pfn[nid];
-		
+
 		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
 		if (start > low) {
 #ifdef CONFIG_HIGHMEM
-		  zones_size[ZONE_HIGHMEM] = high - start;
+			BUG_ON(start > high);
+			zones_size[ZONE_HIGHMEM] = high - start;
 #endif
 		} else {
 			if (low < max_dma)
 				zones_size[ZONE_DMA] = low;
 			else {
+				BUG_ON(max_dma > low);
+				BUG_ON(low > high);
 				zones_size[ZONE_DMA] = max_dma;
 				zones_size[ZONE_NORMAL] = low - max_dma;
 #ifdef CONFIG_HIGHMEM
diff -rup linux-2.6.0-test5-summit-include/include/asm-i386/mmzone.h linux-2.6.0-test5-summit/include/asm-i386/mmzone.h
--- linux-2.6.0-test5-summit-include/include/asm-i386/mmzone.h	Wed Sep 10 17:54:26 2003
+++ linux-2.6.0-test5-summit/include/asm-i386/mmzone.h	Wed Sep 10 17:48:37 2003
@@ -122,11 +122,29 @@ static inline struct pglist_data *pfn_to
 #elif CONFIG_ACPI_SRAT
 #include <asm/srat.h>
 #elif CONFIG_X86_PC
-#define get_memcfg_numa get_memcfg_numa_flat
 #define get_zholes_size(n) (0)
 #else
 #define pfn_to_nid(pfn)		(0)
 #endif /* CONFIG_X86_NUMAQ */
+
+extern int get_memcfg_numa_flat(void );
+/*
+ * This allows any one NUMA architecture to be compiled
+ * for, and still fall back to the flat function if it
+ * fails.
+ */
+static inline void get_memcfg_numa(void)
+{
+#ifdef CONFIG_X86_NUMAQ
+	if (get_memcfg_numaq())
+		return;
+#elif CONFIG_ACPI_SRAT
+	if (get_memcfg_from_srat())
+		return;
+#endif
+
+	get_memcfg_numa_flat();
+}
 
 #endif /* CONFIG_DISCONTIGMEM */
 #endif /* _ASM_MMZONE_H_ */
diff -rup linux-2.6.0-test5-summit-include/include/asm-i386/numaq.h linux-2.6.0-test5-summit/include/asm-i386/numaq.h
--- linux-2.6.0-test5-summit-include/include/asm-i386/numaq.h	Wed Sep 10 17:50:11 2003
+++ linux-2.6.0-test5-summit/include/asm-i386/numaq.h	Wed Sep 10 17:19:04 2003
@@ -29,8 +29,7 @@
 #ifdef CONFIG_X86_NUMAQ
 
 #define MAX_NUMNODES		16
-extern void get_memcfg_numaq(void);
-#define get_memcfg_numa() get_memcfg_numaq()
+extern int get_memcfg_numaq(void);
 
 /*
  * SYS_CFG_DATA_PRIV_ADDR, struct eachquadmem, and struct sys_cfg_data are the
diff -rup linux-2.6.0-test5-summit-include/include/asm-i386/srat.h linux-2.6.0-test5-summit/include/asm-i386/srat.h
--- linux-2.6.0-test5-summit-include/include/asm-i386/srat.h	Wed Sep 10 17:54:26 2003
+++ linux-2.6.0-test5-summit/include/asm-i386/srat.h	Wed Sep 10 17:48:37 2003
@@ -32,8 +32,7 @@
 #endif
 
 #define MAX_NUMNODES		8
-extern void get_memcfg_from_srat(void);
+extern int get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);
-#define get_memcfg_numa() get_memcfg_from_srat()
 
 #endif /* _ASM_SRAT_H_ */

--=-QSovcLyx1z3Gh+kffBJM--

