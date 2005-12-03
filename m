Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVLCHOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVLCHOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 02:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVLCHNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 02:13:50 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:37058 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751212AbVLCHNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 02:13:25 -0500
Message-Id: <20051203071933.372083000@localhost.localdomain>
References: <20051203071444.260068000@localhost.localdomain>
Date: Sat, 03 Dec 2005 15:14:58 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 14/16] readahead: disable look-ahead for loopback file
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

--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -623,6 +623,7 @@ struct file_ra_state {
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 #define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
+#define RA_FLAG_NO_LOOKAHEAD	(1UL<<30)	/* disable look-ahead */
 
 struct file {
 	/*
--- linux.orig/drivers/block/loop.c
+++ linux/drivers/block/loop.c
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
 
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -1186,6 +1186,11 @@ static inline void ra_state_update(struc
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
@@ -1546,6 +1551,9 @@ static int query_page_cache(struct addre
 	if (count < ra_max)
 		goto out;
 
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		goto out;
+
 	/*
 	 * Check the far pages coarsely.
 	 * The big count here helps increase la_size.

--
