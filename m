Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUHNThJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUHNThJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUHNTgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:36:49 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:51586 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264881AbUHNTbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:31:44 -0400
Subject: PATCH [4/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511900.4109.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:31:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 NLM: fix lockd to use the new posix locking callbacks.

 Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

 fs/lockd/clntproc.c         |   92 ++++++++++++++++++++++++++++++--------------
 fs/lockd/svc4proc.c         |    1 
 fs/lockd/svclock.c          |   10 ++++
 fs/lockd/svcproc.c          |    1 
 include/linux/lockd/lockd.h |    2 
 5 files changed, 78 insertions(+), 28 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1-03-fix_nfsd/fs/lockd/clntproc.c linux-2.6.8.1-04-fix_lockd/fs/lockd/clntproc.c
--- linux-2.6.8.1-03-fix_nfsd/fs/lockd/clntproc.c	2004-08-14 14:25:49.000000000 -0400
+++ linux-2.6.8.1-04-fix_lockd/fs/lockd/clntproc.c	2004-08-14 14:29:27.000000000 -0400
@@ -27,6 +27,7 @@ static int	nlmclnt_unlock(struct nlm_rqs
 static void	nlmclnt_unlock_callback(struct rpc_task *);
 static void	nlmclnt_cancel_callback(struct rpc_task *);
 static int	nlm_stat_to_errno(u32 stat);
+static void	nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host);
 
 /*
  * Cookie counter for NLM requests
@@ -44,8 +45,7 @@ static inline void nlmclnt_next_cookie(s
 /*
  * Initialize arguments for TEST/LOCK/UNLOCK/CANCEL calls
  */
-static inline void
-nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
+static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 {
 	struct nlm_args	*argp = &req->a_args;
 	struct nlm_lock	*lock = &argp->lock;
@@ -60,6 +60,14 @@ nlmclnt_setlockargs(struct nlm_rqst *req
 	locks_copy_lock(&lock->fl, fl);
 }
 
+static void nlmclnt_release_lockargs(struct nlm_rqst *req)
+{
+	struct file_lock *fl = &req->a_args.lock.fl;
+
+	if (fl->fl_ops && fl->fl_ops->fl_release_private)
+		fl->fl_ops->fl_release_private(fl);
+}
+
 /*
  * Initialize arguments for GRANTED call. The nlm_rqst structure
  * has been cleared already.
@@ -77,8 +85,10 @@ nlmclnt_setgrantargs(struct nlm_rqst *ca
 
 	if (lock->oh.len > NLMCLNT_OHSIZE) {
 		void *data = kmalloc(lock->oh.len, GFP_KERNEL);
-		if (!data)
+		if (!data) {
+			nlmclnt_freegrantargs(call);
 			return 0;
+		}
 		call->a_args.lock.oh.data = (u8 *) data;
 	}
 
@@ -89,12 +99,15 @@ nlmclnt_setgrantargs(struct nlm_rqst *ca
 void
 nlmclnt_freegrantargs(struct nlm_rqst *call)
 {
+	struct file_lock *fl = &call->a_args.lock.fl;
 	/*
 	 * Check whether we allocated memory for the owner.
 	 */
 	if (call->a_args.lock.oh.data != (u8 *) call->a_owner) {
 		kfree(call->a_args.lock.oh.data);
 	}
+	if (fl->fl_ops && fl->fl_ops->fl_release_private)
+		fl->fl_ops->fl_release_private(fl);
 }
 
 /*
@@ -165,6 +178,8 @@ nlmclnt_proc(struct inode *inode, int cm
 	}
 	call->a_host = host;
 
+	nlmclnt_locks_init_private(fl, host);
+
 	/* Set up the argument struct */
 	nlmclnt_setlockargs(call, fl);
 
@@ -179,9 +194,6 @@ nlmclnt_proc(struct inode *inode, int cm
 	else
 		status = -EINVAL;
 
-	if (status < 0 && (call->a_flags & RPC_TASK_ASYNC))
-		kfree(call);
-
  out_restore:
 	spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->blocked = oldset;
@@ -382,7 +394,9 @@ nlmclnt_test(struct nlm_rqst *req, struc
 {
 	int	status;
 
-	if ((status = nlmclnt_call(req, NLMPROC_TEST)) < 0)
+	status = nlmclnt_call(req, NLMPROC_TEST);
+	nlmclnt_release_lockargs(req);
+	if (status < 0)
 		return status;
 
 	status = req->a_res.status;
@@ -391,10 +405,9 @@ nlmclnt_test(struct nlm_rqst *req, struc
 	} if (status == NLM_LCK_DENIED) {
 		/*
 		 * Report the conflicting lock back to the application.
-		 * FIXME: Is it OK to report the pid back as well?
 		 */
 		locks_copy_lock(fl, &req->a_res.lock.fl);
-		/* fl->fl_pid = 0; */
+		fl->fl_pid = 0;
 	} else {
 		return nlm_stat_to_errno(req->a_res.status);
 	}
@@ -402,18 +415,30 @@ nlmclnt_test(struct nlm_rqst *req, struc
 	return 0;
 }
 
-static
-void nlmclnt_insert_lock_callback(struct file_lock *fl)
+static void nlmclnt_locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
-	nlm_get_host(fl->fl_u.nfs_fl.host);
+	memcpy(&new->fl_u.nfs_fl, &fl->fl_u.nfs_fl, sizeof(new->fl_u.nfs_fl));
+	nlm_get_host(new->fl_u.nfs_fl.host);
 }
-static
-void nlmclnt_remove_lock_callback(struct file_lock *fl)
+
+static void nlmclnt_locks_release_private(struct file_lock *fl)
 {
-	if (fl->fl_u.nfs_fl.host) {
-		nlm_release_host(fl->fl_u.nfs_fl.host);
-		fl->fl_u.nfs_fl.host = NULL;
-	}
+	nlm_release_host(fl->fl_u.nfs_fl.host);
+	fl->fl_ops = NULL;
+}
+
+static struct file_lock_operations nlmclnt_lock_ops = {
+	.fl_copy_lock = nlmclnt_locks_copy_lock,
+	.fl_release_private = nlmclnt_locks_release_private,
+};
+
+static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
+{
+	BUG_ON(fl->fl_ops != NULL);
+	fl->fl_u.nfs_fl.state = 0;
+	fl->fl_u.nfs_fl.flags = 0;
+	fl->fl_u.nfs_fl.host = nlm_get_host(host);
+	fl->fl_ops = &nlmclnt_lock_ops;
 }
 
 /*
@@ -446,7 +471,8 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 	if (!host->h_monitored && nsm_monitor(host) < 0) {
 		printk(KERN_NOTICE "lockd: failed to monitor %s\n",
 					host->h_name);
-		return -ENOLCK;
+		status = -ENOLCK;
+		goto out;
 	}
 
 	do {
@@ -456,18 +482,17 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 			status = nlmclnt_block(host, fl, &resp->status);
 		}
 		if (status < 0)
-			return status;
+			goto out;
 	} while (resp->status == NLM_LCK_BLOCKED && req->a_args.block);
 
 	if (resp->status == NLM_LCK_GRANTED) {
 		fl->fl_u.nfs_fl.state = host->h_state;
 		fl->fl_u.nfs_fl.flags |= NFS_LCK_GRANTED;
-		fl->fl_u.nfs_fl.host = host;
-		fl->fl_insert = nlmclnt_insert_lock_callback;
-		fl->fl_remove = nlmclnt_remove_lock_callback;
 	}
-
-	return nlm_stat_to_errno(resp->status);
+	status = nlm_stat_to_errno(resp->status);
+out:
+	nlmclnt_release_lockargs(req);
+	return status;
 }
 
 /*
@@ -527,11 +552,18 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	fl->fl_u.nfs_fl.flags &= ~NFS_LCK_GRANTED;
 
 	if (req->a_flags & RPC_TASK_ASYNC) {
-		return nlmclnt_async_call(req, NLMPROC_UNLOCK,
+		status = nlmclnt_async_call(req, NLMPROC_UNLOCK,
 					nlmclnt_unlock_callback);
+		if (status < 0) {
+			nlmclnt_release_lockargs(req);
+			kfree(req);
+		}
+		return status;
 	}
 
-	if ((status = nlmclnt_call(req, NLMPROC_UNLOCK)) < 0)
+	status = nlmclnt_call(req, NLMPROC_UNLOCK);
+	nlmclnt_release_lockargs(req);
+	if (status < 0)
 		return status;
 
 	if (resp->status == NLM_LCK_GRANTED)
@@ -567,6 +599,7 @@ nlmclnt_unlock_callback(struct rpc_task 
 
 die:
 	nlm_release_host(req->a_host);
+	nlmclnt_release_lockargs(req);
 	kfree(req);
 	return;
  retry_rebind:
@@ -605,8 +638,10 @@ nlmclnt_cancel(struct nlm_host *host, st
 
 	status = nlmclnt_async_call(req, NLMPROC_CANCEL,
 					nlmclnt_cancel_callback);
-	if (status < 0)
+	if (status < 0) {
+		nlmclnt_release_lockargs(req);
 		kfree(req);
+	}
 
 	spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->blocked = oldset;
@@ -648,6 +683,7 @@ nlmclnt_cancel_callback(struct rpc_task 
 
 die:
 	nlm_release_host(req->a_host);
+	nlmclnt_release_lockargs(req);
 	kfree(req);
 	return;
 
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-03-fix_nfsd/fs/lockd/svc4proc.c linux-2.6.8.1-04-fix_lockd/fs/lockd/svc4proc.c
--- linux-2.6.8.1-03-fix_nfsd/fs/lockd/svc4proc.c	2004-08-14 14:26:13.000000000 -0400
+++ linux-2.6.8.1-04-fix_lockd/fs/lockd/svc4proc.c	2004-08-14 14:29:27.000000000 -0400
@@ -55,6 +55,7 @@ nlm4svc_retrieve_args(struct svc_rqst *r
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = &file->f_file;
 		lock->fl.fl_owner = (fl_owner_t) host;
+		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 	}
 
 	return 0;
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-03-fix_nfsd/fs/lockd/svclock.c linux-2.6.8.1-04-fix_lockd/fs/lockd/svclock.c
--- linux-2.6.8.1-03-fix_nfsd/fs/lockd/svclock.c	2004-08-14 14:25:56.000000000 -0400
+++ linux-2.6.8.1-04-fix_lockd/fs/lockd/svclock.c	2004-08-14 14:29:27.000000000 -0400
@@ -194,6 +194,7 @@ nlmsvc_create_block(struct svc_rqst *rqs
 
 	/* Set notifier function for VFS, and init args */
 	block->b_call.a_args.lock.fl.fl_notify = nlmsvc_notify_blocked;
+	block->b_call.a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
 	block->b_call.a_args.cookie = *cookie;	/* see above */
 
 	dprintk("lockd: created block %p...\n", block);
@@ -479,6 +480,15 @@ nlmsvc_notify_blocked(struct file_lock *
 	printk(KERN_WARNING "lockd: notification for unknown block!\n");
 }
 
+static int nlmsvc_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+{
+	return fl1->fl_owner == fl2->fl_owner && fl1->fl_pid == fl2->fl_pid;
+}
+
+struct lock_manager_operations nlmsvc_lock_operations = {
+	.fl_compare_owner = nlmsvc_same_owner,
+};
+
 /*
  * Try to claim a lock that was previously blocked.
  *
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-03-fix_nfsd/fs/lockd/svcproc.c linux-2.6.8.1-04-fix_lockd/fs/lockd/svcproc.c
--- linux-2.6.8.1-03-fix_nfsd/fs/lockd/svcproc.c	2004-08-14 14:27:02.000000000 -0400
+++ linux-2.6.8.1-04-fix_lockd/fs/lockd/svcproc.c	2004-08-14 14:29:27.000000000 -0400
@@ -84,6 +84,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rq
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = &file->f_file;
 		lock->fl.fl_owner = (fl_owner_t) host;
+		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 	}
 
 	return 0;
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-03-fix_nfsd/include/linux/lockd/lockd.h linux-2.6.8.1-04-fix_lockd/include/linux/lockd/lockd.h
--- linux-2.6.8.1-03-fix_nfsd/include/linux/lockd/lockd.h	2004-08-14 14:25:53.000000000 -0400
+++ linux-2.6.8.1-04-fix_lockd/include/linux/lockd/lockd.h	2004-08-14 14:29:27.000000000 -0400
@@ -205,6 +205,8 @@ nlm_compare_locks(struct file_lock *fl1,
 	     &&(fl1->fl_type  == fl2->fl_type || fl2->fl_type == F_UNLCK);
 }
 
+extern struct lock_manager_operations nlmsvc_lock_operations;
+
 #endif /* __KERNEL__ */
 
 #endif /* LINUX_LOCKD_LOCKD_H */

