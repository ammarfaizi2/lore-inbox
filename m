Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWBWQTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWBWQTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWBWQTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:19:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18327 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751619AbWBWQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:19:51 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/23] proc: Make PROC_NUMBUF the buffer size for holding a
 integers as strings.
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
	<m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:18:44 -0700
In-Reply-To: <m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:16:51 -0700")
Message-ID: <m1vev6f3q3.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently in /proc at several different places we define buffers to
hold a process id, or a file descriptor .  In most of them we use
either a hard coded number or a different define.  Modify them all to
use PROC_NUMBUF, so the code has a chance of being maintained. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

43e5ec3ac1c2badfd746bc7f17f60235dfde549f
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 36cddda..1ab12e5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -181,6 +181,9 @@ enum pid_directory_inos {
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
+/* Worst case buffer size needed for holding an integer. */
+#define PROC_NUMBUF 10
+
 struct pid_entry {
 	int type;
 	int len;
@@ -725,12 +728,12 @@ static ssize_t oom_adjust_read(struct fi
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
-	char buffer[8];
+	char buffer[PROC_NUMBUF];
 	size_t len;
 	int oom_adjust = task->oomkilladj;
 	loff_t __ppos = *ppos;
 
-	len = sprintf(buffer, "%i\n", oom_adjust);
+	len = snprintf(buffer, sizeof(buffer), "%i\n", oom_adjust);
 	if (__ppos >= len)
 		return 0;
 	if (count > len-__ppos)
@@ -745,14 +748,14 @@ static ssize_t oom_adjust_write(struct f
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
-	char buffer[8], *end;
+	char buffer[PROC_NUMBUF], *end;
 	int oom_adjust;
 
 	if (!capable(CAP_SYS_RESOURCE))
 		return -EPERM;
-	memset(buffer, 0, 8);
-	if (count > 6)
-		count = 6;
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count))
 		return -EFAULT;
 	oom_adjust = simple_strtol(buffer, &end, 0);
@@ -1037,8 +1040,6 @@ static struct inode_operations proc_pid_
 	.follow_link	= proc_pid_follow_link
 };
 
-#define NUMBUF 10
-
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
 	struct dentry *dentry = filp->f_dentry;
@@ -1046,7 +1047,7 @@ static int proc_readfd(struct file * fil
 	struct task_struct *p = proc_task(inode);
 	unsigned int fd, tid, ino;
 	int retval;
-	char buf[NUMBUF];
+	char buf[PROC_NUMBUF];
 	struct files_struct * files;
 	struct fdtable *fdt;
 
@@ -1082,7 +1083,7 @@ static int proc_readfd(struct file * fil
 					continue;
 				rcu_read_unlock();
 
-				j = NUMBUF;
+				j = PROC_NUMBUF;
 				i = fd;
 				do {
 					j--;
@@ -1091,7 +1092,7 @@ static int proc_readfd(struct file * fil
 				} while (i);
 
 				ino = fake_ino(tid, PROC_TID_FD_DIR + fd);
-				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
+				if (filldir(dirent, buf+j, PROC_NUMBUF-j, fd+2, ino, DT_LNK) < 0) {
 					rcu_read_lock();
 					break;
 				}
@@ -1757,14 +1758,14 @@ static struct inode_operations proc_tid_
 static int proc_self_readlink(struct dentry *dentry, char __user *buffer,
 			      int buflen)
 {
-	char tmp[30];
+	char tmp[PROC_NUMBUF];
 	sprintf(tmp, "%d", current->tgid);
 	return vfs_readlink(dentry,buffer,buflen,tmp);
 }
 
 static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	char tmp[30];
+	char tmp[PROC_NUMBUF];
 	sprintf(tmp, "%d", current->tgid);
 	return ERR_PTR(vfs_follow_link(nd,tmp));
 }	
@@ -1798,7 +1799,7 @@ static struct inode_operations proc_self
 void proc_flush_task(struct task_struct *task)
 {
 	struct dentry *dentry, *leader, *dir;
-	char buf[30];
+	char buf[PROC_NUMBUF];
 	struct qstr name;
 
 	name.name = buf;
@@ -1963,7 +1964,6 @@ out:
 	return result;
 }
 
-#define PROC_NUMBUF 10
 #define PROC_MAXPIDS 20
 
 /*
-- 
1.2.2.g709a

