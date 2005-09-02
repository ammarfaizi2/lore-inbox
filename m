Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbVIBGcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbVIBGcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbVIBGcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:32:14 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:44158 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161006AbVIBGcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:32:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=1zg0cUr0zIyEv57uovhLjkGkU8p+88c8u2M4fiVyLN56njfmrjoW267yNHS4SJcfS04c995EEZKjsDuXtYkcsceMRALTieY3APHnA9gAiH431hc3sbUxwrG565fESZPL/THsZB1PfLeiCzKMFoYkg7aY4HW8hCJp0A9Igpq5jus=  ;
Message-ID: <4317F203.7060109@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:32:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13] lockless pagecache 7/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au> <4317F136.4040601@yahoo.com.au> <4317F17F.5050306@yahoo.com.au> <4317F1A2.8030605@yahoo.com.au> <4317F1BD.8060808@yahoo.com.au> <4317F1E2.7030608@yahoo.com.au>
In-Reply-To: <4317F1E2.7030608@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020705070504090306030804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705070504090306030804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

7/7

-- 
SUSE Labs, Novell Inc.


--------------020705070504090306030804
Content-Type: text/plain;
 name="mm-spinlock-tree_lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-spinlock-tree_lock.patch"

With practially all the read locks gone from mapping->tree_lock,
convert the lock from an rwlock back to a spinlock.

The remaining locks including the read locks mainly deal with IO
submission and not the lookup fastpaths.

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -859,7 +859,7 @@ int __set_page_dirty_buffers(struct page
 	spin_unlock(&mapping->private_lock);
 
 	if (!TestSetPageDirty(page)) {
-		write_lock_irq(&mapping->tree_lock);
+		spin_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
 				inc_page_state(nr_dirty);
@@ -867,7 +867,7 @@ int __set_page_dirty_buffers(struct page
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 		}
-		write_unlock_irq(&mapping->tree_lock);
+		spin_unlock_irq(&mapping->tree_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
Index: linux-2.6/fs/inode.c
===================================================================
--- linux-2.6.orig/fs/inode.c
+++ linux-2.6/fs/inode.c
@@ -195,7 +195,7 @@ void inode_init_once(struct inode *inode
 	sema_init(&inode->i_sem, 1);
 	init_rwsem(&inode->i_alloc_sem);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
-	rwlock_init(&inode->i_data.tree_lock);
+	spin_lock_init(&inode->i_data.tree_lock);
 	spin_lock_init(&inode->i_data.i_mmap_lock);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -339,7 +339,7 @@ struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
-	rwlock_t		tree_lock;	/* and rwlock protecting it */
+	spinlock_t		tree_lock;	/* and lock protecting it */
 	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
 	struct prio_tree_root	i_mmap;		/* tree of private and shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -121,9 +121,9 @@ void remove_from_page_cache(struct page 
 
 	BUG_ON(!PageLocked(page));
 
-	write_lock_irq(&mapping->tree_lock);
+	spin_lock_irq(&mapping->tree_lock);
 	__remove_from_page_cache(page);
-	write_unlock_irq(&mapping->tree_lock);
+	spin_unlock_irq(&mapping->tree_lock);
 }
 
 static int sync_page(void *word)
@@ -384,13 +384,13 @@ int add_to_page_cache(struct page *page,
 		page->mapping = mapping;
 		page->index = offset;
 
-		write_lock_irq(&mapping->tree_lock);
+		spin_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			mapping->nrpages++;
 			pagecache_acct(1);
 		}
-		write_unlock_irq(&mapping->tree_lock);
+		spin_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
 
 		if (error) {
@@ -650,12 +650,12 @@ unsigned find_get_pages(struct address_s
 	unsigned int i;
 	unsigned int ret;
 
-	read_lock_irq(&mapping->tree_lock);
+	spin_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, start, nr_pages);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
-	read_unlock_irq(&mapping->tree_lock);
+	spin_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 
@@ -695,14 +695,14 @@ unsigned find_get_pages_tag(struct addre
 	unsigned int i;
 	unsigned int ret;
 
-	read_lock_irq(&mapping->tree_lock);
+	spin_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup_tag(&mapping->page_tree,
 				(void **)pages, *index, nr_pages, tag);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
 	if (ret)
 		*index = pages[ret - 1]->index + 1;
-	read_unlock_irq(&mapping->tree_lock);
+	spin_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -35,7 +35,7 @@ static struct backing_dev_info swap_back
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC|__GFP_NOWARN),
-	.tree_lock	= RW_LOCK_UNLOCKED,
+	.tree_lock	= SPIN_LOCK_UNLOCKED,
 	.a_ops		= &swap_aops,
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
@@ -81,14 +81,14 @@ static int __add_to_swap_cache(struct pa
 		SetPageSwapCache(page);
 		page->private = entry.val;
 
-		write_lock_irq(&swapper_space.tree_lock);
+		spin_lock_irq(&swapper_space.tree_lock);
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
 			total_swapcache_pages++;
 			pagecache_acct(1);
 		}
-		write_unlock_irq(&swapper_space.tree_lock);
+		spin_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
 
 		if (error) {
@@ -210,9 +210,9 @@ void delete_from_swap_cache(struct page 
   
 	entry.val = page->private;
 
-	write_lock_irq(&swapper_space.tree_lock);
+	spin_lock_irq(&swapper_space.tree_lock);
 	__delete_from_swap_cache(page);
-	write_unlock_irq(&swapper_space.tree_lock);
+	spin_unlock_irq(&swapper_space.tree_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -339,13 +339,13 @@ int remove_exclusive_swap_page(struct pa
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the swapcache lock held.. */
 		SetPageFreeing(page);
-		write_lock_irq(&swapper_space.tree_lock);
+		spin_lock_irq(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		write_unlock_irq(&swapper_space.tree_lock);
+		spin_unlock_irq(&swapper_space.tree_lock);
 		ClearPageFreeing(page);
 	}
 	swap_info_put(p);
Index: linux-2.6/mm/truncate.c
===================================================================
--- linux-2.6.orig/mm/truncate.c
+++ linux-2.6/mm/truncate.c
@@ -76,15 +76,15 @@ invalidate_complete_page(struct address_
 	if (PagePrivate(page) && !try_to_release_page(page, 0))
 		return 0;
 
-	write_lock_irq(&mapping->tree_lock);
+	spin_lock_irq(&mapping->tree_lock);
 	if (PageDirty(page)) {
-		write_unlock_irq(&mapping->tree_lock);
+		spin_unlock_irq(&mapping->tree_lock);
 		return 0;
 	}
 
 	BUG_ON(PagePrivate(page));
 	__remove_from_page_cache(page);
-	write_unlock_irq(&mapping->tree_lock);
+	spin_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -505,7 +505,7 @@ static int shrink_list(struct list_head 
 			goto keep_locked;	/* truncate got there first */
 
 		SetPageFreeing(page);
-		write_lock_irq(&mapping->tree_lock);
+		spin_lock_irq(&mapping->tree_lock);
 
 		/*
 		 * The non-racy check for busy page.  It is critical to check
@@ -513,7 +513,7 @@ static int shrink_list(struct list_head 
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
-			write_unlock_irq(&mapping->tree_lock);
+			spin_unlock_irq(&mapping->tree_lock);
 			ClearPageFreeing(page);
 			goto keep_locked;
 		}
@@ -522,7 +522,7 @@ static int shrink_list(struct list_head 
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
 			__delete_from_swap_cache(page);
-			write_unlock_irq(&mapping->tree_lock);
+			spin_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
 			__put_page(page);	/* The pagecache ref */
 			goto free_it;
@@ -530,7 +530,7 @@ static int shrink_list(struct list_head 
 #endif /* CONFIG_SWAP */
 
 		__remove_from_page_cache(page);
-		write_unlock_irq(&mapping->tree_lock);
+		spin_unlock_irq(&mapping->tree_lock);
 		__put_page(page);
 
 free_it:
Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c
+++ linux-2.6/mm/page-writeback.c
@@ -623,7 +623,7 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping2;
 
 		if (mapping) {
-			write_lock_irq(&mapping->tree_lock);
+			spin_lock_irq(&mapping->tree_lock);
 			mapping2 = page_mapping(page);
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
@@ -632,7 +632,7 @@ int __set_page_dirty_nobuffers(struct pa
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
-			write_unlock_irq(&mapping->tree_lock);
+			spin_unlock_irq(&mapping->tree_lock);
 			if (mapping->host) {
 				/* !PageAnon && !swapper_space */
 				__mark_inode_dirty(mapping->host,
@@ -707,17 +707,17 @@ int test_clear_page_dirty(struct page *p
 	unsigned long flags;
 
 	if (mapping) {
-		write_lock_irqsave(&mapping->tree_lock, flags);
+		spin_lock_irqsave(&mapping->tree_lock, flags);
 		if (TestClearPageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			write_unlock_irqrestore(&mapping->tree_lock, flags);
+			spin_unlock_irqrestore(&mapping->tree_lock, flags);
 			if (mapping_cap_account_dirty(mapping))
 				dec_page_state(nr_dirty);
 			return 1;
 		}
-		write_unlock_irqrestore(&mapping->tree_lock, flags);
+		spin_unlock_irqrestore(&mapping->tree_lock, flags);
 		return 0;
 	}
 	return TestClearPageDirty(page);
@@ -762,13 +762,13 @@ int test_clear_page_writeback(struct pag
 	if (mapping) {
 		unsigned long flags;
 
-		write_lock_irqsave(&mapping->tree_lock, flags);
+		spin_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestClearPageWriteback(page);
 		if (ret)
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-		write_unlock_irqrestore(&mapping->tree_lock, flags);
+		spin_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
@@ -783,7 +783,7 @@ int test_set_page_writeback(struct page 
 	if (mapping) {
 		unsigned long flags;
 
-		write_lock_irqsave(&mapping->tree_lock, flags);
+		spin_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestSetPageWriteback(page);
 		if (!ret)
 			radix_tree_tag_set(&mapping->page_tree,
@@ -793,7 +793,7 @@ int test_set_page_writeback(struct page 
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-		write_unlock_irqrestore(&mapping->tree_lock, flags);
+		spin_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestSetPageWriteback(page);
 	}
@@ -811,10 +811,10 @@ int mapping_tagged(struct address_space 
 	unsigned long flags;
 	int ret;
 
-	/* XXX: radix_tree_tagged is safe to run without the lock? */
-	read_lock_irqsave(&mapping->tree_lock, flags);
+	/* XXX: radix_tree_tagged is safe to run without the lock */
+	spin_lock_irqsave(&mapping->tree_lock, flags);
 	ret = radix_tree_tagged(&mapping->page_tree, tag);
-	read_unlock_irqrestore(&mapping->tree_lock, flags);
+	spin_unlock_irqrestore(&mapping->tree_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(mapping_tagged);
Index: linux-2.6/drivers/mtd/devices/block2mtd.c
===================================================================
--- linux-2.6.orig/drivers/mtd/devices/block2mtd.c
+++ linux-2.6/drivers/mtd/devices/block2mtd.c
@@ -58,7 +58,7 @@ void cache_readahead(struct address_spac
 
 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
-	read_lock_irq(&mapping->tree_lock);
+	spin_lock_irq(&mapping->tree_lock);
 	for (i = 0; i < PAGE_READAHEAD; i++) {
 		pagei = index + i;
 		if (pagei > end_index) {
@@ -70,16 +70,16 @@ void cache_readahead(struct address_spac
 			break;
 		if (page)
 			continue;
-		read_unlock_irq(&mapping->tree_lock);
+		spin_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
-		read_lock_irq(&mapping->tree_lock);
+		spin_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = pagei;
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
-	read_unlock_irq(&mapping->tree_lock);
+	spin_unlock_irq(&mapping->tree_lock);
 	if (ret)
 		read_cache_pages(mapping, &page_pool, filler, NULL);
 }
Index: linux-2.6/include/asm-arm/cacheflush.h
===================================================================
--- linux-2.6.orig/include/asm-arm/cacheflush.h
+++ linux-2.6/include/asm-arm/cacheflush.h
@@ -315,9 +315,9 @@ flush_cache_page(struct vm_area_struct *
 extern void flush_dcache_page(struct page *);
 
 #define flush_dcache_mmap_lock(mapping) \
-	write_lock_irq(&(mapping)->tree_lock)
+	spin_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \
-	write_unlock_irq(&(mapping)->tree_lock)
+	spin_unlock_irq(&(mapping)->tree_lock)
 
 #define flush_icache_user_range(vma,page,addr,len) \
 	flush_dcache_page(page)
Index: linux-2.6/include/asm-parisc/cacheflush.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/cacheflush.h
+++ linux-2.6/include/asm-parisc/cacheflush.h
@@ -57,9 +57,9 @@ flush_user_icache_range(unsigned long st
 extern void flush_dcache_page(struct page *page);
 
 #define flush_dcache_mmap_lock(mapping) \
-	write_lock_irq(&(mapping)->tree_lock)
+	spin_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \
-	write_unlock_irq(&(mapping)->tree_lock)
+	spin_unlock_irq(&(mapping)->tree_lock)
 
 #define flush_icache_page(vma,page)	do { flush_kernel_dcache_page(page_address(page)); flush_kernel_icache_page(page_address(page)); } while (0)
 

--------------020705070504090306030804--
Send instant messages to your online friends http://au.messenger.yahoo.com 
