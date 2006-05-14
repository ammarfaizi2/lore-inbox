Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWENOpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWENOpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWENOpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:45:49 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:43978 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751429AbWENOps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:45:48 -0400
Date: Sun, 14 May 2006 22:45:50 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm, resend] de_thread: fix lockless do_each_thread
Message-ID: <20060514184550.GA89@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should keep the value of old_leader->tasks.next in de_thread,
otherwise we can't do for_each_process/do_each_thread without
tasklist_lock held.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/exec.c~3_RCU	2006-05-14 22:14:42.000000000 +0400
+++ MM/fs/exec.c	2006-05-14 22:32:13.000000000 +0400
@@ -706,7 +706,7 @@ static int de_thread(struct task_struct 
 		attach_pid(current, PIDTYPE_PID,  current->pid);
 		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
 		attach_pid(current, PIDTYPE_SID,  current->signal->session);
-		list_add_tail_rcu(&current->tasks, &init_task.tasks);
+		list_replace_rcu(&leader->tasks, &current->tasks);
 
 		current->group_leader = current;
 		leader->group_leader = current;
@@ -714,7 +714,6 @@ static int de_thread(struct task_struct 
 		/* Reduce leader to a thread */
 		detach_pid(leader, PIDTYPE_PGID);
 		detach_pid(leader, PIDTYPE_SID);
-		list_del_init(&leader->tasks);
 
 		current->exit_signal = SIGCHLD;
 

