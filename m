Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWB0UXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWB0UXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWB0UXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:23:40 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:60871 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751515AbWB0UXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:23:37 -0500
Date: Mon, 27 Feb 2006 15:23:34 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] SELinux - fix hard link count for selinuxfs root directory
Message-ID: <Pine.LNX.4.64.0602271520190.21929@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A further fix is needed for selinuxfs link count management, to ensure 
that the count is correct for the parent directory when a subdirectory is 
created.  This is only required for the root directory currently, but the 
code has been updated for the general case.

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -purN -X dontdiff linux-2.6.16-rc4-mm2.o/security/selinux/selinuxfs.c linux-2.6.16-rc4-mm2.w/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4-mm2.o/security/selinux/selinuxfs.c	2006-02-25 00:29:32.000000000 -0500
+++ linux-2.6.16-rc4-mm2.w/security/selinux/selinuxfs.c	2006-02-25 12:35:26.000000000 -0500
@@ -1177,12 +1177,12 @@ out:
 	return ret;
 }
 
-static int sel_make_dir(struct super_block *sb, struct dentry *dentry)
+static int sel_make_dir(struct inode *dir, struct dentry *dentry)
 {
 	int ret = 0;
 	struct inode *inode;
 
-	inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = sel_make_inode(dir->i_sb, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode) {
 		ret = -ENOMEM;
 		goto out;
@@ -1192,6 +1192,8 @@ static int sel_make_dir(struct super_blo
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inode->i_nlink++;
 	d_add(dentry, inode);
+	/* bump link count on parent directory, too */
+	dir->i_nlink++;
 out:
 	return ret;
 }
@@ -1200,7 +1202,7 @@ static int sel_fill_super(struct super_b
 {
 	int ret;
 	struct dentry *dentry;
-	struct inode *inode;
+	struct inode *inode, *root_inode;
 	struct inode_security_struct *isec;
 
 	static struct tree_descr selinux_files[] = {
@@ -1223,13 +1225,15 @@ static int sel_fill_super(struct super_b
 	if (ret)
 		goto err;
 
+	root_inode = sb->s_root->d_inode;
+
 	dentry = d_alloc_name(sb->s_root, BOOL_DIR_NAME);
 	if (!dentry) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = sel_make_dir(sb, dentry);
+	ret = sel_make_dir(root_inode, dentry);
 	if (ret)
 		goto err;
 
@@ -1261,7 +1265,7 @@ static int sel_fill_super(struct super_b
 		goto err;
 	}
 
-	ret = sel_make_dir(sb, dentry);
+	ret = sel_make_dir(root_inode, dentry);
 	if (ret)
 		goto err;
 
