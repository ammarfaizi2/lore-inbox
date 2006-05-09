Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWEII75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWEII75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWEIItG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:06 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:48259 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751487AbWEIIsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:51 -0400
Message-Id: <20060509085159.621872000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:30 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 30/35] Add apply_to_page_range() function
Content-Disposition: inline; filename=apply-to-page-range
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new mm function apply_to_page_range() which applies a given
function to every pte in a given virtual address range in a given mm
structure. This is a generic alternative to cut-and-pasting the Linux
idiomatic pagetable walking code in every place that a sequence of
PTEs must be accessed.

Although this interface is intended to be useful in a wide range of
situations, it is currently used specifically by several Xen
subsystems, for example: to ensure that pagetables have been allocated
for a virtual address range, and to construct batched special
pagetable update requests to map I/O memory (in ioremap()).

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/linux/mm.h |    5 ++
 mm/memory.c        |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

--- linus-2.6.orig/include/linux/mm.h
+++ linus-2.6/include/linux/mm.h
@@ -1014,6 +1014,11 @@ struct page *follow_page(struct vm_area_
 #define FOLL_GET	0x04	/* do get_page on page */
 #define FOLL_ANON	0x08	/* give ZERO_PAGE if no pgtable */
 
+typedef int (*pte_fn_t)(pte_t *pte, struct page *pmd_page, unsigned long addr,
+			void *data);
+extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
+			       unsigned long size, pte_fn_t fn, void *data);
+
 #ifdef CONFIG_PROC_FS
 void vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
--- linus-2.6.orig/mm/memory.c
+++ linus-2.6/mm/memory.c
@@ -1356,6 +1356,100 @@ int remap_pfn_range(struct vm_area_struc
 }
 EXPORT_SYMBOL(remap_pfn_range);
 
+static inline int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				     unsigned long addr, unsigned long end,
+				     pte_fn_t fn, void *data)
+{
+	pte_t *pte;
+	int err;
+	struct page *pmd_page;
+	spinlock_t *ptl;
+
+	pte = (mm == &init_mm) ?
+		pte_alloc_kernel(pmd, addr) :
+		pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return -ENOMEM;
+
+	BUG_ON(pmd_huge(*pmd));
+
+	pmd_page = pmd_page(*pmd);
+
+	do {
+		err = fn(pte, pmd_page, addr, data);
+		if (err)
+			break;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	if (mm != &init_mm)
+		pte_unmap_unlock(pte-1, ptl);
+	return err;
+}
+
+static inline int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
+				     unsigned long addr, unsigned long end,
+				     pte_fn_t fn, void *data)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	int err;
+
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+		err = apply_to_pte_range(mm, pmd, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pmd++, addr = next, addr != end);
+	return err;
+}
+
+static inline int apply_to_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				     unsigned long addr, unsigned long end,
+				     pte_fn_t fn, void *data)
+{
+	pud_t *pud;
+	unsigned long next;
+	int err;
+
+	pud = pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+		err = apply_to_pmd_range(mm, pud, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pud++, addr = next, addr != end);
+	return err;
+}
+
+/*
+ * Scan a region of virtual memory, filling in page tables as necessary
+ * and calling a provided function on each leaf page table.
+ */
+int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
+			unsigned long size, pte_fn_t fn, void *data)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	unsigned long end = addr + size;
+	int err;
+
+	BUG_ON(addr >= end);
+	pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = apply_to_pud_range(mm, pgd, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+	return err;
+}
+EXPORT_SYMBOL_GPL(apply_to_page_range);
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry
  * which was read non-atomically.  Before making any commitment, on

--
