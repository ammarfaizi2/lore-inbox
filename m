Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319160AbSHMW7x>; Tue, 13 Aug 2002 18:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319156AbSHMW7R>; Tue, 13 Aug 2002 18:59:17 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:23291 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319147AbSHMW6G>; Tue, 13 Aug 2002 18:58:06 -0400
Date: Tue, 13 Aug 2002 19:01:53 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 14/38: CLIENT: add ->setup_read() nfs_rpc_op for async read,
 part 1
Message-ID: <Pine.SOL.4.44.0208131901270.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a nontrivial change to the NFS client.

Synchronous READ operations are currently done via the ->read() nfs_rpc_op.
Therefore, the synchronous READ path can easily be adapted for NFSv4.  On
the other hand, the asynchronous READ path contains several NFSv3-specific
features, which make it difficult to adapt for NFSv4.

In this patch and the next, we modify the async READ path to be
version-agnostic.  This patch just changes the 'struct nfs_read_data'
so that the v2- and v3-specific parts are moved into a private area,
with room for a v4-specific part in parallel.  None of the logic is
changed.

--- old/fs/nfs/read.c	Wed Jul 24 16:03:17 2002
+++ new/fs/nfs/read.c	Sat Aug 10 22:20:39 2002
@@ -38,11 +38,18 @@ struct nfs_read_data {
 	struct rpc_task		task;
 	struct inode		*inode;
 	struct rpc_cred		*cred;
-	struct nfs_readargs	args;	/* XDR argument struct */
-	struct nfs_readres	res;	/* ... and result struct */
 	struct nfs_fattr	fattr;	/* fattr storage */
 	struct list_head	pages;	/* Coalesced read requests */
 	struct page		*pagevec[NFS_READ_MAXIOV];
+	union {
+		struct {
+			struct nfs_readargs args;
+			struct nfs_readres  res;
+		} v3;   /* also v2 */
+#ifdef CONFIG_NFS_V4
+		/* NFSv4 data will come here... */
+#endif
+	} u;
 };

 /*
@@ -64,7 +71,6 @@ static __inline__ struct nfs_read_data *
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
-		p->args.pages = p->pagevec;
 	}
 	return p;
 }
@@ -194,7 +200,7 @@ nfs_read_rpcsetup(struct list_head *head
 	struct page		**pages;
 	unsigned int		count;

-	pages = data->args.pages;
+	pages = data->pagevec;
 	count = 0;
 	while (!list_empty(head)) {
 		struct nfs_page *req = nfs_list_entry(head->next);
@@ -206,13 +212,14 @@ nfs_read_rpcsetup(struct list_head *head
 	req = nfs_list_entry(data->pages.next);
 	data->inode	  = req->wb_inode;
 	data->cred	  = req->wb_cred;
-	data->args.fh     = NFS_FH(req->wb_inode);
-	data->args.offset = page_offset(req->wb_page) + req->wb_offset;
-	data->args.pgbase = req->wb_offset;
-	data->args.count  = count;
-	data->res.fattr   = &data->fattr;
-	data->res.count   = count;
-	data->res.eof     = 0;
+	data->u.v3.args.fh     = NFS_FH(req->wb_inode);
+	data->u.v3.args.offset = page_offset(req->wb_page) + req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.pages  = pages;
+	data->u.v3.args.count  = count;
+	data->u.v3.res.fattr   = &data->fattr;
+	data->u.v3.res.count   = count;
+	data->u.v3.res.eof     = 0;
 }

 static void
@@ -264,8 +271,8 @@ nfs_pagein_one(struct list_head *head, s
 #else
 	msg.rpc_proc = NFSPROC_READ;
 #endif
-	msg.rpc_argp = &data->args;
-	msg.rpc_resp = &data->res;
+	msg.rpc_argp = &data->u.v3.args;
+	msg.rpc_resp = &data->u.v3.res;
 	msg.rpc_cred = data->cred;

 	/* Start the async call */
@@ -273,8 +280,8 @@ nfs_pagein_one(struct list_head *head, s
 		task->tk_pid,
 		inode->i_sb->s_id,
 		(long long)NFS_FILEID(inode),
-		(unsigned int)data->args.count,
-		(unsigned long long)data->args.offset);
+		(unsigned int)data->u.v3.args.count,
+		(unsigned long long)data->u.v3.args.offset);

 	rpc_clnt_sigmask(clnt, &oldset);
 	rpc_call_setup(task, &msg, 0);
@@ -404,7 +411,7 @@ nfs_readpage_result(struct rpc_task *tas
 {
 	struct nfs_read_data	*data = (struct nfs_read_data *) task->tk_calldata;
 	struct inode		*inode = data->inode;
-	unsigned int		count = data->res.count;
+	unsigned int		count = data->u.v3.res.count;

 	dprintk("NFS: %4d nfs_readpage_result, (status %d)\n",
 		task->tk_pid, task->tk_status);

