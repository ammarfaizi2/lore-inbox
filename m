Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752379AbWCPQE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbWCPQE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbWCPQE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:04:26 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:64142 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1752378AbWCPQEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:04:25 -0500
Message-ID: <44198BC4.EE653B1@tv-sign.ru>
Date: Thu, 16 Mar 2006 19:01:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: [PATCH] make fork() atomic wrt pgrp/session signals
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> Ok. SUSV3/Posix is clear, fork is atomic with respect
> to signals.  Either a signal comes before or after a
> fork but not during. (See the rationale section).
> http://www.opengroup.org/onlinepubs/000095399/functions/fork.html
>
> The tasklist_lock does not stop forks from adding to a process
> group. The forks stall while the tasklist_lock is held, but a fork
> that began before we grabbed the tasklist_lock simply completes
> afterwards, and the child does not receive the signal.

This also means that SIGSTOP or sig_kernel_coredump() signal can't
be delivered to pgrp/session reliably.

With this patch copy_process() returns -ERESTARTNOINTR when it
detects a pending signal, fork() will be restarted transparently
after handling the signals.

This patch also deletes now unneeded "group_stop_count > 0" check,
copy_process() can no longer succeed while group stop in progress.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/fork.c~	2006-03-13 15:04:52.000000000 +0300
+++ MM/kernel/fork.c	2006-03-16 21:51:12.000000000 +0300
@@ -1129,16 +1129,6 @@ static task_t *copy_process(unsigned lon
 			!cpu_online(task_cpu(p))))
 		set_task_cpu(p, smp_processor_id());
 
-	/*
-	 * Check for pending SIGKILL! The new thread should not be allowed
-	 * to slip out of an OOM kill. (or normal SIGKILL.)
-	 */
-	if (sigismember(&current->pending.signal, SIGKILL)) {
-		write_unlock_irq(&tasklist_lock);
-		retval = -EINTR;
-		goto bad_fork_cleanup_namespace;
-	}
-
 	/* CLONE_PARENT re-uses the old parent */
 	if (clone_flags & (CLONE_PARENT|CLONE_THREAD))
 		p->real_parent = current->real_parent;
@@ -1147,6 +1137,23 @@ static task_t *copy_process(unsigned lon
 	p->parent = p->real_parent;
 
 	spin_lock(&current->sighand->siglock);
+
+	/*
+	 * Process group and session signals need to be delivered to just the
+	 * parent before the fork or both the parent and the child after the
+	 * fork. Restart if a signal comes in before we add the new process to
+	 * it's process group.
+	 * A fatal signal pending means that current will exit, so the new
+	 * thread can't slip out of an OOM kill (or normal SIGKILL).
+ 	 */
+ 	recalc_sigpending();
+	if (signal_pending(current)) {
+		spin_unlock(&current->sighand->siglock);
+		write_unlock_irq(&tasklist_lock);
+		retval = -ERESTARTNOINTR;
+		goto bad_fork_cleanup_namespace;
+	}
+
 	if (clone_flags & CLONE_THREAD) {
 		/*
 		 * Important: if an exit-all has been started then
@@ -1163,16 +1170,6 @@ static task_t *copy_process(unsigned lon
 		p->group_leader = current->group_leader;
 		list_add_tail_rcu(&p->thread_group, &p->group_leader->thread_group);
 
-		if (current->signal->group_stop_count > 0) {
-			/*
-			 * There is an all-stop in progress for the group.
-			 * We ourselves will stop as soon as we check signals.
-			 * Make the new thread part of that group stop too.
-			 */
-			current->signal->group_stop_count++;
-			set_tsk_thread_flag(p, TIF_SIGPENDING);
-		}
-
 		if (!cputime_eq(current->signal->it_virt_expires,
 				cputime_zero) ||
 		    !cputime_eq(current->signal->it_prof_expires,
