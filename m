Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUIXCXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUIXCXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUIXCV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:21:59 -0400
Received: from holomorphy.com ([207.189.100.168]:988 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265805AbUIXCUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:20:07 -0400
Date: Thu, 23 Sep 2004 19:19:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 1/4] convert remap_page_range() to remap_pfn_range()
Message-ID: <20040924021954.GM9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com> <20040924021735.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924021735.GL9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 07:17:35PM -0700, William Lee Irwin III wrote:
> Do these patches work for you? Compiletested on sparc64.

Convert remap_page_range() to remap_pfn_range(), with a temporary
remap_page_range() wrapper inline (to be eliminated in the sequel).

Index: mm2-2.6.9-rc2/mm/memory.c
===================================================================
--- mm2-2.6.9-rc2.orig/mm/memory.c	2004-09-22 21:32:52.000000000 -0700
+++ mm2-2.6.9-rc2/mm/memory.c	2004-09-23 17:03:21.296806522 -0700
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
Index: mm2-2.6.9-rc2/include/linux/mm.h
===================================================================
--- mm2-2.6.9-rc2.orig/include/linux/mm.h	2004-09-22 21:32:18.000000000 -0700
+++ mm2-2.6.9-rc2/include/linux/mm.h	2004-09-23 16:35:12.546535586 -0700
@@ -764,8 +764,16 @@
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
-extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
-		unsigned long to, unsigned long size, pgprot_t prot);
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long uvaddr,
+		unsigned long pfn, unsigned long size, pgprot_t prot);
+
+static inline int remap_page_range(struct vm_area_struct *vma,
+					unsigned long uvaddr,
+					unsigned long paddr,
+					unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range(vma, uvaddr, paddr >> PAGE_SHIFT, size, prot);
+}
 
 #ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
Index: mm2-2.6.9-rc2/mm/nommu.c
===================================================================
--- mm2-2.6.9-rc2.orig/mm/nommu.c	2004-09-22 21:31:17.000000000 -0700
+++ mm2-2.6.9-rc2/mm/nommu.c	2004-09-23 16:38:50.608385146 -0700
@@ -560,8 +560,8 @@
 	return NULL;
 }
 
-int remap_page_range(struct vm_area_struct *vma, unsigned long from,
-		unsigned long to, unsigned long size, pgprot_t prot)
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	return -EPERM;
 }
Index: mm2-2.6.9-rc2/Documentation/IO-mapping.txt
===================================================================
--- mm2-2.6.9-rc2.orig/Documentation/IO-mapping.txt	2004-09-12 22:32:00.000000000 -0700
+++ mm2-2.6.9-rc2/Documentation/IO-mapping.txt	2004-09-23 16:40:43.150276178 -0700
@@ -119,9 +119,10 @@
 So why do we care about the physical address at all? We do need the physical
 address in some cases, it's just not very often in normal code.  The physical
 address is needed if you use memory mappings, for example, because the
-"remap_page_range()" mm function wants the physical address of the memory to
-be remapped (the memory management layer doesn't know about devices outside
-the CPU, so it shouldn't need to know about "bus addresses" etc). 
+"remap_pfn_range()" mm function wants the physical address of the memory to
+be remapped, as measured in units of pages, a.k.a. the pfn (the memory
+management layer doesn't know about devices outside the CPU, so it
+shouldn't need to know about "bus addresses" etc). 
 
 NOTE NOTE NOTE! The above is only one part of the whole equation. The above
 only talks about "real memory", that is, CPU memory (RAM). 
