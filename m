Return-Path: <linux-kernel-owner+w=401wt.eu-S1422969AbWLVMYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422969AbWLVMYp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 07:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422985AbWLVMYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 07:24:45 -0500
Received: from [85.204.20.254] ([85.204.20.254]:46182 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422969AbWLVMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 07:24:44 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <20061222021714.6a83fcac.akpm@osdl.org>
References: <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	 <20061222100004.GC10273@deprecation.cyrius.com>
	 <20061222021714.6a83fcac.akpm@osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Fri, 22 Dec 2006 14:24:35 +0200
Message-Id: <1166790275.6983.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all three patches I have corruption....


diff --git a/fs/buffer.c b/fs/buffer.c
index d1f1b54..263f88e 100644
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
diff --git a/include/asm-generic/pgtable.h
b/include/asm-generic/pgtable.h
index 9d774d0..8879f1d 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -61,31 +61,6 @@ ({									\
 })
 #endif
 
-#ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define ptep_test_and_clear_dirty(__vma, __address, __ptep)		\
-({									\
-	pte_t __pte = *__ptep;						\
-	int r = 1;							\
-	if (!pte_dirty(__pte))						\
-		r = 0;							\
-	else								\
-		set_pte_at((__vma)->vm_mm, (__address), (__ptep),	\
-			   pte_mkclean(__pte));				\
-	r;								\
-})
-#endif
-
-#ifndef __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
-#define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
-({									\
-	int __dirty;							\
-	__dirty = ptep_test_and_clear_dirty(__vma, __address, __ptep);	\
-	if (__dirty)							\
-		flush_tlb_page(__vma, __address);			\
-	__dirty;							\
-})
-#endif
-
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear(__mm, __address, __ptep)			\
 ({									\
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
index e6a4723..b61d6f9 100644
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -300,18 +300,20 @@ do {									\
 	flush_tlb_page(vma, address);					\
 } while (0)
 
-#define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
-#define ptep_clear_flush_dirty(vma, address, ptep)			\
-({									\
-	int __dirty;							\
-	__dirty = pte_dirty(*(ptep));					\
-	if (__dirty) {							\
-		clear_bit(_PAGE_BIT_DIRTY, &(ptep)->pte_low);		\
-		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
-		flush_tlb_page(vma, address);				\
-	}								\
-	__dirty;							\
-})
+/*
+ * "ptep_exchange()" can be used to atomically change a set of
+ * page table protection bits, returning the old ones (the dirty
+ * and accessed bits in particular, since they are set by hw).
+ *
+ * "ptep_flush_dirty()" then returns the dirty status of the
+ * page (on x86-64, we just look at the dirty bit in the returned
+ * pte, but some other architectures have the dirty bits in
+ * other places than the page tables).
+ */
+#define ptep_exchange(vma, address, ptep, old, new) \
+	(old).pte_low = xchg(&(ptep)->pte_low, (new).pte_low);
+#define ptep_flush_dirty(vma, address, ptep, old) \
+	pte_dirty(old)
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(vma, address, ptep)			\
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index 59901c6..07754b5 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -283,12 +283,20 @@ static inline pte_t pte_clrhuge(pte_t pt
 
 struct vm_area_struct;
 
-static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma,
unsigned long addr, pte_t *ptep)
-{
-	if (!pte_dirty(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte);
-}
+/*
+ * "ptep_exchange()" can be used to atomically change a set of
+ * page table protection bits, returning the old ones (the dirty
+ * and accessed bits in particular, since they are set by hw).
+ *
+ * "ptep_flush_dirty()" then returns the dirty status of the
+ * page (on x86-64, we just look at the dirty bit in the returned
+ * pte, but some other architectures have the dirty bits in
+ * other places than the page tables).
+ */
+#define ptep_exchange(vma, address, ptep, old, new) \
+	(old).pte = xchg(&(ptep)->pte, (new).pte);
+#define ptep_flush_dirty(vma, address, ptep, old) \
+	pte_dirty(old)
 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
unsigned long addr, pte_t *ptep)
 {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4830a3b..350878a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -253,15 +253,11 @@ #define ClearPageUncached(page)	clear_bi
 
 struct page;	/* forward declaration */
 
-int test_clear_page_dirty(struct page *page);
+extern void cancel_dirty_page(struct page *page, unsigned int
account_size);
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
- * Clear a page's dirty flag, while caring for dirty memory
accounting. 
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
index d8a842a..a028803 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -432,7 +432,7 @@ static int page_mkclean_one(struct page 
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *pte, entry;
+	pte_t *ptep;
 	spinlock_t *ptl;
 	int ret = 0;
 
@@ -440,22 +440,24 @@ static int page_mkclean_one(struct page 
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address, &ptl);
-	if (!pte)
-		goto out;
-
-	if (!pte_dirty(*pte) && !pte_write(*pte))
-		goto unlock;
-
-	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
-	entry = pte_wrprotect(entry);
-	ptep_establish(vma, address, pte, entry);
-	lazy_mmu_prot_update(entry);
-	ret = 1;
-
-unlock:
-	pte_unmap_unlock(pte, ptl);
+	ptep = page_check_address(page, mm, address, &ptl);
+	if (ptep) {
+		pte_t old, new;
+
+		old = *ptep;
+		new = pte_wrprotect(pte_mkclean(old));
+		if (!pte_same(old, new)) {
+			for (;;) {
+				flush_cache_page(vma, address, page_to_pfn(page));
+				ptep_exchange(vma, address, ptep, old, new);
+				if (pte_same(old, new))
+					break;
+				ret |= ptep_flush_dirty(vma, address, ptep, old);
+				flush_tlb_page(vma, address);
+			}
+		}
+		pte_unmap_unlock(pte, ptl);
+	}
 out:
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
+	/* If we're cancelling the page, it had better not be mapped any more
*/
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
  * If truncate cannot remove the fs-private metadata from the page, the
page
  * becomes anonymous.  It will be left on the LRU and may even be
mapped into
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



On Fri, 2006-12-22 at 02:17 -0800, Andrew Morton wrote:
> On Fri, 22 Dec 2006 11:00:04 +0100
> Martin Michlmayr <tbm@cyrius.com> wrote:
> 
> > > -	if (TestClearPageDirty(page) && account_size)
> > > +	if (TestClearPageDirty(page) && account_size) {
> > > +		dec_zone_page_state(page, NR_FILE_DIRTY);
> > >  		task_io_account_cancelled_write(account_size);
> > > +	}
> > 
> > This hunk (on top of git from about 2 days ago and your latest patch)
> > results in the installer hanging right at the start. 
> 
> You'll need this also:
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Only (un)account for IO and page-dirtying for devices which have real backing
> store (ie: not tmpfs or ramdisks).
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  mm/truncate.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN mm/truncate.c~truncate-dirty-memory-accounting-fix mm/truncate.c
> --- a/mm/truncate.c~truncate-dirty-memory-accounting-fix
> +++ a/mm/truncate.c
> @@ -60,7 +60,8 @@ void cancel_dirty_page(struct page *page
>  		WARN_ON(++warncount < 5);
>  	}
>  		
> -	if (TestClearPageDirty(page) && account_size) {
> +	if (TestClearPageDirty(page) && account_size &&
> +			mapping_cap_account_dirty(page->mapping)) {
>  		dec_zone_page_state(page, NR_FILE_DIRTY);
>  		task_io_account_cancelled_write(account_size);
>  	}
> _
> 

