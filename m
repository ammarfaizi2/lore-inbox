Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWBLNk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWBLNk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWBLNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:40:45 -0500
Received: from 203-59-200-129.dyn.iinet.net.au ([203.59.200.129]:26842 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1750738AbWBLNk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:40:29 -0500
Date: Sun, 12 Feb 2006 21:40:17 +0800
Message-Id: <200602121340.k1CDeHSn019282@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [RFC:PATCH 2/4] autofs4 - add v5 follow_link mount trigger method
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a follow_link inode method for the root of
an autofs direct mount trigger. It also adds the corresponding
mount options and updates the show_mount method.

--- linux-2.6.16-rc2-mm1/fs/autofs4/inode.c.v5-follow_link	2006-02-12 20:38:17.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/autofs4/inode.c	2006-02-12 20:43:45.000000000 +0800
@@ -3,6 +3,7 @@
  * linux/fs/autofs/inode.c
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
+ *  Copyright 2005-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -177,6 +178,13 @@ static int autofs4_show_options(struct s
 	seq_printf(m, ",minproto=%d", sbi->min_proto);
 	seq_printf(m, ",maxproto=%d", sbi->max_proto);
 
+	if (sbi->type & AUTOFS_TYP_OFFSET)
+		seq_printf(m, ",offset");
+	else if (sbi->type & AUTOFS_TYP_DIRECT)
+		seq_printf(m, ",direct");
+	else
+		seq_printf(m, ",indirect");
+
 	return 0;
 }
 
@@ -186,7 +194,8 @@ static struct super_operations autofs4_s
 	.show_options	= autofs4_show_options,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
+enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
+	Opt_indirect, Opt_direct, Opt_offset};
 
 static match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
@@ -195,11 +204,15 @@ static match_table_t tokens = {
 	{Opt_pgrp, "pgrp=%u"},
 	{Opt_minproto, "minproto=%u"},
 	{Opt_maxproto, "maxproto=%u"},
+	{Opt_indirect, "indirect"},
+	{Opt_direct, "direct"},
+	{Opt_offset, "offset"},
 	{Opt_err, NULL}
 };
 
 static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid,
-			 pid_t *pgrp, int *minproto, int *maxproto)
+			 pid_t *pgrp, unsigned int *type,
+			 int *minproto, int *maxproto)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -253,6 +266,15 @@ static int parse_options(char *options, 
 				return 1;
 			*maxproto = option;
 			break;
+		case Opt_indirect:
+			*type = AUTOFS_TYP_INDIRECT;
+			break;
+		case Opt_direct:
+			*type = AUTOFS_TYP_DIRECT;
+			break;
+		case Opt_offset:
+			*type = AUTOFS_TYP_DIRECT | AUTOFS_TYP_OFFSET;
+			break;
 		default:
 			return 1;
 		}
@@ -271,6 +293,11 @@ static struct autofs_info *autofs4_mkroo
 	return ino;
 }
 
+void autofs4_dentry_release(struct dentry *);
+static struct dentry_operations autofs4_sb_dentry_operations = {
+	.d_release      = autofs4_dentry_release,
+};
+
 int autofs4_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
@@ -297,6 +324,7 @@ int autofs4_fill_super(struct super_bloc
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
+	sbi->type = 0;
 	sbi->min_proto = 0;
 	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
@@ -315,27 +343,31 @@ int autofs4_fill_super(struct super_bloc
 	if (!ino)
 		goto fail_free;
 	root_inode = autofs4_get_inode(s, ino);
-	kfree(ino);
 	if (!root_inode)
-		goto fail_free;
+		goto fail_ino;
 
-	root_inode->i_op = &autofs4_root_inode_operations;
-	root_inode->i_fop = &autofs4_root_operations;
 	root = d_alloc_root(root_inode);
-	pipe = NULL;
-
 	if (!root)
 		goto fail_iput;
+	pipe = NULL;
+
+	root->d_op = &autofs4_sb_dentry_operations;
+	root->d_fsdata = ino;
 
 	/* Can this call block? */
 	if (parse_options(data, &pipefd,
 			  &root_inode->i_uid, &root_inode->i_gid,
-			  &sbi->oz_pgrp,
+			  &sbi->oz_pgrp, &sbi->type,
 			  &sbi->min_proto, &sbi->max_proto)) {
 		printk("autofs: called with bogus options\n");
 		goto fail_dput;
 	}
 
+	root_inode->i_fop = &autofs4_root_operations;
+	root_inode->i_op = sbi->type & AUTOFS_TYP_DIRECT ?
+			&autofs4_direct_root_inode_operations :
+			&autofs4_indirect_root_inode_operations;
+
 	/* Couldn't this be tested earlier? */
 	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
 	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
@@ -391,6 +423,8 @@ fail_dput:
 fail_iput:
 	printk("autofs: get root dentry failed\n");
 	iput(root_inode);
+fail_ino:
+	kfree(ino);
 fail_free:
 	kfree(sbi);
 fail_unlock:
--- linux-2.6.16-rc2-mm1/fs/autofs4/root.c.v5-follow_link	2006-02-12 20:38:17.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/autofs4/root.c	2006-02-12 20:53:39.000000000 +0800
@@ -4,7 +4,7 @@
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
  *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
- *  Copyright 2001-2003 Ian Kent <raven@themaw.net>
+ *  Copyright 2001-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -30,6 +30,7 @@ static int autofs4_dir_close(struct inod
 static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
+static void *autofs4_follow_link(struct dentry *, struct nameidata *);
 
 const struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
@@ -46,7 +47,7 @@ const struct file_operations autofs4_dir
 	.readdir	= autofs4_dir_readdir,
 };
 
-struct inode_operations autofs4_root_inode_operations = {
+struct inode_operations autofs4_indirect_root_inode_operations = {
 	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
@@ -54,6 +55,11 @@ struct inode_operations autofs4_root_ino
 	.rmdir		= autofs4_dir_rmdir,
 };
 
+struct inode_operations autofs4_direct_root_inode_operations = {
+	.lookup		= autofs4_lookup,
+	.follow_link	= autofs4_follow_link,
+};
+
 struct inode_operations autofs4_dir_inode_operations = {
 	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
@@ -252,7 +258,7 @@ static int try_to_fill_dentry(struct den
 		 */
 		status = d_invalidate(dentry);
 		if (status != -EBUSY)
-			return 0;
+			return -ENOENT;
 	}
 
 	DPRINTK("dentry=%p %.*s ino=%p",
@@ -271,17 +277,17 @@ static int try_to_fill_dentry(struct den
 		DPRINTK("mount done status=%d", status);
 
 		if (status && dentry->d_inode)
-			return 0; /* Try to get the kernel to invalidate this dentry */
+			return status; /* Try to get the kernel to invalidate this dentry */
 
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
 			spin_lock(&dentry->d_lock);
 			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 			spin_unlock(&dentry->d_lock);
-			return 0;
+			return status;
 		} else if (status) {
 			/* Return a negative dentry, but leave it "pending" */
-			return 0;
+			return status;
 		}
 	/* Trigger mount for path component or follow link */
 	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
@@ -300,7 +306,7 @@ static int try_to_fill_dentry(struct den
 			spin_lock(&dentry->d_lock);
 			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 			spin_unlock(&dentry->d_lock);
-			return 0;
+			return status;
 		}
 	}
 
@@ -311,7 +317,41 @@ static int try_to_fill_dentry(struct den
 	spin_lock(&dentry->d_lock);
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 	spin_unlock(&dentry->d_lock);
-	return 1;
+	return status;
+}
+
+/* For autofs direct mounts the follow link triggers the mount */
+static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	int oz_mode = autofs4_oz_mode(sbi);
+	unsigned int lookup_type;
+	int status;
+
+	DPRINTK("dentry=%p %.*s oz_mode=%d nd->flags=%d",
+		dentry, dentry->d_name.len, dentry->d_name.name, oz_mode,
+		nd->flags);
+
+	/* If it's our master or we shouldn't trigger a mount we're done */
+	lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+	if (oz_mode || !lookup_type)
+		goto done;
+
+	status = try_to_fill_dentry(dentry, 0);
+	if (status)
+		goto out_error;
+
+	if (!autofs4_follow_mount(&nd->mnt, &nd->dentry)) {
+		status = -ENOENT;
+		goto out_error;
+	}
+
+done:
+	return NULL;
+
+out_error:
+	path_release(nd);
+	return ERR_PTR(status);
 }
 
 /*
@@ -326,13 +366,13 @@ static int autofs4_revalidate(struct den
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
 	int flags = nd ? nd->flags : 0;
-	int status = 1;
+	int status = 0;
 
 	/* Pending dentry */
 	if (autofs4_ispending(dentry)) {
 		if (!oz_mode)
 			status = try_to_fill_dentry(dentry, flags);
-		return status;
+		return !status;
 	}
 
 	/* Negative dentry.. invalidate if "old" */
@@ -349,14 +389,14 @@ static int autofs4_revalidate(struct den
 		spin_unlock(&dcache_lock);
 		if (!oz_mode)
 			status = try_to_fill_dentry(dentry, flags);
-		return status;
+		return !status;
 	}
 	spin_unlock(&dcache_lock);
 
 	return 1;
 }
 
-static void autofs4_dentry_release(struct dentry *de)
+void autofs4_dentry_release(struct dentry *de)
 {
 	struct autofs_info *inf;
 
--- linux-2.6.16-rc2-mm1/fs/autofs4/autofs_i.h.v5-follow_link	2006-02-12 20:38:17.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/autofs4/autofs_i.h	2006-02-12 20:43:45.000000000 +0800
@@ -3,6 +3,7 @@
  * linux/fs/autofs/autofs_i.h
  *
  *   Copyright 1997-1998 Transmeta Corporation - All Rights Reserved
+ *   Copyright 2005-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -84,6 +85,10 @@ struct autofs_wait_queue {
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
+#define AUTOFS_TYP_INDIRECT     0x0001
+#define AUTOFS_TYP_DIRECT       0x0002
+#define AUTOFS_TYP_OFFSET       0x0004
+
 struct autofs_sb_info {
 	u32 magic;
 	struct dentry *root;
@@ -96,6 +101,7 @@ struct autofs_sb_info {
 	int min_proto;
 	int max_proto;
 	unsigned long exp_timeout;
+	unsigned int type;
 	int reghost_enabled;
 	int needs_reghost;
 	struct super_block *sb;
@@ -161,7 +167,8 @@ int autofs4_expire_multi(struct super_bl
 
 extern struct inode_operations autofs4_symlink_inode_operations;
 extern struct inode_operations autofs4_dir_inode_operations;
-extern struct inode_operations autofs4_root_inode_operations;
+extern struct inode_operations autofs4_indirect_root_inode_operations;
+extern struct inode_operations autofs4_direct_root_inode_operations;
 extern const struct file_operations autofs4_dir_operations;
 extern const struct file_operations autofs4_root_operations;
 
