Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVERPbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVERPbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVERP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:29:38 -0400
Received: from fmr17.intel.com ([134.134.136.16]:19426 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262290AbVERPXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:23:49 -0400
Date: Wed, 18 May 2005 08:28:29 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200505181528.j4IFSTo1026925@snoqualmie.dp.intel.com>
To: ak@muc.de, akpm@osdl.org
Subject: [patch 4/4] add x86-64 specific support for sparsemem
Cc: apw@shadowen.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds in the necessary support for sparsemem such that
x86-64 kernels may use sparsemem as an alternative to discontigmem
for NUMA kernels.  Note that this does no preclude one from 
continuing to build NUMA kernels using discontigmem, but merely
allows the option to build NUMA kernels with sparsemem.

Interestingly, the use of sparsemem in lieu of discontigmem in NUMA
kernels results in reduced text size for otherwise equivalent
kernels as shown in the example builds below:

   text	   data	    bss	    dec	    hex	filename
2371036	 765884	1237108	4374028	 42be0c	vmlinux.discontig
2366549	 776484	1302772	4445805	 43d66d	vmlinux.sparse

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/x86_64/kernel/setup.c     |   10 ++++++++--
 arch/x86_64/mm/numa.c          |    8 ++++++++
 include/asm-x86_64/bitops.h    |    2 --
 include/asm-x86_64/sparsemem.h |   26 ++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c linux-2.6.12-rc4-mm2-m/arch/x86_64/kernel/setup.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c	2005-05-18 07:50:07.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/kernel/setup.c	2005-05-18 07:51:13.000000000 -0400
@@ -40,6 +40,7 @@
 #include <linux/acpi.h>
 #include <linux/kallsyms.h>
 #include <linux/edd.h>
+#include <linux/mmzone.h>
 #include <linux/kexec.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -400,9 +401,12 @@ static __init void parse_cmdline_early (
 }
 
 #ifndef CONFIG_NUMA
-static void __init contig_initmem_init(void)
+static void __init
+contig_initmem_init(unsigned long start_pfn, unsigned long end_pfn)
 {
         unsigned long bootmap_size, bootmap; 
+
+	memory_present(0, start_pfn, end_pfn);
         bootmap_size = bootmem_bootmap_pages(end_pfn)<<PAGE_SHIFT;
         bootmap = find_e820_area(0, end_pfn<<PAGE_SHIFT, bootmap_size);
         if (bootmap == -1L) 
@@ -579,7 +583,7 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_NUMA
 	numa_initmem_init(0, end_pfn); 
 #else
-	contig_initmem_init(); 
+	contig_initmem_init(0, end_pfn);
 #endif
 
 	/* Reserve direct mapping */
@@ -645,6 +649,8 @@ void __init setup_arch(char **cmdline_p)
 		reserve_bootmem(crashk_res.start, crashk_res.end - crashk_res.start + 1);
 	}
 #endif
+
+	sparse_init();
 	paging_init();
 
 	check_ioapic();
diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/mm/numa.c linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/numa.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/mm/numa.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/numa.c	2005-05-18 07:51:13.000000000 -0400
@@ -66,6 +66,13 @@ int __init compute_hash_shift(struct nod
 	return -1; 
 }
 
+#ifdef CONFIG_SPARSEMEM
+int early_pfn_to_nid(unsigned long pfn)
+{
+	return phys_to_nid(pfn << PAGE_SHIFT);
+}
+#endif
+
 /* Initialize bootmem allocator for a node */
 void __init setup_node_bootmem(int nodeid, unsigned long start, unsigned long end)
 { 
@@ -80,6 +87,7 @@ void __init setup_node_bootmem(int nodei
 	start_pfn = start >> PAGE_SHIFT;
 	end_pfn = end >> PAGE_SHIFT;
 
+	memory_present(nodeid, start_pfn, end_pfn);
 	nodedata_phys = find_e820_area(start, end, pgdat_size); 
 	if (nodedata_phys == -1L) 
 		panic("Cannot find memory pgdat in node %d\n", nodeid);
diff -urNp linux-2.6.12-rc4-mm2/include/asm-x86_64/bitops.h linux-2.6.12-rc4-mm2-m/include/asm-x86_64/bitops.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/bitops.h	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/include/asm-x86_64/bitops.h	2005-05-18 07:51:13.000000000 -0400
@@ -411,8 +411,6 @@ static __inline__ int ffs(int x)
 /* find last set bit */
 #define fls(x) generic_fls(x)
 
-#define ARCH_HAS_ATOMIC_UNSIGNED 1
-
 #endif /* __KERNEL__ */
 
 #endif /* _X86_64_BITOPS_H */
diff -urNp linux-2.6.12-rc4-mm2/include/asm-x86_64/sparsemem.h linux-2.6.12-rc4-mm2-m/include/asm-x86_64/sparsemem.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/sparsemem.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-mm2-m/include/asm-x86_64/sparsemem.h	2005-05-18 07:51:13.000000000 -0400
@@ -0,0 +1,26 @@
+#ifndef _ASM_X86_64_SPARSEMEM_H
+#define _ASM_X86_64_SPARSEMEM_H 1
+
+#ifdef CONFIG_SPARSEMEM
+
+/*
+ * generic non-linear memory support:
+ *
+ * 1) we will not split memory into more chunks than will fit into the flags
+ *    field of the struct page
+ *
+ * SECTION_SIZE_BITS		2^n: size of each section
+ * MAX_PHYSADDR_BITS		2^n: max size of physical address space
+ * MAX_PHYSMEM_BITS		2^n: how much memory we can have in that space
+ *
+ */
+
+#define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
+#define MAX_PHYSADDR_BITS	40
+#define MAX_PHYSMEM_BITS	40
+
+extern int early_pfn_to_nid(unsigned long pfn);
+
+#endif /* CONFIG_SPARSEMEM */
+
+#endif /* _ASM_X86_64_SPARSEMEM_H */
