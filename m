Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966599AbWKOH5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966599AbWKOH5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966059AbWKOHz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:55:59 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:63950 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755484AbWKOHud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:33 -0500
Message-ID: <363577028.14717@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075032.213167260@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:31 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 24/28] readahead: loop case
Content-Disposition: inline; filename=readahead-loop-case.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable look-ahead for loop file.

Loopback files normally contain filesystems, in which case there are already
proper look-aheads in the upper layer, more look-aheads on the loopback file
only ruins the read-ahead hit rate.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/drivers/block/loop.c
+++ linux-2.6.19-rc5-mm2/drivers/block/loop.c
@@ -755,6 +755,12 @@ static int loop_set_fd(struct loop_devic
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
+	/* Instruct the readahead code to skip look-ahead on loop file.
+	 * The upper layer should already do proper look-ahead,
+	 * one more look-ahead here only ruins the cache hit rate.
+	 */
+	file->f_ra.flags |= RA_FLAG_LOOP;
+
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
--- linux-2.6.19-rc5-mm2.orig/include/linux/fs.h
+++ linux-2.6.19-rc5-mm2/include/linux/fs.h
@@ -741,6 +741,7 @@ struct file_ra_state {
 #define RA_FLAG_MISS	(1UL<<31) /* a cache miss occured against this file */
 #define RA_FLAG_INCACHE	(1UL<<30) /* file is already in cache */
 #define RA_FLAG_MMAP	(1UL<<29) /* mmap page access */
+#define RA_FLAG_LOOP	(1UL<<28) /* loopback file */
 
 struct file {
 	/*
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -985,6 +985,10 @@ static int ra_submit(struct file_ra_stat
 		    ra->lookahead_index = eof;
 	}
 
+	/* Disable look-ahead for loopback file. */
+	if (ra->flags & RA_FLAG_LOOP)
+		ra->lookahead_index = ra->readahead_index;
+
 	/* Take down the current read-ahead aging value. */
 	ra->age = nr_scanned_pages_node(numa_node_id());
 

--
