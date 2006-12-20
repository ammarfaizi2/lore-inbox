Return-Path: <linux-kernel-owner+w=401wt.eu-S1030307AbWLTTvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWLTTvw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWLTTvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:51:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60712 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030314AbWLTTvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:51:51 -0500
Date: Wed, 20 Dec 2006 11:50:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Michlmayr <tbm@cyrius.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Linus Torvalds wrote:
> 
> So that's why I've been harping on the fact that I think we simply do 
> really wrong things with PG_dirty at times [ ... ]

Ok, I'll just put my money where my mouth is, and suggest a patch like 
THIS instead.

This one clears up all the issues I find irritating:

 - "test_clear_page_dirty()" is insane, both conceptually and as an 
   implementation. "Give me a 'C', give me an 'R', give me an 'A', give me 
   a 'P'".

   So rip out that mindfart entirely.

 - "clear_page_dirty()" is badly named, and should be about CANCELLING the 
   dirty bit, and must never be called with pages mapped anyway. So throw 
   that out too, and replace it with a new function:

	void cancel_dirty_page(struct page *page, unsigned int accounting_size);

 - "clear_page_dirty_for_io()" is fine.

And with that, I then either rip out any old users of 
"test_clear_page_dirty()" or "clear_page_dirty()", and if appropriate (and 
it's realy lonly appropriate for "truncate()", I replace them with the new 
"cancel_dirty_page()". Most of the time, they should just be deleted 
entirely.

NOTE NOTE NOTE! I _only_ did enough to make things compile for my 
particular configuration. That means that right now the following 
filesystems are broken with this patch (because they use the totally 
broken old crap):

	CIFS, FUSE, JFS, ReiserFS, XFS

and I don't know exactly what they need to be fixed. But most likely their 
usage was insane and pointless anyway (looking at the ReiserFS case, for 
example, that was DEFINITELY the case. I can't even imagine what the heck 
it thinks it is doing).

Anyway, I'm not at all guaranteeing that this solves anything at all. I 
_do_ guarantee that this is a h*ll of a lot saner than what we had before.

[ This also includes a few of my older patches, I didn't bother to sort 
  them out, and the fs/buffer.c patch is required because it got rid of 
  one of the insane uses of test_clear_page_dirty().

  So this goes directly on top of current -git, with no other changes in 
  the tree. ]

Nick, Hugh, Peter, Andrew? Comments? 

Martin, Andrei, does this make any difference for your corruption cases?

		Linus

---
diff --git a/fs/buffer.c b/fs/buffer.c
index d1f1b54..263f88e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *page)
 	int ret = 0;
 
 	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
+	if (PageDirty(page) || PageWriteback(page))
 		return 0;
 
 	if (mapping == NULL) {		/* can this still happen? */
@@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *page)
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
 	spin_unlock(&mapping->private_lock);
-	if (ret) {
-		/*
-		 * If the filesystem writes its buffers by hand (eg ext3)
-		 * then we can have clean buffers against a dirty page.  We
-		 * clean the page here; otherwise later reattachment of buffers
-		 * could encounter a non-uptodate page, which is unresolvable.
-		 * This only applies in the rare case where try_to_free_buffers
-		 * succeeds but the page is not freed.
-		 *
-		 * Also, during truncate, discard_buffer will have marked all
-		 * the page's buffers clean.  We discover that here and clean
-		 * the page also.
-		 */
-		if (test_clear_page_dirty(page))
-			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
-	}
 out:
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ed2c223..4f4cd13 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct file *file,
 
 static void truncate_huge_page(struct page *page)
 {
-	clear_page_dirty(page);
+	cancel_dirty_page(page, /* No IO accounting for huge pages? */0);
 	ClearPageUptodate(page);
 	remove_from_page_cache(page);
 	put_page(page);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4830a3b..350878a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -253,15 +253,11 @@ static inline void SetPageUptodate(struct page *page)
 
 struct page;	/* forward declaration */
 
-int test_clear_page_dirty(struct page *page);
+extern void cancel_dirty_page(struct page *page, unsigned int account_size);
+
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
 
-static inline void clear_page_dirty(struct page *page)
-{
-	test_clear_page_dirty(page);
-}
-
 static inline void set_page_writeback(struct page *page)
 {
 	test_set_page_writeback(page);
diff --git a/mm/memory.c b/mm/memory.c
index c00bac6..79cecab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1842,6 +1842,33 @@ void unmap_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
+static void check_last_page(struct address_space *mapping, loff_t size)
+{
+	pgoff_t index;
+	unsigned int offset;
+	struct page *page;
+
+	if (!mapping)
+		return;
+	offset = size & ~PAGE_MASK;
+	if (!offset)
+		return;
+	index = size >> PAGE_SHIFT;
+	page = find_lock_page(mapping, index);
+	if (page) {
+		unsigned int check = 0;
+		unsigned char *kaddr = kmap_atomic(page, KM_USER0);
+		do {
+			check += kaddr[offset++];
+		} while (offset < PAGE_SIZE);
+		kunmap_atomic(kaddr,KM_USER0);
+		unlock_page(page);
+		page_cache_release(page);
+		if (check)
+			printk("%s: BADNESS: truncate check %u\n", current->comm, check);
+	}
+}
+
 /**
  * vmtruncate - unmap mappings "freed" by truncate() syscall
  * @inode: inode of the file used
@@ -1875,6 +1902,7 @@ do_expand:
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
 		goto out_big;
+	check_last_page(mapping, inode->i_size);
 	i_size_write(inode, offset);
 
 out_truncate:
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 237107c..b3a198c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -845,38 +845,6 @@ int set_page_dirty_lock(struct page *page)
 EXPORT_SYMBOL(set_page_dirty_lock);
 
 /*
- * Clear a page's dirty flag, while caring for dirty memory accounting. 
- * Returns true if the page was previously dirty.
- */
-int test_clear_page_dirty(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
-
-	if (!mapping)
-		return TestClearPageDirty(page);
-
-	write_lock_irqsave(&mapping->tree_lock, flags);
-	if (TestClearPageDirty(page)) {
-		radix_tree_tag_clear(&mapping->page_tree,
-				page_index(page), PAGECACHE_TAG_DIRTY);
-		write_unlock_irqrestore(&mapping->tree_lock, flags);
-		/*
-		 * We can continue to use `mapping' here because the
-		 * page is locked, which pins the address_space
-		 */
-		if (mapping_cap_account_dirty(mapping)) {
-			page_mkclean(page);
-			dec_zone_page_state(page, NR_FILE_DIRTY);
-		}
-		return 1;
-	}
-	write_unlock_irqrestore(&mapping->tree_lock, flags);
-	return 0;
-}
-EXPORT_SYMBOL(test_clear_page_dirty);
-
-/*
  * Clear a page's dirty flag, while caring for dirty memory accounting.
  * Returns true if the page was previously dirty.
  *
diff --git a/mm/truncate.c b/mm/truncate.c
index 9bfb8e8..bf9e296 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -51,6 +51,20 @@ static inline void truncate_partial_page(struct page *page, unsigned partial)
 		do_invalidatepage(page, partial);
 }
 
+void cancel_dirty_page(struct page *page, unsigned int account_size)
+{
+	/* If we're cancelling the page, it had better not be mapped any more */
+	if (page_mapped(page)) {
+		static unsigned int warncount;
+
+		WARN_ON(++warncount < 5);
+	}
+		
+	if (TestClearPageDirty(page) && account_size)
+		task_io_account_cancelled_write(account_size);
+}
+
+
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
  * becomes anonymous.  It will be left on the LRU and may even be mapped into
@@ -70,8 +84,8 @@ truncate_complete_page(struct address_space *mapping, struct page *page)
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	if (test_clear_page_dirty(page))
-		task_io_account_cancelled_write(PAGE_CACHE_SIZE);
+	cancel_dirty_page(page, PAGE_CACHE_SIZE);
+
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
 	remove_from_page_cache(page);
@@ -350,7 +364,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index;
-			int was_dirty;
 
 			lock_page(page);
 			if (page->mapping != mapping) {
@@ -386,12 +399,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
-			if (!invalidate_complete_page2(mapping, page)) {
-				if (was_dirty)
-					set_page_dirty(page);
+			if (!invalidate_complete_page2(mapping, page))
 				ret = -EIO;
-			}
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
