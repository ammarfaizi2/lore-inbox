Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSESTb7>; Sun, 19 May 2002 15:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314906AbSESTb7>; Sun, 19 May 2002 15:31:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34323 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314885AbSESTb6>;
	Sun, 19 May 2002 15:31:58 -0400
Message-ID: <3CE7FE84.8205F047@zip.com.au>
Date: Sun, 19 May 2002 12:35:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/15] reduce lock contention in do_pagecache_readahead
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Blanchard has a workload (the SDET benchmark) which is showing some
moderate lock contention in do_pagecache_readahead().

Seems that SDET has many threads performing seeky reads against a
cached file.  The average number of pagecache probes in a single
do_pagecache_readahead() is six, which seems reasonable.

The patch (from Anton) flips the locking around to optimise for the
fast case (page was present).  So the kernel takes the lock less often,
and does more work once it has been acquired.


=====================================

--- 2.5.16/mm/readahead.c~anton-readahead-locking	Sun May 19 11:49:45 2002
+++ 2.5.16-akpm/mm/readahead.c	Sun May 19 12:02:58 2002
@@ -117,25 +117,27 @@ void do_page_cache_readahead(struct file
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
+	read_lock(&mapping->page_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
 		
 		if (page_offset > end_index)
 			break;
 
-		read_lock(&mapping->page_lock);
 		page = radix_tree_lookup(&mapping->page_tree, page_offset);
-		read_unlock(&mapping->page_lock);
 		if (page)
 			continue;
 
+		read_unlock(&mapping->page_lock);
 		page = page_cache_alloc(mapping);
+		read_lock(&mapping->page_lock);
 		if (!page)
 			break;
 		page->index = page_offset;
 		list_add(&page->list, &page_pool);
 		nr_to_really_read++;
 	}
+	read_unlock(&mapping->page_lock);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the page is not


-
