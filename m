Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbQKOJv6>; Wed, 15 Nov 2000 04:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQKOJvs>; Wed, 15 Nov 2000 04:51:48 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:759 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129775AbQKOJvj>; Wed, 15 Nov 2000 04:51:39 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <qwwpujx383v.fsf@sap.com>
Organisation: SAP LinuxLab
Date: 15 Nov 2000 10:21:27 +0100
In-Reply-To: Christoph Rohland's message of "15 Nov 2000 10:19:48 +0100"
Message-ID: <qwwlmul3814.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to append the patch...

Greetings
		Christoph

diff -uNr 4-11-3/ipc/shm.c c/ipc/shm.c
--- 4-11-3/ipc/shm.c	Wed Oct  4 15:58:02 2000
+++ c/ipc/shm.c	Tue Nov 14 17:43:01 2000
@@ -80,6 +80,7 @@
 	unsigned long		shm_npages; /* size of segment (pages) */
 	pte_t			**shm_dir;  /* ptr to arr of ptrs to frames */ 
 	int			id;
+	struct list_head	list;
 	union permap {
 		struct shmem {
 			time_t			atime;
@@ -92,7 +93,6 @@
 		} shmem;
 		struct zero {
 			struct semaphore	sema;
-			struct list_head	list;
 		} zero;
 	} permap;
 };
@@ -106,7 +106,6 @@
 #define shm_name	permap.shmem.nm
 #define shm_flags	shm_perm.mode
 #define zsem		permap.zero.sema
-#define zero_list	permap.zero.list
 
 static struct ipc_ids shm_ids;
 
@@ -129,13 +128,12 @@
 static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
 #endif
 
-static void zshm_swap (int prio, int gfp_mask);
-static void zmap_unuse(swp_entry_t entry, struct page *page);
 static void shmzero_open(struct vm_area_struct *shmd);
 static void shmzero_close(struct vm_area_struct *shmd);
 static struct page *shmzero_nopage(struct vm_area_struct * shmd, unsigned long address, int no_share);
 static int zero_id;
 static struct shmid_kernel zshmid_kernel;
+static struct list_head shm_list;
 static struct dentry *zdent;
 
 #define SHM_FS_MAGIC 0x02011994
@@ -223,7 +221,7 @@
 #endif
 	zero_id = ipc_addid(&shm_ids, &zshmid_kernel.shm_perm, 1);
 	shm_unlock(zero_id);
-	INIT_LIST_HEAD(&zshmid_kernel.zero_list);
+	INIT_LIST_HEAD(&shm_list);
 	zdent = d_alloc_root(get_empty_inode());
 	return;
 }
@@ -572,13 +570,13 @@
 	if (pages == 0)
 		return NULL;
 
-	ret = kmalloc ((dir+1) * sizeof(pte_t *), GFP_KERNEL);
+	ret = kmalloc ((dir+1) * sizeof(pte_t *), GFP_USER);
 	if (!ret)
 		goto nomem;
 
 	for (ptr = ret; ptr < ret+dir ; ptr++)
 	{
-		*ptr = (pte_t *)__get_free_page (GFP_KERNEL);
+		*ptr = (pte_t *)__get_free_page (GFP_USER);
 		if (!*ptr)
 			goto free;
 		init_ptes (*ptr, PTES_PER_PAGE);
@@ -586,7 +584,7 @@
 
 	/* The last one is probably not of PAGE_SIZE: we use kmalloc */
 	if (last) {
-		*ptr = kmalloc (last*sizeof(pte_t), GFP_KERNEL);
+		*ptr = kmalloc (last*sizeof(pte_t), GFP_USER);
 		if (!*ptr)
 			goto free;
 		init_ptes (*ptr, last);
@@ -724,7 +722,7 @@
 	struct shmid_kernel *shp;
 	pte_t		   **dir;
 
-	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp) + namelen, GFP_KERNEL);
+	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp) + namelen, GFP_USER);
 	if (!shp)
 		return ERR_PTR(-ENOMEM);
 
@@ -737,11 +735,17 @@
 	shp->shm_npages = numpages;
 	shp->shm_nattch = 0;
 	shp->shm_namelen = namelen;
+	shm_lockall();
+	list_add_tail(&shp->list, &shm_list);
+	shm_unlockall();
 	return(shp);
 }
 
 static void seg_free(struct shmid_kernel *shp, int doacc)
 {
+	shm_lockall();
+	list_del(&shp->list);
+	shm_unlockall();
 	shm_free (shp->shm_dir, shp->shm_npages, doacc);
 	kfree(shp);
 }
@@ -1460,32 +1464,45 @@
 	return(page);
 }
 
-#define OKAY	0
-#define RETRY	1
-#define FAILED	2
-
-static int shm_swap_core(struct shmid_kernel *shp, unsigned long idx, swp_entry_t swap_entry, int *counter, struct page **outpage)
+static int shm_swap_core(struct shmid_kernel *shp, unsigned long * idx, 
+			 swp_entry_t swap_entry, struct page **outpage)
 {
 	pte_t page;
 	struct page *page_map;
+        int lowonly = 0;
+	int index;
+
+	while ((index = (*idx)++) < shp->shm_npages) {
+		page = SHM_ENTRY(shp, index);
+		if (!pte_present(page))
+			continue;
+		page_map = pte_page(page);
+		if (page_map->zone->free_pages > page_map->zone->pages_high)
+			continue;
+		if (lowonly && PageHighMem (page_map))
+			continue;
+        
+		if (shp->id != zero_id) swap_attempts++;
+
+		if (page_count(page_map) != 1)
+			continue;
+
+		if (TryLockPage(page_map)) {
+			printk ("shm_swap_core: page locked\n");
+			continue;
+		}
+
+		page_map = prepare_highmem_swapout(page_map);
+		if (page_map)
+			goto swap_out;   
+
+		lowonly = 1; /* We continue to free some lowmem pages */
+	}
+
+	return 0;
 
-	page = SHM_ENTRY(shp, idx);
-	if (!pte_present(page))
-		return RETRY;
-	page_map = pte_page(page);
-	if (page_map->zone->free_pages > page_map->zone->pages_high)
-		return RETRY;
-	if (shp->id != zero_id) swap_attempts++;
-
-	if (--*counter < 0) /* failed */
-		return FAILED;
-	if (page_count(page_map) != 1)
-		return RETRY;
-
-	lock_page(page_map);
-	if (!(page_map = prepare_highmem_swapout(page_map)))
-		return FAILED;
-	SHM_ENTRY (shp, idx) = swp_entry_to_pte(swap_entry);
+swap_out:
+	SHM_ENTRY (shp, index) = swp_entry_to_pte(swap_entry);
 
 	/* add the locked page to the swap cache before allowing
 	   the swapin path to run lookup_swap_cache(). This avoids
@@ -1493,97 +1510,81 @@
 	   NOTE: we just accounted the swap space reference for this
 	   swap cache page at __get_swap_page() time. */
 	add_to_swap_cache(*outpage = page_map, swap_entry);
-	return OKAY;
-}
-
-static void shm_swap_postop(struct page *page)
-{
-	lock_kernel();
-	rw_swap_page(WRITE, page, 0);
-	unlock_kernel();
-	page_cache_release(page);
-}
-
-static int shm_swap_preop(swp_entry_t *swap_entry)
-{
-	lock_kernel();
-	/* subtle: preload the swap count for the swap cache. We can't
-	   increase the count inside the critical section as we can't release
-	   the shm_lock there. And we can't acquire the big lock with the
-	   shm_lock held (otherwise we would deadlock too easily). */
-	*swap_entry = __get_swap_page(2);
-	if (!(*swap_entry).val) {
-		unlock_kernel();
-		return 1;
-	}
-	unlock_kernel();
-	return 0;
+	return 1;
 }
 
 /*
- * Goes through counter = (shm_rss >> prio) present shm pages.
+ * Tries to free count pages
  */
-static unsigned long swap_id; /* currently being swapped */
-static unsigned long swap_idx; /* next to swap */
 
-int shm_swap (int prio, int gfp_mask)
+int shm_swap (int count, int gfp_mask)
 {
+	static unsigned long swap_idx; /* next to swap */
 	struct shmid_kernel *shp;
 	swp_entry_t swap_entry;
-	unsigned long id, idx;
-	int loop = 0;
-	int counter;
+	int counter = 0;
 	struct page * page_map;
+	struct list_head *p;
 
 	/*
 	 * Push this inside:
 	 */
-	if (!(gfp_mask & __GFP_IO))
+	if (!(gfp_mask & __GFP_IO)) {
+                printk ("shm_swap !__GFP_IO\n");
 		return 0;
+        }
 
-	zshm_swap(prio, gfp_mask);
-	counter = shm_rss >> prio;
-	if (!counter)
-		return 0;
-	if (shm_swap_preop(&swap_entry))
-		return 0;
+next:
+	if (counter >= count)
+		goto out;
+
+	lock_kernel();
+	/* subtle: preload the swap count for the swap cache. We can't
+	   increase the count inside the critical section as we can't release
+	   the shm_lock there. And we can't acquire the big lock with the
+	   shm_lock held (otherwise we would deadlock too easily). */
+	swap_entry = __get_swap_page(2);
+	if (!swap_entry.val) {
+		unlock_kernel();
+		goto out;
+	}
+	unlock_kernel();
 
 	shm_lockall();
-check_id:
-	shp = shm_get(swap_id);
-	if(shp==NULL || shp->shm_flags & PRV_LOCKED) {
-next_id:
+	list_for_each (p, &shm_list) {
+		shp = list_entry (p, struct shmid_kernel, list);
+
+		if (shp->id != zero_id && shp->shm_flags & PRV_LOCKED)
+			continue;
+		if (shm_swap_core(shp, &swap_idx, swap_entry, &page_map))
+			goto found;
+
 		swap_idx = 0;
-		if (++swap_id > shm_ids.max_id) {
-			swap_id = 0;
-			if (loop) {
-failed:
-				shm_unlockall();
-				__swap_free(swap_entry, 2);
-				return 0;
-			}
-			loop = 1;
-		}
-		goto check_id;
 	}
-	id = swap_id;
+        shm_unlockall();
+        __swap_free(swap_entry, 2);
+out:
+	printk ("shm_swap %d/%d\n", counter, count);
+	return counter;
 
-check_table:
-	idx = swap_idx++;
-	if (idx >= shp->shm_npages)
-		goto next_id;
+found:
+	if (shp->id != zero_id) {
+		counter++;
+		swap_successes++;
+		shm_swp++;
+		shm_rss--;
+	}
 
-	switch (shm_swap_core(shp, idx, swap_entry, &counter, &page_map)) {
-		case RETRY: goto check_table;
-		case FAILED: goto failed;
-	}
-	swap_successes++;
-	shm_swp++;
-	shm_rss--;
-	shm_unlockall();
+	/* adjust shm_list to start at the last processed segment */
+	list_del (&shm_list);
+	list_add_tail (&shm_list, &shp->list);
 
-	shm_swap_postop(page_map);
-	return 1;
+	shm_unlockall();
+	lock_kernel();
+	rw_swap_page(WRITE, page_map, 0);
+	unlock_kernel();
+	page_cache_release(page_map);
+        goto next;
 }
 
 /*
@@ -1597,48 +1598,44 @@
 	pte = pte_mkdirty(mk_pte(page, PAGE_SHARED));
 	SHM_ENTRY(shp, idx) = pte;
 	page_cache_get(page);
-	shm_rss++;
 
-	shm_swp--;
+	if (shp->id != zero_id) {
+		shm_rss++;
+		shm_swp--;
+	}
 
 	swap_free(entry);
 }
 
-static int shm_unuse_core(struct shmid_kernel *shp, swp_entry_t entry, struct page *page)
-{
-	int n;
-
-	for (n = 0; n < shp->shm_npages; n++) {
-		if (pte_none(SHM_ENTRY(shp,n)))
-			continue;
-		if (pte_present(SHM_ENTRY(shp,n)))
-			continue;
-		if (pte_to_swp_entry(SHM_ENTRY(shp,n)).val == entry.val) {
-			shm_unuse_page(shp, n, entry, page);
-			return 1;
-		}
-	}
-	return 0;
-}
-
 /*
  * unuse_shm() search for an eventually swapped out shm page.
  */
 void shm_unuse(swp_entry_t entry, struct page *page)
 {
-	int i;
+	unsigned long n;
+	struct list_head *p;
 
 	shm_lockall();
-	for (i = 0; i <= shm_ids.max_id; i++) {
-		struct shmid_kernel *shp = shm_get(i);
-		if(shp==NULL)
-			continue;
-		if (shm_unuse_core(shp, entry, page))
-			goto out;
+	list_for_each (p, &shm_list) {
+		struct shmid_kernel *shp;
+
+		shp = list_entry(p, struct shmid_kernel, list);
+		
+		printk ("shm_unuse scanning %d\n", shp->id);
+		for (n = 0; n < shp->shm_npages; n++) {
+			if (pte_none(SHM_ENTRY(shp,n)))
+				continue;
+			if (pte_present(SHM_ENTRY(shp,n)))
+				continue;
+			if (pte_to_swp_entry(SHM_ENTRY(shp,n)).val == entry.val) {
+				shm_unuse_page(shp, n, entry, page);
+				shm_unlockall();
+				return;
+			}
+		}
+		
 	}
-out:
 	shm_unlockall();
-	zmap_unuse(entry, page);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1710,9 +1707,6 @@
 
 #define VMA_TO_SHP(vma)		((vma)->vm_file->private_data)
 
-static spinlock_t zmap_list_lock = SPIN_LOCK_UNLOCKED;
-static unsigned long zswap_idx; /* next to swap */
-static struct shmid_kernel *zswap_shp = &zshmid_kernel;
 static int zshm_rss;
 
 static struct vm_operations_struct shmzero_vm_ops = {
@@ -1786,9 +1780,6 @@
 	init_MUTEX(&shp->zsem);
 	vma->vm_ops = &shmzero_vm_ops;
 	shmzero_open(vma);
-	spin_lock(&zmap_list_lock);
-	list_add(&shp->zero_list, &zshmid_kernel.zero_list);
-	spin_unlock(&zmap_list_lock);
 	return 0;
 }
 
@@ -1797,9 +1788,9 @@
 	struct shmid_kernel *shp;
 
 	shp = VMA_TO_SHP(shmd);
-	down(&shp->zsem);
+	shm_lock(zero_id);
 	shp->shm_nattch++;
-	up(&shp->zsem);
+	shm_unlock(zero_id);
 }
 
 static void shmzero_close(struct vm_area_struct *shmd)
@@ -1808,19 +1799,12 @@
 	struct shmid_kernel *shp;
 
 	shp = VMA_TO_SHP(shmd);
-	down(&shp->zsem);
+	shm_lock(zero_id);
 	if (--shp->shm_nattch == 0)
 		done = 1;
-	up(&shp->zsem);
-	if (done) {
-		spin_lock(&zmap_list_lock);
-		if (shp == zswap_shp)
-			zswap_shp = list_entry(zswap_shp->zero_list.next, 
-						struct shmid_kernel, zero_list);
-		list_del(&shp->zero_list);
-		spin_unlock(&zmap_list_lock);
+	shm_unlock(zero_id);
+	if (done)
 		seg_free(shp, 0);
-	}
 }
 
 static struct page * shmzero_nopage(struct vm_area_struct * shmd, unsigned long address, int no_share)
@@ -1841,79 +1825,3 @@
 	up(&shp->zsem);
 	return(page);
 }
-
-static void zmap_unuse(swp_entry_t entry, struct page *page)
-{
-	struct shmid_kernel *shp;
-
-	spin_lock(&zmap_list_lock);
-	shm_lock(zero_id);
-	for (shp = list_entry(zshmid_kernel.zero_list.next, struct shmid_kernel, 
-			zero_list); shp != &zshmid_kernel;
-			shp = list_entry(shp->zero_list.next, struct shmid_kernel,
-								zero_list)) {
-		if (shm_unuse_core(shp, entry, page))
-			break;
-	}
-	shm_unlock(zero_id);
-	spin_unlock(&zmap_list_lock);
-}
-
-static void zshm_swap (int prio, int gfp_mask)
-{
-	struct shmid_kernel *shp;
-	swp_entry_t swap_entry;
-	unsigned long idx;
-	int loop = 0;
-	int counter;
-	struct page * page_map;
-
-	counter = zshm_rss >> prio;
-	if (!counter)
-		return;
-next:
-	if (shm_swap_preop(&swap_entry))
-		return;
-
-	spin_lock(&zmap_list_lock);
-	shm_lock(zero_id);
-	if (zshmid_kernel.zero_list.next == 0)
-		goto failed;
-next_id:
-	if (zswap_shp == &zshmid_kernel) {
-		if (loop) {
-failed:
-			shm_unlock(zero_id);
-			spin_unlock(&zmap_list_lock);
-			__swap_free(swap_entry, 2);
-			return;
-		}
-		zswap_shp = list_entry(zshmid_kernel.zero_list.next, 
-					struct shmid_kernel, zero_list);
-		zswap_idx = 0;
-		loop = 1;
-	}
-	shp = zswap_shp;
-
-check_table:
-	idx = zswap_idx++;
-	if (idx >= shp->shm_npages) {
-		zswap_shp = list_entry(zswap_shp->zero_list.next, 
-					struct shmid_kernel, zero_list);
-		zswap_idx = 0;
-		goto next_id;
-	}
-
-	switch (shm_swap_core(shp, idx, swap_entry, &counter, &page_map)) {
-		case RETRY: goto check_table;
-		case FAILED: goto failed;
-	}
-	shm_unlock(zero_id);
-	spin_unlock(&zmap_list_lock);
-
-	shm_swap_postop(page_map);
-	if (counter)
-		goto next;
-	return;
-}
-
diff -uNr 4-11-3/mm/vmscan.c c/mm/vmscan.c
--- 4-11-3/mm/vmscan.c	Mon Nov 13 09:49:43 2000
+++ c/mm/vmscan.c	Tue Nov 14 15:01:59 2000
@@ -725,6 +725,8 @@
 	 * IO.
 	 */
 	if (can_get_io_locks && !launder_loop && free_shortage()) {
+		printk ("page_launder: ");
+		cleaned_pages += shm_swap (free_shortage(), gfp_mask);
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)
@@ -924,13 +926,6 @@
 		 */
 		shrink_dcache_memory(priority, gfp_mask);
 		shrink_icache_memory(priority, gfp_mask);
-
-		/* Try to get rid of some shared memory pages.. */
-		while (shm_swap(priority, gfp_mask)) {
-			made_progress = 1;
-			if (--count <= 0)
-				goto done;
-		}
 
 		/*
 		 * Then, try to page stuff out..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
