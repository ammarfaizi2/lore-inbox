Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTHUUgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbTHUUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:36:48 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:56253 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262885AbTHUUgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:36:45 -0400
Subject: Re: [PATCH] Call security hook from pid*_revalidate
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <87wud8pecx.fsf@devron.myhome.or.jp>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	 <1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
	 <20030819142234.64433bad.akpm@osdl.org>
	 <87wud8pecx.fsf@devron.myhome.or.jp>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061498191.25855.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Aug 2003 16:36:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 10:56, OGAWA Hirofumi wrote:
> Umm.. Wasn't the following needed?
> 
> 	inode->i_uid = 0;
> 	inode->i_gid = 0;
> 	if (ino == PROC_PID_INO || task_dumpable(task)) {

Yes, good catch.  That's an omission from the original
proc-pid-setuid-ownership-fix.patch, not mine.  How about the patch
below, against 2.6.0-test3-mm3, which both addresses the omission from
the original patch and adds the security hook call.  Note that the
security hook call is still unconditional, as in proc_pid_make_inode;
the security module can decide how it wants to deal with non-dumpable
tasks when setting the inode security field.

diff -X /home/sds/dontdiff -ru linux-2.6.0-test3-mm3/fs/proc/base.c linux-2.6.0-test3-mm3-sds/fs/proc/base.c
--- linux-2.6.0-test3-mm3/fs/proc/base.c	2003-08-21 16:24:17.469096884 -0400
+++ linux-2.6.0-test3-mm3-sds/fs/proc/base.c	2003-08-21 16:09:40.000000000 -0400
@@ -870,11 +870,17 @@
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
+		inode->i_uid = 0;
+		inode->i_gid = 0;
+		if (ino == PROC_PID_INO || task_dumpable(task)) {
+			inode->i_uid = task->euid;
+			inode->i_gid = task->egid;
+		}
+		security_task_to_inode(task, inode);
 		return 1;
 	}
 	d_drop(dentry);
@@ -883,8 +889,9 @@
 
 static int pid_fd_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	struct task_struct *task = proc_task(dentry->d_inode);
-	int fd = proc_type(dentry->d_inode) - PROC_PID_FD_DIR;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	int fd = proc_type(inode) - PROC_PID_FD_DIR;
 	struct files_struct *files;
 
 	task_lock(task);
@@ -895,10 +902,16 @@
 	if (files) {
 		spin_lock(&files->file_lock);
 		if (fcheck_files(files, fd)) {
+			int ino = inode->i_ino & 0xffff;
 			spin_unlock(&files->file_lock);
 			put_files_struct(files);
-			dentry->d_inode->i_uid = task->euid;
-			dentry->d_inode->i_gid = task->egid;
+			inode->i_uid = 0;
+			inode->i_gid = 0;
+			if (ino == PROC_PID_INO || task_dumpable(task)) {
+				inode->i_uid = task->euid;
+				inode->i_gid = task->egid;
+			}
+			security_task_to_inode(task, inode);
 			return 1;
 		}
 		spin_unlock(&files->file_lock);


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

