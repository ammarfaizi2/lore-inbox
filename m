Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319154AbSHMX0I>; Tue, 13 Aug 2002 19:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319146AbSHMXFI>; Tue, 13 Aug 2002 19:05:08 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:1276 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319106AbSHMXAX>; Tue, 13 Aug 2002 19:00:23 -0400
Date: Tue, 13 Aug 2002 19:04:11 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 19/38: CLIENT: put nfs_async_handle_jukebox() in fs/nfs/nfs3proc.c
Message-ID: <Pine.SOL.4.44.0208131903530.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that all calls to nfs_async_handle_jukebox() have been moved to
fs/nfs/nfs3proc.c, we clean up by moving the nfs_async_jukebox() routine
itself there.  We also rename it nfs3_async_handle_jukebox(), to be
consistent with the naming conventions of that file.

--- old/include/linux/nfs_fs.h	Sat Aug 10 23:39:47 2002
+++ new/include/linux/nfs_fs.h	Thu Aug  8 18:10:03 2002
@@ -443,28 +443,7 @@ extern void * nfs_root_data(void);
 	__retval;							\
 })

-#ifdef CONFIG_NFS_V3
-
 #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
-static inline int
-nfs_async_handle_jukebox(struct rpc_task *task)
-{
-	if (task->tk_status != -EJUKEBOX)
-		return 0;
-	task->tk_status = 0;
-	rpc_restart_call(task);
-	rpc_delay(task, NFS_JUKEBOX_RETRY_TIME);
-	return 1;
-}
-
-#else
-
-static inline int
-nfs_async_handle_jukebox(struct rpc_task *task)
-{
-	return 0;
-}
-#endif /* CONFIG_NFS_V3 */

 #ifdef CONFIG_NFS_V4

--- old/fs/nfs/nfs3proc.c	Sat Aug 10 23:55:26 2002
+++ new/fs/nfs/nfs3proc.c	Tue Aug  6 10:15:40 2002
@@ -54,6 +54,17 @@ nfs3_rpc_call_wrapper(struct rpc_clnt *c
 #define rpc_call_sync(clnt, msg, flags) \
 		nfs3_rpc_wrapper(clnt, msg, flags)

+static int
+nfs3_async_handle_jukebox(struct rpc_task *task)
+{
+	if (task->tk_status != -EJUKEBOX)
+		return 0;
+	task->tk_status = 0;
+	rpc_restart_call(task);
+	rpc_delay(task, NFS_JUKEBOX_RETRY_TIME);
+	return 1;
+}
+
 /*
  * Bare-bones access to getattr: this is for nfs_read_super.
  */
@@ -393,7 +404,7 @@ nfs3_proc_unlink_done(struct dentry *dir
 	struct rpc_message *msg = &task->tk_msg;
 	struct nfs_fattr	*dir_attr;

-	if (nfs_async_handle_jukebox(task))
+	if (nfs3_async_handle_jukebox(task))
 		return 1;
 	if (msg->rpc_argp) {
 		dir_attr = (struct nfs_fattr*)msg->rpc_resp;
@@ -651,7 +662,7 @@ nfs3_read_done(struct rpc_task *task)
 {
 	struct nfs_read_data *data = (struct nfs_read_data *) task->tk_calldata;

-	if (nfs_async_handle_jukebox(task))
+	if (nfs3_async_handle_jukebox(task))
 		return;
 	nfs_readpage_result(task, data->u.v3.res.count);
 }
@@ -696,7 +707,7 @@ nfs3_write_done(struct rpc_task *task)
 {
 	struct nfs_write_data *data = (struct nfs_write_data *) task->tk_calldata;

-	if (nfs_async_handle_jukebox(task))
+	if (nfs3_async_handle_jukebox(task))
 		return;
 	nfs_writeback_done(task, data->u.v3.args.stable,
 			   data->u.v3.args.count, data->u.v3.res.count);
@@ -750,7 +761,7 @@ nfs3_proc_write_setup(struct nfs_write_d
 static void
 nfs3_commit_done(struct rpc_task *task)
 {
-	if (nfs_async_handle_jukebox(task))
+	if (nfs3_async_handle_jukebox(task))
 		return;
 	nfs_commit_done(task);
 }

