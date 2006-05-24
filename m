Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbWEXLUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWEXLUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWEXLT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:58 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39553 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932703AbWEXLTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:10 -0400
Message-ID: <348469545.16036@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111906.588647885@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:05 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 19/33] readahead: initial method - thrashing guard size
Content-Disposition: inline; filename=readahead-method-initial-size-thrash.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backing_dev_info.ra_thrash_bytes is dynamicly updated to be a little above
the thrashing safe read-ahead size. It is used in the initial method where
the thrashing threshold for the particular reader is still unknown.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -817,6 +817,22 @@ out:
 }
 
 /*
+ * Update `backing_dev_info.ra_thrash_bytes' to be a _biased_ average of
+ * read-ahead sizes. Which makes it an a-bit-risky(*) estimation of the
+ * _minimal_ read-ahead thrashing threshold on the device.
+ *
+ * (*) Note that being a bit risky can _help_ overall performance.
+ */
+static inline void update_ra_thrash_bytes(struct backing_dev_info *bdi,
+						unsigned long ra_size)
+{
+	ra_size <<= PAGE_CACHE_SHIFT;
+	bdi->ra_thrash_bytes = (bdi->ra_thrash_bytes < ra_size) ?
+				(ra_size + bdi->ra_thrash_bytes * 1023) / 1024:
+				(ra_size + bdi->ra_thrash_bytes *    7) /    8;
+}
+
+/*
  * The node's effective length of inactive_list(s).
  */
 static unsigned long node_free_and_cold_pages(void)
@@ -1180,6 +1196,10 @@ state_based_readahead(struct address_spa
 	if (!adjust_rala(growth_limit, &ra_size, &la_size))
 		return 0;
 
+	/* ra_size in its _steady_ state reflects thrashing threshold */
+	if (page && ra_old + ra_old / 8 >= ra_size)
+		update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);
+
 	ra_set_class(ra, RA_CLASS_STATE);
 	ra_set_index(ra, index, ra->readahead_index);
 	ra_set_size(ra, ra_size, la_size);

--
