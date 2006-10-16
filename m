Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWJPXaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWJPXaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWJPXao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:30:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44487 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750805AbWJPXag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:30:36 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Oct 2006 09:30:30 +1000
Message-Id: <1061016233030.11366@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: Marc Eshel <eshel@almaden.ibm.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 5] knfsd: Allow lockd to drop replys as appropriate.
References: <20061017092702.11224.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is possible for the ->fopen callback from lockd into nfsd to find
that an answer cannot be given straight away (an upcall is needed) and
so the request has to be 'dropped', to be retried later.
That error status is not currently propagated back.

So:
  Change nlm_fopen to return nlm error codes (rather than a private
  protocol) and define a new nlm_drop_reply code.
  Cause nlm_drop_reply to cause the rpc request to get rpc_drop_reply
  when this error comes back.
  Cause svc_process to drop a request which returns a status of
  rpc_drop_reply.

Cc: Marc Eshel <eshel@almaden.ibm.com>

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svc4proc.c             |   12 ++++++------
 ./fs/lockd/svcproc.c              |   16 +++++++++-------
 ./fs/lockd/svcsubs.c              |    6 ------
 ./fs/nfsd/lockd.c                 |   14 ++++++++------
 ./include/linux/lockd/bind.h      |    5 +++++
 ./include/linux/lockd/xdr.h       |    2 ++
 ./include/linux/sunrpc/msg_prot.h |    4 +++-
 ./include/linux/sunrpc/xdr.h      |    1 +
 ./net/sunrpc/svc.c                |    5 +++++
 9 files changed, 39 insertions(+), 26 deletions(-)

diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
--- .prev/fs/lockd/svc4proc.c	2006-10-17 09:10:54.000000000 +1000
+++ ./fs/lockd/svc4proc.c	2006-10-17 09:10:55.000000000 +1000
@@ -96,7 +96,7 @@ nlm4svc_proc_test(struct svc_rqst *rqstp
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(file, &argp->lock, &resp->lock);
@@ -126,7 +126,7 @@ nlm4svc_proc_lock(struct svc_rqst *rqstp
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 #if 0
 	/* If supplied state doesn't match current state, we assume it's
@@ -169,7 +169,7 @@ nlm4svc_proc_cancel(struct svc_rqst *rqs
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Try to cancel request. */
 	resp->status = nlmsvc_cancel_blocked(file, &argp->lock);
@@ -202,7 +202,7 @@ nlm4svc_proc_unlock(struct svc_rqst *rqs
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to remove the lock */
 	resp->status = nlmsvc_unlock(file, &argp->lock);
@@ -339,7 +339,7 @@ nlm4svc_proc_share(struct svc_rqst *rqst
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to create the share */
 	resp->status = nlmsvc_share_file(host, file, argp);
@@ -372,7 +372,7 @@ nlm4svc_proc_unshare(struct svc_rqst *rq
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to lock the file */
 	resp->status = nlmsvc_unshare_file(host, file, argp);

diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
--- .prev/fs/lockd/svcproc.c	2006-10-17 09:10:54.000000000 +1000
+++ ./fs/lockd/svcproc.c	2006-10-17 09:10:55.000000000 +1000
@@ -59,7 +59,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rq
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
-	u32			error;
+	u32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
 	if (!nlmsvc_ops)
@@ -88,6 +88,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rq
 no_locks:
 	if (host)
 		nlm_release_host(host);
+	if (error)
+		return error;
 	return nlm_lck_denied_nolocks;
 }
 
@@ -122,7 +124,7 @@ nlmsvc_proc_test(struct svc_rqst *rqstp,
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(file, &argp->lock, &resp->lock));
@@ -153,7 +155,7 @@ nlmsvc_proc_lock(struct svc_rqst *rqstp,
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 #if 0
 	/* If supplied state doesn't match current state, we assume it's
@@ -196,7 +198,7 @@ nlmsvc_proc_cancel(struct svc_rqst *rqst
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Try to cancel request. */
 	resp->status = cast_status(nlmsvc_cancel_blocked(file, &argp->lock));
@@ -229,7 +231,7 @@ nlmsvc_proc_unlock(struct svc_rqst *rqst
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to remove the lock */
 	resp->status = cast_status(nlmsvc_unlock(file, &argp->lock));
@@ -368,7 +370,7 @@ nlmsvc_proc_share(struct svc_rqst *rqstp
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to create the share */
 	resp->status = cast_status(nlmsvc_share_file(host, file, argp));
@@ -401,7 +403,7 @@ nlmsvc_proc_unshare(struct svc_rqst *rqs
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return rpc_success;
+		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to unshare the file */
 	resp->status = cast_status(nlmsvc_unshare_file(host, file, argp));

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-10-17 09:10:40.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-10-17 09:13:54.000000000 +1000
@@ -135,12 +135,6 @@ out_unlock:
 
 out_free:
 	kfree(file);
-#ifdef CONFIG_LOCKD_V4
-	if (nfserr == 1)
-		nfserr = nlm4_stale_fh;
-	else
-#endif
-	nfserr = nlm_lck_denied;
 	goto out_unlock;
 }
 

diff .prev/fs/nfsd/lockd.c ./fs/nfsd/lockd.c
--- .prev/fs/nfsd/lockd.c	2006-10-17 09:10:54.000000000 +1000
+++ ./fs/nfsd/lockd.c	2006-10-17 09:19:18.000000000 +1000
@@ -39,18 +39,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct
 	fh_put(&fh);
 	rqstp->rq_client = NULL;
 	exp_readunlock();
- 	/* nlm and nfsd don't share error codes.
-	 * we invent: 0 = no error
-	 *            1 = stale file handle
-	 *	      2 = other error
+ 	/* We return nlm error codes as nlm doesn't know
+	 * about nfsd, but nfsd does know about nlm..
 	 */
 	switch (nfserr) {
 	case nfs_ok:
 		return 0;
+	case nfserr_dropit:
+		return nlm_drop_reply;
+#ifdef CONFIG_LOCKD_V4
 	case nfserr_stale:
-		return 1;
+		return nlm4_stale_fh;
+#endif
 	default:
-		return 2;
+		return nlm_lck_denied;
 	}
 }
 

diff .prev/include/linux/lockd/bind.h ./include/linux/lockd/bind.h
--- .prev/include/linux/lockd/bind.h	2006-10-17 09:20:09.000000000 +1000
+++ ./include/linux/lockd/bind.h	2006-10-17 09:22:26.000000000 +1000
@@ -10,6 +10,11 @@
 #define LINUX_LOCKD_BIND_H
 
 #include <linux/lockd/nlm.h>
+/* need xdr-encoded error codes too, so... */
+#include <linux/lockd/xdr.h>
+#ifdef CONFIG_LOCKD_V4
+#include <linux/lockd/xdr4.h>
+#endif
 
 /* Dummy declarations */
 struct svc_rqst;

diff .prev/include/linux/lockd/xdr.h ./include/linux/lockd/xdr.h
--- .prev/include/linux/lockd/xdr.h	2006-10-17 09:10:54.000000000 +1000
+++ ./include/linux/lockd/xdr.h	2006-10-17 09:10:55.000000000 +1000
@@ -22,6 +22,8 @@
 #define	nlm_lck_blocked		__constant_htonl(NLM_LCK_BLOCKED)
 #define	nlm_lck_denied_grace_period	__constant_htonl(NLM_LCK_DENIED_GRACE_PERIOD)
 
+#define nlm_drop_reply		__constant_htonl(30000)
+
 /* Lock info passed via NLM */
 struct nlm_lock {
 	char *			caller;

diff .prev/include/linux/sunrpc/msg_prot.h ./include/linux/sunrpc/msg_prot.h
--- .prev/include/linux/sunrpc/msg_prot.h	2006-10-17 09:10:55.000000000 +1000
+++ ./include/linux/sunrpc/msg_prot.h	2006-10-17 09:10:55.000000000 +1000
@@ -56,7 +56,9 @@ enum rpc_accept_stat {
 	RPC_PROG_MISMATCH = 2,
 	RPC_PROC_UNAVAIL = 3,
 	RPC_GARBAGE_ARGS = 4,
-	RPC_SYSTEM_ERR = 5
+	RPC_SYSTEM_ERR = 5,
+	/* internal use only */
+	RPC_DROP_REPLY = 60000,
 };
 
 enum rpc_reject_stat {

diff .prev/include/linux/sunrpc/xdr.h ./include/linux/sunrpc/xdr.h
--- .prev/include/linux/sunrpc/xdr.h	2006-10-17 09:10:55.000000000 +1000
+++ ./include/linux/sunrpc/xdr.h	2006-10-17 09:10:55.000000000 +1000
@@ -74,6 +74,7 @@ struct xdr_buf {
 #define	rpc_proc_unavail	__constant_htonl(RPC_PROC_UNAVAIL)
 #define	rpc_garbage_args	__constant_htonl(RPC_GARBAGE_ARGS)
 #define	rpc_system_err		__constant_htonl(RPC_SYSTEM_ERR)
+#define	rpc_drop_reply		__constant_htonl(RPC_DROP_REPLY)
 
 #define	rpc_auth_ok		__constant_htonl(RPC_AUTH_OK)
 #define	rpc_autherr_badcred	__constant_htonl(RPC_AUTH_BADCRED)

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-10-17 09:10:55.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-10-17 09:10:55.000000000 +1000
@@ -828,6 +828,11 @@ svc_process(struct svc_rqst *rqstp)
 		*statp = procp->pc_func(rqstp, rqstp->rq_argp, rqstp->rq_resp);
 
 		/* Encode reply */
+		if (*statp == rpc_drop_reply) {
+			if (procp->pc_release)
+				procp->pc_release(rqstp, NULL, rqstp->rq_resp);
+			goto dropit;
+		}
 		if (*statp == rpc_success && (xdr = procp->pc_encode)
 		 && !xdr(rqstp, resv->iov_base+resv->iov_len, rqstp->rq_resp)) {
 			dprintk("svc: failed to encode reply\n");
