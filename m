Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVAVUyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVAVUyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVAVUvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:51:41 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:49872 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262739AbVAVUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:31 -0500
Message-Id: <20050122203620.213040000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:13 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 13/13] Cache acls on the nfs client side
Content-Disposition: inline; filename=patches.suse/nfsacl-client-cache.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attach acls to inodes in the icache to avoid unnecessary GETACL RPC
round-trips. As long as the client doesn't retrieve any acls itself,
only the default acls of exiting directories and the default and access
acls of new directories will end up in the cache, which preserves some
memory compared to always caching the access and default acl of all
files.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc2/fs/nfs/nfs3proc.c
@@ -729,25 +729,29 @@ nfs3_proc_getacl(struct inode *inode, in
 	struct nfs3_getaclres res = {
 		.fattr =	&fattr,
 	};
-	struct posix_acl *acl = NULL;
+	struct posix_acl *acl;
 	int status, count;
 
 	if (!(server->flags & NFSACL) || (server->flags & NFS_MOUNT_NOACL))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	switch (type) {
-		case ACL_TYPE_ACCESS:
-			args.mask = NFS3_ACLCNT|NFS3_ACL;
-			break;
-
-		case ACL_TYPE_DEFAULT:
-			if (!S_ISDIR(inode->i_mode))
-				return NULL;
-			args.mask = NFS3_DFACLCNT|NFS3_DFACL;
-
-		default:
-			return -EINVAL;
-	}
+	acl = nfs_get_cached_acl(inode, type);
+	if (acl != ERR_PTR(-EAGAIN))
+		return acl;
+	acl = NULL;
+
+	/*
+	 * Only get the access acl when explicitly requested: We don't
+	 * need it for access decisions, and only some applications use
+	 * it. Applications which request the access acl first are not
+	 * penalized from this optimization.
+	 */
+	if (type == ACL_TYPE_ACCESS)
+		args.mask |= NFS3_ACLCNT|NFS3_ACL;
+	if (S_ISDIR(inode->i_mode))
+		args.mask |= NFS3_DFACLCNT|NFS3_DFACL;
+	if (!args.mask)
+		return NULL;
 	args.fh = NFS_FH(inode);
 
 	dprintk("NFS call getacl\n");
@@ -780,6 +784,7 @@ nfs3_proc_getacl(struct inode *inode, in
 			res.acl_access = NULL;
 		}
 	}
+	nfs_cache_acls(inode, res.acl_access, res.acl_default);
 
 	switch(type) {
 		case ACL_TYPE_ACCESS:
@@ -871,6 +876,7 @@ nfs3_proc_setacls(struct inode *inode, s
 				acl = NULL;
 			}
 		}
+		nfs_cache_acls(inode, acl, dfacl);
 		status = nfs_refresh_inode(inode, &fattr);
 	}
 
Index: linux-2.6.11-rc2/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfs/inode.c
+++ linux-2.6.11-rc2/fs/nfs/inode.c
@@ -64,6 +64,19 @@ static void nfs_umount_begin(struct supe
 static int  nfs_statfs(struct super_block *, struct kstatfs *);
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
 
+#ifdef CONFIG_NFS_ACL
+static void nfs_forget_cached_acls(struct inode *);
+static void __nfs_forget_cached_acls(struct nfs_inode *nfsi);
+#else
+static inline void nfs_forget_cached_acls(struct inode *inode)
+{
+}
+
+static inline void __nfs_forget_cached_acls(struct nfs_inode *nfsi)
+{
+}
+#endif
+
 static struct super_operations nfs_sops = { 
 	.alloc_inode	= nfs_alloc_inode,
 	.destroy_inode	= nfs_destroy_inode,
@@ -617,6 +630,7 @@ nfs_zap_caches(struct inode *inode)
 		nfsi->flags |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA|NFS_INO_INVALID_ACCESS;
 	else
 		nfsi->flags |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ACCESS;
+	nfs_forget_cached_acls(inode);
 }
 
 /*
@@ -1159,6 +1173,81 @@ void nfs_end_data_update_defer(struct in
 	}
 }
 
+#ifdef CONFIG_NFS_ACL
+static void __nfs_forget_cached_acls(struct nfs_inode *nfsi)
+{
+	if (nfsi->acl_access != ERR_PTR(-EAGAIN)) {
+		posix_acl_release(nfsi->acl_access);
+		nfsi->acl_access = ERR_PTR(-EAGAIN);
+	}
+	if (nfsi->acl_default != ERR_PTR(-EAGAIN)) {
+		posix_acl_release(nfsi->acl_default);
+		nfsi->acl_default = ERR_PTR(-EAGAIN);
+	}
+}
+#endif  /* CONFIG_NFS_ACL */
+
+#ifdef CONFIG_NFS_ACL
+static void nfs_forget_cached_acls(struct inode *inode)
+{
+	dprintk("NFS: nfs_forget_cached_acls(%s/%ld)\n", inode->i_sb->s_id,
+		inode->i_ino);
+	spin_lock(&inode->i_lock);
+	__nfs_forget_cached_acls(NFS_I(inode));
+	spin_unlock(&inode->i_lock);
+}
+#endif
+
+#ifdef CONFIG_NFS_ACL
+struct posix_acl *nfs_get_cached_acl(struct inode *inode, int type)
+{
+	struct nfs_inode *nfsi = NFS_I(inode);
+	struct posix_acl *acl = ERR_PTR(-EAGAIN);
+
+	spin_lock(&inode->i_lock);
+	if (time_after(jiffies, nfsi->acl_timestamp + nfsi->attrtimeo)) {
+		__nfs_forget_cached_acls(nfsi);
+		nfsi->acl_timestamp = jiffies;
+	} else switch(type) {
+		case ACL_TYPE_ACCESS:
+			acl = nfsi->acl_access;
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			acl = nfsi->acl_default;
+			break;
+
+		default:
+			return ERR_PTR(-EINVAL);
+	}
+	if (acl == ERR_PTR(-EAGAIN))
+		acl = ERR_PTR(-EAGAIN);
+	else
+		acl = posix_acl_dup(acl);
+	spin_unlock(&inode->i_lock);
+	dprintk("NFS: nfs_get_cached_acl(%s/%ld, %d) = %p\n", inode->i_sb->s_id,
+		inode->i_ino, type, acl);
+	return acl;
+}
+#endif  /* CONFIG_NFS_ACL */
+
+#ifdef CONFIG_NFS_ACL
+void nfs_cache_acls(struct inode *inode, struct posix_acl *acl,
+		    struct posix_acl *dfacl)
+{
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	dprintk("nfs_cache_acls(%s/%ld, %p, %p)\n", inode->i_sb->s_id,
+		inode->i_ino, acl, dfacl);
+	spin_lock(&inode->i_lock);
+	__nfs_forget_cached_acls(NFS_I(inode));
+	nfsi->acl_access = posix_acl_dup(acl);
+	nfsi->acl_default = posix_acl_dup(dfacl);
+	nfsi->acl_timestamp = jiffies;
+	spin_unlock(&inode->i_lock);
+}
+#endif  /* CONFIG_NFS_ACL */
+
 /**
  * nfs_refresh_inode - verify consistency of the inode attribute cache
  * @inode - pointer to inode
@@ -1219,8 +1308,10 @@ int nfs_refresh_inode(struct inode *inod
 	/* Have any file permissions changed? */
 	if ((inode->i_mode & S_IALLUGO) != (fattr->mode & S_IALLUGO)
 			|| inode->i_uid != fattr->uid
-			|| inode->i_gid != fattr->gid)
+			|| inode->i_gid != fattr->gid) {
 		nfsi->flags |= NFS_INO_INVALID_ATTR | NFS_INO_INVALID_ACCESS;
+		nfs_forget_cached_acls(inode);
+	}
 
 	/* Has the link count changed? */
 	if (inode->i_nlink != fattr->nlink)
@@ -1337,8 +1428,10 @@ static int nfs_update_inode(struct inode
 
 	if ((inode->i_mode & S_IALLUGO) != (fattr->mode & S_IALLUGO) ||
 	    inode->i_uid != fattr->uid ||
-	    inode->i_gid != fattr->gid)
+	    inode->i_gid != fattr->gid) {
 		invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ACCESS;
+		nfs_forget_cached_acls(inode);
+	}
 
 	inode->i_mode = fattr->mode;
 	inode->i_nlink = fattr->nlink;
@@ -1912,6 +2005,7 @@ static struct inode *nfs_alloc_inode(str
 
 static void nfs_destroy_inode(struct inode *inode)
 {
+	__nfs_forget_cached_acls(NFS_I(inode));
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
 
@@ -1932,6 +2026,10 @@ static void init_once(void * foo, kmem_c
 		nfsi->ncommit = 0;
 		nfsi->npages = 0;
 		init_waitqueue_head(&nfsi->nfs_i_wait);
+#ifdef CONFIG_NFS_ACL
+		nfsi->acl_access = ERR_PTR(-EAGAIN);
+		nfsi->acl_default = ERR_PTR(-EAGAIN);
+#endif
 		nfs4_init_once(nfsi);
 	}
 }
Index: linux-2.6.11-rc2/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/nfs_fs.h
+++ linux-2.6.11-rc2/include/linux/nfs_fs.h
@@ -104,6 +104,8 @@ struct nfs_open_context {
  */
 struct nfs_delegation;
 
+struct posix_acl;
+
 /*
  * nfs fs inode data in memory
  */
@@ -158,6 +160,11 @@ struct nfs_inode {
 	atomic_t		data_updates;
 
 	struct nfs_access_entry	cache_access;
+#ifdef CONFIG_NFS_ACL
+	unsigned long		acl_timestamp;
+	struct posix_acl	*acl_access;
+	struct posix_acl	*acl_default;
+#endif
 
 	/*
 	 * This is the cookie verifier used for NFSv3 readdir
@@ -284,6 +291,8 @@ static inline int nfs_verify_change_attr
 extern void nfs_zap_caches(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
 				struct nfs_fattr *);
+extern struct posix_acl *nfs_get_cached_acl(struct inode *, int);
+extern void nfs_cache_acls(struct inode *, struct posix_acl *, struct posix_acl *);
 extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 extern int nfs_permission(struct inode *, int, struct nameidata *);

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

