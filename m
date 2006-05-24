Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWEXLWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWEXLWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWEXLTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:46 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:20097 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932704AbWEXLTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:12 -0400
Message-ID: <348469543.10865@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111904.683513683@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:01 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 15/33] readahead: state based method - routines
Content-Disposition: inline; filename=readahead-method-stateful-routines.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define some helpers on struct file_ra_state.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  188 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 186 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -854,6 +854,190 @@ static unsigned long node_readahead_agin
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
+ * The 64bit cache_hits stores three accumulated values and a counter value.
+ * MSB                                                                   LSB
+ * 3333333333333333 : 2222222222222222 : 1111111111111111 : 0000000000000000
+ */
+static int ra_cache_hit(struct file_ra_state *ra, int nr)
+{
+	return (ra->cache_hits >> (nr * 16)) & 0xFFFF;
+}
+
+/*
+ * Conceptual code:
+ * ra_cache_hit(ra, 1) += ra_cache_hit(ra, 0);
+ * ra_cache_hit(ra, 0) = 0;
+ */
+static void ra_addup_cache_hit(struct file_ra_state *ra)
+{
+	int n;
+
+	n = ra_cache_hit(ra, 0);
+	ra->cache_hits -= n;
+	n <<= 16;
+	ra->cache_hits += n;
+}
+
+/*
+ * The read-ahead is deemed success if cache-hit-rate >= 1/readahead_hit_rate.
+ */
+static int ra_cache_hit_ok(struct file_ra_state *ra)
+{
+	return ra_cache_hit(ra, 0) * readahead_hit_rate >=
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
+	ra_addup_cache_hit(ra);
+	if (ra_class != RA_CLASS_STATE)
+		ra->cache_hits <<= 16;
+
+	ra->age = node_readahead_aging();
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
+	/* Disable look-ahead for loopback file. */
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		la_size = 0;
+
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
+	enum ra_class ra_class = ra_class_new(ra);
+	unsigned long ra_size = ra_readahead_size(ra);
+	unsigned long la_size = ra_lookahead_size(ra);
+	pgoff_t eof_index = PAGES_BYTE(i_size_read(mapping->host)) + 1;
+	int actual;
+
+	if (unlikely(ra->ra_index >= eof_index))
+		return 0;
+
+	/* Snap to EOF. */
+	if (ra->readahead_index + ra_size / 2 > eof_index) {
+		if (ra_class == RA_CLASS_CONTEXT_AGGRESSIVE &&
+				eof_index > ra->lookahead_index + 1)
+			la_size = eof_index - ra->lookahead_index;
+		else
+			la_size = 0;
+		ra_size = eof_index - ra->ra_index;
+		ra_set_size(ra, ra_size, la_size);
+		ra->flags |= RA_FLAG_EOF;
+	}
+
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
+			ra_class_name[ra_class],
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
@@ -925,10 +1109,10 @@ static void ra_account(struct file_ra_st
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
