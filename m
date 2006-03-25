Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWCYQ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWCYQ0d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWCYQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:26:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52371 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750861AbWCYQ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:26:01 -0500
Subject: [patch 4 of 4] i386 version of the changes
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <1143303796.2898.6.camel@laptopd505.fenrus.org>
References: <1143303796.2898.6.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 17:25:45 +0100
Message-Id: <1143303946.2898.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/i386/kernel/setup.c |   30 ++++++++++++++++++++++++++++++
 arch/i386/pci/mmconfig.c |   12 ++++++++++++
 include/asm-i386/e820.h  |    3 +++
 3 files changed, 45 insertions(+)

Index: linux-2.6.16-mmconfig/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/i386/kernel/setup.c
+++ linux-2.6.16-mmconfig/arch/i386/kernel/setup.c
@@ -991,6 +991,36 @@ void __init find_max_pfn(void)
 }
 
 /*
+ * This function checks if the entire range <start,end> is mapped with type.
+ *
+ * Note: this function only works correct if the e820 table is sorted and
+ * not-overlapping, which is the case
+ */
+int __init e820_all_mapped(unsigned long start, unsigned long end, unsigned type)
+{
+	int i;
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		if (type && ei->type != type)
+			continue;
+		/* is the region (part) in overlap with the current region ?*/
+		if (ei->addr >= end || ei->addr + ei->size <= start)
+			continue;
+
+		/* if the region is at the beginning of <start,end> we move
+		 * start to the end of the region since it's ok until there
+		 */
+		if (ei->addr <= start)
+			start = ei->addr + ei->size;
+		/* if start is now at or beyond end, we're done, full coverage */
+		if (start >= end)
+			return 1; /* we're done */
+	}
+	return 0;
+}
+
+
+/*
  * Determine low and high memory ranges:
  */
 unsigned long __init find_max_low_pfn(void)
Index: linux-2.6.16-mmconfig/arch/i386/pci/mmconfig.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/i386/pci/mmconfig.c
+++ linux-2.6.16-mmconfig/arch/i386/pci/mmconfig.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <asm/e820.h>
 #include "pci.h"
 
 #define mmcfg_virt_addr ((void __iomem *) fix_to_virt(FIX_PCIE_MCFG))
@@ -19,6 +20,9 @@
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
 
+#define MMCONFIG_APER_SIZE (256*1024*1024)
+
+
 static DECLARE_BITMAP(fallback_slots, 32);
 
 /*
@@ -183,6 +187,14 @@ void __init pci_mmcfg_init(void)
 	    (pci_mmcfg_config[0].base_address == 0))
 		return;
 
+	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
+			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+			E820_RESERVED)) {
+		printk(KERN_INFO "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
+		printk(KERN_INFO "PCI: Not using MMCONFIG.\n");
+		return;
+	}
+
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
Index: linux-2.6.16-mmconfig/include/asm-i386/e820.h
===================================================================
--- linux-2.6.16-mmconfig.orig/include/asm-i386/e820.h
+++ linux-2.6.16-mmconfig/include/asm-i386/e820.h
@@ -35,6 +35,9 @@ struct e820map {
 };
 
 extern struct e820map e820;
+
+extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
+
 #endif/*!__ASSEMBLY__*/
 
 #endif/*__E820_HEADER*/


