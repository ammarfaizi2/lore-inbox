Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272228AbTHDUQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTHDUQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:16:51 -0400
Received: from thunk.org ([140.239.227.29]:46272 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S272228AbTHDUQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:16:47 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4] 64-bit write system call patch
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E19jkS0-0001na-00@think.thunk.org>
Date: Mon, 04 Aug 2003 14:52:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

The following patch (the BK Linux 2.4 tree) is needed to fix some
32/64-bit issues with the write system call.  There are a number of
places in the VFS stack (and in ext2/3 filesystem --- possibly others,
but I haven't had the time to audit them yet) where the number of bytes
written assigned to an integer instead of a ssize_t.  This causes the
top 32-bits of the returned value to get lopped off, so that a write()
of 4 gigabytes returns 0 instead of 4GB.

The patch is fairly straightforward, and obvious(tm).  Please apply.

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1052  -> 1.1053 
#	        mm/filemap.c	1.85    -> 1.86   
#	      fs/ext3/file.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/03	tytso@think.thunk.org	1.1053
# Fix 32/64 bit issues.
# --------------------------------------------
#
diff -Nru a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	Mon Aug  4 14:47:00 2003
+++ b/fs/ext3/file.c	Mon Aug  4 14:47:00 2003
@@ -61,7 +61,8 @@
 static ssize_t
 ext3_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	int ret, err;
+	ssize_t ret;
+	int err;
 	struct inode *inode = file->f_dentry->d_inode;
 
 	ret = generic_file_write(file, buf, count, ppos);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Mon Aug  4 14:47:00 2003
+++ b/mm/filemap.c	Mon Aug  4 14:47:00 2003
@@ -3108,7 +3108,7 @@
 	struct page	*page, *cached_page;
 	ssize_t		written;
 	long		status = 0;
-	int		err;
+	ssize_t		err;
 	unsigned	bytes;
 
 	cached_page = NULL;
@@ -3229,7 +3229,7 @@
 	loff_t		pos;
 	ssize_t		written;
 	long		status = 0;
-	int		err;
+	ssize_t		err;
 
 	pos = *ppos;
 	written = 0;
@@ -3270,7 +3270,8 @@
 static int do_odirect_fallback(struct file *file, struct inode *inode,
 			       const char *buf, size_t count, loff_t *ppos)
 {
-	int ret, err;
+	ssize_t ret;
+	int err;
 
 	down(&inode->i_sem);
 	ret = do_generic_file_write(file, buf, count, ppos);
@@ -3287,7 +3288,7 @@
 generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode->i_mapping->host;
-	int		err;
+	ssize_t		err;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;

