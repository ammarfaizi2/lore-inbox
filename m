Return-Path: <linux-kernel-owner+w=401wt.eu-S1752100AbWLVTVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWLVTVA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWLVTVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:21:00 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:54841 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbWLVTU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:20:59 -0500
Date: Fri, 22 Dec 2006 20:20:27 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222192027.GJ4229@deprecation.cyrius.com>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost> <20061222123249.GG13727@deprecation.cyrius.com> <20061222125920.GA16763@deprecation.cyrius.com> <1166793952.32117.29.camel@twins>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <1166793952.32117.29.camel@twins>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2006-12-22 14:25]:
> > .... and it failed.
> Since you are on ARM you might want to try with the page_mkclean_one
> cleanup patch too.

I've already tried it and it didn't work.  I just tried it again
together with Linus' patch and the two from Andrew and it still fails.
(For reference, the patch is attached.)
-- 
Martin Michlmayr
http://www.cyrius.com/

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *pag
 	int ret = 0;
 
 	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
+	if (PageDirty(page) || PageWriteback(page))
 		return 0;
 
 	if (mapping == NULL) {		/* can this still happen? */
@@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *pag
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
@@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct
 
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
@@ -253,15 +253,11 @@ #define ClearPageUncached(page)	clear_bi
 
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
@@ -1842,6 +1842,33 @@ void unmap_mapping_range(struct address_
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
@@ -845,38 +845,6 @@ int set_page_dirty_lock(struct page *pag
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
diff --git a/mm/rmap.c b/mm/rmap.c
index d8a842a..3278b2a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -432,7 +432,7 @@ static int page_mkclean_one(struct page
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *pte, entry;
+	pte_t *pte;
 	spinlock_t *ptl;
 	int ret = 0;
 
@@ -444,17 +444,18 @@ static int page_mkclean_one(struct page
 	if (!pte)
 		goto out;
 
-	if (!pte_dirty(*pte) && !pte_write(*pte))
-		goto unlock;
+	if (pte_dirty(*pte) || pte_write(*pte)) {
+		pte_t entry;
 
-	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
-	entry = pte_wrprotect(entry);
-	ptep_establish(vma, address, pte, entry);
-	lazy_mmu_prot_update(entry);
-	ret = 1;
+		flush_cache_page(vma, address, pte_pfn(*pte));
+		entry = ptep_clear_flush(vma, address, pte);
+		entry = pte_wrprotect(entry);
+		entry = pte_mkclean(entry);
+		set_pte_at(vma, address, pte, entry);
+		lazy_mmu_prot_update(entry);
+		ret = 1;
+	}
 
-unlock:
 	pte_unmap_unlock(pte, ptl);
 out:
 	return ret;
@@ -489,6 +490,8 @@ int page_mkclean(struct page *page)
 		if (mapping)
 			ret = page_mkclean_file(mapping, page);
 	}
+	if (page_test_and_clear_dirty(page))
+		ret = 1;
 
 	return ret;
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index 9bfb8e8..4a38dd1 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -51,6 +51,22 @@ static inline void truncate_partial_page
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
+	if (TestClearPageDirty(page) && account_size &&
+			mapping_cap_account_dirty(page->mapping)) {
+		dec_zone_page_state(page, NR_FILE_DIRTY);
+		task_io_account_cancelled_write(account_size);
+	}
+}
+
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
  * becomes anonymous.  It will be left on the LRU and may even be mapped into
@@ -67,11 +83,11 @@ truncate_complete_page(struct address_sp
 	if (page->mapping != mapping)
 		return;
 
+	cancel_dirty_page(page, PAGE_CACHE_SIZE);
+
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	if (test_clear_page_dirty(page))
-		task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
 	remove_from_page_cache(page);
@@ -350,7 +366,6 @@ int invalidate_inode_pages2_range(struct
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index;
-			int was_dirty;
 
 			lock_page(page);
 			if (page->mapping != mapping) {
@@ -386,12 +401,8 @@ int invalidate_inode_pages2_range(struct
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

--mP3DRpeJDSE+ciuQ--
