Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTEFQJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTEFQJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:09:11 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:33278 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263913AbTEFQI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:08:59 -0400
Subject: [PATCH] Change LSM hooks in setxattr 2.5.69
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1052238063.1377.997.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 12:21:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.69 adds a security_inode_post_setxattr hook so
that security modules can update the inode security structure after a
successful setxattr, and it moves the existing security_inode_setxattr
hook call after the taking the inode semaphore so that atomicity is
provided for the security check and the update to the inode security
structure.  Al, if you approve of this change, please acknowledge.  If
not, please advise as to what must change.  Thanks. 

 fs/xattr.c               |    7 ++++---
 include/linux/security.h |   15 +++++++++++++++
 security/dummy.c         |    6 ++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

Index: linux-2.5/fs/xattr.c
diff -u linux-2.5/fs/xattr.c:1.1.1.1 linux-2.5/fs/xattr.c:1.4
--- linux-2.5/fs/xattr.c:1.1.1.1	Wed Mar 12 10:55:12 2003
+++ linux-2.5/fs/xattr.c	Wed Mar 26 14:03:25 2003
@@ -79,15 +79,16 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
+		down(&d->d_inode->i_sem);
 		error = security_inode_setxattr(d, kname, kvalue, size, flags);
 		if (error)
 			goto out;
-		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
+		if (!error)
+			security_inode_post_setxattr(d, kname, kvalue, size, flags);
+out:
 		up(&d->d_inode->i_sem);
 	}
-
-out:
 	xattr_free(kvalue, size);
 	return error;
 }
Index: linux-2.5/include/linux/security.h
diff -u linux-2.5/include/linux/security.h:1.1.1.2 linux-2.5/include/linux/security.h:1.16
--- linux-2.5/include/linux/security.h:1.1.1.2	Wed Mar 19 09:54:58 2003
+++ linux-2.5/include/linux/security.h	Fri Apr 18 11:17:19 2003
@@ -361,6 +361,9 @@
  * 	Check permission before setting the extended attributes
  * 	@value identified by @name for @dentry.
  * 	Return 0 if permission is granted.
+ * @inode_post_setxattr:
+ * 	Update inode security field after successful setxattr operation.
+ * 	@value identified by @name for @dentry.
  * @inode_getxattr:
  * 	Check permission before obtaining the extended attributes
  * 	identified by @name for @dentry.
@@ -1036,6 +1039,8 @@
         void (*inode_delete) (struct inode *inode);
 	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
 			       size_t size, int flags);
+	void (*inode_post_setxattr) (struct dentry *dentry, char *name, void *value,
+				     size_t size, int flags);
 	int (*inode_getxattr) (struct dentry *dentry, char *name);
 	int (*inode_listxattr) (struct dentry *dentry);
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
@@ -1464,6 +1472,12 @@
 	return security_ops->inode_setxattr (dentry, name, value, size, flags);
 }
 
+static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
+						void *value, size_t size, int flags)
+{
+	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
+}
+
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
 	return security_ops->inode_getxattr (dentry, name);
@@ -2063,6 +2087,10 @@
 	return 0;
 }
 
+static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
+						 void *value, size_t size, int flags)
+{ }
+
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
 	return 0;
Index: linux-2.5/security/dummy.c
diff -u linux-2.5/security/dummy.c:1.1.1.2 linux-2.5/security/dummy.c:1.14
--- linux-2.5/security/dummy.c:1.1.1.2	Wed Mar 19 09:59:17 2003
+++ linux-2.5/security/dummy.c	Fri Apr 18 11:17:20 2003
@@ -334,6 +334,11 @@
 	return 0;
 }
 
+static void dummy_inode_post_setxattr (struct dentry *dentry, char *name, void *value,
+				       size_t size, int flags)
+{
+}
+
 static int dummy_inode_getxattr (struct dentry *dentry, char *name)
 {
 	return 0;
@@ -803,6 +818,7 @@
 	set_to_dummy_if_null(ops, inode_getattr);
 	set_to_dummy_if_null(ops, inode_delete);
 	set_to_dummy_if_null(ops, inode_setxattr);
+	set_to_dummy_if_null(ops, inode_post_setxattr);
 	set_to_dummy_if_null(ops, inode_getxattr);
 	set_to_dummy_if_null(ops, inode_listxattr);
 	set_to_dummy_if_null(ops, inode_removexattr);

 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

