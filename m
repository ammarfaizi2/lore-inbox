Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWG0NA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWG0NA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWG0NA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:00:58 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:20426 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1161044AbWG0NA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:00:57 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 27 Jul 2006 14:55:30 +0200)
Subject: [PATCH 4/5] fuse: use dentry in statfs
References: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1G65Tc-0002iG-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Jul 2006 15:00:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some filesystems may want to report different values depending on the
path within the filesystem, i.e. one mount is actually several
filesystems.  This can be the case for a network filesystem exported
by an unprivileged server (e.g. sshfs).

This is now possible, thanks to David Howells "VFS: Permit filesystem
to perform statfs with a known root dentry" patch.

This change is backward compatible, so no need to change interface
version.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-07-27 14:38:04.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-07-27 14:38:12.000000000 +0200
@@ -252,6 +252,7 @@ static int fuse_statfs(struct dentry *de
 	memset(&outarg, 0, sizeof(outarg));
 	req->in.numargs = 0;
 	req->in.h.opcode = FUSE_STATFS;
+	req->in.h.nodeid = get_node_id(dentry->d_inode);
 	req->out.numargs = 1;
 	req->out.args[0].size =
 		fc->minor < 4 ? FUSE_COMPAT_STATFS_SIZE : sizeof(outarg);
