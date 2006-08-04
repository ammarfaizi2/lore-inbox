Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWHDNQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWHDNQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWHDNP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:15:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:50874 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161146AbWHDNPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:15:30 -0400
Date: Fri, 4 Aug 2006 07:14:27 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131427.21401.22299.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 7/10] hot-add-mem x86_64: x86_64 kernel mapping fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

  Fix for the x86_64 kernel mapping code.  Without this patch the update path
only inits one pmd_page worth of memory and tramples any entries on it. 
now the calling convention to phys_pmd_init and phys_init is to always
pass a [pmd/pud] page not an offset within a page. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 init.c |   51 ++++++++++++++++++++++++++-------------------------
 1 files changed, 26 insertions(+), 25 deletions(-)

diff -urN linux-2.6.17-stock/arch/x86_64/mm/init.c linux-2.6.17/arch/x86_64/mm/init.c
--- linux-2.6.17-stock/arch/x86_64/mm/init.c	2006-08-04 08:01:57.000000000 -0400
+++ linux-2.6.17/arch/x86_64/mm/init.c	2006-08-04 08:01:01.000000000 -0400
@@ -250,12 +250,13 @@
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
@@ -263,6 +264,10 @@
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
@@ -272,45 +277,41 @@
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
+	int i = pud_index(addr);
 
-	pud = pud + i;
 
-	if (after_bootmem && pud_val(*pud)) {
-		phys_pmd_update(pud, address, end);
-		return;
-	}
-
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
