Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWEZLyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWEZLyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWEZLxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:45 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:44250 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932428AbWEZLxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:09 -0400
Message-ID: <348644386.05317@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115311.541535720@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:28 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 22/33] readahead: initial method
Content-Disposition: inline; filename=readahead-method-initial.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aggressive readahead policy for read on start-of-file.

Instead of selecting a conservative readahead size,
it tries to do large readahead in the first place.

However we have to watch on two cases:
	- do not ruin the hit rate for file-head-checkers
	- do not lead to thrashing for memory tight systems

It benefits the many-small-files case:

adaptive readahead: avg 10.3 seconds
====================================
diff -r work/rxvt-unicode-7.7 /tmp/rxvt-unicode-7.7  0.10s user 0.32s system 4% cpu 10.211 total
diff -r work/rxvt-unicode-7.7 /tmp/rxvt-unicode-7.7  0.09s user 0.31s system 3% cpu 10.389 total

stock readahead: avg 12.3 seconds
=================================
diff -r work/rxvt-unicode-7.7 /tmp/rxvt-unicode-7.7  0.12s user 0.30s system 3% cpu 12.274 total
diff -r work/rxvt-unicode-7.7 /tmp/rxvt-unicode-7.7  0.09s user 0.33s system 3% cpu 12.403 total

The rxvt-unicode-7.7 being benchmarked is a dir with many .C/.h/.o files.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1537,6 +1537,43 @@ try_context_based_readahead(struct addre
 }
 
 /*
+ * Read-ahead on start of file.
+ *
+ * We want to be as aggressive as possible, _and_
+ * 	- do not ruin the hit rate for file-head-peekers
+ * 	- do not lead to thrashing for memory tight systems
+ */
+static unsigned long
+initial_readahead(struct address_space *mapping, struct file *filp,
+		struct file_ra_state *ra, unsigned long req_size)
+{
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	unsigned long thrash_pages = bdi->ra_thrash_bytes >> PAGE_CACHE_SHIFT;
+	unsigned long expect_pages = bdi->ra_expect_bytes >> PAGE_CACHE_SHIFT;
+	unsigned long ra_size;
+	unsigned long la_size;
+
+	ra_size = req_size;
+
+	/* be aggressive if the system tends to read more */
+	if (ra_size < expect_pages)
+		ra_size = expect_pages;
+
+	/* no read-ahead thrashing */
+	if (ra_size > thrash_pages)
+		ra_size = thrash_pages;
+
+	/* do look-ahead on large(>= 32KB) read-ahead */
+	la_size = ra_size / LOOKAHEAD_RATIO;
+
+	ra_set_class(ra, RA_CLASS_INITIAL);
+	ra_set_index(ra, 0, 0);
+	ra_set_size(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
