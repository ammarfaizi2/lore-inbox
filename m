Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVCCCFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVCCCFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVCCCFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:05:23 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:59089 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261338AbVCCB7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:59:54 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Thu, 3 Mar 2005 12:59:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.28560.325928.858464@berry.gelato.unsw.EDU.AU>
CC: scalability@gelato.org
Subject: [PATCH] Fixing address space lock contention in 2.6.11
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	As part of the Gelato scalability focus group, we've been running
OSDL's Re-AIM7 benchmark with an I/O intensive load with varying
numbers of processors.  The current kernel shows severe contention on
the tree_lock in the address space structure when running on tmpfs or
ext2 on a RAM disk.


Lockstat output for a 12-way:

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        5.5%  0.4us(3177us)   28us(  20ms)(44.2%) 131821954 94.5%  5.5% 0.00%  *TOTAL*

 72.3% 13.1%  0.5us( 9.5us)   29us(  20ms)(42.5%)  50542055 86.9% 13.1%    0%  find_lock_page+0x30
 23.8%    0%  385us(3177us)    0us                    23235  100%    0%    0%  exit_mmap+0x50
 11.5% 0.82%  0.1us( 101us)   17us(5670us)( 1.6%)  50665658 99.2% 0.82%    0%  dnotify_parent+0x70


Replacing the spinlock with a multi-reader lock fixes this problem,
without unduly affecting anything else.

Here are the benchmark results (jobs per minute at a 50-client level,
average of 5 runs, standard deviation in parens) on an HP Olympia with
3 cells, 12 processors, and dnotify turned off (after this spinlock,
the spinlock in dnotify_parent is the worst contended for this workload).

	 tmpfs...............               ext2...............
#CPUs	 spinlock      rwlock               spinlock     rwlock
    1     7556(15)      7588(17)  +0.42%      3744(20)     3791(16) +1.25%
    2	 13743(31)     13791(33)  +0.35%      6405(30)     6413(24) +0.12%
    4	 23334(111)    22881(154) -2%        9648(51)     9595(50)  -0.55%
    8	 33580(240)    36163(190) +7.7%     13183(63)    13070(68)  -0.85%
   12	 28748(170)    44064(238)+53%      12681(49)	 14504(105)+14%  

And on a pentium3 single processsor:
    1    4177(4)        4169(2)  -0.2%        3811(4)     3820(3) +0.23%

I'm not sure what's happening in the 4-processor case.  The important
thing to note is that with a spinlock, the benchmark shows worse
performance for a 12 than for an 8-way box; with the patch, the 12 way
performs better, as expected.  We've done some runs with 16-way as
well; without the patch below, the 16-way performs worse than the
12-way.

Anyway, here's the patch to convert the address space lock to a
rwlock, and allow multiple processes to scan an address-space's radix
tree at once.

===== drivers/mtd/devices/block2mtd.c 1.4 vs edited =====
--- 1.4/drivers/mtd/devices/block2mtd.c	2005-02-02 19:27:37 +11:00
+++ edited/drivers/mtd/devices/block2mtd.c	2005-02-22 14:28:23 +11:00
@@ -59,7 +59,7 @@ void cache_readahead(struct address_spac
 
 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 	for (i = 0; i < PAGE_READAHEAD; i++) {
 		pagei = index + i;
 		if (pagei > end_index) {
@@ -71,16 +71,16 @@ void cache_readahead(struct address_spac
 			break;
 		if (page)
 			continue;
-		spin_unlock_irq(&mapping->tree_lock);
+		read_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
-		spin_lock_irq(&mapping->tree_lock);
+		read_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = pagei;
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 	if (ret)
 		read_cache_pages(mapping, &page_pool, filler, NULL);
 }
===== fs/buffer.c 1.271 vs edited =====
--- 1.271/fs/buffer.c	2005-02-18 20:44:07 +11:00
+++ edited/fs/buffer.c	2005-02-22 14:31:41 +11:00
@@ -875,7 +875,7 @@ int __set_page_dirty_buffers(struct page
 	spin_unlock(&mapping->private_lock);
 
 	if (!TestSetPageDirty(page)) {
-		spin_lock_irq(&mapping->tree_lock);
+		read_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (!mapping->backing_dev_info->memory_backed)
 				inc_page_state(nr_dirty);
@@ -883,7 +883,7 @@ int __set_page_dirty_buffers(struct page
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 		}
-		spin_unlock_irq(&mapping->tree_lock);
+		read_unlock_irq(&mapping->tree_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
===== fs/inode.c 1.143 vs edited =====
--- 1.143/fs/inode.c	2005-01-21 16:02:13 +11:00
+++ edited/fs/inode.c	2005-02-22 14:16:33 +11:00
@@ -196,7 +196,7 @@ void inode_init_once(struct inode *inode
 	sema_init(&inode->i_sem, 1);
 	init_rwsem(&inode->i_alloc_sem);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
-	spin_lock_init(&inode->i_data.tree_lock);
+	rwlock_init(&inode->i_data.tree_lock);
 	spin_lock_init(&inode->i_data.i_mmap_lock);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
 	spin_lock_init(&inode->i_data.private_lock);
===== include/asm-arm/cacheflush.h 1.18 vs edited =====
--- 1.18/include/asm-arm/cacheflush.h	2004-11-05 21:53:14 +11:00
+++ edited/include/asm-arm/cacheflush.h	2005-02-22 14:31:05 +11:00
@@ -312,9 +312,9 @@ flush_cache_page(struct vm_area_struct *
 extern void flush_dcache_page(struct page *);
 
 #define flush_dcache_mmap_lock(mapping) \
-	spin_lock_irq(&(mapping)->tree_lock)
+	write_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \
-	spin_unlock_irq(&(mapping)->tree_lock)
+	write_unlock_irq(&(mapping)->tree_lock)
 
 #define flush_icache_user_range(vma,page,addr,len) \
 	flush_dcache_page(page)
===== include/asm-parisc/cacheflush.h 1.13 vs edited =====
--- 1.13/include/asm-parisc/cacheflush.h	2004-12-25 10:40:22 +11:00
+++ edited/include/asm-parisc/cacheflush.h	2005-02-22 14:31:41 +11:00
@@ -57,9 +57,9 @@ flush_user_icache_range(unsigned long st
 extern void flush_dcache_page(struct page *page);
 
 #define flush_dcache_mmap_lock(mapping) \
-	spin_lock_irq(&(mapping)->tree_lock)
+	write_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \
-	spin_unlock_irq(&(mapping)->tree_lock)
+	write_unlock_irq(&(mapping)->tree_lock)
 
 #define flush_icache_page(vma,page)	do { flush_kernel_dcache_page(page_address(page)); flush_kernel_icache_page(page_address(page)); } while (0)
 
===== include/linux/fs.h 1.376 vs edited =====
--- 1.376/include/linux/fs.h	2005-02-04 01:42:40 +11:00
+++ edited/include/linux/fs.h	2005-02-22 14:31:41 +11:00
@@ -334,7 +334,7 @@ struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
-	spinlock_t		tree_lock;	/* and spinlock protecting it */
+	rwlock_t		tree_lock;	/* and multi-reader lock protecting it */
 	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
 	struct prio_tree_root	i_mmap;		/* tree of private and shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
===== mm/filemap.c 1.292 vs edited =====
--- 1.292/mm/filemap.c	2005-02-15 05:31:41 +11:00
+++ edited/mm/filemap.c	2005-02-22 14:31:41 +11:00
@@ -126,9 +126,9 @@ void remove_from_page_cache(struct page 
 	if (unlikely(!PageLocked(page)))
 		PAGE_BUG(page);
 
-	spin_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 }
 
 static int sync_page(void *word)
@@ -349,7 +349,7 @@ int add_to_page_cache(struct page *page,
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
-		spin_lock_irq(&mapping->tree_lock);
+		write_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			page_cache_get(page);
@@ -359,7 +359,7 @@ int add_to_page_cache(struct page *page,
 			mapping->nrpages++;
 			pagecache_acct(1);
 		}
-		spin_unlock_irq(&mapping->tree_lock);
+		write_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -472,11 +472,11 @@ struct page * find_get_page(struct addre
 {
 	struct page *page;
 
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page)
 		page_cache_get(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -489,11 +489,11 @@ struct page *find_trylock_page(struct ad
 {
 	struct page *page;
 
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page && TestSetPageLocked(page))
 		page = NULL;
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -515,15 +515,15 @@ struct page *find_lock_page(struct addre
 {
 	struct page *page;
 
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
-			spin_unlock_irq(&mapping->tree_lock);
+			read_unlock_irq(&mapping->tree_lock);
 			lock_page(page);
-			spin_lock_irq(&mapping->tree_lock);
+			read_lock_irq(&mapping->tree_lock);
 
 			/* Has the page been truncated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
@@ -533,7 +533,7 @@ repeat:
 			}
 		}
 	}
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 	return page;
 }
 
@@ -607,12 +607,12 @@ unsigned find_get_pages(struct address_s
 	unsigned int i;
 	unsigned int ret;
 
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, start, nr_pages);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 
@@ -626,14 +626,14 @@ unsigned find_get_pages_tag(struct addre
 	unsigned int i;
 	unsigned int ret;
 
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup_tag(&mapping->page_tree,
 				(void **)pages, *index, nr_pages, tag);
 	for (i = 0; i < ret; i++)
 		page_cache_get(pages[i]);
 	if (ret)
 		*index = pages[ret - 1]->index + 1;
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
 
===== mm/page-writeback.c 1.96 vs edited =====
--- 1.96/mm/page-writeback.c	2005-01-26 08:50:13 +11:00
+++ edited/mm/page-writeback.c	2005-02-22 14:31:41 +11:00
@@ -601,7 +601,7 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping2;
 
 		if (mapping) {
-			spin_lock_irq(&mapping->tree_lock);
+			read_lock_irq(&mapping->tree_lock);
 			mapping2 = page_mapping(page);
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
@@ -610,7 +610,7 @@ int __set_page_dirty_nobuffers(struct pa
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
-			spin_unlock_irq(&mapping->tree_lock);
+			read_unlock_irq(&mapping->tree_lock);
 			if (mapping->host) {
 				/* !PageAnon && !swapper_space */
 				__mark_inode_dirty(mapping->host,
@@ -685,17 +685,17 @@ int test_clear_page_dirty(struct page *p
 	unsigned long flags;
 
 	if (mapping) {
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		read_lock_irqsave(&mapping->tree_lock, flags);
 		if (TestClearPageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			spin_unlock_irqrestore(&mapping->tree_lock, flags);
+			read_unlock_irqrestore(&mapping->tree_lock, flags);
 			if (!mapping->backing_dev_info->memory_backed)
 				dec_page_state(nr_dirty);
 			return 1;
 		}
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		read_unlock_irqrestore(&mapping->tree_lock, flags);
 		return 0;
 	}
 	return TestClearPageDirty(page);
@@ -742,15 +742,15 @@ int __clear_page_dirty(struct page *page
 	if (mapping) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		read_lock_irqsave(&mapping->tree_lock, flags);
 		if (TestClearPageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			spin_unlock_irqrestore(&mapping->tree_lock, flags);
+			read_unlock_irqrestore(&mapping->tree_lock, flags);
 			return 1;
 		}
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		read_unlock_irqrestore(&mapping->tree_lock, flags);
 		return 0;
 	}
 	return TestClearPageDirty(page);
@@ -764,13 +764,13 @@ int test_clear_page_writeback(struct pag
 	if (mapping) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		read_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestClearPageWriteback(page);
 		if (ret)
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		read_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
@@ -785,7 +785,7 @@ int test_set_page_writeback(struct page 
 	if (mapping) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		read_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestSetPageWriteback(page);
 		if (!ret)
 			radix_tree_tag_set(&mapping->page_tree,
@@ -795,7 +795,7 @@ int test_set_page_writeback(struct page 
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		read_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestSetPageWriteback(page);
 	}
@@ -813,9 +813,9 @@ int mapping_tagged(struct address_space 
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&mapping->tree_lock, flags);
+	read_lock_irqsave(&mapping->tree_lock, flags);
 	ret = radix_tree_tagged(&mapping->page_tree, tag);
-	spin_unlock_irqrestore(&mapping->tree_lock, flags);
+	read_unlock_irqrestore(&mapping->tree_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(mapping_tagged);
===== mm/readahead.c 1.56 vs edited =====
--- 1.56/mm/readahead.c	2005-01-12 11:42:34 +11:00
+++ edited/mm/readahead.c	2005-02-22 14:31:41 +11:00
@@ -274,7 +274,7 @@ __do_page_cache_readahead(struct address
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	spin_lock_irq(&mapping->tree_lock);
+	read_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
 		
@@ -285,16 +285,16 @@ __do_page_cache_readahead(struct address
 		if (page)
 			continue;
 
-		spin_unlock_irq(&mapping->tree_lock);
+		read_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
-		spin_lock_irq(&mapping->tree_lock);
+		read_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
-	spin_unlock_irq(&mapping->tree_lock);
+	read_unlock_irq(&mapping->tree_lock);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the page is not
===== mm/swap_state.c 1.82 vs edited =====
--- 1.82/mm/swap_state.c	2005-01-31 17:19:53 +11:00
+++ edited/mm/swap_state.c	2005-02-22 14:31:41 +11:00
@@ -35,7 +35,7 @@ static struct backing_dev_info swap_back
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC|__GFP_NOWARN),
-	.tree_lock	= SPIN_LOCK_UNLOCKED,
+	.tree_lock	= RW_LOCK_UNLOCKED,
 	.a_ops		= &swap_aops,
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
@@ -76,7 +76,7 @@ static int __add_to_swap_cache(struct pa
 	BUG_ON(PagePrivate(page));
 	error = radix_tree_preload(gfp_mask);
 	if (!error) {
-		spin_lock_irq(&swapper_space.tree_lock);
+		write_lock_irq(&swapper_space.tree_lock);
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
@@ -87,7 +87,7 @@ static int __add_to_swap_cache(struct pa
 			total_swapcache_pages++;
 			pagecache_acct(1);
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
+		write_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -214,9 +214,9 @@ void delete_from_swap_cache(struct page 
   
 	entry.val = page->private;
 
-	spin_lock_irq(&swapper_space.tree_lock);
+	write_lock_irq(&swapper_space.tree_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock_irq(&swapper_space.tree_lock);
+	write_unlock_irq(&swapper_space.tree_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
@@ -315,13 +315,13 @@ struct page * lookup_swap_cache(swp_entr
 {
 	struct page *page;
 
-	spin_lock_irq(&swapper_space.tree_lock);
+	read_lock_irq(&swapper_space.tree_lock);
 	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
 	if (page) {
 		page_cache_get(page);
 		INC_CACHE_INFO(find_success);
 	}
-	spin_unlock_irq(&swapper_space.tree_lock);
+	read_unlock_irq(&swapper_space.tree_lock);
 	INC_CACHE_INFO(find_total);
 	return page;
 }
@@ -344,12 +344,12 @@ struct page *read_swap_cache_async(swp_e
 		 * called after lookup_swap_cache() failed, re-calling
 		 * that would confuse statistics.
 		 */
-		spin_lock_irq(&swapper_space.tree_lock);
+		read_lock_irq(&swapper_space.tree_lock);
 		found_page = radix_tree_lookup(&swapper_space.page_tree,
 						entry.val);
 		if (found_page)
 			page_cache_get(found_page);
-		spin_unlock_irq(&swapper_space.tree_lock);
+		read_unlock_irq(&swapper_space.tree_lock);
 		if (found_page)
 			break;
 
===== mm/swapfile.c 1.125 vs edited =====
--- 1.125/mm/swapfile.c	2005-01-12 11:42:36 +11:00
+++ edited/mm/swapfile.c	2005-02-22 14:31:41 +11:00
@@ -292,10 +292,10 @@ static int exclusive_swap_page(struct pa
 		/* Is the only swap cache user the cache itself? */
 		if (p->swap_map[swp_offset(entry)] == 1) {
 			/* Recheck the page count with the swapcache lock held.. */
-			spin_lock_irq(&swapper_space.tree_lock);
+			read_lock_irq(&swapper_space.tree_lock);
 			if (page_count(page) == 2)
 				retval = 1;
-			spin_unlock_irq(&swapper_space.tree_lock);
+			read_unlock_irq(&swapper_space.tree_lock);
 		}
 		swap_info_put(p);
 	}
@@ -363,13 +363,13 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the swapcache lock held.. */
-		spin_lock_irq(&swapper_space.tree_lock);
+		write_lock_irq(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
+		write_unlock_irq(&swapper_space.tree_lock);
 	}
 	swap_info_put(p);
 
@@ -393,12 +393,12 @@ void free_swap_and_cache(swp_entry_t ent
 	p = swap_info_get(entry);
 	if (p) {
 		if (swap_entry_free(p, swp_offset(entry)) == 1) {
-			spin_lock_irq(&swapper_space.tree_lock);
+			read_lock_irq(&swapper_space.tree_lock);
 			page = radix_tree_lookup(&swapper_space.page_tree,
 				entry.val);
 			if (page && TestSetPageLocked(page))
 				page = NULL;
-			spin_unlock_irq(&swapper_space.tree_lock);
+			read_unlock_irq(&swapper_space.tree_lock);
 		}
 		swap_info_put(p);
 	}
===== mm/truncate.c 1.20 vs edited =====
--- 1.20/mm/truncate.c	2005-02-06 07:51:43 +11:00
+++ edited/mm/truncate.c	2005-02-22 14:31:41 +11:00
@@ -76,15 +76,15 @@ invalidate_complete_page(struct address_
 	if (PagePrivate(page) && !try_to_release_page(page, 0))
 		return 0;
 
-	spin_lock_irq(&mapping->tree_lock);
+	write_lock_irq(&mapping->tree_lock);
 	if (PageDirty(page)) {
-		spin_unlock_irq(&mapping->tree_lock);
+		write_unlock_irq(&mapping->tree_lock);
 		return 0;
 	}
 
 	BUG_ON(PagePrivate(page));
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
===== mm/vmscan.c 1.240 vs edited =====
--- 1.240/mm/vmscan.c	2005-02-04 11:53:32 +11:00
+++ edited/mm/vmscan.c	2005-02-22 14:31:41 +11:00
@@ -475,7 +475,7 @@ static int shrink_list(struct list_head 
 		if (!mapping)
 			goto keep_locked;	/* truncate got there first */
 
-		spin_lock_irq(&mapping->tree_lock);
+		write_lock_irq(&mapping->tree_lock);
 
 		/*
 		 * The non-racy check for busy page.  It is critical to check
@@ -483,7 +483,7 @@ static int shrink_list(struct list_head 
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
-			spin_unlock_irq(&mapping->tree_lock);
+			write_unlock_irq(&mapping->tree_lock);
 			goto keep_locked;
 		}
 
@@ -491,7 +491,7 @@ static int shrink_list(struct list_head 
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
 			__delete_from_swap_cache(page);
-			spin_unlock_irq(&mapping->tree_lock);
+			write_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
 			__put_page(page);	/* The pagecache ref */
 			goto free_it;
@@ -499,7 +499,7 @@ static int shrink_list(struct list_head 
 #endif /* CONFIG_SWAP */
 
 		__remove_from_page_cache(page);
-		spin_unlock_irq(&mapping->tree_lock);
+		write_unlock_irq(&mapping->tree_lock);
 		__put_page(page);
 
 free_it:
