Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTDKSrX (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTDKSrX (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:47:23 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:22270 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261380AbTDKSrV (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 14:47:21 -0400
Date: Fri, 11 Apr 2003 14:59:00 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bugfix nfs kmap_atomic (fwd)
Message-ID: <Pine.LNX.4.44.0304111458410.26007-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, wrong address at first ;)

---------- Forwarded message ----------
Date: Fri, 11 Apr 2003 14:44:28 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
Subject: [PATCH] bugfix nfs kmap_atomic


There's a serious bug in the handling of the pointer returned
by kmap_atomic() in nfs/dir.c.   The pointer (part of desc) is
passed into find_dirent_name and from there into dir_decode,
which modifies the pointer.

That means you end up passing a wrong address to kunmap_atomic().
The patch below fixes it by remembering the address that kmap_atomic()
told us.

Please apply. Thank you,

Rik

===== fs/nfs/dir.c 1.53 vs edited =====
--- 1.53/fs/nfs/dir.c	Mon Apr  7 18:22:57 2003
+++ edited/fs/nfs/dir.c	Fri Apr 11 14:40:39 2003
@@ -714,6 +714,7 @@
 	struct nfs_server *server;
 	struct nfs_entry entry;
 	struct page *page;
+	void * kaddr;
 	unsigned long timestamp = NFS_MTIME_UPDATE(dir);
 	int res;
 
@@ -736,9 +737,9 @@
 
 		res = -EIO;
 		if (PageUptodate(page)) {
-			desc.ptr = kmap_atomic(page, KM_USER0);
+			kaddr = desc.ptr = kmap_atomic(page, KM_USER0);
 			res = find_dirent_name(&desc, page, dentry);
-			kunmap_atomic(desc.ptr, KM_USER0);
+			kunmap_atomic(kaddr, KM_USER0);
 		}
 		page_cache_release(page);
 


