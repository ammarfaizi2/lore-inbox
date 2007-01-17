Return-Path: <linux-kernel-owner+w=401wt.eu-S932094AbXAQJCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbXAQJCg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXAQJCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:02:36 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53623 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbXAQJCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:02:34 -0500
Message-ID: <45ADE5D0.5080509@bull.net>
Date: Wed, 17 Jan 2007 10:01:04 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH 2.6.20-rc5 2/4] Make futex_wait() use an hrtimer for timeout
References: <45ADDF60.5080704@bull.net>
In-Reply-To: <45ADDF60.5080704@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 10:10:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 10:10:51,
	Serialize complete at 17/01/2007 10:10:51
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi,

   This patch modifies futex_wait() to use an hrtimer + schedule() in place of
schedule_timeout() in an RT kernel.

   More details in the patch header.


--------------------------------------------------------------------------------

   This patch modifies futex_wait() to use an hrtimer + schedule() in place of
schedule_timeout().

   schedule_timeout() is tick based, therefore the timeout granularity is
the tick (1 ms, 4 ms or 10 ms depending on HZ). By using a high resolution
timer for timeout wakeup, we can attain a much finer timeout granularity
(in the microsecond range). This parallels what is already done for
futex_lock_pi().

   The timeout passed to the syscall is no longer converted to jiffies
and is therefore passed to do_futex() and futex_wait() as a timespec
therefore keeping nanosecond resolution.

   Also this removes the need to pass the nanoseconds timeout part to
futex_lock_pi() in val2.

   In futex_wait(), if the timeout is zero then a regular schedule() is
performed. Otherwise, an hrtimer is fired before schedule() is called.

---
  include/linux/futex.h |    2 -
  kernel/futex.c        |   58 ++++++++++++++++++++++++++++++++------------------
  kernel/futex_compat.c |   11 +--------
  3 files changed, 41 insertions(+), 30 deletions(-)

---

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Pierre Peiffer <pierre.peiffer@bull.net>

---
Index: linux-2.6/kernel/futex.c
===================================================================
--- linux-2.6.orig/kernel/futex.c	2007-01-17 09:44:25.000000000 +0100
+++ linux-2.6/kernel/futex.c	2007-01-17 09:44:42.000000000 +0100
@@ -1020,7 +1020,7 @@ static void unqueue_me_pi(struct futex_q
  	drop_key_refs(&q->key);
  }

-static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
+static int futex_wait(u32 __user *uaddr, u32 val, struct timespec *time)
  {
  	struct task_struct *curr = current;
  	DECLARE_WAITQUEUE(wait, curr);
@@ -1028,6 +1028,8 @@ static int futex_wait(u32 __user *uaddr,
  	struct futex_q q;
  	u32 uval;
  	int ret;
+	struct hrtimer_sleeper t;
+	int rem = 0;

  	q.pi_state = NULL;
   retry:
@@ -1105,8 +1107,31 @@ static int futex_wait(u32 __user *uaddr,
  	 * !plist_node_empty() is safe here without any lock.
  	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
  	 */
-	if (likely(!plist_node_empty(&q.list)))
-		time = schedule_timeout(time);
+	if (likely(!plist_node_empty(&q.list))) {
+		if (time->tv_sec == 0 && time->tv_nsec == 0)
+			schedule();
+		else {
+			hrtimer_init(&t.timer, CLOCK_MONOTONIC, HRTIMER_REL);
+			hrtimer_init_sleeper(&t, current);
+			t.timer.expires = timespec_to_ktime(*time);
+
+			hrtimer_start(&t.timer, t.timer.expires, HRTIMER_REL);
+
+			/*
+			 * the timer could have already expired, in which
+			 * case current would be flagged for rescheduling.
+			 * Don't bother calling schedule.
+			 */
+			if (likely(t.task))
+				schedule();
+
+			hrtimer_cancel(&t.timer);
+
+			/* Flag if a timeout occured */
+			rem = (t.task == NULL);
+		}
+	}
+
  	__set_current_state(TASK_RUNNING);

  	/*
@@ -1117,7 +1142,7 @@ static int futex_wait(u32 __user *uaddr,
  	/* If we were woken (and unqueued), we succeeded, whatever. */
  	if (!unqueue_me(&q))
  		return 0;
-	if (time == 0)
+	if (rem)
  		return -ETIMEDOUT;
  	/*
  	 * We expect signal_pending(current), but another thread may
@@ -1139,8 +1164,8 @@ static int futex_wait(u32 __user *uaddr,
   * if there are waiters then it will block, it does PI, etc. (Due to
   * races the kernel might see a 0 value of the futex too.)
   */
-static int futex_lock_pi(u32 __user *uaddr, int detect, unsigned long sec,
-			 long nsec, int trylock)
+static int futex_lock_pi(u32 __user *uaddr, int detect, struct timespec *time,
+			 int trylock)
  {
  	struct hrtimer_sleeper timeout, *to = NULL;
  	struct task_struct *curr = current;
@@ -1152,11 +1177,11 @@ static int futex_lock_pi(u32 __user *uad
  	if (refill_pi_state_cache())
  		return -ENOMEM;

-	if (sec != MAX_SCHEDULE_TIMEOUT) {
+	if (time->tv_sec || time->tv_nsec) {
  		to = &timeout;
  		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
  		hrtimer_init_sleeper(to, current);
-		to->timer.expires = ktime_set(sec, nsec);
+		to->timer.expires = timespec_to_ktime(*time);
  	}

  	q.pi_state = NULL;
@@ -1792,7 +1817,7 @@ void exit_robust_list(struct task_struct
  	}
  }

-long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
+long do_futex(u32 __user *uaddr, int op, u32 val, struct timespec *timeout,
  		u32 __user *uaddr2, u32 val2, u32 val3)
  {
  	int ret;
@@ -1818,13 +1843,13 @@ long do_futex(u32 __user *uaddr, int op,
  		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
  		break;
  	case FUTEX_LOCK_PI:
-		ret = futex_lock_pi(uaddr, val, timeout, val2, 0);
+		ret = futex_lock_pi(uaddr, val, timeout, 0);
  		break;
  	case FUTEX_UNLOCK_PI:
  		ret = futex_unlock_pi(uaddr);
  		break;
  	case FUTEX_TRYLOCK_PI:
-		ret = futex_lock_pi(uaddr, 0, timeout, val2, 1);
+		ret = futex_lock_pi(uaddr, 0, timeout, 1);
  		break;
  	default:
  		ret = -ENOSYS;
@@ -1837,8 +1862,7 @@ asmlinkage long sys_futex(u32 __user *ua
  			  struct timespec __user *utime, u32 __user *uaddr2,
  			  u32 val3)
  {
-	struct timespec t;
-	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+	struct timespec t = {.tv_sec = 0, .tv_nsec = 0};
  	u32 val2 = 0;

  	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
@@ -1846,12 +1870,6 @@ asmlinkage long sys_futex(u32 __user *ua
  			return -EFAULT;
  		if (!timespec_valid(&t))
  			return -EINVAL;
-		if (op == FUTEX_WAIT)
-			timeout = timespec_to_jiffies(&t) + 1;
-		else {
-			timeout = t.tv_sec;
-			val2 = t.tv_nsec;
-		}
  	}
  	/*
  	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
@@ -1859,7 +1877,7 @@ asmlinkage long sys_futex(u32 __user *ua
  	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
  		val2 = (u32) (unsigned long) utime;

-	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
  }

  static int futexfs_get_sb(struct file_system_type *fs_type,
Index: linux-2.6/kernel/futex_compat.c
===================================================================
--- linux-2.6.orig/kernel/futex_compat.c	2007-01-17 09:39:57.000000000 +0100
+++ linux-2.6/kernel/futex_compat.c	2007-01-17 09:44:42.000000000 +0100
@@ -141,8 +141,7 @@ asmlinkage long compat_sys_futex(u32 __u
  		struct compat_timespec __user *utime, u32 __user *uaddr2,
  		u32 val3)
  {
-	struct timespec t;
-	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+	struct timespec t = {.tv_sec = 0, .tv_nsec = 0};
  	int val2 = 0;

  	if (utime && (op == FUTEX_WAIT || op == FUTEX_LOCK_PI)) {
@@ -150,15 +149,9 @@ asmlinkage long compat_sys_futex(u32 __u
  			return -EFAULT;
  		if (!timespec_valid(&t))
  			return -EINVAL;
-		if (op == FUTEX_WAIT)
-			timeout = timespec_to_jiffies(&t) + 1;
-		else {
-			timeout = t.tv_sec;
-			val2 = t.tv_nsec;
-		}
  	}
  	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
  		val2 = (int) (unsigned long) utime;

-	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
  }
Index: linux-2.6/include/linux/futex.h
===================================================================
--- linux-2.6.orig/include/linux/futex.h	2007-01-17 09:39:57.000000000 +0100
+++ linux-2.6/include/linux/futex.h	2007-01-17 09:44:42.000000000 +0100
@@ -94,7 +94,7 @@ struct robust_list_head {
  #define ROBUST_LIST_LIMIT	2048

  #ifdef __KERNEL__
-long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
+long do_futex(u32 __user *uaddr, int op, u32 val, struct timespec *timeout,
  	      u32 __user *uaddr2, u32 val2, u32 val3);

  extern int

-- 
Pierre

