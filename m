Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUHRLV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUHRLV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUHRLV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:21:29 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:39094 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S265833AbUHRLUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:20:50 -0400
Date: Wed, 18 Aug 2004 04:20:44 -0700
Message-Id: <200408181120.i7IBKill017267@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix rusage semantics
X-Fcc: ~/Mail/linus
X-Zippy-Says: Did you move a lot of KOREAN STEAK KNIVES this trip, Dingy?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the rusage bookkeeping and the semantics of the getrusage
and times calls in a couple of ways.

The first change is in the c* fields counting dead child processes.  POSIX
requires that children that have died be counted in these fields when they
are reaped by a wait* call, and that if they are never reaped (e.g. because
of ignoring SIGCHLD, or exitting yourself first) then they are never
counted.  These were counted in release_task for all threads.  I've changed
it so they are counted in wait_task_zombie, i.e. exactly when being reaped.

POSIX also specifies for RUSAGE_CHILDREN that the report include the reaped
child processes of the calling process, i.e. whole thread group in Linux,
not just ones forked by the calling thread.  POSIX specifies tms_c[us]time
fields in the times call the same way.  I've moved the c* fields that
contain this information into signal_struct, where the single set of
counters accumulates data from any thread in the group that calls wait*.

Finally, POSIX specifies getrusage and times as returning cumulative totals
for the whole process (aka thread group), not just the calling thread.
I've added fields in signal_struct to accumulate the stats of detached
threads as they die.  The process stats are the sums of these records plus
the stats of remaining each live/zombie thread.  The times and getrusage
calls, and the internal uses for filling in wait4 results and siginfo_t,
now iterate over the threads in the thread group and sum up their stats
along with the stats recorded for threads already dead and gone.

I added a new value RUSAGE_GROUP (-3) for the getrusage system call rather
than changing the behavior of the old RUSAGE_SELF (0).  POSIX specifies
RUSAGE_SELF to mean all threads, so the glibc getrusage call will just
translate it to RUSAGE_GROUP for new kernels.  I did this thinking that
someone somewhere might want the old behavior with an old glibc and a new
kernel (it is only different if they are using CLONE_THREAD anyway).
However, I've changed the times system call to conform to POSIX as well and
did not provide any backward compatibility there.  In that case there is
nothing easy like a parameter value to use, it would have to be a new
system call number.  That seems pretty pointless.  Given that, I wonder if
it is worth bothering to preserve the compatible RUSAGE_SELF behavior by
introducing RUSAGE_GROUP instead of just changing RUSAGE_SELF's meaning.
Comments?

I've done some basic testing on x86 and x86-64, and all the numbers come
out right after these fixes.  (I have a test program that shows a few
different ways they were wonky before, if you know what to look for.)

This patch is against 2.6.8.1 + the waitid patches in -mm1 + the
notify_parent cleanup I posted earlier.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6.8.1-waitid/arch/alpha/kernel/osf_sys.c	2004-07-13 11:02:33.000000000 -0700
+++ linux-2.6/arch/alpha/kernel/osf_sys.c	2004-08-18 00:50:50.000000000 -0700
@@ -1079,18 +1079,10 @@ osf_getrusage(int who, struct rusage32 _
 		r.ru_majflt = current->maj_flt;
 		break;
 	case RUSAGE_CHILDREN:
-		jiffies_to_timeval32(current->cutime, &r.ru_utime);
-		jiffies_to_timeval32(current->cstime, &r.ru_stime);
-		r.ru_minflt = current->cmin_flt;
-		r.ru_majflt = current->cmaj_flt;
-		break;
-	default:
-		jiffies_to_timeval32(current->utime + current->cutime,
-				   &r.ru_utime);
-		jiffies_to_timeval32(current->stime + current->cstime,
-				   &r.ru_stime);
-		r.ru_minflt = current->min_flt + current->cmin_flt;
-		r.ru_majflt = current->maj_flt + current->cmaj_flt;
+		jiffies_to_timeval32(current->signal->cutime, &r.ru_utime);
+		jiffies_to_timeval32(current->signal->cstime, &r.ru_stime);
+		r.ru_minflt = current->signal->cmin_flt;
+		r.ru_majflt = current->signal->cmaj_flt;
 		break;
 	}
 
--- linux-2.6.8.1-waitid/arch/mips/kernel/sysirix.c	2004-06-24 09:19:53.000000000 -0700
+++ linux-2.6/arch/mips/kernel/sysirix.c	2004-08-17 22:11:33.000000000 -0700
@@ -810,8 +810,8 @@ asmlinkage int irix_times(struct tms * t
 			return err;
 		err |= __put_user(current->utime, &tbuf->tms_utime);
 		err |= __put_user(current->stime, &tbuf->tms_stime);
-		err |= __put_user(current->cutime, &tbuf->tms_cutime);
-		err |= __put_user(current->cstime, &tbuf->tms_cstime);
+		err |= __put_user(current->signal->cutime, &tbuf->tms_cutime);
+		err |= __put_user(current->signal->cstime, &tbuf->tms_cstime);
 	}
 
 	return err;
--- linux-2.6.8.1-waitid/fs/binfmt_elf.c	2004-07-30 22:49:36.000000000 -0700
+++ linux-2.6/fs/binfmt_elf.c	2004-08-17 17:48:50.000000000 -0700
@@ -1176,10 +1176,27 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_ppid = p->parent->pid;
 	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->signal->session;
-	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
-	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
-	jiffies_to_timeval(p->cutime, &prstatus->pr_cutime);
-	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
+	if (p->pid == p->tgid) {
+		/*
+		 * This is the record for the group leader.  Add in the
+		 * cumulative times of previous dead threads.  This total
+		 * won't include the time of each live thread whose state
+		 * is included in the core dump.  The final total reported
+		 * to our parent process when it calls wait4 will include
+		 * those sums as well as the little bit more time it takes
+		 * this and each other thread to finish dying after the
+		 * core dump synchronization phase.
+		 */
+		jiffies_to_timeval(p->utime + p->signal->utime,
+				   &prstatus->pr_utime);
+		jiffies_to_timeval(p->stime + p->signal->stime,
+				   &prstatus->pr_stime);
+	} else {
+		jiffies_to_timeval(p->utime, &prstatus->pr_utime);
+		jiffies_to_timeval(p->stime, &prstatus->pr_stime);
+	}
+	jiffies_to_timeval(p->signal->cutime, &prstatus->pr_cutime);
+	jiffies_to_timeval(p->signal->cstime, &prstatus->pr_cstime);
 }
 
 static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
--- linux-2.6.8.1-waitid/fs/proc/array.c	2004-08-05 17:43:51.000000000 -0700
+++ linux-2.6/fs/proc/array.c	2004-08-16 18:03:16.000000000 -0700
@@ -309,6 +309,7 @@ int proc_pid_stat(struct task_struct *ta
 	int num_threads = 0;
 	struct mm_struct *mm;
 	unsigned long long start_time;
+	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -343,6 +344,10 @@ int proc_pid_stat(struct task_struct *ta
 		}
 		pgid = process_group(task);
 		sid = task->signal->session;
+		cmin_flt = task->signal->cmin_flt;
+		cmaj_flt = task->signal->cmaj_flt;
+		cutime = task->signal->cutime;
+		cstime = task->signal->cstime;
 	}
 	read_unlock(&tasklist_lock);
 
@@ -371,13 +376,13 @@ int proc_pid_stat(struct task_struct *ta
 		tty_pgrp,
 		task->flags,
 		task->min_flt,
-		task->cmin_flt,
+		cmin_flt,
 		task->maj_flt,
-		task->cmaj_flt,
+		cmaj_flt,
 		jiffies_to_clock_t(task->utime),
 		jiffies_to_clock_t(task->stime),
-		jiffies_to_clock_t(task->cutime),
-		jiffies_to_clock_t(task->cstime),
+		jiffies_to_clock_t(cutime),
+		jiffies_to_clock_t(cstime),
 		priority,
 		nice,
 		num_threads,
--- linux-2.6.8.1-waitid/kernel/exit.c	2004-08-16 04:24:36.000000000 -0700
+++ linux-2.6/kernel/exit.c	2004-08-16 01:53:40.000000000 -0700
@@ -90,12 +90,6 @@ repeat: 
 		zap_leader = (leader->exit_signal == -1);
 	}
 
-	p->parent->cutime += p->utime + p->cutime;
-	p->parent->cstime += p->stime + p->cstime;
-	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
-	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
-	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
-	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
@@ -1043,6 +1037,38 @@ static int wait_task_zombie(task_t *p, i
 		return 0;
 	}
 
+	if (likely(p->real_parent == p->parent) && likely(p->signal)) {
+		/*
+		 * The resource counters for the group leader are in its
+		 * own task_struct.  Those for dead threads in the group
+		 * are in its signal_struct, as are those for the child
+		 * processes it has previously reaped.  All these
+		 * accumulate in the parent's signal_struct c* fields.
+		 *
+		 * We don't bother to take a lock here to protect these
+		 * p->signal fields, because they are only touched by
+		 * __exit_signal, which runs with tasklist_lock
+		 * write-locked anyway, and so is excluded here.  We do
+		 * need to protect the access to p->parent->signal fields,
+		 * as other threads in the parent group can be right
+		 * here reaping other children at the same time.
+		 */
+		spin_lock_irq(&p->parent->sighand->siglock);
+		p->parent->signal->cutime +=
+			p->utime + p->signal->utime + p->signal->cutime;
+		p->parent->signal->cstime +=
+			p->stime + p->signal->stime + p->signal->cstime;
+		p->parent->signal->cmin_flt +=
+			p->min_flt + p->signal->min_flt + p->signal->cmin_flt;
+		p->parent->signal->cmaj_flt +=
+			p->maj_flt + p->signal->maj_flt + p->signal->cmaj_flt;
+		p->parent->signal->cnvcsw +=
+			p->nvcsw + p->signal->nvcsw + p->signal->cnvcsw;
+		p->parent->signal->cnivcsw +=
+			p->nivcsw + p->signal->nivcsw + p->signal->cnivcsw;
+		spin_unlock_irq(&p->parent->sighand->siglock);
+	}
+
 	/*
 	 * Now we are sure this task is interesting, and no other
 	 * thread can reap it because we set its state to TASK_DEAD.
--- linux-2.6.8.1-waitid/kernel/fork.c	2004-07-28 23:14:26.000000000 -0700
+++ linux-2.6/kernel/fork.c	2004-08-18 00:44:15.397247725 -0700
@@ -527,8 +527,7 @@ static int copy_mm(unsigned long clone_f
 	int retval;
 
 	tsk->min_flt = tsk->maj_flt = 0;
-	tsk->cmin_flt = tsk->cmaj_flt = 0;
-	tsk->nvcsw = tsk->nivcsw = tsk->cnvcsw = tsk->cnivcsw = 0;
+	tsk->nvcsw = tsk->nivcsw = 0;
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
@@ -835,6 +834,10 @@ static inline int copy_signal(unsigned l
 	sig->leader = 0;	/* session leadership doesn't inherit */
 	sig->tty_old_pgrp = 0;
 
+	sig->utime = sig->stime = sig->cutime = sig->cstime = 0;
+	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
+	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
+
 	return 0;
 }
 
@@ -959,7 +962,6 @@ struct task_struct *copy_process(unsigne
 	p->real_timer.data = (unsigned long) p;
 
 	p->utime = p->stime = 0;
-	p->cutime = p->cstime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
--- linux-2.6.8.1-waitid/kernel/signal.c	2004-08-17 17:19:07.000000000 -0700
+++ linux-2.6/kernel/signal.c	2004-08-17 18:22:36.000000000 -0700
@@ -369,6 +369,22 @@ void __exit_signal(struct task_struct *t
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
+		/*
+		 * Accumulate here the counters for all threads but the
+		 * group leader as they die, so they can be added into
+		 * the process-wide totals when those are taken.
+		 * The group leader stays around as a zombie as long
+		 * as there are other threads.  When it gets reaped,
+		 * the exit.c code will add its counts into these totals.
+		 * We won't ever get here for the group leader, since it
+		 * will have been the last reference on the signal_struct.
+		 */
+		sig->utime += tsk->utime;
+		sig->stime += tsk->stime;
+		sig->min_flt += tsk->min_flt;
+		sig->maj_flt += tsk->maj_flt;
+		sig->nvcsw += tsk->nvcsw;
+		sig->nivcsw += tsk->nivcsw;
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
@@ -663,12 +679,14 @@ static void handle_stop_signal(int sig, 
 			 */
 			p->signal->group_stop_count = 0;
 			p->signal->stop_state = 1;
+			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
 				do_notify_parent_cldstop(p, p->parent);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
 					p->group_leader->real_parent);
+			spin_lock(&p->sighand->siglock);
 		}
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
 		t = p;
@@ -707,12 +725,14 @@ static void handle_stop_signal(int sig, 
 			 */
 			p->signal->stop_state = -1;
 			p->signal->group_exit_code = 0;
+			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
 				do_notify_parent_cldstop(p, p->parent);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
 					p->group_leader->real_parent);
+			spin_lock(&p->sighand->siglock);
 		}
 	}
 }
@@ -1457,8 +1477,8 @@ void do_notify_parent(struct task_struct
 	/* do_notify_parent_cldstop should have been called instead.  */
 	BUG_ON(tsk->state == TASK_STOPPED);
 
-	BUG_ON(tsk->group_leader != tsk && tsk->group_leader->state != TASK_ZOMBIE && !tsk->ptrace);
-	BUG_ON(tsk->group_leader == tsk && !thread_group_empty(tsk) && !tsk->ptrace);
+	BUG_ON(!tsk->ptrace &&
+	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
 	info.si_signo = sig;
 	info.si_errno = 0;
@@ -1466,8 +1486,8 @@ void do_notify_parent(struct task_struct
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime;
-	info.si_stime = tsk->stime;
+	info.si_utime = tsk->utime + tsk->signal->utime;
+	info.si_stime = tsk->stime + tsk->signal->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
 	info.si_status = tsk->exit_code & 0x7f;
--- linux-2.6.8.1-waitid/kernel/sys.c	2004-08-16 04:24:20.000000000 -0700
+++ linux-2.6/kernel/sys.c	2004-08-18 03:10:06.324666795 -0700
@@ -947,10 +947,39 @@ asmlinkage long sys_times(struct tms __u
 	 */
 	if (tbuf) {
 		struct tms tmp;
-		tmp.tms_utime = jiffies_to_clock_t(current->utime);
-		tmp.tms_stime = jiffies_to_clock_t(current->stime);
-		tmp.tms_cutime = jiffies_to_clock_t(current->cutime);
-		tmp.tms_cstime = jiffies_to_clock_t(current->cstime);
+		struct task_struct *tsk = current;
+		struct task_struct *t;
+		unsigned long utime, stime, cutime, cstime;
+
+		read_lock(&tasklist_lock);
+		utime = tsk->signal->utime;
+		stime = tsk->signal->stime;
+		t = tsk;
+		do {
+			utime += t->utime;
+			stime += t->stime;
+			t = next_thread(t);
+		} while (t != tsk);
+
+		/*
+		 * While we have tasklist_lock read-locked, no dying thread
+		 * can be updating current->signal->[us]time.  Instead,
+		 * we got their counts included in the live thread loop.
+		 * However, another thread can come in right now and
+		 * do a wait call that updates current->signal->c[us]time.
+		 * To make sure we always see that pair updated atomically,
+		 * we take the siglock around fetching them.
+		 */
+		spin_lock_irq(&tsk->sighand->siglock);
+		cutime = tsk->signal->cutime;
+		cstime = tsk->signal->cstime;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+
+		tmp.tms_utime = jiffies_to_clock_t(utime);
+		tmp.tms_stime = jiffies_to_clock_t(stime);
+		tmp.tms_cutime = jiffies_to_clock_t(cutime);
+		tmp.tms_cstime = jiffies_to_clock_t(cstime);
 		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
 	}
@@ -1533,18 +1562,29 @@ asmlinkage long sys_setrlimit(unsigned i
  * a lot simpler!  (Which we're not doing right now because we're not
  * measuring them yet).
  *
- * This is SMP safe.  Either we are called from sys_getrusage on ourselves
- * below (we know we aren't going to exit/disappear and only we change our
- * rusage counters), or we are called from wait4() on a process which is
- * either stopped or zombied.  In the zombied case the task won't get
- * reaped till shortly after the call to getrusage(), in both cases the
- * task being examined is in a frozen state so the counters won't change.
+ * This expects to be called with tasklist_lock read-locked or better,
+ * and the siglock not locked.  It may momentarily take the siglock.
+ *
+ * When sampling multiple threads for RUSAGE_GROUP, under SMP we might have
+ * races with threads incrementing their own counters.  But since word
+ * reads are atomic, we either get new values or old values and we don't
+ * care which for the sums.  We always take the siglock to protect reading
+ * the c* fields from p->signal from races with exit.c updating those
+ * fields when reaping, so a sample either gets all the additions of a
+ * given child after it's reaped, or none so this sample is before reaping.
  */
 
-
 void k_getrusage(struct task_struct *p, int who, struct rusage *r)
 {
+	struct task_struct *t;
+	unsigned long flags;
+	unsigned long utime, stime;
+
 	memset((char *) r, 0, sizeof *r);
+
+	if (unlikely(!p->signal))
+		return;
+
 	switch (who) {
 		case RUSAGE_SELF:
 			jiffies_to_timeval(p->utime, &r->ru_utime);
@@ -1555,34 +1595,68 @@ void k_getrusage(struct task_struct *p, 
 			r->ru_majflt = p->maj_flt;
 			break;
 		case RUSAGE_CHILDREN:
-			jiffies_to_timeval(p->cutime, &r->ru_utime);
-			jiffies_to_timeval(p->cstime, &r->ru_stime);
-			r->ru_nvcsw = p->cnvcsw;
-			r->ru_nivcsw = p->cnivcsw;
-			r->ru_minflt = p->cmin_flt;
-			r->ru_majflt = p->cmaj_flt;
+			spin_lock_irqsave(&p->sighand->siglock, flags);
+			utime = p->signal->cutime;
+			stime = p->signal->cstime;
+			r->ru_nvcsw = p->signal->cnvcsw;
+			r->ru_nivcsw = p->signal->cnivcsw;
+			r->ru_minflt = p->signal->cmin_flt;
+			r->ru_majflt = p->signal->cmaj_flt;
+			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			jiffies_to_timeval(utime, &r->ru_utime);
+			jiffies_to_timeval(stime, &r->ru_stime);
+			break;
+		case RUSAGE_GROUP:
+			spin_lock_irqsave(&p->sighand->siglock, flags);
+			utime = stime = 0;
+			goto sum_group;
+		case RUSAGE_BOTH:
+			spin_lock_irqsave(&p->sighand->siglock, flags);
+			utime = p->signal->cutime;
+			stime = p->signal->cstime;
+			r->ru_nvcsw = p->signal->cnvcsw;
+			r->ru_nivcsw = p->signal->cnivcsw;
+			r->ru_minflt = p->signal->cmin_flt;
+			r->ru_majflt = p->signal->cmaj_flt;
+		sum_group:
+			utime += p->signal->utime;
+			stime += p->signal->stime;
+			r->ru_nvcsw += p->signal->nvcsw;
+			r->ru_nivcsw += p->signal->nivcsw;
+			r->ru_minflt += p->signal->min_flt;
+			r->ru_majflt += p->signal->maj_flt;
+			t = p;
+			do {
+				utime += t->utime;
+				stime += t->stime;
+				r->ru_nvcsw += t->nvcsw;
+				r->ru_nivcsw += t->nivcsw;
+				r->ru_minflt += t->min_flt;
+				r->ru_majflt += t->maj_flt;
+				t = next_thread(t);
+			} while (t != p);
+			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			jiffies_to_timeval(utime, &r->ru_utime);
+			jiffies_to_timeval(stime, &r->ru_stime);
 			break;
 		default:
-			jiffies_to_timeval(p->utime + p->cutime, &r->ru_utime);
-			jiffies_to_timeval(p->stime + p->cstime, &r->ru_stime);
-			r->ru_nvcsw = p->nvcsw + p->cnvcsw;
-			r->ru_nivcsw = p->nivcsw + p->cnivcsw;
-			r->ru_minflt = p->min_flt + p->cmin_flt;
-			r->ru_majflt = p->maj_flt + p->cmaj_flt;
-			break;
+			BUG();
 	}
 }
 
 int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
 {
 	struct rusage r;
+	read_lock(&tasklist_lock);
 	k_getrusage(p, who, &r);
+	read_unlock(&tasklist_lock);
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
+	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN
+	    && who != RUSAGE_GROUP)
 		return -EINVAL;
 	return getrusage(current, who, ru);
 }
--- linux-2.6.8.1-waitid/include/linux/sched.h	2004-08-16 04:24:20.000000000 -0700
+++ linux-2.6/include/linux/sched.h	2004-08-15 23:20:08.000000000 -0700
@@ -282,6 +282,16 @@ struct signal_struct {
 	int leader;
 
 	struct tty_struct *tty; /* NULL if no tty */
+
+	/*
+	 * Cumulative resource counters for dead threads in the group,
+	 * and for reaped dead child processes forked by this group.
+	 * Live threads maintain their own counters and add to these
+	 * in __exit_signal, except for the group leader.
+	 */
+	unsigned long utime, stime, cutime, cstime;
+	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
+	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 };
 
 /*
@@ -457,11 +467,11 @@ struct task_struct {
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
-	unsigned long utime, stime, cutime, cstime;
-	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
+	unsigned long utime, stime;
+	unsigned long nvcsw, nivcsw; /* context switch counts */
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
-	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
+	unsigned long min_flt, maj_flt;
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
--- linux-2.6.8.1-waitid/include/linux/resource.h	2002-11-08 14:12:48.000000000 -0800
+++ linux-2.6/include/linux/resource.h	2004-08-16 18:26:46.000000000 -0700
@@ -17,6 +17,7 @@
 #define	RUSAGE_SELF	0
 #define	RUSAGE_CHILDREN	(-1)
 #define RUSAGE_BOTH	(-2)		/* sys_wait4() uses this */
+#define RUSAGE_GROUP	(-3)		/* thread group sum + dead threads */
 
 struct	rusage {
 	struct timeval ru_utime;	/* user time used */
--- linux-2.6.8.1-waitid/kernel/compat.c	2004-08-16 04:24:20.000000000 -0700
+++ linux-2.6/kernel/compat.c	2004-08-18 03:07:11.000000000 -0700
@@ -160,10 +160,39 @@ asmlinkage long compat_sys_times(struct 
 	 */
 	if (tbuf) {
 		struct compat_tms tmp;
-		tmp.tms_utime = compat_jiffies_to_clock_t(current->utime);
-		tmp.tms_stime = compat_jiffies_to_clock_t(current->stime);
-		tmp.tms_cutime = compat_jiffies_to_clock_t(current->cutime);
-		tmp.tms_cstime = compat_jiffies_to_clock_t(current->cstime);
+		struct task_struct *tsk = current;
+		struct task_struct *t;
+		unsigned long utime, stime, cutime, cstime;
+
+		read_lock(&tasklist_lock);
+		utime = tsk->signal->utime;
+		stime = tsk->signal->stime;
+		t = tsk;
+		do {
+			utime += t->utime;
+			stime += t->stime;
+			t = next_thread(t);
+		} while (t != tsk);
+
+		/*
+		 * While we have tasklist_lock read-locked, no dying thread
+		 * can be updating current->signal->[us]time.  Instead,
+		 * we got their counts included in the live thread loop.
+		 * However, another thread can come in right now and
+		 * do a wait call that updates current->signal->c[us]time.
+		 * To make sure we always see that pair updated atomically,
+		 * we take the siglock around fetching them.
+		 */
+		spin_lock_irq(&tsk->sighand->siglock);
+		cutime = tsk->signal->cutime;
+		cstime = tsk->signal->cstime;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+
+		tmp.tms_utime = compat_jiffies_to_clock_t(utime);
+		tmp.tms_stime = compat_jiffies_to_clock_t(stime);
+		tmp.tms_cutime = compat_jiffies_to_clock_t(cutime);
+		tmp.tms_cstime = compat_jiffies_to_clock_t(cstime);
 		if (copy_to_user(tbuf, &tmp, sizeof(tmp)))
 			return -EFAULT;
 	}
