Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUIYG60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUIYG60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269254AbUIYG60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:58:26 -0400
Received: from holomorphy.com ([207.189.100.168]:44005 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269252AbUIYG6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:58:19 -0400
Date: Fri, 24 Sep 2004 23:58:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 1/76] introduce remap_pfn_range()
Message-ID: <20040925065816.GW9106@holomorphy.com>
References: <20040925065335.GV9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925065335.GV9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces remap_pfn_range(), destined to replace
remap_page_range(). In the sequel, the callers of remap_page_range()
will be converted one at a time.

By using a pfn to specify its physical address argument,
remap_pfn_range() resolves a longstanding physical address overflow
issue.


Index: mm3-2.6.9-rc2/include/linux/mm.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/mm.h	2004-09-24 19:17:00.863688360 -0700
+++ mm3-2.6.9-rc2/include/linux/mm.h	2004-09-24 22:01:48.366559448 -0700
@@ -856,8 +856,15 @@
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
-extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
-		unsigned long to, unsigned long size, pgprot_t prot);
+int remap_pfn_range(struct vm_area_struct *, unsigned long,
+		unsigned long, unsigned long, pgprot_t);
+
+static inline
+int remap_page_range(struct vm_area_struct *vma, unsigned long uvaddr,
+			unsigned long paddr, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range(vma, uvaddr, paddr >> PAGE_SHIFT, size, prot);
+}
 
 #ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
Index: mm3-2.6.9-rc2/mm/memory.c
===================================================================
--- mm3-2.6.9-rc2.orig/mm/memory.c	2004-09-24 17:37:15.000000000 -0700
+++ mm3-2.6.9-rc2/mm/memory.c	2004-09-24 21:58:50.300629584 -0700
@@ -945,16 +945,14 @@
  * in null mappings (currently treated as "copy-on-access")
  */
 static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+	unsigned long pfn, pgprot_t prot)
 {
 	unsigned long end;
-	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
-	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
@@ -966,7 +964,7 @@
 }
 
 static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+	unsigned long pfn, pgprot_t prot)
 {
 	unsigned long base, end;
 
@@ -975,12 +973,12 @@
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
-	phys_addr -= address;
+	pfn -= address >> PAGE_SHIFT;
 	do {
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address, address + phys_addr, prot);
+		remap_pte_range(pte, base + address, end - address, pfn + (address >> PAGE_SHIFT), prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -989,7 +987,7 @@
 }
 
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long phys_addr, unsigned long size, pgprot_t prot)
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long from, unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	int error = 0;
 	pgd_t * dir;
@@ -997,7 +995,7 @@
 	unsigned long end = from + size;
 	struct mm_struct *mm = vma->vm_mm;
 
-	phys_addr -= from;
+	pfn -= from >> PAGE_SHIFT;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
 	if (from >= end)
@@ -1009,7 +1007,7 @@
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = remap_pmd_range(mm, pmd, from, end - from, phys_addr + from, prot);
+		error = remap_pmd_range(mm, pmd, from, end - from, pfn + (from >> PAGE_SHIFT), prot);
 		if (error)
 			break;
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
@@ -1022,8 +1020,7 @@
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }
-
-EXPORT_SYMBOL(remap_page_range);
+EXPORT_SYMBOL(remap_pfn_range);
 
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
Index: mm3-2.6.9-rc2/mm/nommu.c
===================================================================
--- mm3-2.6.9-rc2.orig/mm/nommu.c	2004-09-24 02:10:30.000000000 -0700
+++ mm3-2.6.9-rc2/mm/nommu.c	2004-09-24 22:06:16.400812048 -0700
@@ -560,7 +560,7 @@
 	return NULL;
 }
 
-int remap_page_range(struct vm_area_struct *vma, unsigned long from,
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot)
 {
 	return -EPERM;
