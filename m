Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVEEV0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVEEV0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEEV0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:26:13 -0400
Received: from verein.lst.de ([213.95.11.210]:5545 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261896AbVEEVZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:25:54 -0400
Date: Thu, 5 May 2005 23:25:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove duplicate get_dentry functions in various places
Message-ID: <20050505212549.GA16811@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

various filesystem drivers have grown a get_dentry() function that's
a duplicate of lookup_one_len, except that it doesn't take a maximum
length argument and doesn't check for \0 or / in the passed in filename.

Switch all these places to use lookup_one_len.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: drivers/usb/core/inode.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/drivers/usb/core/inode.c  (mode:100644 sha1:f9f9561c6bad3fa611e410af62aaffae92771335)
+++ uncommitted/drivers/usb/core/inode.c  (mode:100644)
@@ -453,17 +453,6 @@
 	return 0;
 }
 
-static struct dentry * get_dentry(struct dentry *parent, const char *name)
-{               
-	struct qstr qstr;
-
-	qstr.name = name;
-	qstr.len = strlen(name);
-	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
-}               
-
-
 /*
  * fs_create_by_name - create a file, given a name
  * @name:	name of file
@@ -496,7 +485,7 @@
 
 	*dentry = NULL;
 	down(&parent->d_inode->i_sem);
-	*dentry = get_dentry (parent, name);
+	*dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry)) {
 		if ((mode & S_IFMT) == S_IFDIR)
 			error = usbfs_mkdir (parent->d_inode, *dentry, mode);
Index: fs/debugfs/inode.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/fs/debugfs/inode.c  (mode:100644 sha1:b529786699e7025a4c3e5e654b8b2524c001430b)
+++ uncommitted/fs/debugfs/inode.c  (mode:100644)
@@ -110,16 +110,6 @@
 	return simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
 }
 
-static struct dentry * get_dentry(struct dentry *parent, const char *name)
-{               
-	struct qstr qstr;
-
-	qstr.name = name;
-	qstr.len = strlen(name);
-	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
-}               
-
 static struct super_block *debug_get_sb(struct file_system_type *fs_type,
 				        int flags, const char *dev_name,
 					void *data)
@@ -157,7 +147,7 @@
 
 	*dentry = NULL;
 	down(&parent->d_inode->i_sem);
-	*dentry = get_dentry (parent, name);
+	*dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry)) {
 		if ((mode & S_IFMT) == S_IFDIR)
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
Index: fs/sysfs/dir.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/fs/sysfs/dir.c  (mode:100644 sha1:fe198210bc2d53081c018ac064e433715010daba)
+++ uncommitted/fs/sysfs/dir.c  (mode:100644)
@@ -8,6 +8,7 @@
 #include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/kobject.h>
+#include <linux/namei.h>
 #include "sysfs.h"
 
 DECLARE_RWSEM(sysfs_rename_sem);
@@ -99,7 +100,7 @@
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
 	down(&p->d_inode->i_sem);
-	*d = sysfs_get_dentry(p,n);
+	*d = lookup_one_len(n, p, strlen(n));
 	if (!IS_ERR(*d)) {
 		error = sysfs_create(*d, mode, init_dir);
 		if (!error) {
@@ -309,7 +310,7 @@
 
 	down(&parent->d_inode->i_sem);
 
-	new_dentry = sysfs_get_dentry(parent, new_name);
+	new_dentry = lookup_one_len(new_name, parent, strlen(new_name));
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
 			error = kobject_set_name(kobj, "%s", new_name);
Index: fs/sysfs/file.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/fs/sysfs/file.c  (mode:100644 sha1:364208071e1747d155b3eb6521d364c30b53bcd5)
+++ uncommitted/fs/sysfs/file.c  (mode:100644)
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/dnotify.h>
 #include <linux/kobject.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -400,7 +401,7 @@
 	int res = -ENOENT;
 
 	down(&dir->d_inode->i_sem);
-	victim = sysfs_get_dentry(dir, attr->name);
+	victim = lookup_one_len(attr->name, dir, strlen(attr->name));
 	if (!IS_ERR(victim)) {
 		/* make sure dentry is really there */
 		if (victim->d_inode && 
@@ -443,7 +444,7 @@
 	int res = -ENOENT;
 
 	down(&dir->d_inode->i_sem);
-	victim = sysfs_get_dentry(dir, attr->name);
+	victim = lookup_one_len(attr->name, dir, strlen(attr->name));
 	if (!IS_ERR(victim)) {
 		if (victim->d_inode &&
 		    (victim->d_parent->d_inode == dir->d_inode)) {
Index: fs/sysfs/group.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/fs/sysfs/group.c  (mode:100644 sha1:f11ac5ea7021c4b325211b2f7e58b6e29fbbc60c)
+++ uncommitted/fs/sysfs/group.c  (mode:100644)
@@ -11,6 +11,7 @@
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/dcache.h>
+#include <linux/namei.h>
 #include <linux/err.h>
 #include "sysfs.h"
 
@@ -68,7 +69,8 @@
 	struct dentry * dir;
 
 	if (grp->name)
-		dir = sysfs_get_dentry(kobj->dentry,grp->name);
+		dir = lookup_one_len(grp->name, kobj->dentry,
+				strlen(grp->name));
 	else
 		dir = dget(kobj->dentry);
 
Index: fs/sysfs/inode.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/fs/sysfs/inode.c  (mode:100644 sha1:aff7b2dfa8eed3a4c4c76b81cfffd26f04344706)
+++ uncommitted/fs/sysfs/inode.c  (mode:100644)
@@ -76,16 +76,6 @@
 	return error;
 }
 
-struct dentry * sysfs_get_dentry(struct dentry * parent, const char * name)
-{
-	struct qstr qstr;
-
-	qstr.name = name;
-	qstr.len = strlen(name);
-	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
-}
-
 /*
  * Get the name for corresponding element represented by the given sysfs_dirent
  */
Index: fs/sysfs/sysfs.h
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/fs/sysfs/sysfs.h  (mode:100644 sha1:a8a24a0c0b3bd44b910e2e6fe52daa0a23e4855b)
+++ uncommitted/fs/sysfs/sysfs.h  (mode:100644)
@@ -7,7 +7,6 @@
 
 extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
 				umode_t, int);
-extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
Index: kernel/cpuset.c
===================================================================
--- 95866d31faa6db4ec786399296238344c7cfea0c/kernel/cpuset.c  (mode:100644 sha1:961d74044deb0b08f8ce237e4f86c700da5e768a)
+++ uncommitted/kernel/cpuset.c  (mode:100644)
@@ -229,13 +229,7 @@
 
 static struct dentry *cpuset_get_dentry(struct dentry *parent, const char *name)
 {
-	struct qstr qstr;
-	struct dentry *d;
-
-	qstr.name = name;
-	qstr.len = strlen(name);
-	qstr.hash = full_name_hash(name, qstr.len);
-	d = lookup_hash(&qstr, parent);
+	struct dentry *d = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(d))
 		d->d_op = &cpuset_dops;
 	return d;
