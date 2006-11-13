Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755218AbWKMQyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbWKMQyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbWKMQyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:47008 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755213AbWKMQyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:04 -0500
Date: Mon, 13 Nov 2006 11:31:41 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 4/16] x86_64: Clean up the early boot page table
Message-ID: <20061113163141.GE17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Merge physmem_pgt and ident_pgt, removing physmem_pgt.  The merge
  is broken as soon as mm/init.c:init_memory_mapping is run.
- As physmem_pgt is gone don't export it in pgtable.h.
- Use defines from pgtable.h for page permissions.
- Fix the physical memory identity mapping so it is at the correct
  address.
- Remove the physical memory mapping from wakeup_level4_pgt it
  is at the wrong address so we can't possibly be usinging it.
- Simply NEXT_PAGE the work to calculate the phys_ alias
  of the labels was very cool.  Unfortuantely it was a brittle
  special purpose hack that makes maitenance more difficult.
  Instead just use label - __START_KERNEL_map like we do
  everywhere else in assembly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/head.S    |   61 +++++++++++++++++++------------------------
 include/asm-x86_64/pgtable.h |    1 
 2 files changed, 28 insertions(+), 34 deletions(-)

diff -puN arch/x86_64/kernel/head.S~x86_64-Cleanup-the-early-boot-page-table arch/x86_64/kernel/head.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/head.S~x86_64-Cleanup-the-early-boot-page-table	2006-11-09 22:55:39.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/head.S	2006-11-09 22:55:39.000000000 -0500
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <asm/desc.h>
 #include <asm/segment.h>
+#include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/msr.h>
 #include <asm/cache.h>
@@ -252,52 +253,48 @@ ljumpvector:
 ENTRY(stext)
 ENTRY(_stext)
 
-	$page = 0
 #define NEXT_PAGE(name) \
-	$page = $page + 1; \
-	.org $page * 0x1000; \
-	phys_/**/name = $page * 0x1000 + __PHYSICAL_START; \
+	.balign	PAGE_SIZE; \
 ENTRY(name)
 
+/* Automate the creation of 1 to 1 mapping pmd entries */
+#define PMDS(START, PERM, COUNT)		\
+	i = 0 ;					\
+	.rept (COUNT) ;				\
+	.quad	(START) + (i << 21) + (PERM) ;	\
+	i = i + 1 ;				\
+	.endr
+
 NEXT_PAGE(init_level4_pgt)
 	/* This gets initialized in x86_64_start_kernel */
 	.fill	512,8,0
 
 NEXT_PAGE(level3_ident_pgt)
-	.quad	phys_level2_ident_pgt | 0x007
+	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
 	.fill	511,8,0
 
 NEXT_PAGE(level3_kernel_pgt)
 	.fill	510,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
-	.quad	phys_level2_kernel_pgt | 0x007
+	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
 	.fill	1,8,0
 
 NEXT_PAGE(level2_ident_pgt)
-	/* 40MB for bootup. 	*/
-	i = 0
-	.rept 20
-	.quad	i << 21 | 0x083
-	i = i + 1
-	.endr
-	.fill	492,8,0
+	/* Since I easily can, map the first 1G.
+	 * Don't set NX because code runs from these pages.
+	 */
+	PMDS(0x0000000000000000, __PAGE_KERNEL_LARGE_EXEC, PTRS_PER_PMD)
 	
 NEXT_PAGE(level2_kernel_pgt)
 	/* 40MB kernel mapping. The kernel code cannot be bigger than that.
 	   When you change this change KERNEL_TEXT_SIZE in page.h too. */
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511)-((2^30)*510)) = 0 */
-	i = 0
-	.rept 20
-	.quad	i << 21 | 0x183
-	i = i + 1
-	.endr
+	PMDS(0x0000000000000000, __PAGE_KERNEL_LARGE_EXEC|_PAGE_GLOBAL,
+		KERNEL_TEXT_SIZE/PMD_SIZE)
 	/* Module mapping starts here */
-	.fill	492,8,0
-
-NEXT_PAGE(level3_physmem_pgt)
-	.quad	phys_level2_kernel_pgt | 0x007	/* so that __va works even before pagetable_init */
-	.fill	511,8,0
+	.fill	(PTRS_PER_PMD - (KERNEL_TEXT_SIZE/PMD_SIZE)),8,0
 
+#undef PMDS
 #undef NEXT_PAGE
 
 	.data
@@ -305,12 +302,10 @@ NEXT_PAGE(level3_physmem_pgt)
 #ifdef CONFIG_ACPI_SLEEP
 	.align PAGE_SIZE
 ENTRY(wakeup_level4_pgt)
-	.quad	phys_level3_ident_pgt | 0x007
-	.fill	255,8,0
-	.quad	phys_level3_physmem_pgt | 0x007
-	.fill	254,8,0
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	510,8,0
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	phys_level3_kernel_pgt | 0x007
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
 #endif
 
 #ifndef CONFIG_HOTPLUG_CPU
@@ -324,12 +319,12 @@ ENTRY(wakeup_level4_pgt)
 	 */
 	.align PAGE_SIZE
 ENTRY(boot_level4_pgt)
-	.quad	phys_level3_ident_pgt | 0x007
-	.fill	255,8,0
-	.quad	phys_level3_physmem_pgt | 0x007
-	.fill	254,8,0
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	257,8,0
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	252,8,0
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	phys_level3_kernel_pgt | 0x007
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE
 
 	.data
 
diff -puN include/asm-x86_64/pgtable.h~x86_64-Cleanup-the-early-boot-page-table include/asm-x86_64/pgtable.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/pgtable.h~x86_64-Cleanup-the-early-boot-page-table	2006-11-09 22:55:39.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/pgtable.h	2006-11-09 22:55:39.000000000 -0500
@@ -15,7 +15,6 @@
 #include <asm/pda.h>
 
 extern pud_t level3_kernel_pgt[512];
-extern pud_t level3_physmem_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
_
