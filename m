Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966392AbWKOHvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966392AbWKOHvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966421AbWKOHvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:11 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:46286 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755485AbWKOHug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:36 -0500
Message-ID: <363577027.13886@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075031.286178806@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:28 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 21/28] readahead: thrashing recovery method
Content-Disposition: inline; filename=readahead-thrashing-recovery-method.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Readahead policy after thrashing.

It tries to recover gracefully from the thrashing.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -1522,6 +1522,50 @@ try_backward_prefetching(struct file_ra_
 }
 
 /*
+ * Readahead thrashing recovery.
+ */
+static unsigned long
+thrashing_recovery_readahead(struct address_space *mapping,
+				struct file *filp, struct file_ra_state *ra,
+				pgoff_t offset, unsigned long ra_max)
+{
+	unsigned long ra_size;
+
+#ifdef CONFIG_DEBUG_READAHEAD
+	if (probe_page(mapping, offset - 1))
+		ra_account(ra, RA_EVENT_READAHEAD_MUTILATE,
+						ra->readahead_index - offset);
+	ra_account(ra, RA_EVENT_READAHEAD_THRASHING,
+						ra->readahead_index - offset);
+#endif
+
+	/*
+	 * Some thrashing occur in (ra_index, la_index], in which case the
+	 * old read-ahead chunk is lost soon after the new one is allocated.
+	 * Ensure that we recover all needed pages in the old chunk.
+	 */
+	if (offset < ra->ra_index)
+		ra_size = ra->ra_index - offset;
+	else {
+		/* After thrashing, we know the exact thrashing-threshold. */
+		ra_size = offset - ra->ra_index;
+		update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);
+
+		/* And we'd better be a bit conservative. */
+		ra_size = ra_size * 3 / 4;
+	}
+
+	if (ra_size > ra_max)
+		ra_size = ra_max;
+
+	ra_set_class(ra, RA_CLASS_THRASHING);
+	ra_set_index(ra, offset, offset);
+	ra_set_size(ra, ra_size, ra_size / LOOKAHEAD_RATIO);
+
+	return ra_submit(ra, mapping, filp);
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
