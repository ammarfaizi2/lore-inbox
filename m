Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966457AbWKOHyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966457AbWKOHyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966559AbWKOHu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:58 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:53710 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966457AbWKOHum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:42 -0500
Message-ID: <363577027.21937@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075030.942942737@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:27 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 20/28] readahead: backward prefetching method
Content-Disposition: inline; filename=readahead-backward-prefetching-method.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Readahead policy for reading backward.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
DESC
readahead: backward prefetching method - add use case comment
EDESC
From: Wu Fengguang <wfg@mail.ustc.edu.cn>

Backward prefetching is vital to structural analysis and some other
scientific applications.  Comment this use case.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -1476,6 +1476,52 @@ initial_readahead(struct address_space *
 }
 
 /*
+ * Backward prefetching.
+ *
+ * No look-ahead and thrashing safety guard: should be unnecessary.
+ *
+ * Important for certain scientific arenas(i.e. structural analysis).
+ */
+static int
+try_backward_prefetching(struct file_ra_state *ra, pgoff_t offset,
+			 unsigned long size, unsigned long ra_max)
+{
+	pgoff_t prev = ra->prev_page;
+
+	/* Reading backward? */
+	if (offset >= prev)
+		return 0;
+
+	/* Close enough? */
+	size += readahead_hit_rate;
+	if (offset + 2 * size <= prev)
+		return 0;
+
+	if (ra_class_new(ra) == RA_CLASS_BACKWARD && ra_has_index(ra, prev)) {
+		prev = ra->la_index;
+		size += 2 * ra_readahead_size(ra);
+	} else
+		size *= 2;
+
+	if (size > ra_max)
+		size = ra_max;
+	if (size > prev)
+		size = prev;
+
+	/* The readahead-request covers the read-request? */
+	if (offset < prev - size)
+		return 0;
+
+	offset = prev - size;
+
+	ra_set_class(ra, RA_CLASS_BACKWARD);
+	ra_set_index(ra, offset, offset);
+	ra_set_size(ra, size, 0);
+
+	return 1;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
