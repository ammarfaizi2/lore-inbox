Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVLCHMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVLCHMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 02:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVLCHMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 02:12:13 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:64448 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751205AbVLCHMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 02:12:08 -0500
Message-Id: <20051203071815.148667000@localhost.localdomain>
References: <20051203071444.260068000@localhost.localdomain>
Date: Sat, 03 Dec 2005 15:14:53 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 09/16] readahead: read-around method for mmap file
Content-Disposition: inline; filename=readahead-method-around.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the readaround logic outside of filemap_nopage(), and make it a little
more smart and tunable.

The original logic is quite agressive, so relax readahead_hit_rate for mmap
to make the new implementation comparable to the old behavior. It should be
larger than normal files anyway: programs can jump back and forth frequently,
there will be less chance to accumulate a big cache_hit_rate, though the
chance of it coming back to read the missed pages are large.

The pgmajfault was increased on every readahead invocation and other possible
I/O waits. Change it to simply increase on every I/O waits, since readahead
means I/O wait in normal.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 include/linux/fs.h |    1 +
 include/linux/mm.h |    3 +++
 mm/filemap.c       |   42 +++++++-----------------------------------
 mm/readahead.c     |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 35 deletions(-)

--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -1014,6 +1014,9 @@ page_cache_readahead_adaptive(struct add
 			struct page *prev_page, struct page *page,
 			pgoff_t first_index,
 			pgoff_t index, pgoff_t last_index);
+unsigned long
+page_cache_readaround(struct address_space *mapping, struct file_ra_state *ra,
+					struct file *filp, pgoff_t index);
 void fastcall ra_access(struct file_ra_state *ra, struct page *page);
 
 #ifdef CONFIG_DEBUG_FS
--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -1267,8 +1267,9 @@ struct page *filemap_nopage(struct vm_ar
 	struct inode *inode = mapping->host;
 	struct page *page;
 	unsigned long size, pgoff;
-	int did_readaround = 0, majmin = VM_FAULT_MINOR;
+	int majmin = VM_FAULT_MINOR;
 
+	ra->flags |= RA_FLAG_MMAP;
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
@@ -1308,47 +1309,19 @@ retry_find:
 		}
 	}
 	if (!page) {
-		unsigned long ra_pages;
-
 		if (VM_SequentialReadHint(area)) {
 			if (!prefer_adaptive_readahead())
 				handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
-		ra->mmap_miss++;
 
-		/*
-		 * Do we miss much more than hit in this file? If so,
-		 * stop bothering with read-ahead. It will only hurt.
-		 */
-		if (ra->mmap_miss > ra->mmap_hit + MMAP_LOTSAMISS)
-			goto no_cached_page;
+		page_cache_readaround(mapping, ra, file, pgoff);
 
-		/*
-		 * To keep the pgmajfault counter straight, we need to
-		 * check did_readaround, as this is an inner loop.
-		 */
-		if (!did_readaround) {
-			majmin = VM_FAULT_MAJOR;
-			inc_page_state(pgmajfault);
-		}
-		did_readaround = 1;
-		ra_pages = max_sane_readahead(file->f_ra.ra_pages);
-		if (ra_pages) {
-			pgoff_t start = 0;
-
-			if (pgoff > ra_pages / 2)
-				start = pgoff - ra_pages / 2;
-			do_page_cache_readahead(mapping, file, start, ra_pages);
-		}
 		page = find_get_page(mapping, pgoff);
 		if (!page)
 			goto no_cached_page;
 	}
 
-	if (!did_readaround)
-		ra->mmap_hit++;
-
 	ra_access(ra, page);
 	if (READAHEAD_DEBUG_LEVEL(6))
 		printk(KERN_DEBUG "read-mmap(ino=%lu, idx=%lu, hint=%s, io=%s)\n",
@@ -1371,7 +1344,7 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
-	if (prefer_adaptive_readahead())
+	if (prefer_adaptive_readahead() || !VM_SequentialReadHint(area))
 		ra->prev_page = page->index;
 	return page;
 
@@ -1409,10 +1382,9 @@ no_cached_page:
 	return NULL;
 
 page_not_uptodate:
-	if (!did_readaround) {
-		majmin = VM_FAULT_MAJOR;
-		inc_page_state(pgmajfault);
-	}
+	majmin = VM_FAULT_MAJOR;
+	inc_page_state(pgmajfault);
+
 	lock_page(page);
 
 	/* Did it get unhashed while we waited for it? */
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -1517,6 +1517,56 @@ try_context_based_readahead(struct addre
 
 
 /*
+ * Read-around for mmaped file.
+ */
+unsigned long
+page_cache_readaround(struct address_space *mapping, struct file_ra_state *ra,
+					struct file *filp, pgoff_t index)
+{
+	unsigned long ra_index;
+	unsigned long ra_size = 0;
+	unsigned long hit_rate = 8 + readahead_hit_rate;
+
+	if (ra->cache_hit * readahead_hit_rate > ra->age)
+		ra_size = ra->ra_pages;
+	else if (ra->cache_hit * hit_rate >= ra->age)
+		ra_size = ra->ra_pages / 4;
+	else if ((unsigned)(ra->prev_page - index) <= hit_rate)
+		ra_size = 4 * (ra->prev_page - index);
+	else if ((unsigned)(index - ra->prev_page) <= hit_rate)
+		ra_size = 4 * (index - ra->prev_page);
+	else {
+		read_lock_irq(&mapping->tree_lock);
+		if (radix_tree_lookup_node(&mapping->page_tree, index, 1))
+			ra_size = RADIX_TREE_MAP_SIZE;
+		read_unlock_irq(&mapping->tree_lock);
+	}
+
+	if (!ra_size)
+		return 0;
+
+	ra_size = max_sane_readahead(ra_size);
+
+	if (index > ra_size / 2) {
+		ra_index = index - ra_size / 2;
+		if (!(ra_size & RADIX_TREE_MAP_MASK))
+			ra_index = (ra_index + RADIX_TREE_MAP_SIZE / 2) &
+							~RADIX_TREE_MAP_MASK;
+	} else
+		ra_index = 0;
+
+	set_ra_class(ra, RA_CLASS_AROUND);
+	ra->cache_hit = 0;
+	ra->ra_index = ra_index;
+	ra->la_index = ra_index;
+	ra->readahead_index = ra_index + ra_size;
+	ra->lookahead_index = ra_index + ra_size;
+
+	ra->age = ra_dispatch(ra, mapping, filp);
+	return ra->age;
+}
+
+/*
  * ra_size is mainly determined by:
  * 1. sequential-start: min(MIN_RA_PAGES + (pages>>14), KB(128))
  * 2. sequential-max:	min(ra->ra_pages, 0xFFFF)
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -622,6 +622,7 @@ struct file_ra_state {
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
+#define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
 
 struct file {
 	/*

--
