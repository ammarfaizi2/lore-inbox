Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWF0Mqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWF0Mqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWF0Mqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:46:46 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:45480 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932300AbWF0Mqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:46:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, bjorn_helgaas@hp.com, holt@sgi.com
Subject: [patch] do_no_pfn - against latest git
References: <yq0psh5zenq.fsf@jaguar.mkp.net>
From: Jes Sorensen <jes@sgi.com>
Date: 27 Jun 2006 08:46:44 -0400
In-Reply-To: <yq0psh5zenq.fsf@jaguar.mkp.net>
Message-ID: <yq0hd26ix57.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Included is the latest diff of the do_no_pfn patch against the latest
git tree. Since there has been no new objections to this one, it would
be nice to get it in before 2.6.18 closes.

Thanks,
Jes

Implement do_no_pfn() for handling mapping of memory without a struct
page backing it. This avoids creating fake page table entries for
regions which are not backed by real memory.

This feature is used by the MSPEC driver and other users, where it is
highly undesirable to have a struct page sitting behind the page
(for instance if the page is accessed in cached mode via the struct
page in parallel to the the driver accessing it uncached, which can
result in data corruption on some architectures, such as ia64).

This version uses specific NOPFN_{SIGBUS,OOM} return values, rather
than expect all negative pfn values would be an error. It also bugs on
cow mappings as this would not work with the VM.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 include/linux/mm.h |    7 +++++
 mm/memory.c        |   62 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 5 deletions(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -197,6 +197,7 @@ struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
+	unsigned long (*nopfn)(struct vm_area_struct * area, unsigned long address);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 
 	/* notification that a previously read-only page is about to become
@@ -619,6 +620,12 @@ static inline int page_mapped(struct pag
 #define NOPAGE_OOM	((struct page *) (-1))
 
 /*
+ * Error return values for the *_nopfn functions
+ */
+#define NOPFN_SIGBUS	((unsigned long) -1)
+#define NOPFN_OOM	((unsigned long) -2)
+
+/*
  * Different kinds of faults, as returned by handle_mm_fault().
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2207,6 +2207,52 @@ oom:
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
+	unsigned long pfn;
+	int ret = VM_FAULT_MINOR;
+
+	pte_unmap(page_table);
+	BUG_ON(!(vma->vm_flags & VM_PFNMAP));
+	BUG_ON(is_cow_mapping(vma->vm_flags));
+
+	pfn = vma->vm_ops->nopfn(vma, address & PAGE_MASK);
+	if (pfn == NOPFN_OOM)
+		return VM_FAULT_OOM;
+	if (pfn == NOPFN_SIGBUS)
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
@@ -2268,11 +2314,17 @@ static inline int handle_pte_fault(struc
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
