Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWG0VFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWG0VFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWG0VCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751216AbWG0VCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:18 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/30] NFS: Maintain a common server record for NFS2/3 as well as for NFS4 [try #11]
Date: Thu, 27 Jul 2006 21:52:56 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205255.8443.74309.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain a common server record for NFS2/3 as well as for NFS4 so that common
stuff can be moved there from struct nfs_server.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c            |   21 ++++++++++++++++++++-
 include/linux/nfs_fs_sb.h |    2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 65e1bec..afd00f1 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -653,11 +653,19 @@ static void nfs_init_timeout_values(stru
 static struct rpc_clnt *
 nfs_create_client(struct nfs_server *server, const struct nfs_mount_data *data)
 {
+	struct nfs_client	*clp;
 	struct rpc_timeout	timeparms;
 	struct rpc_xprt		*xprt = NULL;
 	struct rpc_clnt		*clnt = NULL;
 	int			proto = (data->flags & NFS_MOUNT_TCP) ? IPPROTO_TCP : IPPROTO_UDP;
 
+	clp = nfs_get_client(server->hostname, &server->addr,
+			     server->rpc_ops->version);
+	if (!clp) {
+		dprintk("%s: failed to create NFS4 client.\n", __FUNCTION__);
+		return ERR_PTR(PTR_ERR(clp));
+	}
+
 	nfs_init_timeout_values(&timeparms, proto, data->timeo, data->retrans);
 
 	server->retrans_timeo = timeparms.to_initval;
@@ -668,6 +676,8 @@ nfs_create_client(struct nfs_server *ser
 	if (IS_ERR(xprt)) {
 		dprintk("%s: cannot create RPC transport. Error = %ld\n",
 				__FUNCTION__, PTR_ERR(xprt));
+		nfs_mark_client_ready(clp, PTR_ERR(xprt));
+		nfs_put_client(clp);
 		return (struct rpc_clnt *)xprt;
 	}
 	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
@@ -681,9 +691,13 @@ nfs_create_client(struct nfs_server *ser
 	clnt->cl_intr     = 1;
 	clnt->cl_softrtry = 1;
 
+	nfs_mark_client_ready(clp, 0);
+	server->nfs_client = clp;
 	return clnt;
 
 out_fail:
+	nfs_mark_client_ready(clp, PTR_ERR(xprt));
+	nfs_put_client(clp);
 	return clnt;
 }
 
@@ -759,6 +773,7 @@ static int nfs_clone_generic_sb(struct n
 	if (server == NULL)
 		goto out_err;
 	memcpy(server, parent, sizeof(*server));
+	atomic_inc(&server->nfs_client->cl_count);
 	hostname = (data->hostname != NULL) ? data->hostname : parent->hostname;
 	len = strlen(hostname) + 1;
 	server->hostname = kmalloc(len, GFP_KERNEL);
@@ -791,6 +806,7 @@ out_deactivate:
 out_rpciod_down:
 	rpciod_down();
 	kfree(server->hostname);
+	nfs_put_client(server->nfs_client);
 	kfree(server);
 	return simple_set_mnt(mnt, sb);
 kill_rpciod:
@@ -798,6 +814,7 @@ kill_rpciod:
 free_hostname:
 	kfree(server->hostname);
 free_server:
+	nfs_put_client(server->nfs_client);
 	kfree(server);
 out_err:
 	return error;
@@ -1066,6 +1083,7 @@ static void nfs_kill_super(struct super_
 
 	nfs_free_iostats(server->io_stats);
 	kfree(server->hostname);
+	nfs_put_client(server->nfs_client);
 	kfree(server);
 	nfs_release_automount_timer();
 }
@@ -1416,7 +1434,6 @@ static struct super_block *nfs4_clone_sb
 	nfs4_server_capabilities(server, &server->fh);
 
 	down_write(&clp->cl_sem);
-	atomic_inc(&clp->cl_count);
 	list_add_tail(&server->nfs4_siblings, &clp->cl_superblocks);
 	up_write(&clp->cl_sem);
 	return sb;
@@ -1471,6 +1488,8 @@ static struct nfs_server *nfs4_referral_
 	retrans = 1;
 	nfs_init_timeout_values(&timeparms, proto, timeo, retrans);
 
+	nfs_put_client(server->nfs_client);
+	server->nfs_client = NULL;
 	server->client = nfs4_create_client(server, &timeparms, proto, data->authflavor);
 	if (IS_ERR((err = server->client)))
 		goto out_err;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 95f32d5..e7d7662 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -70,6 +70,7 @@ #endif
  * NFS client parameters stored in the superblock.
  */
 struct nfs_server {
+	struct nfs_client *	nfs_client;	/* shared client and NFS4 state */
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
@@ -103,7 +104,6 @@ #ifdef CONFIG_NFS_V4
 	 */
 	char			ip_addr[16];
 	char *			mnt_path;
-	struct nfs_client *	nfs_client;	/* all NFSv4 state starts here */
 	struct list_head	nfs4_siblings;	/* List of other nfs_server structs
 						 * that share the same clientid
 						 */
