Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVBAXxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVBAXxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBAXxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:53:22 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:60599 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262146AbVBAXsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:48:50 -0500
Date: Wed, 2 Feb 2005 00:48:45 +0100
From: rene.scharfe@lsrfire.ath.cx
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc filesystem (2/3): add umask option
Message-ID: <20050201234845.GB29125@lsrfire.ath.cx>
References: <20050201234614.GA29125@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201234614.GA29125@lsrfire.ath.cx>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the umask option to the proc filesystem.  It's
essentially unchanged from the previous version, except that the mount
option has to be specified as a kernel parameter now.  This way we avoid
dealing with pre-existing inodes.

The umask can be used to restrict the permissions of process information
in /proc (the numerical directories and the files within them).  No other
file or directory should be affected.

Al, there was a big IF in your comment regarding the previous version.  
Do you have general objections against the umask feature or its
usefulness?

Thanks,
Rene


diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-02-01 04:17:25.000000000 +0100
+++ l2/fs/proc/base.c	2005-02-01 04:26:03.000000000 +0100
@@ -180,6 +180,8 @@ static struct pid_entry tid_attr_stuff[]
 
 #undef E
 
+umode_t proc_umask;
+
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct task_struct *task = proc_task(inode);
@@ -1222,7 +1224,7 @@ static struct dentry *proc_pident_lookup
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
+	inode->i_mode = p->mode & ~proc_umask;
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
@@ -1537,7 +1539,7 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~proc_umask;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
@@ -1592,7 +1594,7 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~proc_umask;
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
diff -pur l1/fs/proc/inode.c l2/fs/proc/inode.c
--- l1/fs/proc/inode.c	2005-02-01 04:29:33.000000000 +0100
+++ l2/fs/proc/inode.c	2005-02-01 04:24:08.000000000 +0100
@@ -20,6 +20,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
+extern umode_t proc_umask;
 extern void free_proc_entry(struct proc_dir_entry *);
 
 static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
@@ -144,12 +145,13 @@ static struct super_operations proc_sops
 };
 
 enum {
-	Opt_uid, Opt_gid, Opt_err
+	Opt_uid, Opt_gid, Opt_umask, Opt_err
 };
 
 static match_table_t tokens = {
 	{Opt_uid, "proc.uid=%u"},
 	{Opt_gid, "proc.gid=%u"},
+	{Opt_umask, "proc.umask=%o"},
 	{Opt_err, NULL}
 };
 
@@ -183,6 +185,11 @@ static int parse_options(char *options,u
 				continue;
 			*gid = option;
 			break;
+		case Opt_umask:
+			if (match_octal(args, &option))
+				continue;
+			proc_umask = option & 0777;
+			break;
 		}
 	}
 	return 1;
@@ -240,6 +247,7 @@ int proc_fill_super(struct super_block *
 {
 	struct inode * root_inode;
 
+	proc_umask = 0;
 	s->s_flags |= MS_NODIRATIME;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
