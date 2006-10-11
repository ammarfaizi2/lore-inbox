Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWJKGSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWJKGSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbWJKGSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:18:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030660AbWJKGSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:18:05 -0400
Date: Tue, 10 Oct 2006 23:17:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 3/6] generic_file_buffered_write() cleanup
Message-Id: <20061010231759.dee9e88d.akpm@osdl.org>
In-Reply-To: <20061010231243.bc8b834c.akpm@osdl.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	<20061010121332.19693.37204.sendpatchset@linux.site>
	<20061010221304.6bef249f.akpm@osdl.org>
	<452C8613.7080708@yahoo.com.au>
	<20061010231150.fb9e30f5.akpm@osdl.org>
	<20061010231243.bc8b834c.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff -puN mm/filemap.c~generic_file_buffered_write-cleanup mm/filemap.c
--- a/mm/filemap.c~generic_file_buffered_write-cleanup
+++ a/mm/filemap.c
@@ -2064,16 +2064,15 @@ generic_file_buffered_write(struct kiocb
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
@@ -2084,31 +2083,33 @@ generic_file_buffered_write(struct kiocb
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
@@ -2139,7 +2140,7 @@ generic_file_buffered_write(struct kiocb
 							buf, bytes);
 		else
 			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_base, bytes);
+						cur_iov, iov_offset, bytes);
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (status == AOP_TRUNCATED_PAGE) {
@@ -2157,12 +2158,12 @@ generic_file_buffered_write(struct kiocb
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
_

