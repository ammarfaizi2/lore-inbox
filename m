Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWBFTZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWBFTZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWBFTZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:25:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58604 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932308AbWBFTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:25:29 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 01/20] pid: Intoduce the concept of a wid (wait id)
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:22:40 -0700
In-Reply-To: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Mon, 06 Feb 2006 12:19:30 -0700")
Message-ID: <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The wait id is the pid returned by wait.  For tasks that span 2
namespaces (i.e. the process leaders of the pid namespaces) their
parent knows the task by a different PID value than the task knows
itself. Having a child with PID == 1 would be confusing. 

This patch introduces the wid and walks through kernel and modifies
the places that observe the pid from the parent processes perspective
to use the wid instead of the pid. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/sched.h |    1 +
 kernel/exit.c         |   18 +++++++++---------
 kernel/fork.c         |    4 ++--
 kernel/sched.c        |    2 +-
 kernel/signal.c       |    6 +++---
 5 files changed, 16 insertions(+), 15 deletions(-)

598714d79648463ab3f2cbf6f6acd3cd6c09c87a
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f368048..e8ea561 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -740,6 +740,7 @@ struct task_struct {
 	/* ??? */
 	unsigned long personality;
 	unsigned did_exec:1;
+	pid_t wid;
 	pid_t pid;
 	pid_t tgid;
 	/* 
diff --git a/kernel/exit.c b/kernel/exit.c
index fb4c8b1..749bc8b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -941,7 +941,7 @@ asmlinkage void sys_exit_group(int error
 static int eligible_child(pid_t pid, int options, task_t *p)
 {
 	if (pid > 0) {
-		if (p->pid != pid)
+		if (p->wid != pid)
 			return 0;
 	} else if (!pid) {
 		if (process_group(p) != process_group(current))
@@ -1018,7 +1018,7 @@ static int wait_task_zombie(task_t *p, i
 	int status;
 
 	if (unlikely(noreap)) {
-		pid_t pid = p->pid;
+		pid_t pid = p->wid;
 		uid_t uid = p->uid;
 		int exit_code = p->exit_code;
 		int why, status;
@@ -1130,7 +1130,7 @@ static int wait_task_zombie(task_t *p, i
 			retval = put_user(status, &infop->si_status);
 	}
 	if (!retval && infop)
-		retval = put_user(p->pid, &infop->si_pid);
+		retval = put_user(p->wid, &infop->si_pid);
 	if (!retval && infop)
 		retval = put_user(p->uid, &infop->si_uid);
 	if (retval) {
@@ -1138,7 +1138,7 @@ static int wait_task_zombie(task_t *p, i
 		p->exit_state = EXIT_ZOMBIE;
 		return retval;
 	}
-	retval = p->pid;
+	retval = p->wid;
 	if (p->real_parent != p->parent) {
 		write_lock_irq(&tasklist_lock);
 		/* Double-check with lock held.  */
@@ -1198,7 +1198,7 @@ static int wait_task_stopped(task_t *p, 
 	read_unlock(&tasklist_lock);
 
 	if (unlikely(noreap)) {
-		pid_t pid = p->pid;
+		pid_t pid = p->wid;
 		uid_t uid = p->uid;
 		int why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
 
@@ -1269,11 +1269,11 @@ bail_ref:
 	if (!retval && infop)
 		retval = put_user(exit_code, &infop->si_status);
 	if (!retval && infop)
-		retval = put_user(p->pid, &infop->si_pid);
+		retval = put_user(p->wid, &infop->si_pid);
 	if (!retval && infop)
 		retval = put_user(p->uid, &infop->si_uid);
 	if (!retval)
-		retval = p->pid;
+		retval = p->wid;
 	put_task_struct(p);
 
 	BUG_ON(!retval);
@@ -1310,7 +1310,7 @@ static int wait_task_continued(task_t *p
 		p->signal->flags &= ~SIGNAL_STOP_CONTINUED;
 	spin_unlock_irq(&p->sighand->siglock);
 
-	pid = p->pid;
+	pid = p->wid;
 	uid = p->uid;
 	get_task_struct(p);
 	read_unlock(&tasklist_lock);
@@ -1321,7 +1321,7 @@ static int wait_task_continued(task_t *p
 		if (!retval && stat_addr)
 			retval = put_user(0xffff, stat_addr);
 		if (!retval)
-			retval = p->pid;
+			retval = pid;
 	} else {
 		retval = wait_noreap_copyout(p, pid, uid,
 					     CLD_CONTINUED, SIGCONT,
diff --git a/kernel/fork.c b/kernel/fork.c
index f4a7281..743d46c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -931,10 +931,10 @@ static task_t *copy_process(unsigned lon
 
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
-	p->pid = pid;
+	p->wid = p->pid = pid;
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
-		if (put_user(p->pid, parent_tidptr))
+		if (put_user(p->wid, parent_tidptr))
 			goto bad_fork_cleanup;
 
 	p->proc_dentry = NULL;
diff --git a/kernel/sched.c b/kernel/sched.c
index f77f23f..6579d49 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1674,7 +1674,7 @@ asmlinkage void schedule_tail(task_t *pr
 	preempt_enable();
 #endif
 	if (current->set_child_tid)
-		put_user(current->pid, current->set_child_tid);
+		put_user(current->wid, current->set_child_tid);
 }
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index 1f54ed7..70c226c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1564,7 +1564,7 @@ void do_notify_parent(struct task_struct
 
 	info.si_signo = sig;
 	info.si_errno = 0;
-	info.si_pid = tsk->pid;
+	info.si_pid = tsk->wid;
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -1629,7 +1629,7 @@ static void do_notify_parent_cldstop(str
 
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
-	info.si_pid = tsk->pid;
+	info.si_pid = tsk->wid;
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
@@ -1732,7 +1732,7 @@ void ptrace_notify(int exit_code)
 	memset(&info, 0, sizeof info);
 	info.si_signo = SIGTRAP;
 	info.si_code = exit_code;
-	info.si_pid = current->pid;
+	info.si_pid = current->wid;
 	info.si_uid = current->uid;
 
 	/* Let the debugger run.  */
-- 
1.1.5.g3480

