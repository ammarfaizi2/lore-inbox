Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbUKUAeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUKUAeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUKUAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:32:19 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:45072 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261639AbUKUANV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:13:21 -0500
Date: Sat, 20 Nov 2004 19:13:18 -0500
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH 2/5] selinux: adds a private inode operation
Message-ID: <20041121001318.GC979@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS implements extended attributes by backing them with regular files.
This means that selinux would create an infinite series of
xattrs-on-xattrs-on-xattrs etc. However, due to the locking of xattrs, this
series never happens. Instead, a locking loop occurs.

This patch allows SElinux to mark inodes as "private," such that SElinux
attributes aren't associated with them.

Original implementation by Stephen Smalley <sds@epoch.ncsc.mil>

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

diff -ruNpX dontdiff linux-2.6.9/include/linux/security.h linux-2.6.9.selinux/include/linux/security.h
--- linux-2.6.9/include/linux/security.h	2004-08-14 01:37:30.000000000 -0400
+++ linux-2.6.9.selinux/include/linux/security.h	2004-11-20 17:06:29.000000000 -0500
@@ -412,6 +412,11 @@ struct swap_info_struct;
  *	associated with @dentry into @buffer.  @buffer may be NULL to 
  *	request the size of the buffer required.  
  *	Returns number of bytes used/required on success.
+ * @inode_mark_private:
+ *      Set up the security state of @inode to reflect the fact that the inode
+ *	is private, i.e. used internally by the filesystem for purposes such
+ *	as xattr storage and not accessible by userspace.  This property should
+ *	then be inherited by all nodes under this node.
  *
  * Security hooks for file operations
  *
@@ -1111,6 +1116,7 @@ struct security_operations {
   	int (*inode_getsecurity)(struct dentry *dentry, const char *name, void *buffer, size_t size);
   	int (*inode_setsecurity)(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct dentry *dentry, char *buffer);
+  	void (*inode_mark_private)(struct inode *inode);
 
 	int (*file_permission) (struct file * file, int mask);
 	int (*file_alloc_security) (struct file * file);
@@ -1590,6 +1596,11 @@ static inline int security_inode_listsec
 	return security_ops->inode_listsecurity(dentry, buffer);
 }
 
+static inline void security_inode_mark_private(struct inode *inode)
+{
+	security_ops->inode_mark_private(inode);
+}
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return security_ops->file_permission (file, mask);
@@ -2229,6 +2240,9 @@ static inline int security_inode_listsec
 	return 0;
 }
 
+static inline void security_inode_mark_private(struct inode *inode)
+{ }
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return 0;
diff -ruNpX dontdiff linux-2.6.9/security/dummy.c linux-2.6.9.selinux/security/dummy.c
--- linux-2.6.9/security/dummy.c	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.selinux/security/dummy.c	2004-11-19 18:28:03.000000000 -0500
@@ -462,6 +462,11 @@ static int dummy_inode_listsecurity(stru
 	return 0;
 }
 
+static void dummy_inode_mark_private(struct inode *inode)
+{
+	return;
+}
+
 static int dummy_file_permission (struct file *file, int mask)
 {
 	return 0;
@@ -949,6 +954,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, inode_getsecurity);
 	set_to_dummy_if_null(ops, inode_setsecurity);
 	set_to_dummy_if_null(ops, inode_listsecurity);
+	set_to_dummy_if_null(ops, inode_mark_private);
 	set_to_dummy_if_null(ops, file_permission);
 	set_to_dummy_if_null(ops, file_alloc_security);
 	set_to_dummy_if_null(ops, file_free_security);
diff -ruNpX dontdiff linux-2.6.9/security/selinux/hooks.c linux-2.6.9.selinux/security/selinux/hooks.c
--- linux-2.6.9/security/selinux/hooks.c	2004-11-19 14:40:58.000000000 -0500
+++ linux-2.6.9.selinux/security/selinux/hooks.c	2004-11-20 17:11:22.000000000 -0500
@@ -740,6 +740,15 @@ static int inode_doinit_with_dentry(stru
 	if (isec->initialized)
 		goto out;
 
+	if (opt_dentry && opt_dentry->d_parent && opt_dentry->d_parent->d_inode) {
+		struct inode_security_struct *pisec = opt_dentry->d_parent->d_inode->i_security;
+		if (pisec->inherit) {
+			isec->sid = pisec->sid;
+			isec->initialized = 1;
+			goto out;
+		}
+	}
+
 	down(&isec->sem);
 	hold_sem = 1;
 	if (isec->initialized)
@@ -2391,6 +2400,15 @@ static int selinux_inode_listsecurity(st
 	return len;
 }
 
+static void selinux_inode_mark_private(struct inode *inode)
+{
+	struct inode_security_struct *isec = inode->i_security;
+
+	isec->sid = SECINITSID_KERNEL;
+	isec->initialized = 1;
+	isec->inherit = 1;
+}
+
 /* file security operations */
 
 static int selinux_file_permission(struct file *file, int mask)
@@ -4253,6 +4271,7 @@ struct security_operations selinux_ops =
 	.inode_getsecurity =            selinux_inode_getsecurity,
 	.inode_setsecurity =            selinux_inode_setsecurity,
 	.inode_listsecurity =           selinux_inode_listsecurity,
+	.inode_mark_private =           selinux_inode_mark_private,
 
 	.file_permission =		selinux_file_permission,
 	.file_alloc_security =		selinux_file_alloc_security,
-- 
Jeff Mahoney
SuSE Labs
