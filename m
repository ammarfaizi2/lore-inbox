Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVKIOPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVKIOPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVKIOO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:14:57 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:62189 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750827AbVKIOOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:37 -0500
Message-Id: <20051109141521.853427000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:48 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 10/16] readahead: other methods
Content-Disposition: inline; filename=readahead-method-others.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various read-ahead strategies for:
	- fresh read from start of file
	- backward prefetching
	- seek and read one record pattern(db workload)
	- quick recover from thrashing

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+)

--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -1469,6 +1469,117 @@ try_context_based_readahead(struct addre
 	return 1;
 }
 
+/*
+ * Read-ahead on start of file.
+ *
+ * It is most important for small files.
+ * 1. Set a moderate large read-ahead size;
+ * 2. Issue the next read-ahead request as soon as possible.
+ *
+ * But be careful, there are some applications that dip into only the very head
+ * of a file. The most important thing is to prevent them from triggering the
+ * next (much larger) read-ahead request, which leads to lots of cache misses.
+ * Two pages should be enough for them, correct me if I'm wrong.
+ */
+static inline unsigned long
+newfile_readahead(struct address_space *mapping,
+		struct file *filp, struct file_ra_state *ra,
+		unsigned long req_size, unsigned long ra_min)
+{
+	unsigned long ra_size;
+	unsigned long la_size;
+
+	if (req_size > ra_min)
+		req_size = ra_min;
+
+	ra_size = 4 * req_size;
+	la_size = 2 * req_size;
+
+	set_ra_class(ra, RA_CLASS_NEWFILE);
+	ra_state_init(ra, 0, 0);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * Backward prefetching.
+ * No look ahead and thrashing threshold estimation for stepping backward
+ * pattern: should be unnecessary.
+ */
+static inline int
+try_read_backward(struct file_ra_state *ra,
+			pgoff_t begin_index, pgoff_t end_index,
+			unsigned long ra_size,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	if (ra_size > ra_max || end_index > ra->prev_page)
+		return 0;
+
+	if (ra_has_index(ra, ra->prev_page)) {
+		if (end_index > ra->la_index)
+			return 0;
+		ra_size += 2 * ra_cache_hit(ra, 0);
+		end_index = ra->la_index;
+	} else {
+		ra_size += readahead_hit_rate + ra_min;
+		end_index = ra->prev_page;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	if (end_index > begin_index + ra_size)
+		return 0;
+
+	begin_index = end_index - ra_size;
+
+	set_ra_class(ra, RA_CLASS_BACKWARD);
+	ra_state_init(ra, begin_index, begin_index);
+	ra_state_update(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
+ * If there is a previous sequential read, it is likely to be another
+ * sequential read at the new position.
+ * Databases are known to have this seek-and-read-one-record pattern.
+ */
+static inline int
+try_random_readahead(struct file_ra_state *ra, pgoff_t index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	unsigned long hit0 = ra_cache_hit(ra, 0);
+	unsigned long hit1 = ra_cache_hit(ra, 1) + hit0;
+	unsigned long hit2 = ra_cache_hit(ra, 2);
+	unsigned long hit3 = ra_cache_hit(ra, 3);
+
+	if (!ra_has_index(ra, ra->prev_page))
+		return 0;
+
+	if (index == ra->prev_page + 1) {    /* read after thrashing */
+		ra_size = hit0;
+		set_ra_class(ra, RA_CLASS_RANDOM_THRASHING);
+		ra_account(ra, RA_EVENT_READAHEAD_THRASHING,
+						ra->readahead_index - index);
+	} else if (ra_size < hit1 &&         /* read after seeking   */
+			hit1 > hit2 / 2 &&
+			hit2 > hit3 / 2 &&
+			hit3 > hit1 / 2) {
+		ra_size = max(hit1, hit2);
+		set_ra_class(ra, RA_CLASS_RANDOM_SEEK);
+	} else
+		return 0;
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	ra_state_init(ra, index, index);
+	ra_state_update(ra, ra_size, 0);
+
+	return 1;
+}
 
 /*
  * ra_size is mainly determined by:

--
