Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUIBNqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUIBNqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUIBNqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:46:24 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:25872 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S268315AbUIBNpY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:45:24 -0400
Message-ID: <20040902174521.A13656@castle.nmd.msu.ru>
Date: Thu, 2 Sep 2004 17:45:21 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] exec: atomic MAY_EXEC check and SUID/SGID handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a time window between permission(MAY_EXEC) check in
open_exec() and S_ISUID check plus bprm->e_uid setting in prepare_binprm().
And S_ISUID is checked and bprm->e_uid is copied from the inode without
any serialization with attribute updates.

That means that some executable may have permissions
-rwxr-xr-x    root     disk     /bin/file
at the moment of MAY_EXEC check and
-rwsr-x---    root     disk     /bin/file
at the moment of S_ISUID check, providing lucky users starting /bin/file at
the moment of permission change with a setuid-root program.

It's arguable whether it's a big security issue, but certainly such behavior
is not what administrators may expect.
I do not like the idea of `chmod 04750' being non-atomic and instructions
like
        All system administrator should be aware that setting SUID
        bit on files that are (or used to be) world-executable is dangerous.
	Instead of
                # chgrp disk /bin/file
                # chmod 04750 /bin/file
        administrators should run
                # umask 077
                # cp --preserve=timestamps /bin/file /bin/file.new
                # chgrp disk /bin/file.new
                # chmod 04750 /bin/file.new
                # mv /bin/file.new /bin/file

>From 2 possible solutions:
 - take i_sem and call permission() for the second time in prepare_binprm(),
   causing inode's ->permission() method be called without i_sem in some
   places and with i_sem in the others, and
 - offloading the decisions to the filesystems and returning i_mode, i_uid
   and i_gid from the place where MAY_EXEC permission is checked
I prefer the second one.

Any opinions?

        Andrey

--- ./arch/mips/kernel/irixelf.c.stabexec	2004-09-02 14:40:17.000000000 +0400
+++ ./arch/mips/kernel/irixelf.c	2004-09-02 14:40:28.577905360 +0400
@@ -448,7 +448,12 @@ static inline int look_for_irix_interpre
 		if (retval < 0)
 			goto out;
 
-		file = open_exec(*name);
+		/*
+		 * I don't understand this loop.
+		 * Are we suppose to break the loop after successful open and
+		 * read, or close the file, or store it somewhere?  --SAW
+		 */
+		file = open_exec(*name, bprm);
 		if (IS_ERR(file)) {
 			retval = PTR_ERR(file);
 			goto out;
--- ./drivers/block/floppy.c.stabexec	2004-09-01 14:32:24.000000000 +0400
+++ ./drivers/block/floppy.c	2004-09-02 14:11:40.000000000 +0400
@@ -3774,7 +3774,7 @@ static int floppy_open(struct inode *ino
 	 * Needed so that programs such as fdrawcmd still can work on write
 	 * protected disks */
 	if (filp->f_mode & 2
-	    || permission(filp->f_dentry->d_inode, 2, NULL) == 0)
+	    || permission(filp->f_dentry->d_inode, 2, NULL, NULL) == 0)
 		filp->private_data = (void *)8;
 
 	if (UFDCS->rawcmd == 1)
--- ./fs/cifs/cifsfs.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/cifs/cifsfs.c	2004-09-02 14:11:40.000000000 +0400
@@ -188,7 +188,8 @@ cifs_statfs(struct super_block *sb, stru
 	return 0;		/* always return success? what if volume is no longer available? */
 }
 
-static int cifs_permission(struct inode * inode, int mask, struct nameidata *nd)
+static int cifs_permission(struct inode * inode, int mask,
+		struct nameidata *nd, struct exec_perm *exec_perm)
 {
 	struct cifs_sb_info *cifs_sb;
 
@@ -200,7 +201,7 @@ static int cifs_permission(struct inode 
 		on the client (above and beyond ACL on servers) for  
 		servers which do not support setting and viewing mode bits,
 		so allowing client to check permissions is useful */ 
-		return vfs_permission(inode, mask);
+		return vfs_permission(inode, mask, exec_perm);
 }
 
 static kmem_cache_t *cifs_inode_cachep;
--- ./fs/coda/dir.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/coda/dir.c	2004-09-02 14:11:40.000000000 +0400
@@ -147,7 +147,8 @@ exit:
 }
 
 
-int coda_permission(struct inode *inode, int mask, struct nameidata *nd)
+int coda_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *perm)
 {
         int error = 0;
  
--- ./fs/coda/pioctl.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/coda/pioctl.c	2004-09-02 14:11:40.000000000 +0400
@@ -25,7 +25,7 @@
 
 /* pioctl ops */
 static int coda_ioctl_permission(struct inode *inode, int mask,
-				 struct nameidata *nd);
+				 struct nameidata *nd, struct exec_perm *);
 static int coda_pioctl(struct inode * inode, struct file * filp, 
                        unsigned int cmd, unsigned long user_data);
 
@@ -43,7 +43,8 @@ struct file_operations coda_ioctl_operat
 
 /* the coda pioctl inode ops */
 static int coda_ioctl_permission(struct inode *inode, int mask,
-				 struct nameidata *nd)
+				 struct nameidata *nd,
+				 struct exec_perm *exec_perm)
 {
         return 0;
 }
--- ./fs/ext2/acl.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/ext2/acl.c	2004-09-02 14:11:40.000000000 +0400
@@ -286,7 +286,7 @@ ext2_set_acl(struct inode *inode, int ty
  * inode->i_sem: don't care
  */
 int
-ext2_permission(struct inode *inode, int mask, struct nameidata *nd)
+__ext2_permission(struct inode *inode, int mask)
 {
 	int mode = inode->i_mode;
 
@@ -336,6 +336,29 @@ check_capabilities:
 	return -EACCES;
 }
 
+int
+ext2_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
+{
+	int ret;
+
+	if (exec_perm != NULL)
+		down(&inode->i_sem);
+
+	ret = __ext2_permission(inode, mask);
+
+	if (exec_perm != NULL) {
+		if (!ret) {
+			exec_perm->set = 1;
+			exec_perm->mode = inode->i_mode;
+			exec_perm->uid = inode->i_uid;
+			exec_perm->gid = inode->i_gid;
+		}
+		up(&inode->i_sem);
+	}
+	return ret;
+}
+
 /*
  * Initialize the ACLs of a new inode. Called from ext2_new_inode.
  *
--- ./fs/ext2/acl.h.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/ext2/acl.h	2004-09-02 14:11:40.000000000 +0400
@@ -59,7 +59,8 @@ static inline int ext2_acl_count(size_t 
 #define EXT2_ACL_NOT_CACHED ((void *)-1)
 
 /* acl.c */
-extern int ext2_permission (struct inode *, int, struct nameidata *);
+extern int ext2_permission (struct inode *, int, struct nameidata *,
+		struct exec_perm *);
 extern int ext2_acl_chmod (struct inode *);
 extern int ext2_init_acl (struct inode *, struct inode *);
 
--- ./fs/ext2/xattr_user.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/ext2/xattr_user.c	2004-09-02 14:11:40.000000000 +0400
@@ -40,7 +40,7 @@ ext2_xattr_user_get(struct inode *inode,
 		return -EINVAL;
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	error = permission(inode, MAY_READ, NULL);
+	error = permission(inode, MAY_READ, NULL, NULL);
 	if (error)
 		return error;
 
@@ -60,7 +60,7 @@ ext2_xattr_user_set(struct inode *inode,
 	if ( !S_ISREG(inode->i_mode) &&
 	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
 		return -EPERM;
-	error = permission(inode, MAY_WRITE, NULL);
+	error = permission(inode, MAY_WRITE, NULL, NULL);
 	if (error)
 		return error;
 
--- ./fs/ext3/acl.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/ext3/acl.c	2004-09-02 14:11:40.000000000 +0400
@@ -291,7 +291,7 @@ ext3_set_acl(handle_t *handle, struct in
  * inode->i_sem: don't care
  */
 int
-ext3_permission(struct inode *inode, int mask, struct nameidata *nd)
+__ext3_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	int mode = inode->i_mode;
 
@@ -341,6 +341,29 @@ check_capabilities:
 	return -EACCES;
 }
 
+int
+ext3_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
+{
+	int ret;
+
+	if (exec_perm != NULL)
+		down(&inode->i_sem);
+
+	ret = __ext3_permission(inode, mask);
+
+	if (exec_perm != NULL) {
+		if (!ret) {
+			exec_perm->set = 1;
+			exec_perm->mode = inode->i_mode;
+			exec_perm->uid = inode->i_uid;
+			exec_perm->gid = inode->i_gid;
+		}
+		up(&inode->i_sem);
+	}
+	return ret;
+}
+
 /*
  * Initialize the ACLs of a new inode. Called from ext3_new_inode.
  *
--- ./fs/ext3/acl.h.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/ext3/acl.h	2004-09-02 14:11:40.000000000 +0400
@@ -59,7 +59,8 @@ static inline int ext3_acl_count(size_t 
 #define EXT3_ACL_NOT_CACHED ((void *)-1)
 
 /* acl.c */
-extern int ext3_permission (struct inode *, int, struct nameidata *);
+extern int ext3_permission (struct inode *, int, struct nameidata *,
+		struct exec_perm *);
 extern int ext3_acl_chmod (struct inode *);
 extern int ext3_init_acl (handle_t *, struct inode *, struct inode *);
 
--- ./fs/ext3/xattr_user.c.stabexec	2004-09-01 14:32:51.000000000 +0400
+++ ./fs/ext3/xattr_user.c	2004-09-02 14:11:40.000000000 +0400
@@ -42,7 +42,7 @@ ext3_xattr_user_get(struct inode *inode,
 		return -EINVAL;
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
-	error = permission(inode, MAY_READ, NULL);
+	error = permission(inode, MAY_READ, NULL, NULL);
 	if (error)
 		return error;
 
@@ -62,7 +62,7 @@ ext3_xattr_user_set(struct inode *inode,
 	if ( !S_ISREG(inode->i_mode) &&
 	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
 		return -EPERM;
-	error = permission(inode, MAY_WRITE, NULL);
+	error = permission(inode, MAY_WRITE, NULL, NULL);
 	if (error)
 		return error;
 
--- ./fs/hfs/inode.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/hfs/inode.c	2004-09-02 14:11:40.000000000 +0400
@@ -512,11 +512,11 @@ void hfs_clear_inode(struct inode *inode
 }
 
 static int hfs_permission(struct inode *inode, int mask,
-			  struct nameidata *nd)
+			  struct nameidata *nd, struct exec_perm *exec_perm)
 {
 	if (S_ISREG(inode->i_mode) && mask & MAY_EXEC)
 		return 0;
-	return vfs_permission(inode, mask);
+	return vfs_permission(inode, mask, NULL);
 }
 
 static int hfs_file_open(struct inode *inode, struct file *file)
--- ./fs/hfsplus/inode.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/hfsplus/inode.c	2004-09-02 14:11:40.000000000 +0400
@@ -252,15 +252,19 @@ static void hfsplus_set_perms(struct ino
 	perms->dev = cpu_to_be32(HFSPLUS_I(inode).dev);
 }
 
-static int hfsplus_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int hfsplus_permission(struct inode *inode, int mask,
+		struct nameidata *nd, struct exec_perm *exec_perm)
 {
 	/* MAY_EXEC is also used for lookup, if no x bit is set allow lookup,
 	 * open_exec has the same test, so it's still not executable, if a x bit
 	 * is set fall back to standard permission check.
+	 *
+	 * The comment above and the check below don't make much sense
+	 * with S_ISREG condition...  --SAW
 	 */
 	if (S_ISREG(inode->i_mode) && mask & MAY_EXEC && !(inode->i_mode & 0111))
 		return 0;
-	return vfs_permission(inode, mask);
+	return vfs_permission(inode, mask, exec_perm);
 }
 
 
--- ./fs/hostfs/hostfs_kern.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/hostfs/hostfs_kern.c	2004-09-02 14:11:40.000000000 +0400
@@ -790,7 +790,8 @@ void hostfs_truncate(struct inode *ino)
 	not_implemented();
 }
 
-int hostfs_permission(struct inode *ino, int desired, struct nameidata *nd)
+int hostfs_permission(struct inode *ino, int desired, struct nameidata *nd,
+		struct exec_perm *exec_perm)
 {
 	char *name;
 	int r = 0, w = 0, x = 0, err;
@@ -802,7 +803,7 @@ int hostfs_permission(struct inode *ino,
 	if(name == NULL) return(-ENOMEM);
 	err = access_file(name, r, w, x);
 	kfree(name);
-	if(!err) err = vfs_permission(ino, desired);
+	if(!err) err = vfs_permission(ino, desired, exec_perm);
 	return(err);
 }
 
--- ./fs/hpfs/namei.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/hpfs/namei.c	2004-09-02 14:11:40.000000000 +0400
@@ -415,7 +415,7 @@ again:
 		d_drop(dentry);
 		spin_lock(&dentry->d_lock);
 		if (atomic_read(&dentry->d_count) > 1 ||
-		    permission(inode, MAY_WRITE, NULL) ||
+		    permission(inode, MAY_WRITE, NULL, NULL) ||
 		    !S_ISREG(inode->i_mode) ||
 		    get_write_access(inode)) {
 			spin_unlock(&dentry->d_lock);
--- ./fs/jfs/acl.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/jfs/acl.c	2004-09-02 14:11:40.000000000 +0400
@@ -128,7 +128,7 @@ out:
  *
  * modified vfs_permission to check posix acl
  */
-int jfs_permission(struct inode * inode, int mask, struct nameidata *nd)
+int __jfs_permission(struct inode * inode, int mask, struct nameidata *nd)
 {
 	umode_t mode = inode->i_mode;
 	struct jfs_inode_info *ji = JFS_IP(inode);
@@ -207,6 +207,28 @@ check_capabilities:
 	return -EACCES;
 }
 
+int jfs_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
+{
+	int ret;
+
+	if (exec_perm != NULL)
+		down(&inode->i_sem);
+
+	ret = __jfs_permission(inode, mask);
+
+	if (exec_perm != NULL) {
+		if (!ret) {
+			exec_perm->set = 1;
+			exec_perm->mode = inode->i_mode;
+			exec_perm->uid = inode->i_uid;
+			exec_perm->gid = inode->i_gid;
+		}
+		up(&inode->i_sem);
+	}
+	return ret;
+}
+
 int jfs_init_acl(struct inode *inode, struct inode *dir)
 {
 	struct posix_acl *acl = NULL;
--- ./fs/jfs/jfs_acl.h.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/jfs/jfs_acl.h	2004-09-02 14:11:40.000000000 +0400
@@ -22,7 +22,7 @@
 
 #include <linux/xattr_acl.h>
 
-int jfs_permission(struct inode *, int, struct nameidata *);
+int jfs_permission(struct inode *, int, struct nameidata *, struct exec_perm *);
 int jfs_init_acl(struct inode *, struct inode *);
 int jfs_setattr(struct dentry *, struct iattr *);
 
--- ./fs/jfs/xattr.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/jfs/xattr.c	2004-09-02 14:11:40.000000000 +0400
@@ -778,7 +778,7 @@ static int can_set_xattr(struct inode *i
 	    (!S_ISDIR(inode->i_mode) || inode->i_mode &S_ISVTX))
 		return -EPERM;
 
-	return permission(inode, MAY_WRITE, NULL);
+	return permission(inode, MAY_WRITE, NULL, NULL);
 }
 
 int __jfs_setxattr(struct inode *inode, const char *name, const void *value,
@@ -939,7 +939,7 @@ static int can_get_xattr(struct inode *i
 {
 	if(strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN) == 0)
 		return 0;
-	return permission(inode, MAY_READ, NULL);
+	return permission(inode, MAY_READ, NULL, NULL);
 }
 
 ssize_t __jfs_getxattr(struct inode *inode, const char *name, void *data,
--- ./fs/ncpfs/ioctl.c.stabexec	2004-09-01 14:32:52.000000000 +0400
+++ ./fs/ncpfs/ioctl.c	2004-09-02 14:11:40.000000000 +0400
@@ -34,7 +34,7 @@ ncp_get_fs_info(struct ncp_server* serve
 {
 	struct ncp_fs_info info;
 
-	if ((permission(inode, MAY_WRITE, NULL) != 0)
+	if ((permission(inode, MAY_WRITE, NULL, NULL) != 0)
 	    && (current->uid != server->m.mounted_uid)) {
 		return -EACCES;
 	}
@@ -62,7 +62,7 @@ ncp_get_fs_info_v2(struct ncp_server* se
 {
 	struct ncp_fs_info_v2 info2;
 
-	if ((permission(inode, MAY_WRITE, NULL) != 0)
+	if ((permission(inode, MAY_WRITE, NULL, NULL) != 0)
 	    && (current->uid != server->m.mounted_uid)) {
 		return -EACCES;
 	}
@@ -190,7 +190,7 @@ int ncp_ioctl(struct inode *inode, struc
 	switch (cmd) {
 	case NCP_IOC_NCPREQUEST:
 
-		if ((permission(inode, MAY_WRITE, NULL) != 0)
+		if ((permission(inode, MAY_WRITE, NULL, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid)) {
 			return -EACCES;
 		}
@@ -254,7 +254,7 @@ int ncp_ioctl(struct inode *inode, struc
 		{
 			unsigned long tmp = server->m.mounted_uid;
 
-			if (   (permission(inode, MAY_READ, NULL) != 0)
+			if (   (permission(inode, MAY_READ, NULL, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid))
 			{
 				return -EACCES;
@@ -268,7 +268,7 @@ int ncp_ioctl(struct inode *inode, struc
 		{
 			struct ncp_setroot_ioctl sr;
 
-			if (   (permission(inode, MAY_READ, NULL) != 0)
+			if (   (permission(inode, MAY_READ, NULL, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid))
 			{
 				return -EACCES;
@@ -341,7 +341,7 @@ int ncp_ioctl(struct inode *inode, struc
 
 #ifdef CONFIG_NCPFS_PACKET_SIGNING	
 	case NCP_IOC_SIGN_INIT:
-		if ((permission(inode, MAY_WRITE, NULL) != 0)
+		if ((permission(inode, MAY_WRITE, NULL, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid))
 		{
 			return -EACCES;
@@ -364,7 +364,7 @@ int ncp_ioctl(struct inode *inode, struc
 		return 0;		
 		
         case NCP_IOC_SIGN_WANTED:
-		if (   (permission(inode, MAY_READ, NULL) != 0)
+		if (   (permission(inode, MAY_READ, NULL, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid))
 		{
 			return -EACCES;
@@ -377,7 +377,7 @@ int ncp_ioctl(struct inode *inode, struc
 		{
 			int newstate;
 
-			if (   (permission(inode, MAY_WRITE, NULL) != 0)
+			if (   (permission(inode, MAY_WRITE, NULL, NULL) != 0)
 			    && (current->uid != server->m.mounted_uid))
 			{
 				return -EACCES;
@@ -398,7 +398,7 @@ int ncp_ioctl(struct inode *inode, struc
 
 #ifdef CONFIG_NCPFS_IOCTL_LOCKING
 	case NCP_IOC_LOCKUNLOCK:
-		if (   (permission(inode, MAY_WRITE, NULL) != 0)
+		if (   (permission(inode, MAY_WRITE, NULL, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid))
 		{
 			return -EACCES;
@@ -603,7 +603,7 @@ outrel:			
 #endif /* CONFIG_NCPFS_NLS */
 
 	case NCP_IOC_SETDENTRYTTL:
-		if ((permission(inode, MAY_WRITE, NULL) != 0) &&
+		if ((permission(inode, MAY_WRITE, NULL, NULL) != 0) &&
 				 (current->uid != server->m.mounted_uid))
 			return -EACCES;
 		{
@@ -633,7 +633,7 @@ outrel:			
            so we have this out of switch */
 	if (cmd == NCP_IOC_GETMOUNTUID) {
 		__kernel_uid_t uid = 0;
-		if ((permission(inode, MAY_READ, NULL) != 0)
+		if ((permission(inode, MAY_READ, NULL, NULL) != 0)
 		    && (current->uid != server->m.mounted_uid)) {
 			return -EACCES;
 		}
--- ./fs/nfs/dir.c.stabexec	2004-09-01 14:32:53.000000000 +0400
+++ ./fs/nfs/dir.c	2004-09-02 14:11:40.000000000 +0400
@@ -1541,7 +1541,8 @@ out:
 	return -EACCES;
 }
 
-int nfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+int nfs_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
 {
 	struct rpc_cred *cred;
 	int mode = inode->i_mode;
@@ -1582,6 +1583,7 @@ int nfs_permission(struct inode *inode, 
 	if (!NFS_PROTO(inode)->access)
 		goto out_notsup;
 
+	/* Can NFS fill exec_perm atomically?  Don't know...  --SAW */
 	cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
 	res = nfs_do_access(inode, cred, mask);
 	put_rpccred(cred);
@@ -1589,7 +1591,7 @@ int nfs_permission(struct inode *inode, 
 	return res;
 out_notsup:
 	nfs_revalidate_inode(NFS_SERVER(inode), inode);
-	res = vfs_permission(inode, mask);
+	res = vfs_permission(inode, mask, exec_perm);
 	unlock_kernel();
 	return res;
 }
--- ./fs/nfsd/nfsfh.c.stabexec	2004-09-01 14:32:53.000000000 +0400
+++ ./fs/nfsd/nfsfh.c	2004-09-02 14:11:40.000000000 +0400
@@ -56,7 +56,7 @@ int nfsd_acceptable(void *expv, struct d
 		/* make sure parents give x permission to user */
 		int err;
 		parent = dget_parent(tdentry);
-		err = permission(parent->d_inode, MAY_EXEC, NULL);
+		err = permission(parent->d_inode, MAY_EXEC, NULL, NULL);
 		if (err < 0) {
 			dput(parent);
 			break;
--- ./fs/nfsd/vfs.c.stabexec	2004-09-01 14:32:53.000000000 +0400
+++ ./fs/nfsd/vfs.c	2004-09-02 14:11:40.000000000 +0400
@@ -1765,12 +1765,13 @@ nfsd_permission(struct svc_export *exp, 
 	    inode->i_uid == current->fsuid)
 		return 0;
 
-	err = permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC), NULL);
+	err = permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC),
+			NULL, NULL);
 
 	/* Allow read access to binaries even when mode 111 */
 	if (err == -EACCES && S_ISREG(inode->i_mode) &&
 	    acc == (MAY_READ | MAY_OWNER_OVERRIDE))
-		err = permission(inode, MAY_EXEC, NULL);
+		err = permission(inode, MAY_EXEC, NULL, NULL);
 
 	return err? nfserrno(err) : 0;
 }
--- ./fs/proc/base.c.stabexec	2004-09-01 14:34:47.000000000 +0400
+++ ./fs/proc/base.c	2004-09-02 14:11:40.000000000 +0400
@@ -469,9 +469,10 @@ out:
 	goto exit;
 }
 
-static int proc_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int proc_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
 {
-	if (vfs_permission(inode, mask) != 0)
+	if (vfs_permission(inode, mask, exec_perm) != 0)
 		return -EACCES;
 	return proc_check_root(inode);
 }
--- ./fs/reiserfs/xattr.c.stabexec	2004-09-01 14:32:54.000000000 +0400
+++ ./fs/reiserfs/xattr.c	2004-09-02 14:11:40.000000000 +0400
@@ -1436,9 +1436,26 @@ check_capabilities:
 }
 
 int
-reiserfs_permission (struct inode *inode, int mask, struct nameidata *nd)
+reiserfs_permission (struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
 {
-    return __reiserfs_permission (inode, mask, nd, 1);
+	int ret;
+
+	if (exec_perm != NULL)
+		down(&inode->i_sem);
+
+	ret = __reiserfs_permission (inode, mask, nd, 1);
+
+	if (exec_perm != NULL) {
+		if (!ret) {
+			exec_perm->set = 1;
+			exec_perm->mode = inode->i_mode;
+			exec_perm->uid = inode->i_uid;
+			exec_perm->gid = inode->i_gid;
+		}
+		up(&inode->i_sem);
+	}
+	return ret;
 }
 
 int
--- ./fs/smbfs/file.c.stabexec	2004-09-01 14:32:54.000000000 +0400
+++ ./fs/smbfs/file.c	2004-09-02 14:11:40.000000000 +0400
@@ -387,7 +387,8 @@ smb_file_release(struct inode *inode, st
  * privileges, so we need our own check for this.
  */
 static int
-smb_file_permission(struct inode *inode, int mask, struct nameidata *nd)
+smb_file_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
 {
 	int mode = inode->i_mode;
 	int error = 0;
--- ./fs/udf/file.c.stabexec	2004-09-01 14:32:55.000000000 +0400
+++ ./fs/udf/file.c	2004-09-02 14:11:40.000000000 +0400
@@ -188,7 +188,7 @@ int udf_ioctl(struct inode *inode, struc
 {
 	int result = -EINVAL;
 
-	if ( permission(inode, MAY_READ, NULL) != 0 )
+	if ( permission(inode, MAY_READ, NULL, NULL) != 0 )
 	{
 		udf_debug("no permission to access inode %lu\n",
 						inode->i_ino);
--- ./fs/xfs/linux-2.6/xfs_iops.c.stabexec	2004-09-01 14:32:56.000000000 +0400
+++ ./fs/xfs/linux-2.6/xfs_iops.c	2004-09-02 14:11:40.000000000 +0400
@@ -468,7 +468,8 @@ STATIC int
 linvfs_permission(
 	struct inode	*inode,
 	int		mode,
-	struct nameidata *nd)
+	struct nameidata *nd,
+	struct exec_perm *exec_perm)
 {
 	vnode_t		*vp = LINVFS_GET_VP(inode);
 	int		error;
--- ./fs/exec.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/exec.c	2004-09-02 14:45:58.641728032 +0400
@@ -130,7 +130,7 @@ asmlinkage long sys_uselib(const char __
 	if (!S_ISREG(nd.dentry->d_inode->i_mode))
 		goto exit;
 
-	error = permission(nd.dentry->d_inode, MAY_READ | MAY_EXEC, &nd);
+	error = permission(nd.dentry->d_inode, MAY_READ | MAY_EXEC, &nd, NULL);
 	if (error)
 		goto exit;
 
@@ -468,7 +468,7 @@ static inline void free_arg_pages(struct
 
 #endif /* CONFIG_MMU */
 
-struct file *open_exec(const char *name)
+struct file *open_exec(const char *name, struct linux_binprm *bprm)
 {
 	struct nameidata nd;
 	int err;
@@ -483,9 +483,13 @@ struct file *open_exec(const char *name)
 		file = ERR_PTR(-EACCES);
 		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
 		    S_ISREG(inode->i_mode)) {
-			int err = permission(inode, MAY_EXEC, &nd);
-			if (!err && !(inode->i_mode & 0111))
-				err = -EACCES;
+			int err;
+			if (bprm != NULL) {
+				bprm->perm.set = 0;
+				err = permission(inode, MAY_EXEC, &nd,
+						&bprm->perm);
+			} else
+				err = permission(inode, MAY_EXEC, &nd, NULL);
 			file = ERR_PTR(err);
 			if (!err) {
 				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
@@ -857,7 +861,7 @@ int flush_old_exec(struct linux_binprm *
 	flush_thread();
 
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
-	    permission(bprm->file->f_dentry->d_inode,MAY_READ, NULL) ||
+	    permission(bprm->file->f_dentry->d_inode, MAY_READ, NULL, NULL) ||
 	    (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP))
 		current->mm->dumpable = 0;
 
@@ -890,13 +894,6 @@ int prepare_binprm(struct linux_binprm *
 	struct inode * inode = bprm->file->f_dentry->d_inode;
 	int retval;
 
-	mode = inode->i_mode;
-	/*
-	 * Check execute perms again - if the caller has CAP_DAC_OVERRIDE,
-	 * vfs_permission lets a non-executable through
-	 */
-	if (!(mode & 0111))	/* with at least _one_ execute bit set */
-		return -EACCES;
 	if (bprm->file->f_op == NULL)
 		return -EACCES;
 
@@ -904,10 +901,24 @@ int prepare_binprm(struct linux_binprm *
 	bprm->e_gid = current->egid;
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
+		if (!bprm->perm.set) {
+			/*
+			 * This piece of code creates a time window between
+			 * MAY_EXEC permission check and setuid/setgid
+			 * operations and may be considered as a security hole.
+			 * This code is here for compatibility reasons,
+			 * if the filesystem is unable to return info now.
+			 */
+			bprm->perm.mode = inode->i_mode;
+			bprm->perm.uid = inode->i_uid;
+			bprm->perm.gid = inode->i_gid;
+		}
+		mode = bprm->perm.mode;
+
 		/* Set-uid? */
 		if (mode & S_ISUID) {
 			current->personality &= ~PER_CLEAR_ON_SETID;
-			bprm->e_uid = inode->i_uid;
+			bprm->e_uid = bprm->perm.uid;
 		}
 
 		/* Set-gid? */
@@ -918,7 +929,7 @@ int prepare_binprm(struct linux_binprm *
 		 */
 		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			current->personality &= ~PER_CLEAR_ON_SETID;
-			bprm->e_gid = inode->i_gid;
+			bprm->e_gid = bprm->perm.gid;
 		}
 	}
 
@@ -1011,7 +1022,7 @@ int search_binary_handler(struct linux_b
 
 	        loader = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 
-		file = open_exec("/sbin/loader");
+		file = open_exec("/sbin/loader", bprm);
 		retval = PTR_ERR(file);
 		if (IS_ERR(file))
 			return retval;
@@ -1097,7 +1108,7 @@ int do_execve(char * filename,
 	int retval;
 	int i;
 
-	file = open_exec(filename);
+	file = open_exec(filename, &bprm);
 
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
--- ./fs/namei.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/namei.c	2004-09-02 14:29:29.999024568 +0400
@@ -159,7 +159,7 @@ char * getname(const char __user * filen
  * for filesystem access without changing the "normal" uids which
  * are used for other things..
  */
-int vfs_permission(struct inode * inode, int mask)
+int __vfs_permission(struct inode * inode, int mask)
 {
 	umode_t			mode = inode->i_mode;
 
@@ -208,7 +208,29 @@ int vfs_permission(struct inode * inode,
 	return -EACCES;
 }
 
-int permission(struct inode * inode,int mask, struct nameidata *nd)
+int vfs_permission(struct inode * inode, int mask, struct exec_perm * exec_perm)
+{
+	int ret;
+
+	if (exec_perm != NULL)
+		down(&inode->i_sem);
+
+	ret = __vfs_permission(inode, mask);
+
+	if (exec_perm != NULL) {
+		if (!ret) {
+			exec_perm->set = 1;
+			exec_perm->mode = inode->i_mode;
+			exec_perm->uid = inode->i_uid;
+			exec_perm->gid = inode->i_gid;
+		}
+		up(&inode->i_sem);
+	}
+	return ret;
+}
+
+int permission(struct inode * inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm)
 {
 	int retval;
 	int submask;
@@ -217,9 +239,9 @@ int permission(struct inode * inode,int 
 	submask = mask & ~MAY_APPEND;
 
 	if (inode->i_op && inode->i_op->permission)
-		retval = inode->i_op->permission(inode, submask, nd);
+		retval = inode->i_op->permission(inode, submask, nd, exec_perm);
 	else
-		retval = vfs_permission(inode, submask);
+		retval = vfs_permission(inode, submask, exec_perm);
 	if (retval)
 		return retval;
 
@@ -678,7 +700,7 @@ int fastcall link_path_walk(const char *
 
 		err = exec_permission_lite(inode, nd);
 		if (err == -EAGAIN) { 
-			err = permission(inode, MAY_EXEC, nd);
+			err = permission(inode, MAY_EXEC, nd, NULL);
 		}
  		if (err)
 			break;
@@ -972,7 +994,7 @@ static struct dentry * __lookup_hash(str
 	int err;
 
 	inode = base->d_inode;
-	err = permission(inode, MAY_EXEC, nd);
+	err = permission(inode, MAY_EXEC, nd, NULL);
 	dentry = ERR_PTR(err);
 	if (err)
 		goto out;
@@ -1101,7 +1123,7 @@ static inline int may_delete(struct inod
 
 	BUG_ON(victim->d_parent->d_inode != dir);
 
-	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
+	error = permission(dir, MAY_WRITE | MAY_EXEC, NULL, NULL);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -1138,7 +1160,7 @@ static inline int may_create(struct inod
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
+	return permission(dir, MAY_WRITE | MAY_EXEC, nd, NULL);
 }
 
 /* 
@@ -1246,7 +1268,7 @@ int may_open(struct nameidata *nd, int a
 	if (S_ISDIR(inode->i_mode) && (flag & FMODE_WRITE))
 		return -EISDIR;
 
-	error = permission(inode, acc_mode, nd);
+	error = permission(inode, acc_mode, nd, NULL);
 	if (error)
 		return error;
 
@@ -2025,7 +2047,7 @@ int vfs_rename_dir(struct inode *old_dir
 	 * we'll need to flip '..'.
 	 */
 	if (new_dir != old_dir) {
-		error = permission(old_dentry->d_inode, MAY_WRITE, NULL);
+		error = permission(old_dentry->d_inode, MAY_WRITE, NULL, NULL);
 		if (error)
 			return error;
 	}
--- ./fs/namespace.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/namespace.c	2004-09-02 14:11:40.695583400 +0400
@@ -515,7 +515,7 @@ static int mount_is_safe(struct nameidat
 		if (current->uid != nd->dentry->d_inode->i_uid)
 			return -EPERM;
 	}
-	if (permission(nd->dentry->d_inode, MAY_WRITE, nd))
+	if (permission(nd->dentry->d_inode, MAY_WRITE, nd, NULL))
 		return -EPERM;
 	return 0;
 #endif
--- ./fs/open.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/open.c	2004-09-02 14:11:40.802567136 +0400
@@ -234,7 +234,7 @@ static inline long do_sys_truncate(const
 	if (!S_ISREG(inode->i_mode))
 		goto dput_and_out;
 
-	error = permission(inode,MAY_WRITE,&nd);
+	error = permission(inode,MAY_WRITE,&nd,NULL);
 	if (error)
 		goto dput_and_out;
 
@@ -388,7 +388,7 @@ asmlinkage long sys_utime(char __user * 
                         goto dput_and_out;
 
 		if (current->fsuid != inode->i_uid &&
-		    (error = permission(inode,MAY_WRITE,&nd)) != 0)
+		    (error = permission(inode,MAY_WRITE,&nd,NULL)) != 0)
 			goto dput_and_out;
 	}
 	down(&inode->i_sem);
@@ -441,7 +441,7 @@ long do_utimes(char __user * filename, s
                         goto dput_and_out;
 
 		if (current->fsuid != inode->i_uid &&
-		    (error = permission(inode,MAY_WRITE,&nd)) != 0)
+		    (error = permission(inode,MAY_WRITE,&nd,NULL)) != 0)
 			goto dput_and_out;
 	}
 	down(&inode->i_sem);
@@ -500,7 +500,7 @@ asmlinkage long sys_access(const char __
 
 	res = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
 	if (!res) {
-		res = permission(nd.dentry->d_inode, mode, &nd);
+		res = permission(nd.dentry->d_inode, mode, &nd, NULL);
 		/* SuS v2 requires we report a read only fs too */
 		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
 		   && !special_file(nd.dentry->d_inode->i_mode))
@@ -524,7 +524,7 @@ asmlinkage long sys_chdir(const char __u
 	if (error)
 		goto out;
 
-	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd);
+	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd,NULL);
 	if (error)
 		goto dput_and_out;
 
@@ -557,7 +557,7 @@ asmlinkage long sys_fchdir(unsigned int 
 	if (!S_ISDIR(inode->i_mode))
 		goto out_putf;
 
-	error = permission(inode, MAY_EXEC, NULL);
+	error = permission(inode, MAY_EXEC, NULL, NULL);
 	if (!error)
 		set_fs_pwd(current->fs, mnt, dentry);
 out_putf:
@@ -575,7 +575,7 @@ asmlinkage long sys_chroot(const char __
 	if (error)
 		goto out;
 
-	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd);
+	error = permission(nd.dentry->d_inode,MAY_EXEC,&nd,NULL);
 	if (error)
 		goto dput_and_out;
 
--- ./fs/binfmt_misc.c.stabexec	2004-09-02 14:33:50.000000000 +0400
+++ ./fs/binfmt_misc.c	2004-09-02 14:33:58.000000000 +0400
@@ -150,7 +150,8 @@ static int load_misc_binary(struct linux
 
 		/* if the binary is not readable than enforce mm->dumpable=0
 		   regardless of the interpreter's permissions */
-		if (permission(bprm->file->f_dentry->d_inode, MAY_READ, NULL))
+		if (permission(bprm->file->f_dentry->d_inode, MAY_READ,
+					NULL, NULL))
 			bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
 		allow_write_access(bprm->file);
@@ -179,7 +180,7 @@ static int load_misc_binary(struct linux
 
 	bprm->interp = iname;	/* for binfmt_script */
 
-	interp_file = open_exec (iname);
+	interp_file = open_exec (iname, bprm);
 	retval = PTR_ERR (interp_file);
 	if (IS_ERR (interp_file))
 		goto _error;
--- ./fs/binfmt_elf.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/binfmt_elf.c	2004-09-02 14:45:52.854607808 +0400
@@ -603,7 +603,7 @@ static int load_elf_binary(struct linux_
 			 */
 			SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 
-			interpreter = open_exec(elf_interpreter);
+			interpreter = open_exec(elf_interpreter, NULL);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
--- ./fs/binfmt_em86.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/binfmt_em86.c	2004-09-02 14:46:14.885258640 +0400
@@ -82,7 +82,7 @@ static int load_em86(struct linux_binprm
 	 * Note that we use open_exec() as the name is now in kernel
 	 * space, and we don't need to copy it.
 	 */
-	file = open_exec(interp);
+	file = open_exec(interp, bprm);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
--- ./fs/binfmt_flat.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/binfmt_flat.c	2004-09-02 14:47:50.055790520 +0400
@@ -774,7 +774,7 @@ static int load_flat_shared_library(int 
 
 	/* Open the file up */
 	bprm.filename = buf;
-	bprm.file = open_exec(bprm.filename);
+	bprm.file = open_exec(bprm.filename, &bprm);
 	res = PTR_ERR(bprm.file);
 	if (IS_ERR(bprm.file))
 		return res;
--- ./fs/binfmt_script.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/binfmt_script.c	2004-09-02 14:47:50.056790368 +0400
@@ -85,7 +85,7 @@ static int load_script(struct linux_binp
 	/*
 	 * OK, now restart the process with the interpreter's dentry.
 	 */
-	file = open_exec(interp);
+	file = open_exec(interp, bprm);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
--- ./fs/compat.c.stabexec	2004-09-01 14:32:50.000000000 +0400
+++ ./fs/compat.c	2004-09-02 14:48:36.883671600 +0400
@@ -1369,7 +1369,7 @@ int compat_do_execve(char * filename,
 	int retval;
 	int i;
 
-	file = open_exec(filename);
+	file = open_exec(filename, &bprm);
 
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
--- ./include/linux/fs.h.stabexec	2004-09-01 14:33:15.000000000 +0400
+++ ./include/linux/fs.h	2004-09-02 14:25:28.087800664 +0400
@@ -538,6 +538,12 @@ static inline unsigned imajor(struct ino
 
 extern struct block_device *I_BDEV(struct inode *inode);
 
+struct exec_perm {
+	umode_t mode;
+	uid_t uid, gid;
+	int set;
+};
+
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
@@ -929,7 +935,8 @@ struct inode_operations {
 	int (*follow_link) (struct dentry *, struct nameidata *);
 	void (*put_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int, struct nameidata *);
+	int (*permission) (struct inode *, int, struct nameidata *,
+			struct exec_perm *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
 	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
@@ -1335,8 +1342,9 @@ extern int do_remount_sb(struct super_bl
 extern sector_t bmap(struct inode *, sector_t);
 extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);
-extern int permission(struct inode *, int, struct nameidata *);
-extern int vfs_permission(struct inode *, int);
+extern int permission(struct inode *, int, struct nameidata *,
+		struct exec_perm *);
+extern int vfs_permission(struct inode *, int, struct exec_perm *);
 extern int get_write_access(struct inode *);
 extern int deny_write_access(struct file *);
 static inline void put_write_access(struct inode * inode)
@@ -1353,8 +1361,9 @@ extern int do_pipe(int *);
 extern int open_namei(const char *, int, int, struct nameidata *);
 extern int may_open(struct nameidata *, int, int);
 
+struct linux_binprm;
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
-extern struct file * open_exec(const char *);
+extern struct file * open_exec(const char *, struct linux_binprm *);
  
 /* fs/dcache.c -- generic fs support functions */
 extern int is_subdir(struct dentry *, struct dentry *);
--- ./include/linux/binfmts.h.stabexec	2004-09-01 14:33:14.000000000 +0400
+++ ./include/linux/binfmts.h	2004-09-02 14:11:40.000000000 +0400
@@ -2,6 +2,7 @@
 #define _LINUX_BINFMTS_H
 
 #include <linux/capability.h>
+#include <linux/fs.h>
 
 struct pt_regs;
 
@@ -28,6 +29,7 @@ struct linux_binprm{
 	int sh_bang;
 	struct file * file;
 	int e_uid, e_gid;
+	struct exec_perm perm;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
 	void *security;
 	int argc, envc;
--- ./include/linux/coda_linux.h.stabexec	2004-09-01 14:33:14.000000000 +0400
+++ ./include/linux/coda_linux.h	2004-09-02 14:11:41.000000000 +0400
@@ -38,7 +38,8 @@ extern struct file_operations coda_ioctl
 int coda_open(struct inode *i, struct file *f);
 int coda_flush(struct file *f);
 int coda_release(struct inode *i, struct file *f);
-int coda_permission(struct inode *inode, int mask, struct nameidata *nd);
+int coda_permission(struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm);
 int coda_revalidate_inode(struct dentry *);
 int coda_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 int coda_setattr(struct dentry *, struct iattr *);
--- ./include/linux/nfs_fs.h.stabexec	2004-09-01 14:33:17.000000000 +0400
+++ ./include/linux/nfs_fs.h	2004-09-02 14:11:41.000000000 +0400
@@ -290,7 +290,8 @@ extern struct inode *nfs_fhget(struct su
 				struct nfs_fattr *);
 extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
-extern int nfs_permission(struct inode *, int, struct nameidata *);
+extern int nfs_permission(struct inode *, int, struct nameidata *,
+		struct exec_perm *);
 extern int nfs_access_get_cached(struct inode *, struct rpc_cred *, struct nfs_access_entry *);
 extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *);
 extern int nfs_open(struct inode *, struct file *);
--- ./include/linux/reiserfs_xattr.h.stabexec	2004-09-01 14:33:17.000000000 +0400
+++ ./include/linux/reiserfs_xattr.h	2004-09-02 14:11:41.000000000 +0400
@@ -42,7 +42,8 @@ int reiserfs_removexattr (struct dentry 
 int reiserfs_delete_xattrs (struct inode *inode);
 int reiserfs_chown_xattrs (struct inode *inode, struct iattr *attrs);
 int reiserfs_xattr_init (struct super_block *sb, int mount_flags);
-int reiserfs_permission (struct inode *inode, int mask, struct nameidata *nd);
+int reiserfs_permission (struct inode *inode, int mask, struct nameidata *nd,
+		struct exec_perm *exec_perm);
 int reiserfs_permission_locked (struct inode *inode, int mask, struct nameidata *nd);
 
 int reiserfs_xattr_del (struct inode *, const char *);
--- ./ipc/mqueue.c.stabexec	2004-09-01 14:33:20.000000000 +0400
+++ ./ipc/mqueue.c	2004-09-02 14:11:41.000000000 +0400
@@ -631,7 +631,8 @@ static int oflag2acc[O_ACCMODE] = { MAY_
 	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY))
 		return ERR_PTR(-EINVAL);
 
-	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL))
+	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE],
+				NULL, NULL))
 		return ERR_PTR(-EACCES);
 
 	filp = dentry_open(dentry, mqueue_mnt, oflag);
--- ./net/unix/af_unix.c.stabexec	2004-09-01 14:33:28.000000000 +0400
+++ ./net/unix/af_unix.c	2004-09-02 14:11:41.000000000 +0400
@@ -677,7 +677,7 @@ static struct sock *unix_find_other(stru
 		err = path_lookup(sunname->sun_path, LOOKUP_FOLLOW, &nd);
 		if (err)
 			goto fail;
-		err = permission(nd.dentry->d_inode,MAY_WRITE, &nd);
+		err = permission(nd.dentry->d_inode, MAY_WRITE, &nd, NULL);
 		if (err)
 			goto put_fail;
 
