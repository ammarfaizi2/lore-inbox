Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbULGUCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbULGUCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbULGUBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:01:23 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:29006 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261905AbULGT4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:56:11 -0500
Message-ID: <41B60B0F.1080201@suse.com>
Date: Tue, 07 Dec 2004 14:57:03 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Mason <mason@suse.com>
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org>	 <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>	 <20041130112903.C2357@build.pdx.osdl.net>	 <20041130194328.GA28126@infradead.org>	 <20041201233203.GA22773@locomotive.unixthugs.org> <1101993302.26015.5.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101993302.26015.5.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020800040606050109070001"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020800040606050109070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
| On Wed, 2004-12-01 at 18:32, Jeffrey Mahoney wrote:
|
|>I took some more time to find a more optimal solution. Since ReiserFS is
|>currently the only filesystem that cares about this, it's far easier
to keep
|>the whole mess internal to ReiserFS. The issue isn't about the treating of
|>"private" files in reiserfs, but rather just to avoid the looping of xattr
|>calls that selinux would create.
|
|
| No.  It is also about avoiding applying permission checks to these
| "private" inodes when reiserfs performs operations on them, e.g. when
| __get_xa_root() does a lookup_one_len(), there is ultimately a call to
| permission(inode, MAY_EXEC, nd), which triggers a security hook call,
| and SELinux will view this as an attempt by the current process to
| access the private directory.  Simply disabling getxattr/setxattr for
| the private inodes won't change this, and you can't assume that most
| processes have permission to access the default file context (in fact,
| in a strict policy, that won't be the case).
|
| Chris' suggestion of exporting this private flag via i_flags and having
| the VFS and/or security framework skip the security hook calls for such
| inodes is more reasonable, and should yield the same behavior as that
| current patchset (just without the extra security hook and the
| filesystem and SELinux-specific private flags).


Ok, well I have a test version of this up and running. It's ugly, but I
don't think any solution to this problem will be pretty. It just hooks
into include/linux/security.h so that all the individual callers don't
need to be special cased.

However, selinux itself accesses inode lists internally that circumvent
this. I believe I caught the major case that causes this, but I'd prefer
someone with more intimate knowledge of selinux verify.

Attached are four patches:
01-vfs-private-flag.diff
~  - adds the S_PRIVATE flag and adds use to security
02-vfs-private-selinux.diff
~  -internal inode loop needs IS_PRIVATE test
03-reiserfs-priv-abstract.diff
~  - private inode abstracted to static inline
04-vfs-private-reiserfs.diff
~  - change reiserfs to use S_PRIVATE

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtgsPLPWxlyuTD7IRAm3PAJ9K5lOebus6pY/nkpVQabv9AlXOKwCbBXZw
P94N38RrkdOGuWs19Erbj7I=
=VpuN
-----END PGP SIGNATURE-----

--------------020800040606050109070001
Content-Type: text/x-patch;
 name="02-vfs-private-selinux.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-vfs-private-selinux.diff"

From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 2/4] selinux: internal inode loop needs IS_PRIVATE test

This patch applies the IS_PRIVATE test to the selinux internal inode loop.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9.base/security/selinux/hooks.c linux-2.6.9.private/security/selinux/hooks.c
--- linux-2.6.9.base/security/selinux/hooks.c	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.private/security/selinux/hooks.c	2004-12-01 14:38:50.000000000 -0500
@@ -595,7 +595,8 @@ next_inode:
 		spin_unlock(&sbsec->isec_lock);
 		inode = igrab(inode);
 		if (inode) {
-			inode_doinit(inode);
+			if (!IS_PRIVATE (inode))
+				inode_doinit(inode);
 			iput(inode);
 		}
 		spin_lock(&sbsec->isec_lock);

--------------020800040606050109070001
Content-Type: text/x-patch;
 name="01-vfs-private-flag.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-vfs-private-flag.diff"

From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to security

This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
filesystem-internal. As such, it should be excepted from the security
infrastructure to allow the filesystem to perform its own access control.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9.base/include/linux/fs.h linux-2.6.9.private/include/linux/fs.h
--- linux-2.6.9.base/include/linux/fs.h	2004-11-19 14:40:56.000000000 -0500
+++ linux-2.6.9.private/include/linux/fs.h	2004-11-30 15:04:24.000000000 -0500
@@ -146,6 +146,7 @@ extern int leases_enable, dir_notify_ena
 #define S_DIRSYNC	64	/* Directory modifications are synchronous */
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
+#define S_PRIVATE	512	/* Inode is fs-internal */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -180,6 +181,7 @@ extern int leases_enable, dir_notify_ena
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
+#define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
diff -ruNpX dontdiff linux-2.6.9.base/include/linux/security.h linux-2.6.9.private/include/linux/security.h
--- linux-2.6.9.base/include/linux/security.h	2004-08-14 01:37:30.000000000 -0400
+++ linux-2.6.9.private/include/linux/security.h	2004-12-01 14:14:07.000000000 -0500
@@ -1406,11 +1406,15 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_alloc_security (inode);
 }
 
 static inline void security_inode_free (struct inode *inode)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return;
 	security_ops->inode_free_security (inode);
 }
 	
@@ -1418,6 +1422,8 @@ static inline int security_inode_create 
 					 struct dentry *dentry,
 					 int mode)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_create (dir, dentry, mode);
 }
 
@@ -1425,6 +1431,8 @@ static inline void security_inode_post_c
 					       struct dentry *dentry,
 					       int mode)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_create (dir, dentry, mode);
 }
 
@@ -1432,6 +1440,8 @@ static inline int security_inode_link (s
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
+	if (unlikely (IS_PRIVATE (old_dentry->d_inode)))
+		return 0;
 	return security_ops->inode_link (old_dentry, dir, new_dentry);
 }
 
@@ -1439,12 +1449,16 @@ static inline void security_inode_post_l
 					     struct inode *dir,
 					     struct dentry *new_dentry)
 {
+	if (unlikely (IS_PRIVATE (new_dentry->d_inode)))
+		return;
 	security_ops->inode_post_link (old_dentry, dir, new_dentry);
 }
 
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_unlink (dir, dentry);
 }
 
@@ -1452,6 +1466,8 @@ static inline int security_inode_symlink
 					  struct dentry *dentry,
 					  const char *old_name)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_symlink (dir, dentry, old_name);
 }
 
@@ -1459,6 +1475,8 @@ static inline void security_inode_post_s
 						struct dentry *dentry,
 						const char *old_name)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_symlink (dir, dentry, old_name);
 }
 
@@ -1466,6 +1484,8 @@ static inline int security_inode_mkdir (
 					struct dentry *dentry,
 					int mode)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_mkdir (dir, dentry, mode);
 }
 
@@ -1473,12 +1493,16 @@ static inline void security_inode_post_m
 					      struct dentry *dentry,
 					      int mode)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_mkdir (dir, dentry, mode);
 }
 
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_rmdir (dir, dentry);
 }
 
@@ -1486,6 +1510,8 @@ static inline int security_inode_mknod (
 					struct dentry *dentry,
 					int mode, dev_t dev)
 {
+	if (unlikely (IS_PRIVATE (dir)))
+		return 0;
 	return security_ops->inode_mknod (dir, dentry, mode, dev);
 }
 
@@ -1493,6 +1519,8 @@ static inline void security_inode_post_m
 					      struct dentry *dentry,
 					      int mode, dev_t dev)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_mknod (dir, dentry, mode, dev);
 }
 
@@ -1501,6 +1529,9 @@ static inline int security_inode_rename 
 					 struct inode *new_dir,
 					 struct dentry *new_dentry)
 {
+        if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
+            (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
+		return 0;
 	return security_ops->inode_rename (old_dir, old_dentry,
 					   new_dir, new_dentry);
 }
@@ -1510,83 +1541,114 @@ static inline void security_inode_post_r
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
 {
+        if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
+            (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
+		return;
 	security_ops->inode_post_rename (old_dir, old_dentry,
 						new_dir, new_dentry);
 }
 
 static inline int security_inode_readlink (struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_readlink (dentry);
 }
 
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_follow_link (dentry, nd);
 }
 
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return 0;
 	return security_ops->inode_permission (inode, mask, nd);
 }
 
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_setattr (dentry, attr);
 }
 
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_getattr (mnt, dentry);
 }
 
 static inline void security_inode_delete (struct inode *inode)
 {
+	if (unlikely (IS_PRIVATE (inode)))
+		return;
 	security_ops->inode_delete (inode);
 }
 
 static inline int security_inode_setxattr (struct dentry *dentry, char *name,
 					   void *value, size_t size, int flags)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_setxattr (dentry, name, value, size, flags);
 }
 
 static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
 						void *value, size_t size, int flags)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
 	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
 }
 
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_getxattr (dentry, name);
 }
 
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_listxattr (dentry);
 }
 
 static inline int security_inode_removexattr (struct dentry *dentry, char *name)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_removexattr (dentry, name);
 }
 
 static inline int security_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_getsecurity(dentry, name, buffer, size);
 }
 
 static inline int security_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_setsecurity(dentry, name, value, size, flags);
 }
 
 static inline int security_inode_listsecurity(struct dentry *dentry, char *buffer)
 {
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
 	return security_ops->inode_listsecurity(dentry, buffer);
 }
 
@@ -1863,6 +1925,8 @@ static inline int security_sem_semop (st
 
 static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
 {
+	if (unlikely (inode && IS_PRIVATE (inode)))
+		return;
 	security_ops->d_instantiate (dentry, inode);
 }
 

--------------020800040606050109070001
Content-Type: text/x-patch;
 name="03-reiserfs-priv-abstract.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-reiserfs-priv-abstract.diff"

From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 3/4] reiserfs: private inode abstracted to static inline

This patch moves the assignment of i_priv_object to a static inline. This
is in preparation for selinux support in reiserfs.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/inode.c linux-2.6.9.base/fs/reiserfs/inode.c
--- linux-2.6.9/fs/reiserfs/inode.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.base/fs/reiserfs/inode.c	2004-11-30 16:03:42.000000000 -0500
@@ -1804,6 +1804,8 @@ int reiserfs_new_inode (struct reiserfs_
     } else if (inode->i_sb->s_flags & MS_POSIXACL) {
 	reiserfs_warning (inode->i_sb, "ACLs aren't enabled in the fs, "
 			  "but vfs thinks they are!");
+    } else if (is_reiserfs_priv_object (dir)) {
+	reiserfs_mark_inode_private (inode);
     }
 
     insert_inode_hash (inode);
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/namei.c linux-2.6.9.base/fs/reiserfs/namei.c
--- linux-2.6.9/fs/reiserfs/namei.c	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.9.base/fs/reiserfs/namei.c	2004-11-30 16:03:42.000000000 -0500
@@ -352,7 +352,7 @@ static struct dentry * reiserfs_lookup (
 
 	/* Propogate the priv_object flag so we know we're in the priv tree */
 	if (is_reiserfs_priv_object (dir))
-	    REISERFS_I(inode)->i_flags |= i_priv_object;
+	    reiserfs_mark_inode_private (inode);
     }
     reiserfs_write_unlock(dir->i_sb);
     if ( retval == IO_ERROR ) {
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr_acl.c linux-2.6.9.base/fs/reiserfs/xattr_acl.c
--- linux-2.6.9/fs/reiserfs/xattr_acl.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.base/fs/reiserfs/xattr_acl.c	2004-11-30 16:03:42.000000000 -0500
@@ -337,7 +337,7 @@ reiserfs_inherit_default_acl (struct ino
      * would be useless since permissions are ignored, and a pain because
      * it introduces locking cycles */
     if (is_reiserfs_priv_object (dir)) {
-        REISERFS_I(inode)->i_flags |= i_priv_object;
+        reiserfs_mark_inode_private (inode);
         goto apply_umask;
     }
 
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr.c linux-2.6.9.base/fs/reiserfs/xattr.c
--- linux-2.6.9/fs/reiserfs/xattr.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.base/fs/reiserfs/xattr.c	2004-12-07 13:54:17.336459088 -0500
@@ -181,8 +181,6 @@ open_xa_dir (const struct inode *inode, 
             dput (xadir);
             return ERR_PTR (-ENODATA);
         }
-        /* Newly created object.. Need to mark it private */
-        REISERFS_I(xadir->d_inode)->i_flags |= i_priv_object;
     }
 
     dput (xaroot);
@@ -230,8 +228,6 @@ get_xa_file_dentry (const struct inode *
             dput (xafile);
             goto out;
         }
-        /* Newly created object.. Need to mark it private */
-        REISERFS_I(xafile->d_inode)->i_flags |= i_priv_object;
     }
 
 out:
@@ -1316,7 +1312,7 @@ reiserfs_xattr_init (struct super_block 
 
       if (!err && dentry) {
           s->s_root->d_op = &xattr_lookup_poison_ops;
-          REISERFS_I(dentry->d_inode)->i_flags |= i_priv_object;
+          reiserfs_mark_inode_private (dentry->d_inode);
           REISERFS_SB(s)->priv_root = dentry;
       } else if (!(mount_flags & MS_RDONLY)) { /* xattrs are unavailable */
           /* If we're read-only it just means that the dir hasn't been
diff -ruNpX dontdiff linux-2.6.9/include/linux/reiserfs_xattr.h linux-2.6.9.base/include/linux/reiserfs_xattr.h
--- linux-2.6.9/include/linux/reiserfs_xattr.h	2004-08-14 01:38:11.000000000 -0400
+++ linux-2.6.9.base/include/linux/reiserfs_xattr.h	2004-11-30 16:03:42.000000000 -0500
@@ -103,6 +103,12 @@ reiserfs_read_unlock_xattr_i(struct inod
     up_read (&REISERFS_I(inode)->xattr_sem);
 }
 
+static inline void
+reiserfs_mark_inode_private(struct inode *inode)
+{
+    REISERFS_I(inode)->i_flags |= i_priv_object;
+}
+
 #else
 
 #define is_reiserfs_priv_object(inode) 0

--------------020800040606050109070001
Content-Type: text/x-patch;
 name="04-vfs-private-reiserfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-vfs-private-reiserfs.diff"

From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 4/4] reiserfs: change reiserfs to use S_PRIVATE

This patch changes reiserfs to use the VFS level private inode flags, and
eliminates the old reiserfs private inode flag.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9.base/include/linux/reiserfs_xattr.h linux-2.6.9.private/include/linux/reiserfs_xattr.h
--- linux-2.6.9.base/include/linux/reiserfs_xattr.h	2004-11-30 16:03:42.000000000 -0500
+++ linux-2.6.9.private/include/linux/reiserfs_xattr.h	2004-12-07 14:23:43.266996840 -0500
@@ -31,7 +31,7 @@ struct reiserfs_xattr_handler {
 
 
 #ifdef CONFIG_REISERFS_FS_XATTR
-#define is_reiserfs_priv_object(inode) (REISERFS_I(inode)->i_flags & i_priv_object)
+#define is_reiserfs_priv_object(inode) IS_PRIVATE(inode)
 #define has_xattr_dir(inode) (REISERFS_I(inode)->i_flags & i_has_xattr_dir)
 ssize_t reiserfs_getxattr (struct dentry *dentry, const char *name,
 			   void *buffer, size_t size);
@@ -106,7 +106,7 @@ reiserfs_read_unlock_xattr_i(struct inod
 static inline void
 reiserfs_mark_inode_private(struct inode *inode)
 {
-    REISERFS_I(inode)->i_flags |= i_priv_object;
+    inode->i_flags |= S_PRIVATE;
 }
 
 #else

diff -ruNpX dontdiff linux-2.6.9.base/include/linux/reiserfs_fs_i.h linux-2.6.9.private/include/linux/reiserfs_fs_i.h
--- linux-2.6.9.base/include/linux/reiserfs_fs_i.h	2004-11-19 14:40:57.000000000 -0500
+++ linux-2.6.9.private/include/linux/reiserfs_fs_i.h	2004-12-07 14:25:40.259211320 -0500
@@ -23,9 +23,8 @@ typedef enum {
       space on crash with some files open, but unlinked. */
     i_link_saved_unlink_mask   =  0x0010,
     i_link_saved_truncate_mask =  0x0020,
-    i_priv_object              =  0x0080,
-    i_has_xattr_dir            =  0x0100,
-    i_data_log	               =  0x0200,
+    i_has_xattr_dir            =  0x0040,
+    i_data_log	               =  0x0080,
 } reiserfs_inode_flags;
 
 

--------------020800040606050109070001--
