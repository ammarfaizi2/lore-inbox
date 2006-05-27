Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWE0Pyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWE0Pyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWE0Pw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:28 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22492 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751570AbWE0Pve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:34 -0400
Message-ID: <348745091.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155132.649338979@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:03 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 14/32] readahead: state based method - routines
Content-Disposition: inline; filename=readahead-method-stateful-routines.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend struct file_ra_state to support the adaptive read-ahead logic.
Also define some helpers for it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/fs.h |   74 +++++++++++++++++---
 mm/readahead.c     |  189 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 251 insertions(+), 12 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/fs.h
+++ linux-2.6.17-rc4-mm3/include/linux/fs.h
@@ -613,21 +613,75 @@ struct fown_struct {
 
 /*
  * Track a single file's readahead state
+ *
+ * Diagram for the adaptive readahead logic:
+ *
+ *  |--------- old chunk ------->|-------------- new chunk -------------->|
+ *  +----------------------------+----------------------------------------+
+ *  |               #            |                  #                     |
+ *  +----------------------------+----------------------------------------+
+ *                  ^            ^                  ^                     ^
+ *  file_ra_state.la_index    .ra_index   .lookahead_index      .readahead_index
+ *
+ * Common used deduced sizes:
+ *                               |----------- readahead size ------------>|
+ *  +----------------------------+----------------------------------------+
+ *  |               #            |                  #                     |
+ *  +----------------------------+----------------------------------------+
+ *                  |------- invoke interval ------>|-- lookahead size -->|
  */
 struct file_ra_state {
-	unsigned long start;		/* Current window */
-	unsigned long size;
-	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
-	unsigned long cache_hit;	/* cache hit count*/
-	unsigned long prev_page;	/* Cache last read() position */
-	unsigned long ahead_start;	/* Ahead window */
-	unsigned long ahead_size;
-	unsigned long ra_pages;		/* Maximum readahead window */
+	union {
+		struct { /* stock read-ahead */
+			unsigned long start;		/* Current window */
+			unsigned long size;
+			unsigned long ahead_start;	/* Ahead window */
+			unsigned long ahead_size;
+			unsigned long cache_hit;	/* cache hit count */
+		};
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+		struct { /* adaptive read-ahead */
+			pgoff_t la_index;		/* old chunk */
+			pgoff_t ra_index;
+			pgoff_t lookahead_index;	/* new chunk */
+			pgoff_t readahead_index;
+
+			/*
+			 * Read-ahead hits.
+			 * 	i.e. # of distinct read-ahead pages accessed.
+			 *
+			 * What is a read-ahead sequence?
+			 * 	A collection of sequential read-ahead requests.
+			 * To put it simple:
+			 * 	Normally a seek starts a new sequence.
+			 */
+			u16	hit0;	/* for the current request */
+			u16	hit1;	/* for the current sequence */
+			u16	hit2;	/* for the previous sequence */
+			u16	hit3;	/* for the prev-prev sequence */
+
+			/*
+			 * Snapshot of the (node's) read-ahead aging value
+			 * on time of I/O submission.
+			 */
+			unsigned long age;
+		};
+#endif
+	};
+
+	/* mmap read-around */
 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+
+	unsigned long flags;	/* RA_FLAG_xxx | ra_class_old | ra_class_new */
+	unsigned long prev_page;	/* Cache last read() position */
+	unsigned long ra_pages;		/* Maximum readahead window */
 };
-#define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
-#define RA_FLAG_INCACHE 0x02	/* file is already in cache */
+#define RA_FLAG_MISS	(1UL<<31) /* a cache miss occured against this file */
+#define RA_FLAG_INCACHE	(1UL<<30) /* file is already in cache */
+#define RA_FLAG_MMAP		(1UL<<29) /* mmaped page access */
+#define RA_FLAG_NO_LOOKAHEAD	(1UL<<28) /* disable look-ahead */
+#define RA_FLAG_EOF		(1UL<<27) /* readahead hits EOF */
 
 struct file {
 	/*
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -817,6 +817,191 @@ static unsigned long node_readahead_agin
 }
 
 /*
+ * Some helpers for querying/building a read-ahead request.
+ *
+ * Diagram for some variable names used frequently:
+ *
+ *                                   |<------- la_size ------>|
+ *                  +-----------------------------------------+
+ *                  |                #                        |
+ *                  +-----------------------------------------+
+ *      ra_index -->|<---------------- ra_size -------------->|
+ *
+ */
+
+static enum ra_class ra_class_new(struct file_ra_state *ra)
+{
+	return ra->flags & RA_CLASS_MASK;
+}
+
+static inline enum ra_class ra_class_old(struct file_ra_state *ra)
+{
+	return (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+}
+
+static unsigned long ra_readahead_size(struct file_ra_state *ra)
+{
+	return ra->readahead_index - ra->ra_index;
+}
+
+static unsigned long ra_lookahead_size(struct file_ra_state *ra)
+{
+	return ra->readahead_index - ra->lookahead_index;
+}
+
+static unsigned long ra_invoke_interval(struct file_ra_state *ra)
+{
+	return ra->lookahead_index - ra->la_index;
+}
+
+/*
+ * The read-ahead is deemed success if cache-hit-rate >= 1/readahead_hit_rate.
+ */
+static int ra_cache_hit_ok(struct file_ra_state *ra)
+{
+	return ra->hit0 * readahead_hit_rate >=
+					(ra->lookahead_index - ra->la_index);
+}
+
+/*
+ * Check if @index falls in the @ra request.
+ */
+static int ra_has_index(struct file_ra_state *ra, pgoff_t index)
+{
+	if (index < ra->la_index || index >= ra->readahead_index)
+		return 0;
+
+	if (index >= ra->ra_index)
+		return 1;
+	else
+		return -1;
+}
+
+/*
+ * Which method is issuing this read-ahead?
+ */
+static void ra_set_class(struct file_ra_state *ra,
+				enum ra_class ra_class)
+{
+	unsigned long flags_mask;
+	unsigned long flags;
+	unsigned long old_ra_class;
+
+	flags_mask = ~(RA_CLASS_MASK | (RA_CLASS_MASK << RA_CLASS_SHIFT));
+	flags = ra->flags & flags_mask;
+
+	old_ra_class = ra_class_new(ra) << RA_CLASS_SHIFT;
+
+	ra->flags = flags | old_ra_class | ra_class;
+
+	/*
+	 * Add request-hit up to sequence-hit and reset the former.
+	 */
+	ra->hit1 += ra->hit0;
+	ra->hit0 = 0;
+
+	/*
+	 * Manage the read-ahead sequences' hit counts.
+	 * 	- the stateful method continues any existing sequence;
+	 * 	- all other methods starts a new one.
+	 */
+	if (ra_class != RA_CLASS_STATE) {
+		ra->hit3 = ra->hit2;
+		ra->hit2 = ra->hit1;
+		ra->hit1 = 0;
+	}
+}
+
+/*
+ * Where is the old read-ahead and look-ahead?
+ */
+static void ra_set_index(struct file_ra_state *ra,
+				pgoff_t la_index, pgoff_t ra_index)
+{
+	ra->la_index = la_index;
+	ra->ra_index = ra_index;
+}
+
+/*
+ * Where is the new read-ahead and look-ahead?
+ */
+static void ra_set_size(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+	ra->readahead_index = ra->ra_index + ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+}
+
+/*
+ * Submit IO for the read-ahead request in file_ra_state.
+ */
+static int ra_dispatch(struct file_ra_state *ra,
+			struct address_space *mapping, struct file *filp)
+{
+	unsigned long ra_size;
+	unsigned long la_size;
+	pgoff_t eof_index;
+	int actual;
+
+	eof_index = /* it's a past-the-end index! */
+		DIV_ROUND_UP(i_size_read(mapping->host), PAGE_CACHE_SIZE);
+
+	if (unlikely(ra->ra_index >= eof_index))
+		return 0;
+
+	/*
+	 * Snap to EOF, if the request
+	 * 	- crossed the EOF boundary;
+	 * 	- is close to EOF(explained below).
+	 *
+	 * Imagine a file sized 18 pages, and we dicided to read-ahead the
+	 * first 16 pages. It is highly possible that in the near future we
+	 * will have to do another read-ahead for the remaining 2 pages,
+	 * which is an unfavorable small I/O.
+	 *
+	 * So we prefer to take a bit risk to enlarge the current read-ahead,
+	 * to eliminate possible future small I/O.
+	 */
+	if (ra->readahead_index + ra_readahead_size(ra)/4 > eof_index) {
+		ra->readahead_index = eof_index;
+		if (ra->lookahead_index > eof_index)
+			ra->lookahead_index = eof_index;
+		ra->flags |= RA_FLAG_EOF;
+	}
+
+	/* Disable look-ahead for loopback file. */
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		ra->lookahead_index = ra->readahead_index;
+
+	/* Take down the current read-ahead aging value. */
+	ra->age = node_readahead_aging();
+
+	ra_size = ra_readahead_size(ra);
+	la_size = ra_lookahead_size(ra);
+	actual = __do_page_cache_readahead(mapping, filp,
+					ra->ra_index, ra_size, la_size);
+
+#ifdef CONFIG_DEBUG_READAHEAD
+	if (ra->flags & RA_FLAG_MMAP)
+		ra_account(ra, RA_EVENT_READAHEAD_MMAP, actual);
+	if (ra->readahead_index == eof_index)
+		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
+	if (la_size)
+		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
+	ra_account(ra, RA_EVENT_READAHEAD, actual);
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class_new(ra)],
+			mapping->host->i_ino, ra->la_index,
+			ra->ra_index, ra_size, la_size, actual);
+#endif /* CONFIG_DEBUG_READAHEAD */
+
+	return actual;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:
@@ -888,10 +1073,10 @@ static void ra_account(struct file_ra_st
 		return;
 
 	if (e == RA_EVENT_READAHEAD_HIT && pages < 0) {
-		c = (ra->flags >> RA_CLASS_SHIFT) & RA_CLASS_MASK;
+		c = ra_class_old(ra);
 		pages = -pages;
 	} else if (ra)
-		c = ra->flags & RA_CLASS_MASK;
+		c = ra_class_new(ra);
 	else
 		c = RA_CLASS_NONE;
 

--
