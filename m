Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWCSCfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWCSCfk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWCSCfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:35:09 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:47554 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751299AbWCSCem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:42 -0500
Message-Id: <20060319023456.441281000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:29 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 16/23] readahead: other methods
Content-Disposition: inline; filename=readahead-method-others.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various read-ahead strategies for:
	- fresh read from start of file
	- backward prefetching
	- seek and read one block pattern(db workload)
	- quickly recover from thrashing

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -1689,6 +1689,159 @@ try_context_based_readahead(struct addre
 }
 
 /*
+ * Read-ahead on start of file.
+ *
+ * The strategies here are most important for small files.
+ * 1. Set a moderately large read-ahead size;
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
+	if (req_size > ra_min) /* larger value risks thrashing */
+		req_size = ra_min;
+
+	ra_size = 4 * req_size;
+	la_size = 2 * req_size;
+
+	ra_set_class(ra, RA_CLASS_NEWFILE);
+	ra_set_index(ra, 0, 0);
+	ra_set_size(ra, ra_size, la_size);
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
+ * Readahead thrashing recovery.
+ */
+static inline unsigned long
+thrashing_recovery_readahead(struct address_space *mapping,
+				struct file *filp, struct file_ra_state *ra,
+				pgoff_t index, unsigned long ra_max)
+{
+	unsigned long ra_size;
+
+	if (readahead_debug_level && find_page(mapping, index - 1))
+		ra_account(ra, RA_EVENT_READAHEAD_MUTILATE,
+						ra->readahead_index - index);
+	ra_account(ra, RA_EVENT_READAHEAD_THRASHING,
+						ra->readahead_index - index);
+
+	/*
+	 * Some thrashing occur in (ra_index, la_index], in which case the
+	 * old read-ahead chunk is lost soon after the new one is allocated.
+	 * Ensure that we recover all needed pages in the old chunk.
+	 */
+	if (index < ra->ra_index)
+		ra_size = ra->ra_index - index;
+	else {
+		/* After thrashing, we know the exact thrashing-threshold. */
+		ra_size = ra_cache_hit(ra, 0);
+
+		/* And we'd better be a bit conservative. */
+		ra_size = ra_size * 3 / 4;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	ra_set_class(ra, RA_CLASS_THRASHING);
+	ra_set_index(ra, index, index);
+	ra_set_size(ra, ra_size, ra_size / LOOKAHEAD_RATIO);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
+ * If there is a previous sequential read, it is likely to be another
+ * sequential read at the new position.
+ * Databases are known to have this seek-and-read-one-block pattern.
+ */
+static inline int
+try_readahead_on_seek(struct file_ra_state *ra, pgoff_t index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	unsigned long hit0 = ra_cache_hit(ra, 0);
+	unsigned long hit1 = ra_cache_hit(ra, 1) + hit0;
+	unsigned long hit2 = ra_cache_hit(ra, 2);
+	unsigned long hit3 = ra_cache_hit(ra, 3);
+
+	/* There's a previous read-ahead request? */
+	if (!ra_has_index(ra, ra->prev_page))
+		return 0;
+
+	/* The previous read-ahead sequences have similiar sizes? */
+	if (!(ra_size < hit1 && hit1 > hit2 / 2 &&
+				hit2 > hit3 / 2 &&
+				hit3 > hit1 / 2))
+		return 0;
+
+	hit1 = max(hit1, hit2);
+
+	/* Follow the same prefetching direction. */
+	if ((ra->flags & RA_CLASS_MASK) == RA_CLASS_BACKWARD)
+		index = ((index > hit1 - ra_size) ? index - hit1 + ra_size : 0);
+
+	ra_size = min(hit1, ra_max);
+
+	ra_set_class(ra, RA_CLASS_SEEK);
+	ra_set_index(ra, index, index);
+	ra_set_size(ra, ra_size, 0);
+
+	return 1;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory.
  * Table of concrete numbers for 4KB page size:
  *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024

--
