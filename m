Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWCWSXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWCWSXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWCWSXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:23:05 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:38838 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1422646AbWCWSXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:23:04 -0500
Subject: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
	e820 table
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Mar 2006 19:22:50 +0100
Message-Id: <1143138170.3147.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There have been several machines that don't have a working MMCONFIG,
often because of a buggy MCFG table in the ACPI bios. This patch adds a
simple sanity check that detects a whole bunch of these cases, and when
it detects it, linux now boots rather than crash-and-burns. 

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

diff -purN linux-2.6.16/arch/i386/kernel/setup.c linux-2.6.16-mmconfig/arch/i386/kernel/setup.c
--- linux-2.6.16/arch/i386/kernel/setup.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mmconfig/arch/i386/kernel/setup.c	2006-03-23 17:26:13.000000000 +0100
@@ -1377,6 +1377,31 @@ static void __init register_memory(void)
 		pci_mem_start, gapstart, gapsize);
 }
 
+
+
+/*
+ * Check if an address is reserved in the e820 map
+ */
+int is_e820_reserved(u64 address)
+{
+	int	      i;
+	i = e820.nr_map;
+	while (--i >= 0) {
+		unsigned long long start = e820.map[i].addr;
+		unsigned long long end = start + e820.map[i].size;
+
+		if (address <=end && address >= start) {
+			if (e820.map[i].type == E820_RESERVED)
+				return 1;
+			else
+				return 0;
+		}
+	}
+	return 0;
+}
+
+
+
 /* Use inline assembly to define this because the nops are defined 
    as inline assembly strings in the include files and we cannot 
    get them easily into strings. */
diff -purN linux-2.6.16/arch/i386/pci/mmconfig.c linux-2.6.16-mmconfig/arch/i386/pci/mmconfig.c
--- linux-2.6.16/arch/i386/pci/mmconfig.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mmconfig/arch/i386/pci/mmconfig.c	2006-03-23 17:26:13.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <asm/e820.h>
 #include "pci.h"
 
 #define mmcfg_virt_addr ((void __iomem *) fix_to_virt(FIX_PCIE_MCFG))
@@ -183,6 +184,17 @@ static int __init pci_mmcfg_init(void)
 	    (pci_mmcfg_config[0].base_address == 0))
 		goto out;
 
+	/*
+	 * several bioses have a buggy MCFG table. While this is hard
+	 * to test for conclusively, we know the value is defective
+	 * if the memory isn't marked reserved in the e820 table
+	 */
+	if (!is_e820_reserved(pci_mmcfg_config[0].base_address)) {
+		printk(KERN_INFO "PCI: BIOS Bug: MCFG area is not reserved\n");
+		printk(KERN_INFO "PCI: Not using MMCONFIG.\n");
+		goto out;
+	}
+
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
diff -purN linux-2.6.16/arch/x86_64/kernel/e820.c linux-2.6.16-mmconfig/arch/x86_64/kernel/e820.c
--- linux-2.6.16/arch/x86_64/kernel/e820.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mmconfig/arch/x86_64/kernel/e820.c	2006-03-23 17:27:04.000000000 +0100
@@ -639,3 +639,25 @@ __init void e820_setup_gap(void)
 	printk(KERN_INFO "Allocating PCI resources starting at %lx (gap: %lx:%lx)\n",
 		pci_mem_start, gapstart, gapsize);
 }
+
+/*
+ * Check if an address is reserved in the e820 map
+ */
+int is_e820_reserved(u64 address)
+{
+	int	      i;
+	i = e820.nr_map;
+	while (--i >= 0) {
+		unsigned long long start = e820.map[i].addr;
+		unsigned long long end = start + e820.map[i].size;
+
+		if (address <=end && address >= start) {
+			if (e820.map[i].type == E820_RESERVED)
+				return 1;
+			else
+				return 0;
+		}
+	}
+	return 0;
+}
+
diff -purN linux-2.6.16/arch/x86_64/pci/mmconfig.c linux-2.6.16-mmconfig/arch/x86_64/pci/mmconfig.c
--- linux-2.6.16/arch/x86_64/pci/mmconfig.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mmconfig/arch/x86_64/pci/mmconfig.c	2006-03-23 17:34:06.000000000 +0100
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <asm/e820.h>
 #include "pci.h"
 
 #define MMCONFIG_APER_SIZE (256*1024*1024)
@@ -161,6 +162,19 @@ static int __init pci_mmcfg_init(void)
 	    (pci_mmcfg_config[0].base_address == 0))
 		return 0;
 
+
+	/*
+	 * several bioses have a buggy MCFG table. While this is hard
+	 * to test for conclusively, we know the value is defective
+	 * if the memory isn't marked reserved in the e820 table
+	 */
+	if (!is_e820_reserved(pci_mmcfg_config[0].base_address)) {
+		printk(KERN_INFO "PCI: BIOS Bug: MCFG area is not reserved\n");
+		printk(KERN_INFO "PCI: Not using MMCONFIG.\n");
+		return 0;
+	}
+
+
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {
diff -purN linux-2.6.16/include/asm-i386/e820.h linux-2.6.16-mmconfig/include/asm-i386/e820.h
--- linux-2.6.16/include/asm-i386/e820.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mmconfig/include/asm-i386/e820.h	2006-03-23 17:26:13.000000000 +0100
@@ -35,6 +35,9 @@ struct e820map {
 };
 
 extern struct e820map e820;
+
+extern int is_e820_reserved(u64 address);
+
 #endif/*!__ASSEMBLY__*/
 
 #endif/*__E820_HEADER*/
diff -purN linux-2.6.16/include/asm-x86_64/e820.h linux-2.6.16-mmconfig/include/asm-x86_64/e820.h
--- linux-2.6.16/include/asm-x86_64/e820.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-mmconfig/include/asm-x86_64/e820.h	2006-03-23 17:27:41.000000000 +0100
@@ -47,6 +47,7 @@ extern void contig_e820_setup(void); 
 extern unsigned long e820_end_of_ram(void);
 extern void e820_reserve_resources(void);
 extern void e820_print_map(char *who);
+extern int is_e820_reserved(u64 address);
 extern int e820_mapped(unsigned long start, unsigned long end, unsigned type);
 
 extern void e820_bootmem_free(pg_data_t *pgdat, unsigned long start,unsigned long end);

