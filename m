Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWBNKNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWBNKNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWBNKLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:11:35 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:37610 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030316AbWBNKLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:31 -0500
Date: Tue, 14 Feb 2006 11:11:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 07/12] hrtimer: remove data field
Message-ID: <Pine.LNX.4.61.0602141111200.3726@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The nanosleep cleanup allows to remove the data field of hrtimer. The
callback function can use container_of() to get it's own data. Since the
hrtimer structure is usually embedded in other structures, the code also
becomes a bit simpler.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 fs/exec.c               |    2 +-
 include/linux/hrtimer.h |    3 +--
 include/linux/sched.h   |    1 +
 include/linux/timer.h   |    3 ++-
 kernel/fork.c           |    2 +-
 kernel/hrtimer.c        |   11 ++++-------
 kernel/itimer.c         |   12 +++++-------
 kernel/posix-timers.c   |    7 +++----
 8 files changed, 18 insertions(+), 23 deletions(-)

Index: linux-2.6-git/fs/exec.c
===================================================================
--- linux-2.6-git.orig/fs/exec.c	2006-02-14 04:56:21.000000000 +0100
+++ linux-2.6-git/fs/exec.c	2006-02-14 04:56:39.000000000 +0100
@@ -632,7 +632,7 @@ static int de_thread(struct task_struct 
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->real_timer.data = current;
+		sig->tsk = current;
 		spin_unlock_irq(lock);
 		if (hrtimer_cancel(&sig->real_timer))
 			hrtimer_restart(&sig->real_timer);
Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-14 04:56:36.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-14 04:56:39.000000000 +0100
@@ -55,8 +55,7 @@ struct hrtimer_base;
 struct hrtimer {
 	struct rb_node		node;
 	ktime_t			expires;
-	int			(*function)(void *);
-	void			*data;
+	int			(*function)(struct hrtimer *);
 	struct hrtimer_base	*base;
 };
 
Index: linux-2.6-git/include/linux/sched.h
===================================================================
--- linux-2.6-git.orig/include/linux/sched.h	2006-02-14 04:56:21.000000000 +0100
+++ linux-2.6-git/include/linux/sched.h	2006-02-14 04:56:39.000000000 +0100
@@ -401,6 +401,7 @@ struct signal_struct {
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
+	struct task_struct *tsk;
 	ktime_t it_real_incr;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
Index: linux-2.6-git/include/linux/timer.h
===================================================================
--- linux-2.6-git.orig/include/linux/timer.h	2006-02-14 04:56:21.000000000 +0100
+++ linux-2.6-git/include/linux/timer.h	2006-02-14 04:56:39.000000000 +0100
@@ -96,6 +96,7 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern int it_real_fn(void *);
+struct hrtimer;
+extern int it_real_fn(struct hrtimer *);
 
 #endif
Index: linux-2.6-git/kernel/fork.c
===================================================================
--- linux-2.6-git.orig/kernel/fork.c	2006-02-14 04:56:21.000000000 +0100
+++ linux-2.6-git/kernel/fork.c	2006-02-14 04:56:39.000000000 +0100
@@ -845,7 +845,7 @@ static inline int copy_signal(unsigned l
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_REL);
 	sig->it_real_incr.tv64 = 0;
 	sig->real_timer.function = it_real_fn;
-	sig->real_timer.data = tsk;
+	sig->tsk = tsk;
 
 	sig->it_virt_expires = cputime_zero;
 	sig->it_virt_incr = cputime_zero;
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-14 04:56:36.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-14 04:56:39.000000000 +0100
@@ -546,21 +546,19 @@ static inline void run_hrtimer_queue(str
 
 	while ((node = base->first)) {
 		struct hrtimer *timer;
-		int (*fn)(void *);
+		int (*fn)(struct hrtimer *);
 		int restart;
-		void *data;
 
 		timer = rb_entry(node, struct hrtimer, node);
 		if (now.tv64 <= timer->expires.tv64)
 			break;
 
 		fn = timer->function;
-		data = timer->data;
 		set_curr_timer(base, timer);
 		__remove_hrtimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
-		restart = fn(data);
+		restart = fn(timer);
 
 		spin_lock_irq(&base->lock);
 
@@ -603,9 +601,9 @@ struct sleep_hrtimer {
 	int done;
 };
 
-static int nanosleep_wakeup(void *data)
+static int nanosleep_wakeup(struct hrtimer *timer)
 {
-	struct sleep_hrtimer *t = data;
+	struct sleep_hrtimer *t = container_of(timer, struct sleep_hrtimer, timer);
 
 	t->done = 1;
 	wake_up_process(t->task);
@@ -616,7 +614,6 @@ static int nanosleep_wakeup(void *data)
 static int __sched do_nanosleep(struct sleep_hrtimer *t, enum hrtimer_mode mode)
 {
 	t->timer.function = nanosleep_wakeup;
-	t->timer.data = t;
 	t->task = current;
 	t->done = 0;
 
Index: linux-2.6-git/kernel/itimer.c
===================================================================
--- linux-2.6-git.orig/kernel/itimer.c	2006-02-14 04:56:33.000000000 +0100
+++ linux-2.6-git/kernel/itimer.c	2006-02-14 04:56:39.000000000 +0100
@@ -128,16 +128,14 @@ asmlinkage long sys_getitimer(int which,
 /*
  * The timer is automagically restarted, when interval != 0
  */
-int it_real_fn(void *data)
+int it_real_fn(struct hrtimer *timer)
 {
-	struct task_struct *tsk = (struct task_struct *) data;
+	struct signal_struct *sig = container_of(timer, struct signal_struct, real_timer);
 
-	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, tsk);
+	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
-	if (tsk->signal->it_real_incr.tv64 != 0) {
-		hrtimer_forward(&tsk->signal->real_timer,
-			       tsk->signal->real_timer.base->last_expired,
-			       tsk->signal->it_real_incr);
+	if (sig->it_real_incr.tv64 != 0) {
+		hrtimer_forward(timer, timer->base->last_expired, sig->it_real_incr);
 
 		return HRTIMER_RESTART;
 	}
Index: linux-2.6-git/kernel/posix-timers.c
===================================================================
--- linux-2.6-git.orig/kernel/posix-timers.c	2006-02-14 04:56:33.000000000 +0100
+++ linux-2.6-git/kernel/posix-timers.c	2006-02-14 04:56:39.000000000 +0100
@@ -144,7 +144,7 @@ static int common_timer_set(struct k_iti
 			    struct itimerspec *, struct itimerspec *);
 static int common_timer_del(struct k_itimer *timer);
 
-static int posix_timer_fn(void *data);
+static int posix_timer_fn(struct hrtimer *data);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -331,9 +331,9 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
-static int posix_timer_fn(void *data)
+static int posix_timer_fn(struct hrtimer *data)
 {
-	struct k_itimer *timr = data;
+	struct k_itimer *timr = container_of(data, struct k_itimer, it.real.timer);
 	unsigned long flags;
 	int si_private = 0;
 	int ret = HRTIMER_NORESTART;
@@ -715,7 +715,6 @@ common_timer_set(struct k_itimer *timr, 
 
 	mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
 	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
-	timr->it.real.timer.data = timr;
 	timr->it.real.timer.function = posix_timer_fn;
 
 	timer->expires = timespec_to_ktime(new_setting->it_value);
