Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTEOO5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTEOO5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:57:25 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:20653 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264012AbTEOO5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:57:10 -0400
Subject: [RFC][PATCH] devpts xattr handler for security labels 2.5.69-bk
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@digeo.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1053011337.4729.720.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 May 2003 11:09:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.69-bk adds an xattr handler for security labels
to devpts and corresponding hooks to the LSM API to support conversion
between xattr values and the security labels stored in the inode
security field by the security module.  This allows userspace to get and
set the security labels on devpts nodes, e.g. so that sshd can set the
security label for the pty using setxattr, just as sshd already sets the
ownership using chown.  SELinux uses this support to protect the pty in
accordance with the user process' security label.  The changes to the
LSM API are general and should be re-useable by xattr handlers in other
pseudo filesystems to support similar security labeling.  The xattr
handler for devpts includes the same generic framework as in ext[23], so
handlers for other kinds of attributes can be added easily in the
future.  I can split this patch into two separate patches for the
changes to the LSM API and the devpts xattr handler if desired, although
the devpts xattr handler will initially be the only user of the new
hooks.  If anyone has any objections to this patch, please let me know. 
Thanks.


 fs/Kconfig                 |   22 ++++
 fs/devpts/Makefile         |    8 +
 fs/devpts/inode.c          |   15 ++-
 fs/devpts/xattr.c          |  214 +++++++++++++++++++++++++++++++++++++++++++++
 fs/devpts/xattr.h          |   59 ++++++++++++
 fs/devpts/xattr_security.c |   42 ++++++++
 include/linux/security.h   |   52 ++++++++++
 security/dummy.c           |   18 +++
 8 files changed, 429 insertions(+), 1 deletion(-)

diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Thu May 15 09:29:12 2003
+++ b/include/linux/security.h	Thu May 15 09:29:12 2003
@@ -376,6 +376,25 @@
  * 	Check permission before removing the extended attribute
  * 	identified by @name for @dentry.
  * 	Return 0 if permission is granted.
+ * @inode_getsecurity:
+ *	Copy the extended attribute representation of the security label 
+ *	associated with @name for @dentry into @buffer.  @buffer may be 
+ *	NULL to request the size of the buffer required.  @size indicates
+ *	the size of @buffer in bytes.  Note that @name is the remainder
+ *	of the attribute name after the security. prefix has been removed.
+ *	Return number of bytes used/required on success.
+ * @inode_setsecurity:
+ *	Set the security label associated with @name for @dentry from the 
+ *	extended attribute value @value.  @size indicates the size of the
+ *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
+ *	Note that @name is the remainder of the attribute name after the 
+ *	security. prefix has been removed.
+ *	Return 0 on success.
+ * @inode_listsecurity:
+ *	Copy the extended attribute names for the security labels
+ *	associated with @dentry into @buffer.  @buffer may be NULL to 
+ *	request the size of the buffer required.  
+ *	Returns number of bytes used/required on success.
  *
  * Security hooks for file operations
  *
@@ -1044,6 +1063,9 @@
 	int (*inode_getxattr) (struct dentry *dentry, char *name);
 	int (*inode_listxattr) (struct dentry *dentry);
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
+  	int (*inode_getsecurity)(struct dentry *dentry, const char *name, void *buffer, size_t size);
+  	int (*inode_setsecurity)(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
+  	int (*inode_listsecurity)(struct dentry *dentry, char *buffer);
 
 	int (*file_permission) (struct file * file, int mask);
 	int (*file_alloc_security) (struct file * file);
@@ -1490,6 +1512,21 @@
 	return security_ops->inode_removexattr (dentry, name);
 }
 
+static inline int security_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	return security_ops->inode_getsecurity(dentry, name, buffer, size);
+}
+
+static inline int security_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
+{
+	return security_ops->inode_setsecurity(dentry, name, value, size, flags);
+}
+
+static inline int security_inode_listsecurity(struct dentry *dentry, char *buffer)
+{
+	return security_ops->inode_listsecurity(dentry, buffer);
+}
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return security_ops->file_permission (file, mask);
@@ -2091,6 +2128,21 @@
 static inline int security_inode_removexattr (struct dentry *dentry, char *name)
 {
 	return 0;
+}
+
+static inline int security_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_inode_listsecurity(struct dentry *dentry, char *buffer)
+{
+	return 0;
 }
 
 static inline int security_file_permission (struct file *file, int mask)
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Thu May 15 09:29:12 2003
+++ b/security/dummy.c	Thu May 15 09:29:12 2003
@@ -354,6 +354,21 @@
 	return 0;
 }
 
+static int dummy_inode_getsecurity(struct dentry *dentry, const char *name, void *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int dummy_inode_setsecurity(struct dentry *dentry, const char *name, const void *value, size_t size, int flags) 
+{
+	return -EOPNOTSUPP;
+}
+
+static int dummy_inode_listsecurity(struct dentry *dentry, char *buffer)
+{
+	return 0;
+}
+
 static int dummy_file_permission (struct file *file, int mask)
 {
 	return 0;
@@ -812,6 +827,9 @@
 	set_to_dummy_if_null(ops, inode_getxattr);
 	set_to_dummy_if_null(ops, inode_listxattr);
 	set_to_dummy_if_null(ops, inode_removexattr);
+	set_to_dummy_if_null(ops, inode_getsecurity);
+	set_to_dummy_if_null(ops, inode_setsecurity);
+	set_to_dummy_if_null(ops, inode_listsecurity);
 	set_to_dummy_if_null(ops, file_permission);
 	set_to_dummy_if_null(ops, file_alloc_security);
 	set_to_dummy_if_null(ops, file_free_security);
diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Thu May 15 09:29:23 2003
+++ b/fs/Kconfig	Thu May 15 09:29:23 2003
@@ -827,6 +827,28 @@
 	  Note that the experimental "/dev file system support"
 	  (CONFIG_DEVFS_FS)  is a more general facility.
 
+config DEVPTS_FS_XATTR
+	bool "/dev/pts Extended Attributes"
+	depends on DEVPTS_FS
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+
+	  If unsure, say N.
+
+config DEVPTS_FS_SECURITY
+	bool "/dev/pts Security Labels"
+	depends on DEVPTS_FS_XATTR
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the /dev/pts filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
 config TMPFS
 	bool "Virtual memory file system support (former shm fs)"
 	help
diff -Nru a/fs/devpts/Makefile b/fs/devpts/Makefile
--- a/fs/devpts/Makefile	Thu May 15 09:29:23 2003
+++ b/fs/devpts/Makefile	Thu May 15 09:29:23 2003
@@ -5,3 +5,11 @@
 obj-$(CONFIG_DEVPTS_FS) += devpts.o
 
 devpts-objs := inode.o
+
+ifeq ($(CONFIG_DEVPTS_FS_XATTR),y)
+devpts-objs += xattr.o 
+endif
+
+ifeq ($(CONFIG_DEVPTS_FS_SECURITY),y)
+devpts-objs += xattr_security.o
+endif
diff -Nru a/fs/devpts/inode.c b/fs/devpts/inode.c
--- a/fs/devpts/inode.c	Thu May 15 09:29:23 2003
+++ b/fs/devpts/inode.c	Thu May 15 09:29:23 2003
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include "xattr.h"
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
@@ -130,6 +131,13 @@
 	return lookup_one_len(s, root, sprintf(s, "%d", num));
 }
 
+static struct inode_operations devpts_file_inode_operations = {
+	.setxattr	= devpts_setxattr,
+	.getxattr	= devpts_getxattr,
+	.listxattr	= devpts_listxattr,
+	.removexattr	= devpts_removexattr,
+};
+
 void devpts_pty_new(int number, dev_t device)
 {
 	struct dentry *dentry;
@@ -142,6 +150,7 @@
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
+	inode->i_op = &devpts_file_inode_operations;
 
 	dentry = get_node(number);
 	if (!IS_ERR(dentry) && !dentry->d_inode)
@@ -167,7 +176,10 @@
 
 static int __init init_devpts_fs(void)
 {
-	int err = register_filesystem(&devpts_fs_type);
+	int err = init_devpts_xattr();
+	if (err)
+		return err;
+	err = register_filesystem(&devpts_fs_type);
 	if (!err) {
 		devpts_mnt = kern_mount(&devpts_fs_type);
 		err = PTR_ERR(devpts_mnt);
@@ -181,6 +193,7 @@
 {
 	unregister_filesystem(&devpts_fs_type);
 	mntput(devpts_mnt);
+	exit_devpts_xattr();
 }
 
 module_init(init_devpts_fs)
diff -Nru a/fs/devpts/xattr.c b/fs/devpts/xattr.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/devpts/xattr.c	Thu May 15 09:29:23 2003
@@ -0,0 +1,214 @@
+/*
+  File: fs/devpts/xattr.c
+ 
+  Derived from fs/ext3/xattr.c, changed in the following ways:
+      drop everything related to persistent storage of EAs
+      pass dentry rather than inode to internal methods
+      only presently define a handler for security modules
+*/
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <asm/semaphore.h>
+#include "xattr.h"
+
+static struct devpts_xattr_handler *devpts_xattr_handlers[DEVPTS_XATTR_INDEX_MAX];
+static rwlock_t devpts_handler_lock = RW_LOCK_UNLOCKED;
+
+int
+devpts_xattr_register(int name_index, struct devpts_xattr_handler *handler)
+{
+	int error = -EINVAL;
+
+	if (name_index > 0 && name_index <= DEVPTS_XATTR_INDEX_MAX) {
+		write_lock(&devpts_handler_lock);
+		if (!devpts_xattr_handlers[name_index-1]) {
+			devpts_xattr_handlers[name_index-1] = handler;
+			error = 0;
+		}
+		write_unlock(&devpts_handler_lock);
+	}
+	return error;
+}
+
+void
+devpts_xattr_unregister(int name_index, struct devpts_xattr_handler *handler)
+{
+	if (name_index > 0 || name_index <= DEVPTS_XATTR_INDEX_MAX) {
+		write_lock(&devpts_handler_lock);
+		devpts_xattr_handlers[name_index-1] = NULL;
+		write_unlock(&devpts_handler_lock);
+	}
+}
+
+static inline const char *
+strcmp_prefix(const char *a, const char *a_prefix)
+{
+	while (*a_prefix && *a == *a_prefix) {
+		a++;
+		a_prefix++;
+	}
+	return *a_prefix ? NULL : a;
+}
+
+/*
+ * Decode the extended attribute name, and translate it into
+ * the name_index and name suffix.
+ */
+static inline struct devpts_xattr_handler *
+devpts_xattr_resolve_name(const char **name)
+{
+	struct devpts_xattr_handler *handler = NULL;
+	int i;
+
+	if (!*name)
+		return NULL;
+	read_lock(&devpts_handler_lock);
+	for (i=0; i<DEVPTS_XATTR_INDEX_MAX; i++) {
+		if (devpts_xattr_handlers[i]) {
+			const char *n = strcmp_prefix(*name,
+				devpts_xattr_handlers[i]->prefix);
+			if (n) {
+				handler = devpts_xattr_handlers[i];
+				*name = n;
+				break;
+			}
+		}
+	}
+	read_unlock(&devpts_handler_lock);
+	return handler;
+}
+
+static inline struct devpts_xattr_handler *
+devpts_xattr_handler(int name_index)
+{
+	struct devpts_xattr_handler *handler = NULL;
+	if (name_index > 0 && name_index <= DEVPTS_XATTR_INDEX_MAX) {
+		read_lock(&devpts_handler_lock);
+		handler = devpts_xattr_handlers[name_index-1];
+		read_unlock(&devpts_handler_lock);
+	}
+	return handler;
+}
+
+/*
+ * Inode operation getxattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+ssize_t
+devpts_getxattr(struct dentry *dentry, const char *name,
+	      void *buffer, size_t size)
+{
+	struct devpts_xattr_handler *handler;
+
+	handler = devpts_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->get(dentry, name, buffer, size);
+}
+
+/*
+ * Inode operation listxattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+ssize_t
+devpts_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
+{
+	struct devpts_xattr_handler *handler = NULL;
+	int i, error = 0;
+	unsigned int size = 0;
+	char *buf;
+
+	read_lock(&devpts_handler_lock);
+
+	for (i=0; i<DEVPTS_XATTR_INDEX_MAX; i++) {
+		handler = devpts_xattr_handlers[i];
+		if (handler)
+			size += handler->list(dentry, NULL);
+	}
+
+	if (!buffer) {
+		error = size;
+		goto out;
+	} else {
+		error = -ERANGE;
+		if (size > buffer_size)
+			goto out;
+	}
+
+	buf = buffer;
+	for (i=0; i<DEVPTS_XATTR_INDEX_MAX; i++) {
+		handler = devpts_xattr_handlers[i];
+		if (handler)
+			buf += handler->list(dentry, buf);
+	}
+	error = size;
+
+out:
+	read_unlock(&devpts_handler_lock);
+	return size;
+}
+
+/*
+ * Inode operation setxattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+int
+devpts_setxattr(struct dentry *dentry, const char *name,
+	      const void *value, size_t size, int flags)
+{
+	struct devpts_xattr_handler *handler;
+
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+	handler = devpts_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(dentry, name, value, size, flags);
+}
+
+/*
+ * Inode operation removexattr()
+ *
+ * dentry->d_inode->i_sem down
+ */
+int
+devpts_removexattr(struct dentry *dentry, const char *name)
+{
+	struct devpts_xattr_handler *handler;
+
+	handler = devpts_xattr_resolve_name(&name);
+	if (!handler)
+		return -EOPNOTSUPP;
+	return handler->set(dentry, name, NULL, 0, XATTR_REPLACE);
+}
+
+int __init
+init_devpts_xattr(void)
+{
+#ifdef CONFIG_DEVPTS_FS_SECURITY	
+	int	err;
+
+	err = devpts_xattr_register(DEVPTS_XATTR_INDEX_SECURITY,
+				    &devpts_xattr_security_handler);
+	if (err)
+		return err;
+#endif
+
+	return 0;
+}
+
+void
+exit_devpts_xattr(void)
+{
+#ifdef CONFIG_DEVPTS_FS_SECURITY	
+	devpts_xattr_unregister(DEVPTS_XATTR_INDEX_SECURITY,
+				&devpts_xattr_security_handler);
+#endif
+
+}
diff -Nru a/fs/devpts/xattr.h b/fs/devpts/xattr.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/devpts/xattr.h	Thu May 15 09:29:23 2003
@@ -0,0 +1,59 @@
+/*
+  File: fs/devpts/xattr.h
+ 
+  Derived from fs/ext3/xattr.h, changed in the following ways:
+      drop everything related to persistent storage of EAs
+      pass dentry rather than inode to internal methods
+      only presently define a handler for security modules
+*/
+
+#include <linux/config.h>
+#include <linux/xattr.h>
+
+/* Name indexes */
+#define DEVPTS_XATTR_INDEX_MAX			10
+#define DEVPTS_XATTR_INDEX_SECURITY	        1
+
+# ifdef CONFIG_DEVPTS_FS_XATTR
+
+struct devpts_xattr_handler {
+	char *prefix;
+	size_t (*list)(struct dentry *dentry, char *buffer);
+	int (*get)(struct dentry *dentry, const char *name, void *buffer,
+		   size_t size);
+	int (*set)(struct dentry *dentry, const char *name, const void *buffer,
+		   size_t size, int flags);
+};
+
+extern int devpts_xattr_register(int, struct devpts_xattr_handler *);
+extern void devpts_xattr_unregister(int, struct devpts_xattr_handler *);
+
+extern int devpts_setxattr(struct dentry *, const char *, const void *, size_t, int);
+extern ssize_t devpts_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t devpts_listxattr(struct dentry *, char *, size_t);
+extern int devpts_removexattr(struct dentry *, const char *);
+
+extern int init_devpts_xattr(void);
+extern void exit_devpts_xattr(void);
+
+# else  /* CONFIG_DEVPTS_FS_XATTR */
+#  define devpts_setxattr		NULL
+#  define devpts_getxattr		NULL
+#  define devpts_listxattr	NULL
+#  define devpts_removexattr	NULL
+
+static inline int
+init_devpts_xattr(void)
+{
+	return 0;
+}
+
+static inline void
+exit_devpts_xattr(void)
+{
+}
+
+# endif  /* CONFIG_DEVPTS_FS_XATTR */
+
+extern struct devpts_xattr_handler devpts_xattr_security_handler;
+
diff -Nru a/fs/devpts/xattr_security.c b/fs/devpts/xattr_security.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/devpts/xattr_security.c	Thu May 15 09:29:23 2003
@@ -0,0 +1,42 @@
+/*
+ * File: fs/devpts/xattr_security.c
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+#include "xattr.h"
+
+#define XATTR_SECURITY_PREFIX "security."
+
+static size_t
+devpts_xattr_security_list(struct dentry *dentry, char *buffer)
+{
+	return security_inode_listsecurity(dentry, buffer);
+}
+
+static int
+devpts_xattr_security_get(struct dentry *dentry, const char *name,
+			  void *buffer, size_t size)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_getsecurity(dentry, name, buffer, size);
+}
+
+static int
+devpts_xattr_security_set(struct dentry *dentry, const char *name,
+			  const void *value, size_t size, int flags)
+{
+	if (strcmp(name, "") == 0)
+		return -EINVAL;
+	return security_inode_setsecurity(dentry, name, value, size, flags);
+}
+
+struct devpts_xattr_handler devpts_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.list	= devpts_xattr_security_list,
+	.get	= devpts_xattr_security_get,
+	.set	= devpts_xattr_security_set,
+};


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

