Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVBXWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVBXWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVBXWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:17:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16338 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262516AbVBXWQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:16:45 -0500
Date: Thu, 24 Feb 2005 22:15:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Colin Harrison <colin.harrison@virgin.net>
cc: "Ammar T. Al-Sayegh" <ammar@kunet.com>, linux-kernel@vger.kernel.org
Subject: RE: Kernel oops in mm/rmap.c in 2.6.11rc4-bk9
In-Reply-To: <200502241920.j1OJJxj0016253@StraightRunning.com>
Message-ID: <Pine.LNX.4.61.0502242131170.14771@goblin.wat.veritas.com>
References: <200502241920.j1OJJxj0016253@StraightRunning.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Colin Harrison wrote:
> Fresher trace of my oops captured over a serial tty link (kernel now
> 2.6.11rc4-bk11) 
> 
> kernel BUG at mm/rmap.c:482!
> EIP is at page_remove_rmap+0x38/0x50
> Process cc1 (pid: 10543, threadinfo=d10e0000 task=ced11a80)

Welcome to the exclusive club of those who've seen this -
check the archives for other sightings.

> > -----Original Message-----
> > From: Colin Harrison [mailto:colin.harrison@virgin.net] 
> > Sent: 21 February 2005 18:45
> > To: 'linux-kernel@vger.kernel.org'
> > Subject: Kernel oops in mm/rmap.c in 2.6.11rc4-bk9

Sorry, that message never reached the list - marc hasn't got it.

[ I've snipped out a lot of info you were right to supply,
  thank you, though it'll probably turn out to be irrelevant. ]

> > More info can be supplied if required and patches compiled in 
> > to trace etc.

Thank you: please apply the patch below, and mail me back any
interesting messages you see - should be captured by dmesg, or
better /var/log/messages which will show the times too, to help
group them.  Not just the "Bad rmap:" errors this patch adds,
there might be relevant "Bad page state" errors or "swap_free:"
errors.  The system should stay up.  Perhaps you'll be swamped
with messages (don't spam the list with them if so, just me).

> > Note that I have run a memory checker (memtest-86 v3.2 boot 
> > CD) for ~ 3hours with no errors.

Right thing to try first, though may not have been long enough.
Since you've already tried that, let's try the patch below next.

> > I can usually repeat the crash while compiling a 
> > kernel..which after a reboot recovers and allows 'make 
> > bzImage' 'make modules' to finish!

If you can reproduce this fairly easily, that would be _wonderful_!
It's dragged on for months, but nobody sees it often enough to get
an understanding of it.  It's possible that most sightings are in
fact due to bad memory, and the rmap.c BUG a good (but tiresome)
checker itself - I do hope your info will give us more of a clue.

Thanks,
Hugh

p.s. Ammar, I've cc'ed you for interest as the most recent member
of the club; but this patch below is unlikely to apply cleanly to
your Fedora kernel - if you're used to moving patches from one
release to another, you might want to try it, but probably not.

--- 2.6.11-rc5/include/linux/rmap.h	2004-12-24 21:36:18.000000000 +0000
+++ linux/include/linux/rmap.h	2005-02-24 20:52:17.000000000 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.11-rc5/mm/fremap.c	2005-02-24 20:11:11.000000000 +0000
+++ linux/mm/fremap.c	2005-02-24 20:52:17.000000000 +0000
@@ -37,7 +37,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page);
+				page_remove_rmap(page, vma, addr);
 				page_cache_release(page);
 				mm->rss--;
 			}
--- 2.6.11-rc5/mm/memory.c	2005-02-24 20:11:11.000000000 +0000
+++ linux/mm/memory.c	2005-02-24 20:52:17.000000000 +0000
@@ -452,6 +452,7 @@ next_pgd:
 }
 
 static void zap_pte_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pmd_t *pmd, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -517,7 +518,7 @@ static void zap_pte_range(struct mmu_gat
 			else if (pte_young(pte))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, address+offset);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -535,6 +536,7 @@ static void zap_pte_range(struct mmu_gat
 }
 
 static void zap_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pud_t *pud, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -553,13 +555,14 @@ static void zap_pmd_range(struct mmu_gat
 	if (end > ((address + PUD_SIZE) & PUD_MASK))
 		end = ((address + PUD_SIZE) & PUD_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
+		zap_pte_range(tlb, vma, pmd, address, end - address, details);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address && (address < end));
 }
 
 static void zap_pud_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pgd_t * pgd, unsigned long address,
 		unsigned long end, struct zap_details *details)
 {
@@ -574,7 +577,7 @@ static void zap_pud_range(struct mmu_gat
 	}
 	pud = pud_offset(pgd, address);
 	do {
-		zap_pmd_range(tlb, pud, address, end - address, details);
+		zap_pmd_range(tlb, vma, pud, address, end - address, details);
 		address = (address + PUD_SIZE) & PUD_MASK; 
 		pud++;
 	} while (address && (address < end));
@@ -595,7 +598,7 @@ static void unmap_page_range(struct mmu_
 		next = (address + PGDIR_SIZE) & PGDIR_MASK;
 		if (next <= address || next > end)
 			next = end;
-		zap_pud_range(tlb, pgd, address, next, details);
+		zap_pud_range(tlb, vma, pgd, address, next, details);
 		address = next;
 		pgd++;
 	}
@@ -1343,7 +1346,7 @@ static int do_wp_page(struct mm_struct *
 			acct_update_integrals();
 			update_mem_hiwater();
 		} else
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma, address);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
--- 2.6.11-rc5/mm/rmap.c	2005-02-24 20:11:11.000000000 +0000
+++ linux/mm/rmap.c	2005-02-24 21:33:37.000000000 +0000
@@ -461,8 +461,12 @@ void page_add_anon_rmap(struct page *pag
 void page_add_file_rmap(struct page *page)
 {
 	BUG_ON(PageAnon(page));
-	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
+	if (!pfn_valid(page_to_pfn(page)))
 		return;
+	if (PageReserved(page)) {
+		set_bit(PG_arch_1, &page->flags);
+		return;
+	}
 
 	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
@@ -474,12 +478,43 @@ void page_add_file_rmap(struct page *pag
  *
  * Caller needs to hold the mm->page_table_lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address)
 {
+	struct address_space *mapping = NULL;
+	unsigned long index;
+
 	BUG_ON(PageReserved(page));
 
+	index = (address - vma->vm_start) >> PAGE_SHIFT;
+	index += vma->vm_pgoff;
+
+	if (PageAnon(page))
+		mapping = (void *) vma->anon_vma + PAGE_MAPPING_ANON;
+	else if (!(vma->vm_flags & (VM_IO|VM_RESERVED)))
+		mapping = vma->vm_file? vma->vm_file->f_mapping: (void *)(-1);
+
+	if (page_mapcount(page) <= 0 || page_count(page) <= 0 ||
+	    (mapping && (mapping != page->mapping || index != page->index)) ||
+	    test_bit(PG_arch_1, &page->flags) /* was PageReserved before */) {
+		pgd_t *pgd = pgd_offset(vma->vm_mm, address);
+		pud_t *pud = pud_offset(pgd, address);
+		pmd_t *pmd = pmd_offset(pud, address);
+		unsigned long ptpfn = pmd_val(*pmd) >> PAGE_SHIFT;
+
+		printk(KERN_ERR "Bad rmap: "
+			"page %p flags %lx count %d mapcount %d\n",
+			page, (unsigned long)page->flags,
+			page_count(page), page_mapcount(page));
+		printk(KERN_ERR "  %s addr %lx ptpfn %lx vm_flags %lx\n",
+			current->comm, address, ptpfn, vma->vm_flags);
+		printk(KERN_ERR "  page mapping %p %lx vma mapping %p %lx\n",
+			page->mapping, page->index, mapping, index);
+		get_page(page);	/* corrupt, so leak rather than free it */
+		return;
+	}
+
 	if (atomic_add_negative(-1, &page->_mapcount)) {
-		BUG_ON(page_mapcount(page) < 0);
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
@@ -601,7 +636,7 @@ static int try_to_unmap_one(struct page 
 
 	mm->rss--;
 	acct_update_integrals();
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -703,7 +738,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		acct_update_integrals();
 		mm->rss--;
