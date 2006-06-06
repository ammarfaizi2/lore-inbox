Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWFFXiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWFFXiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWFFXiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:38:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17060 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751363AbWFFXiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:38:14 -0400
Date: Wed, 7 Jun 2006 01:38:21 +0200
From: Petr Baudis <pasky@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Let even non-dumpable tasks access /proc/self/fd
Message-ID: <20060606233820.GL28014@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All tasks calling setuid() from root to non-root during their lifetime
will not be able to access their /proc/self/fd.  This is troublesome
because the fstatat() and other *at() routines are emulated by accessing
/proc/self/fd/*/path and that will break with setuid()ing programs,
leading to various weird consequences (e.g. with the latest glibc,
nftw() does not work with setuid()ing programs on ppc and furthermore
causes the LSB testsuite to fail because of this).

This kernel patch fixes the problem by letting the process access its
own /proc/self/fd - as far as I can see, this should be reasonably safe
since for the process, this does not reveal "anything new". Feel free to
comment on this.

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6cc77dc..ea36a25 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1368,7 +1368,9 @@ static struct inode *proc_pid_make_inode
 	ei->type = ino;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_TGID_INO || ino == PROC_TID_INO || task_dumpable(task)) {
+	if (ino == PROC_TGID_INO || ino == PROC_TID_INO ||
+	    ((ino == PROC_TGID_FD || ino == PROC_TID_FD || ino >= PROC_TID_FD_DIR) && task == current) ||
+	    task_dumpable(task)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
@@ -1398,7 +1400,9 @@ static int pid_revalidate(struct dentry 
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = proc_task(inode);
 	if (pid_alive(task)) {
-		if (proc_type(inode) == PROC_TGID_INO || proc_type(inode) == PROC_TID_INO || task_dumpable(task)) {
+		if (proc_type(inode) == PROC_TGID_INO || proc_type(inode) == PROC_TID_INO ||
+		    ((proc_type(inode) == PROC_TGID_FD || proc_type(inode) == PROC_TID_FD) && task == current) ||
+		     task_dumpable(task)) {
 			inode->i_uid = task->euid;
 			inode->i_gid = task->egid;
 		} else {
@@ -1425,7 +1429,7 @@ static int tid_fd_revalidate(struct dent
 		if (fcheck_files(files, fd)) {
 			rcu_read_unlock();
 			put_files_struct(files);
-			if (task_dumpable(task)) {
+			if (task_dumpable(task) || task == current) {
 				inode->i_uid = task->euid;
 				inode->i_gid = task->egid;
 			} else {


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
