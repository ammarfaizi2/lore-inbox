Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270708AbRHKCWl>; Fri, 10 Aug 2001 22:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269793AbRHKCWd>; Fri, 10 Aug 2001 22:22:33 -0400
Received: from zeus.kernel.org ([209.10.41.242]:40325 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S270708AbRHKCWT>;
	Fri, 10 Aug 2001 22:22:19 -0400
Date: Fri, 10 Aug 2001 18:08:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Linton <jlinton@interactivesi.com>
cc: <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [BUG][PATCH] in sys_swapoff() path 
In-Reply-To: <005a01c121f8$8371bdc0$bef7020a@mammon>
Message-ID: <Pine.LNX.4.33.0108101803570.1289-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Aug 2001, Jeremy Linton wrote:
>
> I'm resending this patch because it apparently went to /dev/null last time I
> sent it.

Yes, thanks.

Can you test that the appended version does the same thing for you? I made
the mm/memory.c check a bit stricter (it should be the _same_ pte entry,
not just still not present), and re-did the swapfile loop logic slightly,
but it's basically your patch otherwise. Still happy with it?

Plus this has Rik's swapspace full patch - fixed to NOT unconditionally
and incorrectly mark the pte writable. We can (and do) have non-writable
dirty swap pages - they could have been writable earlier in the process
lifetime.

Jeremy, Rik, please verify my changes..

		Linus

------
diff -u --recursive --new-file pre8/linux/include/linux/swap.h linux/include/linux/swap.h
--- pre8/linux/include/linux/swap.h	Fri Aug 10 16:39:04 2001
+++ linux/include/linux/swap.h	Fri Aug 10 14:25:04 2001
@@ -148,6 +148,7 @@
 extern void free_page_and_swap_cache(struct page *page);

 /* linux/mm/swapfile.c */
+extern int vm_swap_full(void);
 extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern int is_swap_partition(kdev_t);
diff -u --recursive --new-file pre8/linux/mm/memory.c linux/mm/memory.c
--- pre8/linux/mm/memory.c	Fri Aug 10 16:39:04 2001
+++ linux/mm/memory.c	Fri Aug 10 17:45:55 2001
@@ -1098,9 +1098,10 @@
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
-	pte_t * page_table, swp_entry_t entry, int write_access)
+	pte_t * page_table, pte_t orig_pte, int write_access)
 {
 	struct page *page;
+	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;

 	spin_unlock(&mm->page_table_lock);
@@ -1112,7 +1113,11 @@
 		unlock_kernel();
 		if (!page) {
 			spin_lock(&mm->page_table_lock);
-			return -1;
+			/*
+			 * Back out if somebody else faulted in this pte while
+			 * we released the page table lock.
+			 */
+			return pte_same(*page_table, orig_pte) ? -1 : 1;
 		}
 	}

@@ -1128,7 +1133,7 @@
 	 * released the page table lock.
 	 */
 	spin_lock(&mm->page_table_lock);
-	if (pte_present(*page_table)) {
+	if (!pte_same(*page_table, orig_pte)) {
 		UnlockPage(page);
 		page_cache_release(page);
 		return 1;
@@ -1139,8 +1144,14 @@
 	pte = mk_pte(page, vma->vm_page_prot);

 	swap_free(entry);
-	if (write_access && exclusive_swap_page(page))
-		pte = pte_mkwrite(pte_mkdirty(pte));
+	if (exclusive_swap_page(page)) {
+		if (write_access)
+			pte = pte_mkwrite(pte_mkdirty(pte));
+		if (vm_swap_full()) {
+			delete_from_swap_cache_nolock(page);
+			pte = pte_mkdirty(pte);
+		}
+	}
 	UnlockPage(page);

 	flush_page_to_ram(page);
@@ -1297,7 +1308,7 @@
 		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte);
-		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);
+		return do_swap_page(mm, vma, address, pte, entry, write_access);
 	}

 	if (write_access) {
diff -u --recursive --new-file pre8/linux/mm/swapfile.c linux/mm/swapfile.c
--- pre8/linux/mm/swapfile.c	Wed Jul  4 11:50:38 2001
+++ linux/mm/swapfile.c	Fri Aug 10 18:02:42 2001
@@ -19,11 +19,31 @@

 spinlock_t swaplock = SPIN_LOCK_UNLOCKED;
 unsigned int nr_swapfiles;
+int total_swap_pages;

 struct swap_list_t swap_list = {-1, -1};

 struct swap_info_struct swap_info[MAX_SWAPFILES];

+/*
+ * When swap space gets filled up, we will set this flag.
+ * This will make do_swap_page(), in the page fault path,
+ * free swap entries on swapin so we'll reclaim swap space
+ * in order to be able to swap something out.
+ *
+ * At the moment we start reclaiming when swap usage goes
+ * over 80% of swap space.
+ *
+ * XXX: Random numbers, fixme.
+ */
+#define SWAP_FULL_PCT 80
+int vm_swap_full (void)
+{
+	int swap_used = total_swap_pages - nr_swap_pages;
+
+	return swap_used * 100 > total_swap_pages * SWAP_FULL_PCT;
+}
+
 #define SWAPFILE_CLUSTER 256

 static inline int scan_swap_map(struct swap_info_struct *si, unsigned short count)
@@ -329,6 +349,54 @@
 }

 /*
+ * this is called when we find a page in the swap list
+ * all the locks have been dropped at this point which
+ * isn't a problem because we rescan the swap map
+ * and we _don't_ clear the refrence count if for
+ * some reason it isn't 0
+ */
+
+static inline int free_found_swap_entry(unsigned int type, int i)
+{
+	struct task_struct *p;
+	struct page *page;
+	swp_entry_t entry;
+
+	entry = SWP_ENTRY(type, i);
+
+	/*
+	 * Get a page for the entry, using the existing swap
+	 * cache page if there is one.  Otherwise, get a clean
+	 * page and read the swap into it.
+	 */
+	page = read_swap_cache_async(entry);
+	if (!page) {
+		swap_free(entry);
+		return -ENOMEM;
+	}
+	lock_page(page);
+	if (PageSwapCache(page))
+		delete_from_swap_cache_nolock(page);
+	UnlockPage(page);
+	read_lock(&tasklist_lock);
+	for_each_task(p)
+		unuse_process(p->mm, entry, page);
+	read_unlock(&tasklist_lock);
+	shmem_unuse(entry, page);
+	/*
+	 * Now get rid of the extra reference to the temporary
+	 * page we've been using.
+	 */
+	page_cache_release(page);
+	/*
+	 * Check for and clear any overflowed swap map counts.
+	 */
+	swap_free(entry);
+	return 0;
+}
+
+
+/*
  * We completely avoid races by reading each swap page in advance,
  * and then search for the process using it.  All the necessary
  * page table adjustments can then be made atomically.
@@ -336,82 +404,79 @@
 static int try_to_unuse(unsigned int type)
 {
 	struct swap_info_struct * si = &swap_info[type];
-	struct task_struct *p;
-	struct page *page;
-	swp_entry_t entry;
-	int i;
+	int ret, foundpage;
+
+	do {
+		int i;

-	while (1) {
 		/*
 		 * The algorithm is inefficient but seldomly used
-		 * and probably not worth fixing.
 		 *
-		 * Make sure that we aren't completely killing
-		 * interactive performance.
-		 */
-		if (current->need_resched)
-			schedule();
-
-		/*
 		 * Find a swap page in use and read it in.
 		 */
+		foundpage = 0;
 		swap_device_lock(si);
 		for (i = 1; i < si->max ; i++) {
-			if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD) {
-				/*
-				 * Prevent swaphandle from being completely
-				 * unused by swap_free while we are trying
-				 * to read in the page - this prevents warning
-				 * messages from rw_swap_page_base.
+			int count = si->swap_map[i];
+			if (!count || count == SWAP_MAP_BAD)
+				continue;
+
+			/*
+			 * Prevent swaphandle from being completely
+			 * unused by swap_free while we are trying
+			 * to read in the page - this prevents warning
+			 * messages from rw_swap_page_base.
+			 */
+			foundpage = 1;
+			if (count != SWAP_MAP_MAX)
+				si->swap_map[i] = count + 1;
+
+			swap_device_unlock(si);
+			ret = free_found_swap_entry(type,i);
+			if (ret)
+				return ret;
+
+			/*
+			 * we pick up the swap_list_lock() to guard the nr_swap_pages,
+			 * si->swap_map[] should only be changed if it is SWAP_MAP_MAX
+			 * otherwise ugly stuff can happen with other people who are in
+			 * the middle of a swap operation to this device. This kind of
+			 * operation can sometimes be detected with the undead swap
+			 * check. Don't worry about these 'undead' entries for now
+			 * they will be caught the next time though the top loop.
+			 * Do worry, about the weak locking that allows this to happen
+			 * because if it happens to a page that is SWAP_MAP_MAX
+			 * then bad stuff can happen.
+			 */
+			swap_list_lock();
+			swap_device_lock(si);
+			if (si->swap_map[i] > 0) {
+				/* normally this would just kill the swap page if
+				 * it still existed, it appears though that the locks
+				 * are a little fuzzy
 				 */
-				if (si->swap_map[i] != SWAP_MAP_MAX)
-					si->swap_map[i]++;
-				swap_device_unlock(si);
-				goto found_entry;
+				if (si->swap_map[i] != SWAP_MAP_MAX) {
+					printk("VM: Undead swap entry %08lx\n",
+					       SWP_ENTRY(type, i).val);
+				} else {
+					nr_swap_pages++;
+					si->swap_map[i] = 0;
+				}
 			}
-		}
-		swap_device_unlock(si);
-		break;
+			swap_device_unlock(si);
+			swap_list_unlock();

-	found_entry:
-		entry = SWP_ENTRY(type, i);
-
-		/* Get a page for the entry, using the existing swap
-                   cache page if there is one.  Otherwise, get a clean
-                   page and read the swap into it. */
-		page = read_swap_cache_async(entry);
-		if (!page) {
-			swap_free(entry);
-  			return -ENOMEM;
-		}
-		lock_page(page);
-		if (PageSwapCache(page))
-			delete_from_swap_cache_nolock(page);
-		UnlockPage(page);
-		read_lock(&tasklist_lock);
-		for_each_task(p)
-			unuse_process(p->mm, entry, page);
-		read_unlock(&tasklist_lock);
-		shmem_unuse(entry, page);
-		/* Now get rid of the extra reference to the temporary
-                   page we've been using. */
-		page_cache_release(page);
-		/*
-		 * Check for and clear any overflowed swap map counts.
-		 */
-		swap_free(entry);
-		swap_list_lock();
-		swap_device_lock(si);
-		if (si->swap_map[i] > 0) {
-			if (si->swap_map[i] != SWAP_MAP_MAX)
-				printk("VM: Undead swap entry %08lx\n",
-								entry.val);
-			nr_swap_pages++;
-			si->swap_map[i] = 0;
+			/*
+			 * This lock stuff is ulgy!
+			 * Make sure that we aren't completely killing
+			 * interactive performance.
+			 */
+			if (current->need_resched)
+				schedule();
+			swap_device_lock(si);
 		}
 		swap_device_unlock(si);
-		swap_list_unlock();
-	}
+	} while (foundpage);
 	return 0;
 }

@@ -462,6 +527,7 @@
 		swap_list.next = swap_list.head;
 	}
 	nr_swap_pages -= p->pages;
+	total_swap_pages -= p->pages;
 	swap_list_unlock();
 	p->flags = SWP_USED;
 	err = try_to_unuse(type);
@@ -477,6 +543,7 @@
 		else
 			swap_info[prev].next = p - swap_info;
 		nr_swap_pages += p->pages;
+		total_swap_pages += p->pages;
 		swap_list_unlock();
 		p->flags = SWP_WRITEOK;
 		goto out_dput;
@@ -764,6 +831,7 @@
 	p->pages = nr_good_pages;
 	swap_list_lock();
 	nr_swap_pages += nr_good_pages;
+	total_swap_pages += nr_good_pages;
 	printk(KERN_INFO "Adding Swap: %dk swap-space (priority %d)\n",
 	       nr_good_pages<<(PAGE_SHIFT-10), p->prio);


