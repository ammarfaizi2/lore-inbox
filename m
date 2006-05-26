Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWEZLyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEZLyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWEZLxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:44 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:49882 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932440AbWEZLxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:09 -0400
Message-ID: <348644387.06434@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115312.145248016@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:29 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 23/33] readahead: backward prefetching method
Content-Disposition: inline; filename=readahead-method-backward.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Readahead policy for reading backward.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1574,6 +1574,46 @@ initial_readahead(struct address_space *
 }
 
 /*
+ * Backward prefetching.
+ *
+ * No look-ahead and thrashing safety guard: should be unnecessary.
+ */
+static int
+try_read_backward(struct file_ra_state *ra, pgoff_t begin_index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	pgoff_t end_index;
+
+	/* Are we reading backward? */
+	if (begin_index > ra->prev_page)
+		return 0;
+
+	if ((ra->flags & RA_CLASS_MASK) == RA_CLASS_BACKWARD &&
+					ra_has_index(ra, ra->prev_page)) {
+		ra_size += 2 * ra_cache_hit(ra, 0);
+		end_index = ra->la_index;
+	} else {
+		ra_size += ra_size + ra_size * (readahead_hit_rate - 1) / 2;
+		end_index = ra->prev_page;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	/* Read traces close enough to be covered by the prefetching? */
+	if (end_index > begin_index + ra_size)
+		return 0;
+
+	begin_index = end_index - ra_size;
+
+	ra_set_class(ra, RA_CLASS_BACKWARD);
+	ra_set_index(ra, begin_index, begin_index);
+	ra_set_size(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
