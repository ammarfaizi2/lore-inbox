Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVDXPvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVDXPvC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVDXPvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:51:02 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:409 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262347AbVDXPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:50:56 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: disable sendfile with direct_io 
Message-Id: <E1DPjNY-0000PZ-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 17:50:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case a filesystem is mounted with "direct_io", sendfile should not
use the generic function, but return an error instead.  The generic
sendfile uses the page cache, which could return stale data.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.12-rc2-mm3/fs/fuse/file.c	2005-04-24 17:41:47.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-04-24 17:42:53.000000000 +0200
@@ -531,6 +531,17 @@ static int fuse_file_mmap(struct file *f
 	return generic_file_mmap(file, vma);
 }
 
+static ssize_t fuse_file_sendfile(struct file *file, loff_t *ppos,
+				  size_t count, read_actor_t actor,
+				  void *target)
+{
+	struct fuse_conn *fc = get_fuse_conn(file->f_dentry->d_inode);
+	if (fc->flags & FUSE_DIRECT_IO)
+		return -EINVAL;
+	else
+		return generic_file_sendfile(file, ppos, count, actor, target);
+}
+
 static int fuse_set_page_dirty(struct page *page)
 {
 	printk("fuse_set_page_dirty: should not happen\n");
@@ -547,7 +558,7 @@ static struct file_operations fuse_file_
 	.flush		= fuse_flush,
 	.release	= fuse_release,
 	.fsync		= fuse_fsync,
-	.sendfile	= generic_file_sendfile,
+	.sendfile	= fuse_file_sendfile,
 };
 
 static struct address_space_operations fuse_file_aops  = {
