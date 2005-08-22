Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVHVVwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVHVVwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVHVVwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:52:33 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:42883 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751267AbVHVVwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:52:30 -0400
Date: Mon, 22 Aug 2005 03:04:01 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@wirex.com,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Ext2-devel@lists.sourceforge.net, Andreas Gruenbacher <agruen@suse.de>,
       Andreas Dilger <adilger@clusterfs.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH -mm] [LSM] Stacking support for inode_init_security
Message-ID: <20050822080401.GA26125@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically the same patch as I sent out Friday, except against
2.6.13-rc6-mm1 with stacker applied.  It redefines
security_inode_init_security() to pass a struct list_head to which
security modules can attach their data.  Filesystems can then loop
through the results easily to store each of the xattrs and free the
results.

This is useful both for the stacker LSM, and for any two (or more)
LSMs which might want to cooperate even without stacker.

I've tested this under using Stephen Smalley's sample exploit
originally motivating inode_init_security, as well as with a simple
'touch ab; ls -Z ab'.  Several kernels have been compiled without a
problem.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 fs/ext2/xattr_security.c |   22 ++++++++++++++--------
 fs/ext3/xattr_security.c |   22 ++++++++++++++--------
 include/linux/security.h |   30 +++++++++++++++++++-----------
 mm/shmem.c               |    6 ++----
 security/dummy.c         |    2 +-
 security/selinux/hooks.c |   42 ++++++++++++++++++++++++++----------------
 6 files changed, 76 insertions(+), 48 deletions(-)

Index: linux-2.6.13-rc6-mm1/include/linux/security.h
===================================================================
--- linux-2.6.13-rc6-mm1.orig/include/linux/security.h	2005-08-19 17:00:39.000000000 -0500
+++ linux-2.6.13-rc6-mm1/include/linux/security.h	2005-08-21 21:11:07.000000000 -0500
@@ -161,6 +161,14 @@ struct swap_info_struct;
 
 #ifdef CONFIG_SECURITY
 
+struct xattr_data {
+	struct list_head list;
+	char *name;
+	void *value;
+	int len;
+};
+
+
 /**
  * struct security_operations - main security structure
  *
@@ -343,9 +351,13 @@ struct swap_info_struct;
  *	then it should return -EOPNOTSUPP to skip this processing.
  *	@inode contains the inode structure of the newly created inode.
  *	@dir contains the inode structure of the parent directory.
- *	@name will be set to the allocated name suffix (e.g. selinux).
- *	@value will be set to the allocated attribute value.
- *	@len will be set to the length of the value.
+ *	@head, if not null, points to a listhead to which to append a
+ *		newly allocated struct xattr_data with the following data:
+ *		@data->name will be set to the allocated name suffix
+ * 			(e.g. selinux).
+ *		@data->value will be set to the allocated attribute value.
+ *		@data->len will be set to the length of the value.
+ *		@data->list is used to add the data to the list_head
  *	Returns 0 if @name and @value have been successfully set,
  *		-EOPNOTSUPP if no security attribute is needed, or
  *		-ENOMEM on memory allocation failure.
@@ -1146,7 +1158,7 @@ struct security_operations {
 	int (*inode_alloc_security) (struct inode *inode);	
 	void (*inode_free_security) (struct inode *inode);
 	int (*inode_init_security) (struct inode *inode, struct inode *dir,
-				    char **name, void **value, size_t *len);
+				    struct list_head *head);
 	int (*inode_create) (struct inode *dir,
 	                     struct dentry *dentry, int mode);
 	int (*inode_link) (struct dentry *old_dentry,
@@ -1497,13 +1509,11 @@ static inline void security_inode_free (
 
 static inline int security_inode_init_security (struct inode *inode,
 						struct inode *dir,
-						char **name,
-						void **value,
-						size_t *len)
+						struct list_head *head)
 {
 	if (unlikely (IS_PRIVATE (inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_init_security (inode, dir, name, value, len);
+	return security_ops->inode_init_security (inode, dir, head);
 }
 	
 static inline int security_inode_create (struct inode *dir,
@@ -2186,9 +2196,7 @@ static inline void security_inode_free (
 
 static inline int security_inode_init_security (struct inode *inode,
 						struct inode *dir,
-						char **name,
-						void **value,
-						size_t *len)
+						struct list_head *head)
 {
 	return -EOPNOTSUPP;
 }
Index: linux-2.6.13-rc6-mm1/mm/shmem.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/mm/shmem.c	2005-08-19 16:59:41.000000000 -0500
+++ linux-2.6.13-rc6-mm1/mm/shmem.c	2005-08-19 17:01:49.000000000 -0500
@@ -1611,8 +1611,7 @@ shmem_mknod(struct inode *dir, struct de
 	int error = -ENOSPC;
 
 	if (inode) {
-		error = security_inode_init_security(inode, dir, NULL, NULL,
-						     NULL);
+		error = security_inode_init_security(inode, dir, NULL);
 		if (error) {
 			if (error != -EOPNOTSUPP) {
 				iput(inode);
@@ -1758,8 +1757,7 @@ static int shmem_symlink(struct inode *d
 	if (!inode)
 		return -ENOSPC;
 
-	error = security_inode_init_security(inode, dir, NULL, NULL,
-					     NULL);
+	error = security_inode_init_security(inode, dir, NULL);
 	if (error) {
 		if (error != -EOPNOTSUPP) {
 			iput(inode);
Index: linux-2.6.13-rc6-mm1/security/dummy.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/security/dummy.c	2005-08-19 16:59:42.000000000 -0500
+++ linux-2.6.13-rc6-mm1/security/dummy.c	2005-08-19 17:01:49.000000000 -0500
@@ -259,7 +259,7 @@ static void dummy_inode_free_security (s
 }
 
 static int dummy_inode_init_security (struct inode *inode, struct inode *dir,
-				      char **name, void **value, size_t *len)
+				      struct list_head *head)
 {
 	return -EOPNOTSUPP;
 }
Index: linux-2.6.13-rc6-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/security/selinux/hooks.c	2005-08-19 17:00:39.000000000 -0500
+++ linux-2.6.13-rc6-mm1/security/selinux/hooks.c	2005-08-19 17:01:49.000000000 -0500
@@ -1960,13 +1960,13 @@ static void selinux_inode_free_security(
 }
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
-				       char **name, void **value,
-				       size_t *len)
+				       struct list_head *head)
 {
 	struct task_security_struct *tsec;
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	struct inode_security_struct *isec;
+	struct xattr_data *datap;
 	u32 newsid, clen;
 	int rc;
 	char *namep = NULL, *context;
@@ -2002,24 +2002,34 @@ static int selinux_inode_init_security(s
 
 	inode_security_set_sid(inode, newsid);
 
-	if (name) {
-		namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_KERNEL);
-		if (!namep)
-			return -ENOMEM;
-		*name = namep;
-	}
+	if (!head)
+		return 0;
 
-	if (value && len) {
-		rc = security_sid_to_context(newsid, &context, &clen);
-		if (rc) {
-			kfree(namep);
-			return rc;
-		}
-		*value = context;
-		*len = clen;
+	datap = kmalloc(sizeof(struct xattr_data), GFP_KERNEL);
+	if (!datap)
+		return -ENOMEM;
+
+	namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_KERNEL);
+	if (!namep) {
+		rc = -ENOMEM;
+		goto err;
 	}
 
+	rc = security_sid_to_context(newsid, &context, &clen);
+	if (rc)
+		goto err;
+	datap->value = context;
+	datap->len = clen;
+	datap->name = namep;
+	INIT_LIST_HEAD(&datap->list);
+
+	list_add_tail(&datap->list, head);
 	return 0;
+
+err:
+	kfree(namep);
+	kfree(datap);
+	return rc;
 }
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, int mask)
Index: linux-2.6.13-rc6-mm1/fs/ext2/xattr_security.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/fs/ext2/xattr_security.c	2005-08-19 16:59:38.000000000 -0500
+++ linux-2.6.13-rc6-mm1/fs/ext2/xattr_security.c	2005-08-19 17:01:49.000000000 -0500
@@ -50,20 +50,26 @@ int
 ext2_init_security(struct inode *inode, struct inode *dir)
 {
 	int err;
-	size_t len;
-	void *value;
-	char *name;
+	struct xattr_data *p, *n;
+	LIST_HEAD(head);
 
-	err = security_inode_init_security(inode, dir, &name, &value, &len);
+	err = security_inode_init_security(inode, dir, &head);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
 		return err;
 	}
-	err = ext2_xattr_set(inode, EXT2_XATTR_INDEX_SECURITY,
-			     name, value, len, 0);
-	kfree(name);
-	kfree(value);
+
+	list_for_each_entry_safe(p, n, &head, list) {
+		if (!err)
+			err = ext2_xattr_set(inode,
+				EXT2_XATTR_INDEX_SECURITY,
+				p->name, p->value, p->len, 0);
+		list_del(&p->list);
+		kfree(p->name);
+		kfree(p->value);
+		kfree(p);
+	}
 	return err;
 }
 
Index: linux-2.6.13-rc6-mm1/fs/ext3/xattr_security.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/fs/ext3/xattr_security.c	2005-08-19 16:59:38.000000000 -0500
+++ linux-2.6.13-rc6-mm1/fs/ext3/xattr_security.c	2005-08-19 17:01:49.000000000 -0500
@@ -52,20 +52,26 @@ int
 ext3_init_security(handle_t *handle, struct inode *inode, struct inode *dir)
 {
 	int err;
-	size_t len;
-	void *value;
-	char *name;
+	struct xattr_data *p, *n;
+	LIST_HEAD(head);
 
-	err = security_inode_init_security(inode, dir, &name, &value, &len);
+	err = security_inode_init_security(inode, dir, &head);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
 		return err;
 	}
-	err = ext3_xattr_set_handle(handle, inode, EXT3_XATTR_INDEX_SECURITY,
-				    name, value, len, 0);
-	kfree(name);
-	kfree(value);
+
+	list_for_each_entry_safe(p, n, &head, list) {
+		if (!err)
+			err = ext3_xattr_set_handle(handle, inode,
+				EXT3_XATTR_INDEX_SECURITY,
+				p->name, p->value, p->len, 0);
+		list_del(&p->list);
+		kfree(p->name);
+		kfree(p->value);
+		kfree(p);
+	}
 	return err;
 }
 
