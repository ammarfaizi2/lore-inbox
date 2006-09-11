Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWIKCZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWIKCZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 22:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWIKCZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 22:25:41 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:60088 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751029AbWIKCZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 22:25:40 -0400
Date: Mon, 11 Sep 2006 06:25:35 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] introduce get_task_pid() to fix unsafe get_pid()
Message-ID: <20060911022535.GA7095@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(COMPILE TESTED, needs an ack from Eric)

proc_pid_make_inode:

	ei->pid = get_pid(task_pid(task));

I think this is not safe. get_pid() can be preempted after checking
"pid != NULL". Then the task exits, does detach_pid(), and RCU frees
the pid.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc6-mm1/include/linux/pid.h~1_tgp	2006-09-09 22:34:50.000000000 +0400
+++ rc6-mm1/include/linux/pid.h	2006-09-11 05:46:14.000000000 +0400
@@ -68,6 +68,8 @@ extern struct task_struct *FASTCALL(pid_
 extern struct task_struct *FASTCALL(get_pid_task(struct pid *pid,
 						enum pid_type));
 
+extern struct pid *get_task_pid(struct task_struct *task, enum pid_type type);
+
 /*
  * attach_pid() and detach_pid() must be called with the tasklist_lock
  * write-held.
--- rc6-mm1/kernel/pid.c~1_tgp	2006-09-09 22:34:50.000000000 +0400
+++ rc6-mm1/kernel/pid.c	2006-09-11 05:39:23.000000000 +0400
@@ -305,6 +305,15 @@ struct task_struct *find_task_by_pid_typ
 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
+struct pid *get_task_pid(struct task_struct *task, enum pid_type type)
+{
+	struct pid *pid;
+	rcu_read_lock();
+	pid = get_pid(task->pids[type].pid);
+	rcu_read_unlock();
+	return pid;
+}
+
 struct task_struct *fastcall get_pid_task(struct pid *pid, enum pid_type type)
 {
 	struct task_struct *result;
--- rc6-mm1/fs/proc/base.c~1_tgp	2006-09-09 22:34:49.000000000 +0400
+++ rc6-mm1/fs/proc/base.c	2006-09-11 05:56:19.000000000 +0400
@@ -958,7 +958,7 @@ static struct inode *proc_pid_make_inode
 	/*
 	 * grab the reference to task.
 	 */
-	ei->pid = get_pid(task_pid(task));
+	ei->pid = get_task_pid(task, PIDTYPE_PID);
 	if (!ei->pid)
 		goto out_unlock;
 
@@ -1665,7 +1665,7 @@ static struct dentry *proc_base_instanti
 	/*
 	 * grab the reference to the task.
 	 */
-	ei->pid = get_pid(task_pid(task));
+	ei->pid = get_task_pid(task, PIDTYPE_PID);
 	if (!ei->pid)
 		goto out_iput;
 

