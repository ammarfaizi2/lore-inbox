Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWFSJTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWFSJTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWFSJTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:19:08 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:34282 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751265AbWFSJTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:19:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, Carsten Otte <cotte@de.ibm.com>,
       bjorn_helgaas@hp.com
Subject: [patch] do_no_pfn
From: Jes Sorensen <jes@sgi.com>
Date: 19 Jun 2006 05:19:05 -0400
Message-ID: <yq0psh5zenq.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I woke up this morning and had a revelation! Today is the day, the day
of do_no_pfn()! It can be no other way ... :) And what happens, I come
into the office to discover that 2.6.17 is out! It has to be a sign!

Anyway, I have had no objections to this patch for a while now,
clearly it is perfect<tm> :) If anybody has new objections, it's
obviously not my fault! But ok I'll look at them anyway :)

So here it is, it even boots!

Cheers,
Jes

Implement do_no_pfn() for handling mapping of memory without a struct
page backing it. This avoids creating fake page table entries for
regions which are not backed by real memory.

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
@@ -199,6 +199,7 @@
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
+	unsigned long (*nopfn)(struct vm_area_struct * area, unsigned long address);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 #ifdef CONFIG_NUMA
 	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
@@ -612,6 +613,12 @@
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
@@ -2146,6 +2146,52 @@
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
@@ -2207,11 +2253,17 @@
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
