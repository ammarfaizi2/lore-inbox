Return-Path: <linux-kernel-owner+w=401wt.eu-S1161230AbXAMD27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbXAMD27 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbXAMD26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:28:58 -0500
Received: from ns2.suse.de ([195.135.220.15]:46815 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161215AbXAMD2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:28:54 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, thomas@tungstengraphics.com
Message-Id: <20070113011633.9479.16247.sendpatchset@linux.site>
In-Reply-To: <20070113011526.9479.79596.sendpatchset@linux.site>
References: <20070113011526.9479.79596.sendpatchset@linux.site>
Subject: [patch 6/7] mm: merge nopfn into fault
Date: Sat, 13 Jan 2007 04:28:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ->nopfn and reimplement the only existing handler using ->fault

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/char/mspec.c
===================================================================
--- linux-2.6.orig/drivers/char/mspec.c
+++ linux-2.6/drivers/char/mspec.c
@@ -182,24 +182,25 @@ mspec_close(struct vm_area_struct *vma)
 
 
 /*
- * mspec_nopfn
+ * mspec_fault
  *
  * Creates a mspec page and maps it to user space.
  */
-static unsigned long
-mspec_nopfn(struct vm_area_struct *vma, unsigned long address)
+static struct page *
+mspec_fault(struct fault_data *fdata)
 {
 	unsigned long paddr, maddr;
 	unsigned long pfn;
-	int index;
-	struct vma_data *vdata = vma->vm_private_data;
+	int index = fdata->pgoff;
+	struct vma_data *vdata = fdata->vma->vm_private_data;
 
-	index = (address - vma->vm_start) >> PAGE_SHIFT;
 	maddr = (volatile unsigned long) vdata->maddr[index];
 	if (maddr == 0) {
 		maddr = uncached_alloc_page(numa_node_id());
-		if (maddr == 0)
-			return NOPFN_OOM;
+		if (maddr == 0) {
+			fdata->type = VM_FAULT_OOM;
+			return NULL;
+		}
 
 		spin_lock(&vdata->lock);
 		if (vdata->maddr[index] == 0) {
@@ -219,13 +220,21 @@ mspec_nopfn(struct vm_area_struct *vma, 
 
 	pfn = paddr >> PAGE_SHIFT;
 
-	return pfn;
+	fdata->type = VM_FAULT_MINOR;
+	/*
+	 * vm_insert_pfn can fail with -EBUSY, but in that case it will
+	 * be because another thread has installed the pte first, so it
+	 * is no problem.
+	 */
+	vm_insert_pfn(fdata->vma, fdata->address, pfn);
+
+	return NULL;
 }
 
 static struct vm_operations_struct mspec_vm_ops = {
 	.open = mspec_open,
 	.close = mspec_close,
-	.nopfn = mspec_nopfn
+	.fault = mspec_fault,
 };
 
 /*
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -228,7 +228,6 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*fault)(struct vm_area_struct *vma, struct fault_data * fdata);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
-	unsigned long (*nopfn)(struct vm_area_struct * area, unsigned long address);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 
 	/* notification that a previously read-only page is about to become
@@ -659,12 +658,6 @@ static inline int page_mapped(struct pag
 #define NOPAGE_OOM	((struct page *) (-1))
 
 /*
- * Error return values for the *_nopfn functions
- */
-#define NOPFN_SIGBUS	((unsigned long) -1)
-#define NOPFN_OOM	((unsigned long) -2)
-
-/*
  * Different kinds of faults, as returned by handle_mm_fault().
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -1288,6 +1288,11 @@ EXPORT_SYMBOL(vm_insert_page);
  *
  * This function should only be called from a vm_ops->fault handler, and
  * in that case the handler should return NULL.
+ *
+ * vma cannot be a COW mapping.
+ *
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
  */
 int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
 {
@@ -2346,54 +2351,6 @@ static int do_nonlinear_fault(struct mm_
 }
 
 /*
- * do_no_pfn() tries to create a new page mapping for a page without
- * a struct_page backing it
- *
- * As this is called only for pages that do not currently exist, we
- * do not need to flush old virtual caches or the TLB.
- *
- * We enter with non-exclusive mmap_sem (to exclude vma changes,
- * but allow concurrent faults), and pte mapped but not yet locked.
- * We return with mmap_sem still held, but pte unmapped and unlocked.
- *
- * It is expected that the ->nopfn handler always returns the same pfn
- * for a given virtual mapping.
- *
- * Mark this `noinline' to prevent it from bloating the main pagefault code.
- */
-static noinline int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
-		     unsigned long address, pte_t *page_table, pmd_t *pmd,
-		     int write_access)
-{
-	spinlock_t *ptl;
-	pte_t entry;
-	unsigned long pfn;
-	int ret = VM_FAULT_MINOR;
-
-	pte_unmap(page_table);
-	BUG_ON(!(vma->vm_flags & VM_PFNMAP));
-	BUG_ON(is_cow_mapping(vma->vm_flags));
-
-	pfn = vma->vm_ops->nopfn(vma, address & PAGE_MASK);
-	if (pfn == NOPFN_OOM)
-		return VM_FAULT_OOM;
-	if (pfn == NOPFN_SIGBUS)
-		return VM_FAULT_SIGBUS;
-
-	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
-
-	/* Only go through if we didn't race with anybody else... */
-	if (pte_none(*page_table)) {
-		entry = pfn_pte(pfn, vma->vm_page_prot);
-		if (write_access)
-			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte_at(mm, address, page_table, entry);
-	}
-	pte_unmap_unlock(page_table, ptl);
-	return ret;
-}
-
-/*
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
  * nonlinear vmas.
@@ -2464,9 +2421,6 @@ static inline int handle_pte_fault(struc
 				if (vma->vm_ops->fault || vma->vm_ops->nopage)
 					return do_linear_fault(mm, vma, address,
 						pte, pmd, write_access, entry);
-				if (unlikely(vma->vm_ops->nopfn))
-					return do_no_pfn(mm, vma, address, pte,
-							 pmd, write_access);
 			}
 			return do_anonymous_page(mm, vma, address,
 						 pte, pmd, write_access);
