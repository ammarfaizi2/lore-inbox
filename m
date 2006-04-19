Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWDSRy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWDSRy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWDSRy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:54:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:1438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751073AbWDSRyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:54:50 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:50:26 -0700
Message-Id: <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new function d_path_flags which takes an additional flags
parameter.   Adding a new function rather than ammending the existing d_path
was done to avoid impact on the current users.

It is not essential for inclusion with AppArmor (the apparmor_mediation.patch
can easily be revised to use plain d_path) but it enables cleaner code 
["(delete)" handling] and closes a loophole with pathname generation for 
chrooted tasks. 

It currently adds two flags:

DPATH_SYSROOT:
	d_path should generate a path from the system root rather than the
	task's current root. 

	For AppArmor this enables generation of absolute pathnames in all
	cases.  Currently when a task is chrooted, file access is reported
	relative to the chroot.  Because it is currently not possible to 
	obtain the absolute path in an SMP safe way, without this patch 
	AppArmor will have to report chroot-relative pathnames.
	
DPATH_NODELETED:
	d_path should not append "(deleted)" to unhashed entries. Sometimes
	this information is not useful for the caller and the string can
	exist as the suffix of a valid pathname.

Signed-off-by: Tony Jones <tonyj@suse.de>

---
 fs/dcache.c            |   48 ++++++++++++++++++++++++++++++++----------------
 include/linux/dcache.h |    7 +++++++
 2 files changed, 39 insertions(+), 16 deletions(-)

--- linux-2.6.17-rc1.orig/fs/dcache.c
+++ linux-2.6.17-rc1/fs/dcache.c
@@ -1381,9 +1381,11 @@
  * @rootmnt: vfsmnt to which the root dentry belongs
  * @buffer: buffer to return value in
  * @buflen: buffer length
+ * @flags: control flags
  *
  * Convert a dentry into an ASCII path name. If the entry has been deleted
- * the string " (deleted)" is appended. Note that this is ambiguous.
+ * and DPATH_NODELETED is not specified in flags then the string " (deleted)"
+ * is appended. Note that this is ambiguous.
  *
  * Returns the buffer or an error code if the path was too long.
  *
@@ -1391,7 +1393,7 @@
  */
 static char * __d_path( struct dentry *dentry, struct vfsmount *vfsmnt,
 			struct dentry *root, struct vfsmount *rootmnt,
-			char *buffer, int buflen)
+			char *buffer, int buflen, unsigned int flags)
 {
 	char * end = buffer+buflen;
 	char * retval;
@@ -1399,7 +1401,8 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
+	if (!(flags & DPATH_NODELETED) &&
+	    !IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		if (buflen < 0)
@@ -1416,7 +1419,8 @@
 	for (;;) {
 		struct dentry * parent;
 
-		if (dentry == root && vfsmnt == rootmnt)
+		if (!(flags & DPATH_SYSROOT) &&
+		    dentry == root && vfsmnt == rootmnt)
 			break;
 		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
 			/* Global root? */
@@ -1458,25 +1462,36 @@
 }
 
 /* write full pathname into buffer and return start of pathname */
-char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
-				char *buf, int buflen)
+char * d_path_flags(struct dentry *dentry, struct vfsmount *vfsmnt,
+		    char *buf, int buflen, unsigned int flags)
 {
 	char *res;
-	struct vfsmount *rootmnt;
-	struct dentry *root;
+	struct vfsmount *rootmnt = NULL;
+	struct dentry *root = NULL;
 
-	read_lock(&current->fs->lock);
-	rootmnt = mntget(current->fs->rootmnt);
-	root = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
+	if (!(flags & DPATH_SYSROOT)){
+		read_lock(&current->fs->lock);
+		rootmnt = mntget(current->fs->rootmnt);
+		root = dget(current->fs->root);
+		read_unlock(&current->fs->lock);
+	}
 	spin_lock(&dcache_lock);
-	res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
+	res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen, flags);
 	spin_unlock(&dcache_lock);
-	dput(root);
-	mntput(rootmnt);
+	if (!(flags & DPATH_SYSROOT)){
+		dput(root);
+		mntput(rootmnt);
+	}
 	return res;
 }
 
+/* original d_path without support for flags */
+char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
+	      char *buf, int buflen)
+{
+	return d_path_flags(dentry, vfsmnt, buf, buflen, 0);
+}
+
 /*
  * NOTE! The user-level library version returns a
  * character pointer. The kernel system call just
@@ -1519,7 +1534,7 @@
 		unsigned long len;
 		char * cwd;
 
-		cwd = __d_path(pwd, pwdmnt, root, rootmnt, page, PAGE_SIZE);
+		cwd = __d_path(pwd, pwdmnt, root, rootmnt, page, PAGE_SIZE, 0);
 		spin_unlock(&dcache_lock);
 
 		error = PTR_ERR(cwd);
@@ -1771,6 +1786,7 @@
 EXPORT_SYMBOL(d_invalidate);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(d_move);
+EXPORT_SYMBOL(d_path_flags);
 EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(d_prune_aliases);
 EXPORT_SYMBOL(d_rehash);
--- linux-2.6.17-rc1.orig/include/linux/dcache.h
+++ linux-2.6.17-rc1/include/linux/dcache.h
@@ -164,6 +164,10 @@
 
 #define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
 
+/* dpath flags */
+#define DPATH_SYSROOT		0x0001	/* continue past fsroot (chroot) */
+#define DPATH_NODELETED		0x0002	/* do not append " (deleted)" */
+
 extern spinlock_t dcache_lock;
 
 /**
@@ -281,6 +285,9 @@
 extern int d_validate(struct dentry *, struct dentry *);
 
 extern char * d_path(struct dentry *, struct vfsmount *, char *, int);
+
+extern char * d_path_flags(struct dentry *, struct vfsmount *, char *, int,
+		     unsigned int);
   
 /* Allocation counts.. */
 
