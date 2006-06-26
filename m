Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933161AbWFZXaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbWFZXaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933257AbWFZXau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:30:50 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:3516 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S933233AbWFZXaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:30:13 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 5/5] NLM,NFSv4: Wait on local locks before we put RPC calls on the wire
Date: Mon, 26 Jun 2006 19:30:12 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233012.6059.34137.stgit@lade.trondhjem.org>
In-Reply-To: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
References: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Use FL_ACCESS flag to test and/or wait for local locks before we try
requesting a lock from the server

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/lockd/clntproc.c |    8 +++++++-
 fs/nfs/nfs4proc.c   |   35 ++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index e6dd725..ad089d0 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -497,6 +497,7 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait *block = NULL;
+	unsigned char fl_flags = fl->fl_flags;
 	int status = -ENOLCK;
 
 	if (!host->h_monitored && nsm_monitor(host) < 0) {
@@ -504,6 +505,10 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 					host->h_name);
 		goto out;
 	}
+	fl->fl_flags |= FL_ACCESS;
+	status = do_vfs_lock(fl);
+	if (status < 0)
+		goto out;
 
 	block = nlmclnt_prepare_block(host, fl);
 again:
@@ -538,8 +543,8 @@ again:
 			up_read(&host->h_rwsem);
 			goto again;
 		}
-		fl->fl_flags |= FL_SLEEP;
 		/* Ensure the resulting lock will get added to granted list */
+		fl->fl_flags = fl_flags | FL_SLEEP;
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __FUNCTION__);
 		up_read(&host->h_rwsem);
@@ -552,6 +557,7 @@ out_unblock:
 		nlmclnt_cancel(host, req->a_args.block, fl);
 out:
 	nlm_release_call(req);
+	fl->fl_flags = fl_flags;
 	return status;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8bdfe3f..e6ee97f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3489,29 +3489,42 @@ static int nfs4_lock_expired(struct nfs4
 static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 {
 	struct nfs4_client *clp = state->owner->so_client;
+	unsigned char fl_flags = request->fl_flags;
 	int status;
 
 	/* Is this a delegated open? */
-	if (NFS_I(state->inode)->delegation_state != 0) {
-		/* Yes: cache locks! */
-		status = do_vfs_lock(request->fl_file, request);
-		/* ...but avoid races with delegation recall... */
-		if (status < 0 || test_bit(NFS_DELEGATED_STATE, &state->flags))
-			return status;
-	}
-	down_read(&clp->cl_sem);
 	status = nfs4_set_lock_state(state, request);
 	if (status != 0)
 		goto out;
+	request->fl_flags |= FL_ACCESS;
+	status = do_vfs_lock(request->fl_file, request);
+	if (status < 0)
+		goto out;
+	down_read(&clp->cl_sem);
+	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
+		struct nfs_inode *nfsi = NFS_I(state->inode);
+		/* Yes: cache locks! */
+		down_read(&nfsi->rwsem);
+		/* ...but avoid races with delegation recall... */
+		if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
+			request->fl_flags = fl_flags & ~FL_SLEEP;
+			status = do_vfs_lock(request->fl_file, request);
+			up_read(&nfsi->rwsem);
+			goto out_unlock;
+		}
+		up_read(&nfsi->rwsem);
+	}
 	status = _nfs4_do_setlk(state, cmd, request, 0);
 	if (status != 0)
-		goto out;
+		goto out_unlock;
 	/* Note: we always want to sleep here! */
-	request->fl_flags |= FL_SLEEP;
+	request->fl_flags = fl_flags | FL_SLEEP;
 	if (do_vfs_lock(request->fl_file, request) < 0)
 		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __FUNCTION__);
-out:
+out_unlock:
 	up_read(&clp->cl_sem);
+out:
+	request->fl_flags = fl_flags;
 	return status;
 }
 
