Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUIWD5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUIWD5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUIWD5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:57:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61124 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268246AbUIWD4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:56:06 -0400
Date: Wed, 22 Sep 2004 23:55:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 2/6] xattr consolidation v3 - LSM
In-Reply-To: <Xine.LNX.4.44.0409222347120.447@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409222348090.447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the dentry parameter with an inode in the LSM
inode_{set|get|list}security hooks, in keeping with the ext2/ext3 code.
dentries are not needed here.


 include/linux/security.h |   33 +++++++++++++++++----------------
 security/dummy.c         |    6 +++---
 security/selinux/hooks.c |   10 ++++------
 3 files changed, 24 insertions(+), 25 deletions(-)

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/include/linux/security.h linux-2.6.9-rc2-mm2.w/include/linux/security.h
--- linux-2.6.9-rc2-mm2.p/include/linux/security.h	2004-09-22 22:08:56.646989840 -0400
+++ linux-2.6.9-rc2-mm2.w/include/linux/security.h	2004-09-22 22:09:35.139138144 -0400
@@ -396,13 +396,13 @@ struct swap_info_struct;
  * 	Return 0 if permission is granted.
  * @inode_getsecurity:
  *	Copy the extended attribute representation of the security label 
- *	associated with @name for @dentry into @buffer.  @buffer may be 
+ *	associated with @name for @inode into @buffer.  @buffer may be 
  *	NULL to request the size of the buffer required.  @size indicates
  *	the size of @buffer in bytes.  Note that @name is the remainder
  *	of the attribute name after the security. prefix has been removed.
  *	Return number of bytes used/required on success.
  * @inode_setsecurity:
- *	Set the security label associated with @name for @dentry from the 
+ *	Set the security label associated with @name for @inode from the 
  *	extended attribute value @value.  @size indicates the size of the
  *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
  *	Note that @name is the remainder of the attribute name after the 
@@ -410,8 +410,9 @@ struct swap_info_struct;
  *	Return 0 on success.
  * @inode_listsecurity:
  *	Copy the extended attribute names for the security labels
- *	associated with @dentry into @buffer.  @buffer may be NULL to 
- *	request the size of the buffer required.  
+ *	associated with @inode into @buffer.  The maximum size of @buffer
+ *	is specified by @buffer_size.  @buffer may be NULL to request
+ *	the size of the buffer required.  
  *	Returns number of bytes used/required on success.
  *
  * Security hooks for file operations
@@ -1109,9 +1110,9 @@ struct security_operations {
 	int (*inode_getxattr) (struct dentry *dentry, char *name);
 	int (*inode_listxattr) (struct dentry *dentry);
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
-  	int (*inode_getsecurity)(struct dentry *dentry, const char *name, void *buffer, size_t size);
-  	int (*inode_setsecurity)(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
-  	int (*inode_listsecurity)(struct dentry *dentry, char *buffer);
+  	int (*inode_getsecurity)(struct inode *inode, const char *name, void *buffer, size_t size);
+  	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
+  	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
 
 	int (*file_permission) (struct file * file, int mask);
 	int (*file_alloc_security) (struct file * file);
@@ -1576,19 +1577,19 @@ static inline int security_inode_removex
 	return security_ops->inode_removexattr (dentry, name);
 }
 
-static inline int security_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
-	return security_ops->inode_getsecurity(dentry, name, buffer, size);
+	return security_ops->inode_getsecurity(inode, name, buffer, size);
 }
 
-static inline int security_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
+static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags) 
 {
-	return security_ops->inode_setsecurity(dentry, name, value, size, flags);
+	return security_ops->inode_setsecurity(inode, name, value, size, flags);
 }
 
-static inline int security_inode_listsecurity(struct dentry *dentry, char *buffer)
+static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
-	return security_ops->inode_listsecurity(dentry, buffer);
+	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
 }
 
 static inline int security_file_permission (struct file *file, int mask)
@@ -2215,17 +2216,17 @@ static inline int security_inode_removex
 	return cap_inode_removexattr(dentry, name);
 }
 
-static inline int security_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
+static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags) 
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_listsecurity(struct dentry *dentry, char *buffer)
+static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	return 0;
 }
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/security/dummy.c linux-2.6.9-rc2-mm2.w/security/dummy.c
--- linux-2.6.9-rc2-mm2.p/security/dummy.c	2004-09-22 22:08:56.661987560 -0400
+++ linux-2.6.9-rc2-mm2.w/security/dummy.c	2004-09-22 19:26:22.000000000 -0400
@@ -447,17 +447,17 @@ static int dummy_inode_removexattr (stru
 	return 0;
 }
 
-static int dummy_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+static int dummy_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
 	return -EOPNOTSUPP;
 }
 
-static int dummy_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
+static int dummy_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags) 
 {
 	return -EOPNOTSUPP;
 }
 
-static int dummy_inode_listsecurity(struct dentry *dentry, char *buffer)
+static int dummy_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	return 0;
 }
diff -purN -X dontdiff linux-2.6.9-rc2-mm2.p/security/selinux/hooks.c linux-2.6.9-rc2-mm2.w/security/selinux/hooks.c
--- linux-2.6.9-rc2-mm2.p/security/selinux/hooks.c	2004-09-22 22:08:56.665986952 -0400
+++ linux-2.6.9-rc2-mm2.w/security/selinux/hooks.c	2004-09-22 19:26:22.000000000 -0400
@@ -2332,9 +2332,8 @@ static int selinux_inode_removexattr (st
 	return -EACCES;
 }
 
-static int selinux_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+static int selinux_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
-	struct inode *inode = dentry->d_inode;
 	struct inode_security_struct *isec = inode->i_security;
 	char *context;
 	unsigned len;
@@ -2362,10 +2361,9 @@ static int selinux_inode_getsecurity(str
 	return len;
 }
 
-static int selinux_inode_setsecurity(struct dentry *dentry, const char *name,
+static int selinux_inode_setsecurity(struct inode *inode, const char *name,
                                      const void *value, size_t size, int flags)
 {
-	struct inode *inode = dentry->d_inode;
 	struct inode_security_struct *isec = inode->i_security;
 	u32 newsid;
 	int rc;
@@ -2384,10 +2382,10 @@ static int selinux_inode_setsecurity(str
 	return 0;
 }
 
-static int selinux_inode_listsecurity(struct dentry *dentry, char *buffer)
+static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	const int len = sizeof(XATTR_NAME_SELINUX);
-	if (buffer)
+	if (buffer && len <= buffer_size)
 		memcpy(buffer, XATTR_NAME_SELINUX, len);
 	return len;
 }


