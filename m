Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWBWQSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWBWQSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWBWQSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:18:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16279 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751604AbWBWQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:17:59 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/23] proc: Close the race of a process dying durning
 lookup.
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:16:51 -0700
In-Reply-To: <m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:15:15 -0700")
Message-ID: <m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


proc_lookup and task exiting are not synchronized, although some of the
previous code may have suggested that.  Every time before we reuse a dentry
namei.c calls d_op->derevalidate which prevents us from reusing a stale
dcache entry.  Unfortunately it does not prevent us from returning a stale
dcache entry.  This race has been explicitly plugged in proc_pid_lookup
but there is nothing to confine it to just that proc lookup function.

So to prevent the race I call revalidate explictily in all of the
proc lookup functions after I call d_add, and report an error if
the revalidate does not succeed.

Years ago Al Viro did something similar but those changes got lost in
the churn.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |   54 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

aea0459c7bef967ce3345449db5183d4b2dafefe
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9fab7fe..36cddda 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1340,6 +1340,7 @@ static struct dentry *proc_lookupfd(stru
 {
 	struct task_struct *task = proc_task(dir);
 	unsigned fd = name_to_int(dentry);
+	struct dentry *result = ERR_PTR(-ENOENT);
 	struct file * file;
 	struct files_struct * files;
 	struct inode *inode;
@@ -1374,15 +1375,18 @@ static struct dentry *proc_lookupfd(stru
 	ei->op.proc_get_link = proc_fd_link;
 	dentry->d_op = &tid_fd_dentry_operations;
 	d_add(dentry, inode);
-	return NULL;
+	/* Close the race of the process dying before we return the dentry */
+	if (tid_fd_revalidate(dentry, NULL))
+		result = NULL;
+out:
+	return result;
 
 out_unlock2:
 	rcu_read_unlock();
 	put_files_struct(files);
 out_unlock:
 	iput(inode);
-out:
-	return ERR_PTR(-ENOENT);
+	goto out;
 }
 
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir);
@@ -1482,12 +1486,12 @@ static struct dentry *proc_pident_lookup
 					 struct pid_entry *ents)
 {
 	struct inode *inode;
-	int error;
+	struct dentry *error;
 	struct task_struct *task = proc_task(dir);
 	struct pid_entry *p;
 	struct proc_inode *ei;
 
-	error = -ENOENT;
+	error = ERR_PTR(-ENOENT);
 	inode = NULL;
 
 	if (!pid_alive(task))
@@ -1502,7 +1506,7 @@ static struct dentry *proc_pident_lookup
 	if (!p->name)
 		goto out;
 
-	error = -EINVAL;
+	error = ERR_PTR(-EINVAL);
 	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
 	if (!inode)
 		goto out;
@@ -1663,14 +1667,16 @@ static struct dentry *proc_pident_lookup
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
-			return ERR_PTR(-EINVAL);
+			error = ERR_PTR(-EINVAL);
+			goto out;
 	}
 	dentry->d_op = &pid_dentry_operations;
 	d_add(dentry, inode);
-	return NULL;
-
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		error = NULL;
 out:
-	return ERR_PTR(error);
+	return error;
 }
 
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd){
@@ -1846,6 +1852,7 @@ out:
 /* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
+	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
 	struct inode *inode;
 	struct proc_inode *ei;
@@ -1879,12 +1886,9 @@ struct dentry *proc_pid_lookup(struct in
 		goto out;
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
+	if (!inode)
+		goto out_put_task;
 
-
-	if (!inode) {
-		put_task_struct(task);
-		goto out;
-	}
 	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
@@ -1898,21 +1902,20 @@ struct dentry *proc_pid_lookup(struct in
 	dentry->d_op = &pid_dentry_operations;
 
 	d_add(dentry, inode);
-	if (!pid_alive(task)) {
-		d_drop(dentry);
-		shrink_dcache_parent(dentry);
-		goto out;
-	}
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		result = NULL;
 
+out_put_task:
 	put_task_struct(task);
-	return NULL;
 out:
-	return ERR_PTR(-ENOENT);
+	return result;
 }
 
 /* SMP-safe */
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
+	struct dentry *result = ERR_PTR(-ENOENT);
 	struct task_struct *task;
 	struct task_struct *leader = proc_task(dir);
 	struct inode *inode;
@@ -1950,13 +1953,14 @@ static struct dentry *proc_task_lookup(s
 	dentry->d_op = &pid_dentry_operations;
 
 	d_add(dentry, inode);
+	/* Close the race of the process dying before we return the dentry */
+	if (pid_revalidate(dentry, NULL))
+		result = NULL;
 
-	put_task_struct(task);
-	return NULL;
 out_drop_task:
 	put_task_struct(task);
 out:
-	return ERR_PTR(-ENOENT);
+	return result;
 }
 
 #define PROC_NUMBUF 10
-- 
1.2.2.g709a

