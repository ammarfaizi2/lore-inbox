Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319300AbSHNUlv>; Wed, 14 Aug 2002 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319299AbSHNUkr>; Wed, 14 Aug 2002 16:40:47 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:24277 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319297AbSHNUju>; Wed, 14 Aug 2002 16:39:50 -0400
Date: Wed, 14 Aug 2002 16:43:40 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 15/38: CLIENT: add ->setup_{write,commit}() for async
 write, part 1
Message-ID: <Pine.SOL.4.44.0208141643050.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a nontrivial change to the NFS client.

This patch does for the async WRITE and COMMIT paths what patch 14
did for the async READ path, by changing 'struct nfs_write_data'
so that the v2- and v3-specific parts are moved into a private area,
with room for a v4-specific part in parallel.  None of the logic is
changed.

--- old/fs/nfs/write.c	Sun Aug 11 21:43:37 2002
+++ new/fs/nfs/write.c	Sun Aug 11 21:42:12 2002
@@ -72,12 +72,19 @@ struct nfs_write_data {
 	struct rpc_task		task;
 	struct inode		*inode;
 	struct rpc_cred		*cred;
-	struct nfs_writeargs	args;		/* argument struct */
-	struct nfs_writeres	res;		/* result struct */
 	struct nfs_fattr	fattr;
 	struct nfs_writeverf	verf;
 	struct list_head	pages;		/* Coalesced requests we wish to flush */
 	struct page		*pagevec[NFS_WRITE_MAXIOV];
+	union {
+		struct {
+			struct nfs_writeargs args;
+			struct nfs_writeres  res;
+		} v3;
+#ifdef CONFIG_NFS_V4
+		/* NFSv4 data to come here... */
+#endif
+	} u;
 };

 /*
@@ -106,7 +113,7 @@ static __inline__ struct nfs_write_data
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->pages);
-		p->args.pages = p->pagevec;
+		p->u.v3.args.pages = p->pagevec;
 	}
 	return p;
 }
@@ -871,10 +878,10 @@ nfs_write_rpcsetup(struct list_head *hea
 	/* Set up the RPC argument and reply structs
 	 * NB: take care not to mess about with data->commit et al. */

-	pages = data->args.pages;
+	pages = data->u.v3.args.pages;
 	count = 0;
 	while (!list_empty(head)) {
-		struct nfs_page *req = nfs_list_entry(head->next);
+		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_list_add_request(req, &data->pages);
 		*pages++ = req->wb_page;
@@ -883,13 +890,13 @@ nfs_write_rpcsetup(struct list_head *hea
 	req = nfs_list_entry(data->pages.next);
 	data->inode = req->wb_inode;
 	data->cred = req->wb_cred;
-	data->args.fh     = NFS_FH(req->wb_inode);
-	data->args.offset = page_offset(req->wb_page) + req->wb_offset;
-	data->args.pgbase = req->wb_offset;
-	data->args.count  = count;
-	data->res.fattr   = &data->fattr;
-	data->res.count   = count;
-	data->res.verf    = &data->verf;
+	data->u.v3.args.fh     = NFS_FH(req->wb_inode);
+	data->u.v3.args.offset = page_offset(req->wb_page) + req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.count  = count;
+	data->u.v3.res.fattr   = &data->fattr;
+	data->u.v3.res.count   = count;
+	data->u.v3.res.verf    = &data->verf;
 }


@@ -927,14 +934,14 @@ nfs_flush_one(struct list_head *head, st
 	/* Set up the argument struct */
 	nfs_write_rpcsetup(head, data);
 	if (nfsvers < 3)
-		data->args.stable = NFS_FILE_SYNC;
+		data->u.v3.args.stable = NFS_FILE_SYNC;
 	else if (stable) {
 		if (!nfsi->ncommit)
-			data->args.stable = NFS_FILE_SYNC;
+			data->u.v3.args.stable = NFS_FILE_SYNC;
 		else
-			data->args.stable = NFS_DATA_SYNC;
+			data->u.v3.args.stable = NFS_DATA_SYNC;
 	} else
-		data->args.stable = NFS_UNSTABLE;
+		data->u.v3.args.stable = NFS_UNSTABLE;

 	/* Finalize the task. */
 	rpc_init_task(task, clnt, nfs_writeback_done, flags);
@@ -947,16 +954,16 @@ nfs_flush_one(struct list_head *head, st
 #else
 	msg.rpc_proc = NFSPROC_WRITE;
 #endif
-	msg.rpc_argp = &data->args;
-	msg.rpc_resp = &data->res;
+	msg.rpc_argp = &data->u.v3.args;
+	msg.rpc_resp = &data->u.v3.res;
 	msg.rpc_cred = data->cred;

 	dprintk("NFS: %4d initiated write call (req %s/%Ld, %u bytes @ offset %Lu)\n",
 		task->tk_pid,
 		inode->i_sb->s_id,
 		(long long)NFS_FILEID(inode),
-		(unsigned int)data->args.count,
-		(unsigned long long)data->args.offset);
+		(unsigned int)data->u.v3.args.count,
+		(unsigned long long)data->u.v3.args.offset);

 	rpc_clnt_sigmask(clnt, &oldset);
 	rpc_call_setup(task, &msg, 0);
@@ -1010,8 +1017,8 @@ static void
 nfs_writeback_done(struct rpc_task *task)
 {
 	struct nfs_write_data	*data = (struct nfs_write_data *) task->tk_calldata;
-	struct nfs_writeargs	*argp = &data->args;
-	struct nfs_writeres	*resp = &data->res;
+	struct nfs_writeargs	*argp = &data->u.v3.args;
+	struct nfs_writeres	*resp = &data->u.v3.res;
 	struct inode		*inode = data->inode;
 	struct nfs_page		*req;
 	struct page		*page;
@@ -1135,11 +1142,11 @@ nfs_commit_rpcsetup(struct list_head *he

 	data->inode	  = inode;
 	data->cred	  = first->wb_cred;
-	data->args.fh     = NFS_FH(inode);
-	data->args.offset = start;
-	data->res.count   = data->args.count = (u32)len;
-	data->res.fattr   = &data->fattr;
-	data->res.verf    = &data->verf;
+	data->u.v3.args.fh     = NFS_FH(inode);
+	data->u.v3.args.offset = start;
+	data->u.v3.res.count   = data->u.v3.args.count = (u32)len;
+	data->u.v3.res.fattr   = &data->fattr;
+	data->u.v3.res.verf    = &data->verf;
 }

 /*
@@ -1176,8 +1183,8 @@ nfs_commit_list(struct list_head *head,
 	task->tk_release = nfs_writedata_release;

 	msg.rpc_proc = NFS3PROC_COMMIT;
-	msg.rpc_argp = &data->args;
-	msg.rpc_resp = &data->res;
+	msg.rpc_argp = &data->u.v3.args;
+	msg.rpc_resp = &data->u.v3.res;
 	msg.rpc_cred = data->cred;

 	dprintk("NFS: %4d initiated commit call\n", task->tk_pid);
@@ -1205,7 +1212,7 @@ static void
 nfs_commit_done(struct rpc_task *task)
 {
 	struct nfs_write_data	*data = (struct nfs_write_data *)task->tk_calldata;
-	struct nfs_writeres	*resp = &data->res;
+	struct nfs_writeres	*resp = &data->u.v3.res;
 	struct nfs_page		*req;
 	struct inode		*inode = data->inode;


