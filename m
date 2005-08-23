Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVHWUap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVHWUap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVHWUap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:30:45 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:2322 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932380AbVHWUao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:30:44 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:26:53 +0200)
Subject: [PATCH 3/8] use get_fs_struct() in proc
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:30:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up proc_cwd_link() and proc_root_link() by factoring
out common code into get_fs_struct().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/proc/base.c
===================================================================
--- linux.orig/fs/proc/base.c	2005-08-19 14:47:20.000000000 +0200
+++ linux/fs/proc/base.c	2005-08-19 14:47:35.000000000 +0200
@@ -298,15 +298,21 @@ static int proc_fd_link(struct inode *in
 	return -ENOENT;
 }
 
-static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+static struct fs_struct *get_fs_struct(struct task_struct *task)
 {
 	struct fs_struct *fs;
-	int result = -ENOENT;
-	task_lock(proc_task(inode));
-	fs = proc_task(inode)->fs;
+	task_lock(task);
+	fs = task->fs;
 	if(fs)
 		atomic_inc(&fs->count);
-	task_unlock(proc_task(inode));
+	task_unlock(task);
+	return fs;
+}
+
+static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	struct fs_struct *fs = get_fs_struct(proc_task(inode));
+	int result = -ENOENT;
 	if (fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->pwdmnt);
@@ -320,13 +326,8 @@ static int proc_cwd_link(struct inode *i
 
 static int proc_root_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	struct fs_struct *fs;
+	struct fs_struct *fs = get_fs_struct(proc_task(inode));
 	int result = -ENOENT;
-	task_lock(proc_task(inode));
-	fs = proc_task(inode)->fs;
-	if(fs)
-		atomic_inc(&fs->count);
-	task_unlock(proc_task(inode));
 	if (fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->rootmnt);
