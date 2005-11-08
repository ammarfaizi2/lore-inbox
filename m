Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVKHDq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVKHDq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKHDq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:46:28 -0500
Received: from ozlabs.org ([203.10.76.45]:21651 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932465AbVKHDq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:46:26 -0500
Date: Tue, 8 Nov 2005 14:46:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       akpm@osdl.org
Subject: Re: [RFC 2/2] Hugetlb COW
Message-ID: <20051108034613.GD14336@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	akpm@osdl.org
References: <1131397841.25133.90.camel@localhost.localdomain> <1131399533.25133.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131399533.25133.104.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:38:53PM -0600, Adam Litke wrote:
> [RFC] COW for hugepages
> (Patch originally from David Gibson <dwg@au1.ibm.com>)

Just realised there's at least one seriouss bug in the patch -
find_or_alloc_huge_page() can return a non-locked page when demand
faulting a PRIVATE mapping.  That will cause the unlock_page() further
down to BUG().  Here's a corrected version.

This patch implements copy-on-write for hugepages, hence allowing
MAP_SHARED mappings of hugetlbfs.

This is chiefly useful for cases where we want to use hugepages
"automatically" - that is to map hugepages without the knowledge of
the code in the final application (either via kernel hooks, or with
LD_PRELOAD).  We can use various heuristics to determine when
hugepages might be a good idea, but changing the semantics of
anonymous memory from MAP_PRIVATE to MAP_SHARED without the app's
knowledge is clearly wrong.

Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2005-11-08 14:04:59.000000000 +1100
+++ working-2.6/fs/hugetlbfs/inode.c	2005-11-08 14:05:04.000000000 +1100
@@ -100,9 +100,6 @@
 	loff_t len, vma_len;
 	int ret;
 
-	if ((vma->vm_flags & (VM_MAYSHARE | VM_WRITE)) == VM_WRITE)
-		return -EINVAL;
-
 	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
 		return -EINVAL;
 
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2005-11-08 14:04:59.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2005-11-08 14:05:04.000000000 +1100
@@ -65,6 +65,17 @@
 			      pte_t *ptep);
 #endif
 
+#define huge_ptep_set_wrprotect(mm, addr, ptep) ptep_set_wrprotect(mm, addr, ptep)
+static inline void set_huge_ptep_writable(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep)
+{
+	pte_t entry;
+
+	entry = pte_mkwrite(pte_mkdirty(*ptep));
+	ptep_set_access_flags(vma, address, ptep, entry, 1);
+	update_mmu_cache(vma, address, entry);
+}
+
 #ifndef ARCH_HAS_HUGETLB_PREFAULT_HOOK
 #define hugetlb_prefault_arch_hook(mm)		do { } while (0)
 #else
Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2005-11-08 14:05:04.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2005-11-08 14:21:13.000000000 +1100
@@ -255,11 +255,12 @@
 	.nopage = hugetlb_nopage,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
+static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+			   int writable)
 {
 	pte_t entry;
 
-	if (vma->vm_flags & VM_WRITE) {
+	if (writable) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	} else {
@@ -277,6 +278,9 @@
 	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
 	unsigned long addr;
+	int cow;
+
+	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		src_pte = huge_pte_offset(src, addr);
@@ -288,6 +292,8 @@
 		spin_lock(&dst->page_table_lock);
 		spin_lock(&src->page_table_lock);
 		if (!pte_none(*src_pte)) {
+			if (cow)
+				huge_ptep_set_wrprotect(src, addr, src_pte);
 			entry = *src_pte;
 			ptepage = pte_page(entry);
 			get_page(ptepage);
@@ -340,7 +346,7 @@
 }
 
 static struct page *find_or_alloc_huge_page(struct address_space *mapping,
-					    unsigned long idx)
+					    unsigned long idx, int shared)
 {
 	struct page *page;
 	int err;
@@ -359,26 +365,81 @@
 		return NULL;
 	}
 
-	err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
-	if (err) {
-		put_page(page);
-		hugetlb_put_quota(mapping);
-		if (err == -EEXIST)
-			goto retry;
-		page = NULL;
+	if (shared) {
+		err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
+		if (err) {
+			put_page(page);
+			hugetlb_put_quota(mapping);
+			if (err == -EEXIST)
+				goto retry;
+			page = NULL;
+		}
+	} else {
+		/* Caller expects a locked page */
+		lock_page(page);
 	}
 
 	return page;
 }
 
-int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    unsigned long address, pte_t *ptep)
+static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
+		       unsigned long address, pte_t *ptep, pte_t pte)
+{
+	struct page *old_page, *new_page;
+	int i, avoidcopy;
+
+	old_page = pte_page(pte);
+
+	/* If no-one else is actually using this page, avoid the copy
+	 * and just make the page writable */
+	avoidcopy = (page_count(old_page) == 1);
+	if (avoidcopy) {
+		set_huge_ptep_writable(vma, address, ptep);
+		return VM_FAULT_MINOR;
+	}
+
+	page_cache_get(old_page);
+	new_page = alloc_huge_page();
+
+	if (! new_page) {
+		page_cache_release(old_page);
+
+		/* Logically this is OOM, not a SIGBUS, but an OOM
+		 * could cause the kernel to go killing other
+		 * processes which won't help the hugepage situation
+		 * at all (?) */
+		return VM_FAULT_SIGBUS;
+	}
+
+	spin_unlock(&mm->page_table_lock);
+	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++)
+		copy_user_highpage(new_page + i, old_page + i,
+				   address + i*PAGE_SIZE);
+	spin_lock(&mm->page_table_lock);
+
+	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
+	if (likely(pte_same(*ptep, pte))) {
+		/* Break COW */
+		set_huge_pte_at(mm, address, ptep,
+				make_huge_pte(vma, new_page, 1));
+		/* Make the old page be freed below */
+		new_page = old_page;
+	}
+	page_cache_release(new_page);
+	page_cache_release(old_page);
+	return VM_FAULT_MINOR;
+}
+
+static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			   unsigned long address, pte_t *ptep,
+			   int write_access)
 {
 	int ret;
 	unsigned long idx;
 	unsigned long size;
 	struct page *page;
 	struct address_space *mapping;
+	pte_t new_pte;
 
 	mapping = vma->vm_file->f_mapping;
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
@@ -386,10 +447,13 @@
 
 	/* This returns a locked page, which keeps us safe in the
 	 * event of a race with truncate() */
-	page = find_or_alloc_huge_page(mapping, idx);
+	page = find_or_alloc_huge_page(mapping, idx,
+				       vma->vm_flags & VM_SHARED);
 	if (!page)
 		return VM_FAULT_SIGBUS;
 
+	BUG_ON(!PageLocked(page));
+
 	spin_lock(&mm->page_table_lock);
 
 	ret = VM_FAULT_SIGBUS;
@@ -405,7 +469,16 @@
 		goto backout;
 
 	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
-	set_huge_pte_at(mm, address, ptep, make_huge_pte(vma, page));
+
+	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
+					    && (vma->vm_flags & VM_SHARED)));
+
+	set_huge_pte_at(mm, address, ptep, new_pte);
+
+	if (write_access && !(vma->vm_flags & VM_SHARED)) {
+		/* Optimization, do the COW without a second fault */
+		ret = hugetlb_cow(mm, vma, address, ptep, new_pte);
+	}
 
 	spin_unlock(&mm->page_table_lock);
 	unlock_page(page);
@@ -426,6 +499,7 @@
 {
 	pte_t *ptep;
 	pte_t entry;
+	int ret;
 
 	ptep = huge_pte_alloc(mm, address);
 	if (! ptep)
@@ -434,12 +508,20 @@
 	entry = *ptep;
 
 	if (pte_none(entry))
-		return hugetlb_no_page(mm, vma, address, ptep);
+		return hugetlb_no_page(mm, vma, address, ptep, write_access);
 
-	/* we could get here if another thread instantiated the pte
-	 * before the test above */
+	ret = VM_FAULT_MINOR;
 
-	return VM_FAULT_MINOR;
+	spin_lock(&mm->page_table_lock);
+
+	if (likely(pte_same(entry, *ptep)))
+		/* pte could have changed before we grabbed the lock */
+		if (write_access && !pte_write(entry))
+			ret = hugetlb_cow(mm, vma, address, ptep, entry);
+
+	spin_unlock(&mm->page_table_lock);
+
+	return ret;
 }
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2005-11-08 14:04:59.000000000 +1100
+++ working-2.6/mm/mmap.c	2005-11-08 14:05:04.000000000 +1100
@@ -1076,7 +1076,7 @@
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED))
+		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED | VM_HUGETLB))
 						== (VM_WRITE | VM_RESERVED)) {
 			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
 				"PROT_WRITE mmap of VM_RESERVED memory, which "


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
