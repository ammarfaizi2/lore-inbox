Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423467AbWJZMco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423467AbWJZMco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423465AbWJZMco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:32:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:39601 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423462AbWJZMcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:32:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,361,1157353200"; 
   d="scan'208"; a="150975984:sNHT851709852"
Message-ID: <4540AAD3.1010303@intel.com>
Date: Thu, 26 Oct 2006 20:32:19 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] i386 create e820.c to handle memmap table walking
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves e820/efi memmap table walking function from 
setup.c to e820.c, also this patch adds extern declaration in 
header file.

Signed-off-by: bibo,mao <bibo.mao@intel.com>

 arch/i386/kernel/e820.c  |  115 +++++++++++++++++++++++++++++++++
 arch/i386/kernel/setup.c |  118 -----------------------------------
 include/asm-i386/e820.h  |    2
 3 files changed, 117 insertions(+), 118 deletions(-)
------------------------------------------------------

diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c 2.6.19-rc2-mm2/arch/i386/kernel/e820.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c	2006-10-26 16:27:59.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/e820.c	2006-10-26 16:27:48.000000000 +0800
@@ -28,6 +28,11 @@ static struct change_member change_point
 static struct change_member *change_point[2*E820MAX] __initdata;
 static struct e820entry *overlap_list[E820MAX] __initdata;
 static struct e820entry new_bios[E820MAX] __initdata;
+/* For PCI or other memory-mapped resources */
+unsigned long pci_mem_start = 0x10000000;
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL(pci_mem_start);
+#endif
 struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
@@ -591,3 +596,113 @@ void __init find_max_pfn(void)
 		memory_present(0, start, end);
 	}
 }
+
+/*
+ * Free all available memory for boot time allocation.  Used
+ * as a callback function by efi_memory_walk()
+ */
+
+static int __init
+free_available_memory(unsigned long start, unsigned long end, void *arg)
+{
+	/* check max_low_pfn */
+	if (start >= (max_low_pfn << PAGE_SHIFT))
+		return 0;
+	if (end >= (max_low_pfn << PAGE_SHIFT))
+		end = max_low_pfn << PAGE_SHIFT;
+	if (start < end)
+		free_bootmem(start, end - start);
+
+	return 0;
+}
+/*
+ * Register fully available low RAM pages with the bootmem allocator.
+ */
+void __init register_bootmem_low_pages(unsigned long max_low_pfn)
+{
+	int i;
+
+	if (efi_enabled) {
+		efi_memmap_walk(free_available_memory, NULL);
+		return;
+	}
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long curr_pfn, last_pfn, size;
+		/*
+		 * Reserve usable low memory
+		 */
+		if (e820.map[i].type != E820_RAM)
+			continue;
+		/*
+		 * We are rounding up the start address of usable memory:
+		 */
+		curr_pfn = PFN_UP(e820.map[i].addr);
+		if (curr_pfn >= max_low_pfn)
+			continue;
+		/*
+		 * ... and at the end of the usable range downwards:
+		 */
+		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+
+		if (last_pfn > max_low_pfn)
+			last_pfn = max_low_pfn;
+
+		/*
+		 * .. finally, did all the rounding and playing
+		 * around just make the area go away?
+		 */
+		if (last_pfn <= curr_pfn)
+			continue;
+
+		size = last_pfn - curr_pfn;
+		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
+	}
+}
+
+void __init register_memory(void)
+{
+	unsigned long gapstart, gapsize, round;
+	unsigned long long last;
+	int i;
+
+	/*
+	 * Search for the bigest gap in the low 32 bits of the e820
+	 * memory space.
+	 */
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
+			}
+		}
+		if (start < last)
+			last = start;
+	}
+
+	/*
+	 * See how much we want to round up: start off with
+	 * rounding to the next 1MB area.
+	 */
+	round = 0x100000;
+	while ((gapsize >> 4) > round)
+		round += round;
+	/* Fun with two's complement */
+	pci_mem_start = (gapstart + round) & -round;
+
+	printk("Allocating PCI resources starting at %08lx (gap: %08lx:%08lx)\n",
+		pci_mem_start, gapstart, gapsize);
+}
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c 2.6.19-rc2-mm2/arch/i386/kernel/setup.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c	2006-10-26 16:27:59.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/setup.c	2006-10-26 16:27:48.000000000 +0800
@@ -94,12 +94,6 @@ unsigned int machine_submodel_id;
 unsigned int BIOS_revision;
 unsigned int mca_pentium_flag;
 
-/* For PCI or other memory-mapped resources */
-unsigned long pci_mem_start = 0x10000000;
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL(pci_mem_start);
-#endif
-
 /* Boot loader ID as an integer, for the benefit of proc_dointvec */
 int bootloader_type;
 
@@ -481,68 +475,6 @@ unsigned long __init find_max_low_pfn(vo
 }
 
 /*
- * Free all available memory for boot time allocation.  Used
- * as a callback function by efi_memory_walk()
- */
-
-static int __init
-free_available_memory(unsigned long start, unsigned long end, void *arg)
-{
-	/* check max_low_pfn */
-	if (start >= (max_low_pfn << PAGE_SHIFT))
-		return 0;
-	if (end >= (max_low_pfn << PAGE_SHIFT))
-		end = max_low_pfn << PAGE_SHIFT;
-	if (start < end)
-		free_bootmem(start, end - start);
-
-	return 0;
-}
-/*
- * Register fully available low RAM pages with the bootmem allocator.
- */
-static void __init register_bootmem_low_pages(unsigned long max_low_pfn)
-{
-	int i;
-
-	if (efi_enabled) {
-		efi_memmap_walk(free_available_memory, NULL);
-		return;
-	}
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long curr_pfn, last_pfn, size;
-		/*
-		 * Reserve usable low memory
-		 */
-		if (e820.map[i].type != E820_RAM)
-			continue;
-		/*
-		 * We are rounding up the start address of usable memory:
-		 */
-		curr_pfn = PFN_UP(e820.map[i].addr);
-		if (curr_pfn >= max_low_pfn)
-			continue;
-		/*
-		 * ... and at the end of the usable range downwards:
-		 */
-		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
-
-		if (last_pfn > max_low_pfn)
-			last_pfn = max_low_pfn;
-
-		/*
-		 * .. finally, did all the rounding and playing
-		 * around just make the area go away?
-		 */
-		if (last_pfn <= curr_pfn)
-			continue;
-
-		size = last_pfn - curr_pfn;
-		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
-	}
-}
-
-/*
  * workaround for Dell systems that neglect to reserve EBDA
  */
 static void __init reserve_ebda_region(void)
@@ -710,56 +642,6 @@ void __init remapped_pgdat_init(void)
 	}
 }
 
-
-
-static void __init register_memory(void)
-{
-	unsigned long gapstart, gapsize, round;
-	unsigned long long last;
-	int i;
-
-	/*
-	 * Search for the bigest gap in the low 32 bits of the e820
-	 * memory space.
-	 */
-	last = 0x100000000ull;
-	gapstart = 0x10000000;
-	gapsize = 0x400000;
-	i = e820.nr_map;
-	while (--i >= 0) {
-		unsigned long long start = e820.map[i].addr;
-		unsigned long long end = start + e820.map[i].size;
-
-		/*
-		 * Since "last" is at most 4GB, we know we'll
-		 * fit in 32 bits if this condition is true
-		 */
-		if (last > end) {
-			unsigned long gap = last - end;
-
-			if (gap > gapsize) {
-				gapsize = gap;
-				gapstart = end;
-			}
-		}
-		if (start < last)
-			last = start;
-	}
-
-	/*
-	 * See how much we want to round up: start off with
-	 * rounding to the next 1MB area.
-	 */
-	round = 0x100000;
-	while ((gapsize >> 4) > round)
-		round += round;
-	/* Fun with two's complement */
-	pci_mem_start = (gapstart + round) & -round;
-
-	printk("Allocating PCI resources starting at %08lx (gap: %08lx:%08lx)\n",
-		pci_mem_start, gapstart, gapsize);
-}
-
 #ifdef CONFIG_MCA
 static void set_mca_bus(int x)
 {
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/include/asm-i386/e820.h 2.6.19-rc2-mm2/include/asm-i386/e820.h
--- 2.6.19-rc2-mm2.org/include/asm-i386/e820.h	2006-10-26 16:27:59.000000000 +0800
+++ 2.6.19-rc2-mm2/include/asm-i386/e820.h	2006-10-26 16:29:45.000000000 +0800
@@ -39,6 +39,8 @@ extern struct e820map e820;
 extern int e820_all_mapped(unsigned long start, unsigned long end,
 			   unsigned type);
 extern void find_max_pfn(void);
+extern void register_bootmem_low_pages(unsigned long max_low_pfn);
+extern void register_memory(void);
 
 #endif/*!__ASSEMBLY__*/
 
