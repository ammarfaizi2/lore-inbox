Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUDNUwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUDNUwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:52:49 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:6231 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S261690AbUDNUwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:52:46 -0400
Subject: [PATCH 2.4] fix for large direct I/O
From: Eric Sandeen <sandeen@sgi.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Organization: Eric Conspiracy Secret Labs
Message-Id: <1081975961.18488.33.camel@stout.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2004 15:52:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow on to Ted Tso's patch which fixed up IOs of > 2G.
There seems to still be a problem with direct IO. 

(Ted's patch was:
#	           ChangeSet	1.1058.2.2 -> 1.1058.2.3
#	        mm/filemap.c	1.85    -> 1.86   
#	      fs/ext3/file.c	1.3     -> 1.4)


generic_file_direct_IO() takes a size_t count for the IO size, but then
assigns it to an int before checking for > chunk_size.  Also, progress
is rolled up in an (int) progress var.  These get garbled on ia64 for
example.

I think this patch takes care of these issues.

--- linux/mm/filemap.c_1.3    2004-04-14 15:46:43.000000000 -0500
+++ linux/mm/filemap.c        2004-04-14 15:46:32.000000000 -0500
@@ -1639,8 +1639,9 @@
  
 static ssize_t generic_file_direct_IO(int rw, struct file * filp, char * buf, size_t count, loff_t offset)
 {
-       ssize_t retval;
-       int new_iobuf, chunk_size, blocksize_mask, blocksize, blocksize_bits, iosize, progress;
+       ssize_t retval, progress;
+       int new_iobuf, chunk_size, blocksize_mask, blocksize, blocksize_bits;
+       size_t iosize;
        struct kiobuf * iobuf;
        struct address_space * mapping = filp->f_dentry->d_inode->i_mapping;
        struct inode * inode = mapping->host;


-- 
Eric Sandeen      [C]XFS for Linux   http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.          651-683-3102

