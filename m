Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVCBSGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVCBSGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBSGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:06:00 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:61346 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262396AbVCBSDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:03:32 -0500
Message-ID: <42260F30.BE15B4DA@tv-sign.ru>
Date: Wed, 02 Mar 2005 22:08:32 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] readahead: improve sequential read detection
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Current code can't always detect sequential reading, in case
   when read size is not PAGE_CACHE_SIZE aligned.

   If application reads the file by 4096+512 chunks, we have:
   1st read: first read detected, prev_page = 2.
   2nd read: offset == 2, the read is considered random.

   page_cache_readahead() should treat prev_page == offset as
   sequential access. In this case it is better to ++offset,
   because of blockable_page_cache_readahead(offset, size).

2. If application reads 4096 bytes with *ppos == 512, we have to
   read 2 pages, but req_size == 1 in do_generic_mapping_read().

   Usually it's not a problem. But in random read case it results
   in unnecessary page cache misses.

~$ time dd conv=notrunc if=/tmp/GIG of=/tmp/dummy bs=$((4096+512))

2.6.11-clean:	real=370.35 user=0.16 sys=14.66
2.6.11-patched:	real=234.49 user=0.19 sys=12.41

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/mm/readahead.c~	2005-02-27 21:57:43.000000000 +0300
+++ 2.6.11/mm/readahead.c	2005-03-01 23:00:21.000000000 +0300
@@ -443,26 +443,26 @@ page_cache_readahead(struct address_spac
 		     struct file *filp, unsigned long offset,
 		     unsigned long req_size)
 {
-	unsigned long max, newsize = req_size;
-	int sequential = (offset == ra->prev_page + 1);
+	unsigned long max, newsize;
+	int sequential;
 
 	/*
 	 * Here we detect the case where the application is performing
 	 * sub-page sized reads.  We avoid doing extra work and bogusly
 	 * perturbing the readahead window expansion logic.
-	 * If size is zero, there is no read ahead window so we need one
 	 */
-	if (offset == ra->prev_page && req_size == 1)
-		goto out;
+	if (offset == ra->prev_page && --req_size)
+		++offset;
 
+	sequential = (offset == ra->prev_page + 1);
 	ra->prev_page = offset;
+
 	max = get_max_readahead(ra);
 	newsize = min(req_size, max);
 
-	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
-		newsize = 1;
-		goto out;	/* No readahead or file already in cache */
-	}
+	/* No readahead or file already in cache or sub-page sized read */
+	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE))
+		goto out;
 
 	ra->prev_page += newsize - 1;
 
@@ -527,7 +527,7 @@ page_cache_readahead(struct address_spac
 	}
 
 out:
-	return newsize;
+	return ra->prev_page + 1;
 }
 
 /*
--- 2.6.11/mm/filemap.c~	2005-02-25 14:32:52.000000000 +0300
+++ 2.6.11/mm/filemap.c	2005-03-01 22:26:10.000000000 +0300
@@ -691,7 +691,7 @@ void do_generic_mapping_read(struct addr
 	unsigned long index;
 	unsigned long end_index;
 	unsigned long offset;
-	unsigned long req_size;
+	unsigned long last_index;
 	unsigned long next_index;
 	unsigned long prev_index;
 	loff_t isize;
@@ -703,7 +703,7 @@ void do_generic_mapping_read(struct addr
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
-	req_size = (desc->count + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	isize = i_size_read(inode);
@@ -713,7 +713,7 @@ void do_generic_mapping_read(struct addr
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
-		unsigned long ret_size, nr, ret;
+		unsigned long nr, ret;
 
 		/* nr is the maximum number of bytes to copy from this page */
 		nr = PAGE_CACHE_SIZE;
@@ -728,12 +728,9 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index && req_size) {
-			ret_size = page_cache_readahead(mapping, &ra,
-					filp, index, req_size);
-			next_index += ret_size;
-			req_size -= ret_size;
-		}
+		if (index == next_index)
+			next_index = page_cache_readahead(mapping, &ra, filp,
+					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
