Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWE0Pzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWE0Pzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWE0PwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:22 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:221 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751605AbWE0Pvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:39 -0400
Message-ID: <348745096.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155137.552915509@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 24/32] readahead: thrashing recovery method
Content-Disposition: inline; filename=readahead-method-onthrash.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Readahead policy after thrashing.

It tries to recover gracefully from the thrashing.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1619,6 +1619,48 @@ try_readahead_on_seek(struct file_ra_sta
 }
 
 /*
+ * Readahead thrashing recovery.
+ */
+static unsigned long
+thrashing_recovery_readahead(struct address_space *mapping,
+				struct file *filp, struct file_ra_state *ra,
+				pgoff_t index, unsigned long ra_max)
+{
+	unsigned long ra_size;
+
+	if (probe_page(mapping, index - 1))
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
+		ra_size = ra->hit0;
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
+	ra_set_index(ra, index, index);
+	ra_set_size(ra, ra_size, ra_size / LOOKAHEAD_RATIO);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
