Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271974AbRIOLia>; Sat, 15 Sep 2001 07:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272249AbRIOLiS>; Sat, 15 Sep 2001 07:38:18 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:48054 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271974AbRIOLhv>; Sat, 15 Sep 2001 07:37:51 -0400
Date: Sat, 15 Sep 2001 12:39:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, Christoph Rohland <cr@sap.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.4.10pre VM changes: Potential race
In-Reply-To: <Pine.LNX.4.21.0109141747210.4708-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109151236270.1155-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I've done little testing of patch below (just SMP build on UP machine),
and uncertain whether I'll be able to do more over the weekend.  Better
for me to think backwards and forwards over it instead.  Please check
it out and give it a try, or take pieces for a patch of your own.
I won't be online, but will fetch mail from time to time.

It's an all-in-one patch of various things, which I'd want to
divide up into separate parts if I were submitting to Linus.
There's something in Documentation should be updated too.

The files affected are:

include/linux/mm.h
include/linux/swap.h
mm/memory.c
mm/shmem.c
mm/swap_state.c
mm/swapfile.c
mm/vmscan.c

The categories of change are:

add_to_swap_cache races:
- read_swap_cache_async use swap_list_lock around __find_get_page +
  swap_duplicate + add_to_swap_cache to protect against try_to_swap_out
- try_to_swap_out (and shmem_writepage) use swap_list_lock around
  get_swap_page + add_to_swap_cache, get_swap_page assume swap_list_lock
- lock ordering now prohibits __delete_from_swap_cache from doing its
  own swap_free (needs swap_list_lock) inside pagecache_lock

Big Kernel Lock:
- remove BKL from around swapin_readahead and read_swap_cache_async
- keep them in sys_swapon and sys_swapoff (drop around try_to_unuse),
  but swap_list_lock for flags and max, swap_device_lock for max too
- swap_duplicate checks within swap_device_lock (+ avoid SWAP_MAP_BAD)
- valid_swaphandles needs swap_device_lock again to protect map max
  (+ don't give up at offset 0 which is always SWAP_MAP_BAD)
- perhaps reinstate BKL temporarily for 2.4.10, remove in 2.4.11?

shmem_getpage_locked mis-oom:
- may suffer from same race as 2.4.8 fixed in do_swap_page, swap entry
  freed while lock dropped: recheck before reporting -ENOMEM or -EIO
  (already agreed with Christoph Rohland)

shmem_writepage hang:
- in odd cases (after swapoff, or write to mapped hole of sparse file)
  fsync or msync hang in filemap_fdatasync if no swap can be allocated:
  SetPageDirty instead of set_page_dirty (already agreed with Christoph)

si_swapinfo speedup:
- Zach Brown posted a speedup a few days ago, use nr_swap_pages and
  total_swap_pages instead of scanning: integrate that, but scan any
  maps caught in swapoff to avoid absurd numbers in that odd case

scan_swap_map speedup:
- Alan's tree reduces rescans by updating lowest_bit and highest_bit
  differently, after looking at that I think this does it better

cleanups:
- no PG_swap_cache bit, PageSwapCache test if mapping == &swapper_space
- remove old delete_from_swap_cache (only used by arch/m68k/atari/stram.c!
  which is clearly unsupported since it's using other vanished functions),
  rename old delete_from_swap_cache_nolock to new delete_from_swap_cache
- replace __get_swap_page by get_swap_page without count, scan_swap_map
  always start at 2, replace __swap_free by swap_free using count 1

Hugh

--- 2.4.10-pre9/include/linux/mm.h	Fri Sep 14 10:36:03 2001
+++ linux/include/linux/mm.h	Sat Sep 15 09:15:29 2001
@@ -277,7 +277,7 @@
 #define PG_active		 6
 #define PG_inactive_dirty	 7
 #define PG_slab			 8
-#define PG_swap_cache		 9
+/* #define PG_swap_cache	 9 unused: mapping == &swapper_space? */
 #define PG_skip			10
 #define PG_inactive_clean	11
 #define PG_highmem		12
@@ -331,18 +331,12 @@
 #define SetPageDecrAfter(page)	set_bit(PG_decr_after, &(page)->flags)
 #define PageTestandClearDecrAfter(page)	test_and_clear_bit(PG_decr_after, &(page)->flags)
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
-#define PageSwapCache(page)	test_bit(PG_swap_cache, &(page)->flags)
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 
 #define PageSetSlab(page)	set_bit(PG_slab, &(page)->flags)
-#define PageSetSwapCache(page)	set_bit(PG_swap_cache, &(page)->flags)
-
-#define PageTestandSetSwapCache(page)	test_and_set_bit(PG_swap_cache, &(page)->flags)
 
 #define PageClearSlab(page)		clear_bit(PG_slab, &(page)->flags)
-#define PageClearSwapCache(page)	clear_bit(PG_swap_cache, &(page)->flags)
 
-#define PageTestandClearSwapCache(page)	test_and_clear_bit(PG_swap_cache, &(page)->flags)
 
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
@@ -467,6 +461,9 @@
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void swapin_readahead(swp_entry_t);
+
+extern struct address_space swapper_space;
+#define PageSwapCache(page) ((page)->mapping == &swapper_space)
 
 /*
  * Work out if there are any other processes sharing this
--- 2.4.10-pre9/include/linux/swap.h	Fri Sep 14 10:36:03 2001
+++ linux/include/linux/swap.h	Sat Sep 15 09:15:29 2001
@@ -85,7 +85,6 @@
 extern int nr_active_pages;
 extern int nr_inactive_dirty_pages;
 extern atomic_t nr_async_pages;
-extern struct address_space swapper_space;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
 extern spinlock_t pagecache_lock;
@@ -129,7 +128,9 @@
 /* linux/mm/swap_state.c */
 extern void show_swap_cache_info(void);
 extern void add_to_swap_cache(struct page *, swp_entry_t);
-extern int swap_check_entry(unsigned long);
+extern void __delete_from_swap_cache(struct page *page);
+extern void delete_from_swap_cache(struct page *page);
+extern void free_page_and_swap_cache(struct page *page);
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t);
 
@@ -137,29 +138,19 @@
 extern int out_of_memory(void);
 extern void oom_kill(void);
 
-/*
- * Make these inline later once they are working properly.
- */
-extern void __delete_from_swap_cache(struct page *page);
-extern void delete_from_swap_cache(struct page *page);
-extern void delete_from_swap_cache_nolock(struct page *page);
-extern void free_page_and_swap_cache(struct page *page);
-
 /* linux/mm/swapfile.c */
 extern int vm_swap_full(void);
 extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern int is_swap_partition(kdev_t);
 extern void si_swapinfo(struct sysinfo *);
-extern swp_entry_t __get_swap_page(unsigned short);
+extern swp_entry_t get_swap_page(void);
 extern void get_swaphandle_info(swp_entry_t, unsigned long *, kdev_t *, 
 					struct inode **);
 extern int swap_duplicate(swp_entry_t);
 extern int swap_count(struct page *);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
-#define get_swap_page() __get_swap_page(1)
-extern void __swap_free(swp_entry_t, unsigned short);
-#define swap_free(entry) __swap_free((entry), 1)
+extern void swap_free(swp_entry_t);
 struct swap_list_t {
 	int head;	/* head of priority-ordered swapfile list */
 	int next;	/* swapfile to be used next */
--- 2.4.10-pre9/mm/memory.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/memory.c	Sat Sep 15 09:15:29 2001
@@ -1100,10 +1100,8 @@
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
-		lock_kernel();
 		swapin_readahead(entry);
 		page = read_swap_cache_async(entry);
-		unlock_kernel();
 		if (!page) {
 			spin_lock(&mm->page_table_lock);
 			/*
@@ -1142,7 +1140,7 @@
 		if (write_access)
 			pte = pte_mkwrite(pte_mkdirty(pte));
 		if (vm_swap_full()) {
-			delete_from_swap_cache_nolock(page);
+			delete_from_swap_cache(page);
 			pte = pte_mkdirty(pte);
 		}
 	}
--- 2.4.10-pre9/mm/shmem.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/shmem.c	Sat Sep 15 09:15:29 2001
@@ -234,44 +234,55 @@
 	int error;
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
+	struct address_space *mapping;
+	unsigned long index;
 	struct inode *inode;
 
 	if (!PageLocked(page))
 		BUG();
-	
-	inode = page->mapping->host;
+
+	mapping = page->mapping;
+	index = page->index;
+	inode = mapping->host;
 	info = &inode->u.shmem_i;
-	swap = __get_swap_page(2);
-	error = -ENOMEM;
-	if (!swap.val) {
-		activate_page(page);
-		goto out;
-	}
 
 	spin_lock(&info->lock);
-	entry = shmem_swp_entry(info, page->index);
+	entry = shmem_swp_entry(info, index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
-	shmem_recalc_inode(page->mapping->host);
-	error = -EAGAIN;
+	shmem_recalc_inode(inode);
 	if (entry->val)
 		BUG();
 
-	*entry = swap;
-	error = 0;
-	/* Remove the from the page cache */
+	/* Remove it from the page cache */
 	lru_cache_del(page);
 	remove_inode_page(page);
 
+	swap_list_lock();
+	swap = get_swap_page();
+
+	if (!swap.val) {
+		swap_list_unlock();
+		/* Add it back to the page cache */
+		add_to_page_cache_locked(page, mapping, index);
+		activate_page(page);
+		SetPageDirty(page);
+		error = -ENOMEM;
+		goto out;
+	}
+
 	/* Add it to the swap cache */
 	add_to_swap_cache(page, swap);
-	page_cache_release(page);
-	info->swapped++;
+	swap_list_unlock();
 
-	spin_unlock(&info->lock);
-out:
 	set_page_dirty(page);
+	info->swapped++;
+	*entry = swap;
+	error = 0;
+out:
+	spin_unlock(&info->lock);
 	UnlockPage(page);
+	page_cache_release(page);
 	return error;
 }
 
@@ -311,7 +322,7 @@
 	 * cache and swap cache.  We need to recheck the page cache
 	 * under the protection of the info->lock spinlock. */
 
-	page = __find_get_page(mapping, idx, page_hash(mapping, idx));
+	page = find_get_page(mapping, idx);
 	if (page) {
 		if (TryLockPage(page))
 			goto wait_retry;
@@ -324,18 +335,19 @@
 		unsigned long flags;
 
 		/* Look it up and read it in.. */
-		page = __find_get_page(&swapper_space, entry->val,
-				       page_hash(&swapper_space, entry->val));
+		page = find_get_page(&swapper_space, entry->val);
 		if (!page) {
+			swp_entry_t swap = *entry;
 			spin_unlock (&info->lock);
-			lock_kernel();
 			swapin_readahead(*entry);
 			page = read_swap_cache_async(*entry);
-			unlock_kernel();
-			if (!page) 
+			if (!page) {
+				if (entry->val != swap.val)
+					goto repeat;
 				return ERR_PTR(-ENOMEM);
+			}
 			wait_on_page(page);
-			if (!Page_Uptodate(page)) {
+			if (!Page_Uptodate(page) && entry->val == swap.val) {
 				page_cache_release(page);
 				return ERR_PTR(-EIO);
 			}
@@ -352,7 +364,7 @@
 
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
-		delete_from_swap_cache_nolock(page);
+		delete_from_swap_cache(page);
 		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
 		page->flags = flags | (1 << PG_dirty);
 		add_to_page_cache_locked(page, mapping, idx);
@@ -1243,7 +1255,7 @@
 	return 0;
 found:
 	add_to_page_cache(page, inode->i_mapping, offset + idx);
-	set_page_dirty(page);
+	SetPageDirty(page);
 	SetPageUptodate(page);
 	UnlockPage(page);
 	info->swapped--;
--- 2.4.10-pre9/mm/swap_state.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/swap_state.c	Sat Sep 15 09:15:29 2001
@@ -29,7 +29,7 @@
 	if (swap_count(page) > 1)
 		goto in_use;
 
-	delete_from_swap_cache_nolock(page);
+	delete_from_swap_cache(page);
 	UnlockPage(page);
 	return 0;
 
@@ -75,8 +75,6 @@
 #endif
 	if (!PageLocked(page))
 		BUG();
-	if (PageTestandSetSwapCache(page))
-		BUG();
 	if (page->mapping)
 		BUG();
 
@@ -93,51 +91,42 @@
  */
 void __delete_from_swap_cache(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-	swp_entry_t entry;
-
 #ifdef SWAP_CACHE_INFO
 	swap_cache_del_total++;
 #endif
-	if (mapping != &swapper_space)
+	if (!PageLocked(page))
 		BUG();
-	if (!PageSwapCache(page) || !PageLocked(page))
+	if (!PageSwapCache(page))
 		BUG();
 
-	entry.val = page->index;
-	PageClearSwapCache(page);
 	ClearPageDirty(page);
 	__remove_inode_page(page);
-	swap_free(entry);
 }
 
 /*
- * This will never put the page into the free list, the caller has
- * a reference on the page.
+ * This must be called only on pages that have
+ * been verified to be in the swap cache and locked.
+ * This will never put the page into the free list,
+ * the caller has a reference on the page.
  */
-void delete_from_swap_cache_nolock(struct page *page)
+void delete_from_swap_cache(struct page *page)
 {
+	swp_entry_t entry;
+
 	if (!PageLocked(page))
 		BUG();
 
 	if (block_flushpage(page, 0))
 		lru_cache_del(page);
 
+	entry.val = page->index;
+
 	spin_lock(&pagecache_lock);
 	__delete_from_swap_cache(page);
 	spin_unlock(&pagecache_lock);
-	page_cache_release(page);
-}
 
-/*
- * This must be called only on pages that have
- * been verified to be in the swap cache and locked.
- */
-void delete_from_swap_cache(struct page *page)
-{
-	lock_page(page);
-	delete_from_swap_cache_nolock(page);
-	UnlockPage(page);
+	swap_free(entry);
+	page_cache_release(page);
 }
 
 /* 
@@ -157,7 +146,7 @@
 	 */
 	if (PageSwapCache(page) && !TryLockPage(page)) {
 		if (exclusive_swap_page(page))
-			delete_from_swap_cache_nolock(page);
+			delete_from_swap_cache(page);
 		UnlockPage(page);
 	}
 	page_cache_release(page);
@@ -214,19 +203,24 @@
 	new_page = alloc_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto out;		/* Out of memory */
+	if (TryLockPage(new_page))
+		BUG();
 
 	/*
 	 * Check the swap cache again, in case we stalled above.
-	 * The BKL is guarding against races between this check
+	 * swap_list_lock is guarding against races between this check
 	 * and where the new page is added to the swap cache below.
+	 * It is also guarding against race where try_to_swap_out
+	 * allocates entry with get_swap_page then adds to cache.
 	 */
+	swap_list_lock();
 	found_page = __find_get_page(&swapper_space, entry.val, hash);
 	if (found_page)
 		goto out_free_page;
 
 	/*
 	 * Make sure the swap entry is still in use.  It could have gone
-	 * while caller waited for BKL, or while allocating page above,
+	 * since we dropped page_table_lock, while allocating page above,
 	 * or while allocating page in prior call via swapin_readahead.
 	 */
 	if (!swap_duplicate(entry))	/* Account for the swap cache */
@@ -235,13 +229,14 @@
 	/* 
 	 * Add it to the swap cache and read its contents.
 	 */
-	if (TryLockPage(new_page))
-		BUG();
 	add_to_swap_cache(new_page, entry);
+	swap_list_unlock();
 	rw_swap_page(READ, new_page);
 	return new_page;
 
 out_free_page:
+	swap_list_unlock();
+	UnlockPage(new_page);
 	page_cache_release(new_page);
 out:
 	return found_page;
--- 2.4.10-pre9/mm/swapfile.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/swapfile.c	Sat Sep 15 09:15:29 2001
@@ -52,7 +52,7 @@
 
 #define SWAPFILE_CLUSTER 256
 
-static inline int scan_swap_map(struct swap_info_struct *si, unsigned short count)
+static inline int scan_swap_map(struct swap_info_struct *si)
 {
 	unsigned long offset;
 	/* 
@@ -95,12 +95,18 @@
 	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
 		if (si->swap_map[offset])
 			continue;
+		si->lowest_bit = offset+1;
 	got_page:
 		if (offset == si->lowest_bit)
 			si->lowest_bit++;
 		if (offset == si->highest_bit)
 			si->highest_bit--;
-		si->swap_map[offset] = count;
+		if (si->lowest_bit > si->highest_bit) {
+			si->lowest_bit = si->max;
+			si->highest_bit = 0;
+		}
+		/* Initial count 1 for user reference + 1 for swap cache */
+		si->swap_map[offset] = 2;
 		nr_swap_pages--;
 		si->cluster_next = offset+1;
 		return offset;
@@ -108,7 +114,12 @@
 	return 0;
 }
 
-swp_entry_t __get_swap_page(unsigned short count)
+/*
+ * Callers of get_swap_page must hold swap_list_lock across the call,
+ * and across the following add_to_swap_cache, to guard against races
+ * with read_swap_cache_async.
+ */
+swp_entry_t get_swap_page(void)
 {
 	struct swap_info_struct * p;
 	unsigned long offset;
@@ -116,20 +127,17 @@
 	int type, wrapped = 0;
 
 	entry.val = 0;	/* Out of memory */
-	if (count >= SWAP_MAP_MAX)
-		goto bad_count;
-	swap_list_lock();
 	type = swap_list.next;
 	if (type < 0)
 		goto out;
-	if (nr_swap_pages == 0)
+	if (nr_swap_pages <= 0)
 		goto out;
 
 	while (1) {
 		p = &swap_info[type];
 		if ((p->flags & SWP_WRITEOK) == SWP_WRITEOK) {
 			swap_device_lock(p);
-			offset = scan_swap_map(p, count);
+			offset = scan_swap_map(p);
 			swap_device_unlock(p);
 			if (offset) {
 				entry = SWP_ENTRY(type,offset);
@@ -154,21 +162,14 @@
 				goto out;	/* out of swap space */
 	}
 out:
-	swap_list_unlock();
-	return entry;
-
-bad_count:
-	printk(KERN_ERR "get_swap_page: bad count %hd from %p\n",
-	       count, __builtin_return_address(0));
 	return entry;
 }
 
-
 /*
  * Caller has made sure that the swapdevice corresponding to entry
  * is still around or has not been recycled.
  */
-void __swap_free(swp_entry_t entry, unsigned short count)
+void swap_free(swp_entry_t entry)
 {
 	struct swap_info_struct * p;
 	unsigned long offset, type;
@@ -192,9 +193,7 @@
 		swap_list.next = type;
 	swap_device_lock(p);
 	if (p->swap_map[offset] < SWAP_MAP_MAX) {
-		if (p->swap_map[offset] < count)
-			goto bad_count;
-		if (!(p->swap_map[offset] -= count)) {
+		if (!--(p->swap_map[offset])) {
 			if (offset < p->lowest_bit)
 				p->lowest_bit = offset;
 			if (offset > p->highest_bit)
@@ -219,11 +218,6 @@
 bad_free:
 	printk(KERN_ERR "swap_free: %s%08lx\n", Unused_offset, entry.val);
 	goto out;
-bad_count:
-	swap_device_unlock(p);
-	swap_list_unlock();
-	printk(KERN_ERR "swap_free: Bad count %hd current count %hd\n", count, p->swap_map[offset]);
-	goto out;
 }
 
 /*
@@ -235,7 +229,7 @@
  * share this swap entry, so be cautious and let do_wp_page work out
  * what to do if a write is requested later.
  */
-/* BKL, mmlist_lock and vma->vm_mm->page_table_lock are held */
+/* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pte(struct vm_area_struct * vma, unsigned long address,
 	pte_t *dir, swp_entry_t entry, struct page* page)
 {
@@ -251,7 +245,7 @@
 	++vma->vm_mm->rss;
 }
 
-/* BKL, mmlist_lock and vma->vm_mm->page_table_lock are held */
+/* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
 	unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page* page)
@@ -279,7 +273,7 @@
 	} while (address && (address < end));
 }
 
-/* BKL, mmlist_lock and vma->vm_mm->page_table_lock are held */
+/* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
 	unsigned long address, unsigned long size,
 	swp_entry_t entry, struct page* page)
@@ -310,7 +304,7 @@
 	} while (address && (address < end));
 }
 
-/* BKL, mmlist_lock and vma->vm_mm->page_table_lock are held */
+/* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static void unuse_vma(struct vm_area_struct * vma, pgd_t *pgdir,
 			swp_entry_t entry, struct page* page)
 {
@@ -470,7 +464,7 @@
 		 */
 		lock_page(page);
 		if (PageSwapCache(page))
-			delete_from_swap_cache_nolock(page);
+			delete_from_swap_cache(page);
 		SetPageDirty(page);
 		UnlockPage(page);
 		flush_page_to_ram(page);
@@ -544,10 +538,6 @@
 		 */
 		if (current->need_resched)
 			schedule();
-		else {
-			unlock_kernel();
-			lock_kernel();
-		}
 	}
 
 	mmput(start_mm);
@@ -561,6 +551,7 @@
 asmlinkage long sys_swapoff(const char * specialfile)
 {
 	struct swap_info_struct * p = NULL;
+	unsigned short *swap_map;
 	struct nameidata nd;
 	int i, type, prev;
 	int err;
@@ -608,7 +599,9 @@
 	total_swap_pages -= p->pages;
 	p->flags = SWP_USED;
 	swap_list_unlock();
+	unlock_kernel();
 	err = try_to_unuse(type);
+	lock_kernel();
 	if (err) {
 		/* re-insert swap space back into swap_list */
 		swap_list_lock();
@@ -630,15 +623,20 @@
 		blkdev_put(nd.dentry->d_inode->i_bdev, BDEV_SWAP);
 	path_release(&nd);
 
+	swap_list_lock();
+	swap_device_lock(p);
 	nd.dentry = p->swap_file;
 	p->swap_file = NULL;
 	nd.mnt = p->swap_vfsmnt;
 	p->swap_vfsmnt = NULL;
 	p->swap_device = 0;
 	p->max = 0;
-	vfree(p->swap_map);
+	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	p->flags = 0;
+	swap_device_unlock(p);
+	swap_list_unlock();
+	vfree(swap_map);
 	err = 0;
 
 out_dput:
@@ -723,13 +721,16 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	lock_kernel();
+	swap_list_lock();
 	p = swap_info;
 	for (type = 0 ; type < nr_swapfiles ; type++,p++)
 		if (!(p->flags & SWP_USED))
 			break;
 	error = -EPERM;
-	if (type >= MAX_SWAPFILES)
+	if (type >= MAX_SWAPFILES) {
+		swap_list_unlock();
 		goto out;
+	}
 	if (type >= nr_swapfiles)
 		nr_swapfiles = type+1;
 	p->flags = SWP_USED;
@@ -748,6 +749,7 @@
 	} else {
 		p->prio = --least_priority;
 	}
+	swap_list_unlock();
 	error = user_path_walk(specialfile, &nd);
 	if (error)
 		goto bad_swap_2;
@@ -860,10 +862,10 @@
 		}
 
 		p->lowest_bit  = 1;
-		p->highest_bit = swap_header->info.last_page - 1;
 		maxpages = SWP_OFFSET(SWP_ENTRY(0,~0UL)) - 1;
 		if (maxpages > swap_header->info.last_page)
 			maxpages = swap_header->info.last_page;
+		p->highest_bit = maxpages - 1;
 
 		error = -EINVAL;
 		if (swap_header->info.nr_badpages > MAX_SWAP_BADPAGES)
@@ -903,10 +905,11 @@
 		goto bad_swap;
 	}
 	p->swap_map[0] = SWAP_MAP_BAD;
+	swap_list_lock();
+	swap_device_lock(p);
 	p->max = maxpages;
 	p->flags = SWP_WRITEOK;
 	p->pages = nr_good_pages;
-	swap_list_lock();
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
 	printk(KERN_INFO "Adding Swap: %dk swap-space (priority %d)\n",
@@ -926,6 +929,7 @@
 	} else {
 		swap_info[prev].next = p - swap_info;
 	}
+	swap_device_unlock(p);
 	swap_list_unlock();
 	error = 0;
 	goto out;
@@ -937,6 +941,7 @@
 		vfree(p->swap_map);
 	nd.mnt = p->swap_vfsmnt;
 	nd.dentry = p->swap_file;
+	swap_list_lock();
 	p->swap_device = 0;
 	p->swap_file = NULL;
 	p->swap_vfsmnt = NULL;
@@ -944,6 +949,7 @@
 	p->flags = 0;
 	if (!(swap_flags & SWAP_FLAG_PREFER))
 		++least_priority;
+	swap_list_unlock();
 	path_release(&nd);
 out:
 	if (swap_header)
@@ -955,27 +961,26 @@
 void si_swapinfo(struct sysinfo *val)
 {
 	unsigned int i;
-	unsigned long freeswap = 0;
-	unsigned long totalswap = 0;
+	unsigned long nr_to_be_unused = 0;
 
+	swap_list_lock();
 	for (i = 0; i < nr_swapfiles; i++) {
 		unsigned int j;
-		if ((swap_info[i].flags & SWP_WRITEOK) != SWP_WRITEOK)
+		if (swap_info[i].flags != SWP_USED)
 			continue;
 		for (j = 0; j < swap_info[i].max; ++j) {
 			switch (swap_info[i].swap_map[j]) {
+				case 0:
 				case SWAP_MAP_BAD:
 					continue;
-				case 0:
-					freeswap++;
 				default:
-					totalswap++;
+					nr_to_be_unused++;
 			}
 		}
 	}
-	val->freeswap = freeswap;
-	val->totalswap = totalswap;
-	return;
+	val->freeswap = nr_swap_pages + nr_to_be_unused;
+	val->totalswap = total_swap_pages + nr_to_be_unused;
+	swap_list_unlock();
 }
 
 /*
@@ -990,43 +995,31 @@
 	unsigned long offset, type;
 	int result = 0;
 
-	/* Swap entry 0 is illegal */
-	if (!entry.val)
-		goto out;
 	type = SWP_TYPE(entry);
 	if (type >= nr_swapfiles)
 		goto bad_file;
 	p = type + swap_info;
 	offset = SWP_OFFSET(entry);
-	if (offset >= p->max)
-		goto bad_offset;
-	if (!p->swap_map[offset])
-		goto bad_unused;
-	/*
-	 * Entry is valid, so increment the map count.
-	 */
+
 	swap_device_lock(p);
-	if (p->swap_map[offset] < SWAP_MAP_MAX)
-		p->swap_map[offset]++;
-	else {
-		if (swap_overflow++ < 5)
-			printk(KERN_WARNING "swap_dup: swap entry overflow\n");
-		p->swap_map[offset] = SWAP_MAP_MAX;
+	if (offset < p->max && p->swap_map[offset]) {
+		if (p->swap_map[offset] < SWAP_MAP_MAX - 1) {
+			p->swap_map[offset]++;
+			result = 1;
+		} else if (p->swap_map[offset] <= SWAP_MAP_MAX) {
+			if (swap_overflow++ < 5)
+				printk(KERN_WARNING "swap_dup: swap entry overflow\n");
+			p->swap_map[offset] = SWAP_MAP_MAX;
+			result = 1;
+		}
 	}
 	swap_device_unlock(p);
-	result = 1;
 out:
 	return result;
 
 bad_file:
 	printk(KERN_ERR "swap_dup: %s%08lx\n", Bad_file, entry.val);
 	goto out;
-bad_offset:
-	/* Don't report: can happen in read_swap_cache_async after swapoff */
-	goto out;
-bad_unused:
-	/* Don't report: can happen in read_swap_cache_async after blocking */
-	goto out;
 }
 
 /*
@@ -1071,7 +1064,7 @@
 }
 
 /*
- * Kernel_lock protects against swap device deletion.
+ * Prior swap_duplicate protects against swap device deletion.
  */
 void get_swaphandle_info(swp_entry_t entry, unsigned long *offset, 
 			kdev_t *dev, struct inode **swapf)
@@ -1111,7 +1104,7 @@
 }
 
 /*
- * Kernel_lock protects against swap device deletion. Don't grab an extra
+ * swap_device_lock prevents swap_map being freed. Don't grab an extra
  * reference on the swaphandle, it doesn't matter if it becomes unused.
  */
 int valid_swaphandles(swp_entry_t entry, unsigned long *offset)
@@ -1120,14 +1113,19 @@
 	unsigned long toff;
 	struct swap_info_struct *swapdev = SWP_TYPE(entry) + swap_info;
 
-	*offset = SWP_OFFSET(entry);
-	toff = *offset = (*offset >> page_cluster) << page_cluster;
+	if (!page_cluster)	/* no readahead */
+		return 0;
+	toff = (SWP_OFFSET(entry) >> page_cluster) << page_cluster;
+	if (!toff)		/* first page is swap header */
+		toff++, i--;
+	*offset = toff;
 
+	swap_device_lock(swapdev);
 	do {
 		/* Don't read-ahead past the end of the swap area */
 		if (toff >= swapdev->max)
 			break;
-		/* Don't read in bad or busy pages */
+		/* Don't read in unused or bad pages */
 		if (!swapdev->swap_map[toff])
 			break;
 		if (swapdev->swap_map[toff] == SWAP_MAP_BAD)
@@ -1135,5 +1133,6 @@
 		toff++;
 		ret++;
 	} while (--i);
+	swap_device_unlock(swapdev);
 	return ret;
 }
--- 2.4.10-pre9/mm/vmscan.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/vmscan.c	Sat Sep 15 09:15:29 2001
@@ -122,8 +122,8 @@
 		entry.val = page->index;
 		if (pte_dirty(pte))
 			set_page_dirty(page);
-set_swap_pte:
 		swap_duplicate(entry);
+set_swap_pte:
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
@@ -166,16 +166,17 @@
 	 * we have the swap cache set up to associate the
 	 * page with that swap entry.
 	 */
+	swap_list_lock();
 	entry = get_swap_page();
-	if (!entry.val)
-		goto out_unlock_restore; /* No swap space left */
-
-	/* Add it to the swap cache and mark it dirty */
-	add_to_swap_cache(page, entry);
-	set_page_dirty(page);
-	goto set_swap_pte;
+	if (entry.val) {
+		add_to_swap_cache(page, entry);
+		swap_list_unlock();
+		set_page_dirty(page);
+		goto set_swap_pte;
+	}
 
-out_unlock_restore:
+	/* No swap space left */
+	swap_list_unlock();
 	set_pte(page_table, pte);
 	UnlockPage(page);
 	return;
@@ -384,6 +385,7 @@
 {
 	struct page * page = NULL;
 	struct list_head * page_lru;
+	swp_entry_t entry = {0};
 	int maxscan;
 
 	/*
@@ -423,6 +425,7 @@
 
 		/* OK, remove the page from the caches. */
 		if (PageSwapCache(page)) {
+			entry.val = page->index;
 			__delete_from_swap_cache(page);
 			goto found_page;
 		}
@@ -438,21 +441,22 @@
 		zone->inactive_clean_pages--;
 		UnlockPage(page);
 	}
-	/* Reset page pointer, maybe we encountered an unfreeable page. */
-	page = NULL;
-	goto out;
+	spin_unlock(&pagemap_lru_lock);
+	spin_unlock(&pagecache_lock);
+	return NULL;
 
 found_page:
 	memory_pressure++;
 	del_page_from_inactive_clean_list(page);
+	spin_unlock(&pagemap_lru_lock);
+	spin_unlock(&pagecache_lock);
+	if (entry.val)
+		swap_free(entry);
 	UnlockPage(page);
 	page->age = PAGE_AGE_START;
 	if (page_count(page) != 1)
 		printk("VM: reclaim_page, found page with count %d!\n",
 				page_count(page));
-out:
-	spin_unlock(&pagemap_lru_lock);
-	spin_unlock(&pagecache_lock);
 	return page;
 }
 

