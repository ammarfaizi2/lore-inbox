Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTGPGLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTGPGLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:11:33 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:59 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263205AbTGPGLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:11:23 -0400
Date: Tue, 15 Jul 2003 23:26:05 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow unattended nfs3/krb5 mounts
Message-ID: <20030715232605.A9418@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in nfs_get_root() basically describes the patch:

    Some authentication types (gss/krb5, most notably)
    are such that root won't be able to present a
    credential for GETATTR (ie, getroot()).

An easy way (ie, without this patch) to have unattended mounts is to
have a root/host@REALM (or similar) principal stashed in a keytab, which
root (rather, gssd) can use.  However, this might not be desirable for
many sites.  In any case, RFC2623 specifically describes the problem
addressed here.

Notes:

- Root inode gets inum of 1.  This doesn't seem to matter, but may be
  aesthetically unpleasing.  I wanted to choose an inum unlikely to
  conflict with an existing inum (although NFS has specific support
  for that).  It looks like more work than it's worth to change the
  inum after the info is available.  AFAICT it's not critical info.

- Solaris has this "wierd" (but understandable)  behavior that after
  mounting without a credential, the mount point is not visible at all
  until an access is attempted with a credential.  This now-you-see-it-
  now-you-don't behavior doesn't seem worthwhile to reproduce here.

- Unfortunately, MOUNT_VERSION must go to 5.  Some kernels with ver 4
  do not understand pseudoflavor.  Keeping it at 4 means that the
  userland mount can't know for sure whether the kernel accepted the
  option or not.  (Unless I'm missing some hack that could be done.)

- This doesn't actually work as-is.  A separate patch is needed for
  rpc_setbufsize() which I will provide separately, after getting
  feedback for this patch.

Does this patch look reasonable?  It works in my environment, against
a netapp server (with the rpcsec_gss patch I provided earlier).

If interested, I can supply the userland changes as well, just email me
for the patch.  (I will send it to the util-linux folks if this change
makes it into the kernel.)

/fc

diff -uNrp linux-2.6.0-test1.0/fs/nfs/inode.c linux-2.6.0-test1.1/fs/nfs/inode.c
--- linux-2.6.0-test1.0/fs/nfs/inode.c	Tue Jul 15 21:19:59 2003
+++ linux-2.6.0-test1.1/fs/nfs/inode.c	Tue Jul 15 22:56:05 2003
@@ -151,15 +151,16 @@ void
 nfs_put_super(struct super_block *sb)
 {
 	struct nfs_server *server = NFS_SB(sb);
-	struct rpc_clnt	*rpc;
 
 #ifdef CONFIG_NFS_V4
 	if (server->idmap != NULL)
 		nfs_idmap_delete(server);
 #endif /* CONFIG_NFS_V4 */
 
-	if ((rpc = server->client) != NULL)
-		rpc_shutdown_client(rpc);
+	if (server->client != NULL)
+		rpc_shutdown_client(server->client);
+	if (server->client_sys != NULL)
+		rpc_shutdown_client(server->client_sys);
 
 	if (!(server->flags & NFS_MOUNT_NONLM))
 		lockd_down();	/* release rpc.lockd */
@@ -226,27 +227,57 @@ nfs_block_size(unsigned long bsize, unsi
 /*
  * Obtain the root inode of the file system.
  */
-static struct inode *
-nfs_get_root(struct super_block *sb, struct nfs_fh *rootfh)
+static int
+nfs_get_root(struct inode **rooti, rpc_authflavor_t authflavor, struct super_block *sb, struct nfs_fh *rootfh)
 {
 	struct nfs_server	*server = NFS_SB(sb);
-	struct nfs_fattr	fattr;
-	struct inode		*inode;
+	struct nfs_fattr	fattr = { };
 	int			error;
 
-	if ((error = server->rpc_ops->getroot(server, rootfh, &fattr)) < 0) {
+	error = server->rpc_ops->getroot(server, rootfh, &fattr);
+	if (error == -EACCES && authflavor > RPC_AUTH_MAXFLAVOR) {
+		/*
+		 * Some authentication types (gss/krb5, most notably)
+		 * are such that root won't be able to present a
+		 * credential for GETATTR (ie, getroot()).
+		 *
+		 * We still want the mount to succeed.
+		 * 
+		 * So we fake the attr values and mark the inode as such.
+		 * On the first succesful traversal, we fix everything.
+		 * The auth type test isn't quite correct, but whatever.
+		 */
+		dfprintk(VFS, "NFS: faking root inode\n");
+
+		fattr.fileid = 1;
+		fattr.nlink = 2;	/* minimum for a dir */
+		fattr.type = NFDIR;
+		fattr.mode = S_IFDIR|S_IRUGO|S_IXUGO;
+		fattr.size = 4096;
+		fattr.du.nfs3.used = 1;
+		fattr.valid = NFS_ATTR_FATTR|NFS_ATTR_FATTR_V3;
+	} else if (error < 0) {
 		printk(KERN_NOTICE "nfs_get_root: getattr error = %d\n", -error);
-		return NULL;
+		*rooti = NULL;	/* superfluous ... but safe */
+		return error;
 	}
 
-	inode = __nfs_fhget(sb, rootfh, &fattr);
-	return inode;
+	*rooti = __nfs_fhget(sb, rootfh, &fattr);
+	if (error == -EACCES && authflavor > RPC_AUTH_MAXFLAVOR) {
+		if (*rooti) {
+			NFS_FLAGS(*rooti) |= NFS_INO_FAKE_ROOT;
+			NFS_CACHEINV((*rooti));
+			error = 0;
+		}
+	}
+	return error;
 }
 
 /*
  * Do NFS version-independent mount processing, and sanity checking
  */
-int nfs_sb_init(struct super_block *sb)
+static int
+nfs_sb_init(struct super_block *sb, rpc_authflavor_t authflavor)
 {
 	struct nfs_server	*server;
 	struct inode		*root_inode = NULL;
@@ -267,8 +298,7 @@ int nfs_sb_init(struct super_block *sb)
 	sb->s_op         = &nfs_sops;
 
 	/* Did getting the root inode fail? */
-	root_inode = nfs_get_root(sb, &server->fh);
-	if (!root_inode)
+	if (nfs_get_root(&root_inode, authflavor, sb, &server->fh) < 0)
 		goto out_no_root;
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root)
@@ -346,19 +376,66 @@ out_no_root:
 }
 
 /*
+ * Create an RPC client handle.
+ */
+static struct rpc_clnt *
+nfs_create_client(struct nfs_server *server, const struct nfs_mount_data *data)
+{
+	struct rpc_timeout	timeparms;
+	struct rpc_xprt		*xprt = NULL;
+	struct rpc_clnt		*clnt = NULL;
+	int			tcp   = (data->flags & NFS_MOUNT_TCP);
+
+	/* Initialize timeout values */
+	timeparms.to_initval = data->timeo * HZ / 10;
+	timeparms.to_retries = data->retrans;
+	timeparms.to_maxval  = tcp ? RPC_MAX_TCP_TIMEOUT : RPC_MAX_UDP_TIMEOUT;
+	timeparms.to_exponential = 1;
+
+	if (!timeparms.to_initval)
+		timeparms.to_initval = (tcp ? 600 : 11) * HZ / 10;
+	if (!timeparms.to_retries)
+		timeparms.to_retries = 5;
+
+	/* create transport and client */
+	xprt = xprt_create_proto(tcp ? IPPROTO_TCP : IPPROTO_UDP,
+				 &server->addr, &timeparms);
+	if (xprt == NULL) {
+		printk(KERN_WARNING "NFS: cannot create RPC transport.\n");
+		goto out_fail;
+	}
+	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
+				 server->rpc_ops->version, data->pseudoflavor);
+	if (clnt == NULL) {
+		printk(KERN_WARNING "NFS: cannot create RPC client.\n");
+		goto out_fail;
+	}
+
+	clnt->cl_intr     = (server->flags & NFS_MOUNT_INTR) ? 1 : 0;
+	clnt->cl_softrtry = (server->flags & NFS_MOUNT_SOFT) ? 1 : 0;
+	clnt->cl_droppriv = (server->flags & NFS_MOUNT_BROKEN_SUID) ? 1 : 0;
+	clnt->cl_chatty   = 1;
+
+	return clnt;
+
+out_fail:
+	if (xprt)
+		xprt_destroy(xprt);
+	return NULL;
+}
+
+/*
  * The way this works is that the mount process passes a structure
  * in the data argument which contains the server's IP address
  * and the root file handle obtained from the server's mount
  * daemon. We stash these away in the private superblock fields.
  */
-int nfs_fill_super(struct super_block *sb, struct nfs_mount_data *data, int silent)
+static int
+nfs_fill_super(struct super_block *sb, struct nfs_mount_data *data, int silent)
 {
 	struct nfs_server	*server;
-	struct rpc_xprt		*xprt = NULL;
-	struct rpc_clnt		*clnt = NULL;
-	struct rpc_timeout	timeparms;
-	int			tcp, err = -EIO;
-	u32			authflavor;
+	int			err = -EIO;
+	rpc_authflavor_t	authflavor;
 
 	server           = NFS_SB(sb);
 	sb->s_blocksize_bits = 0;
@@ -400,46 +477,20 @@ int nfs_fill_super(struct super_block *s
 		server->rpc_ops = &nfs_v2_clientops;
 	}
 
-	/* Which protocol do we use? */
-	tcp   = (data->flags & NFS_MOUNT_TCP);
-
-	/* Initialize timeout values */
-	timeparms.to_initval = data->timeo * HZ / 10;
-	timeparms.to_retries = data->retrans;
-	timeparms.to_maxval  = tcp? RPC_MAX_TCP_TIMEOUT : RPC_MAX_UDP_TIMEOUT;
-	timeparms.to_exponential = 1;
-
-	if (!timeparms.to_initval)
-		timeparms.to_initval = (tcp ? 600 : 11) * HZ / 10;
-	if (!timeparms.to_retries)
-		timeparms.to_retries = 5;
-
-	/* Now create transport and client */
-	xprt = xprt_create_proto(tcp? IPPROTO_TCP : IPPROTO_UDP,
-						&server->addr, &timeparms);
-	if (xprt == NULL) {
-		printk(KERN_WARNING "NFS: cannot create RPC transport.\n");
-		goto out_fail;
-	}
-
-	if (data->flags & NFS_MOUNT_SECFLAVOUR)
-		authflavor = data->pseudoflavor;
-	else
-		authflavor = RPC_AUTH_UNIX;
-
-	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
-				 server->rpc_ops->version, authflavor);
-	if (clnt == NULL) {
-		printk(KERN_WARNING "NFS: cannot create RPC client.\n");
-		xprt_destroy(xprt);
+	/* Fill in pseudoflavor for mount version < 5 */
+	if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
+		data->pseudoflavor = RPC_AUTH_UNIX;
+	authflavor = data->pseudoflavor;	/* save for sb_init() */
+	/* XXX maybe we want to add a server->pseudoflavor field */
+
+	/* Create RPC client handles */
+	server->client = nfs_create_client(server, data);
+	if (server->client == NULL)
 		goto out_fail;
-	}
-
-	clnt->cl_intr     = (server->flags & NFS_MOUNT_INTR) ? 1 : 0;
-	clnt->cl_softrtry = (server->flags & NFS_MOUNT_SOFT) ? 1 : 0;
-	clnt->cl_droppriv = (server->flags & NFS_MOUNT_BROKEN_SUID) ? 1 : 0;
-	clnt->cl_chatty   = 1;
-	server->client    = clnt;
+	data->pseudoflavor = RPC_AUTH_UNIX;	/* RFC 2623, sec 2.3.2 */
+	server->client_sys = nfs_create_client(server, data);
+	if (server->client_sys == NULL)
+		goto out_shutdown;
 
 	/* Fire up rpciod if not yet running */
 	if (rpciod_up() != 0) {
@@ -447,7 +498,7 @@ int nfs_fill_super(struct super_block *s
 		goto out_shutdown;
 	}
 
-	err = nfs_sb_init(sb);
+	err = nfs_sb_init(sb, authflavor);
 	if (err != 0)
 		goto out_noinit;
 
@@ -466,7 +517,10 @@ int nfs_fill_super(struct super_block *s
 out_noinit:
 	rpciod_down();
 out_shutdown:
-	rpc_shutdown_client(server->client);
+	if (server->client)
+		rpc_shutdown_client(server->client);
+	if (server->client_sys)
+		rpc_shutdown_client(server->client_sys);
 out_fail:
 	if (server->hostname)
 		kfree(server->hostname);
@@ -904,6 +958,11 @@ __nfs_revalidate_inode(struct nfs_server
  		goto out_nowait;
 	if (NFS_STALE(inode) && inode != inode->i_sb->s_root->d_inode)
  		goto out_nowait;
+	if (NFS_FAKE_ROOT(inode)) {
+		dfprintk(VFS, "NFS: not revalidating fake root\n");
+		status = 0;
+		goto out_nowait;
+	}
 
 	while (NFS_REVALIDATING(inode)) {
 		status = nfs_wait_on_inode(inode, NFS_INO_REVALIDATING);
@@ -1007,6 +1066,13 @@ __nfs_refresh_inode(struct inode *inode,
 			inode->i_sb->s_id, inode->i_ino,
 			atomic_read(&inode->i_count), fattr->valid);
 
+	/* First successful call after mount, fill real data. */
+	if (NFS_FAKE_ROOT(inode)) {
+		dfprintk(VFS, "NFS: updating fake root\n");
+		nfsi->fileid = fattr->fileid;
+		NFS_FLAGS(inode) &= ~NFS_INO_FAKE_ROOT;
+	}
+
 	if (nfsi->fileid != fattr->fileid) {
 		printk(KERN_ERR "nfs_refresh_inode: inode number mismatch\n"
 		       "expected (%s/0x%Lx), got (%s/0x%Lx)\n",
@@ -1229,6 +1295,8 @@ static struct super_block *nfs_get_sb(st
 			root->size = NFS2_FHSIZE;
 			memcpy(root->data, data->old_root.data, NFS2_FHSIZE);
 		}
+		if (data->version < 5)
+			data->flags &= ~NFS_MOUNT_SECFLAVOUR;
 	}
 
 	if (root->size > sizeof(root->data)) {
diff -uNrp linux-2.6.0-test1.0/fs/nfs/nfs3proc.c linux-2.6.0-test1.1/fs/nfs/nfs3proc.c
--- linux-2.6.0-test1.0/fs/nfs/nfs3proc.c	Tue Jul 15 21:10:30 2003
+++ linux-2.6.0-test1.1/fs/nfs/nfs3proc.c	Tue Jul 15 21:45:39 2003
@@ -681,7 +681,7 @@ nfs3_proc_fsinfo(struct nfs_server *serv
 
 	dprintk("NFS call  fsinfo\n");
 	info->fattr->valid = 0;
-	status = rpc_call(server->client, NFS3PROC_FSINFO, fhandle, info, 0);
+	status = rpc_call(server->client_sys, NFS3PROC_FSINFO, fhandle, info, 0);
 	dprintk("NFS reply fsinfo: %d\n", status);
 	return status;
 }
diff -uNrp linux-2.6.0-test1.0/include/linux/nfs_fs.h linux-2.6.0-test1.1/include/linux/nfs_fs.h
--- linux-2.6.0-test1.0/include/linux/nfs_fs.h	Tue Jul 15 21:10:08 2003
+++ linux-2.6.0-test1.1/include/linux/nfs_fs.h	Tue Jul 15 21:47:23 2003
@@ -172,6 +172,7 @@ struct nfs_inode {
 #define NFS_INO_ADVISE_RDPLUS   0x0002          /* advise readdirplus */
 #define NFS_INO_REVALIDATING	0x0004		/* revalidating attrs */
 #define NFS_INO_FLUSH		0x0008		/* inode is due for flushing */
+#define NFS_INO_FAKE_ROOT	0x0080		/* root inode placeholder */
 
 static inline struct nfs_inode *NFS_I(struct inode *inode)
 {
@@ -207,6 +208,7 @@ do { \
 #define NFS_FLAGS(inode)		(NFS_I(inode)->flags)
 #define NFS_REVALIDATING(inode)		(NFS_FLAGS(inode) & NFS_INO_REVALIDATING)
 #define NFS_STALE(inode)		(NFS_FLAGS(inode) & NFS_INO_STALE)
+#define NFS_FAKE_ROOT(inode)		(NFS_FLAGS(inode) & NFS_INO_FAKE_ROOT)
 
 #define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
 
diff -uNrp linux-2.6.0-test1.0/include/linux/nfs_fs_sb.h linux-2.6.0-test1.1/include/linux/nfs_fs_sb.h
--- linux-2.6.0-test1.0/include/linux/nfs_fs_sb.h	Tue Jul 15 21:10:08 2003
+++ linux-2.6.0-test1.1/include/linux/nfs_fs_sb.h	Tue Jul 15 21:45:39 2003
@@ -9,6 +9,7 @@
  */
 struct nfs_server {
 	struct rpc_clnt *	client;		/* RPC client handle */
+	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
 	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
 	struct backing_dev_info	backing_dev_info;
 	int			flags;		/* various flags */
diff -uNrp linux-2.6.0-test1.0/include/linux/nfs_mount.h linux-2.6.0-test1.1/include/linux/nfs_mount.h
--- linux-2.6.0-test1.0/include/linux/nfs_mount.h	Tue Jul 15 21:10:08 2003
+++ linux-2.6.0-test1.1/include/linux/nfs_mount.h	Tue Jul 15 21:45:39 2003
@@ -20,7 +20,7 @@
  * mount-to-kernel version compatibility.  Some of these aren't used yet
  * but here they are anyway.
  */
-#define NFS_MOUNT_VERSION	4
+#define NFS_MOUNT_VERSION	5
 
 struct nfs_mount_data {
 	int		version;		/* 1 */
@@ -40,7 +40,7 @@ struct nfs_mount_data {
 	int		namlen;			/* 2 */
 	unsigned int	bsize;			/* 3 */
 	struct nfs3_fh	root;			/* 4 */
-	int		pseudoflavor;		/* 4 */
+	int		pseudoflavor;		/* 5 */
 };
 
 /* bits in the flags field */
@@ -57,7 +57,7 @@ struct nfs_mount_data {
 #define NFS_MOUNT_NONLM		0x0200	/* 3 */
 #define NFS_MOUNT_BROKEN_SUID	0x0400	/* 4 */
 #define NFS_MOUNT_STRICTLOCK	0x1000	/* reserved for NFSv4 */
-#define NFS_MOUNT_SECFLAVOUR	0x2000	/* reserved */
+#define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
 #endif
