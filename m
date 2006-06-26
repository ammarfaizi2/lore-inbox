Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933160AbWFZXbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160AbWFZXbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWFZXbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:31:00 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:1212 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S933206AbWFZXaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:30:07 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 2/5] NLM,NFSv4: Don't put UNLOCK requests on the wire unless we hold a lock
Date: Mon, 26 Jun 2006 19:30:06 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233006.6059.81461.stgit@lade.trondhjem.org>
In-Reply-To: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
References: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Use the new behaviour of {flock,posix}_file_lock(F_UNLCK) to determine if
we held a lock, and only send the RPC request to the server if this was the
case.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/lockd/clntproc.c |   18 ++++++++++--------
 fs/nfs/nfs4proc.c   |   31 ++++++++++++-------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 4db6209..e6dd725 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -455,7 +455,7 @@ static void nlmclnt_locks_init_private(s
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 
-static void do_vfs_lock(struct file_lock *fl)
+static int do_vfs_lock(struct file_lock *fl)
 {
 	int res = 0;
 	switch (fl->fl_flags & (FL_POSIX|FL_FLOCK)) {
@@ -468,9 +468,7 @@ static void do_vfs_lock(struct file_lock
 		default:
 			BUG();
 	}
-	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
+	return res;
 }
 
 /*
@@ -542,7 +540,8 @@ again:
 		}
 		fl->fl_flags |= FL_SLEEP;
 		/* Ensure the resulting lock will get added to granted list */
-		do_vfs_lock(fl);
+		if (do_vfs_lock(fl) < 0)
+			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __FUNCTION__);
 		up_read(&host->h_rwsem);
 	}
 	status = nlm_stat_to_errno(resp->status);
@@ -607,15 +606,19 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 {
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
-	int		status;
+	int status = 0;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
 	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
 	 * case, we want to unlock.
 	 */
+	fl->fl_flags |= FL_EXISTS;
 	down_read(&host->h_rwsem);
-	do_vfs_lock(fl);
+	if (do_vfs_lock(fl) == -ENOENT) {
+		up_read(&host->h_rwsem);
+		goto out;
+	}
 	up_read(&host->h_rwsem);
 
 	if (req->a_flags & RPC_TASK_ASYNC)
@@ -625,7 +628,6 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	if (status < 0)
 		goto out;
 
-	status = 0;
 	if (resp->status == NLM_LCK_GRANTED)
 		goto out;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b4916b0..b8c6375 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3144,9 +3144,6 @@ static int do_vfs_lock(struct file *file
 		default:
 			BUG();
 	}
-	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
 	return res;
 }
 
@@ -3258,8 +3255,6 @@ static struct rpc_task *nfs4_do_unlck(st
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Unlock _before_ we do the RPC call */
-	do_vfs_lock(fl->fl_file, fl);
 	return rpc_run_task(NFS_CLIENT(lsp->ls_state->inode), RPC_TASK_ASYNC, &nfs4_locku_ops, data);
 }
 
@@ -3270,30 +3265,28 @@ static int nfs4_proc_unlck(struct nfs4_s
 	struct rpc_task *task;
 	int status = 0;
 
-	/* Is this a delegated lock? */
-	if (test_bit(NFS_DELEGATED_STATE, &state->flags))
-		goto out_unlock;
-	/* Is this open_owner holding any locks on the server? */
-	if (test_bit(LK_STATE_IN_USE, &state->flags) == 0)
-		goto out_unlock;
-
 	status = nfs4_set_lock_state(state, request);
+	/* Unlock _before_ we do the RPC call */
+	request->fl_flags |= FL_EXISTS;
+	if (do_vfs_lock(request->fl_file, request) == -ENOENT)
+		goto out;
 	if (status != 0)
-		goto out_unlock;
+		goto out;
+	/* Is this a delegated lock? */
+	if (test_bit(NFS_DELEGATED_STATE, &state->flags))
+		goto out;
 	lsp = request->fl_u.nfs4_fl.owner;
-	status = -ENOMEM;
 	seqid = nfs_alloc_seqid(&lsp->ls_seqid);
+	status = -ENOMEM;
 	if (seqid == NULL)
-		goto out_unlock;
+		goto out;
 	task = nfs4_do_unlck(request, request->fl_file->private_data, lsp, seqid);
 	status = PTR_ERR(task);
 	if (IS_ERR(task))
-		goto out_unlock;
+		goto out;
 	status = nfs4_wait_for_completion_rpc_task(task);
 	rpc_release_task(task);
-	return status;
-out_unlock:
-	do_vfs_lock(request->fl_file, request);
+out:
 	return status;
 }
 
