Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbUDFNrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbUDFNqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:46:38 -0400
Received: from ns.suse.de ([195.135.220.2]:930 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263827AbUDFNky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:40:54 -0400
Date: Tue, 6 Apr 2004 15:40:12 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 9/ Add simple lazy i386/x86-64 hugetlbfs
 policy support
Message-Id: <20040406154012.2750827d.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add NUMA policy support to i386/x86-64 hugetlbfs and switch it 
over to lazy allocation instead of prefaulting.

The NUMA policy support policies the huge page allocation based on the
current policy.

It also switch the hugetlbfs to lazy allocation, because otherwise
mbind() cannot work after mmap, because the memory was already allocated.
This doesn't do any prereservation; when a process runs out of 
huge pages it will get a SIGBUS.

There are currently various proposals on linux-kernel to add preallocation
for this; once one of these patches turns out to be good it would be 
best to replace this patch with it (and port the mpol_* changes over)

diff -u linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c-o linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c
--- linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c-o	2004-04-06 13:11:59.000000000 +0200
+++ linux-2.6.5-numa/arch/i386/mm/hugetlbpage.c	2004-04-06 13:36:12.000000000 +0200
@@ -15,14 +15,17 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
+#include <linux/mempolicy.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-static long    htlbpagemem;
+/* AK: this should be all moved into the pgdat */
+
+static long    htlbpagemem[MAX_NUMNODES];
 int     htlbpage_max;
-static long    htlbzone_pages;
+static long    htlbzone_pages[MAX_NUMNODES];
 
 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
@@ -33,14 +36,15 @@
 		&hugepage_freelists[page_zone(page)->zone_pgdat->node_id]);
 }
 
-static struct page *dequeue_huge_page(void)
+static struct page *dequeue_huge_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	int nid = numa_node_id();
+	int nid = mpol_first_node(vma, addr); 
 	struct page *page = NULL;
 
 	if (list_empty(&hugepage_freelists[nid])) {
 		for (nid = 0; nid < MAX_NUMNODES; ++nid)
-			if (!list_empty(&hugepage_freelists[nid]))
+			if (mpol_node_valid(nid, vma, addr) && 
+			    !list_empty(&hugepage_freelists[nid]))
 				break;
 	}
 	if (nid >= 0 && nid < MAX_NUMNODES && !list_empty(&hugepage_freelists[nid])) {
@@ -61,18 +65,18 @@
 
 static void free_huge_page(struct page *page);
 
-static struct page *alloc_hugetlb_page(void)
+static struct page *alloc_hugetlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	int i;
 	struct page *page;
 
 	spin_lock(&htlbpage_lock);
-	page = dequeue_huge_page();
+	page = dequeue_huge_page(vma, addr);
 	if (!page) {
 		spin_unlock(&htlbpage_lock);
 		return NULL;
 	}
-	htlbpagemem--;
+	htlbpagemem[page_zone(page)->zone_pgdat->node_id]--;
 	spin_unlock(&htlbpage_lock);
 	set_page_count(page, 1);
 	page->lru.prev = (void *)free_huge_page;
@@ -284,7 +288,7 @@
 
 	spin_lock(&htlbpage_lock);
 	enqueue_huge_page(page);
-	htlbpagemem++;
+	htlbpagemem[page_zone(page)->zone_pgdat->node_id]++;
 	spin_unlock(&htlbpage_lock);
 }
 
@@ -329,41 +333,49 @@
 	spin_unlock(&mm->page_table_lock);
 }
 
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+/* page_table_lock hold on entry. */
+static int 
+hugetlb_alloc_fault(struct mm_struct *mm, struct vm_area_struct *vma, 
+			       unsigned long addr, int write_access)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
+	int ret;
+	pte_t *pte;
+	struct page *page = NULL;
+	struct address_space *mapping = vma->vm_file->f_mapping;
 
+	pte = huge_pte_alloc(mm, addr); 
 		if (!pte) {
-			ret = -ENOMEM;
+		ret = VM_FAULT_OOM;
 			goto out;
 		}
-		if (!pte_none(*pte))
-			continue;
+
+		/* Handle race */
+		if (!pte_none(*pte)) { 
+			ret = VM_FAULT_MINOR;
+			goto flush; 
+		}
 
 		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 		page = find_get_page(mapping, idx);
 		if (!page) {
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
+		/* Should do this at prefault time, but that gets us into
+		   trouble with freeing right now. */
+		ret = hugetlb_get_quota(mapping);
+		if (ret) {
+			ret = VM_FAULT_OOM;
 				goto out;
 			}
-			page = alloc_hugetlb_page();
+		
+			page = alloc_hugetlb_page(vma, addr);
 			if (!page) {
 				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
+			
+			/* Instead of OOMing here could just transparently use
+			   small pages. */
+			
+				ret = VM_FAULT_OOM;
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
@@ -371,23 +383,64 @@
 			if (ret) {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
+				ret = VM_FAULT_SIGBUS;
 				goto out;
 			}
-		}
+		ret = VM_FAULT_MAJOR; 
+	} else
+		ret = VM_FAULT_MINOR;
+		
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
+
+ flush:
+	/* Don't need to flush other CPUs. They will just do a page
+	   fault and flush it lazily. */
+	__flush_tlb_one(addr);
+	
+ out:
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
 
+int arch_hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, 
+		       unsigned long address, int write_access)
+{ 
+	pmd_t *pmd;
+	pgd_t *pgd;
+
+	if (write_access && !(vma->vm_flags & VM_WRITE))
+		return VM_FAULT_SIGBUS;
+
+	spin_lock(&mm->page_table_lock);	
+	pgd = pgd_offset(mm, address); 
+	if (pgd_none(*pgd)) 
+		return hugetlb_alloc_fault(mm, vma, address, write_access); 
+
+	pmd = pmd_offset(pgd, address);
+	if (pmd_none(*pmd))
+		return hugetlb_alloc_fault(mm, vma, address, write_access); 
+
+	BUG_ON(!pmd_large(*pmd)); 
+
+	/* must have been a race. Flush the TLB. NX not supported yet. */ 
+
+	__flush_tlb_one(address); 
+	spin_lock(&mm->page_table_lock);	
+	return VM_FAULT_MINOR;
+} 
+
+int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
+{
+	return 0;
+}
+
 static void update_and_free_page(struct page *page)
 {
 	int j;
 	struct page *map;
 
 	map = page;
-	htlbzone_pages--;
+	htlbzone_pages[page_zone(page)->zone_pgdat->node_id]--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
 				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
@@ -404,6 +457,7 @@
 	struct list_head *p;
 	struct page *page, *map;
 
+   page = NULL;
 	map = NULL;
 	spin_lock(&htlbpage_lock);
 	/* all lowmem is on node 0 */
@@ -411,7 +465,7 @@
 		if (map) {
 			list_del(&map->list);
 			update_and_free_page(map);
-			htlbpagemem--;
+ 			htlbpagemem[page_zone(map)->zone_pgdat->node_id]--;
 			map = NULL;
 			if (++count == 0)
 				break;
@@ -423,49 +477,61 @@
 	if (map) {
 		list_del(&map->list);
 		update_and_free_page(map);
-		htlbpagemem--;
+		htlbpagemem[page_zone(page)->zone_pgdat->node_id]--;
 		count++;
 	}
 	spin_unlock(&htlbpage_lock);
 	return count;
 }
 
+static long all_huge_pages(void)
+{ 
+	long pages = 0;
+	int i;
+	for (i = 0; i < numnodes; i++) 
+		pages += htlbzone_pages[i];
+	return pages;
+} 
+
 static int set_hugetlb_mem_size(int count)
 {
 	int lcount;
 	struct page *page;
-
 	if (count < 0)
 		lcount = count;
-	else
-		lcount = count - htlbzone_pages;
+	else { 
+		lcount = count - all_huge_pages();
+	}
 
 	if (lcount == 0)
-		return (int)htlbzone_pages;
+		return (int)all_huge_pages();
 	if (lcount > 0) {	/* Increase the mem size. */
 		while (lcount--) {
+			int node;
 			page = alloc_fresh_huge_page();
 			if (page == NULL)
 				break;
 			spin_lock(&htlbpage_lock);
 			enqueue_huge_page(page);
-			htlbpagemem++;
-			htlbzone_pages++;
+			node = page_zone(page)->zone_pgdat->node_id;
+			htlbpagemem[node]++;
+			htlbzone_pages[node]++;
 			spin_unlock(&htlbpage_lock);
 		}
-		return (int) htlbzone_pages;
+		goto out;
 	}
 	/* Shrink the memory size. */
 	lcount = try_to_free_low(lcount);
 	while (lcount++) {
-		page = alloc_hugetlb_page();
+		page = alloc_hugetlb_page(NULL, 0);
 		if (page == NULL)
 			break;
 		spin_lock(&htlbpage_lock);
 		update_and_free_page(page);
 		spin_unlock(&htlbpage_lock);
 	}
-	return (int) htlbzone_pages;
+ out:
+	return (int)all_huge_pages();
 }
 
 int hugetlb_sysctl_handler(ctl_table *table, int write,
@@ -498,33 +564,60 @@
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 	for (i = 0; i < htlbpage_max; ++i) {
+		int nid; 
 		page = alloc_fresh_huge_page();
 		if (!page)
 			break;
 		spin_lock(&htlbpage_lock);
 		enqueue_huge_page(page);
+		nid = page_zone(page)->zone_pgdat->node_id;
+		htlbpagemem[nid]++;
+		htlbzone_pages[nid]++;
 		spin_unlock(&htlbpage_lock);
 	}
-	htlbpage_max = htlbpagemem = htlbzone_pages = i;
-	printk("Total HugeTLB memory allocated, %ld\n", htlbpagemem);
+	htlbpage_max = i;
+	printk("Initial HugeTLB pages allocated: %d\n", i);
 	return 0;
 }
 module_init(hugetlb_init);
 
 int hugetlb_report_meminfo(char *buf)
 {
+	int i;
+	long pages = 0, mem = 0;
+	for (i = 0; i < numnodes; i++) {
+		pages += htlbzone_pages[i];
+		mem += htlbpagemem[i];
+	}
+
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
 			"Hugepagesize:    %5lu kB\n",
-			htlbzone_pages,
-			htlbpagemem,
+			pages,
+			mem,
 			HPAGE_SIZE/1024);
 }
 
+int hugetlb_report_node_meminfo(int node, char *buf)
+{
+	return sprintf(buf,
+			"HugePages_Total: %5lu\n"
+			"HugePages_Free:  %5lu\n"
+			"Hugepagesize:    %5lu kB\n",
+			htlbzone_pages[node],
+			htlbpagemem[node],
+			HPAGE_SIZE/1024);
+}
+
+/* Not accurate with policy */
 int is_hugepage_mem_enough(size_t size)
 {
-	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem;
+	long pm = 0;
+	int i;
+	for (i = 0; i < numnodes; i++)
+		pm += htlbpagemem[i];
+	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= pm;
 }
 
 /* Return the number pages of memory we physically have, in PAGE_SIZE units. */
diff -u linux-2.6.5-numa/include/linux/mm.h-o linux-2.6.5-numa/include/linux/mm.h
--- linux-2.6.5-numa/include/linux/mm.h-o	2004-04-06 13:12:23.000000000 +0200
+++ linux-2.6.5-numa/include/linux/mm.h	2004-04-06 13:36:12.000000000 +0200
@@ -643,6 +660,9 @@
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long from,
 		unsigned long to, unsigned long size, pgprot_t prot);
 
+extern int arch_hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma, 
+			      unsigned long address, int write_access);
+
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
diff -u linux-2.6.5-numa/mm/memory.c-o linux-2.6.5-numa/mm/memory.c
--- linux-2.6.5-numa/mm/memory.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/memory.c	2004-04-06 13:36:12.000000000 +0200
@@ -1604,6 +1633,15 @@
 	return VM_FAULT_MINOR;
 }
 
+
+/* Can be overwritten by the architecture */
+int __attribute__((weak)) arch_hugetlb_fault(struct mm_struct *mm, 
+					     struct vm_area_struct *vma, 
+					     unsigned long address, int write_access)
+{
+	return VM_FAULT_SIGBUS;
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  */
@@ -1619,7 +1657,7 @@
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return arch_hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
