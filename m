Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWEXLVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWEXLVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWEXLTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:52 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:61825 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932690AbWEXLTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:10 -0400
Message-ID: <348469547.79437@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111909.147416866@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 24/33] readahead: seeking reads method
Content-Disposition: inline; filename=readahead-method-onseek.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Readahead policy on read after seeking.

It tries to detect sequences like:
	seek(), 5*read(); seek(), 6*read(); seek(), 4*read(); ...

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1614,6 +1614,49 @@ try_read_backward(struct file_ra_state *
 }
 
 /*
+ * If there is a previous sequential read, it is likely to be another
+ * sequential read at the new position.
+ *
+ * i.e. detect the following sequences:
+ * 	seek(), 5*read(); seek(), 6*read(); seek(), 4*read(); ...
+ *
+ * Databases are known to have this seek-and-read-N-pages pattern.
+ */
+static int
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
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
