Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVAWXX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVAWXX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVAWXXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:23:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8597 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261373AbVAWXWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:22:46 -0500
Date: Sun, 23 Jan 2005 15:22:38 -0800
Message-Id: <200501232322.j0NNMcxe006476@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 1/7] posix-timers: tidy up clock interfaces and consolidate dispatch logic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the posix-timers interfaces for defining clocks, and
the calls to them.  It fixes some sloppy types, adds a clockid_t parameter
to the calls that lacked it, and adds a function pointer that can be used
for clock_getres.  It further cleans up the posix-timers.c code using the
k_clock function pointers or default functions when no hooks are supplied,
consolidating repeated code into shared inline functions or macros.  
This paves the way for adding the CPU clock hooks.

The mmtimer.c changes are untested, but obviously can't be wrong.
There aren't any other struct k_clock definitions in the tree, but any
others would need to be updated for the function signature changes.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/drivers/char/mmtimer.c
+++ linux-2.6/drivers/char/mmtimer.c
@@ -378,7 +378,7 @@ static int sgi_clock_period;
 static struct timespec sgi_clock_offset;
 static int sgi_clock_period;
 
-static int sgi_clock_get(struct timespec *tp)
+static int sgi_clock_get(clockid_t clockid, struct timespec *tp)
 {
 	u64 nsec;
 
@@ -389,7 +389,7 @@ static int sgi_clock_get(struct timespec
 	return 0;
 };
 
-static int sgi_clock_set(struct timespec *tp)
+static int sgi_clock_set(clockid_t clockid, struct timespec *tp)
 {
 
 	u64 nsec;
--- linux-2.6/include/linux/posix-timers.h
+++ linux-2.6/include/linux/posix-timers.h
@@ -30,12 +30,12 @@ struct k_clock_abs {
 };
 struct k_clock {
 	int res;		/* in nano seconds */
+	int (*clock_getres) (clockid_t which_clock, struct timespec *tp);
 	struct k_clock_abs *abs_struct;
-	int (*clock_set) (struct timespec * tp);
-	int (*clock_get) (struct timespec * tp);
+	int (*clock_set) (clockid_t which_clock, struct timespec * tp);
+	int (*clock_get) (clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (int which_clock, int flags,
-		       struct timespec * t);
+	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -44,12 +44,12 @@ struct k_clock {
 			   struct itimerspec * cur_setting);
 };
 
-void register_posix_clock(int clock_id, struct k_clock *new_clock);
+void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock);
 
 /* Error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
-int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);
-int do_posix_clock_nosettime(struct timespec *tp);
+int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *);
+int do_posix_clock_nosettime(clockid_t, struct timespec *tp);
 
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -173,22 +173,12 @@ static struct k_clock posix_clocks[MAX_C
 static struct k_clock_abs abs_list = {.list = LIST_HEAD_INIT(abs_list.list),
 				      .lock = SPIN_LOCK_UNLOCKED};
 
-#define if_clock_do(clock_fun,alt_fun,parms) \
-		(!clock_fun) ? alt_fun parms : clock_fun parms
-
-#define p_timer_get(clock,a,b) \
-	       	if_clock_do((clock)->timer_get,do_timer_gettime, (a,b))
-
-#define p_nsleep(clock,a,b,c) \
-		if_clock_do((clock)->nsleep, do_nsleep, (a,b,c))
-
-#define p_timer_del(clock,a) \
-		if_clock_do((clock)->timer_del, do_timer_delete, (a))
-
-static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
+static void posix_timer_fn(unsigned long);
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
+static int do_posix_clock_monotonic_get(clockid_t, struct timespec *tp);
+
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -197,6 +187,109 @@ static inline void unlock_timer(struct k
 }
 
 /*
+ * Define this to initialize every k_clock function table so all its
+ * function pointers are non-null, and always do indirect calls through the
+ * table.  Leave it undefined to instead leave null function pointers and
+ * decide at the call sites between a direct call (maybe inlined) to the
+ * default function and an indirect call through the table when it's filled
+ * in.  Which style is preferable is whichever performs better in the
+ * common case of using the default functions.
+ *
+#define CLOCK_DISPATCH_DIRECT
+ */
+
+#ifdef CLOCK_DISPATCH_DIRECT
+#define CLOCK_DISPATCH(clock, call, arglist) \
+	((*posix_clocks[clock].call) arglist)
+#define DEFHOOK(name)	if (clock->name == NULL) clock->name = common_##name
+#define COMMONDEFN	static
+#else
+#define CLOCK_DISPATCH(clock, call, arglist) \
+	(posix_clocks[clock].call != NULL \
+	 ? (*posix_clocks[clock].call) arglist : common_##call arglist)
+#define DEFHOOK(name)		(void) 0 /* Nothing here.  */
+#define COMMONDEFN	static inline
+#endif
+
+/*
+ * Default clock hook functions when the struct k_clock passed
+ * to register_posix_clock leaves a function pointer null.
+ *
+ * The function common_CALL is the default implementation for
+ * the function pointer CALL in struct k_clock.
+ */
+
+COMMONDEFN int common_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	tp->tv_sec = 0;
+	tp->tv_nsec = posix_clocks[which_clock].res;
+	return 0;
+}
+
+COMMONDEFN int common_clock_get(clockid_t which_clock, struct timespec *tp)
+{
+	getnstimeofday(tp);
+	return 0;
+}
+
+COMMONDEFN int common_clock_set(clockid_t which_clock, struct timespec *tp)
+{
+	return do_sys_settimeofday(tp, NULL);
+}
+
+COMMONDEFN int common_timer_create(struct k_itimer *new_timer)
+{
+	init_timer(&new_timer->it_timer);
+	new_timer->it_timer.expires = 0;
+	new_timer->it_timer.data = (unsigned long) new_timer;
+	new_timer->it_timer.function = posix_timer_fn;
+	set_timer_inactive(new_timer);
+	return 0;
+}
+
+/*
+ * These ones are defined below.
+ */
+static int common_nsleep(clockid_t, int flags, struct timespec *t);
+static void common_timer_get(struct k_itimer *, struct itimerspec *);
+static int common_timer_set(struct k_itimer *, int,
+			    struct itimerspec *, struct itimerspec *);
+static int common_timer_del(struct k_itimer *timer);
+
+/*
+ * Install default functions for hooks not filled in.
+ */
+static inline void common_default_hooks(struct k_clock *clock)
+{
+	DEFHOOK(clock_getres);
+	DEFHOOK(clock_get);
+	DEFHOOK(clock_set);
+	DEFHOOK(timer_create);
+	DEFHOOK(timer_set);
+	DEFHOOK(timer_get);
+	DEFHOOK(timer_del);
+	DEFHOOK(nsleep);
+}
+#undef	DEFHOOK
+
+/*
+ * Return nonzero iff we know a priori this clockid_t value is bogus.
+ */
+static inline int invalid_clockid(clockid_t which_clock)
+{
+	if ((unsigned) which_clock >= MAX_CLOCKS)
+		return 1;
+	if (posix_clocks[which_clock].clock_getres != NULL)
+		return 0;
+#ifndef CLOCK_DISPATCH_DIRECT
+	if (posix_clocks[which_clock].res != 0)
+		return 0;
+#endif
+	return 1;
+}
+
+
+/*
  * Initialize everything, well, just everything in Posix clocks/timers ;)
  */
 static __init int init_posix_timers(void)
@@ -206,7 +299,7 @@ static __init int init_posix_timers(void
 	};
 	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
 		.abs_struct = NULL,
-		.clock_get = do_posix_clock_monotonic_gettime,
+		.clock_get = do_posix_clock_monotonic_get,
 		.clock_set = do_posix_clock_nosettime
 	};
 
@@ -481,7 +574,7 @@ static inline struct task_struct * good_
 	return rtn;
 }
 
-void register_posix_clock(int clock_id, struct k_clock *new_clock)
+void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock)
 {
 	if ((unsigned) clock_id >= MAX_CLOCKS) {
 		printk("POSIX clock register failed for clock_id %d\n",
@@ -488,7 +581,9 @@ void register_posix_clock(int clock_id, 
 		       clock_id);
 		return;
 	}
+
 	posix_clocks[clock_id] = *new_clock;
+	common_default_hooks(&posix_clocks[clock_id]);
 }
 
 static struct k_itimer * alloc_posix_timer(void)
@@ -538,8 +633,7 @@ sys_timer_create(clockid_t which_clock,
 	sigevent_t event;
 	int it_id_set = IT_ID_NOT_SET;
 
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
-				!posix_clocks[which_clock].res)
+	if (invalid_clockid(which_clock))
 		return -EINVAL;
 
 	new_timer = alloc_posix_timer();
@@ -573,17 +667,9 @@ sys_timer_create(clockid_t which_clock,
 	new_timer->it_clock = which_clock;
 	new_timer->it_incr = 0;
 	new_timer->it_overrun = -1;
-	if (posix_clocks[which_clock].timer_create) {
-		error =  posix_clocks[which_clock].timer_create(new_timer);
-		if (error)
-			goto out;
-	} else {
-		init_timer(&new_timer->it_timer);
-		new_timer->it_timer.expires = 0;
-		new_timer->it_timer.data = (unsigned long) new_timer;
-		new_timer->it_timer.function = posix_timer_fn;
-		set_timer_inactive(new_timer);
-	}
+	error = CLOCK_DISPATCH(which_clock, timer_create, (new_timer));
+	if (error)
+		goto out;
 
 	/*
 	 * return the timer_id now.  The next step is hard to
@@ -734,7 +820,7 @@ static struct k_itimer * lock_timer(time
  * report.
  */
 static void
-do_timer_gettime(struct k_itimer *timr, struct itimerspec *cur_setting)
+common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
 	unsigned long expires;
 	struct now_struct now;
@@ -783,7 +869,7 @@ sys_timer_gettime(timer_t timer_id, stru
 	if (!timr)
 		return -EINVAL;
 
-	p_timer_get(&posix_clocks[timr->it_clock], timr, &cur_setting);
+	CLOCK_DISPATCH(timr->it_clock, timer_get, (timr, &cur_setting));
 
 	unlock_timer(timr, flags);
 
@@ -854,7 +940,7 @@ static int adjust_abs_time(struct k_cloc
 			/*
 			 * Not one of the basic clocks
 			 */
-			do_posix_gettime(clock, &now);	
+			clock->clock_get(clock - posix_clocks, &now);
 			jiffies_64_f = get_jiffies_64();
 		}
 		/*
@@ -906,15 +992,15 @@ static int adjust_abs_time(struct k_cloc
 
 /* Set a POSIX.1b interval timer. */
 /* timr->it_lock is taken. */
-static inline int
-do_timer_settime(struct k_itimer *timr, int flags,
+COMMONDEFN int
+common_timer_set(struct k_itimer *timr, int flags,
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
 	struct k_clock *clock = &posix_clocks[timr->it_clock];
 	u64 expire_64;
 
 	if (old_setting)
-		do_timer_gettime(timr, old_setting);
+		common_timer_get(timr, old_setting);
 
 	/* disable the timer */
 	timr->it_incr = 0;
@@ -1003,12 +1089,9 @@ retry:
 	if (!timr)
 		return -EINVAL;
 
-	if (!posix_clocks[timr->it_clock].timer_set)
-		error = do_timer_settime(timr, flags, &new_spec, rtn);
-	else
-	        error = posix_clocks[timr->it_clock].timer_set(timr,
-							       flags,
-							       &new_spec, rtn);
+	error = CLOCK_DISPATCH(timr->it_clock, timer_set,
+			       (timr, flags, &new_spec, rtn));
+
 	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
 		rtn = NULL;	// We already got the old time...
@@ -1022,7 +1105,7 @@ retry:
 	return error;
 }
 
-static inline int do_timer_delete(struct k_itimer *timer)
+COMMONDEFN int common_timer_del(struct k_itimer *timer)
 {
 	timer->it_incr = 0;
 #ifdef CONFIG_SMP
@@ -1044,6 +1127,11 @@ static inline int do_timer_delete(struct
 	return 0;
 }
 
+static inline int timer_delete_hook(struct k_itimer *timer)
+{
+	return CLOCK_DISPATCH(timer->it_clock, timer_del, (timer));
+}
+
 /* Delete a POSIX.1b interval timer. */
 asmlinkage long
 sys_timer_delete(timer_t timer_id)
@@ -1060,14 +1148,14 @@ retry_delete:
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
+	error = timer_delete_hook(timer);
 
 	if (error == TIMER_RETRY) {
 		unlock_timer(timer, flags);
 		goto retry_delete;
 	}
 #else
-	p_timer_del(&posix_clocks[timer->it_clock], timer);
+	timer_delete_hook(timer);
 #endif
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
@@ -1099,14 +1187,14 @@ retry_delete:
 	spin_lock_irqsave(&timer->it_lock, flags);
 
 #ifdef CONFIG_SMP
-	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
+	error = timer_delete_hook(timer);
 
 	if (error == TIMER_RETRY) {
 		unlock_timer(timer, flags);
 		goto retry_delete;
 	}
 #else
-	p_timer_del(&posix_clocks[timer->it_clock], timer);
+	timer_delete_hook(timer);
 #endif
 	list_del(&timer->list);
 	/*
@@ -1143,14 +1231,6 @@ void exit_itimers(struct signal_struct *
  * spin_lock_irq() held and from clock calls with no locking.	They must
  * use the save flags versions of locks.
  */
-static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
-{
-	if (clock->clock_get)
-		return clock->clock_get(tp);
-
-	getnstimeofday(tp);
-	return 0;
-}
 
 /*
  * We do ticks here to avoid the irq lock ( they take sooo long).
@@ -1177,7 +1257,7 @@ static u64 do_posix_clock_monotonic_gett
 	return jiff;
 }
 
-int do_posix_clock_monotonic_gettime(struct timespec *tp)
+static int do_posix_clock_monotonic_get(clockid_t clock, struct timespec *tp)
 {
 	struct timespec wall_to_mono;
 
@@ -1193,7 +1273,13 @@ int do_posix_clock_monotonic_gettime(str
 	return 0;
 }
 
-int do_posix_clock_nosettime(struct timespec *tp)
+int do_posix_clock_monotonic_gettime(struct timespec *tp)
+{
+	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
+}
+
+
+int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
 {
 	return -EINVAL;
 }
@@ -1203,7 +1289,7 @@ int do_posix_clock_notimer_create(struct
 	return -EINVAL;
 }
 
-int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec *t)
+int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t)
 {
 #ifndef ENOTSUP
 	return -EOPNOTSUPP;	/* aka ENOTSUP in userland for POSIX */
@@ -1217,24 +1303,12 @@ sys_clock_settime(clockid_t which_clock,
 {
 	struct timespec new_tp;
 
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
-					!posix_clocks[which_clock].res)
+	if (invalid_clockid(which_clock))
 		return -EINVAL;
 	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
 		return -EFAULT;
-	if (posix_clocks[which_clock].clock_set)
-		return posix_clocks[which_clock].clock_set(&new_tp);
 
-	return do_sys_settimeofday(&new_tp, NULL);
-}
-
-static int do_clock_gettime(clockid_t which_clock, struct timespec *tp)
-{
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
-					!posix_clocks[which_clock].res)
-		return -EINVAL;
-
-	return do_posix_gettime(&posix_clocks[which_clock], tp);
+	return CLOCK_DISPATCH(which_clock, clock_set, (which_clock, &new_tp));
 }
 
 asmlinkage long
@@ -1243,7 +1317,10 @@ sys_clock_gettime(clockid_t which_clock,
 	struct timespec kernel_tp;
 	int error;
 
-	error = do_clock_gettime(which_clock, &kernel_tp);
+	if (invalid_clockid(which_clock))
+		return -EINVAL;
+	error = CLOCK_DISPATCH(which_clock, clock_get,
+			       (which_clock, &kernel_tp));
 	if (!error && copy_to_user(tp, &kernel_tp, sizeof (kernel_tp)))
 		error = -EFAULT;
 
@@ -1255,18 +1332,19 @@ asmlinkage long
 sys_clock_getres(clockid_t which_clock, struct timespec __user *tp)
 {
 	struct timespec rtn_tp;
+	int error;
 
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
-					!posix_clocks[which_clock].res)
+	if (invalid_clockid(which_clock))
 		return -EINVAL;
 
-	rtn_tp.tv_sec = 0;
-	rtn_tp.tv_nsec = posix_clocks[which_clock].res;
-	if (tp && copy_to_user(tp, &rtn_tp, sizeof (rtn_tp)))
-		return -EFAULT;
+	error = CLOCK_DISPATCH(which_clock, clock_getres,
+			       (which_clock, &rtn_tp));
 
-	return 0;
+	if (!error && tp && copy_to_user(tp, &rtn_tp, sizeof (rtn_tp))) {
+		error = -EFAULT;
+	}
 
+	return error;
 }
 
 static void nanosleep_wake_up(unsigned long __data)
@@ -1379,9 +1457,6 @@ void clock_was_set(void)
 
 long clock_nanosleep_restart(struct restart_block *restart_block);
 
-extern long do_clock_nanosleep(clockid_t which_clock, int flags,
-			       struct timespec *t);
-
 asmlinkage long
 sys_clock_nanosleep(clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
@@ -1392,8 +1467,7 @@ sys_clock_nanosleep(clockid_t which_cloc
 	    &(current_thread_info()->restart_block);
 	int ret;
 
-	if ((unsigned) which_clock >= MAX_CLOCKS ||
-					!posix_clocks[which_clock].res)
+	if (invalid_clockid(which_clock))
 		return -EINVAL;
 
 	if (copy_from_user(&t, rqtp, sizeof (struct timespec)))
@@ -1402,12 +1476,10 @@ sys_clock_nanosleep(clockid_t which_cloc
 	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
 		return -EINVAL;
 
-	if (posix_clocks[which_clock].nsleep)
-		ret = posix_clocks[which_clock].nsleep(which_clock, flags, &t);
-	else
-		ret = do_clock_nanosleep(which_clock, flags, &t);
+	ret = CLOCK_DISPATCH(which_clock, nsleep, (which_clock, flags, &t));
+
 	/*
-	 * Do this here as do_clock_nanosleep does not have the real address
+	 * Do this here as common_nsleep does not have the real address
 	 */
 	restart_block->arg1 = (unsigned long)rmtp;
 
@@ -1417,8 +1489,9 @@ sys_clock_nanosleep(clockid_t which_cloc
 	return ret;
 }
 
-long
-do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
+
+static int common_nsleep(clockid_t which_clock,
+			 int flags, struct timespec *tsave)
 {
 	struct timespec t, dum;
 	struct timer_list new_timer;
@@ -1525,7 +1598,7 @@ long
 clock_nanosleep_restart(struct restart_block *restart_block)
 {
 	struct timespec t;
-	int ret = do_clock_nanosleep(restart_block->arg0, 0, &t);
+	int ret = common_nsleep(restart_block->arg0, 0, &t);
 
 	if ((ret == -ERESTART_RESTARTBLOCK) && restart_block->arg1 &&
 	    copy_to_user((struct timespec __user *)(restart_block->arg1), &t,
