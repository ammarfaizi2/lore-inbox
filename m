Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVCLVNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVCLVNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 16:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVCLVNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 16:13:42 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:8338 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261356AbVCLVM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 16:12:58 -0500
Date: Sat, 12 Mar 2005 22:12:55 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH][RFC] Apply umask to /proc/<pid>
Message-ID: <20050312211255.GA4627@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

patch below makes procfs apply the umask of the processes to their
respective /proc/<pid> directories and the files below them.  That
allows users to gain a bit of privacy by setting a restrictive umask in
their profiles.

Unlike my previous patches on that subject it requires no new parameter
or mount option and puts control into the hands of the user owning those
files.  And it's even smaller and simpler, too. :]

A umask change only affects processes created after the change with
certainty.  The /proc files of a process changing its own umask may or
may not be affected, depending on whether their inode already exists.
That's OK, I think, and fits within the conventional meaning of umask.

Tools like top and ps continue to work, they simply don't show processes
that the user running them has no permission to get details on.  Even
pstree works as long as the umask of init is kept at its permissive default
value.

Comments welcome!

Rene



--- linux-2.6.11-bk8/fs/proc/base.c~	2005-03-12 19:11:37.000000000 +0100
+++ linux-2.6.11-bk8/fs/proc/base.c	2005-03-12 19:12:53.000000000 +0100
@@ -1418,6 +1418,8 @@ static struct file_operations proc_tgid_
 static struct inode_operations proc_tgid_attr_inode_operations;
 #endif
 
+#define proc_get_umask(task) (task->fs ? task->fs->umask : 0)
+
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1450,7 +1452,7 @@ static struct dentry *proc_pident_lookup
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
+	inode->i_mode = p->mode & ~proc_get_umask(task);
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
@@ -1796,7 +1798,7 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~proc_get_umask(task);
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
@@ -1851,7 +1853,7 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~proc_get_umask(task);
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
