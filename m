Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbQKMVhR>; Mon, 13 Nov 2000 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbQKMVg4>; Mon, 13 Nov 2000 16:36:56 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55311 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129429AbQKMVgs>;
	Mon, 13 Nov 2000 16:36:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14864.16395.652711.596971@charged.uio.no>
Date: Mon, 13 Nov 2000 20:24:59 +0100 (CET)
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [PATCH 2.2.18pre21] Fix 3 leaks in lockd...
X-Mailer: VM 6.71 under 21.1 (patch 3) "Acadia" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As usual, I messed up the list addresses. Here's a resend (not Cced to
Alan since he should already have received it).

Cheers,
  Trond


Forwarded message ----------------------------------


Hi Alan,

  The following patch fixes 3 leaks in the 2.2.18pre21 'lockd'
server:

  - The nlm_host h_count leaks in nlm{,4}svc_callback(). This is due
    to both nlmsvc_async_call() and the above functions incrementing
    the h_count.
    Backport the 2.4.0 definitions of nlm{clnt,svc}_async_call() in
    order to fix problem and to avoid having different APIs in 2.2.x
    and 2.4.x lockd.
    Hopefully we can clean this entire mess out in 2.5.x.

  - nlmsvc_share_file() increments the file->f_count. This causes a
    file leak when using MSDOS-style shares.
    Instead we should do as per the posix server code, and simply rely
    on the lockd file garbage collectors to not close a file with
    pending locks/shares/blocks.

  - nlm{4,}svc_proc_sm_notify() should only call nlm_release_host()
    when nlm_lookup_host() returns a non-null value.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.2.18pre21/fs/lockd/clntproc.c linux-2.2.18-fix_leak/fs/lockd/clntproc.c
--- linux-2.2.18pre21/fs/lockd/clntproc.c	Mon Nov 13 17:15:58 2000
+++ linux-2.2.18-fix_leak/fs/lockd/clntproc.c	Mon Nov 13 19:31:55 2000
@@ -309,16 +309,14 @@
 /*
  * Generic NLM call, async version.
  */
-static int
-_nlmclnt_async_call(struct nlm_rqst *req, u32 proc, rpc_action callback,
-		    struct rpc_cred *cred)
+int
+nlmsvc_async_call(struct nlm_rqst *req, u32 proc, rpc_action callback)
 {
 	struct nlm_host	*host = req->a_host;
 	struct rpc_clnt	*clnt;
 	struct nlm_args	*argp = &req->a_args;
 	struct nlm_res	*resp = &req->a_res;
 	struct rpc_message msg;
-	int		status;
 
 	dprintk("lockd: call procedure %s on %s (async)\n",
 			nlm_procname(proc), host->h_name);
@@ -327,41 +325,47 @@
 	if ((clnt = nlm_bind_host(host)) == NULL)
 		return -ENOLCK;
 
-	/* Increment host refcount */
-        nlm_get_host(host);
-
-        /* bootstrap and kick off the async RPC call */
+	/* bootstrap and kick off the async RPC call */
 	msg.rpc_proc = proc;
 	msg.rpc_argp = argp;
 	msg.rpc_resp =resp;
-	msg.rpc_cred = cred;
-        status = rpc_call_async(clnt, &msg, RPC_TASK_ASYNC, callback, req);
-
-	if (status < 0)
-		nlm_release_host(host);
-	return status;
+	msg.rpc_cred = NULL;	
+	return rpc_call_async(clnt, &msg, RPC_TASK_ASYNC, callback, req);
 }
 
-
 int
 nlmclnt_async_call(struct nlm_rqst *req, u32 proc, rpc_action callback)
 {
+	struct nlm_host	*host = req->a_host;
+	struct rpc_clnt	*clnt;
 	struct nlm_args	*argp = &req->a_args;
-	struct file	*filp = argp->lock.fl.fl_file;
-	struct rpc_cred *cred = NULL;
+	struct nlm_res	*resp = &req->a_res;
+	struct file	*file = argp->lock.fl.fl_file;
+	struct rpc_message msg;
+	int		status;
 
-	if (filp)
-		cred = nfs_file_cred(filp);
+	dprintk("lockd: call procedure %s on %s (async)\n",
+			nlm_procname(proc), host->h_name);
 
-	return _nlmclnt_async_call(req, proc, callback, cred);
-}
+	/* If we have no RPC client yet, create one. */
+	if ((clnt = nlm_bind_host(host)) == NULL)
+		return -ENOLCK;
 
-int
-nlmsvc_async_call(struct nlm_rqst *req, u32 proc, rpc_action callback)
-{
-	return _nlmclnt_async_call(req, proc, callback, NULL);
+	/* bootstrap and kick off the async RPC call */
+	msg.rpc_proc = proc;
+	msg.rpc_argp = argp;
+	msg.rpc_resp =resp;
+	if (file)
+		msg.rpc_cred = nfs_file_cred(file);
+	else
+		msg.rpc_cred = NULL;
+	/* Increment host refcount */
+	nlm_get_host(host);
+	status = rpc_call_async(clnt, &msg, RPC_TASK_ASYNC, callback, req);
+	if (status < 0)
+		nlm_release_host(host);
+	return status;
 }
-
 
 /*
  * TEST for the presence of a conflicting lock
diff -u --recursive --new-file linux-2.2.18pre21/fs/lockd/svc4proc.c linux-2.2.18-fix_leak/fs/lockd/svc4proc.c
--- linux-2.2.18pre21/fs/lockd/svc4proc.c	Mon Nov 13 17:15:58 2000
+++ linux-2.2.18-fix_leak/fs/lockd/svc4proc.c	Mon Nov 13 19:51:12 2000
@@ -450,8 +450,8 @@
 		if ((clnt = nlmsvc_ops->exp_getclient(&saddr)) != NULL 
 		 && (host = nlm_lookup_host(clnt, &saddr, 0, 0)) != NULL) {
 			nlmsvc_free_host_resources(host);
+			nlm_release_host(host);
 		}
-		nlm_release_host(host);
 	}
 
 	return rpc_success;
@@ -472,7 +472,7 @@
 	host = nlmclnt_lookup_host(&rqstp->rq_addr,
 				rqstp->rq_prot, rqstp->rq_vers);
 	if (!host) {
-		rpc_free(call);
+		kfree(call);
 		return rpc_system_err;
 	}
 
@@ -481,9 +481,13 @@
 	memcpy(&call->a_args, resp, sizeof(*resp));
 
 	if (nlmsvc_async_call(call, proc, nlm4svc_callback_exit) < 0)
-		return rpc_system_err;
+		goto error;
 
 	return rpc_success;
+ error:
+	kfree(call);
+	nlm_release_host(host);
+	return rpc_system_err;
 }
 
 static void
@@ -496,7 +500,7 @@
 					task->tk_pid, -task->tk_status);
 	}
 	nlm_release_host(call->a_host);
-	rpc_free(call);
+	kfree(call);
 }
 
 /*
diff -u --recursive --new-file linux-2.2.18pre21/fs/lockd/svclock.c linux-2.2.18-fix_leak/fs/lockd/svclock.c
--- linux-2.2.18pre21/fs/lockd/svclock.c	Mon Nov 13 17:15:58 2000
+++ linux-2.2.18-fix_leak/fs/lockd/svclock.c	Mon Nov 13 19:49:12 2000
@@ -531,8 +531,10 @@
 	nlmsvc_insert_block(block, jiffies + 30 * HZ);
 
 	/* Call the client */
-	nlmsvc_async_call(&block->b_call, NLMPROC_GRANTED_MSG,
-						nlmsvc_grant_callback);
+	nlm_get_host(block->b_call.a_host);
+	if (nlmsvc_async_call(&block->b_call, NLMPROC_GRANTED_MSG,
+						nlmsvc_grant_callback) < 0)
+		nlm_release_host(block->b_call.a_host);
 	up(&file->f_sema);
 }
 
diff -u --recursive --new-file linux-2.2.18pre21/fs/lockd/svcproc.c linux-2.2.18-fix_leak/fs/lockd/svcproc.c
--- linux-2.2.18pre21/fs/lockd/svcproc.c	Mon Nov 13 17:15:59 2000
+++ linux-2.2.18-fix_leak/fs/lockd/svcproc.c	Mon Nov 13 19:51:04 2000
@@ -463,8 +463,8 @@
 		if ((clnt = nlmsvc_ops->exp_getclient(&saddr)) != NULL 
 		 && (host = nlm_lookup_host(clnt, &saddr, 0, 0)) != NULL) {
 			nlmsvc_free_host_resources(host);
+			nlm_release_host(host);
 		}
-		nlm_release_host(host);
 	}
 
 	return rpc_success;
@@ -494,9 +494,13 @@
 	memcpy(&call->a_args, resp, sizeof(*resp));
 
 	if (nlmsvc_async_call(call, proc, nlmsvc_callback_exit) < 0)
-		return rpc_system_err;
+		goto error;
 
 	return rpc_success;
+ error:
+	nlm_release_host(host);
+	kfree(call);
+	return rpc_system_err;
 }
 
 static void
diff -u --recursive --new-file linux-2.2.18pre21/fs/lockd/svcshare.c linux-2.2.18-fix_leak/fs/lockd/svcshare.c
--- linux-2.2.18pre21/fs/lockd/svcshare.c	Mon Nov 13 17:15:59 2000
+++ linux-2.2.18-fix_leak/fs/lockd/svcshare.c	Mon Nov 13 19:07:12 2000
@@ -54,7 +54,6 @@
 	share->s_owner.len  = oh->len;
 	share->s_next       = file->f_shares;
 	file->f_shares      = share;
-	file->f_count	   += 1;
 
 update:
 	share->s_access = argp->fsm_access;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
