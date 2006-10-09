Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932963AbWJIQNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbWJIQNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932959AbWJIQNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:13:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:62633 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932967AbWJIQNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:13:04 -0400
From: Nick Piggin <npiggin@suse.de>
To: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20061009140447.13840.20975.sendpatchset@linux.site>
In-Reply-To: <20061009140354.13840.71273.sendpatchset@linux.site>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
Subject: [patch 4/5] mm: add vm_insert_pfn helpler
Date: Mon,  9 Oct 2006 18:12:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vm_insert_pfn helper, so that ->fault handlers can have nopfn
functionality by installing their own pte and returning NULL.

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -1104,6 +1104,7 @@ unsigned long vmalloc_to_pfn(void *addr)
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
+int vm_insert_pfn(struct vm_area_struct *, unsigned long addr, unsigned long pfn);
 
 struct page *follow_page(struct vm_area_struct *, unsigned long address,
 			unsigned int foll_flags);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -1267,6 +1267,50 @@ int vm_insert_page(struct vm_area_struct
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+/**
+ * vm_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_inert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply.
+ *
+ * This function should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return NULL.
+ */
+int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int retval;
+	pte_t *pte, entry;
+	spinlock_t *ptl;
+
+	BUG_ON(is_cow_mapping(vma->vm_flags));
+
+	retval = -ENOMEM;
+	pte = get_locked_pte(mm, addr, &ptl);
+	if (!pte)
+		goto out;
+	retval = -EBUSY;
+	if (!pte_none(*pte))
+		goto out_unlock;
+
+	/* Ok, finally just insert the thing.. */
+	entry = pfn_pte(pfn, vma->vm_page_prot);
+	set_pte_at(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, entry);
+
+	vma->vm_flags |= VM_PFNMAP;
+	retval = 0;
+out_unlock:
+	pte_unmap_unlock(pte, ptl);
+
+out:
+	return retval;
+}
+EXPORT_SYMBOL(vm_insert_pfn);
+
 /*
  * maps a range of physical memory into the requested pages. the old
  * mappings are removed. any references to nonexistent pages results
