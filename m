Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUJPDlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUJPDlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 23:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUJPDlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 23:41:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15778 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268594AbUJPDkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 23:40:55 -0400
Date: Fri, 15 Oct 2004 23:40:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>,
       <amax@us.ibm.com>, <trond.myklebust@fys.uio.no>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add simple_alloc_dentry to libfs
Message-ID: <Xine.LNX.4.44.0410152332330.12321-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch consolidates several occurrences of duplicated code into a new 
libfs function simple_alloc_dentry().

Please review & apply if ok.

Signed-off-by: James Morris <jmorris@redhat.com>

 drivers/misc/ibmasm/ibmasmfs.c |   13 ++-----------
 drivers/oprofile/oprofilefs.c  |   14 ++++----------
 drivers/usb/gadget/inode.c     |    6 +-----
 fs/libfs.c                     |   17 ++++++++++++-----
 include/linux/fs.h             |    1 +
 net/sunrpc/rpc_pipe.c          |    6 +-----
 security/selinux/selinuxfs.c   |   17 +++--------------
 7 files changed, 24 insertions(+), 50 deletions(-)


diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/drivers/misc/ibmasm/ibmasmfs.c linux-2.6.9-rc4-mm1.f/drivers/misc/ibmasm/ibmasmfs.c
--- linux-2.6.9-rc4-mm1.o/drivers/misc/ibmasm/ibmasmfs.c	2004-10-15 00:05:42.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/drivers/misc/ibmasm/ibmasmfs.c	2004-10-15 23:11:57.800435680 -0400
@@ -173,13 +173,8 @@ static struct dentry *ibmasmfs_create_fi
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	struct qstr qname;
 
-	qname.name = name;
-	qname.len = strlen (name);
-	qname.hash = full_name_hash(name, qname.len);
-
-	dentry = d_alloc(parent, &qname);
+	dentry = simple_alloc_dentry(parent, name);
 	if (!dentry)
 		return NULL;
 
@@ -202,12 +197,8 @@ static struct dentry *ibmasmfs_create_di
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	struct qstr qname;
 
-	qname.name = name;
-	qname.len = strlen (name);
-	qname.hash = full_name_hash(name, qname.len);
-	dentry = d_alloc(parent, &qname);
+	dentry = simple_alloc_dentry(parent, name);
 	if (!dentry)
 		return NULL;
 
diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/drivers/oprofile/oprofilefs.c linux-2.6.9-rc4-mm1.f/drivers/oprofile/oprofilefs.c
--- linux-2.6.9-rc4-mm1.o/drivers/oprofile/oprofilefs.c	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/drivers/oprofile/oprofilefs.c	2004-10-15 23:11:57.800435680 -0400
@@ -135,11 +135,8 @@ static struct dentry * __oprofilefs_crea
 {
 	struct dentry * dentry;
 	struct inode * inode;
-	struct qstr qname;
-	qname.name = name;
-	qname.len = strlen(name);
-	qname.hash = full_name_hash(qname.name, qname.len);
-	dentry = d_alloc(root, &qname);
+
+	dentry = simple_alloc_dentry(root, name);
 	if (!dentry)
 		return NULL;
 	inode = oprofilefs_get_inode(sb, S_IFREG | perm);
@@ -228,11 +225,8 @@ struct dentry * oprofilefs_mkdir(struct 
 {
 	struct dentry * dentry;
 	struct inode * inode;
-	struct qstr qname;
-	qname.name = name;
-	qname.len = strlen(name);
-	qname.hash = full_name_hash(qname.name, qname.len);
-	dentry = d_alloc(root, &qname);
+
+	dentry = simple_alloc_dentry(root, name);
 	if (!dentry)
 		return NULL;
 	inode = oprofilefs_get_inode(sb, S_IFDIR | 0755);
diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/drivers/usb/gadget/inode.c linux-2.6.9-rc4-mm1.f/drivers/usb/gadget/inode.c
--- linux-2.6.9-rc4-mm1.o/drivers/usb/gadget/inode.c	2004-10-15 00:00:37.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/drivers/usb/gadget/inode.c	2004-10-15 23:11:57.802435376 -0400
@@ -1981,12 +1981,8 @@ gadgetfs_create_file (struct super_block
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
-	struct qstr	qname;
 
-	qname.name = name;
-	qname.len = strlen (name);
-	qname.hash = full_name_hash (qname.name, qname.len);
-	dentry = d_alloc (sb->s_root, &qname);
+	dentry = simple_alloc_dentry (sb->s_root, name);
 	if (!dentry)
 		return NULL;
 
diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/fs/libfs.c linux-2.6.9-rc4-mm1.f/fs/libfs.c
--- linux-2.6.9-rc4-mm1.o/fs/libfs.c	2004-10-15 00:00:39.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/fs/libfs.c	2004-10-15 23:11:57.803435224 -0400
@@ -362,6 +362,16 @@ int simple_commit_write(struct file *fil
 	return 0;
 }
 
+struct dentry *simple_alloc_dentry(struct dentry *parent, const char *name)
+{
+	struct qstr q;
+
+	q.name = name;
+	q.len = strlen(name);
+	q.hash = full_name_hash(q.name, q.len);
+	return d_alloc(parent, &q);
+}
+
 int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
 {
 	static struct super_operations s_ops = {.statfs = simple_statfs};
@@ -391,13 +401,9 @@ int simple_fill_super(struct super_block
 		return -ENOMEM;
 	}
 	for (i = 0; !files->name || files->name[0]; i++, files++) {
-		struct qstr name;
 		if (!files->name)
 			continue;
-		name.name = files->name;
-		name.len = strlen(name.name);
-		name.hash = full_name_hash(name.name, name.len);
-		dentry = d_alloc(root, &name);
+		dentry = simple_alloc_dentry(root, files->name);
 		if (!dentry)
 			goto out;
 		inode = new_inode(s);
@@ -530,6 +536,7 @@ EXPORT_SYMBOL(simple_commit_write);
 EXPORT_SYMBOL(simple_dir_inode_operations);
 EXPORT_SYMBOL(simple_dir_operations);
 EXPORT_SYMBOL(simple_empty);
+EXPORT_SYMBOL(simple_alloc_dentry);
 EXPORT_SYMBOL(simple_fill_super);
 EXPORT_SYMBOL(simple_getattr);
 EXPORT_SYMBOL(simple_link);
diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/include/linux/fs.h linux-2.6.9-rc4-mm1.f/include/linux/fs.h
--- linux-2.6.9-rc4-mm1.o/include/linux/fs.h	2004-10-15 00:05:45.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/include/linux/fs.h	2004-10-15 23:11:57.805434920 -0400
@@ -1642,6 +1642,7 @@ extern ssize_t generic_read_dir(struct f
 extern struct file_operations simple_dir_operations;
 extern struct inode_operations simple_dir_inode_operations;
 struct tree_descr { char *name; struct file_operations *ops; int mode; };
+struct dentry *simple_alloc_dentry(struct dentry *, const char *);
 extern int simple_fill_super(struct super_block *, int, struct tree_descr *);
 extern int simple_pin_fs(char *name, struct vfsmount **mount, int *count);
 extern void simple_release_fs(struct vfsmount **mount, int *count);
diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/net/sunrpc/rpc_pipe.c linux-2.6.9-rc4-mm1.f/net/sunrpc/rpc_pipe.c
--- linux-2.6.9-rc4-mm1.o/net/sunrpc/rpc_pipe.c	2004-08-14 01:36:44.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/net/sunrpc/rpc_pipe.c	2004-10-15 23:11:57.806434768 -0400
@@ -523,16 +523,12 @@ rpc_populate(struct dentry *parent,
 {
 	struct inode *inode, *dir = parent->d_inode;
 	void *private = RPC_I(dir)->private;
-	struct qstr name;
 	struct dentry *dentry;
 	int mode, i;
 
 	down(&dir->i_sem);
 	for (i = start; i < eof; i++) {
-		name.name = files[i].name;
-		name.len = strlen(name.name);
-		name.hash = full_name_hash(name.name, name.len);
-		dentry = d_alloc(parent, &name);
+		dentry = simple_alloc_dentry(parent, files[i].name);
 		if (!dentry)
 			goto out_bad;
 		mode = files[i].mode;
diff -purN -X dontdiff linux-2.6.9-rc4-mm1.o/security/selinux/selinuxfs.c linux-2.6.9-rc4-mm1.f/security/selinux/selinuxfs.c
--- linux-2.6.9-rc4-mm1.o/security/selinux/selinuxfs.c	2004-10-15 00:00:42.000000000 -0400
+++ linux-2.6.9-rc4-mm1.f/security/selinux/selinuxfs.c	2004-10-15 23:11:57.807434616 -0400
@@ -818,7 +818,6 @@ static int sel_make_bools(void)
 	struct dentry *dir = bool_dir;
 	struct inode *inode = NULL;
 	struct inode_security_struct *isec;
-	struct qstr qname;
 	char **names = NULL, *page;
 	int num;
 	int *values = NULL;
@@ -838,10 +837,7 @@ static int sel_make_bools(void)
 		goto out;
 
 	for (i = 0; i < num; i++) {
-		qname.name = names[i];
-		qname.len = strlen(qname.name);
-		qname.hash = full_name_hash(qname.name, qname.len);
-		dentry = d_alloc(dir, &qname);
+		dentry = simple_alloc_dentry(dir, names[i]);
 		if (!dentry) {
 			ret = -ENOMEM;
 			goto err;
@@ -896,7 +892,6 @@ static int sel_fill_super(struct super_b
 	int ret;
 	struct dentry *dentry;
 	struct inode *inode;
-	struct qstr qname;
 	struct inode_security_struct *isec;
 
 	static struct tree_descr selinux_files[] = {
@@ -917,10 +912,7 @@ static int sel_fill_super(struct super_b
 	if (ret)
 		return ret;
 
-	qname.name = BOOL_DIR_NAME;
-	qname.len = strlen(qname.name);
-	qname.hash = full_name_hash(qname.name, qname.len);
-	dentry = d_alloc(sb->s_root, &qname);
+	dentry = simple_alloc_dentry(sb->s_root, BOOL_DIR_NAME);
 	if (!dentry)
 		return -ENOMEM;
 
@@ -935,10 +927,7 @@ static int sel_fill_super(struct super_b
 	if (ret)
 		goto out;
 
-	qname.name = NULL_FILE_NAME;
-	qname.len = strlen(qname.name);
-	qname.hash = full_name_hash(qname.name, qname.len);
-	dentry = d_alloc(sb->s_root, &qname);
+	dentry = simple_alloc_dentry(sb->s_root, NULL_FILE_NAME);
 	if (!dentry)
 		return -ENOMEM;
 

