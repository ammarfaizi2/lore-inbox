Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUGGNCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUGGNCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUGGNB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:01:28 -0400
Received: from linuxhacker.ru ([217.76.32.60]:5591 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265095AbUGGMtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:40 -0400
Date: Wed, 7 Jul 2004 15:47:32 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [4/9] Lustre VFS patches for 2.6
Message-ID: <20040707124732.GA25930@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce "parent lookup" inode operation that is called when LOOKUP_PARENT
flagged link_path_walk isw about to return. Fill in intents with necessary data
so that raw-ops aware filesystems can do some operations during initial
name lookup (target lookup for link and rename), in this case such filesystems
are responsible to call necessary security plugins and ensure that files they
operate on are not mountpoints.

 fs/namei.c            |   69 +++++++++++++++++++++++++++++++++++++++-----------
 include/linux/fs.h    |    1 
 include/linux/namei.h |   17 +++++++++++-
 3 files changed, 71 insertions(+), 16 deletions(-)

Index: linus-2.6.7-bk-latest/fs/namei.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/namei.c	2004-07-07 11:43:48.525500248 +0300
+++ linus-2.6.7-bk-latest/fs/namei.c	2004-07-07 11:52:16.170326504 +0300
@@ -770,14 +770,19 @@
 lookup_parent:
 		nd->last = this;
 		nd->last_type = LAST_NORM;
-		if (this.name[0] != '.')
-			goto return_base;
-		if (this.len == 1)
-			nd->last_type = LAST_DOT;
-		else if (this.len == 2 && this.name[1] == '.')
-			nd->last_type = LAST_DOTDOT;
-		else
-			goto return_base;
+		if (this.name[0] == '.') {
+			if (this.len == 1)
+				nd->last_type = LAST_DOT;
+			else if (this.len == 2 && this.name[1] == '.')
+				nd->last_type = LAST_DOTDOT;
+		}
+
+		if (inode->i_op && inode->i_op->endparentlookup) {
+			err = inode->i_op->endparentlookup(nd);
+			if (err)
+				break;
+		}
+		goto return_base;
 return_reval:
 		/*
 		 * We bypassed the ordinary revalidation routines.
@@ -1554,9 +1559,16 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
+	intent_init(&nd.intent.open, IT_MKNOD);
+	nd.intent.open.create_mode = mode;
+	nd.intent.open.create.dev = dev;
+
+	error = path_lookup_it(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
+	if (nd.intent.open.flags & IT_STATUS_RAW)
+		goto out2;
+
 	dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(dentry);
 
@@ -1583,6 +1595,7 @@
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
+out2:
 	path_release(&nd);
 out:
 	putname(tmp);
@@ -1625,9 +1638,13 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
+		intent_init(&nd.intent.open, IT_MKDIR);
+		nd.intent.open.create_mode = mode;
+		error = path_lookup_it(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
+		if (nd.intent.open.flags & IT_STATUS_RAW)
+			goto out2;
 		dentry = lookup_create(&nd, 1);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
@@ -1637,6 +1654,7 @@
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
+out2:
 		path_release(&nd);
 out:
 		putname(tmp);
@@ -1722,9 +1740,12 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
+	intent_init(&nd.intent.open, IT_RMDIR);
+	error = path_lookup_it(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
+	if (nd.intent.open.flags & IT_STATUS_RAW)
+		goto exit1;
 
 	switch(nd.last_type) {
 		case LAST_DOTDOT:
@@ -1800,9 +1821,13 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
+	intent_init(&nd.intent.open, IT_UNLINK);
+	error = path_lookup_it(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
+	if (nd.intent.open.flags & IT_STATUS_RAW)
+		goto exit1;
+
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
@@ -1874,9 +1899,13 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		error = path_lookup(to, LOOKUP_PARENT, &nd);
+		intent_init(&nd.intent.open, IT_SYMLINK);
+		nd.intent.open.create.link = from;
+		error = path_lookup_it(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
+		if (nd.intent.open.flags & IT_STATUS_RAW)
+			goto out2;
 		dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
@@ -1884,6 +1913,7 @@
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
+out2:
 		path_release(&nd);
 out:
 		putname(to);
@@ -1955,9 +1985,13 @@
 	error = __user_walk(oldname, 0, &old_nd);
 	if (error)
 		goto exit;
-	error = path_lookup(to, LOOKUP_PARENT, &nd);
+	intent_init(&nd.intent.open, IT_LINK);
+	nd.intent.open.create.source_nd = &old_nd;
+	error = path_lookup_it(to, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
+	if (nd.intent.open.flags & IT_STATUS_RAW)
+		goto out_release;
 	error = -EXDEV;
 	if (old_nd.mnt != nd.mnt)
 		goto out_release;
@@ -2138,9 +2172,14 @@
 	if (error)
 		goto exit;
 
-	error = path_lookup(newname, LOOKUP_PARENT, &newnd);
+	intent_init(&newnd.intent.open, IT_RENAME);
+	newnd.intent.open.create.source_nd = &oldnd;
+	error = path_lookup_it(newname, LOOKUP_PARENT, &newnd);
 	if (error)
 		goto exit1;
+	if (newnd.intent.open.flags & IT_STATUS_RAW) {
+		goto exit2;
+	}
 
 	error = -EXDEV;
 	if (oldnd.mnt != newnd.mnt)
Index: linus-2.6.7-bk-latest/include/linux/namei.h
===================================================================
--- linus-2.6.7-bk-latest.orig/include/linux/namei.h	2004-07-07 11:43:48.523500552 +0300
+++ linus-2.6.7-bk-latest/include/linux/namei.h	2004-07-07 11:56:19.668309184 +0300
@@ -15,15 +15,30 @@
 #define IT_UNLINK	(1<<5)
 #define IT_TRUNC	(1<<6)
 #define IT_GETXATTR	(1<<7)
+#define IT_RMDIR	(1<<8)
+#define IT_LINK		(1<<9)
+#define IT_RENAME	(1<<10)
+#define IT_MKDIR	(1<<11)
+#define IT_MKNOD	(1<<12)
+#define IT_SYMLINK	(1<<13)
 
 #define INTENT_MAGIC 0x19620323
-
+#define IT_STATUS_RAW (1<<10)  /* Setting this in it_flags on exit from lookup
+                                  means everything was done already and return
+                                  value from lookup is in fact status of
+                                  already performed operation */
 struct open_intent {
 	int	magic;
 	int	op;
 	void	(*op_release)(struct open_intent *);
 	int	flags;
 	int	create_mode;
+	union {
+		int	raw_status;	/* return value from raw method */
+		unsigned	dev;	/* For mknod */
+		char	*link;	/* For symlink */
+		struct nameidata *source_nd; /* For link/rename */
+	} create;
 	union {
 		void *fs_data; /* FS-specific intent data */
 	} d;
Index: linus-2.6.7-bk-latest/include/linux/fs.h
===================================================================
--- linus-2.6.7-bk-latest.orig/include/linux/fs.h	2004-07-07 11:43:48.524500400 +0300
+++ linus-2.6.7-bk-latest/include/linux/fs.h	2004-07-07 11:52:16.172326200 +0300
@@ -914,6 +914,7 @@
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
+	int (*endparentlookup) (struct nameidata *);
 };
 
 struct seq_file;
