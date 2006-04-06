Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWDFQOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWDFQOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDFQOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:14:07 -0400
Received: from mail.parknet.jp ([210.171.160.80]:58891 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751257AbWDFQOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:14:06 -0400
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] writeback: fix range handling
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 07 Apr 2006 01:13:56 +0900
Message-ID: <877j62n0l7.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a writeback_control's `start' and `end' fields are used to
indicate a one-byte-range starting at file offset zero, the required
values of .start=0,.end=0 mean that the ->writepages() implementation
has no way of telling that it is being asked to perform a range
request.  Because we're currently overloading (start == 0 && end == 0)
to mean "this is not a write-a-range request".

To make all this sane, the patch changes range of writeback_control.

So caller does: If it is calling ->writepages() to write pages, it
sets range (range_start/end or range_cyclic) always.

And if range_cyclic is true, ->writepages() thinks the range is
cyclic, otherwise it just uses range_start and range_end.

This patch does,

    - Add LLONG_MAX, LLONG_MIN, ULLONG_MAX to include/linux/kernel.h
      -1 is usually ok for range_end (type is long long). But, if someone did,

		range_end += val;		range_end is "val - 1"
		u64val = range_end >> bits;	u64val is "~(0ULL)"

      or something, they are wrong. So, this adds LLONG_MAX to avoid nasty
      things, and uses LLONG_MAX for range_end.

    - All callers of ->writepages() sets range_start/end or range_cyclic.

    - Fix updates of ->writeback_index. It seems already bit strange.
      If it starts at 0 and ended by check of nr_to_write, this last
      index may reduce chance to scan end of file.  So, this updates
      ->writeback_index only if range_cyclic is true or whole-file is
      scanned.

---

 fs/cifs/file.c            |   24 +++++++++++-------------
 fs/fs-writeback.c         |    4 ++++
 fs/mpage.c                |   22 ++++++++++------------
 fs/sync.c                 |    2 +-
 include/linux/kernel.h    |    3 +++
 include/linux/writeback.h |    5 +++--
 mm/filemap.c              |    6 +++---
 mm/page-writeback.c       |    3 +++
 mm/vmscan.c               |    2 ++
 9 files changed, 40 insertions(+), 31 deletions(-)

diff -puN fs/cifs/file.c~wbc-range-cleanup fs/cifs/file.c
--- linux-2.6-akpm/fs/cifs/file.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/fs/cifs/file.c	2006-04-06 04:38:49.000000000 +0900
@@ -1068,9 +1068,9 @@ static int cifs_writepages(struct addres
 	unsigned int bytes_written;
 	struct cifs_sb_info *cifs_sb;
 	int done = 0;
-	pgoff_t end = -1;
+	pgoff_t end;
 	pgoff_t index;
-	int is_range = 0;
+ 	int range_whole = 0;
 	struct kvec iov[32];
 	int len;
 	int n_iov = 0;
@@ -1112,16 +1112,14 @@ static int cifs_writepages(struct addres
 	xid = GetXid();
 
 	pagevec_init(&pvec, 0);
-	if (wbc->sync_mode == WB_SYNC_NONE)
+	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
-	else {
-		index = 0;
-		scanned = 1;
-	}
-	if (wbc->start || wbc->end) {
-		index = wbc->start >> PAGE_CACHE_SHIFT;
-		end = wbc->end >> PAGE_CACHE_SHIFT;
-		is_range = 1;
+		end = -1;
+	} else {
+		index = wbc->range_start >> PAGE_CACHE_SHIFT;
+		end = wbc->range_end >> PAGE_CACHE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			range_whole = 1;
 		scanned = 1;
 	}
 retry:
@@ -1157,7 +1155,7 @@ retry:
 				break;
 			}
 
-			if (unlikely(is_range) && (page->index > end)) {
+			if (!wbc->range_cyclic && page->index > end) {
 				done = 1;
 				unlock_page(page);
 				break;
@@ -1261,7 +1259,7 @@ retry:
 		index = 0;
 		goto retry;
 	}
-	if (!is_range)
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = index;
 
 	FreeXid(xid);
diff -puN fs/fs-writeback.c~wbc-range-cleanup fs/fs-writeback.c
--- linux-2.6-akpm/fs/fs-writeback.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/fs/fs-writeback.c	2006-04-06 04:26:35.000000000 +0900
@@ -469,6 +469,8 @@ void sync_inodes_sb(struct super_block *
 {
 	struct writeback_control wbc = {
 		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
+		.range_start	= 0,
+		.range_end	= LLONG_MAX,
 	};
 	unsigned long nr_dirty = read_page_state(nr_dirty);
 	unsigned long nr_unstable = read_page_state(nr_unstable);
@@ -565,6 +567,8 @@ int write_inode_now(struct inode *inode,
 	struct writeback_control wbc = {
 		.nr_to_write = LONG_MAX,
 		.sync_mode = WB_SYNC_ALL,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
 	};
 
 	if (!mapping_cap_writeback_dirty(inode->i_mapping))
diff -puN fs/mpage.c~wbc-range-cleanup fs/mpage.c
--- linux-2.6-akpm/fs/mpage.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/fs/mpage.c	2006-04-06 04:34:17.000000000 +0900
@@ -707,9 +707,9 @@ mpage_writepages(struct address_space *m
 	struct pagevec pvec;
 	int nr_pages;
 	pgoff_t index;
-	pgoff_t end = -1;		/* Inclusive */
+	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
-	int is_range = 0;
+	int range_whole = 0;
 
 	if (wbc->nonblocking && bdi_write_congested(bdi)) {
 		wbc->encountered_congestion = 1;
@@ -721,16 +721,14 @@ mpage_writepages(struct address_space *m
 		writepage = mapping->a_ops->writepage;
 
 	pagevec_init(&pvec, 0);
-	if (wbc->sync_mode == WB_SYNC_NONE) {
+	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
+		end = -1;
 	} else {
-		index = 0;			  /* whole-file sweep */
-		scanned = 1;
-	}
-	if (wbc->start || wbc->end) {
-		index = wbc->start >> PAGE_CACHE_SHIFT;
-		end = wbc->end >> PAGE_CACHE_SHIFT;
-		is_range = 1;
+		index = wbc->range_start >> PAGE_CACHE_SHIFT;
+		end = wbc->range_end >> PAGE_CACHE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			range_whole = 1;
 		scanned = 1;
 	}
 retry:
@@ -759,7 +757,7 @@ retry:
 				continue;
 			}
 
-			if (unlikely(is_range) && page->index > end) {
+			if (!wbc->range_cyclic && page->index > end) {
 				done = 1;
 				unlock_page(page);
 				continue;
@@ -810,7 +808,7 @@ retry:
 		index = 0;
 		goto retry;
 	}
-	if (!is_range)
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = index;
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
diff -puN fs/sync.c~wbc-range-cleanup fs/sync.c
--- linux-2.6-akpm/fs/sync.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/fs/sync.c	2006-04-06 04:26:35.000000000 +0900
@@ -100,7 +100,7 @@ asmlinkage long sys_sync_file_range(int 
 	}
 
 	if (nbytes == 0)
-		endbyte = -1;
+		endbyte = LLONG_MAX;
 	else
 		endbyte--;		/* inclusive */
 
diff -puN include/linux/kernel.h~wbc-range-cleanup include/linux/kernel.h
--- linux-2.6-akpm/include/linux/kernel.h~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/include/linux/kernel.h	2006-04-06 04:26:35.000000000 +0900
@@ -24,6 +24,9 @@ extern const char linux_banner[];
 #define LONG_MAX	((long)(~0UL>>1))
 #define LONG_MIN	(-LONG_MAX - 1)
 #define ULONG_MAX	(~0UL)
+#define LLONG_MAX	((long long)(~0ULL>>1))
+#define LLONG_MIN	(-LLONG_MAX - 1)
+#define ULLONG_MAX	(~0ULL)
 
 #define STACK_MAGIC	0xdeadbeef
 
diff -puN include/linux/writeback.h~wbc-range-cleanup include/linux/writeback.h
--- linux-2.6-akpm/include/linux/writeback.h~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/include/linux/writeback.h	2006-04-06 04:26:35.000000000 +0900
@@ -50,14 +50,15 @@ struct writeback_control {
 	 * a hint that the filesystem need only write out the pages inside that
 	 * byterange.  The byte at `end' is included in the writeout request.
 	 */
-	loff_t start;
-	loff_t end;
+	loff_t range_start;
+	loff_t range_end;
 
 	unsigned nonblocking:1;		/* Don't get stuck on request queues */
 	unsigned encountered_congestion:1; /* An output: a queue is full */
 	unsigned for_kupdate:1;		/* A kupdate writeback */
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned for_writepages:1;	/* This is a writepages() call */
+	unsigned range_cyclic:1;	/* range_start is cyclic */
 };
 
 /*
diff -puN mm/filemap.c~wbc-range-cleanup mm/filemap.c
--- linux-2.6-akpm/mm/filemap.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/mm/filemap.c	2006-04-06 04:26:35.000000000 +0900
@@ -192,8 +192,8 @@ int __filemap_fdatawrite_range(struct ad
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
-		.start = start,
-		.end = end,
+		.range_start = start,
+		.range_end = end,
 	};
 
 	if (!mapping_cap_writeback_dirty(mapping))
@@ -206,7 +206,7 @@ int __filemap_fdatawrite_range(struct ad
 static inline int __filemap_fdatawrite(struct address_space *mapping,
 	int sync_mode)
 {
-	return __filemap_fdatawrite_range(mapping, 0, 0, sync_mode);
+	return __filemap_fdatawrite_range(mapping, 0, LLONG_MAX, sync_mode);
 }
 
 int filemap_fdatawrite(struct address_space *mapping)
diff -puN mm/page-writeback.c~wbc-range-cleanup mm/page-writeback.c
--- linux-2.6-akpm/mm/page-writeback.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/mm/page-writeback.c	2006-04-06 04:26:35.000000000 +0900
@@ -205,6 +205,7 @@ static void balance_dirty_pages(struct a
 			.sync_mode	= WB_SYNC_NONE,
 			.older_than_this = NULL,
 			.nr_to_write	= write_chunk,
+			.range_cyclic	= 1,
 		};
 
 		get_dirty_limits(&wbs, &background_thresh,
@@ -332,6 +333,7 @@ static void background_writeout(unsigned
 		.older_than_this = NULL,
 		.nr_to_write	= 0,
 		.nonblocking	= 1,
+		.range_cyclic	= 1,
 	};
 
 	for ( ; ; ) {
@@ -408,6 +410,7 @@ static void wb_kupdate(unsigned long arg
 		.nr_to_write	= 0,
 		.nonblocking	= 1,
 		.for_kupdate	= 1,
+		.range_cyclic	= 1,
 	};
 
 	sync_supers();
diff -puN mm/vmscan.c~wbc-range-cleanup mm/vmscan.c
--- linux-2.6-akpm/mm/vmscan.c~wbc-range-cleanup	2006-04-06 04:26:35.000000000 +0900
+++ linux-2.6-akpm-hirofumi/mm/vmscan.c	2006-04-06 04:26:35.000000000 +0900
@@ -337,6 +337,8 @@ pageout_t pageout(struct page *page, str
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_NONE,
 			.nr_to_write = SWAP_CLUSTER_MAX,
+			.range_start = 0,
+			.range_end = LLONG_MAX,
 			.nonblocking = 1,
 			.for_reclaim = 1,
 		};
_
