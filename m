Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUAIUtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbUAIUtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:49:51 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:22706 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264132AbUAIUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:49:43 -0500
Date: Fri, 9 Jan 2004 15:49:34 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Mike Fedyk <mfedyk@matchmail.com>, Alex Buell <alex.buell@munted.org.uk>,
       <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
In-Reply-To: <Pine.LNX.4.58L.0401051531040.5618@logos.cnet>
Message-ID: <Pine.LNX.4.44.0401051245350.10419-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Marcelo Tosatti wrote:

> The fix in -aa seems to reclaim inodes very aggressively. The 2.4 RH tree
> seems to contain a better version. Need to look into that.

Here it is, against yesterday's 2.4 bitkeeper tree.
Some comments:
- prune_icache() can be called with a priority of zero, so we
  should check for <= 0
- the main reason we don't strip the page cache from inodes
  with lots of cache in memory are inefficiencies observed
  in invalidate_inode_pages()

I have tested this code with a trivial shell script that
touches a zillion and a half really small files over and
over again, more than the system can cache.  Once the
inodes and dentries fill up more than about 800MB of low
memory the system gets very uncomfortable without the
patch.  With the patch it simply frees a whole bunch of
inodes and things run fine.


===== fs/inode.c 1.46 vs edited =====
--- 1.46/fs/inode.c	Wed Dec 31 07:31:15 2003
+++ edited/fs/inode.c	Thu Jan  8 12:23:51 2004
@@ -49,7 +49,8 @@
  * other linked list is the "type" list:
  *  "in_use" - valid inode, i_count > 0, i_nlink > 0
  *  "dirty"  - as "in_use" but also dirty
- *  "unused" - valid inode, i_count = 0
+ *  "unused" - valid inode, i_count = 0, no pages in the pagecache
+ *  "unused_pagecache" - valid inode, i_count = 0, data in the pagecache
  *
  * A "dirty" list is maintained for each super block,
  * allowing for low-overhead inode sync() operations.
@@ -57,6 +58,7 @@
 
 static LIST_HEAD(inode_in_use);
 static LIST_HEAD(inode_unused);
+static LIST_HEAD(inode_unused_pagecache);
 static struct list_head *inode_hashtable;
 static LIST_HEAD(anon_hash_chain); /* for inodes with NULL i_sb */
 
@@ -286,6 +288,36 @@
 	inodes_stat.nr_unused--;
 }
 
+static inline void __refile_inode(struct inode *inode)
+{
+	struct list_head *to;
+
+	if (inode->i_state & I_FREEING)
+		return;
+	if (list_empty(&inode->i_hash))
+		return;
+
+	if (inode->i_state & I_DIRTY)
+		to = &inode->i_sb->s_dirty;
+	else if (atomic_read(&inode->i_count))
+		to = &inode_in_use;
+	else if (inode->i_data.nrpages)
+		to = &inode_unused_pagecache;
+	else
+		to = &inode_unused;
+	list_del(&inode->i_list);
+	list_add(&inode->i_list, to);
+}
+
+void refile_inode(struct inode *inode)
+{
+	if (!inode)
+		return;
+	spin_lock(&inode_lock);
+	__refile_inode(inode);
+	spin_unlock(&inode_lock);
+}
+
 static inline void __sync_one(struct inode *inode, int sync)
 {
 	unsigned dirty;
@@ -312,17 +344,8 @@
 
 	spin_lock(&inode_lock);
 	inode->i_state &= ~I_LOCK;
-	if (!(inode->i_state & I_FREEING)) {
-		struct list_head *to;
-		if (inode->i_state & I_DIRTY)
-			to = &inode->i_sb->s_dirty;
-		else if (atomic_read(&inode->i_count))
-			to = &inode_in_use;
-		else
-			to = &inode_unused;
-		list_del(&inode->i_list);
-		list_add(&inode->i_list, to);
-	}
+	if (!(inode->i_state & I_FREEING))
+		__refile_inode(inode);
 	wake_up(&inode->i_wait);
 }
 
@@ -699,6 +722,7 @@
 	spin_lock(&inode_lock);
 	busy = invalidate_list(&inode_in_use, sb, &throw_away);
 	busy |= invalidate_list(&inode_unused, sb, &throw_away);
+	busy |= invalidate_list(&inode_unused_pagecache, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_locked_inodes, sb, &throw_away);
 	spin_unlock(&inode_lock);
@@ -762,7 +786,7 @@
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
-	int count;
+	int count, avg_pages;
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
@@ -785,7 +809,7 @@
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
-		if (!--goal)
+		if (--goal <= 0)
 			break;
 	}
 	inodes_stat.nr_unused -= count;
@@ -799,8 +823,70 @@
 	 * from here or we're either synchronously dogslow
 	 * or we deadlock with oom.
 	 */
-	if (goal)
+	if (goal > 0)
 		schedule_task(&unused_inodes_flush_task);
+
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * On highmem machines it is possible to have low memory
+	 * filled with inodes that cannot be reclaimed because they
+	 * have page cache pages in highmem attached to them.
+	 * This could deadlock the system if the memory used by
+	 * inodes is significant compared to the amount of freeable
+	 * low memory.  In that case we forcefully remove the page
+	 * cache pages from the inodes we want to reclaim.
+	 *
+	 * Note that this loop doesn't actually reclaim the inodes;
+	 * once the last pagecache pages belonging to the inode is
+	 * gone it will be placed on the inode_unused list and the
+	 * loop above will prune it the next time prune_icache() is
+	 * called.
+	 */
+	if (goal <= 0)
+		return;
+	if (inodes_stat.nr_unused * sizeof(struct inode) * 10 <
+				freeable_lowmem() * PAGE_SIZE)
+		return;
+
+	wakeup_bdflush();
+
+	avg_pages = page_cache_size;
+	avg_pages -= atomic_read(&buffermem_pages) + swapper_space.nrpages;
+	avg_pages = avg_pages / (inodes_stat.nr_inodes + 1);
+	spin_lock(&inode_lock);
+	while (goal-- > 0) {
+		if (list_empty(&inode_unused_pagecache))
+			break;
+		entry = inode_unused_pagecache.prev;
+		list_del(entry);
+		list_add(entry, &inode_unused_pagecache);
+
+		inode = INODE(entry);
+		/* Don't nuke inodes with lots of page cache attached. */
+		if (inode->i_mapping->nrpages > 5 * avg_pages)
+			continue;
+		/* Because of locking we grab the inode and unlock the list .*/
+		if (inode->i_state & I_LOCK)
+			continue;
+		inode->i_state |= I_LOCK;
+		spin_unlock(&inode_lock);
+
+		/*
+		 * If the inode has clean pages only, we can free all its
+		 * pagecache memory; the inode will automagically be refiled
+		 * onto the unused_list.  The wakeup_bdflush above makes
+		 * sure that all inodes become clean eventually.
+		 */
+		if (list_empty(&inode->i_mapping->dirty_pages) &&
+				!inode_has_buffers(inode))
+			invalidate_inode_pages(inode);
+
+		/* Release the inode again. */
+		spin_lock(&inode_lock);
+		inode->i_state &= ~I_LOCK;
+	}
+	spin_unlock(&inode_lock);
+#endif /* CONFIG_HIGHMEM */
 }
 
 int shrink_icache_memory(int priority, int gfp_mask)
===== include/linux/fs.h 1.95 vs edited =====
--- 1.95/include/linux/fs.h	Fri Dec  5 22:25:43 2003
+++ edited/include/linux/fs.h	Thu Jan  8 15:03:26 2004
@@ -1399,6 +1399,7 @@
 extern void inode_init_once(struct inode *);
 extern void __inode_init_once(struct inode *);
 extern void iput(struct inode *);
+extern void refile_inode(struct inode *inode);
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern struct inode * ilookup(struct super_block *, unsigned long);
===== include/linux/swap.h 1.39 vs edited =====
--- 1.39/include/linux/swap.h	Fri Sep 12 10:25:22 2003
+++ edited/include/linux/swap.h	Thu Jan  8 15:03:26 2004
@@ -85,6 +85,7 @@
 
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
+extern unsigned int freeable_lowmem(void);
 extern int nr_active_pages;
 extern int nr_inactive_pages;
 extern unsigned long page_cache_size;
===== mm/filemap.c 1.96 vs edited =====
--- 1.96/mm/filemap.c	Wed Dec 31 07:31:15 2003
+++ edited/mm/filemap.c	Tue Jan  6 16:04:15 2004
@@ -102,6 +102,8 @@
 	page->mapping = NULL;
 	wmb();
 	mapping->nrpages--;
+	if (!mapping->nrpages)
+		refile_inode(mapping->host);
 }
 
 static inline void remove_page_from_hash_queue(struct page * page)
===== mm/page_alloc.c 1.67 vs edited =====
--- 1.67/mm/page_alloc.c	Thu Dec 18 12:47:08 2003
+++ edited/mm/page_alloc.c	Thu Jan  8 14:53:31 2004
@@ -534,6 +534,23 @@
 
 	return pages;
 }
+
+unsigned int freeable_lowmem(void)
+{
+	unsigned int pages = 0;
+	pg_data_t *pgdat;
+
+	for_each_pgdat(pgdat) {
+		pages += pgdat->node_zones[ZONE_DMA].free_pages;
+		pages += pgdat->node_zones[ZONE_DMA].nr_active_pages;
+		pages += pgdat->node_zones[ZONE_DMA].nr_inactive_pages;
+		pages += pgdat->node_zones[ZONE_NORMAL].free_pages;
+		pages += pgdat->node_zones[ZONE_NORMAL].nr_active_pages;
+		pages += pgdat->node_zones[ZONE_NORMAL].nr_inactive_pages;
+	}
+
+	return pages;
+}
 #endif
 
 #define K(x) ((x) << (PAGE_SHIFT-10))

