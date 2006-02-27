Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWB0BoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWB0BoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWB0BoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:44:04 -0500
Received: from cantor2.suse.de ([195.135.220.15]:21679 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750782AbWB0BoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:44:01 -0500
From: NeilBrown <neilb@suse.de>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Mon, 27 Feb 2006 12:43:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17410.22835.447376.605735@cse.unsw.edu.au>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
References: <20060227122948.24317.patches-A@notabene>
Subject: [PATCH 001 of 2] Make address_space_operations->invalidatepage return void
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The return value of this function is never used, so let's
be honest and declare it as void.

Some places where invalidatepage returned 0, I have inserted a BUG_ON,
partly for documentation purposes.  I would be nice if these were
verified by someone with more knowledge...

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/afs/file.c               |    6 +++---
 ./fs/buffer.c                 |   22 +++++++++++-----------
 ./fs/ext3/inode.c             |    4 ++--
 ./fs/jbd/transaction.c        |   11 ++++-------
 ./fs/jfs/jfs_metapage.c       |    7 +++----
 ./fs/reiser4/as_ops.c         |   13 ++++++-------
 ./fs/reiser4/vfs_ops.h        |    2 +-
 ./fs/reiserfs/inode.c         |    8 +++++---
 ./fs/xfs/linux-2.6/xfs_aops.c |    4 ++--
 ./include/linux/buffer_head.h |    4 ++--
 ./include/linux/fs.h          |    2 +-
 ./include/linux/jbd.h         |    2 +-
 12 files changed, 41 insertions(+), 44 deletions(-)

diff ./fs/afs/file.c~current~ ./fs/afs/file.c
--- ./fs/afs/file.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/afs/file.c	2006-02-27 11:55:43.000000000 +1100
@@ -28,7 +28,7 @@ static int afs_file_release(struct inode
 #endif
 
 static int afs_file_readpage(struct file *file, struct page *page);
-static int afs_file_invalidatepage(struct page *page, unsigned long offset);
+static void afs_file_invalidatepage(struct page *page, unsigned long offset);
 static int afs_file_releasepage(struct page *page, gfp_t gfp_flags);
 
 struct inode_operations afs_file_inode_operations = {
@@ -212,7 +212,7 @@ int afs_cache_get_page_cookie(struct pag
 /*
  * invalidate part or all of a page
  */
-static int afs_file_invalidatepage(struct page *page, unsigned long offset)
+static void afs_file_invalidatepage(struct page *page, unsigned long offset)
 {
 	int ret = 1;
 
@@ -238,11 +238,11 @@ static int afs_file_invalidatepage(struc
 			if (!PageWriteback(page))
 				ret = page->mapping->a_ops->releasepage(page,
 									0);
+			BUG_ON(!ret);
 		}
 	}
 
 	_leave(" = %d", ret);
-	return ret;
 } /* end afs_file_invalidatepage() */
 
 /*****************************************************************************/

diff ./fs/buffer.c~current~ ./fs/buffer.c
--- ./fs/buffer.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/buffer.c	2006-02-27 12:12:57.000000000 +1100
@@ -1598,11 +1598,10 @@ EXPORT_SYMBOL(try_to_release_page);
  * point.  Because the caller is about to free (and possibly reuse) those
  * blocks on-disk.
  */
-int block_invalidatepage(struct page *page, unsigned long offset)
+void block_invalidatepage(struct page *page, unsigned long offset)
 {
 	struct buffer_head *head, *bh, *next;
 	unsigned int curr_off = 0;
-	int ret = 1;
 
 	BUG_ON(!PageLocked(page));
 	if (!page_has_buffers(page))
@@ -1628,20 +1627,21 @@ int block_invalidatepage(struct page *pa
 	 * The get_block cached value has been unconditionally invalidated,
 	 * so real IO is not possible anymore.
 	 */
-	if (offset == 0)
-		ret = try_to_release_page(page, 0);
+	if (offset == 0) {
+		int ret = try_to_release_page(page, 0);
+		BUG_ON(!ret);
+	}
 out:
-	return ret;
+	return;
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
-int do_invalidatepage(struct page *page, unsigned long offset)
+void do_invalidatepage(struct page *page, unsigned long offset)
 {
-	int (*invalidatepage)(struct page *, unsigned long);
-	invalidatepage = page->mapping->a_ops->invalidatepage;
-	if (invalidatepage == NULL)
-		invalidatepage = block_invalidatepage;
-	return (*invalidatepage)(page, offset);
+	void (*invalidatepage)(struct page *, unsigned long);
+	invalidatepage = page->mapping->a_ops->invalidatepage ? :
+		block_invalidatepage;
+	(*invalidatepage)(page, offset);
 }
 
 /*

diff ./fs/ext3/inode.c~current~ ./fs/ext3/inode.c
--- ./fs/ext3/inode.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/ext3/inode.c	2006-02-27 11:55:43.000000000 +1100
@@ -1591,7 +1591,7 @@ ext3_readpages(struct file *file, struct
 	return mpage_readpages(mapping, pages, nr_pages, ext3_get_block);
 }
 
-static int ext3_invalidatepage(struct page *page, unsigned long offset)
+static void ext3_invalidatepage(struct page *page, unsigned long offset)
 {
 	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
 
@@ -1601,7 +1601,7 @@ static int ext3_invalidatepage(struct pa
 	if (offset == 0)
 		ClearPageChecked(page);
 
-	return journal_invalidatepage(journal, page, offset);
+	journal_invalidatepage(journal, page, offset);
 }
 
 static int ext3_releasepage(struct page *page, gfp_t wait)

diff ./fs/jbd/transaction.c~current~ ./fs/jbd/transaction.c
--- ./fs/jbd/transaction.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/jbd/transaction.c	2006-02-27 11:55:43.000000000 +1100
@@ -1873,16 +1873,15 @@ zap_buffer_unlocked:
 }
 
 /** 
- * int journal_invalidatepage() 
+ * void journal_invalidatepage()
  * @journal: journal to use for flush... 
  * @page:    page to flush
  * @offset:  length of page to invalidate.
  *
  * Reap page buffers containing data after offset in page.
  *
- * Return non-zero if the page's buffers were successfully reaped.
  */
-int journal_invalidatepage(journal_t *journal, 
+void journal_invalidatepage(journal_t *journal,
 		      struct page *page, 
 		      unsigned long offset)
 {
@@ -1893,7 +1892,7 @@ int journal_invalidatepage(journal_t *jo
 	if (!PageLocked(page))
 		BUG();
 	if (!page_has_buffers(page))
-		return 1;
+		return;
 
 	/* We will potentially be playing with lists other than just the
 	 * data lists (especially for journaled data mode), so be
@@ -1916,11 +1915,9 @@ int journal_invalidatepage(journal_t *jo
 	} while (bh != head);
 
 	if (!offset) {
-		if (!may_free || !try_to_free_buffers(page))
-			return 0;
+		BUG_ON(!may_free || !try_to_free_buffers(page));
 		J_ASSERT(!page_has_buffers(page));
 	}
-	return 1;
 }
 
 /* 

diff ./fs/jfs/jfs_metapage.c~current~ ./fs/jfs/jfs_metapage.c
--- ./fs/jfs/jfs_metapage.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/jfs/jfs_metapage.c	2006-02-27 11:55:43.000000000 +1100
@@ -579,14 +579,13 @@ static int metapage_releasepage(struct p
 	return 0;
 }
 
-static int metapage_invalidatepage(struct page *page, unsigned long offset)
+static void metapage_invalidatepage(struct page *page, unsigned long offset)
 {
 	BUG_ON(offset);
 
-	if (PageWriteback(page))
-		return 0;
+	BUG_ON(PageWriteback(page));
 
-	return metapage_releasepage(page, 0);
+	metapage_releasepage(page, 0);
 }
 
 struct address_space_operations jfs_metapage_aops = {

diff ./fs/reiser4/as_ops.c~current~ ./fs/reiser4/as_ops.c
--- ./fs/reiser4/as_ops.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/reiser4/as_ops.c	2006-02-27 11:55:43.000000000 +1100
@@ -170,7 +170,7 @@ reiser4_readpages(struct file *file, str
  * @offset: starting offset for partial invalidation
  *
  */
-int reiser4_invalidatepage(struct page *page, unsigned long offset)
+void reiser4_invalidatepage(struct page *page, unsigned long offset)
 {
 	int ret = 0;
 	reiser4_context *ctx;
@@ -208,11 +208,11 @@ int reiser4_invalidatepage(struct page *
 	 * them. Check for this, and do nothing.
 	 */
 	if (get_super_fake(inode->i_sb) == inode)
-		return 0;
+		return;
 	if (get_cc_fake(inode->i_sb) == inode)
-		return 0;
+		return;
 	if (get_bitmap_fake(inode->i_sb) == inode)
-		return 0;
+		return;
 	assert("vs-1426", PagePrivate(page));
 	assert("vs-1427",
 	       page->mapping == jnode_get_mapping(jnode_by_page(page)));
@@ -222,7 +222,7 @@ int reiser4_invalidatepage(struct page *
 
 	ctx = init_context(inode->i_sb);
 	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+		return;
 
 	node = jprivate(page);
 	spin_lock_jnode(node);
@@ -236,7 +236,7 @@ int reiser4_invalidatepage(struct page *
 		unhash_unformatted_jnode(node);
 		jput(node);
 		reiser4_exit_context(ctx);
-		return 0;
+		return;
 	}
 	spin_unlock_jnode(node);
 
@@ -265,7 +265,6 @@ int reiser4_invalidatepage(struct page *
 	}
 
 	reiser4_exit_context(ctx);
-	return ret;
 }
 
 /* help function called from reiser4_releasepage(). It returns true if jnode

diff ./fs/reiser4/vfs_ops.h~current~ ./fs/reiser4/vfs_ops.h
--- ./fs/reiser4/vfs_ops.h~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/reiser4/vfs_ops.h	2006-02-27 11:55:43.000000000 +1100
@@ -24,7 +24,7 @@ int reiser4_writepage(struct page *, str
 int reiser4_set_page_dirty(struct page *);
 int reiser4_readpages(struct file *, struct address_space *,
 		      struct list_head *pages, unsigned nr_pages);
-int reiser4_invalidatepage(struct page *, unsigned long offset);
+void reiser4_invalidatepage(struct page *, unsigned long offset);
 int reiser4_releasepage(struct page *, gfp_t);
 
 extern int reiser4_update_sd(struct inode *);

diff ./fs/reiserfs/inode.c~current~ ./fs/reiserfs/inode.c
--- ./fs/reiserfs/inode.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/reiserfs/inode.c	2006-02-27 11:55:43.000000000 +1100
@@ -2797,7 +2797,7 @@ static int invalidatepage_can_drop(struc
 }
 
 /* clm -- taken from fs/buffer.c:block_invalidate_page */
-static int reiserfs_invalidatepage(struct page *page, unsigned long offset)
+static void reiserfs_invalidatepage(struct page *page, unsigned long offset)
 {
 	struct buffer_head *head, *bh, *next;
 	struct inode *inode = page->mapping->host;
@@ -2836,10 +2836,12 @@ static int reiserfs_invalidatepage(struc
 	 * The get_block cached value has been unconditionally invalidated,
 	 * so real IO is not possible anymore.
 	 */
-	if (!offset && ret)
+	if (!offset && ret) {
 		ret = try_to_release_page(page, 0);
+		BUG_ON(!ret);
+	}
       out:
-	return ret;
+	return;
 }
 
 static int reiserfs_set_page_dirty(struct page *page)

diff ./fs/xfs/linux-2.6/xfs_aops.c~current~ ./fs/xfs/linux-2.6/xfs_aops.c
--- ./fs/xfs/linux-2.6/xfs_aops.c~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./fs/xfs/linux-2.6/xfs_aops.c	2006-02-27 11:55:43.000000000 +1100
@@ -1371,14 +1371,14 @@ out_unlock:
 	return error;
 }
 
-STATIC int
+STATIC void
 linvfs_invalidate_page(
 	struct page		*page,
 	unsigned long		offset)
 {
 	xfs_page_trace(XFS_INVALIDPAGE_ENTER,
 			page->mapping->host, page, offset);
-	return block_invalidatepage(page, offset);
+	block_invalidatepage(page, offset);
 }
 
 /*

diff ./include/linux/buffer_head.h~current~ ./include/linux/buffer_head.h
--- ./include/linux/buffer_head.h~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./include/linux/buffer_head.h	2006-02-27 12:12:57.000000000 +1100
@@ -189,8 +189,8 @@ extern int buffer_heads_over_limit;
  * address_spaces.
  */
 int try_to_release_page(struct page * page, gfp_t gfp_mask);
-int block_invalidatepage(struct page *page, unsigned long offset);
-int do_invalidatepage(struct page *page, unsigned long offset);
+void block_invalidatepage(struct page *page, unsigned long offset);
+void do_invalidatepage(struct page *page, unsigned long offset);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
 int block_read_full_page(struct page*, get_block_t*);

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./include/linux/fs.h	2006-02-27 12:12:57.000000000 +1100
@@ -359,7 +359,7 @@ struct address_space_operations {
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
-	int (*invalidatepage) (struct page *, unsigned long);
+	void (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, gfp_t);
 	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);

diff ./include/linux/jbd.h~current~ ./include/linux/jbd.h
--- ./include/linux/jbd.h~current~	2006-02-27 12:13:00.000000000 +1100
+++ ./include/linux/jbd.h	2006-02-27 11:56:44.000000000 +1100
@@ -900,7 +900,7 @@ extern int	 journal_dirty_metadata (hand
 extern void	 journal_release_buffer (handle_t *, struct buffer_head *);
 extern int	 journal_forget (handle_t *, struct buffer_head *);
 extern void	 journal_sync_buffer (struct buffer_head *);
-extern int	 journal_invalidatepage(journal_t *,
+extern void	 journal_invalidatepage(journal_t *,
 				struct page *, unsigned long);
 extern int	 journal_try_to_free_buffers(journal_t *, struct page *, gfp_t);
 extern int	 journal_stop(handle_t *);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
