Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVAKQze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVAKQze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVAKQxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:53:42 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:33664 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262830AbVAKQbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:31:53 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] FUSE - NFS export
Message-Id: <E1CoOvl-0003Ms-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:31:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for exporting a FUSE filesystem through NFS.

The following export operations are defined:

 o get_dentry
 o encode_fh

Currently only inodes still in the cache are found.  This is adequate
for most applications.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -Nurp a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
+++ b/fs/fuse/inode.c	2005-01-11 16:28:28.000000000 +0100
@@ -437,6 +437,63 @@ static struct inode *get_root_inode(stru
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
+	inode = ilookup5(sb, nodeid, fuse_inode_eq, &nodeid);
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
+	int len = *max_len;
+	int type = 1;
+
+	if (len < 2 || (connectable && len < 4))
+		return 255;
+
+	len = 2;
+	fh[0] = get_fuse_inode(inode)->nodeid;
+	fh[1] = inode->i_generation;
+	if (connectable && !S_ISDIR(inode->i_mode)) {
+		struct inode *parent;
+
+		spin_lock(&dentry->d_lock);
+		parent = dentry->d_parent->d_inode;
+		fh[2] = get_fuse_inode(parent)->nodeid;
+		fh[3] = parent->i_generation;
+		spin_unlock(&dentry->d_lock);
+		len = 4;
+		type = 2;
+	}
+	*max_len = len;
+	return type;
+}
+
+static struct export_operations fuse_export_operations = {
+	.get_dentry	= fuse_get_dentry,
+	.encode_fh      = fuse_encode_fh,
+};
+
 static struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
 	.destroy_inode  = fuse_destroy_inode,
@@ -479,6 +536,7 @@ static int fuse_fill_super(struct super_
 	sb->s_magic = FUSE_SUPER_MAGIC;
 	sb->s_op = &fuse_super_operations;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_export_op = &fuse_export_operations;
 
 	file = fget(d.fd);
 	if (!file)
