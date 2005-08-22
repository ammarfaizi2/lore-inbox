Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVHVVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVHVVgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVHVVgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:36:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6136 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751253AbVHVVf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:35:58 -0400
Date: Mon, 22 Aug 2005 11:50:30 -0500
From: serue@us.ibm.com
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       linux-security-module@wirex.com,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Ext2-devel@lists.sourceforge.net, Andreas Gruenbacher <agruen@suse.de>,
       Andreas Dilger <adilger@clusterfs.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH -mm] [LSM] Stacking support for inode_init_security
Message-ID: <20050822165030.GA5511@sergelap.austin.ibm.com>
References: <20050822080401.GA26125@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822080401.GA26125@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch used int instead of size_t for the xattr value
length.  A new patch just for include/linux/security.h is appended.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
  include/linux/security.h |   30 +++++++++++++++++++-----------

Index: linux-2.6.13-rc6-mm1/include/linux/security.h
===================================================================
--- linux-2.6.13-rc6-mm1.orig/include/linux/security.h	2005-08-21 21:19:32.000000000 -0500
+++ linux-2.6.13-rc6-mm1/include/linux/security.h	2005-08-22 14:46:21.000000000 -0500
@@ -161,6 +161,14 @@ struct swap_info_struct;
 
 #ifdef CONFIG_SECURITY
 
+struct xattr_data {
+	struct list_head list;
+	char *name;
+	void *value;
+	size_t len;
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
