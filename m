Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280693AbRKFXlu>; Tue, 6 Nov 2001 18:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280692AbRKFXlk>; Tue, 6 Nov 2001 18:41:40 -0500
Received: from pat.uio.no ([129.240.130.16]:1711 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S280693AbRKFXlb>;
	Tue, 6 Nov 2001 18:41:31 -0500
To: Bob Smart <smart@hpc.CSIRO.AU>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: handling NFSERR_JUKEBOX
In-Reply-To: <200111061036.VAA07886@trout.hpc.CSIRO.AU>
	<shsg07sknsf.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Nov 2001 00:41:21 +0100
In-Reply-To: <shsg07sknsf.fsf@charged.uio.no>
Message-ID: <shs4ro7a2n2.fsf_-_@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > I'm still not convinced this is a good idea, but if you are
     > going to do things inside the NFS client, why don't you instead
     > write a wrapper function around rpc_call_sync() for
     > fs/nfs/nfs3proc.c. Something like

...and here's the full patch that implements it...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.14/fs/nfs/nfs3proc.c linux-2.4.14-jukebox/fs/nfs/nfs3proc.c
--- linux-2.4.14/fs/nfs/nfs3proc.c	Mon Oct  1 22:45:37 2001
+++ linux-2.4.14-jukebox/fs/nfs/nfs3proc.c	Wed Nov  7 00:25:19 2001
@@ -17,6 +17,37 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
+/* A wrapper to handle the EJUKEBOX error message */
+static int
+nfs3_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
+{
+	sigset_t oldset;
+	int res;
+	rpc_clnt_sigmask(clnt, &oldset);
+	do {
+		res = rpc_call_sync(clnt, msg, flags);
+		if (res != -EJUKEBOX)
+			break;
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
+		res = -ERESTARTSYS;
+	} while (!signalled());
+	rpc_clnt_sigunmask(clnt, &oldset);
+	return res;
+}
+
+static inline int
+nfs3_rpc_call_wrapper(struct rpc_clnt *clnt, u32 proc, void *argp, void *resp, int flags)
+{
+	struct rpc_message msg = { proc, argp, resp, NULL };
+	return nfs3_rpc_wrapper(clnt, &msg, flags);
+}
+
+#define rpc_call(clnt, proc, argp, resp, flags) \
+		nfs3_rpc_call_wrapper(clnt, proc, argp, resp, flags)
+#define rpc_call_sync(clnt, msg, flags) \
+		nfs3_rpc_wrapper(clnt, msg, flags)
+
 /*
  * Bare-bones access to getattr: this is for nfs_read_super.
  */
diff -u --recursive --new-file linux-2.4.14/fs/nfs/read.c linux-2.4.14-jukebox/fs/nfs/read.c
--- linux-2.4.14/fs/nfs/read.c	Thu Oct 11 17:12:52 2001
+++ linux-2.4.14-jukebox/fs/nfs/read.c	Wed Nov  7 00:25:19 2001
@@ -437,6 +437,9 @@
 	dprintk("NFS: %4d nfs_readpage_result, (status %d)\n",
 		task->tk_pid, task->tk_status);
 
+	if (nfs_async_handle_jukebox(task))
+		return;
+
 	nfs_refresh_inode(inode, &data->fattr);
 	while (!list_empty(&data->pages)) {
 		struct nfs_page *req = nfs_list_entry(data->pages.next);
diff -u --recursive --new-file linux-2.4.14/fs/nfs/unlink.c linux-2.4.14-jukebox/fs/nfs/unlink.c
--- linux-2.4.14/fs/nfs/unlink.c	Thu Aug 16 18:39:37 2001
+++ linux-2.4.14-jukebox/fs/nfs/unlink.c	Wed Nov  7 00:25:19 2001
@@ -123,6 +123,8 @@
 	struct dentry		*dir = data->dir;
 	struct inode		*dir_i;
 
+	if (nfs_async_handle_jukebox(task))
+		return;
 	if (!dir)
 		return;
 	dir_i = dir->d_inode;
diff -u --recursive --new-file linux-2.4.14/fs/nfs/write.c linux-2.4.14-jukebox/fs/nfs/write.c
--- linux-2.4.14/fs/nfs/write.c	Thu Oct 11 17:12:52 2001
+++ linux-2.4.14-jukebox/fs/nfs/write.c	Wed Nov  7 00:25:19 2001
@@ -1229,6 +1229,9 @@
 	dprintk("NFS: %4d nfs_writeback_done (status %d)\n",
 		task->tk_pid, task->tk_status);
 
+	if (nfs_async_handle_jukebox(task))
+		return;
+
 	/* We can't handle that yet but we check for it nevertheless */
 	if (resp->count < argp->count && task->tk_status >= 0) {
 		static unsigned long    complain;
@@ -1422,6 +1425,9 @@
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
 
+	if (nfs_async_handle_jukebox(task))
+		return;
+
 	nfs_write_attributes(inode, resp->fattr);
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
diff -u --recursive --new-file linux-2.4.14/include/linux/nfs_fs.h linux-2.4.14-jukebox/include/linux/nfs_fs.h
--- linux-2.4.14/include/linux/nfs_fs.h	Wed Oct 24 07:00:07 2001
+++ linux-2.4.14-jukebox/include/linux/nfs_fs.h	Wed Nov  7 00:25:19 2001
@@ -16,6 +16,7 @@
 
 #include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/auth.h>
+#include <linux/sunrpc/clnt.h>
 
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
@@ -326,6 +327,29 @@
 	__retval;							\
 })
 
+#ifdef CONFIG_NFS_V3
+
+#define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
+static inline int
+nfs_async_handle_jukebox(struct rpc_task *task)
+{
+	if (task->tk_status != -EJUKEBOX)
+		return 0;
+	task->tk_status = 0;
+	rpc_restart_call(task);
+	rpc_delay(task, NFS_JUKEBOX_RETRY_TIME);
+	return 1;
+}
+
+#else
+
+static inline int
+nfs_async_handle_jukebox(struct rpc_task *task)
+{
+	return 0;
+}
+#endif /* CONFIG_NFS_V3 */
+
 #endif /* __KERNEL__ */
 
 /*
