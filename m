Return-Path: <linux-kernel-owner+w=401wt.eu-S1754792AbWLSAaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbWLSAaI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbWLSAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:30:08 -0500
Received: from [85.204.20.254] ([85.204.20.254]:41015 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754792AbWLSAaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:30:05 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
	 <1166476297.6862.1.camel@localhost>
	 <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>
	 <1166485691.6977.6.camel@localhost>
	 <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Tue, 19 Dec 2006 02:29:59 +0200
Message-Id: <1166488199.6950.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 16:04 -0800, Linus Torvalds wrote:
> 
> On Tue, 19 Dec 2006, Andrei Popa wrote:
> > > 
> > > There's exactly two call sites that call "page_mkclean()" (an dthat is the 
> > > only thing in turn that calls "page_mkclean_one()", which we already 
> > > determined will cause the corruption). 
> > >
> > > Can you just TOTALLY DISABLE that case for the test_clear_page_dirty() 
> > > case? Just do an "#if 0 .. #endif" around that whole if-statement, leaving 
> > > the _only_ thing that actually calls "page_mkclean()" to be the 
> > > "clear_page_dirty_for_io()" call.
> > > 
> > > Do you still see corruption?
> > 
> > nope, no file corruption at all.
> 
> Ok. That's interesting, but I think you actually #ifdef'ed out too 
> much:
> 
> > +
> > +#if 0
> >  	if (TestClearPageDirty(page)) {
> >  		radix_tree_tag_clear(&mapping->page_tree,
> >  				page_index(page), PAGECACHE_TAG_DIRTY);
> > @@ -866,11 +868,19 @@ int test_clear_page_dirty(struct page *p
> >  		 * page is locked, which pins the address_space
> >  		 */
> >  		if (mapping_cap_account_dirty(mapping)) {
> > -			page_mkclean(page);
> > +			int cleaned = page_mkclean(page);
> > +			if (!must_clean_ptes && cleaned){
> > +			WARN_ON(1);
> > +			set_page_dirty(page);
> > +			}
> > +
> >  			dec_zone_page_state(page, NR_FILE_DIRTY);
> >  		}
> >  		return 1;
> >  	}
> > +
> > +#endif
> > +
> 
> It was really just the _inner_ "if (mapping_cap_account_dirty(.." 
> statement that I meant you should remove.
> 
> Can you try that too?

I have file corruption: "Hash check on download completion found bad
chunks, consider using "safe_sync"."


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
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0f05cab..2d8bbbb 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1245,7 +1245,7 @@ retry:
 				wait_on_page_writeback(page);
 
 			if (PageWriteback(page) ||
-					!test_clear_page_dirty(page)) {
+					!test_clear_page_dirty(page, 0)) {
 				unlock_page(page);
 				break;
 			}
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1387749..da2bdb1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -484,7 +484,7 @@ static int fuse_commit_write(struct file
 		spin_unlock(&fc->lock);
 
 		if (offset == 0 && to == PAGE_CACHE_SIZE) {
-			clear_page_dirty(page);
+			clear_page_dirty(page, 0);
 			SetPageUptodate(page);
 		}
 	}
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ed2c223..9f82cd0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct
 
 static void truncate_huge_page(struct page *page)
 {
-	clear_page_dirty(page);
+	clear_page_dirty(page, 0);
 	ClearPageUptodate(page);
 	remove_from_page_cache(page);
 	put_page(page);
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index b1a1c72..5e29b37 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -773,7 +773,7 @@ #if MPS_PER_PAGE == 1
 
 	/* Retest mp->count since we may have released page lock */
 	if (test_bit(META_discard, &mp->flag) && !mp->count) {
-		clear_page_dirty(page);
+		clear_page_dirty(page, 0);
 		ClearPageUptodate(page);
 	}
 #else
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 47e7027..a97e198 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1459,7 +1459,7 @@ static void unmap_buffers(struct page *p
 				bh = next;
 			} while (bh != head);
 			if (PAGE_SIZE == bh->b_size) {
-				clear_page_dirty(page);
+				clear_page_dirty(page, 0);
 			}
 		}
 	}
diff --git a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
index b56eb75..44ac434 100644
--- a/fs/xfs/linux-2.6/xfs_aops.c
+++ b/fs/xfs/linux-2.6/xfs_aops.c
@@ -343,7 +343,7 @@ xfs_start_page_writeback(
 	ASSERT(!PageWriteback(page));
 	set_page_writeback(page);
 	if (clear_dirty)
-		clear_page_dirty(page);
+		clear_page_dirty(page, 0);
 	unlock_page(page);
 	if (!buffers) {
 		end_page_writeback(page);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4830a3b..175ab3c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -253,13 +253,13 @@ #define ClearPageUncached(page)	clear_bi
 
 struct page;	/* forward declaration */
 
-int test_clear_page_dirty(struct page *page);
+int test_clear_page_dirty(struct page *page, int must_clean_ptes);
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
 
-static inline void clear_page_dirty(struct page *page)
+static inline void clear_page_dirty(struct page *page, int
must_clean_ptes)
 {
-	test_clear_page_dirty(page);
+	test_clear_page_dirty(page, must_clean_ptes);
 }
 
 static inline void set_page_writeback(struct page *page)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 237107c..4ff7f90 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -848,7 +848,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
  * Clear a page's dirty flag, while caring for dirty memory
accounting. 
  * Returns true if the page was previously dirty.
  */
-int test_clear_page_dirty(struct page *page)
+int test_clear_page_dirty(struct page *page, int must_clean_ptes)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
@@ -857,6 +857,7 @@ int test_clear_page_dirty(struct page *p
 		return TestClearPageDirty(page);
 
 	write_lock_irqsave(&mapping->tree_lock, flags);
+
 	if (TestClearPageDirty(page)) {
 		radix_tree_tag_clear(&mapping->page_tree,
 				page_index(page), PAGECACHE_TAG_DIRTY);
@@ -865,12 +866,23 @@ int test_clear_page_dirty(struct page *p
 		 * We can continue to use `mapping' here because the
 		 * page is locked, which pins the address_space
 		 */
+
+#if 0
+
 		if (mapping_cap_account_dirty(mapping)) {
-			page_mkclean(page);
+			int cleaned = page_mkclean(page);
+			if (!must_clean_ptes && cleaned){
+			WARN_ON(1);
+			set_page_dirty(page);
+			}
+
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
+#endif
+
 		return 1;
 	}
+
 	write_unlock_irqrestore(&mapping->tree_lock, flags);
 	return 0;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
diff --git a/mm/truncate.c b/mm/truncate.c
index 9bfb8e8..9a01d9e 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -70,7 +70,7 @@ truncate_complete_page(struct address_sp
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	if (test_clear_page_dirty(page))
+	if (test_clear_page_dirty(page, 0))
 		task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
@@ -386,7 +386,7 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
+			was_dirty = test_clear_page_dirty(page, 0);
 			if (!invalidate_complete_page2(mapping, page)) {
 				if (was_dirty)
 					set_page_dirty(page);


