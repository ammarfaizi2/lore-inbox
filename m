Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVIWOTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVIWOTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVIWOTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:19:04 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:37387 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751006AbVIWOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:19:03 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fuse: check reserved node ID values 
Message-Id: <E1EIoNz-0006RR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Sep 2005 16:18:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks reserved node ID values returned by lookup and
creation operations.  In case one of the reserved values is sent,
return -EIO.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2005-09-23 14:58:09.000000000 +0200
+++ linux/fs/fuse/dir.c	2005-09-23 15:22:37.000000000 +0200
@@ -96,6 +96,8 @@ static int fuse_lookup_iget(struct inode
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
+	if (!err && (!outarg.nodeid || outarg.nodeid == FUSE_ROOT_ID))
+		err = -EIO;
 	if (!err) {
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 				  &outarg.attr);
@@ -152,6 +154,10 @@ static int create_new_entry(struct fuse_
 		fuse_put_request(fc, req);
 		return err;
 	}
+	if (!outarg.nodeid || outarg.nodeid == FUSE_ROOT_ID) {
+		fuse_put_request(fc, req);
+		return -EIO;
+	}
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr);
 	if (!inode) {
