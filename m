Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSJDBAy>; Thu, 3 Oct 2002 21:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJDBAy>; Thu, 3 Oct 2002 21:00:54 -0400
Received: from holomorphy.com ([66.224.33.161]:45259 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261208AbSJDBAw>;
	Thu, 3 Oct 2002 21:00:52 -0400
Date: Thu, 3 Oct 2002 18:05:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, rohit.seth@intel.com
Subject: abstract out prefaulting from alloc_shared_hugetlb_pages()
Message-ID: <20021004010543.GC21619@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@zip.com.au, rohit.seth@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order for hugetlbfs to operate, prefaulting the vma at mmap()-time
while simultaneously instantiating and performing lookups on its
ratcache entries is needed as an isolated operation. This is implemented
as part of a different function within hugetlbpage.c that ties it to
inode and key lookup and allocation. The following patch simply moves
the code already present into its own function, calls it, and makes it
available for hugetlbfs to use.

The BUG() checks for alignment etc. are consistent with current usage
within sys_alloc_hugepages() and its associated get_addr():

in get_addr():

        if (addr) {
                addr = HPAGE_ALIGN(addr);
...
        }
        addr = HPAGE_ALIGN(TASK_UNMAPPED_BASE);

in sys_alloc_hugepages():

        if (len & (HPAGE_SIZE - 1))
                return -EINVAL;


Bill


diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/mm/hugetlbpage.c hugetlbfs/arch/i386/mm/hugetlbpage.c
--- linux-2.5/arch/i386/mm/hugetlbpage.c	Wed Oct  2 20:14:31 2002
+++ hugetlbfs/arch/i386/mm/hugetlbpage.c	Thu Oct  3 17:45:14 2002
@@ -406,25 +404,10 @@
 		goto freeinode;
 	}
 
-	spin_lock(&mm->page_table_lock);
-	do {
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		if ((pte) && (pte_none(*pte))) {
-			idx = (addr - vma->vm_start) >> HPAGE_SHIFT;
-			page = find_get_page(mapping, idx);
-			if (page == NULL) {
-				page = alloc_hugetlb_page();
-				if (page == NULL)
-					goto out;
-				add_to_page_cache(page, mapping, idx);
-			}
-			set_huge_pte(mm, vma, page, pte,
-				     (vma->vm_flags & VM_WRITE));
-		} else
-			goto out;
-		addr += HPAGE_SIZE;
-	} while (addr < vma->vm_end);
-	retval = 0;
+	retval = hugetlb_prefault(mapping, vma);
+	if (retval)
+		goto out;
+
 	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
 	vma->vm_ops = &hugetlb_vm_ops;
 	spin_unlock(&mm->page_table_lock);
@@ -459,6 +442,46 @@
 	 return retval;
 }
 
+int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+{
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
+		page = find_get_page(mapping, idx);
+		if (!page) {
+			page = alloc_hugetlb_page();
+			if (!page) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			add_to_page_cache(page, mapping, idx);
+		}
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+	}
+out:
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}
+
 static int
 alloc_private_hugetlb_pages(int key, unsigned long addr, unsigned long len,
 			    int prot, int flag)
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/mm.h hugetlbfs/include/linux/mm.h
--- linux-2.5/include/linux/mm.h	Wed Oct  2 20:14:55 2002
+++ hugetlbfs/include/linux/mm.h	Thu Oct  3 15:28:10 2002
@@ -386,7 +386,7 @@
 extern int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 extern int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
 extern	int free_hugepages(struct vm_area_struct *);
-
+extern int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 #else
 #define is_vm_hugetlb_page(vma) (0)
 #define follow_hugetlb_page(mm, vma, pages, vmas, start, len, i) (0)
