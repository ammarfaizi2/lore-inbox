Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161376AbWHJQEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161376AbWHJQEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWHJQEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:04:36 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:22983 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161376AbWHJQET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:04:19 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Richard Henderson <rth@twiddle.net>
Subject: [PATCH 3/14] Generic ioremap_page_range: alpha conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:35 +0200
Message-Id: <115522582724-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11552258271630-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Henderson <rth@twiddle.net>

Convert Alpha to use generic ioremap_page_range() by turning
__alpha_remap_area_pages() into an inline wrapper around
ioremap_page_range().

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/alpha/kernel/proto.h |   15 ++++++--
 arch/alpha/mm/Makefile    |    2 +
 arch/alpha/mm/remap.c     |   86 ---------------------------------------------
 3 files changed, 13 insertions(+), 90 deletions(-)

diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 2a6e3da..21f7128 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -1,5 +1,7 @@
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
+#include <asm/pgtable.h>
 
 /* Prototypes of functions used across modules here in this directory.  */
 
@@ -181,9 +183,16 @@ extern void titan_dispatch_irqs(u64, str
 extern void switch_to_system_map(void);
 extern void srm_paging_stop(void);
 
-/* ../mm/remap.c */
-extern int __alpha_remap_area_pages(unsigned long, unsigned long, 
-				    unsigned long, unsigned long);
+static inline int
+__alpha_remap_area_pages(unsigned long address, unsigned long phys_addr,
+			 unsigned long size, unsigned long flags)
+{
+	pgprot_t prot;
+
+	prot = __pgprot(_PAGE_VALID | _PAGE_ASM | _PAGE_KRE
+			| _PAGE_KWE | flags);
+	return ioremap_page_range(address, address + size, phys_addr, prot);
+}
 
 /* irq.c */
 
diff --git a/arch/alpha/mm/Makefile b/arch/alpha/mm/Makefile
index 6edd9a0..09399c5 100644
--- a/arch/alpha/mm/Makefile
+++ b/arch/alpha/mm/Makefile
@@ -4,6 +4,6 @@ #
 
 EXTRA_CFLAGS := -Werror
 
-obj-y	:= init.o fault.o extable.o remap.o
+obj-y	:= init.o fault.o extable.o
 
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
diff --git a/arch/alpha/mm/remap.c b/arch/alpha/mm/remap.c
deleted file mode 100644
index a78356c..0000000
--- a/arch/alpha/mm/remap.c
+++ /dev/null
@@ -1,86 +0,0 @@
-#include <linux/vmalloc.h>
-#include <asm/pgalloc.h>
-#include <asm/cacheflush.h>
-
-static inline void 
-remap_area_pte(pte_t * pte, unsigned long address, unsigned long size, 
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, pfn_pte(pfn, 
-				     __pgprot(_PAGE_VALID | _PAGE_ASM | 
-				              _PAGE_KRE | _PAGE_KWE | flags)));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int 
-remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size, 
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, 
-				     address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-int
-__alpha_remap_area_pages(unsigned long address, unsigned long phys_addr,
-			 unsigned long size, unsigned long flags)
-{
-	pgd_t * dir;
-	int error = 0;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pmd_t *pmd;
-		pmd = pmd_alloc(&init_mm, dir, address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-			           phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	return error;
-}
-
-- 
1.4.0

