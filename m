Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVHJWMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVHJWMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVHJWMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:12:41 -0400
Received: from smtp.istop.com ([66.11.167.126]:33457 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932424AbVHJWMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:12:40 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] Rename PageChecked as PageMiscFS
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>, David Howells <dhowells@redhat.com>
References: <42F57FCA.9040805@yahoo.com.au> <200508090724.30962.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org>
In-Reply-To: <20050808145430.15394c3c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 11 Aug 2005 08:12:59 +1000
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508110812.59986.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This filesystem-specific flag needs to be prevented from escaping into other
subsystems that might interact, such as VM.  The current usage is mainly
for directories, except for Reiser4, which uses it for journalling, and NFS,
which presses it into service in a network cache coherency role.

Also resolves the collision between two different names for the same flag bit.

Signed-off-by: Daniel Phillips <phillips@istop.com>

diff -up --recursive 2.6.13-rc5-mm1.clean/fs/afs/dir.c 2.6.13-rc5-mm1/fs/afs/dir.c
--- 2.6.13-rc5-mm1.clean/fs/afs/dir.c	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/afs/dir.c	2005-08-09 18:59:49.000000000 -0400
@@ -155,11 +155,11 @@ static inline void afs_dir_check_page(st
 		}
 	}
 
-	SetPageChecked(page);
+	SetPageMiscFS(page);
 	return;
 
  error:
-	SetPageChecked(page);
+	SetPageMiscFS(page);
 	SetPageError(page);
 
 } /* end afs_dir_check_page() */
@@ -193,7 +193,7 @@ static struct page *afs_dir_get_page(str
 		kmap(page);
 		if (!PageUptodate(page))
 			goto fail;
-		if (!PageChecked(page))
+		if (!PageMiscFS(page))
 			afs_dir_check_page(dir, page);
 		if (PageError(page))
 			goto fail;
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/ext2/dir.c 2.6.13-rc5-mm1/fs/ext2/dir.c
--- 2.6.13-rc5-mm1.clean/fs/ext2/dir.c	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/ext2/dir.c	2005-08-09 18:59:51.000000000 -0400
@@ -112,7 +112,7 @@ static void ext2_check_page(struct page 
 	if (offs != limit)
 		goto Eend;
 out:
-	SetPageChecked(page);
+	SetPageMiscFS(page);
 	return;
 
 	/* Too bad, we had an error */
@@ -152,7 +152,7 @@ Eend:
 		dir->i_ino, (page->index<<PAGE_CACHE_SHIFT)+offs,
 		(unsigned long) le32_to_cpu(p->inode));
 fail:
-	SetPageChecked(page);
+	SetPageMiscFS(page);
 	SetPageError(page);
 }
 
@@ -166,7 +166,7 @@ static struct page * ext2_get_page(struc
 		kmap(page);
 		if (!PageUptodate(page))
 			goto fail;
-		if (!PageChecked(page))
+		if (!PageMiscFS(page))
 			ext2_check_page(page);
 		if (PageError(page))
 			goto fail;
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/ext3/inode.c 2.6.13-rc5-mm1/fs/ext3/inode.c
--- 2.6.13-rc5-mm1.clean/fs/ext3/inode.c	2005-08-09 18:23:30.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/ext3/inode.c	2005-08-09 18:59:53.000000000 -0400
@@ -1369,12 +1369,12 @@ static int ext3_journalled_writepage(str
 		goto no_write;
 	}
 
-	if (!page_has_buffers(page) || PageChecked(page)) {
+	if (!page_has_buffers(page) || PageMiscFS(page)) {
 		/*
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
 		 */
-		ClearPageChecked(page);
+		ClearPageMiscFS(page);
 		ret = block_prepare_write(page, 0, PAGE_CACHE_SIZE,
 					ext3_get_block);
 		if (ret != 0)
@@ -1429,7 +1429,7 @@ static int ext3_invalidatepage(struct pa
 	 * If it's a full truncate we just forget about the pending dirtying
 	 */
 	if (offset == 0)
-		ClearPageChecked(page);
+		ClearPageMiscFS(page);
 
 	return journal_invalidatepage(journal, page, offset);
 }
@@ -1438,7 +1438,7 @@ static int ext3_releasepage(struct page 
 {
 	journal_t *journal = EXT3_JOURNAL(page->mapping->host);
 
-	WARN_ON(PageChecked(page));
+	WARN_ON(PageMiscFS(page));
 	if (!page_has_buffers(page))
 		return 0;
 	return journal_try_to_free_buffers(journal, page, wait);
@@ -1535,7 +1535,7 @@ out:
  */
 static int ext3_journalled_set_page_dirty(struct page *page)
 {
-	SetPageChecked(page);
+	SetPageMiscFS(page);
 	return __set_page_dirty_nobuffers(page);
 }
 
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/freevxfs/vxfs_subr.c 2.6.13-rc5-mm1/fs/freevxfs/vxfs_subr.c
--- 2.6.13-rc5-mm1.clean/fs/freevxfs/vxfs_subr.c	2005-08-09 18:23:11.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/freevxfs/vxfs_subr.c	2005-08-09 18:59:54.000000000 -0400
@@ -79,7 +79,7 @@ vxfs_get_page(struct address_space *mapp
 		kmap(pp);
 		if (!PageUptodate(pp))
 			goto fail;
-		/** if (!PageChecked(pp)) **/
+		/** if (!PageMiscFS(pp)) **/
 			/** vxfs_check_page(pp); **/
 		if (PageError(pp))
 			goto fail;
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/reiser4/page_cache.c 2.6.13-rc5-mm1/fs/reiser4/page_cache.c
--- 2.6.13-rc5-mm1.clean/fs/reiser4/page_cache.c	2005-08-09 18:23:30.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/reiser4/page_cache.c	2005-08-09 18:59:58.000000000 -0400
@@ -754,7 +754,7 @@ print_page(const char *prefix, struct pa
 	       page_flag_name(page, PG_lru),
 	       page_flag_name(page, PG_slab),
 
-	       page_flag_name(page, PG_checked),
+	       page_flag_name(page, PG_miscfs),
 	       page_flag_name(page, PG_reserved),
 	       page_flag_name(page, PG_private), page_flag_name(page, PG_writeback), page_flag_name(page, PG_nosave));
 	if (jprivate(page) != NULL) {
diff -up --recursive 2.6.13-rc5-mm1.clean/fs/reiserfs/inode.c 2.6.13-rc5-mm1/fs/reiserfs/inode.c
--- 2.6.13-rc5-mm1.clean/fs/reiserfs/inode.c	2005-08-09 18:23:31.000000000 -0400
+++ 2.6.13-rc5-mm1/fs/reiserfs/inode.c	2005-08-09 19:00:02.000000000 -0400
@@ -2347,7 +2347,7 @@ static int reiserfs_write_full_page(stru
 	struct buffer_head *head, *bh;
 	int partial = 0;
 	int nr = 0;
-	int checked = PageChecked(page);
+	int checked = PageMiscFS(page);
 	struct reiserfs_transaction_handle th;
 	struct super_block *s = inode->i_sb;
 	int bh_per_page = PAGE_CACHE_SIZE / s->s_blocksize;
@@ -2409,7 +2409,7 @@ static int reiserfs_write_full_page(stru
 	 * blocks we're going to log
 	 */
 	if (checked) {
-		ClearPageChecked(page);
+		ClearPageMiscFS(page);
 		reiserfs_write_lock(s);
 		error = journal_begin(&th, s, bh_per_page + 1);
 		if (error) {
@@ -2790,7 +2790,7 @@ static int reiserfs_invalidatepage(struc
 	BUG_ON(!PageLocked(page));
 
 	if (offset == 0)
-		ClearPageChecked(page);
+		ClearPageMiscFS(page);
 
 	if (!page_has_buffers(page))
 		goto out;
@@ -2829,7 +2829,7 @@ static int reiserfs_set_page_dirty(struc
 {
 	struct inode *inode = page->mapping->host;
 	if (reiserfs_file_data_log(inode)) {
-		SetPageChecked(page);
+		SetPageMiscFS(page);
 		return __set_page_dirty_nobuffers(page);
 	}
 	return __set_page_dirty_buffers(page);
@@ -2852,7 +2852,7 @@ static int reiserfs_releasepage(struct p
 	struct buffer_head *bh;
 	int ret = 1;
 
-	WARN_ON(PageChecked(page));
+	WARN_ON(PageMiscFS(page));
 	spin_lock(&j->j_dirty_buffers_lock);
 	head = page_buffers(page);
 	bh = head;
diff -up --recursive 2.6.13-rc5-mm1.clean/include/linux/page-flags.h 2.6.13-rc5-mm1/include/linux/page-flags.h
--- 2.6.13-rc5-mm1.clean/include/linux/page-flags.h	2005-08-09 18:23:31.000000000 -0400
+++ 2.6.13-rc5-mm1/include/linux/page-flags.h	2005-08-10 17:41:32.000000000 -0400
@@ -61,8 +61,7 @@
 #define PG_active		 6
 #define PG_slab			 7	/* slab debug (Suparna wants this) */
 
-#define PG_checked		 8	/* kill me in 2.5.<early>. */
-#define PG_fs_misc		 8
+#define PG_fs_misc		 8	/* don't let me spread */
 #define PG_arch_1		 9
 #define PG_reserved		10
 #define PG_private		11	/* Has something at ->private */
@@ -227,9 +226,11 @@ extern void __mod_page_state(unsigned lo
 #define PageHighMem(page)	0 /* needed to optimize away at compile time */
 #endif
 
-#define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
-#define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
-#define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
+#define PageMiscFS(page)	test_bit(PG_fs_misc, &(page)->flags)
+#define SetPageMiscFS(page)	set_bit(PG_fs_misc, &(page)->flags)
+#define ClearPageMiscFS(page)	clear_bit(PG_fs_misc, &(page)->flags)
+#define TestSetPageMiscFS(page)		test_and_set_bit(PG_fs_misc, &(page)->flags)
+#define TestClearPageMiscFS(page)	test_and_clear_bit(PG_fs_misc, &(page)->flags)
 
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
@@ -313,7 +314,7 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
-struct page;	/* forward declaration */
+struct page; /* What am I doing in this file? */
 
 int test_clear_page_dirty(struct page *page);
 int test_clear_page_writeback(struct page *page);
@@ -329,13 +330,4 @@ static inline void set_page_writeback(st
 	test_set_page_writeback(page);
 }
 
-/*
- * Filesystem-specific page bit testing
- */
-#define PageFsMisc(page)		test_bit(PG_fs_misc, &(page)->flags)
-#define SetPageFsMisc(page)		set_bit(PG_fs_misc, &(page)->flags)
-#define TestSetPageFsMisc(page)		test_and_set_bit(PG_fs_misc, &(page)->flags)
-#define ClearPageFsMisc(page)		clear_bit(PG_fs_misc, &(page)->flags)
-#define TestClearPageFsMisc(page)	test_and_clear_bit(PG_fs_misc, &(page)->flags)
-
 #endif	/* PAGE_FLAGS_H */
diff -up --recursive 2.6.13-rc5-mm1.clean/include/linux/pagemap.h 2.6.13-rc5-mm1/include/linux/pagemap.h
--- 2.6.13-rc5-mm1.clean/include/linux/pagemap.h	2005-08-09 18:23:31.000000000 -0400
+++ 2.6.13-rc5-mm1/include/linux/pagemap.h	2005-08-10 17:18:18.000000000 -0400
@@ -204,7 +204,7 @@ extern void end_page_writeback(struct pa
  */
 static inline void wait_on_page_fs_misc(struct page *page)
 {
-	if (PageFsMisc(page))
+	if (PageMiscFS(page))
 		wait_on_page_bit(page, PG_fs_misc);
 }
 
diff -up --recursive 2.6.13-rc5-mm1.clean/mm/filemap.c 2.6.13-rc5-mm1/mm/filemap.c
--- 2.6.13-rc5-mm1.clean/mm/filemap.c	2005-08-09 18:23:31.000000000 -0400
+++ 2.6.13-rc5-mm1/mm/filemap.c	2005-08-10 17:15:45.000000000 -0400
@@ -509,7 +509,7 @@ EXPORT_SYMBOL(__lock_page);
 void fastcall end_page_fs_misc(struct page *page)
 {
 	smp_mb__before_clear_bit();
-	if (!TestClearPageFsMisc(page))
+	if (!TestClearPageMiscFS(page))
 		BUG();
 	smp_mb__after_clear_bit();
 	__wake_up_bit(page_waitqueue(page), &page->flags, PG_fs_misc);
diff -up --recursive 2.6.13-rc5-mm1.clean/mm/page_alloc.c 2.6.13-rc5-mm1/mm/page_alloc.c
--- 2.6.13-rc5-mm1.clean/mm/page_alloc.c	2005-08-09 18:23:31.000000000 -0400
+++ 2.6.13-rc5-mm1/mm/page_alloc.c	2005-08-10 17:19:30.000000000 -0400
@@ -458,7 +458,7 @@ static void prep_new_page(struct page *p
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_checked | 1 << PG_mappedtodisk);
+			1 << PG_fs_misc | 1 << PG_mappedtodisk);
 	page->private = 0;
 	set_page_refs(page, order);
 	kernel_map_pages(page, 1 << order, 1);
