Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWHALG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWHALG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWHALGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9181 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932629AbWHALGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 19/33] x86_64: Cleanup the early boot page table.
Date: Tue,  1 Aug 2006 05:03:34 -0600
Message-Id: <1154430239211-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
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
---
 arch/x86_64/kernel/head.S    |   61 +++++++++++++++++++-----------------------
 include/asm-x86_64/pgtable.h |    1 -
 2 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index ca57a37..a9e34d9 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -15,6 +15,7 @@ #include <linux/threads.h>
 #include <linux/init.h>
 #include <asm/desc.h>
 #include <asm/segment.h>
+#include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/msr.h>
 #include <asm/cache.h>
@@ -250,52 +251,48 @@ ljumpvector:
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
@@ -303,12 +300,10 @@ #undef NEXT_PAGE
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
@@ -322,12 +317,12 @@ #endif
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
 
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index 211a2ca..5528e8b 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -15,7 +15,6 @@ #include <linux/threads.h>
 #include <asm/pda.h>
 
 extern pud_t level3_kernel_pgt[512];
-extern pud_t level3_physmem_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
-- 
1.4.2.rc2.g5209e

