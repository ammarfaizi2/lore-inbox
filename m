Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWG0Uyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWG0Uyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWG0Uyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:54:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750860AbWG0UxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:01 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/30] NFS: Rename nfs_server::nfs4_state [try #11]
Date: Thu, 27 Jul 2006 21:52:39 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205239.8443.46659.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename nfs_server::nfs4_state to nfs_client as it will be used to represent the
client state for NFS2 and NFS3 also.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/delegation.c       |   12 ++++++------
 fs/nfs/nfs4proc.c         |   26 +++++++++++++-------------
 fs/nfs/nfs4renewd.c       |    2 +-
 fs/nfs/nfs4state.c        |   10 +++++-----
 fs/nfs/nfs4xdr.c          |   10 +++++-----
 fs/nfs/super.c            |    6 +++---
 include/linux/nfs_fs_sb.h |    2 +-
 7 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5a1105c..cfe2397 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -52,7 +52,7 @@ static int nfs_delegation_claim_locks(st
 			case -NFS4ERR_EXPIRED:
 				/* kill_proc(fl->fl_pid, SIGLOST, 1); */
 			case -NFS4ERR_STALE_CLIENTID:
-				nfs4_schedule_state_recovery(NFS_SERVER(inode)->nfs4_state);
+				nfs4_schedule_state_recovery(NFS_SERVER(inode)->nfs_client);
 				goto out_err;
 		}
 	}
@@ -114,7 +114,7 @@ void nfs_inode_reclaim_delegation(struct
  */
 int nfs_inode_set_delegation(struct inode *inode, struct rpc_cred *cred, struct nfs_openres *res)
 {
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 	int status = 0;
@@ -176,7 +176,7 @@ static void nfs_msync_inode(struct inode
  */
 int __nfs_inode_return_delegation(struct inode *inode)
 {
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 	int res = 0;
@@ -208,7 +208,7 @@ int __nfs_inode_return_delegation(struct
  */
 void nfs_return_all_delegations(struct super_block *sb)
 {
-	struct nfs_client *clp = NFS_SB(sb)->nfs4_state;
+	struct nfs_client *clp = NFS_SB(sb)->nfs_client;
 	struct nfs_delegation *delegation;
 	struct inode *inode;
 
@@ -310,7 +310,7 @@ static int recall_thread(void *data)
 {
 	struct recall_threadargs *args = (struct recall_threadargs *)data;
 	struct inode *inode = igrab(args->inode);
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 
@@ -423,7 +423,7 @@ void nfs_delegation_reap_unclaimed(struc
 
 int nfs4_copy_delegation_stateid(nfs4_stateid *dst, struct inode *inode)
 {
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 	int res = 0;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 73f72a2..eff6043 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -195,7 +195,7 @@ static void nfs4_setup_readdir(u64 cooki
 
 static void renew_lease(const struct nfs_server *server, unsigned long timestamp)
 {
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	spin_lock(&clp->cl_lock);
 	if (time_before(clp->cl_last_renewal,timestamp))
 		clp->cl_last_renewal = timestamp;
@@ -252,7 +252,7 @@ static struct nfs4_opendata *nfs4_openda
 	atomic_inc(&sp->so_count);
 	p->o_arg.fh = NFS_FH(dir);
 	p->o_arg.open_flags = flags,
-	p->o_arg.clientid = server->nfs4_state->cl_clientid;
+	p->o_arg.clientid = server->nfs_client->cl_clientid;
 	p->o_arg.id = sp->so_id;
 	p->o_arg.name = &dentry->d_name;
 	p->o_arg.server = server;
@@ -550,7 +550,7 @@ int nfs4_open_delegation_recall(struct d
 			case -NFS4ERR_STALE_STATEID:
 			case -NFS4ERR_EXPIRED:
 				/* Don't recall a delegation if it was lost */
-				nfs4_schedule_state_recovery(server->nfs4_state);
+				nfs4_schedule_state_recovery(server->nfs_client);
 				return err;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
@@ -792,7 +792,7 @@ out:
 
 int nfs4_recover_expired_lease(struct nfs_server *server)
 {
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 
 	if (test_and_clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state))
 		nfs4_schedule_state_recovery(clp);
@@ -867,7 +867,7 @@ static int _nfs4_open_delegated(struct i
 {
 	struct nfs_delegation *delegation;
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs4_state_owner *sp = NULL;
 	struct nfs4_state *state = NULL;
@@ -953,7 +953,7 @@ static int _nfs4_do_open(struct inode *d
 	struct nfs4_state_owner  *sp;
 	struct nfs4_state     *state = NULL;
 	struct nfs_server       *server = NFS_SERVER(dir);
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_opendata *opendata;
 	int                     status;
 
@@ -1133,7 +1133,7 @@ static void nfs4_close_done(struct rpc_t
 			break;
 		case -NFS4ERR_STALE_STATEID:
 		case -NFS4ERR_EXPIRED:
-			nfs4_schedule_state_recovery(server->nfs4_state);
+			nfs4_schedule_state_recovery(server->nfs_client);
 			break;
 		default:
 			if (nfs4_async_handle_error(task, server) == -EAGAIN) {
@@ -2766,7 +2766,7 @@ static int nfs4_proc_set_acl(struct inod
 static int
 nfs4_async_handle_error(struct rpc_task *task, const struct nfs_server *server)
 {
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 
 	if (!clp || task->tk_status >= 0)
 		return 0;
@@ -2846,7 +2846,7 @@ static int nfs4_delay(struct rpc_clnt *c
  */
 int nfs4_handle_exception(const struct nfs_server *server, int errorcode, struct nfs4_exception *exception)
 {
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	int ret = errorcode;
 
 	exception->retry = 0;
@@ -3052,7 +3052,7 @@ int nfs4_proc_delegreturn(struct inode *
 		switch (err) {
 			case -NFS4ERR_STALE_STATEID:
 			case -NFS4ERR_EXPIRED:
-				nfs4_schedule_state_recovery(server->nfs4_state);
+				nfs4_schedule_state_recovery(server->nfs_client);
 			case 0:
 				return 0;
 		}
@@ -3081,7 +3081,7 @@ static int _nfs4_proc_getlk(struct nfs4_
 {
 	struct inode *inode = state->inode;
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs_lockt_args arg = {
 		.fh = NFS_FH(inode),
 		.fl = request,
@@ -3206,7 +3206,7 @@ static void nfs4_locku_done(struct rpc_t
 			break;
 		case -NFS4ERR_STALE_STATEID:
 		case -NFS4ERR_EXPIRED:
-			nfs4_schedule_state_recovery(calldata->server->nfs4_state);
+			nfs4_schedule_state_recovery(calldata->server->nfs_client);
 			break;
 		default:
 			if (nfs4_async_handle_error(task, calldata->server) == -EAGAIN) {
@@ -3318,7 +3318,7 @@ static struct nfs4_lockdata *nfs4_alloc_
 	if (p->arg.lock_seqid == NULL)
 		goto out_free;
 	p->arg.lock_stateid = &lsp->ls_stateid;
-	p->arg.lock_owner.clientid = server->nfs4_state->cl_clientid;
+	p->arg.lock_owner.clientid = server->nfs_client->cl_clientid;
 	p->arg.lock_owner.id = lsp->ls_id;
 	p->lsp = lsp;
 	atomic_inc(&lsp->ls_count);
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 2087640..ff947ec 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -127,7 +127,7 @@ nfs4_schedule_state_renewal(struct nfs_c
 void
 nfs4_renewd_prepare_shutdown(struct nfs_server *server)
 {
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 
 	if (!clp)
 		return;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index c0b6439..fa51a7d 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -61,7 +61,7 @@ static LIST_HEAD(nfs4_clientid_list);
 void
 init_nfsv4_state(struct nfs_server *server)
 {
-	server->nfs4_state = NULL;
+	server->nfs_client = NULL;
 	INIT_LIST_HEAD(&server->nfs4_siblings);
 }
 
@@ -70,9 +70,9 @@ destroy_nfsv4_state(struct nfs_server *s
 {
 	kfree(server->mnt_path);
 	server->mnt_path = NULL;
-	if (server->nfs4_state) {
-		nfs4_put_client(server->nfs4_state);
-		server->nfs4_state = NULL;
+	if (server->nfs_client) {
+		nfs4_put_client(server->nfs_client);
+		server->nfs_client = NULL;
 	}
 }
 
@@ -306,7 +306,7 @@ nfs4_drop_state_owner(struct nfs4_state_
  */
 struct nfs4_state_owner *nfs4_get_state_owner(struct nfs_server *server, struct rpc_cred *cred)
 {
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_state_owner *sp, *new;
 
 	get_rpccred(cred);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 44ea44c..992a713 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -529,7 +529,7 @@ static int encode_attrs(struct xdr_strea
 	if (iap->ia_valid & ATTR_MODE)
 		len += 4;
 	if (iap->ia_valid & ATTR_UID) {
-		owner_namelen = nfs_map_uid_to_name(server->nfs4_state, iap->ia_uid, owner_name);
+		owner_namelen = nfs_map_uid_to_name(server->nfs_client, iap->ia_uid, owner_name);
 		if (owner_namelen < 0) {
 			printk(KERN_WARNING "nfs: couldn't resolve uid %d to string\n",
 			       iap->ia_uid);
@@ -541,7 +541,7 @@ static int encode_attrs(struct xdr_strea
 		len += 4 + (XDR_QUADLEN(owner_namelen) << 2);
 	}
 	if (iap->ia_valid & ATTR_GID) {
-		owner_grouplen = nfs_map_gid_to_group(server->nfs4_state, iap->ia_gid, owner_group);
+		owner_grouplen = nfs_map_gid_to_group(server->nfs_client, iap->ia_gid, owner_group);
 		if (owner_grouplen < 0) {
 			printk(KERN_WARNING "nfs4: couldn't resolve gid %d to string\n",
 			       iap->ia_gid);
@@ -3051,9 +3051,9 @@ static int decode_getfattr(struct xdr_st
 	fattr->mode |= fmode;
 	if ((status = decode_attr_nlink(xdr, bitmap, &fattr->nlink)) != 0)
 		goto xdr_error;
-	if ((status = decode_attr_owner(xdr, bitmap, server->nfs4_state, &fattr->uid)) != 0)
+	if ((status = decode_attr_owner(xdr, bitmap, server->nfs_client, &fattr->uid)) != 0)
 		goto xdr_error;
-	if ((status = decode_attr_group(xdr, bitmap, server->nfs4_state, &fattr->gid)) != 0)
+	if ((status = decode_attr_group(xdr, bitmap, server->nfs_client, &fattr->gid)) != 0)
 		goto xdr_error;
 	if ((status = decode_attr_rdev(xdr, bitmap, &fattr->rdev)) != 0)
 		goto xdr_error;
@@ -3254,7 +3254,7 @@ static int decode_delegation(struct xdr_
 			if (decode_space_limit(xdr, &res->maxsize) < 0)
 				return -EIO;
 	}
-	return decode_ace(xdr, NULL, res->server->nfs4_state);
+	return decode_ace(xdr, NULL, res->server->nfs_client);
 }
 
 static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index b9a7c2b..509fa99 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1136,7 +1136,7 @@ static struct rpc_clnt *nfs4_create_clie
 	list_add_tail(&server->nfs4_siblings, &clp->cl_superblocks);
 	clnt = rpc_clone_client(clp->cl_rpcclient);
 	if (!IS_ERR(clnt))
-		server->nfs4_state = clp;
+		server->nfs_client = clp;
 	up_write(&clp->cl_sem);
 	clp = NULL;
 
@@ -1146,7 +1146,7 @@ static struct rpc_clnt *nfs4_create_clie
 		return clnt;
 	}
 
-	if (server->nfs4_state->cl_idmap == NULL) {
+	if (server->nfs_client->cl_idmap == NULL) {
 		dprintk("%s: failed to create idmapper.\n", __FUNCTION__);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -1411,7 +1411,7 @@ static inline char *nfs4_dup_path(const 
 static struct super_block *nfs4_clone_sb(struct nfs_server *server, struct nfs_clone_mount *data)
 {
 	const struct dentry *dentry = data->dentry;
-	struct nfs_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs_client;
 	struct super_block *sb;
 
 	server->fsid = data->fattr->fsid;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 4db90df..fc20d6b 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -43,7 +43,7 @@ #ifdef CONFIG_NFS_V4
 	 */
 	char			ip_addr[16];
 	char *			mnt_path;
-	struct nfs_client *	nfs4_state;	/* all NFSv4 state starts here */
+	struct nfs_client *	nfs_client;	/* all NFSv4 state starts here */
 	struct list_head	nfs4_siblings;	/* List of other nfs_server structs
 						 * that share the same clientid
 						 */
