Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVB0Q3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVB0Q3B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVB0Q14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:27:56 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:30932 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261435AbVB0P45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:57 -0500
Message-Id: <20050227152354.731871000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:57 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 14/16] Client side of nfsacl
Content-Disposition: inline; filename=nfsacl-client-side-of-nfsacl.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds acl support fo nfs clients via the NFSACL protocol extension, by
implementing the getxattr, listxattr, setxattr, and removexattr iops for the
system.posix_acl_access and system.posix_acl_default attributes.  This patch
implements a dumb version that uses no caching (and thus adds some overhead). 
(Another patch in this patchset adds caching as well.)

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/fs/Kconfig
===================================================================
--- linux-2.6.11-rc5.orig/fs/Kconfig
+++ linux-2.6.11-rc5/fs/Kconfig
@@ -1459,6 +1459,16 @@ config NFS_V3
 
 	  If unsure, say Y.
 
+config NFS_ACL
+	bool "NFS_ACL protocol extension"
+	depends on NFS_V3
+	help
+	  Implement the NFS_ACL protocol extension for manipulating POSIX
+	  Access Control Lists.  The server must also implement the NFS_ACL
+	  protocol extension; see the CONFIG_NFSD_ACL option.
+
+	  If unsure, say N.
+
 config NFS_V4
 	bool "Provide NFSv4 client support (EXPERIMENTAL)"
 	depends on NFS_FS && EXPERIMENTAL
@@ -1501,6 +1511,7 @@ config NFSD
 	depends on INET
 	select LOCKD
 	select SUNRPC
+	select NFS_ACL_SUPPORT if NFS_ACL
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
Index: linux-2.6.11-rc5/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc5/fs/nfs/dir.c
@@ -76,6 +76,27 @@ struct inode_operations nfs_dir_inode_op
 	.setattr	= nfs_setattr,
 };
 
+#ifdef CONFIG_NFS_V3
+struct inode_operations nfs3_dir_inode_operations = {
+	.create		= nfs_create,
+	.lookup		= nfs_lookup,
+	.link		= nfs_link,
+	.unlink		= nfs_unlink,
+	.symlink	= nfs_symlink,
+	.mkdir		= nfs_mkdir,
+	.rmdir		= nfs_rmdir,
+	.mknod		= nfs_mknod,
+	.rename		= nfs_rename,
+	.permission	= nfs_permission,
+	.getattr	= nfs_getattr,
+	.setattr	= nfs_setattr,
+	.listxattr	= nfs_listxattr,
+	.getxattr	= nfs_getxattr,
+	.setxattr	= nfs_setxattr,
+	.removexattr	= nfs_removexattr,
+};
+#endif  /* CONFIG_NFS_V3 */
+
 #ifdef CONFIG_NFS_V4
 
 static struct dentry *nfs_atomic_lookup(struct inode *, struct dentry *, struct nameidata *);
Index: linux-2.6.11-rc5/fs/nfs/file.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/file.c
+++ linux-2.6.11-rc5/fs/nfs/file.c
@@ -67,6 +67,18 @@ struct inode_operations nfs_file_inode_o
 	.setattr	= nfs_setattr,
 };
 
+#ifdef CONFIG_NFS_V3
+struct inode_operations nfs3_file_inode_operations = {
+	.permission	= nfs_permission,
+	.getattr	= nfs_getattr,
+	.setattr	= nfs_setattr,
+	.listxattr	= nfs_listxattr,
+	.getxattr	= nfs_getxattr,
+	.setxattr	= nfs_setxattr,
+	.removexattr	= nfs_removexattr,
+};
+#endif  /* CONFIG_NFS_v3 */
+
 /* Hack for future NFS swap support */
 #ifndef IS_SWAPFILE
 # define IS_SWAPFILE(inode)	(0)
Index: linux-2.6.11-rc5/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/inode.c
+++ linux-2.6.11-rc5/fs/nfs/inode.c
@@ -104,6 +104,21 @@ struct rpc_program		nfs_program = {
 	.pipe_dir_name		= "/nfs",
 };
 
+#ifdef CONFIG_NFS_ACL
+static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
+static struct rpc_version *	nfsacl_version[] = {
+	[3]			= &nfsacl_version3,
+};
+
+struct rpc_program		nfsacl_program = {
+	.name =			"nfsacl",
+	.number =		NFS3_ACL_PROGRAM,
+	.nrvers =		sizeof(nfsacl_version) / sizeof(nfsacl_version[0]),
+	.version =		nfsacl_version,
+	.stats =		&nfsacl_rpcstat,
+};
+#endif  /* CONFIG_NFS_ACL */
+
 static inline unsigned long
 nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 {
@@ -165,6 +180,10 @@ nfs_umount_begin(struct super_block *sb)
 	/* -EIO all pending I/O */
 	if ((rpc = server->client) != NULL)
 		rpc_killall_tasks(rpc);
+#ifdef CONFIG_NFS_ACL
+	if ((rpc = server->client_acl) != NULL)
+		rpc_killall_tasks(rpc);
+#endif  /* CONFIG_NFS_ACL */
 }
 
 
@@ -453,7 +472,21 @@ nfs_fill_super(struct super_block *sb, s
 		atomic_inc(&server->client->cl_count);
 		server->client_sys = server->client;
 	}
+#ifdef CONFIG_NFS_ACL
+	if (server->flags & NFS_MOUNT_VER3) {
+		struct rpc_clnt *clnt = rpc_clone_client(server->client);
 
+		if (IS_ERR(clnt)) {
+			rpc_release_client(server->client_sys);
+			server->client_sys = NULL;
+			return PTR_ERR(clnt);
+		}
+		rpc_change_program(clnt, &nfsacl_program, 3);
+		server->client_acl = clnt;
+		/* Initially assume the nfsacl program is supported */
+		server->flags |= NFSACL;
+	}
+#endif
 	if (server->flags & NFS_MOUNT_VER3) {
 		if (server->namelen == 0 || server->namelen > NFS3_MAXNAMLEN)
 			server->namelen = NFS3_MAXNAMLEN;
@@ -625,6 +658,18 @@ nfs_init_locked(struct inode *inode, voi
 /* Don't use READDIRPLUS on directories that we believe are too large */
 #define NFS_LIMIT_READDIRPLUS (8*PAGE_SIZE)
 
+#ifdef CONFIG_NFS_ACL
+struct inode_operations nfs3_special_inode_operations = {
+	.permission =	nfs_permission,
+	.getattr =	nfs_getattr,
+	.setattr =	nfs_setattr,
+	.listxattr =	nfs_listxattr,
+	.getxattr =	nfs_getxattr,
+	.setxattr =	nfs_setxattr,
+	.removexattr =	nfs_removexattr,
+};
+#endif  /* CONFIG_NFS_ACL */
+
 /*
  * This is our front-end to iget that looks up inodes by file handle
  * instead of inode number.
@@ -665,7 +710,7 @@ nfs_fhget(struct super_block *sb, struct
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
 		 */
-		inode->i_op = &nfs_file_inode_operations;
+		inode->i_op = NFS_SB(sb)->rpc_ops->file_inode_ops;
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &nfs_file_operations;
 			inode->i_data.a_ops = &nfs_file_aops;
@@ -678,8 +723,12 @@ nfs_fhget(struct super_block *sb, struct
 				NFS_FLAGS(inode) |= NFS_INO_ADVISE_RDPLUS;
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
-		else
+		else {
+			if (NFS_SB(sb)->rpc_ops->special_inode_ops)
+				inode->i_op = NFS_SB(sb)->rpc_ops->
+						       special_inode_ops;
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
+		}
 
 		nfsi->read_cache_jiffies = fattr->timestamp;
 		inode->i_atime = fattr->atime;
@@ -1456,6 +1505,10 @@ static void nfs_kill_super(struct super_
 		rpc_shutdown_client(server->client);
 	if (server->client_sys != NULL && !IS_ERR(server->client_sys))
 		rpc_shutdown_client(server->client_sys);
+#ifdef CONFIG_NFS_ACL
+	if (server->client_acl != NULL && !IS_ERR(server->client_acl))
+		rpc_shutdown_client(server->client_acl);
+#endif
 
 	if (!(server->flags & NFS_MOUNT_NONLM))
 		lockd_down();	/* release rpc.lockd */
Index: linux-2.6.11-rc5/fs/nfs/Makefile
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/Makefile
+++ linux-2.6.11-rc5/fs/nfs/Makefile
@@ -8,6 +8,7 @@ nfs-y 			:= dir.o file.o inode.o nfs2xdr
 			   proc.o read.o symlink.o unlink.o write.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o      
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
+nfs-$(CONFIG_NFS_ACL)	+= xattr.o
 nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o \
 			   delegation.o idmap.o \
 			   callback.o callback_xdr.o callback_proc.o
Index: linux-2.6.11-rc5/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs3proc.c
@@ -17,6 +17,7 @@
 #include <linux/nfs_page.h>
 #include <linux/lockd/bind.h>
 #include <linux/smp_lock.h>
+#include <linux/nfs_mount.h>
 
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
@@ -45,7 +46,7 @@ static inline int
 nfs3_rpc_call_wrapper(struct rpc_clnt *clnt, u32 proc, void *argp, void *resp, int flags)
 {
 	struct rpc_message msg = {
-		.rpc_proc	= &nfs3_procedures[proc],
+		.rpc_proc	= &clnt->cl_procinfo[proc],
 		.rpc_argp	= argp,
 		.rpc_resp	= resp,
 	};
@@ -719,6 +720,218 @@ nfs3_proc_pathconf(struct nfs_server *se
 	return status;
 }
 
+#ifdef CONFIG_NFS_ACL
+static struct posix_acl *
+nfs3_proc_getacl(struct inode *inode, int type)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs_fattr fattr;
+	struct page *pages[NFSACL_MAXPAGES] = { };
+	struct nfs3_getaclargs args = {
+		/* The xdr layer may allocate pages here. */
+		.pages =	pages,
+	};
+	struct nfs3_getaclres res = {
+		.fattr =	&fattr,
+	};
+	struct posix_acl *acl = NULL;
+	int status, count;
+
+	if (!(server->flags & NFSACL) || (server->flags & NFS_MOUNT_NOACL))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	switch (type) {
+		case ACL_TYPE_ACCESS:
+			args.mask = NFS3_ACLCNT|NFS3_ACL;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			if (!S_ISDIR(inode->i_mode))
+				return NULL;
+			args.mask = NFS3_DFACLCNT|NFS3_DFACL;
+			break;
+
+		default:
+			return ERR_PTR(-EINVAL);
+	}
+	args.fh = NFS_FH(inode);
+
+	dprintk("NFS call getacl\n");
+	status = rpc_call(server->client_acl, NFS3PROC_GETACL,
+			  &args, &res, 0);
+	dprintk("NFS reply getacl: %d\n", status);
+
+	/* pages may have been allocated at the xdr layer. */
+	for (count = 0; count < NFSACL_MAXPAGES && args.pages[count]; count++)
+		__free_page(args.pages[count]);
+
+	if (status) {
+		if (status == -ENOSYS || status == -EOPNOTSUPP) {
+			dprintk("NFS_ACL extension not supported; disabling\n");
+			server->flags &= ~NFSACL;
+			status = -EOPNOTSUPP;
+		} else if (status == -ENOTSUPP)
+			status = -EOPNOTSUPP;
+		goto getout;
+	}
+	if ((args.mask & res.mask) != args.mask) {
+		status = -EIO;
+		goto getout;
+	}
+
+	status = nfs_refresh_inode(inode, &fattr);
+	if (res.acl_access) {
+		if (posix_acl_equiv_mode(res.acl_access, NULL) == 0) {
+			posix_acl_release(res.acl_access);
+			res.acl_access = NULL;
+		}
+	}
+
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			acl = res.acl_access;
+			res.acl_access = NULL;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			acl = res.acl_default;
+			res.acl_default = NULL;
+			break;
+	}
+
+getout:
+	posix_acl_release(res.acl_access);
+	posix_acl_release(res.acl_default);
+
+	if (status) {
+		posix_acl_release(acl);
+		acl = ERR_PTR(status);
+	}
+	return acl;
+}
+#endif  /* CONFIG_NFS_ACL */
+
+#ifdef CONFIG_NFS_ACL
+static int
+nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
+		  struct posix_acl *dfacl)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs_fattr fattr;
+	struct page *pages[NFSACL_MAXPAGES] = { };
+	struct nfs3_setaclargs args = {
+		.pages = pages,
+	};
+	int status, count;
+
+	if (!(server->flags & NFSACL) || (server->flags & NFS_MOUNT_NOACL))
+		return -EOPNOTSUPP;
+
+	/* We are doing this here, because XDR marshalling can only
+	   return -ENOMEM. */
+	if (acl && acl->a_count > NFS3_ACL_MAX_ENTRIES)
+		return -ENOSPC;
+	if (dfacl && dfacl->a_count > NFS3_ACL_MAX_ENTRIES)
+		return -ENOSPC;
+	args.inode = inode;
+	args.mask = NFS3_ACL;
+	args.acl_access = acl;
+	if (S_ISDIR(inode->i_mode)) {
+		args.mask |= NFS3_DFACL;
+		args.acl_default = dfacl;
+	}
+
+	dprintk("NFS call setacl\n");
+	status = rpc_call(server->client_acl, NFS3PROC_SETACL,
+			  &args, &fattr, 0);
+	dprintk("NFS reply setacl: %d\n", status);
+
+	/* pages may have been allocated at the xdr layer. */
+	for (count = 0; count < NFSACL_MAXPAGES && args.pages[count]; count++)
+		__free_page(args.pages[count]);
+
+	if (status) {
+		if (status == -ENOSYS || status == -EOPNOTSUPP) {
+			dprintk("NFS_ACL SETACL RPC not supported"
+				"(will not retry)\n");
+			server->flags &= ~NFSACL;
+			status = -EOPNOTSUPP;
+		} else if (status == -ENOTSUPP)
+			status = -EOPNOTSUPP;
+	} else {
+		struct rpc_cred **cred = &NFS_I(inode)->cache_access.cred;
+		if (*cred) {
+			put_rpccred(*cred);
+			*cred = NULL;
+		}
+		if (acl) {
+			/*
+			 * Updating the access acl modifies the file mode
+			 * mode permission bits, so update the icache.
+			 */
+			mode_t mode = inode->i_mode;
+			int error = posix_acl_equiv_mode(acl, &mode);
+			if (error >= 0)
+				inode->i_mode = mode;
+			if (error == 0) {
+				/*
+				 * The acl is equivalent to the file mode
+				 * permission bits. No need to cache it.
+				 */
+				acl = NULL;
+			}
+		}
+		status = nfs_refresh_inode(inode, &fattr);
+	}
+
+	return status;
+}
+#endif  /* CONFIG_NFS_ACL */
+
+#ifdef CONFIG_NFS_ACL
+static int
+nfs3_proc_setacl(struct inode *inode, int type, struct posix_acl *acl)
+{
+	struct posix_acl *alloc = NULL, *dfacl = NULL;
+	int status;
+
+	if (S_ISDIR(inode->i_mode)) {
+		switch(type) {
+			case ACL_TYPE_ACCESS:
+				alloc = dfacl = NFS_PROTO(inode)->
+					getacl(inode, ACL_TYPE_DEFAULT);
+				if (IS_ERR(alloc))
+					goto fail;
+				break;
+
+			case ACL_TYPE_DEFAULT:
+				dfacl = acl;
+				alloc = acl = NFS_PROTO(inode)->
+					getacl(inode, ACL_TYPE_ACCESS);
+				if (IS_ERR(alloc))
+					goto fail;
+				break;
+
+			default:
+				return -EINVAL;
+		}
+	} else if (type != ACL_TYPE_ACCESS)
+			return -EINVAL;
+
+	if (acl == NULL) {
+		alloc = acl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+		if (IS_ERR(alloc))
+			goto fail;
+	}
+	status = nfs3_proc_setacls(inode, acl, dfacl);
+	posix_acl_release(alloc);
+	return status;
+
+fail:
+	return PTR_ERR(alloc);
+}
+#endif  /* CONFIG_NFS_ACL */
+
 extern u32 *nfs3_decode_dirent(u32 *, struct nfs_entry *, int);
 
 static void
@@ -842,7 +1055,9 @@ nfs3_proc_lock(struct file *filp, int cm
 struct nfs_rpc_ops	nfs_v3_clientops = {
 	.version	= 3,			/* protocol version */
 	.dentry_ops	= &nfs_dentry_operations,
-	.dir_inode_ops	= &nfs_dir_inode_operations,
+	.file_inode_ops	= &nfs3_file_inode_operations,
+	.dir_inode_ops	= &nfs3_dir_inode_operations,
+	.special_inode_ops = &nfs3_special_inode_operations,
 	.getroot	= nfs3_proc_get_root,
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
@@ -873,4 +1088,9 @@ struct nfs_rpc_ops	nfs_v3_clientops = {
 	.file_open	= nfs_open,
 	.file_release	= nfs_release,
 	.lock		= nfs3_proc_lock,
+#ifdef CONFIG_NFS_ACL
+	.getacl		= nfs3_proc_getacl,
+	.setacl		= nfs3_proc_setacl,
+	.setacls	= nfs3_proc_setacls,
+#endif  /* CONFIG_NFS_ACL */
 };
Index: linux-2.6.11-rc5/fs/nfs/nfs3xdr.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs3xdr.c
+++ linux-2.6.11-rc5/fs/nfs/nfs3xdr.c
@@ -21,6 +21,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfsacl.h>
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
@@ -62,6 +63,8 @@ extern int			nfs_stat_to_errno(int);
 #define NFS3_linkargs_sz		(NFS3_fh_sz+NFS3_diropargs_sz)
 #define NFS3_readdirargs_sz	(NFS3_fh_sz+2)
 #define NFS3_commitargs_sz	(NFS3_fh_sz+3)
+#define NFS3_getaclargs_sz	(NFS3_fh_sz+1)
+#define NFS3_setaclargs_sz	(NFS3_fh_sz+1+2*(2+5*3))
 
 #define NFS3_attrstat_sz	(1+NFS3_fattr_sz)
 #define NFS3_wccstat_sz		(1+NFS3_wcc_data_sz)
@@ -78,6 +81,8 @@ extern int			nfs_stat_to_errno(int);
 #define NFS3_fsinfores_sz	(1+NFS3_post_op_attr_sz+12)
 #define NFS3_pathconfres_sz	(1+NFS3_post_op_attr_sz+6)
 #define NFS3_commitres_sz	(1+NFS3_wcc_data_sz+2)
+#define NFS3_getaclres_sz	(1+NFS3_post_op_attr_sz+1+2*(2+5*3))
+#define NFS3_setaclres_sz	(1+NFS3_post_op_attr_sz)
 
 /*
  * Map file type to S_IFMT bits
@@ -627,6 +632,76 @@ nfs3_xdr_commitargs(struct rpc_rqst *req
 	return 0;
 }
 
+#ifdef CONFIG_NFS_ACL
+/*
+ * Encode GETACL arguments
+ */
+static int
+nfs3_xdr_getaclargs(struct rpc_rqst *req, u32 *p,
+		    struct nfs3_getaclargs *args)
+{
+	struct rpc_auth *auth = req->rq_task->tk_auth;
+	unsigned int replen;
+
+	p = xdr_encode_fhandle(p, args->fh);
+	*p++ = htonl(args->mask);
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+
+	if (args->mask & (NFS3_ACL | NFS3_DFACL)) {
+		/* Inline the page array */
+		replen = (RPC_REPHDRSIZE + auth->au_rslack +
+			  NFS3_getaclres_sz) << 2;
+		xdr_inline_pages(&req->rq_rcv_buf, replen, args->pages, 0,
+				 NFSACL_MAXPAGES << PAGE_SHIFT);
+	}
+	return 0;
+}
+#endif  /* CONFIG_NFS_ACL */
+
+#ifdef CONFIG_NFS_ACL
+/*
+ * Encode SETACL arguments
+ */
+static int
+nfs3_xdr_setaclargs(struct rpc_rqst *req, u32 *p,
+                   struct nfs3_setaclargs *args)
+{
+	struct xdr_buf *buf = &req->rq_snd_buf;
+	unsigned int base, len_in_head, len = nfsacl_size(
+		(args->mask & NFS3_ACL)   ? args->acl_access  : NULL,
+		(args->mask & NFS3_DFACL) ? args->acl_default : NULL);
+	int count, err;
+
+	p = xdr_encode_fhandle(p, NFS_FH(args->inode));
+	*p++ = htonl(args->mask);
+	base = (char *)p - (char *)buf->head->iov_base;
+	/* put as much of the acls into head as possible. */
+	len_in_head = min_t(unsigned int, buf->head->iov_len - base, len);
+	len -= len_in_head;
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p + len_in_head);
+
+	for (count = 0; (count << PAGE_SHIFT) < len; count++) {
+		args->pages[count] = alloc_page(GFP_KERNEL);
+		if (!args->pages[count]) {
+			while (count)
+				__free_page(args->pages[--count]);
+			return -ENOMEM;
+		}
+	}
+	xdr_encode_pages(buf, args->pages, 0, len);
+
+	err = nfsacl_encode(buf, base, args->inode,
+			    (args->mask & NFS3_ACL) ?
+			    args->acl_access : NULL, 1, 0);
+	if (err > 0)
+		err = nfsacl_encode(buf, base + err, args->inode,
+				    (args->mask & NFS3_DFACL) ?
+				    args->acl_default : NULL, 1,
+				    NFS3_ACL_DEFAULT);
+	return (err > 0) ? 0 : err;
+}
+#endif  /* CONFIG_NFS_ACL */
+
 /*
  * NFS XDR decode functions
  */
@@ -978,6 +1053,56 @@ nfs3_xdr_commitres(struct rpc_rqst *req,
 	return 0;
 }
 
+#ifdef CONFIG_NFS_ACL
+/*
+ * Decode GETACL reply
+ */
+static int
+nfs3_xdr_getaclres(struct rpc_rqst *req, u32 *p,
+		   struct nfs3_getaclres *res)
+{
+	struct xdr_buf *buf = &req->rq_rcv_buf;
+	int status = ntohl(*p++);
+	struct posix_acl **acl;
+	unsigned int *aclcnt;
+	int err, base;
+
+	if (status != 0)
+		return -nfs_stat_to_errno(status);
+	p = xdr_decode_post_op_attr(p, res->fattr);
+	res->mask = ntohl(*p++);
+	if (res->mask & ~(NFS3_ACL|NFS3_ACLCNT|NFS3_DFACL|NFS3_DFACLCNT))
+		return -EINVAL;
+	base = (char *)p - (char *)req->rq_rcv_buf.head->iov_base;
+
+	acl = (res->mask & NFS3_ACL) ? &res->acl_access : NULL;
+	aclcnt = (res->mask & NFS3_ACLCNT) ? &res->acl_access_count : NULL;
+	err = nfsacl_decode(buf, base, aclcnt, acl);
+
+	acl = (res->mask & NFS3_DFACL) ? &res->acl_default : NULL;
+	aclcnt = (res->mask & NFS3_DFACLCNT) ? &res->acl_default_count : NULL;
+	if (err > 0)
+		err = nfsacl_decode(buf, base + err, aclcnt, acl);
+	return (err > 0) ? 0 : err;
+}
+#endif  /* CONFIG_NFS_ACL */
+
+#ifdef CONFIG_NFS_ACL
+/*
+ * Decode setacl reply.
+ */
+static int
+nfs3_xdr_setaclres(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+{
+	int status = ntohl(*p++);
+
+	if (status)
+		return -nfs_stat_to_errno(status);
+	xdr_decode_post_op_attr(p, fattr);
+	return 0;
+}
+#endif  /* CONFIG_NFS_ACL */
+
 #ifndef MAX
 # define MAX(a, b)	(((a) > (b))? (a) : (b))
 #endif
@@ -1021,3 +1146,16 @@ struct rpc_version		nfs_version3 = {
 	.procs			= nfs3_procedures
 };
 
+#ifdef CONFIG_NFS_ACL
+static struct rpc_procinfo	nfs3_acl_procedures[] = {
+  PROC(GETACL,		getaclargs,	getaclres, 1),
+  PROC(SETACL,		setaclargs,	setaclres, 0),
+};
+
+struct rpc_version		nfsacl_version3 = {
+	.number			= 3,
+	.nrprocs		= sizeof(nfs3_acl_procedures)/
+				  sizeof(nfs3_acl_procedures[0]),
+	.procs			= nfs3_acl_procedures,
+};
+#endif  /* CONFIG_NFS_ACL */
Index: linux-2.6.11-rc5/fs/nfs/xattr.c
===================================================================
--- /dev/null
+++ linux-2.6.11-rc5/fs/nfs/xattr.c
@@ -0,0 +1,114 @@
+#include <linux/fs.h>
+#include <linux/nfs.h>
+#include <linux/nfs3.h>
+#include <linux/nfs_fs.h>
+#include <linux/xattr_acl.h>
+
+ssize_t
+nfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct posix_acl *acl;
+	int pos=0, len=0;
+
+#	define output(s) do {						\
+			if (pos + sizeof(s) <= size) {			\
+				memcpy(buffer + pos, s, sizeof(s));	\
+				pos += sizeof(s);			\
+			}						\
+			len += sizeof(s);				\
+		} while(0)
+
+	acl = NFS_PROTO(inode)->getacl(inode, ACL_TYPE_ACCESS);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	if (acl) {
+		output("system.posix_acl_access");
+		posix_acl_release(acl);
+	}
+
+	if (S_ISDIR(inode->i_mode)) {
+		acl = NFS_PROTO(inode)->getacl(inode, ACL_TYPE_DEFAULT);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+		if (acl) {
+			output("system.posix_acl_default");
+			posix_acl_release(acl);
+		}
+	}
+
+#	undef output
+
+	if (!buffer || len <= size)
+		return len;
+	return -ERANGE;
+}
+
+ssize_t
+nfs_getxattr(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct posix_acl *acl;
+	int type, error = 0;
+
+	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
+		type = ACL_TYPE_ACCESS;
+	else if (strcmp(name, XATTR_NAME_ACL_DEFAULT) == 0)
+		type = ACL_TYPE_DEFAULT;
+	else
+		return -EOPNOTSUPP;
+
+	acl = NFS_PROTO(inode)->getacl(inode, type);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	else if (acl) {
+		if (type == ACL_TYPE_ACCESS && acl->a_count == 0)
+			error = -ENODATA;
+		else
+			error = posix_acl_to_xattr(acl, buffer, size);
+		posix_acl_release(acl);
+	} else
+		error = -ENODATA;
+
+	return error;
+}
+
+int
+nfs_setxattr(struct dentry *dentry, const char *name,
+	     const void *value, size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct posix_acl *acl;
+	int type, error;
+
+	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
+		type = ACL_TYPE_ACCESS;
+	else if (strcmp(name, XATTR_NAME_ACL_DEFAULT) == 0)
+		type = ACL_TYPE_DEFAULT;
+	else
+		return -EOPNOTSUPP;
+
+	acl = posix_acl_from_xattr(value, size);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+	error = NFS_PROTO(inode)->setacl(inode, type, acl);
+	posix_acl_release(acl);
+
+	return error;
+}
+
+int
+nfs_removexattr(struct dentry *dentry, const char *name)
+{
+	struct inode *inode = dentry->d_inode;
+	int type;
+
+	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
+		type = ACL_TYPE_ACCESS;
+	else if (strcmp(name, XATTR_NAME_ACL_DEFAULT) == 0)
+		type = ACL_TYPE_DEFAULT;
+	else
+		return -EOPNOTSUPP;
+
+	return NFS_PROTO(inode)->setacl(inode, type, NULL);
+}
Index: linux-2.6.11-rc5/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_fs.h
+++ linux-2.6.11-rc5/include/linux/nfs_fs.h
@@ -285,6 +285,8 @@ static inline int nfs_verify_change_attr
 /*
  * linux/fs/nfs/inode.c
  */
+extern struct inode_operations nfs3_special_inode_operations;
+
 extern void nfs_zap_caches(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
 				struct nfs_fattr *);
@@ -318,6 +320,7 @@ extern u32 root_nfs_parse_addr(char *nam
  * linux/fs/nfs/file.c
  */
 extern struct inode_operations nfs_file_inode_operations;
+extern struct inode_operations nfs3_file_inode_operations;
 extern struct file_operations nfs_file_operations;
 extern struct address_space_operations nfs_file_aops;
 
@@ -333,6 +336,22 @@ static inline struct rpc_cred *nfs_file_
 }
 
 /*
+ * linux/fs/nfs/xattr.c
+ */
+#ifdef CONFIG_NFS_ACL
+extern ssize_t nfs_listxattr(struct dentry *, char *, size_t);
+extern ssize_t nfs_getxattr(struct dentry *, const char *, void *, size_t);
+extern int nfs_setxattr(struct dentry *, const char *,
+			const void *, size_t, int);
+extern int nfs_removexattr (struct dentry *, const char *name);
+#else
+# define nfs_listxattr NULL
+# define nfs_getxattr NULL
+# define nfs_setxattr NULL
+# define nfs_removexattr NULL
+#endif
+
+/*
  * linux/fs/nfs/direct.c
  */
 extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, loff_t,
@@ -346,6 +365,7 @@ extern ssize_t nfs_file_direct_write(str
  * linux/fs/nfs/dir.c
  */
 extern struct inode_operations nfs_dir_inode_operations;
+extern struct inode_operations nfs3_dir_inode_operations;
 extern struct file_operations nfs_dir_operations;
 extern struct dentry_operations nfs_dentry_operations;
 
Index: linux-2.6.11-rc5/include/linux/nfs_fs_sb.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_fs_sb.h
+++ linux-2.6.11-rc5/include/linux/nfs_fs_sb.h
@@ -10,6 +10,9 @@
 struct nfs_server {
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
+#ifdef CONFIG_NFS_ACL
+	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
+#endif  /* CONFIG_NFS_ACL */
 	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
 	struct backing_dev_info	backing_dev_info;
 	int			flags;		/* various flags */
Index: linux-2.6.11-rc5/include/linux/nfs_mount.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_mount.h
+++ linux-2.6.11-rc5/include/linux/nfs_mount.h
@@ -63,4 +63,7 @@ struct nfs_mount_data {
 #define NFS_MOUNT_SECFLAVOUR	0x2000	/* 5 */
 #define NFS_MOUNT_FLAGMASK	0xFFFF
 
+/* Feature flag for the NFS_ACL protocol extension */
+#define NFSACL			0x10000
+
 #endif
Index: linux-2.6.11-rc5/include/linux/nfs_xdr.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_xdr.h
+++ linux-2.6.11-rc5/include/linux/nfs_xdr.h
@@ -2,6 +2,7 @@
 #define _LINUX_NFS_XDR_H
 
 #include <linux/sunrpc/xprt.h>
+#include <linux/nfsacl.h>
 
 struct nfs4_fsid {
 	__u64 major;
@@ -354,6 +355,20 @@ struct nfs_readdirargs {
 	struct page **		pages;
 };
 
+struct nfs3_getaclargs {
+	struct nfs_fh *		fh;
+	int			mask;
+	struct page **		pages;
+};
+
+struct nfs3_setaclargs {
+	struct inode *		inode;
+	int			mask;
+	struct posix_acl *	acl_access;
+	struct posix_acl *	acl_default;
+	struct page **		pages;
+};
+
 struct nfs_diropok {
 	struct nfs_fh *		fh;
 	struct nfs_fattr *	fattr;
@@ -477,6 +492,15 @@ struct nfs3_readdirres {
 	int			plus;
 };
 
+struct nfs3_getaclres {
+	struct nfs_fattr *	fattr;
+	int			mask;
+	unsigned int		acl_access_count;
+	unsigned int		acl_default_count;
+	struct posix_acl *	acl_access;
+	struct posix_acl *	acl_default;
+};
+
 #ifdef CONFIG_NFS_V4
 
 typedef u64 clientid4;
@@ -665,7 +689,9 @@ struct nfs_access_entry;
 struct nfs_rpc_ops {
 	int	version;		/* Protocol version */
 	struct dentry_operations *dentry_ops;
+	struct inode_operations *file_inode_ops;
 	struct inode_operations *dir_inode_ops;
+	struct inode_operations *special_inode_ops;
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsinfo *);
@@ -712,6 +738,11 @@ struct nfs_rpc_ops {
 	int	(*file_open)   (struct inode *, struct file *);
 	int	(*file_release) (struct inode *, struct file *);
 	int	(*lock)(struct file *, int, struct file_lock *);
+#ifdef CONFIG_NFS_ACL
+	struct posix_acl * (*getacl)(struct inode *, int);
+	int	(*setacl)(struct inode *, int, struct posix_acl *);
+	int	(*setacls)(struct inode *, struct posix_acl *, struct posix_acl *);
+#endif  /* CONFIG_NFS_ACL */
 };
 
 /*
@@ -733,4 +764,7 @@ extern struct rpc_version	nfs_version4;
 extern struct rpc_program	nfs_program;
 extern struct rpc_stat		nfs_rpcstat;
 
+extern struct rpc_version	nfsacl_version3;
+extern struct rpc_program	nfsacl_program;
+
 #endif
Index: linux-2.6.11-rc5/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs4proc.c
@@ -2590,6 +2590,7 @@ nfs4_proc_lock(struct file *filp, int cm
 struct nfs_rpc_ops	nfs_v4_clientops = {
 	.version	= 4,			/* protocol version */
 	.dentry_ops	= &nfs4_dentry_operations,
+	.file_inode_ops	= &nfs_file_inode_operations,
 	.dir_inode_ops	= &nfs4_dir_inode_operations,
 	.getroot	= nfs4_proc_get_root,
 	.getattr	= nfs4_proc_getattr,
Index: linux-2.6.11-rc5/fs/nfs/proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/proc.c
+++ linux-2.6.11-rc5/fs/nfs/proc.c
@@ -626,6 +626,7 @@ nfs_proc_lock(struct file *filp, int cmd
 struct nfs_rpc_ops	nfs_v2_clientops = {
 	.version	= 2,		       /* protocol version */
 	.dentry_ops	= &nfs_dentry_operations,
+	.file_inode_ops	= &nfs_file_inode_operations,
 	.dir_inode_ops	= &nfs_dir_inode_operations,
 	.getroot	= nfs_proc_get_root,
 	.getattr	= nfs_proc_getattr,

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

