Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVBAXxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVBAXxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBAXxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:53:45 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:62135 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262184AbVBAXuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:50:16 -0500
Date: Wed, 2 Feb 2005 00:50:15 +0100
From: rene.scharfe@lsrfire.ath.cx
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc filesystem (3/3): add proc_show_options()
Message-ID: <20050201235015.GC29125@lsrfire.ath.cx>
References: <20050201234614.GA29125@lsrfire.ath.cx> <20050201234845.GB29125@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201234845.GB29125@lsrfire.ath.cx>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a show_options function to the proc filesystem.

diff -pur l2/fs/proc/inode.c l3/fs/proc/inode.c
--- l2/fs/proc/inode.c	2005-02-01 04:51:23.000000000 +0100
+++ l3/fs/proc/inode.c	2005-02-01 04:51:07.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/smp_lock.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -23,6 +24,9 @@
 extern umode_t proc_umask;
 extern void free_proc_entry(struct proc_dir_entry *);
 
+static int proc_root_inode_uid;
+static int proc_root_inode_gid;
+
 static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
 	if (de)
@@ -134,6 +138,17 @@ static int proc_remount(struct super_blo
 	return 0;
 }
 
+static int proc_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	if (proc_root_inode_uid != 0)
+		seq_printf(m, ",uid=%i", proc_root_inode_uid);
+	if (proc_root_inode_gid != 0)
+		seq_printf(m, ",gid=%i", proc_root_inode_gid);
+	if (proc_umask != 0)
+		seq_printf(m, ",umask=%04o", proc_umask);
+	return 0;
+}
+
 static struct super_operations proc_sops = { 
 	.alloc_inode	= proc_alloc_inode,
 	.destroy_inode	= proc_destroy_inode,
@@ -142,6 +157,7 @@ static struct super_operations proc_sops
 	.delete_inode	= proc_delete_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= proc_remount,
+	.show_options	= proc_show_options,
 };
 
 enum {
@@ -248,6 +264,8 @@ int proc_fill_super(struct super_block *
 	struct inode * root_inode;
 
 	proc_umask = 0;
+	proc_root_inode_uid = 0;
+	proc_root_inode_gid = 0;
 	s->s_flags |= MS_NODIRATIME;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
@@ -262,12 +280,12 @@ int proc_fill_super(struct super_block *
 	 * Fixup the root inode's nlink value
 	 */
 	root_inode->i_nlink += nr_processes();
-	root_inode->i_uid = 0;
-	root_inode->i_gid = 0;
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_no_root;
-	parse_options(data, &root_inode->i_uid, &root_inode->i_gid);
+	parse_options(data, &proc_root_inode_uid, &proc_root_inode_gid);
+	root_inode->i_uid = proc_root_inode_uid;
+	root_inode->i_gid = proc_root_inode_gid;
 	return 0;
 
 out_no_root:
