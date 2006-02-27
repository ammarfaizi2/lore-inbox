Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWB0GhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWB0GhW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWB0GhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:37:22 -0500
Received: from fmr22.intel.com ([143.183.121.14]:45466 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751559AbWB0GhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:37:20 -0500
Subject: Re: [PATCH] Enable mprotect on huge pages
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paul Mundt <lethal@linux-sh.org>, kkojima@rr.iij4u.or.jp,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
	 <20060224142844.77cbd484.akpm@osdl.org>
	 <20060226230903.GA24422@localhost.localdomain>
	 <1141018592.1256.37.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1141022034.1256.44.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 27 Feb 2006 14:33:54 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 13:36, Zhang, Yanmin wrote:
> On Mon, 2006-02-27 at 07:09, David Gibson wrote:
> > On Fri, Feb 24, 2006 at 02:28:44PM -0800, Andrew Morton wrote:
> > > "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> > > >
> > > > From: Zhang, Yanmin <yanmin.zhang@intel.com>
> > > > 
> > > > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> > > > mprotect. My patch against 2.6.16-rc3 enables this capability.

Based on David's comments, I worked out a new patch against 2.6.16-rc4.
Thank David.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

I tested it on i386/x86_64/ia64. Who could help test it on other
platforms, such like PPC64?

---

diff -Nraup linux-2.6.16-rc4/include/linux/hugetlb.h linux-2.6.16-rc4_mprotect/include/linux/hugetlb.h
--- linux-2.6.16-rc4/include/linux/hugetlb.h	2006-02-22 19:19:04.000000000 +0800
+++ linux-2.6.16-rc4_mprotect/include/linux/hugetlb.h	2006-02-27 20:58:33.000000000 +0800
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
 
+#define hugetlb_change_protection(vma, address, end, newprot)
+
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
 #define HPAGE_SIZE	PAGE_SIZE
diff -Nraup linux-2.6.16-rc4/mm/hugetlb.c linux-2.6.16-rc4_mprotect/mm/hugetlb.c
--- linux-2.6.16-rc4/mm/hugetlb.c	2006-02-22 19:19:05.000000000 +0800
+++ linux-2.6.16-rc4_mprotect/mm/hugetlb.c	2006-02-27 20:57:17.000000000 +0800
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
+		if (!pte_none(*ptep)) {
+			pte = huge_ptep_get_and_clear(mm, address, ptep);
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
diff -Nraup linux-2.6.16-rc4/mm/mprotect.c linux-2.6.16-rc4_mprotect/mm/mprotect.c
--- linux-2.6.16-rc4/mm/mprotect.c	2006-02-22 19:18:21.000000000 +0800
+++ linux-2.6.16-rc4_mprotect/mm/mprotect.c	2006-02-27 20:55:10.000000000 +0800
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


