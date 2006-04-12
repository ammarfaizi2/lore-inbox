Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWDLJJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWDLJJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWDLJJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:09:29 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:4493 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750928AbWDLJJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:09:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net>
	<Pine.LNX.4.64.0604110751510.10745@g5.osdl.org>
From: Jes Sorensen <jes@sgi.com>
Date: 12 Apr 2006 05:09:25 -0400
In-Reply-To: <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org>
Message-ID: <yq0slojtb22.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> On Tue, 11 Apr 2006, Jes Sorensen wrote:
>>  You mentioned earlier that you preferred an alternative approach,
>> do you still feel that given the additional interest from other
>> Bjorn and Carsten? If this is still the case, I'd love to get some
>> guidance as to what that should be.

Linus> I'm still pretty unhappy with this. It's pretty much designed
Linus> to screw up the system by letting the driver do random things
Linus> that make little or no sense from a VM standpoint.

Hi Linus,

I'd love to come up with another way to do it, but this still comes
back as the cleanest to me :( I've tried to limit the damage based on
your comments.

Linus> At the very least, it would also need a

Linus> 	BUG_ON(is_cow_mapping(vma->vm_flags));

Added - I am not sure how this will affect Carsten's situation based
on the further discussion in this thread, however if something changes
at that point I assume we can modify the limitation at a later stage.

Linus> It also assumes that a negative pfn is ok as an error return,
Linus> but maybe that's fine. I can't think of any architecture that
Linus> uses all bits of the PFN (x86 with PAE can have a full 32-bit
Linus> PFN, but I don't think any actual CPU supports 48 bits of
Linus> physical addressing?). Something to think about.

Good catch! I think it goes back to when the mspec driver abused the
nopage interface. The previous version was passing `ret' to the driver
as well as looking at the pfn return value. I don't think the driver
should modify `ret' directly, so I have changed it to use two specific
pfn error values (NOPFN_OOM and NOPFN_SIGBUS), similar to how the
nopage handler works. I think the original intention was to catch all
potential errors a driver could stick in, but thinking about it again
I don't think it makes sense to try that.

Anyway, I hope you like this version of the nopfn code better! Update
version of the mspec driver to match it will follow in a minute.

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
+	long (*nopfn)(struct vm_area_struct * area, unsigned long address);
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
