Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWIKEh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWIKEh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 00:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWIKEh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 00:37:56 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:44997 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751147AbWIKEhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 00:37:55 -0400
Date: Mon, 11 Sep 2006 08:37:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce get_task_pid() to fix unsafe get_pid()
Message-ID: <20060911043751.GA7320@oleg>
References: <20060911022535.GA7095@oleg> <m1venvawbi.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1venvawbi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Eric W. Biederman wrote:
> 
> As for the functions can we build them in all 4 varieties.
> struct pid *get_task_pid(struct task *);
> struct pid *get_task_tgid(struct task *);
> struct pid *get_task_pgrp(struct task *);
> struct pid *get_task_session(struct task *);

Something like the patch below?

> Either that or we can just drop in some rcu_read_lock() rcu_read_unlock()
> into the call sites.

Possible. I don't have a strong opinion, please feel free to send
a different patch.

[PATCH] introduce get_task_pid() to fix unsafe get_pid()

proc_pid_make_inode:

	ei->pid = get_pid(task_pid(task));

I think this is not safe. get_pid() can be preempted after checking
"pid != NULL". Then the task exits, does detach_pid(), and RCU frees
the pid.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc6-mm1/include/linux/pid.h~1_tgp	2006-09-09 22:34:50.000000000 +0400
+++ rc6-mm1/include/linux/pid.h	2006-09-11 08:24:15.000000000 +0400
@@ -68,6 +68,8 @@ extern struct task_struct *FASTCALL(pid_
 extern struct task_struct *FASTCALL(get_pid_task(struct pid *pid,
 						enum pid_type));
 
+extern struct pid *__get_task_pid(struct task_struct *task, enum pid_type type);
+
 /*
  * attach_pid() and detach_pid() must be called with the tasklist_lock
  * write-held.
--- rc6-mm1/kernel/pid.c~1_tgp	2006-09-09 22:34:50.000000000 +0400
+++ rc6-mm1/kernel/pid.c	2006-09-11 08:24:21.000000000 +0400
@@ -305,6 +305,15 @@ struct task_struct *find_task_by_pid_typ
 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
+struct pid *__get_task_pid(struct task_struct *task, enum pid_type type)
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
--- rc6-mm1/include/linux/sched.h~1_tgp	2006-09-09 22:34:50.000000000 +0400
+++ rc6-mm1/include/linux/sched.h	2006-09-11 08:26:29.000000000 +0400
@@ -1073,6 +1073,11 @@ static inline struct pid *task_session(s
 	return task->group_leader->pids[PIDTYPE_SID].pid;
 }
 
+static inline struct pid *get_task_pid(struct task_struct *task)
+{
+	return __get_task_pid(task, PIDTYPE_PID);
+}
+
 /**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.
--- rc6-mm1/fs/proc/base.c~1_tgp	2006-09-09 22:34:49.000000000 +0400
+++ rc6-mm1/fs/proc/base.c	2006-09-11 08:27:12.000000000 +0400
@@ -958,7 +958,7 @@ static struct inode *proc_pid_make_inode
 	/*
 	 * grab the reference to task.
 	 */
-	ei->pid = get_pid(task_pid(task));
+	ei->pid = get_task_pid(task);
 	if (!ei->pid)
 		goto out_unlock;
 
@@ -1665,7 +1665,7 @@ static struct dentry *proc_base_instanti
 	/*
 	 * grab the reference to the task.
 	 */
-	ei->pid = get_pid(task_pid(task));
+	ei->pid = get_task_pid(task);
 	if (!ei->pid)
 		goto out_iput;
 

