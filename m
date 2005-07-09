Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbVGIAND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbVGIAND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVGIALL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:11:11 -0400
Received: from silver.veritas.com ([143.127.12.111]:3648 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263008AbVGIAKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:10:19 -0400
Date: Sat, 9 Jul 2005 01:11:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] swap_lock replace list+device
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090110220.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:10:17.0979 (UTC) FILETIME=[968D5CB0:01C5841A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idea of a swap_device_lock per device, and a swap_list_lock over them
all, is appealing; but in practice almost every holder of swap_device_lock
must already hold swap_list_lock, which defeats the purpose of the split.

The only exceptions have been swap_duplicate, valid_swaphandles and an
untrodden path in try_to_unuse (plus a few places added in this series).
valid_swaphandles doesn't show up high in profiles, but swap_duplicate
does demand attention.  However, with the hold time in get_swap_pages so
much reduced, I've not yet found a load and set of swap device priorities
to show even swap_duplicate benefitting from the split.  Certainly the
split is mere overhead in the common case of a single swap device.

So, replace swap_list_lock and swap_device_lock by spinlock_t swap_lock
(generally we seem to prefer an _ in the name, and not hide in a macro).

If someone can show a regression in swap_duplicate, then probably we
should add a hashlock for the swap_map entries alone (shorts being
anatomic), so as to help the case of the single swap device too.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 Documentation/vm/locking |   15 ++---
 include/linux/swap.h     |   11 ----
 mm/filemap.c             |    7 +-
 mm/rmap.c                |    3 -
 mm/swapfile.c            |  125 +++++++++++++++++++----------------------------
 5 files changed, 66 insertions(+), 95 deletions(-)

--- swap11/Documentation/vm/locking	2004-06-16 06:20:38.000000000 +0100
+++ swap12/Documentation/vm/locking	2005-07-08 19:15:46.000000000 +0100
@@ -83,19 +83,18 @@ single address space optimization, so th
 vmtruncate) does not lose sending ipi's to cloned threads that might 
 be spawned underneath it and go to user mode to drag in pte's into tlbs.
 
-swap_list_lock/swap_device_lock
--------------------------------
+swap_lock
+--------------
 The swap devices are chained in priority order from the "swap_list" header. 
 The "swap_list" is used for the round-robin swaphandle allocation strategy.
 The #free swaphandles is maintained in "nr_swap_pages". These two together
-are protected by the swap_list_lock. 
+are protected by the swap_lock. 
 
-The swap_device_lock, which is per swap device, protects the reference 
-counts on the corresponding swaphandles, maintained in the "swap_map"
-array, and the "highest_bit" and "lowest_bit" fields.
+The swap_lock also protects all the device reference counts on the
+corresponding swaphandles, maintained in the "swap_map" array, and the
+"highest_bit" and "lowest_bit" fields.
 
-Both of these are spinlocks, and are never acquired from intr level. The
-locking hierarchy is swap_list_lock -> swap_device_lock.
+The swap_lock is a spinlock, and is never acquired from intr level.
 
 To prevent races between swap space deletion or async readahead swapins
 deciding whether a swap handle is being used, ie worthy of being read in
--- swap11/include/linux/swap.h	2005-07-08 19:15:20.000000000 +0100
+++ swap12/include/linux/swap.h	2005-07-08 19:15:46.000000000 +0100
@@ -120,7 +120,7 @@ enum {
  */
 struct swap_info_struct {
 	unsigned int flags;
-	spinlock_t sdev_lock;
+	int prio;			/* swap priority */
 	struct file *swap_file;
 	struct block_device *bdev;
 	struct list_head extent_list;
@@ -134,7 +134,6 @@ struct swap_info_struct {
 	unsigned int pages;
 	unsigned int max;
 	unsigned int inuse_pages;
-	int prio;			/* swap priority */
 	int next;			/* next entry on swap list */
 };
 
@@ -220,13 +219,7 @@ extern int can_share_swap_page(struct pa
 extern int remove_exclusive_swap_page(struct page *);
 struct backing_dev_info;
 
-extern struct swap_list_t swap_list;
-extern spinlock_t swaplock;
-
-#define swap_list_lock()	spin_lock(&swaplock)
-#define swap_list_unlock()	spin_unlock(&swaplock)
-#define swap_device_lock(p)	spin_lock(&p->sdev_lock)
-#define swap_device_unlock(p)	spin_unlock(&p->sdev_lock)
+extern spinlock_t swap_lock;
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
--- swap11/mm/filemap.c	2005-07-07 12:33:21.000000000 +0100
+++ swap12/mm/filemap.c	2005-07-08 19:15:46.000000000 +0100
@@ -58,9 +58,8 @@ generic_file_direct_IO(int rw, struct ki
  *
  *  ->i_mmap_lock		(vmtruncate)
  *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
- *      ->swap_list_lock
- *        ->swap_device_lock	(exclusive_swap_page, others)
- *          ->mapping->tree_lock
+ *      ->swap_lock		(exclusive_swap_page, others)
+ *        ->mapping->tree_lock
  *
  *  ->i_sem
  *    ->i_mmap_lock		(truncate->unmap_mapping_range)
@@ -90,7 +89,7 @@ generic_file_direct_IO(int rw, struct ki
  *    ->page_table_lock		(anon_vma_prepare and various)
  *
  *  ->page_table_lock
- *    ->swap_device_lock	(try_to_unmap_one)
+ *    ->swap_lock		(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->tree_lock		(try_to_unmap_one)
  *    ->zone.lru_lock		(follow_page->mark_page_accessed)
--- swap11/mm/rmap.c	2005-07-07 12:33:21.000000000 +0100
+++ swap12/mm/rmap.c	2005-07-08 19:15:46.000000000 +0100
@@ -34,9 +34,8 @@
  *       anon_vma->lock
  *         mm->page_table_lock
  *           zone->lru_lock (in mark_page_accessed)
- *           swap_list_lock (in swap_free etc's swap_info_get)
+ *           swap_lock (in swap_duplicate, swap_info_get)
  *             mmlist_lock (in mmput, drain_mmlist and others)
- *             swap_device_lock (in swap_duplicate, swap_info_get)
  *             mapping->private_lock (in __set_page_dirty_buffers)
  *             inode_lock (in set_page_dirty's __mark_inode_dirty)
  *               sb_lock (within inode_lock in fs/fs-writeback.c)
--- swap11/mm/swapfile.c	2005-07-08 19:15:33.000000000 +0100
+++ swap12/mm/swapfile.c	2005-07-08 19:15:46.000000000 +0100
@@ -31,7 +31,7 @@
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
 
-DEFINE_SPINLOCK(swaplock);
+DEFINE_SPINLOCK(swap_lock);
 unsigned int nr_swapfiles;
 long total_swap_pages;
 static int swap_overflow;
@@ -49,7 +49,7 @@ static DECLARE_MUTEX(swapon_sem);
 
 /*
  * We need this because the bdev->unplug_fn can sleep and we cannot
- * hold swap_list_lock while calling the unplug_fn. And swap_list_lock
+ * hold swap_lock while calling the unplug_fn. And swap_lock
  * cannot be turned into a semaphore.
  */
 static DECLARE_RWSEM(swap_unplug_sem);
@@ -103,7 +103,7 @@ static inline unsigned long scan_swap_ma
 		si->cluster_nr = SWAPFILE_CLUSTER - 1;
 		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER)
 			goto lowest;
-		swap_device_unlock(si);
+		spin_unlock(&swap_lock);
 
 		offset = si->lowest_bit;
 		last_in_cluster = offset + SWAPFILE_CLUSTER - 1;
@@ -113,7 +113,7 @@ static inline unsigned long scan_swap_ma
 			if (si->swap_map[offset])
 				last_in_cluster = offset + SWAPFILE_CLUSTER;
 			else if (offset == last_in_cluster) {
-				swap_device_lock(si);
+				spin_lock(&swap_lock);
 				si->cluster_next = offset-SWAPFILE_CLUSTER-1;
 				goto cluster;
 			}
@@ -122,7 +122,7 @@ static inline unsigned long scan_swap_ma
 				latency_ration = LATENCY_LIMIT;
 			}
 		}
-		swap_device_lock(si);
+		spin_lock(&swap_lock);
 		goto lowest;
 	}
 
@@ -151,10 +151,10 @@ checks:	if (!(si->flags & SWP_WRITEOK))
 		return offset;
 	}
 
-	swap_device_unlock(si);
+	spin_unlock(&swap_lock);
 	while (++offset <= si->highest_bit) {
 		if (!si->swap_map[offset]) {
-			swap_device_lock(si);
+			spin_lock(&swap_lock);
 			goto checks;
 		}
 		if (unlikely(--latency_ration < 0)) {
@@ -162,7 +162,7 @@ checks:	if (!(si->flags & SWP_WRITEOK))
 			latency_ration = LATENCY_LIMIT;
 		}
 	}
-	swap_device_lock(si);
+	spin_lock(&swap_lock);
 	goto lowest;
 
 no_page:
@@ -177,7 +177,7 @@ swp_entry_t get_swap_page(void)
 	int type, next;
 	int wrapped = 0;
 
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	if (nr_swap_pages <= 0)
 		goto noswap;
 	nr_swap_pages--;
@@ -197,19 +197,17 @@ swp_entry_t get_swap_page(void)
 			continue;
 
 		swap_list.next = next;
-		swap_device_lock(si);
-		swap_list_unlock();
 		offset = scan_swap_map(si);
-		swap_device_unlock(si);
-		if (offset)
+		if (offset) {
+			spin_unlock(&swap_lock);
 			return swp_entry(type, offset);
-		swap_list_lock();
+		}
 		next = swap_list.next;
 	}
 
 	nr_swap_pages++;
 noswap:
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 	return (swp_entry_t) {0};
 }
 
@@ -231,8 +229,7 @@ static struct swap_info_struct * swap_in
 		goto bad_offset;
 	if (!p->swap_map[offset])
 		goto bad_free;
-	swap_list_lock();
-	swap_device_lock(p);
+	spin_lock(&swap_lock);
 	return p;
 
 bad_free:
@@ -250,12 +247,6 @@ out:
 	return NULL;
 }	
 
-static void swap_info_put(struct swap_info_struct * p)
-{
-	swap_device_unlock(p);
-	swap_list_unlock();
-}
-
 static int swap_entry_free(struct swap_info_struct *p, unsigned long offset)
 {
 	int count = p->swap_map[offset];
@@ -288,7 +279,7 @@ void swap_free(swp_entry_t entry)
 	p = swap_info_get(entry);
 	if (p) {
 		swap_entry_free(p, swp_offset(entry));
-		swap_info_put(p);
+		spin_unlock(&swap_lock);
 	}
 }
 
@@ -306,7 +297,7 @@ static inline int page_swapcount(struct 
 	if (p) {
 		/* Subtract the 1 for the swap cache itself */
 		count = p->swap_map[swp_offset(entry)] - 1;
-		swap_info_put(p);
+		spin_unlock(&swap_lock);
 	}
 	return count;
 }
@@ -363,7 +354,7 @@ int remove_exclusive_swap_page(struct pa
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
 	}
-	swap_info_put(p);
+	spin_unlock(&swap_lock);
 
 	if (retval) {
 		swap_free(entry);
@@ -386,7 +377,7 @@ void free_swap_and_cache(swp_entry_t ent
 	if (p) {
 		if (swap_entry_free(p, swp_offset(entry)) == 1)
 			page = find_trylock_page(&swapper_space, entry.val);
-		swap_info_put(p);
+		spin_unlock(&swap_lock);
 	}
 	if (page) {
 		int one_user;
@@ -556,10 +547,10 @@ static unsigned int find_next_to_unuse(s
 	int count;
 
 	/*
-	 * No need for swap_device_lock(si) here: we're just looking
+	 * No need for swap_lock here: we're just looking
 	 * for whether an entry is in use, not modifying it; false
 	 * hits are okay, and sys_swapoff() has already prevented new
-	 * allocations from this area (while holding swap_list_lock()).
+	 * allocations from this area (while holding swap_lock).
 	 */
 	for (;;) {
 		if (++i >= max) {
@@ -749,9 +740,9 @@ static int try_to_unuse(unsigned int typ
 		 * report them; but do report if we reset SWAP_MAP_MAX.
 		 */
 		if (*swap_map == SWAP_MAP_MAX) {
-			swap_device_lock(si);
+			spin_lock(&swap_lock);
 			*swap_map = 1;
-			swap_device_unlock(si);
+			spin_unlock(&swap_lock);
 			reset_overflow = 1;
 		}
 
@@ -815,9 +806,9 @@ static int try_to_unuse(unsigned int typ
 }
 
 /*
- * After a successful try_to_unuse, if no swap is now in use, we know we
- * can empty the mmlist.  swap_list_lock must be held on entry and exit.
- * Note that mmlist_lock nests inside swap_list_lock, and an mm must be
+ * After a successful try_to_unuse, if no swap is now in use, we know
+ * we can empty the mmlist.  swap_lock must be held on entry and exit.
+ * Note that mmlist_lock nests inside swap_lock, and an mm must be
  * added to the mmlist just after page_duplicate - before would be racy.
  */
 static void drain_mmlist(void)
@@ -1090,7 +1081,7 @@ asmlinkage long sys_swapoff(const char _
 
 	mapping = victim->f_mapping;
 	prev = -1;
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	for (type = swap_list.head; type >= 0; type = swap_info[type].next) {
 		p = swap_info + type;
 		if ((p->flags & SWP_ACTIVE) == SWP_ACTIVE) {
@@ -1101,14 +1092,14 @@ asmlinkage long sys_swapoff(const char _
 	}
 	if (type < 0) {
 		err = -EINVAL;
-		swap_list_unlock();
+		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
 	if (!security_vm_enough_memory(p->pages))
 		vm_unacct_memory(p->pages);
 	else {
 		err = -ENOMEM;
-		swap_list_unlock();
+		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
 	if (prev < 0) {
@@ -1122,10 +1113,8 @@ asmlinkage long sys_swapoff(const char _
 	}
 	nr_swap_pages -= p->pages;
 	total_swap_pages -= p->pages;
-	swap_device_lock(p);
 	p->flags &= ~SWP_WRITEOK;
-	swap_device_unlock(p);
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 
 	current->flags |= PF_SWAPOFF;
 	err = try_to_unuse(type);
@@ -1133,7 +1122,7 @@ asmlinkage long sys_swapoff(const char _
 
 	if (err) {
 		/* re-insert swap space back into swap_list */
-		swap_list_lock();
+		spin_lock(&swap_lock);
 		for (prev = -1, i = swap_list.head; i >= 0; prev = i, i = swap_info[i].next)
 			if (p->prio >= swap_info[i].prio)
 				break;
@@ -1144,10 +1133,8 @@ asmlinkage long sys_swapoff(const char _
 			swap_info[prev].next = p - swap_info;
 		nr_swap_pages += p->pages;
 		total_swap_pages += p->pages;
-		swap_device_lock(p);
 		p->flags |= SWP_WRITEOK;
-		swap_device_unlock(p);
-		swap_list_unlock();
+		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
 
@@ -1155,30 +1142,27 @@ asmlinkage long sys_swapoff(const char _
 	down_write(&swap_unplug_sem);
 	up_write(&swap_unplug_sem);
 
+	destroy_swap_extents(p);
+	down(&swapon_sem);
+	spin_lock(&swap_lock);
+	drain_mmlist();
+
 	/* wait for anyone still in scan_swap_map */
-	swap_device_lock(p);
 	p->highest_bit = 0;		/* cuts scans short */
 	while (p->flags >= SWP_SCANNING) {
-		swap_device_unlock(p);
+		spin_unlock(&swap_lock);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
-		swap_device_lock(p);
+		spin_lock(&swap_lock);
 	}
-	swap_device_unlock(p);
 
-	destroy_swap_extents(p);
-	down(&swapon_sem);
-	swap_list_lock();
-	drain_mmlist();
-	swap_device_lock(p);
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
 	p->max = 0;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	p->flags = 0;
-	swap_device_unlock(p);
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 	up(&swapon_sem);
 	vfree(swap_map);
 	inode = mapping->host;
@@ -1322,7 +1306,7 @@ asmlinkage long sys_swapon(const char __
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	p = swap_info;
 	for (type = 0 ; type < nr_swapfiles ; type++,p++)
 		if (!(p->flags & SWP_USED))
@@ -1341,7 +1325,7 @@ asmlinkage long sys_swapon(const char __
 	 * swp_entry_t or the architecture definition of a swap pte.
 	 */
 	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
-		swap_list_unlock();
+		spin_unlock(&swap_lock);
 		goto out;
 	}
 	if (type >= nr_swapfiles)
@@ -1355,7 +1339,6 @@ asmlinkage long sys_swapon(const char __
 	p->highest_bit = 0;
 	p->cluster_nr = 0;
 	p->inuse_pages = 0;
-	spin_lock_init(&p->sdev_lock);
 	p->next = -1;
 	if (swap_flags & SWAP_FLAG_PREFER) {
 		p->prio =
@@ -1363,7 +1346,7 @@ asmlinkage long sys_swapon(const char __
 	} else {
 		p->prio = --least_priority;
 	}
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 	name = getname(specialfile);
 	error = PTR_ERR(name);
 	if (IS_ERR(name)) {
@@ -1540,8 +1523,7 @@ asmlinkage long sys_swapon(const char __
 	}
 
 	down(&swapon_sem);
-	swap_list_lock();
-	swap_device_lock(p);
+	spin_lock(&swap_lock);
 	p->flags = SWP_ACTIVE;
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
@@ -1565,8 +1547,7 @@ asmlinkage long sys_swapon(const char __
 	} else {
 		swap_info[prev].next = p - swap_info;
 	}
-	swap_device_unlock(p);
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 	up(&swapon_sem);
 	error = 0;
 	goto out;
@@ -1577,14 +1558,14 @@ bad_swap:
 	}
 	destroy_swap_extents(p);
 bad_swap_2:
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	swap_map = p->swap_map;
 	p->swap_file = NULL;
 	p->swap_map = NULL;
 	p->flags = 0;
 	if (!(swap_flags & SWAP_FLAG_PREFER))
 		++least_priority;
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 	vfree(swap_map);
 	if (swap_file)
 		filp_close(swap_file, NULL);
@@ -1608,7 +1589,7 @@ void si_swapinfo(struct sysinfo *val)
 	unsigned int i;
 	unsigned long nr_to_be_unused = 0;
 
-	swap_list_lock();
+	spin_lock(&swap_lock);
 	for (i = 0; i < nr_swapfiles; i++) {
 		if (!(swap_info[i].flags & SWP_USED) ||
 		     (swap_info[i].flags & SWP_WRITEOK))
@@ -1617,7 +1598,7 @@ void si_swapinfo(struct sysinfo *val)
 	}
 	val->freeswap = nr_swap_pages + nr_to_be_unused;
 	val->totalswap = total_swap_pages + nr_to_be_unused;
-	swap_list_unlock();
+	spin_unlock(&swap_lock);
 }
 
 /*
@@ -1638,7 +1619,7 @@ int swap_duplicate(swp_entry_t entry)
 	p = type + swap_info;
 	offset = swp_offset(entry);
 
-	swap_device_lock(p);
+	spin_lock(&swap_lock);
 	if (offset < p->max && p->swap_map[offset]) {
 		if (p->swap_map[offset] < SWAP_MAP_MAX - 1) {
 			p->swap_map[offset]++;
@@ -1650,7 +1631,7 @@ int swap_duplicate(swp_entry_t entry)
 			result = 1;
 		}
 	}
-	swap_device_unlock(p);
+	spin_unlock(&swap_lock);
 out:
 	return result;
 
@@ -1666,7 +1647,7 @@ get_swap_info_struct(unsigned type)
 }
 
 /*
- * swap_device_lock prevents swap_map being freed. Don't grab an extra
+ * swap_lock prevents swap_map being freed. Don't grab an extra
  * reference on the swaphandle, it doesn't matter if it becomes unused.
  */
 int valid_swaphandles(swp_entry_t entry, unsigned long *offset)
@@ -1682,7 +1663,7 @@ int valid_swaphandles(swp_entry_t entry,
 		toff++, i--;
 	*offset = toff;
 
-	swap_device_lock(swapdev);
+	spin_lock(&swap_lock);
 	do {
 		/* Don't read-ahead past the end of the swap area */
 		if (toff >= swapdev->max)
@@ -1695,6 +1676,6 @@ int valid_swaphandles(swp_entry_t entry,
 		toff++;
 		ret++;
 	} while (--i);
-	swap_device_unlock(swapdev);
+	spin_unlock(&swap_lock);
 	return ret;
 }
