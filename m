Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVLAAK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVLAAK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVK3X6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:06 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54434
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751296AbVK3X5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:48 -0500
Subject: [patch 17/43] Switch itimers to ktimer
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:28 +0100
Message-Id: <1133395409.32542.460.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-convert-itimer.patch)
- switch itimers to a ktimers-based implementation

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 fs/exec.c             |    7 +--
 fs/proc/array.c       |    6 +-
 include/linux/sched.h |    4 -
 include/linux/timer.h |    2 
 kernel/exit.c         |    2 
 kernel/fork.c         |    5 --
 kernel/itimer.c       |  108 ++++++++++++++++++++++----------------------------
 7 files changed, 62 insertions(+), 72 deletions(-)

Index: linux-2.6.15-rc2-rework/fs/exec.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/fs/exec.c
+++ linux-2.6.15-rc2-rework/fs/exec.c
@@ -642,10 +642,11 @@ static inline int de_thread(struct task_
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->real_timer.data = (unsigned long)current;
+		sig->real_timer.data = current;
 		spin_unlock_irq(lock);
-		if (del_timer_sync(&sig->real_timer))
-			add_timer(&sig->real_timer);
+		if (ktimer_cancel(&sig->real_timer))
+			ktimer_start(&sig->real_timer, NULL,
+				     KTIMER_RESTART|KTIMER_NOCHECK);
 		spin_lock_irq(lock);
 	}
 	while (atomic_read(&sig->count) > count) {
Index: linux-2.6.15-rc2-rework/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/fs/proc/array.c
+++ linux-2.6.15-rc2-rework/fs/proc/array.c
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
Index: linux-2.6.15-rc2-rework/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/sched.h
+++ linux-2.6.15-rc2-rework/include/linux/sched.h
@@ -104,6 +104,7 @@ extern unsigned long nr_iowait(void);
 #include <linux/param.h>
 #include <linux/resource.h>
 #include <linux/timer.h>
+#include <linux/ktimer.h>
 
 #include <asm/processor.h>
 
@@ -402,8 +403,7 @@ struct signal_struct {
 	struct list_head posix_timers;
 
 	/* ITIMER_REAL timer for the process */
-	struct timer_list real_timer;
-	unsigned long it_real_value, it_real_incr;
+	struct ktimer real_timer;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
 	cputime_t it_prof_expires, it_virt_expires;
Index: linux-2.6.15-rc2-rework/include/linux/timer.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/timer.h
+++ linux-2.6.15-rc2-rework/include/linux/timer.h
@@ -96,6 +96,6 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern void it_real_fn(unsigned long);
+extern void it_real_fn(void *);
 
 #endif
Index: linux-2.6.15-rc2-rework/kernel/exit.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/exit.c
+++ linux-2.6.15-rc2-rework/kernel/exit.c
@@ -842,7 +842,7 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
- 		del_timer_sync(&tsk->signal->real_timer);
+ 		ktimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
Index: linux-2.6.15-rc2-rework/kernel/fork.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/fork.c
+++ linux-2.6.15-rc2-rework/kernel/fork.c
@@ -793,10 +793,9 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	sig->it_real_value = sig->it_real_incr = 0;
+	ktimer_init(&sig->real_timer);
 	sig->real_timer.function = it_real_fn;
-	sig->real_timer.data = (unsigned long) tsk;
-	init_timer(&sig->real_timer);
+	sig->real_timer.data = tsk;
 
 	sig->it_virt_expires = cputime_zero;
 	sig->it_virt_incr = cputime_zero;
Index: linux-2.6.15-rc2-rework/kernel/itimer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/itimer.c
+++ linux-2.6.15-rc2-rework/kernel/itimer.c
@@ -12,36 +12,49 @@
 #include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/posix-timers.h>
+#include <linux/ktimer.h>
 
 #include <asm/uaccess.h>
 
-static unsigned long it_real_value(struct signal_struct *sig)
+/**
+ * itimer_get_remtime - get remaining time for the timer
+ *
+ * @timer: the timer to read
+ * @fake:  a pending, but expired timer returns fake (itimers kludge)
+ *
+ * Returns the delta between the expiry time and now, which can be
+ * less than zero or the fake value described above.
+ */
+static struct timeval itimer_get_remtime(struct ktimer *timer, long fake)
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
+	ktime_t rem = ktimer_get_remtime(timer);
+
+	/*
+	 * Racy but safe: if the itimer expires after the above
+	 * ktimer_get_remtime() call but before this condition
+	 * then we return KTIMER_ZERO - which is correct.
+	 */
+	if (ktimer_active(timer)) {
+		if (rem.tv64 <= 0)
+			rem = ktime_set(0, fake);
+	} else
+		rem.tv64 = 0;
+
+	return ktime_to_timeval(rem);
 }
 
 int do_getitimer(int which, struct itimerval *value)
 {
 	struct task_struct *tsk = current;
-	unsigned long interval, val;
+	ktime_t interval;
 	cputime_t cinterval, cval;
 
 	switch (which) {
 	case ITIMER_REAL:
-		spin_lock_irq(&tsk->sighand->siglock);
-		interval = tsk->signal->it_real_incr;
-		val = it_real_value(tsk->signal);
-		spin_unlock_irq(&tsk->sighand->siglock);
-		jiffies_to_timeval(val, &value->it_value);
-		jiffies_to_timeval(interval, &value->it_interval);
+		interval = tsk->signal->real_timer.interval;
+		value->it_value = itimer_get_remtime(&tsk->signal->real_timer,
+						     NSEC_PER_USEC);
+		value->it_interval = ktime_to_timeval(interval);
 		break;
 	case ITIMER_VIRTUAL:
 		read_lock(&tasklist_lock);
@@ -113,59 +126,36 @@ asmlinkage long sys_getitimer(int which,
 }
 

-void it_real_fn(unsigned long __data)
+/*
+ * The timer is automagically restarted, when interval != 0
+ */
+void it_real_fn(void *data)
 {
-	struct task_struct * p = (struct task_struct *) __data;
-	unsigned long inc = p->signal->it_real_incr;
-
-	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
-
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
+	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, data);
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
- 	unsigned long val, interval, expires;
+	struct ktimer *timer;
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
+		ktimer_cancel(timer);
 		if (ovalue) {
-			jiffies_to_timeval(val, &ovalue->it_value);
-			jiffies_to_timeval(interval,
-					   &ovalue->it_interval);
-		}
+			ovalue->it_value = itimer_get_remtime(timer,
+							      NSEC_PER_USEC);
+			ovalue->it_interval = ktime_to_timeval(timer->interval);
+		}
+		timer->interval = ktimer_round_timeval(timer,
+							&value->it_interval);
+		expires = timeval_to_ktime(value->it_value);
+		if (expires.tv64 != 0)
+			ktimer_restart(timer, &expires,
+				KTIMER_REL | KTIMER_NOCHECK | KTIMER_ROUND);
 		break;
 	case ITIMER_VIRTUAL:
 		nval = timeval_to_cputime(&value->it_value);

--

