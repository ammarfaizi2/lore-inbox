Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUKTXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUKTXmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUKTXjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:39:53 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:11404 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263220AbUKTXNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:13:18 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] Filesystem in Userspace
Message-Id: <E1CVePn-0007Rr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:13:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for exporting a FUSE filesystem through NFS.

The following export operations are defined:

 o get_dentry
 o encode_fh

Currently only inodes still in the cache are found.  This is adequate
for most applications.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:22.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:22.000000000 +0100
@@ -337,6 +337,67 @@ static struct inode *get_root_inode(stru
 	return fuse_iget(sb, 1, 0, &attr, 0);
 }
 
+static struct dentry *fuse_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long nodeid = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *entry;
+
+	if (nodeid == 0)
+		return ERR_PTR(-ESTALE);
+
+	inode = fuse_ilookup(sb, nodeid);
+	if (!inode || inode->i_generation != generation)
+		return ERR_PTR(-ESTALE);
+
+	entry = d_alloc_anon(inode);
+	if (!entry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return entry;
+}
+
+static int fuse_encode_fh(struct dentry *dentry, __u32 *fh, int *max_len,
+			  int connectable)
+{
+	struct inode *inode = dentry->d_inode;
+	struct fuse_inode *fi = INO_FI(inode);
+	int len = *max_len;
+	int type = 1;
+	
+	if (len < 2 || (connectable && len < 4))
+		return 255;
+
+	len = 2;
+	fh[0] = fi->nodeid;
+	fh[1] = inode->i_generation;
+	if (connectable && !S_ISDIR(inode->i_mode)) {
+		struct inode *parent;
+		struct fuse_inode *parent_fi;
+
+		spin_lock(&dentry->d_lock);
+		parent = dentry->d_parent->d_inode;
+		parent_fi = INO_FI(parent);
+		fh[2] = parent_fi->nodeid;
+		fh[3] = parent->i_generation;
+		spin_unlock(&dentry->d_lock);
+		len = 4;
+		type = 2;
+	}
+	*max_len = len;
+	return type;
+}
+
+
+static struct export_operations fuse_export_operations = {
+	.get_dentry	= fuse_get_dentry,
+	.encode_fh      = fuse_encode_fh,
+};
+
 static struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
 	.destroy_inode  = fuse_destroy_inode,
@@ -367,6 +428,7 @@ static int fuse_read_super(struct super_
 	sb->s_magic = FUSE_SUPER_MAGIC;
 	sb->s_op = &fuse_super_operations;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_export_op = &fuse_export_operations;
 
 	file = fget(d.fd);
 	if (!file)
