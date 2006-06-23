Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161440AbWFVXRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161440AbWFVXRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWFVXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:17:38 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:7616 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030466AbWFVXRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:17:37 -0400
Date: Fri, 23 Jun 2006 07:17:39 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched_exit: move the callsite to do_exit()
Message-ID: <20060623031739.GA2793@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sched_exit() is called by release_task(). If the task auto-reaps itself
this call happens a bit too early (the task still uses cpu after that).
If the task goes to TASK_ZOMBIE this call is unpredictably delayed.

I think it is better to do sched_exit() right before the last schedule().

We can use read_lock_rcu() instead of write_lock(tasklist). In that case
it is possible that sched_exit() changes ->time_slice/->sleep_avg of the
already dead ->parent, but I think this is tolerable.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc6/kernel/sched.c~MOVE	2006-06-23 04:48:48.000000000 +0400
+++ 2.6.17-rc6/kernel/sched.c	2006-06-23 06:46:57.000000000 +0400
@@ -1479,10 +1479,13 @@ void fastcall wake_up_new_task(task_t *p
  */
 void fastcall sched_exit(task_t *p)
 {
-	task_t *parent = p->parent;
+	task_t *parent;
 	unsigned long flags;
 	runqueue_t *rq;
 
+	rcu_read_lock();
+	parent = p->real_parent;
+
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
@@ -1498,6 +1501,7 @@ void fastcall sched_exit(task_t *p)
 		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
 		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
+	rcu_read_unlock();
 }
 
 /**
--- 2.6.17-rc6/kernel/exit.c~MOVE	2006-06-18 06:10:26.000000000 +0400
+++ 2.6.17-rc6/kernel/exit.c	2006-06-23 05:45:42.000000000 +0400
@@ -170,7 +170,6 @@ repeat:
 		zap_leader = (leader->exit_signal == -1);
 	}
 
-	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
@@ -940,6 +939,8 @@ fastcall NORET_TYPE void do_exit(long co
 	if (tsk->splice_pipe)
 		__free_pipe_info(tsk->splice_pipe);
 
+	sched_exit(tsk);
+
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);

