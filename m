Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbSKLIYi>; Tue, 12 Nov 2002 03:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKLIYh>; Tue, 12 Nov 2002 03:24:37 -0500
Received: from holomorphy.com ([66.224.33.161]:41913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266278AbSKLIYe>;
	Tue, 12 Nov 2002 03:24:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [8/11] hugetlb: reduce inode usage in prefault_key()
Message-Id: <E18BWPl-0005KK-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This expands out prefault_key() into its hugetlb_prefault() component, but
substitutes stubs to abstract out inode access.

 hugetlbpage.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletion(-)


diff -urpN htlb-2.5.47-7/arch/i386/mm/hugetlbpage.c htlb-2.5.47-8/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-7/arch/i386/mm/hugetlbpage.c	2002-11-11 22:21:49.000000000 -0800
+++ htlb-2.5.47-8/arch/i386/mm/hugetlbpage.c	2002-11-11 22:32:00.000000000 -0800
@@ -371,9 +371,55 @@ static int check_size_prot(struct inode 
 	return 0;
 }
 
+struct page *key_find_page(struct hugetlb_key *key, unsigned long index)
+{
+	return find_get_page(key->in->i_mapping, index);
+}
+
+void key_add_page(struct page *page, struct hugetlb_key *key, unsigned long index)
+{
+	add_to_page_cache(page, key->in->i_mapping, index);
+}
+
 static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma)
 {
-	return hugetlb_prefault(key->in->i_mapping, vma);
+	struct mm_struct *mm = current->mm;
+	unsigned long addr;
+	int ret = 0;
+
+	BUG_ON(vma->vm_start & ~HPAGE_MASK);
+	BUG_ON(vma->vm_end & ~HPAGE_MASK);
+
+	spin_lock(&mm->page_table_lock);
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
+		unsigned long idx;
+		pte_t *pte = huge_pte_alloc(mm, addr);
+		struct page *page;
+
+		if (!pte) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (!pte_none(*pte))
+			continue;
+
+		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+		page = key_find_page(key, idx);
+		if (!page) {
+			page = alloc_hugetlb_page();
+			if (!page) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			key_add_page(page, key, idx);
+			unlock_page(page);
+		}
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+	}
+out:
+	spin_unlock(&mm->page_table_lock);
+	return ret;
 }
 
 static int alloc_shared_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
