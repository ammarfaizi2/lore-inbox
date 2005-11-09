Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbVKIXku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbVKIXku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVKIXkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:40:49 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63642 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751606AbVKIXks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:40:48 -0500
Subject: [PATCH 4/4] Hugetlb: Copy on Write support
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, wli@holomorphy.com,
       hugh@veritas.com, rohit.seth@intel.com, kenneth.w.chen@intel.com,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1131578925.28383.9.camel@localhost.localdomain>
References: <1131578925.28383.9.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Wed, 09 Nov 2005 17:39:55 -0600
Message-Id: <1131579596.28383.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb: Copy on Write support

Implement copy-on-write support for hugetlb mappings so MAP_PRIVATE can be
supported.  This helps us to safely use hugetlb pages in many more
applications.  The patch makes the following changes.  If needed, I also have
it broken out according to the following paragraphs.

1. Add a pair of functions to set/clear write access on huge ptes.  The
writable check in make_huge_pte is moved out to the caller for use by COW
later.

2. Hugetlb copy-on-write requires special case handling in the following
situations:
 - copy_hugetlb_page_range() - Copied pages must be write protected so a COW
    fault will be triggered (if necessary) if those pages are written to.
 - find_or_alloc_huge_page() - Only MAP_SHARED pages are added to the page
    cache.  MAP_PRIVATE pages still need to be locked however.

3. Provide hugetlb_cow() and calls from hugetlb_fault() and hugetlb_no_page()
which handles the COW fault by making the actual copy.

4. Remove the check in hugetlbfs_file_map() so that MAP_PRIVATE mmaps will be
allowed.  Make MAP_HUGETLB exempt from the depricated VM_RESERVED mapping
check.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 fs/hugetlbfs/inode.c    |    3 -
 include/linux/hugetlb.h |   12 +++++
 mm/hugetlb.c            |  115 ++++++++++++++++++++++++++++++++++++++++--------
 mm/mmap.c               |    4 -
 4 files changed, 110 insertions(+), 24 deletions(-)
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c
+++ current/fs/hugetlbfs/inode.c
@@ -100,9 +100,6 @@ static int hugetlbfs_file_mmap(struct fi
 	loff_t len, vma_len;
 	int ret;
 
-	if ((vma->vm_flags & (VM_MAYSHARE | VM_WRITE)) == VM_WRITE)
-		return -EINVAL;
-
 	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
 		return -EINVAL;
 
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h
+++ current/include/linux/hugetlb.h
@@ -65,6 +65,18 @@ pte_t huge_ptep_get_and_clear(struct mm_
 			      pte_t *ptep);
 #endif
 
+#define huge_ptep_set_wrprotect(mm, addr, ptep) \
+	ptep_set_wrprotect(mm, addr, ptep)
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
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -255,11 +255,12 @@ struct vm_operations_struct hugetlb_vm_o
 	.nopage = hugetlb_nopage,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page)
+static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+				int writable)
 {
 	pte_t entry;
 
-	if (vma->vm_flags & VM_WRITE) {
+	if (writable) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	} else {
@@ -277,6 +278,9 @@ int copy_hugetlb_page_range(struct mm_st
 	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
 	unsigned long addr;
+	int cow;
+
+	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		src_pte = huge_pte_offset(src, addr);
@@ -288,6 +292,8 @@ int copy_hugetlb_page_range(struct mm_st
 		spin_lock(&dst->page_table_lock);
 		spin_lock(&src->page_table_lock);
 		if (!pte_none(*src_pte)) {
+			if (cow)
+				huge_ptep_set_wrprotect(src, addr, src_pte);
 			entry = *src_pte;
 			ptepage = pte_page(entry);
 			get_page(ptepage);
@@ -340,7 +346,7 @@ void unmap_hugepage_range(struct vm_area
 }
 
 static struct page *find_or_alloc_huge_page(struct address_space *mapping,
-						unsigned long idx)
+				unsigned long idx, int shared)
 {
 	struct page *page;
 	int err;
@@ -358,26 +364,80 @@ retry:
 		goto out;
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
 out:
 	return page;
 }
 
+static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, pte_t pte)
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
 int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, pte_t *ptep)
+			unsigned long address, pte_t *ptep, int write_access)
 {
 	int ret = VM_FAULT_SIGBUS;
 	unsigned long idx;
 	unsigned long size;
 	struct page *page;
 	struct address_space *mapping;
+	pte_t new_pte;
 
 	mapping = vma->vm_file->f_mapping;
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
@@ -387,10 +447,13 @@ int hugetlb_no_page(struct mm_struct *mm
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	page = find_or_alloc_huge_page(mapping, idx);
+	page = find_or_alloc_huge_page(mapping, idx,
+			vma->vm_flags & VM_SHARED);
 	if (!page)
 		goto out;
 
+	BUG_ON(!PageLocked(page));
+
 	spin_lock(&mm->page_table_lock);
 	size = i_size_read(mapping->host) >> HPAGE_SHIFT;
 	if (idx >= size)
@@ -401,7 +464,15 @@ int hugetlb_no_page(struct mm_struct *mm
 		goto backout;
 
 	add_mm_counter(mm, file_rss, HPAGE_SIZE / PAGE_SIZE);
-	set_huge_pte_at(mm, address, ptep, make_huge_pte(vma, page));
+	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
+				&& (vma->vm_flags & VM_SHARED)));
+	set_huge_pte_at(mm, address, ptep, new_pte);
+
+	if (write_access && !(vma->vm_flags & VM_SHARED)) {
+		/* Optimization, do the COW without a second fault */
+		ret = hugetlb_cow(mm, vma, address, ptep, new_pte);
+	}
+
 	spin_unlock(&mm->page_table_lock);
 	unlock_page(page);
 out:
@@ -420,6 +491,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 {
 	pte_t *ptep;
 	pte_t entry;
+	int ret;
 
 	ptep = huge_pte_alloc(mm, address);
 	if (!ptep)
@@ -427,13 +499,18 @@ int hugetlb_fault(struct mm_struct *mm, 
 
 	entry = *ptep;
 	if (pte_none(entry))
-		return hugetlb_no_page(mm, vma, address, ptep);
+		return hugetlb_no_page(mm, vma, address, ptep, write_access);
 
-	/*
-	 * We could get here if another thread instantiated the pte
-	 * before the test above.
-	 */
-	return VM_FAULT_MINOR;
+	ret = VM_FAULT_MINOR;
+
+	spin_lock(&mm->page_table_lock);
+	/* Check for a racing update before calling hugetlb_cow */
+	if (likely(pte_same(entry, *ptep)))
+		if (write_access && !pte_write(entry))
+			ret = hugetlb_cow(mm, vma, address, ptep, entry);
+	spin_unlock(&mm->page_table_lock);
+
+	return ret;
 }
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
diff -upN reference/mm/mmap.c current/mm/mmap.c
--- reference/mm/mmap.c
+++ current/mm/mmap.c
@@ -1077,8 +1077,8 @@ munmap_back:
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED))
-						== (VM_WRITE | VM_RESERVED)) {
+		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED 
+				| VM_HUGETLB)) == (VM_WRITE | VM_RESERVED)) {
 			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
 				"PROT_WRITE mmap of VM_RESERVED memory, which "
 				"is deprecated. Please report this to "

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

