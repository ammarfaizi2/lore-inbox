Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWE0QAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWE0QAG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWE0Pv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:51:56 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:40413 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751614AbWE0Pvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:44 -0400
Message-ID: <348745101.17278@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155142.715530234@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:21 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 32/32] readahead: debug traces showing read patterns
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

--- linux-2.6.17-rc4-mm3.orig/mm/filemap.c
+++ linux-2.6.17-rc4-mm3/mm/filemap.c
@@ -45,6 +45,12 @@ static ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs);
 
+#ifdef CONFIG_DEBUG_READAHEAD
+extern u32 debug_level;
+#else
+#define debug_level 0
+#endif /* CONFIG_DEBUG_READAHEAD */
+
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -851,6 +857,10 @@ void do_generic_mapping_read(struct addr
 	if (!isize)
 		goto out;
 
+	if (debug_level >= 5)
+		printk(KERN_DEBUG "read-file(ino=%lu, req=%lu+%lu)\n",
+			inode->i_ino, index, last_index - index);
+
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
@@ -905,6 +915,11 @@ find_page:
 		if (prefer_adaptive_readahead())
 			readahead_cache_hit(&ra, page);
 
+		if (debug_level >= 7)
+			printk(KERN_DEBUG "read-page(ino=%lu, idx=%lu, io=%s)\n",
+				inode->i_ino, index,
+				PageUptodate(page) ? "hit" : "miss");
+
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -1356,7 +1371,6 @@ retry_all:
 	if (!prefer_adaptive_readahead() && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
-
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -1419,6 +1433,13 @@ retry_find:
 	if (prefer_adaptive_readahead())
 		readahead_cache_hit(ra, page);
 
+	if (debug_level >= 6)
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
