Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVIMUIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVIMUIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVIMUIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:08:13 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:24784 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932487AbVIMUIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:08:11 -0400
Date: Tue, 13 Sep 2005 16:08:08 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] SELinux - canonicalize getxattr()
Message-ID: <Pine.LNX.4.63.0509131559140.4738@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows SELinux to canonicalize the value returned from 
getxattr() via  the security_inode_getsecurity() hook, which is called 
after the fs level getxattr() function.

The purpose of this is to allow the in-core security context for an inode 
to override the on-disk value.  This could happen in cases such as 
upgrading a system to a different labeling form (e.g. standard SELinux to 
MLS) without needing to do a full relabel of the filesystem.

In such cases, we want getxattr() to return the canonical security context 
that the kernel is using rather than what is stored on disk.

The implementation hooks into the inode_getsecurity(), adding another 
parameter to indicate the result of the preceding fs-level getxattr() 
call, so that SELinux knows whether to compare a value obtained from disk 
with the kernel value.

We also now allow getxattr() to work for mountpoint labeled filesystems 
(i.e. mount with option context=foo_t), as we are able to return the 
kernel value to the user.

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 fs/xattr.c               |   14 +++++++++-----
 include/linux/security.h |   11 +++++++----
 security/dummy.c         |    2 +-
 security/selinux/hooks.c |   46 ++++++++++++++++++++++++++++++++--------------
 4 files changed, 49 insertions(+), 24 deletions(-)


diff -purN -X dontdiff linux-2.6.13-mm2.o/fs/xattr.c linux-2.6.13-mm2.w/fs/xattr.c
--- linux-2.6.13-mm2.o/fs/xattr.c	2005-09-12 11:28:55.000000000 -0400
+++ linux-2.6.13-mm2.w/fs/xattr.c	2005-09-12 22:31:32.000000000 -0400
@@ -143,7 +143,7 @@ getxattr(struct dentry *d, char __user *
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			size = XATTR_SIZE_MAX;
-		kvalue = kmalloc(size, GFP_KERNEL);
+		kvalue = kzalloc(size, GFP_KERNEL);
 		if (!kvalue)
 			return -ENOMEM;
 	}
@@ -154,11 +154,15 @@ getxattr(struct dentry *d, char __user *
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->getxattr)
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
-	else if (!strncmp(kname, XATTR_SECURITY_PREFIX,
-			  sizeof XATTR_SECURITY_PREFIX - 1)) {
+		
+	if (!strncmp(kname, XATTR_SECURITY_PREFIX,
+		     sizeof XATTR_SECURITY_PREFIX - 1)) {
 		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
-		error = security_inode_getsecurity(d->d_inode, suffix, kvalue,
-						   size);
+		int rv = security_inode_getsecurity(d->d_inode, suffix, kvalue,
+						    size, error);
+		/* Security module active: overwrite error value */
+		if (rv != -EOPNOTSUPP)
+			error = rv;
 	}
 	if (error > 0) {
 		if (size && copy_to_user(value, kvalue, error))
diff -purN -X dontdiff linux-2.6.13-mm2.o/include/linux/security.h linux-2.6.13-mm2.w/include/linux/security.h
--- linux-2.6.13-mm2.o/include/linux/security.h	2005-09-12 11:28:56.000000000 -0400
+++ linux-2.6.13-mm2.w/include/linux/security.h	2005-09-12 21:00:25.000000000 -0400
@@ -385,6 +385,9 @@ struct swap_info_struct;
  *	NULL to request the size of the buffer required.  @size indicates
  *	the size of @buffer in bytes.  Note that @name is the remainder
  *	of the attribute name after the security. prefix has been removed.
+ *	@err is the return value from the preceding fs getxattr call,
+ *	and can be used by the security module to determine whether it
+ *	should try and canonicalize the attribute value.
  *	Return number of bytes used/required on success.
  * @inode_setsecurity:
  *	Set the security label associated with @name for @inode from the
@@ -1091,7 +1094,7 @@ struct security_operations {
 	int (*inode_getxattr) (struct dentry *dentry, char *name);
 	int (*inode_listxattr) (struct dentry *dentry);
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
-  	int (*inode_getsecurity)(struct inode *inode, const char *name, void *buffer, size_t size);
+  	int (*inode_getsecurity)(struct inode *inode, const char *name, void *buffer, size_t size, int err);
   	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
 
@@ -1580,11 +1583,11 @@ static inline int security_inode_removex
 	return security_ops->inode_removexattr (dentry, name);
 }
 
-static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
+static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size, int err)
 {
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_getsecurity(inode, name, buffer, size);
+	return security_ops->inode_getsecurity(inode, name, buffer, size, err);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
@@ -2222,7 +2225,7 @@ static inline int security_inode_removex
 	return cap_inode_removexattr(dentry, name);
 }
 
-static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
+static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size, int err)
 {
 	return -EOPNOTSUPP;
 }
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/dummy.c linux-2.6.13-mm2.w/security/dummy.c
--- linux-2.6.13-mm2.o/security/dummy.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/dummy.c	2005-09-12 12:28:47.000000000 -0400
@@ -377,7 +377,7 @@ static int dummy_inode_removexattr (stru
 	return 0;
 }
 
-static int dummy_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
+static int dummy_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size, int err)
 {
 	return -EOPNOTSUPP;
 }
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/hooks.c linux-2.6.13-mm2.w/security/selinux/hooks.c
--- linux-2.6.13-mm2.o/security/selinux/hooks.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/hooks.c	2005-09-13 14:45:18.000000000 -0400
@@ -2198,9 +2198,6 @@ static int selinux_inode_getxattr (struc
 	struct inode *inode = dentry->d_inode;
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
-	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
-		return -EOPNOTSUPP;
-
 	return dentry_has_perm(current, NULL, dentry, FILE__GETATTR);
 }
 
@@ -2231,33 +2228,54 @@ static int selinux_inode_removexattr (st
 	return -EACCES;
 }
 
-static int selinux_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
+/*
+ * Copy the in-core inode security context value to the user.  If the
+ * getxattr() prior to this succeeded, check to see if we need to
+ * canonicalize the value to be finally returned to the user.
+ *
+ * Permission check is handled by selinux_inode_getxattr hook.
+ */
+static int selinux_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size, int err)
 {
 	struct inode_security_struct *isec = inode->i_security;
 	char *context;
 	unsigned len;
 	int rc;
 
-	/* Permission check handled by selinux_inode_getxattr hook.*/
-
-	if (strcmp(name, XATTR_SELINUX_SUFFIX))
-		return -EOPNOTSUPP;
+	if (strcmp(name, XATTR_SELINUX_SUFFIX)) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
 
 	rc = security_sid_to_context(isec->sid, &context, &len);
 	if (rc)
-		return rc;
+		goto out;
 
+	/* Probe for required buffer size */
 	if (!buffer || !size) {
-		kfree(context);
-		return len;
+		rc = len;
+		goto out_free;
 	}
+
 	if (size < len) {
-		kfree(context);
-		return -ERANGE;
+		rc = -ERANGE;
+		goto out_free;
+	}
+	
+	if (err > 0) {
+		if ((len == err) && !(memcmp(context, buffer, len))) {
+			/* Don't need to canonicalize value */
+			rc = err;
+			goto out_free;
+		}
+		memset(buffer, 0, size);
 	}
 	memcpy(buffer, context, len);
+	rc = len;
+out_free:	
 	kfree(context);
-	return len;
+out:
+	return rc;
 }
 
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
