Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161464AbWALX0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464AbWALX0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161456AbWALX0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:26:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54446 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161464AbWALX0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:26:35 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: John Hesterberg <jh@sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
In-Reply-To: <yq0fynt3gv6.fsf@jaguar.mkp.net>
References: <1136414431.22868.115.camel@stark>
	 <20060104151730.77df5bf6.akpm@osdl.org> <1136486566.22868.127.camel@stark>
	 <1136488842.22868.142.camel@stark> <20060105151016.732612fd.akpm@osdl.org>
	 <1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
	 <43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
	 <1137013330.6673.80.camel@stark> <20060111213910.GA17986@sgi.com>
	 <1137019367.6673.97.camel@stark>  <yq0fynt3gv6.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 15:20:30 -0800
Message-Id: <1137108030.6673.255.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 05:01 -0500, Jes Sorensen wrote:
> >>>>> "Matt" == Matt Helsley <matthltc@us.ibm.com> writes:
> 
> Matt> On Wed, 2006-01-11 at 15:39 -0600, John Hesterberg wrote:
> >> I have two concerns about an all-tasks notification interface.
> >> First, we want this to scale, so don't want more global locks.  One
> >> unique part of the task notify is that it doesn't use locks.
> 
> Matt> 	Are you against global locks in these paths based solely on
> Matt> principle or have you measured their impact on scalability in
> Matt> those locations?
> 
> Matt,
> 
> It all depends on the specific location of the locks and how often
> they are taken. As long as something is taken by the same CPU all the
> time is not going to be a major issue, but if we end up with anything
> resembling a global lock, even if it is only held for a very short
> time, it is going to bite badly. On a 4-way you probably won't notice,
> but go to a 64-way and it bites, on a 512-way it eats you alive (we
> had a problem in the timer code quite a while back that prevented the
> machine from booting - it wasn't a lock that was held for a long time,
> just the fact that every CPU would take it every HZ was enough).

	OK, so you've established that global locks in timer paths are Bad.
However you haven't established that timer paths are almost the same as
the task paths we're talking about. I suspect timer paths are used much
more frequently than fork, exec, or exit.

	I've appended a small patch that adds a global lock to the task_notify
paths for testing purposes. I'm curious to know what kind of a
performance difference you would see on your 64 or 512-way if you were
to run with it.

	Looking at the ideas for lockless implementations I'm curious how well
Keith's notifier chains patch would work in this case. It does not
acquire a global lock in the "call" path and, as Keith suggested,
probably can be modified to avoid cache bouncing.

Cheers,
	-Matt Helsley

> Matt> 	Without measurement there are two conflicting principles here:
> Matt> code complexity vs. scalability.
> 
> The two should never be mutually exlusive as long as we are careful.
> 
> Matt> 	If you've made measurements I'm curious to know what kind of
> Matt> locks were measured, where they were used, what the load was
> Matt> doing -- as a rough characterization of the pattern of
> Matt> notifications -- and how much it impacted scalability. This
> Matt> information might help suggest a better solution.
> 
> The one I mentioned above was in the timer interrupt path.
> 
> Cheers,
> Jes


Index: linux-2.6.15/kernel/fork.c
===================================================================
--- linux-2.6.15.orig/kernel/fork.c
+++ linux-2.6.15/kernel/fork.c
@@ -849,10 +849,12 @@ asmlinkage long sys_set_tid_address(int 
 	current->clear_child_tid = tidptr;
 
 	return current->pid;
 }
 
+extern spinlock_t proposed_global_lock;
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
  *
  * It copies the registers, and all the appropriate
@@ -1137,12 +1139,14 @@ static task_t *copy_process(unsigned lon
 		p->signal->tty = NULL;
 
 	nr_threads++;
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);
+	spin_lock(&proposed_global_lock);
 	proc_fork_connector(p);
 	cpuset_fork(p);
+	spin_unlock(&proposed_global_lock);
 	retval = 0;
 
 fork_out:
 	if (retval)
 		return ERR_PTR(retval);
Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c
+++ linux-2.6.15/kernel/exit.c
@@ -784,10 +784,11 @@ static void exit_notify(struct task_stru
 	/* If the process is dead, release it - nobody will wait for it */
 	if (state == EXIT_DEAD)
 		release_task(tsk);
 }
 
+extern spinlock_t proposed_global_lock;
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
 	int group_dead;
 
@@ -844,10 +845,12 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead) {
  		del_timer_sync(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
+	spin_lock(&proposed_global_lock);
+	spin_unlock(&proposed_global_lock);
 	exit_mm(tsk);
 
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
Index: linux-2.6.15/fs/exec.c
===================================================================
--- linux-2.6.15.orig/fs/exec.c
+++ linux-2.6.15/fs/exec.c
@@ -1121,10 +1121,12 @@ int search_binary_handler(struct linux_b
 	return retval;
 }
 
 EXPORT_SYMBOL(search_binary_handler);
 
+extern spinlock_t proposed_global_lock;
+
 /*
  * sys_execve() executes a new program.
  */
 int do_execve(char * filename,
 	char __user *__user *argv,
@@ -1190,10 +1192,12 @@ int do_execve(char * filename,
 
 	retval = copy_strings(bprm->argc, argv, bprm);
 	if (retval < 0)
 		goto out;
 
+	spin_lock(&proposed_global_lock);
+	spin_unlock(&proposed_global_lock);
 	retval = search_binary_handler(bprm,regs);
 	if (retval >= 0) {
 		free_arg_pages(bprm);
 
 		/* execve success */
Index: linux-2.6.15/init/main.c
===================================================================
--- linux-2.6.15.orig/init/main.c
+++ linux-2.6.15/init/main.c
@@ -440,10 +440,11 @@ void __init parse_early_param(void)
 
 /*
  *	Activate the first processor.
  */
 
+spinlock_t proposed_global_lock = SPIN_LOCK_UNLOCKED;
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
 /*


