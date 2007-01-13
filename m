Return-Path: <linux-kernel-owner+w=401wt.eu-S1161234AbXAMDZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbXAMDZm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbXAMDZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:25:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:46630 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161225AbXAMDZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:25:35 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011315.9449.43708.sendpatchset@linux.site>
In-Reply-To: <20070113011159.9449.4327.sendpatchset@linux.site>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 8/10] mm: generic_file_buffered_write cleanup more
Date: Sat, 13 Jan 2007 04:25:31 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to do the confusing switch of variables from copied into status.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1898,28 +1898,22 @@ generic_file_buffered_write(struct kiocb
 			goto fs_write_aop_error;
 
 		if (likely(copied > 0)) {
-			if (!status)
-				status = copied;
-
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
-					filemap_set_next_iovec(&cur_iov,
-							&iov_offset, status);
-					if (count)
-						buf = cur_iov->iov_base +
-							iov_offset;
-				} else {
-					iov_offset += status;
-				}
+			written += copied;
+			count -= copied;
+			pos += copied;
+			buf += copied;
+			if (unlikely(nr_segs > 1)) {
+				filemap_set_next_iovec(&cur_iov,
+						&iov_offset, copied);
+				if (count)
+					buf = cur_iov->iov_base + iov_offset;
+			} else {
+				iov_offset += copied;
 			}
 		}
 		if (unlikely(copied != bytes))
-			if (status >= 0)
-				status = -EFAULT;
+			status = -EFAULT;
+
 		unlock_page(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
