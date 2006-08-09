Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWHIXJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWHIXJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWHIXJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:09:28 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:4035 "EHLO
	dhcp119.mvista.com") by vger.kernel.org with ESMTP id S1751432AbWHIXJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:09:05 -0400
Date: Wed, 9 Aug 2006 16:09:03 -0700
Message-Id: <200608092309.k79N93m7028316@dhcp119.mvista.com>
Subject: [PATCH 2/2] posix-timers: Fix the flags handling in posix_cpu_nsleep().
From: toyoa@mvista.com
To: george@wildturkeyranch.net
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a posix_cpu_nsleep() sleep is interrupted by a signal more than twice,
it incorrectly reports the sleep time remaining to the user.
Because posix_cpu_nsleep() doesn't report back to the user when it's called
from restart function due to the wrong flags handling.

This patch, which applies after previous one, moves the nanosleep() function
from posix_cpu_nsleep() to do_cpu_nanosleep() and cleans up the flags handling
appropriately.

Signed-off-by: Toyo Abe <toyoa@mvista.com>

---

--- linux-2.6.18-rc4.org/kernel/posix-cpu-timers.c	2006-08-09 11:01:38.000000000 -0700
+++ linux-2.6.18-rc4/kernel/posix-cpu-timers.c	2006-08-09 11:00:40.000000000 -0700
@@ -1393,23 +1393,13 @@ void set_process_cpu_timer(struct task_s
 	}
 }
 
-int posix_cpu_nsleep(const clockid_t which_clock, int flags,
-		     struct timespec *rqtp, struct timespec __user *rmtp)
+static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
+			    struct timespec *rqtp, struct itimerspec *it)
 {
-	struct restart_block *restart_block =
-	    &current_thread_info()->restart_block;
 	struct k_itimer timer;
 	int error;
 
 	/*
-	 * Diagnose required errors first.
-	 */
-	if (CPUCLOCK_PERTHREAD(which_clock) &&
-	    (CPUCLOCK_PID(which_clock) == 0 ||
-	     CPUCLOCK_PID(which_clock) == current->pid))
-		return -EINVAL;
-
-	/*
 	 * Set up a temporary timer and then wait for it to go off.
 	 */
 	memset(&timer, 0, sizeof timer);
@@ -1420,11 +1410,12 @@ int posix_cpu_nsleep(const clockid_t whi
 	timer.it_process = current;
 	if (!error) {
 		static struct itimerspec zero_it;
-		struct itimerspec it = { .it_value = *rqtp,
-					 .it_interval = {} };
+
+		memset(it, 0, sizeof *it);
+		it->it_value = *rqtp;
 
 		spin_lock_irq(&timer.it_lock);
-		error = posix_cpu_timer_set(&timer, flags, &it, NULL);
+		error = posix_cpu_timer_set(&timer, flags, it, NULL);
 		if (error) {
 			spin_unlock_irq(&timer.it_lock);
 			return error;
@@ -1452,33 +1443,56 @@ int posix_cpu_nsleep(const clockid_t whi
 		 * We were interrupted by a signal.
 		 */
 		sample_to_timespec(which_clock, timer.it.cpu.expires, rqtp);
-		posix_cpu_timer_set(&timer, 0, &zero_it, &it);
+		posix_cpu_timer_set(&timer, 0, &zero_it, it);
 		spin_unlock_irq(&timer.it_lock);
 
-		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
+		if ((it->it_value.tv_sec | it->it_value.tv_nsec) == 0) {
 			/*
 			 * It actually did fire already.
 			 */
 			return 0;
 		}
 
+		error = -ERESTART_RESTARTBLOCK;
+	}
+
+	return error;
+}
+
+int posix_cpu_nsleep(const clockid_t which_clock, int flags,
+		     struct timespec *rqtp, struct timespec __user *rmtp)
+{
+	struct restart_block *restart_block =
+	    &current_thread_info()->restart_block;
+	struct itimerspec it;
+	int error;
+
+	/*
+	 * Diagnose required errors first.
+	 */
+	if (CPUCLOCK_PERTHREAD(which_clock) &&
+	    (CPUCLOCK_PID(which_clock) == 0 ||
+	     CPUCLOCK_PID(which_clock) == current->pid))
+		return -EINVAL;
+
+	error = do_cpu_nanosleep(which_clock, flags, rqtp, &it);
+
+	if (error = -ERESTART_RESTARTBLOCK) {
+
+	       	if (flags & TIMER_ABSTIME)
+			return -ERESTARTNOHAND;
 		/*
-		 * Report back to the user the time still remaining.
-		 */
-		if (rmtp != NULL && !(flags & TIMER_ABSTIME) &&
-		    copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
+	 	 * Report back to the user the time still remaining.
+	 	 */
+		if (rmtp != NULL && copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
 			return -EFAULT;
 
 		restart_block->fn = posix_cpu_nsleep_restart;
-		/* Caller already set restart_block->arg1 */
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (unsigned long) rmtp;
 		restart_block->arg2 = rqtp->tv_sec;
 		restart_block->arg3 = rqtp->tv_nsec;
-
-		error = -ERESTART_RESTARTBLOCK;
 	}
-
 	return error;
 }
 
@@ -1487,13 +1501,31 @@ long posix_cpu_nsleep_restart(struct res
 	clockid_t which_clock = restart_block->arg0;
 	struct timespec __user *rmtp;
 	struct timespec t;
+	struct itimerspec it;
+	int error;
 
 	rmtp = (struct timespec __user *) restart_block->arg1;
 	t.tv_sec = restart_block->arg2;
 	t.tv_nsec = restart_block->arg3;
 
 	restart_block->fn = do_no_restart_syscall;
-	return posix_cpu_nsleep(which_clock, TIMER_ABSTIME, &t, rmtp);
+	error = do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t, &it);
+
+	if (error = -ERESTART_RESTARTBLOCK) {
+		/*
+	 	 * Report back to the user the time still remaining.
+	 	 */
+		if (rmtp != NULL && copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
+			return -EFAULT;
+
+		restart_block->fn = posix_cpu_nsleep_restart;
+		restart_block->arg0 = which_clock;
+		restart_block->arg1 = (unsigned long) rmtp;
+		restart_block->arg2 = t.tv_sec;
+		restart_block->arg3 = t.tv_nsec;
+	}
+	return error;
+
 }
 
 
