Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132286AbRCWBQT>; Thu, 22 Mar 2001 20:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbRCWBQB>; Thu, 22 Mar 2001 20:16:01 -0500
Received: from zeus.kernel.org ([209.10.41.242]:56038 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132286AbRCWBPt>;
	Thu, 22 Mar 2001 20:15:49 -0500
Date: Fri, 23 Mar 2001 01:13:31 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben LaHaise <bcrl@redhat.com>,
        Christoph Rohland <cr@sap.com>, Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
Message-ID: <20010323011331.J7756@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The patch below is for two races in sysV shared memory.

The first (minor) one is in shmem_free_swp:

		swap_free (entry);
		*ptr = (swp_entry_t){0};
		freed++;
		if (!(page = lookup_swap_cache(entry)))
			continue;
		delete_from_swap_cache(page);
		page_cache_release(page);

has a window between the first swap_free() and the
lookup_swap_cache().  If the swap_free() frees the last ref to the
swap entry and another cpu allocates and caches the same entry before
the lookup, we'll end up destroying another task's swap cache.

The second is nastier.  shmem_nopage() uses the inode semaphore to
serialise access to shmem_getpage_locked() for paging in shared memory
segments.  Lookups in the page cache and in the shmem swap vector are
done to locate the entry.  _getpage_ can move entries from swap to
page cache under protection of the shmem's info->lock spinlock.

shmem_writepage() is locked via the page lock, and moves shmem pages
from the page cache to the swap cache under protection of the same
info->lock spinlock.

However, shmem_nopage() does not hold this spinlock while doing its
lookups in the page cache and swap vectors, so it can race with
writepage, with once cpu in the middle of moving the page out of the
page cache in writepage and the other cpu then failing to find the
entry either in the page cache or in the shm swap entry vector.

Feedback welcome.

Cheers, 
 Stephen

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.2-ac22.shmlock.diff"

--- mm/shmem.c.~1~	Fri Mar 23 00:26:49 2001
+++ mm/shmem.c	Fri Mar 23 00:42:21 2001
@@ -121,13 +121,13 @@
 		if (!ptr->val)
 			continue;
 		entry = *ptr;
-		swap_free (entry);
 		*ptr = (swp_entry_t){0};
 		freed++;
-		if (!(page = lookup_swap_cache(entry)))
-			continue;
-		delete_from_swap_cache(page);
-		page_cache_release(page);
+		if ((page = lookup_swap_cache(entry)) != NULL) {
+			delete_from_swap_cache(page);
+			page_cache_release(page);	
+		}
+		swap_free (entry);
 	}
 	return freed;
 }
@@ -218,15 +218,24 @@
 }
 
 /*
- * Move the page from the page cache to the swap cache
+ * Move the page from the page cache to the swap cache.
+ *
+ * The page lock prevents multiple occurences of shmem_writepage at
+ * once.  We still need to guard against racing with
+ * shmem_getpage_locked().  
  */
 static int shmem_writepage(struct page * page)
 {
 	int error;
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
+	struct inode *inode;
 
-	info = &page->mapping->host->u.shmem_i;
+	if (!PageLocked(page))
+		BUG();
+	
+	inode = page->mapping->host;
+	info = &inode->u.shmem_i;
 	swap = __get_swap_page(2);
 	if (!swap.val) {
 		set_page_dirty(page);
@@ -234,11 +243,11 @@
 		return -ENOMEM;
 	}
 
-	spin_lock(&info->lock);
-	shmem_recalc_inode(page->mapping->host);
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
+	spin_lock(&info->lock);
+	shmem_recalc_inode(page->mapping->host);
 	error = -EAGAIN;
 	if (entry->val) {
 		__swap_free(swap, 2);
@@ -268,6 +277,10 @@
  * If we allocate a new one we do not mark it dirty. That's up to the
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
+ *
+ * Called with the inode locked, so it cannot race with itself, but we
+ * still need to guard against racing with shm_writepage(), which might
+ * be trying to move the page to the swap cache as we run.
  */
 static struct page * shmem_getpage_locked(struct inode * inode, unsigned long idx)
 {
@@ -276,31 +289,57 @@
 	struct page * page;
 	swp_entry_t *entry;
 
-	page = find_lock_page(mapping, idx);;
+	info = &inode->u.shmem_i;
+
+repeat:
+	page = find_lock_page(mapping, idx);
 	if (page)
 		return page;
 
-	info = &inode->u.shmem_i;
 	entry = shmem_swp_entry (info, idx);
 	if (IS_ERR(entry))
 		return (void *)entry;
+
+	spin_lock (&info->lock);
+	
+	/* The shmem_swp_entry() call may have blocked, and
+	 * shmem_writepage may have been moving a page between the page
+	 * cache and swap cache.  We need to recheck the page cache
+	 * under the protection of the info->lock spinlock. */
+
+	page = find_lock_page(mapping, idx);
+	if (page) {
+		spin_unlock (&info->lock);
+		return page;
+	}
+	
 	if (entry->val) {
 		unsigned long flags;
 
 		/* Look it up and read it in.. */
 		page = lookup_swap_cache(*entry);
 		if (!page) {
+			spin_unlock (&info->lock);
 			lock_kernel();
 			swapin_readahead(*entry);
 			page = read_swap_cache(*entry);
 			unlock_kernel();
 			if (!page) 
 				return ERR_PTR(-ENOMEM);
+			/* Too bad we can't trust this page, because we
+			 * dropped the info->lock spinlock */
+			page_cache_release(page);
+			goto repeat;
 		}
 
 		/* We have to this with page locked to prevent races */
-		lock_page(page);
-		spin_lock (&info->lock);
+		if (TryLockPage(page)) {
+			spin_unlock(&info->lock);
+ 			wait_on_page(page);
+			page_cache_release(page);
+			goto repeat;
+		}
+			
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
 		delete_from_swap_cache_nolock(page);
@@ -310,12 +349,20 @@
 		info->swapped--;
 		spin_unlock (&info->lock);
 	} else {
+		spin_unlock (&info->lock);
 		spin_lock (&inode->i_sb->u.shmem_sb.stat_lock);
 		if (inode->i_sb->u.shmem_sb.free_blocks == 0)
 			goto no_space;
 		inode->i_sb->u.shmem_sb.free_blocks--;
 		spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
-		/* Ok, get a new page */
+
+		/* Ok, get a new page.  We don't have to worry about the
+		 * info->lock spinlock here: we cannot race against
+		 * shm_writepage because we have already verified that
+		 * there is no page present either in memory or in the
+		 * swap cache, so we are guaranteed to be populating a
+		 * new shm entry.  The inode semaphore we already hold
+		 * is enough to make this atomic. */
 		page = page_cache_alloc(mapping);
 		if (!page)
 			return ERR_PTR(-ENOMEM);
@@ -323,6 +370,8 @@
 		inode->i_blocks += BLOCKS_PER_PAGE;
 		add_to_page_cache (page, mapping, idx);
 	}
+
+	
 	/* We have the page */
 	SetPageUptodate(page);
 	if (info->locked)

--LyciRD1jyfeSSjG0--
