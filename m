Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWDJBhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWDJBhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 21:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWDJBhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 21:37:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750861AbWDJBhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 21:37:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
In-Reply-To: Oleg Nesterov's message of  Thursday, 13 October 2005 20:50:54 +0400 <434E906E.85BD86BF@tv-sign.ru>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20060410013651.4D1791809D1@magilla.sf.frob.com>
Date: Sun,  9 Apr 2006 18:36:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I have been absent from the discussion for such a long time.
I'm trying to catch up on old issues that I should have reviewed earlier.
This is about Oleg's change, commit 1291cf4163d21f1b4999d697cbf68d38e7151c28.

Your change is sensible on its own terms and clearly it resolves the
deadlock.  But thinking about this made me realize that we have a more
general problem with this kind of race condition.  The coredump deadlock is
the worst failure mode, but in non-coredump fatal signals we were already
getting the semantics wrong in the same race condition.  That is, the fatal
signal should never be dropped on the floor.  If the exec wins the race,
then any signals not yet acted on should remain queued.  Before your patch
this race scenario would hit the deadlock in the coredump case.  Now, the
coredump case matches the non-coredump fatal signal: the signal is dropped
on the floor.  This violates POSIX, which says that signals pending for the
process are preserved across exec.  (There might even be some way to abuse
this, though it seems like a bit of a stretch off hand.)

What do you think about this patch?  I think it's the correct thing to do,
and a bit of a cleanup not to use SIGNAL_GROUP_EXIT for exec.  The
do_coredump part of the patch can be cleaned up nicely in concert with some
of the other coredump changes you have posted recently.  In de_thread, I
wanted to get rid of taking tasklist_lock, which is no longer needed by
zap_other_threads these days.  But I didn't really know the story on the
child_reaper magic there that seems still to need the lock.  (Note that for
the ptrace corner cases not to lose signals either, we also need the patch
I posted to revert most of commit 30e0fca6c1d7d26f3f2daa4dd2b12c51dadc778a.)

By reverting the 1291cf4163d21f1b4999d697cbf68d38e7151c28 change, I was
able to reproduce the deadlock.  With that patch restored, I then verified
that in some of the races, a fatal signal was dropped on the floor.  In the
same tests using the patch below, there was never a deadlock or a lost signal.


Thanks,
Roland


[PATCH] Fix race between exec and fatal signals

When we have a race between an exec and another thread in the same group
dequeuing a fatal signal, the signal loses and the exec goes through.  The
problem here is that the signal is lost entirely.  In some circumstances
this violates POSIX, which says that signals pending for the process
(i.e. on the group's shared_pending queue) are preserved across exec.
This might even be abusable to some extent, though it's hard to see much
real damage being done.

There is no problem when signals remain queued, as they will be seen after
the exec.  The problematic race is when a signal has been dequeued by some
thread and is then dropped on floor when the thread decides to go and die
for the exec instead.  I think the correct solution is for the exec to
always lose that race.  

This patch adds a SIGNAL_GROUP_EXEC flag to distinguish de_thread from a
true group exit that will be fatal to all threads (SIGNAL_GROUP_EXIT).
When an exec is waiting for threads to die and another thread tries to do a
group exit, it aborts the exec so the exec'ing thread will die with the others.

Signed-off-by: Roland McGrath <roland@redhat.com>

---

 fs/exec.c             |   48 ++++++++++++++++++++++++++++++++++++++++--------
 include/linux/sched.h |    3 ++-
 kernel/exit.c         |    5 +++--
 kernel/fork.c         |    3 ++-
 kernel/signal.c       |   31 ++++++++++++++++++++++++-------
 5 files changed, 71 insertions(+), 19 deletions(-)

ced7c831060aadb6f2dbb15f36391e84061f5720
diff --git a/fs/exec.c b/fs/exec.c
index 0291a68..eae6371 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -606,15 +606,16 @@ static int de_thread(struct task_struct 
 	 */
 	read_lock(&tasklist_lock);
 	spin_lock_irq(lock);
-	if (sig->flags & SIGNAL_GROUP_EXIT) {
+	if (unlikely(sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC))) {
 		/*
 		 * Another group action in progress, just
 		 * return so that the signal is processed.
 		 */
-		spin_unlock_irq(lock);
 		read_unlock(&tasklist_lock);
+	dying:
+		spin_unlock_irq(lock);
 		kmem_cache_free(sighand_cachep, newsighand);
-		return -EAGAIN;
+		return -ERESTARTNOINTR;
 	}
 
 	/*
@@ -625,7 +626,7 @@ static int de_thread(struct task_struct 
 	if (unlikely(current->group_leader == child_reaper))
 		child_reaper = current;
 
-	zap_other_threads(current);
+	zap_other_threads(current, SIGNAL_GROUP_EXEC);
 	read_unlock(&tasklist_lock);
 
 	/*
@@ -646,6 +647,17 @@ static int de_thread(struct task_struct 
 		if (hrtimer_cancel(&sig->real_timer))
 			hrtimer_restart(&sig->real_timer);
 		spin_lock_irq(lock);
+		if (unlikely(!(sig->flags & SIGNAL_GROUP_EXEC))) {
+			BUG_ON(!(sig->flags & SIGNAL_GROUP_EXIT));
+			/*
+			 * Oh, dear.  Our exec was cancelled by a group
+			 * exit during the window where we released the
+			 * lock to update the timer.  Since we know we are
+			 * all about to die, it doesn't matter that the
+			 * timer now points at us.
+			 */
+			goto dying;
+		}
 	}
 	while (atomic_read(&sig->count) > count) {
 		sig->group_exit_task = current;
@@ -654,6 +666,14 @@ static int de_thread(struct task_struct 
 		spin_unlock_irq(lock);
 		schedule();
 		spin_lock_irq(lock);
+		if (unlikely(!(sig->flags & SIGNAL_GROUP_EXEC))) {
+			BUG_ON(!(sig->flags & SIGNAL_GROUP_EXIT));
+			BUG_ON(sig->group_exit_task == current);
+			/*
+			 * Our exec was cancelled by a group exit.
+			 */
+			goto dying;
+		}
 	}
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
@@ -1480,10 +1500,22 @@ int do_coredump(long signr, int exit_cod
 
 	retval = -EAGAIN;
 	spin_lock_irq(&current->sighand->siglock);
-	if (!(current->signal->flags & SIGNAL_GROUP_EXIT)) {
-		current->signal->flags = SIGNAL_GROUP_EXIT;
-		current->signal->group_exit_code = exit_code;
-		current->signal->group_stop_count = 0;
+	if (likely(!(current->signal->flags & SIGNAL_GROUP_EXIT))) {
+		struct signal_struct *sig = current->signal;
+		/*
+		 * If there is an exec in progress, cancel it and wake
+		 * up the exec'ing thread to feel our imminent zapping.
+		 */
+		if (unlikely(sig->flags & SIGNAL_GROUP_EXEC)) {
+			struct task_struct *execer = sig->group_exit_task;
+			sigaddset(&execer->pending.signal, SIGKILL);
+			sig->group_exit_task = NULL;
+			sig->notify_count = 0;
+			wake_up_process(execer);
+		}
+		sig->flags = SIGNAL_GROUP_EXIT;
+		sig->group_exit_code = exit_code;
+		sig->group_stop_count = 0;
 		retval = 0;
 	}
 	spin_unlock_irq(&current->sighand->siglock);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 541f482..1f5d7ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -463,6 +463,7 @@ struct signal_struct {
 #define SIGNAL_STOP_DEQUEUED	0x00000002 /* stop signal dequeued */
 #define SIGNAL_STOP_CONTINUED	0x00000004 /* SIGCONT since WCONTINUED reap */
 #define SIGNAL_GROUP_EXIT	0x00000008 /* group exit in progress */
+#define SIGNAL_GROUP_EXEC	0x00000010 /* group-killing exec in progress */
 
 
 /*
@@ -1102,7 +1103,7 @@ extern void do_notify_parent(struct task
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
 extern int send_sig(int, struct task_struct *, int);
-extern void zap_other_threads(struct task_struct *p);
+extern void zap_other_threads(struct task_struct *p, int);
 extern int kill_pg(pid_t, int, int);
 extern int kill_proc(pid_t, int, int);
 extern struct sigqueue *sigqueue_alloc(void);
diff --git a/kernel/exit.c b/kernel/exit.c
index 6c2eeb8..176c641 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -826,7 +826,8 @@ static void exit_notify(struct task_stru
 	state = EXIT_ZOMBIE;
 	if (tsk->exit_signal == -1 &&
 	    (likely(tsk->ptrace == 0) ||
-	     unlikely(tsk->parent->signal->flags & SIGNAL_GROUP_EXIT)))
+	     unlikely(tsk->parent->signal->flags
+		      & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC))))
 		state = EXIT_DEAD;
 	tsk->exit_state = state;
 
@@ -989,7 +990,7 @@ do_group_exit(int exit_code)
 			exit_code = sig->group_exit_code;
 		else {
 			sig->group_exit_code = exit_code;
-			zap_other_threads(current);
+			zap_other_threads(current, SIGNAL_GROUP_EXIT);
 		}
 		spin_unlock_irq(&sighand->siglock);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 3384eb8..8276618 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1167,7 +1167,8 @@ static task_t *copy_process(unsigned lon
 		 * do not create this new thread - the whole thread
 		 * group is supposed to exit anyway.
 		 */
-		if (current->signal->flags & SIGNAL_GROUP_EXIT) {
+		if (current->signal->flags
+		    & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC)) {
 			spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
 			retval = -EAGAIN;
diff --git a/kernel/signal.c b/kernel/signal.c
index 0492c04..b59154b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -465,7 +465,8 @@ int dequeue_signal(struct task_struct *t
  		 * is to alert stop-signal processing code when another
  		 * processor has come along and cleared the flag.
  		 */
- 		if (!(tsk->signal->flags & SIGNAL_GROUP_EXIT))
+ 		if (!(tsk->signal->flags
+		      & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC)))
  			tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
  	}
 	if ( signr &&
@@ -604,7 +605,7 @@ static void handle_stop_signal(int sig, 
 {
 	struct task_struct *t;
 
-	if (p->signal->flags & SIGNAL_GROUP_EXIT)
+	if (p->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC))
 		/*
 		 * The process is in the middle of dying already.
 		 */
@@ -887,7 +888,8 @@ __group_complete_signal(int sig, struct 
 	 * Found a killable thread.  If the signal will be fatal,
 	 * then start taking the whole group down immediately.
 	 */
-	if (sig_fatal(p, sig) && !(p->signal->flags & SIGNAL_GROUP_EXIT) &&
+	if (sig_fatal(p, sig) &&
+	    !(p->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC)) &&
 	    !sigismember(&t->real_blocked, sig) &&
 	    (sig == SIGKILL || !(t->ptrace & PT_PTRACED))) {
 		/*
@@ -975,12 +977,26 @@ __group_send_sig_info(int sig, struct si
 
 /*
  * Nuke all other threads in the group.
+ * tasklist_lock is not needed here, but p->sighand->siglock must be held.
  */
-void zap_other_threads(struct task_struct *p)
+void zap_other_threads(struct task_struct *p, int flag)
 {
 	struct task_struct *t;
 
-	p->signal->flags = SIGNAL_GROUP_EXIT;
+	if (unlikely(p->signal->flags & SIGNAL_GROUP_EXEC)) {
+		/*
+		 * We are cancelling an exec that is in progress, to let
+		 * the thread group die instead.  We need to wake the
+		 * exec'ing thread up from uninterruptible wait.
+		 */
+		BUG_ON(flag != SIGNAL_GROUP_EXIT);
+		t = p->signal->group_exit_task;
+		p->signal->group_exit_task = NULL;
+		p->signal->notify_count = 0;
+		wake_up_process(t);
+	}
+
+	p->signal->flags = flag;
 	p->signal->group_stop_count = 0;
 
 	if (thread_group_empty(p))
@@ -1564,7 +1580,8 @@ static void ptrace_stop(int exit_code, i
 	    likely(current->parent != current->real_parent ||
 		   !(current->ptrace & PT_ATTACHED)) &&
 	    (likely(current->parent->signal != current->signal) ||
-	     !unlikely(current->signal->flags & SIGNAL_GROUP_EXIT))) {
+	     !unlikely(current->signal->flags
+		       & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC)))) {
 		do_notify_parent_cldstop(current, CLD_TRAPPED);
 		read_unlock(&tasklist_lock);
 		schedule();
@@ -1705,7 +1722,7 @@ static int handle_group_stop(void)
 		return 0;
 	}
 
-	if (current->signal->flags & SIGNAL_GROUP_EXIT)
+	if (current->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC))
 		/*
 		 * Group stop is so another thread can do a core dump,
 		 * or else we are racing against a death signal.
