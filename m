Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUIGL4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUIGL4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUIGLzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:55:46 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:37641 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S267869AbUIGLzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:55:25 -0400
Message-ID: <20040907155522.A21423@castle.nmd.msu.ru>
Date: Tue, 7 Sep 2004 15:55:22 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Chris Mason <mason@suse.com>, Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] EXT3: problem with copy_from_user inside a transaction
References: <20040903150521.B1834@castle.nmd.msu.ru> <20040903123541.GB8557@x30.random> <1094213179.16078.19.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <1094213179.16078.19.camel@watt.suse.com>; from "Chris Mason" on Fri, Sep 03, 2004 at 08:06:20AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 08:06:20AM -0400, Chris Mason wrote:
> On Fri, 2004-09-03 at 08:35, Andrea Arcangeli wrote:
> > On Fri, Sep 03, 2004 at 03:05:21PM +0400, Andrey Savochkin wrote:
> > > Hi Andrew,
> > > 
> > > filemap_copy_from_user() between prepare_write() and commit_write()
> > > appears to be a problem for ext3.
> > > 
> And reiserv3, and maybe the other journaled filesystems.
> 
> > yes, Chris is working on it for a few months.
> > 
> Working is a generous term, I've somewhat been waiting for a better
> solution to pop into my head.  In the end, I think all we can do is not
> allow filesystems to take locks (or implicit locks like starting a
> transaction) inside the prepare_write call.
> 
> This would mean that all the work is done during the commit_write
> stage.  The trick is that we would have to handle -ENOSPC since we might
> not know we've run out of room until after the data has been copied from
> userland.
> 
> prepare_write could reserve blocks, which brings us half way to a
> generic delayed allocation layer.  But for a quick and dirty start,
> doing it all in commit_write should work.

Ok, so here is the patch moving journal_start() together with space
allocation from ext3_prepare_write() to commit_write().

ENOSPC is handled in ext3_map_write() called from commit_write().
In ENOSPC or other error case, the data copied from the userspace is zeroed,
but only if the buffers and the whole page are not up to date.
Answering my previous questions, if
 - the inode page is modified through mmap and then by write,
 - the file has holes and
 - there is no space on disk,
the page cache will have the new content (provided by write) not written to
disk.  Similarly to modifications through pure mmap.

It's interesting that block_prepare_write() zeroes the page content in case
of error even if the page has been modified through mmap()...

Comments?

	Andrey

Signed-off-by: Andrey Savochkin <saw@saw.sw.com.sg>

===== fs/buffer.c 1.255 vs edited =====
--- 1.255/fs/buffer.c	2004-08-27 10:31:38 +04:00
+++ edited/fs/buffer.c	2004-09-06 14:57:01 +04:00
@@ -2025,8 +2025,9 @@ static int __block_prepare_write(struct 
 				goto out;
 			if (buffer_new(bh)) {
 				clear_buffer_new(bh);
-				unmap_underlying_metadata(bh->b_bdev,
-							bh->b_blocknr);
+				if (buffer_mapped(bh))
+					unmap_underlying_metadata(bh->b_bdev,
+								bh->b_blocknr);
 				if (PageUptodate(page)) {
 					set_buffer_uptodate(bh);
 					continue;
===== fs/ext3/inode.c 1.101 vs edited =====
--- 1.101/fs/ext3/inode.c	2004-08-27 10:31:38 +04:00
+++ edited/fs/ext3/inode.c	2004-09-07 13:00:36 +04:00
@@ -782,6 +782,7 @@ reread:
 	if (!partial) {
 		clear_buffer_new(bh_result);
 got_it:
+		clear_buffer_delay(bh_result);
 		map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
 		if (boundary)
 			set_buffer_boundary(bh_result);
@@ -1065,11 +1066,13 @@ static int walk_page_buffers(	handle_t *
  * and the commit_write().  So doing the journal_start at the start of
  * prepare_write() is the right place.
  *
- * Also, this function can nest inside ext3_writepage() ->
- * block_write_full_page(). In that case, we *know* that ext3_writepage()
- * has generated enough buffer credits to do the whole page.  So we won't
- * block on the journal in that case, which is good, because the caller may
- * be PF_MEMALLOC.
+ * [2004/09/04 SAW] journal_start() in prepare_write() causes different ranking
+ * violations if copy_from_user() triggers a page fault (mmap_sem, may be page
+ * lock, plus __GFP_FS allocations).
+ * Now we read in not up-to-date buffers in prepare_write(), and do the rest
+ * including hole instantiation and inode extension in commit_write().
+ *
+ * Other notes.
  *
  * By accident, ext3 can be reentered when a transaction is open via
  * quota file writes.  If we were to commit the transaction while thus
@@ -1084,6 +1087,66 @@ static int walk_page_buffers(	handle_t *
  * write.  
  */
 
+static int ext3_get_block_delay(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh, int create)
+{
+	int ret;
+
+	ret = ext3_get_block_handle(NULL, inode, iblock, bh, 0, 0);
+	if (ret)
+		return ret;
+	if (!buffer_mapped(bh)) {
+		set_buffer_delay(bh);
+		set_buffer_new(bh);
+	}
+	return ret;
+}
+
+static int ext3_get_block_delay_uptodate(handle_t *handle,
+		struct buffer_head *bh)
+{
+	struct page *page;
+	struct inode *inode;
+	sector_t block;
+	int ret;
+
+	page = bh->b_page;
+	inode = page->mapping->host;
+	block = (sector_t)page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	ret = ext3_get_block_handle(NULL, inode, block, bh, 0, 0);
+	if (ret)
+		return ret;
+	if (!buffer_uptodate(bh))
+		set_buffer_uptodate(bh); /* PageUptodate */
+	if (!buffer_mapped(bh)) {
+		set_buffer_delay(bh);
+		set_buffer_new(bh);
+	} else {
+		unmap_underlying_metadata(bh->b_bdev, bh->b_blocknr);
+	}
+	return ret;
+}
+
+static int ext3_prepare_write(struct file *file, struct page *page,
+		unsigned from, unsigned to)
+{
+	int ret;
+
+	if (PageUptodate(page)) {
+		/* simplified version of block_prepare_write */
+		struct inode *inode = page->mapping->host;
+		if (!page_has_buffers(page))
+			create_empty_buffers(page, 1 << inode->i_blkbits, 0);
+		ret = walk_page_buffers(NULL, page_buffers(page),
+				from, to, NULL, ext3_get_block_delay_uptodate);
+		if (ret) /* XXX: really should do this? */
+			ClearPageUptodate(page);
+	} else
+		ret = block_prepare_write(page, from, to,
+				ext3_get_block_delay);
+	return ret;
+}
+
 static int do_journal_get_write_access(handle_t *handle, 
 				       struct buffer_head *bh)
 {
@@ -1092,8 +1155,52 @@ static int do_journal_get_write_access(h
 	return ext3_journal_get_write_access(handle, bh);
 }
 
-static int ext3_prepare_write(struct file *file, struct page *page,
-			      unsigned from, unsigned to)
+/*
+ * This function zeroes buffers not mapped to disk.
+ * We do it similarly to the error path in __block_prepare_write() to avoid
+ * keeping garbage in the page cache.
+ * Here we check BH_delay state.  We know that if the buffer appears
+ * !buffer_mapped then
+ *   - it was !buffer_mapped at the moment of ext3_prepare_write, and
+ *   - ext3_get_block failed to map this buffer (e.g., ENOSPC).
+ * If this !mapped buffer is not up to date (it can be up to date if
+ * PageUptodate), then we zero its content.
+ */
+static void ext3_clear_delayed_buffers(struct page *page,
+		unsigned from, unsigned to)
+{
+	struct buffer_head *bh, *head, *next;
+	unsigned block_start, block_end;
+	unsigned blocksize;
+	void *kaddr;
+
+	head = page_buffers(page);
+	blocksize = head->b_size;
+	for (	bh = head, block_start = 0;
+		bh != head || !block_start;
+	    	block_start = block_end, bh = next)
+	{
+		next = bh->b_this_page;
+		block_end = block_start + blocksize;
+		if (block_end <= from || block_start >= to)
+			continue;
+		if (!buffer_delay(bh))
+			continue;
+		J_ASSERT_BH(bh, !buffer_mapped(bh));
+		clear_buffer_new(bh);
+		clear_buffer_delay(bh);
+		if (!buffer_uptodate(bh)) {
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + block_start, 0, bh->b_size);
+			kunmap_atomic(kaddr, KM_USER0);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+		}
+	}
+}
+
+static int ext3_map_write(struct file *file, struct page *page,
+		unsigned from, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
 	int ret, needed_blocks = ext3_writepage_trans_blocks(inode);
@@ -1106,19 +1213,19 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	ret = block_prepare_write(page, from, to, ext3_get_block);
-	if (ret)
-		goto prepare_write_failed;
 
-	if (ext3_should_journal_data(inode)) {
+	ret = block_prepare_write(page, from, to, ext3_get_block);
+	if (!ret && ext3_should_journal_data(inode)) {
 		ret = walk_page_buffers(handle, page_buffers(page),
 				from, to, NULL, do_journal_get_write_access);
 	}
-prepare_write_failed:
-	if (ret)
-		ext3_journal_stop(handle);
+	if (!ret)
+		goto out;
+
+	ext3_journal_stop(handle);
 	if (ret == -ENOSPC && ext3_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
+	ext3_clear_delayed_buffers(page, from, to);
 out:
 	return ret;
 }
@@ -1153,10 +1260,15 @@ static int commit_write_fn(handle_t *han
 static int ext3_ordered_commit_write(struct file *file, struct page *page,
 			     unsigned from, unsigned to)
 {
-	handle_t *handle = ext3_journal_current_handle();
+	handle_t *handle;
 	struct inode *inode = page->mapping->host;
 	int ret = 0, ret2;
 
+	ret = ext3_map_write(file, page, from, to);
+	if (ret)
+		return ret;
+	handle = ext3_journal_current_handle();
+
 	ret = walk_page_buffers(handle, page_buffers(page),
 		from, to, NULL, ext3_journal_dirty_data);
 
@@ -1182,11 +1294,15 @@ static int ext3_ordered_commit_write(str
 static int ext3_writeback_commit_write(struct file *file, struct page *page,
 			     unsigned from, unsigned to)
 {
-	handle_t *handle = ext3_journal_current_handle();
+	handle_t *handle;
 	struct inode *inode = page->mapping->host;
 	int ret = 0, ret2;
 	loff_t new_i_size;
 
+	ret = ext3_map_write(file, page, from, to);
+	if (ret)
+		return ret;
+	handle = ext3_journal_current_handle();
 	new_i_size = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 	if (new_i_size > EXT3_I(inode)->i_disksize)
 		EXT3_I(inode)->i_disksize = new_i_size;
@@ -1200,11 +1316,16 @@ static int ext3_writeback_commit_write(s
 static int ext3_journalled_commit_write(struct file *file,
 			struct page *page, unsigned from, unsigned to)
 {
-	handle_t *handle = ext3_journal_current_handle();
+	handle_t *handle;
 	struct inode *inode = page->mapping->host;
 	int ret = 0, ret2;
 	int partial = 0;
 	loff_t pos;
+
+	ret = ext3_map_write(file, page, from, to);
+	if (ret)
+		return ret;
+	handle = ext3_journal_current_handle();
 
 	/*
 	 * Here we duplicate the generic_commit_write() functionality
===== fs/jbd/transaction.c 1.87 vs edited =====
--- 1.87/fs/jbd/transaction.c	2004-08-07 21:59:49 +04:00
+++ edited/fs/jbd/transaction.c	2004-09-04 16:17:15 +04:00
@@ -1870,6 +1870,7 @@ zap_buffer_unlocked:
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
+	clear_buffer_delay(bh);
 	bh->b_bdev = NULL;
 	return may_free;
 }
