Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWIFQfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWIFQfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWIFQfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:35:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55953 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751628AbWIFQfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:35:50 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Access Control Lists for tmpfs
Date: Wed, 6 Sep 2006 18:40:06 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20060901221421.968954146@winden.suse.de> <20060901221458.148480972@winden.suse.de> <20060905120700.4f778843.akpm@osdl.org>
In-Reply-To: <20060905120700.4f778843.akpm@osdl.org>
MIME-Version: 1.0
X-Length: 15882
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mnv/EZcWGDR3G8J"
Message-Id: <200609061840.06586.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_mnv/EZcWGDR3G8J
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, 05 September 2006 21:07, Andrew Morton wrote:
> Can we move this declaration into a header file please?

That's better, yes. Attached is a version that incorporates the feedback so 
far.

Thanks,
Andreas

--Boundary-00=_mnv/EZcWGDR3G8J
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="tmpfs-acl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tmpfs-acl.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Access Control Lists for tmpfs
References: 118299

Add access control lists for tmpfs.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

---
 fs/Kconfig               |   13 +++
 include/linux/shmem_fs.h |   21 ++++++
 mm/Makefile              |    1 
 mm/shmem.c               |   94 ++++++++++++++++++++++++++-
 mm/shmem_acl.c           |  163 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 290 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc6/fs/Kconfig
===================================================================
--- linux-2.6.18-rc6.orig/fs/Kconfig
+++ linux-2.6.18-rc6/fs/Kconfig
@@ -862,6 +862,19 @@ config TMPFS
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
+config TMPFS_POSIX_ACL
+	bool "Tmpfs POSIX Access Control Lists"
+	depends on TMPFS
+	select GENERIC_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the POSIX ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
Index: linux-2.6.18-rc6/include/linux/shmem_fs.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/shmem_fs.h
+++ linux-2.6.18-rc6/include/linux/shmem_fs.h
@@ -19,6 +19,10 @@ struct shmem_inode_info {
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* first blocks */
 	struct list_head	swaplist;	/* chain of maybes on swap */
 	struct inode		vfs_inode;
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	struct posix_acl	*i_acl;
+	struct posix_acl	*i_default_acl;
+#endif
 };
 
 struct shmem_sb_info {
@@ -36,4 +40,24 @@ static inline struct shmem_inode_info *S
 	return container_of(inode, struct shmem_inode_info, vfs_inode);
 }
 
+#ifdef CONFIG_TMPFS_POSIX_ACL
+int shmem_permission(struct inode *, int, struct nameidata *);
+int shmem_acl_init(struct inode *, struct inode *);
+void shmem_acl_destroy_inode(struct inode *);
+
+extern struct xattr_handler shmem_xattr_acl_access_handler;
+extern struct xattr_handler shmem_xattr_acl_default_handler;
+
+extern struct generic_acl_operations shmem_acl_ops;
+
+#else
+static inline int shmem_acl_init(struct inode *inode, struct inode *dir)
+{
+	return 0;
+}
+static inline void shmem_acl_destroy_inode(struct inode *inode)
+{
+}
+#endif  /* CONFIG_TMPFS_POSIX_ACL */
+
 #endif
Index: linux-2.6.18-rc6/mm/Makefile
===================================================================
--- linux-2.6.18-rc6.orig/mm/Makefile
+++ linux-2.6.18-rc6/mm/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
+obj-$(CONFIG_TMPFS_POSIX_ACL) += shmem_acl.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_SLAB) += slab.o
Index: linux-2.6.18-rc6/mm/shmem.c
===================================================================
--- linux-2.6.18-rc6.orig/mm/shmem.c
+++ linux-2.6.18-rc6/mm/shmem.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/xattr.h>
+#include <linux/generic_acl.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/file.h>
@@ -176,6 +178,7 @@ static const struct address_space_operat
 static struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
+static struct inode_operations shmem_special_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info  __read_mostly = {
@@ -636,7 +639,7 @@ static int shmem_notify_change(struct de
 	struct page *page = NULL;
 	int error;
 
-	if (attr->ia_valid & ATTR_SIZE) {
+	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		if (attr->ia_size < inode->i_size) {
 			/*
 			 * If truncating down to a partial page, then
@@ -669,6 +672,10 @@ static int shmem_notify_change(struct de
 	error = inode_change_ok(inode, attr);
 	if (!error)
 		error = inode_setattr(inode, attr);
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	if (!error && (attr->ia_valid & ATTR_MODE))
+		error = generic_acl_chmod(inode, &shmem_acl_ops);
+#endif
 	if (page)
 		page_cache_release(page);
 	return error;
@@ -1362,6 +1369,7 @@ shmem_get_inode(struct super_block *sb, 
 
 		switch (mode & S_IFMT) {
 		default:
+			inode->i_op = &shmem_special_inode_operations;
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
@@ -1682,7 +1690,11 @@ shmem_mknod(struct inode *dir, struct de
 				iput(inode);
 				return error;
 			}
-			error = 0;
+		}
+		error = shmem_acl_init(inode, dir);
+		if (error) {
+			iput(inode);
+			return error;
 		}
 		if (dir->i_mode & S_ISGID) {
 			inode->i_gid = dir->i_gid;
@@ -1897,6 +1909,53 @@ static struct inode_operations shmem_sym
 	.put_link	= shmem_put_link,
 };
 
+#ifdef CONFIG_TMPFS_POSIX_ACL
+/**
+ * Superblocks without xattr inode operations will get security.* xattr
+ * support from the VFS "for free". As soon as we have any other xattrs
+ * like ACLs, we also need to implement the security.* handlers at
+ * filesystem level, though.
+ */
+
+static size_t shmem_xattr_security_list(struct inode *inode, char *list,
+					size_t list_len, const char *name,
+					size_t name_len)
+{
+	return security_inode_listsecurity(inode, list, list_len);
+}
+
+static int shmem_xattr_security_get(struct inode *inode, const char *name,
+				    void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_getsecurity(inode, name, buffer, size,
+					  -EOPNOTSUPP);
+}
+
+static int shmem_xattr_security_set(struct inode *inode, const char *name,
+				    const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_setsecurity(inode, name, value, size, flags);
+}
+
+struct xattr_handler shmem_xattr_security_handler = {
+	.prefix = XATTR_SECURITY_PREFIX,
+	.list   = shmem_xattr_security_list,
+	.get    = shmem_xattr_security_get,
+	.set    = shmem_xattr_security_set,
+};
+
+static struct xattr_handler *shmem_xattr_handlers[] = {
+	&shmem_xattr_acl_access_handler,
+	&shmem_xattr_acl_default_handler,
+	&shmem_xattr_security_handler,
+	NULL
+};
+#endif
+
 static int shmem_parse_options(char *options, int *mode, uid_t *uid,
 	gid_t *gid, unsigned long *blocks, unsigned long *inodes,
 	int *policy, nodemask_t *policy_nodes)
@@ -2094,6 +2153,10 @@ static int shmem_fill_super(struct super
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	sb->s_time_gran = 1;
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	sb->s_xattr = shmem_xattr_handlers;
+	sb->s_flags |= MS_POSIXACL;
+#endif
 
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
@@ -2130,6 +2193,7 @@ static void shmem_destroy_inode(struct i
 		/* only struct inode is valid if it's an inline symlink */
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
 	}
+	shmem_acl_destroy_inode(inode);
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
@@ -2141,6 +2205,10 @@ static void init_once(void *foo, struct 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
 		inode_init_once(&p->vfs_inode);
+#ifdef CONFIG_TMPFS_POSIX_ACL
+		p->i_acl = NULL;
+		p->i_default_acl = NULL;
+#endif
 	}
 }
 
@@ -2185,6 +2253,14 @@ static struct inode_operations shmem_ino
 	.truncate	= shmem_truncate,
 	.setattr	= shmem_notify_change,
 	.truncate_range	= shmem_truncate_range,
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= generic_listxattr,
+	.removexattr	= generic_removexattr,
+	.permission	= shmem_permission,
+#endif
+
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -2199,6 +2275,25 @@ static struct inode_operations shmem_dir
 	.mknod		= shmem_mknod,
 	.rename		= shmem_rename,
 #endif
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	.setattr	= shmem_notify_change,
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= generic_listxattr,
+	.removexattr	= generic_removexattr,
+	.permission	= shmem_permission,
+#endif
+};
+
+static struct inode_operations shmem_special_inode_operations = {
+#ifdef CONFIG_TMPFS_POSIX_ACL
+	.setattr	= shmem_notify_change,
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= generic_listxattr,
+	.removexattr	= generic_removexattr,
+	.permission	= shmem_permission,
+#endif
 };
 
 static struct super_operations shmem_ops = {
Index: linux-2.6.18-rc6/mm/shmem_acl.c
===================================================================
--- /dev/null
+++ linux-2.6.18-rc6/mm/shmem_acl.c
@@ -0,0 +1,197 @@
+/*
+ * mm/shmem_acl.c
+ *
+ * (C) 2005 Andreas Gruenbacher <agruen@suse.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/fs.h>
+#include <linux/shmem_fs.h>
+#include <linux/xattr.h>
+#include <linux/generic_acl.h>
+
+/**
+ * shmem_get_acl  -   generic_acl_operations->getacl() operation
+ */
+static struct posix_acl *
+shmem_get_acl(struct inode *inode, int type)
+{
+	struct posix_acl *acl = NULL;
+
+	spin_lock(&inode->i_lock);
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			acl = posix_acl_dup(SHMEM_I(inode)->i_acl);
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			acl = posix_acl_dup(SHMEM_I(inode)->i_default_acl);
+			break;
+	}
+	spin_unlock(&inode->i_lock);
+
+	return acl;
+}
+
+/**
+ * shmem_get_acl  -   generic_acl_operations->setacl() operation
+ */
+static void
+shmem_set_acl(struct inode *inode, int type, struct posix_acl *acl)
+{
+	struct posix_acl *free = NULL;
+
+	spin_lock(&inode->i_lock);
+	switch(type) {
+		case ACL_TYPE_ACCESS:
+			free = SHMEM_I(inode)->i_acl;
+			SHMEM_I(inode)->i_acl = posix_acl_dup(acl);
+			break;
+
+		case ACL_TYPE_DEFAULT:
+			free = SHMEM_I(inode)->i_default_acl;
+			SHMEM_I(inode)->i_default_acl = posix_acl_dup(acl);
+			break;
+	}
+	spin_unlock(&inode->i_lock);
+	posix_acl_release(free);
+}
+
+struct generic_acl_operations shmem_acl_ops = {
+	.getacl = shmem_get_acl,
+	.setacl = shmem_set_acl,
+};
+
+/**
+ * shmem_list_acl_access, shmem_get_acl_access, shmem_set_acl_access,
+ * shmem_xattr_acl_access_handler  -  plumbing code to implement the
+ * system.posix_acl_access xattr using the generic acl functions.
+ */
+
+static size_t
+shmem_list_acl_access(struct inode *inode, char *list, size_t list_size,
+		      const char *name, size_t name_len)
+{
+	return generic_acl_list(inode, &shmem_acl_ops, ACL_TYPE_ACCESS,
+				list, list_size);
+}
+
+static int
+shmem_get_acl_access(struct inode *inode, const char *name, void *buffer,
+		     size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_get(inode, &shmem_acl_ops, ACL_TYPE_ACCESS, buffer,
+			       size);
+}
+
+static int
+shmem_set_acl_access(struct inode *inode, const char *name, const void *value,
+		     size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_set(inode, &shmem_acl_ops, ACL_TYPE_ACCESS, value,
+			       size);
+}
+
+struct xattr_handler shmem_xattr_acl_access_handler = {
+	.prefix = POSIX_ACL_XATTR_ACCESS,
+	.list	= shmem_list_acl_access,
+	.get	= shmem_get_acl_access,
+	.set	= shmem_set_acl_access,
+};
+
+/**
+ * shmem_list_acl_default, shmem_get_acl_default, shmem_set_acl_default,
+ * shmem_xattr_acl_default_handler  -  plumbing code to implement the
+ * system.posix_acl_default xattr using the generic acl functions.
+ */
+
+static size_t
+shmem_list_acl_default(struct inode *inode, char *list, size_t list_size,
+		       const char *name, size_t name_len)
+{
+	return generic_acl_list(inode, &shmem_acl_ops, ACL_TYPE_DEFAULT,
+				list, list_size);
+}
+
+static int
+shmem_get_acl_default(struct inode *inode, const char *name, void *buffer,
+		      size_t size)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_get(inode, &shmem_acl_ops, ACL_TYPE_DEFAULT, buffer,
+			       size);
+}
+
+static int
+shmem_set_acl_default(struct inode *inode, const char *name, const void *value,
+		      size_t size, int flags)
+{
+	if (strcmp(name, "") != 0)
+		return -EINVAL;
+	return generic_acl_set(inode, &shmem_acl_ops, ACL_TYPE_DEFAULT, value,
+			       size);
+}
+
+struct xattr_handler shmem_xattr_acl_default_handler = {
+	.prefix = POSIX_ACL_XATTR_DEFAULT,
+	.list	= shmem_list_acl_default,
+	.get	= shmem_get_acl_default,
+	.set	= shmem_set_acl_default,
+};
+
+/**
+ * shmem_acl_init  -  Inizialize the acl(s) of a new inode
+ */
+int
+shmem_acl_init(struct inode *inode, struct inode *dir)
+{
+	return generic_acl_init(inode, dir, &shmem_acl_ops);
+}
+
+/**
+ * shmem_acl_destroy_inode  -  destroy acls hanging off the in-memory inode
+ *
+ * This is done before destroying the actual inode.
+ */
+
+void
+shmem_acl_destroy_inode(struct inode *inode)
+{
+	if (SHMEM_I(inode)->i_acl)
+		posix_acl_release(SHMEM_I(inode)->i_acl);
+	SHMEM_I(inode)->i_acl = NULL;
+	if (SHMEM_I(inode)->i_default_acl)
+		posix_acl_release(SHMEM_I(inode)->i_default_acl);
+	SHMEM_I(inode)->i_default_acl = NULL;
+}
+
+/**
+ * shmem_check_acl  -  check_acl() callback for generic_permission()
+ */
+static int
+shmem_check_acl(struct inode *inode, int mask)
+{
+	struct posix_acl *acl = shmem_get_acl(inode, ACL_TYPE_ACCESS);
+
+	if (acl) {
+		int error = posix_acl_permission(inode, acl, mask);
+		posix_acl_release(acl);
+		return error;
+	}
+	return -EAGAIN;
+}
+
+/**
+ * shmem_permission  -  permission() inode operation
+ */
+int
+shmem_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	return generic_permission(inode, mask, shmem_check_acl);
+}

--Boundary-00=_mnv/EZcWGDR3G8J--
