Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTE2Tcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTE2Tcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:32:33 -0400
Received: from waste.org ([209.173.204.2]:61137 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262571AbTE2Tc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:32:28 -0400
Date: Thu, 29 May 2003 14:45:40 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] write errors [3/3] fs-writepage-truncate
Message-ID: <20030529194540.GA23715@waste.org>
References: <20030514032712.0c7fa0d1.akpm@digeo.com> <20030514171000.GB23380@waste.org> <20030514104455.374b5df6.akpm@digeo.com> <20030529194232.GY23715@waste.org> <20030529194410.GZ23715@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529194410.GZ23715@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of newly exposed (and meaningless) EIO errors from truncate
races in filesystems

diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
--- orig/fs/buffer.c	2003-05-21 13:26:41.000000000 -0500
+++ patched/fs/buffer.c	2003-05-21 13:26:41.000000000 -0500
@@ -2625,7 +2625,7 @@
 		 */
 		block_invalidatepage(page, 0);
 		unlock_page(page);
-		return -EIO;
+		return 0; /* don't care */
 	}
 
 	/*
diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/cifs/file.c patched/fs/cifs/file.c
--- orig/fs/cifs/file.c	2003-05-12 14:34:30.000000000 -0500
+++ patched/fs/cifs/file.c	2003-05-21 13:26:41.000000000 -0500
@@ -433,12 +433,18 @@
 	write_data = kmap(page);
 	write_data += from;
 
-	if((to > PAGE_CACHE_SIZE) || (from > to) || (offset > mapping->host->i_size)) {
+	if((to > PAGE_CACHE_SIZE) || (from > to)) {
 		kunmap(page);
 		FreeXid(xid);
 		return -EIO;
 	}
 
+	/* racing with truncate? */
+	if(offset > mapping->host->i_size) {
+		FreeXid(xid);
+		return 0; /* don't care */
+	}
+
 	/* check to make sure that we are not extending the file */
 	if(mapping->host->i_size - offset < (loff_t)to)
 		to = (unsigned)(mapping->host->i_size - offset); 
diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/nfs/write.c patched/fs/nfs/write.c
--- orig/fs/nfs/write.c	2003-05-21 12:54:32.000000000 -0500
+++ patched/fs/nfs/write.c	2003-05-21 13:30:39.000000000 -0500
@@ -241,7 +241,7 @@
 	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
 
 	/* OK, are we completely out? */
-	err = -EIO;
+	err = 0; /* potential race with truncate - ignore */
 	if (page->index >= end_index+1 || !offset)
 		goto out;
 do_it:
diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/ntfs/aops.c patched/fs/ntfs/aops.c
--- orig/fs/ntfs/aops.c	2003-05-12 14:34:30.000000000 -0500
+++ patched/fs/ntfs/aops.c	2003-05-21 13:26:41.000000000 -0500
@@ -811,8 +811,8 @@
 	if (unlikely(page->index >= (vi->i_size + PAGE_CACHE_SIZE - 1) >>
 			PAGE_CACHE_SHIFT)) {
 		unlock_page(page);
-		ntfs_debug("Write outside i_size. Returning i/o error.");
-		return -EIO;
+		ntfs_debug("Write outside i_size - truncated?");
+		return 0;
 	}
 
 	ni = NTFS_I(vi);
diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/reiserfs/inode.c patched/fs/reiserfs/inode.c
--- orig/fs/reiserfs/inode.c	2003-05-21 12:54:32.000000000 -0500
+++ patched/fs/reiserfs/inode.c	2003-05-21 13:26:41.000000000 -0500
@@ -2048,8 +2048,8 @@
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
-	    error =  -EIO ;
-	    goto fail ;
+	    error = 0 ;
+	    goto done ;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;
diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/fs/smbfs/file.c patched/fs/smbfs/file.c
--- orig/fs/smbfs/file.c	2003-04-19 21:50:45.000000000 -0500
+++ patched/fs/smbfs/file.c	2003-05-21 13:26:41.000000000 -0500
@@ -193,7 +193,7 @@
 	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
 	/* OK, are we completely out? */
 	if (page->index >= end_index+1 || !offset)
-		return -EIO;
+		return 0; /* truncated - don't care */
 do_it:
 	page_cache_get(page);
 	err = smb_writepage_sync(inode, page, 0, offset);

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
