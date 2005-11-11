Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVKKQrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVKKQrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVKKQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:47:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:53659 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750880AbVKKQrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:47:39 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.51975.485344.880078@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:47:03 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 2/12] relayfs: export relayfs_create_file() with fileops param
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a mandatory fileops param to relayfs_create_file() and
exports that function so that clients can use it to create files
defined by their own set of file operations, in relayfs.  The purpose
is to allow relayfs applications to create their own set of 'control'
files alongside their relay files in relayfs rather than having to
create them in /proc or debugfs for instance.  relayfs_create_file()
is also used by relay_open_buf() to create the relay files for a
channel.  In this case, a pointer to relayfs_file_operations is passed
in, along with a pointer to the buffer associated with the file.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/inode.c         |   41 ++++++++++++++++++++++++++---------------
 fs/relayfs/relay.c         |    3 ++-
 fs/relayfs/relay.h         |    4 ----
 include/linux/relayfs_fs.h |    7 ++++++-
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -33,7 +33,9 @@ static struct backing_dev_info		relayfs_
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
-static struct inode *relayfs_get_inode(struct super_block *sb, int mode,
+static struct inode *relayfs_get_inode(struct super_block *sb,
+				       int mode,
+ 				       struct file_operations *fops,
 				       void *data)
 {
 	struct inode *inode;
@@ -51,8 +53,8 @@ static struct inode *relayfs_get_inode(s
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	switch (mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_fop = &relayfs_file_operations;
-		RELAYFS_I(inode)->buf = data;
+		inode->i_fop = fops;
+		RELAYFS_I(inode)->data = data;
 		break;
 	case S_IFDIR:
 		inode->i_op = &simple_dir_inode_operations;
@@ -73,6 +75,7 @@ static struct inode *relayfs_get_inode(s
  *	@name: the name of the file to create
  *	@parent: parent directory
  *	@mode: mode
+ *	@fops: file operations to use for the file
  *	@data: user-associated data for this file
  *
  *	Returns the new dentry, NULL on failure
@@ -82,6 +85,7 @@ static struct inode *relayfs_get_inode(s
 static struct dentry *relayfs_create_entry(const char *name,
 					   struct dentry *parent,
 					   int mode,
+					   struct file_operations *fops,
 					   void *data)
 {
 	struct dentry *d;
@@ -117,7 +121,7 @@ static struct dentry *relayfs_create_ent
 		goto release_mount;
 	}
 
-	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, data);
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, fops, data);
 	if (!inode) {
 		d = NULL;
 		goto release_mount;
@@ -145,20 +149,26 @@ exit:
  *	@name: the name of the file to create
  *	@parent: parent directory
  *	@mode: mode, if not specied the default perms are used
+ *	@fops: file operations to use for the file
  *	@data: user-associated data for this file
  *
  *	Returns file dentry if successful, NULL otherwise.
  *
  *	The file will be created user r on behalf of current user.
  */
-struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
-				   int mode, void *data)
+struct dentry *relayfs_create_file(const char *name,
+				   struct dentry *parent,
+				   int mode,
+				   struct file_operations *fops,
+				   void *data)
 {
+	BUG_ON(!fops);
+
 	if (!mode)
 		mode = S_IRUSR;
 	mode = (mode & S_IALLUGO) | S_IFREG;
 
-	return relayfs_create_entry(name, parent, mode, data);
+	return relayfs_create_entry(name, parent, mode, fops, data);
 }
 
 /**
@@ -173,7 +183,7 @@ struct dentry *relayfs_create_file(const
 struct dentry *relayfs_create_dir(const char *name, struct dentry *parent)
 {
 	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	return relayfs_create_entry(name, parent, mode, NULL);
+	return relayfs_create_entry(name, parent, mode, NULL, NULL);
 }
 
 /**
@@ -234,7 +244,7 @@ int relayfs_remove_dir(struct dentry *de
  */
 static int relayfs_open(struct inode *inode, struct file *filp)
 {
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = RELAYFS_I(inode)->data;
 	kref_get(&buf->kref);
 
 	return 0;
@@ -250,7 +260,7 @@ static int relayfs_open(struct inode *in
 static int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	return relay_mmap_buf(RELAYFS_I(inode)->buf, vma);
+	return relay_mmap_buf(RELAYFS_I(inode)->data, vma);
 }
 
 /**
@@ -264,7 +274,7 @@ static unsigned int relayfs_poll(struct 
 {
 	unsigned int mask = 0;
 	struct inode *inode = filp->f_dentry->d_inode;
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = RELAYFS_I(inode)->data;
 
 	if (buf->finalized)
 		return POLLERR;
@@ -288,7 +298,7 @@ static unsigned int relayfs_poll(struct 
  */
 static int relayfs_release(struct inode *inode, struct file *filp)
 {
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = RELAYFS_I(inode)->data;
 	kref_put(&buf->kref, relay_remove_buf);
 
 	return 0;
@@ -450,7 +460,7 @@ static ssize_t relayfs_read(struct file 
 			    loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
+	struct rchan_buf *buf = RELAYFS_I(inode)->data;
 	size_t read_start, avail;
 	ssize_t ret = 0;
 	void *from;
@@ -485,7 +495,7 @@ static struct inode *relayfs_alloc_inode
 	struct relayfs_inode_info *p = kmem_cache_alloc(relayfs_inode_cachep, SLAB_KERNEL);
 	if (!p)
 		return NULL;
-	p->buf = NULL;
+	p->data = NULL;
 
 	return &p->vfs_inode;
 }
@@ -531,7 +541,7 @@ static int relayfs_fill_super(struct sup
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RELAYFS_MAGIC;
 	sb->s_op = &relayfs_ops;
-	inode = relayfs_get_inode(sb, mode, NULL);
+	inode = relayfs_get_inode(sb, mode, NULL, NULL);
 
 	if (!inode)
 		return -ENOMEM;
@@ -589,6 +599,7 @@ module_exit(exit_relayfs_fs)
 EXPORT_SYMBOL_GPL(relayfs_file_operations);
 EXPORT_SYMBOL_GPL(relayfs_create_dir);
 EXPORT_SYMBOL_GPL(relayfs_remove_dir);
+EXPORT_SYMBOL_GPL(relayfs_create_file);
 
 MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
 MODULE_DESCRIPTION("Relay Filesystem");
diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -176,7 +176,8 @@ static struct rchan_buf *relay_open_buf(
  		return NULL;
 
 	/* Create file in fs */
-	dentry = relayfs_create_file(filename, parent, S_IRUSR, buf);
+	dentry = relayfs_create_file(filename, parent, S_IRUSR,
+				     &relayfs_file_operations, buf);
  	if (!dentry) {
  		relay_destroy_buf(buf);
 		return NULL;
diff --git a/fs/relayfs/relay.h b/fs/relayfs/relay.h
--- a/fs/relayfs/relay.h
+++ b/fs/relayfs/relay.h
@@ -1,10 +1,6 @@
 #ifndef _RELAY_H
 #define _RELAY_H
 
-struct dentry *relayfs_create_file(const char *name,
-				   struct dentry *parent,
-				   int mode,
-				   void *data);
 extern int relayfs_remove(struct dentry *dentry);
 extern int relay_buf_empty(struct rchan_buf *buf);
 extern void relay_destroy_channel(struct kref *kref);
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -69,7 +69,7 @@ struct rchan
 struct relayfs_inode_info
 {
 	struct inode vfs_inode;
-	struct rchan_buf *buf;
+	void *data;
 };
 
 static inline struct relayfs_inode_info *RELAYFS_I(struct inode *inode)
@@ -147,6 +147,11 @@ extern size_t relay_switch_subbuf(struct
 extern struct dentry *relayfs_create_dir(const char *name,
 					 struct dentry *parent);
 extern int relayfs_remove_dir(struct dentry *dentry);
+extern struct dentry *relayfs_create_file(const char *name,
+					  struct dentry *parent,
+					  int mode,
+					  struct file_operations *fops,
+					  void *data);
 
 /**
  *	relay_write - write data into the channel


