Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319303AbSHNUnM>; Wed, 14 Aug 2002 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSHNUmF>; Wed, 14 Aug 2002 16:42:05 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:47061 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319297AbSHNUlJ>; Wed, 14 Aug 2002 16:41:09 -0400
Date: Wed, 14 Aug 2002 16:44:59 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 17/38: CLIENT: move nfs_async_handle_jukebox() into
 ->unlink_done()
Message-ID: <Pine.SOL.4.44.0208141644340.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In NFSv3, an RPC is retried if the special error NFSERR_JUKEBOX is
received.  This generic bit of postprocessing happens invisibly for
synchronous RPC's, but in the async case, the ->tk_exit callback
must call nfs_async_handle_jukebox() by hand.

In NFSv4, we also need generic postprocessing of async RPC's, but
the details are different.  Therefore, we don't want to call
nfs_async_handle_jukebox(); we want to call a different, NFSv4-specific
routine.  Therefore, we want to move calls to nfs_async_handle_jukebox()
out of the "generic" NFS code and into NFSv3-specific routines.  This
has already been done for async READ and WRITE in the preceding patches,
but there is still one outstanding case: the async REMOVE in sillyrename.

This patch removes nfs_async_handle_jukebox() from the async sillyrename
path, and puts in the NFSv3 ->unlink_done() rpc_op.

--- old/fs/nfs/nfs3proc.c	Sun Aug 11 21:58:52 2002
+++ new/fs/nfs/nfs3proc.c	Sun Aug 11 22:18:11 2002
@@ -392,16 +392,20 @@ nfs3_proc_unlink_setup(struct rpc_messag
 	return 0;
 }

-static void
-nfs3_proc_unlink_done(struct dentry *dir, struct rpc_message *msg)
+static int
+nfs3_proc_unlink_done(struct dentry *dir, struct rpc_task *task)
 {
+	struct rpc_message *msg = &task->tk_msg;
 	struct nfs_fattr	*dir_attr;

+	if (nfs_async_handle_jukebox(task))
+		return 1;
 	if (msg->rpc_argp) {
 		dir_attr = (struct nfs_fattr*)msg->rpc_resp;
 		nfs_refresh_inode(dir->d_inode, dir_attr);
 		kfree(msg->rpc_argp);
 	}
+	return 0;
 }

 static int
--- old/fs/nfs/proc.c	Sun Aug 11 21:58:52 2002
+++ new/fs/nfs/proc.c	Sun Aug 11 22:18:11 2002
@@ -312,13 +312,16 @@ nfs_proc_unlink_setup(struct rpc_message
 	return 0;
 }

-static void
-nfs_proc_unlink_done(struct dentry *dir, struct rpc_message *msg)
+static int
+nfs_proc_unlink_done(struct dentry *dir, struct rpc_task *task)
 {
+	struct rpc_message *msg = &task->tk_msg;
+
 	if (msg->rpc_argp) {
 		NFS_CACHEINV(dir->d_inode);
 		kfree(msg->rpc_argp);
 	}
+	return 0;
 }

 static int
--- old/fs/nfs/unlink.c	Thu Aug  1 16:16:39 2002
+++ new/fs/nfs/unlink.c	Sun Aug 11 22:18:11 2002
@@ -123,13 +123,12 @@ nfs_async_unlink_done(struct rpc_task *t
 	struct dentry		*dir = data->dir;
 	struct inode		*dir_i;

-	if (nfs_async_handle_jukebox(task))
-		return;
 	if (!dir)
 		return;
 	dir_i = dir->d_inode;
 	nfs_zap_caches(dir_i);
-	NFS_PROTO(dir_i)->unlink_done(dir, &task->tk_msg);
+	if (NFS_PROTO(dir_i)->unlink_done(dir, task))
+		return;
 	put_rpccred(data->cred);
 	data->cred = NULL;
 	dput(dir);
--- old/include/linux/nfs_xdr.h	Sun Aug 11 21:58:52 2002
+++ new/include/linux/nfs_xdr.h	Sun Aug 11 22:18:11 2002
@@ -366,7 +366,7 @@ struct nfs_rpc_ops {
 	int	(*remove)  (struct inode *, struct qstr *);
 	int	(*unlink_setup)  (struct rpc_message *,
 			    struct dentry *, struct qstr *);
-	void	(*unlink_done) (struct dentry *, struct rpc_message *);
+	int	(*unlink_done) (struct dentry *, struct rpc_task *);
 	int	(*rename)  (struct inode *, struct qstr *,
 			    struct inode *, struct qstr *);
 	int	(*link)    (struct inode *, struct inode *, struct qstr *);

