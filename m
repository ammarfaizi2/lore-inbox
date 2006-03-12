Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWCLRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWCLRJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWCLRJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:09:52 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13546
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751120AbWCLRJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:09:37 -0500
Subject: [PATCH] hrtimers remove data field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 18:09:58 +0100
Message-Id: <1142183399.19916.523.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>

The nanosleep cleanup allows to remove the data field of hrtimer. The
callback function can use container_of() to get it's own data. Since 
the hrtimer structure is anyway embedded in other structures, this adds
no overhead.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 fs/exec.c               |    2 +-
 include/linux/hrtimer.h |    5 +----
 include/linux/sched.h   |    1 +
 include/linux/timer.h   |    3 ++-
 kernel/fork.c           |    2 +-
 kernel/hrtimer.c        |   12 +++++-------
 kernel/itimer.c         |   15 +++++++--------
 kernel/posix-timers.c   |    9 ++++-----
 8 files changed, 22 insertions(+), 27 deletions(-)

Index: linux-2.6.16-updates/fs/exec.c
===================================================================
--- linux-2.6.16-updates.orig/fs/exec.c
+++ linux-2.6.16-updates/fs/exec.c
@@ -632,7 +632,7 @@ static int de_thread(struct task_struct 
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->real_timer.data = current;
+		sig->tsk = current;
 		spin_unlock_irq(lock);
 		if (hrtimer_cancel(&sig->real_timer))
 			hrtimer_restart(&sig->real_timer);
Index: linux-2.6.16-updates/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/hrtimer.h
+++ linux-2.6.16-updates/include/linux/hrtimer.h
@@ -45,9 +45,7 @@ struct hrtimer_base;
  * @expires:	the absolute expiry time in the hrtimers internal
  *		representation. The time is related to the clock on
  *		which the timer is based.
- * @state:	state of the timer
  * @function:	timer expiry callback function
- * @data:	argument for the callback function
  * @base:	pointer to the timer base (per cpu and per clock)
  *
  * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()
@@ -55,8 +53,7 @@ struct hrtimer_base;
 struct hrtimer {
 	struct rb_node		node;
 	ktime_t			expires;
-	int			(*function)(void *);
-	void			*data;
+	int			(*function)(struct hrtimer *);
 	struct hrtimer_base	*base;
 };
 
Index: linux-2.6.16-updates/include/linux/sched.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/sched.h
+++ linux-2.6.16-updates/include/linux/sched.h
@@ -402,6 +402,7 @@ struct signal_struct {
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
+	struct task_struct *tsk;
 	ktime_t it_real_incr;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
Index: linux-2.6.16-updates/include/linux/timer.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/timer.h
+++ linux-2.6.16-updates/include/linux/timer.h
@@ -96,6 +96,7 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern int it_real_fn(void *);
+struct hrtimer;
+extern int it_real_fn(struct hrtimer *);
 
 #endif
Index: linux-2.6.16-updates/kernel/fork.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/fork.c
+++ linux-2.6.16-updates/kernel/fork.c
@@ -845,7 +845,7 @@ static inline int copy_signal(unsigned l
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_REL);
 	sig->it_real_incr.tv64 = 0;
 	sig->real_timer.function = it_real_fn;
-	sig->real_timer.data = tsk;
+	sig->tsk = tsk;
 
 	sig->it_virt_expires = cputime_zero;
 	sig->it_virt_incr = cputime_zero;
Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -613,21 +613,19 @@ static inline void run_hrtimer_queue(str
 
 	while ((node = base->first)) {
 		struct hrtimer *timer;
-		int (*fn)(void *);
+		int (*fn)(struct hrtimer *);
 		int restart;
-		void *data;
 
 		timer = rb_entry(node, struct hrtimer, node);
 		if (base->softirq_time.tv64 <= timer->expires.tv64)
 			break;
 
 		fn = timer->function;
-		data = timer->data;
 		set_curr_timer(base, timer);
 		__remove_hrtimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
-		restart = fn(data);
+		restart = fn(timer);
 
 		spin_lock_irq(&base->lock);
 
@@ -664,9 +662,10 @@ struct sleep_hrtimer {
 	int expired;
 };
 
-static int nanosleep_wakeup(void *data)
+static int nanosleep_wakeup(struct hrtimer *timer)
 {
-	struct sleep_hrtimer *t = data;
+	struct sleep_hrtimer *t =
+		container_of(timer, struct sleep_hrtimer, timer);
 
 	t->expired = 1;
 	wake_up_process(t->task);
@@ -677,7 +676,6 @@ static int nanosleep_wakeup(void *data)
 static int __sched do_nanosleep(struct sleep_hrtimer *t, enum hrtimer_mode mode)
 {
 	t->timer.function = nanosleep_wakeup;
-	t->timer.data = t;
 	t->task = current;
 	t->expired = 0;
 
Index: linux-2.6.16-updates/kernel/itimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/itimer.c
+++ linux-2.6.16-updates/kernel/itimer.c
@@ -128,17 +128,16 @@ asmlinkage long sys_getitimer(int which,
 /*
  * The timer is automagically restarted, when interval != 0
  */
-int it_real_fn(void *data)
+int it_real_fn(struct hrtimer *timer)
 {
-	struct task_struct *tsk = (struct task_struct *) data;
+	struct signal_struct *sig =
+	    container_of(timer, struct signal_struct, real_timer);
 
-	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, tsk);
-
-	if (tsk->signal->it_real_incr.tv64 != 0) {
-		hrtimer_forward(&tsk->signal->real_timer,
-				tsk->signal->real_timer.base->softirq_time,
-				tsk->signal->it_real_incr);
+	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
+	if (sig->it_real_incr.tv64 != 0) {
+		hrtimer_forward(timer, timer->base->softirq_time,
+				sig->it_real_incr);
 		return HRTIMER_RESTART;
 	}
 	return HRTIMER_NORESTART;
Index: linux-2.6.16-updates/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/posix-timers.c
+++ linux-2.6.16-updates/kernel/posix-timers.c
@@ -144,7 +144,7 @@ static int common_timer_set(struct k_iti
 			    struct itimerspec *, struct itimerspec *);
 static int common_timer_del(struct k_itimer *timer);
 
-static int posix_timer_fn(void *data);
+static int posix_timer_fn(struct hrtimer *data);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -333,14 +333,14 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
-static int posix_timer_fn(void *data)
+static int posix_timer_fn(struct hrtimer *timer)
 {
-	struct k_itimer *timr = data;
-	struct hrtimer *timer = &timr->it.real.timer;
+	struct k_itimer *timr;
 	unsigned long flags;
 	int si_private = 0;
 	int ret = HRTIMER_NORESTART;
 
+	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
 
 	if (timr->it.real.interval.tv64 != 0)
@@ -718,7 +718,6 @@ common_timer_set(struct k_itimer *timr, 
 
 	mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
 	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
-	timr->it.real.timer.data = timr;
 	timr->it.real.timer.function = posix_timer_fn;
 
 	timer->expires = timespec_to_ktime(new_setting->it_value);


