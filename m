Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVLPMsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVLPMsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLPMrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:47:22 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:64142 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932248AbVLPMrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:47:10 -0500
Message-Id: <20051216131032.653462000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:48 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 10/12] readahead: disable look-ahead for loopback file
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
 mm/readahead.c       |    7 +++++++
 3 files changed, 14 insertions(+)

--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -631,6 +631,7 @@ struct file_ra_state {
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
@@ -1191,6 +1191,10 @@ static inline void ra_set_index(struct f
 static inline void ra_set_size(struct file_ra_state *ra,
 				unsigned long ra_size, unsigned long la_size)
 {
+	/* Disable look-ahead for loopback file. */
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		la_size = 0;
+
 	ra->readahead_index = ra->ra_index + ra_size;
 	ra->lookahead_index = ra->readahead_index - la_size;
 }
@@ -1571,6 +1575,9 @@ static int query_page_cache(struct addre
 	if (count < ra_max)
 		goto out;
 
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		goto out;
+
 	/*
 	 * Check the far pages coarsely.
 	 * The big count here helps increase la_size.

--
