Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271767AbRIDP1T>; Tue, 4 Sep 2001 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271794AbRIDP1G>; Tue, 4 Sep 2001 11:27:06 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:40849 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S271767AbRIDP1A>; Tue, 4 Sep 2001 11:27:00 -0400
Date: Tue, 4 Sep 2001 11:26:29 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904112629.A27988@cs.cmu.edu>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com> <Pine.LNX.4.21.0109031140351.918-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109031140351.918-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 11:57:09AM -0300, Marcelo Tosatti wrote:
> I already have some code which adds a laundry list -- pages being written
> out (by page_launder()) go to the laundry list, and each page_launder()
> call will first check for unlocked pages on the laundry list, for then
> doing the usual page_launder() stuff.

NO, please don't add another list to fix the symptoms of bad page aging.

One of the graduate students here at CMU has been looking at the 2.4 VM,
trying to predict the size of the app that can possibly be loaded
without causing the system to start trashing.

To do this he was looking at the current working set and was using the
ages of pages in the page-cache as an indicator. i.e. he is exporting
the number of pages of a given age on the active list through a /proc
device. The results were unpredictable (almost every page was age 0,
except for a few that were MAX_PAGE_AGE) and walking through the source
showed why.

Aging is broken. Horribly. As a result, the inactive list is filled with
pages that are not necessarily inactive.

refill_inactive scan does aging based on the PG_Referenced bit, this is
only set for bufferpages. So on every call to refill_inactive pretty
much all active pages are being aged down agressively.

The hardware referenced bit is checked in swap_out and ages up. swap_out
walks part of the vm of all processes, and ages up all referenced pages.
However these pages will immediately get aged down as well by the
following refill_inactive. The recent moving around of refill_inactive
in the 2.4.10-pre4 patch has actually made down aging twice as
agressive.

Down aging is /2, up aging is += 3, so only pages that are referenced
more frequently than once a second on a not-loaded system could slowly
crawl up. Anything else is at age 0.

I've attached a patch against 2.4.10-pre4 that tries to do 2 things,
split the up/down aging out of refill_inactive etc. And it crawls _all_
process VM's to copy all hardware referenced bits to the software bit.
On a system withoug shortage, pages are only aged up, this is not realy
a problem, because as soon as there is some shortage the aggressive down
aging pulls pages at MAX_PAGE_AGE down to age 0 within 5 calls.

This is just an experimental patch, it probably doesn't work right on
all various kinds of CPU's. But at least it gets the aging somewhat
better. Oh and it seems to me that the discussion about read-ahead pages
is pretty much moot after this patch, they shouldn't push active stuff
out of memory.

Jan


diff -ur linux-2.4.10-pre4/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.4.10-pre4/mm/vmscan.c	Tue Sep  4 10:55:29 2001
+++ linux/mm/vmscan.c	Tue Sep  4 11:04:48 2001
@@ -45,6 +45,165 @@
 	page->age /= 2;
 }
 
+/* mm->page_table_lock is held. mmap_sem is not held */
+static void vm_crawl_pmd(struct mm_struct * mm, struct vm_area_struct * vma, pmd_t *dir, unsigned long address, unsigned long end)
+{
+	pte_t * pte;
+	unsigned long pmd_end;
+
+	if (pmd_none(*dir))
+		return;
+	if (pmd_bad(*dir)) {
+		pmd_ERROR(*dir);
+		pmd_clear(dir);
+		return;
+	}
+	
+	pte = pte_offset(dir, address);
+	
+	pmd_end = (address + PMD_SIZE) & PMD_MASK;
+	if (end > pmd_end)
+		end = pmd_end;
+
+	do {
+		if (pte_present(*pte)) {
+			struct page *page = pte_page(*pte);
+
+			if (VALID_PAGE(page) && !PageReserved(page) &&
+			    ptep_test_and_clear_young(pte))
+			{
+				SetPageReferenced(page);
+			}
+		}
+		address += PAGE_SIZE;
+		pte++;
+	} while (address && (address < end));
+}
+
+/* mm->page_table_lock is held. mmap_sem is not held */
+static inline void vm_crawl_pgd(struct mm_struct * mm, struct vm_area_struct * vma, pgd_t *dir, unsigned long address, unsigned long end)
+{
+	pmd_t * pmd;
+	unsigned long pgd_end;
+
+	if (pgd_none(*dir))
+		return;
+	if (pgd_bad(*dir)) {
+		pgd_ERROR(*dir);
+		pgd_clear(dir);
+		return;
+	}
+
+	pmd = pmd_offset(dir, address);
+
+	pgd_end = (address + PGDIR_SIZE) & PGDIR_MASK;	
+	if (pgd_end && (end > pgd_end))
+		end = pgd_end;
+	
+	do {
+		vm_crawl_pmd(mm, vma, pmd, address, end);
+		address = (address + PMD_SIZE) & PMD_MASK;
+		pmd++;
+	} while (address && (address < end));
+}
+
+/* mm->page_table_lock is held. mmap_sem is not held */
+static void vm_crawl_vma(struct mm_struct * mm, struct vm_area_struct * vma)
+{
+	pgd_t *pgdir;
+	unsigned long end, address;
+
+	/* Skip areas which are locked down */
+	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
+		return;
+
+	address = vma->vm_start;
+	pgdir = pgd_offset(mm, address);
+
+	end = vma->vm_end;
+	if (address >= end)
+		BUG();
+	do {
+		vm_crawl_pgd(mm, vma, pgdir, address, end);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgdir++;
+	} while (address && (address < end));
+}
+
+static void vm_crawl_mm(struct mm_struct * mm)
+{
+	struct vm_area_struct* vma;
+
+	/*
+	 * Go through process' page directory.
+	 */
+
+	/*
+	 * Find the proper vm-area after freezing the vma chain 
+	 * and ptes.
+	 */
+	spin_lock(&mm->page_table_lock);
+
+	for (vma = find_vma(mm, 0); vma; vma = vma->vm_next)
+		vm_crawl_vma(mm, vma);
+
+	spin_unlock(&mm->page_table_lock);
+}
+
+/* set the software PG_Referenced bit on pages that have been accessed since
+ * the last scan. */
+static void vm_angel(void)
+{
+	struct list_head *p;
+	struct mm_struct *mm;
+
+	/* Walk all mm's */
+	spin_lock(&mmlist_lock);
+
+	p = init_mm.mmlist.next;
+	while (p != &init_mm.mmlist)
+	{
+		mm = list_entry(p, struct mm_struct, mmlist);
+
+		/* Make sure the mm doesn't disappear when we drop the lock.. */
+		atomic_inc(&mm->mm_users);
+		spin_unlock(&mmlist_lock);
+
+		vm_crawl_mm(mm);
+
+		/* Grab the lock again */
+		spin_lock(&mmlist_lock);
+
+		p = p->next;
+		mmput(mm);
+	}
+
+	spin_unlock(&mmlist_lock);
+}
+
+/* Age all pages that on the active list that have their referenced bit set.
+ * Down aging is only done when do_try_to_free pages fails the first time
+ * through. kswapd is running too often to get any fair aging behavior
+ * otherwise and apps that are running when there is no memory pressure should
+ * in my opinion get a little advantage against the new 'memory hogs' that
+ * push us into a shortage. */
+void vm_devil(int general_shortage)
+{
+	struct list_head * p;
+	struct page * page;
+
+	/* Take the lock while messing with the list... */
+	spin_lock(&pagemap_lru_lock);
+	list_for_each(p, &active_list) {
+		page = list_entry(p, struct page, lru);
+		if (PageTestandClearReferenced(page))
+		    age_page_up(page);
+		else if (general_shortage)
+		    age_page_down(page);
+	}
+	spin_unlock(&pagemap_lru_lock);
+}
+
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
@@ -87,6 +246,23 @@
 	pte_t pte;
 	swp_entry_t entry;
 
+	/* Don't look at this page if it's been accessed recently. */
+	if (page->mapping && page->age)
+		return;
+
+#if 0 /* The problem is that this test makes the system extremely unwilling to
+       * swap anything out, maybe we're not looking at a large enough part of
+       * the process VM so basically everything is typically referenced by the
+       * time we consider swapping out? */
+
+	/* Pages that have no swap allocated will not be on the active list and
+	 * will not be aged. However their Referenced bit should be set. */
+	if (PageTestandClearReferenced(page)) {
+	    page->age = 0;
+	    return;
+	}
+#endif
+
 	/* 
 	 * If we are doing a zone-specific scan, do not
 	 * touch pages from zones which don't have a 
@@ -95,12 +271,6 @@
 	if (zone_inactive_plenty(page->zone))
 		return;
 
-	/* Don't look at this pte if it's been accessed recently. */
-	if (ptep_test_and_clear_young(page_table)) {
-		age_page_up(page);
-		return;
-	}
-
 	if (TryLockPage(page))
 		return;
 
@@ -153,9 +323,12 @@
 			set_page_dirty(page);
 		goto drop_pte;
 	}
+
 	/*
-	 * Check PageDirty as well as pte_dirty: page may
-	 * have been brought back from swap by swapoff.
+	 * Ok, it's really dirty. That means that
+	 * we should either create a new swap cache
+	 * entry for it, or we should write it back
+	 * to its own backing store.
 	 */
 	if (!pte_dirty(pte) && !PageDirty(page))
 		goto drop_pte;
@@ -669,7 +842,6 @@
 	struct list_head * page_lru;
 	struct page * page;
 	int maxscan = nr_active_pages >> priority;
-	int page_active = 0;
 	int nr_deactivated = 0;
 
 	/* Take the lock while messing with the list... */
@@ -690,41 +862,34 @@
 		 * have plenty inactive pages.
 		 */
 
-		if (zone_inactive_plenty(page->zone)) {
-			page_active = 1;
+		if (zone_inactive_plenty(page->zone))
 			goto skip_page;
-		}
 
-		/* Do aging on the pages. */
-		if (PageTestandClearReferenced(page)) {
-			age_page_up(page);
-			page_active = 1;
-		} else {
-			age_page_down(page);
-			/*
-			 * Since we don't hold a reference on the page
-			 * ourselves, we have to do our test a bit more
-			 * strict then deactivate_page(). This is needed
-			 * since otherwise the system could hang shuffling
-			 * unfreeable pages from the active list to the
-			 * inactive_dirty list and back again...
-			 *
-			 * SUBTLE: we can have buffer pages with count 1.
-			 */
-			if (page->age == 0 && page_count(page) <=
-						(page->buffers ? 2 : 1)) {
-				deactivate_page_nolock(page);
-				page_active = 0;
-			} else {
-				page_active = 1;
-			}
+		/* not much use to inactivate ramdisk pages when page_launder
+		 * simply bounces them back to the active list */
+		if (page_ramdisk(page))
+		    	goto skip_page;
+
+		/*
+		 * Since we don't hold a reference on the page
+		 * ourselves, we have to do our test a bit more
+		 * strict then deactivate_page(). This is needed
+		 * since otherwise the system could hang shuffling
+		 * unfreeable pages from the active list to the
+		 * inactive_dirty list and back again...
+		 *
+		 * SUBTLE: we can have buffer pages with count 1.
+		 */
+		if (page->age == 0 && page_count(page) <= (page->buffers ? 2 : 1)) {
+			deactivate_page_nolock(page);
 		}
+
 		/*
 		 * If the page is still on the active list, move it
 		 * to the other end of the list. Otherwise we exit if
 		 * we have done enough work.
 		 */
-		if (page_active || PageActive(page)) {
+		if (PageActive(page)) {
 skip_page:
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
@@ -820,14 +985,21 @@
 #define GENERAL_SHORTAGE 4
 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
 {
+	/* Always walk at least the active queue when called */
 	int shortage = 0;
 	int maxtry;
 
+	/* make sure to update referenced bits */
+	vm_angel();
+
 	/* Always walk at least the active queue when called */
 	refill_inactive_scan(DEF_PRIORITY);
 
 	maxtry = 1 << DEF_PRIORITY;
 	do {
+	    	/* perform aging of the active list */
+	    	vm_devil(shortage & GENERAL_SHORTAGE);
+
 		/*
 		 * If needed, we move pages from the active list
 		 * to the inactive list.
