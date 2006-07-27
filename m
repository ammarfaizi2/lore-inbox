Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWG0VDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWG0VDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWG0VC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751249AbWG0VCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:53 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/30] NFS: Eliminate client_sys in favour of cl_rpcclient [try #11]
Date: Thu, 27 Jul 2006 21:53:02 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205302.8443.6952.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate nfs_server::client_sys in favour of nfs_client::cl_rpcclient as we
only really need one per server that we're talking to since it doesn't have any
security on it.

The retransmission management variables are also moved to the common struct as
they're required to set up the cl_rpcclient connection.

The NFS2/3 client and client_acl connections are thenceforth derived by cloning
the cl_rpcclient connection and post-applying the authorisation flavour.

The code for setting up the initial common connection has been moved to
client.c as nfs_create_rpc_client().  All the NFS program definition tables are
also moved there as that's where they're now required rather than super.c.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/client.c           |  119 ++++++++++++++++++++++++
 fs/nfs/internal.h         |    2 
 fs/nfs/nfs3proc.c         |    6 +
 fs/nfs/proc.c             |    4 -
 fs/nfs/super.c            |  222 ++++++++++-----------------------------------
 include/linux/nfs_fs_sb.h |    5 -
 6 files changed, 179 insertions(+), 179 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index cb5e924..c08cab9 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -51,6 +51,48 @@ static LIST_HEAD(nfs_client_list);
 static DECLARE_WAIT_QUEUE_HEAD(nfs_client_active_wq);
 
 /*
+ * RPC cruft for NFS
+ */
+static struct rpc_version *nfs_version[5] = {
+	[2]			= &nfs_version2,
+#ifdef CONFIG_NFS_V3
+	[3]			= &nfs_version3,
+#endif
+#ifdef CONFIG_NFS_V4
+	[4]			= &nfs_version4,
+#endif
+};
+
+struct rpc_program nfs_program = {
+	.name			= "nfs",
+	.number			= NFS_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfs_version),
+	.version		= nfs_version,
+	.stats			= &nfs_rpcstat,
+	.pipe_dir_name		= "/nfs",
+};
+
+struct rpc_stat nfs_rpcstat = {
+	.program		= &nfs_program
+};
+
+
+#ifdef CONFIG_NFS_V3_ACL
+static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
+static struct rpc_version *	nfsacl_version[] = {
+	[3]			= &nfsacl_version3,
+};
+
+struct rpc_program		nfsacl_program = {
+	.name			= "nfsacl",
+	.number			= NFS_ACL_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfsacl_version),
+	.version		= nfsacl_version,
+	.stats			= &nfsacl_rpcstat,
+};
+#endif  /* CONFIG_NFS_V3_ACL */
+
+/*
  * Allocate a shared client record
  *
  * Since these are allocated/deallocated very rarely, we don't
@@ -310,3 +352,80 @@ void nfs_mark_client_ready(struct nfs_cl
 	clp->cl_cons_state = state;
 	wake_up_all(&nfs_client_active_wq);
 }
+
+/*
+ * Initialise the timeout values for a connection
+ */
+static void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
+				    unsigned int timeo, unsigned int retrans)
+{
+	to->to_initval = timeo * HZ / 10;
+	to->to_retries = retrans;
+	if (!to->to_retries)
+		to->to_retries = 2;
+
+	switch (proto) {
+	case IPPROTO_TCP:
+		if (!to->to_initval)
+			to->to_initval = 60 * HZ;
+		if (to->to_initval > NFS_MAX_TCP_TIMEOUT)
+			to->to_initval = NFS_MAX_TCP_TIMEOUT;
+		to->to_increment = to->to_initval;
+		to->to_maxval = to->to_initval + (to->to_increment * to->to_retries);
+		to->to_exponential = 0;
+		break;
+	case IPPROTO_UDP:
+	default:
+		if (!to->to_initval)
+			to->to_initval = 11 * HZ / 10;
+		if (to->to_initval > NFS_MAX_UDP_TIMEOUT)
+			to->to_initval = NFS_MAX_UDP_TIMEOUT;
+		to->to_maxval = NFS_MAX_UDP_TIMEOUT;
+		to->to_exponential = 1;
+		break;
+	}
+}
+
+/*
+ * Create an RPC client handle
+ */
+int nfs_create_rpc_client(struct nfs_client *clp, int proto,
+			  unsigned int timeo,
+			  unsigned int retrans,
+			  rpc_authflavor_t flavor)
+{
+	struct rpc_timeout	timeparms;
+	struct rpc_xprt		*xprt = NULL;
+	struct rpc_clnt		*clnt = NULL;
+
+	if (!IS_ERR(clp->cl_rpcclient))
+		return 0;
+
+	nfs_init_timeout_values(&timeparms, proto, timeo, retrans);
+	clp->retrans_timeo = timeparms.to_initval;
+	clp->retrans_count = timeparms.to_retries;
+
+	/* create transport and client */
+	xprt = xprt_create_proto(proto, &clp->cl_addr, &timeparms);
+	if (IS_ERR(xprt)) {
+		dprintk("%s: cannot create RPC transport. Error = %ld\n",
+				__FUNCTION__, PTR_ERR(xprt));
+		return PTR_ERR(xprt);
+	}
+
+	/* Bind to a reserved port! */
+	xprt->resvport = 1;
+	/* Create the client RPC handle */
+	clnt = rpc_create_client(xprt, clp->cl_hostname, &nfs_program,
+				 clp->rpc_ops->version, RPC_AUTH_UNIX);
+	if (IS_ERR(clnt)) {
+		dprintk("%s: cannot create RPC client. Error = %ld\n",
+				__FUNCTION__, PTR_ERR(clnt));
+		return PTR_ERR(clnt);
+	}
+
+	clnt->cl_intr     = 1;
+	clnt->cl_softrtry = 1;
+	clp->cl_rpcclient = clnt;
+	return 0;
+}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5ae1306..3bbdfca 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -20,6 +20,8 @@ extern void nfs_put_client(struct nfs_cl
 extern struct nfs_client *nfs_find_client(const struct sockaddr_in *, int);
 extern struct nfs_client *nfs_get_client(const char *, const struct sockaddr_in *, int);
 extern void nfs_mark_client_ready(struct nfs_client *, int);
+extern int nfs_create_rpc_client(struct nfs_client *, int, unsigned int,
+				 unsigned int, rpc_authflavor_t);
 
 /* nfs4namespace.c */
 #ifdef CONFIG_NFS_V4
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 3e53712..0622af0 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -90,8 +90,8 @@ nfs3_proc_get_root(struct nfs_server *se
 	int	status;
 
 	status = do_proc_get_root(server->client, fhandle, info);
-	if (status && server->client_sys != server->client)
-		status = do_proc_get_root(server->client_sys, fhandle, info);
+	if (status && server->nfs_client->cl_rpcclient != server->client)
+		status = do_proc_get_root(server->nfs_client->cl_rpcclient, fhandle, info);
 	return status;
 }
 
@@ -785,7 +785,7 @@ nfs3_proc_fsinfo(struct nfs_server *serv
 
 	dprintk("NFS call  fsinfo\n");
 	nfs_fattr_init(info->fattr);
-	status = rpc_call_sync(server->client_sys, &msg, 0);
+	status = rpc_call_sync(server->nfs_client->cl_rpcclient, &msg, 0);
 	dprintk("NFS reply fsinfo: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 7767690..5a8b940 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -66,14 +66,14 @@ nfs_proc_get_root(struct nfs_server *ser
 
 	dprintk("%s: call getattr\n", __FUNCTION__);
 	nfs_fattr_init(fattr);
-	status = rpc_call_sync(server->client_sys, &msg, 0);
+	status = rpc_call_sync(server->nfs_client->cl_rpcclient, &msg, 0);
 	dprintk("%s: reply getattr: %d\n", __FUNCTION__, status);
 	if (status)
 		return status;
 	dprintk("%s: call statfs\n", __FUNCTION__);
 	msg.rpc_proc = &nfs_procedures[NFSPROC_STATFS];
 	msg.rpc_resp = &fsinfo;
-	status = rpc_call_sync(server->client_sys, &msg, 0);
+	status = rpc_call_sync(server->nfs_client->cl_rpcclient, &msg, 0);
 	dprintk("%s: reply statfs: %d\n", __FUNCTION__, status);
 	if (status)
 		return status;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a23b9cc..f3f229d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -60,52 +60,6 @@ #define NFSDBG_FACILITY		NFSDBG_VFS
  */
 #define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
 
-/*
- * RPC cruft for NFS
- */
-static struct rpc_version * nfs_version[] = {
-	NULL,
-	NULL,
-	&nfs_version2,
-#if defined(CONFIG_NFS_V3)
-	&nfs_version3,
-#elif defined(CONFIG_NFS_V4)
-	NULL,
-#endif
-#if defined(CONFIG_NFS_V4)
-	&nfs_version4,
-#endif
-};
-
-static struct rpc_program nfs_program = {
-	.name			= "nfs",
-	.number			= NFS_PROGRAM,
-	.nrvers			= ARRAY_SIZE(nfs_version),
-	.version		= nfs_version,
-	.stats			= &nfs_rpcstat,
-	.pipe_dir_name		= "/nfs",
-};
-
-struct rpc_stat nfs_rpcstat = {
-	.program		= &nfs_program
-};
-
-
-#ifdef CONFIG_NFS_V3_ACL
-static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
-static struct rpc_version *	nfsacl_version[] = {
-	[3]			= &nfsacl_version3,
-};
-
-struct rpc_program		nfsacl_program = {
-	.name =			"nfsacl",
-	.number =		NFS_ACL_PROGRAM,
-	.nrvers =		ARRAY_SIZE(nfsacl_version),
-	.version =		nfsacl_version,
-	.stats =		&nfsacl_rpcstat,
-};
-#endif  /* CONFIG_NFS_V3_ACL */
-
 static void nfs_umount_begin(struct vfsmount *, int);
 static int  nfs_statfs(struct dentry *, struct kstatfs *);
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
@@ -371,8 +325,8 @@ static void nfs_show_mount_options(struc
 			proto = buf;
 	}
 	seq_printf(m, ",proto=%s", proto);
-	seq_printf(m, ",timeo=%lu", 10U * nfss->retrans_timeo / HZ);
-	seq_printf(m, ",retrans=%u", nfss->retrans_count);
+	seq_printf(m, ",timeo=%lu", 10U * clp->retrans_timeo / HZ);
+	seq_printf(m, ",retrans=%u", clp->retrans_count);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
 }
 
@@ -617,49 +571,16 @@ out_no_root:
 }
 
 /*
- * Initialise the timeout values for a connection
- */
-static void nfs_init_timeout_values(struct rpc_timeout *to, int proto, unsigned int timeo, unsigned int retrans)
-{
-	to->to_initval = timeo * HZ / 10;
-	to->to_retries = retrans;
-	if (!to->to_retries)
-		to->to_retries = 2;
-
-	switch (proto) {
-	case IPPROTO_TCP:
-		if (!to->to_initval)
-			to->to_initval = 60 * HZ;
-		if (to->to_initval > NFS_MAX_TCP_TIMEOUT)
-			to->to_initval = NFS_MAX_TCP_TIMEOUT;
-		to->to_increment = to->to_initval;
-		to->to_maxval = to->to_initval + (to->to_increment * to->to_retries);
-		to->to_exponential = 0;
-		break;
-	case IPPROTO_UDP:
-	default:
-		if (!to->to_initval)
-			to->to_initval = 11 * HZ / 10;
-		if (to->to_initval > NFS_MAX_UDP_TIMEOUT)
-			to->to_initval = NFS_MAX_UDP_TIMEOUT;
-		to->to_maxval = NFS_MAX_UDP_TIMEOUT;
-		to->to_exponential = 1;
-		break;
-	}
-}
-
-/*
  * Create an RPC client handle.
  */
 static struct rpc_clnt *
 nfs_create_client(struct nfs_server *server, const struct nfs_mount_data *data)
 {
 	struct nfs_client	*clp;
-	struct rpc_timeout	timeparms;
-	struct rpc_xprt		*xprt = NULL;
-	struct rpc_clnt		*clnt = NULL;
+	struct rpc_clnt		*clnt;
 	int			proto = (data->flags & NFS_MOUNT_TCP) ? IPPROTO_TCP : IPPROTO_UDP;
 	int			nfsversion = 2;
+	int			err;
 
 #ifdef CONFIG_NFS_V3
 	if (server->flags & NFS_MOUNT_VER3)
@@ -672,52 +593,54 @@ #endif
 		return ERR_PTR(PTR_ERR(clp));
 	}
 
-	nfs_init_timeout_values(&timeparms, proto, data->timeo, data->retrans);
-
-	server->retrans_timeo = timeparms.to_initval;
-	server->retrans_count = timeparms.to_retries;
-
-	/* Check NFS protocol revision and initialize RPC op vector
-	 * and file handle pool. */
+	if (clp->cl_cons_state == NFS_CS_INITING) {
+		/* Check NFS protocol revision and initialize RPC op
+		 * vector and file handle pool. */
 #ifdef CONFIG_NFS_V3
-	if (nfsversion == 3) {
-		clp->rpc_ops = &nfs_v3_clientops;
-		server->caps |= NFS_CAP_READDIRPLUS;
-	} else {
-		clp->rpc_ops = &nfs_v2_clientops;
-	}
+		if (nfsversion == 3) {
+			clp->rpc_ops = &nfs_v3_clientops;
+			server->caps |= NFS_CAP_READDIRPLUS;
+		} else {
+			clp->rpc_ops = &nfs_v2_clientops;
+		}
 #else
-	clp->rpc_ops = &nfs_v2_clientops;
+		clp->rpc_ops = &nfs_v2_clientops;
 #endif
 
-	/* create transport and client */
-	xprt = xprt_create_proto(proto, &server->addr, &timeparms);
-	if (IS_ERR(xprt)) {
-		dprintk("%s: cannot create RPC transport. Error = %ld\n",
-				__FUNCTION__, PTR_ERR(xprt));
-		nfs_mark_client_ready(clp, PTR_ERR(xprt));
-		nfs_put_client(clp);
-		return (struct rpc_clnt *)xprt;
+		/* create transport and client */
+		err = nfs_create_rpc_client(clp, proto, data->timeo,
+					    data->retrans, RPC_AUTH_UNIX);
+		if (err < 0)
+			goto client_init_error;
+
+		nfs_mark_client_ready(clp, 0);
 	}
-	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				 clp->cl_nfsversion, data->pseudoflavor);
+
+	/* create an nfs_server-specific client */
+	clnt = rpc_clone_client(clp->cl_rpcclient);
 	if (IS_ERR(clnt)) {
-		dprintk("%s: cannot create RPC client. Error = %ld\n",
-				__FUNCTION__, PTR_ERR(xprt));
-		goto out_fail;
+		dprintk("%s: couldn't create rpc_client!\n", __FUNCTION__);
+		nfs_put_client(clp);
+		return ERR_PTR(PTR_ERR(clnt));
 	}
 
-	clnt->cl_intr     = 1;
-	clnt->cl_softrtry = 1;
+	if (data->pseudoflavor != clp->cl_rpcclient->cl_auth->au_flavor) {
+		struct rpc_auth *auth;
+
+		auth = rpcauth_create(data->pseudoflavor, server->client);
+		if (IS_ERR(auth)) {
+			dprintk("%s: couldn't create credcache!\n", __FUNCTION__);
+			return ERR_PTR(PTR_ERR(auth));
+		}
+	}
 
-	nfs_mark_client_ready(clp, 0);
 	server->nfs_client = clp;
 	return clnt;
 
-out_fail:
-	nfs_mark_client_ready(clp, PTR_ERR(xprt));
+client_init_error:
+	nfs_mark_client_ready(clp, err);
 	nfs_put_client(clp);
-	return clnt;
+	return ERR_PTR(err);
 }
 
 /*
@@ -736,7 +659,7 @@ static struct nfs_server *nfs_clone_serv
 	sb->s_blocksize_bits = data->sb->s_blocksize_bits;
 	sb->s_maxbytes = data->sb->s_maxbytes;
 
-	server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
+	server->client_acl = ERR_PTR(-EINVAL);
 	server->io_stats = nfs_alloc_iostats();
 	if (server->io_stats == NULL)
 		goto out;
@@ -745,11 +668,6 @@ static struct nfs_server *nfs_clone_serv
 	if (IS_ERR((err = server->client)))
 		goto out;
 
-	if (!IS_ERR(parent->client_sys)) {
-		server->client_sys = rpc_clone_client(parent->client_sys);
-		if (IS_ERR((err = server->client_sys)))
-			goto out;
-	}
 	if (!IS_ERR(parent->client_acl)) {
 		server->client_acl = rpc_clone_client(parent->client_acl);
 		if (IS_ERR((err = server->client_acl)))
@@ -808,7 +726,7 @@ static int nfs_clone_generic_sb(struct n
 		error = PTR_ERR(sb);
 		goto kill_rpciod;
 	}
-		
+
 	if (sb->s_root)
 		goto out_rpciod_down;
 
@@ -891,19 +809,6 @@ nfs_fill_super(struct super_block *sb, s
 		return PTR_ERR(server->client);
 
 	/* RFC 2623, sec 2.3.2 */
-	if (authflavor != RPC_AUTH_UNIX) {
-		struct rpc_auth *auth;
-
-		server->client_sys = rpc_clone_client(server->client);
-		if (IS_ERR(server->client_sys))
-			return PTR_ERR(server->client_sys);
-		auth = rpcauth_create(RPC_AUTH_UNIX, server->client_sys);
-		if (IS_ERR(auth))
-			return PTR_ERR(auth);
-	} else {
-		atomic_inc(&server->client->cl_count);
-		server->client_sys = server->client;
-	}
 	if (server->flags & NFS_MOUNT_VER3) {
 #ifdef CONFIG_NFS_V3_ACL
 		if (!(server->flags & NFS_MOUNT_NOACL)) {
@@ -1007,7 +912,7 @@ #endif /* CONFIG_NFS_V3 */
 		goto out_err_noserver;
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
-	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
+	server->client = server->client_acl = ERR_PTR(-EINVAL);
 
 	root = &server->fh;
 	if (data->flags & NFS_MOUNT_VER3)
@@ -1078,8 +983,6 @@ static void nfs_kill_super(struct super_
 
 	if (!IS_ERR(server->client))
 		rpc_shutdown_client(server->client);
-	if (!IS_ERR(server->client_sys))
-		rpc_shutdown_client(server->client_sys);
 	if (!IS_ERR(server->client_acl))
 		rpc_shutdown_client(server->client_acl);
 
@@ -1116,10 +1019,9 @@ static int nfs_clone_nfs_sb(struct file_
 
 #ifdef CONFIG_NFS_V4
 static struct rpc_clnt *nfs4_create_client(struct nfs_server *server,
-	struct rpc_timeout *timeparms, int proto, rpc_authflavor_t flavor)
+	int timeo, int retrans, int proto, rpc_authflavor_t flavor)
 {
 	struct nfs_client *clp;
-	struct rpc_xprt *xprt = NULL;
 	struct rpc_clnt *clnt = NULL;
 	int err = -EIO;
 
@@ -1133,26 +1035,10 @@ static struct rpc_clnt *nfs4_create_clie
 	if (clp->cl_cons_state == NFS_CS_INITING) {
 		clp->rpc_ops = &nfs_v4_clientops;
 
-		xprt = xprt_create_proto(proto, &server->addr, timeparms);
-		if (IS_ERR(xprt)) {
-			err = PTR_ERR(xprt);
-			dprintk("%s: cannot create RPC transport. Error = %d\n",
-					__FUNCTION__, err);
+		err = nfs_create_rpc_client(clp, proto, timeo, retrans, flavor);
+		if (err < 0)
 			goto client_init_error;
-		}
-		/* Bind to a reserved port! */
-		xprt->resvport = 1;
-		clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				clp->cl_nfsversion, flavor);
-		if (IS_ERR(clnt)) {
-			err = PTR_ERR(clnt);
-			dprintk("%s: cannot create RPC client. Error = %d\n",
-					__FUNCTION__, err);
-			goto client_init_error;
-		}
-		clnt->cl_intr     = 1;
-		clnt->cl_softrtry = 1;
-		clp->cl_rpcclient = clnt;
+
 		memcpy(clp->cl_ipaddr, server->ip_addr, sizeof(clp->cl_ipaddr));
 		err = nfs_idmap_new(clp);
 		if (err < 0) {
@@ -1200,7 +1086,6 @@ client_init_error:
 static int nfs4_fill_super(struct super_block *sb, struct nfs4_mount_data *data, int silent)
 {
 	struct nfs_server *server;
-	struct rpc_timeout timeparms;
 	rpc_authflavor_t authflavour;
 	int err = -EIO;
 
@@ -1219,11 +1104,6 @@ static int nfs4_fill_super(struct super_
 	server->acdirmin = data->acdirmin*HZ;
 	server->acdirmax = data->acdirmax*HZ;
 
-	nfs_init_timeout_values(&timeparms, data->proto, data->timeo, data->retrans);
-
-	server->retrans_timeo = timeparms.to_initval;
-	server->retrans_count = timeparms.to_retries;
-
 	/* Now create transport and client */
 	authflavour = RPC_AUTH_UNIX;
 	if (data->auth_flavourlen != 0) {
@@ -1239,7 +1119,8 @@ static int nfs4_fill_super(struct super_
 		}
 	}
 
-	server->client = nfs4_create_client(server, &timeparms, data->proto, authflavour);
+	server->client = nfs4_create_client(server, data->timeo, data->retrans,
+					    data->proto, authflavour);
 	if (IS_ERR(server->client)) {
 		err = PTR_ERR(server->client);
 			dprintk("%s: cannot create RPC client. Error = %d\n",
@@ -1313,7 +1194,7 @@ static int nfs4_get_sb(struct file_syste
 		return -ENOMEM;
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
-	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
+	server->client = server->client_acl = ERR_PTR(-EINVAL);
 
 	p = nfs_copy_user_string(NULL, &data->hostname, 256);
 	if (IS_ERR(p))
@@ -1484,7 +1365,6 @@ err:
 static struct nfs_server *nfs4_referral_server(struct super_block *sb, struct nfs_clone_mount *data)
 {
 	struct nfs_server *server = NFS_SB(sb);
-	struct rpc_timeout timeparms;
 	int proto, timeo, retrans;
 	void *err;
 
@@ -1493,11 +1373,11 @@ static struct nfs_server *nfs4_referral_
 	   set the timeouts and retries to low values */
 	timeo = 2;
 	retrans = 1;
-	nfs_init_timeout_values(&timeparms, proto, timeo, retrans);
 
 	nfs_put_client(server->nfs_client);
 	server->nfs_client = NULL;
-	server->client = nfs4_create_client(server, &timeparms, proto, data->authflavor);
+	server->client = nfs4_create_client(server, timeo, retrans, proto,
+					    data->authflavor);
 	if (IS_ERR((err = server->client)))
 		goto out_err;
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index aae7c11..d404cec 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -26,6 +26,8 @@ #define NFS_CS_IDMAP		2		/* - idmap star
 
 	struct rpc_clnt *	cl_rpcclient;
 	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
+	unsigned long		retrans_timeo;	/* retransmit timeout */
+	unsigned int		retrans_count;	/* number of retransmit tries */
 
 #ifdef CONFIG_NFS_V4
 	u64			cl_clientid;	/* constant */
@@ -73,7 +75,6 @@ #endif
 struct nfs_server {
 	struct nfs_client *	nfs_client;	/* shared client and NFS4 state */
 	struct rpc_clnt *	client;		/* RPC client handle */
-	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
 	struct nfs_iostats *	io_stats;	/* I/O statistics */
 	struct backing_dev_info	backing_dev_info;
@@ -90,8 +91,6 @@ struct nfs_server {
 	unsigned int		acregmax;
 	unsigned int		acdirmin;
 	unsigned int		acdirmax;
-	unsigned long		retrans_timeo;	/* retransmit timeout */
-	unsigned int		retrans_count;	/* number of retransmit tries */
 	unsigned int		namelen;
 	char *			hostname;	/* remote hostname */
 	struct nfs_fh		fh;
