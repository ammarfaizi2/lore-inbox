Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWG0VDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWG0VDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWG0VDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:03:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751239AbWG0VCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:36 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/30] NFS: Move rpc_ops from nfs_server to nfs_client [try #11]
Date: Thu, 27 Jul 2006 21:53:00 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205300.8443.86429.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the rpc_ops from the nfs_server struct to the nfs_client struct as they're
common to all server records of a particular NFS protocol version.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c              |    2 +-
 fs/nfs/inode.c            |    4 ++-
 fs/nfs/namespace.c        |    6 +++--
 fs/nfs/nfs4proc.c         |    2 +-
 fs/nfs/super.c            |   59 +++++++++++++++++++++++++--------------------
 include/linux/nfs_fs.h    |    2 +-
 include/linux/nfs_fs_sb.h |    2 +-
 7 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e7ffb4d..0dd727d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1147,7 +1147,7 @@ int nfs_instantiate(struct dentry *dentr
 	}
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		struct nfs_server *server = NFS_SB(dentry->d_sb);
-		error = server->rpc_ops->getattr(server, fhandle, fattr);
+		error = server->nfs_client->rpc_ops->getattr(server, fhandle, fattr);
 		if (error < 0)
 			goto out_err;
 	}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d349fb2..a9ff211 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -242,13 +242,13 @@ nfs_fhget(struct super_block *sb, struct
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
 		 */
-		inode->i_op = NFS_SB(sb)->rpc_ops->file_inode_ops;
+		inode->i_op = NFS_SB(sb)->nfs_client->rpc_ops->file_inode_ops;
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &nfs_file_operations;
 			inode->i_data.a_ops = &nfs_file_aops;
 			inode->i_data.backing_dev_info = &NFS_SB(sb)->backing_dev_info;
 		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op = NFS_SB(sb)->rpc_ops->dir_inode_ops;
+			inode->i_op = NFS_SB(sb)->nfs_client->rpc_ops->dir_inode_ops;
 			inode->i_fop = &nfs_dir_operations;
 			if (nfs_server_capable(inode, NFS_CAP_READDIRPLUS)
 			    && fattr->size <= NFS_LIMIT_READDIRPLUS)
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 460a978..f1b6ff6 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -102,7 +102,9 @@ static void * nfs_follow_mountpoint(stru
 		goto out_follow;
 	/* Look it up again */
 	parent = dget_parent(nd->dentry);
-	err = server->rpc_ops->lookup(parent->d_inode, &nd->dentry->d_name, &fh, &fattr);
+	err = server->nfs_client->rpc_ops->lookup(parent->d_inode,
+						  &nd->dentry->d_name,
+						  &fh, &fattr);
 	dput(parent);
 	if (err != 0)
 		goto out_err;
@@ -176,7 +178,7 @@ static struct vfsmount *nfs_do_clone_mou
 {
 #ifdef CONFIG_NFS_V4
 	struct vfsmount *mnt = NULL;
-	switch (server->rpc_ops->version) {
+	switch (server->nfs_client->cl_nfsversion) {
 		case 2:
 		case 3:
 			mnt = vfs_kern_mount(&clone_nfs_fs_type, 0, devname, mountdata);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 74b9163..e041ff8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -758,7 +758,7 @@ static int _nfs4_proc_open(struct nfs4_o
 	}
 	nfs_confirm_seqid(&data->owner->so_seqid, 0);
 	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR))
-		return server->rpc_ops->getattr(server, &o_res->fh, o_res->f_attr);
+		return server->nfs_client->rpc_ops->getattr(server, &o_res->fh, o_res->f_attr);
 	return 0;
 }
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index afd00f1..a23b9cc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -247,7 +247,7 @@ static int nfs_statfs(struct dentry *den
 
 	lock_kernel();
 
-	error = server->rpc_ops->statfs(server, fh, &res);
+	error = server->nfs_client->rpc_ops->statfs(server, fh, &res);
 	buf->f_type = NFS_SUPER_MAGIC;
 	if (error < 0)
 		goto out_err;
@@ -338,10 +338,11 @@ static void nfs_show_mount_options(struc
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
+	struct nfs_client *clp = nfss->nfs_client;
 	char buf[12];
 	const char *proto;
 
-	seq_printf(m, ",vers=%d", nfss->rpc_ops->version);
+	seq_printf(m, ",vers=%d", clp->rpc_ops->version);
 	seq_printf(m, ",rsize=%d", nfss->rsize);
 	seq_printf(m, ",wsize=%d", nfss->wsize);
 	if (nfss->acregmin != 3*HZ || showdefaults)
@@ -422,7 +423,7 @@ static int nfs_show_stats(struct seq_fil
 	seq_printf(m, ",namelen=%d", nfss->namelen);
 
 #ifdef CONFIG_NFS_V4
-	if (nfss->rpc_ops->version == 4) {
+	if (nfss->nfs_client->cl_nfsversion == 4) {
 		seq_printf(m, "\n\tnfsv4:\t");
 		seq_printf(m, "bm0=0x%x", nfss->attr_bitmask[0]);
 		seq_printf(m, ",bm1=0x%x", nfss->attr_bitmask[1]);
@@ -498,7 +499,7 @@ nfs_get_root(struct super_block *sb, str
 	struct nfs_server	*server = NFS_SB(sb);
 	int			error;
 
-	error = server->rpc_ops->getroot(server, rootfh, fsinfo);
+	error = server->nfs_client->rpc_ops->getroot(server, rootfh, fsinfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
 		return ERR_PTR(error);
@@ -548,14 +549,14 @@ nfs_sb_init(struct super_block *sb, rpc_
 		no_root_error = -ENOMEM;
 		goto out_no_root;
 	}
-	sb->s_root->d_op = server->rpc_ops->dentry_ops;
+	sb->s_root->d_op = server->nfs_client->rpc_ops->dentry_ops;
 
 	/* mount time stamp, in seconds */
 	server->mount_time = jiffies;
 
 	/* Get some general file system info */
 	if (server->namelen == 0 &&
-	    server->rpc_ops->pathconf(server, &server->fh, &pathinfo) >= 0)
+	    server->nfs_client->rpc_ops->pathconf(server, &server->fh, &pathinfo) >= 0)
 		server->namelen = pathinfo.max_namelen;
 	/* Work out a lot of parameters */
 	if (server->rsize == 0)
@@ -658,9 +659,14 @@ nfs_create_client(struct nfs_server *ser
 	struct rpc_xprt		*xprt = NULL;
 	struct rpc_clnt		*clnt = NULL;
 	int			proto = (data->flags & NFS_MOUNT_TCP) ? IPPROTO_TCP : IPPROTO_UDP;
+	int			nfsversion = 2;
 
-	clp = nfs_get_client(server->hostname, &server->addr,
-			     server->rpc_ops->version);
+#ifdef CONFIG_NFS_V3
+	if (server->flags & NFS_MOUNT_VER3)
+		nfsversion = 3;
+#endif
+
+	clp = nfs_get_client(server->hostname, &server->addr, nfsversion);
 	if (!clp) {
 		dprintk("%s: failed to create NFS4 client.\n", __FUNCTION__);
 		return ERR_PTR(PTR_ERR(clp));
@@ -671,6 +677,19 @@ nfs_create_client(struct nfs_server *ser
 	server->retrans_timeo = timeparms.to_initval;
 	server->retrans_count = timeparms.to_retries;
 
+	/* Check NFS protocol revision and initialize RPC op vector
+	 * and file handle pool. */
+#ifdef CONFIG_NFS_V3
+	if (nfsversion == 3) {
+		clp->rpc_ops = &nfs_v3_clientops;
+		server->caps |= NFS_CAP_READDIRPLUS;
+	} else {
+		clp->rpc_ops = &nfs_v2_clientops;
+	}
+#else
+	clp->rpc_ops = &nfs_v2_clientops;
+#endif
+
 	/* create transport and client */
 	xprt = xprt_create_proto(proto, &server->addr, &timeparms);
 	if (IS_ERR(xprt)) {
@@ -681,7 +700,7 @@ nfs_create_client(struct nfs_server *ser
 		return (struct rpc_clnt *)xprt;
 	}
 	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				 server->rpc_ops->version, data->pseudoflavor);
+				 clp->cl_nfsversion, data->pseudoflavor);
 	if (IS_ERR(clnt)) {
 		dprintk("%s: cannot create RPC client. Error = %ld\n",
 				__FUNCTION__, PTR_ERR(xprt));
@@ -745,7 +764,7 @@ static struct nfs_server *nfs_clone_serv
 	fsinfo.fattr = data->fattr;
 	if (NFS_PROTO(root_inode)->fsinfo(server, data->fh, &fsinfo) == 0)
 		nfs_super_set_maxbytes(sb, fsinfo.maxfilesize);
-	sb->s_root->d_op = server->rpc_ops->dentry_ops;
+	sb->s_root->d_op = server->nfs_client->rpc_ops->dentry_ops;
 	sb->s_flags |= MS_ACTIVE;
 	return server;
 out_put_root:
@@ -860,19 +879,6 @@ nfs_fill_super(struct super_block *sb, s
 		return -ENOMEM;
 	strcpy(server->hostname, data->hostname);
 
-	/* Check NFS protocol revision and initialize RPC op vector
-	 * and file handle pool. */
-#ifdef CONFIG_NFS_V3
-	if (server->flags & NFS_MOUNT_VER3) {
-		server->rpc_ops = &nfs_v3_clientops;
-		server->caps |= NFS_CAP_READDIRPLUS;
-	} else {
-		server->rpc_ops = &nfs_v2_clientops;
-	}
-#else
-	server->rpc_ops = &nfs_v2_clientops;
-#endif
-
 	/* Fill in pseudoflavor for mount version < 5 */
 	if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
 		data->pseudoflavor = RPC_AUTH_UNIX;
@@ -883,6 +889,7 @@ #endif
 	server->client = nfs_create_client(server, data);
 	if (IS_ERR(server->client))
 		return PTR_ERR(server->client);
+
 	/* RFC 2623, sec 2.3.2 */
 	if (authflavor != RPC_AUTH_UNIX) {
 		struct rpc_auth *auth;
@@ -1124,6 +1131,8 @@ static struct rpc_clnt *nfs4_create_clie
 
 	/* Now create transport and client */
 	if (clp->cl_cons_state == NFS_CS_INITING) {
+		clp->rpc_ops = &nfs_v4_clientops;
+
 		xprt = xprt_create_proto(proto, &server->addr, timeparms);
 		if (IS_ERR(xprt)) {
 			err = PTR_ERR(xprt);
@@ -1134,7 +1143,7 @@ static struct rpc_clnt *nfs4_create_clie
 		/* Bind to a reserved port! */
 		xprt->resvport = 1;
 		clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				server->rpc_ops->version, flavor);
+				clp->cl_nfsversion, flavor);
 		if (IS_ERR(clnt)) {
 			err = PTR_ERR(clnt);
 			dprintk("%s: cannot create RPC client. Error = %d\n",
@@ -1210,8 +1219,6 @@ static int nfs4_fill_super(struct super_
 	server->acdirmin = data->acdirmin*HZ;
 	server->acdirmax = data->acdirmax*HZ;
 
-	server->rpc_ops = &nfs_v4_clientops;
-
 	nfs_init_timeout_values(&timeparms, data->proto, data->timeo, data->retrans);
 
 	server->retrans_timeo = timeparms.to_initval;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 9616419..b7b4371 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -209,7 +209,7 @@ #define NFS_SB(s)		((struct nfs_server *
 #define NFS_FH(inode)			(&NFS_I(inode)->fh)
 #define NFS_SERVER(inode)		(NFS_SB(inode->i_sb))
 #define NFS_CLIENT(inode)		(NFS_SERVER(inode)->client)
-#define NFS_PROTO(inode)		(NFS_SERVER(inode)->rpc_ops)
+#define NFS_PROTO(inode)		(NFS_SERVER(inode)->nfs_client->rpc_ops)
 #define NFS_ADDR(inode)			(RPC_PEERADDR(NFS_CLIENT(inode)))
 #define NFS_COOKIEVERF(inode)		(NFS_I(inode)->cookieverf)
 #define NFS_READTIME(inode)		(NFS_I(inode)->read_cache_jiffies)
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index e7d7662..aae7c11 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -25,6 +25,7 @@ #define NFS_CS_IDMAP		2		/* - idmap star
 	struct list_head	cl_superblocks;	/* List of nfs_server structs */
 
 	struct rpc_clnt *	cl_rpcclient;
+	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
 
 #ifdef CONFIG_NFS_V4
 	u64			cl_clientid;	/* constant */
@@ -74,7 +75,6 @@ struct nfs_server {
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
-	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
 	struct nfs_iostats *	io_stats;	/* I/O statistics */
 	struct backing_dev_info	backing_dev_info;
 	int			flags;		/* various flags */
