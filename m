Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTBSXjp>; Wed, 19 Feb 2003 18:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTBSXjp>; Wed, 19 Feb 2003 18:39:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:31506 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262602AbTBSXjL>;
	Wed, 19 Feb 2003 18:39:11 -0500
Date: Wed, 19 Feb 2003 15:42:16 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234216.GC18590@kroah.com>
References: <20030219234140.GA18590@kroah.com> <20030219234203.GB18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234203.GB18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.914.34.2, 2003/01/16 14:23:59-08:00, sds@epoch.ncsc.mil

[PATCH] Replace inode_post_lookup hook with d_instantiate hook

This patch removes the security_inode_post_lookup hook entirely and
adds a security_d_instantiate hook call to the d_instantiate function
and the d_splice_alias function.  The inode_post_lookup hook was
subject to races since the inode is already accessible through the
dcache before it is called, didn't handle filesystems that directly
populate the dcache, and wasn't always called in the desired context
(e.g. for pipe, shmem, and devpts inodes).  The d_instantiate hook
enables initialization of the inode security information.  This hook
is used by SELinux and by DTE to setup the inode security state, and
eliminated the need for the inode_precondition function in SELinux.


diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Wed Feb 19 15:39:14 2003
+++ b/fs/dcache.c	Wed Feb 19 15:39:14 2003
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <asm/uaccess.h>
+#include <linux/security.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -699,6 +700,7 @@
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	if (!list_empty(&entry->d_alias)) BUG();
+	security_d_instantiate(entry, inode);
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
@@ -825,6 +827,7 @@
 	struct dentry *new = NULL;
 
 	if (inode && S_ISDIR(inode->i_mode)) {
+		security_d_instantiate(dentry, inode);
 		spin_lock(&dcache_lock);
 		if (!list_empty(&inode->i_dentry)) {
 			new = list_entry(inode->i_dentry.next, struct dentry, d_alias);
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Wed Feb 19 15:39:14 2003
+++ b/fs/namei.c	Wed Feb 19 15:39:14 2003
@@ -372,10 +372,8 @@
 			result = dir->i_op->lookup(dir, dentry);
 			if (result)
 				dput(dentry);
-			else {
+			else
 				result = dentry;
-				security_inode_post_lookup(dir, result);
-			}
 		}
 		up(&dir->i_sem);
 		return result;
@@ -916,10 +914,9 @@
 		if (!new)
 			goto out;
 		dentry = inode->i_op->lookup(inode, new);
-		if (!dentry) {
+		if (!dentry)
 			dentry = new;
-			security_inode_post_lookup(inode, dentry);
-		} else
+		else
 			dput(new);
 	}
 out:
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Wed Feb 19 15:39:14 2003
+++ b/include/linux/security.h	Wed Feb 19 15:39:14 2003
@@ -339,10 +339,6 @@
  *	@mnt is the vfsmount where the dentry was looked up
  *	@dentry contains the dentry structure for the file.
  *	Return 0 if permission is granted.
- * @inode_post_lookup:
- *	Set the security attributes for a file after it has been looked up.
- *	@inode contains the inode structure for parent directory.
- *	@d contains the dentry structure for the file.
  * @inode_delete:
  *	@inode contains the inode structure for deleted inode.
  *	This hook is called when a deleted inode is released (i.e. an inode
@@ -868,7 +864,6 @@
 	int (*inode_permission_lite) (struct inode *inode, int mask);
 	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
 	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
-	void (*inode_post_lookup) (struct inode *inode, struct dentry *d);
         void (*inode_delete) (struct inode *inode);
 	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
 			       size_t size, int flags);
@@ -953,6 +948,8 @@
 	                          struct security_operations *ops);
 	int (*unregister_security) (const char *name,
 	                            struct security_operations *ops);
+
+	void (*d_instantiate) (struct dentry * dentry, struct inode * inode);
 };
 
 /* global variables */
@@ -1246,12 +1243,6 @@
 	return security_ops->inode_getattr (mnt, dentry);
 }
 
-static inline void security_inode_post_lookup (struct inode *inode,
-					       struct dentry *dentry)
-{
-	security_ops->inode_post_lookup (inode, dentry);
-}
-
 static inline void security_inode_delete (struct inode *inode)
 {
 	security_ops->inode_delete (inode);
@@ -1549,6 +1540,11 @@
 	return security_ops->sem_semop(sma, sops, nsops, alter);
 }
 
+static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	security_ops->d_instantiate (dentry, inode);
+}
+
 /* prototypes */
 extern int security_scaffolding_startup	(void);
 extern int register_security	(struct security_operations *ops);
@@ -1828,10 +1824,6 @@
 	return 0;
 }
 
-static inline void security_inode_post_lookup (struct inode *inode,
-					       struct dentry *dentry)
-{ }
-
 static inline void security_inode_delete (struct inode *inode)
 { }
 
@@ -2114,6 +2106,9 @@
 {
 	return 0;
 }
+
+static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
+{ }
 
 #endif	/* CONFIG_SECURITY */
 
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Wed Feb 19 15:39:14 2003
+++ b/security/dummy.c	Wed Feb 19 15:39:14 2003
@@ -311,11 +311,6 @@
 	return 0;
 }
 
-static void dummy_inode_post_lookup (struct inode *ino, struct dentry *d)
-{
-	return;
-}
-
 static void dummy_inode_delete (struct inode *ino)
 {
 	return;
@@ -612,6 +607,12 @@
 	return -EINVAL;
 }
 
+static void dummy_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
+
 struct security_operations dummy_security_ops;
 
 #define set_to_dummy_if_null(ops, function)				\
@@ -674,7 +675,6 @@
 	set_to_dummy_if_null(ops, inode_permission_lite);
 	set_to_dummy_if_null(ops, inode_setattr);
 	set_to_dummy_if_null(ops, inode_getattr);
-	set_to_dummy_if_null(ops, inode_post_lookup);
 	set_to_dummy_if_null(ops, inode_delete);
 	set_to_dummy_if_null(ops, inode_setxattr);
 	set_to_dummy_if_null(ops, inode_getxattr);
@@ -731,5 +731,6 @@
 	set_to_dummy_if_null(ops, sem_semop);
 	set_to_dummy_if_null(ops, register_security);
 	set_to_dummy_if_null(ops, unregister_security);
+	set_to_dummy_if_null(ops, d_instantiate);
 }
 
