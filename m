Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTJLIpg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 04:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTJLIpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 04:45:36 -0400
Received: from holomorphy.com ([66.224.33.161]:64129 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263434AbTJLIpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 04:45:32 -0400
Date: Sun, 12 Oct 2003 01:48:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [RFC] invalidate_mmap_range() misses remap_file_pages()-affected targets
Message-ID: <20031012084842.GB765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

invalidate_mmap_range(), and hence vmtruncate(), can miss its targets
due to remap_file_pages() disturbing the former invariant of file
offsets only being mapped within vmas tagged as mapping file offset
ranges containing them.

This patch uses the VM_NONLINEAR flag to detect when this could happen,
and does the full pagetable walk over the full range of virtualspace
the vma tracks to ensure that the search proceeds over vmas and virtual
addresses possibly cacheing file offsets outside vmas' "natural range"
due to remap_file_pages().

A further twist is that remap_file_pages() now needs to set VM_NONLINEAR
in a manner synchronized with invalidate_mmap_range(); this is done by
protecting the setting of VM_NONLINEAR with ->i_shared_sem. This will
suffice to exclude ->populate() even though it doesn't surround it, as
vmtruncate() alters the inode size prior to the invalidation. More
general uses of invalidate_mmap_range() may need to hold it during the
->populate() calls as they may not have protection from the inode size.

Untested, though it appears to compile. The only disturbing signs are
tlb_remove_tlb_entry() on an uncleared pte, which is at variance with
zap_pte_range() (include/asm-ppc64/tlb.h suggests zap_pte_range() is
erroneous) and a semantic question with respect to PTE_FILE ptes, i.e.
whether to clear or ignore (zap_page_range() clears as it stands now).

vs. 2.6.0-test7-bk3


diff -prauN linux-2.6.0-test7-bk3/mm/fremap.c rfp-2.6.0-test7-bk3-1/mm/fremap.c
--- linux-2.6.0-test7-bk3/mm/fremap.c	2003-10-08 12:24:00.000000000 -0700
+++ rfp-2.6.0-test7-bk3-1/mm/fremap.c	2003-10-12 00:48:45.000000000 -0700
@@ -201,9 +201,19 @@ long sys_remap_file_pages(unsigned long 
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end) {
 
-		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff)
+		/*
+		 * Must set VM_NONLINEAR before any pages are populated.
+		 * Take ->i_shared_sem to lock out invalidate_mmap_range().
+		 */
+		if (pgoff != ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff) {
+			struct file *file = vma->vm_file;
+			struct address_space *mapping;
+
+			mapping = file->f_dentry->d_inode->i_mapping;
+			down(&mapping->i_shared_sem);
 			vma->vm_flags |= VM_NONLINEAR;
+			up(&mapping->i_shared_sem);
+		}
 
 		/* ->populate can take a long time, so downgrade the lock. */
 		downgrade_write(&mm->mmap_sem);
diff -prauN linux-2.6.0-test7-bk3/mm/memory.c rfp-2.6.0-test7-bk3-1/mm/memory.c
--- linux-2.6.0-test7-bk3/mm/memory.c	2003-10-08 12:24:04.000000000 -0700
+++ rfp-2.6.0-test7-bk3-1/mm/memory.c	2003-10-12 01:10:30.000000000 -0700
@@ -1077,6 +1077,102 @@ out:
 	return ret;
 }
 
+static void
+invalidate_mmap_nonlinear_range(struct vm_area_struct *vma,
+					const unsigned long pgoff,
+					const unsigned long len)
+{
+	unsigned long addr;
+	pgd_t *pgd;
+	struct mmu_gather *tlb;
+
+	spin_lock(&vma->vm_mm->page_table_lock);
+	addr = vma->vm_start;
+	pgd = pgd_offset(vma->vm_mm, addr);
+	tlb = tlb_gather_mmu(vma->vm_mm, vma->vm_start);
+
+	tlb_start_vma(tlb, vma);
+	while (1) {
+		pmd_t *pmd;
+
+		if (pgd_none(*pgd)) {
+			addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
+			goto skip_pgd;
+		} else if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+skip_pgd:		addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
+			if (!addr || addr >= vma->vm_end)
+				break;
+			goto next_pgd;
+		}
+
+		pmd = pmd_offset(pgd, addr);
+		do {
+			pte_t *pte;
+
+			if (pmd_none(*pmd)) {
+				goto skip_pmd;
+			} else if (pmd_bad(*pmd)) {
+				pmd_ERROR(*pmd);
+				pmd_clear(pmd);
+skip_pmd:			addr = (addr + PMD_SIZE) & PMD_MASK;
+				if (!addr || addr >= vma->vm_end)
+					goto out;
+				goto next_pmd;
+			}
+			pte = pte_offset_map(pmd, addr);
+			do {
+				unsigned long pfn;
+				struct page *page;
+
+				if (pte_none(*pte))
+					goto next_pte;
+				if (!pte_present(*pte)) {
+					unsigned long index;
+					if (!pte_file(*pte))
+						goto next_pte;
+					index = pte_to_pgoff(*pte);
+					if (index >= pgoff &&
+							index - pgoff < len)
+						pte_clear(pte);
+					goto next_pte;
+				}
+				pfn = pte_pfn(*pte);
+				if (!pfn_valid(pfn))
+					goto next_pte;
+				page = pfn_to_page(pfn);
+				if (page->index < pgoff ||
+						page->index - pgoff >= len)
+					goto next_pte;
+				tlb_remove_tlb_entry(tlb, pte, addr);
+				if (pte_dirty(*pte))
+					set_page_dirty(page);
+				if (page->mapping &&
+						pte_young(*pte) &&
+						!PageSwapCache(page))
+					mark_page_accessed(page);
+				tlb->freed++;
+				page_remove_rmap(page, pte);
+				tlb_remove_page(tlb, page);
+				pte_clear(pte);
+next_pte:			addr += PAGE_SIZE;
+				if (addr >= vma->vm_end) {
+					pte_unmap(pte);
+					goto out;
+				}
+				++pte;
+			} while ((unsigned long)pte & PTE_TABLE_MASK);
+			pte_unmap(pte - 1);
+next_pmd:		++pmd;
+		} while ((unsigned long)pmd & PMD_TABLE_MASK);
+next_pgd:	++pgd;
+	}
+out:	tlb_end_vma(tlb, vma);
+	tlb_finish_mmu(tlb, vma->vm_start, vma->vm_end);
+	spin_unlock(&vma->vm_mm->page_table_lock);
+}
+
 /*
  * Helper function for invalidate_mmap_range().
  * Both hba and hlen are page numbers in PAGE_SIZE units.
@@ -1100,6 +1196,10 @@ invalidate_mmap_range_list(struct list_h
 		hea = ULONG_MAX;
 	list_for_each(curr, head) {
 		vp = list_entry(curr, struct vm_area_struct, shared);
+		if (unlikely(vp->vm_flags & VM_NONLINEAR)) {
+			invalidate_mmap_nonlinear_range(vp, hba, hlen);
+			continue;
+		}
 		vba = vp->vm_pgoff;
 		vea = vba + ((vp->vm_end - vp->vm_start) >> PAGE_SHIFT) - 1;
 		if (hea < vba || vea < hba)
