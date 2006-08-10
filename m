Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWHJQFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWHJQFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161382AbWHJQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:04:41 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:36319 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161374AbWHJQEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:04:15 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 13/14] Generic ioremap_page_range: sh64 conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 10 Aug 2006 18:03:45 +0200
Message-Id: <11552258273079-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11552258273304-git-send-email-hskinnemoen@atmel.com>
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com> <115522582724-git-send-email-hskinnemoen@atmel.com> <11552258272417-git-send-email-hskinnemoen@atmel.com> <11552258273292-git-send-email-hskinnemoen@atmel.com> <11552258272265-git-send-email-hskinnemoen@atmel.com> <11552258271169-git-send-email-hskinnemoen@atmel.com> <11552258273246-git-send-email-hskinnemoen@atmel.com> <11552258271464-git-send-email-hskinnemoen@atmel.com> <11552258272884-git-send-email-hskinnemoen@atmel.com> <11552258273005-git-send-email-hskinnemoen@atmel.com> <11552258273304-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mundt <lethal@linux-sh.org>

Convert SH64 to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/sh64/mm/ioremap.c |  100 ++++--------------------------------------------
 1 files changed, 8 insertions(+), 92 deletions(-)

diff --git a/arch/sh64/mm/ioremap.c b/arch/sh64/mm/ioremap.c
index fb1866f..e77d85f 100644
--- a/arch/sh64/mm/ioremap.c
+++ b/arch/sh64/mm/ioremap.c
@@ -18,7 +18,7 @@ #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
 #include <linux/string.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <linux/ioport.h>
@@ -28,96 +28,6 @@ #include <linux/proc_fs.h>
 static void shmedia_mapioaddr(unsigned long, unsigned long);
 static unsigned long shmedia_ioremap(struct resource *, u32, int);
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_PRESENT  | _PAGE_READ   |
-				   _PAGE_WRITE    | _PAGE_DIRTY  |
-				   _PAGE_ACCESSED | _PAGE_SHARED | flags);
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-
-	pfn = phys_addr >> PAGE_SHIFT;
-
-	pr_debug("    %s: pte %p address %lx size %lx phys_addr %lx\n",
-		 __FUNCTION__,pte,address,size,phys_addr);
-
-	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-
-		set_pte(pte, pfn_pte(pfn, pgprot));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-
-	phys_addr -= address;
-
-	if (address >= end)
-		BUG();
-
-	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				 unsigned long size, unsigned long flags)
-{
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset_k(address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-				   phys_addr + address, flags)) {
-			 break;
-		}
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return 0;
-}
-
 /*
  * Generic mapping function (not visible outside):
  */
@@ -136,12 +46,17 @@ void * __ioremap(unsigned long phys_addr
 	void * addr;
 	struct vm_struct * area;
 	unsigned long offset, last_addr;
+	pgprot_t pgprot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
 		return NULL;
 
+	pgprot = __pgprot(_PAGE_PRESENT  | _PAGE_READ   |
+			  _PAGE_WRITE    | _PAGE_DIRTY  |
+			  _PAGE_ACCESSED | _PAGE_SHARED | flags);
+
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -158,7 +73,8 @@ void * __ioremap(unsigned long phys_addr
 		return NULL;
 	area->phys_addr = phys_addr;
 	addr = area->addr;
-	if (remap_area_pages((unsigned long)addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, pgprot)) {
 		vunmap(addr);
 		return NULL;
 	}
-- 
1.4.0

