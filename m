Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCQM2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCQM2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWCQM2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:28:22 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:64187 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932102AbWCQM2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:28:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hch@lst.de, cotte@de.ibm.com,
       Hugh Dickins <hugh@veritas.com>
Subject: [patch 1/2] do_no_pfn handler (was: Re: [patch] mspec - special memory driver and do_no_pfn handler)
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>
	<20060316163728.06f49c00.akpm@osdl.org>
From: Jes Sorensen <jes@sgi.com>
Date: 17 Mar 2006 07:28:09 -0500
In-Reply-To: <20060316163728.06f49c00.akpm@osdl.org>
Message-ID: <yq0fylhuug6.fsf_-_@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Jes Sorensen <jes@sgi.com> wrote:
>>  Hi,
>> 
>> This is an updated version of the mspec driver (special memory
>> support), formerly known as fetchop.
>> 
>> With this version I have implemented a do_no_pfn() handler, similar
>> to the do_no_page() handler but for pages which are not backed by a
>> struct page.

Andrew> hm.  Is that a superset of ->nopage?  Should we be looking at
Andrew> migrating over to ->nopfn, retire ->nopage?

Andrew> <looks at the ghastly stuff in do_no_page>

It wasn't designed to handle all possible cases as a do_no_page
replacement :) My initial thought was that adding an extra op to the
vm_operations_struct was that it wouldn't be very expensive since we
don't allocate all that many of them.

>> Please let me know if there are any objections or comments etc. to
>> this approach. If preferred I can split out the do_no_pfn part into
>> a seperate patch.

Andrew> That would probably be best.

Here goes - if Linus comes back with a suggestion for how to do it in
a different fashion it may obsolete this patch, but at least until
then.

The cleaned up version of the actual mspec driver will be in a
seperate mail.

Cheers,
Jes

Implement do_no_pfn() for handling mapping of memory without a struct
page backing it.

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
@@ -2148,6 +2148,51 @@
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
@@ -2209,9 +2254,13 @@
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

