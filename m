Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVBVNlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVBVNlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVBVNlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:41:45 -0500
Received: from news.suse.de ([195.135.220.2]:59789 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262303AbVBVNlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:41:32 -0500
Subject: Re: [patch 11/13] Client side of nfsacl
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108489757.10073.46.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.005569000@blunzn.suse.de>
	 <1108489757.10073.46.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-KBB4fF7fGer0YJU4kjR2"
Organization: SUSE Labs
Message-Id: <1109079688.6102.264.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Feb 2005 14:41:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KBB4fF7fGer0YJU4kjR2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 18:49, Trond Myklebust wrote:
> I suggest you rather do the same thing we're doing for the NFSv4 acls,
> and provide an nfsv3-specific struct inode_operations that points to
> nfsv3-specific {get,set,list}xattr functions.

Okay, that requires iops for file, dir, and others. How about the
attached patch?

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-KBB4fF7fGer0YJU4kjR2
Content-Disposition: attachment; filename=nfsacl-client-side-of-nfsacl-fix3.patch
Content-Type: text/x-patch; name=nfsacl-client-side-of-nfsacl-fix3.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.11-rc3/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc3/fs/nfs/nfs3proc.c
@@ -1045,7 +1045,9 @@ nfs3_proc_lock(struct file *filp, int cm
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
Index: linux-2.6.11-rc3/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/inode.c
+++ linux-2.6.11-rc3/fs/nfs/inode.c
@@ -674,7 +674,7 @@ nfs_init_locked(struct inode *inode, voi
 #define NFS_LIMIT_READDIRPLUS (8*PAGE_SIZE)
 
 #ifdef CONFIG_NFS_ACL
-static struct inode_operations nfs_special_inode_operations = {
+struct inode_operations nfs3_special_inode_operations = {
 	.permission =	nfs_permission,
 	.getattr =	nfs_getattr,
 	.setattr =	nfs_setattr,
@@ -725,7 +725,7 @@ nfs_fhget(struct super_block *sb, struct
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
 		 */
-		inode->i_op = &nfs_file_inode_operations;
+		inode->i_op = NFS_SB(sb)->rpc_ops->file_inode_ops;
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &nfs_file_operations;
 			inode->i_data.a_ops = &nfs_file_aops;
@@ -739,9 +739,9 @@ nfs_fhget(struct super_block *sb, struct
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
 		else {
-#ifdef CONFIG_NFS_ACL
-			inode->i_op = &nfs_special_inode_operations;
-#endif
+			if (NFS_SB(sb)->rpc_ops->special_inode_ops)
+				inode->i_op = NFS_SB(sb)->rpc_ops->
+						       special_inode_ops;
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
 		}
 
Index: linux-2.6.11-rc3/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.11-rc3/fs/nfs/nfs4proc.c
@@ -2596,6 +2596,7 @@ nfs4_proc_lock(struct file *filp, int cm
 struct nfs_rpc_ops	nfs_v4_clientops = {
 	.version	= 4,			/* protocol version */
 	.dentry_ops	= &nfs4_dentry_operations,
+	.file_inode_ops	= &nfs_file_inode_operations,
 	.dir_inode_ops	= &nfs4_dir_inode_operations,
 	.getroot	= nfs4_proc_get_root,
 	.getattr	= nfs4_proc_getattr,
Index: linux-2.6.11-rc3/fs/nfs/proc.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/proc.c
+++ linux-2.6.11-rc3/fs/nfs/proc.c
@@ -619,6 +619,7 @@ nfs_proc_lock(struct file *filp, int cmd
 struct nfs_rpc_ops	nfs_v2_clientops = {
 	.version	= 2,		       /* protocol version */
 	.dentry_ops	= &nfs_dentry_operations,
+	.file_inode_ops	= &nfs_file_inode_operations,
 	.dir_inode_ops	= &nfs_dir_inode_operations,
 	.getroot	= nfs_proc_get_root,
 	.getattr	= nfs_proc_getattr,
Index: linux-2.6.11-rc3/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc3/fs/nfs/dir.c
@@ -72,11 +72,28 @@ struct inode_operations nfs_dir_inode_op
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+};
+
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
 	.listxattr	= nfs_listxattr,
 	.getxattr	= nfs_getxattr,
 	.setxattr	= nfs_setxattr,
 	.removexattr	= nfs_removexattr,
 };
+#endif  /* CONFIG_NFS_V3 */
 
 #ifdef CONFIG_NFS_V4
 
Index: linux-2.6.11-rc3/include/linux/nfs_xdr.h
===================================================================
--- linux-2.6.11-rc3.orig/include/linux/nfs_xdr.h
+++ linux-2.6.11-rc3/include/linux/nfs_xdr.h
@@ -689,7 +689,9 @@ struct nfs_access_entry;
 struct nfs_rpc_ops {
 	int	version;		/* Protocol version */
 	struct dentry_operations *dentry_ops;
+	struct inode_operations *file_inode_ops;
 	struct inode_operations *dir_inode_ops;
+	struct inode_operations *special_inode_ops;
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsinfo *);
Index: linux-2.6.11-rc3/fs/nfs/xattr.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/xattr.c
+++ linux-2.6.11-rc3/fs/nfs/xattr.c
@@ -11,9 +11,6 @@ nfs_listxattr(struct dentry *dentry, cha
 	struct posix_acl *acl;
 	int pos=0, len=0;
 
-	if (NFS_PROTO(inode)->version != 3 || !NFS_PROTO(inode)->getacl)
-		return -EOPNOTSUPP;
-
 #	define output(s) do {						\
 			if (pos + sizeof(s) <= size) {			\
 				memcpy(buffer + pos, s, sizeof(s));	\
@@ -61,9 +58,7 @@ nfs_getxattr(struct dentry *dentry, cons
 	else
 		return -EOPNOTSUPP;
 
-	acl = ERR_PTR(-EOPNOTSUPP);
-	if (NFS_PROTO(inode)->version == 3 && NFS_PROTO(inode)->getacl)
-		acl = NFS_PROTO(inode)->getacl(inode, type);
+	acl = NFS_PROTO(inode)->getacl(inode, type);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	else if (acl) {
@@ -92,8 +87,6 @@ nfs_setxattr(struct dentry *dentry, cons
 		type = ACL_TYPE_DEFAULT;
 	else
 		return -EOPNOTSUPP;
-	if (NFS_PROTO(inode)->version != 3 || !NFS_PROTO(inode)->setacl)
-		return -EOPNOTSUPP;
 
 	acl = posix_acl_from_xattr(value, size);
 	if (IS_ERR(acl))
@@ -108,7 +101,7 @@ int
 nfs_removexattr(struct dentry *dentry, const char *name)
 {
 	struct inode *inode = dentry->d_inode;
-	int error, type;
+	int type;
 
 	if (strcmp(name, XATTR_NAME_ACL_ACCESS) == 0)
 		type = ACL_TYPE_ACCESS;
@@ -117,9 +110,5 @@ nfs_removexattr(struct dentry *dentry, c
 	else
 		return -EOPNOTSUPP;
 
-	error = -EOPNOTSUPP;
-	if (NFS_PROTO(inode)->version == 3 && NFS_PROTO(inode)->setacl)
-		error = NFS_PROTO(inode)->setacl(inode, type, NULL);
-
-	return error;
+	return NFS_PROTO(inode)->setacl(inode, type, NULL);
 }
Index: linux-2.6.11-rc3/fs/nfs/file.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/file.c
+++ linux-2.6.11-rc3/fs/nfs/file.c
@@ -68,11 +68,19 @@ struct inode_operations nfs_file_inode_o
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+};
+
+#ifdef CONFIG_NFS_V3
+struct inode_operations nfs3_file_inode_operations = {
+	.permission	= nfs_permission,
+	.getattr	= nfs_getattr,
+	.setattr	= nfs_setattr,
 	.listxattr	= nfs_listxattr,
 	.getxattr	= nfs_getxattr,
 	.setxattr	= nfs_setxattr,
 	.removexattr	= nfs_removexattr,
 };
+#endif  /* CONFIG_NFS_v3 */
 
 /* Hack for future NFS swap support */
 #ifndef IS_SWAPFILE
Index: linux-2.6.11-rc3/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.11-rc3.orig/include/linux/nfs_fs.h
+++ linux-2.6.11-rc3/include/linux/nfs_fs.h
@@ -281,6 +281,8 @@ static inline int nfs_verify_change_attr
 /*
  * linux/fs/nfs/inode.c
  */
+extern struct inode_operations nfs3_special_inode_operations;
+
 extern void nfs_zap_caches(struct inode *);
 extern struct inode *nfs_fhget(struct super_block *, struct nfs_fh *,
 				struct nfs_fattr *);
@@ -314,6 +316,7 @@ extern u32 root_nfs_parse_addr(char *nam
  * linux/fs/nfs/file.c
  */
 extern struct inode_operations nfs_file_inode_operations;
+extern struct inode_operations nfs3_file_inode_operations;
 extern struct file_operations nfs_file_operations;
 extern struct address_space_operations nfs_file_aops;
 
@@ -358,6 +361,7 @@ extern ssize_t nfs_file_direct_write(str
  * linux/fs/nfs/dir.c
  */
 extern struct inode_operations nfs_dir_inode_operations;
+extern struct inode_operations nfs3_dir_inode_operations;
 extern struct file_operations nfs_dir_operations;
 extern struct dentry_operations nfs_dentry_operations;
 

--=-KBB4fF7fGer0YJU4kjR2--

