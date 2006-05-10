Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWEJQDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWEJQDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWEJQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17577 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751490AbWEJQBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:01:53 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/14] FS-Cache: Provide a filesystem-specific sync'able page bit [try #8]
Date: Wed, 10 May 2006 17:01:35 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060510160135.9058.74825.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides a filesystem-specific page bit that a filesystem
can synchronise upon.  This can be used, for example, by a netfs to synchronise
with CacheFS writing its pages to disk.

The PG_checked bit is replaced with PG_fs_misc, and various operations are
provided based upon that.  The *PageChecked() macros still exist, though now
they just convert to *PageFsMisc() macros.  The name of the "checked" macros
seems appropriate as they're used for metadata page validation by various
filesystems.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c               |    5 +----
 fs/ext2/dir.c              |    6 +++---
 fs/ext3/inode.c            |   10 +++++-----
 fs/freevxfs/vxfs_subr.c    |    2 +-
 fs/reiserfs/inode.c        |   10 +++++-----
 include/linux/page-flags.h |   15 ++++++++++-----
 include/linux/pagemap.h    |   11 +++++++++++
 mm/filemap.c               |   17 +++++++++++++++++
 mm/migrate.c               |    4 ++--
 mm/page_alloc.c            |    2 +-
 10 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a6dff6a..c23de2b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -155,11 +155,9 @@ #endif
 		}
 	}
 
-	SetPageChecked(page);
 	return;
 
  error:
-	SetPageChecked(page);
 	SetPageError(page);
 
 } /* end afs_dir_check_page() */
@@ -193,8 +191,7 @@ static struct page *afs_dir_get_page(str
 		kmap(page);
 		if (!PageUptodate(page))
 			goto fail;
-		if (!PageChecked(page))
-			afs_dir_check_page(dir, page);
+		afs_dir_check_page(dir, page);
 		if (PageError(page))
 			goto fail;
 	}
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index d672aa9..cf9cee4 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -112,7 +112,7 @@ static void ext2_check_page(struct page 
 	if (offs != limit)
 		goto Eend;
 out:
-	SetPageChecked(page);
+	SetPageFsMisc(page);
 	return;
 
 	/* Too bad, we had an error */
@@ -152,7 +152,7 @@ Eend:
 		dir->i_ino, (page->index<<PAGE_CACHE_SHIFT)+offs,
 		(unsigned long) le32_to_cpu(p->inode));
 fail:
-	SetPageChecked(page);
+	SetPageFsMisc(page);
 	SetPageError(page);
 }
 
@@ -166,7 +166,7 @@ static struct page * ext2_get_page(struc
 		kmap(page);
 		if (!PageUptodate(page))
 			goto fail;
-		if (!PageChecked(page))
+		if (!PageFsMisc(page))
 			ext2_check_page(page);
 		if (PageError(page))
 			goto fail;
diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index 2edd7ee..2a38eee 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -1528,12 +1528,12 @@ static int ext3_journalled_writepage(str
 		goto no_write;
 	}
 
-	if (!page_has_buffers(page) || PageChecked(page)) {
+	if (!page_has_buffers(page) || PageFsMisc(page)) {
 		/*
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		ClearPageChecked(page);
+		ClearPageFsMisc(page);
 		ret = block_prepare_write(page, 0, PAGE_CACHE_SIZE,
 					ext3_get_block);
 		if (ret != 0) {
@@ -1590,7 +1590,7 @@ static void ext3_invalidatepage(struct p
 	 * If it's a full truncate we just forget about the pending dirtying
 	 */
 	if (offset == 0)
-		ClearPageChecked(page);
+		ClearPageFsMisc(page);
 
 	journal_invalidatepage(journal, page, offset);
 }
@@ -1599,7 +1599,7 @@ static int ext3_releasepage(struct page 
 {
 	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
 
-	WARN_ON(PageChecked(page));
+	WARN_ON(PageFsMisc(page));
 	if (!page_has_buffers(page))
 		return 0;
 	return journal_try_to_free_buffers(journal, page, wait);
@@ -1695,7 +1695,7 @@ out:
  */
 static int ext3_journalled_set_page_dirty(struct page *page)
 {
-	SetPageChecked(page);
+	SetPageFsMisc(page);
 	return __set_page_dirty_nobuffers(page);
 }
 
diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index 50aae77..e884bfc 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -79,7 +79,7 @@ vxfs_get_page(struct address_space *mapp
 		kmap(pp);
 		if (!PageUptodate(pp))
 			goto fail;
-		/** if (!PageChecked(pp)) **/
+		/** if (!PageFsMisc(pp)) **/
 			/** vxfs_check_page(pp); **/
 		if (PageError(pp))
 			goto fail;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 9857e50..3c79e02 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2352,7 +2352,7 @@ static int reiserfs_write_full_page(stru
 	struct buffer_head *head, *bh;
 	int partial = 0;
 	int nr = 0;
-	int checked = PageChecked(page);
+	int checked = PageFsMisc(page);
 	struct reiserfs_transaction_handle th;
 	struct super_block *s = inode->i_sb;
 	int bh_per_page = PAGE_CACHE_SIZE / s->s_blocksize;
@@ -2421,7 +2421,7 @@ static int reiserfs_write_full_page(stru
 	 * blocks we're going to log
 	 */
 	if (checked) {
-		ClearPageChecked(page);
+		ClearPageFsMisc(page);
 		reiserfs_write_lock(s);
 		error = journal_begin(&th, s, bh_per_page + 1);
 		if (error) {
@@ -2802,7 +2802,7 @@ static void reiserfs_invalidatepage(stru
 	BUG_ON(!PageLocked(page));
 
 	if (offset == 0)
-		ClearPageChecked(page);
+		ClearPageFsMisc(page);
 
 	if (!page_has_buffers(page))
 		goto out;
@@ -2843,7 +2843,7 @@ static int reiserfs_set_page_dirty(struc
 {
 	struct inode *inode = page->mapping->host;
 	if (reiserfs_file_data_log(inode)) {
-		SetPageChecked(page);
+		SetPageFsMisc(page);
 		return __set_page_dirty_nobuffers(page);
 	}
 	return __set_page_dirty_buffers(page);
@@ -2866,7 +2866,7 @@ static int reiserfs_releasepage(struct p
 	struct buffer_head *bh;
 	int ret = 1;
 
-	WARN_ON(PageChecked(page));
+	WARN_ON(PageFsMisc(page));
 	spin_lock(&j->j_dirty_buffers_lock);
 	head = page_buffers(page);
 	bh = head;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d276a4e..7d7ef97 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -73,7 +73,7 @@ #define PG_lru			 5
 #define PG_active		 6
 #define PG_slab			 7	/* slab debug (Suparna wants this) */
 
-#define PG_checked		 8	/* kill me in 2.5.<early>. */
+#define PG_fs_misc		 8
 #define PG_arch_1		 9
 #define PG_reserved		10
 #define PG_private		11	/* Has something at ->private */
@@ -274,10 +274,6 @@ #else
 #define PageHighMem(page)	0 /* needed to optimize away at compile time */
 #endif
 
-#define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
-#define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
-#define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
-
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
@@ -376,4 +372,13 @@ static inline void set_page_writeback(st
 	test_set_page_writeback(page);
 }
 
+/*
+ * Filesystem-specific page bit testing
+ */
+#define PageFsMisc(page)		test_bit(PG_fs_misc, &(page)->flags)
+#define SetPageFsMisc(page)		set_bit(PG_fs_misc, &(page)->flags)
+#define TestSetPageFsMisc(page)		test_and_set_bit(PG_fs_misc, &(page)->flags)
+#define ClearPageFsMisc(page)		clear_bit(PG_fs_misc, &(page)->flags)
+#define TestClearPageFsMisc(page)	test_and_clear_bit(PG_fs_misc, &(page)->flags)
+
 #endif	/* PAGE_FLAGS_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7a1af57..049382d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -208,6 +208,17 @@ static inline void wait_on_page_writebac
 extern void end_page_writeback(struct page *page);
 
 /*
+ * Wait for filesystem-specific page synchronisation to complete
+ */
+static inline void wait_on_page_fs_misc(struct page *page)
+{
+	if (PageFsMisc(page))
+		wait_on_page_bit(page, PG_fs_misc);
+}
+
+extern void fastcall end_page_fs_misc(struct page *page);
+
+/*
  * Fault a userspace page into pagetables.  Return non-zero on a fault.
  *
  * This assumes that two userspace pages are always sufficient.  That's
diff --git a/mm/filemap.c b/mm/filemap.c
index fd57442..02c4925 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -545,6 +545,23 @@ void fastcall __lock_page(struct page *p
 EXPORT_SYMBOL(__lock_page);
 
 /*
+ * Note completion of filesystem specific page synchronisation
+ *
+ * This is used to allow a page to be written to a filesystem cache in the
+ * background without holding up the completion of readpage
+ */
+void fastcall end_page_fs_misc(struct page *page)
+{
+	smp_mb__before_clear_bit();
+	if (!TestClearPageFsMisc(page))
+		BUG();
+	smp_mb__after_clear_bit();
+	__wake_up_bit(page_waitqueue(page), &page->flags, PG_fs_misc);
+}
+
+EXPORT_SYMBOL(end_page_fs_misc);
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */
diff --git a/mm/migrate.c b/mm/migrate.c
index 1c25040..bb3f22f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -272,8 +272,8 @@ void migrate_page_copy(struct page *newp
 		SetPageUptodate(newpage);
 	if (PageActive(page))
 		SetPageActive(newpage);
-	if (PageChecked(page))
-		SetPageChecked(newpage);
+	if (PageFsMisc(page))
+		SetPageFsMisc(newpage);
 	if (PageMappedToDisk(page))
 		SetPageMappedToDisk(newpage);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ea77c99..b40e04a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -544,7 +544,7 @@ static int prep_new_page(struct page *pa
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_checked | 1 << PG_mappedtodisk);
+			1 << PG_fs_misc | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
 	set_page_refcounted(page);
 	kernel_map_pages(page, 1 << order, 1);

