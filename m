Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbTHUVkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTHUVkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:40:04 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:44225 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262915AbTHUVj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:39:58 -0400
Subject: Re: [PATCH] Call security hook from pid*_revalidate
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1061498191.25855.77.camel@moss-spartans.epoch.ncsc.mil>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	 <1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
	 <20030819142234.64433bad.akpm@osdl.org>
	 <87wud8pecx.fsf@devron.myhome.or.jp>
	 <1061498191.25855.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061501984.25855.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Aug 2003 17:39:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A slightly updated version of the same patch against 2.6.0-test3-mm3 is
below.  Avoid clearing the i_uid and i_gid in revalidate unless those
are truly the right values, and don't bother testing for PROC_PID_INO in
pid_fd_revalidate.  Of course, these changes only ensure proper updating
when revalidate is called, so already opened files can still be read
under the old attributes until the file is looked up again...

diff -X /home/sds/dontdiff -ru linux-2.6.0-test3-mm3/fs/proc/base.c linux-2.6.0-test3-mm3-sds/fs/proc/base.c
--- linux-2.6.0-test3-mm3/fs/proc/base.c	2003-08-21 16:24:17.000000000 -0400
+++ linux-2.6.0-test3-mm3-sds/fs/proc/base.c	2003-08-21 17:23:29.764522205 -0400
@@ -870,11 +870,18 @@
  */
 static int pid_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	if (pid_alive(proc_task(dentry->d_inode))) {
-		struct task_struct *task = proc_task(dentry->d_inode);
-
-		dentry->d_inode->i_uid = task->euid;
-		dentry->d_inode->i_gid = task->egid;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	if (pid_alive(task)) {
+		int ino = inode->i_ino & 0xffff;
+		if (ino == PROC_PID_INO || task_dumpable(task)) {
+			inode->i_uid = task->euid;
+			inode->i_gid = task->egid;
+		} else {
+			inode->i_uid = 0;
+			inode->i_gid = 0;
+		}
+		security_task_to_inode(task, inode);
 		return 1;
 	}
 	d_drop(dentry);
@@ -883,8 +890,9 @@
 
 static int pid_fd_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	struct task_struct *task = proc_task(dentry->d_inode);
-	int fd = proc_type(dentry->d_inode) - PROC_PID_FD_DIR;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	int fd = proc_type(inode) - PROC_PID_FD_DIR;
 	struct files_struct *files;
 
 	task_lock(task);
@@ -897,8 +905,14 @@
 		if (fcheck_files(files, fd)) {
 			spin_unlock(&files->file_lock);
 			put_files_struct(files);
-			dentry->d_inode->i_uid = task->euid;
-			dentry->d_inode->i_gid = task->egid;
+			if (task_dumpable(task)) {
+				inode->i_uid = task->euid;
+				inode->i_gid = task->egid;
+			} else {
+				inode->i_uid = 0;
+				inode->i_gid = 0;
+			}
+			security_task_to_inode(task, inode);
 			return 1;
 		}
 		spin_unlock(&files->file_lock);


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

