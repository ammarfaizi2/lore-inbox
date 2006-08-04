Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161294AbWHDQpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161294AbWHDQpP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWHDQpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:45:14 -0400
Received: from pat.uio.no ([129.240.10.4]:35232 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161294AbWHDQpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:45:12 -0400
Subject: [GIT] NFS client fixes for 2.6.18-rc3
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 04 Aug 2006 12:45:02 -0400
Message-Id: <1154709903.4727.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.836, required 12,
	autolearn=disabled, AWL 0.65, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git fixes

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/lockd/svclock.c          |   12 ++--------
 fs/nfs/namespace.c          |    4 ++-
 fs/nfs/read.c               |    2 +-
 fs/nfs/write.c              |    2 +-
 include/linux/lockd/lockd.h |    1 -
 include/linux/nfs_fs.h      |    6 ++---
 include/linux/sunrpc/xprt.h |    2 +-
 net/sunrpc/clnt.c           |   52 ++++++++++++++++++++++++-------------------
 net/sunrpc/rpc_pipe.c       |    6 +++--
 net/sunrpc/xprt.c           |   21 ++---------------
 net/sunrpc/xprtsock.c       |   29 +++++++++++++++++++++++-
 11 files changed, 75 insertions(+), 62 deletions(-)

commit 5c3e985a2c1908aa97221d3806f85ce7e2fbfa88
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Sat Jul 29 17:37:40 2006 -0400

    SUNRPC: Fix obvious refcounting bugs in rpc_pipefs.
    
    Doh!
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
    (cherry picked from 496f408f2f0e7ee5481a7c2222189be6c4f5aa6c commit)

commit e0ab53deaa91293a7958d63d5a2cf4c5645ad6f0
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Jul 27 17:22:50 2006 -0400

    RPC: Ensure that we disconnect TCP socket when client requests error out
    
    If we're part way through transmitting a TCP request, and the client
    errors, then we need to disconnect and reconnect the TCP socket in order to
    avoid confusing the server.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
    (cherry picked from 031a50c8b9ea82616abd4a4e18021a25848941ce commit)

commit f3d43c769d14b7065da7f62ec468b1fcb8cd6e06
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Thu Aug 3 15:07:47 2006 -0400

    NLM/lockd: remove b_done
    
    We never actually set the b_done field any more; it's always zero.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
    (cherry picked from af8412d4283ef91356e65e0ed9b025b376aebded commit)

commit e4e20512cfe0bacec0764b4925889d1fa94644f9
Author: Adrian Bunk <bunk@stusta.de>
Date:   Thu Aug 3 15:07:47 2006 -0400

    NFS: make 2 functions static
    
    nfs_writedata_free() and nfs_readdata_free() can now become static.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
    (cherry picked from 5e1ce40f0c3c8f67591aff17756930d7a18ceb1a commit)

commit ce510193272c295b891e45525a83b543ae3207c1
Author: Josh Triplett <josht@us.ibm.com>
Date:   Mon Jul 24 16:30:00 2006 -0700

    NFS: Release dcache_lock in an error path of nfs_path
    
    In one of the error paths of nfs_path, it may return with dcache_lock still
    held; fix this by adding and using a new error path Elong_unlock which unlocks
    dcache_lock.
    
    Signed-off-by: Josh Triplett <josh@freedesktop.org>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
    (cherry picked from f4b90b43677fb23297c56802c3056fc304f988d9 commit)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index baf5ae5..c9d4197 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -638,9 +638,6 @@ static void nlmsvc_grant_callback(struct
 	if (task->tk_status < 0) {
 		/* RPC error: Re-insert for retransmission */
 		timeout = 10 * HZ;
-	} else if (block->b_done) {
-		/* Block already removed, kill it for real */
-		timeout = 0;
 	} else {
 		/* Call was successful, now wait for client callback */
 		timeout = 60 * HZ;
@@ -709,13 +706,10 @@ nlmsvc_retry_blocked(void)
 			break;
 	        if (time_after(block->b_when,jiffies))
 			break;
-		dprintk("nlmsvc_retry_blocked(%p, when=%ld, done=%d)\n",
-			block, block->b_when, block->b_done);
+		dprintk("nlmsvc_retry_blocked(%p, when=%ld)\n",
+			block, block->b_when);
 		kref_get(&block->b_count);
-		if (block->b_done)
-			nlmsvc_unlink_block(block);
-		else
-			nlmsvc_grant_blocked(block);
+		nlmsvc_grant_blocked(block);
 		nlmsvc_release_block(block);
 	}
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 19b98ca..86b3169 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -51,7 +51,7 @@ char *nfs_path(const char *base, const s
 		namelen = dentry->d_name.len;
 		buflen -= namelen + 1;
 		if (buflen < 0)
-			goto Elong;
+			goto Elong_unlock;
 		end -= namelen;
 		memcpy(end, dentry->d_name.name, namelen);
 		*--end = '/';
@@ -68,6 +68,8 @@ char *nfs_path(const char *base, const s
 	end -= namelen;
 	memcpy(end, base, namelen);
 	return end;
+Elong_unlock:
+	spin_unlock(&dcache_lock);
 Elong:
 	return ERR_PTR(-ENAMETOOLONG);
 }
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 52bf634..65c0c5b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -63,7 +63,7 @@ struct nfs_read_data *nfs_readdata_alloc
 	return p;
 }
 
-void nfs_readdata_free(struct nfs_read_data *p)
+static void nfs_readdata_free(struct nfs_read_data *p)
 {
 	if (p && (p->pagevec != &p->page_array[0]))
 		kfree(p->pagevec);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 86bac6a..5077499 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -137,7 +137,7 @@ struct nfs_write_data *nfs_writedata_all
 	return p;
 }
 
-void nfs_writedata_free(struct nfs_write_data *p)
+static void nfs_writedata_free(struct nfs_write_data *p)
 {
 	if (p && (p->pagevec != &p->page_array[0]))
 		kfree(p->pagevec);
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index aa4fe90..0d92c46 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -123,7 +123,6 @@ struct nlm_block {
 	unsigned int		b_id;		/* block id */
 	unsigned char		b_queued;	/* re-queued */
 	unsigned char		b_granted;	/* VFS granted lock */
-	unsigned char		b_done;		/* callback complete */
 	struct nlm_file *	b_file;		/* file in question */
 };
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 55ea853..2474345 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -476,10 +476,9 @@ static inline int nfs_wb_page(struct ino
 }
 
 /*
- * Allocate and free nfs_write_data structures
+ * Allocate nfs_write_data structures
  */
 extern struct nfs_write_data *nfs_writedata_alloc(unsigned int pagecount);
-extern void nfs_writedata_free(struct nfs_write_data *p);
 
 /*
  * linux/fs/nfs/read.c
@@ -491,10 +490,9 @@ extern int  nfs_readpage_result(struct r
 extern void nfs_readdata_release(void *data);
 
 /*
- * Allocate and free nfs_read_data structures
+ * Allocate nfs_read_data structures
  */
 extern struct nfs_read_data *nfs_readdata_alloc(unsigned int pagecount);
-extern void nfs_readdata_free(struct nfs_read_data *p);
 
 /*
  * linux/fs/nfs3proc.c
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index e8bbe81..840e47a 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -229,7 +229,7 @@ int			xprt_reserve_xprt(struct rpc_task 
 int			xprt_reserve_xprt_cong(struct rpc_task *task);
 int			xprt_prepare_transmit(struct rpc_task *task);
 void			xprt_transmit(struct rpc_task *task);
-void			xprt_abort_transmit(struct rpc_task *task);
+void			xprt_end_transmit(struct rpc_task *task);
 int			xprt_adjust_timeout(struct rpc_rqst *req);
 void			xprt_release_xprt(struct rpc_xprt *xprt, struct rpc_task *task);
 void			xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 4ba271f..d6409e7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -921,26 +921,43 @@ call_transmit(struct rpc_task *task)
 	task->tk_status = xprt_prepare_transmit(task);
 	if (task->tk_status != 0)
 		return;
+	task->tk_action = call_transmit_status;
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
 	if (rpc_task_need_encode(task)) {
-		task->tk_rqstp->rq_bytes_sent = 0;
+		BUG_ON(task->tk_rqstp->rq_bytes_sent != 0);
 		call_encode(task);
 		/* Did the encode result in an error condition? */
 		if (task->tk_status != 0)
-			goto out_nosend;
+			return;
 	}
-	task->tk_action = call_transmit_status;
 	xprt_transmit(task);
 	if (task->tk_status < 0)
 		return;
-	if (!task->tk_msg.rpc_proc->p_decode) {
-		task->tk_action = rpc_exit_task;
-		rpc_wake_up_task(task);
-	}
-	return;
-out_nosend:
-	/* release socket write lock before attempting to handle error */
-	xprt_abort_transmit(task);
+	/*
+	 * On success, ensure that we call xprt_end_transmit() before sleeping
+	 * in order to allow access to the socket to other RPC requests.
+	 */
+	call_transmit_status(task);
+	if (task->tk_msg.rpc_proc->p_decode != NULL)
+		return;
+	task->tk_action = rpc_exit_task;
+	rpc_wake_up_task(task);
+}
+
+/*
+ * 5a.	Handle cleanup after a transmission
+ */
+static void
+call_transmit_status(struct rpc_task *task)
+{
+	task->tk_action = call_status;
+	/*
+	 * Special case: if we've been waiting on the socket's write_space()
+	 * callback, then don't call xprt_end_transmit().
+	 */
+	if (task->tk_status == -EAGAIN)
+		return;
+	xprt_end_transmit(task);
 	rpc_task_force_reencode(task);
 }
 
@@ -992,18 +1009,7 @@ call_status(struct rpc_task *task)
 }
 
 /*
- * 6a.	Handle transmission errors.
- */
-static void
-call_transmit_status(struct rpc_task *task)
-{
-	if (task->tk_status != -EAGAIN)
-		rpc_task_force_reencode(task);
-	call_status(task);
-}
-
-/*
- * 6b.	Handle RPC timeout
+ * 6a.	Handle RPC timeout
  * 	We do not release the request slot, so we keep using the
  *	same XID for all retransmits.
  */
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index dc6cb93..a3bd2db 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -667,10 +667,11 @@ rpc_mkdir(char *path, struct rpc_clnt *r
 			RPCAUTH_info, RPCAUTH_EOF);
 	if (error)
 		goto err_depopulate;
+	dget(dentry);
 out:
 	mutex_unlock(&dir->i_mutex);
 	rpc_release_path(&nd);
-	return dget(dentry);
+	return dentry;
 err_depopulate:
 	rpc_depopulate(dentry);
 	__rpc_rmdir(dir, dentry);
@@ -731,10 +732,11 @@ rpc_mkpipe(char *path, void *private, st
 	rpci->flags = flags;
 	rpci->ops = ops;
 	inode_dir_notify(dir, DN_CREATE);
+	dget(dentry);
 out:
 	mutex_unlock(&dir->i_mutex);
 	rpc_release_path(&nd);
-	return dget(dentry);
+	return dentry;
 err_dput:
 	dput(dentry);
 	dentry = ERR_PTR(-ENOMEM);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 313b68d..e8c2bc4 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -707,12 +707,9 @@ out_unlock:
 	return err;
 }
 
-void
-xprt_abort_transmit(struct rpc_task *task)
+void xprt_end_transmit(struct rpc_task *task)
 {
-	struct rpc_xprt	*xprt = task->tk_xprt;
-
-	xprt_release_write(xprt, task);
+	xprt_release_write(task->tk_xprt, task);
 }
 
 /**
@@ -761,8 +758,6 @@ void xprt_transmit(struct rpc_task *task
 			task->tk_status = -ENOTCONN;
 		else if (!req->rq_received)
 			rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
-
-		xprt->ops->release_xprt(xprt, task);
 		spin_unlock_bh(&xprt->transport_lock);
 		return;
 	}
@@ -772,18 +767,8 @@ void xprt_transmit(struct rpc_task *task
 	 *	 schedq, and being picked up by a parallel run of rpciod().
 	 */
 	task->tk_status = status;
-
-	switch (status) {
-	case -ECONNREFUSED:
+	if (status == -ECONNREFUSED)
 		rpc_sleep_on(&xprt->sending, task, NULL, NULL);
-	case -EAGAIN:
-	case -ENOTCONN:
-		return;
-	default:
-		break;
-	}
-	xprt_release_write(xprt, task);
-	return;
 }
 
 static inline void do_xprt_reserve(struct rpc_task *task)
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index ee678ed..441bd53 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -414,6 +414,33 @@ static int xs_tcp_send_request(struct rp
 }
 
 /**
+ * xs_tcp_release_xprt - clean up after a tcp transmission
+ * @xprt: transport
+ * @task: rpc task
+ *
+ * This cleans up if an error causes us to abort the transmission of a request.
+ * In this case, the socket may need to be reset in order to avoid confusing
+ * the server.
+ */
+static void xs_tcp_release_xprt(struct rpc_xprt *xprt, struct rpc_task *task)
+{
+	struct rpc_rqst *req;
+
+	if (task != xprt->snd_task)
+		return;
+	if (task == NULL)
+		goto out_release;
+	req = task->tk_rqstp;
+	if (req->rq_bytes_sent == 0)
+		goto out_release;
+	if (req->rq_bytes_sent == req->rq_snd_buf.len)
+		goto out_release;
+	set_bit(XPRT_CLOSE_WAIT, &task->tk_xprt->state);
+out_release:
+	xprt_release_xprt(xprt, task);
+}
+
+/**
  * xs_close - close a socket
  * @xprt: transport
  *
@@ -1250,7 +1277,7 @@ static struct rpc_xprt_ops xs_udp_ops = 
 
 static struct rpc_xprt_ops xs_tcp_ops = {
 	.reserve_xprt		= xprt_reserve_xprt,
-	.release_xprt		= xprt_release_xprt,
+	.release_xprt		= xs_tcp_release_xprt,
 	.set_port		= xs_set_port,
 	.connect		= xs_connect,
 	.buf_alloc		= rpc_malloc,


