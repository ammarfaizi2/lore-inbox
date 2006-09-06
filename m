Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWIFURJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWIFURJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWIFURJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:17:09 -0400
Received: from www.osadl.org ([213.239.205.134]:61885 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751567AbWIFURH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:17:07 -0400
Subject: [PATCH] Use the correct restart option for futex_lock_pi
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 22:17:15 +0200
Message-Id: <1157573835.5724.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of futex_lock_pi returns -ERESTART_RESTARTBLOCK
in case that the lock operation has been interrupted by a signal. This 
results in a return of -EINTR to userspace in case there is an handler
for the signal. This is wrong, because userspace expects that the lock
function does not return in any case of signal delivery. 

This was not caught by my insufficient test case, but triggered a nasty
userspace problem in an high load application scenario. Unfortunately
also glibc does not check for this invalid return value.

Using -ERSTARTNOINTR makes sure, that the interrupted syscall is restarted.
The restart block related code can be safely removed, as the possible 
timeout argument is an absolute time value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>

diff --git a/kernel/futex.c b/kernel/futex.c
index b9b8aea..9d260e8 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1120,9 +1120,10 @@ static int futex_wait(u32 __user *uaddr,
  * if there are waiters then it will block, it does PI, etc. (Due to
  * races the kernel might see a 0 value of the futex too.)
  */
-static int do_futex_lock_pi(u32 __user *uaddr, int detect, int trylock,
-			    struct hrtimer_sleeper *to)
+static int futex_lock_pi(u32 __user *uaddr, int detect, unsigned long sec,
+			 long nsec, int trylock)
 {
+	struct hrtimer_sleeper timeout, *to = NULL;
 	struct task_struct *curr = current;
 	struct futex_hash_bucket *hb;
 	u32 uval, newval, curval;
@@ -1132,6 +1133,13 @@ static int do_futex_lock_pi(u32 __user *
 	if (refill_pi_state_cache())
 		return -ENOMEM;
 
+	if (sec != MAX_SCHEDULE_TIMEOUT) {
+		to = &timeout;
+		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
+		hrtimer_init_sleeper(to, current);
+		to->timer.expires = ktime_set(sec, nsec);
+	}
+
 	q.pi_state = NULL;
  retry:
 	down_read(&curr->mm->mmap_sem);
@@ -1307,7 +1315,7 @@ static int do_futex_lock_pi(u32 __user *
 	if (!detect && ret == -EDEADLK && 0)
 		force_sig(SIGKILL, current);
 
-	return ret;
+	return ret != -EINTR ? ret : -ERESTARTNOINTR;
 
  out_unlock_release_sem:
 	queue_unlock(&q, hb);
@@ -1342,76 +1350,6 @@ static int do_futex_lock_pi(u32 __user *
 }
 
 /*
- * Restart handler
- */
-static long futex_lock_pi_restart(struct restart_block *restart)
-{
-	struct hrtimer_sleeper timeout, *to = NULL;
-	int ret;
-
-	restart->fn = do_no_restart_syscall;
-
-	if (restart->arg2 || restart->arg3) {
-		to = &timeout;
-		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
-		hrtimer_init_sleeper(to, current);
-		to->timer.expires.tv64 = ((u64)restart->arg1 << 32) |
-			(u64) restart->arg0;
-	}
-
-	pr_debug("lock_pi restart: %p, %d (%d)\n",
-		 (u32 __user *)restart->arg0, current->pid);
-
-	ret = do_futex_lock_pi((u32 __user *)restart->arg0, restart->arg1,
-			       0, to);
-
-	if (ret != -EINTR)
-		return ret;
-
-	restart->fn = futex_lock_pi_restart;
-
-	/* The other values are filled in */
-	return -ERESTART_RESTARTBLOCK;
-}
-
-/*
- * Called from the syscall entry below.
- */
-static int futex_lock_pi(u32 __user *uaddr, int detect, unsigned long sec,
-			 long nsec, int trylock)
-{
-	struct hrtimer_sleeper timeout, *to = NULL;
-	struct restart_block *restart;
-	int ret;
-
-	if (sec != MAX_SCHEDULE_TIMEOUT) {
-		to = &timeout;
-		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
-		hrtimer_init_sleeper(to, current);
-		to->timer.expires = ktime_set(sec, nsec);
-	}
-
-	ret = do_futex_lock_pi(uaddr, detect, trylock, to);
-
-	if (ret != -EINTR)
-		return ret;
-
-	pr_debug("lock_pi interrupted: %p, %d (%d)\n", uaddr, current->pid);
-
-	restart = &current_thread_info()->restart_block;
-	restart->fn = futex_lock_pi_restart;
-	restart->arg0 = (unsigned long) uaddr;
-	restart->arg1 = detect;
-	if (to) {
-		restart->arg2 = to->timer.expires.tv64 & 0xFFFFFFFF;
-		restart->arg3 = to->timer.expires.tv64 >> 32;
-	} else
-		restart->arg2 = restart->arg3 = 0;
-
-	return -ERESTART_RESTARTBLOCK;
-}
-
-/*
  * Userspace attempted a TID -> 0 atomic transition, and failed.
  * This is the in-kernel slowpath: we look up the PI state (if any),
  * and do the rt-mutex unlock.


