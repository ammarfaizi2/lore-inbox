Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSIKMbN>; Wed, 11 Sep 2002 08:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSIKMbN>; Wed, 11 Sep 2002 08:31:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56226 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317326AbSIKMbE>;
	Wed, 11 Sep 2002 08:31:04 -0400
Date: Wed, 11 Sep 2002 14:41:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sys_exit_group(), threading, 2.5.34
Message-ID: <Pine.LNX.4.44.0209111416260.13940-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) is another step to have better
threading support under Linux, it implements the sys_exit_group() system
call.

it's a straightforward extension of the generic 'thread group' concept,
which extension also comes handy to solve a number of problems when
implementing POSIX threads.

POSIX exit() [the C library function] has the following semantics: all
thread have to exit and the waiting parent has to get the exit code that
was specified for the exit() function. It also has to be ensured that
every thread has truly finished its work by the time the parent gets the
notification. The exit code has to be propagated properly to the parent
thread even if not the thread group leader calls the exit() function.

Normal single-thread exit is done via the pthread_exit() function, which
calls sys_exit().

previous incarnations of Linux POSIX threads implementations chose the
following solution: send a 'thread management' signal to the thread group
leader via tkill(), which thread goes around and kills every thread in the
group (except itself), then calls sys_exit() with the proper exit code.  
Both old libpthreads and NGPT use this solution.

this works to a certain degree, unless a userspace threading library uses
the initial thread for normal thread work [like the new libpthreads],
which 'work' can cause the initial thread to exit prematurely.

At this point the threading library has to catch the group leader in
pthread_exit() and has to keep the management thread 'hanging around'
artificially, waiting for the management signal. Besides being slightly
confusing to users ('why is this thread still around?') even this variant
is unrobust: if the initial thread is killed by the kernel (SIGSEGV or any
other thread-specific event that triggers do_exit()) then the thread goes
away without the thread library having a chance to intervene.

the sys_exit_group() syscall implements the mechanism within the kernel,
which, besides robustness, is also *much* faster. Instead of the threading
library having to tkill() every thread available, the kernel can use the
already existing 'broadcast signal' capability. (the threading library
cannot use broadcast signals because that would kill the initial thread as
well.)

as a side-effect of the completion mechanism used by sys_exit_group() it
was also possible to make the initial thread hang around as a zombie until
every other thread in the group has exited. A 'Z' state thread is much
easier to understand by users - it's around because it has to wait for all
other threads to exit first.

and as a side-effect of the initial thread hanging around in a guaranteed
way, there are three advantages:

 - signals sent to the thread group via sys_kill() work again. Previously 
   if the initial thread exited then all subsequent sys_kill() calls to 
   the group PID failed with a -ESRCH.

 - the get_pid() function got faster: it does not have to check for tgid 
   collision anymore.

 - procps has an easier job displaying threaded applications - since the 
   thread group leader is always around, no thread group can 'hide' from 
   procps just because the thread group leader has exited.

 [ - NOTE: the same mechanism can/will also be used by the upcoming
     threaded-coredumps patch. ]

there's also another (small) advantage for threading libraries: eg. the
new libpthreads does not even have any notion of 'group of threads'
anymore - it does not maintain any global list of threads. Via this
syscall it can purely rely on the kernel to manage thread groups.

the patch itself does some internal changes to the way a thread exits: now
the unhashing of the PID and the signal-freeing is done atomically. This
is needed to make sure the thread group leader unhashes itself precisely
when the last thread group member has exited.

(the sys_exit_group() syscall has been used by glibc's new libpthreads
code for the past couple of weeks and the concept is working just fine.)
 
	Ingo

--- linux/arch/i386/kernel/entry.S.orig	Wed Sep 11 13:53:32 2002
+++ linux/arch/i386/kernel/entry.S	Wed Sep 11 14:03:49 2002
@@ -759,6 +759,7 @@
 	.long sys_io_getevents
 	.long sys_io_submit
 	.long sys_io_cancel
+	.long sys_exit_group	/* 250 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/include/linux/sched.h.orig	Wed Sep 11 12:28:09 2002
+++ linux/include/linux/sched.h	Wed Sep 11 14:15:11 2002
@@ -27,6 +27,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 
 struct exec_domain;
 
@@ -128,8 +129,6 @@
 	int sched_priority;
 };
 
-struct completion;
-
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
@@ -216,6 +215,12 @@
         task_t                  *curr_target;
 
 	struct sigpending	shared_pending;
+
+	/* thread group exit support */
+	int			group_exit;
+	int			group_exit_code;
+
+	struct completion	group_exit_done;
 };
 
 /*
@@ -555,6 +560,7 @@
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern int send_sig(int, struct task_struct *, int);
+extern int __broadcast_thread_group(struct task_struct *p, int sig);
 extern int kill_pg(pid_t, int, int);
 extern int kill_sl(pid_t, int, int);
 extern int kill_proc(pid_t, int, int);
@@ -661,6 +667,7 @@
 extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
+extern void __exit_sighand(struct task_struct *);
 extern void remove_thread_group(struct task_struct *tsk, struct signal_struct *sig);
 
 extern void reparent_to_init(void);
--- linux/fs/exec.c.orig	Wed Sep 11 12:28:17 2002
+++ linux/fs/exec.c	Wed Sep 11 14:01:45 2002
@@ -513,6 +513,9 @@
 		return -ENOMEM;
 	spin_lock_init(&newsig->siglock);
 	atomic_set(&newsig->count, 1);
+	newsig->group_exit = 0;
+	newsig->group_exit_code = 0;
+	init_completion(&newsig->group_exit_done);
 	memcpy(newsig->action, current->sig->action, sizeof(newsig->action));
 	init_sigpending(&newsig->shared_pending);
 
--- linux/kernel/exit.c.orig	Wed Sep 11 12:22:31 2002
+++ linux/kernel/exit.c	Wed Sep 11 14:10:30 2002
@@ -29,10 +29,9 @@
 
 int getrusage(struct task_struct *, int, struct rusage *);
 
-static inline void __unhash_process(struct task_struct *p)
+static struct dentry * __unhash_process(struct task_struct *p)
 {
 	struct dentry *proc_dentry;
-	write_lock_irq(&tasklist_lock);
 	nr_threads--;
 	unhash_pid(p);
 	REMOVE_LINKS(p);
@@ -47,15 +46,13 @@
 			proc_dentry = NULL;
 		spin_unlock(&dcache_lock);
 	}
-	write_unlock_irq(&tasklist_lock);
-	if (unlikely(proc_dentry != NULL)) {
-		shrink_dcache_parent(proc_dentry);
-		dput(proc_dentry);
-	}
+	return proc_dentry;
 }
 
 static void release_task(struct task_struct * p)
 {
+	struct dentry *proc_dentry;
+
 	if (p->state != TASK_ZOMBIE)
 		BUG();
 #ifdef CONFIG_SMP
@@ -71,8 +68,14 @@
 		write_unlock_irq(&tasklist_lock);
 	}
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
-	unhash_process(p);
-	exit_sighand(p);
+	write_lock_irq(&tasklist_lock);
+	__exit_sighand(p);
+	proc_dentry = __unhash_process(p);
+	write_unlock_irq(&tasklist_lock);
+	if (unlikely(proc_dentry != NULL)) {
+		shrink_dcache_parent(proc_dentry);
+		dput(proc_dentry);
+	}
 
 	release_thread(p);
 	if (p != current) {
@@ -88,7 +91,16 @@
 
 void unhash_process(struct task_struct *p)
 {
-	return __unhash_process(p);
+	struct dentry *proc_dentry;
+
+	write_lock_irq(&tasklist_lock);
+	proc_dentry = __unhash_process(p);
+	write_unlock_irq(&tasklist_lock);
+
+	if (unlikely(proc_dentry != NULL)) {
+		shrink_dcache_parent(proc_dentry);
+		dput(proc_dentry);
+	}
 }
 
 /*
@@ -651,6 +663,30 @@
 asmlinkage long sys_exit(int error_code)
 {
 	do_exit((error_code&0xff)<<8);
+}
+
+/*
+ * this kills every thread in the thread group. Note that any externally
+ * wait4()-ing process will get the correct exit code - even if this 
+ * thread is not the thread group leader.
+ */
+asmlinkage long sys_exit_group(int error_code)
+{
+	struct signal_struct *sig = current->sig;
+
+	spin_lock_irq(&sig->siglock);
+	if (sig->group_exit) {
+		spin_unlock_irq(&sig->siglock);
+
+		/* another thread was faster: */
+		do_exit(sig->group_exit_code);
+	}
+	sig->group_exit = 1;
+	sig->group_exit_code = (error_code & 0xff) << 8;
+	__broadcast_thread_group(current, SIGKILL);
+	spin_unlock_irq(&sig->siglock);
+
+	do_exit(sig->group_exit_code);
 }
 
 static inline int eligible_child(pid_t pid, int options, task_t *p)
--- linux/kernel/fork.c.orig	Wed Sep 11 12:28:52 2002
+++ linux/kernel/fork.c	Wed Sep 11 14:01:55 2002
@@ -181,7 +181,6 @@
 		for_each_task(p) {
 			if (p->pid == last_pid	||
 			   p->pgrp == last_pid	||
-			   p->tgid == last_pid	||
 			   p->session == last_pid) {
 				if (++last_pid >= next_safe) {
 					if (last_pid >= pid_max)
@@ -194,8 +193,6 @@
 				next_safe = p->pid;
 			if (p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe = p->pgrp;
-			if (p->tgid > last_pid && next_safe > p->tgid)
-				next_safe = p->tgid;
 			if (p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
 		}
@@ -629,7 +626,10 @@
 		return -1;
 	spin_lock_init(&sig->siglock);
 	atomic_set(&sig->count, 1);
-	memcpy(tsk->sig->action, current->sig->action, sizeof(tsk->sig->action));
+	sig->group_exit = 0;
+	sig->group_exit_code = 0;
+	init_completion(&sig->group_exit_done);
+	memcpy(sig->action, current->sig->action, sizeof(sig->action));
 	sig->curr_target = NULL;
 	init_sigpending(&sig->shared_pending);
 
@@ -853,6 +853,16 @@
 
 	if (clone_flags & CLONE_THREAD) {
 		spin_lock(&current->sig->siglock);
+		/*
+		 * Important: if an exit-all has been started then
+		 * do not create this new thread - the whole thread
+		 * group is supposed to exit anyway.
+		 */
+		if (current->sig->group_exit) {
+			spin_unlock(&current->sig->siglock);
+			write_unlock_irq(&tasklist_lock);
+			goto bad_fork_cleanup_namespace;
+		}
 		p->tgid = current->tgid;
 		list_add(&p->thread_group, &current->thread_group);
 		spin_unlock(&current->sig->siglock);
--- linux/kernel/signal.c.orig	Wed Sep 11 12:29:48 2002
+++ linux/kernel/signal.c	Wed Sep 11 14:10:13 2002
@@ -221,20 +221,28 @@
 	flush_sigqueue(&t->pending);
 }
 
+static inline void __remove_thread_group(struct task_struct *tsk, struct signal_struct *sig)
+{
+	if (tsk == sig->curr_target)
+		sig->curr_target = next_thread(tsk);
+	list_del_init(&tsk->thread_group);
+}
+
 void remove_thread_group(struct task_struct *tsk, struct signal_struct *sig)
 {
 	write_lock_irq(&tasklist_lock);
 	spin_lock(&tsk->sig->siglock);
 
-	if (tsk == sig->curr_target)
-		sig->curr_target = next_thread(tsk);
-	list_del_init(&tsk->thread_group);
+	__remove_thread_group(tsk, sig);
 
 	spin_unlock(&tsk->sig->siglock);
 	write_unlock_irq(&tasklist_lock);
 }
 
-void exit_sighand(struct task_struct *tsk)
+/*
+ * This function expects the tasklist_lock write-locked.
+ */
+void __exit_sighand(struct task_struct *tsk)
 {
 	struct signal_struct * sig = tsk->sig;
 
@@ -242,19 +250,45 @@
 		BUG();
 	if (!atomic_read(&sig->count))
 		BUG();
-	remove_thread_group(tsk, sig);
+	spin_lock(&sig->siglock);
+	/*
+	 * Do not let the thread group leader exit until all other
+	 * threads are done:
+	 */
+	while (current->tgid == current->pid && atomic_read(&sig->count) > 1) {
+		spin_unlock(&sig->siglock);
+		write_unlock_irq(&tasklist_lock);
 
-	spin_lock_irq(&tsk->sigmask_lock);
-	if (sig) {
-		tsk->sig = NULL;
-		if (atomic_dec_and_test(&sig->count)) {
-			flush_sigqueue(&sig->shared_pending);
-			kmem_cache_free(sigact_cachep, sig);
-		}
+		wait_for_completion(&sig->group_exit_done);
+
+		write_lock_irq(&tasklist_lock);
+		spin_lock(&sig->siglock);
+	}
+
+	__remove_thread_group(tsk, sig);
+
+	spin_lock(&tsk->sigmask_lock);
+	tsk->sig = NULL;
+	if (atomic_dec_and_test(&sig->count)) {
+		spin_unlock(&sig->siglock);
+		flush_sigqueue(&sig->shared_pending);
+		kmem_cache_free(sigact_cachep, sig);
+	} else {
+		if (atomic_read(&sig->count) == 1)
+			complete(&sig->group_exit_done);
+		spin_unlock(&sig->siglock);
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
-	spin_unlock_irq(&tsk->sigmask_lock);
+
+	spin_unlock(&tsk->sigmask_lock);
+}
+
+void exit_sighand(struct task_struct *tsk)
+{
+	write_lock_irq(&tasklist_lock);
+	__exit_sighand(tsk);
+	write_unlock_irq(&tasklist_lock);
 }
 
 /*
@@ -285,6 +319,9 @@
 	sigaddset(&current->pending.signal, sig);
 	recalc_sigpending();
 	current->flags |= PF_SIGNALED;
+
+	if (current->sig->group_exit)
+		exit_code = current->sig->group_exit_code;
 
 	do_exit(exit_code);
 	/* NOTREACHED */

