Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWBWDVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWBWDVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 22:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWBWDVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 22:21:18 -0500
Received: from fmr23.intel.com ([143.183.121.15]:8114 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750741AbWBWDVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 22:21:17 -0500
Subject: [PATCH] Enable mprotect on huge pages
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 23 Feb 2006 11:19:40 +0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

2.6.16-rc3 uses hugetlb on-demand paging, but it doesnÿt support hugetlb
mprotect. My patch against 2.6.16-rc3 enables this capability.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com> 

Discussion is welcomed.

---

diff -Nraup linux-2.6.16-rc3/include/linux/hugetlb.h linux-2.6.16-rc3_mprotect/include/linux/hugetlb.h
--- linux-2.6.16-rc3/include/linux/hugetlb.h	2006-02-14 16:43:50.000000000 +0800
+++ linux-2.6.16-rc3_mprotect/include/linux/hugetlb.h	2006-02-22 00:12:35.000000000 +0800
@@ -41,6 +41,8 @@ struct page *follow_huge_pmd(struct mm_s
 				pmd_t *pmd, int write);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
+void hugetlb_change_protection(struct vm_area_struct *vma,
+		unsigned long address, unsigned long end, pgprot_t newprot);
 
 #ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define is_hugepage_only_range(mm, addr, len)	0
@@ -101,6 +103,8 @@ static inline unsigned long hugetlb_tota
 #define free_huge_page(p)			({ (void)(p); BUG(); })
 #define hugetlb_fault(mm, vma, addr, write)	({ BUG(); 0; })
 
+#define	hugetlb_change_protection(vma, address, end, newprot)
+
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
 #define HPAGE_SIZE	PAGE_SIZE
diff -Nraup linux-2.6.16-rc3/mm/hugetlb.c linux-2.6.16-rc3_mprotect/mm/hugetlb.c
--- linux-2.6.16-rc3/mm/hugetlb.c	2006-02-14 16:43:50.000000000 +0800
+++ linux-2.6.16-rc3_mprotect/mm/hugetlb.c	2006-02-22 00:12:35.000000000 +0800
@@ -572,3 +572,32 @@ int follow_hugetlb_page(struct mm_struct
 
 	return i;
 }
+
+void hugetlb_change_protection(struct vm_area_struct *vma,
+		unsigned long address, unsigned long end, pgprot_t newprot)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long start = address;
+	pte_t *ptep;
+	pte_t pte;
+
+	BUG_ON(address >= end);
+	flush_cache_range(vma, address, end);
+
+	spin_lock(&mm->page_table_lock);
+	for (; address < end; address += HPAGE_SIZE) {
+		ptep = huge_pte_offset(mm, address);
+		if (!ptep)
+			continue;
+		if (pte_present(*ptep)) {
+			pte = ptep_get_and_clear(mm, address, ptep);
+			pte = pte_modify(pte, newprot);
+			set_huge_pte_at(mm, addr, ptep, pte);
+			lazy_mmu_prot_update(pte);
+		}
+	}
+	spin_unlock(&mm->page_table_lock);
+
+	flush_tlb_range(vma, start, end);
+}
+
diff -Nraup linux-2.6.16-rc3/mm/mprotect.c linux-2.6.16-rc3_mprotect/mm/mprotect.c
--- linux-2.6.16-rc3/mm/mprotect.c	2006-01-25 21:54:15.000000000 +0800
+++ linux-2.6.16-rc3_mprotect/mm/mprotect.c	2006-02-22 00:13:34.000000000 +0800
@@ -124,7 +124,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED|VM_HUGETLB))) {
+		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 			charged = nrpages;
 			if (security_vm_enough_memory(charged))
 				return -ENOMEM;
@@ -166,7 +166,10 @@ success:
 	 */
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
-	change_protection(vma, start, end, newprot);
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_change_protection(vma, start, end, newprot);
+	else
+		change_protection(vma, start, end, newprot);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;
@@ -240,11 +243,6 @@ sys_mprotect(unsigned long start, size_t
 
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 
-		if (is_vm_hugetlb_page(vma)) {
-			error = -EACCES;
-			goto out;
-		}
-
 		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
 
 		/* newflags >> 4 shift VM_MAY% in place of VM_% */
@@ -260,6 +258,12 @@ sys_mprotect(unsigned long start, size_t
 		tmp = vma->vm_end;
 		if (tmp > end)
 			tmp = end;
+		if (is_vm_hugetlb_page(vma) &&
+			is_aligned_hugepage_range(nstart, tmp - nstart)) {
+			error = -EINVAL;
+			goto out;
+		}
+
 		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			goto out;


