Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWEJS4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWEJS4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWEJS4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:56:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60376 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932456AbWEJS4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:56:45 -0400
Subject: [RFC] Hugetlb demotion for x86
From: Adam Litke <agl@us.ibm.com>
To: linux-mm@kvack.kernel.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Date: Wed, 10 May 2006 13:56:40 -0500
Message-Id: <1147287400.24029.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch enables demotion of MAP_PRIVATE hugetlb memory to
normal anonymous memory on the i386 architecture.  Below is a short
description of the problem from a previous posting.

> Thanks to the latest hugetlb accounting patches, we now have reliable
> shared mappings.  Private mappings are much more difficult because
> there is no way to know up-front how many huge pages will be required
> (we may have forking combined with unknown copy-on-write activity).
> So private mappings currently get full overcommit semantics and when a
> fault cannot be handled, the apps get SIGBUS.
> 
> The problem: Random SIGBUS crashes for applications using large pages
> are not acceptable.  We need a way to handle the fault without giving
> up and killing the process.

The mechanics of this approach are straightforward.  When failing to
allocate a huge page, the HPAGE_SIZE area is munmap'ed and mmap'ed as
anonymous memory.  If a hugepte existed (happens on a COW fault) a
series of write-protected normal ptes that point to the sub-pages of the
original huge page are installed.  When finished, the normal fault
handling path finishes the fault via do_anonymous page (or do_wp_page
for COW faults).

At this point I am looking for comments on the approach.  It has been
working reliably on my system so far but I have probably missed
something.  Also, enabling other architectures will involve a more work
(such as demotion regions that span multiple pages and vmas), which I am
now looking at.

Signed-off-by: Adam Litke <agl@us.ibm.com>
* Patch not ready for merging

 include/linux/mman.h |   22 ++++++++++++
 mm/hugetlb.c         |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/rmap.c            |    3 +
 3 files changed, 112 insertions(+), 1 deletion(-)
diff -upN reference/include/linux/mman.h current/include/linux/mman.h
--- reference/include/linux/mman.h
+++ current/include/linux/mman.h
@@ -53,6 +53,17 @@ calc_vm_prot_bits(unsigned long prot)
 }
 
 /*
+ * Combine the vm_flags protection bits into mmap "prot" argument
+ */
+static inline unsigned long
+calc_mmap_prot_bits(unsigned long vm_flags)
+{
+	return _calc_vm_trans(vm_flags, VM_READ,  PROT_READ ) |
+	       _calc_vm_trans(vm_flags, VM_WRITE, PROT_WRITE) |
+	       _calc_vm_trans(vm_flags, VM_EXEC,  PROT_EXEC );
+}
+
+/*
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
 static inline unsigned long
@@ -64,4 +75,15 @@ calc_vm_flag_bits(unsigned long flags)
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
 }
 
+/*
+ * Convert vm_flags into the mmap "flags" argument
+ */
+static inline unsigned long
+calc_mmap_flag_bits(unsigned long vm_flags)
+{
+	return _calc_vm_trans(vm_flags, VM_GROWSDOWN,  MAP_GROWSDOWN ) |
+	       _calc_vm_trans(vm_flags, VM_DENYWRITE,  MAP_DENYWRITE ) |
+	       _calc_vm_trans(vm_flags, VM_EXECUTABLE, MAP_EXECUTABLE) |
+	       _calc_vm_trans(vm_flags, VM_LOCKED,     MAP_LOCKED    );
+}
 #endif /* _LINUX_MMAN_H */
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -14,6 +14,7 @@
 #include <linux/mempolicy.h>
 #include <linux/cpuset.h>
 #include <linux/mutex.h>
+#include <linux/mman.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -503,6 +504,86 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
+/*
+ * For copy-on-write triggered demotions, we have an instantiated page and
+ * huge pte.  Since we need the data in the existing huge page, install
+ * normal, write-protected ptes that point to the sub-pages of this huge page.
+ * We can then let do_wp_page() lazily copy the data for us.  Just take a
+ * reference on the huge page for each pte we install.
+ */
+static inline int
+install_demotion_ptes(struct mm_struct *mm, struct page *page,
+			pgprot_t prot, unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t entry, *ptep;
+	int pfn, i;
+
+	pgd = pgd_offset(mm, address);
+	pud = pud_alloc(mm, pgd, address);
+	if (!pud)
+		return -ENOMEM;
+	pmd = pmd_alloc(mm, pud, address);
+	if (!pmd)
+		return -ENOMEM;
+
+	pfn = page_to_pfn(page);
+	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++) {
+		address += i * PAGE_SIZE;
+		entry = pte_wrprotect(pfn_pte(pfn + i, prot));
+		ptep = pte_alloc_map(mm, pmd, address);
+		set_pte_at(mm, address, ptep, entry);
+		pte_unmap(ptep);
+		get_page(page);
+	}
+
+	return 0;
+}
+
+static int hugetlb_demote_page(struct mm_struct *mm, struct vm_area_struct *vma,
+				unsigned long address)
+{
+	unsigned long start, prot, flags;
+	pgprot_t pgprot;
+	pte_t *ptep;
+	struct page *page = NULL;
+	int ret, established = 0;
+
+	/* Only private VMAs can be demoted */
+	if (vma->vm_flags & VM_MAYSHARE)
+		return VM_FAULT_OOM;
+
+	start = address & HPAGE_MASK;
+	pgprot = vma->vm_page_prot;
+	prot = calc_mmap_prot_bits(vma->vm_flags);
+	flags = calc_mmap_flag_bits(vma->vm_flags);
+	flags |= MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED;
+
+	ptep = huge_pte_offset(mm, start);
+	if (ptep && !pte_none(*ptep)) {
+		established = 1;
+		page = pte_page(*ptep);
+		get_page(page);
+	}
+
+	do_munmap(mm, start, HPAGE_SIZE);
+	start = do_mmap_pgoff(0, start, HPAGE_SIZE, prot, flags, 0);
+	if (start < 0) {
+		return VM_FAULT_OOM;
+	}
+
+	if (established) {
+		ret = install_demotion_ptes(mm, page, pgprot, start);
+		put_page(page);
+		if (ret)
+			return VM_FAULT_OOM;
+	}
+
+	return VM_FAULT_MINOR;
+}
+
 static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, pte_t *ptep, pte_t pte)
 {
@@ -643,6 +724,8 @@ int hugetlb_fault(struct mm_struct *mm, 
 	entry = *ptep;
 	if (pte_none(entry)) {
 		ret = hugetlb_no_page(mm, vma, address, ptep, write_access);
+		if (ret == VM_FAULT_OOM)
+			ret = hugetlb_demote_page(mm, vma, address);
 		mutex_unlock(&hugetlb_instantiation_mutex);
 		return ret;
 	}
@@ -652,8 +735,11 @@ int hugetlb_fault(struct mm_struct *mm, 
 	spin_lock(&mm->page_table_lock);
 	/* Check for a racing update before calling hugetlb_cow */
 	if (likely(pte_same(entry, *ptep)))
-		if (write_access && !pte_write(entry))
+		if (write_access && !pte_write(entry)) {
 			ret = hugetlb_cow(mm, vma, address, ptep, entry);
+			if (ret == VM_FAULT_OOM)
+				ret = hugetlb_demote_page(mm, vma, address);
+		}
 	spin_unlock(&mm->page_table_lock);
 	mutex_unlock(&hugetlb_instantiation_mutex);
 
diff -upN reference/mm/rmap.c current/mm/rmap.c
--- reference/mm/rmap.c
+++ current/mm/rmap.c
@@ -548,6 +548,9 @@ void page_add_file_rmap(struct page *pag
  */
 void page_remove_rmap(struct page *page)
 {
+	if (unlikely(PageCompound(page)))
+		return;
+
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 #ifdef CONFIG_DEBUG_VM
 		if (unlikely(page_mapcount(page) < 0)) {

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

