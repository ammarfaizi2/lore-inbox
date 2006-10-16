Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWJPQ2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWJPQ2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbWJPQ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:39 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:27337 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1422741AbWJPQ2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:23 -0400
Message-Id: <20061016162737.228987000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:13 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 04/12] fuse: fix spurious BUG
Content-Disposition: inline; filename=fuse_iget_race_fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spurious BUG in an unlikely race, where at least three parallel
lookups return the same inode, but with different file type.  This has
not yet been observed in real life.

Allowing unlimited retries could delay fuse_iget() indefinitely, but
this is really for the broken userspace filesystem to worry about.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 16:08:00.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 16:08:08.000000000 +0200
@@ -172,7 +172,6 @@ struct inode *fuse_iget(struct super_blo
 	struct inode *inode;
 	struct fuse_inode *fi;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
-	int retried = 0;
 
  retry:
 	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
@@ -186,11 +185,9 @@ struct inode *fuse_iget(struct super_blo
 		fuse_init_inode(inode, attr);
 		unlock_new_inode(inode);
 	} else if ((inode->i_mode ^ attr->mode) & S_IFMT) {
-		BUG_ON(retried);
 		/* Inode has changed type, any I/O on the old should fail */
 		make_bad_inode(inode);
 		iput(inode);
-		retried = 1;
 		goto retry;
 	}
 

--
