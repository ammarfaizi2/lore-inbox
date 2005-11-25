Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbVKYPKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVKYPKI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKYPJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:09:40 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:51330 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161105AbVKYPJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:09:22 -0500
Message-Id: <20051125151738.229577000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:27 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 17/19] readahead: disable look-ahead for loopback file
Content-Disposition: inline; filename=readahead-disable-lookahead-for-loopback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loopback files normally contain filesystem, in which case there are already
proper look-aheads in the upper layer, more look-aheads on the loopback file
only ruins the read-ahead hit rate.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

I'd like to thank Tero Grundstr?m for uncovering the loopback problem.

 drivers/block/loop.c |    6 ++++++
 include/linux/fs.h   |    1 +
 mm/readahead.c       |    8 ++++++++
 3 files changed, 15 insertions(+)

--- linux-2.6.15-rc2-mm1.orig/include/linux/fs.h
+++ linux-2.6.15-rc2-mm1/include/linux/fs.h
@@ -620,6 +620,7 @@ struct file_ra_state {
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
+#define RA_FLAG_NO_LOOKAHEAD	(1UL<<31)	/* disable look-ahead */
 
 struct file {
 	/*
--- linux-2.6.15-rc2-mm1.orig/drivers/block/loop.c
+++ linux-2.6.15-rc2-mm1/drivers/block/loop.c
@@ -782,6 +782,12 @@ static int loop_set_fd(struct loop_devic
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
+	/*
+	 * The upper layer should already do proper look-ahead,
+	 * one more look-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.flags |= RA_FLAG_NO_LOOKAHEAD;
+
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
--- linux-2.6.15-rc2-mm1.orig/mm/readahead.c
+++ linux-2.6.15-rc2-mm1/mm/readahead.c
@@ -1312,6 +1312,11 @@ static inline void ra_state_update(struc
 	if (ra_size < old_ra && ra_cache_hit(ra, 0))
 		ra_account(ra, RA_EVENT_READAHEAD_SHRINK, old_ra - ra_size);
 #endif
+
+	/* Disable look-ahead for loopback file. */
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		la_size = 0;
+
 	ra_addup_cache_hit(ra);
 	ra->ra_index = ra->readahead_index;
 	ra->la_index = ra->lookahead_index;
@@ -1672,6 +1677,9 @@ static int query_page_cache(struct addre
 	if (count < ra_max)
 		goto out;
 
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		goto out;
+
 	/*
 	 * Check the far pages coarsely.
 	 * The big count here helps increase la_size.

--
