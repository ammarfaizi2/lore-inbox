Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319164AbSHMXBb>; Tue, 13 Aug 2002 19:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319163AbSHMXAk>; Tue, 13 Aug 2002 19:00:40 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:45307 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319147AbSHMW7U>; Tue, 13 Aug 2002 18:59:20 -0400
Date: Tue, 13 Aug 2002 19:03:09 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 17/38: CLIENT: add ->setup_{write,commit}() for async write,
 part 2
Message-ID: <Pine.SOL.4.44.0208131902490.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a nontrivial change to the NFS client.

This patch does for the async WRITE and COMMIT paths what patch 15
did for the async READ path, by defining new nfs_rpc_ops ->setup_write()
and ->setup_commit().

--- old/fs/nfs/write.c	Sat Aug 10 23:12:35 2002
+++ new/fs/nfs/write.c	Tue Aug  6 07:02:07 2002
@@ -64,45 +64,12 @@
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE

 /*
- * Local structures
- *
- * This is the struct where the WRITE/COMMIT arguments go.
- */
-struct nfs_write_data {
-	struct rpc_task		task;
-	struct inode		*inode;
-	struct rpc_cred		*cred;
-	struct nfs_fattr	fattr;
-	struct nfs_writeverf	verf;
-	struct list_head	pages;		/* Coalesced requests we wish to flush */
-	struct page		*pagevec[NFS_WRITE_MAXIOV];
-	union {
-		struct {
-			struct nfs_writeargs args;
-			struct nfs_writeres  res;
-		} v3;
-#ifdef CONFIG_NFS_V4
-		/* NFSv4 data to come here... */
-#endif
-	} u;
-};
-
-/*
  * Local function declarations
  */
 static struct nfs_page * nfs_update_request(struct file*, struct inode *,
 					    struct page *,
 					    unsigned int, unsigned int);
 static void	nfs_strategy(struct inode *inode);
-static void	nfs_writeback_done(struct rpc_task *);
-#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-static void	nfs_commit_done(struct rpc_task *);
-#endif
-
-/* Hack for future NFS swap support */
-#ifndef IS_SWAPFILE
-# define IS_SWAPFILE(inode)	(0)
-#endif

 static kmem_cache_t *nfs_wdata_cachep;

@@ -122,7 +89,7 @@ static __inline__ void nfs_writedata_fre
 	kmem_cache_free(nfs_wdata_cachep, p);
 }

-static void nfs_writedata_release(struct rpc_task *task)
+void nfs_writedata_release(struct rpc_task *task)
 {
 	struct nfs_write_data	*wdata = (struct nfs_write_data *)task->tk_calldata;
 	nfs_writedata_free(wdata);
@@ -861,8 +828,10 @@ done:
  * Set up the argument/result storage required for the RPC call.
  */
 static void
-nfs_write_rpcsetup(struct list_head *head, struct nfs_write_data *data)
+nfs_write_rpcsetup(struct list_head *head, struct nfs_write_data *data, int how)
 {
+	struct rpc_task		*task = &data->task;
+	struct inode		*inode;
 	struct nfs_page		*req;
 	struct page		**pages;
 	unsigned int		count;
@@ -880,18 +849,18 @@ nfs_write_rpcsetup(struct list_head *hea
 		count += req->wb_bytes;
 	}
 	req = nfs_list_entry(data->pages.next);
-	data->inode = req->wb_inode;
+	data->inode = inode = req->wb_inode;
 	data->cred = req->wb_cred;
-	data->u.v3.args.fh     = NFS_FH(req->wb_inode);
-	data->u.v3.args.offset = page_offset(req->wb_page) + req->wb_offset;
-	data->u.v3.args.pgbase = req->wb_offset;
-	data->u.v3.args.pages  = pages;
-	data->u.v3.args.count  = count;
-	data->u.v3.res.fattr   = &data->fattr;
-	data->u.v3.res.count   = count;
-	data->u.v3.res.verf    = &data->verf;
-}

+	NFS_PROTO(inode)->write_setup(data, count, how);
+
+	dprintk("NFS: %4d initiated write call (req %s/%Ld, %u bytes @ offset %Lu)\n",
+		task->tk_pid,
+		inode->i_sb->s_id,
+		(long long)NFS_FILEID(inode),
+		count,
+		(unsigned long long)page_offset(req->wb_page) + req->wb_offset);
+}

 /*
  * Create an RPC task for the given write request and kick it.
@@ -904,64 +873,20 @@ nfs_write_rpcsetup(struct list_head *hea
 static int
 nfs_flush_one(struct list_head *head, struct inode *inode, int how)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
 	struct rpc_clnt 	*clnt = NFS_CLIENT(inode);
 	struct nfs_write_data	*data;
-	struct rpc_task		*task;
-	struct rpc_message	msg;
-	int                     flags,
-				nfsvers = NFS_PROTO(inode)->version,
-				async = !(how & FLUSH_SYNC),
-				stable = (how & FLUSH_STABLE);
 	sigset_t		oldset;

-
 	data = nfs_writedata_alloc();
 	if (!data)
 		goto out_bad;
-	task = &data->task;
-
-	/* Set the initial flags for the task.  */
-	flags = (async) ? RPC_TASK_ASYNC : 0;

 	/* Set up the argument struct */
-	nfs_write_rpcsetup(head, data);
-	if (nfsvers < 3)
-		data->u.v3.args.stable = NFS_FILE_SYNC;
-	else if (stable) {
-		if (!nfsi->ncommit)
-			data->u.v3.args.stable = NFS_FILE_SYNC;
-		else
-			data->u.v3.args.stable = NFS_DATA_SYNC;
-	} else
-		data->u.v3.args.stable = NFS_UNSTABLE;
-
-	/* Finalize the task. */
-	rpc_init_task(task, clnt, nfs_writeback_done, flags);
-	task->tk_calldata = data;
-	/* Release requests */
-	task->tk_release = nfs_writedata_release;
-
-#ifdef CONFIG_NFS_V3
-	msg.rpc_proc = (nfsvers == 3) ? NFS3PROC_WRITE : NFSPROC_WRITE;
-#else
-	msg.rpc_proc = NFSPROC_WRITE;
-#endif
-	msg.rpc_argp = &data->u.v3.args;
-	msg.rpc_resp = &data->u.v3.res;
-	msg.rpc_cred = data->cred;
-
-	dprintk("NFS: %4d initiated write call (req %s/%Ld, %u bytes @ offset %Lu)\n",
-		task->tk_pid,
-		inode->i_sb->s_id,
-		(long long)NFS_FILEID(inode),
-		(unsigned int)data->u.v3.args.count,
-		(unsigned long long)data->u.v3.args.offset);
+	nfs_write_rpcsetup(head, data, how);

 	rpc_clnt_sigmask(clnt, &oldset);
-	rpc_call_setup(task, &msg, 0);
 	lock_kernel();
-	rpc_execute(task);
+	rpc_execute(&data->task);
 	unlock_kernel();
 	rpc_clnt_sigunmask(clnt, &oldset);
 	return 0;
@@ -1006,12 +931,11 @@ nfs_flush_list(struct list_head *head, i
 /*
  * This function is called when the WRITE call is complete.
  */
-static void
-nfs_writeback_done(struct rpc_task *task)
+void
+nfs_writeback_done(struct rpc_task *task, int stable,
+		   unsigned int arg_count, unsigned int res_count)
 {
 	struct nfs_write_data	*data = (struct nfs_write_data *) task->tk_calldata;
-	struct nfs_writeargs	*argp = &data->u.v3.args;
-	struct nfs_writeres	*resp = &data->u.v3.res;
 	struct inode		*inode = data->inode;
 	struct nfs_page		*req;
 	struct page		*page;
@@ -1019,11 +943,8 @@ nfs_writeback_done(struct rpc_task *task
 	dprintk("NFS: %4d nfs_writeback_done (status %d)\n",
 		task->tk_pid, task->tk_status);

-	if (nfs_async_handle_jukebox(task))
-		return;
-
 	/* We can't handle that yet but we check for it nevertheless */
-	if (resp->count < argp->count && task->tk_status >= 0) {
+	if (res_count < arg_count && task->tk_status >= 0) {
 		static unsigned long    complain;
 		if (time_before(complain, jiffies)) {
 			printk(KERN_WARNING
@@ -1035,7 +956,7 @@ nfs_writeback_done(struct rpc_task *task
 		task->tk_status = -EIO;
 	}
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-	if (resp->verf->committed < argp->stable && task->tk_status >= 0) {
+	if (data->verf.committed < stable && task->tk_status >= 0) {
 		/* We tried a write call, but the server did not
 		 * commit data to stable storage even though we
 		 * requested it.
@@ -1047,10 +968,10 @@ nfs_writeback_done(struct rpc_task *task
 		static unsigned long    complain;

 		if (time_before(complain, jiffies)) {
-			dprintk("NFS: faulty NFSv3 server %s:"
+			dprintk("NFS: faulty NFS server %s:"
 				" (committed = %d) != (stable = %d)\n",
 				NFS_SERVER(inode)->hostname,
-				resp->verf->committed, argp->stable);
+				data->verf.committed, stable);
 			complain = jiffies + 300 * HZ;
 		}
 	}
@@ -1062,7 +983,7 @@ nfs_writeback_done(struct rpc_task *task
 	 *	  writebacks since the page->count is kept > 1 for as long
 	 *	  as the page has a write request pending.
 	 */
-	nfs_write_attributes(inode, resp->fattr);
+	nfs_write_attributes(inode, &data->fattr);
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
@@ -1085,12 +1006,12 @@ nfs_writeback_done(struct rpc_task *task
 		}

 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-		if (argp->stable != NFS_UNSTABLE || resp->verf->committed == NFS_FILE_SYNC) {
+		if (stable != NFS_UNSTABLE || data->verf.committed == NFS_FILE_SYNC) {
 			nfs_inode_remove_request(req);
 			dprintk(" OK\n");
 			goto next;
 		}
-		memcpy(&req->wb_verf, resp->verf, sizeof(req->wb_verf));
+		memcpy(&req->wb_verf, &data->verf, sizeof(req->wb_verf));
 		req->wb_timeout = jiffies + NFS_COMMIT_DELAY;
 		nfs_mark_request_commit(req);
 		dprintk(" marked for commit\n");
@@ -1108,8 +1029,9 @@ nfs_writeback_done(struct rpc_task *task
  * Set up the argument/result storage required for the RPC call.
  */
 static void
-nfs_commit_rpcsetup(struct list_head *head, struct nfs_write_data *data)
+nfs_commit_rpcsetup(struct list_head *head, struct nfs_write_data *data, int how)
 {
+	struct rpc_task		*task = &data->task;
 	struct nfs_page		*first, *last;
 	struct inode		*inode;
 	loff_t			start, end, len;
@@ -1135,11 +1057,10 @@ nfs_commit_rpcsetup(struct list_head *he

 	data->inode	  = inode;
 	data->cred	  = first->wb_cred;
-	data->u.v3.args.fh     = NFS_FH(inode);
-	data->u.v3.args.offset = start;
-	data->u.v3.res.count   = data->u.v3.args.count = (u32)len;
-	data->u.v3.res.fattr   = &data->fattr;
-	data->u.v3.res.verf    = &data->verf;
+
+	NFS_PROTO(inode)->commit_setup(data, start, len, how);
+
+	dprintk("NFS: %4d initiated commit call\n", task->tk_pid);
 }

 /*
@@ -1148,43 +1069,23 @@ nfs_commit_rpcsetup(struct list_head *he
 int
 nfs_commit_list(struct list_head *head, int how)
 {
-	struct rpc_message	msg;
 	struct rpc_clnt		*clnt;
 	struct nfs_write_data	*data;
-	struct rpc_task         *task;
 	struct nfs_page         *req;
-	int                     flags,
-				async = !(how & FLUSH_SYNC);
 	sigset_t		oldset;

 	data = nfs_writedata_alloc();

 	if (!data)
 		goto out_bad;
-	task = &data->task;
-
-	flags = (async) ? RPC_TASK_ASYNC : 0;

 	/* Set up the argument struct */
-	nfs_commit_rpcsetup(head, data);
-	req = nfs_list_entry(data->pages.next);
-	clnt = NFS_CLIENT(req->wb_inode);
+	nfs_commit_rpcsetup(head, data, how);
+	clnt = NFS_CLIENT(data->inode);

-	rpc_init_task(task, clnt, nfs_commit_done, flags);
-	task->tk_calldata = data;
-	/* Release requests */
-	task->tk_release = nfs_writedata_release;
-
-	msg.rpc_proc = NFS3PROC_COMMIT;
-	msg.rpc_argp = &data->u.v3.args;
-	msg.rpc_resp = &data->u.v3.res;
-	msg.rpc_cred = data->cred;
-
-	dprintk("NFS: %4d initiated commit call\n", task->tk_pid);
 	rpc_clnt_sigmask(clnt, &oldset);
-	rpc_call_setup(task, &msg, 0);
 	lock_kernel();
-	rpc_execute(task);
+	rpc_execute(&data->task);
 	unlock_kernel();
 	rpc_clnt_sigunmask(clnt, &oldset);
 	return 0;
@@ -1201,21 +1102,17 @@ nfs_commit_list(struct list_head *head,
 /*
  * COMMIT call returned
  */
-static void
+void
 nfs_commit_done(struct rpc_task *task)
 {
 	struct nfs_write_data	*data = (struct nfs_write_data *)task->tk_calldata;
-	struct nfs_writeres	*resp = &data->u.v3.res;
 	struct nfs_page		*req;
 	struct inode		*inode = data->inode;

         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);

-	if (nfs_async_handle_jukebox(task))
-		return;
-
-	nfs_write_attributes(inode, resp->fattr);
+	nfs_write_attributes(inode, &data->fattr);
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
--- old/include/linux/nfs_fs.h	Sat Aug 10 22:48:15 2002
+++ new/include/linux/nfs_fs.h	Thu Aug  8 18:10:03 2002
@@ -297,6 +297,14 @@ extern void nfs_complete_unlink(struct d
 extern int  nfs_writepage(struct page *);
 extern int  nfs_flush_incompatible(struct file *file, struct page *page);
 extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned int);
+extern void nfs_writeback_done(struct rpc_task *task, int stable,
+			       unsigned int arg_count, unsigned int res_count);
+extern void nfs_writedata_release(struct rpc_task *task);
+
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
+extern void nfs_commit_done(struct rpc_task *);
+#endif
+
 /*
  * Try to write back everything synchronously (but check the
  * return value!)
--- old/include/linux/nfs_xdr.h	Sat Aug 10 22:48:15 2002
+++ new/include/linux/nfs_xdr.h	Sat Aug 10 23:26:29 2002
@@ -316,6 +316,25 @@ struct nfs_read_data {
 	} u;
 };

+struct nfs_write_data {
+	struct rpc_task		task;
+	struct inode		*inode;
+	struct rpc_cred		*cred;
+	struct nfs_fattr	fattr;
+	struct nfs_writeverf	verf;
+	struct list_head	pages;		/* Coalesced requests we wish to flush */
+	struct page		*pagevec[NFS_WRITE_MAXIOV];
+	union {
+		struct {
+			struct nfs_writeargs args;
+			struct nfs_writeres  res;
+		} v3;
+#ifdef CONFIG_NFS_V4
+		/* NFSv4 data to come here... */
+#endif
+	} u;
+};
+
 /*
  * RPC procedure vector for NFSv2/NFSv3 demuxing
  */
@@ -364,6 +383,8 @@ struct nfs_rpc_ops {
 			    struct nfs_fsinfo *);
 	u32 *	(*decode_dirent)(u32 *, struct nfs_entry *, int plus);
 	void	(*read_setup)   (struct nfs_read_data *, unsigned int count);
+	void	(*write_setup)  (struct nfs_write_data *, unsigned int count, int how);
+	void	(*commit_setup) (struct nfs_write_data *, u64 start, u32 len, int how);
 };

 /*
--- old/fs/nfs/proc.c	Sat Aug 10 22:48:15 2002
+++ new/fs/nfs/proc.c	Tue Aug  6 10:15:51 2002
@@ -512,6 +512,58 @@ nfs_proc_read_setup(struct nfs_read_data
 	rpc_call_setup(&data->task, &msg, 0);
 }

+static void
+nfs_write_done(struct rpc_task *task)
+{
+	struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;
+	nfs_writeback_done(task, data->u.v3.args.stable,
+			   data->u.v3.args.count, data->u.v3.res.count);
+}
+
+static void
+nfs_proc_write_setup(struct nfs_write_data *data, unsigned int count, int how)
+{
+	struct rpc_task		*task = &data->task;
+	struct inode		*inode = data->inode;
+	struct nfs_page		*req;
+	int			flags;
+	struct rpc_message	msg;
+
+	/* Note: NFSv2 ignores @stable and always uses NFS_FILE_SYNC */
+
+	req = nfs_list_entry(data->pages.next);
+	data->u.v3.args.fh     = NFS_FH(inode);
+	data->u.v3.args.offset = page_offset(req->wb_page) + req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.count  = count;
+	data->u.v3.args.stable = NFS_FILE_SYNC;
+	data->u.v3.args.pages  = data->pagevec;
+	data->u.v3.res.fattr   = &data->fattr;
+	data->u.v3.res.count   = count;
+	data->u.v3.res.verf    = &data->verf;
+
+	/* Set the initial flags for the task.  */
+	flags = (how & FLUSH_SYNC) ? 0 : RPC_TASK_ASYNC;
+
+	/* Finalize the task. */
+	rpc_init_task(task, NFS_CLIENT(inode), nfs_write_done, flags);
+	task->tk_calldata = data;
+	/* Release requests */
+	task->tk_release = nfs_writedata_release;
+
+	msg.rpc_proc = NFSPROC_WRITE;
+	msg.rpc_argp = &data->u.v3.args;
+	msg.rpc_resp = &data->u.v3.res;
+	msg.rpc_cred = data->cred;
+	rpc_call_setup(&data->task, &msg, 0);
+}
+
+static void
+nfs_proc_commit_setup(struct nfs_write_data *data, u64 start, u32 len, int how)
+{
+	BUG();
+}
+
 struct nfs_rpc_ops	nfs_v2_clientops = {
 	version:	2,		       /* protocol version */
 	getroot:	nfs_proc_get_root,
@@ -537,4 +589,6 @@ struct nfs_rpc_ops	nfs_v2_clientops = {
 	statfs:		nfs_proc_statfs,
 	decode_dirent:	nfs_decode_dirent,
 	read_setup:	nfs_proc_read_setup,
+	write_setup:	nfs_proc_write_setup,
+	commit_setup:	nfs_proc_commit_setup,
 };
--- old/fs/nfs/nfs3proc.c	Sat Aug 10 22:48:15 2002
+++ new/fs/nfs/nfs3proc.c	Tue Aug  6 10:15:40 2002
@@ -687,6 +687,101 @@ nfs3_proc_read_setup(struct nfs_read_dat
 	rpc_call_setup(&data->task, &msg, 0);
 }

+static void
+nfs3_write_done(struct rpc_task *task)
+{
+	struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;
+
+	if (nfs_async_handle_jukebox(task))
+		return;
+	nfs_writeback_done(task, data->u.v3.args.stable,
+			   data->u.v3.args.count, data->u.v3.res.count);
+}
+
+static void
+nfs3_proc_write_setup(struct nfs_write_data *data, unsigned int count, int how)
+{
+	struct rpc_task		*task = &data->task;
+	struct inode		*inode = data->inode;
+	struct nfs_page		*req;
+	int			stable;
+	int			flags;
+	struct rpc_message	msg;
+
+	if (how & FLUSH_STABLE) {
+		if (!NFS_I(inode)->ncommit)
+			stable = NFS_FILE_SYNC;
+		else
+			stable = NFS_DATA_SYNC;
+	} else
+		stable = NFS_UNSTABLE;
+
+	req = nfs_list_entry(data->pages.next);
+	data->u.v3.args.fh     = NFS_FH(inode);
+	data->u.v3.args.offset = page_offset(req->wb_page) + req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.count  = count;
+	data->u.v3.args.stable = stable;
+	data->u.v3.args.pages  = data->pagevec;
+	data->u.v3.res.fattr   = &data->fattr;
+	data->u.v3.res.count   = count;
+	data->u.v3.res.verf    = &data->verf;
+
+	/* Set the initial flags for the task.  */
+	flags = (how & FLUSH_SYNC) ? 0 : RPC_TASK_ASYNC;
+
+	/* Finalize the task. */
+	rpc_init_task(task, NFS_CLIENT(inode), nfs3_write_done, flags);
+	task->tk_calldata = data;
+	/* Release requests */
+	task->tk_release = nfs_writedata_release;
+
+	msg.rpc_proc = NFS3PROC_WRITE;
+	msg.rpc_argp = &data->u.v3.args;
+	msg.rpc_resp = &data->u.v3.res;
+	msg.rpc_cred = data->cred;
+	rpc_call_setup(&data->task, &msg, 0);
+}
+
+static void
+nfs3_commit_done(struct rpc_task *task)
+{
+	if (nfs_async_handle_jukebox(task))
+		return;
+	nfs_commit_done(task);
+}
+
+static void
+nfs3_proc_commit_setup(struct nfs_write_data *data, u64 start, u32 len, int how)
+{
+	struct rpc_task		*task = &data->task;
+	struct inode		*inode = data->inode;
+	int			flags;
+	struct rpc_message	msg;
+
+	data->u.v3.args.fh     = NFS_FH(data->inode);
+	data->u.v3.args.offset = start;
+	data->u.v3.args.count  = len;
+	data->u.v3.res.count   = len;
+	data->u.v3.res.fattr   = &data->fattr;
+	data->u.v3.res.verf    = &data->verf;
+
+	/* Set the initial flags for the task.  */
+	flags = (how & FLUSH_SYNC) ? 0 : RPC_TASK_ASYNC;
+
+	/* Finalize the task. */
+	rpc_init_task(task, NFS_CLIENT(inode), nfs3_commit_done, flags);
+	task->tk_calldata = data;
+	/* Release requests */
+	task->tk_release = nfs_writedata_release;
+
+	msg.rpc_proc = NFS3PROC_COMMIT;
+	msg.rpc_argp = &data->u.v3.args;
+	msg.rpc_resp = &data->u.v3.res;
+	msg.rpc_cred = data->cred;
+	rpc_call_setup(&data->task, &msg, 0);
+}
+
 struct nfs_rpc_ops	nfs_v3_clientops = {
 	version:	3,			/* protocol version */
 	getroot:	nfs3_proc_get_root,
@@ -711,4 +806,6 @@ struct nfs_rpc_ops	nfs_v3_clientops = {
 	statfs:		nfs3_proc_statfs,
 	decode_dirent:	nfs3_decode_dirent,
 	read_setup:	nfs3_proc_read_setup,
+	write_setup:	nfs3_proc_write_setup,
+	commit_setup:	nfs3_proc_commit_setup,
 };

