Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVDXPbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVDXPbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVDXPbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:31:24 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:43928 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262343AbVDXPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:31:21 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: interrupted open fix
Message-Id: <E1DPj4N-0000Nd-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 17:30:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes incorrect behavior of open(..., O_CREAT|O_EXCL) in
case it is interrupted after the file has been created.  In this case
the system call was restarted and returned -EEXIST.  The solution is
not to allow interruption.  Thanks to David Shaw for the bug report
and testing.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.12-rc2-mm3/fs/fuse/file.c	2005-04-22 15:37:21.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-04-22 15:50:32.000000000 +0200
@@ -20,6 +20,9 @@ int fuse_open_common(struct inode *inode
 	struct fuse_open_out outarg;
 	struct fuse_file *ff;
 	int err;
+	/* Restarting the syscall is not allowed if O_CREAT and O_EXCL
+	   are both set, because creation will fail on the restart */
+	int excl = (file->f_flags & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL);
 
 	err = generic_file_open(inode, file);
 	if (err)
@@ -33,9 +36,12 @@ int fuse_open_common(struct inode *inode
 		 	return err;
 	}
 
-	req = fuse_get_request(fc);
+	if (excl)
+		req = fuse_get_request_nonint(fc);
+	else
+		req = fuse_get_request(fc);
 	if (!req)
-		return -ERESTARTSYS;
+		return excl ? -EINTR : -ERESTARTSYS;
 
 	err = -ENOMEM;
 	ff = kmalloc(sizeof(struct fuse_file), GFP_KERNEL);
@@ -59,7 +65,10 @@ int fuse_open_common(struct inode *inode
 	req->out.numargs = 1;
 	req->out.args[0].size = sizeof(outarg);
 	req->out.args[0].value = &outarg;
-	request_send(fc, req);
+	if (excl)
+		request_send_nonint(fc, req);
+	else
+		request_send(fc, req);
 	err = req->out.h.error;
 	if (!err && !(fc->flags & FUSE_KERNEL_CACHE))
 		invalidate_inode_pages(inode->i_mapping);
