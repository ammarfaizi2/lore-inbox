Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161410AbWG2Cw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWG2Cw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161408AbWG2Cwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:52:55 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:8424 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161409AbWG2Cwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:52:53 -0400
Subject: [Patch] 4/5 in support of hot-add memory x86_64 fix kernel mapping
	code
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: lhms-devel <lhms-devel@lists.sourceforge.net>,
       discuss <discuss@x86-64.org>, Andi Kleen <ak@suse.de>,
       andrew <akpm@osdl.org>, kame <kamezawa.hiroyu@jp.fujitsu.com>,
       dave hansen <haveblue@us.ibm.com>, konrad <darnok@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-/jD2Jj3qPsiAZuxIdV9z"
Organization: Linux Technology Center IBM
Date: Fri, 28 Jul 2006 19:52:50 -0700
Message-Id: <1154141570.5874.148.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/jD2Jj3qPsiAZuxIdV9z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,
  
  phys_pud_init is broken when using it at runtime with some offsets.
It currently only maps one pud entry worth of pages while trampling any
mappings that may have existed on the pmd_page :( 

This his patch make it safe to map addresses that are not pmd_page
aligned and generally more robust.  

This is a critical patch for hot-add and x86_64. 

Thanks to Dave Hansen for input on look and feel of this patch and it's
constructs. 

This was built against 2.6.18-rc2.

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

--=-/jD2Jj3qPsiAZuxIdV9z
Content-Disposition: attachment; filename=patch-2.6.18-rc2-mapping-fix
Content-Type: text/x-patch; name=patch-2.6.18-rc2-mapping-fix; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN orig/arch/x86_64/mm/init.c work/arch/x86_64/mm/init.c
--- orig/arch/x86_64/mm/init.c	2006-07-28 13:57:35.000000000 -0400
+++ work/arch/x86_64/mm/init.c	2006-07-28 14:38:53.000000000 -0400
@@ -252,9 +252,11 @@
 static void __meminit
 phys_pmd_init(pmd_t *pmd, unsigned long address, unsigned long end)
 {
-	int i;
+	int i = pmd_index(address);
 
-	for (i = 0; i < PTRS_PER_PMD; pmd++, i++, address += PMD_SIZE) {
+	pmd = pmd + i;
+
+	for (; i < PTRS_PER_PMD; pmd++, i++, address += PMD_SIZE) {
 		unsigned long entry;
 
 		if (address >= end) {
@@ -263,6 +265,11 @@
 					set_pmd(pmd, __pmd(0));
 			break;
 		}
+		
+		if (pmd_val(*pmd)) {
+			printk (KERN_ERR "%s trying to trample pte entry \
+				%08lx@%08lx\n",__func__,pmd_val(*pmd),address);
+		}
 		entry = _PAGE_NX|_PAGE_PSE|_KERNPG_TABLE|_PAGE_GLOBAL|address;
 		entry &= __supported_pte_mask;
 		set_pmd(pmd, __pmd(entry));
@@ -272,45 +279,42 @@
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
 
 static void __meminit phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
 { 
-	long i = pud_index(address);
+	int i = pud_index(address);
 
 	pud = pud + i;
 
-	if (after_bootmem && pud_val(*pud)) {
-		phys_pmd_update(pud, address, end);
-		return;
-	}
-
-	for (; i < PTRS_PER_PUD; pud++, i++) {
+	for (; i < PTRS_PER_PUD; pud++, i++, \
+			address = (address & PUD_MASK) + PUD_SIZE ) {
 		int map; 
-		unsigned long paddr, pmd_phys;
+		unsigned long pmd_phys;
 		pmd_t *pmd;
 
-		paddr = (address & PGDIR_MASK) + i*PUD_SIZE;
-		if (paddr >= end)
+		if (address >= end)
 			break;
 
-		if (!after_bootmem && !e820_any_mapped(paddr, paddr+PUD_SIZE, 0)) {
+		if (!after_bootmem && !e820_any_mapped(address, address+PUD_SIZE, 0)) {
 			set_pud(pud, __pud(0)); 
 			continue;
 		} 
 
+		if (pud_val(*pud)) {
+			phys_pmd_update(pud, address, end);
+			continue;
+		}
+
 		pmd = alloc_low_page(&map, &pmd_phys);
 		spin_lock(&init_mm.page_table_lock);
 		set_pud(pud, __pud(pmd_phys | _KERNPG_TABLE));
-		phys_pmd_init(pmd, paddr, end);
+		phys_pmd_init(pmd, address, end);
 		spin_unlock(&init_mm.page_table_lock);
 		unmap_low_page(map);
 	}

--=-/jD2Jj3qPsiAZuxIdV9z--

