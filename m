Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWJMQoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWJMQoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWJMQoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:44:30 -0400
Received: from mail.suse.de ([195.135.220.2]:7642 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751338AbWJMQo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:44:27 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Message-Id: <20061013143546.15438.42943.sendpatchset@linux.site>
In-Reply-To: <20061013143516.15438.8802.sendpatchset@linux.site>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
Subject: [patch 3/6] mm: generic_file_buffered_write cleanup
Date: Fri, 13 Oct 2006 18:44:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1855,16 +1855,15 @@ generic_file_buffered_write(struct kiocb
 		size_t count, ssize_t written)
 {
 	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
+	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	struct inode 	*inode = mapping->host;
 	long		status = 0;
 	struct page	*page;
 	struct page	*cached_page = NULL;
-	size_t		bytes;
 	struct pagevec	lru_pvec;
 	const struct iovec *cur_iov = iov; /* current iovec */
-	size_t		iov_base = 0;	   /* offset in the current iovec */
+	size_t		iov_offset = 0;	   /* offset in the current iovec */
 	char __user	*buf;
 
 	pagevec_init(&lru_pvec, 0);
@@ -1875,31 +1874,33 @@ generic_file_buffered_write(struct kiocb
 	if (likely(nr_segs == 1))
 		buf = iov->iov_base + written;
 	else {
-		filemap_set_next_iovec(&cur_iov, &iov_base, written);
-		buf = cur_iov->iov_base + iov_base;
+		filemap_set_next_iovec(&cur_iov, &iov_offset, written);
+		buf = cur_iov->iov_base + iov_offset;
 	}
 
 	do {
-		unsigned long index;
-		unsigned long offset;
-		unsigned long maxlen;
-		size_t copied;
+		pgoff_t index;		/* Pagecache index for current page */
+		unsigned long offset;	/* Offset into pagecache page */
+		unsigned long maxlen;	/* Bytes remaining in current iovec */
+		size_t bytes;		/* Bytes to write to page */
+		size_t copied;		/* Bytes copied from user */
 
-		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
+		offset = (pos & (PAGE_CACHE_SIZE - 1));
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
 		if (bytes > count)
 			bytes = count;
 
+		maxlen = cur_iov->iov_len - iov_offset;
+		if (maxlen > bytes)
+			maxlen = bytes;
+
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		maxlen = cur_iov->iov_len - iov_base;
-		if (maxlen > bytes)
-			maxlen = bytes;
 		fault_in_pages_readable(buf, maxlen);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
@@ -1930,7 +1931,7 @@ generic_file_buffered_write(struct kiocb
 							buf, bytes);
 		else
 			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_base, bytes);
+						cur_iov, iov_offset, bytes);
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (status == AOP_TRUNCATED_PAGE) {
@@ -1948,12 +1949,12 @@ generic_file_buffered_write(struct kiocb
 				buf += status;
 				if (unlikely(nr_segs > 1)) {
 					filemap_set_next_iovec(&cur_iov,
-							&iov_base, status);
+							&iov_offset, status);
 					if (count)
 						buf = cur_iov->iov_base +
-							iov_base;
+							iov_offset;
 				} else {
-					iov_base += status;
+					iov_offset += status;
 				}
 			}
 		}
