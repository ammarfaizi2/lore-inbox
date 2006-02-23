Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWBWQD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWBWQD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWBWQDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:03:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64918 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751510AbWBWQDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:03:17 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/23] proc: Simplify the ownership rules for /proc
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:02:09 -0700
In-Reply-To: <m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:00:30 -0700")
Message-ID: <m1y802gj26.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently in /proc if the task is dumpable all of files are owned by
the tasks effective users.  Otherwise the files are owned by root.
Unless it is the /proc/<tgid>/ or /proc/<tgid>/task/<pid> directory
in that case we always make the directory owned by the effective user.

However the special case for directories is pointless except as a way
to read the effective user, because the permissions on both of those
directories are world readable, and executable.

/proc/<tgid>/status provides a much better way to read a processes effecitve
userid, so it is silly to try to provide that on the directory.

So this patch simplifies the code by removing a pointless special case and
gets us one step closer to being able to remove the hard coded /proc inode
numbers.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

453d43f2b9e9fee71c23007f1cfe5dbedd9d3790
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 56ca519..c35f340 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1324,7 +1324,7 @@ static struct inode *proc_pid_make_inode
 	ei->type = ino;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_TGID_INO || ino == PROC_TID_INO || task_dumpable(task)) {
+	if (task_dumpable(task)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
@@ -1353,7 +1353,7 @@ static int pid_revalidate(struct dentry 
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = proc_task(inode);
 	if (pid_alive(task)) {
-		if (proc_type(inode) == PROC_TGID_INO || proc_type(inode) == PROC_TID_INO || task_dumpable(task)) {
+		if (task_dumpable(task)) {
 			inode->i_uid = task->euid;
 			inode->i_gid = task->egid;
 		} else {
-- 
1.2.2.g709a

