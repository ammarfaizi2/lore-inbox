Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWJILAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWJILAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWJILAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:00:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:25245 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751798AbWJILAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:00:09 -0400
Date: Mon, 9 Oct 2006 13:00:07 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061009110007.GA3592@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site> <20061007134407.6aa4dd26.akpm@osdl.org> <1160351174.14601.3.camel@localhost.localdomain> <20061009102635.GC3487@wotan.suse.de> <1160391014.10229.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160391014.10229.16.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 08:50:14PM +1000, Benjamin Herrenschmidt wrote:
> 
> > The truncate logic can't be duplicated because it works on struct pages.
> > 
> > What sounds best, if you use nopfn, is to do your own internal
> > synchronisation against your unmap call. Obviously you can't because you
> > have no ->nopfn_done call with which to drop locks ;)
> > 
> > So, hmm yes I have a good idea for how fault() could take over ->nopfn as
> > well: just return NULL, set the fault type to VM_FAULT_MINOR, and have
> > the ->fault handler install the pte. It will require a new helper along
> > the lines of vm_insert_page.
> > 
> > I'll code that up in my next patchset.
> 
> Which is exactly what I was proposing in my other mail :)
> 
> Read it, you'll understnad my point about the truncate logic... I
> sometimes want to return struct page (when the mapping is pointing to
> backup memory) or map it directly to hardware.
> 
> In the later case, with an appropriate helper, I can definitely do my
> own locking. In the former case, I return struct page's and need the
> truncate logic.

Yep, I see. You just need to be careful about the PFNMAP logic, so
the VM knows whether the pte is backed by a struct page or not.
And going the pageless route means that you must disallow MAP_PRIVATE
PROT_WRITE mappings, I trust that isn't a problem for you?

I guess the helper looks something like the following...

--

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -1105,6 +1105,7 @@ unsigned long vmalloc_to_pfn(void *addr)
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
@@ -1267,6 +1267,44 @@ int vm_insert_page(struct vm_area_struct
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+/**
+ * vm_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_inert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply
+ */
+int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int retval;
+	pte_t *pte;
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
+	set_pte_at(mm, addr, pte, pfn_pte(pfn, vma->vm_page_prot));
+
+	vma->vm_flags |= VM_PFNMAP;
+	retval = 0;
+out_unlock:
+	pte_unmap_unlock(pte, ptl);
+out:
+	return retval;
+}
+EXPORT_SYMBOL(vm_insert_pfn);
+
 /*
  * maps a range of physical memory into the requested pages. the old
  * mappings are removed. any references to nonexistent pages results
