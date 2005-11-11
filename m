Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVKKQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVKKQqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVKKQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:46:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49389 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750870AbVKKQqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:46:48 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.51921.762490.884264@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:46:09 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 1/12] relayfs: decouple buffer creation from inode creation
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate buffer create/destroy from inode create/destroy.  We want to
be able to associate other data and not just relay buffers with
inodes.  Buffer create/destroy is moved out of inode.c and into
relayfs core code.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 buffers.c |    1 +
 inode.c   |   31 +++++++++----------------------
 relay.c   |   11 ++++++++---
 relay.h   |    2 +-
 4 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/relayfs/buffers.c b/fs/relayfs/buffers.c
--- a/fs/relayfs/buffers.c
+++ b/fs/relayfs/buffers.c
@@ -186,4 +186,5 @@ void relay_remove_buf(struct kref *kref)
 {
 	struct rchan_buf *buf = container_of(kref, struct rchan_buf, kref);
 	relayfs_remove(buf->dentry);
+	relay_destroy_buf(buf);
 }
diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -34,23 +34,13 @@ static struct backing_dev_info		relayfs_
 };
 
 static struct inode *relayfs_get_inode(struct super_block *sb, int mode,
-				       struct rchan *chan)
+				       void *data)
 {
-	struct rchan_buf *buf = NULL;
 	struct inode *inode;
 
-	if (S_ISREG(mode)) {
-		BUG_ON(!chan);
-		buf = relay_create_buf(chan);
-		if (!buf)
-			return NULL;
-	}
-
 	inode = new_inode(sb);
-	if (!inode) {
-		relay_destroy_buf(buf);
+	if (!inode)
 		return NULL;
-	}
 
 	inode->i_mode = mode;
 	inode->i_uid = 0;
@@ -62,7 +52,7 @@ static struct inode *relayfs_get_inode(s
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_fop = &relayfs_file_operations;
-		RELAYFS_I(inode)->buf = buf;
+		RELAYFS_I(inode)->buf = data;
 		break;
 	case S_IFDIR:
 		inode->i_op = &simple_dir_inode_operations;
@@ -83,7 +73,7 @@ static struct inode *relayfs_get_inode(s
  *	@name: the name of the file to create
  *	@parent: parent directory
  *	@mode: mode
- *	@chan: relay channel associated with the file
+ *	@data: user-associated data for this file
  *
  *	Returns the new dentry, NULL on failure
  *
@@ -92,7 +82,7 @@ static struct inode *relayfs_get_inode(s
 static struct dentry *relayfs_create_entry(const char *name,
 					   struct dentry *parent,
 					   int mode,
-					   struct rchan *chan)
+					   void *data)
 {
 	struct dentry *d;
 	struct inode *inode;
@@ -127,7 +117,7 @@ static struct dentry *relayfs_create_ent
 		goto release_mount;
 	}
 
-	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, chan);
+	inode = relayfs_get_inode(parent->d_inode->i_sb, mode, data);
 	if (!inode) {
 		d = NULL;
 		goto release_mount;
@@ -155,20 +145,20 @@ exit:
  *	@name: the name of the file to create
  *	@parent: parent directory
  *	@mode: mode, if not specied the default perms are used
- *	@chan: channel associated with the file
+ *	@data: user-associated data for this file
  *
  *	Returns file dentry if successful, NULL otherwise.
  *
  *	The file will be created user r on behalf of current user.
  */
 struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
-				   int mode, struct rchan *chan)
+				   int mode, void *data)
 {
 	if (!mode)
 		mode = S_IRUSR;
 	mode = (mode & S_IALLUGO) | S_IFREG;
 
-	return relayfs_create_entry(name, parent, mode, chan);
+	return relayfs_create_entry(name, parent, mode, data);
 }
 
 /**
@@ -505,9 +495,6 @@ static struct inode *relayfs_alloc_inode
  */
 static void relayfs_destroy_inode(struct inode *inode)
 {
-	if (RELAYFS_I(inode)->buf)
-		relay_destroy_buf(RELAYFS_I(inode)->buf);
-
 	kmem_cache_free(relayfs_inode_cachep, RELAYFS_I(inode));
 }
 
diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -171,12 +171,17 @@ static struct rchan_buf *relay_open_buf(
 	struct rchan_buf *buf;
 	struct dentry *dentry;
 
+ 	buf = relay_create_buf(chan);
+ 	if (!buf)
+ 		return NULL;
+
 	/* Create file in fs */
-	dentry = relayfs_create_file(filename, parent, S_IRUSR, chan);
-	if (!dentry)
+	dentry = relayfs_create_file(filename, parent, S_IRUSR, buf);
+ 	if (!dentry) {
+ 		relay_destroy_buf(buf);
 		return NULL;
+ 	}
 
-	buf = RELAYFS_I(dentry->d_inode)->buf;
 	buf->dentry = dentry;
 	__relay_reset(buf, 1);
 
diff --git a/fs/relayfs/relay.h b/fs/relayfs/relay.h
--- a/fs/relayfs/relay.h
+++ b/fs/relayfs/relay.h
@@ -4,7 +4,7 @@
 struct dentry *relayfs_create_file(const char *name,
 				   struct dentry *parent,
 				   int mode,
-				   struct rchan *chan);
+				   void *data);
 extern int relayfs_remove(struct dentry *dentry);
 extern int relay_buf_empty(struct rchan_buf *buf);
 extern void relay_destroy_channel(struct kref *kref);


