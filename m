Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVBGVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVBGVXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVBGVWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:22:34 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:20452 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261329AbVBGVVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:21:09 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Zach Brown <zach.brown@oracle.com>
Message-Id: <20050207212108.10977.1452.77493@volauvent.pdx.zabbo.net>
Subject: [Patch] only unmap what intersects a direct_IO op
Date: Mon,  7 Feb 2005 13:21:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that we're only invalidating the pages that intersected a direct IO write
we might as well only unmap the intersecting bytes as well.  This passed a
light fsx load with page cache, direct, and mmap IO.

Signed-off-by: Zach Brown <zach.brown@oracle.com>

---

 filemap.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

Index: 2.6-bk-odirinv/mm/filemap.c
===================================================================
--- 2.6-bk-odirinv.orig/mm/filemap.c	2005-02-07 12:42:50.000000000 -0800
+++ 2.6-bk-odirinv/mm/filemap.c	2005-02-07 12:43:16.244253441 -0800
@@ -2285,22 +2285,26 @@
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	ssize_t retval;
+	size_t write_len = 0;
 
 	/*
 	 * If it's a write, unmap all mmappings of the file up-front.  This
 	 * will cause any pte dirty bits to be propagated into the pageframes
 	 * for the subsequent filemap_write_and_wait().
 	 */
-	if (rw == WRITE && mapping_mapped(mapping))
-		unmap_mapping_range(mapping, 0, -1, 0);
+	if (rw == WRITE) {
+		write_len = iov_length(iov, nr_segs);
+	       	if (mapping_mapped(mapping))
+			unmap_mapping_range(mapping, offset, write_len, 0);
+	}
 
 	retval = filemap_write_and_wait(mapping);
 	if (retval == 0) {
 		retval = mapping->a_ops->direct_IO(rw, iocb, iov,
 						offset, nr_segs);
 		if (rw == WRITE && mapping->nrpages) {
-			pgoff_t end = (offset + iov_length(iov, nr_segs) - 1)
-				      >> PAGE_CACHE_SHIFT;
+			pgoff_t end = (offset + write_len - 1)
+						>> PAGE_CACHE_SHIFT;
 			int err = invalidate_inode_pages2_range(mapping,
 					offset >> PAGE_CACHE_SHIFT, end);
 			if (err)
