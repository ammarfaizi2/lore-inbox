Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWCVGhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWCVGhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWCVGhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:37:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42369 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750884AbWCVGhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:47 -0500
Message-Id: <20060322063805.741915000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 30/35] Add generic_page_range() function
Content-Disposition: inline; filename=29-generic-page-range
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new mm function generic_page_range() which applies a given
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
 mm/memory.c        |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

--- xen-subarch-2.6.orig/include/linux/mm.h
+++ xen-subarch-2.6/include/linux/mm.h
@@ -1013,6 +1013,11 @@ struct page *follow_page(struct vm_area_
 #define FOLL_GET	0x04	/* do get_page on page */
 #define FOLL_ANON	0x08	/* give ZERO_PAGE if no pgtable */
 
+typedef int (*pte_fn_t)(pte_t *pte, struct page *pte_page, unsigned long addr,
+                        void *data);
+extern int generic_page_range(struct mm_struct *mm, unsigned long address,
+                              unsigned long size, pte_fn_t fn, void *data);
+
 #ifdef CONFIG_PROC_FS
 void vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
--- xen-subarch-2.6.orig/mm/memory.c
+++ xen-subarch-2.6/mm/memory.c
@@ -1359,6 +1359,96 @@ int remap_pfn_range(struct vm_area_struc
 }
 EXPORT_SYMBOL(remap_pfn_range);
 
+static inline int generic_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				    unsigned long addr, unsigned long end,
+				    pte_fn_t fn, void *data)
+{
+	pte_t *pte;
+	int err;
+	struct page *pte_page;
+
+	pte = (mm == &init_mm) ?
+		pte_alloc_kernel(pmd, addr) :
+		pte_alloc_map(mm, pmd, addr);
+	if (!pte)
+		return -ENOMEM;
+
+	pte_page = pmd_page(*pmd);
+
+	do {
+		err = fn(pte, pte_page, addr, data);
+		if (err)
+			break;
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	if (mm != &init_mm)
+		pte_unmap(pte-1);
+	return err;
+}
+
+static inline int generic_pmd_range(struct mm_struct *mm, pud_t *pud,
+				    unsigned long addr, unsigned long end,
+				    pte_fn_t fn, void *data)
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
+		err = generic_pte_range(mm, pmd, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pmd++, addr = next, addr != end);
+	return err;
+}
+
+static inline int generic_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				    unsigned long addr, unsigned long end,
+				    pte_fn_t fn, void *data)
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
+		err = generic_pmd_range(mm, pud, addr, next, fn, data);
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
+int generic_page_range(struct mm_struct *mm, unsigned long addr,
+		       unsigned long size, pte_fn_t fn, void *data)
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
+		err = generic_pud_range(mm, pgd, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr != end);
+	return err;
+}
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry
  * which was read non-atomically.  Before making any commitment, on

--
