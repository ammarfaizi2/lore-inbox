Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWBFP2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWBFP2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWBFP2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:28:39 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:40426 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932085AbWBFP2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:28:38 -0500
Message-ID: <43E77D3C.C967A275@tv-sign.ru>
Date: Mon, 06 Feb 2006 19:45:48 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix kill_proc_info() vs copy_process() race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kill_proc_info() takes taskllist_lock only for sig_kernel_stop()
case nowadays. I beleive it races with copy_process().

The first race is simple, copy_process:

	/*
	 * Check for pending SIGKILL! The new thread should not be allowed
	 * to slip out of an OOM kill. (or normal SIGKILL.)
	 */
	if (sigismember(&current->pending.signal, SIGKILL))
		return EINTR;

This relies on tasklist_lock and is racy now.


The second race is more tricky, copy_process:

	attach_pid(p, PIDTYPE_PID, p->pid);
	attach_pid(p, PIDTYPE_TGID, p->tgid);

This means that we can find a task in kill_proc_info()->find_task_by_pid()
which is not registered as part of thread group yet. Various bad things can
happen, note that handle_stop_signal(SIGCONT) and __group_complete_signal()
iterate over threads list. But p->pids[PIDTYPE_TGID] is a copy of current's
'struct pid' from dup_task_struct(), and if we don't have CLONE_THREAD here
we will use completely unreleated (parent's) thread list.

I think we can solve these problems by enlarging a ->siglock's scope in
copy_process(), but I don't know how to test this patch.

NOTE: release_task()->__unhash_process() path is safe, we already have
->sighand == NULL while detaching PIDTYPE_PID/PIDTYPE_TGID nonatomically.

Unless I missed something, I personally think this is a 2.6.16 material.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/fork.c~	2006-02-06 22:04:40.000000000 +0300
+++ RC-1/kernel/fork.c	2006-02-06 22:11:51.000000000 +0300
@@ -1050,7 +1050,7 @@ static task_t *copy_process(unsigned lon
 	sched_fork(p, clone_flags);
 
 	/* Need tasklist lock for parent etc handling! */
-	write_lock_irq(&tasklist_lock);
+	write_lock(&tasklist_lock);
 
 	/*
 	 * The task hasn't been attached yet, so its cpus_allowed mask will
@@ -1066,33 +1066,34 @@ static task_t *copy_process(unsigned lon
 			!cpu_online(task_cpu(p))))
 		set_task_cpu(p, smp_processor_id());
 
+	/* CLONE_PARENT re-uses the old parent */
+	if (clone_flags & (CLONE_PARENT|CLONE_THREAD))
+		p->real_parent = current->real_parent;
+	else
+		p->real_parent = current;
+	p->parent = p->real_parent;
+
+	spin_lock_irq(&current->sighand->siglock);
 	/*
 	 * Check for pending SIGKILL! The new thread should not be allowed
 	 * to slip out of an OOM kill. (or normal SIGKILL.)
 	 */
 	if (sigismember(&current->pending.signal, SIGKILL)) {
-		write_unlock_irq(&tasklist_lock);
+		spin_unlock_irq(&current->sighand->siglock);
+		write_unlock(&tasklist_lock);
 		retval = -EINTR;
 		goto bad_fork_cleanup_namespace;
 	}
 
-	/* CLONE_PARENT re-uses the old parent */
-	if (clone_flags & (CLONE_PARENT|CLONE_THREAD))
-		p->real_parent = current->real_parent;
-	else
-		p->real_parent = current;
-	p->parent = p->real_parent;
-
 	if (clone_flags & CLONE_THREAD) {
-		spin_lock(&current->sighand->siglock);
 		/*
 		 * Important: if an exit-all has been started then
 		 * do not create this new thread - the whole thread
 		 * group is supposed to exit anyway.
 		 */
 		if (current->signal->flags & SIGNAL_GROUP_EXIT) {
-			spin_unlock(&current->sighand->siglock);
-			write_unlock_irq(&tasklist_lock);
+			spin_unlock_irq(&current->sighand->siglock);
+			write_unlock(&tasklist_lock);
 			retval = -EAGAIN;
 			goto bad_fork_cleanup_namespace;
 		}
@@ -1122,8 +1123,6 @@ static task_t *copy_process(unsigned lon
 			 */
 			p->it_prof_expires = jiffies_to_cputime(1);
 		}
-
-		spin_unlock(&current->sighand->siglock);
 	}
 
 	/*
@@ -1151,7 +1150,9 @@ static task_t *copy_process(unsigned lon
 
 	nr_threads++;
 	total_forks++;
-	write_unlock_irq(&tasklist_lock);
+	spin_unlock_irq(&current->sighand->siglock);
+	write_unlock(&tasklist_lock);
+
 	proc_fork_connector(p);
 	return p;
