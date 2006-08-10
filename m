Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWHJTjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWHJTjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbWHJTi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:27 -0400
Received: from mx1.suse.de ([195.135.220.2]:40849 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932686AbWHJThl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:41 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [136/145] x86_64: x86_64 kernel mapping fix
Message-Id: <20060810193736.5240413B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:36 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Keith Mannthey <kmannth@us.ibm.com>

Fix for the x86_64 kernel mapping code.  Without this patch the update path
only inits one pmd_page worth of memory and tramples any entries on it.  now
the calling convention to phys_pmd_init and phys_init is to always pass a
[pmd/pud] page not an offset within a page.

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>


---
 arch/x86_64/mm/init.c |   51 +++++++++++++++++++++++++-------------------------
 1 files changed, 26 insertions(+), 25 deletions(-)

Index: linux/arch/x86_64/mm/init.c
===================================================================
--- linux.orig/arch/x86_64/mm/init.c
+++ linux/arch/x86_64/mm/init.c
@@ -250,12 +250,13 @@ __init void early_iounmap(void *addr, un
 }
 
 static void __meminit
-phys_pmd_init(pmd_t *pmd, unsigned long address, unsigned long end)
+phys_pmd_init(pmd_t *pmd_page, unsigned long address, unsigned long end)
 {
-	int i;
+	int i = pmd_index(address);
 
-	for (i = 0; i < PTRS_PER_PMD; pmd++, i++, address += PMD_SIZE) {
+	for (; i < PTRS_PER_PMD; i++, address += PMD_SIZE) {
 		unsigned long entry;
+		pmd_t *pmd = pmd_page + pmd_index(address);
 
 		if (address >= end) {
 			if (!after_bootmem)
@@ -263,6 +264,10 @@ phys_pmd_init(pmd_t *pmd, unsigned long 
 					set_pmd(pmd, __pmd(0));
 			break;
 		}
+
+		if (pmd_val(*pmd))
+			continue;
+
 		entry = _PAGE_NX|_PAGE_PSE|_KERNPG_TABLE|_PAGE_GLOBAL|address;
 		entry &= __supported_pte_mask;
 		set_pmd(pmd, __pmd(entry));
@@ -272,45 +277,41 @@ phys_pmd_init(pmd_t *pmd, unsigned long 
 static void __meminit
 phys_pmd_update(pud_t *pud, unsigned long address, unsigned long end)
 {
-	pmd_t *pmd = pmd_offset(pud, (unsigned long)__va(address));
-
-	if (pmd_none(*pmd)) {
-		spin_lock(&init_mm.page_table_lock);
-		phys_pmd_init(pmd, address, end);
-		spin_unlock(&init_mm.page_table_lock);
-		__flush_tlb_all();
-	}
+	pmd_t *pmd = pmd_offset(pud,0);
+	spin_lock(&init_mm.page_table_lock);
+	phys_pmd_init(pmd, address, end);
+	spin_unlock(&init_mm.page_table_lock);
+	__flush_tlb_all();
 }
 
-static void __meminit phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
+static void __meminit phys_pud_init(pud_t *pud_page, unsigned long addr, unsigned long end)
 { 
-	long i = pud_index(address);
-
-	pud = pud + i;
+	int i = pud_index(addr);
 
-	if (after_bootmem && pud_val(*pud)) {
-		phys_pmd_update(pud, address, end);
-		return;
-	}
 
-	for (; i < PTRS_PER_PUD; pud++, i++) {
+	for (; i < PTRS_PER_PUD; i++, addr = (addr & PUD_MASK) + PUD_SIZE ) {
 		int map; 
-		unsigned long paddr, pmd_phys;
+		unsigned long pmd_phys;
+		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
 
-		paddr = (address & PGDIR_MASK) + i*PUD_SIZE;
-		if (paddr >= end)
+		if (addr >= end)
 			break;
 
-		if (!after_bootmem && !e820_any_mapped(paddr, paddr+PUD_SIZE, 0)) {
+		if (!after_bootmem && !e820_any_mapped(addr,addr+PUD_SIZE,0)) {
 			set_pud(pud, __pud(0)); 
 			continue;
 		} 
 
+		if (pud_val(*pud)) {
+			phys_pmd_update(pud, addr, end);
+			continue;
+		}
+
 		pmd = alloc_low_page(&map, &pmd_phys);
 		spin_lock(&init_mm.page_table_lock);
 		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
-		phys_pmd_init(pmd, paddr, end);
+		phys_pmd_init(pmd, addr, end);
 		spin_unlock(&init_mm.page_table_lock);
 		unmap_low_page(map);
 	}
