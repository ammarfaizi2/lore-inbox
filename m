Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUGTLQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUGTLQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUGTLQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:16:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:31971 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265784AbUGTLPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:15:46 -0400
MIME-Version: 1.0
Date: Tue, 20 Jul 2004 20:15:44 +0900
Subject: [PATCH] ia64 memory hotplug for hugetlbpages [2/4]
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Message-ID: <JZ200407202015448.33073640@pst.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Mailer: JsvMail 5.5 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -dupr linux-2.6.7/arch/ia64/mm/hugetlbpage.c linux-2.6.7-RMAP/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ia64/mm/hugetlbpage.c  2004-07-09 15:51:19.000000000 +0900
+++ linux-2.6.7-RMAP/arch/ia64/mm/hugetlbpage.c 2004-07-15 11:28:52.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
+#include <linux/rmap.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
@@ -108,6 +109,7 @@ int copy_hugetlb_page_range(struct mm_st
        if (!pte_none(entry)) {
            ptepage = pte_page(entry);
            get_page(ptepage);
+           page_dup_rmap(ptepage);
            dst->rss += (HPAGE_SIZE / PAGE_SIZE);
        }
        set_pte(dst_pte, entry);
@@ -261,6 +263,7 @@ void unmap_hugepage_range(struct vm_area
        if (pte_none(*pte))
            continue;
        page = pte_page(*pte);
+       page_remove_rmap(page);
        put_page(page);
        pte_clear(pte);
        mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
@@ -315,6 +318,7 @@ int hugetlb_prefault(struct address_spac
            }
        }
        set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+       page_add_file_rmap(page);
    }
 out:
    spin_unlock(&mm->page_table_lock);
@@ -371,6 +375,7 @@ again:
    }
    if (pte_none(*pte)) {
        set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+       page_add_file_rmap(page);
        flush_tlb_range(vma, address, address + HPAGE_SIZE);
        update_mmu_cache(vma, address, *pte);
    } else {
@@ -383,6 +388,89 @@ out:
    return ret;
 }
 
+/*
+ * At what user virtual address is page expected in vma?
+ */
+static inline unsigned long
+huge_vma_address(struct page *page, struct vm_area_struct *vma)
+{
+   pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+   unsigned long address;
+
+   address = vma->vm_start + ((pgoff - vma->vm_pgoff) << HPAGE_SHIFT);
+   if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+       /* page should be within any vma from prio_tree_next */
+       BUG_ON(!PageAnon(page));
+       return -EFAULT;
+   }
+   return address;
+}
+
+/*
+ * Try to clear the PTE which map the hugepage.
+ */
+int try_to_unmap_hugepage(struct page *page, struct vm_area_struct *vma,
+           struct list_head *force)
+{
+   pte_t *pte;
+   pte_t pteval;
+   int ret = SWAP_AGAIN;
+   struct mm_struct *mm = vma->vm_mm;
+   unsigned long address;
+
+   address = huge_vma_address(page, vma);
+   if (address == -EFAULT)
+       goto out;
+
+   /*
+    * We need the page_table_lock to protect us from page faults,
+    * munmap, fork, etc...
+    */
+   if (!spin_trylock(&mm->page_table_lock))
+       goto out;
+
+   pte = huge_pte_offset(mm, address);
+   if (!pte || pte_none(*pte))
+       goto out_unlock;
+   if (!pte_present(*pte))
+       goto out_unlock;
+
+   if (page_to_pfn(page) != pte_pfn(*pte))
+       goto out_unlock;
+
+   BUG_ON(!vma);
+
+#if 0
+   if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
+       ptep_test_and_clear_young(pte)) {
+       ret = SWAP_FAIL;
+       goto out_unlock;
+   }
+#endif
+
+   /* Nuke the page table entry. */
+   flush_cache_page(vma, address);
+   pteval = ptep_get_and_clear(pte);
+   flush_tlb_range(vma, address, address + HPAGE_SIZE);
+
+   /* Move the dirty bit to the physical page now the pte is gone. */
+   if (pte_dirty(pteval))
+       set_page_dirty(page);
+
+   BUG_ON(PageAnon(page));
+
+   mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
+   BUG_ON(!page->mapcount);
+   page->mapcount--;
+   page_cache_release(page);
+
+out_unlock:
+   spin_unlock(&mm->page_table_lock);
+
+out:
+   return ret;
+}
+
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
        unsigned long pgoff, unsigned long flags)
 {
