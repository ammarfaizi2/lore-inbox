Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131534AbRAWWXW>; Tue, 23 Jan 2001 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131143AbRAWWXN>; Tue, 23 Jan 2001 17:23:13 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:31934 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130098AbRAWWVB>; Tue, 23 Jan 2001 17:21:01 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.1-test10 
Date: Tue, 23 Jan 2001 17:20:45 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01012317204500.24969@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Linus Torvalds wrote:

>On Tue, 23 Jan 2001, Marcelo Tosatti wrote:
 
>> Any technical reason why the background page aging fix was not applied?

>Because I have not heard anybody claim that it makes a huge difference..

Linus,

Marcelo's changes make a difference here - enought of a difference that I
spent the time to merge his 'swap_max_pageout' and 'limit_bg_pte_scaning'
patches.

These patches make my system more stable when there is memory preasure.  With 
them I see much less 'jerky' behavior when swapping starts.  Limiting the 
ammout of swapping to what's actually needed seems very effective.  Using pte 
scaning, when under light memory peasure, looks to be effective at keeping 
swapping transparent (and freepages available)...  The effect of limiting the 
bg aging is harder to see but I do notice that going back to a long,  
intermitantly running task, often does not result in a large delay due to 
swapins...

In short think you should take a serious look at Marcelo's latest work.  I 
have included the merged patch.  Marcelo has briefly vetted it but more eyes 
would be a very good idea...

TIA

Ed Tomlinson

BTW - I sent a comment on this thread this morning - it bounced due to a 
knode problem with multiple address.  It said the same things.

---
Only in linux-pre9e/mm/: .depend
diff -u linux/mm/swap.c linux-pre9e/mm/swap.c
--- linux/mm/swap.c	Tue Nov 28 19:52:56 2000
+++ linux-pre9e/mm/swap.c	Thu Jan 18 22:33:42 2001
@@ -200,17 +200,22 @@
 {
 	if (PageInactiveDirty(page)) {
 		del_page_from_inactive_dirty_list(page);
-		add_page_to_active_list(page);
 	} else if (PageInactiveClean(page)) {
 		del_page_from_inactive_clean_list(page);
-		add_page_to_active_list(page);
 	} else {
 		/*
 		 * The page was not on any list, so we take care
 		 * not to do anything.
 		 */
+		goto inc_age;
 	}
 
+	add_page_to_active_list(page);
+	
+	if(bg_page_aging < num_physpages)
+		bg_page_aging++;
+
+inc_age:
 	/* Make sure the page gets a fair chance at staying active. */
 	if (page->age < PAGE_AGE_START)
 		page->age = PAGE_AGE_START;
diff -u linux/mm/vmscan.c linux-pre9e/mm/vmscan.c
--- linux/mm/vmscan.c	Sun Jan 21 21:44:55 2001
+++ linux-pre9e/mm/vmscan.c	Sun Jan 21 11:54:09 2001
@@ -24,32 +24,21 @@
 
 #include <asm/pgalloc.h>
 
-/*
- * The swap-out functions return 1 if they successfully
- * threw something out, and we got a free page. It returns
- * zero if it couldn't do anything, and any other value
- * indicates it decreased rss, but the page was shared.
- *
- * NOTE! If it sleeps, it *must* return 1 to make sure we
- * don't continue with the swap-out. Otherwise we may be
- * using a process that no longer actually exists (it might
- * have died while we slept).
- */
-static void try_to_swap_out(struct mm_struct * mm, struct vm_area_struct* 
vma, unsigned long address, pte_t * page_table, struct page *page)
+int bg_page_aging = 0;
+
+static int try_to_swap_out(struct mm_struct * mm, struct vm_area_struct* 
vma, unsigned long address, pte_t * page_table, struct page *page)
 {
 	pte_t pte;
 	swp_entry_t entry;
 
 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
-		page->age += PAGE_AGE_ADV;
-		if (page->age > PAGE_AGE_MAX)
-			page->age = PAGE_AGE_MAX;
-		return;
+		age_page_up(page);
+		return 0;
 	}
 
 	if (TryLockPage(page))
-		return;
+		return 0;
 
 	/* From this point on, the odds are that we're going to
 	 * nuke this pte, so read and clear the pte.  This hook
@@ -73,11 +62,17 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
-		if (!page->age)
+		if (!page->age) {
 			deactivate_page(page);
+			if(!PageActive(page)) {
+				UnlockPage(page);
+				page_cache_release(page);
+				return 1;
+			}
+		}
 		UnlockPage(page);
 		page_cache_release(page);
-		return;
+		return 0;
 	}
 
 	/*
@@ -121,25 +116,27 @@
 	/* Add it to the swap cache and mark it dirty */
 	add_to_swap_cache(page, entry);
 	set_page_dirty(page);
+	if (bg_page_aging)
+		bg_page_aging--;
 	goto set_swap_pte;
 
 out_unlock_restore:
 	set_pte(page_table, pte);
 	UnlockPage(page);
-	return;
+	return 0;
 }
 
-static int swap_out_pmd(struct mm_struct * mm, struct vm_area_struct * vma, 
pmd_t *dir, unsigned long address, unsigned long end, int count)
+static int swap_out_pmd(struct mm_struct * mm, struct vm_area_struct * vma, 
pmd_t *dir, unsigned long address, unsigned long end, int maxtry, int *count)
 {
 	pte_t * pte;
 	unsigned long pmd_end;
 
 	if (pmd_none(*dir))
-		return count;
+		return maxtry;
 	if (pmd_bad(*dir)) {
 		pmd_ERROR(*dir);
 		pmd_clear(dir);
-		return count;
+		return maxtry;
 	}
 	
 	pte = pte_offset(dir, address);
@@ -153,8 +150,12 @@
 			struct page *page = pte_page(*pte);
 
 			if (VALID_PAGE(page) && !PageReserved(page)) {
-				try_to_swap_out(mm, vma, address, pte, page);
-				if (!--count)
+				*count -= try_to_swap_out(mm, vma, address, pte, page);
+				if (!*count) {
+					maxtry = 0;
+					break;
+				}
+				if (!--maxtry)
 					break;
 			}
 		}
@@ -162,20 +163,20 @@
 		pte++;
 	} while (address && (address < end));
 	mm->swap_address = address + PAGE_SIZE;
-	return count;
+	return maxtry;
 }
 
-static inline int swap_out_pgd(struct mm_struct * mm, struct vm_area_struct 
* vma, pgd_t *dir, unsigned long address, unsigned long end, int count)
+static inline int swap_out_pgd(struct mm_struct * mm, struct vm_area_struct 
* vma, pgd_t *dir, unsigned long address, unsigned long end, int maxtry, int 
*count)
 {
 	pmd_t * pmd;
 	unsigned long pgd_end;
 
 	if (pgd_none(*dir))
-		return count;
+		return maxtry;
 	if (pgd_bad(*dir)) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
-		return count;
+		return maxtry;
 	}
 
 	pmd = pmd_offset(dir, address);
@@ -185,23 +186,23 @@
 		end = pgd_end;
 	
 	do {
-		count = swap_out_pmd(mm, vma, pmd, address, end, count);
-		if (!count)
+		maxtry = swap_out_pmd(mm, vma, pmd, address, end, maxtry, count);
+		if (!maxtry)
 			break;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
-	return count;
+	return maxtry;
 }
 
-static int swap_out_vma(struct mm_struct * mm, struct vm_area_struct * vma, 
unsigned long address, int count)
+static int swap_out_vma(struct mm_struct * mm, struct vm_area_struct * vma, 
unsigned long address, int maxtry, int *count)
 {
 	pgd_t *pgdir;
 	unsigned long end;
 
 	/* Don't swap out areas which are locked down */
 	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
-		return count;
+		return maxtry;
 
 	pgdir = pgd_offset(mm, address);
 
@@ -209,16 +210,16 @@
 	if (address >= end)
 		BUG();
 	do {
-		count = swap_out_pgd(mm, vma, pgdir, address, end, count);
-		if (!count)
+		maxtry = swap_out_pgd(mm, vma, pgdir, address, end, maxtry, count);
+		if (!maxtry)
 			break;
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		pgdir++;
 	} while (address && (address < end));
-	return count;
+	return maxtry;
 }
 
-static int swap_out_mm(struct mm_struct * mm, int count)
+static int swap_out_mm(struct mm_struct * mm, int maxtry, int *count)
 {
 	unsigned long address;
 	struct vm_area_struct* vma;
@@ -239,8 +240,8 @@
 			address = vma->vm_start;
 
 		for (;;) {
-			count = swap_out_vma(mm, vma, address, count);
-			if (!count)
+			maxtry = swap_out_vma(mm, vma, address, maxtry, count);
+			if (!maxtry)
 				goto out_unlock;
 			vma = vma->vm_next;
 			if (!vma)
@@ -253,7 +254,7 @@
 
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
-	return !count;
+	return !maxtry;
 }
 
 /*
@@ -269,15 +270,17 @@
 	return nr < SWAP_MIN ? SWAP_MIN : nr;
 }
 
-static int swap_out(unsigned int priority, int gfp_mask)
+static int swap_out(unsigned int priority, int background, int *needed)
 {
-	int counter;
-	int retval = 0;
+	int counter, retval = 0; 
 	struct mm_struct *mm = current->mm;
 
 	/* Always start by trying to penalize the process that is allocating memory 
*/
-	if (mm)
-		retval = swap_out_mm(mm, swap_amount(mm));
+	if (mm) {
+		retval = swap_out_mm(mm, swap_amount(mm),needed);
+                if (!*needed && !background)
+			return 1;
+	}
 
 	/* Then, look at the other mm's */
 	counter = mmlist_nr >> priority;
@@ -299,8 +302,15 @@
 		spin_unlock(&mmlist_lock);
 
 		/* Walk about 6% of the address space each time */
-		retval |= swap_out_mm(mm, swap_amount(mm));
+		retval |= swap_out_mm(mm, swap_amount(mm),needed);
 		mmput(mm);
+		/* 
+		 *  In the case of background aging, stop
+		 *  the scan when we aged the necessary amount
+		 *  of pages.
+		 */
+		if ((background && !bg_page_aging) || (!*needed && !background))
+			break;
 	} while (--counter >= 0);
 	return retval;
 
@@ -626,22 +636,24 @@
 /**
  * refill_inactive_scan - scan the active list and find pages to deactivate
  * @priority: the priority at which to scan
- * @oneshot: exit after deactivating one page
+ * @background: slightly different behaviour for background scanning
  *
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-int refill_inactive_scan(unsigned int priority, int oneshot)
+int refill_inactive_scan(unsigned int priority, int background)
 {
 	struct list_head * page_lru;
 	struct page * page;
-	int maxscan, page_active = 0;
+	int maxscan;
 	int ret = 0;
+	int deactivate = 1;
 
 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
 	maxscan = nr_active_pages >> priority;
 	while (maxscan-- > 0 && (page_lru = active_list.prev) != &active_list) {
+		int page_active = 0;
 		page = list_entry(page_lru, struct page, lru);
 
 		/* Wrong page on list?! (list corruption, should not happen) */
@@ -656,9 +668,19 @@
 		if (PageTestandClearReferenced(page)) {
 			age_page_up_nolock(page);
 			page_active = 1;
-		} else {
+		} else if (deactivate) {
 			age_page_down_ageonly(page);
 			/*
+			 * We're aging down a page. Decrement the counter if it
+ 			 * has not reached zero yet. If it reached zero, and we 			 * are doing 
background scan, stop deactivating pages.
+			 */
+			if (bg_page_aging)
+				bg_page_aging--;
+			else if (background) {
+				deactivate = 0;
+				continue;	
+			}
+			/*
 			 * Since we don't hold a reference on the page
 			 * ourselves, we have to do our test a bit more
 			 * strict then deactivate_page(). This is needed
@@ -672,21 +694,20 @@
 						(page->buffers ? 2 : 1)) {
 				deactivate_page_nolock(page);
 				page_active = 0;
-			} else {
-				page_active = 1;
 			}
 		}
 		/*
 		 * If the page is still on the active list, move it
 		 * to the other end of the list. Otherwise it was
-		 * deactivated by age_page_down and we exit successfully.
+		 * deactivated by deactivate_page_nolock and we exit 
+		 * successfully.
 		 */
 		if (page_active || PageActive(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
 			ret = 1;
-			if (oneshot)
+			if (!background)
 				break;
 		}
 	}
@@ -800,13 +821,16 @@
 			schedule();
 		}
 
-		while (refill_inactive_scan(DEF_PRIORITY, 1)) {
+		while (refill_inactive_scan(DEF_PRIORITY, 0)) {
 			if (--count <= 0)
 				goto done;
 		}
 
 		/* If refill_inactive_scan failed, try to page stuff out.. */
-		swap_out(DEF_PRIORITY, gfp_mask);
+		swap_out(DEF_PRIORITY, 0, &count);
+
+		if (count <= 0)
+			goto done; 
 
 		if (--maxtry <= 0)
 				return 0;
@@ -908,6 +932,7 @@
 	 */
 	for (;;) {
 		static int recalc = 0;
+		int count = -1;			/* no limit for bg swapping */
 
 		/* If needed, try to free some memory. */
 		if (inactive_shortage() || free_shortage()) 
@@ -919,7 +944,11 @@
 		 * every minute. This clears old referenced bits
 		 * and moves unused pages to the inactive list.
 		 */
-		refill_inactive_scan(DEF_PRIORITY, 0);
+		refill_inactive_scan(DEF_PRIORITY, 1);
+
+		/* Walk the pte's and age them. */
+		if (bg_page_aging)  
+			swap_out(DEF_PRIORITY, 1, &count);
 
 		/* Once a second, recalculate some VM stats. */
 		if (time_after(jiffies, recalc + HZ)) {
--- linux/include/linux/swap.h	Sun Jan 21 21:44:55 2001
+++ linux-pre9e/include/linux/swap.h	Sun Jan 21 11:59:39 2001
@@ -101,6 +101,7 @@
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
+extern int bg_page_aging;
 extern struct page * reclaim_page(zone_t *);
 extern wait_queue_head_t kswapd_wait;
 extern wait_queue_head_t kreclaimd_wait;
---
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
