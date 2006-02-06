Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWBFTIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWBFTIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWBFTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:08:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:51628 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932192AbWBFTIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:08:25 -0500
Message-ID: <43E7B0BF.D13E1F07@tv-sign.ru>
Date: Mon, 06 Feb 2006 23:25:35 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix kill_proc_info() vs copy_process() race
References: <43E77D3C.C967A275@tv-sign.ru> <43E7830E.974EF20C@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Sorry, I was wrong. Without CLONE_THREAD current->sighand.siglock can't help,
> we need p->sighand.siglock, I beleive.

Also, it is stupid to do write_lock(&tasklist_lock) without clearing irqs.

Ok, may be something like (untested, for review only) patch below ?

attach_pid() does wmb(), group_send_sig_info()->rcu_dereference() calls
rmb(), so we can just reverse PIDTYPE_PID/PIDTYPE_TGID attaching?

Note that now we check sigismember(->pending, SIGKILL) holding both
tasklist and ->sighand.siglock, this means we can kill SIGNAL_GROUP_EXIT
check under 'if (clone_flags & CLONE_THREAD)':

	__group_complete_signal() and zap_other_threads() need at least
	->sighand.siglock and they send SIGKILL without unlocking.

	We can miss SIGNAL_GROUP_EXIT from do_coredump(), but it is possible
	anyway. The new thread will be killed later, from zap_threads().
	
What do you think?

Oleg.

--- RC-1/kernel/fork.c~	2006-02-07 01:41:14.000000000 +0300
+++ RC-1/kernel/fork.c	2006-02-07 02:13:10.000000000 +0300
@@ -1066,11 +1066,13 @@ static task_t *copy_process(unsigned lon
 			!cpu_online(task_cpu(p))))
 		set_task_cpu(p, smp_processor_id());
 
+	spin_lock(&current->sighand->siglock);
 	/*
 	 * Check for pending SIGKILL! The new thread should not be allowed
 	 * to slip out of an OOM kill. (or normal SIGKILL.)
 	 */
 	if (sigismember(&current->pending.signal, SIGKILL)) {
+		spin_unlock(&current->sighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 		retval = -EINTR;
 		goto bad_fork_cleanup_namespace;
@@ -1084,18 +1086,6 @@ static task_t *copy_process(unsigned lon
 	p->parent = p->real_parent;
 
 	if (clone_flags & CLONE_THREAD) {
-		spin_lock(&current->sighand->siglock);
-		/*
-		 * Important: if an exit-all has been started then
-		 * do not create this new thread - the whole thread
-		 * group is supposed to exit anyway.
-		 */
-		if (current->signal->flags & SIGNAL_GROUP_EXIT) {
-			spin_unlock(&current->sighand->siglock);
-			write_unlock_irq(&tasklist_lock);
-			retval = -EAGAIN;
-			goto bad_fork_cleanup_namespace;
-		}
 		p->group_leader = current->group_leader;
 
 		if (current->signal->group_stop_count > 0) {
@@ -1122,8 +1112,6 @@ static task_t *copy_process(unsigned lon
 			 */
 			p->it_prof_expires = jiffies_to_cputime(1);
 		}
-
-		spin_unlock(&current->sighand->siglock);
 	}
 
 	/*
@@ -1135,8 +1123,8 @@ static task_t *copy_process(unsigned lon
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
-	attach_pid(p, PIDTYPE_PID, p->pid);
 	attach_pid(p, PIDTYPE_TGID, p->tgid);
+	attach_pid(p, PIDTYPE_PID, p->pid);
 	if (thread_group_leader(p)) {
 		p->signal->tty = current->signal->tty;
 		p->signal->pgrp = process_group(current);
@@ -1149,6 +1137,7 @@ static task_t *copy_process(unsigned lon
 
 	nr_threads++;
 	total_forks++;
+	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
 	return p;
