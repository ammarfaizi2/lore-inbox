Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWFHIX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWFHIX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFHIX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:23:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8241 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932547AbWFHIX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:23:58 -0400
Date: Thu, 8 Jun 2006 10:26:39 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, torvalds@osdl.org
Subject: [PATCH] debugfs inode leak
Message-ID: <20060608082638.GY5207@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looking at the reiser4 crash, I found a leak in debugfs. In
debugfs_mknod(), we create the inode before checking if the dentry
already has one attached. We don't free it if that is the case.

These bugs happen quite often, I'm starting to think we should disallow
such coding in CodingStyle.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 85d166c..b55b4ea 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -67,12 +67,13 @@ static struct inode *debugfs_get_inode(s
 static int debugfs_mknod(struct inode *dir, struct dentry *dentry,
 			 int mode, dev_t dev)
 {
-	struct inode *inode = debugfs_get_inode(dir->i_sb, mode, dev);
+	struct inode *inode;
 	int error = -EPERM;
 
 	if (dentry->d_inode)
 		return -EEXIST;
 
+	inode = debugfs_get_inode(dir->i_sb, mode, dev);
 	if (inode) {
 		d_instantiate(dentry, inode);
 		dget(dentry);

-- 
Jens Axboe

