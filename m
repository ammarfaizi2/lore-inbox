Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbVKIVun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbVKIVun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030781AbVKIVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:50:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56805 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030499AbVKIVum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:50:42 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.28430.472991.124439@tut.ibm.com>
Date: Wed, 9 Nov 2005 15:50:06 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 1/4] relayfs: add support for non-relay files
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, the relayfs API only supports the creation of directories
(relayfs_create_dir()) and relay files (relay_open()).  This patch
adds support for non-relay files (relayfs_create_file()).
    
This is so relayfs applications can create 'control files' in relayfs
itself rather than in /proc or via a netlink channel, as is currently
done in the relay-app examples.  There were several comments that the
use of netlink in the example code was non-intuitive and in fact the
whole relay-app business was needlessly confusing.  Based on that
feedback, the example code has been completely converted over to
relayfs control files as supported by this patch, and have also been
made completely self-contained.  The converted examples can be found
here:
    
http://prdownloads.sourceforge.net/relayfs/relay-apps-0.9.tar.gz?download

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/inode.c         |   86 ++++++++++++++++++++++++++++++++++++---------
 fs/relayfs/relay.c         |    2 -
 fs/relayfs/relay.h         |    8 ++--
 include/linux/relayfs_fs.h |    6 +++
 4 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -33,14 +33,15 @@ static struct backing_dev_info		relayfs_
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
-static struct inode *relayfs_get_inode(struct super_block *sb, int mode,
-				       struct rchan *chan)
+static struct inode *relayfs_get_inode(struct super_block *sb,
+				       int mode,
+				       struct rchan *chan,
+				       struct file_operations *fops)
 {
 	struct rchan_buf *buf = NULL;
 	struct inode *inode;
 
-	if (S_ISREG(mode)) {
-		BUG_ON(!chan);
+	if (S_ISREG(mode) && chan) {
 		buf = relay_create_buf(chan);
 		if (!buf)
 			return NULL;
@@ -48,7 +49,8 @@ static struct inode *relayfs_get_inode(s
 
 	inode = new_inode(sb);
 	if (!inode) {
-		relay_destroy_buf(buf);
+		if (chan)
+			relay_destroy_buf(buf);
 		return NULL;
 	}
 
@@ -61,7 +63,7 @@ static struct inode *relayfs_get_inode(s
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	switch (mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_fop = &relayfs_file_operations;
+		inode->i_fop = fops;
 		RELAYFS_I(inode)->buf = buf;
 		break;
 	case S_IFDIR:
@@ -92,7 +94,8 @@ static struct inode *relayfs_get_inode(s
 static struct dentry *relayfs_create_entry(const char *name,
 					   struct dentry *parent,
 					   int mode,
-					   struct rchan *chan)
+					   struct rchan *chan,
+					   struct file_operations *fops)
 {
 	struct dentry *d;
 	struct inode *inode;
@@ -127,7 +130,7 @@ static struct dentry *relayfs_create_ent
 		goto release_mount;
 	}
 
-	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, chan);
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, chan, fops);
 	if (!inode) {
 		d = NULL;
 		goto release_mount;
@@ -151,24 +154,62 @@ exit:
 }
 
 /**
- *	relayfs_create_file - create a file in the relay filesystem
+ *	relayfs_create_file - create a file in relay filesystem
  *	@name: the name of the file to create
  *	@parent: parent directory
  *	@mode: mode, if not specied the default perms are used
- *	@chan: channel associated with the file
+ *	@fops: file operations to use for the file
+ *	@data: user-associated data for this file
  *
  *	Returns file dentry if successful, NULL otherwise.
  *
- *	The file will be created user r on behalf of current user.
+ *	The file will be created user r on behalf of current user if
+ *	mode is not specified.
+ *
  */
-struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
-				   int mode, struct rchan *chan)
+struct dentry *relayfs_create_file(const char *name,
+				   struct dentry *parent,
+				   int mode,
+				   struct file_operations *fops,
+				   void *data)
 {
+	struct dentry *d;
+	BUG_ON(!fops);
+
 	if (!mode)
 		mode = S_IRUSR;
 	mode = (mode & S_IALLUGO) | S_IFREG;
 
-	return relayfs_create_entry(name, parent, mode, chan);
+	d = relayfs_create_entry(name, parent, mode, NULL, fops);
+	if (d)
+		d->d_inode->u.generic_ip = data;
+	
+	return d;
+}
+
+/**
+ *	relayfs_create_relay_file - create a relay file in the relay filesystem
+ *	@name: the name of the file to create
+ *	@parent: parent directory
+ *	@mode: mode, if not specied the default perms are used
+ *	@chan: channel associated with the file
+ *
+ *	Returns file dentry if successful, NULL otherwise.
+ *
+ *	The file will be created user r on behalf of current user if
+ *	mode is not specified.
+ */
+struct dentry *relayfs_create_relay_file(const char *name,
+					 struct dentry *parent,
+					 int mode,
+					 struct rchan *chan)
+{
+	if (!mode)
+		mode = S_IRUSR;
+	mode = (mode & S_IALLUGO) | S_IFREG;
+	
+	return relayfs_create_entry(name, parent, mode, chan,
+				    &relayfs_file_operations);
 }
 
 /**
@@ -183,7 +224,7 @@ struct dentry *relayfs_create_file(const
 struct dentry *relayfs_create_dir(const char *name, struct dentry *parent)
 {
 	int mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	return relayfs_create_entry(name, parent, mode, NULL);
+	return relayfs_create_entry(name, parent, mode, NULL, NULL);
 }
 
 /**
@@ -225,6 +266,17 @@ int relayfs_remove(struct dentry *dentry
 }
 
 /**
+ *	relayfs_remove_file - remove a file from relay filesystem
+ *	@dentry: directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
+ */
+int relayfs_remove_file(struct dentry *dentry)
+{
+	return relayfs_remove(dentry);
+}
+
+/**
  *	relayfs_remove_dir - remove a directory in the relay filesystem
  *	@dentry: directory dentry
  *
@@ -544,7 +596,7 @@ static int relayfs_fill_super(struct sup
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RELAYFS_MAGIC;
 	sb->s_op = &relayfs_ops;
-	inode = relayfs_get_inode(sb, mode, NULL);
+	inode = relayfs_get_inode(sb, mode, NULL, NULL);
 
 	if (!inode)
 		return -ENOMEM;
@@ -602,6 +654,8 @@ module_exit(exit_relayfs_fs)
 EXPORT_SYMBOL_GPL(relayfs_file_operations);
 EXPORT_SYMBOL_GPL(relayfs_create_dir);
 EXPORT_SYMBOL_GPL(relayfs_remove_dir);
+EXPORT_SYMBOL_GPL(relayfs_create_file);
+EXPORT_SYMBOL_GPL(relayfs_remove_file);
 
 MODULE_AUTHOR("Tom Zanussi <zanussi@us.ibm.com> and Karim Yaghmour <karim@opersys.com>");
 MODULE_DESCRIPTION("Relay Filesystem");
diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -172,7 +172,7 @@ static struct rchan_buf *relay_open_buf(
 	struct dentry *dentry;
 
 	/* Create file in fs */
-	dentry = relayfs_create_file(filename, parent, S_IRUSR, chan);
+	dentry = relayfs_create_relay_file(filename, parent, S_IRUSR, chan);
 	if (!dentry)
 		return NULL;
 
diff --git a/fs/relayfs/relay.h b/fs/relayfs/relay.h
--- a/fs/relayfs/relay.h
+++ b/fs/relayfs/relay.h
@@ -1,10 +1,10 @@
 #ifndef _RELAY_H
 #define _RELAY_H
 
-struct dentry *relayfs_create_file(const char *name,
-				   struct dentry *parent,
-				   int mode,
-				   struct rchan *chan);
+struct dentry *relayfs_create_relay_file(const char *name,
+					 struct dentry *parent,
+					 int mode,
+					 struct rchan *chan);
 extern int relayfs_remove(struct dentry *dentry);
 extern int relay_buf_empty(struct rchan_buf *buf);
 extern void relay_destroy_channel(struct kref *kref);
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -147,6 +147,12 @@ extern size_t relay_switch_subbuf(struct
 extern struct dentry *relayfs_create_dir(const char *name,
 					 struct dentry *parent);
 extern int relayfs_remove_dir(struct dentry *dentry);
+extern struct dentry *relayfs_create_file(const char *name,
+					  struct dentry *parent,
+					  int mode,
+					  struct file_operations *fops,
+					  void *data);
+extern int relayfs_remove_file(struct dentry *dentry);
 
 /**
  *	relay_write - write data into the channel


