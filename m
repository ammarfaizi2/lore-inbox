Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVCUMqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVCUMqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 07:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVCUMqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 07:46:49 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:4492 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261778AbVCUMqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 07:46:46 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: fix locking for background list
Message-Id: <E1DDMIR-0002Hd-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 21 Mar 2005 13:46:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

In the prevous fix (fix busy inodes after unmount) I forgot to protect
against concurrent modification of the background list.  This patch
adds the necessary locking.

Next time I'll think before sending.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm1/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.12-rc1-mm1/fs/fuse/dev.c	2005-03-21 13:34:42.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-03-21 13:35:30.000000000 +0100
@@ -148,7 +148,9 @@ void fuse_release_background(struct fuse
 		iput(req->inode2);
 	if (req->file)
 		fput(req->file);
+	spin_lock(&fuse_lock);
 	list_del(&req->bg_entry);
+	spin_unlock(&fuse_lock);
 }
 
 /* Called with fuse_lock, unlocks it */
@@ -324,7 +326,9 @@ void request_send_noreply(struct fuse_co
 void request_send_background(struct fuse_conn *fc, struct fuse_req *req)
 {
 	req->isreply = 1;
+	spin_lock(&fuse_lock);
 	background_request(fc, req);
+	spin_unlock(&fuse_lock);
 	request_send_nowait(fc, req);
 }
 
diff -rup linux-2.6.12-rc1-mm1/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc1-mm1/fs/fuse/fuse_i.h	2005-03-21 13:34:42.000000000 +0100
+++ linux-fuse/fs/fuse/fuse_i.h	2005-03-21 13:35:30.000000000 +0100
@@ -301,6 +301,7 @@ extern struct file_operations fuse_dev_o
  *  - the private_data field of the device file
  *  - the s_fs_info field of the super block
  *  - unused_list, pending, processing lists in fuse_conn
+ *  - background list in fuse_conn
  *  - the unique request ID counter reqctr in fuse_conn
  *  - the sb (super_block) field in fuse_conn
  *  - the file (device file) field in fuse_conn

