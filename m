Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVAZXSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVAZXSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVAZXRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:17:42 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:12192 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262283AbVAZRlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:41:10 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - fix hard link operation
Message-Id: <E1Ctr9s-0000Pm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Jan 2005 18:40:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a bug in link, where the wrong inode number was
passed to userspace as the link source.

Needs update to fuse library to 2.2-pre6 as well.

Please apply.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.11-rc2-mm1/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.11-rc2-mm1/fs/fuse/dir.c	2005-01-26 18:30:47.000000000 +0100
+++ linux-fuse/fs/fuse/dir.c	2005-01-26 18:18:58.000000000 +0100
@@ -360,9 +360,9 @@ static int fuse_link(struct dentry *entr
 		return -ERESTARTNOINTR;
 
 	memset(&inarg, 0, sizeof(inarg));
-	inarg.newdir = get_node_id(newdir);
+	inarg.oldnodeid = get_node_id(inode);
 	req->in.h.opcode = FUSE_LINK;
-	req->inode2 = newdir;
+	req->inode2 = inode;
 	req->in.numargs = 2;
 	req->in.args[0].size = sizeof(inarg);
 	req->in.args[0].value = &inarg;
diff -rup linux-2.6.11-rc2-mm1/include/linux/fuse.h linux-fuse/include/linux/fuse.h
--- linux-2.6.11-rc2-mm1/include/linux/fuse.h	2005-01-26 18:30:53.000000000 +0100
+++ linux-fuse/include/linux/fuse.h	2005-01-26 18:18:58.000000000 +0100
@@ -133,7 +133,7 @@ struct fuse_rename_in {
 };
 
 struct fuse_link_in {
-	__u64	newdir;
+	__u64	oldnodeid;
 };
 
 struct fuse_setattr_in {
