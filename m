Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWDFSHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWDFSHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWDFSHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:07:11 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:64663 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932101AbWDFSHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:07:10 -0400
Date: Fri, 7 Apr 2006 02:04:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH rc1-mm] de_thread: fix deadlockable process addition
Message-ID: <20060406220403.GA205@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of
	task-make-task-list-manipulations-rcu-safe.patch
	
This patch
	pidhash-kill-switch_exec_pids.patch

changed de_thread() so that it doesn't remove 'leader' from it's thread group.
However de_thread() still adds current to init_task.tasks without removing
'leader' from this list. What if another CLONE_VM task starts do_coredump()
after de_thread() drops tasklist_lock but before it calls release_task(leader) ?

do_coredump()->zap_threads() will find this thread group twice on init_task.tasks
list. And it will increment mm->core_waiters twice for the new leader (current in
de_thread). So, exit_mm()->complete(mm->core_startup_done) doesn't happen, and we
have a deadlock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/exec.c~0_DET	2006-04-06 22:37:33.000000000 +0400
+++ MM/fs/exec.c	2006-04-06 22:51:51.000000000 +0400
@@ -713,7 +713,7 @@ static int de_thread(struct task_struct 
 		attach_pid(current, PIDTYPE_PID,  current->pid);
 		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
 		attach_pid(current, PIDTYPE_SID,  current->signal->session);
-		list_add_tail_rcu(&current->tasks, &init_task.tasks);
+		list_replace_rcu(&leader->tasks, &current->tasks);
 
 		current->parent = current->real_parent = leader->real_parent;
 		leader->parent = leader->real_parent = child_reaper;
--- MM/kernel/exit.c~0_DET	2006-03-23 23:02:53.000000000 +0300
+++ MM/kernel/exit.c	2006-04-06 23:01:37.000000000 +0400
@@ -55,7 +55,9 @@ static void __unhash_process(struct task
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
 
-		list_del_rcu(&p->tasks);
+		/* see de_thread()->list_replace_rcu() */
+		if (likely(p->tasks.prev != LIST_POISON2))
+			list_del_rcu(&p->tasks);
 		__get_cpu_var(process_counts)--;
 	}
 	list_del_rcu(&p->thread_group);

