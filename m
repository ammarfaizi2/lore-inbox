Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTJLKba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 06:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTJLKb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 06:31:29 -0400
Received: from holomorphy.com ([66.224.33.161]:11650 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263441AbTJLKb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 06:31:27 -0400
Date: Sun, 12 Oct 2003 03:34:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] invalidate_mmap_range() misses remap_file_pages()-affected targets
Message-ID: <20031012103436.GC765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20031012084842.GB765@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012084842.GB765@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 01:48:42AM -0700, William Lee Irwin III wrote:
> invalidate_mmap_range(), and hence vmtruncate(), can miss its targets
> due to remap_file_pages() disturbing the former invariant of file
> offsets only being mapped within vmas tagged as mapping file offset
> ranges containing them.

It would seem that mincore() shares a similar issue on account of its
algorithm (surely concocted as defensive programming for deadlock
avoidance). The following patch checks pagetable entries in a path
where copy_to_user() is not involved. The cases where the results would
differ are when nonlinearly mapped pages are paged out and have
pte_file(*pte) true, or when vma protections differ from the ptes that
remap_file_pages() has instantiated. This is dealt with by holding
->i_shared_sem during mincore_page() and carrying out a pagetable
lookup for every virtual page when testing presence in nonlinear vmas.

Untested. The disturbing questions are whether mincore_page() should
actually return -ENOMEM when asked to report presence on vmas with
vma->vm_file == NULL, and, of course, the usual confusion over what on
earth the VM_MAY* flags really are.

vs. 2.6.0-test7-bk3


diff -prauN rfp-2.6.0-test7-bk3-1/mm/mincore.c rfp-2.6.0-test7-bk3-2/mm/mincore.c
--- rfp-2.6.0-test7-bk3-1/mm/mincore.c	2003-10-08 12:24:51.000000000 -0700
+++ rfp-2.6.0-test7-bk3-2/mm/mincore.c	2003-10-12 02:17:19.000000000 -0700
@@ -22,7 +22,7 @@
  * and is up to date; i.e. that no page-in operation would be required
  * at this time if an application were to map and access this page.
  */
-static unsigned char mincore_page(struct vm_area_struct * vma,
+static unsigned char mincore_linear_page(struct vm_area_struct *vma,
 	unsigned long pgoff)
 {
 	unsigned char present = 0;
@@ -38,6 +38,58 @@ static unsigned char mincore_page(struct
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
+	pte = pte_offset_map(pmd, vaddr);
+	if (pte_file(*pte))
+		present = mincore_linear_page(vma, pte_to_pgoff(*pte));
+	else if (!(vma->vm_flags | (VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE)))
+		present = pte_present(*pte);
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
+	struct address_space *as = vma->vm_file->f_dentry->d_inode->i_mapping;
+	down(&as->i_shared_sem);
+	if (vma->vm_flags & VM_NONLINEAR)
+		return mincore_nonlinear_page(vma, pgoff);
+	else
+		return mincore_linear_page(vma, pgoff);
+	up(&as->i_shared_sem);
+}
+
 static long mincore_vma(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, unsigned char __user * vec)
 {
