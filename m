Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUHaINJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUHaINJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUHaINJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:13:09 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:23440 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267370AbUHaIMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:12:05 -0400
Subject: [PATCH] whole-process CPU usage
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093939834.434.7043.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Aug 2004 04:10:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like it ought to work. Due to undocumented
locking, it may need a bit of work. The two ungreppable
old names are replaced with these six:

->task_sys_time           Per-thread CPU usage
->signal->proc_sys_time   Per-process CPU usage
->signal->dead_sys_time   CPU usage of dead children
(and 3 more, with "usr" in place of "sys")

Some of the changes appear to fix UNIX non-compliance.
For example, times() and getrusage() are per-process.
I assume that the OOM killer wants per-process data too.
BSD accounting appears to be per-thread, so that's what
I gave it for now, but per-process accounting makes more
sense.

Context switch and fault counts can get this treatment
in some future patch.

It's long past time for "signal" to get renamed. Ideas?

diff -Naurd a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
--- a/arch/alpha/kernel/osf_sys.c	2004-08-24 03:01:50.000000000 -0400
+++ b/arch/alpha/kernel/osf_sys.c	2004-08-31 00:53:16.000000000 -0400
@@ -1073,21 +1073,21 @@
 	memset(&r, 0, sizeof(r));
 	switch (who) {
 	case RUSAGE_SELF:
-		jiffies_to_timeval32(current->utime, &r.ru_utime);
-		jiffies_to_timeval32(current->stime, &r.ru_stime);
+		jiffies_to_timeval32(current->signal->proc_usr_time, &r.ru_utime);
+		jiffies_to_timeval32(current->signal->proc_sys_time, &r.ru_stime);
 		r.ru_minflt = current->min_flt;
 		r.ru_majflt = current->maj_flt;
 		break;
 	case RUSAGE_CHILDREN:
-		jiffies_to_timeval32(current->cutime, &r.ru_utime);
-		jiffies_to_timeval32(current->cstime, &r.ru_stime);
+		jiffies_to_timeval32(current->signal->dead_usr_time, &r.ru_utime);
+		jiffies_to_timeval32(current->signal->dead_sys_time, &r.ru_stime);
 		r.ru_minflt = current->cmin_flt;
 		r.ru_majflt = current->cmaj_flt;
 		break;
 	default:
-		jiffies_to_timeval32(current->utime + current->cutime,
+		jiffies_to_timeval32(current->signal->proc_usr_time + current->signal->dead_usr_time,
 				   &r.ru_utime);
-		jiffies_to_timeval32(current->stime + current->cstime,
+		jiffies_to_timeval32(current->signal->proc_sys_time + current->signal->dead_sys_time,
 				   &r.ru_stime);
 		r.ru_minflt = current->min_flt + current->cmin_flt;
 		r.ru_majflt = current->maj_flt + current->cmaj_flt;
diff -Naurd a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2004-08-24 03:01:53.000000000 -0400
+++ b/arch/i386/kernel/apm.c	2004-08-31 00:48:38.000000000 -0400
@@ -837,18 +837,18 @@
 	if (jiffies_since_last_check > IDLE_CALC_LIMIT) {
 		use_apm_idle = 0;
 		last_jiffies = jiffies;
-		last_stime = current->stime;
+		last_stime = current->task_sys_time;
 	} else if (jiffies_since_last_check > idle_period) {
 		unsigned int idle_percentage;
 
-		idle_percentage = current->stime - last_stime;
+		idle_percentage = current->task_sys_time - last_stime;
 		idle_percentage *= 100;
 		idle_percentage /= jiffies_since_last_check;
 		use_apm_idle = (idle_percentage > idle_threshold);
 		if (apm_info.forbid_idle)
 			use_apm_idle = 0;
 		last_jiffies = jiffies;
-		last_stime = current->stime;
+		last_stime = current->task_sys_time;
 	}
 
 	bucket = IDLE_LEAKY_MAX;
diff -Naurd a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	2004-08-24 03:02:33.000000000 -0400
+++ b/fs/binfmt_elf.c	2004-08-30 22:38:48.000000000 -0400
@@ -1176,10 +1176,10 @@
 	prstatus->pr_ppid = p->parent->pid;
 	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->signal->session;
-	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
-	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
-	jiffies_to_timeval(p->cutime, &prstatus->pr_cutime);
-	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
+	jiffies_to_timeval(p->task_usr_time, &prstatus->pr_utime);
+	jiffies_to_timeval(p->task_sys_time, &prstatus->pr_stime);
+	jiffies_to_timeval(p->signal->dead_usr_time, &prstatus->pr_cutime);
+	jiffies_to_timeval(p->signal->dead_sys_time, &prstatus->pr_cstime);
 }
 
 static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
diff -Naurd a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	2004-08-24 03:02:58.000000000 -0400
+++ b/fs/proc/array.c	2004-08-31 02:57:25.000000000 -0400
@@ -300,9 +300,10 @@
 }
 
 extern unsigned long task_vsize(struct mm_struct *);
-int proc_pid_stat(struct task_struct *task, char * buffer)
+static int do_task_stat(struct task_struct *task, char * buffer, int whole)
 {
 	unsigned long vsize, eip, esp, wchan;
+	unsigned long dead_usr_time, dead_sys_time, usr_time, sys_time;
 	long priority, nice;
 	int tty_pgrp = -1, tty_nr = 0;
 	sigset_t sigign, sigcatch;
@@ -330,10 +331,10 @@
 	}
 
 	get_task_comm(tcomm, task);
-	wchan = get_wchan(task);
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
+
 	read_lock(&tasklist_lock);
 	if (task->sighand) {
 		spin_lock_irq(&task->sighand->siglock);
@@ -349,6 +350,7 @@
 		pgid = process_group(task);
 		sid = task->signal->session;
 	}
+	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 
 	/* scale priority and nice values from timeslices to -20..20 */
@@ -356,16 +358,32 @@
 	priority = task_prio(task);
 	nice = task_nice(task);
 
-	read_lock(&tasklist_lock);
-	ppid = task->pid ? task->real_parent->pid : 0;
-	read_unlock(&tasklist_lock);
+	/* if this is found to need siglock or tasklist_lock, DOCUMENT WHY */
+	dead_usr_time = jiffies_to_clock_t(task->signal->dead_usr_time);
+	dead_sys_time = jiffies_to_clock_t(task->signal->dead_sys_time);
+	if (whole) {
+		usr_time = jiffies_to_clock_t(task->signal->proc_usr_time);
+		sys_time = jiffies_to_clock_t(task->signal->proc_sys_time);
+	} else {
+		usr_time = jiffies_to_clock_t(task->task_usr_time);
+		sys_time = jiffies_to_clock_t(task->task_sys_time);
+	}
+
+	/* compute whole-process wchan only if single-threaded */
+	wchan = (whole && num_threads>1) ? ~0ul : get_wchan(task);
 
 	/* Temporary variable needed for gcc-2.96 */
 	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
 
-	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+	res = sprintf(
+		buffer,
+		"%d (%s) %c %d %d %d %d %d %lu "
+		"%lu %lu %lu %lu %lu %lu %lu %lu "
+		"%ld %ld %d %ld %llu %lu "
+		"%ld %lu %lu %lu %lu %lu %lu "
+		"%lu %lu %lu %lu %lu 0 0 %d %d %lu %lu\n",
+
+		/* arg 3 */
 		task->pid,
 		tcomm,
 		state,
@@ -375,20 +393,26 @@
 		tty_nr,
 		tty_pgrp,
 		task->flags,
+
+		/* arg 12 */
 		task->min_flt,
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
-		jiffies_to_clock_t(task->utime),
-		jiffies_to_clock_t(task->stime),
-		jiffies_to_clock_t(task->cutime),
-		jiffies_to_clock_t(task->cstime),
+		usr_time,
+		sys_time,
+		dead_usr_time,
+		dead_sys_time,
+
+		/* arg 20 */
 		priority,
 		nice,
 		num_threads,
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
+
+		/* arg 26 */
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
@@ -396,26 +420,39 @@
 		mm ? mm->start_stack : 0,
 		esp,
 		eip,
+
 		/* The signal information here is obsolete.
 		 * It must be decimal for Linux 2.0 compatibility.
 		 * Use /proc/#/status for real-time signals.
 		 */
+		/* arg 33 */
 		task->pending.signal.sig[0] & 0x7fffffffUL,
-		task->blocked.sig[0] & 0x7fffffffUL,
-		sigign      .sig[0] & 0x7fffffffUL,
-		sigcatch    .sig[0] & 0x7fffffffUL,
+		task->blocked       .sig[0] & 0x7fffffffUL,
+		sigign              .sig[0] & 0x7fffffffUL,
+		sigcatch            .sig[0] & 0x7fffffffUL,
 		wchan,
-		0UL,
-		0UL,
+		/* 0UL, */
+		/* 0UL, */
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
+		task->policy
+	);
 	if(mm)
 		mmput(mm);
 	return res;
 }
 
+int proc_tid_stat(struct task_struct *task, char * buffer)
+{
+	return do_task_stat(task, buffer, 0);
+}
+
+int proc_tgid_stat(struct task_struct *task, char * buffer)
+{
+	return do_task_stat(task, buffer, 1);
+}
+
 extern int task_statm(struct mm_struct *, int *, int *, int *, int *);
 int proc_pid_statm(struct task_struct *task, char *buffer)
 {
diff -Naurd a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	2004-08-24 03:01:55.000000000 -0400
+++ b/fs/proc/proc_misc.c	2004-08-31 01:04:45.000000000 -0400
@@ -136,7 +136,7 @@
 	struct timespec uptime;
 	struct timespec idle;
 	int len;
-	u64 idle_jiffies = init_task.utime + init_task.stime;
+	u64 idle_jiffies = init_task.task_usr_time + init_task.task_sys_time;
 
 	do_posix_clock_monotonic_gettime(&uptime);
 	jiffies_to_timespec(idle_jiffies, &idle);
diff -Naurd a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-08-24 03:01:54.000000000 -0400
+++ b/include/linux/sched.h	2004-08-30 22:20:29.000000000 -0400
@@ -284,6 +284,9 @@
 	int leader;
 
 	struct tty_struct *tty; /* NULL if no tty */
+
+	unsigned long proc_sys_time, proc_usr_time; /* whole process */
+	unsigned long dead_sys_time, dead_usr_time; /* dead children */
 };
 
 /*
@@ -460,7 +463,7 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
-	unsigned long utime, stime, cutime, cstime;
+	unsigned long task_sys_time, task_usr_time;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
diff -Naurd a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	2004-08-24 03:02:48.000000000 -0400
+++ b/kernel/acct.c	2004-08-30 22:59:30.000000000 -0400
@@ -418,8 +418,14 @@
 #endif
 	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->utime));
-	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->stime));
+
+	/*
+	 * accounting is called once per thread -- maybe not the best
+	 * (if that changes, use current->signal->proc_usr_time, etc.)
+	 */
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->task_usr_time));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->task_sys_time));
+
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
diff -Naurd a/kernel/compat.c b/kernel/compat.c
--- a/kernel/compat.c	2004-08-24 03:02:47.000000000 -0400
+++ b/kernel/compat.c	2004-08-30 23:01:52.000000000 -0400
@@ -160,10 +160,10 @@
 	 */
 	if (tbuf) {
 		struct compat_tms tmp;
-		tmp.tms_utime = compat_jiffies_to_clock_t(current->utime);
-		tmp.tms_stime = compat_jiffies_to_clock_t(current->stime);
-		tmp.tms_cutime = compat_jiffies_to_clock_t(current->cutime);
-		tmp.tms_cstime = compat_jiffies_to_clock_t(current->cstime);
+		tmp.tms_utime  = compat_jiffies_to_clock_t(current->signal->proc_usr_time);
+		tmp.tms_stime  = compat_jiffies_to_clock_t(current->signal->proc_sys_time);
+		tmp.tms_cutime = compat_jiffies_to_clock_t(current->signal->dead_usr_time);
+		tmp.tms_cstime = compat_jiffies_to_clock_t(current->signal->dead_sys_time);
 		if (copy_to_user(tbuf, &tmp, sizeof(tmp)))
 			return -EFAULT;
 	}
diff -Naurd a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c	2004-08-24 03:03:31.000000000 -0400
+++ b/kernel/cpu.c	2004-08-30 23:21:47.000000000 -0400
@@ -49,7 +49,7 @@
 
 	write_lock_irq(&tasklist_lock);
 	for_each_process(p) {
-		if (task_cpu(p) == cpu && (p->utime != 0 || p->stime != 0))
+		if (task_cpu(p) == cpu && (p->signal->proc_usr_time || p->signal->proc_sys_time))
 			printk(KERN_WARNING "Task %s (pid = %d) is on cpu %d\
 				(state = %ld, flags = %lx) \n",
 				 p->comm, p->pid, cpu, p->state, p->flags);
diff -Naurd a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2004-08-24 03:03:31.000000000 -0400
+++ b/kernel/exit.c	2004-08-31 00:04:13.000000000 -0400
@@ -90,12 +90,18 @@
 		zap_leader = (leader->exit_signal == -1);
 	}
 
-	p->parent->cutime += p->utime + p->cutime;
-	p->parent->cstime += p->stime + p->cstime;
+	/* credit parent's dead-child stats (proper: when parent waits) */
+	if (leader == p && thread_group_empty(leader)) {
+		p->parent->signal->dead_usr_time += p->signal->proc_usr_time + p->signal->dead_usr_time;
+		p->parent->signal->dead_sys_time += p->signal->proc_sys_time + p->signal->dead_sys_time;
+	}
+
+	/* TODO: these should get the same treatment as CPU time */
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
+
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
diff -Naurd a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	2004-08-24 03:01:54.000000000 -0400
+++ b/kernel/fork.c	2004-08-31 00:10:31.000000000 -0400
@@ -822,6 +822,8 @@
 	if (!sig)
 		return -ENOMEM;
 	atomic_set(&sig->count, 1);
+	sig->proc_usr_time = sig->proc_sys_time = 0;
+	sig->dead_usr_time = sig->dead_sys_time = 0;
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
 	sig->group_exit_task = NULL;
@@ -959,8 +961,7 @@
 	init_timer(&p->real_timer);
 	p->real_timer.data = (unsigned long) p;
 
-	p->utime = p->stime = 0;
-	p->cutime = p->cstime = 0;
+	p->task_usr_time = p->task_sys_time = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
diff -Naurd a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	2004-08-24 03:02:32.000000000 -0400
+++ b/kernel/signal.c	2004-08-31 00:19:24.000000000 -0400
@@ -1445,8 +1445,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime;
-	info.si_stime = tsk->stime;
+	info.si_utime = tsk->signal->proc_usr_time + tsk->signal->dead_usr_time;
+	info.si_stime = tsk->signal->proc_sys_time + tsk->signal->dead_sys_time;
 
 	status = tsk->exit_code & 0x7f;
 	why = SI_KERNEL;	/* shouldn't happen */
@@ -1534,8 +1534,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime;
-	info.si_stime = tsk->stime;
+	info.si_utime = tsk->signal->proc_usr_time + tsk->signal->dead_usr_time;
+	info.si_stime = tsk->signal->proc_sys_time + tsk->signal->dead_sys_time;
 
 	info.si_status = tsk->exit_code & 0x7f;
 	info.si_code = CLD_STOPPED;
diff -Naurd a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	2004-08-24 03:01:54.000000000 -0400
+++ b/kernel/sys.c	2004-08-31 00:29:43.000000000 -0400
@@ -944,13 +944,14 @@
 	 *	the times increment as we use it. Since the value is an
 	 *	atomically safe type this is just fine. Conceptually its
 	 *	as if the syscall took an instant longer to occur.
+	 *	The UNIX spec seems to indicate that these are per-process.
 	 */
 	if (tbuf) {
 		struct tms tmp;
-		tmp.tms_utime = jiffies_to_clock_t(current->utime);
-		tmp.tms_stime = jiffies_to_clock_t(current->stime);
-		tmp.tms_cutime = jiffies_to_clock_t(current->cutime);
-		tmp.tms_cstime = jiffies_to_clock_t(current->cstime);
+		tmp.tms_utime  = jiffies_to_clock_t(current->signal->proc_usr_time);
+		tmp.tms_stime  = jiffies_to_clock_t(current->signal->proc_sys_time);
+		tmp.tms_cutime = jiffies_to_clock_t(current->signal->dead_usr_time);
+		tmp.tms_cstime = jiffies_to_clock_t(current->signal->dead_sys_time);
 		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
 	}
@@ -1526,12 +1527,9 @@
 }
 
 /*
- * It would make sense to put struct rusage in the task_struct,
- * except that would make the task_struct be *really big*.  After
- * task_struct gets moved into malloc'ed memory, it would
- * make sense to do this.  It will make moving the rest of the information
- * a lot simpler!  (Which we're not doing right now because we're not
- * measuring them yet).
+ * It would make sense to put struct rusage in the signal_struct,
+ * except that would make the signal_struct be *really big*.
+ * TODO: Perhaps a thread-specific rusage value would be useful.
  *
  * This is SMP safe.  Either we are called from sys_getrusage on ourselves
  * below (we know we aren't going to exit/disappear and only we change our
@@ -1547,24 +1545,27 @@
 	memset((char *) &r, 0, sizeof(r));
 	switch (who) {
 		case RUSAGE_SELF:
-			jiffies_to_timeval(p->utime, &r.ru_utime);
-			jiffies_to_timeval(p->stime, &r.ru_stime);
+			jiffies_to_timeval(p->signal->proc_usr_time, &r.ru_utime);
+			jiffies_to_timeval(p->signal->proc_sys_time, &r.ru_stime);
+			/* these are still broken -- should be per-process */
 			r.ru_nvcsw = p->nvcsw;
 			r.ru_nivcsw = p->nivcsw;
 			r.ru_minflt = p->min_flt;
 			r.ru_majflt = p->maj_flt;
 			break;
 		case RUSAGE_CHILDREN:
-			jiffies_to_timeval(p->cutime, &r.ru_utime);
-			jiffies_to_timeval(p->cstime, &r.ru_stime);
+			jiffies_to_timeval(p->signal->dead_usr_time, &r.ru_utime);
+			jiffies_to_timeval(p->signal->dead_sys_time, &r.ru_stime);
+			/* these are still broken -- should be per-process */
 			r.ru_nvcsw = p->cnvcsw;
 			r.ru_nivcsw = p->cnivcsw;
 			r.ru_minflt = p->cmin_flt;
 			r.ru_majflt = p->cmaj_flt;
 			break;
 		default:
-			jiffies_to_timeval(p->utime + p->cutime, &r.ru_utime);
-			jiffies_to_timeval(p->stime + p->cstime, &r.ru_stime);
+			jiffies_to_timeval(p->signal->proc_usr_time + p->signal->dead_usr_time, &r.ru_utime);
+			jiffies_to_timeval(p->signal->proc_sys_time + p->signal->dead_sys_time, &r.ru_stime);
+			/* these are still broken -- should be per-process */
 			r.ru_nvcsw = p->nvcsw + p->cnvcsw;
 			r.ru_nivcsw = p->nivcsw + p->cnivcsw;
 			r.ru_minflt = p->min_flt + p->cmin_flt;
diff -Naurd a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	2004-08-24 03:03:31.000000000 -0400
+++ b/kernel/timer.c	2004-08-31 00:33:25.000000000 -0400
@@ -790,8 +790,10 @@
 {
 	unsigned long psecs;
 
-	psecs = (p->utime += user);
-	psecs += (p->stime += system);
+	p->task_usr_time += user;
+	p->task_sys_time += system;
+	psecs  = (p->signal->proc_usr_time += user);
+	psecs += (p->signal->proc_sys_time += system);
 	if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_cur) {
 		/* Send SIGXCPU every second.. */
 		if (!(psecs % HZ))
diff -Naurd a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c	2004-08-24 03:02:48.000000000 -0400
+++ b/mm/oom_kill.c	2004-08-31 00:43:00.000000000 -0400
@@ -60,7 +60,7 @@
 	 * particular reason for this other than that it turned out to work
 	 * very well in practice.
 	 */
-	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
+	cpu_time = (p->signal->proc_usr_time + p->signal->proc_sys_time) >> (SHIFT_HZ + 3);
 	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	s = int_sqrt(cpu_time);



