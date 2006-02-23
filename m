Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWBWQLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWBWQLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWBWQLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:11:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10135 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751587AbWBWQLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:11:50 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/23] proc: Fix the link count for /proc/<pid>/task
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:10:41 -0700
In-Reply-To: <m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:08:20 -0700")
Message-ID: <m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use getattr to get an accurate link count when needed.  This is cheaper
and more accurate than trying to derive it by walking the thread list
of a process.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

eec5c7327c53b862025a595985a72fa01509c5e4
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 81c2f2a..1a39258 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1466,6 +1466,7 @@ out:
 
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd);
+static int proc_task_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat);
 
 static struct file_operations proc_fd_operations = {
 	.read		= generic_read_dir,
@@ -1486,6 +1487,7 @@ static struct inode_operations proc_fd_i
 
 static struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
+	.getattr	= proc_task_getattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1592,7 +1594,7 @@ static struct dentry *proc_pident_lookup
 	 */
 	switch(p->type) {
 		case PROC_TGID_TASK:
-			inode->i_nlink = 2 + get_tid_list(2, NULL, dir);
+			inode->i_nlink = 2;
 			inode->i_op = &proc_task_inode_operations;
 			inode->i_fop = &proc_task_operations;
 			break;
@@ -2189,7 +2191,6 @@ static int proc_task_readdir(struct file
 	}
 
 	nr_tids = get_tid_list(pos, tid_array, inode);
-	inode->i_nlink = pos + nr_tids;
 
 	for (i = 0; i < nr_tids; i++) {
 		unsigned long j = PROC_NUMBUF;
@@ -2209,3 +2210,19 @@ out:
 	filp->f_pos = pos;
 	return retval;
 }
+
+static int proc_task_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *p = proc_task(inode);
+	generic_fillattr(inode, stat);
+
+	if (pid_alive(p)) {
+		task_lock(p);
+		if (p->signal)
+			stat->nlink += atomic_read(&p->signal->count);
+		task_unlock(p);
+	}
+		
+	return 0;
+}
-- 
1.2.2.g709a

