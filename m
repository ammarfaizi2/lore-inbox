Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWE0P4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWE0P4W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWE0PwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:16 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:57820 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751603AbWE0Pvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:38 -0400
Message-ID: <348745095.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155136.503037461@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:11 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 22/32] readahead: backward prefetching method
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
@@ -1536,6 +1536,46 @@ initial_readahead(struct address_space *
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
+		ra_size += 2 * ra->hit0;
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
