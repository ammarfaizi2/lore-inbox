Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUJVTiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUJVTiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUJVTg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:36:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42926 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267304AbUJVTey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:34:54 -0400
Date: Fri, 22 Oct 2004 21:34:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
In-Reply-To: <20041022110846.GA17866@infradead.org>
Message-ID: <Pine.LNX.4.61.0410222124240.17266@scrub.home>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022103910.GB17526@infradead.org>
 <20041022035400.28131d76.akpm@osdl.org> <20041022110846.GA17866@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Oct 2004, Christoph Hellwig wrote:

> > > > +hfs-export-type-creator-via-xattr.patch
> > > 
> > > I haven't heard an answer on the comments on this on on -fsdevel yet..
> > 
> > To use the generic xattr code?  Yes, we're waiting to hear back on that.
> 
> I'm more concerned about the lacking xattr name prefix as that's a
> published API.

Below I only added the prefix. The generic code doesn't seem to have that 
many advantages if you have only a single prefix anyway, does it?
Andrew, below is the replacement for hfs-export-type-creator-via-xattr.patch

bye, Roman



This exports the hfs type/creator info via xattr.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Index: linux-2.6-hfs/fs/hfs/inode.c
===================================================================
--- linux-2.6-hfs.orig/fs/hfs/inode.c	2004-10-21 01:01:11.000000000 +0200
+++ linux-2.6-hfs/fs/hfs/inode.c	2004-10-22 20:26:58.000000000 +0200
@@ -627,4 +627,7 @@ struct inode_operations hfs_file_inode_o
 	.truncate	= hfs_file_truncate,
 	.setattr	= hfs_inode_setattr,
 	.permission	= hfs_permission,
+	.setxattr	= hfs_setxattr,
+	.getxattr	= hfs_getxattr,
+	.listxattr	= hfs_listxattr,
 };
Index: linux-2.6-hfs/fs/hfs/hfs_fs.h
===================================================================
--- linux-2.6-hfs.orig/fs/hfs/hfs_fs.h	2004-10-21 01:01:11.000000000 +0200
+++ linux-2.6-hfs/fs/hfs/hfs_fs.h	2004-10-21 01:01:11.000000000 +0200
@@ -207,6 +207,13 @@ extern struct inode *hfs_iget(struct sup
 extern void hfs_clear_inode(struct inode *);
 extern void hfs_delete_inode(struct inode *);
 
+/* attr.c */
+extern int hfs_setxattr(struct dentry *dentry, const char *name,
+			const void *value, size_t size, int flags);
+extern ssize_t hfs_getxattr(struct dentry *dentry, const char *name,
+			    void *value, size_t size);
+extern ssize_t hfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
+
 /* mdb.c */
 extern int hfs_mdb_get(struct super_block *);
 extern void hfs_mdb_commit(struct super_block *);
Index: linux-2.6-hfs/fs/hfs/attr.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-hfs/fs/hfs/attr.c	2004-10-22 20:19:39.000000000 +0200
@@ -0,0 +1,121 @@
+/*
+ *  linux/fs/hfs/attr.c
+ *
+ * (C) 2003 Ardis Technologies <roman@ardistech.com>
+ *
+ * Export hfs data via xattr
+ */
+
+
+#include <linux/fs.h>
+#include <linux/xattr.h>
+
+#include "hfs_fs.h"
+#include "btree.h"
+
+int hfs_setxattr(struct dentry *dentry, const char *name,
+		 const void *value, size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct hfs_find_data fd;
+	hfs_cat_rec rec;
+	struct hfs_cat_file *file;
+	int res;
+
+	if (!S_ISREG(inode->i_mode) || HFS_IS_RSRC(inode))
+		return -EOPNOTSUPP;
+
+	res = hfs_find_init(HFS_SB(inode->i_sb)->cat_tree, &fd);
+	if (res)
+		return res;
+	fd.search_key->cat = HFS_I(inode)->cat_key;
+	res = hfs_brec_find(&fd);
+	if (res)
+		goto out;
+	hfs_bnode_read(fd.bnode, &rec, fd.entryoffset,
+			sizeof(struct hfs_cat_file));
+	file = &rec.file;
+
+	if (!strcmp(name, "hfs.type")) {
+		if (size == 4)
+			memcpy(&file->UsrWds.fdType, value, 4);
+		else
+			res = -ERANGE;
+	} else if (!strcmp(name, "hfs.creator")) {
+		if (size == 4)
+			memcpy(&file->UsrWds.fdCreator, value, 4);
+		else
+			res = -ERANGE;
+	} else
+		res = -EOPNOTSUPP;
+	if (!res)
+		hfs_bnode_write(fd.bnode, &rec, fd.entryoffset,
+				sizeof(struct hfs_cat_file));
+out:
+	hfs_find_exit(&fd);
+	return res;
+}
+
+ssize_t hfs_getxattr(struct dentry *dentry, const char *name,
+			 void *value, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct hfs_find_data fd;
+	hfs_cat_rec rec;
+	struct hfs_cat_file *file;
+	ssize_t res = 0;
+
+	if (!S_ISREG(inode->i_mode) || HFS_IS_RSRC(inode))
+		return -EOPNOTSUPP;
+
+	if (size) {
+		res = hfs_find_init(HFS_SB(inode->i_sb)->cat_tree, &fd);
+		if (res)
+			return res;
+		fd.search_key->cat = HFS_I(inode)->cat_key;
+		res = hfs_brec_find(&fd);
+		if (res)
+			goto out;
+		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset,
+				sizeof(struct hfs_cat_file));
+	}
+	file = &rec.file;
+
+	if (!strcmp(name, "hfs.type")) {
+		if (size >= 4) {
+			memcpy(value, &file->UsrWds.fdType, 4);
+			res = 4;
+		} else
+			res = size ? -ERANGE : 4;
+	} else if (!strcmp(name, "hfs.creator")) {
+		if (size >= 4) {
+			memcpy(value, &file->UsrWds.fdCreator, 4);
+			res = 4;
+		} else
+			res = size ? -ERANGE : 4;
+	} else
+		res = -ENODATA;
+out:
+	if (size)
+		hfs_find_exit(&fd);
+	return res;
+}
+
+#define HFS_ATTRLIST_SIZE (sizeof("hfs.creator")+sizeof("hfs.type"))
+
+ssize_t hfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+
+	if (!S_ISREG(inode->i_mode) || HFS_IS_RSRC(inode))
+		return -EOPNOTSUPP;
+
+	if (!buffer || !size)
+		return HFS_ATTRLIST_SIZE;
+	if (size < HFS_ATTRLIST_SIZE)
+		return -ERANGE;
+	strcpy(buffer, "hfs.type");
+	strcpy(buffer + sizeof("hfs.type"), "hfs.creator");
+
+	return HFS_ATTRLIST_SIZE;
+}
Index: linux-2.6-hfs/fs/hfsplus/ioctl.c
===================================================================
--- linux-2.6-hfs.orig/fs/hfsplus/ioctl.c	2004-06-16 20:26:38.000000000 +0200
+++ linux-2.6-hfs/fs/hfsplus/ioctl.c	2004-10-22 20:22:17.000000000 +0200
@@ -14,6 +14,7 @@
 
 #include <linux/fs.h>
 #include <linux/sched.h>
+#include <linux/xattr.h>
 #include <asm/uaccess.h>
 #include "hfsplus_fs.h"
 
@@ -80,3 +81,108 @@ int hfsplus_ioctl(struct inode *inode, s
 		return -ENOTTY;
 	}
 }
+
+int hfsplus_setxattr(struct dentry *dentry, const char *name,
+		     const void *value, size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct hfs_find_data fd;
+	hfsplus_cat_entry entry;
+	struct hfsplus_cat_file *file;
+	int res;
+
+	if (!S_ISREG(inode->i_mode) || HFSPLUS_IS_RSRC(inode))
+		return -EOPNOTSUPP;
+
+	res = hfs_find_init(HFSPLUS_SB(inode->i_sb).cat_tree, &fd);
+	if (res)
+		return res;
+	res = hfsplus_find_cat(inode->i_sb, inode->i_ino, &fd);
+	if (res)
+		goto out;
+	hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
+			sizeof(struct hfsplus_cat_file));
+	file = &entry.file;
+
+	if (!strcmp(name, "hfs.type")) {
+		if (size == 4)
+			memcpy(&file->user_info.fdType, value, 4);
+		else
+			res = -ERANGE;
+	} else if (!strcmp(name, "hfs.creator")) {
+		if (size == 4)
+			memcpy(&file->user_info.fdCreator, value, 4);
+		else
+			res = -ERANGE;
+	} else
+		res = -EOPNOTSUPP;
+	if (!res)
+		hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
+				sizeof(struct hfsplus_cat_file));
+out:
+	hfs_find_exit(&fd);
+	return res;
+}
+
+ssize_t hfsplus_getxattr(struct dentry *dentry, const char *name,
+			 void *value, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct hfs_find_data fd;
+	hfsplus_cat_entry entry;
+	struct hfsplus_cat_file *file;
+	ssize_t res = 0;
+
+	if (!S_ISREG(inode->i_mode) || HFSPLUS_IS_RSRC(inode))
+		return -EOPNOTSUPP;
+
+	if (size) {
+		res = hfs_find_init(HFSPLUS_SB(inode->i_sb).cat_tree, &fd);
+		if (res)
+			return res;
+		res = hfsplus_find_cat(inode->i_sb, inode->i_ino, &fd);
+		if (res)
+			goto out;
+		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
+				sizeof(struct hfsplus_cat_file));
+	}
+	file = &entry.file;
+
+	if (!strcmp(name, "hfs.type")) {
+		if (size >= 4) {
+			memcpy(value, &file->user_info.fdType, 4);
+			res = 4;
+		} else
+			res = size ? -ERANGE : 4;
+	} else if (!strcmp(name, "hfs.creator")) {
+		if (size >= 4) {
+			memcpy(value, &file->user_info.fdCreator, 4);
+			res = 4;
+		} else
+			res = size ? -ERANGE : 4;
+	} else
+		res = -ENODATA;
+out:
+	if (size)
+		hfs_find_exit(&fd);
+	return res;
+}
+
+#define HFSPLUS_ATTRLIST_SIZE (sizeof("hfs.creator")+sizeof("hfs.type"))
+
+ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+
+	if (!S_ISREG(inode->i_mode) || HFSPLUS_IS_RSRC(inode))
+		return -EOPNOTSUPP;
+
+	if (!buffer || !size)
+		return HFSPLUS_ATTRLIST_SIZE;
+	if (size < HFSPLUS_ATTRLIST_SIZE)
+		return -ERANGE;
+	strcpy(buffer, "hfs.type");
+	strcpy(buffer + sizeof("hfs.type"), "hfs.creator");
+
+	return HFSPLUS_ATTRLIST_SIZE;
+}
Index: linux-2.6-hfs/fs/hfsplus/hfsplus_fs.h
===================================================================
--- linux-2.6-hfs.orig/fs/hfsplus/hfsplus_fs.h	2004-10-21 01:01:11.000000000 +0200
+++ linux-2.6-hfs/fs/hfsplus/hfsplus_fs.h	2004-10-21 01:01:11.000000000 +0200
@@ -341,6 +341,11 @@ void hfsplus_delete_inode(struct inode *
 /* ioctl.c */
 int hfsplus_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
 		  unsigned long arg);
+int hfsplus_setxattr(struct dentry *dentry, const char *name,
+		     const void *value, size_t size, int flags);
+ssize_t hfsplus_getxattr(struct dentry *dentry, const char *name,
+			 void *value, size_t size);
+ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size);
 
 /* options.c */
 int parse_options(char *, struct hfsplus_sb_info *);
Index: linux-2.6-hfs/fs/hfsplus/inode.c
===================================================================
--- linux-2.6-hfs.orig/fs/hfsplus/inode.c	2004-10-21 01:01:11.000000000 +0200
+++ linux-2.6-hfs/fs/hfsplus/inode.c	2004-10-21 01:01:11.000000000 +0200
@@ -301,6 +301,9 @@ struct inode_operations hfsplus_file_ino
 	.lookup		= hfsplus_file_lookup,
 	.truncate	= hfsplus_file_truncate,
 	.permission	= hfsplus_permission,
+	.setxattr	= hfsplus_setxattr,
+	.getxattr	= hfsplus_getxattr,
+	.listxattr	= hfsplus_listxattr,
 };
 
 struct file_operations hfsplus_file_operations = {
Index: linux-2.6-hfs/fs/hfs/Makefile
===================================================================
--- linux-2.6-hfs.orig/fs/hfs/Makefile	2004-03-11 19:33:09.000000000 +0100
+++ linux-2.6-hfs/fs/hfs/Makefile	2004-10-21 01:01:11.000000000 +0200
@@ -5,6 +5,6 @@
 obj-$(CONFIG_HFS_FS) += hfs.o
 
 hfs-objs := bitmap.o bfind.o bnode.o brec.o btree.o \
-	    catalog.o dir.o extent.o inode.o mdb.o \
+	    catalog.o dir.o extent.o inode.o attr.o mdb.o \
             part_tbl.o string.o super.o sysdep.o trans.o
 
