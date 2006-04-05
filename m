Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWDEJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWDEJeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWDEJeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:34:07 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:20422 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751193AbWDEJeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:34:05 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq01wwdppyc.fsf@jaguar.mkp.net>
	<4432530A.70606@yahoo.com.au>
From: Jes Sorensen <jes@sgi.com>
Date: 05 Apr 2006 05:34:31 -0400
In-Reply-To: <4432530A.70606@yahoo.com.au>
Message-ID: <yq0vetonz6g.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nick" == Nick Piggin <nickpiggin@yahoo.com.au> writes:

Nick> Jes Sorensen wrote:
>> Hi, Ingo Oeser suggested reorganizing the hangle_pte_fault code in
>> a way that simplifies the code deciding which fault handler to
>> call. It makes the call to ->nopfn and ->nopage a lot clearer.

Nick> Probably doesn't make much difference, but I'd rather do the
Nick> nopage check first, as that will obviously be the most common.

Hi Nick,

Fair 'nuff. I guess I had had a more hierarchical approach in mind,
but then a driver really shouldn't provide both.

Nick> Other than that, you never know what a nopfn handler will want
Nick> to do, so I think it is better to be consistent with other
Nick> faults. Shouldn't need much more than a `if (pte_none()) { /* do
Nick> it */ }`.

Like this?

Thanks for the input, updated patch attached.

Cheers,
Jes

Implement do_no_pfn() for handling mapping of memory without a struct
page backing it. This avoids creating fake page table entries for
regions which are not backed by real memory.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 include/linux/mm.h |    1 
 mm/memory.c        |   63 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 5 deletions(-)

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
@@ -2146,6 +2146,53 @@
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
+	/* Only go through if we didn't race with anybody else... */
+	if (pte_none(*page_table)) {
+		entry = pfn_pte(pfn, vma->vm_page_prot);
+		if (write_access)
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		set_pte_at(mm, address, page_table, entry);
+	}
+	pte_unmap_unlock(page_table, ptl);
+	return ret;
+}
+
+/*
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
  * nonlinear vmas.
@@ -2207,11 +2254,17 @@
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
-			if (!vma->vm_ops || !vma->vm_ops->nopage)
-				return do_anonymous_page(mm, vma, address,
-					pte, pmd, write_access);
-			return do_no_page(mm, vma, address,
-					pte, pmd, write_access);
+			if (vma->vm_ops) {
+				if (vma->vm_ops->nopage)
+					return do_no_page(mm, vma, address,
+							  pte, pmd,
+							  write_access);
+				if (vma->vm_ops->nopfn)
+					return do_no_pfn(mm, vma, address, pte,
+							 pmd, write_access);
+			}
+			return do_anonymous_page(mm, vma, address,
+						 pte, pmd, write_access);
 		}
 		if (pte_file(entry))
 			return do_file_page(mm, vma, address,
