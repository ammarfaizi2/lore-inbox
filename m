Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVDLTa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVDLTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVDLTaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:30:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:15049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbVDLKcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:16 -0400
Message-Id: <200504121032.j3CAW67h005506@shell0.pdx.osdl.net>
Subject: [patch 093/198] x86_64: Port over e820 gap detection from i386
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Look for gaps in the e820 memory map to put PCI resources in.

This hopefully fixes problems with the PCI code assigning 32bit BARs MMIO
resources which are >32bit.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/e820.c  |   59 +++++++++++++++++++++++++++++++++++++
 25-akpm/arch/x86_64/kernel/setup.c |   12 -------
 25-akpm/include/asm-x86_64/e820.h  |    1 
 3 files changed, 61 insertions(+), 11 deletions(-)

diff -puN arch/x86_64/kernel/e820.c~x86_64-port-over-e820-gap-detection-from-i386 arch/x86_64/kernel/e820.c
--- 25/arch/x86_64/kernel/e820.c~x86_64-port-over-e820-gap-detection-from-i386	2005-04-12 03:21:25.287292648 -0700
+++ 25-akpm/arch/x86_64/kernel/e820.c	2005-04-12 03:21:25.293291736 -0700
@@ -511,3 +511,62 @@ void __init parse_memopt(char *p, char *
 	end_user_pfn >>= PAGE_SHIFT;	
 } 
 
+unsigned long pci_mem_start = 0xaeedbabe;
+
+/*
+ * Search for the biggest gap in the low 32 bits of the e820
+ * memory space.  We pass this space to PCI to assign MMIO resources
+ * for hotplug or unconfigured devices in.
+ * Hopefully the BIOS let enough space left.
+ */
+__init void e820_setup_gap(void)
+{
+	unsigned long gapstart, gapsize;
+	unsigned long last;
+	int i;
+	int found = 0;
+
+	last = 0x100000000ull;
+	gapstart = 0x10000000;
+	gapsize = 0x400000;
+	i = e820.nr_map;
+	while (--i >= 0) {
+		unsigned long long start = e820.map[i].addr;
+		unsigned long long end = start + e820.map[i].size;
+
+		/*
+		 * Since "last" is at most 4GB, we know we'll
+		 * fit in 32 bits if this condition is true
+		 */
+		if (last > end) {
+			unsigned long gap = last - end;
+
+			if (gap > gapsize) {
+				gapsize = gap;
+				gapstart = end;
+				found = 1;
+			}
+		}
+		if (start < last)
+			last = start;
+	}
+
+	if (!found) {
+		gapstart = (end_pfn << PAGE_SHIFT) + 1024*1024;
+		printk(KERN_ERR "PCI: Warning: Cannot find a gap in the 32bit address range\n"
+		       KERN_ERR "PCI: Unassigned devices with 32bit resource registers may break!\n");
+	}
+
+	/*
+	 * Start allocating dynamic PCI memory a bit into the gap,
+	 * aligned up to the nearest megabyte.
+	 *
+	 * Question: should we try to pad it up a bit (do something
+	 * like " + (gapsize >> 3)" in there too?). We now have the
+	 * technology.
+	 */
+	pci_mem_start = (gapstart + 0xfffff) & ~0xfffff;
+
+	printk(KERN_INFO "Allocating PCI resources starting at %lx (gap: %lx:%lx)\n",
+		pci_mem_start, gapstart, gapsize);
+}
diff -puN arch/x86_64/kernel/setup.c~x86_64-port-over-e820-gap-detection-from-i386 arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86_64-port-over-e820-gap-detection-from-i386	2005-04-12 03:21:25.288292496 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:25.294291584 -0700
@@ -76,9 +76,6 @@ int __initdata acpi_force = 0;
 
 int acpi_numa __initdata;
 
-/* For PCI or other memory-mapped resources */
-unsigned long pci_mem_start = 0x10000000;
-
 /* Boot loader ID as an integer, for the benefit of proc_dointvec */
 int bootloader_type;
 
@@ -495,7 +492,6 @@ static void __init reserve_ebda_region(v
 
 void __init setup_arch(char **cmdline_p)
 {
-	unsigned long low_mem_size;
 	unsigned long kernel_end;
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
@@ -654,13 +650,7 @@ void __init setup_arch(char **cmdline_p)
 		request_resource(&ioport_resource, &standard_io_resources[i]);
 	}
 
-	/* Will likely break when you have unassigned resources with more
-	   than 4GB memory and bridges that don't support more than 4GB. 
-	   Doing it properly would require to use pci_alloc_consistent
-	   in this case. */
-	low_mem_size = ((end_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
-	if (low_mem_size > pci_mem_start)
-		pci_mem_start = low_mem_size;
+	e820_setup_gap();
 
 #ifdef CONFIG_GART_IOMMU
        iommu_hole_init();
diff -puN include/asm-x86_64/e820.h~x86_64-port-over-e820-gap-detection-from-i386 include/asm-x86_64/e820.h
--- 25/include/asm-x86_64/e820.h~x86_64-port-over-e820-gap-detection-from-i386	2005-04-12 03:21:25.289292344 -0700
+++ 25-akpm/include/asm-x86_64/e820.h	2005-04-12 03:21:25.294291584 -0700
@@ -50,6 +50,7 @@ extern void e820_print_map(char *who);
 extern int e820_mapped(unsigned long start, unsigned long end, unsigned type);
 
 extern void e820_bootmem_free(pg_data_t *pgdat, unsigned long start,unsigned long end);
+extern void e820_setup_gap(void);
 
 extern void __init parse_memopt(char *p, char **end);
 
_
