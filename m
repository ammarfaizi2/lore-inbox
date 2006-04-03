Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWDCLbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWDCLbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 07:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWDCLbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 07:31:20 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:24036 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750900AbWDCLbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 07:31:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: [patch] do_no_pfn handler
From: Jes Sorensen <jes@sgi.com>
Date: 03 Apr 2006 07:32:01 -0400
Message-ID: <yq0k6a6uc7i.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached is a repost of the do_no_pfn handler patch which is needed
for the MSPEC driver and Bjorn and Carsten have expressed strong
interest in using this interface for other things as well.

You mentioned earlier that you preferred an alternative approach, do
you still feel that given the additional interest from other Bjorn and
Carsten? If this is still the case, I'd love to get some guidance as
to what that should be.

I had hoped to get this in before 2.6.17 closed, but I guess I missed
that window. If we can agree on the interface it would be ok for the
-mm series for a while.

Thanks,
Jes

Implement do_no_pfn() for handling mapping of memory without a struct
page backing it. This avoids creating fake page table entries for
regions which are not backed by real memory.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 include/linux/mm.h |    1 +
 mm/memory.c        |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -199,6 +199,7 @@
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
+	long (*nopfn)(struct vm_area_struct * area, unsigned long address, int *type);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 #ifdef CONFIG_NUMA
 	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2146,6 +2146,51 @@
 }
 
 /*
+ * do_no_pfn() tries to create a new page mapping for a page without
+ * a struct_page backing it
+ *
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
+ *
+ * We enter with non-exclusive mmap_sem (to exclude vma changes,
+ * but allow concurrent faults), and pte mapped but not yet locked.
+ * We return with mmap_sem still held, but pte unmapped and unlocked.
+ *
+ * It is expected that the ->nopfn handler always returns the same pfn
+ * for a given virtual mapping.
+ */
+static int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long address, pte_t *page_table, pmd_t *pmd,
+		     int write_access)
+{
+	spinlock_t *ptl;
+	pte_t entry;
+	long pfn;
+	int ret = VM_FAULT_MINOR;
+
+	pte_unmap(page_table);
+	BUG_ON(!(vma->vm_flags & VM_PFNMAP));
+
+	pfn = vma->vm_ops->nopfn(vma, address & PAGE_MASK, &ret);
+	if (pfn == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (pfn == -EFAULT)
+		return VM_FAULT_SIGBUS;
+	if (pfn < 0)
+		return VM_FAULT_SIGBUS;
+
+	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
+
+	entry = pfn_pte(pfn, vma->vm_page_prot);
+	if (write_access)
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	set_pte_at(mm, address, page_table, entry);
+
+	pte_unmap_unlock(page_table, ptl);
+	return ret;
+}
+
+/*
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
  * nonlinear vmas.
@@ -2207,9 +2252,13 @@
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
-			if (!vma->vm_ops || !vma->vm_ops->nopage)
+			if (!vma->vm_ops ||
+			    (!vma->vm_ops->nopage && !vma->vm_ops->nopfn))
 				return do_anonymous_page(mm, vma, address,
 					pte, pmd, write_access);
+			if (vma->vm_ops->nopfn)
+				return do_no_pfn(mm, vma, address,
+						 pte, pmd, write_access);
 			return do_no_page(mm, vma, address,
 					pte, pmd, write_access);
 		}
