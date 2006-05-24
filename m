Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWEXL3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWEXL3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWEXLTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:04 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:38016 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932687AbWEXLTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:01 -0400
Message-ID: <348469538.91213@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111859.909928820@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:52 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 06/33] readahead: refactor __do_page_cache_readahead()
Content-Disposition: inline; filename=readahead-refactor-__do_page_cache_readahead.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add look-ahead support to __do_page_cache_readahead(),
which is needed by the adaptive read-ahead logic.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -266,7 +266,8 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			pgoff_t offset, unsigned long nr_to_read)
+			pgoff_t offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
 	struct page *page;
@@ -279,7 +280,7 @@ __do_page_cache_readahead(struct address
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -302,6 +303,8 @@ __do_page_cache_readahead(struct address
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
+		if (page_idx == nr_to_read - lookahead_size)
+			__SetPageReadahead(page);
 		ret++;
 	}
 	read_unlock_irq(&mapping->tree_lock);
@@ -338,7 +341,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -385,7 +388,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -405,7 +408,7 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 
 	return check_ra_success(ra, nr_to_read, actual);
 }
@@ -450,7 +453,7 @@ static int make_ahead_window(struct addr
  * @req_size: hint: total size of the read which the caller is performing in
  *            PAGE_CACHE_SIZE units
  *
- * page_cache_readahead() is the main function.  If performs the adaptive
+ * page_cache_readahead() is the main function.  It performs the adaptive
  * readahead window size management and submits the readahead I/O.
  *
  * Note that @filp is purely used for passing on to the ->readpage[s]()

--
