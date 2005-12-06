Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVLFAkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVLFAkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbVLFAfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:08 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34254
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751531AbVLFAej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:39 -0500
Message-Id: <20051206000155.185937000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:43 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 17/21] Switch itimers to hrtimer
Content-Disposition: inline; filename=hrtimer-convert-itimer.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- switch itimers to a hrtimers-based implementation

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 fs/exec.c             |    6 +-
 fs/proc/array.c       |    6 +-
 include/linux/sched.h |    5 +-
 include/linux/timer.h |    2 
 kernel/exit.c         |    2 
 kernel/fork.c         |    6 +-
 kernel/itimer.c       |  108 ++++++++++++++++++++++++--------------------------
 7 files changed, 66 insertions(+), 69 deletions(-)

Index: linux-2.6.15-rc5/fs/exec.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/exec.c
+++ linux-2.6.15-rc5/fs/exec.c
@@ -632,10 +632,10 @@ static inline int de_thread(struct task_
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->real_timer.data = (unsigned long)current;
+		sig->real_timer.data = current;
 		spin_unlock_irq(lock);
-		if (del_timer_sync(&sig->real_timer))
-			add_timer(&sig->real_timer);
+		if (hrtimer_cancel(&sig->real_timer))
+			hrtimer_restart(&sig->real_timer);
 		spin_lock_irq(lock);
 	}
 	while (atomic_read(&sig->count) > count) {
Index: linux-2.6.15-rc5/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/proc/array.c
+++ linux-2.6.15-rc5/fs/proc/array.c
@@ -330,7 +330,7 @@ static int do_task_stat(struct task_stru
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
-	unsigned long it_real_value = 0;
+	DEFINE_KTIME(it_real_value);
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
 
@@ -386,7 +386,7 @@ static int do_task_stat(struct task_stru
 			utime = cputime_add(utime, task->signal->utime);
 			stime = cputime_add(stime, task->signal->stime);
 		}
-		it_real_value = task->signal->it_real_value;
+		it_real_value = task->signal->real_timer.expires;
 	}
 	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
@@ -435,7 +435,7 @@ static int do_task_stat(struct task_stru
 		priority,
 		nice,
 		num_threads,
-		jiffies_to_clock_t(it_real_value),
+		(long) ktime_to_clock_t(it_real_value),
 		start_time,
 		vsize,
 		mm ? get_mm_rss(mm) : 0,
Index: linux-2.6.15-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sched.h
+++ linux-2.6.15-rc5/include/linux/sched.h
@@ -104,6 +104,7 @@ extern unsigned long nr_iowait(void);
 #include <linux/param.h>
 #include <linux/resource.h>
 #include <linux/timer.h>
+#include <linux/hrtimer.h>
 
 #include <asm/processor.h>
 
@@ -402,8 +403,8 @@ struct signal_struct {
 	struct list_head posix_timers;
 
 	/* ITIMER_REAL timer for the process */
-	struct timer_list real_timer;
-	unsigned long it_real_value, it_real_incr;
+	struct hrtimer real_timer;
+	ktime_t it_real_incr;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
 	cputime_t it_prof_expires, it_virt_expires;
Index: linux-2.6.15-rc5/include/linux/timer.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/timer.h
+++ linux-2.6.15-rc5/include/linux/timer.h
@@ -96,6 +96,6 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern void it_real_fn(unsigned long);
+extern int it_real_fn(void *);
 
 #endif
Index: linux-2.6.15-rc5/kernel/exit.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/exit.c
+++ linux-2.6.15-rc5/kernel/exit.c
@@ -842,7 +842,7 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
- 		del_timer_sync(&tsk->signal->real_timer);
+ 		hrtimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
Index: linux-2.6.15-rc5/kernel/fork.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/fork.c
+++ linux-2.6.15-rc5/kernel/fork.c
@@ -793,10 +793,10 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	sig->it_real_value = sig->it_real_incr = 0;
+	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC);
+	sig->it_real_incr.tv64 = 0;
 	sig->real_timer.function = it_real_fn;
-	sig->real_timer.data = (unsigned long) tsk;
-	init_timer(&sig->real_timer);
+	sig->real_timer.data = tsk;
 
 	sig->it_virt_expires = cputime_zero;
 	sig->it_virt_incr = cputime_zero;
Index: linux-2.6.15-rc5/kernel/itimer.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/itimer.c
+++ linux-2.6.15-rc5/kernel/itimer.c
@@ -12,36 +12,46 @@
 #include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/posix-timers.h>
+#include <linux/hrtimer.h>
 
 #include <asm/uaccess.h>
 
-static unsigned long it_real_value(struct signal_struct *sig)
+/**
+ * itimer_get_remtime - get remaining time for the timer
+ *
+ * @timer: the timer to read
+ *
+ * Returns the delta between the expiry time and now, which can be
+ * less than zero or 1usec for an pending expired timer
+ */
+static struct timeval itimer_get_remtime(struct hrtimer *timer)
 {
-	unsigned long val = 0;
-	if (timer_pending(&sig->real_timer)) {
-		val = sig->real_timer.expires - jiffies;
-
-		/* look out for negative/zero itimer.. */
-		if ((long) val <= 0)
-			val = 1;
-	}
-	return val;
+	ktime_t rem = hrtimer_get_remaining(timer);
+
+	/*
+	 * Racy but safe: if the itimer expires after the above
+	 * hrtimer_get_remtime() call but before this condition
+	 * then we return 0 - which is correct.
+	 */
+	if (hrtimer_active(timer)) {
+		if (rem.tv64 <= 0)
+			rem.tv64 = NSEC_PER_USEC;
+	} else
+		rem.tv64 = 0;
+
+	return ktime_to_timeval(rem);
 }
 
 int do_getitimer(int which, struct itimerval *value)
 {
 	struct task_struct *tsk = current;
-	unsigned long interval, val;
 	cputime_t cinterval, cval;
 
 	switch (which) {
 	case ITIMER_REAL:
-		spin_lock_irq(&tsk->sighand->siglock);
-		interval = tsk->signal->it_real_incr;
-		val = it_real_value(tsk->signal);
-		spin_unlock_irq(&tsk->sighand->siglock);
-		jiffies_to_timeval(val, &value->it_value);
-		jiffies_to_timeval(interval, &value->it_interval);
+		value->it_value = itimer_get_remtime(&tsk->signal->real_timer);
+		value->it_interval =
+			ktime_to_timeval(tsk->signal->it_real_incr);
 		break;
 	case ITIMER_VIRTUAL:
 		read_lock(&tasklist_lock);
@@ -113,59 +123,45 @@ asmlinkage long sys_getitimer(int which,
 }
 
 
-void it_real_fn(unsigned long __data)
+/*
+ * The timer is automagically restarted, when interval != 0
+ */
+int it_real_fn(void *data)
 {
-	struct task_struct * p = (struct task_struct *) __data;
-	unsigned long inc = p->signal->it_real_incr;
+	struct task_struct *tsk = (struct task_struct *) data;
 
-	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
+	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, tsk);
 
-	/*
-	 * Now restart the timer if necessary.  We don't need any locking
-	 * here because do_setitimer makes sure we have finished running
-	 * before it touches anything.
-	 * Note, we KNOW we are (or should be) at a jiffie edge here so
-	 * we don't need the +1 stuff.  Also, we want to use the prior
-	 * expire value so as to not "slip" a jiffie if we are late.
-	 * Deal with requesting a time prior to "now" here rather than
-	 * in add_timer.
-	 */
-	if (!inc)
-		return;
-	while (time_before_eq(p->signal->real_timer.expires, jiffies))
-		p->signal->real_timer.expires += inc;
-	add_timer(&p->signal->real_timer);
+	if (tsk->signal->it_real_incr.tv64 != 0) {
+		hrtimer_forward(&tsk->signal->real_timer,
+			       tsk->signal->it_real_incr);
+
+		return HRTIMER_RESTART;
+	}
+	return HRTIMER_NORESTART;
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
- 	unsigned long val, interval, expires;
+	struct hrtimer *timer;
+	ktime_t expires;
 	cputime_t cval, cinterval, nval, ninterval;
 
 	switch (which) {
 	case ITIMER_REAL:
-again:
-		spin_lock_irq(&tsk->sighand->siglock);
-		interval = tsk->signal->it_real_incr;
-		val = it_real_value(tsk->signal);
-		/* We are sharing ->siglock with it_real_fn() */
-		if (try_to_del_timer_sync(&tsk->signal->real_timer) < 0) {
-			spin_unlock_irq(&tsk->sighand->siglock);
-			goto again;
-		}
-		tsk->signal->it_real_incr =
-			timeval_to_jiffies(&value->it_interval);
-		expires = timeval_to_jiffies(&value->it_value);
-		if (expires)
-			mod_timer(&tsk->signal->real_timer,
-				  jiffies + 1 + expires);
-		spin_unlock_irq(&tsk->sighand->siglock);
+		timer = &tsk->signal->real_timer;
+		hrtimer_cancel(timer);
 		if (ovalue) {
-			jiffies_to_timeval(val, &ovalue->it_value);
-			jiffies_to_timeval(interval,
-					   &ovalue->it_interval);
+			ovalue->it_value = itimer_get_remtime(timer);
+			ovalue->it_interval
+				= ktime_to_timeval(tsk->signal->it_real_incr);
 		}
+		tsk->signal->it_real_incr =
+			timeval_to_ktime(value->it_interval);
+		expires = timeval_to_ktime(value->it_value);
+		if (expires.tv64 != 0)
+			hrtimer_start(timer, expires, HRTIMER_REL);
 		break;
 	case ITIMER_VIRTUAL:
 		nval = timeval_to_cputime(&value->it_value);

--

