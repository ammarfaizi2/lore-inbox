Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262717AbSJHCdS>; Mon, 7 Oct 2002 22:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbSJHCdS>; Mon, 7 Oct 2002 22:33:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49420
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262717AbSJHCdN>; Mon, 7 Oct 2002 22:33:13 -0400
Subject: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, riel@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 22:38:55 -0400
Message-Id: <1034044736.29463.318.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch implements an O_STREAMING file I/O flag which enables
manual drop-behind of pages.

If the file has O_STREAMING set then the user has explicitly said "this
is streaming data, I know I will not revisit this, do not cache
anything".  So we drop pages from the pagecache before our current
index.  We have to fiddle a bit to get writes working since we do
write-behind but the logic is there and it works.

Some numbers.  A simple streaming read to verify the pagecache effects:

        Streaming 1GB Read (avg of many runs, mem=2GB):
        O_STREAMING     Wall time       Change in Page Cache
        Yes             25.58s          0
        No              25.55s          +835MB

Another read with much more VM pressure:

        Streaming 1GB Read (avg of many runs, mem=8M)
        O_STREAMING     Wall time       Change in Page Cache
        Yes             25.76s          0
        No              29.01s          +1MB

And now the kicker:

	Kernel compile (make -j2) and concurrent streaming I/O
        (avg of two runs, mem=128M):
        O_STREAMING     Time to complete Kernel Compile
        Yes             3m27.863s
        No              4m15.818s

This is c/o Andrew Morton.

Patch is against 2.4.20-pre9.  Why not 2.5?  Because Andrew says we can
do better, perhaps with a real drop-behind heuristic.  As 20 Oct looms
quite close, we shall see.

	Robert Love

Implement O_STREAMING for streaming I/O for manual drop-behind of pages.

 include/asm-arm/fcntl.h  |    1
 include/asm-i386/fcntl.h |    1
 include/asm-mips/fcntl.h |    1
 include/asm-ppc/fcntl.h  |    1
 include/asm-sh/fcntl.h   |    1
 mm/filemap.c             |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+)

diff -urN linux-2.4.20-pre9/include/asm-arm/fcntl.h linux/include/asm-arm/fcntl.h
--- linux-2.4.20-pre9/include/asm-arm/fcntl.h	2002-10-06 14:57:26.000000000 -0400
+++ linux/include/asm-arm/fcntl.h	2002-10-07 18:45:51.000000000 -0400
@@ -20,6 +20,7 @@
 #define O_NOFOLLOW	0100000	/* don't follow links */
 #define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
 #define O_LARGEFILE	0400000
+#define O_STREAMING    04000000	/* streaming access */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN linux-2.4.20-pre9/include/asm-i386/fcntl.h linux/include/asm-i386/fcntl.h
--- linux-2.4.20-pre9/include/asm-i386/fcntl.h	2002-10-06 14:57:21.000000000 -0400
+++ linux/include/asm-i386/fcntl.h	2002-10-07 18:45:51.000000000 -0400
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_STREAMING    04000000	/* streaming access */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN linux-2.4.20-pre9/include/asm-mips/fcntl.h linux/include/asm-mips/fcntl.h
--- linux-2.4.20-pre9/include/asm-mips/fcntl.h	2002-10-06 14:57:21.000000000 -0400
+++ linux/include/asm-mips/fcntl.h	2002-10-07 18:45:51.000000000 -0400
@@ -26,6 +26,7 @@
 #define O_DIRECT	0x8000	/* direct disk access hint */
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
+#define O_STREAMING    0x400000	/* streaming access */
 
 #define O_NDELAY	O_NONBLOCK
 
diff -urN linux-2.4.20-pre9/include/asm-ppc/fcntl.h linux/include/asm-ppc/fcntl.h
--- linux-2.4.20-pre9/include/asm-ppc/fcntl.h	2002-10-06 14:57:22.000000000 -0400
+++ linux/include/asm-ppc/fcntl.h	2002-10-07 18:45:51.000000000 -0400
@@ -23,6 +23,7 @@
 #define O_NOFOLLOW      0100000	/* don't follow links */
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
+#define O_STREAMING    04000000	/* streaming access */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN linux-2.4.20-pre9/include/asm-sh/fcntl.h linux/include/asm-sh/fcntl.h
--- linux-2.4.20-pre9/include/asm-sh/fcntl.h	2002-10-06 14:57:27.000000000 -0400
+++ linux/include/asm-sh/fcntl.h	2002-10-07 18:45:51.000000000 -0400
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_STREAMING    04000000	/* streaming access */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN linux-2.4.20-pre9/mm/filemap.c linux/mm/filemap.c
--- linux-2.4.20-pre9/mm/filemap.c	2002-10-06 14:57:20.000000000 -0400
+++ linux/mm/filemap.c	2002-10-07 18:45:51.000000000 -0400
@@ -1322,6 +1322,90 @@
 		SetPageReferenced(page);
 }
 
+/**
+ * shrink_list - non-blockingly drop pages from the given cache list
+ * @mapping: the mapping from which we want to drop pages
+ * @list: which list (e.g. locked, dirty, clean)?
+ * @max_index: greatest index from which we will drop pages
+ */
+static unsigned long shrink_list(struct address_space *mapping,
+				 struct list_head *list,
+				 unsigned long max_index)
+{
+	struct list_head *curr = list->prev;
+	unsigned long nr_shrunk = 0;
+
+	spin_lock(&pagemap_lru_lock);
+	spin_lock(&pagecache_lock);
+
+	while ((curr != list)) {
+		struct page *page = list_entry(curr, struct page, list);
+
+		curr = curr->prev;
+
+		if (page->index > max_index)
+			continue;
+
+		if (PageDirty(page))
+			continue;
+
+		if (TryLockPage(page))
+			break;
+
+		if (page->buffers && !try_to_release_page(page, 0)) {
+			/* probably dirty buffers */
+			unlock_page(page);
+			break;
+		}
+
+		if (page_count(page) != 1) {
+			unlock_page(page);
+			continue;
+		}
+
+		__lru_cache_del(page);
+		__remove_inode_page(page);
+		unlock_page(page);
+		page_cache_release(page);
+		nr_shrunk++;
+	}
+
+	spin_unlock(&pagecache_lock);
+	spin_unlock(&pagemap_lru_lock);
+
+	return nr_shrunk;
+}
+
+/**
+ * shrink_pagecache - nonblockingly drop pages from the mapping.
+ * @file: the file we are doing I/O on
+ * @max_index: the maximum index from which we are willing to drop pages
+ * 
+ * This is for O_STREAMING, which says "I am streaming data, I know I will not
+ * revisit this; do not cache anything".
+ * 
+ * max_index allows us to only drop pages which are behind `index', to avoid
+ * trashing readahead.
+ */
+static unsigned long shrink_pagecache(struct file *file,
+				      unsigned long max_index)
+{
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	unsigned long nr_locked, nr_clean, nr_dirty;
+
+	/*
+	 * ensure we have a decent amount of work todo
+	 */
+	if (mapping->nrpages < 256)
+		return 0;
+
+	nr_locked = shrink_list(mapping, &mapping->locked_pages, max_index);
+	nr_clean = shrink_list(mapping, &mapping->clean_pages, max_index);
+	nr_dirty = shrink_list(mapping, &mapping->dirty_pages, max_index);
+
+	return nr_locked + nr_clean + nr_dirty;
+}
+
 /*
  * This is a generic file read routine, and uses the
  * inode->i_op->readpage() function for the actual low-level
@@ -1538,6 +1622,8 @@
 	filp->f_reada = 1;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (filp->f_flags & O_STREAMING)
+		shrink_pagecache(filp, index);
 	UPDATE_ATIME(inode);
 }
 
@@ -3047,6 +3133,9 @@
 	if (file->f_flags & O_DIRECT)
 		goto o_direct;
 
+	if (file->f_flags & O_STREAMING)
+		shrink_pagecache(file, pos >> PAGE_CACHE_SHIFT);
+
 	do {
 		unsigned long index, offset;
 		long page_fault;

