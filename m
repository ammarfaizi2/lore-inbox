Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTJLTsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTJLTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 15:48:52 -0400
Received: from holomorphy.com ([66.224.33.161]:11651 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263518AbTJLTsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 15:48:38 -0400
Date: Sun, 12 Oct 2003 12:51:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] invalidate_mmap_range() misses remap_file_pages()-affected targets
Message-ID: <20031012195146.GB16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031012084842.GB765@holomorphy.com> <20031012103436.GC765@holomorphy.com> <20031012045644.0dce8f6b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012045644.0dce8f6b.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> It would seem that mincore() shares a similar issue on account of its
>>  algorithm

On Sun, Oct 12, 2003 at 04:56:44AM -0700, Andrew Morton wrote:
> Yes, I think it makes sense to fix mincore().  I don't fully understand the
> reasoning behind the three cases though:

Probably because the second case is broken.


William Lee Irwin III <wli@holomorphy.com> wrote:
> +	if (pte_file(*pte))
> +		present = mincore_linear_page(vma, pte_to_pgoff(*pte));
> +	else if (!(vma->vm_flags | (VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE)))
> +		present = pte_present(*pte);
> +	else
> +		present = mincore_linear_page(vma, pgoff);

On Sun, Oct 12, 2003 at 04:56:44AM -0700, Andrew Morton wrote:
> Could you explain the logic behind each of these?  Perhaps with permanent
> comments?

I think the PROT_NONE handling is bogus; since we have the pte, we can
just override the pgoff-based lookup if the pte is present and ignore
vm_flags, and the behavior isn't unique to PROT_NONE anyway. The prior
post flubs the case of pte_present(*pte) with unaligned pgoff and rw
or ro vma protection.

Mike Galbraith also spotted a typical locking booboo in mincore_page(),
fixed here.


-- wli


diff -prauN rfp-2.6.0-test7-bk3-1/mm/mincore.c rfp-2.6.0-test7-bk3-2/mm/mincore.c
--- rfp-2.6.0-test7-bk3-1/mm/mincore.c	2003-10-08 12:24:51.000000000 -0700
+++ rfp-2.6.0-test7-bk3-2/mm/mincore.c	2003-10-12 12:36:52.000000000 -0700
@@ -22,7 +22,7 @@
  * and is up to date; i.e. that no page-in operation would be required
  * at this time if an application were to map and access this page.
  */
-static unsigned char mincore_page(struct vm_area_struct * vma,
+static unsigned char mincore_linear_page(struct vm_area_struct *vma,
 	unsigned long pgoff)
 {
 	unsigned char present = 0;
@@ -38,6 +38,67 @@ static unsigned char mincore_page(struct
 	return present;
 }
 
+static unsigned char mincore_nonlinear_page(struct vm_area_struct *vma,
+						unsigned long pgoff)
+{
+	unsigned char present = 0;
+	unsigned long vaddr;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	spin_lock(&vma->vm_mm->page_table_lock);
+	vaddr = PAGE_SIZE*(pgoff - vma->vm_pgoff) + vma->vm_start;
+	pgd = pgd_offset(vma->vm_mm, vaddr);
+	if (pgd_none(*pgd))
+		goto out;
+	else if (pgd_bad(*pgd)) {
+		pgd_ERROR(*pgd);
+		pgd_clear(pgd);
+		goto out;
+	}
+	pmd = pmd_offset(pgd, vaddr);
+	if (pmd_none(*pmd))
+		goto out;
+	else if (pmd_ERROR(*pmd)) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		goto out;
+	}
+
+	pte = pte_offset_map(pmd, vaddr);
+
+	/* PTE_FILE ptes have the same file, but pgoff can differ */
+	if (pte_file(*pte))
+		present = mincore_linear_page(vma, pte_to_pgoff(*pte));
+
+	/* pte presence overrides the calculated offset */
+	else if (pte_present(*pte))
+		present = 1;
+
+	/* matching offsets are the faulted in if the pte isn't set */
+	else
+		present = mincore_linear_page(vma, pgoff);
+	pte_unmap(pte);
+out:
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return present;
+}
+
+static inline unsigned char mincore_page(struct vm_area_struct *vma,
+						unsigned long pgoff)
+{
+	unsigned char ret;
+	struct address_space *as = vma->vm_file->f_dentry->d_inode->i_mapping;
+	down(&as->i_shared_sem);
+	if (vma->vm_flags & VM_NONLINEAR)
+		ret = mincore_nonlinear_page(vma, pgoff);
+	else
+		ret = mincore_linear_page(vma, pgoff);
+	up(&as->i_shared_sem);
+	return ret;
+}
+
 static long mincore_vma(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, unsigned char __user * vec)
 {
