Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWE0Pyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWE0Pyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWE0Pw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:26 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39388 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751600AbWE0Pvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:36 -0400
Message-ID: <348745093.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155134.715578802@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:07 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 18/32] readahead: initial method - thrashing guard size
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
@@ -796,6 +796,22 @@ out:
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
  * The node's accumulated aging activities.
  */
 static unsigned long node_readahead_aging(void)
@@ -1144,6 +1160,10 @@ state_based_readahead(struct address_spa
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
