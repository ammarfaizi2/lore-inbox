Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164350AbWLHBQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164350AbWLHBQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164328AbWLHBOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:30 -0500
Received: from mail.suse.de ([195.135.220.2]:58545 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164340AbWLHBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:24 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:35 +1100
Message-Id: <1061208011435.30725@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 014 of 18] knfsd: nfsd4: reorganize compound ops
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Define an op descriptor struct, use it to simplify nfsd4_proc_compound().

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c         |  254 +++++++++++++++++++++----------------------
 ./fs/nfsd/nfs4state.c        |   14 +-
 ./include/linux/nfsd/state.h |    1 
 ./include/linux/nfsd/xdr4.h  |    5 
 4 files changed, 144 insertions(+), 130 deletions(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:09:30.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:09:30.000000000 +1100
@@ -258,7 +258,8 @@ out:
  * filehandle-manipulating ops.
  */
 static __be32
-nfsd4_getfh(struct nfsd4_compound_state *cstate, struct svc_fh **getfh)
+nfsd4_getfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    struct svc_fh **getfh)
 {
 	if (!cstate->current_fh.fh_dentry)
 		return nfserr_nofilehandle;
@@ -279,7 +280,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, stru
 }
 
 static __be32
-nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate)
+nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		void *arg)
 {
 	__be32 status;
 
@@ -290,7 +292,8 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, 
 }
 
 static __be32
-nfsd4_restorefh(struct nfsd4_compound_state *cstate)
+nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		void *arg)
 {
 	if (!cstate->save_fh.fh_dentry)
 		return nfserr_restorefh;
@@ -300,7 +303,8 @@ nfsd4_restorefh(struct nfsd4_compound_st
 }
 
 static __be32
-nfsd4_savefh(struct nfsd4_compound_state *cstate)
+nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	     void *arg)
 {
 	if (!cstate->current_fh.fh_dentry)
 		return nfserr_nofilehandle;
@@ -463,7 +467,8 @@ nfsd4_link(struct svc_rqst *rqstp, struc
 }
 
 static __be32
-nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate)
+nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	      void *arg)
 {
 	struct svc_fh tmp_fh;
 	__be32 ret;
@@ -791,6 +796,16 @@ static struct nfsd4_compound_state *csta
 	return cstate;
 }
 
+typedef __be32(*nfsd4op_func)(struct svc_rqst *, struct nfsd4_compound_state *,
+			      void *);
+
+struct nfsd4_operation {
+	nfsd4op_func op_func;
+	u32 op_flags;
+};
+
+static struct nfsd4_operation nfsd4_ops[];
+
 /*
  * COMPOUND call.
  */
@@ -800,6 +815,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 		    struct nfsd4_compoundres *resp)
 {
 	struct nfsd4_op	*op;
+	struct nfsd4_operation *opdesc;
 	struct nfsd4_compound_state *cstate = NULL;
 	int		slack_bytes;
 	__be32		status;
@@ -854,6 +870,8 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 			goto encode_op;
 		}
 
+		opdesc = &nfsd4_ops[op->opnum];
+
 		/* All operations except RENEW, SETCLIENTID, RESTOREFH
 		* SETCLIENTID_CONFIRM, PUTFH and PUTROOTFH
 		* require a valid current filehandle
@@ -883,127 +901,11 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 			op->status = nfserr_moved;
 			goto encode_op;
 		}
-		switch (op->opnum) {
-		case OP_ACCESS:
-			op->status = nfsd4_access(rqstp, cstate,
-						  &op->u.access);
-			break;
-		case OP_CLOSE:
-			op->status = nfsd4_close(rqstp, cstate,
-						 &op->u.close);
-			break;
-		case OP_COMMIT:
-			op->status = nfsd4_commit(rqstp, cstate,
-						  &op->u.commit);
-			break;
-		case OP_CREATE:
-			op->status = nfsd4_create(rqstp, cstate,
-						  &op->u.create);
-			break;
-		case OP_DELEGRETURN:
-			op->status = nfsd4_delegreturn(rqstp, cstate,
-						       &op->u.delegreturn);
-			break;
-		case OP_GETATTR:
-			op->status = nfsd4_getattr(rqstp, cstate,
-						   &op->u.getattr);
-			break;
-		case OP_GETFH:
-			op->status = nfsd4_getfh(cstate, &op->u.getfh);
-			break;
-		case OP_LINK:
-			op->status = nfsd4_link(rqstp, cstate, &op->u.link);
-			break;
-		case OP_LOCK:
-			op->status = nfsd4_lock(rqstp, cstate, &op->u.lock);
-			break;
-		case OP_LOCKT:
-			op->status = nfsd4_lockt(rqstp, cstate, &op->u.lockt);
-			break;
-		case OP_LOCKU:
-			op->status = nfsd4_locku(rqstp, cstate, &op->u.locku);
-			break;
-		case OP_LOOKUP:
-			op->status = nfsd4_lookup(rqstp, cstate,
-						  &op->u.lookup);
-			break;
-		case OP_LOOKUPP:
-			op->status = nfsd4_lookupp(rqstp, cstate);
-			break;
-		case OP_NVERIFY:
-			op->status = nfsd4_nverify(rqstp, cstate,
-						  &op->u.nverify);
-			break;
-		case OP_OPEN:
-			op->status = nfsd4_open(rqstp, cstate,
-						&op->u.open);
-			break;
-		case OP_OPEN_CONFIRM:
-			op->status = nfsd4_open_confirm(rqstp, cstate,
-							&op->u.open_confirm);
-			break;
-		case OP_OPEN_DOWNGRADE:
-			op->status = nfsd4_open_downgrade(rqstp, cstate,
-							&op->u.open_downgrade);
-			break;
-		case OP_PUTFH:
-			op->status = nfsd4_putfh(rqstp, cstate, &op->u.putfh);
-			break;
-		case OP_PUTROOTFH:
-			op->status = nfsd4_putrootfh(rqstp, cstate);
-			break;
-		case OP_READ:
-			op->status = nfsd4_read(rqstp, cstate, &op->u.read);
-			break;
-		case OP_READDIR:
-			op->status = nfsd4_readdir(rqstp, cstate,
-						   &op->u.readdir);
-			break;
-		case OP_READLINK:
-			op->status = nfsd4_readlink(rqstp, cstate,
-						    &op->u.readlink);
-			break;
-		case OP_REMOVE:
-			op->status = nfsd4_remove(rqstp, cstate,
-						  &op->u.remove);
-			break;
-		case OP_RENAME:
-			op->status = nfsd4_rename(rqstp, cstate,
-						  &op->u.rename);
-			break;
-		case OP_RENEW:
-			op->status = nfsd4_renew(&op->u.renew);
-			break;
-		case OP_RESTOREFH:
-			op->status = nfsd4_restorefh(cstate);
-			break;
-		case OP_SAVEFH:
-			op->status = nfsd4_savefh(cstate);
-			break;
-		case OP_SETATTR:
-			op->status = nfsd4_setattr(rqstp, cstate,
-						   &op->u.setattr);
-			break;
-		case OP_SETCLIENTID:
-			op->status = nfsd4_setclientid(rqstp, &op->u.setclientid);
-			break;
-		case OP_SETCLIENTID_CONFIRM:
-			op->status = nfsd4_setclientid_confirm(rqstp, &op->u.setclientid_confirm);
-			break;
-		case OP_VERIFY:
-			op->status = nfsd4_verify(rqstp, cstate,
-						  &op->u.verify);
-			break;
-		case OP_WRITE:
-			op->status = nfsd4_write(rqstp, cstate, &op->u.write);
-			break;
-		case OP_RELEASE_LOCKOWNER:
-			op->status = nfsd4_release_lockowner(rqstp, &op->u.release_lockowner);
-			break;
-		default:
+
+		if (opdesc->op_func)
+			op->status = opdesc->op_func(rqstp, cstate, &op->u);
+		else
 			BUG_ON(op->status == nfs_ok);
-			break;
-		}
 
 encode_op:
 		if (op->status == nfserr_replay_me) {
@@ -1031,6 +933,108 @@ out:
 	return status;
 }
 
+static struct nfsd4_operation nfsd4_ops[OP_RELEASE_LOCKOWNER+1] = {
+	[OP_ACCESS] = {
+		.op_func = (nfsd4op_func)nfsd4_access,
+	},
+	[OP_CLOSE] = {
+		.op_func = (nfsd4op_func)nfsd4_close,
+	},
+	[OP_COMMIT] = {
+		.op_func = (nfsd4op_func)nfsd4_commit,
+	},
+	[OP_CREATE] = {
+		.op_func = (nfsd4op_func)nfsd4_create,
+	},
+	[OP_DELEGRETURN] = {
+		.op_func = (nfsd4op_func)nfsd4_delegreturn,
+	},
+	[OP_GETATTR] = {
+		.op_func = (nfsd4op_func)nfsd4_getattr,
+	},
+	[OP_GETFH] = {
+		.op_func = (nfsd4op_func)nfsd4_getfh,
+	},
+	[OP_LINK] = {
+		.op_func = (nfsd4op_func)nfsd4_link,
+	},
+	[OP_LOCK] = {
+		.op_func = (nfsd4op_func)nfsd4_lock,
+	},
+	[OP_LOCKT] = {
+		.op_func = (nfsd4op_func)nfsd4_lockt,
+	},
+	[OP_LOCKU] = {
+		.op_func = (nfsd4op_func)nfsd4_locku,
+	},
+	[OP_LOOKUP] = {
+		.op_func = (nfsd4op_func)nfsd4_lookup,
+	},
+	[OP_LOOKUPP] = {
+		.op_func = (nfsd4op_func)nfsd4_lookupp,
+	},
+	[OP_NVERIFY] = {
+		.op_func = (nfsd4op_func)nfsd4_nverify,
+	},
+	[OP_OPEN] = {
+		.op_func = (nfsd4op_func)nfsd4_open,
+	},
+	[OP_OPEN_CONFIRM] = {
+		.op_func = (nfsd4op_func)nfsd4_open_confirm,
+	},
+	[OP_OPEN_DOWNGRADE] = {
+		.op_func = (nfsd4op_func)nfsd4_open_downgrade,
+	},
+	[OP_PUTFH] = {
+		.op_func = (nfsd4op_func)nfsd4_putfh,
+	},
+	[OP_PUTROOTFH] = {
+		.op_func = (nfsd4op_func)nfsd4_putrootfh,
+	},
+	[OP_READ] = {
+		.op_func = (nfsd4op_func)nfsd4_read,
+	},
+	[OP_READDIR] = {
+		.op_func = (nfsd4op_func)nfsd4_readdir,
+	},
+	[OP_READLINK] = {
+		.op_func = (nfsd4op_func)nfsd4_readlink,
+	},
+	[OP_REMOVE] = {
+		.op_func = (nfsd4op_func)nfsd4_remove,
+	},
+	[OP_RENAME] = {
+		.op_func = (nfsd4op_func)nfsd4_rename,
+	},
+	[OP_RENEW] = {
+		.op_func = (nfsd4op_func)nfsd4_renew,
+	},
+	[OP_RESTOREFH] = {
+		.op_func = (nfsd4op_func)nfsd4_restorefh,
+	},
+	[OP_SAVEFH] = {
+		.op_func = (nfsd4op_func)nfsd4_savefh,
+	},
+	[OP_SETATTR] = {
+		.op_func = (nfsd4op_func)nfsd4_setattr,
+	},
+	[OP_SETCLIENTID] = {
+		.op_func = (nfsd4op_func)nfsd4_setclientid,
+	},
+	[OP_SETCLIENTID_CONFIRM] = {
+		.op_func = (nfsd4op_func)nfsd4_setclientid_confirm,
+	},
+	[OP_VERIFY] = {
+		.op_func = (nfsd4op_func)nfsd4_verify,
+	},
+	[OP_WRITE] = {
+		.op_func = (nfsd4op_func)nfsd4_write,
+	},
+	[OP_RELEASE_LOCKOWNER] = {
+		.op_func = (nfsd4op_func)nfsd4_release_lockowner,
+	},
+};
+
 #define nfs4svc_decode_voidargs		NULL
 #define nfs4svc_release_void		NULL
 #define nfsd4_voidres			nfsd4_voidargs

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-12-08 12:09:27.000000000 +1100
+++ ./fs/nfsd/nfs4state.c	2006-12-08 12:09:30.000000000 +1100
@@ -711,7 +711,8 @@ out_err:
  *
  */
 __be32
-nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_setclientid *setclid)
+nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+		  struct nfsd4_setclientid *setclid)
 {
 	__be32 			ip_addr = rqstp->rq_addr.sin_addr.s_addr;
 	struct xdr_netobj 	clname = { 
@@ -876,7 +877,9 @@ out:
  * NOTE: callback information will be processed here in a future patch
  */
 __be32
-nfsd4_setclientid_confirm(struct svc_rqst *rqstp, struct nfsd4_setclientid_confirm *setclientid_confirm)
+nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
+			 struct nfsd4_compound_state *cstate,
+			 struct nfsd4_setclientid_confirm *setclientid_confirm)
 {
 	__be32 ip_addr = rqstp->rq_addr.sin_addr.s_addr;
 	struct nfs4_client *conf, *unconf;
@@ -1834,7 +1837,8 @@ static void laundromat_main(void *);
 static DECLARE_WORK(laundromat_work, laundromat_main, NULL);
 
 __be32
-nfsd4_renew(clientid_t *clid)
+nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	    clientid_t *clid)
 {
 	struct nfs4_client *clp;
 	__be32 status;
@@ -2980,7 +2984,9 @@ out:
 }
 
 __be32
-nfsd4_release_lockowner(struct svc_rqst *rqstp, struct nfsd4_release_lockowner *rlockowner)
+nfsd4_release_lockowner(struct svc_rqst *rqstp,
+			struct nfsd4_compound_state *cstate,
+			struct nfsd4_release_lockowner *rlockowner)
 {
 	clientid_t *clid = &rlockowner->rl_clientid;
 	struct nfs4_stateowner *sop;

diff .prev/include/linux/nfsd/state.h ./include/linux/nfsd/state.h
--- .prev/include/linux/nfsd/state.h	2006-12-08 12:07:21.000000000 +1100
+++ ./include/linux/nfsd/state.h	2006-12-08 12:09:30.000000000 +1100
@@ -273,7 +273,6 @@ struct nfs4_stateid {
 	((err) != nfserr_stale_stateid) &&      \
 	((err) != nfserr_bad_stateid))
 
-extern __be32 nfsd4_renew(clientid_t *clid);
 extern __be32 nfs4_preprocess_stateid_op(struct svc_fh *current_fh,
 		stateid_t *stateid, int flags, struct file **filp);
 extern void nfs4_lock_state(void);

diff .prev/include/linux/nfsd/xdr4.h ./include/linux/nfsd/xdr4.h
--- .prev/include/linux/nfsd/xdr4.h	2006-12-08 12:09:27.000000000 +1100
+++ ./include/linux/nfsd/xdr4.h	2006-12-08 12:09:30.000000000 +1100
@@ -436,8 +436,10 @@ __be32 nfsd4_encode_fattr(struct svc_fh 
 		       struct dentry *dentry, __be32 *buffer, int *countp,
 		       u32 *bmval, struct svc_rqst *);
 extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
+		struct nfsd4_compound_state *,
 		struct nfsd4_setclientid *setclid);
 extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
+		struct nfsd4_compound_state *,
 		struct nfsd4_setclientid_confirm *setclientid_confirm);
 extern __be32 nfsd4_process_open1(struct nfsd4_open *open);
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
@@ -460,10 +462,13 @@ extern __be32 nfsd4_locku(struct svc_rqs
 		struct nfsd4_locku *locku);
 extern __be32
 nfsd4_release_lockowner(struct svc_rqst *rqstp,
+		struct nfsd4_compound_state *,
 		struct nfsd4_release_lockowner *rlockowner);
 extern void nfsd4_release_compoundargs(struct nfsd4_compoundargs *);
 extern __be32 nfsd4_delegreturn(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, struct nfsd4_delegreturn *dr);
+extern __be32 nfsd4_renew(struct svc_rqst *rqstp,
+			  struct nfsd4_compound_state *, clientid_t *clid);
 #endif
 
 /*
