Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWBWQFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWBWQFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWBWQFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:05:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1431 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751510AbWBWQFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:05:19 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/23] proc: Replace proc_inode.type with proc_inode.fd
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:04:08 -0700
In-Reply-To: <m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:00:30 -0700")
Message-ID: <m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sole renaming use of proc_inode.type is to discover the file descriptor
number, so just store the file descriptor number instead of deriving it
from the inode type.  This removes any /proc limits on the maximum number
of file descriptors, and clears the path to make the hard coded /proc
inode numbers go away.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c          |    6 +++---
 fs/proc/inode.c         |    2 +-
 fs/proc/internal.h      |    4 ++--
 include/linux/proc_fs.h |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

7c7a69a8f4291176a595da2c8046ddef15bc6135
diff --git a/fs/proc/base.c b/fs/proc/base.c
index c35f340..8357c52 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -290,7 +290,7 @@ static int proc_fd_link(struct inode *in
 	struct task_struct *task = proc_task(inode);
 	struct files_struct *files;
 	struct file *file;
-	int fd = proc_type(inode) - PROC_TID_FD_DIR;
+	int fd = proc_fd(inode);
 
 	files = get_files_struct(task);
 	if (files) {
@@ -1321,7 +1321,6 @@ static struct inode *proc_pid_make_inode
 	 */
 	get_task_struct(task);
 	ei->task = task;
-	ei->type = ino;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
 	if (task_dumpable(task)) {
@@ -1371,7 +1370,7 @@ static int tid_fd_revalidate(struct dent
 {
 	struct inode *inode = dentry->d_inode;
 	struct task_struct *task = proc_task(inode);
-	int fd = proc_type(inode) - PROC_TID_FD_DIR;
+	int fd = proc_fd(inode);
 	struct files_struct *files;
 
 	files = get_files_struct(task);
@@ -1478,6 +1477,7 @@ static struct dentry *proc_lookupfd(stru
 	if (!inode)
 		goto out;
 	ei = PROC_I(inode);
+	ei->fd = fd;
 	files = get_files_struct(task);
 	if (!files)
 		goto out_unlock;
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 075d3e9..8f532d7 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -95,7 +95,7 @@ static struct inode *proc_alloc_inode(st
 	if (!ei)
 		return NULL;
 	ei->task = NULL;
-	ei->type = 0;
+	ei->fd = 0;
 	ei->op.proc_get_link = NULL;
 	ei->pde = NULL;
 	inode = &ei->vfs_inode;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 95a1cf3..8ea21d3 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -46,7 +46,7 @@ static inline struct task_struct *proc_t
 	return PROC_I(inode)->task;
 }
 
-static inline int proc_type(struct inode *inode)
+static inline int proc_fd(struct inode *inode)
 {
-	return PROC_I(inode)->type;
+	return PROC_I(inode)->fd;
 }
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index aa6322d..cab152d 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -247,7 +247,7 @@ extern void kclist_add(struct kcore_list
 
 struct proc_inode {
 	struct task_struct *task;
-	int type;
+	int fd;
 	union {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
 		int (*proc_read)(struct task_struct *task, char *page);
-- 
1.2.2.g709a

