Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTFJQmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFJQmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:42:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:2215 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S262298AbTFJQmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:42:50 -0400
Date: Tue, 10 Jun 2003 17:58:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 1/3 shmem_file_write EFAULT
Message-ID: <Pine.LNX.4.44.0306101757150.2432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the first of three small unrelated patches to mm/shmem.c.
Based on 2.5.70-mm7.  Aggregate diffstat is:

 include/linux/shmem_fs.h |    2 -
 mm/shmem.c               |   73 +++++++++++++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 32 deletions(-)

tmpfs 1/3 shmem_file_write EFAULT

generic_file_aio_write_nolock (phew!) has recently been corrected for
when partial writes hit -EFAULT: now bring shmem_file_write into line.

--- 2.5.70-mm7/mm/shmem.c	Thu Jun  5 10:27:34 2003
+++ tmpfs1/mm/shmem.c	Fri Jun  6 19:20:21 2003
@@ -1186,30 +1186,32 @@
 			left = __copy_from_user(kaddr + offset, buf, bytes);
 			kunmap(page);
 		}
+
+		written += bytes;
+		count -= bytes;
+		pos += bytes;
+		buf += bytes;
+		if (pos > inode->i_size)
+			inode->i_size = pos;
+
 		flush_dcache_page(page);
+		set_page_dirty(page);
+		if (!PageReferenced(page))
+			SetPageReferenced(page);
+		page_cache_release(page);
+
 		if (left) {
-			page_cache_release(page);
+			pos -= left;
+			written -= left;
 			err = -EFAULT;
 			break;
 		}
 
-		if (!PageReferenced(page))
-			SetPageReferenced(page);
-		set_page_dirty(page);
-		page_cache_release(page);
-
 		/*
 		 * Our dirty pages are not counted in nr_dirty,
 		 * and we do not attempt to balance dirty pages.
 		 */
 
-		written += bytes;
-		count -= bytes;
-		pos += bytes;
-		buf += bytes;
-		if (pos > inode->i_size)
-			inode->i_size = pos;
-
 		cond_resched();
 	} while (count);
 

