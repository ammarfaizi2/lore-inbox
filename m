Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWKOHwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWKOHwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966400AbWKOHvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:10 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:36046 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966421AbWKOHuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:37 -0500
Message-ID: <363577026.21912@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075029.869472273@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:24 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 17/28] readahead: initial method - thrashing guard size
Content-Disposition: inline; filename=readahead-initial-method-thrashing-guard-size.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backing_dev_info.ra_thrash_bytes is dynamicly updated to be a little above
the thrashing safe read-ahead size. It is used in the initial method where
the thrashing threshold for the particular reader is still unknown.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -822,6 +822,22 @@ out:
 }
 
 /*
+ * Update `backing_dev_info.ra_thrash_bytes' to be a _biased_ average of
+ * read-ahead sizes. Which makes it an a-bit-risky(*) estimation of the
+ * _minimal_ read-ahead thrashing threshold on the device.
+ *
+ * (*) Note that being a bit risky can _help_ overall performance.
+ */
+static void update_ra_thrash_bytes(struct backing_dev_info *bdi,
+							unsigned long ra_size)
+{
+	ra_size <<= PAGE_CACHE_SHIFT;
+	bdi->ra_thrash_bytes = (bdi->ra_thrash_bytes < ra_size) ?
+				(ra_size + bdi->ra_thrash_bytes * 127) / 128:
+				(ra_size + bdi->ra_thrash_bytes *   7) /   8;
+}
+
+/*
  * Some helpers for querying/building a read-ahead request.
  *
  * Diagram for some variable names used frequently:
@@ -1118,6 +1134,10 @@ state_based_readahead(struct address_spa
 
 	limit_rala(growth_limit, la_old, &ra_size, &la_size);
 
+	/* ra_size in its _steady_ state reflects thrashing threshold */
+	if (page && ra_old + ra_old / 8 >= ra_size)
+		update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);
+
 	ra_set_class(ra, RA_CLASS_STATE);
 	ra_set_index(ra, offset, ra->readahead_index);
 	ra_set_size(ra, ra_size, la_size);

--
