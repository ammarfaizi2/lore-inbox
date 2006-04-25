Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWDYQje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWDYQje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWDYQje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:39:34 -0400
Received: from www.osadl.org ([213.239.205.134]:49792 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751604AbWDYQjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:39:14 -0400
Message-Id: <20060425162421.913189000@localhost.localdomain>
References: <20060425162414.896662000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:41:08 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>
Subject: [patch 4/4] futex-pi: Make use of restart_block when interrupted
Content-Disposition: inline; filename=futex-use-restart.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make use of restart_block when the lock operation has been interrupted.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/futex.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 10 deletions(-)

Index: linux-2.6.17-rc1-mm3/kernel/futex.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/futex.c
+++ linux-2.6.17-rc1-mm3/kernel/futex.c
@@ -1077,26 +1077,18 @@ static int futex_wait(u32 __user *uaddr,
  * if there are waiters then it will block, it does PI, etc. (Due to
  * races the kernel might see a 0 value of the futex too.)
  */
-static int futex_lock_pi(u32 __user *uaddr, int detect,
-			 unsigned long sec, long nsec, int trylock)
+static int do_futex_lock_pi(u32 __user *uaddr, int detect, int trylock,
+			    struct hrtimer_sleeper *to)
 {
 	struct task_struct *curr = current;
 	struct futex_hash_bucket *hb;
 	u32 uval, newval, curval;
 	struct futex_q q;
-	struct hrtimer_sleeper timeout, *to = NULL;
 	int ret, attempt = 0;
 
 	if (refill_pi_state_cache())
 		return -ENOMEM;
 
-	if (sec != MAX_SCHEDULE_TIMEOUT) {
-		to = &timeout;
-		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
-		hrtimer_init_sleeper(to, current);
-		to->timer.expires = ktime_set(sec, nsec);
-	}
-
 	q.pi_state = NULL;
  retry:
 	down_read(&curr->mm->mmap_sem);
@@ -1304,6 +1296,76 @@ static int futex_lock_pi(u32 __user *uad
 }
 
 /*
+ * Restart handler
+ */
+static long futex_lock_pi_restart(struct restart_block *restart)
+{
+	struct hrtimer_sleeper timeout, *to = NULL;
+	int ret;
+
+	restart->fn = do_no_restart_syscall;
+
+	if (restart->arg2 || restart->arg3) {
+		to = &timeout;
+		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
+		hrtimer_init_sleeper(to, current);
+		to->timer.expires.tv64 = ((u64)restart->arg1 << 32) |
+			(u64) restart->arg0;
+	}
+
+	pr_debug("lock_pi restart: %p, %d (%d)\n",
+		 (u32 __user *)restart->arg0, current->pid);
+
+	ret = do_futex_lock_pi((u32 __user *)restart->arg0, restart->arg1,
+			       0, to);
+
+	if (ret != -EINTR)
+		return ret;
+
+	restart->fn = futex_lock_pi_restart;
+
+	/* The other values are filled in */
+	return -ERESTART_RESTARTBLOCK;
+}
+
+/*
+ * Called from the syscall entry below.
+ */
+static int futex_lock_pi(u32 __user *uaddr, int detect, unsigned long sec,
+			 long nsec, int trylock)
+{
+	struct hrtimer_sleeper timeout, *to = NULL;
+	struct restart_block *restart;
+	int ret;
+
+	if (sec != MAX_SCHEDULE_TIMEOUT) {
+		to = &timeout;
+		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
+		hrtimer_init_sleeper(to, current);
+		to->timer.expires = ktime_set(sec, nsec);
+	}
+
+	ret = do_futex_lock_pi(uaddr, detect, trylock, to);
+
+	if (ret != -EINTR)
+		return ret;
+
+	pr_debug("lock_pi interrupted: %p, %d (%d)\n", uaddr, current->pid);
+
+	restart = &current_thread_info()->restart_block;
+	restart->fn = futex_lock_pi_restart;
+	restart->arg0 = (unsigned long) uaddr;
+	restart->arg1 = detect;
+	if (to) {
+		restart->arg2 = to->timer.expires.tv64 & 0xFFFFFFFF;
+		restart->arg3 = to->timer.expires.tv64 >> 32;
+	} else
+		restart->arg2 = restart->arg3 = 0;
+
+	return -ERESTART_RESTARTBLOCK;
+}
+
+/*
  * Userspace attempted a TID -> 0 atomic transition, and failed.
  * This is the in-kernel slowpath: we look up the PI state (if any),
  * and do the rt-mutex unlock.

--

