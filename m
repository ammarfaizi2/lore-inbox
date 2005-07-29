Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVG2T26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVG2T26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVG2T1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:27:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60809 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262585AbVG2TZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:25:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] x86_64 machine_kexec: Use standard pagetable helpers
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 13:25:28 -0600
Message-ID: <m1ack52z4n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard hardware page table manipulation macros.
This is possible now that linux works with all 4 levels
of the page tables.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/machine_kexec.c |   65 +++++++++++++-----------------------
 include/asm-x86_64/pgtable.h       |    2 +
 2 files changed, 26 insertions(+), 41 deletions(-)

d2b0b843161ec7fffff9bae5fee3b1be4b774e57
diff --git a/arch/x86_64/kernel/machine_kexec.c b/arch/x86_64/kernel/machine_kexec.c
--- a/arch/x86_64/kernel/machine_kexec.c
+++ b/arch/x86_64/kernel/machine_kexec.c
@@ -8,43 +8,26 @@
 
 #include <linux/mm.h>
 #include <linux/kexec.h>
-#include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/reboot.h>
-#include <asm/pda.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/apic.h>
-#include <asm/cpufeature.h>
-#include <asm/hw_irq.h>
-
-#define LEVEL0_SIZE (1UL << 12UL)
-#define LEVEL1_SIZE (1UL << 21UL)
-#define LEVEL2_SIZE (1UL << 30UL)
-#define LEVEL3_SIZE (1UL << 39UL)
-#define LEVEL4_SIZE (1UL << 48UL)
-
-#define L0_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
-#define L1_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE)
-#define L2_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
-#define L3_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
-static void init_level2_page(u64 *level2p, unsigned long addr)
+static void init_level2_page(pmd_t *level2p, unsigned long addr)
 {
 	unsigned long end_addr;
 
 	addr &= PAGE_MASK;
-	end_addr = addr + LEVEL2_SIZE;
+	end_addr = addr + PUD_SIZE;
 	while (addr < end_addr) {
-		*(level2p++) = addr | L1_ATTR;
-		addr += LEVEL1_SIZE;
+		set_pmd(level2p++, __pmd(addr | __PAGE_KERNEL_LARGE_EXEC));
+		addr += PMD_SIZE;
 	}
 }
 
-static int init_level3_page(struct kimage *image, u64 *level3p,
+static int init_level3_page(struct kimage *image, pud_t *level3p,
 				unsigned long addr, unsigned long last_addr)
 {
 	unsigned long end_addr;
@@ -52,32 +35,32 @@ static int init_level3_page(struct kimag
 
 	result = 0;
 	addr &= PAGE_MASK;
-	end_addr = addr + LEVEL3_SIZE;
+	end_addr = addr + PGDIR_SIZE;
 	while ((addr < last_addr) && (addr < end_addr)) {
 		struct page *page;
-		u64 *level2p;
+		pmd_t *level2p;
 
 		page = kimage_alloc_control_pages(image, 0);
 		if (!page) {
 			result = -ENOMEM;
 			goto out;
 		}
-		level2p = (u64 *)page_address(page);
+		level2p = (pmd_t *)page_address(page);
 		init_level2_page(level2p, addr);
-		*(level3p++) = __pa(level2p) | L2_ATTR;
-		addr += LEVEL2_SIZE;
+		set_pud(level3p++, __pud(__pa(level2p) | _KERNPG_TABLE));
+		addr += PUD_SIZE;
 	}
 	/* clear the unused entries */
 	while (addr < end_addr) {
-		*(level3p++) = 0;
-		addr += LEVEL2_SIZE;
+		pud_clear(level3p++);
+		addr += PUD_SIZE;
 	}
 out:
 	return result;
 }
 
 
-static int init_level4_page(struct kimage *image, u64 *level4p,
+static int init_level4_page(struct kimage *image, pgd_t *level4p,
 				unsigned long addr, unsigned long last_addr)
 {
 	unsigned long end_addr;
@@ -85,28 +68,28 @@ static int init_level4_page(struct kimag
 
 	result = 0;
 	addr &= PAGE_MASK;
-	end_addr = addr + LEVEL4_SIZE;
+	end_addr = addr + (PTRS_PER_PGD * PGDIR_SIZE);
 	while ((addr < last_addr) && (addr < end_addr)) {
 		struct page *page;
-		u64 *level3p;
+		pud_t *level3p;
 
 		page = kimage_alloc_control_pages(image, 0);
 		if (!page) {
 			result = -ENOMEM;
 			goto out;
 		}
-		level3p = (u64 *)page_address(page);
+		level3p = (pud_t *)page_address(page);
 		result = init_level3_page(image, level3p, addr, last_addr);
 		if (result) {
 			goto out;
 		}
-		*(level4p++) = __pa(level3p) | L3_ATTR;
-		addr += LEVEL3_SIZE;
+		set_pgd(level4p++, __pgd(__pa(level3p) | _KERNPG_TABLE));
+		addr += PGDIR_SIZE;
 	}
 	/* clear the unused entries */
 	while (addr < end_addr) {
-		*(level4p++) = 0;
-		addr += LEVEL3_SIZE;
+		pgd_clear(level4p++);
+		addr += PGDIR_SIZE;
 	}
 out:
 	return result;
@@ -115,8 +98,8 @@ out:
 
 static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 {
-	u64 *level4p;
-	level4p = (u64 *)__va(start_pgtable);
+	pgd_t *level4p;
+	level4p = (pgd_t *)__va(start_pgtable);
  	return init_level4_page(image, level4p, 0, end_pfn << PAGE_SHIFT);
 }
 
@@ -176,7 +159,7 @@ int machine_kexec_prepare(struct kimage 
 
 	/* Calculate the offsets */
 	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + 4096UL;
+	control_code_buffer = start_pgtable + PAGE_SIZE;
 
 	/* Setup the identity mapped 64bit page table */
 	result = init_pgtable(image, start_pgtable);
@@ -212,7 +195,7 @@ NORET_TYPE void machine_kexec(struct kim
 	/* Calculate the offsets */
 	page_list = image->head;
 	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + 4096UL;
+	control_code_buffer = start_pgtable + PAGE_SIZE;
 
 	/* Set the low half of the page table to my identity mapped
 	 * page table for kexec.  Leave the high half pointing at the
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -176,6 +176,8 @@ extern inline void pgd_clear (pgd_t * pg
 	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED | _PAGE_PCD)
 #define __PAGE_KERNEL_LARGE \
 	(__PAGE_KERNEL | _PAGE_PSE)
+#define __PAGE_KERNEL_LARGE_EXEC \
+	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
 
 #define MAKE_GLOBAL(x) __pgprot((x) | _PAGE_GLOBAL)
 
