Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWHOFyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWHOFyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 01:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWHOFyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 01:54:12 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:40600 "EHLO
	dhcp119.mvista.com") by vger.kernel.org with ESMTP id S965120AbWHOFyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 01:54:11 -0400
Date: Mon, 14 Aug 2006 22:54:29 -0700
Message-Id: <200608150554.k7F5sTiu000878@dhcp119.mvista.com>
Subject: [REPOST] [PATCH 1/2] posix-timers: Fix clock_nanosleep() doesn't return the remaining time in compatibility mode.
From: Toyo Abe <toyoa@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the revised version, which fixes the wrong type declaration of new functions
in kernel/posix-cpu-timers.c
I'm sorry that my initial postings have some easy mistakes. In this time, I'd verified 
this with more test cases than before.

Signed-off-by Toyo Abe <toyoa@mvista.com>

---

 include/linux/hrtimer.h      |    1 +
 include/linux/posix-timers.h |    4 ++++
 kernel/compat.c              |   33 +++++++++++++++++++++++++++++++++
 kernel/hrtimer.c             |   20 ++++++++++----------
 kernel/posix-cpu-timers.c    |   17 ++++++++++++-----
 kernel/posix-timers.c        |   21 +++++++++++++++++++++
 6 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index e4bccbc..c634e30 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -137,6 +137,7 @@ extern long hrtimer_nanosleep(struct tim
 			      struct timespec __user *rmtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
+extern long hrtimer_nanosleep_restart(struct restart_block *restart_block);
 
 extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 				 struct task_struct *tsk);
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 95572c4..a7dd38f 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -72,6 +72,7 @@ struct k_clock {
 	int (*timer_create) (struct k_itimer *timer);
 	int (*nsleep) (const clockid_t which_clock, int flags,
 		       struct timespec *, struct timespec __user *);
+	long (*nsleep_restart) (struct restart_block *restart_block);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -97,6 +98,7 @@ int posix_cpu_clock_set(const clockid_t 
 int posix_cpu_timer_create(struct k_itimer *timer);
 int posix_cpu_nsleep(const clockid_t which_clock, int flags,
 		     struct timespec *rqtp, struct timespec __user *rmtp);
+long posix_cpu_nsleep_restart(struct restart_block *restart_block);
 int posix_cpu_timer_set(struct k_itimer *timer, int flags,
 			struct itimerspec *new, struct itimerspec *old);
 int posix_cpu_timer_del(struct k_itimer *timer);
@@ -111,4 +113,6 @@ void posix_cpu_timers_exit_group(struct 
 void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 			   cputime_t *newval, cputime_t *oldval);
 
+long clock_nanosleep_restart(struct restart_block *restart_block);
+
 #endif
diff --git a/kernel/compat.c b/kernel/compat.c
index 126dee9..75573e5 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -22,6 +22,7 @@ #include <linux/unistd.h>
 #include <linux/security.h>
 #include <linux/timex.h>
 #include <linux/migrate.h>
+#include <linux/posix-timers.h>
 
 #include <asm/uaccess.h>
 
@@ -601,6 +602,30 @@ long compat_sys_clock_getres(clockid_t w
 	return err;
 } 
 
+static long compat_clock_nanosleep_restart(struct restart_block *restart)
+{
+	long err;
+	mm_segment_t oldfs;
+	struct timespec tu;
+	struct compat_timespec *rmtp = (struct compat_timespec *)(restart->arg1);
+
+	restart->arg1 = (unsigned long) &tu;
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	err = clock_nanosleep_restart(restart);
+	set_fs(oldfs);
+
+	if ((err == -ERESTART_RESTARTBLOCK) && rmtp &&
+	    put_compat_timespec(&tu, rmtp))
+		return -EFAULT;
+
+	if (err == -ERESTART_RESTARTBLOCK) {
+		restart->fn = compat_clock_nanosleep_restart;
+		restart->arg1 = (unsigned long) rmtp;
+	}
+	return err;
+}
+
 long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
 			    struct compat_timespec __user *rqtp,
 			    struct compat_timespec __user *rmtp)
@@ -608,6 +633,7 @@ long compat_sys_clock_nanosleep(clockid_
 	long err;
 	mm_segment_t oldfs;
 	struct timespec in, out; 
+	struct restart_block *restart;
 
 	if (get_compat_timespec(&in, rqtp)) 
 		return -EFAULT;
@@ -618,9 +644,16 @@ long compat_sys_clock_nanosleep(clockid_
 				  (struct timespec __user *) &in,
 				  (struct timespec __user *) &out);
 	set_fs(oldfs);
+
 	if ((err == -ERESTART_RESTARTBLOCK) && rmtp &&
 	    put_compat_timespec(&out, rmtp))
 		return -EFAULT;
+
+	if (err == -ERESTART_RESTARTBLOCK) {
+		restart = &current_thread_info()->restart_block;
+		restart->fn = compat_clock_nanosleep_restart;
+		restart->arg1 = (unsigned long) rmtp;
+	}
 	return err;	
 } 
 
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index be989ef..17cb072 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -693,7 +693,7 @@ static int __sched do_nanosleep(struct h
 	return t->task == NULL;
 }
 
-static long __sched nanosleep_restart(struct restart_block *restart)
+long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 {
 	struct hrtimer_sleeper t;
 	struct timespec __user *rmtp;
@@ -702,13 +702,13 @@ static long __sched nanosleep_restart(st
 
 	restart->fn = do_no_restart_syscall;
 
-	hrtimer_init(&t.timer, restart->arg3, HRTIMER_ABS);
-	t.timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
+	hrtimer_init(&t.timer, restart->arg0, HRTIMER_ABS);
+	t.timer.expires.tv64 = ((u64)restart->arg3 << 32) | (u64) restart->arg2;
 
 	if (do_nanosleep(&t, HRTIMER_ABS))
 		return 0;
 
-	rmtp = (struct timespec __user *) restart->arg2;
+	rmtp = (struct timespec __user *) restart->arg1;
 	if (rmtp) {
 		time = ktime_sub(t.timer.expires, t.timer.base->get_time());
 		if (time.tv64 <= 0)
@@ -718,7 +718,7 @@ static long __sched nanosleep_restart(st
 			return -EFAULT;
 	}
 
-	restart->fn = nanosleep_restart;
+	restart->fn = hrtimer_nanosleep_restart;
 
 	/* The other values in restart are already filled in */
 	return -ERESTART_RESTARTBLOCK;
@@ -751,11 +751,11 @@ long hrtimer_nanosleep(struct timespec *
 	}
 
 	restart = &current_thread_info()->restart_block;
-	restart->fn = nanosleep_restart;
-	restart->arg0 = t.timer.expires.tv64 & 0xFFFFFFFF;
-	restart->arg1 = t.timer.expires.tv64 >> 32;
-	restart->arg2 = (unsigned long) rmtp;
-	restart->arg3 = (unsigned long) t.timer.base->index;
+	restart->fn = hrtimer_nanosleep_restart;
+	restart->arg0 = (unsigned long) t.timer.base->index;
+	restart->arg1 = (unsigned long) rmtp;
+	restart->arg2 = t.timer.expires.tv64 & 0xFFFFFFFF;
+	restart->arg3 = t.timer.expires.tv64 >> 32;
 
 	return -ERESTART_RESTARTBLOCK;
 }
diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index d38d9ec..5667fef 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -1393,8 +1393,6 @@ void set_process_cpu_timer(struct task_s
 	}
 }
 
-static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
-
 int posix_cpu_nsleep(const clockid_t which_clock, int flags,
 		     struct timespec *rqtp, struct timespec __user *rmtp)
 {
@@ -1471,7 +1469,7 @@ int posix_cpu_nsleep(const clockid_t whi
 		    copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
 			return -EFAULT;
 
-		restart_block->fn = posix_cpu_clock_nanosleep_restart;
+		restart_block->fn = posix_cpu_nsleep_restart;
 		/* Caller already set restart_block->arg1 */
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (unsigned long) rmtp;
@@ -1484,8 +1482,7 @@ int posix_cpu_nsleep(const clockid_t whi
 	return error;
 }
 
-static long
-posix_cpu_clock_nanosleep_restart(struct restart_block *restart_block)
+long posix_cpu_nsleep_restart(struct restart_block *restart_block)
 {
 	clockid_t which_clock = restart_block->arg0;
 	struct timespec __user *rmtp;
@@ -1524,6 +1521,10 @@ static int process_cpu_nsleep(const cloc
 {
 	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp, rmtp);
 }
+static long process_cpu_nsleep_restart(struct restart_block *restart_block)
+{
+	return -EINVAL;
+}
 static int thread_cpu_clock_getres(const clockid_t which_clock,
 				   struct timespec *tp)
 {
@@ -1544,6 +1545,10 @@ static int thread_cpu_nsleep(const clock
 {
 	return -EINVAL;
 }
+static long thread_cpu_nsleep_restart(struct restart_block *restart_block)
+{
+	return -EINVAL;
+}
 
 static __init int init_posix_cpu_timers(void)
 {
@@ -1553,6 +1558,7 @@ static __init int init_posix_cpu_timers(
 		.clock_set = do_posix_clock_nosettime,
 		.timer_create = process_cpu_timer_create,
 		.nsleep = process_cpu_nsleep,
+		.nsleep_restart = process_cpu_nsleep_restart,
 	};
 	struct k_clock thread = {
 		.clock_getres = thread_cpu_clock_getres,
@@ -1560,6 +1566,7 @@ static __init int init_posix_cpu_timers(
 		.clock_set = do_posix_clock_nosettime,
 		.timer_create = thread_cpu_timer_create,
 		.nsleep = thread_cpu_nsleep,
+		.nsleep_restart = thread_cpu_nsleep_restart,
 	};
 
 	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &process);
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index ac6dc87..e5ebcc1 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -973,3 +973,24 @@ sys_clock_nanosleep(const clockid_t whic
 	return CLOCK_DISPATCH(which_clock, nsleep,
 			      (which_clock, flags, &t, rmtp));
 }
+
+/*
+ * nanosleep_restart for monotonic and realtime clocks
+ */
+static int common_nsleep_restart(struct restart_block *restart_block)
+{
+	return hrtimer_nanosleep_restart(restart_block);
+}
+
+/*
+ * This will restart clock_nanosleep. This is required only by
+ * compat_clock_nanosleep_restart for now.
+ */
+long
+clock_nanosleep_restart(struct restart_block *restart_block)
+{
+	clockid_t which_clock = restart_block->arg0;
+
+	return CLOCK_DISPATCH(which_clock, nsleep_restart,
+			      (restart_block));
+}
