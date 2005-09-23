Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVIWOVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVIWOVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVIWOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:21:39 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:38411 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751010AbVIWOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:21:39 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] fuse: check O_DIRECT
Message-Id: <E1EIoQZ-0006Rz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Sep 2005 16:21:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check O_DIRECT and return -EINVAL error in open.  dentry_open() also
checks this but only after the open method is called.  This patch
optimizes away the unnecessary upcalls in this case.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2005-09-21 11:55:45.000000000 +0200
+++ linux/fs/fuse/file.c	2005-09-23 15:24:23.000000000 +0200
@@ -23,6 +23,10 @@ int fuse_open_common(struct inode *inode
 	struct fuse_file *ff;
 	int err;
 
+	/* VFS checks this, but only _after_ ->open() */
+	if (file->f_flags & O_DIRECT)
+		return -EINVAL;
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
