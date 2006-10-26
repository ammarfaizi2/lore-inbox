Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423457AbWJZMcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423457AbWJZMcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423464AbWJZMcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:32:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:43525 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423457AbWJZMcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:32:33 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,361,1157353200"; 
   d="scan'208"; a="150976062:sNHT26556922"
Message-ID: <4540AADE.2000406@intel.com>
Date: Thu, 26 Oct 2006 20:32:30 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] i386 create e820.c about memap boot param parse and print
 function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves e820 memory map print and memmap boot param
parsing function from setup.c to e820.c, also adds limit_regions
and print_memory_map declaration in header file.

Signed-off-by: bibo,mao <bibo.mao@intel.com>

 arch/i386/kernel/e820.c  |  152 +++++++++++++++++++++++++++
 arch/i386/kernel/setup.c |  158 ---------------------------------
 include/asm-i386/e820.h  |    2
 3 files changed, 155 insertions(+), 157 deletions(-)
---------------------------------------------------------------

diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c 2.6.19-rc2-mm2/arch/i386/kernel/e820.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/e820.c	2006-10-26 16:37:26.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/e820.c	2006-10-26 16:38:31.000000000 +0800
@@ -33,6 +33,7 @@ unsigned long pci_mem_start = 0x10000000
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(pci_mem_start);
 #endif
+extern int user_defined_memmap;
 struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
@@ -706,3 +707,154 @@ void __init register_memory(void)
 	printk("Allocating PCI resources starting at %08lx (gap: %08lx:%08lx)\n",
 		pci_mem_start, gapstart, gapsize);
 }
+
+void __init print_memory_map(char *who)
+{
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		printk(" %s: %016Lx - %016Lx ", who,
+			e820.map[i].addr,
+			e820.map[i].addr + e820.map[i].size);
+		switch (e820.map[i].type) {
+		case E820_RAM:	printk("(usable)\n");
+				break;
+		case E820_RESERVED:
+				printk("(reserved)\n");
+				break;
+		case E820_ACPI:
+				printk("(ACPI data)\n");
+				break;
+		case E820_NVS:
+				printk("(ACPI NVS)\n");
+				break;
+		default:	printk("type %lu\n", e820.map[i].type);
+				break;
+		}
+	}
+}
+
+void __init limit_regions(unsigned long long size)
+{
+	unsigned long long current_addr = 0;
+	int i;
+
+	print_memory_map("limit_regions start");
+	if (efi_enabled) {
+		efi_memory_desc_t *md;
+		void *p;
+
+		for (p = memmap.map, i = 0; p < memmap.map_end;
+			p += memmap.desc_size, i++) {
+			md = p;
+			current_addr = md->phys_addr + (md->num_pages << 12);
+			if (md->type == EFI_CONVENTIONAL_MEMORY) {
+				if (current_addr >= size) {
+					md->num_pages -=
+						(((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
+					memmap.nr_map = i + 1;
+					return;
+				}
+			}
+		}
+	}
+	for (i = 0; i < e820.nr_map; i++) {
+		current_addr = e820.map[i].addr + e820.map[i].size;
+		if (current_addr < size)
+			continue;
+
+		if (e820.map[i].type != E820_RAM)
+			continue;
+
+		if (e820.map[i].addr >= size) {
+			/*
+			 * This region starts past the end of the
+			 * requested size, skip it completely.
+			 */
+			e820.nr_map = i;
+		} else {
+			e820.nr_map = i + 1;
+			e820.map[i].size -= current_addr - size;
+		}
+		print_memory_map("limit_regions endfor");
+		return;
+	}
+	print_memory_map("limit_regions endfunc");
+}
+
+ /*
+  * This function checks if the entire range <start,end> is mapped with type.
+  *
+  * Note: this function only works correct if the e820 table is sorted and
+  * not-overlapping, which is the case
+  */
+int __init
+e820_all_mapped(unsigned long s, unsigned long e, unsigned type)
+{
+	u64 start = s;
+	u64 end = e;
+	int i;
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		if (type && ei->type != type)
+			continue;
+		/* is the region (part) in overlap with the current region ?*/
+		if (ei->addr >= end || ei->addr + ei->size <= start)
+			continue;
+		/* if the region is at the beginning of <start,end> we move
+		 * start to the end of the region since it's ok until there
+		 */
+		if (ei->addr <= start)
+			start = ei->addr + ei->size;
+		/* if start is now at or beyond end, we're done, full
+		 * coverage */
+		if (start >= end)
+			return 1; /* we're done */
+	}
+	return 0;
+}
+
+static int __init parse_memmap(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "exactmap") == 0) {
+#ifdef CONFIG_CRASH_DUMP
+		/* If we are doing a crash dump, we
+		 * still need to know the real mem
+		 * size before original memory map is
+		 * reset.
+		 */
+		find_max_pfn();
+		saved_max_pfn = max_pfn;
+#endif
+		e820.nr_map = 0;
+		user_defined_memmap = 1;
+	} else {
+		/* If the user specifies memory size, we
+		 * limit the BIOS-provided memory map to
+		 * that size. exactmap can be used to specify
+		 * the exact map. mem=number can be used to
+		 * trim the existing memory map.
+		 */
+		unsigned long long start_at, mem_size;
+
+		mem_size = memparse(arg, &arg);
+		if (*arg == '@') {
+			start_at = memparse(arg+1, &arg);
+			add_memory_region(start_at, mem_size, E820_RAM);
+		} else if (*arg == '#') {
+			start_at = memparse(arg+1, &arg);
+			add_memory_region(start_at, mem_size, E820_ACPI);
+		} else if (*arg == '$') {
+			start_at = memparse(arg+1, &arg);
+			add_memory_region(start_at, mem_size, E820_RESERVED);
+		} else {
+			limit_regions(mem_size);
+			user_defined_memmap = 1;
+		}
+	}
+	return 0;
+}
+early_param("memmap", parse_memmap);
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c 2.6.19-rc2-mm2/arch/i386/kernel/setup.c
--- 2.6.19-rc2-mm2.org/arch/i386/kernel/setup.c	2006-10-26 16:37:26.000000000 +0800
+++ 2.6.19-rc2-mm2/arch/i386/kernel/setup.c	2006-10-26 16:37:14.000000000 +0800
@@ -73,7 +73,6 @@ int disable_pse __devinitdata = 0;
 /*
  * Machine setup..
  */
-extern struct e820map e820;
 extern struct resource code_resource;
 extern struct resource data_resource;
 
@@ -137,84 +136,6 @@ static char command_line[COMMAND_LINE_SI
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
-static void __init print_memory_map(char *who);
-static void __init limit_regions(unsigned long long size)
-{
-	unsigned long long current_addr = 0;
-	int i;
-
-	print_memory_map("limit_regions start");
-	if (efi_enabled) {
-		efi_memory_desc_t *md;
-		void *p;
-
-		for (p = memmap.map, i = 0; p < memmap.map_end;
-			p += memmap.desc_size, i++) {
-			md = p;
-			current_addr = md->phys_addr + (md->num_pages << 12);
-			if (md->type == EFI_CONVENTIONAL_MEMORY) {
-				if (current_addr >= size) {
-					md->num_pages -=
-						(((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
-					memmap.nr_map = i + 1;
-					return;
-				}
-			}
-		}
-	}
-	for (i = 0; i < e820.nr_map; i++) {
-		current_addr = e820.map[i].addr + e820.map[i].size;
-		if (current_addr < size)
-			continue;
-
-		if (e820.map[i].type != E820_RAM)
-			continue;
-
-		if (e820.map[i].addr >= size) {
-			/*
-			 * This region starts past the end of the
-			 * requested size, skip it completely.
-			 */
-			e820.nr_map = i;
-		} else {
-			e820.nr_map = i + 1;
-			e820.map[i].size -= current_addr - size;
-		}
-		print_memory_map("limit_regions endfor");
-		return;
-	}
-	print_memory_map("limit_regions endfunc");
-}
-
-#define E820_DEBUG	1
-
-static void __init print_memory_map(char *who)
-{
-	int i;
-
-	for (i = 0; i < e820.nr_map; i++) {
-		printk(" %s: %016Lx - %016Lx ", who,
-			e820.map[i].addr,
-			e820.map[i].addr + e820.map[i].size);
-		switch (e820.map[i].type) {
-		case E820_RAM:	printk("(usable)\n");
-				break;
-		case E820_RESERVED:
-				printk("(reserved)\n");
-				break;
-		case E820_ACPI:
-				printk("(ACPI data)\n");
-				break;
-		case E820_NVS:
-				printk("(ACPI NVS)\n");
-				break;
-		default:	printk("type %lu\n", e820.map[i].type);
-				break;
-		}
-	}
-}
-
-
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
 #ifdef CONFIG_EDD_MODULE
@@ -238,7 +159,7 @@ static inline void copy_edd(void)
 }
 #endif
 
-static int __initdata user_defined_memmap = 0;
+int __initdata user_defined_memmap = 0;
 
 /*
  * "mem=nopentium" disables the 4MB page tables.
@@ -275,51 +196,6 @@ static int __init parse_mem(char *arg)
 }
 early_param("mem", parse_mem);
 
-static int __init parse_memmap(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (strcmp(arg, "exactmap") == 0) {
-#ifdef CONFIG_CRASH_DUMP
-		/* If we are doing a crash dump, we
-		 * still need to know the real mem
-		 * size before original memory map is
-		 * reset.
-		 */
-		find_max_pfn();
-		saved_max_pfn = max_pfn;
-#endif
-		e820.nr_map = 0;
-		user_defined_memmap = 1;
-	} else {
-		/* If the user specifies memory size, we
-		 * limit the BIOS-provided memory map to
-		 * that size. exactmap can be used to specify
-		 * the exact map. mem=number can be used to
-		 * trim the existing memory map.
-		 */
-		unsigned long long start_at, mem_size;
-
-		mem_size = memparse(arg, &arg);
-		if (*arg == '@') {
-			start_at = memparse(arg+1, &arg);
-			add_memory_region(start_at, mem_size, E820_RAM);
-		} else if (*arg == '#') {
-			start_at = memparse(arg+1, &arg);
-			add_memory_region(start_at, mem_size, E820_ACPI);
-		} else if (*arg == '$') {
-			start_at = memparse(arg+1, &arg);
-			add_memory_region(start_at, mem_size, E820_RESERVED);
-		} else {
-			limit_regions(mem_size);
-			user_defined_memmap = 1;
-		}
-	}
-	return 0;
-}
-early_param("memmap", parse_memmap);
-
 #ifdef CONFIG_PROC_VMCORE
 /* elfcorehdr= specifies the location of elf core header
  * stored by the crashed kernel.
@@ -383,38 +259,6 @@ static int __init parse_reservetop(char 
 }
 early_param("reservetop", parse_reservetop);
 
- /*
-  * This function checks if the entire range <start,end> is mapped with type.
-  *
-  * Note: this function only works correct if the e820 table is sorted and
-  * not-overlapping, which is the case
-  */
-int __init
-e820_all_mapped(unsigned long s, unsigned long e, unsigned type)
-{
-	u64 start = s;
-	u64 end = e;
-	int i;
-	for (i = 0; i < e820.nr_map; i++) {
-		struct e820entry *ei = &e820.map[i];
-		if (type && ei->type != type)
-			continue;
-		/* is the region (part) in overlap with the current region ?*/
-		if (ei->addr >= end || ei->addr + ei->size <= start)
-			continue;
-		/* if the region is at the beginning of <start,end> we move
-		 * start to the end of the region since it's ok until there
-		 */
-		if (ei->addr <= start)
-			start = ei->addr + ei->size;
-		/* if start is now at or beyond end, we're done, full
-		 * coverage */
-		if (start >= end)
-			return 1; /* we're done */
-	}
-	return 0;
-}
-
 /*
  * Determine low and high memory ranges:
  */
diff -Nrup -X 2.6.19-rc2-mm2.org/Documentation/dontdiff 2.6.19-rc2-mm2.org/include/asm-i386/e820.h 2.6.19-rc2-mm2/include/asm-i386/e820.h
--- 2.6.19-rc2-mm2.org/include/asm-i386/e820.h	2006-10-26 16:37:26.000000000 +0800
+++ 2.6.19-rc2-mm2/include/asm-i386/e820.h	2006-10-26 16:38:50.000000000 +0800
@@ -41,6 +41,8 @@ extern int e820_all_mapped(unsigned long
 extern void find_max_pfn(void);
 extern void register_bootmem_low_pages(unsigned long max_low_pfn);
 extern void register_memory(void);
+extern void limit_regions(unsigned long long size);
+extern void print_memory_map(char *who);
 
 #endif/*!__ASSEMBLY__*/
 
