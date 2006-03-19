Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWCSCfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWCSCfC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWCSCe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:56 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:53954 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751310AbWCSCen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:43 -0500
Message-Id: <20060319023500.087249000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:36 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 23/23] readahead: debug traces showing read patterns
Content-Disposition: inline; filename=readahead-debug-traces-access-pattern.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print all relavant read requests to help discover the access pattern.

If you are experiencing performance problems, or want to help improve
the read-ahead logic, please send me the trace data. Thanks.

- Preparations

# Compile kernel with option CONFIG_DEBUG_READAHEAD
mkdir /debug
mount -t debug none /debug

- For each session with distinct access pattern

echo > /debug/readahead # reset the counters
# echo > /var/log/kern.log # you may want to backup it first
echo 8 > /debug/readahead/debug_level # show verbose printk traces
# do one benchmark/task
echo 0 > /debug/readahead/debug_level # revert to normal value
cp /debug/readahead/events readahead-events-`date +'%F_%R'`
bzip2 -c /var/log/kern.log > kern.log-`date +'%F_%R'`.bz2

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/filemap.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc6-mm2.orig/mm/filemap.c
+++ linux-2.6.16-rc6-mm2/mm/filemap.c
@@ -45,6 +45,12 @@ static ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs);
 
+#ifdef CONFIG_DEBUG_READAHEAD
+extern u32 readahead_debug_level;
+#else
+#define readahead_debug_level 0
+#endif /* CONFIG_DEBUG_READAHEAD */
+
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -815,6 +821,10 @@ void do_generic_mapping_read(struct addr
 	if (!isize)
 		goto out;
 
+	if (readahead_debug_level >= 5)
+		printk(KERN_DEBUG "read-file(ino=%lu, req=%lu+%lu)\n",
+			inode->i_ino, index, last_index - index);
+
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
@@ -867,6 +877,11 @@ find_page:
 		prev_page = page;
 
 		readahead_cache_hit(&ra, page);
+		if (readahead_debug_level >= 7)
+			printk(KERN_DEBUG "read-page(ino=%lu, idx=%lu, io=%s)\n",
+				inode->i_ino, index,
+				PageUptodate(page) ? "hit" : "miss");
+
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -1317,7 +1332,6 @@ retry_all:
 	if (!prefer_adaptive_readahead() && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
-
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -1378,6 +1392,13 @@ retry_find:
 		ra->mmap_hit++;
 
 	readahead_cache_hit(ra, page);
+	if (readahead_debug_level >= 6)
+		printk(KERN_DEBUG "read-mmap(ino=%lu, idx=%lu, hint=%s, io=%s)\n",
+			inode->i_ino, pgoff,
+			VM_RandomReadHint(area) ? "random" :
+			(VM_SequentialReadHint(area) ? "sequential" : "none"),
+			PageUptodate(page) ? "hit" : "miss");
+
 	/*
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.

--
