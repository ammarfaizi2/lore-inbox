Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVDXP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVDXP1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVDXP1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:27:08 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:42136 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262342AbVDXP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:27:06 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: nfsd directory fsync fix
Message-Id: <E1DPj0P-0000NC-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 17:26:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an Oops which happens when nfsd calls fsync on a
directory with a NULL file argument.  The solution is to just ignore
the fsync.  Thanks to David Shaw for the bugreport.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc2-mm3/fs/fuse/dir.c	2005-04-22 15:49:29.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-04-22 15:50:32.000000000 +0200
@@ -590,7 +590,8 @@ static int fuse_dir_release(struct inode
 
 static int fuse_dir_fsync(struct file *file, struct dentry *de, int datasync)
 {
-	return fuse_fsync_common(file, de, datasync, 1);
+	/* nfsd can call this with no file */
+	return file ? fuse_fsync_common(file, de, datasync, 1) : 0;
 }
 
 static unsigned iattr_to_fattr(struct iattr *iattr, struct fuse_attr *fattr)
